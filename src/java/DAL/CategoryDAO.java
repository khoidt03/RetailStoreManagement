package DAL;

import Model.Category;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO extends DBContext {

    public List<Category> getNameCategory() {
        List<Category> listCategory = new ArrayList<>();
        String sql = "SELECT id, [name] FROM Category";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryID(rs.getInt("id"));
                category.setCategoryName(rs.getString("name"));
                listCategory.add(category);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return listCategory;
    }  
    public int getCategoryID(String categoryName){
        String sql = "select id from Category where Category.name LIKE ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) { 
            stm.setString(1, "%" + categoryName + "%");
            ResultSet rs = stm.executeQuery();
            while(rs.next()){  
                return rs.getInt(1);
            }
        } catch (SQLException e) {
        }
        return 0;
    }
}
