<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="text-right">
			<a style="display: inline-block;" href="#reviews-anchor"
				id="open-review-box" class="btn btn-success btn-green">Leave a
				Review</a>
		</div>
		<div class="row" id="post-review-box" style="display: none;">
			<div class="col-md-12">
				<form:form method="post" modelAttribute="review" id="reviewForm">

					<form:hidden id="ratings-hidden" path="rating" />
					<form:hidden path="product.id" />
					<div class="col-xs-12 col-md-6">
						<form:input path="userName" class="form-control animated"
							placeholder="Name" />
					</div>
					<div class="col-xs-12 col-md-6">
						<form:input path="userEmail" id="userEmail"
							class="form-control animated" placeholder="Email" />
					</div>
					<div class="col-md-12" style="margin-top: 2rem;">
						<form:textarea path="comment"
							style="overflow: hidden; word-wrap: break-word; resize: horizontal; height: 54px;"
							rows="5" id="new-review" class="form-control animated"
							placeholder="Enter your review here..." name="comment" cols="50"></form:textarea>
					</div>
					<div class="text-right">
						<div class="stars starrr" data-rating="0"></div>
						<a href="#" class="btn btn-danger btn-sm" id="close-review-box"
							style="margin-right: 10px; display: none;"> <span
							class="glyphicon glyphicon-remove"></span>Cancel
						</a>
						<button class="btn btn-success btn-lg" type="submit">Save</button>
					</div>
				</form:form>
			</div>
		</div>
		<!--popup-->
		<div id="popup" class="popup-wrapper" style="display: none;">
			<div class="popup-content">
				<div class="popup-title">
					<button type="button" class="popup-close">×</button>
					<h3></h3>
				</div>
				<div class="popup-body">Popup body</div>
			</div>
		</div>

		<script type="text/javascript">
			$(function() {

				// initialize the autosize plugin on the review text area
				$('#new-review').autosize({
					append : "\n"
				});

				var reviewBox = $('#post-review-box');
				var newReview = $('#new-review');
				var openReviewBtn = $('#open-review-box');
				var closeReviewBtn = $('#close-review-box');
				var ratingsField = $('#ratings-hidden');

				openReviewBtn.click(function(e) {
					reviewBox.slideDown(400, function() {
						$('#new-review').trigger('autosize.resize');
						newReview.focus();
					});
					openReviewBtn.fadeOut(100);
					closeReviewBtn.show();
				});

				closeReviewBtn.click(function(e) {
					e.preventDefault();
					reviewBox.slideUp(300, function() {
						newReview.focus();
						openReviewBtn.fadeIn(200);
					});
					closeReviewBtn.hide();

				});

				// If there were validation errors we need to open the comment form programmatically 

				// Bind the change event for the star rating - store the rating value in a hidden field
				$('.starrr').on('starrr:change', function(e, value) {
					ratingsField.val(value);
					console.log(value);
				});
			});
		</script>

		<script type="text/javascript">
			$(document)
					.ready(
							function() {
								var popup = $('#popup').popup({
									width : 400,
									height : 130
								});

								$('#reviewForm')
										.submit(
												function(e) {
													e.preventDefault();

													var str = $("#reviewForm")
															.serialize();

													$
															.ajax({
																type : "post",
																dataType : 'text',
																data : str,
																url : "${pageContext.request.contextPath}/createReview",
																async : false,
																success : function(
																		data) {
																	if (data == "SUCCESS") {
																		document
																				.getElementById('reviewPostMessage').innerHTML = "Review uploaded successfuly!";
																		popup
																				.open();
																		$(
																				'#close-review-box')
																				.click();
																	} else {
																		document
																				.getElementById('reviewPostMessage').innerHTML = data;
																		popup
																				.open();
																	}
																}
															});
												});
							});
		</script>
		<div class="ratings">

			${fn:length(prod.reviews)} reviews

			<c:forEach begin="1" end="${prod.rating}" varStatus="loop">
				<span class="glyphicon glyphicon-star"></span>
			</c:forEach>
			<c:forEach begin="${prod.rating}" end="4" varStatus="loop">
				<span class="glyphicon glyphicon-star-empty"></span>
			</c:forEach>
			${prod.rating}.0 stars
		</div>
