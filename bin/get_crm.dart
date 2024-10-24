void main() {
  List<Map<String, dynamic>> attractions = [
    {'name': 'Исаакиевский собор', 'time': 5.0, 'importance': 10},
    {'name': 'Эрмитаж', 'time': 8.0, 'importance': 11},
    {'name': 'Кунсткамера', 'time': 3.5, 'importance': 4},
    {'name': 'Петропавловская крепость', 'time': 10.0, 'importance': 7},
    {'name': 'Ленинградский зоопарк', 'time': 9.0, 'importance': 15},
    {'name': 'Медный всадник', 'time': 1.0, 'importance': 17},
    {'name': 'Казанский собор', 'time': 4.0, 'importance': 3},
    {'name': 'Спас на Крови', 'time': 2.0, 'importance': 9},
    {'name': 'Зимний дворец Петра I', 'time': 7.0, 'importance': 12},
    {'name': 'Зоологический музей', 'time': 5.5, 'importance': 6},
    {
      'name': 'Музей обороны и блокады Ленинграда',
      'time': 2.0,
      'importance': 19
    },
    {'name': 'Русский музей', 'time': 5.0, 'importance': 8},
    {'name': 'Навестить друзей', 'time': 12.0, 'importance': 20},
    {'name': 'Музей восковых фигур', 'time': 2.0, 'importance': 13},
    {
      'name': 'Литературно-мемориальный музей Ф.М. Достоевского',
      'time': 4.0,
      'importance': 2
    },
    {'name': 'Екатерининский дворец', 'time': 1.5, 'importance': 5},
    {'name': 'Петербургский музей кукол', 'time': 1.0, 'importance': 14},
    {
      'name': 'Музей микроминиатюры «Русский Левша»',
      'time': 3.0,
      'importance': 18
    },
    {'name': 'Всероссийский музей А.С. Пушкина', 'time': 6.0, 'importance': 1},
    {
      'name': 'Музей современного искусства Эрарта',
      'time': 7.0,
      'importance': 16
    },
  ];

  double availableTime = 32.0;

  double totalTime = 0;
  int totalImportance = 0;
  List<Map<String, dynamic>> selectedAttractions = [];

  List<Map<String, dynamic>> day1 = [];
  List<Map<String, dynamic>> day2 = [];
  double day1Time = 0;
  double day2Time = 0;

  // Коэффициенты важность/время
  for (var attraction in attractions) {
    attraction['value_per_time'] =
        attraction['importance'] / attraction['time'];
  }

  // Сортировка достопримечательностей
  attractions
      .sort((a, b) => b['value_per_time'].compareTo(a['value_per_time']));

  // Отбор достопримечательностей
  for (var attraction in List.from(attractions)) {
    if (totalTime + (attraction['time'] as double) <= availableTime) {
      totalTime += attraction['time'] as double;
      totalImportance += attraction['importance'] as int;
      selectedAttractions.add(attraction);
    }
  }

  // Составление расписания
  for (var attraction in selectedAttractions) {
    if (day1Time + (attraction['time'] as double) <= availableTime / 2) {
      day1.add(attraction);
      day1Time += attraction['time'] as double;
    } else {
      day2.add(attraction);
      day2Time += attraction['time'] as double;
    }
  }

  // Оптимизация расписания
  for (int i = 0; i < day1.length; i++) {
    for (int j = 0; j < day2.length; j++) {
      double newDay1Time =
          day1Time - (day1[i]['time'] as double) + (day2[j]['time'] as double);
      double newDay2Time =
          day2Time - (day2[j]['time'] as double) + (day1[i]['time'] as double);

      if (newDay1Time <= availableTime / 2 &&
          newDay2Time <= availableTime / 2) {
        var temp = day1[i];
        day1[i] = day2[j];
        day2[j] = temp;
        day1Time = newDay1Time;
        day2Time = newDay2Time;
      }
    }
  }

  // Вывод
  print('День 1:');
  for (var attraction in day1) {
    print('${attraction['name']} - ${attraction['time']} ч.');
  }
  print('Общее время День 1: $day1Time ч');

  print('\nДень 2:');
  for (var attraction in day2) {
    print('${attraction['name']} - ${attraction['time']} ч.');
  }
  print('Общее время День 2: $day2Time ч');

  print('\nОбщая важность за два дня: $totalImportance');
}
