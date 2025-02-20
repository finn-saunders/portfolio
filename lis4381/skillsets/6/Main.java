class Main {

    public static void main(String argst[])
    {
        Methods.getRequirements();
       // System.out.println("***Call static(no object) void (non-value returning) method:*** ");
        int[] myArray = Methods.createArray();
        Methods.generatePseudoRandomNumbers(myArray);
    }
}
