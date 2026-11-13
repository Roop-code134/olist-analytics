# Insights and Recommendations

Analysis window: **1 Jan 2017 to 31 Aug 2018**, delivered orders only.
Revenue in SQL Q1 and in the dashboard = payment value (includes freight). Revenue in Q2, Q3 and Q5 = item price only (excludes freight), so totals differ (15.38M vs about 13.2M).

---

## Headline findings

| # | Finding | Evidence | Recommendation |
|---|---|---|---|
| 1 | Retention is extremely low | Only 3.0% of customers (2,789 of 93,104) bought more than once; they generate 5.5% of revenue. Cohort retention is below 1% in every month. | Launch post-purchase emails, loyalty offers and review follow-ups |
| 2 | Late delivery hurts reviews | 8.0% of orders arrive late. Late orders average 2.57 stars vs 4.29 on time (gap of 1.72) | Set delivery targets for the worst states and sellers |
| 3 | Revenue growth stalled in 2018 | Revenue rose through 2017, then stayed at roughly 1.0M to 1.13M per month from Jan to Aug 2018 | Shift focus from acquisition alone to retention |
| 4 | Revenue is concentrated geographically | SP, RJ and MG generate about 63% of item revenue | Keep investing in the Southeast; test offers in mid-sized states |
| 5 | A few seller groups drag down quality | Lowest-rated sellers (30+ orders) average 2.3 to 3.1 stars, many with 12% to 32% late rates | Introduce seller performance thresholds |

---

## Q1: Monthly revenue and growth
Revenue grew fast through 2017 (127,546 in Jan 2017 to over 1M by late 2017), with a Black Friday spike in November 2017 followed by a 26.9% drop in December. From Jan 2018 it plateaued between about 0.97M and 1.13M per month and drifted down after April (Aug 2018: 985,414).
**Recommendation:** growth depends on new customers and that has stalled, so retention is the bigger lever.

## Q2: Top 10 categories
Revenue is spread across many categories, led by health_beauty and watches_gifts, then bed_bath_table, sports_leisure and computers_accessories. watches_gifts earns more revenue from fewer orders (5,491) than bed_bath_table (9,267 orders). Freight is about 24% of revenue for furniture_decor but about 8% for watches_gifts.
**Recommendation:** promote high-value categories; review shipping options for bulky ones.

## Q3: Repeat vs one-time customers
2,789 repeat customers (3.0%) brought 725,355 (5.5% of revenue). 90,315 one-time customers brought 12,455,672 (94.5%).
**Recommendation:** even a small increase in repeat rate adds revenue without new acquisition cost.

## Q4: Cohort retention
In the January 2017 cohort, 2 of 717 customers (about 0.3%) returned in month 1. Across all cohorts the heatmap shows 0.0% to 0.7%, with no improvement from 2017 to 2018, so the problem is structural, not seasonal.
**Recommendation:** build a dedicated retention programme.

## Q5: Lifetime value by state
SP 5.06M, RJ 1.75M and MG 1.55M of item revenue. SP has the most customers (39,065) but a lower average value per customer (129.50) than BA (156.39), RJ (147.46) and GO (149.56).
**Recommendation:** keep investing in the Southeast and test higher-value offers in SP; explore mid-sized states where customers spend more.

## Q6: Delivery performance vs reviews
7,697 of 96,087 reviewed orders (8.0%) arrived after the estimated date. Late orders average 2.57 stars vs 4.29 for on-time orders.
**Caveat:** this shows association, not proof of cause; late orders may differ in distance or product type.
**Recommendation:** treat late delivery as the main driver of poor reviews and set targets for the worst states.

## Q7: Lowest-rated sellers (minimum 30 orders)
The lowest-rated sellers average roughly 2.3 to 3.1 stars, and many have late rates of 12% to 32%, well above the platform's 8%. Lateness is not the only cause: one seller has a 13.8% late rate but a 2.81 rating.
**Recommendation:** thresholds for rating and late rate, warnings, and review of sellers who do not improve.

## Q8: Payment methods
Credit card is about 78% of payment value (12.06M of about 15.38M), with 3.5 installments on average. Boleto is about 18% (2.76M). Voucher and debit card are marginal.
**Recommendation:** keep installments prominent at checkout and keep boleto for customers without cards.

## RFM segmentation (Python)
93,104 customers scored on recency, frequency and monetary value. Champions and At Risk (High Value) bring the largest revenue shares (roughly 30% each) from far fewer customers than Lost or Recent Customers. Even the best segments have repeat-purchase rates under 7% (Potential Loyalists 6.7%, Champions 6.4%, At Risk 5.2%; Lost 1.1%, Recent 1.0%, Average 0.9%).
**Recommendation:** win back the At Risk (High Value) segment first, since these customers have already shown high spend.

## Limitations
- Olist has no cost data, so profit margin cannot be calculated.
- Data covers Jan 2017 to Aug 2018 only; Sep to Oct 2018 is incomplete and excluded.
- Frequency is almost always 1, so the RFM frequency score is rank-based.
- The category and seller charts in the dashboard are not filtered by the state or date slicers.
