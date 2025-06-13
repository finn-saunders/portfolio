public class Book {

    private String author;





    public String getAuthor() {
        return author;
    }

    public void seAuthor(String au) {
        author = au;
    }

    public void print() {
        System.out.println("\nAuthor: " + author);
    }
}
