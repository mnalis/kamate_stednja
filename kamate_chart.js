var config = {
	type: 'line',
	data: {},
	options: {
		responsive: true,
		spanGaps: false,
		title: {
			display: true,
			text: 'Banke kamate Chart.js'
		},
		tooltips: {
			mode: 'point',
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
					labelString: 'Datum'
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

		// find last pct for each bank, in order to create table:
		var last_pct = [];
		for (var i in config.data.datasets) {
			var cur=config.data.datasets[i];
			last_pct.push ([ cur.label, cur.data[cur.data.length-1] ]);
		}
		last_pct.sort(function(a, b) {
			retVal=0;
			if(a[1]!=b[1]) retVal=a[1]>b[1]?1:-1;
			return retVal
		});
		var old_tbody = document.getElementById('tbody_lastpct');
		var new_tbody = document.createElement('tbody');
		for (var i in last_pct) {
			var row = new_tbody.insertRow(0);
			var cell_label = row.insertCell(0); cell_label.innerHTML = last_pct[i][0];
			var cell_pct = row.insertCell(1); cell_pct.innerHTML = last_pct[i][1] ? last_pct[i][1].toFixed(2) + "%" : "-";
		}
		old_tbody.parentNode.replaceChild(new_tbody, old_tbody)
	    }
	};
	jsonhttp.open("GET", "getdata.cgi", true);
	jsonhttp.send(); 
};

