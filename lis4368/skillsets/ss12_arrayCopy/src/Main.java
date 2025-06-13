class Main
{
    public static void main(String args[])
    {
        // call static void methods (i.e., no object, non-value returning)
        Methods.getRequirements();
        
        // Java style String[] myArray
        // C++ style String myArray[]
        // call createArray() method in Methods class
        // returns initialized array, array size determined by user
        String[] userArray = Methods.createArray(); //Java style array

        // Prints pseudo-randomly generated numbers, determined by number user inputs
        Methods.copyArray(userArray); //pass array
    }
}