# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

david = User.create! email: 'michelle@lumastic.com',
                     display_name: 'Michelle Lovering',
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

student = User.create! email: 'student@lumastic.com',
                       display_name: 'Student',
                       password: 'This is my password',
                       role: Roleable::ROLE_STUDENT

lumastic = Community.create! name: "Lumastic Community",
                             description: "This community is meant to be a communication channel between the Lumastic team and the greater Lumastic community.  This is your space to give us feedback, ask us questions, and stay in the loop about our progress on updates and new features."


curators = Community.create! name: "Curator Community",
                             description: "This community is meant to be a support network for curators of communities.  This is your space to recommend practices, share ideas, and ask for help from people who also have this awesome responsibility."

getting_started_course = Course.create! title: "Getting Started",
               course_info: "Wondering how to get started on Lumastic? Josh has you covered!  In these lessons, he'll walk you through everything you need to know about the platform.",
               keywords: "Lumastic, Getting Started",
               open: true,
               community: lumastic,
               user: josh

lesson_1 = Lesson.create! title: "Getting Started with Josh",
                          video_url: "https://youtu.be/TMJedxEaSEw",
                          lesson_info: "A little introduction from Josh!",
                          keywords: "Getting Started",
                          position: 1,
                          likes: 1,
                          dislikes: 0,
                          user: josh,
                          course: getting_started_course

lesson_2 = Lesson.create! title: "What is a community?",
                          video_url: "https://youtu.be/9Clu72jc0vk",
                          lesson_info: "The community is the core of Lumastic.  Communities are made up of people who share the same interest and passion.  Members of communities teach, learn, and grow together.  They encourage each other to go farther and achieve their dreams.",
                          keywords: "Community, Lumastic",
                          position: 2,
                          likes: 1,
                          dislikes: 0,
                          user: josh,
                          course: getting_started_course

lesson_3 = Lesson.create! title: "What is a course?",
                          video_url: "https://youtu.be/lmp-IfnrIoE",
                          lesson_info: "A course is a collection of lessons centered around a certain topic - obviously.  However, on Lumamstic, it's important to note that courses can be open or closed.  Open courses allow anyone in the community to add lessons.",
                          keywords: "Courses",
                          position: 3,
                          likes: 1,
                          dislikes: 0,
                          user: josh,
                          course: getting_started_course

lesson_4 = Lesson.create! title: "What is a lesson?",
                          video_url: "https://youtu.be/1Y6qRkHsJTE",
                          lesson_info: "A lesson is your time to shine! Hit record on anything that takes video and make it happen!  Do not worry about production quality or being self conscience.  If you're into it, I'm into it.  Share what you know!",
                          keywords: "Courses",
                          position: 4,
                          likes: 1,
                          dislikes: 0,
                          user: josh,
                          course: getting_started_course

lesson_5 = Lesson.create! title: "What is a discussion?",
                          video_url: "https://youtu.be/NhVIxBD8enY",
                          lesson_info: "A discussion is a forum for you to ask questions and foster productive discourse with peers in your community.",
                          keywords: "Discussions",
                          position: 5,
                          likes: 1,
                          dislikes: 0,
                          user: josh,
                          course: getting_started_course

lesson_6 = Lesson.create! title: "Words of Encouragement",
                          video_url: "https://youtu.be/oUT7DbZR5xI",
                          lesson_info: "At Lumastic, we want you to share everything you know with others.  We don't care what package that comes in, and neither will your fellow community members.  It's about growing together.  That's it.",
                          keywords: "Encouragement",
                          position: 6,
                          likes: 1,
                          dislikes: 0,
                          user: josh,
                          course: getting_started_course