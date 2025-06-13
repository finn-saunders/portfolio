public class Book extends Product {

    private String author;

    // No-arg constructor
    public Book() {
        // Calls the no-arg constructor of Product implicitly
        System.out.println("Inside book default constructor.");
        author = "Unknown Author";
    }

    // Parameterized constructor (4 arguments)
    public Book(String code, String description, double price, String author) {
        // Call Product's parameterized constructor for the first 3
        super(code, description, price);
        System.out.println("Inside book constructor with parameters.");
        this.author = author;
    }

    // Setter for author
    public void setAuthor(String author) {
        this.author = author;
    }

    // Getter for author
    public String getAuthor() {
        return author;
    }

    // Overrides the base class print() method
    @Override
    public void print() {
        // You can call super.print() to display Product fields
        super.print();
        System.out.println("Author: " + author);
    }
}
