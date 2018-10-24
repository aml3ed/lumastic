# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

david = User.create! email: 'david@lumastic.com',
                     display_name: 'David Clark',
                     password: 'This is my password',
                     role: Roleable::ROLE_ADMIN

drew = User.create! email: 'drew@lumastic.com',
                    display_name: 'Drew Lytle',
                     password: 'This is my password',
                     role: Roleable::ROLE_ADMIN

josh = User.create! email: 'josh@lumastic.com',
                    display_name: 'Joshua Stuart',
                    password: 'This is my password',
                    role: Roleable::ROLE_ADMIN

lumastic = Community.create! name: "Lumastic Community",
                              description: "This community is meant to be a communication channel between the Lumastic team and the greater Lumastic community.  This is your space to give us feedback, ask us questions, and stay in the loop about our progress on updates and new features."

webdesign = Community.create! name: "Web Design",
                              description: "This is a community for people who love web design"

cooking = Community.create! name: "cooking",
                            description: "This is a community for people who love cooking"

student = User.create! email: 'student@lumastic.com',
                       display_name: 'Student',
                       password: 'password',
                       role: Roleable::ROLE_STUDENT

course1 = Course.create! title: "How to make a website",
               course_info: "This is a course on how to make a website.  We hope that this is helps you!",
               keywords: "Web Developement, Engineering, Computer Science, Art, Design, HTML, CSS",
               published: "true",
               community: webdesign,
               user: david

lesson_1 = Lesson.create! title: "Start without a plan",
                          video_url: "https://www.youtube.com/watch?v=2gUtfBmw86Y&frags=pl%2Cwn",
                          lesson_info: "When building a website, the best thing to do is not plan it.",
                          in_red: 10,
                          in_blue: 5,
                          in_green: 3,
                          out_red: 3,
                          out_blue: 5,
                          out_green: 10,
                          keywords: "Do, Not, Plan, Anything",
                          position: 1,
                          user: david,
                          course: course1

lesson_2 = Lesson.create! title: "HTML Basics",
                          video_url: "https://www.youtube.com/watch?v=qDrsUcg0bx4&frags=pl%2Cwn",
                          lesson_info: "Let's get down to basics and learn some HTML!",
                          in_red: 0,
                          in_blue: 10,
                          in_green: 30,
                          out_red: 15,
                          out_blue: 14,
                          out_green: 2,
                          keywords: "HTML, Web Developement",
                          position: 2,
                          user: david,
                          course: course1

lesson_3 = Lesson.create! title: "CSS Basics",
                          video_url: "https://www.youtube.com/watch?v=P34zTU8dWrU&frags=pl%2Cwn",
                          lesson_info: "Let's get down to basics and learn some HTML!",
                          in_red: 0,
                          in_blue: 10,
                          in_green: 30,
                          out_red: 15,
                          out_blue: 14,
                          out_green: 2,
                          keywords: "CSS, Web Developement",
                          position: 3,
                          user: david,
                          course: course1


course2 = Course.create! title: "Deep Dive into Fermented Foods",
               course_info: "This is a course on fermentation and fermented foods.  We hope that this is helps you!",
               keywords: "Food, Culture, Sauerkraut",
               published: "true",
               community: cooking,
               user: drew

lesson_4 = Lesson.create! title: "How to Make Mustard",
                          video_url: "https://www.youtube.com/watch?v=8ktONdU_wXU&t=2s&frags=pl%2Cwn",
                          lesson_info: "This is a video on how to make mustard!",
                          in_red: 10,
                          in_blue: 5,
                          in_green: 3,
                          out_red: 3,
                          out_blue: 5,
                          out_green: 10,
                          keywords: "Mustard",
                          position: 1,
                          user: drew,
                          course: course2

lesson_5 = Lesson.create! title: "How to Make Fermented Eggs",
                          video_url: "https://www.youtube.com/watch?v=8ktONdU_wXU&t=2s&frags=pl%2Cwn",
                          lesson_info: "This is a video on how to make fermented eggs!",
                          in_red: 0,
                          in_blue: 10,
                          in_green: 30,
                          out_red: 15,
                          out_blue: 14,
                          out_green: 2,
                          keywords: "Fermented, Eggs, Smell",
                          position: 2,
                          user: drew,
                          course: course2

lesson_5 = Lesson.create! title: "How to Make Sauerkraut",
                          video_url: "https://www.youtube.com/watch?v=snxb_PSe3Ps&frags=pl%2Cwn",
                          lesson_info: "This is a video on how to make sauerkraut!",
                          in_red: 0,
                          in_blue: 10,
                          in_green: 30,
                          out_red: 15,
                          out_blue: 14,
                          out_green: 2,
                          keywords: "Sauerkraut, Cooking, Fermentation",
                          position: 3,
                          user: drew,
                          course: course2
