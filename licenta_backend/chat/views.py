from django.http import HttpResponseNotAllowed, HttpResponseBadRequest, HttpResponse
from pgpt_python.client import PrivateGPTApi
from django.views.decorators.csrf import csrf_exempt


@csrf_exempt
def privategpt_response_view(request):
    if not request.method == 'POST':
        return HttpResponseNotAllowed('Method not allowed')

    q = request.POST.get('prompt')
    if not q:
        return HttpResponseBadRequest('Please provide prompt.')

    client = PrivateGPTApi(base_url="http://192.168.1.6:8001")
    prompt_result = client.contextual_completions.prompt_completion(prompt=q)
    return HttpResponse(prompt_result.choices[0].message.content)
