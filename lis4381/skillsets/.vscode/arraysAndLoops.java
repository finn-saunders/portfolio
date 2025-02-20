public class arraysAndLoops{
    public static void main(String[] args){
        String[] animals = {"dog", "cat", "bird", "fish", "insect"};
        System.out.println("Program loops through an array of strings.");
        System.out.println("Use the following values: dog, cat, bird, fish, and insect");
        System.out.println("Use the following loop structures: for, enhanced for, while, do...while\n");

        System.out.println("Note: pretest loops for, enhanced for, while. Posttest loop: do...while\n" );


        //for loop
        System.out.println("for loop:");
        for (int i = 0; i < animals.length; i++) {
            System.out.println(animals[i]);
        }

        //enhanced for loop
        System.out.println("\nEnhanced for loop:");
        for (String animal: animals) {
            System.out.println(animal);
        }

        //while loop
        System.out.println("\nWhile loop:");
        int index = 0;
        while (index <animals.length) {
            System.out.println(animals[index]);
            index++;
        }

        //do..while loop
        System.out.println("do..while loop:");
        index = 0;
        do {
            System.out.println(animals[index]);
            index++;
        } while (index < animals.length);
    }
}