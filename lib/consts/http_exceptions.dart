class HttpExceptions implements Exception {
  final String codeMessage;

  HttpExceptions(this.codeMessage);
  String get getnewsApiErrorMessage {
    if (codeMessage.contains("apiKeyDisabled")) {
      return "Your API key has been disabled.";
    } else if (codeMessage.contains("apiKeyExhausted")) {
      return "Your API key has no more requests available.";
    } else if (codeMessage.contains("apiKeyInvalid")) {
      return "Your API key hasn't been entered correctly. Double check it and try again.";
    } else if (codeMessage.contains("apiKeyMissing")) {
      return "Your API key is missing from the request. Append it to the request with one of these methods.";
    } else if (codeMessage.contains("parameterInvalid")) {
      return "You've included a parameter in your request which is currently not supported. Check the message property for more details.";
    } else if (codeMessage.contains("parametersMissing")) {
      return "Required parameters are missing from the request and it cannot be completed. Check the message property for more details.";
    } else if (codeMessage.contains("rateLimited")) {
      return "You have been rate limited. Back off for a while before trying the request again.";
    } else if (codeMessage.contains("sourcesTooMany")) {
      return "You have requested too many sources in a single request. Try splitting the request into 2 smaller requests.";
    } else if (codeMessage.contains("sourceDoesNotExist")) {
      return "You have requested a source which does not exist.";
    } else if (codeMessage.contains("unexpectedError")) {
      return "This shouldn't happen, and if it does then it's our fault, not yours. Try the request again shortly.";
    } else if (codeMessage.contains("200")) {
      return "The request was executed successfully.";
    } else if (codeMessage.contains("400")) {
      return "The request was unacceptable, often due to a missing or misconfigured parameter.";
    } else if (codeMessage.contains("401")) {
      return "Your API key was missing from the request, or wasn't correct.";
    } else if (codeMessage.contains("429 ")) {
      return "You made too many requests within a window of time and have been rate limited. Back off for a while.";
    } else if (codeMessage.contains("500")) {
      return "Something went wrong on our side.";
    }
    return "Something went wrong";
  }

// for showing the error details message
  @override
  String toString() {
    return getnewsApiErrorMessage;
  }

//for showing the error message
  // @override
  // String toString() {
  //   return codeMessage;
  // }
}
