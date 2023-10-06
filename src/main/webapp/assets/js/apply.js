/**
 * 
 */
let startDateInput = document.getElementById("startDate");
		let endDateInput = document.getElementById("endDate");
		let noOfDaysInput = document.getElementById("noOfDays");
		let submitBtn = document.getElementById("sumbit");

		// Get all date input fields
		let dateInputs = document.querySelectorAll(".date");

		const today = new Date(Date.now() - new Date().getTimezoneOffset()
				* 60000).toISOString().split("T")[0];
		// Set the minimum date for each date input field
		dateInputs.forEach(function(dateInput) {
			dateInput.setAttribute("min", today);
		});

		function calculateDaysDifference() {
			let startDate = new Date(startDateInput.value);
			let endDate = new Date(endDateInput.value);

			if (endDate != "Invalid Date"
					&& startDate.getDate() == endDate.getDate()) {
				noOfDaysInput.removeAttribute("readonly");
				document.addEventListener("change",
						function() {
							if (noOfDaysInput.value != 1
									&& noOfDaysInput.value != 0.5) {
								alert("Please Enter no of Days 1 or 0.5");
								submitBtn.setAttribute("disabled", "");
							} else {
								submitBtn.removeAttribute("disabled");
							}
						});
			} else {
				noOfDaysInput.setAttribute("readonly", "");
			}

			// Calculate time difference
			let timeDifference = endDate.getTime() - startDate.getTime();

			// Calculate days difference by dividing total milliseconds in a day
			let daysDifference = timeDifference / (1000 * 60 * 60 * 24);

			let weekendDays = 0;

			for (let i = 0; i <= daysDifference; i++) {
				let currentDate = new Date(startDate);
				currentDate.setDate(startDate.getDate() + i);

				// Check if the current day is a Saturday or Sunday
				if (currentDate.getDay() === 0 || currentDate.getDay() === 6) {
					weekendDays++;
				}
			}

			// Subtract weekend days from the total days
			let totalDaysWithoutWeekends = daysDifference - weekendDays + 1;

			noOfDaysInput.value = totalDaysWithoutWeekends;
		}

		endDateInput.addEventListener("input", calculateDaysDifference);
		calculateDaysDifference();