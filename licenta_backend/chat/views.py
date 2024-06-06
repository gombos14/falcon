from django.http import HttpResponseNotAllowed, HttpResponseBadRequest, HttpResponse
from pgpt_python.client import PrivateGPTApi
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings


@csrf_exempt
def privategpt_response_view(request):
    if not request.method == 'POST':
        return HttpResponseNotAllowed('Method not allowed')

    q = request.POST.get('prompt')
    if not q:
        return HttpResponseBadRequest('Please provide prompt.')

    print(request.POST)

    client = PrivateGPTApi(base_url=settings.PRIVATE_GPT_URL, timeout=300.0)
    completion_args = {
        'prompt': q,
        'use_context': True
    }

    user_id = request.POST.get('user_id')
    if user_id:
        accept_docs = set()
        for doc in client.ingestion.list_ingested().data:
            print(doc)
            file_name = doc.doc_metadata.get('file_name')
            if file_name and file_name.split('_')[0] == user_id:
                accept_docs.add(doc.doc_id)

        if accept_docs:
            completion_args['context_filter'] = {'docs_ids': list(accept_docs)}

    print(completion_args)
    prompt_result = client.contextual_completions.prompt_completion(**completion_args)
    return HttpResponse(prompt_result.choices[0].message.content)
