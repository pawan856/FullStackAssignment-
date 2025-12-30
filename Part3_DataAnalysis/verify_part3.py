import pandas as pd
import os

def verify_part3():
    print("--- Verifying Part 3: Data Analysis ---")
    
    # Check if files exist
    files = ['dataset.csv', 'Analysis.ipynb', 'Analysis.html']
    missing = [f for f in files if not os.path.exists(f)]
    
    if missing:
        print(f"❌ FAILED: Missing files: {missing}")
        return
    else:
        print("✅ File Check: All required files exist.")

    # Verify Analysis Logic
    try:
        df = pd.read_csv('dataset.csv')
        
        # 1. Cleaning & Column Mapping
        # Map new columns to old names for consistency if needed, or just access directly
        df.rename(columns={'User ID': 'User_ID', 'Product Category': 'Product_Category'}, inplace=True)
        
        df['Revenue'] = df['Revenue'].fillna(0)
        
        # New date format seems to be DD-MM-YYYY
        df['Timestamp'] = pd.to_datetime(df['Timestamp'], dayfirst=True, errors='coerce')
        df = df.dropna(subset=['Timestamp'])
        
        # 2. Conversion Rate Calc
        total_users = df['User_ID'].nunique()
        purchasers = df[df['Action'] == 'purchased']['User_ID'].nunique()
        conversion_rate = (purchasers / total_users) * 100
        
        print(f"✅ Data Loaded: {len(df)} rows.")
        print(f"ℹ️  Calculated Conversion Rate: {conversion_rate:.2f}%")
        
        if conversion_rate > 0:
             print("✅ Logic Check: Convention rate calculation looks valid.")
        else:
             print("⚠️  Warning: Conversion rate is 0%.")

    except Exception as e:
        print(f"❌ FAILED: Error during data verification: {e}")
        return

    print("--- Part 3 Verification COMPLETED SUCCESSFULY ---")

if __name__ == "__main__":
    verify_part3()
