<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
	$(function() {
		var no = $("#no").val();
		//취소 버튼 클릭 시
		$(".cancel").click(function() {
			if (confirm("해당 상품을 주문 취소 하시겠습니까?")) {
				$('#type').attr('value', 'cancel');
				$('#frm').attr('action', './change.com');
				$('#frm').submit();
			}
		});
		//반품 버튼 클릭 시
		$(".confirm").click(function() {
			if (confirm("해당 상품을 구매확정 하시겠습니까? 구매확정 후에는 주문 취소 및 반품을 할 수 없습니다.")) {
				$('#type').attr('value', 'confirm');
				$('#frm').attr('action', './change.com');
				$('#frm').submit();
			}
		});

	})
</script>
</head>
<body>
	<div class="mem_right">
		<div class="mem_top_wrap noto_sans">
			<h2>상단타이틀</h2>
			<div class="mem_top_new">
				<div class="mem_title">주문상세보기</div>
			</div>

			<div class="mem_order_checkmn_wrap_new">
				<h2>주문번호</h2>
				<p class="order_num_view_2">
					<em class="order_fcT2">주문번호 </em>${ORDER.odto.ordernum}<em
						class="order_view_line">l</em><em class="order_fcT2">주문일</em>
					${ORDER.odto.sodate}
				</p>
			</div>
		</div>


		<table class="order_tbl2 mt13 font_ng" cellspacing="0" border="1"
			summary="주문 리스트" style="width: 99%;">
			<colgroup>
				<col width="120">
				<col width="auto">
				<col width="60">
				<col width="140">
				<col width="200">
			</colgroup>
				<thead>
					<tr>
						<th class="order_amount" scope="col">상품정보</th>
						<th class="order_amount" scope="col">수량</th>
						<th class="order_amount" scope="col">주문 금액</th>
						<th class="order_amount" scope="col">진행 상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ORDER.oddto}" var="oddto">
						<c:if test="${odto.ono eq oddto.ono}">
							<tr class="last">
								<c:set var="done" value="false" />
								<c:forEach items="${ORDER.sdto}" var="sdto">
									<c:if test="${not done}">
										<c:if test="${sdto.ino eq oddto.ino}">
											<td class="order_thmb"><a href="#?"
												onclick="hitRecentLog('12189');"> <img alt="temp_thmb"
													src="${sdto.imgimage}" class="product-image"></a></td>
											<td class="order_info" colspan="3"><a class="order_deal"
												href="/goods/view.asp?g=12189"
												onclick="hitRecentLog('12189');">${sdto.iname}</a>
												<p class="order_deal_info">${sdto.idetail}</p> <!-- 옵션명 노출-->
												<ul class="order_option_area">

													<li><span class="order_option">${sdto.iprice} X
													</span> <span class="order_option_cnt"> <span
															class="order_option_input">${oddto.odamount} = </span>
													</span> <span class="order_option_amounts"> <em>${oddto.odprice}</em>원
													</span></li>

												</ul></td>
											<form id="frm">
												<input type="hidden" name="no" value="${oddto.odno}" /> <input
													type="hidden" name="type" id="type" />
											</form>
											<!-- 결제완료, 배송준비중 -->
											<td class="order_amount"><c:if
													test="${oddto.ostatus eq '배송준비중' or oddto.ostatus eq '결제완료'}">
													<ul>
														<li class="order_pay_info qq-9">${oddto.ostatus}</li>
														<li class="mb5"><a id="cancel"
															class="order_btn_write" style="cursor: pointer;">주문취소</a></li>
													</ul>
												</c:if> <!-- 배송시작, 배송완료 --> <c:if
													test="${oddto.ostatus eq '배송시작' or oddto.ostatus eq '배송완료'}">
													<ul>
														<li class="order_pay_info qq-9">${oddto.ostatus}</li>

														<li class="mb5"><a
															onclick="delivery_view('택배회사','송장번호');"
															class="order_btn_delcheck" style="cursor: pointer;">배송조회</a></li>

														<li class="mb5"><a id="confirm"
															class="order_btn_write" style="cursor: pointer;">구매확정</a></li>
													</ul>
												</c:if> <!-- 구매확정 --> <c:if test="${oddto.ostatus eq '구매확정'}">
													<ul>
														<li class="order_pay_info qq-9">${oddto.ostatus}</li>

														<li class="mb5"><a
															onclick="delivery_view('택배회사','송장번호');"
															class="order_btn_delcheck" style="cursor: pointer;">배송조회</a></li>

														<li class="mb5"><a
															href="mem_goods_review_write.asp?orderno=202004052091881&amp;g=12189&amp;vtab=O"
															class="order_btn_write" style="cursor: pointer;">상품
																리뷰 쓰기</a></li>
													</ul>
												</c:if> <c:if
													test="${oddto.ostatus eq '주문취소' or oddto.ostatus eq '반품'}">
													<ul>
														<li class="order_pay_info qq-9">${oddto.ostatus}</li>
												</c:if></td>
											<c:set var="done" value="true" />
										</c:if>
									</c:if>
								</c:forEach>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
		</table>

		<!-- 주문자정보 -->
		<div class="order_detail mt60">
			<h2>정보</h2>
			<h3 class="order_detail_tit">주문자 정보</h3>
			<table class="tbl" cellspacing="0" border="1" summary="정보">
				<caption>정보</caption>
				<colgroup>
					<col width="140">
					<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<th>보내는분</th>
						<td>${sessionScope.MNAME}</td>
					</tr>
					<tr class="last">
						<th>연락처</th>
						<td>${sessionScope.MTEL1}-${sessionScope.MTEL2}-${sessionScope.MTEL3}</td>
					</tr>
				</tbody>
			</table>
		</div>

		<!-- 배송지정보 -->
		<div class="order_detail mt60">
			<h2>정보</h2>
			<h3 class="order_detail_tit">배송지 정보</h3>
			<table class="tbl" cellspacing="0" border="1" summary="정보">
				<caption>정보</caption>
				<colgroup>
					<col width="140">
					<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<th>받으실분</th>
						<td>${ORDER.odto.oreceiver}</td>
					</tr>

					<tr>
						<th>배송지 주소</th>
						<td>(${ORDER.odto.oaddno})${ORDER.odto.oaddress1}&nbsp;${ORDER.odto.oaddress2}</td>
					</tr>

					<tr>
						<th><span>연락처</span></th>
						<td>?-?-?</td>
					</tr>
					<tr class="last">
						<th><span>배송요청사항</span></th>
						<td>${ORDER.odto.orequirethings}</td>
					</tr>
				</tbody>
			</table>
		</div>

		<!-- 결제정보 -->
		<div class="order_detail mt60" id="div_cost_info">
			<h2>정보</h2>
			<h3 class="order_detail_tit">결제 정보</h3>
			<table class="tbl" cellspacing="0" border="1" summary="정보">
				<caption>정보</caption>
				<colgroup>
					<col width="140">
					<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<th>결제 수단</th>
						<td>신용카드 () <span class="receipt"><a
								onclick="$.viewReceipt();" href="javascript:">영수증보기</a></span></td>
					</tr>
					<!--<tr>
							<th>카드번호</th>
							<td>
							472**********141 (00개월)
							</td>
						</tr>-->
					<tr>
						<th>승인일시</th>
						<td>2020-04-05 오후 10:17:32</td>
					</tr>

					<tr>
						<th>적립금</th>
						<td><strong class="fctah">130</strong>원</td>
					</tr>

				</tbody>
			</table>
		</div>

		<!-- 결제금액 -->
		<div class="order_calculate_area">
			<div class="order_deal_price">
				<div class="order_h_area">
					<strong>구매 금액</strong>
				</div>
				<div class="order_result_area">
					<em>${ORDER.odto.sum}</em> <span class="won">원</span>
				</div>
			</div>

			<span class="order_minus">-</span>

			<div class="order_deal_dis">
				<div class="order_h_area">
					<strong><span>할인금액</span></strong>
				</div>
				<div class="order_result_area">
					<em><span>- 2,500</span></em> <span class="won">원</span>
				</div>
			</div>

			<span class="order_plus">+</span>

			<div class="order_deal_delivery">
				<div class="order_h_area">
					<strong>총 배송비</strong>
				</div>
				<div class="order_result_area">
					<em>+ 2,500</em> <span class="won">원</span>
				</div>
			</div>

			<span class="order_equal">=</span>

			<div class="order_deal_payment">
				<div class="order_h_area">
					<strong><span>총 결제 금액</span></strong>
				</div>
				<div class="order_result_area">
					<em><span>${ORDER.odto.sum}</span></em> <span class="won"><span>원</span></span>
				</div>
			</div>
		</div>
	</div>
</body>
</html>