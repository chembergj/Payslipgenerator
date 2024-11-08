package dk.studiosw.payslipgenerator.pdfgenerator;

import com.itextpdf.io.image.ImageData;
import com.itextpdf.io.image.ImageDataFactory;
import com.itextpdf.kernel.colors.ColorConstants;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Image;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.properties.HorizontalAlignment;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.layout.properties.UnitValue;
import com.itextpdf.layout.properties.VerticalAlignment;
import dk.studiosw.payslipgenerator.PageTokenFactorUtil;
import dk.studiosw.payslipgenerator.dao.PayslipVO;
import org.springframework.stereotype.Service;

import java.io.*;
import java.text.DecimalFormat;
import java.time.format.DateTimeFormatter;

@Service
public class PdfGenerator {

    private final static DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern( "dd.MM.yyyy");
    private final static DecimalFormat paymentFormatter = new DecimalFormat("$#,###,###,##0");

    public void generate(String filename, PayslipVO payslip) throws FileNotFoundException {
        generate(new FileOutputStream(filename), payslip);
    }

    public void generate(OutputStream os, PayslipVO payslip) {
        PdfDocument pdfDoc = new PdfDocument(new PdfWriter(os));
        Document doc = new Document(pdfDoc);

        InputStream is = getClass().getResourceAsStream("/headerlogo.png");
        byte[] dataBytes;

        try {
            dataBytes = new byte[is.available()];
            is.read(dataBytes);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        ImageData data = ImageDataFactory.create(dataBytes);
        Image img = new Image(data);
        img.setHorizontalAlignment(HorizontalAlignment.CENTER);
        img.setWidth(UnitValue.createPercentValue(40f));
        doc.add(img);

        doc.setFontSize(9);
        double totalModelPayment = 0;


        Table table = new Table(UnitValue.createPercentArray(new float[] {15f, 35f, 20f, 20f, 10f})).useAllAvailableWidth();

        // Headers
        table.addCell(new Cell(3, 1).add(new Paragraph("NOMBRE:")).setVerticalAlignment(VerticalAlignment.MIDDLE).setTextAlignment(TextAlignment.LEFT))
                .addCell(new Cell(3, 1).add(new Paragraph(payslip.getFullname())).setTextAlignment(TextAlignment.CENTER).setVerticalAlignment(VerticalAlignment.MIDDLE))
                .addCell(new Paragraph("FECHA:").setTextAlignment(TextAlignment.LEFT))
                .addCell(new Paragraph(payslip.getCalculationDate().format(dateFormatter)).setTextAlignment(TextAlignment.LEFT))
                .addCell("")

                .addCell(new Paragraph("PERIODO:").setTextAlignment(TextAlignment.LEFT))
                .addCell(new Cell(1, 2).add(new Paragraph(payslip.getFromDate().format(dateFormatter) + "-" + payslip.getToDate().format(dateFormatter))).setTextAlignment(TextAlignment.LEFT))

                .addCell(new Paragraph("HORAS:").setTextAlignment(TextAlignment.LEFT))
                .addCell(new Cell(1, 2).add(new Paragraph(payslip.getHoursWorked() == 0 ? "" : String.format("%.1f", payslip.getHoursWorked()) + " (" + String.format("%.1f", payslip.getHoursWorked() - 36.0) + ")")).setTextAlignment(TextAlignment.LEFT))

                .addCell(new Cell(2, 1).add(new Paragraph("PAGINAS")).setVerticalAlignment(VerticalAlignment.MIDDLE).setTextAlignment(TextAlignment.LEFT))
                .addCell(new Cell(2, 1).add(new Paragraph("TOKENS")).setVerticalAlignment(VerticalAlignment.MIDDLE).setTextAlignment(TextAlignment.LEFT))
                .addCell(new Cell(2, 1).add(new Paragraph("PAGOS MODELOS").setTextAlignment(TextAlignment.LEFT)).setVerticalAlignment(VerticalAlignment.MIDDLE))
                .addCell(new Paragraph("VALOR USD").setTextAlignment(TextAlignment.LEFT))
                .addCell(Integer.valueOf(Double.valueOf(payslip.getTRM()).intValue()).toString()).setTextAlignment(TextAlignment.RIGHT)
                .addCell(new Paragraph("PAGOS %:").setTextAlignment(TextAlignment.LEFT))
                .addCell(String.format("%.1f", payslip.getPercentage())).setTextAlignment(TextAlignment.RIGHT);

        // Lines

        for(var line: payslip.getLines())  {
            double modelPayment = PageTokenFactorUtil.getTokenFactor(line.website()) * line.tokens() * payslip.getTRM() * payslip.getPercentage() / 100.0d;
            table
                    .addCell(new Paragraph(line.website().toString()).setTextAlignment(TextAlignment.LEFT))
                    .addCell(String.format("%d", line.tokens()))
                    .addCell(paymentFormatter.format(modelPayment))
                    .addCell("")
                    .addCell("");

            totalModelPayment += modelPayment;
        }

        // Generic lines
        for(var line: payslip.getGenericLines())  {
            table
                    .addCell(new Paragraph(line.text()).setTextAlignment(TextAlignment.LEFT))
                    .addCell("")
                    .addCell(paymentFormatter.format(line.amount()))
                    .addCell("")
                    .addCell("");

            totalModelPayment += line.amount();
        }


        // Empty row
        table.addCell(" ").addCell("").addCell("").addCell("").addCell(new Cell().setHeight(10));

        // Totals rows
        table.addCell(new Paragraph("TOTAL").setVerticalAlignment(VerticalAlignment.MIDDLE).setTextAlignment(TextAlignment.LEFT))
                .addCell("")
                .addCell(new Cell().add(new Paragraph(paymentFormatter.format(totalModelPayment))).setBackgroundColor(ColorConstants.LIGHT_GRAY))
                .addCell(new Cell().add(new Paragraph("US$")).setBackgroundColor(ColorConstants.LIGHT_GRAY))
                .addCell(new Cell().add(new Paragraph(paymentFormatter.format(totalModelPayment/payslip.getTRM()))).setBackgroundColor(ColorConstants.LIGHT_GRAY));

        doc.add(table);
        doc.close();
    }
}
