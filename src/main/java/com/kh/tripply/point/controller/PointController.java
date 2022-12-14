package com.kh.tripply.point.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.tripply.common.Paging;
import com.kh.tripply.member.domain.Member;
import com.kh.tripply.point.domain.Point;
import com.kh.tripply.point.service.PointService;
import com.kh.tripply.trade.domain.Trade;
import com.kh.tripply.trade.service.TradeService;

@Controller
public class PointController {
	@Autowired
	PointService pService;
	@Autowired
	TradeService tService;
	
	/**
	 * 포인트 내역 페이지 이동
	 * @param mv
	 * @return
	 */
	@RequestMapping(value="/point/historyView.kh",method=RequestMethod.GET)
	public ModelAndView pointHistoryView(ModelAndView mv,
			HttpSession session,
			Point point,  // select 시 필요한 값 전달용 객체 생성
			@RequestParam(value="currentPage",required=false) Integer page) {
		
		//1.currentPage를 널체크한다.
		int currentPage = (page != null)? page : 1;
		
		//2.paging처리를 위해 Paging 객체를 생성한다.
		Paging paging = new Paging(pService.getHistoryTotalCount(point), currentPage, 10, 5);
		
		//3.로그인한 유저의 아이디를 이용하여 로그인 유저의 회원정보를 SELECT한다.
		Member loginUserInfo = 
				pService.getMemberPoint((Member)session.getAttribute("loginUser"));
		
		//3-1.세션에 저장된 loginUser를 변경한다.
		session.removeAttribute("loginUser");
		session.setAttribute("loginUser", loginUserInfo);
		
		
		//4.SELECT 시 필요한 값들을 POINT객체에 담는다.
		//로그인 유저아이디,
		String loginUser = loginUserInfo.getMemberId();
		point.setLoginUser(loginUser);
		
		//5.페이징과 포인트 객체를 매개값으로 SELECT한다.
		List<Point> pList = pService.printAllPointHistory(paging,point);
		if(!pList.isEmpty()) {
			
			//6.화면에 pList와 paging값을 전달한다.
			mv.addObject("pList",pList)
			.addObject("paging",paging)
			.addObject("loginUserInfo",loginUserInfo)
			.setViewName("/point/pointHistory");
		}else {
			mv.addObject("pList",null)
			.addObject("paging",paging)
			.addObject("loginUserInfo",loginUserInfo)
			.setViewName("/point/pointHistory");
		}
		return mv;
	}
	
	/**
	 * 포인트 전송 페이지 이동
	 * @param mv
	 * @return
	 */
	@RequestMapping(value="/point/sendView.kh",method=RequestMethod.GET)
	public ModelAndView pointSendView(ModelAndView mv,
			HttpSession session) {
		
		//1.세션에서 로그인유저의 객체를 가져온다.
		Member loginUser = (Member)session.getAttribute("loginUser");
		
		//2.채택된 거래게시물의 목록을 가져온다.
		List<Trade> tList = tService.printMyTrade(loginUser);
		if(!tList.isEmpty()) {
			mv.addObject("tList",tList)
			.setViewName("/point/pointSend1");
		}else {
			mv.addObject("tList",null)
			.setViewName("/point/pointSend1");
		}
		return mv;
	}
	
	/**
	 * 채택된 게시물의 판매자에게 포인트를 전송하는 기능
	 * @param mv
	 * @param point
	 * @param boardNo
	 * @return
	 */
	@RequestMapping(value="/point/send.kh",method=RequestMethod.POST)
	public ModelAndView pointSend(ModelAndView mv,
			@ModelAttribute Point point,
			@RequestParam("boardNo") Integer boardNo) {
		
		//1. 1)보내는이 포인트 감소, 2) 받는이 포인트 증가 3) 게시물 판매완료 처리를 트랜잭션처리한다.
		//   service에서 3개의 DAO 메소드를 호출한다.
		//  1)보내는 유저의 포인트를 가격만큼 뺀다.UPDATE
		//  2)받는 유저의 포인트를 가격만큼 더한다.UPDATE
		//  3)게시물의 soldOut 'Y'로 UPDATE
		int sendPointResult = pService.modifySendPoint(point);
		int getPointResult = pService.modifyGetPoint(point);
		int soldOutResult = pService.modifyTradeSoldOut(boardNo);
		
		if(sendPointResult > 0 && getPointResult> 0 && soldOutResult > 0) {

			//2.성공 시 포인트히스토리에 INSERT한다.
			int registerHistoryResult = pService.registerPointHistory(point);
			if(registerHistoryResult>0) {
				mv.addObject("message","전송")
				.addObject("point",point)
				.setViewName("/point/pointWorkSuccess");
			}else {
				
			}
		}else {
			
		}
		return mv;
	}
	
	
	/**
	 * 포인트 충전 페이지 이동
	 * @param mv
	 * @return
	 */
	@RequestMapping(value="/point/chargeView.kh",method=RequestMethod.GET)
	public ModelAndView pointChargeView(ModelAndView mv) {
		mv.setViewName("/point/pointCharge");
		return mv;
	}
	
	/**
	 * 포인트 충전
	 * @param mv
	 * @param session
	 * @param point
	 * @return
	 */
	@RequestMapping(value="/point/charge.kh", method=RequestMethod.POST)
	public ModelAndView pointCharge(ModelAndView mv,
			HttpSession session,
			@ModelAttribute Point point) {
		
		//1.포인트 충전 창에서 가져온 값을 이용하여
		//멤버 테이블의 POINT_BALANCE를	UPDATE한다.
		//충전이므로 기존 값에 충전금액을 더해준다.
		try {
			int chargeResult = pService.modifyChargePoint(point);
			if(chargeResult>0) {
				
				//2. 1번 작업 완료 시 POINT_HISTORY_TBL에 INSERT한다.
				int registerHistoryResult = pService.registerPointHistory(point);
				if(registerHistoryResult>0) {
					mv.addObject("message","충전")
					.addObject("point",point)
					.setViewName("/point/pointWorkSuccess");
				}else {
					
				}
			}
		} catch (Exception e) {
		}
		
		
		return mv;
	}
	
	
}
