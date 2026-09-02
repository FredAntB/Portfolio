import { Component, h } from '@stencil/core';
import { createRouter, Route, match } from "stencil-router-v2";

const Router = createRouter()

@Component({
  tag: 'app-root',
  styleUrl: 'app-root.css',
  shadow: true,
})
export class AppRoot {
  render() {
    return (
      <div>
        <header>
            <h1 onClick={() => Router.push("/")}>
              Stencil App Starter
            </h1>
        </header>

        <main>
          <Router.Switch>
            <Route path="/">
              <app-home />
            </Route>
            <Route
              path={match("/profile/:name")}
              render={({ name }) => <app-profile name={name} />}
            />
            <Route path="/arcade">
              <app-arcade />
            </Route>
            <Route path="/systems">
              <app-systems />
            </Route>
            <Route path="/security">
              <app-security />
            </Route>
            <Route path="/web-heritage">
              <app-web-heritage />
            </Route>
            <Route path="/terminal-lab">
              <app-terminal-lab />
            </Route>
          </Router.Switch>
        </main>
      </div>
    );
  }
}
