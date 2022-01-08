# yo_quiz_app

A small project application in which the user can create private quizzes, share the code, add them to himself, delete them.

Table of Contents:
- [yo_quiz_app](#yo_quiz_app)
  - [Features](#features)
    - [Realized features](#realized-features)
    - [Unrealized other features](#unrealized-other-features)
  - [Screenshots](#screenshots)
  - [Configuration](#configuration)
    - [Configuration firebase](#configuration-firebase)
  - [Author](#author)
  - [License](#license)


## Features
### Realized features

Profile:
- [x] Show userProfile.
- [x] Upload and look user image.
- [x] Users tests: share, delete, edit, create.

Quiz create:
- [x] Create quiz: set title and description.
- [x] Create question: set text, answers.
- [x] Update quiz.
- [x] Update question.
- [x] Share quiz.

Quiz game:
- [x] Quiz main (description) screen.
- [x] Answer counter.
- [x] Screen question.
- [x] Screen results.

Home page:
- [x] Official tests in public screen. Set quiz public status only in firebase console.

Quiz create other:
- [x] Delete quiz.
- [x] Edit existed created quiz.
- [ ] Fix error A RenderFlex overflowed: when keyboard opened and navigator goes to create_questions_area_screen

### Unrealized other features 
Maybe i do it...

Quiz game:
- [ ] Previous result.
- [ ] Timer in question when user play game.

Other:
- [ ] Leaderboard.

Profile other:
- [ ] Contacts user.
- [ ] User scores.
- [ ] Shared tests.



## Screenshots

| Sign Up | Sign In | Home screen |
| - | - | - |
| ![1](./docs/app/1.png) | ![2](./docs/app/2.png) | ![3](./docs/app/3.png) |

| Public quizzes screens | Profile | Created quizzes by user |
| - | - | - |
| ![4](./docs/app/4.png) | ![5](./docs/app/5.png) | ![6](./docs/app/6.png) |

| Create quiz description screen | Create quiz description screen (indicator) | Created quizzes by user |
| - | - | - |
| ![7](./docs/app/7.png) | ![8](./docs/app/8.png) | ![9](./docs/app/9.png) |

| Quiz play games | Quiz play questions screen 1 | Quiz play questions screen 1 | Quiz play results |
| - | - | - | - |
| ![10](./docs/app/10.png) | ![11](./docs/app/11.png) | ![12](./docs/app/12.png) | ![13](./docs/app/13.png) |


## Configuration
I developed app with [flutterfire_cli](https://firebase.flutter.dev/docs/cli)

### Configuration firebase

| Authentication | Cloud Firestore Rules | Storage | 
| - | - | - |
| ![10](./docs/firebase/authentication.jpg) | ![11](./docs/firebase/cloud_firestore_rules.jpg) | ![12](./docs/firebase/storage.jpg) |

| Cloud firestore single field indexes 1 | Cloud firestore single field indexes 1 | 
| - | - |
| ![10](./docs/firebase/cloud_firestore_single_field_indexes_1.jpg) | ![11](./docs/firebase/cloud_firestore_single_field_indexes_2.jpg) |

## Author
Danil Shubin, 2022

## License
MIT


