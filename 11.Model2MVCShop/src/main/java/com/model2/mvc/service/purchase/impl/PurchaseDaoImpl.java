package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Coupon;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseDao;

@Repository("purchaseDaoImpl")
public class PurchaseDaoImpl implements PurchaseDao {
	//field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	
	public PurchaseDaoImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public Purchase findPurchase(int tranNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("PurchaseMapper.findPurchase", tranNo);
	}

	@Override
	public Purchase findPurchase2(int prodNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("PurchaseMapper.findPurchase2", prodNo);
	}

	@Override
	public List getPurchaseList(Search search, String userId) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap();
		map.put("search", search);
		map.put("userId", userId);
		return sqlSession.selectList("PurchaseMapper.getPurchaseList", map);
	}

	@Override
	public int getTotalCount(Search search, String userId) throws Exception {
		// TODO Auto-generated method stub
		Map map = new HashMap();
		map.put("search", search);
		map.put("userId", userId);
		return sqlSession.selectOne("PurchaseMapper.getTotalCount", map);
	}

	@Override
	public int insertPurchase(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		Product product = new Product();
		product.setProdNo(purchase.getPurchaseProd().getProdNo());
		product.setStock(purchase.getPurchaseProd().getStock()-purchase.getAmount());
		sqlSession.update("ProductMapper.updateProduct", product);
		sqlSession.insert("PurchaseMapper.insertPurchase", purchase);
		return sqlSession.selectOne("PurchaseMapper.getTranNo");
	}

	@Override
	public void updatePurchase(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("PurchaseMapper.updatePurchase", purchase);
	}

	@Override
	public void updateTranCode(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("PurchaseMapper.updateTranCode", purchase);
	}

	@Override
	public void deletePurchase(int tranNo) throws Exception {
		// TODO Auto-generated method stub
		//구매수량만큼 상품재고 복구시키기
		Purchase purchase = sqlSession.selectOne("PurchaseMapper.findPurchase", tranNo);
		Product product = new Product();
		product.setProdNo(purchase.getPurchaseProd().getProdNo());
		product.setStock(purchase.getPurchaseProd().getStock()+purchase.getAmount());
		sqlSession.update("ProductMapper.updateProduct", product);
		
		//쿠폰 사용한 구매였을 때 쿠폰 복구시키기
		//true : 쿠폰썼음 false : 쿠폰 안씀
		boolean isUseCoupon = (purchase.getPurchaseProd().getPrice())*purchase.getAmount()!=purchase.getSoldPrice();
		if(isUseCoupon) {
			Coupon coupon = new Coupon();
			User user = new User();
			user.setUserId(purchase.getBuyer().getUserId());
			System.out.println("쿠폰 복구");
			coupon.setDiscountCoupon10("1");
			user.setCoupon(coupon);
			sqlSession.update("UserMapper.updateCoupon", user);
		}
		
		//구매 지우기
		sqlSession.delete("PurchaseMapper.deletePurchase", tranNo);
	}

}
