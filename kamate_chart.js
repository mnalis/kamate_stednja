		var config = {
			type: 'line',
			data: {},
			options: {
				responsive: true,
				title: {
					display: true,
					text: 'Banke kamate Chart.js'
				},
				tooltips: {
					mode: 'index',
					intersect: false,
				},
				hover: {
					mode: 'nearest',
					intersect: true
				},
				scales: {
					xAxes: [{
						display: true,
						type: 'time',
						time: {
							displayFormats: {
								hour: 'YYYY-MM-DD'
							}
						},
						distribution: 'linear',
						scaleLabel: {
							display: true,
							labelString: 'Time'
						}
					}],
					yAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'kamate %'
						}
					}]
				}
			}
		};

		window.onload = function() {
			var jsonhttp = new XMLHttpRequest();
			jsonhttp.onreadystatechange = function() {
			    if (this.readyState == 4 && this.status == 200) {
				config.data = JSON.parse(this.responseText);

				var ctx = document.getElementById('canvas').getContext('2d');
				window.myLine = new Chart(ctx, config);
			    }
			};
			jsonhttp.open("GET", "getdata.json", true);
			jsonhttp.send(); 
		};

