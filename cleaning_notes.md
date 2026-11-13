# Data Cleaning Notes

## Findings
- 97% of orders are delivered (96,478). Revenue and delivery analysis uses delivered orders only.
- 8 delivered orders have no delivery date; excluded from delivery-time metrics.
- 610 products have no category; grouped as 'unknown'.
- 2016 data is very sparse (a few hundred orders); trend analysis starts Jan 2017.
- Data spans 4 Sep 2016 to 17 Oct 2018.
- Sep 2018 (16 orders) and Oct 2018 (4 orders) are incomplete; excluded from trends.
- customer_id is unique per order; customer_unique_id identifies real customers.

## Final analysis window
1 Jan 2017 to 31 Aug 2018 (complete months only).