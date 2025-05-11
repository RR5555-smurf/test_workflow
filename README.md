# Test


## tox-uv parallel: Issue


Bump into concurrency issue on windows:
```bash
INTERNALERROR> Traceback (most recent call last):
INTERNALERROR>   File "D:\a\test_workflow\test_workflow\.tox\py311\Lib\site-packages\_pytest\main.py", line 283, in wrap_session
INTERNALERROR>     session.exitstatus = doit(config, session) or 0
INTERNALERROR>                          ^^^^^^^^^^^^^^^^^^^^^
INTERNALERROR>   File "D:\a\test_workflow\test_workflow\.tox\py311\Lib\site-packages\_pytest\main.py", line 337, in _main
INTERNALERROR>     config.hook.pytest_runtestloop(session=session)
INTERNALERROR>   File "D:\a\test_workflow\test_workflow\.tox\py311\Lib\site-packages\pluggy\_hooks.py", line 513, in __call__
INTERNALERROR>     return self._hookexec(self.name, self._hookimpls.copy(), kwargs, firstresult)
INTERNALERROR>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
INTERNALERROR>   File "D:\a\test_workflow\test_workflow\.tox\py311\Lib\site-packages\pluggy\_manager.py", line 120, in _hookexec
INTERNALERROR>     return self._inner_hookexec(hook_name, methods, kwargs, firstresult)
INTERNALERROR>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
INTERNALERROR>   File "D:\a\test_workflow\test_workflow\.tox\py311\Lib\site-packages\pluggy\_callers.py", line 156, in _multicall
INTERNALERROR>     teardown[0].send(outcome)
INTERNALERROR>   File "D:\a\test_workflow\test_workflow\.tox\py311\Lib\site-packages\pytest_cov\plugin.py", line 324, in pytest_runtestloop
INTERNALERROR>     self.cov_controller.finish()
INTERNALERROR>   File "D:\a\test_workflow\test_workflow\.tox\py311\Lib\site-packages\pytest_cov\engine.py", line 57, in ensure_topdir_wrapper
INTERNALERROR>     return meth(self, *args, **kwargs)
INTERNALERROR>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^
INTERNALERROR>   File "D:\a\test_workflow\test_workflow\.tox\py311\Lib\site-packages\pytest_cov\engine.py", line 320, in finish
INTERNALERROR>     self.cov.combine()
INTERNALERROR>   File "D:\a\test_workflow\test_workflow\.tox\py311\Lib\site-packages\coverage\control.py", line 864, in combine
INTERNALERROR>     combine_parallel_data(
INTERNALERROR>   File "D:\a\test_workflow\test_workflow\.tox\py311\Lib\site-packages\coverage\data.py", line 197, in combine_parallel_data
INTERNALERROR>     file_be_gone(f)
INTERNALERROR>   File "D:\a\test_workflow\test_workflow\.tox\py311\Lib\site-packages\coverage\misc.py", line 139, in file_be_gone
INTERNALERROR>     os.remove(path)
INTERNALERROR> PermissionError: [WinError 32] The process cannot access the file because it is being used by another process: 'D:\\a\\test_workflow\\test_workflow\\.coverage.fv-az844-194.7072.XcZFRRsx.c'
```


## Git conformity

Name:
```bash
# Set:
git config user.name "Mona Lisa"
# Check:
git config user.name
```
Email:
```bash
# Set:
git config user.email "YOUR_EMAIL"
# Check:
git config user.email
```

# PATs

|Secrets|PAT Name|Permissions|Summary|
|:---|:---|:---|:---|
|`GH_RELEASE_TOKEN`|`gh-release`|`Repository permissions`>`Contents`>`Access`>:`Read and write`|<ul><li>Read access to metadata</li><li>Read and Write access to code</li></ul>|
|`GH_ARTIFACT`|`gh-artifact`|`Repository permissions`>`Actions`>`Access`>:`Read-only`|<ul><li> Read access to actions and metadata</li></ul>|

To create the secrets:\
`Settings`>`Secrets and variables`>`Actions`>`Secrets`>`Repository secrets`>`New repository secret`

To create PATs:\
`Profile`>`Settings`>`Developer settings`>`Personnal access tokens`>`Fine-grained tokens`>`Generate new token`

> [!NOTE]
> Regarding `GH_ARTIFACT`: [Download Artifacts from other Workflow Runs or Repositories](https://github.com/actions/download-artifact?tab=readme-ov-file#download-artifacts-from-other-workflow-runs-or-repositories):
```yaml
steps:
- uses: actions/download-artifact@v4
  with:
    name: my-other-artifact
    github-token: ${{ secrets.GH_PAT }} # token with actions:read permissions on target repo
    repository: actions/toolkit
    run-id: 1234
```


> [!NOTE]
> [How to download artifact/release-asset in another workflow -- tylermilner's](https://stackoverflow.com/a/78400005)


