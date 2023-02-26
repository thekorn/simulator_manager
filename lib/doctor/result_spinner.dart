// ignore_for_file: implementation_imports

import 'dart:async' show Timer, StreamSubscription;
import 'dart:io' show ProcessSignal;

import 'package:interact/src/framework/framework.dart';
import 'package:interact/src/theme/theme.dart';
import 'package:interact/src/utils/utils.dart';

String _prompt(bool x) => '';

/// A spinner or a loading indicator component.
class ResultSpinner extends Component<ResultSpinnerState> {
  /// Construts a [Spinner] component with the default theme.
  ResultSpinner({
    required this.errorIcon,
    required this.successIcon,
    this.leftPrompt = _prompt,
    this.rightPrompt = _prompt,
  }) : theme = Theme.defaultTheme;

  /// Constructs a [Spinner] component with the supplied theme.
  ResultSpinner.withTheme({
    required this.errorIcon,
    required this.successIcon,
    required this.theme,
    this.leftPrompt = _prompt,
    this.rightPrompt = _prompt,
  });

  Context? _context;

  /// The theme of the component.
  final Theme theme;

  /// The icon to be shown in place of the loading
  /// indicator after it's done.
  final String errorIcon;
  final String successIcon;

  /// The prompt function to be shown on the left side
  /// of the spinning indicator or icon.
  final String Function(bool) leftPrompt;

  /// The prompt function to be shown on the right side
  /// of the spinning indicator or icon.
  final String Function(bool) rightPrompt;

  @override
  // ignore: library_private_types_in_public_api
  _ResultSpinnerState createState() => _ResultSpinnerState();

  @override
  void disposeState(State state) {}

  @override
  State pipeState(State state) {
    if (_context != null) {
      state.setContext(_context!);
    }
    return state;
  }

  /// Sets the context to a new one,
  /// to be used internally by [MultiSpinner].
  // ignore: use_setters_to_change_properties
  void setContext(Context c) => _context = c;
}

/// Handles a [Spinner]'s state.
class ResultSpinnerState {
  /// Constructs a state to manage a [Spinner].
  ResultSpinnerState({required this.done});

  /// Function to be called to indicate that the
  /// spinner is loaded.
  void Function() Function({bool error}) done;
}

class _ResultSpinnerState extends State<ResultSpinner> {
  late bool done;
  late bool error;
  late int index;
  late StreamSubscription<ProcessSignal> sigint;

  @override
  void init() {
    super.init();
    done = false;
    error = false;
    index = 0;
    sigint = handleSigint();
    context.hideCursor();
  }

  @override
  void dispose() {
    context.showCursor();
    super.dispose();
  }

  @override
  void render() {
    final line = StringBuffer();

    line.write(component.leftPrompt(done));

    if (done) {
      if (error) {
        line.write(component.errorIcon);
      } else {
        line.write(component.successIcon);
      }
    } else {
      line.write(component.theme.spinners[index]);
    }
    line.write(' ');
    line.write(component.rightPrompt(done));

    context.writeln(line.toString());
  }

  @override
  ResultSpinnerState interact() {
    final timer = Timer.periodic(
      Duration(
        milliseconds: component.theme.spinningInterval,
      ),
      (timer) {
        setState(() {
          index = (index + 1) % component.theme.spinners.length;
        });
      },
    );

    final state = ResultSpinnerState(
      done: ({bool error = false}) {
        setState(() {
          done = true;
          this.error = error;
          sigint.cancel();
        });
        timer.cancel();
        if (component._context != null) {
          return dispose;
        } else {
          dispose();
          return () {};
        }
      },
    );

    return state;
  }
}
