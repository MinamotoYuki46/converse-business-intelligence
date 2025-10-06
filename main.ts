import { loadDimensions } from "./etl/loadDim";
import { loadFacts } from "./etl/loadFact";

async function main() {
    console.log("🚀 Starting ETL process...");
    await loadDimensions();
    console.log("✅ Dimensions loaded.");
    await loadFacts();
    console.log("✅ Facts loaded.");
    console.log("🎯 ETL process completed.");
}

main().catch(err => console.error("❌ ETL failed:", err));
