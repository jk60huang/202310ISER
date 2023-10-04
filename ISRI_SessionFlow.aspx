
<placeholder id="flowPlaceHolder">
	 
	<h3 class="text-center  ">場次流程</h3>

	<div class=" card">
		<div class=" py-3 px-4 ms-3 ms-lg-5">
			<input type="hidden"
				   id="flowStep"
				   data-provide="slider"
				   data-slider-ticks="[1, 2, 3]"
				   data-slider-ticks-labels='["<%:ISRE.Enum_SessionFlow.Session.GetDescription() %>",
				"<%:ISRE.Enum_SessionFlow.RegistrationForm.GetDescription() %>",
				"<%:ISRE.Enum_SessionFlow.Activate.GetDescription() %>"]'
				   data-slider-value="3"
				   data-slider-enabled="false">
		</div>
		
	</div>
</placeholder>


 