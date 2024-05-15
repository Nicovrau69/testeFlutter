import 'package:testeflutter/common/activity_state.dart';
import 'package:testeflutter/screens/abstract/abstract_state.dart';

class LoginState extends AbstractState {
  final String? user;
  final String? senha;

  const LoginState(
      {ActivityState state = const ActivityLoading(), this.senha, this.user})
      : super(state: state);

  List<Object?> get props => [
        state,
        senha,
        user,
      ];

  @override
  copyWith({ActivityState? state, String? senha, String? user}) {
    return LoginState(
        state: state ?? this.state,
        senha: senha ?? this.senha,
        user: user ?? user);
  }
}
