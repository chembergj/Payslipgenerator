package dk.studiosw.payslipgenerator;

import java.util.UUID;

public class Utils {

    public static UUID UUIDOrNull(String uuid) {
        if(uuid != null) {
            return UUID.fromString(uuid);
        }

        return null;
    }
}
