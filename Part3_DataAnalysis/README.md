# Part 3: Data Analysis Task

## Setup Instructions

1.  **Install Python**: Ensure Python is installed (3.x recommended).
2.  **Install Dependencies**: Run the following command to install the necessary libraries:
    ```bash
    pip install pandas matplotlib seaborn jupyter
    ```
3.  **Run the Notebook**:
    ```bash
    jupyter notebook Analysis.ipynb
    ```
    Or open `Analysis.ipynb` directly in VS Code (requires Python and Jupyter extensions).

## Overview of Analysis

### 1. Data Cleaning
-   Loaded `dataset.csv`.
-   Filled missing `Revenue` values with `0.0` (assuming non-purchases have 0 revenue).
-   Converted `Timestamp` to datetime objects and removed rows with invalid time formats.

### 2. Analysis Performed
-   **Popular Categories**: Calculated based on the total count of actions (View, AddToCart, Purchase) per category.
-   **Conversion Rate**: Calculated as `(Unique Purchasers / Total Unique Users) * 100`.
-   **Trends**: Visualized daily user actions using a line chart.

### 3. Insights (Mock Data Based)
-   **Electronics** appears to be the most active category.
-   Conversion rates fluctuate based on the user sample.
-   Recommendations include focusing marketing on high-traffic categories and retargeting users who carted items but didn't checkout.
