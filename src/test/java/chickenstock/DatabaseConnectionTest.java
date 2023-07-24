package chickenstock;

import org.junit.jupiter.api.Test;
import com.mysql.cj.jdbc.MysqlDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class DatabaseConnectionTest {

    @Test
    public void testConnection() throws SQLException {
        MysqlDataSource dataSource = new MysqlDataSource();
        dataSource.setURL("jdbc:mysql://localhost:3306/mydb?serverTimeZone=Asia/Seoul");
        dataSource.setUser("root");
        dataSource.setPassword("1234");

        try (Connection connection = dataSource.getConnection()) {
            System.out.println(connection.getCatalog()); // 현재 데이터베이스명 출력
        }
    }
}
