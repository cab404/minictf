import flask


a1 = flask.Flask("pwnme")

@a1.route('/calc/<name>')
def fitler(name):
    try:
        return f"of course it's {eval(name)}"
    except BaseException as e:
        return f"y calculate wrongly! {e}"

@a1.route('/')
def main_page():
    return '''
    Hello! this is my f1rst h4cker s3rver!
    <br />
    im a good server writer now, test my methods, they are legit!
    <br />
    <a href="/calc/1+1">this is my test calculator</a>
    '''
