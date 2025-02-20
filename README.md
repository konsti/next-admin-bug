# Minimal reproduction of next-admin bug

## Steps to reproduce

1. Clone the repository
2. Run `docker-compose up`
3. Open http://localhost:3000/admin
4. Try to open the "Send posts to subscribers" dialog

## Expected behavior

The dialog should open without errors.

## Actual behavior

The app crashes with the following error:

```
Error: Minified React error #130;

Element type is invalid: expected a string (for built-in components) or a class/function (for composite components) but got: null.
```


