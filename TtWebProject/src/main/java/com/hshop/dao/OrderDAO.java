package com.hshop.dao;

import java.util.List;

import com.hshop.entity.Order;
import com.hshop.entity.OrderDetail;
import com.hshop.entity.Product;
import com.hshop.entity.User;

public interface OrderDAO {
	Order findById(Integer id);

	List<Order> findAll();

	Order create(Order entity);

	void update(Order entity);

	Order delete(Integer id);

	void create(Order order, List<OrderDetail> details);

	List<Order> findByUser(User user);

	List<Product> findItemsByUser(User user);
}
