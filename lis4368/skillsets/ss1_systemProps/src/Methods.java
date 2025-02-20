public class Methods {
    public static void getRequirements(){
        System.out.println("Author: Finn Saunders");
        System.out.println("Program lists system.properties");

    }

    public static void systemProperties()
    {
        System.out.println("System file path seperator: " + System.getProperty("file.separator"));
        System.out.println("Java class path: " + System.getProperty("java.class.path"));
        System.out.println("Java installation directory: " + System.getProperty("java.home"));
        System.out.println("Java vonder name: " + System.getProperty("java.vendor"));
        System.out.println("Java vondor URL: " + System.getProperty("java.vendor.url"));
        System.out.println("Java version number: " + System.getProperty("java.version"));
        System.out.println("JRE version: " + System.getProperty("java.runtime.version"));
        System.out.println("OS architecture: " + System.getProperty("os.arch"));
        System.out.println("OS name: " + System.getProperty("os.name"));
        System.out.println("OS version: " + System.getProperty("os.version"));
        System.out.println("Path separator used in java.class.path: " + System.getProperty("path.separator"));
        System.out.println("User working directory: " + System.getProperty("user.dir"));
        System.out.println("User home directory: " + System.getProperty("user.home"));
        System.out.println("User account name: " + System.getProperty("user.name"));
    }
}
