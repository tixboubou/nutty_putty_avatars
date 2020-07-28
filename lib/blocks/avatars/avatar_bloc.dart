import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nutty_putty_avatars/models/avatar.dart';
import 'package:nutty_putty_avatars/services/request.dart';

import 'avatar_events.dart';
import 'avatar_state.dart';

class AvatarBloc extends Bloc<AvatarEvents, AvatarState> {
  final AvatarService _avatarService = AvatarService();
  @override
  AvatarState get initialState {
    // super.initialState;
    return AvatarInitial();
  }

  @override
  AvatarState fromJson(Map<String, dynamic> json) {
    try {
      final Avatar avatars = Avatar.fromJson(json);
      return AvatarLoaded(avatars);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(AvatarState state) {
    if (state is AvatarLoaded) {
      return state.avatars.toJson();
    }

    return null;
  }

  @override
  Stream<AvatarState> mapEventToState(
    AvatarEvents event,
  ) async* {
    switch (event.runtimeType) {
      case GetAvatars:
        yield AvatarLoading();
        yield* _mapStateFromGetAvatars(event);
        break;
      case GeneratePartsList:
        yield ListLoading();
        yield* _mapStateGenerateParts(event);
        break;
    }
  }

  Stream<AvatarState> _mapStateFromGetAvatars(GetAvatars event) async* {
    try {
      final Avatar response = await _avatarService.getImages(event.isStaging);
      yield AvatarLoaded(response);
    } catch (err) {
      print(err);
      yield AvatarError(err.toString());
    }
  }

  Stream<AvatarState> _mapStateGenerateParts(GeneratePartsList event) async* {
    try {
      print('dsfdgdf');
      yield ListGenerated(event.parts);
    } catch (err) {
      print(err);
      yield AvatarError(err.toString());
    }
  }
}
