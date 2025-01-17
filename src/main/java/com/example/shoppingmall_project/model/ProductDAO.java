package com.example.shoppingmall_project.model;

import java.util.List;

import com.example.shoppingmall_project.model.vo.ProductVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface ProductDAO {
	
	

	


	@Select("SELECT products.*, color.color, size_table.size_product " + 
			"FROM products " + 
			"LEFT JOIN products_color ON products.products_idx = products_color.products_idx " + 
			"LEFT JOIN color ON products_color.color_idx = color.color_idx " + 
			"LEFT JOIN products_size ON products.products_idx = products_size.products_idx " + 
			"LEFT JOIN size_table ON products_size.size_idx = size_table.size_idx " + 
			"ORDER BY color DESC, DECODE(size_table.size_product, 'S', 1, 'M', 2, 'L', 3, 'XL', 4, 'FREE', 5, 6)")
	List<ProductVO> selectAll();

	@Select("SELECT products.*, color.color, size_table.size_product " +
			"FROM products " +
			"LEFT JOIN products_color ON products.products_idx = products_color.products_idx " +
			"LEFT JOIN color ON products_color.color_idx = color.color_idx " +
			"LEFT JOIN products_size ON products.products_idx = products_size.products_idx " +
			"LEFT JOIN size_table ON products_size.size_idx = size_table.size_idx " +
			"WHERE products.products_idx = #{productIdx} ORDER BY color DESC, DECODE(size_table.size_product, 'S', 1, 'M', 2, 'L', 3, 'XL', 4, 'FREE', 5, 6)")
	List<ProductVO> selectOne(int productIdx);

	
	@Select("SELECT COUNT(DISTINCT size_table.size_product) as size_count " + 
			"FROM products " +  
			"JOIN products_size ON products.products_idx = products_size.products_idx " +  
			"JOIN size_table ON products_size.size_idx = size_table.size_idx " + 
			"WHERE products.products_idx = 1 AND size_table.size_product IS NOT NULL")
	int countAll();

	@Select("SELECT DISTINCT products.products_name, color.color " + 
			"FROM products " + 
			"JOIN products_color ON products.products_idx = products_color.products_idx " + 
			"JOIN color ON products_color.color_idx = color.color_idx " + 
			"WHERE products.products_idx = 1")
	 List<ProductVO> colorAll();

	@Select("SELECT products.products_idx, products_img.img_url " + 
			"FROM products " + 
			"JOIN products_img ON products.products_idx = products_img.products_idx " + 
			"WHERE products.products_idx = 4")
	
	List<ProductVO> imgAll();

	
	@Select("SELECT * FROM PRODUCTS WHERE PRODUCTS_IDX = #{productIdx}")
	ProductVO selectProductByIdx(int productIdx);


	@Select("select p.products_idx, p.products_name, p.products_price, " +
			"p.products_registration_date, p.products_stock, " +
			"c.categories_name from products " +
			"p join categories c on p.categories_idx = c.categories_idx " +
			"order by p.products_idx desc")
    List<ProductVO> productlist();

	@Select("select p.products_idx, p.products_name, p.products_price, " +
			"c.categories_name, c.parentcategory_idx " +
			"from products p " +
			"join categories c on p.categories_idx = c.categories_idx " +
			"where parentcategory_idx = #{parentcategory_idx} " +
			"order by p.products_idx desc")
	List<ProductVO> selectMenu(int idx);

}
