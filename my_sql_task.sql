# The first query has to return all products connected with the sub_category “Jewelry”.
# The second query has to return all products connected with the keyword “Hair accessor”.
# The third query has to return all products connected either with sub_categories “Beauty & Personal Care” and “Skincare” (any of them!) or with the keyword “Aromatherapy”.
# In all these queries, we want to see only products which are not sold out yet.

# Task 1
SELECT DISTINCT gp.product_name,
                gp.product_img_url,
                gp.product_url,
                gp.product_price_min,
                gp.product_short_description
FROM grommet_products gp
         JOIN grommet_product_categories gpc ON gp.id = gpc.product_id
         JOIN grommet_gifts_categories ggc ON gpc.product_category_id = ggc.id
WHERE NOT gp.is_sold_out
  AND ggc.sub_category = 'Jewelry';

# Task 2
SELECT DISTINCT gp.product_name,
                gp.product_img_url,
                gp.product_url,
                gp.product_price_min,
                gp.product_short_description
FROM grommet_products gp
         JOIN grommet_product_to_keyword gptk ON gp.id = gptk.product_id
         JOIN grommet_product_keywords gpk ON gptk.keyword_id = gpk.id
WHERE NOT gp.is_sold_out
  AND gpk.keyword = 'Hair accessor';

# Task 3
SELECT DISTINCT gp.product_name,
                gp.product_img_url,
                gp.product_url,
                gp.product_price_min,
                gp.product_short_description
FROM grommet_products gp
         LEFT JOIN grommet_product_categories gpc ON gp.id = gpc.product_id
         LEFT JOIN grommet_gifts_categories ggc ON gpc.product_category_id = ggc.id
         LEFT JOIN grommet_product_to_keyword gptk ON gp.id = gptk.product_id
         LEFT JOIN grommet_product_keywords gpk ON gptk.keyword_id = gpk.id
WHERE NOT gp.is_sold_out
  AND (ggc.sub_category IN ('Beauty & Personal Care', 'Skincare') OR gpk.keyword = 'Aromatherapy');


