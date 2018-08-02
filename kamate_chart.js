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
		for (var banka_idx in config.data.datasets) {
			var cur_banka = config.data.datasets[banka_idx];
			var last_idx = cur_banka.data.length-1;
			last_pct.push ([ cur_banka.label, cur_banka.data[last_idx], cur_banka.data ]);
		}
		last_pct.sort(function(a, b) {
			retVal=0;
			if(a[1]!=b[1]) retVal=a[1]>b[1]?1:-1;
			return retVal
		});
		var old_tbody = document.getElementById('tbody_lastpct');
		var new_tbody = document.createElement('tbody');
		for (var banka_idx in last_pct) {
			var row = new_tbody.insertRow(0);
			var cell_label = row.insertCell(0); cell_label.innerHTML = last_pct[banka_idx][0];
			var cell_pct = row.insertCell(1);
			var pct_l = last_pct[banka_idx][1];
			var txt = pct_l ? pct_l.toFixed(2) + "% " : "&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;";			// assume  no data for last percentage, unless proven otherwise
			var pct_all = last_pct[banka_idx][2];
			var pct_prev = pct_all[1];
			for (var pct_idx in pct_all) {
				pct_cur = pct_all[pct_idx];
				var txt2 = '-';	// default sign if no percentage defined
				if (pct_cur && pct_prev) {
					if (pct_cur > pct_prev) {
						txt2 = "<span class=u>&#x25B2;</span>";	// triangle up
					} else if (pct_cur < pct_prev) {
						txt2 = "<span class=d>&#x25BC;</span>";	// triangle down
					} else {
						txt2 = "=";	//"&nbsp;";			// empty box
					}
					//txt2 += pct_idx + "/" + pct_cur.toFixed(2) + "% ";
				}
				txt += txt2;
				pct_prev = pct_cur;
			}
			cell_pct.innerHTML = txt;
		}
		old_tbody.parentNode.replaceChild(new_tbody, old_tbody)
	    }
	};
	jsonhttp.open("GET", "getdata.cgi", true);
	jsonhttp.send(); 
};

