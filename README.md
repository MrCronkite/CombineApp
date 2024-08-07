
<h1>Combine</h1>

<h2>Что такое реактивное программирование?</h2>

<p>Реактивное программирование — это парадигма программирования, направленная на работу с асинхронными потоками данных. В этой парадигме данные рассматриваются как потоки, и изменения данных обрабатываются в реальном времени. Реактивное программирование часто используется для создания систем, которые реагируют на события, изменения состояния или пользовательские действия.</p>

<h3>Основные концепции реактивного программирования включают:</h3>

<ol>
    <li>
        <strong>Потоки данных (Streams)</strong>: Поток представляет собой последовательность данных, которые могут поступать асинхронно. Потоки могут содержать данные различных типов, включая события, значения или ошибки.
    </li>
    <li>
        <strong>Наблюдатели (Subscribers)</strong>: Наблюдатель подписывается на поток данных и реагирует на поступающие данные, ошибки или завершение потока. Наблюдатели определяют, что делать при каждом из этих событий.
    </li>
    <li>
        <strong>Издатели (Publishers)</strong>: Издатель создает и управляет потоком данных, который может быть подписан наблюдателями.
    </li>
    <li>
        <strong>Операторы (Operators)</strong>: Операторы позволяют трансформировать, фильтровать и комбинировать потоки данных. Примеры операторов включают <code>map</code>, <code>filter</code>, <code>merge</code>, <code>flatMap</code> и т.д.
    </li>
</ol>

<h3>Пример использования Combine</h3>

<p>Рассмотрим простой пример на языке Swift с использованием библиотеки Combine:</p>

<pre><code class="language-swift">
import Combine

// Издатель, который отправляет значения от 1 до 5
let numbers = [1, 2, 3, 4, 5].publisher

// Подписчик, который печатает значения
let cancellable = numbers
    .map { $0 * 2 }            // Умножаем каждое значение на 2
    .filter { $0 > 5 }         // Фильтруем значения больше 5
    .sink(receiveValue: {
        print($0)
    })

// Вывод: 6, 8, 10
</code></pre>

<p>В этом примере:</p>

<ul>
    <li>Создается издатель <code>numbers</code>, который отправляет числа от 1 до 5.</li>
    <li>С помощью оператора <code>map</code> каждое значение потока умножается на 2.</li>
    <li>С помощью оператора <code>filter</code> выбираются только те значения, которые больше 5.</li>
    <li>Метод <code>sink</code> определяет, что делать с элементами потока — в данном случае они выводятся на консоль.</li>
</ul>

<h3>Применение</h3>

<p>Реактивное программирование широко используется в разработке пользовательских интерфейсов, особенно при работе с асинхронными данными и событиями. Например, в мобильных приложениях оно помогает обрабатывать пользовательские действия, обновлять интерфейс в ответ на изменения данных, а также управлять сетевыми запросами и другими асинхронными операциями.</p>

<h1 class="toggle-button">Publishers</h1>
    <div class="content">
        <h2>Основные Publishers</h2>
        <ul>
            <li><strong>Just</strong>: Немедленно отправляет одно значение и завершает.</li>
            <li><strong>Future</strong>: Отправляет одно значение или ошибку в будущем.</li>
            <li><strong>Deferred</strong>: Создает Publisher, когда кто-то подписывается.</li>
            <li><strong>Empty</strong>: Немедленно завершает без отправки значений.</li>
            <li><strong>Fail</strong>: Немедленно завершает с ошибкой.</li>
            <li><strong>Record</strong>: Записывает последовательность значений и завершений.</li>
        </ul>
        <h2>Таймер и Расписание</h2>
        <ul>
            <li><strong>Timer.TimerPublisher</strong>: Отправляет значения по расписанию.</li>
            <li><strong>Publishers.Sequence</strong>: Отправляет значения из последовательности.</li>
        </ul>
        <h2>Системные Publishers</h2>
        <ul>
            <li><strong>NotificationCenter.Publisher</strong>: Отправляет уведомления.</li>
            <li><strong>URLSession.DataTaskPublisher</strong>: Отправляет результаты сетевых запросов.</li>
        </ul>
        <h2>Subject (Специальные Publishers, поддерживающие отправку значений вручную)</h2>
        <ul>
            <li><strong>PassthroughSubject</strong>: Отправляет значения подписчикам напрямую.</li>
            <li><strong>CurrentValueSubject</strong>: Хранит текущее значение и отправляет его новым подписчикам.</li>
        </ul>
        <h2>Другие полезные Publishers</h2>
        <ul>
            <li><strong>Publishers.CombineLatest</strong>: Комбинирует последние значения из двух Publishers.</li>
            <li><strong>Publishers.Merge</strong>: Объединяет выходные данные нескольких Publishers.</li>
            <li><strong>Publishers.Zip</strong>: Объединяет значения из нескольких Publishers по парам.</li>
        </ul>
    </div>


