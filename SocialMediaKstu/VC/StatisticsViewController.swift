import UIKit
import DGCharts
import Charts
import CoreGraphics
import SnapKit
class StatisticsViewController: UIViewController {
    // Создаем таблицу
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.layer.borderColor = UIColor.gray.cgColor
        tableView.layer.borderWidth = 1.0
        tableView.separatorStyle = .none
        return tableView
    }()
    private var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Топ 10 пользователей"
        label.font = UIFont(name: "Tilda Sans Bold", size: 35)
        label.textAlignment = .center
        
        return label
    }()
    private let barChartView: BarChartView = {
        let chartView = BarChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.legend.enabled = true // Включаем легенду
        chartView.xAxis.labelPosition = .bottom // Подписи оси X внизу
        chartView.xAxis.drawGridLinesEnabled = false // Убираем линии сетки
        chartView.rightAxis.enabled = false // Убираем правую ось
        chartView.leftAxis.axisMinimum = 0 // Минимум оси Y — 0
        return chartView
    }()
    private let pieChartView: PieChartView = {
        let chart = PieChartView()
               chart.translatesAutoresizingMaskIntoConstraints = false
               chart.usePercentValuesEnabled = true  // Включение процентов на диаграмме
               chart.legend.enabled = true  // Включение легенды
               chart.drawSlicesUnderHoleEnabled = false  // Отключение отображения под диаграммой
               chart.holeColor = .white  // Цвет центральной дырки
               return chart    }()
    private let viewModel = StatisticsViewModel()
    private let chartViewModel = ChartViewModel()
    private var userStatistics: [StatisticsViewModel.UserStatistics] = []
    private var userCharts: [ChartViewModel.UserChart] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        self.updateBarChart()
        
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        let scrollView = UIScrollView()
           scrollView.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(scrollView)
        let contentView = UIView()
          contentView.translatesAutoresizingMaskIntoConstraints = false
          scrollView.addSubview(contentView)
        scrollView.snp.makeConstraints { make in
               make.edges.equalToSuperview()
           }
           
           contentView.snp.makeConstraints { make in
               make.width.equalToSuperview()
               make.top.equalToSuperview()
               make.bottom.equalToSuperview()
           }
        contentView.addSubview(tableView)
        contentView.addSubview(barChartView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(pieChartView)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
     
           
        barChartView.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(100)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(300)
        }
        pieChartView.snp.makeConstraints{make in
            make.top.equalTo(barChartView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalTo(300)

        }
        titleLabel.snp.makeConstraints{make in
            make.top.equalTo(pieChartView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        tableView.snp.makeConstraints{make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(contentView.snp.bottom).inset(20) // Добавьте нижнее ограничение
            
        }
        
        
    }
    
    private func fetchData() {
        viewModel.fetchTopUsers { [weak self] stats in
            guard let self = self else { return }
            self.userStatistics = stats
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        chartViewModel.fetchChart { [weak self] charts in
            guard let self = self else { return }
            self.userCharts = charts
            DispatchQueue.main.async {
                self.updateBarChart()
                self.updatePieChart()
            }
        }
    }  
    private func updatePieChart() {
        // Определяем возрастные диапазоны
        let ageRanges = ["0-20", "21-30", "31-40", "41+"]
        
        // Массив для хранения количества пользователей в каждом возрастном диапазоне
        var ageCounts = [0, 0, 0, 0]
        
        // Разбиваем пользователей на возрастные группы
        for user in userCharts { // Используем userCharts, а не users
            let ageIndex: Int
            switch user.age {
            case 0...20:
                ageIndex = 0
            case 21...30:
                ageIndex = 1
            case 31...40:
                ageIndex = 2
            default:
                ageIndex = 3
            }
            
            // Увеличиваем соответствующий счетчик
            ageCounts[ageIndex] += 1
        }
        
        // Преобразуем данные в формат, который требуется для диаграммы
        let entries = zip(ageRanges, ageCounts).map { PieChartDataEntry(value: Double($0.1), label: $0.0) }
        
        // Создаем набор данных для диаграммы
        let dataSet = PieChartDataSet(entries: entries, label: "Возрастные группы")
        
        // Настроим цвета для секторов
        dataSet.colors = [UIColor.blue, UIColor.green, UIColor.orange, UIColor.red]
        
        // Настроим отображение значений на диаграмме
        dataSet.valueTextColor = .black
        dataSet.valueFont = .systemFont(ofSize: 14)
        
        // Создаем объект данных для диаграммы
        let data = PieChartData(dataSet: dataSet)
        
        // Передаем данные в график
        pieChartView.data = data
    }

    private func updateBarChart() {
        // Подсчитываем количество мужчин и женщин
        var maleCount = 0
        var femaleCount = 0

        for user in userCharts {
            if user.gender == "Мужчина" {
                maleCount += 1
            } else if user.gender == "Женщина" {
                femaleCount += 1
            }
        }

        // Выводим значения для отладки
        print("Мужчины: \(maleCount), Женщины: \(femaleCount)")

        // Создаем записи для графика с целыми числами
        let maleEntry = BarChartDataEntry(x: 0, y: Double(maleCount))
        let femaleEntry = BarChartDataEntry(x: 0.5, y: Double(femaleCount))

        // Настроим наборы данных для мужчин и женщин
        let maleDataSet = BarChartDataSet(entries: [maleEntry], label: "Мужчины")
        maleDataSet.colors = [UIColor.blue.withAlphaComponent(0.7)] // Полупрозрачный синий
        maleDataSet.valueTextColor = .black
        maleDataSet.valueFont = .systemFont(ofSize: 12)
        maleDataSet.drawValuesEnabled = true // Показываем значения на графике

        let femaleDataSet = BarChartDataSet(entries: [femaleEntry], label: "Женщины")
        femaleDataSet.colors = [UIColor.red.withAlphaComponent(0.7)] // Полупрозрачный красный
        femaleDataSet.valueTextColor = .black
        femaleDataSet.valueFont = .systemFont(ofSize: 12)
        femaleDataSet.drawValuesEnabled = true // Показываем значения на графике

        // Объединяем данные для баров
        let data = BarChartData(dataSets: [maleDataSet, femaleDataSet])
        data.barWidth = 0.35
        barChartView.data = data

        // Настройка оси X для отображения "Мужчины" и "Женщины"
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["Мужчины", "Женщины"])
        barChartView.xAxis.granularity = 1
        barChartView.xAxis.centerAxisLabelsEnabled = true
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelFont = .systemFont(ofSize: 14, weight: .bold)
        barChartView.xAxis.labelTextColor = .darkGray

        // Настройка оси Y
        barChartView.leftAxis.axisMinimum = 0
        let maxValue = max(maleCount, femaleCount) + 1 // Добавляем 1 для визуального отступа
        barChartView.leftAxis.axisMaximum = Double(maxValue) // Устанавливаем максимальное значение на оси Y
        barChartView.leftAxis.labelTextColor = .black
        barChartView.leftAxis.labelFont = .systemFont(ofSize: 12)

        // Отключаем правую ось
        barChartView.rightAxis.enabled = false

        // Настройка легенды
        barChartView.legend.form = .circle
        barChartView.legend.font = .systemFont(ofSize: 14)
        barChartView.legend.textColor = .black

        // Анимация графика
        barChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInOutQuart)

        // Группировка столбцов
        barChartView.groupBars(fromX: 0, groupSpace: 0.4, barSpace: 0.15)
    }

}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension StatisticsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userStatistics.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }

        let userStat = userStatistics[indexPath.row]
        cell.configure(with: userStat)
        cell.detailLabel.text = "\(userStat.correctAnswers)правильных ответов из 10"
        cell.emailLabel.text = "\(indexPath.row + 1). \(userStat.email)"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70 // Высота каждой строки
    }
    // Изменяем цвет при нажатии
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           // Меняем цвет фона выбранной ячейки на бежевый
           let cell = tableView.cellForRow(at: indexPath)
           cell?.contentView.backgroundColor = .white
       }

       // Восстанавливаем цвет при отмене выбора ячейки
       func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
           let cell = tableView.cellForRow(at: indexPath)
           cell?.contentView.backgroundColor = .white
       }
   
}
