/**
 * 
 */
// Function to open the Add Employee popup
		function openAddEmployeePopup() {
			const addPopupContainer = document
					.getElementById("addPopupContainer");
			addPopupContainer.style.display = "flex";
		}

		// Function to close the Add Employee popup
		function closeAddEmployeePopup() {
			const addPopupContainer = document
					.getElementById("addPopupContainer");
			addPopupContainer.style.display = "none";
		}

		// Function to close the Edit popup
		function closeEditPopup() {
			const editPopup = document.querySelector(".edit-popup");
			editPopup.style.display = "none";
		}

		// Event listeners
		const addEmployeeButton = document.getElementById("addEmployeeButton");
		const closePopupButton = document.getElementById("closePopup"); // Use the correct ID
		const closeEditPopupButton = document.getElementById("closeEditPopup");

		if (addEmployeeButton) {
			addEmployeeButton.addEventListener("click", openAddEmployeePopup);
		}

		if (closePopupButton) { // Use the correct button variable
			closePopupButton.addEventListener("click", closeAddEmployeePopup);
		}

		if (closeEditPopupButton) {
			closeEditPopupButton.addEventListener("click", closeEditPopup);
		}

		const updateForm = document.getElementById("updateForm");
		function setFormUpdate() {
			const email = document.getElementById("emailUpdate").value;
			const name = document.getElementById("nameUpdate").value;
			const manager = document.getElementById("managerUpdate").value;
			const password = document.getElementById("passwordUpdate").value;

			updateForm.action = `UpdateServlet?email=${email}&name=${name}&manager=${manager}&password=${password}`;
		}
		function setFormDelete() {
			const email = document.getElementById("emailUpdate").value;
			updateForm.action = `DeleteServlet?email=${email}`;
		}