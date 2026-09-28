# README

## September 1st, 2026.

This is a github repo dedicated to be my personal portfolio which will be a polygloth micro frontend.

A lot is missing now, a lot will be implemented later on, hopefully.

---

## Expected Track:

I have planned 7 milestones for this portfolio, 5 of which are related to different routes and projects coded on different programming languages that end up compiling some WASM or web code that is glued together via stencil.
The remaining milestones are related to setting up this frankenstein and the CI/CD I plan to use to deploy it to github pages.

---

## Current Progress:

- Milestone 1: Stencil setup has been successfully tackled and completed, wonder how long it will take me to do all this.

---

# Why do this?

Actually this is just some weird idea I got as inspiration from a talk at Digital Harbor by Jhona - one of their devs that commented on his experience as a dev on a talk from the JS Community in Bolivia, last year, 2025 - that was related to stencil js and how he used it with his team to glue different versions of js on a previous project.

Later last year I was in love with Haskell and during my search of some pdf books related to it for a compiler creation I found one mentioning yesod, the name was funny and the cover of the book was bettle, so checking it's content I discovered that Haskell could also be used to craft web pages.

I began thinkering how all this would come to be as I had it in mind and remember a talk from the GDG at Cochabamba/Bolivia that was related to how micro frontends worked together, then finally decided to craft it but got badly used to using AI due to my jobs.

So..., how do you avoid using AI to do something you want to do hastly but also want to learn? I decided to use AI as a guide instead, thinkered with gemini the basic architecture for the whole project, the best languages to be used from the ones I have been using in these last years and came up with a no code AI guide that could help me accelerate the debugging process while not hindering my learning journey.

I crafted all this before the end of august, and started to code on September 1st 2026, today is 00:23 of september 2nd and I can say the first milestone has been successfully completed, so..., I wonder how long it will take.

## All this will probably be moved to a post once the whole thing is finished, until then my README will be my writing canvas.

## September 27th, 2026.

## Current Progress:

- Milestone 2: CI/CD setup completely done, finally resolved Issue #1 too, took me longer than desired.

---

# How it is Going:

Well, I suffered quite a lot with a meager routing problem because I suddenly decided to have the github.io repository hold this Portfolio project as well as another more lightweight code as a landing page, having two different codebases running in tandem in a single github pages website.

In summary it goes like this, at https://fredantb.github.io the lightweight Astro page will be running and at https://fredantb.github.io/portfolio this portfolio project will running as well, this is a tandem work that I believed would be way more straightforward than it was had a way to easy solution.

None of this was really planned, but I could not leave the root route without content, so..., as both repositories made use of github actions workflows it would overwrite the src directory for our github pages, so I replaced the one from this repository by one that only installs deps and creates the build just to check it works. Then modified the one on the github.io repository in order to build that and this repository as steps of the deployment github workflow job then copy the contents of both into the corresponding directory and voila, we got a tandem deployment working surprisingly well, dunno how but it works.

Also, I am already working on the post so look out for that, I will also link it in the Astro project soon so I hope you like it.
