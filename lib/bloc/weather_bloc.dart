import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:flutter_cubit_bloc_tutorial/data/model/weather.dart';
import 'package:flutter_cubit_bloc_tutorial/data/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;
  WeatherBloc(
    this._weatherRepository,
  ) : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {
      if (event is GetWeather) {
        try {
          emit(WeatherLoading());
          final weather = await _weatherRepository.fetchWeather(event.cityName);
          emit(WeatherLoaded(weather));
        } on NetworkException {
          emit(WeatherError("Network Error"));
          //
        }
      }
    });
  }
}
