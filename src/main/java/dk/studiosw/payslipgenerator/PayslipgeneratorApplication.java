package dk.studiosw.payslipgenerator;

import dk.studiosw.payslipgenerator.dao.EarningsRepository;
import dk.studiosw.payslipgenerator.dao.PayslipRepository;
import dk.studiosw.payslipgenerator.pdfgenerator.PdfGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.io.FileNotFoundException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@SpringBootApplication(scanBasePackages = "dk.studiosw")
public class PayslipgeneratorApplication implements CommandLineRunner {

	private final static DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern( "ddMMyyyy");

	@Autowired
	PayslipRepository payslipRepo;

	@Autowired
	PdfGenerator pdfGenerator;

	public static void main(String[] args) {
		SpringApplication.run(PayslipgeneratorApplication.class, args);
	}

	@Override
	public void run(String... strings) throws Exception {
		/*
		if(strings.length == 2) {

			var fromDate = LocalDate.parse(strings[0]);
			var toDate = LocalDate.parse(strings[1]);

			var models = payslipRepo.getModelsWithEarningsInPeriod(fromDate, toDate);

			models.forEach(m -> {
				var payslip = payslipRepo.getPayslip(fromDate, toDate, m.id());
				try {
					pdfGenerator.generate("Pago " + payslip.getFullname() + " " + fromDate.format(dateFormatter) + " " + toDate.format(dateFormatter) + ".pdf", payslip);
				} catch (FileNotFoundException e) {
					throw new RuntimeException(e);
				}
			});
		} */
	}
}
