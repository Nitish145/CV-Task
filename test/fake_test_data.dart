const fakeLoginResponse = {
  "token": "test_token",
  "exp": "04-02-2021 00:00",
  "username": "Test User"
};

const fakeProjectsResponse = {
  "data": [
    {
      "id": "9",
      "type": "project",
      "attributes": {
        "name": "Simple LED",
        "project_access_type": "Public",
        "created_at": "2020-03-19T04:16:53.543Z",
        "updated_at": "2020-03-22T07:14:03.161Z",
        "image_preview": {
          "url":
              "/uploads/project/image_preview/9/preview_2020-03-19_09_46_53_%2B0530.jpeg"
        },
        "description": " <p>Hey there, Loving Circuitverse</p>",
        "view": 1,
        "tags": [
          {
            "id": 1,
            "name": "CV",
            "created_at": "2020-03-10T13:02:10.381Z",
            "updated_at": "2020-03-10T13:02:10.381Z"
          },
        ],
        "stars_count": 1
      },
      "relationships": {
        "author": {
          "data": {"id": "1", "type": "author"}
        }
      }
    },
    {
      "id": "12",
      "type": "project",
      "attributes": {
        "name": "Nitish Aggarwal/Test",
        "project_access_type": "Private",
        "created_at": "2020-03-28T04:14:34.683Z",
        "updated_at": "2020-03-28T05:07:05.530Z",
        "image_preview": {"url": "/img/default.png"},
        "description": null,
        "view": 4,
        "tags": [
          {
            "id": 1,
            "name": "CV",
            "created_at": "2020-03-10T13:02:10.381Z",
            "updated_at": "2020-03-10T13:02:10.381Z"
          },
        ],
        "stars_count": 1
      },
      "relationships": {
        "author": {
          "data": {"id": "1", "type": "author"}
        }
      }
    },
    {
      "id": "10",
      "type": "project",
      "attributes": {
        "name": "Test 3",
        "project_access_type": "Public",
        "created_at": "2020-03-21T18:55:54.528Z",
        "updated_at": "2020-03-28T04:51:21.479Z",
        "image_preview": {
          "url":
              "/uploads/project/image_preview/10/preview_2020-03-22_00_25_54_%2B0530.jpeg"
        },
        "description": "",
        "view": 2,
        "tags": [
          {
            "id": 1,
            "name": "CV",
            "created_at": "2020-03-10T13:02:10.381Z",
            "updated_at": "2020-03-10T13:02:10.381Z"
          },
        ],
        "stars_count": 1
      },
      "relationships": {
        "author": {
          "data": {"id": "1", "type": "author"}
        }
      }
    }
  ],
  "included": [
    {
      "id": "1",
      "type": "author",
      "attributes": {"name": "Nitish", "email": "naggarwal@me.iitr.ac.in"},
      "relationships": {
        "projects": {
          "data": [
            {"id": "9", "type": "project"},
            {"id": "12", "type": "project"},
            {"id": "10", "type": "project"},
            {"id": "11", "type": "project"}
          ]
        }
      }
    }
  ],
  "meta": {
    "current_page": 1,
    "next_page": 2,
    "prev_page": null,
    "total_pages": 2,
    "total_count": 4
  }
};

const fakeUserResponse = {
  "data": {
    "id": "1",
    "type": "user",
    "attributes": {
      "id": 1,
      "email": "test@test.com",
      "name": "test",
      "admin": true,
      "country": "IN",
      "educational_institute": "Indian Institute of Technology Roorkee",
      "subscribed": false,
      "created_at": "2020-02-04T21:27:07.041Z",
      "updated_at": "2020-03-30T15:07:22.487Z"
    }
  }
};

const fakeProjectDetailsResponse = {
  "data": {
    "id": "8",
    "type": "project",
    "attributes": {
      "name": "Test Title",
      "project_access_type": "Public",
      "created_at": "2020-03-18T17:26:26.312Z",
      "updated_at": "2020-03-18T17:26:26.312Z",
      "image_preview": {"url": "/img/default.png"},
      "description": null,
      "view": 1,
      "tags": [
        {
          "id": 1,
          "name": "CV",
          "created_at": "2020-03-10T13:02:10.381Z",
          "updated_at": "2020-03-10T13:02:10.381Z"
        },
      ],
      "stars_count": 0
    },
    "relationships": {
      "author": {
        "data": {"id": "3", "type": "author"}
      }
    }
  },
  "included": [
    {
      "id": "3",
      "type": "author",
      "attributes": {"name": "Test User", "email": "test@test.com"},
      "relationships": {
        "projects": {
          "data": [
            {"id": "8", "type": "project"}
          ]
        }
      }
    }
  ]
};
