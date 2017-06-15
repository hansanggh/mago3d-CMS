<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>${sessionSiteName }</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/${lang}/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/${lang}/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/css/${lang}/style.css" />
</head>

<body>
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	
	<div class="site-body">
		<div class="container">
			<div class="site-content">
				<%@ include file="/WEB-INF/views/layouts/sub_menu.jsp" %>
				<div class="page-area">
					<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
					
					<div class="page-content">
						<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span>체크표시는 필수입력 항목입니다.</div>
						<div class="tabs">
							<ul>
								<li><a href="#user_info_tab">기본정보</a></li>
							</ul>
							<div id="user_info_tab">
								<form:form id="userInfo" modelAttribute="userInfo" method="post" onsubmit="return false;">
									<form:hidden path="user_id"/>
								<table class="input-table scope-row">
									<col class="col-label" />
									<col class="col-input" />
									<tr>
										<th class="col-label" scope="row">아이디
											<span class="icon-glyph glyph-emark-dot color-warning"></span>
										</th>
										<td class="col-input">${userInfo.user_id }</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="user_group_name">사용자 그룹</form:label>
											<span class="icon-glyph glyph-emark-dot color-warning"></span>
										</th>
										<td class="col-input">
											<form:hidden path="user_group_id" />
				 							<form:input path="user_group_name" cssClass="m" readonly="true" />
											<input type="button" id="user_group_buttion" value="그룹선택" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="user_name">이름</form:label>
											<span class="icon-glyph glyph-emark-dot color-warning"></span>
										</th>
										<td class="col-input">
											<form:input path="user_name" class="m" />
					  						<form:errors path="user_name" cssClass="error" />
										</td>
									</tr>
									
									<tr>
										<th class="col-label" scope="row">
											<form:label path="messanger">메신저</form:label>
										</th>
										<td class="col-input">
											<form:input path="messanger" class="m" />
											<form:errors path="messanger" cssClass="error" />
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="status">상태</form:label>
										</th>
										<td class="col-input">
											<form:select path="status" cssClass="select">
												<option value="0">사용중</option>
												<option value="1">사용중지</option>
												<option value="2">잠금(실패횟수)</option>
												<option value="3">휴면</option>
												<option value="4">만료</option>
												<option value="5">삭제</option>
												<option value="6">임시 비밀번호</option>
											</form:select>
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">
											<form:label path="user_insert_type">등록 방법</form:label>
										</th>
										<td class="col-input">
											<form:select path="user_insert_type" cssClass="select">
												<option value="SELF">관리자 등록</option>
												<option value="${externalUserRegister.code_value }">${externalUserRegister.code_name }</option>
											</form:select>
										</td>
									</tr>
									<tr>
										<th class="col-label" scope="row">Single Sign-On</th>
										<td class="col-input">
											<form:radiobutton path="sso_use_yn" value="Y" label="사용"/>
											<form:radiobutton path="sso_use_yn" value="N" label="사용안함" />
										</td>
									</tr>
								</table>
								
								<div class="button-group">
									<div class="center-buttons">
										<input type="submit" value="저장" onclick="updateUserInfo();" />
										<a href="/user/list-user.do?${listParameters}" class="button">목록</a>
									</div>
								</div>
								</form:form>
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
	<!-- Dialog -->
	<div class="dialog" title="데이터 그룹">
		<div class="dialog-user-group">
			<ul>
<c:if test="${!empty userGroupList }">
	<c:set var="groupDepthValue" value="0" />
	<c:forEach var="userGroup" items="${userGroupList }" varStatus="status">
		<c:if test="${groupDepthValue eq '0' && userGroup.depth eq 1 }">
				<li>
					<input type="radio" id="radio_group_${userGroup.user_group_id }" name="radio_group" value="${userGroup.user_group_id }_${userGroup.group_name }" />
					<label for="radio_group_${userGroup.user_group_id }">${userGroup.group_name }</label>
		</c:if>
		<c:if test="${groupDepthValue eq '1' && userGroup.depth eq 1 }">
				</li>
				<li>
					<input type="radio" id="radio_group_${userGroup.user_group_id }" name="radio_group" value="${userGroup.user_group_id }_${userGroup.group_name }" />
					<label for="radio_group_${userGroup.user_group_id }">${userGroup.group_name }</label>
		</c:if>
		<c:if test="${groupDepthValue eq '1' && userGroup.depth eq 2 }">
					<ul>
						<li>
							<input type="radio" id="radio_group_${userGroup.user_group_id }" name="radio_group" value="${userGroup.user_group_id }_${userGroup.group_name }" />
							<label for="radio_group_${userGroup.user_group_id }">${userGroup.group_name }</label>
		</c:if>
		<c:if test="${groupDepthValue eq '2' && userGroup.depth eq 1 }">
						</li>
					</ul>
				</li>
				<li>
					<input type="radio" id="radio_group_${userGroup.user_group_id }" name="radio_group" value="${userGroup.user_group_id }_${userGroup.group_name }" />
					<label for="radio_group_${userGroup.user_group_id }">${userGroup.group_name }</label>
		</c:if>
		<c:if test="${groupDepthValue eq '2' && userGroup.depth eq 2 }">
						</li>
						<li>
							<input type="radio" id="radio_group_${userGroup.user_group_id }" name="radio_group" value="${userGroup.user_group_id }_${userGroup.group_name }" />
							<label for="radio_group_${userGroup.user_group_id }">${userGroup.group_name }</label>
		</c:if>
		<c:if test="${groupDepthValue eq '2' && userGroup.depth eq 3 }">
							<ul style="padding-left: 30px;">
								<li>
									<input type="radio" id="radio_group_${userGroup.user_group_id }" name="radio_group" value="${userGroup.user_group_id }_${userGroup.group_name }" />
									<label for="radio_group_${userGroup.user_group_id }">${userGroup.group_name }</label>
		</c:if>
		<c:if test="${groupDepthValue eq '3' && userGroup.depth eq 1 }">
								</li>
							</ul>
						</li>
					</ul>
				</li>
				<li>
					<input type="radio" id="radio_group_${userGroup.user_group_id }" name="radio_group" value="${userGroup.user_group_id }_${userGroup.group_name }" />
					<label for="radio_group_${userGroup.user_group_id }">${userGroup.group_name }</label>
		</c:if>		
		<c:if test="${groupDepthValue eq '3' && userGroup.depth eq 2 }">
								</li>
							</ul>
						</li>
						<li>
							<input type="radio" id="radio_group_${userGroup.user_group_id }" name="radio_group" value="${userGroup.user_group_id }_${userGroup.group_name }" />
							<label for="radio_group_${userGroup.user_group_id }">${userGroup.group_name }</label>
		</c:if>			
		<c:if test="${groupDepthValue eq '3' && userGroup.depth eq 3 }">
								</li>
								<li>
									<input type="radio" id="radio_group_${userGroup.user_group_id }" name="radio_group" value="${userGroup.user_group_id }_${userGroup.group_name }" />
									<label for="radio_group_${userGroup.user_group_id }">${userGroup.group_name }</label>
		</c:if>	
		<c:if test="${userGroup.depth eq '3' && status.last }">
								</li>
							</ul>
						</li>
					</ul>
				</li>
		</c:if>
		<c:if test="${userGroup.depth eq '2' && status.last }">
						</li>
					</ul>
				</li>
		</c:if>
		<c:if test="${userGroup.depth eq '1' && status.last }">
				</li>
		</c:if>
		<c:set var="groupDepthValue" value="${userGroup.depth }" />			
	</c:forEach>
			</ul>
</c:if>
		</div>
			
		<div class="button-group">
			<input type="submit" id="button_groupSelect" name="button_groupSelect" value="선택" />
		</div>
	</div>
	
<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
<script type="text/javascript" src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>	
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/${lang}/navigation.js"></script>
<script type="text/javascript">
	// 0은 비표시, 1은 표시
	var userDeviceArray = new Array("1", "1", "1", "1", "1", "0");
	var userDeviceCount = 5;
	$(document).ready(function() {
		$( ".tabs" ).tabs();
		
		var email2 = "${userInfo.email2}";
		if(email2 == "") email2 = "0";
		$("#email3").val(email2);
		$("#email3").selectmenu("refresh");
		
		var userStatus = "${userInfo.status}";
		if(userStatus != null && userStatus != "") {
			$("#status").val("${userInfo.status}");
		}
		var userInsertType = "${userInfo.user_insert_type}";
		if(userInsertType != null && userInsertType != "") {
			$("#user_insert_type").val("${userInfo.user_insert_type}");
		}
		
		$("[name=sso_use_yn]").filter("[value='${userInfo.sso_use_yn}']").prop("checked",true);
		
		var otpStatus = "${userOTP.otp_status}";
		if(otpStatus != null && otpStatus != "") {
			$("#otp_status").val("${userOTP.otp_status}");
		}
		
		$("[name=otp_use_yn]").filter("[value='${userOTP.otp_use_yn}']").prop("checked",true);
		$("[name=otp_type]").filter("[value='${userOTP.otp_type}']").prop("checked",true);
		$("[name=use_constraint_yn]").filter("[value='${userOTP.use_constraint_yn}']").prop("checked",true);
		
		// OTP 접속 제어 날짜 및 시간, 요일 설정
		initOTPUseTime();
		$("#use_start_hour").val("${userOTP.use_start_hour}");
		$("#use_start_minute").val("${userOTP.use_start_minute}");
		$("#use_end_hour").val("${userOTP.use_end_hour}");
		$("#use_end_minute").val("${userOTP.use_end_minute}");
		if("${userOTP.use_sunday_yn}" == "Y") {
			$("[name=use_sunday_yn_name]").prop("checked", true);
		}
		if("${userOTP.use_monday_yn}" == "Y") {
			$("[name=use_monday_yn_name]").prop("checked", true);
		}
		if("${userOTP.use_tuesday_yn}" == "Y") {
			$("[name=use_tuesday_yn_name]").prop("checked", true);
		}
		if("${userOTP.use_wednesday_yn}" == "Y") {
			$("[name=use_wednesday_yn_name]").prop("checked", true);
		}
		if("${userOTP.use_thursday_yn}" == "Y") {
			$("[name=use_thursday_yn_name]").prop("checked", true);
		}
		if("${userOTP.use_friday_yn}" == "Y") {
			$("[name=use_friday_yn_name]").prop("checked", true);
		}
		if("${userOTP.use_saturday_yn}" == "Y") {
			$("[name=use_saturday_yn_name]").prop("checked", true);
		}
		
		initJqueryCalendar();
		$("#use_start_day").val("${userOTP.use_start_day}");
		$("#use_end_day").val("${userOTP.use_end_day}");
		
		initUserDevice();
		$( ".select" ).selectmenu();
	});
	
	// 그룹 선택
	$( "#user_group_buttion" ).on( "click", function() {
		dialog.dialog( "open" );
	});
	var dialog = $( ".dialog" ).dialog({
		autoOpen: false,
		height: 600,
		width: 600,
		modal: true,
		resizable: false
	});
	
	// 시작/종료 날짜의 시간/분 값 설정
	function initOTPUseTime() {
		for(var i=0; i<24; i++) {
			if(i < 10) {
				$("#use_start_hour").append("<option value='0"+ i +"'>0" + i + "</option>");
				$("#use_end_hour").append("<option value='0"+ i +"'>0" + i + "</option>");
			} else {
				$("#use_start_hour").append("<option value='"+ i +"'>" + i + "</option>");
				$("#use_end_hour").append("<option value='"+ i +"'>" + i + "</option>");
			}
		}
		for(var i=0; i<60; i++) {
			if(i < 10) {
				$("#use_start_minute").append("<option value='0"+ i +"'>0" + i + "</option>");
				$("#use_end_minute").append("<option value='0"+ i +"'>0" + i + "</option>");
			} else {
				$("#use_start_minute").append("<option value='"+ i +"'>" + i + "</option>");
				$("#use_end_minute").append("<option value='"+ i +"'>" + i + "</option>");
			}
		}
	}
	
	// 디바이스 초기화
	function initUserDevice() {
		if("${userDevice.device_name1}" == null || "${userDevice.device_name1}" == "") {
			$("#user_device1").css("display", "none");
			userDeviceArray[0] = "0";
			userDeviceCount--;
		}
		if("${userDevice.device_name2}" == null || "${userDevice.device_name2}" == "") {
			$("#user_device2").css("display", "none");
			userDeviceArray[1] = "0";
			userDeviceCount--;
		}
		if("${userDevice.device_name3}" == null || "${userDevice.device_name3}" == "") {
			$("#user_device3").css("display", "none");
			userDeviceArray[2] = "0";
			userDeviceCount--;
		}
		if("${userDevice.device_name4}" == null || "${userDevice.device_name4}" == "") {
			$("#user_device4").css("display", "none");
			userDeviceArray[3] = "0";
			userDeviceCount--;
		}
		if("${userDevice.device_name5}" == null || "${userDevice.device_name5}" == "") {
			$("#user_device5").css("display", "none");
			userDeviceArray[4] = "0";
			userDeviceCount--;
		}
		if("${userDevice.device_name1}" != null && "${userDevice.device_name1}" != "") {
			$("#device_type1").val("${userDevice.device_type1}");
			$("#use_yn1").val("${userDevice.use_yn1}");
		}
		if("${userDevice.device_name2}" != null && "${userDevice.device_name2}" != "") {
			$("#device_type2").val("${userDevice.device_type2}");
			$("#use_yn2").val("${userDevice.use_yn2}");
		}
		if("${userDevice.device_name3}" != null && "${userDevice.device_name3}" != "") {
			$("#device_type3").val("${userDevice.device_type3}");
			$("#use_yn3").val("${userDevice.use_yn3}");
		}
		if("${userDevice.device_name4}" != null && "${userDevice.device_name4}" != "") {
			$("#device_type4").val("${userDevice.device_type4}");
			$("#use_yn4").val("${userDevice.use_yn4}");
		}
		if("${userDevice.device_name5}" != null && "${userDevice.device_name5}" != "") {
			$("#device_type5").val("${userDevice.device_type5}");
			$("#use_yn5").val("${userDevice.use_yn5}");
		}
	}
	
	// 아이디 중복 확인
	$( "#user_duplication_buttion" ).on( "click", function() {
		var userId = $("#user_id").val();
		if (userId == "") {
			alert(JS_MESSAGE["user.id.empty"]);
			$("#user_id").focus();
			return false;
		}
		var info = "user_id=" + userId;
		$.ajax({
			url: "/user/ajax-user-id-duplication-check.do",
			type: "POST",
			data: info,
			cache: false,
			async:false,
			dataType: "json",
			success: function(msg){
				if(msg.result == "success") {
					if(msg.duplication_value != "0") {
						alert(JS_MESSAGE["user.id.duplication"]);
						$("#user_id").focus();
						return false;
					} else {
						alert(JS_MESSAGE["user.id.enable"]);
						$("#duplication_value").val(msg.duplication_value);
					}
				} else {
					alert(JS_MESSAGE[msg.result]);
				}
			},
			error: function() {
				alert(JS_MESSAGE["ajax.error.message"]);
			}
		});
	});
	
	// 그룹 선택
	$( "#button_groupSelect" ).on( "click", function() {
		var radioObj = $(":radio[name=radio_group]:checked").val();
		if (!radioObj) {
			alert('그룹이 선택되지 않았습니다.');
	        return false;
	    } else {
	    	var splitValues = radioObj.split("_");
	    	var userGroupName = "";
	    	for(var i = 1; i < splitValues.length; i++) {
	    		userGroupName = userGroupName + splitValues[i];
	    		if(i != splitValues.length - 1) {
	    			userGroupName = userGroupName + "_";
	    		}
			}	    	
	    	$("#user_group_id").val(splitValues[0]);
			$("#user_group_name").val(userGroupName);
			dialog.dialog( "close" );
	    }
	});
	
	// 사용자 정보 저장
	var updateUserInfoFlag = true;
	function updateUserInfo() {
		if(updateUserInfoFlag) {
			if (checkUserInfo() == false) {
				return false;
			}
			
			updateUserInfoFlag = false;
			var info = $("#userInfo").serialize();
			$.ajax({
				url: "/user/ajax-update-user-info.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						$("#reloadMobilePhone").html(msg.maskingMobilePhone);
						$("#reloadEmail").html(msg.maskingEmail);
						$("#reloadMessanger").html(msg.messanger);
						alert(JS_MESSAGE["user.info.update"]);
					} else {
						if(msg.result == "user.password.exception.char") {
							alert(JS_MESSAGE["user.password.exception.char.message1"] + "${passwordExceptionChar}" + JS_MESSAGE["user.password.exception.char.message2"]);
						} else {
							alert(JS_MESSAGE[msg.result]);							
						}
					}
					updateUserInfoFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateUserInfoFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	function checkUserInfo() {
		if ($("#user_id").val() == "") {
			alert(JS_MESSAGE["user.id.empty"]);
			$("#user_id").focus();
			return false;
		}
		if ($("#user_group_id").val() == "") {
			alert(JS_MESSAGE["user.group.id.empty"]);
			$("#user_group_id").focus();
			return false;
		}
		if ($("#user_name").val() == "") {
			alert(JS_MESSAGE["user.name.empty"]);
			$("#user_name").focus();
			return false;
		}
		
		var password = $("#password").val();
		var password_confirm = $("#password_confirm").val();
		if(password != "" && password_confirm != "") {
			if(password != password_confirm) {
				alert("비밀번호가 비밀번호 확인 이랑 일치하지 않습니다.");
				$("#password").focus();
				return false;
			}	
		} 
		
		var telephone_regExp1 = /^\d{2,3}$/;
		var telephone1 = $("#telephone1").val();
		if (telephone1 != null && telephone1 != "" && !telephone_regExp1.test(telephone1)) {
			alert("전화번호 형식에 맞게 입력해 주십시오.");
			$("#telephone1").focus();
			return false;
		}
		var telephone_regExp2 = /^\d{3,4}$/;
		var telephone2 = $("#telephone2").val();
		if (telephone2 != null && telephone2 != "" && !telephone_regExp2.test(telephone2)) {
			alert("전화번호 형식에 맞게 입력해 주십시오.");
			$("#telephone2").focus();
			return false;
		}
		var telephone_regExp3 = /^\d{4,4}$/;
		var telephone3 = $("#telephone3").val();
		if (telephone3 != null && telephone3 != "" && !telephone_regExp3.test(telephone3)) {
			alert("전화번호 형식에 맞게 입력해 주십시오.");
			$("#telephone3").focus();
			return false;
		}
		var mobilephone_regExp1 = /^\d{3,3}$/;
		var mobile_phone1 = $("#mobile_phone1").val();
		if (mobile_phone1 != null && mobile_phone1 != "" && !mobilephone_regExp1.test(mobile_phone1)) {
			alert("핸드폰 번호 형식에맞게 입력해 주십시오.");
			$("#mobile_phone1").focus();
			return false;
		}
		var mobilephone_regExp2 = /^\d{3,4}$/;
		var mobile_phone2 = $("#mobile_phone2").val();
		if (mobile_phone2 != null && mobile_phone2 != "" && !mobilephone_regExp2.test(mobile_phone2)) {
			alert("핸드폰 번호 형식에맞게 입력해 주십시오.");
			$("#mobile_phone2").focus();
			return false;
		}
		var mobilephone_regExp3 = /^\d{4,4}$/;
		var mobile_phone3 = $("#mobile_phone3").val();
		if (mobile_phone3 != null && mobile_phone3 != "" && !mobilephone_regExp3.test(mobile_phone3)) {
			alert("핸드폰 번호 형식에맞게 입력해 주십시오.");
			$("#mobile_phone3").focus();
			return false;
		}
		var email_regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		if ($("#email1").val() != null && $("#email1").val() != "" && $("#email2").val() != null && $("#email2").val() != "") {
			if (!email_regExp.test($("#email1").val() + "@" + $("#email2").val())) {
				alert("이메일 형식에 맞게 입력해 주십시오.");
				return false;
			}
		}
	}
	
	// 사용자 OTP 정보 저장
	var updateUserOTPFlag = true;
	function updateUserOTP() {
		if (checkUserOtp() == false) {
			return false;
		}
		if(updateUserOTPFlag) {
			updateUserOTPFlag = false;
			var info = $("#userOTP").serialize() + "&user_id=" + $("#user_id").val();
			$.ajax({
				url: "/user/ajax-update-user-otp.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["userotp.info.update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateUserOTPFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateUserOTPFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	function checkUserOtp() {
		if ($("#user_id").val() == "") {
			alert(JS_MESSAGE["user.id.notexist"]);
			return false;
		}
		
		var otp_use_yn = $(":radio[name='otp_use_yn']:checked").val();
		var otp_type = $(":radio[name='otp_type']:checked").val();
		if(otp_use_yn == null || otp_use_yn == "") {
			alert(JS_MESSAGE["userotp.otp_use_yn.invalid"]);
			return false;
		}
		if(otp_use_yn == "Y") {
			var user_otp_mobile_app_key_modify_yn = "${policy.user_otp_mobile_app_key_modify_yn}";
			if(user_otp_mobile_app_key_modify_yn == "Y") {
				if(otp_type == "0") {
					var mobile_phone1 = $("#mobile_phone1").val();
					var mobile_phone2 = $("#mobile_phone2").val();
					var mobile_phone3 = $("#mobile_phone3").val();
					if(mobile_phone1 == null || mobile_phone1 == "" 
							|| mobile_phone2 == null || mobile_phone2 == ""
							|| mobile_phone3 == null || mobile_phone3 == "") {
						alert(JS_MESSAGE["userotp.mobile_phone.required"]);
						return false;
					}
					if ($("#mobile_app_key").val() == "") {
						alert(JS_MESSAGE["userotp.mobile_app_key.invalid"]);
						$("#mobile_app_key").focus();
						return false;
					}
				}
			}
			var user_otp_pin_number_modify_yn = "${policy.user_otp_pin_number_modify_yn}";
			if(user_otp_pin_number_modify_yn == "Y") {
				if(otp_type == "2") {
					if ($("#pin_number").val() == "") {
						alert(JS_MESSAGE["userotp.pin_number.invalid"]);
						$("#pin_number").focus();
						return false;
					}
					if(!isNumber($("#pin_number").val())) {
						$("#pin_number").focus();
						return false;
					}
					if($("#pin_number").val().length < 4 || $("#pin_number").val().length > 8) {
						alert(JS_MESSAGE["number.required"]);
						$("#pin_number").focus();
						return false;
					}
				}
			}
		}
		
		var use_constraint_yn = $(':radio[name="use_constraint_yn"]:checked').val();
		var use_start_day = $("#use_start_day").val().replace(/[^0-9]/g, "");
		var use_end_day = $("#use_end_day").val().replace(/[^0-9]/g, "");
		var use_start_hour = $("#use_start_hour").val();
		var use_end_hour = $("#use_end_hour").val();
		var use_start_minute = $("#use_start_minute").val();
		var use_end_minute = $("#use_end_minute").val();
		if(use_constraint_yn == "Y") {
			if(use_start_day == null || use_start_day == "") {
				alert("시작일을 입력하여 주십시오.");
				return false;
			}
			if(use_end_day == null || use_end_day == "") {
				alert("종료일을 입력하여 주십시오.");
				return false;
			}
			if(use_start_hour == null || use_start_hour == "" || use_start_minute == null || use_start_minute == "") {
				alert("시작 시간을 입력하여 주십시오.");
				return false;
			}
			if(use_end_hour == null || use_end_hour == "" || use_end_minute == null || use_end_minute == "") {
				alert("종료 시간을 입력하여 주십시오.");
				return false;
			}

			var use_start_date = use_start_day + use_start_hour + use_start_minute;
			var use_end_date = use_end_day + use_end_hour + use_end_minute;
			if(use_start_date >= use_end_date) {
				alert("시작 기간이 종료 기간보다 같거나 클수 없습니다.");
				return false;
			}
		}

		if($("[name=use_sunday_yn_name]").is(":checked")) {
			$("#use_sunday_yn").val("Y");
		} else {
			$("#use_sunday_yn").val("N");
		}
		if($("[name=use_monday_yn_name]").is(":checked")) {
			$("#use_monday_yn").val("Y");
		} else {
			$("#use_monday_yn").val("N");
		}
		if($("[name=use_tuesday_yn_name]").is(":checked")) {
			$("#use_tuesday_yn").val("Y");
		} else {
			$("#use_tuesday_yn").val("N");
		}
		if($("[name=use_wednesday_yn_name]").is(":checked")) {
			$("#use_wednesday_yn").val("Y");
		} else {
			$("#use_wednesday_yn").val("N");
		}
		if($("[name=use_thursday_yn_name]").is(":checked")) {
			$("#use_thursday_yn").val("Y");
		} else {
			$("#use_thursday_yn").val("N");
		}
		if($("[name=use_friday_yn_name]").is(":checked")) {
			$("#use_friday_yn").val("Y");
		} else {
			$("#use_friday_yn").val("N");
		}
		if($("[name=use_saturday_yn_name]").is(":checked")) {
			$("#use_saturday_yn").val("Y");
		} else {
			$("#use_saturday_yn").val("N");
		}
	}
	
	// 사용자 OTP 번호 요청
	var createOTPNumberFlag = true;
	function createOTPNumber() {
		if ($("#user_id").val() == "") {
			alert(JS_MESSAGE["userotp.info.invalid"]);
			$("#user_id").focus();
			return false;
		}
		if(createOTPNumberFlag) {
			createOTPNumberFlag = false;
			var info = "user_id=" + $("#user_id").val() + "&request_type=ADMIN_TEST";
			$.ajax({
				url: "/user/ajax-create-otp-number.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["userotp.number.send"]);
						$("#otp_number").val(msg.otpNumber);
						$("#otp_number").focus();
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					createOTPNumberFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        createOTPNumberFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 사용자 OTP 번호 검증 요청
	var verifyOTPNumberFlag = true;
	function verifyOTPNumber() {
		if ($("#user_id").val() == "") {
			alert(JS_MESSAGE["userotp.info.invalid"]);
			$("#user_id").focus();
			return false;
		}
		var otp_number = $("#otp_number").val();
		if (otp_number == "") {
			alert(JS_MESSAGE["userotp.number.empty"]);
			$("#otp_number").focus();
			return false;
		}
		if(verifyOTPNumberFlag) {
			otp_number = otp_number.replace(/\s/gi,"");
			verifyOTPNumberFlag = false;
			var info = "user_id=" + $("#user_id").val() + "&otp_number=" + otp_number + "&request_type=ADMIN_TEST";
			$.ajax({
				url: "/user/ajax-verify-otp-number.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["otp.correct.number"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					verifyOTPNumberFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        verifyOTPNumberFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	// 사용자 디바이스 정보 저장
	var updateUserDeviceFlag = true;
	function updateUserDevice() {
		if (checkUserDevice() == false) {
			return false;
		}
		if(updateUserDeviceFlag) {
			updateUserDeviceFlag = false;
			var info = $("#userDevice").serialize() + "&user_id=" + $("#user_id").val();		
			$.ajax({
				url: "/user/ajax-update-user-device.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["update"]);
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					updateUserDeviceFlag = true;
				},
				error:function(request,status,error){
			        alert(JS_MESSAGE["ajax.error.message"]);
			        updateUserDeviceFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
	
	function checkUserDevice() {
		for(var i=1; i<userDeviceCount + 1; i++) {
			if(document.getElementById("user_device" + i).style.display == "") {
				if($("#device_name" + i).val() == null || $("#device_name" + i).val() == "") {
					alert("사용 기기명을 입력해 주십시오.");
					$("#device_name" + i).focus();
					return false;
				}
			}
		}
		
		for(var i=1; i<userDeviceCount + 1; i++) {
			if(!isIP($("#device_ip" + i).val())) {
				alert("IP 형식에 맞게 입력해 주십시오.");
				$("#device_ip" + i).focus();
				return false;
			}
		}
	}
	
	// 사용자 디바이스 추가
	function addUserDevice() {
		if(userDeviceArray[0] == "0") {
			$("#user_device1").css("display", "");
			userDeviceArray[0] = "1";
			userDeviceCount++;
		} else if(userDeviceArray[1] == "0") {
			$("#user_device2").css("display", "");
			userDeviceArray[1] = "1";
			userDeviceCount++;
		} else if(userDeviceArray[2] == "0") {
			$("#user_device3").css("display", "");
			userDeviceArray[2] = "1";
			userDeviceCount++;
		} else if(userDeviceArray[3] == "0") {
			$("#user_device4").css("display", "");
			userDeviceArray[3] = "1";
			userDeviceCount++;
		} else if(userDeviceArray[4] == "0") {
			$("#user_device5").css("display", "");
			userDeviceArray[4] = "1";
			userDeviceCount++;
		} else if(userDeviceArray[5] == "0") {
			userDeviceArray[5] = "1";
		}
		
		if(userDeviceArray[0] == "1" && userDeviceArray[1] == "1" && userDeviceArray[2] == "1"
				&& userDeviceArray[3] == "1" && userDeviceArray[4] == "1" && userDeviceArray[5] == "1") {
			alert("사용자 디바이스 등록은 최대 5개 까지 가능합니다.");
		}
		userDeviceArray[5] = "0"
	}
	
	// 사용자 디바이스 삭제
	function removeUserDevice(idx) {
		var loopCount = userDeviceCount + 1;
		for(var i = idx; i < loopCount; i++) {
			if(i == loopCount - 1) {
				// 마지막의 경우 삭제하고 종료
				userDeviceArray[i-1] = "0";
				$("#device_name" + i).val("");
				$("#device_ip" + i).val("");
				document.getElementById("device_type" + i).selectedIndex = 0;
				document.getElementById("use_yn" + i).selectedIndex = 0;
				$("#user_device" + i).css("display", "none");
				userDeviceCount--;
				return;
			}
			
			$("#device_name" + i).val( $("#device_name" + (i + 1)).val() );
			$("#device_ip" + i).val( $("#device_ip" + (i + 1)).val() );
			document.getElementById("device_type" + i).selectedIndex = document.getElementById("device_type" + (i+1)).selectedIndex;
			document.getElementById("use_yn" + i).selectedIndex = document.getElementById("use_yn" + (i+1)).selectedIndex;
		}
	}
	
	$( "#email3" ).selectmenu({
		change: function( event, ui ) {
			if($("#email3").val() != 0) {
				$("#email2").val($("#email3").val());
			} else {
				$("#email2").val("");
			}
		}
	});
</script>
</body>
</html>