import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Scanner; 
public class F1DatabaseApp {
    public static void main(String args[]) {
        String connectionUrl = 
        "jdbc:sqlserver://cxp-sql-02\\dxz365;" //edit with your case ID
        + "database=F1Database;"
        + "user=F1user;"
        + "password=25F1Data!@#11;"
        + "encrypt=true;"
        + "trustServerCertificate=true;"
        + "loginTimeout=15;";

        Scanner sc = new Scanner(System.in);

        System.out.println("Enter the letter for the menu item you want to execute (See Use Cases for More Info):"
                            + "\n A. Insert a New Team"
                            + "\n B. Cancel a Race"
                            + "\n C. Enter Race Results"
                            + "\n D. Insert a New Driver"
                            + "\n E. Adjust Result for Disqualification"
                            + "\n F. Award Points for Fastest Lap");
        String userInput = sc.nextLine();

        switch (userInput.toUpperCase()) {
            case "A":
                insertNewTeamNDS(connectionUrl, sc);
                break;

            case "B":
                cancelRace(connectionUrl, sc);
                break;
            
            case "C":
                enterRace(connectionUrl, sc);
                break;
            
            case "D":
                insertDriver(connectionUrl, sc);
                break;

            case "E":
                AdjustResultDSQ(connectionUrl, sc);

            case "F":
                AwardFastestLap(connectionUrl, sc);
            //add your case below
        }
    }
    
    //Dylan Zhao's Insert New Team (New Drivers) Use Case
    public static void insertNewTeamNDS(String connectionUrl, Scanner sc) {
        System.out.println("Please enter the short name of the new team:");
            String name = sc.nextLine();

            System.out.println("Please enter the full name of the new team:");
            String fullname = sc.nextLine();

            System.out.println("Please enter the country of origin for the new team:");
            String country = sc.nextLine();

            System.out.println("Please enter the engine used by the new team:");
            String engine = sc.nextLine();

            System.out.println("Please enter the first name of the first driver:");
            String fname1 = sc.nextLine();

            System.out.println("Please enter the last name of the first driver:");
            String lname1 = sc.nextLine();

            System.out.println("Please enter the date of birth of the first driver"
                                + " in the format of YYYY-MM-DD:");
            String dob1 = sc.nextLine();
            
            System.out.println("Please enter the nationality of the first driver:");
            String nat1 = sc.nextLine();

            System.out.println("Please enter the car number of the first driver:");
            int carnum1 = Integer.parseInt(sc.nextLine());
            
            System.out.println("Please enter the first name of the second driver:");
            String fname2 = sc.nextLine();

            System.out.println("Please enter the last name of the second driver:");
            String lname2 = sc.nextLine();

            System.out.println("Please enter the date of birth of the second driver"
                                + " in the format of YYYY-MM-DD:");
            String dob2 = sc.nextLine();
            
            System.out.println("Please enter the nationality of the second driver:");
            String nat2 = sc.nextLine();
            
            System.out.println("Please enter the car number of the second driver:");
            int carnum2 = Integer.parseInt(sc.nextLine());

            

            System.out.println("Team - name: " + name + ", fullname: " + fullname + ", country: " + country +
                                ", engine: " + engine);
            System.out.println("Driver One - fname: " + fname1 + ", lname: " + lname1 + ", dob: " + dob1 +
                                 ", nationality: " + nat1 + ", carnum: " + carnum1);
            System.out.println("Driver Two - fname: " + fname2 + ", lname: " + lname2 + ", dob: " + dob2 +
                                 ", nationality: " + nat2 + ", carnum: " + carnum2);
            
            String callInsertNewTeamNDS = "{call dbo.InsertNewTeamNDS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";

            try (Connection connection = DriverManager.getConnection(connectionUrl);
                CallableStatement prepsStoredProc = connection.prepareCall(callInsertNewTeamNDS);) {
            
            connection.setAutoCommit(false);
           
            prepsStoredProc.setString(1, name); 
            prepsStoredProc.setString(2, fullname);
            prepsStoredProc.setString(3, country);
            prepsStoredProc.setString(4, engine);

            prepsStoredProc.setString(5, fname1);
            prepsStoredProc.setString(6, lname1);
            prepsStoredProc.setString(7, dob1);
            prepsStoredProc.setString(8, nat1);
            prepsStoredProc.setInt(9, carnum1);

            prepsStoredProc.setString(10, fname2);
            prepsStoredProc.setString(11, lname2);
            prepsStoredProc.setString(12, dob2);
            prepsStoredProc.setString(13, nat2);
            prepsStoredProc.setInt(14, carnum2);
          
            prepsStoredProc.registerOutParameter(15, java.sql.Types.INTEGER);
            prepsStoredProc.registerOutParameter(16, java.sql.Types.INTEGER);
            prepsStoredProc.registerOutParameter(17, java.sql.Types.INTEGER);
            prepsStoredProc.execute();

            
            System.out.println("Generated Team ID: " + prepsStoredProc.getInt(15));
            System.out.println("Generated Driver ID: " + prepsStoredProc.getInt(16) +
                                ", " + prepsStoredProc.getInt(17));
            
            System.out.println("Commit or Rollback?");
            String userInput = sc.nextLine();

            if (userInput.equalsIgnoreCase("Commit")){
                connection.commit();
            } else {
                connection.rollback();
            }
            sc.close();
            }

            catch (SQLException e) {
            e.printStackTrace();
            }
    }

    //Dylan Zhao's CancelRace Use Case
    public static void cancelRace(String connectionUrl, Scanner sc) {
        System.out.println("Please enter the season:");
        int season = Integer.parseInt(sc.nextLine());

        System.out.println("Please enter the round:");
        int round = Integer.parseInt(sc.nextLine());


        System.out.println("Print enter the date in the format YYYY-MM-DD:");
        String date = sc.nextLine();

        System.out.println("season: " + season + ", round: " + round + ", date:" + date);

        String callCancelRace = "{call dbo.CancelRace(?,?,?,?,?)}";

        try (Connection connection = DriverManager.getConnection(connectionUrl);
            CallableStatement prepsStoredProc = connection.prepareCall(callCancelRace);) {
        
        connection.setAutoCommit(false);
        prepsStoredProc.setInt(1, season);
        prepsStoredProc.setInt(2, round);
        prepsStoredProc.setString(3, date);
        prepsStoredProc.registerOutParameter(4, java.sql.Types.INTEGER);
        prepsStoredProc.registerOutParameter(5, java.sql.Types.INTEGER);
        prepsStoredProc.execute();

        System.out.println("Number of Rows Deleted in Result Table: " + prepsStoredProc.getInt(4));
        System.out.println("Number of Rows Deleted in Race Table: " + prepsStoredProc.getInt(5));
        System.out.println("Commit or Rollback?");
        String userInput = sc.nextLine();

        if (userInput.equalsIgnoreCase("Commit")){
            connection.commit();
        } else {
            connection.rollback();
        }
        sc.close();
        }

        catch (SQLException e) {
        e.printStackTrace();
        }       

    }

    public static void enterRace(String connectionUrl, Scanner sc) {
        System.out.println("Circuit name  :");
        String cname = sc.nextLine();

        System.out.println("Driver's first name :");
        String fname = sc.nextLine();

        System.out.println("Driver's last  name :");
        String lname = sc.nextLine();

        System.out.println("Car number (int)    :");
        int carNum = Integer.parseInt(sc.nextLine());

        System.out.println("Finishing position  :");
        int position = Integer.parseInt(sc.nextLine());

        System.out.println("Points awarded      :");
        int points = Integer.parseInt(sc.nextLine());

        System.out.println("Status (e.g. \"Finished\", \"DNF\"):");
        String status = sc.nextLine();

        System.out.println("Finish time      :");
        int time = Integer.parseInt(sc.nextLine());

        System.out.println("Race date (YYYY-MM-DD)      :");
        java.sql.Date date = java.sql.Date.valueOf(sc.nextLine());

        System.out.printf(
                "%nCONFIRM →  circuit=%s, driver=%s %s, car=%d, position=%d, points=%d, status=%s, time=%s, date=%s%n",
                cname, fname, lname, carNum, position, points, status, time, date);

        String call = "{call dbo.enterRaceResults(?,?,?,?,?,?,?,?,?,?)}";

        try (Connection cn = DriverManager.getConnection(connectionUrl);
                CallableStatement cs = cn.prepareCall(call)) {

            cn.setAutoCommit(false);

            cs.setString(1, cname);
            cs.setString(2, fname);
            cs.setString(3, lname);
            cs.setInt(4, carNum);
            cs.setInt(5, position);
            cs.setInt(6, points);
            cs.setString(7, status);
            cs.setInt(8, time);
            cs.setDate(9, date);

            cs.registerOutParameter(10, java.sql.Types.INTEGER); // @resultID
            cs.execute();

            int resultID = cs.getInt(10);
            System.out.println("→ New Result ID = " + resultID);

            System.out.print("Commit or Rollback? ");
            if (sc.nextLine().equalsIgnoreCase("Commit"))
                cn.commit();
            else
                cn.rollback();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }       
    }

    public static void insertDriver(String connectionUrl, Scanner sc) {
        System.out.println("Team short-name       :");
        String tname = sc.nextLine();

        System.out.println("Driver first name     :");
        String fname = sc.nextLine();

        System.out.println("Driver last  name     :");
        String lname = sc.nextLine();

        System.out.println("Date of birth (YYYY-MM-DD):");
        java.sql.Date dob = java.sql.Date.valueOf(sc.nextLine());

        System.out.println("Nationality           :");
        String nationality = sc.nextLine();

        System.out.println("Car number (int)      :");
        int carNum = Integer.parseInt(sc.nextLine());

        String call = "{call dbo.insertDriver(?,?,?,?,?,?,?)}";

        try (Connection cn = DriverManager.getConnection(connectionUrl);
                CallableStatement cs = cn.prepareCall(call)) {

            cn.setAutoCommit(false);

            cs.setString(1, tname);
            cs.setString(2, fname);
            cs.setString(3, lname);
            cs.setDate(4, dob);
            cs.setString(5, nationality);
            cs.setInt(6, carNum);

            cs.registerOutParameter(7, java.sql.Types.INTEGER); // @dID
            cs.execute();

            System.out.println("→ New Driver ID = " + cs.getInt(7));

            System.out.print("Commit or Rollback? ");
            if (sc.nextLine().equalsIgnoreCase("Commit"))
                cn.commit();
            else
                cn.rollback();

        } catch (SQLException ex) {
            // if RAISERROR fired in the proc, the message and error‑code appear here
            System.out.println("SQL-related error occured with InsertDriver");
            ex.printStackTrace();
        }

        catch (Exception e) {
            System.out.println("Another error occured during InsertDriver.");
            e.printStackTrace();
        }
    }

    public static void AdjustResultDSQ(String connectionUrl, Scanner sc) {
        ArrayList<Integer> points = new ArrayList<>();
        points.add(25);
        points.add(18);
        points.add(15);
        points.add(12);
        points.add(10);
        points.add(8);
        points.add(6);
        points.add(4);
        points.add(2);
        points.add(1);
        points.add(0);
        points.add(0);
        points.add(0);
        points.add(0);
        points.add(0);
        points.add(0);
        points.add(0);
        points.add(0);
        points.add(0);
        points.add(0);
        points.add(0);
        System.out.println("Please enter the dID of the driver:");
        int dID = Integer.parseInt(sc.nextLine());

        System.out.println("Please enter the rID of the race:");
        int rID = Integer.parseInt(sc.nextLine());
            
        String callAdjustResultDSQ = "{call dbo.AdjustResultDSQ(?,?,?,?,?)}";
        String callAdjustPoint = "{call dbo.FixFirstDSQ(?,?,?,?)}";
        String callFixRest = "{call dbo.FixResultDSQ(?,?,?,?,?,?,?)}";

        try (Connection connection = DriverManager.getConnection(connectionUrl);
            CallableStatement AdjustResult = connection.prepareCall(callAdjustResultDSQ);
            CallableStatement AdjustPoint = connection.prepareCall(callAdjustPoint);
            CallableStatement FixRest = connection.prepareCall(callFixRest);
            ) {
            
            connection.setAutoCommit(false);
           
            AdjustResult.registerOutParameter(1, dID); 
            AdjustResult.registerOutParameter(2, java.sql.Types.INTEGER);
            AdjustResult.setInt(3, rID);
            AdjustResult.registerOutParameter(4, java.sql.Types.INTEGER);
            AdjustResult.registerOutParameter(5, java.sql.Types.INTEGER);

            AdjustResult.execute();

            AdjustPoint.setInt(1, points.get(AdjustResult.getInt(5)-1));
            AdjustPoint.setInt(2, AdjustResult.getInt(4));
            AdjustPoint.setInt(3, AdjustResult.getInt(1));
            AdjustPoint.setInt(4, AdjustResult.getInt(2));

            AdjustPoint.execute();
            
            for(int i = AdjustResult.getInt(5); i<21; i++){
                FixRest.setInt(1, rID);
                FixRest.setInt(2, AdjustResult.getInt(4));
                FixRest.setInt(3, i+1);
                FixRest.setInt(4, points.get(i));
                FixRest.setInt(5, points.get(i-1));
                FixRest.setInt(6, java.sql.Types.INTEGER);
                FixRest.setInt(7, java.sql.Types.INTEGER);

                FixRest.execute();
            }
            
            System.out.println("Commit or Rollback?");
            String userInput = sc.nextLine();

            if (userInput.equalsIgnoreCase("Commit")){
                connection.commit();
            } else {
                connection.rollback();
            }
            sc.close();
        }

        catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Sean Liu Use Case: Award Fastest Lap
    public static void AwardFastestLap(String connectionUrl, Scanner sc) {
        System.out.println("Please enter the rID of the race:");
        int race = Integer.parseInt(sc.nextLine());

        String callAwardFastestLap = "{call dbo.AwardFastestLap(?,?,?,?)}";

        try (Connection connection = DriverManager.getConnection(connectionUrl);
            CallableStatement AwardPoint = connection.prepareCall(callAwardFastestLap);
            ) {
            
            connection.setAutoCommit(false);

            AwardPoint.setInt(1, race);
            AwardPoint.registerOutParameter(2, java.sql.Types.INTEGER);
            AwardPoint.registerOutParameter(3, java.sql.Types.INTEGER);
            AwardPoint.registerOutParameter(4, java.sql.Types.INTEGER);

            AwardPoint.execute();
            
            System.out.println("Commit or Rollback?");
            String userInput = sc.nextLine();

            if (userInput.equalsIgnoreCase("Commit")){
                connection.commit();
            } else {
                connection.rollback();
            }
            sc.close();
        }

        catch (SQLException e) {
            e.printStackTrace();
        }
    }
}