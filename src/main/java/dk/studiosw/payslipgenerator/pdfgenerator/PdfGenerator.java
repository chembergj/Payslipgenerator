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

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.text.DecimalFormat;
import java.time.format.DateTimeFormatter;

@Service
public class PdfGenerator {

    private final static DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern( "dd.MM.yyyy");
    private final static DecimalFormat paymentFormatter = new DecimalFormat("$#,###,###,##0");

    public void generate(String filename, PayslipVO payslip) throws FileNotFoundException {
        PdfDocument pdfDoc = new PdfDocument(new PdfWriter(filename));
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
        table.addCell(new Cell(2, 1).add(new Paragraph("NOMBRE:")).setVerticalAlignment(VerticalAlignment.MIDDLE).setTextAlignment(TextAlignment.LEFT))
                .addCell(new Cell(2, 1).add(new Paragraph(payslip.getFullname())).setTextAlignment(TextAlignment.CENTER).setVerticalAlignment(VerticalAlignment.MIDDLE))
                .addCell(new Paragraph("FECHA:").setTextAlignment(TextAlignment.LEFT))
                .addCell(new Paragraph(payslip.getCalculationDate().format(dateFormatter)).setTextAlignment(TextAlignment.LEFT))
                .addCell("")

                .addCell(new Paragraph("PERIODO:").setTextAlignment(TextAlignment.LEFT))
                .addCell(new Cell(1, 2).add(new Paragraph(payslip.getFromDate().format(dateFormatter) + "-" + payslip.getToDate().format(dateFormatter))).setTextAlignment(TextAlignment.LEFT))

                .addCell(new Cell(2, 1).add(new Paragraph("PAGINAS")).setVerticalAlignment(VerticalAlignment.MIDDLE).setTextAlignment(TextAlignment.LEFT))
                .addCell(new Cell(2, 1).add(new Paragraph("TOKENS")).setVerticalAlignment(VerticalAlignment.MIDDLE).setTextAlignment(TextAlignment.LEFT))
                .addCell(new Cell(2, 1).add(new Paragraph("PAGOS MODELOS").setTextAlignment(TextAlignment.LEFT)).setVerticalAlignment(VerticalAlignment.MIDDLE))
                .addCell(new Paragraph("VALOR USD").setTextAlignment(TextAlignment.LEFT))
                .addCell(Integer.valueOf(Double.valueOf(payslip.getTRM()).intValue()).toString()).setTextAlignment(TextAlignment.RIGHT)
                .addCell(new Paragraph("PAGOS %:").setTextAlignment(TextAlignment.LEFT))
                .addCell(String.format("%d", Integer.valueOf(payslip.getPercentage()))).setTextAlignment(TextAlignment.RIGHT);

        // Lines

        for(var line: payslip.getLines())  {
            double modelPayment = PageTokenFactorUtil.getTokenFactor(line.getPagename()) * line.getTokens() * payslip.getTRM();
            table
                    .addCell(new Paragraph(line.getPagename()).setTextAlignment(TextAlignment.LEFT))
                    .addCell(String.format("%d", line.getTokens()))
                    .addCell(paymentFormatter.format(modelPayment))
                    .addCell("")
                    .addCell("");

            totalModelPayment += modelPayment;
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
