

import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Main {
	public static void main(String[] args) {
		FileWriter fw_append; 
		try {
			SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
			Date time = new Date();
			String time1 = format.format(time);
					
			System.out.println(time1);
			fw_append = new FileWriter(".\\output.txt", true);
			fw_append.write(time1+"\r\n");
			fw_append.close();
		} catch (IOException e1) {
			e1.printStackTrace();
		}

		return;
				
	}

}
