CREATE SCHEMA wages_education;

USE wages_education;

-- Wages are adjusted for inflation.

-- Temp table for to later show the increase or decrease in average wage since 1973

CREATE TEMPORARY TABLE wage_increase (
	person_and_ed VARCHAR(500),
    avg_wage_1973 FLOAT(5, 2), 
    avg_wage_2022 FLOAT(5, 2)
);
INSERT INTO wage_increase (person_and_ed, avg_wage_1973, avg_wage_2022)
VALUES
-- By gender
('Men without highschool educations', 21.18, 17.99),
('Men with advanced degrees', 40.09, 63.51),
('Women without highschool educations', 12.89, 14.33),
('Women with advanced degrees', 32.73, 44.34),
-- By ethnicity
('White person without highschool education', 18.67, 15.70),
('Black person without highschool education', 15.77, 15.19),
('Hispanic person without highschool education', 16.58, 17.32),
('White person with advanced degree', 38.11, 53.30),
('Black person with advanced degree', 42.01, 44.67),
('Hispanic person with advanced degree', 36.35, 48.30), 
-- By gender and ethnicity
('White men without highschool educations',  21.95, 17.14),
('Black men without highschool educations', 18.63, 16.38),
('Hispanic men without highschool educations', 18.43, 18.67),
('White women without highschool educations',  13.08, 13.84),
('Black women without highschool educations', 12.02, 13.89),
('Hispanic women without highschool educations', 12.92, 14.74),
('White men with advanced degrees', 40.23, 63.86),
('Black men with advanced degrees', 42.15, 52.91),
('Hispanic men with advanced degrees', 42.61, 57.08),
('White women with advanced degrees', 31.81, 44.45),
('Black women with advanced degrees', 41.81, 39.41),
('Hispanic women with advanced degrees', 25.10, 40.64);

-- The increase/decrease in the average wages of men and women since 1973 by ethnicity

SELECT 
	*,
    ROUND((avg_wage_2022 - avg_wage_1973)/avg_wage_1973 * 100, 1) AS `% increase/decrease since 1973`
FROM wage_increase;

-- Wage gap between men with an advanced degree and men without a highschool education.
-- Wage gap between women with an advanced degree and women without a highschool education.
-- Wage gap between men without a highschool education and women without a highschool education. 
-- Wage gap between men with advanced degrees and women with advanced degrees. 

SELECT
	year AS Year,
	men_less_than_hs AS `Avg wage of men w/o highschool ed`, 
	women_less_than_hs AS `Avg wage of women w/o highschool ed`,
    men_advanced_degree AS `Avg wage of men w/ advanced degrees`,
    women_advanced_degree AS `Avg wage of women w/ advanced degrees`,
    ROUND(men_advanced_degree - men_less_than_hs, 2) AS `Wage gap between men w/ an advanced degree and men w/o a highschool ed`,
    ROUND((men_advanced_degree - men_less_than_hs)/men_less_than_hs * 100, 1) AS `How much more the avg man w/ an advanced degree makes than a man w/o a highschool ed in %`,
    ROUND(women_advanced_degree - women_less_than_hs, 2) AS `Wage gap between women w/ advanced degrees and women w/o a highschool ed`,
    ROUND((women_advanced_degree - women_less_than_hs)/women_less_than_hs * 100, 1) AS `How much more the avg woman w/ an advanced degree makes than a woman w/o a highschool ed in %`,
    ROUND(men_less_than_hs - women_less_than_hs, 2) AS `Wage gap between men and women w/o highschool ed`,
    ROUND((men_less_than_hs - women_less_than_hs)/women_less_than_hs * 100, 2) AS `How much more/less men w/o highschool ed make compared to women in %`,
    ROUND(men_advanced_degree - women_advanced_degree, 2) AS `Wage gap between men and women with advanced degrees`,
    ROUND((men_advanced_degree - women_advanced_degree)/women_advanced_degree * 100, 2) AS `Wage gap between men and women with advanced degrees in %`
FROM wages_by_education
WHERE year = 2022 OR year = 1973;

-- Average wage of a person without a high school education as well as the average wage of a person with an advanced degree by ethnicity.

SELECT 
	year AS Year,
    white_advanced_degree AS `Avg wage of white person w/ advanced degree`,
    black_advanced_degree AS `Avg wage of black person w/ advanced degree`,
    hispanic_advanced_degree AS `Avg wage of hispanic person w/ advanced degree`,
	ROUND(white_advanced_degree - black_advanced_degree, 2) AS `Wage gap between white and black people with advanced degrees`,
    ROUND((white_advanced_degree - black_advanced_degree)/black_advanced_degree * 100, 1) AS `How much more/less white people w/ advanced degrees make compared to black people in %`,
    ROUND(white_advanced_degree - hispanic_advanced_degree, 2) AS `Wage gap between white and hispanic people with advanced degrees`,
    ROUND((white_advanced_degree - hispanic_advanced_degree)/hispanic_advanced_degree * 100, 1) AS `How much more/less white people w/ advanced degrees make compared to hispanic people in %`,
    ROUND(hispanic_advanced_degree - black_advanced_degree, 2) AS `Wage gap between hispanic and black people with advanced degrees`,
    ROUND((hispanic_advanced_degree - black_advanced_degree)/black_advanced_degree * 100, 1) AS `How much more/less hispanic people w/ advanced degrees make compared to black people in %`
FROM wages_by_education
WHERE year = 2022 or year = 1973;

SELECT
	year AS Year,
    white_less_than_hs AS `Avg wage of white person w/o a highschool ed`,
    black_less_than_hs AS `Avg wage of black person w/o a highschool ed`,
    hispanic_less_than_hs AS `Avg wage of hispanic person w/o a highschool ed`,
    ROUND(white_less_than_hs - black_less_than_hs, 2) AS `Wage gap between white and black people without highschool educations`,
    ROUND((white_less_than_hs - black_less_than_hs)/black_less_than_hs * 100, 1) AS `How much more/less white people w/o highschool ed make compared to black people in %`,
    ROUND(white_less_than_hs - hispanic_less_than_hs, 2) AS `Wage gap between white and hispanic people`,
    ROUND((white_less_than_hs - hispanic_less_than_hs)/hispanic_less_than_hs * 100, 1) AS `How much more/less white people w/o highschool ed make compared to hispanic people in %`,
    ROUND(hispanic_less_than_hs - black_less_than_hs, 2) AS `Wage gap between hispanic and black people`,
    ROUND((hispanic_less_than_hs - black_less_than_hs)/black_less_than_hs * 100, 1) AS `How much more/less hispanic people w/o highschool ed make compared to black people in %`
FROM wages_by_education
WHERE year = 2022 OR year = 1973;

-- The average wages of men and women without highschool educations, by ethnicity.

SELECT
	year AS Year,
    white_men_less_than_hs AS `Avg wage of white men w/o a highschool ed`,
    black_men_less_than_hs AS `Avg wage of black men w/o a highschool ed`,
    hispanic_men_less_than_hs AS `Avg wage of hispanic men w/o a highschool ed`,
    white_women_less_than_hs AS `Avg wage of white women w/o a highschool ed`,
    black_women_less_than_hs AS `Avg wage of black women w/o a highschool ed`,
    hispanic_women_less_than_hs AS `Avg wage of hispanic women w/o a highschool ed`
FROM wages_by_education;

-- Average wage of men and women with advanced degrees, by ethnicity

SELECT
	year AS Year,
    white_men_less_than_hs AS `Avg wage of white men w/o a highschool ed`,
    black_men_less_than_hs AS `Avg wage of black men w/o a highschool ed`,
    hispanic_men_less_than_hs AS `Avg wage of hispanic men w/o a highschool ed`,
    white_men_advanced_degree AS `Avg wage of white men w/ an advanced degree`,
    black_men_advanced_degree AS `Avg wage of black men w/ an advanced degree`,
    hispanic_men_advanced_degree AS `Avg wage of hispanic men w/ an advanced degree`,
    white_women_advanced_degree AS `Avg wage of white women w/ an advanced degree`,
    black_women_advanced_degree AS `Avg wage of black women w/ an advanced degree`,
    hispanic_women_advanced_degree AS `Avg wage of hispanic women w/ an advanced degree`,
    -- Wage gaps between men with advanced degrees and men without highschool educations, by ethnicity
    ROUND(white_men_advanced_degree - white_men_less_than_hs, 2) AS `Wage gap between white men w/ advanced degrees and white men w/o a highschool ed`,
    ROUND((white_men_advanced_degree - white_men_less_than_hs)/white_men_less_than_hs * 100, 1) AS `How much more white men make w/ advanced degrees than white men w/o highschool ed in %`,
    ROUND(black_men_advanced_degree - black_men_less_than_hs, 2) AS `Wage gap between black men w/ advanced degrees and black men w/o a highschool ed`,
    ROUND((black_men_advanced_degree - black_men_less_than_hs)/black_men_less_than_hs * 100, 1) AS `How much more black men make w/ advanced degrees than black men w/o a highschool ed in %`,
    ROUND(hispanic_men_advanced_degree - hispanic_men_less_than_hs, 2) AS `Wage gap between hispanic men w/ advanced degrees and hispanic men w/o a highschool ed`,
    ROUND((hispanic_men_advanced_degree - hispanic_men_less_than_hs)/hispanic_men_less_than_hs * 100, 1) AS `How much more hipsanic men make w/ advanced degrees than hispanic men w/o a highschool ed in %`,
    -- Wage gaps between women with advanced degrees and women without highschool educations, by ethnicity 
    ROUND(white_women_advanced_degree - white_women_less_than_hs, 2) AS `Wage gap between white women w/ advanced degrees and white women w/o a highschool ed`,
    ROUND((white_women_advanced_degree - white_women_less_than_hs)/white_women_less_than_hs * 100, 1) AS `How much more white women w/ advanced degrees make compared to white women w/o highschool ed in %`,
    ROUND(black_women_advanced_degree - black_women_less_than_hs, 2) AS `Wage gap between black women w/ advanced degrees and black women w/o a highschool ed`,
    ROUND((black_women_advanced_degree - black_women_less_than_hs)/black_women_less_than_hs * 100, 1) AS `How much more black women w/ advanced degrees make compared to black women w/o highschool ed in %`,
    ROUND(hispanic_women_advanced_degree - hispanic_women_less_than_hs, 2) AS `Wage gap between hispanic women w/ advanced degrees and hispamic women w/o a highschool ed`,
    ROUND((hispanic_women_advanced_degree - hispanic_women_less_than_hs)/hispanic_women_less_than_hs * 100, 1) AS `How much more hispanic women w/ advanced degrees make compared to hispanic women w/o highschool ed in %`,
    -- Wage gaps of men without highschool educations between ethnicities
    ROUND(white_men_less_than_hs - black_men_less_than_hs, 2) AS `Wage gap between white men w/o a highschool ed and black men w/o a highschool ed`,
    ROUND((white_men_less_than_hs - black_men_less_than_hs)/black_men_less_than_hs * 100, 1) AS `How much more/less white men w/o highschool ed make than black men w/o highschool ed in %`,
    ROUND(white_men_less_than_hs - hispanic_men_less_than_hs, 2) AS `Wage gap between black men w/o a highschool ed and black men w/o a highschool ed`,
    ROUND((white_men_less_than_hs - hispanic_men_less_than_hs)/hispanic_men_less_than_hs * 100, 1) AS `How much more/less white men w/o highschool ed make compared to hispanic men w/o highschool ed in %`,
    ROUND(hispanic_men_less_than_hs - black_men_less_than_hs, 2) AS `Wage gap between hispanic men w/o a highschool ed and hispamic men w/o a highschool ed`,
    ROUND((hispanic_men_less_than_hs - black_men_less_than_hs)/black_men_less_than_hs * 100, 1) AS `How much more/less hispanic men w/o highschool ed make compared to black men w/o highschool ed in %`,
    -- Wage gaps of women without highschool educations between ethnicities
    ROUND(white_women_less_than_hs - black_women_less_than_hs, 2) AS `Wage gap between white women w/ advanced degrees and black women w/ advanced degrees`,
    ROUND((white_women_less_than_hs - black_women_less_than_hs)/black_women_less_than_hs * 100, 1) AS `How much more/less white women w/o highschool ed make compared to black women w/o highschool ed in %`,
    ROUND(white_women_less_than_hs - hispanic_women_less_than_hs, 2) AS `Wage gap between black women w/ advanced degrees and black women w/ advanced degrees`,
    ROUND((white_women_less_than_hs - hispanic_women_less_than_hs)/hispanic_women_less_than_hs * 100, 1) AS `How much more/less white women w/o highschool ed make compared to hispanic women w/o highschool ed in %`,
    ROUND(hispanic_women_less_than_hs - black_women_less_than_hs, 2) AS `Wage gap between hispanic women w/ advanced degrees and hispamic women w/ advanced degrees`,
    ROUND((hispanic_women_less_than_hs - black_women_less_than_hs)/black_women_less_than_hs * 100, 1) AS `How much more/less hispanic women w/o highschool ed make compared to black women w/o highschool ed in %`,
    -- Wage gaps of men with advanced degrees between ethnicities
    ROUND(white_men_advanced_degree - black_men_advanced_degree, 2) AS `Wage gap between white men w/ advanced degrees and black men w/ advanced degrees`,
    ROUND((white_men_advanced_degree - black_men_advanced_degree)/black_men_advanced_degree * 100, 1) AS `How much more/less white men w/ advanced degrees make compared to black men w/ advanced degrees in %`,
    ROUND(white_men_advanced_degree - hispanic_men_advanced_degree, 2) AS `Wage gap between black men w/ advanced degrees and black men w/ advanced degrees`,
    ROUND((white_men_advanced_degree - hispanic_men_advanced_degree)/hispanic_men_advanced_degree * 100, 1) AS `How much more/less white men w/ advanced degrees make compared to hispanic men w/ advanced degrees in %`,
    ROUND(hispanic_men_advanced_degree - black_men_advanced_degree, 2) AS `Wage gap between hispanic men w/ advanced degrees and hispamic men w/ advanced degrees`,
    ROUND((hispanic_men_advanced_degree - black_men_advanced_degree)/black_men_advanced_degree * 100, 1) AS `How much more/less hispanic men w/ advanced degrees make compared to black men w/ advanced degrees in %`,
	-- Wage gaps of women with advanced degrees between ethnicities
    ROUND(white_women_advanced_degree - black_women_advanced_degree, 2) AS `Wage gap between white women w/o a highschool ed and black women w/o a highschool ed`,
    ROUND((white_women_advanced_degree - black_women_advanced_degree)/black_women_advanced_degree * 100, 1) AS `How much more/less white women w/ advanced degrees make compared to black women w/ advanced degrees in %`,
    ROUND(white_women_advanced_degree - hispanic_women_advanced_degree, 2) AS `Wage gap between black women w/ advanced degrees and black women w/o a highschool ed`,
    ROUND((white_women_advanced_degree - hispanic_women_advanced_degree)/hispanic_women_advanced_degree * 100, 1) AS `How much more/less white women w/ advanced degrees make compared to hispanic women w/ advanced degrees in %`,
    ROUND(hispanic_women_advanced_degree - black_women_advanced_degree, 2) AS `Wage gap between hispanic women w/ advanced degrees and hispamic women w/o a highschool ed`,
    ROUND((hispanic_women_advanced_degree - black_women_advanced_degree)/black_women_advanced_degree * 100, 1) AS `How much more/less hispanic women w/ advanced degrees make compared to black women w/ advanced degrees in %`,
    -- Wage gaps between men and women without highschool educations, by ethnicity
    ROUND(white_men_less_than_hs - white_women_less_than_hs, 2) AS `Wage gap between white men and women w/o higschool ed`,
    ROUND((white_men_less_than_hs - white_women_less_than_hs)/white_women_less_than_hs * 100, 1) AS `How much more/less white men w/o highschool ed make compared to white women w/o highschool ed in %`,
    ROUND(black_men_less_than_hs - black_women_less_than_hs, 2) AS `Wage gap between black men and women w/o higschool ed`,
    ROUND((black_men_less_than_hs - black_women_less_than_hs)/black_women_less_than_hs * 100, 1) AS `How much more/less black men w/o highschool ed make compared to black women w/o highschool ed in %`,
    ROUND(hispanic_men_less_than_hs - hispanic_women_less_than_hs, 2) AS `Wage gap between white men and women w/o higschool ed`,
    ROUND((hispanic_men_less_than_hs - hispanic_women_less_than_hs)/hispanic_women_less_than_hs * 100, 1) AS `How much more/less hispanic men w/o highschool ed make compared to hispanic women w/o highschool ed in %`,
    -- Wage gaps between men and women with advanced degrees, by ethnicity
    ROUND(white_men_advanced_degree - white_women_advanced_degree, 2) AS `Wage gap between white men and women w/ advanced degrees`,
    ROUND((white_men_advanced_degree - white_women_advanced_degree)/white_women_advanced_degree * 100, 1) AS `How much more/less white men w/ advanced degrees make compared to white women w/ advanced degrees in %`,
    ROUND(black_men_advanced_degree - black_women_advanced_degree, 2) AS `Wage gap between black men and women w/ advanced degrees`,
    ROUND((black_men_advanced_degree - black_women_advanced_degree)/black_women_advanced_degree * 100, 1) AS `How much more/less black men w/ advanced degrees make compared to black women w/ advanced degrees in %`,
    ROUND(hispanic_men_advanced_degree - hispanic_women_advanced_degree, 2) AS `Wage gap between white men and women w/ advanced degrees`,
    ROUND((hispanic_men_advanced_degree - hispanic_women_advanced_degree)/hispanic_women_advanced_degree * 100, 1) AS `How much more/less hispanic men w/ advanced degrees make compared to hispanic women w/ advanced degrees in %`,
	-- Wage gaps between ethnicities for men without highschool educations
    ROUND(white_men_less_than_hs - black_men_less_than_hs, 2) AS `Wage gap between white and black men w/o highschool ed`,
    ROUND((white_men_less_than_hs - black_men_less_than_hs)/black_men_less_than_hs * 100, 1) AS `How much more/less white men w/o highschool ed make compared to black men w/o highscchool ed in %`,
    ROUND(white_men_less_than_hs - hispanic_men_less_than_hs, 2) AS `Wage gap between white and hispanic men w/o highschool ed`,
    ROUND((white_men_less_than_hs - hispanic_men_less_than_hs)/hispanic_men_less_than_hs * 100, 1) AS `How much more/less white men w/o highschool ed make compared to hispanic men w/o highscchool ed in %`,
    ROUND(hispanic_men_less_than_hs - black_men_less_than_hs, 2) AS `Wage gap between hispanic and black men w/o highschool ed`,
    ROUND((hispanic_men_less_than_hs - black_men_less_than_hs)/black_men_less_than_hs * 100, 1) AS `How much more/less hispanic men w/o highschool ed make compared to black men w/o highscchool ed in %`,
    -- Wage gaps between ethnicities for women without highschool educations
    ROUND(white_women_less_than_hs - black_women_less_than_hs, 2) AS `Wage gap between white and black women w/o highschool ed`,
    ROUND((white_women_less_than_hs - black_women_less_than_hs)/black_women_less_than_hs * 100, 1) AS `How much more/less white women w/o highschool ed make compared to black women w/o highscchool ed in %`,
    ROUND(white_women_less_than_hs - hispanic_women_less_than_hs, 2) AS `Wage gap between white and hispanic women w/o highschool ed`,
    ROUND((white_women_less_than_hs - hispanic_women_less_than_hs)/hispanic_women_less_than_hs * 100, 1) AS `How much more/less white women w/o highschool ed make compared to hispanic women w/o highscchool ed in %`,
    ROUND(hispanic_women_less_than_hs - black_women_less_than_hs, 2) AS `Wage gap between hispanic and black women w/o highschool ed`,
    ROUND((hispanic_women_less_than_hs - black_women_less_than_hs)/black_women_less_than_hs * 100, 1) AS `How much more/less hispanic women w/o highschool ed make compared to black women w/o highscchool ed in %`,
	-- Wage gaps between ethnicities for men with advanced degrees
    ROUND(white_men_advanced_degree - black_men_advanced_degree, 2) AS `Wage gap between white and black men w/ advanced degrees`,
    ROUND((white_men_advanced_degree - black_men_advanced_degree)/black_men_advanced_degree * 100, 1) AS `How much more/less white men w/ advanced degrees make compared to black men w/ advanced degrees in %`,
    ROUND(white_men_advanced_degree - hispanic_men_advanced_degree, 2) AS `Wage gap between white and hispanic men w/ advanced degrees`,
    ROUND((white_men_advanced_degree - hispanic_men_advanced_degree)/hispanic_men_advanced_degree * 100, 1) AS `How much more/less white men w/ advanced degrees make compared to hispanic men w/ advanced degrees in %`,
    ROUND(hispanic_men_advanced_degree - black_men_advanced_degree, 2) AS `Wage gap between hispanic and black men w/ advanced degrees`,
    ROUND((hispanic_men_advanced_degree - black_men_advanced_degree)/black_men_advanced_degree * 100, 1) AS `How much more/less hispanic men w/ advanced degrees make compared to black men w/ advanced degrees in %`,
	-- Wage gaps between ethnicities for women with advanced degrees
    ROUND(white_women_advanced_degree - black_women_advanced_degree, 2) AS `Wage gap between white and black women w/ advanced degrees`,
    ROUND((white_women_advanced_degree - black_women_advanced_degree)/black_women_advanced_degree * 100, 1) AS `How much more/less white women w/ advanced degrees make compared to black women w/ advanced degrees in %`,
    ROUND(white_women_advanced_degree - hispanic_women_advanced_degree, 2) AS `Wage gap between white and hispanic women w/ advanced degrees`,
    ROUND((white_women_advanced_degree - hispanic_women_advanced_degree)/hispanic_women_advanced_degree * 100, 1) AS `How much more/less white women w/ advanced degrees make compared to hispanic women w/ advanced degrees in %`,
    ROUND(hispanic_women_advanced_degree - black_women_advanced_degree, 2) AS `Wage gap between hispanic and black women w/ advanced degrees`,
    ROUND((hispanic_women_advanced_degree - black_women_advanced_degree)/black_women_advanced_degree * 100, 1) AS `How much more/less hispanic women w/ advanced degrees make compared to black women w/ advanced degrees in %`
FROM wages_by_education
WHERE year = 1973 OR year = 2022;
