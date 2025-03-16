# swipe_callback
A simple flutter package to add swipe to reply functionality similar to that of Whatsapp.
<p>
  <img src="https://github.com/rohan031/swipe_callback/blob/main/example.gif?raw=true"
    alt="Swipe Callback plugin animated image" height="400"/>
</p>


## Features

Use this plugin in your Flutter app to:

* Allow performing action based on user swipe action.

## Example

```dart
SwipeCallback(
  swipeDirection: swipeDirection,
  onSwipeSuccess: () {
    showSnackBar("Swipe success triggered");
  },
  threshold: 150,
  child: SizedBox(
    width: double.infinity,
    child: FractionallySizedBox(
      widthFactor: 0.8,
      alignment: Alignment.centerLeft,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(sampleText.first),
        ),
      ),
    ),
  ),
)
```

## Parameter Info

* ``swipDirection``: to allow swipe in particular direction. Possible values are right(default) and left.
* ``onSwipeSuccess``: callback to run when swipe action is completed and valid.
* ``threshold``: determines how much the widget should be swiped to consider swipe to be valid.