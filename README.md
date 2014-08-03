# JSON-API Roar test app

Test rails-api application which implements [JSON-API](http://jsonapi.org/format/)
spec using [Roar](https://github.com/apotonick/roar) gem.

## Setup

```
$ git clone https://github.com/vdmgolub/json_api_roar.git
$ cd json_api_roar
$ bundle
$ bin/rake db:migrate
$ bin/rake db:seed
$ bin/rails s
```

## Tests

```
$ bin/rake
```

## Endpoints

- `GET /posts`
- `GET /posts/:id`
- `GET /authors`
- `GET /authors/:id`
- `GET /authors/:author_id/posts`

## Notes:

- `GET /authors` is a basic JSON-API endpoint without any `links` and `linked` sections.
It's an easy one to implement using `Roar`, see [app/representers/authors_representer](app/representers/authors_representer.rb).

- The complexity starts to grow when `links` and compound `linked` objects need
to be returned. Implementation is here [app/representers/posts_representer](app/representers/posts_representer.rb).
Now we need to create a 'wrapper' resource object which will include target objects,
links and all related compound objects. Compound object should be collected from
all target objects and filtered from duplicates. See `PostExtendedRepresenter` where
`links` attribute is added with related author id.

- Boilerplate grows more when the same resource is returned from different endpoints like
`GET /posts` and `GET /authors/:author_id/posts`. When author's posts are returned
there is no need to include the author. Now `AuthorPostsRepresenter` is implemented.

- The result is that for one resource there are several representers according to
endpoint. Plus it is time consuming to iterate through all related objects to gather
them in `linked` section.
