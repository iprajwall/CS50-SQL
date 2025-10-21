CREATE INDEX idx_enrollments_student_id
ON enrollments(student_id);

CREATE INDEX id_enrollments_course_id
ON enrollments(course_id);

CREATE INDEX idx_satisfies_course_id
ON satisfies(course_id);

CREATE INDEX idx_requirement_id
ON satisfies(requirement_id);

CREATE INDEX idx_courses_semester
ON courses(semester);

CREATE INDEX idx_courses_title_semester
ON courses(title, semester);

CREATE INDEX semester_2023_2024
ON courses(semester)
WHERE semester IN ('Fall 2024', 'Spring 2024', 'Fall 2023');

CREATE INDEX courses_dept
ON courses(department);
