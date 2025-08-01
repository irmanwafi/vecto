<template>
  <div id="app" class="container">
    <header class="header">
      <img src="https://www.vectolabs.com/wp-content/uploads/2023/11/cropped-Vectolabs-No-Subtext.png" alt="Vectolabs Logo" class="logo" />
      <h1 class="title">Vectolabs</h1>
      <p class="subtitle">Professional Asset Management</p>
    </header>
    <main>
      <div class="table-card">
        <h2 class="section-title">Asset List</h2>
        <table class="asset-table">
          <thead>
            <tr>
              <th>Asset Name</th>
              <th>Department</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(item, index) in assets" :key="index">
              <td>{{ item.asset }}</td>
              <td>{{ item.department }}</td>
            </tr>
          </tbody>
        </table>
        <button class="download-btn" @click="downloadCSV">Download CSV</button>
      </div>
    </main>
    <footer class="footer">
      &copy; {{ new Date().getFullYear() }} Vectolabs. All rights reserved.
    </footer>
  </div>
</template>

<script>
export default {
  name: "App",
  data() {
    return {
      assets: [
        { asset: "Printer", department: "HR" },
        { asset: "Monitor", department: "IT" },
        { asset: "Barcode Scanner", department: "ACCOUNT" }
      ]
    };
  },
  methods: {
    downloadCSV() {
      const rows = [
        ["Asset name", "Department"],
        ...this.assets.map(item => [item.asset, item.department])
      ];
      const csv = rows.map(r => r.join(",")).join("\n");
      const blob = new Blob([csv], { type: "text/csv" });
      const url = URL.createObjectURL(blob);
      const a = document.createElement("a");
      a.href = url;
      a.download = "assets.csv";
      a.click();
      URL.revokeObjectURL(url);
    }
  }
};
</script>



<style scoped>
body {
  background: #ececec;
  font-family: 'Segoe UI', Arial, sans-serif;
  margin: 0;
  padding: 0;
}
.container {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background: linear-gradient(135deg, #f8f9fa 0%, #e0e0e0 100%);
}
.header {
  background: rgba(255,255,255,0.35);
  color: #222;
  padding: 2rem 1rem 1rem 1rem;
  text-align: center;
  border-bottom-left-radius: 30px;
  border-bottom-right-radius: 30px;
  box-shadow: 0 4px 24px 0 rgba(180,180,180,0.12);
  backdrop-filter: blur(12px);
}
.logo {
  max-width: 120px;
  height: auto;
  margin-bottom: 0.5rem;
  display: inline-block;
  background: rgba(255,255,255,0.7);
  box-shadow: 0 2px 12px rgba(180,180,180,0.18);
  border-radius: 10px;
}
.title {
  font-family: 'Segoe UI', Arial, sans-serif;
  font-size: 2.5rem;
  font-weight: 700;
  margin: 0.2rem 0 0.3rem 0;
  letter-spacing: 2px;
  color: #444;
  text-shadow: 0 2px 8px rgba(200,200,200,0.18);
  text-transform: uppercase;
}
.subtitle {
  font-family: 'Segoe UI', Arial, sans-serif;
  font-size: 1.1rem;
  color: #888;
  margin-bottom: 0.5rem;
  letter-spacing: 1px;
}
.table-card {
  background: rgba(255,255,255,0.55);
  margin: 2rem auto 1rem auto;
  padding: 2rem 2.5rem 1.5rem 2.5rem;
  border-radius: 18px;
  box-shadow: 0 2px 24px 0 rgba(180,180,180,0.14);
  max-width: 480px;
  width: 100%;
  backdrop-filter: blur(10px);
  border: 1.5px solid rgba(220,220,220,0.45);
}
.section-title {
  font-family: 'Segoe UI', Arial, sans-serif;
  font-size: 1.3rem;
  font-weight: 700;
  color: #555;
  margin-bottom: 1.2rem;
  text-align: left;
  letter-spacing: 1px;
}
.asset-table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 1.5rem;
  background: rgba(255,255,255,0.7);
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 1px 8px rgba(180,180,180,0.08);
}
.asset-table th, .asset-table td {
  font-family: 'Segoe UI', Arial, sans-serif;
  padding: 0.85rem 1.2rem;
  text-align: left;
}
.asset-table th {
  background: rgba(240,240,240,0.85);
  color: #444;
  font-weight: 600;
  border-bottom: 2px solid #e0e0e0;
  backdrop-filter: blur(4px);
}
.asset-table td {
  background: rgba(255,255,255,0.85);
  color: #333;
  border-bottom: 1px solid #e0e0e0;
}
.asset-table tr:last-child td {
  border-bottom: none;
}
.download-btn {
  font-family: 'Segoe UI', Arial, sans-serif;
  background: linear-gradient(90deg, #e0e0e0 0%, #f5f5f5 100%);
  color: #444;
  border: none;
  border-radius: 8px;
  padding: 0.7rem 1.6rem;
  font-size: 1rem;
  font-weight: 700;
  cursor: pointer;
  box-shadow: 0 2px 12px rgba(180,180,180,0.10);
  transition: background 0.2s, box-shadow 0.2s, color 0.2s;
  border: 1px solid #d0d0d0;
  backdrop-filter: blur(2px);
  letter-spacing: 1px;
}
.download-btn:hover {
  background: linear-gradient(90deg, #f5f5f5 0%, #e0e0e0 100%);
  color: #111;
  box-shadow: 0 4px 24px rgba(180,180,180,0.18);
}
.footer {
  font-family: 'Segoe UI', Arial, sans-serif;
  margin-top: auto;
  background: rgba(255,255,255,0.35);
  color: #888;
  text-align: center;
  padding: 1rem 0 0.7rem 0;
  font-size: 1rem;
  border-top-left-radius: 20px;
  border-top-right-radius: 20px;
  box-shadow: 0 -2px 12px rgba(180,180,180,0.08);
  backdrop-filter: blur(8px);
  letter-spacing: 1px;
}
</style>
