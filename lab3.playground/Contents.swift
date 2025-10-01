import Foundation

//Part 1
//продукт — это просто данные без уникальной идентичности - можно копировать, изменять локально, хранить в массиве -> so struct
struct Product {
    let id: String
    let name: String
    let price: Double
    let category: Category
    let description: String
    
    enum Category: String {                                     //перечисления какие могут быть категории товаров
        case electronics, clothing, food, books, furniture, beauty
    }
        
    var displayPrice: String {                          //computed property -> берем строку и переписываем цену в формате с долларом и в сотых ->для читаемости
        return String(format: "$%.2f", price)
    }
    //кастомный инициализатор
    init?(id: String, name: String, price: Double, category: Category, description: String) {  // из за того что может вернуть нил(может не создаться или неправильно создаться ) ->failable initialize
        guard price > 0 else {                           // цена должна быть положительной
            return nil                                  // цена должна быть положительной
        }
        self.id = id                                     //инициализируем, сохраняем переданные значения в свойства структуры
        self.name = name
        self.price = price
        self.category = category
        self.description = description
    }
}

struct CartItem {                        //структура потому что когда ты копируешь CartItem, должна получаться независимая копия чтобы добаить е ее в корзину
    let product: Product
    private(set) var quantity: Int      //снаружи можно читать сколько у нас кол-во продукта, но не можем присвоить напрямую значение ему -для безопасности
    
    var subtotal: Double {              //вычисляем при обращении - общач сумма которую надо заплатить
        return product.price * Double(quantity)
    }
    
    mutating func updateQuantity(_ newQuantity: Int) {      //  // mutating метод для обновления количества
        guard newQuantity > 0 else { return }              // игнорируем тот факт если кол-во продукта 0 или меньше - в корзине не может быть товара меньше 1
        quantity = newQuantity
    }
    
    mutating func increaseQuantity(by amount: Int) {        // увеличение количества продукта
        guard amount > 0 else { return }                    //если кто-то попробует передать 0 или отрицательное значение то обновление проигнорируется
        quantity += amount
    }
}


//Part 2 Shopping Cart Class
// корзина должна быть идентичной и целостной - если ее изменить в одном месте то изменения все увидят - ref type
class ShoppingCart {
    private(set) var items: [CartItem] = []                   //массив элементов корзины -> другие могут читать - но не изменять(только чеез методы корзины)
    var discount: DiscountCode = .none                               // промокод если есть
    
    func addItem(product: Product, quantity: Int = 1) {         // если не указать кол-во по дефолту добавляется 1
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {        //есть ли уже этот товар в корзине - ищет позицию
            var existingItem = items[index]                     // достаём текущий CartItem
            existingItem.increaseQuantity(by: quantity)        // увеличиваем количество
            items[index] = existingItem                         // обновляем его в массиве
        } else {
            let newItem = CartItem(product: product, quantity: quantity)     //если нету -> создаем новый товар - добавляем его в корзину
            items.append(newItem)
        }
    }
    
    func removeItem(productId: String) {
        items.removeAll { $0.product.id == productId }      // удаляет товар по айдишке
    }
    
    func updateItemQuantity(productId: String, quantity: Int) {
        guard let index = items.firstIndex(where: { $0.product.id == productId }) else { return }   //ищем товар в массиве, если нету - сразу выходим
        if quantity <= 0 {
            removeItem(productId: productId)      // если кол-во товара 0 или меньше то удадяем товар с корзины
        } else {
            var item = items[index]                 // достаем товар
            item.updateQuantity(quantity)           //обновляем товар
            items[index] = item                     //кладем обратно
        }
    }
    
    func clearCart() {
        items.removeAll()                         //полностью очистить корзину  - пользователь передумал что то заказывать хоть и положил в корзину проудкты
    }
    
    var subtotal: Double {                  // перечисляется при обращении - суммирует стоимости товаров в корзине
        items.reduce(0) { $0 + $1.subtotal }
    }
    var displaySubTotal: String {
        return String(format: "$%.2f", subtotal)
    }
    func printCartContents() {
            if items.isEmpty {
                print("Cart is empty")
            } else {
                print("Cart contents:")
                for item in items {
                    print("- \(item.product.name) x\(item.quantity) = \(item.subtotal)")
                }
                print("Subtotal: \(displaySubTotal), Total with discount: \(displayTotal)")
            }
        }
    
    // Размер скидки
    enum DiscountCode {             // фиксированная вариация скидок у нас есть в магазине - только вот 10/20 процентов или ничего
        case save10
        case save20
        case none
        
        // Сколько процентов скидки
        var percentage: Double {
            switch self {
            case .save10: return 0.10
            case .save20: return 0.20
            case .none:   return 0.0
            }
        }
    }
    var discountAmount: Double {                //высчитываем скидку сколько будет
            subtotal * discount.percentage
        }
    
    var total: Double {                             // Итоговая сумма с учетом скидки
        subtotal - discountAmount
    }
    var displayTotal: String {
        return String(format: "$%.2f", total)
    }
    
    var itemCount: Int {                            // кол-во всех товаров
        items.reduce(0) { $0 + $1.quantity }            //запускается с 0 и кэшируется количество каждой позиции (quantity) и суммирует
    }
    
    var isEmpty: Bool {                                     // Проверка на пустоту - есть ли хоть что то в корзине
        items.isEmpty
    }
}

// Part 3: Address and Order

struct Address {                //набор данных без идентичности и поведения
    let street: String
    let city: String
    let zipCode: String
    let country: String
    
    var formattedAddress: String {
        "\(street)\n\(city), \(zipCode)\n\(country)"        //делает всё в одну строку красивым видом
    }
}

struct Order {                  //если передать заказ другому объекту то он получит копию и наш ориг заказ не изменится
    let orderId: String             //заказ нельзя менять после создания
    let items: [CartItem]
    let subtotal: Double
    let discountAmount: Double
    let total: Double
    let timestamp: Date
    let shippingAddress: Address
    
    init(from cart: ShoppingCart, shippingAddress: Address) {       //инициализурем все для создания объекта
        self.orderId = UUID().uuidString
        self.items = cart.items
        self.subtotal = cart.subtotal
        self.discountAmount = cart.discountAmount
        self.total = cart.total
        self.timestamp = Date()
        self.shippingAddress = shippingAddress
    }
    
    var itemCount: Int {
        items.reduce(0) { $0 + $1.quantity }            // Складываем количество каждого товара
    }
    
    func printOrderSummary() {
            print("Order ID: \(orderId)")
            print("Date: \(timestamp)")
            print("Shipping to:\n\(shippingAddress.formattedAddress)")
            print("Items:")
            for item in items {
                print("- \(item.product.name) x\(item.quantity) = \(item.subtotal)")
            }
            print("Subtotal: \(subtotal), Discount: \(discountAmount), Total: \(total)")
        }
    
}
extension Order {               //чтобы как то использвать заявленный timestamp как то с функционалом -> расшитываем денб доставки примерно
    var estimatedDeliveryDate: Date {
        return Calendar.current.date(byAdding: .day, value: 3, to: timestamp)!
    }
}

// Part 4 Tests and Demonstrations

//создаем продукты
let laptop = Product(id: "P1", name: "MacBook Pro", price: 1999.99, category: .electronics, description: "Mac M3 Pro 14inch")!
let book = Product(id: "P2", name: "1984", price: 39.99, category: .books, description: "A dystopian classic depicting a totalitarian society")!
let headphones = Product(id: "P3", name: "AirPods", price: 129.99, category: .electronics, description: "AirPods 3rd generation")!
let lipstick = Product(id: "P4", name: "Dior", price: 60.00, category: .beauty, description: "femininity and elegance incarnate, the must-have Dior lip product")!
let hoodie = Product(id: "P5", name: "QR", price: 20.55, category: .clothing, description: "very warm for ala's weather ")!

// корзина
let cart = ShoppingCart()
cart.addItem(product: laptop, quantity: 1)
cart.addItem(product: book, quantity: 2)
cart.addItem(product: lipstick, quantity: 5)
cart.addItem(product: hoodie, quantity: 1)
cart.addItem(product: headphones, quantity: 1)


// добавляем тот же товар снова чтобы проверить обновляется ли количество
cart.addItem(product: laptop, quantity: 1)
cart.addItem(product: book, quantity: 3)

cart.printCartContents()


cart.updateItemQuantity(productId: laptop.id, quantity: 5)         // демонстрация updateItemQuantity
print("Updated laptop quantity to 5. Item count: \(cart.itemCount)")


cart.printCartContents()

// подсчёты суммы за нашу корзину
print("Subtotal: \(cart.displaySubTotal)")
print("Item count: \(cart.itemCount)")

// скидки -> проверяем как работают проценты
cart.discount = .save10
print(cart.displayTotal)


// удаление товара из корзины
cart.removeItem(productId: book.id)
print("Cart after removing book: \(cart.itemCount) items")

// reference type demo
func modifyCart(_ c: ShoppingCart) {
    c.addItem(product: headphones, quantity: 1)
}
modifyCart(cart)                        // cart изменился, так как class это reference type
print("Cart now has \(cart.itemCount) items after modification")

// value type demo
let item1 = CartItem(product: laptop, quantity: 1)
var item2 = item1
item2.updateQuantity(5)                                                 // меняем копию
print("item1 quantity: \(item1.quantity), item2 qty: \(item2.quantity)")

// cоздание заказа
let address = Address(street: "Tole bi 59", city: "Almaty", zipCode: "050000", country: "Kazakhstan")
let order = Order(from: cart, shippingAddress: address)
print("Shipping to:\n\(order.shippingAddress.formattedAddress)")            //использование formattedAddress

let formatter = DateFormatter()
formatter.dateStyle = .medium
print("Estimated delivery: \(formatter.string(from: order.estimatedDeliveryDate))")   // примерно доставка занимает в среднем три дня и мы принтим юзеру что заказ будет через три дня 

// модификация корзины не влияет на заказ
cart.clearCart()
print("Order item count: \(order.itemCount)") // не изменился
print("Cart item count: \(cart.itemCount)")   // стал 0

// демонстрация категорий
print("Laptop category: \(laptop.category.rawValue)")
print("Book category: \(book.category.rawValue)")


order.printOrderSummary()




