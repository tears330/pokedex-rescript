module LoginFields = %lenses(
  type state = {
    username: string,
    password: string,
  }
)

module LoginForm = ReForm.Make(LoginFields)

@react.component
let make = () => {
  let (_, setUser, _) = Hooks.useUser()
  let form: LoginForm.api = LoginForm.use(
    ~validationStrategy=OnChange,
    ~initialState={
      username: "",
      password: "",
    },
    ~onSubmit=({state, send}) => {
      send(SetFormState(ReForm.Submitting))
      let _ = Js.Global.setTimeout(() => {
        if state.values.username === "admin" && state.values.password === "admin" {
          setUser(_ => Some({name: "123"}))
          RescriptReactRouter.push("/")
        } else {
          send(RaiseSubmitFailed(Some("Invalid username or password")))
        }
      }, 1000)
      None
    },
    ~schema={
      open LoginForm.Validation
      Schema([
        StringNonEmpty({
          field: LoginFields.Username,
          error: Some("Username is required"),
          meta: "",
        }),
        StringNonEmpty({
          field: LoginFields.Password,
          error: Some("Password is required"),
          meta: "",
        }),
      ])
    },
    (),
  )

  let inputClass = "bg-dark-300 lg:w-96 sm:w-64 text-dark-100 focus:text-white-900 py-4 px-5 rounded-md text-lg appearance-none  border border-dark-500 focus:outline-none transition-colors focus:border-primary"

  <div className="flex justify-center items-center w-screen h-screen bg-dark-900">
    <form
      className="flex flex-col p-16 bg-dark-500 rounded-lg space-y-5"
      onSubmit={e => {
        e->ReactEvent.Synthetic.preventDefault
        form.submit()
      }}>
      <input
        className={inputClass}
        type_="text"
        name="username"
        value={form.values.username}
        onChange={e =>
          form.handleChange(LoginFields.Username, (e->ReactEvent.Form.target)["value"])}
      />
      {switch LoginFields.Username->LoginForm.ReSchema.Field->form.getFieldError {
      | Some(errMsg) => <div className="mt-2 mb-2 text-sm text-[red]"> {errMsg->React.string} </div>
      | None => React.null
      }}
      <input
        className={inputClass}
        type_="text"
        name="password"
        value={form.values.password}
        onChange={e =>
          form.handleChange(LoginFields.Password, (e->ReactEvent.Form.target)["value"])}
      />
      {switch LoginFields.Password->LoginForm.ReSchema.Field->form.getFieldError {
      | Some(errMsg) => <div className="mt-2 mb-2 text-sm text-[red]"> {errMsg->React.string} </div>
      | None => React.null
      }}
      {switch form.formState {
      | SubmitFailed(errMsg) =>
        <div className="mt-2 mb-2 text-sm text-[red]">
          {errMsg->Belt.Option.getWithDefault("")->React.string}
        </div>
      | _ => React.null
      }}
      <Button loading={form.isSubmitting} theme={#primary} size={#lg} type_="submit">
        {"LOGIN"->React.string}
      </Button>
    </form>
  </div>
}
