package ex.soft.service;

import ex.soft.domain.dao.OrderDao;
import ex.soft.domain.model.Cart;
import ex.soft.domain.model.Order;
import ex.soft.domain.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.math.BigDecimal;

/**
 * Created by Alex108 on 14.10.2016.
 */
@Service("orderService")
@PropertySource("classpath:messages/prices.properties")
public class OrderService {

    private static final String CART_ATTRIBUTE_NAME = "cart";

    @Value("${product.delivery}")
    private BigDecimal DELIVERY_PRICE;

    @Resource(name = "orderDao")
    private OrderDao orderDao;

    @Autowired
    private UserService userService;

    @Resource(name = "cart")
    private Cart cart;

    @Transactional
    public Order createOrder(HttpSession session)  {
        Cart cart = getCartSafely(session);
        Order order = new Order();
        order.setTotalQuantity(cart.getTotalQuantity());
        order.setTotalPrice(cart.getTotalPrice());
        order.setOrderItems(cart.getOrderItems());
        return order;
    }

    @Transactional
    public Order getOrder(Long key){
        return orderDao.get(key);
    }

    @Transactional
    public Long placeOrder(HttpSession session, Order order){
        User user = userService.getUser();
        Cart cart = getCartSafely(session);
        order.setOrderItems(cart.getOrderItems());
        order.setTotalQuantity(cart.getTotalQuantity());
        order.setSubTotalPrice(cart.getTotalPrice());
        order.setTotalPrice(cart.getTotalPrice().add(DELIVERY_PRICE));
        order.setUser(user);
//        session.invalidate();
        session.removeAttribute(CART_ATTRIBUTE_NAME);
        return orderDao.save(order);
    }


    private Cart getCartSafely(HttpSession session){
        Cart cart = (Cart) session.getAttribute(CART_ATTRIBUTE_NAME);
        return cart != null ? cart : new Cart();
    }

}
