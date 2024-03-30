package dk.studiosw.payslipgenerator;

import dk.studiosw.payslipgenerator.dao.PayslipRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = "dk.studiosw")
public class PayslipgeneratorApplication implements CommandLineRunner {

	@Autowired
	PayslipRepository repo;

	public static void main(String[] args) {
		SpringApplication.run(PayslipgeneratorApplication.class, args);
	}

	@Override
	public void run(String... strings) throws Exception {

	}
}
