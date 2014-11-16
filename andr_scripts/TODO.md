1.roboguice lib auto import and code injection

2. auto inspect missing "import lib.." and auto adding

3. delete some affecting symbol eg., <> . ()

4. auto inject "import lib..."

5. permission check script

6. check Androidmanifest.xml min, target version before updating project!

sed -e '/<activity/,/MAIN/!d' AndroidManifest.xml
