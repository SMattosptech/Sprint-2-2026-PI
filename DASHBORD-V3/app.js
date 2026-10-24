 
const dados = {
  '24': {
    labels: ['00h', '03h', '06h', '09h', '12h', '15h', '18h', '21h', '22h', '23h'],
    Umidade: [23.5, 45.8, 24.2, 26.0, 25.5, 27.2, 98.0, 47.3, 25.0, 25.5],
  },
  '7': {
    labels: ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'],
    Umidade: [24.1, 25.3, 23.8, 26.5, 27.1, 25.0, 24.6],
  },
};

let lineChart;
function renderChart(period) {
  if (lineChart) lineChart.destroy();
  const d = dados[period];
  lineChart = new Chart(document.getElementById('chart'), {
    type: 'line',
    data: {
      labels: d.labels,
      datasets: [{
        label: 'Umidade (%)',
        data: d.Umidade,
        borderColor: '#B98543',
        backgroundColor: 'rgba(185,133,67,0.15)',
        fill: true,
        tension: 0.4,
      }],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      animation: false,
      plugins: {
        legend: {
          labels: { color: '#e7eeea' },
        },
      },
      scales: {
        x: {
          ticks: { color: '#e7eeea' },
        },
        y: {
          min: 0,
          max: 100,
          ticks: { color: '#e7eeea' },
        },
      },
    },
  });
}

const plugin = {
  id: 'customCanvasBackgroundColor',
  beforeDraw: (chart, args, options) => {
    const { ctx } = chart;
    ctx.save();
    ctx.globalCompositeOperation = 'destination-over';
    ctx.fillStyle = options.color || 'lightGreen';
    ctx.fillRect(0, 0, chart.width, chart.height);
    ctx.restore();
  },
};

let donutChart;
function renderDonut() {
  if (donutChart) donutChart.destroy();
  const normal = 6;
  const attn = 2;
  const crit = 0;
  donutChart = new Chart(document.getElementById('donut-chart'), {
    type: 'doughnut',
    data: {
      labels: ['Normal', 'Atenção', 'Crítico'],
      datasets: [{
        label: 'Sensores',
        data: [normal, attn, crit],
        backgroundColor: ['#6D946B', '#B98543', '#C96A55'],

      }],
    },
       options: {
      responsive: true,
      maintainAspectRatio: false,
      animation: false,
      plugins: {
        legend: {
          labels: { color: '#F0EEE8' },
        },
        customCanvasBackgroundColor: {
          color: 'rgba(255, 255, 255, 0.0)',
        },
      },
    },
    plugins: [plugin],
  });

  document.getElementById('cnt-normal').textContent = String(normal).padStart(2, '0');
  document.getElementById('cnt-attn').textContent = String(attn).padStart(2, '0');
  document.getElementById('cnt-crit').textContent = String(crit).padStart(2, '0');
}

renderDonut();
renderChart('24');

document.getElementById('period').addEventListener('change', (e) => renderChart(e.target.value));
