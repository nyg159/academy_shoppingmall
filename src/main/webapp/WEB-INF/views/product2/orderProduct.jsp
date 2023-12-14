<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

	<div class="container">
	
	<div class="product-container">
	
	  <div class="product-header">
		        <div class="product-header-item">제품명</div>
		        <div class="product-header-item">가격</div>
		        <div class="product-header-item">색상</div>
		        <div class="product-header-item">사이즈</div>
	        <!-- 필요한 다른 제품 정보들의 헤더 추가 -->
	  </div>
  	 	<div class="product-row">
        <div class="product-item">${product.products_name}</div>
        <div class="product-item">${product.products_price}</div>
        <div class="product-item">${color}</div>
        <div class="product-item">${size_product}</div>

        <!-- 필요한 다른 제품 정보들의 값 추가 -->
    	</div>
    <h2>배송 정보</h2>

    <div class="delivery-destination">
        <h3>배송지 선택</h3>
        <div>
            <label>
                <input type="checkbox" id="same-as-member" name="delivery-option" checked>
                회원 정보와 동일
            </label>
        </div>

        <div>
            <label>
                <input type="checkbox" id="new-destination" name="delivery-option">
                새로운 배송지
            </label>
        </div>
    </div>

    <div class="recipient-info">
        <h3>받으시는 분</h3>
        <div>
            <label for="recipient-name">이름</label>
            <input type="text" id="recipient-name" name="recipient-name">
        </div>
    </div>
	<div class="form-group">
		<h3>주소</h3>
	    <div style="display: flex; align-items: center;">
	        <input class="form-control" style="width: 40%;" placeholder="우편번호" name="addr1" id="addr1" type="text" readonly="readonly">
	        <button type="button" class="btn btn-default" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button>
	    </div>
	    <div style="margin-top: 5px;">
	        <input class="form-control" placeholder="도로명 주소" name="addr2" id="addr2" type="text" readonly="readonly" />
	    </div>
	    <div style="margin-top: 5px;">
	        <input class="form-control" placeholder="상세주소" name="addr3" id="addr3" type="text" />
	    </div>
	    <div style="margin-top: 5px;">
	        <input class="form-control" placeholder="참고항목" name="addr4" id="addr4" type="text" />
	    </div>
    <div class="contact-info">
        <h3>휴대전화</h3>
        <div>
            <label for="phone-prefix">휴대전화</label>
            <select id="phone-prefix" name="phone-prefix">
                <option value="010">010</option>
                <option value="016">016</option>
                <!-- Add more options as needed -->
            </select>
            <input type="text" id="phone-number" name="phone-number" placeholder="휴대전화 번호를 입력하세요">
            <input type="text" id="phone-number2" name="phone-number2" placeholder="휴대전화 번호를 입력하세요">
        </div>
    </div>

    <div class="email-info">
        <h3>이메일</h3>
        <div>
            <input type="text" id="email-id" name="email-id" placeholder="이메일을 입력하세요">
            @
            <select id="email-domain" name="email-domain">
                <option value="naver.com">naver.com</option>
                <!-- Add more options as needed -->
            </select>
        </div>
    </div>

    <div class="delivery-message">
        <h3>배송메시지</h3>
        <div>
            <textarea id="delivery-message" name="delivery-message" placeholder="배송 메시지를 입력하세요"></textarea>
        </div>
    </div>
</div>
	
    	
    
</div>

	
	</div>

	
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	function execPostCode() {
	    new daum.Postcode({
	        oncomplete: function (data) {
	            var addr = '';
	            var extraAddr = '';

	            if (data.userSelectedType === 'R') {
	                addr = data.roadAddress;
	            } else {
	                addr = data.jibunAddress;
	            }

	            if (data.userSelectedType === 'R') {
	                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
	                    extraAddr += data.bname;
	                }
	                if (data.buildingName !== '' && data.apartment === 'Y') {
	                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                if (extraAddr !== '') {
	                    extraAddr = ' (' + extraAddr + ')';
	                }
	                document.getElementById("addr4").value = extraAddr;
	            } else {
	                document.getElementById("addr4").value = '';
	            }

	            document.getElementById('addr1').value = data.zonecode;
	            document.getElementById("addr2").value = addr;
	            document.getElementById("addr3").focus();
	        }
	    }).open();
	}

		</script>


        <!DOCTYPE html>
        <html lang="en">
        <head>
            <!-- jQuery -->
            <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
            <!-- iamport.payment.js -->
            <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
            <script>
                var IMP = window.IMP;
                IMP.init("내 가맹점 식별코드");

                function requestPay() {
                    IMP.request_pay({
                        pg: "{html5_inicis}.{INIBillTst}",
                        pay_method: "card",
                        merchant_uid: "ORD20180131-0000011",   // 주문번호
                        name: "노르웨이 회전 의자",
                        amount: 64900,                         // 숫자 타입
                        buyer_email: "gildong@gmail.com",
                        buyer_name: "홍길동",
                        buyer_tel: "010-4242-4242",
                        buyer_addr: "서울특별시 강남구 신사동",
                        buyer_postcode: "01181"
                    }, function (rsp) { // callback
                        $.ajax({
                           type: 'POST',
                           url: '/verify/' + rsp.imp_uid
                        }).done(function(data) {
                            if(rsp.paid_amount === data.response.amount){
                                alert("결제 성공");
                            } else {
                                alert("결제 실패");
                            }
                        });
                    });
                }
            </script>
            <meta charset="UTF-8">
            <title>Sample Payment</title>
        </head>
        <body>
            <button onclick="requestPay()">결제하기</button> <!-- 결제하기 버튼 생성 -->
        </body>
        </html>
</body>
</html>