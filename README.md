## **MovieQuiz**

MovieQuiz - это приложение с квизами о фильмах из топ-250 рейтинга и самых популярных фильмах по версии IMDb.

## **Ссылки**

[Макет Figma](https://www.figma.com/file/l0IMG3Eys35fUrbvArtwsR/YP-Quiz?node-id=34%3A243)

[API IMDb](https://imdb-api.com/api#Top250Movies-header)

[Шрифты](https://code.s3.yandex.net/Mobile/iOS/Fonts/MovieQuizFonts.zip)

## **Описание приложения**

- Одностраничное приложение с квизами о фильмах из топ-250 рейтинга и самых популярных фильмов IMDb. Пользователь приложения последовательно отвечает на вопросы о рейтинге фильма. По итогам каждого раунда игры показывается статистика о количестве правильных ответов и лучших результатах пользователя. Цель игры — правильно ответить на все 10 вопросов раунда.

## **Функциональные требования**

- При запуске приложения показывается сплеш-скрин;
- После запуска приложения показывается экран вопроса с текстом вопроса, картинкой и двумя вариантами ответа, “Да” и “Нет”, только один из них правильный;
- Вопрос квиза составляется относительно IMDb рейтинга фильма по 10-балльной шкале, например: "Рейтинг этого фильма больше 6?";
- Можно нажать на один из вариантов ответа на вопрос и получить отклик о том, правильный он или нет, при этом рамка фотографии поменяет цвет на соответствующий;
- После выбора ответа на вопрос через 1 секунду автоматически появляется следующий вопрос;
- После завершения раунда из 10 вопросов появляется алерт со статистикой пользователя и возможностью сыграть ещё раз;
- Статистика содержит: результат текущего раунда (количество правильных ответов из 10 вопросов), количество сыгранных квизов, рекорд (лучший результат раунда за сессию, дата и время этого раунда), статистику сыгранных квизов в процентном соотношении (среднюю точность);
- Пользователь может запустить новый раунд, нажав в алерте на кнопку "Сыграть еще раз";
- При невозможности загрузить данные пользователь видит алерт с сообщением о том, что что-то пошло не так, а также кнопкой, по нажатию на которую можно повторить сетевой запрос.

## **Технические требования**

- Приложение должно поддерживать устройства iPhone с iOS 13, предусмотрен только портретный режим;
- Элементы интерфейса адаптируются под разрешения экранов iPhone, начиная с X — вёрстка под SE и iPad не предусмотрена;
- Экраны соответствует макету — использованы верные шрифты нужных размеров, все надписи находятся на нужном месте, расположение всех элементов, размеры кнопок и отступы — точно такие же, как в макете.

---

## Порядок сдачи домашнего задания:

1. Выполните задачу в Xcode.
2. Залейте готовую задачу на GitHub в отдельную ветку с названием sprint_XX. Важно:
- проект должен быть открытым!
- проект нужно выгрузить исходным кодом, то есть папкой со всеми файлами. Не надо загружать zip-архив — ревьюер не сможет его проверить!
3. Создайте Pull Request (ПР) и скопируйте ссылку на него. Вставьте её в специальную форму на сайте Практикума через кнопку «Сдать работу».

---

## Сдаём задачу спринта 4 на ревью (ветка sprint_04)

Вы сверстали первый экран и реализовали его логику. Пришло время для ревью!
Вам нужно сдать проект, в котором есть:
- Экран запуска приложения (Launch Screen), идентичный макету в Figma.
- Основной экран приложения, идентичный макетам в Figma, с реализованной логикой.

## Убедитесь, что:

1. Приложение запускается.
2. Элементы интерфейса адаптируются под разрешения экранов iPhone, начиная с X — вёрстка под SE и iPad не предусмотрена.
3. Свёрстанный экран полностью соответствует макету — использованы верные шрифты нужных размеров, все надписи находятся на нужном месте, расположение всех элементов, размеры кнопок и отступы — точно такие же, как в макете.
4. Interface Builder не показывает ошибок с констрейнтами.
5. Логика приложения соответствуют функциональным и техническим требованиям, каждый пункт выполнен, и выполнен верно: 
- При запуске приложения показывается сплэш-скрин;
- После запуска приложения показывается экран вопроса с текстом вопроса, картинкой и двумя вариантами ответа, «Да» и «Нет», только один из них правильный;
- Вопрос квиза составляется относительно IMDb рейтинга фильма по 10-балльной шкале, например: «Рейтинг этого фильма больше 6?»;
- Можно нажать на один из вариантов ответа на вопрос и получить отклик о том, правильный он или нет, при этом рамка фотографии поменяет цвет на соответствующий;
- После выбора ответа на вопрос через 1 секунду автоматически появляется следующий вопрос;
- После завершения раунда из 10 вопросов появляется алерт «Раунд окончен» с результатом текущего раунда (количество правильных ответов из 10 вопросов) и возможностью сыграть ещё раз (остальная статистика и невозможность загрузить данные реализуются в следующих спринтах);
- Пользователь может запустить новый раунд, нажав в алерте на кнопку «Сыграть ещё раз»;
6. Весь код написан в одном файле MovieQuizViewController.swift.
7. Ваши функции и переменные приватны, не видны за пределами MovieQuizViewController.
8. Имена ваших переменных и функций отражают то, чем эти переменные и функции занимаются.
9. Вы убрали строчку sleep(3), чтобы приложение не задерживало отображение приветственного экрана на 3 секунды.

---

## Сдаём задачу спринта 5 на ревью (ветка sprint_05)

Поздравляем: вы завершили 5-й спринт. Пришло время для ревью!
Вам нужно сдать проект, в котором:
- Логика работы приложения разбита на несколько частей.
- Работа по генерации вопросов для квиза вынесена в отдельную сущность.
- Написан класс для ведения статистики, которая будет учитывать лучший счёт игры в квиз среди всех игр (даже между перезапусками).
- Статистика сохраняется в UserDefaults.

## Убедитесь, что:

1. Логика работы приложения разбита на несколько частей.
2. Работа по генерации вопросов для квиза вынесена в отдельную сущность.
3. Часть логики приложения вынесена в отдельный класс ~~ResultAlertPresenter~~ AlertPresenter.
4. Обработка нажатия на кнопку алерт реализована с использованием либо замыкания, либо делегата.
5. Реализована функция сохранения лучшего результата store (с проверкой на то, что новый лучший результат сохранён в UserDefaults). К самому алерту в поле message передан сформированный из рекордной игры текст.
6. Приложение выглядит корректно — элементы интерфейса адаптируются под разрешения экранов iPhone, начиная с X — вёрстка под SE и iPad не предусмотрена.
7. Приложение запускается и работает корректно по функциональным и техническим требованиям.
8. По окончании раунда вызывается алерт, который соответствует макету и на котором отображаются следующие данные:
- Текущий результат в виде соотношения правильно отвеченных в раунде вопросов и общего количества вопросов в одном раунде.
- Количество сыгранных квизов за всё время, что приложение установлено.
- Лучший результат за всё время, что приложение установлено. В той же строке должна выводится дата достижения этого результата в формате согласно макетам.
- Средняя точность рассчитывается как отношение правильно отвеченных вопросов за всё время игры к общему количеству вопросов за всё время игры. Точность должна быть выражена в процентах.
9. Ваш класс ~~StatisticServiceImplementation~~ StatisticsService закрыт протоколом ~~StatisticService~~ StatisticsServiceProtocol. В MovieQuizViewController используется переменная ~~statisticService~~ statisticsService типа ~~StatisticService~~ StatisticsServiceProtocol.
10. В коде нет ретейн циклов.
11. Попробуйте завершить приложение, выкинув его из памяти и запустив снова. Ваши результаты, которые показываются в конце раунда, не должны обнулиться.

---

## Сдаём задачу спринта 6 на ревью (ветка sprint_06)

Поздравляем: вы завершили 6-й спринт. Пришло время для ревью!
Вам нужно сдать проект, в котором:
- Добавлена работа с сетью, список фильмов загружается из API IMDb.
- Обработаны состояния приложения при загрузке фильмов и получения ошибок.

## Убедитесь, что:

1. Приложение запускается и работает корректно по функциональным и техническим требованиям.
2. Добавлена работа с сетью (фильмы для квиза должны загружаться из открытого API IMDb).
3. В приложении использованы фильмы из топ-250 и самых популярных фильмов IMDb.
4. Обновлён метод viewDidLoad() в MovieQuizViewController — там вы должны начинать загрузку данных и показывать индикатор загрузки (уже показанный метод showLoadingIndicator()).
5. Если происходит ошибка загрузки данных о фильмах, то показывается алерт с ошибкой.
6. Приложение не пишет в логи сообщения об ошибках, связанных с работой с UI из другого потока.
