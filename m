Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47A7B25B12
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 02:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfEVAKU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 20:10:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35102 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfEVAKU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 20:10:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id a39so323211qtk.2
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 17:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=DgDSFdp/Y5/h7tcMJQKlW4O+syemYMzy8aJNypTjznU=;
        b=hgfzYIq7ONCUlK0+xZP1XPcWHPiaWtEq4MushRyWaU6DtYV1mLW46Phcg/HOZeWjBM
         jQwWXm0BLyxrx9aNNzsoFrHGTX9qgRMkJwl/ts5kiLQx5iHzCttLmy5PRVY0aGUGmNF/
         tkSNXpg9fPkmtbYbB9HrHrt/3K47I30b7P079/0qfaaMJI94qBOXAKbKWkHAjiDpayrU
         wVHG3bN9N8hkCMrFP1z0GjU1znXlomUnzxvuFvhExcB+78IbR846SuTplgXzMCQ4cC2V
         QyXFPzhAdzn6T9sro7iuwLgWoZAm3hdCGwnWJxbKqmHwX9BcYxVne06zDUK/ZyW++/+p
         bvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DgDSFdp/Y5/h7tcMJQKlW4O+syemYMzy8aJNypTjznU=;
        b=U9NZZORkkg+sI8nWavByQWYcDbUL58TmMOBJH6hWiV2E9lQtYcmUAm14yQqk/NeLhh
         nhFWK2ZrHo4AlXbDYADsRC0J3xfTki6iesCdifbiT5BIsoRDlRNqRFVnZCmMjdq53L6f
         VLVNaRjMogM/bnFQDmjeHfwYhp104cqbRB2iU2YFmE0TUt+hJ1Z3G2U322wsiOKaEJRv
         FtRnA9C4N6QIjSc1DqhE+oYHrrQ+QusiBRVZP81ECBCpp12dx6mz1fL8HLB1PCuLkhA0
         F/5EnzNVQJFRIu5hnSpL6zmJCZNRbzSXxWh43zYfaVmeKHFtmb7x2sZxblj/vMl1tWNy
         FYGA==
X-Gm-Message-State: APjAAAWIwi5W7YCpEItqYaXAfJeu9wydBOVp8S7VtsGYstIHSwdl2ru7
        /5B59mN26kZELxY8MLfQ7kB+76SwWwI=
X-Google-Smtp-Source: APXvYqyj2d7xFtoue0pOXjUxzRPu0o36Xl52J5r0T37eQ+LsmF96u8mZDJTQzhaGrjtY9HBn/ceu5A==
X-Received: by 2002:ac8:2f98:: with SMTP id l24mr37323674qta.78.1558483818273;
        Tue, 21 May 2019 17:10:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id r54sm10207399qtr.41.2019.05.21.17.10.17
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 17:10:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTEpl-0008Au-4f
        for linux-rdma@vger.kernel.org; Tue, 21 May 2019 21:10:17 -0300
Date:   Tue, 21 May 2019 21:10:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-core] build: Set up CI with Azure Pipelines
Message-ID: <20190522001017.GA27759@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Azure Pipelines is intended to replace travis as the CI for rdma-core.

Build times are much faster at around 5 mins (vs 23 mins for travis) and
because it is built on pre-built containers it should not suffer from the
same flakiness that travis historically has. We can now also scale up the
number of distros we are testing.

This commit replicates all the functionality of travis, except for the
automatic .tar.gz upload on release. That requires a more careful
security analysis first.

However AZP is setup to use a bionic based container, not the ancient
xenial stuff. This container uses the built in bionic arm64 and 32 bit
x86 cross compiler, including all the support libraries. This means it
can now cross build everything except for pyverbs.

The GitHub experience is similar with two notable differences:

1) PRs from non-team outside contributors will not run automatically.
   Someone on the github team has to trigger them with a '/azp run'
   comment. See azure-pipelines.md for why

2) Checkpatch warnings/errors now result in a green checkmark. Clicking
   through the check will show a count of errors/warnings and Azure's GUI
   will show an orange checkmark.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 buildlib/azp-checkpatch      |  72 +++++++++++++++
 buildlib/azure-pipelines.yml | 167 +++++++++++++++++++++++++++++++++++
 buildlib/cbuild              | 141 ++++++++++++++++++++++++++++-
 3 files changed, 379 insertions(+), 1 deletion(-)
 create mode 100755 buildlib/azp-checkpatch
 create mode 100644 buildlib/azure-pipelines.yml

I've been threatening to do this for some time, as travis's
limitations are finally too much to cope with

The UCF Consortium has donated their Azure Tenant and is funding the
Azure Container Registry instance to make this work. Like travis,
Azure Pipelines provides free build time to open source, but Azure has
more parallel VMs and I think the VMs are faster too.

I've set it up to run faster, so it is not quite 100% the same as
travis, but I feel the result is overall an improvement. I
particularly like the GUI log viewer and how it breaks things down and
actually points out where errors are.

I have this linked to my testing repo, if there are no objections I'll
set it up up on the main linux-rdma github sometime after the next
release comes out and we can start to try it out. It would run in
parallel with travis until we decide to turn off travis.

To see the experience here, is a sample PR:

https://github.com/jgunthorpe/rdma-plumbing/pull/2

And the resulting build log/report (click checks then 'View more
details on Azure Pipelines' to get here):

https://dev.azure.com/ucfconsort/rdma-core%20test/_build/results?buildId=48

After this is going I will revise the containers to again use latest
compilers, with gcc 9 and clang 8, and probably add FC30 and Centos6
to the matrix since that won't actually increase build time now..

Jason

diff --git a/buildlib/azp-checkpatch b/buildlib/azp-checkpatch
new file mode 100755
index 00000000000000..d7149a59af02e7
--- /dev/null
+++ b/buildlib/azp-checkpatch
@@ -0,0 +1,72 @@
+#!/usr/bin/env python3
+import subprocess
+import urllib.request
+import os
+import re
+import tempfile
+import collections
+import sys
+
+base = os.environ["SYSTEM_PULLREQUEST_TARGETBRANCH"]
+if not re.match("^[0-9a-fA-F]{40}$", base):
+    base = "refs/remotes/origin/" + base
+
+with tempfile.TemporaryDirectory() as dfn:
+    patches = subprocess.check_output(
+        [
+            "git", "format-patch",
+            "--output-directory", dfn,
+            os.environ["SYSTEM_PULLREQUEST_SOURCECOMMITID"], "^" + base
+        ],
+        universal_newlines=True).splitlines()
+    if len(patches) == 0:
+        sys.exit(0)
+
+    ckp = os.path.join(dfn, "checkpatch.pl")
+    urllib.request.urlretrieve(
+        "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/checkpatch.pl",
+        ckp)
+    urllib.request.urlretrieve(
+        "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/spelling.txt",
+        os.path.join(dfn, "spelling.txt"))
+    os.symlink(
+        os.path.join(os.getcwd(), "buildlib/const_structs.checkpatch"),
+        os.path.join(dfn, "const_structs.checkpatch"))
+    checkpatch = [
+        "perl", ckp, "--no-tree", "--ignore",
+        "PREFER_KERNEL_TYPES,FILE_PATH_CHANGES,EXECUTE_PERMISSIONS,USE_NEGATIVE_ERRNO,CONST_STRUCT",
+        "--emacs", "--mailback", "--quiet", "--no-summary"
+    ]
+
+    failed = False
+    for fn in patches:
+        proc = subprocess.run(
+            checkpatch + [os.path.basename(fn)],
+            cwd=dfn,
+            stdout=subprocess.PIPE,
+            universal_newlines=True,
+            stderr=subprocess.STDOUT)
+        if proc.returncode == 0:
+            assert (not proc.stdout)
+            continue
+        sys.stdout.write(proc.stdout)
+
+        failed = True
+        for g in re.finditer(
+                r"^\d+-.*:\d+: (\S+): (.*)(?:\n#(\d+): (?:FILE: (.*):(\d+):)?)?$",
+                proc.stdout,
+                flags=re.MULTILINE):
+            itms = {}
+            if g.group(1) == "WARNING":
+                itms["type"] = "warning"
+            else:
+                itms["type"] = "error"
+            if g.group(4):
+                itms["sourcepath"] = g.group(4)
+                itms["linenumber"] = g.group(5)
+            print("##vso[task.logissue %s]%s" % (";".join(
+                "%s=%s" % (k, v)
+                for k, v in sorted(itms.items())), g.group(2)))
+
+if failed:
+    print("##vso[task.complete result=SucceededWithIssues]]azp-checkpatch")
diff --git a/buildlib/azure-pipelines.yml b/buildlib/azure-pipelines.yml
new file mode 100644
index 00000000000000..eb371b76c80129
--- /dev/null
+++ b/buildlib/azure-pipelines.yml
@@ -0,0 +1,167 @@
+# See https://aka.ms/yaml
+
+trigger:
+  - master
+pr:
+  - master
+
+resources:
+  # Using ucfconsort_registry2 until this is activated in the agent:
+  #   https://github.com/microsoft/azure-pipelines-agent/commit/70b69d6303e18f07e28ead393faa5f1be7655e6f#diff-2615f6b0f8a85aa4eeca0740b5bac69f
+  #   https://developercommunity.visualstudio.com/content/problem/543727/using-containerized-services-in-build-pipeline-wit.html
+  containers:
+    - container: azp
+      image: ucfconsort.azurecr.io/rdma-core/azure_pipelines:latest
+      endpoint: ucfconsort_registry2
+    - container: centos7
+      image: ucfconsort.azurecr.io/rdma-core/centos7:latest
+      endpoint: ucfconsort_registry2
+    - container: leap
+      image: ucfconsort.azurecr.io/rdma-core/opensuse-15.0:latest
+      endpoint: ucfconsort_registry2
+
+stages:
+  - stage: Build
+    jobs:
+      - job: Compile
+        displayName: Compile Tests
+        pool:
+          vmImage: 'Ubuntu-16.04'
+        container: azp
+        steps:
+          - task: PythonScript@0
+            displayName: checkpatch
+            condition: eq(variables['Build.Reason'], 'PullRequest')
+            inputs:
+              scriptPath: buildlib/azp-checkpatch
+              pythonInterpreter: /usr/bin/python3
+
+          - bash: |
+              set -e
+              mkdir build-gcc8
+              cd build-gcc8
+              CC=gcc-8 CFLAGS="-Werror" cmake -GNinja .. -DIOCTL_MODE=both -DENABLE_STATIC=1
+              ninja
+            displayName: gcc 8.3 Compile
+
+          - bash: |
+              set -e
+              cd build-gcc8
+              python2.7 ../buildlib/check-build --src .. --cc gcc-8
+            displayName: Check Build Script
+
+          # Run sparse on the subdirectories which are sparse clean
+          - bash: |
+              set -e
+              mkdir build-sparse
+              mv CMakeLists.txt CMakeLists-orig.txt
+              grep -v "# NO SPARSE" CMakeLists-orig.txt > CMakeLists.txt
+              cd build-sparse
+              CC=cgcc CFLAGS="-Werror" cmake -GNinja .. -DIOCTL_MODE=both -DNO_PYVERBS=1
+              ninja | grep -v '^\[' | tee out
+              # sparse does not fail gcc on messages
+              if [ -s out ]; then
+                 false
+              fi
+              mv ../CMakeLists-orig.txt ../CMakeLists.txt
+            displayName: sparse Analysis
+
+          - bash: |
+              set -e
+              mkdir build-clang
+              cd build-clang
+              CC=clang-7 CFLAGS="-Werror -m32 -msse3" cmake -GNinja .. -DIOCTL_MODE=both -DNO_PYVERBS=1
+              ninja
+            displayName: clang 7.0 32-bit Compile
+
+          - bash: |
+              set -e
+              mv util/udma_barrier.h util/udma_barrier.h.old
+              echo "#error Fail" >> util/udma_barrier.h
+              cd build-gcc8
+              rm CMakeCache.txt
+              CC=gcc-8 CFLAGS="-Werror" cmake -GNinja .. -DIOCTL_MODE=both
+              ninja
+              mv ../util/udma_barrier.h.old ../util/udma_barrier.h
+            displayName: Simulate non-coherent DMA Platform Compile
+
+          - bash: |
+              set -e
+              mkdir build-arm64
+              cd build-arm64
+              CC=aarch64-linux-gnu-gcc-8 CFLAGS="-Werror" cmake -GNinja .. -DIOCTL_MODE=both -DNO_PYVERBS=1
+              ninja
+            displayName: gcc 8.3 ARM64 Compile
+
+          # When running cmake through debian/rules it is hard to set -Werror,
+          # instead force it on by changing the CMakeLists.txt
+          - bash: |
+              set -e
+              echo 'set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Werror")' >> buildlib/RDMA_EnableCStd.cmake
+              sed -i -e 's/-DCMAKE_BUILD_TYPE=Release/-DCMAKE_BUILD_TYPE=Debug/g' debian/rules
+              sed -i -e 's/ninja \(.*\)-v/ninja \1/g' debian/rules
+              debian/rules CC=clang-7 build
+            displayName: clang 7.0 Bionic Build
+          - bash: |
+              set -e
+              fakeroot debian/rules binary
+            displayName: clang 7.0 Bionic .deb Build
+
+      - job: SrcPrep
+        displayName: Build Source Tar
+        pool:
+          vmImage: 'Ubuntu-16.04'
+        container: azp
+        steps:
+          - checkout: self
+            fetchDepth: 1
+
+          - bash: |
+              set -e
+              mkdir build-pandoc artifacts
+              cd build-pandoc
+              CC=gcc-8 cmake -GNinja ..
+              ninja docs
+              cd ../artifacts
+              # FIXME: Check Build.SourceBranch for tag consistency
+              python2.7 ../buildlib/cbuild make-dist-tar ../build-pandoc
+            displayName: Prebuild Documentation
+
+          - task: PublishPipelineArtifact@0
+            inputs:
+              # Contains a rdma-core-XX.tar.gz file
+              artifactName: source_tar
+              targetPath: artifacts
+
+      - job: Distros
+        displayName: Test Build RPMs for
+        dependsOn: SrcPrep
+        pool:
+          vmImage: 'Ubuntu-16.04'
+        strategy:
+          matrix:
+            centos7:
+              CONTAINER: centos7
+              SPEC: redhat/rdma-core.spec
+              RPMBUILD_OPTS:
+            leap:
+              CONTAINER: leap
+              SPEC: suse/rdma-core.spec
+              RPMBUILD_OPTS: --without=curlmini
+        container: $[ variables['CONTAINER'] ]
+        steps:
+          - checkout: none
+
+          - task: DownloadPipelineArtifact@0
+            inputs:
+              artifactName: source_tar
+              targetPath: .
+
+          - bash: |
+              set -e
+              mkdir SOURCES tmp
+              tar --wildcards -xzf rdma-core*.tar.gz  */$(SPEC) --strip-components=2
+              RPM_SRC=$(rpmspec -P rdma-core.spec | awk '/^Source:/{split($0,a,"[ \t]+");print(a[2])}')
+              (cd SOURCES && ln -sf ../rdma-core*.tar.gz "$RPM_SRC")
+              rpmbuild --define '_tmppath '$(pwd)'/tmp' --define '_topdir '$(pwd) -bb rdma-core.spec $(RPMBUILD_OPTS)
+            displayName: Perform Package Build
diff --git a/buildlib/cbuild b/buildlib/cbuild
index 7b0b9a9de0ed44..ccf45e68962de9 100755
--- a/buildlib/cbuild
+++ b/buildlib/cbuild
@@ -79,7 +79,11 @@ class Environment(object):
     proxy = True;
     build_pyverbs = True;
 
+    to_azp = False;
+
     def image_name(self):
+        if self.to_azp:
+            return "ucfconsort.azurecr.io/%s/%s"%(project, self.name);
         return "build-%s/%s"%(project,self.name);
 
 # -------------------------------------------------------------------------
@@ -122,6 +126,7 @@ class centos7(YumEnvironment):
     build_pyverbs = False;
     specfile = "redhat/rdma-core.spec";
     python_cmd = "python";
+    to_azp = True;
 
 class centos7_epel(centos7):
     pkgs = (centos7.pkgs - {"cmake","make"}) | {
@@ -168,7 +173,7 @@ class APTEnvironment(Environment):
     build_python = True;
     def get_docker_file(self):
         res = DockerFile(self.docker_parent);
-        res.lines.append("RUN apt-get update && apt-get install -y --no-install-recommends %s && apt-get clean"%(
+        res.lines.append("RUN apt-get update && apt-get install -y --no-install-recommends %s && apt-get clean && rm -rf /usr/share/doc/ /usr/lib/debug"%(
             " ".join(sorted(self.pkgs))));
         return res;
 
@@ -356,6 +361,7 @@ class leap(ZypperEnvironment):
         'python3-devel',
     };
     rpmbuild_options = [ "--without=curlmini" ];
+    to_azp = True;
     name = "opensuse-15.0";
     aliases = {"leap"};
 
@@ -368,6 +374,51 @@ class tumbleweed(ZypperEnvironment):
 
 # -------------------------------------------------------------------------
 
+class azure_pipelines(bionic):
+    pkgs = bionic.pkgs | {
+        "abi-compliance-checker",
+        "abi-dumper",
+        "ca-certificates",
+        "clang-7",
+        "fakeroot",
+        "gcc-8",
+        "git",
+        "python2.7",
+        "sparse",
+    } | {
+        # 32 bit build support
+        "libgcc-8-dev:i386",
+        "libc6-dev:i386",
+        "libnl-3-dev:i386",
+        "libnl-route-3-dev:i386",
+        "libsystemd-dev:i386",
+        "libudev-dev:i386",
+    } | {
+        # ARM 64 cross compiler
+        "gcc-8-aarch64-linux-gnu",
+        "libgcc-8-dev:arm64",
+        "libc6-dev:arm64",
+        "libnl-3-dev:arm64",
+        "libnl-route-3-dev:arm64",
+        "libsystemd-dev:arm64",
+        "libudev-dev:arm64",
+    }
+    to_azp = True;
+    name = "azure_pipelines";
+    aliases = {"azp"}
+
+    def get_docker_file(self):
+        res = bionic.get_docker_file(self);
+        res.lines.insert(1,"RUN dpkg --add-architecture i386 &&"
+                         "dpkg --add-architecture arm64 &&"
+                         "sed -i -e 's/^deb /deb [arch=amd64,i386] /g' /etc/apt/sources.list &&"
+                         "echo 'deb [arch=arm64] http://ports.ubuntu.com/ bionic main universe\\n"
+                               "deb [arch=arm64] http://ports.ubuntu.com/ bionic-security main universe\\n"
+                               "deb [arch=arm64] http://ports.ubuntu.com/ bionic-updates main universe' > /etc/apt/sources.list.d/arm64.list");
+        return res;
+
+# -------------------------------------------------------------------------
+
 environments = [centos6(),
                 centos7(),
                 centos7_epel(),
@@ -380,6 +431,7 @@ environments = [centos6(),
                 leap(),
                 tumbleweed(),
                 debian_experimental(),
+                azure_pipelines(),
 ];
 
 class ToEnvActionPkg(argparse.Action):
@@ -751,6 +803,91 @@ def run_travis_build(args,env):
             raise;
         copy_abi_files(os.path.join(tmpdir, "src/ABI"));
 
+def run_azp_build(args,env):
+    import yaml
+    # Load the commands from the pipelines file
+    with open("buildlib/azure-pipelines.yml") as F:
+        azp = yaml.load(F);
+    for bst in azp["stages"]:
+        if bst["stage"] == "Build":
+            break;
+    else:
+        raise ValueError("No Build stage found");
+    for job in bst["jobs"]:
+        if job["job"] == "Compile":
+            break;
+    else:
+        raise ValueError("No Compile job found");
+
+    script = ["#!/bin/bash"]
+    workdir = "/__w/1"
+    srcdir = os.path.join(workdir,"s");
+    for I in job["steps"]:
+        script.append("echo ===================================");
+        script.append("echo %s"%(I["displayName"]));
+        script.append("cd %s"%(srcdir));
+        if "bash" in I:
+            script.append(I["bash"]);
+        elif I.get("task") == "PythonScript@0":
+            script.append("set -e");
+            script.append("%s %s"%(I["inputs"]["pythonInterpreter"],
+                                   I["inputs"]["scriptPath"]));
+        else:
+            raise ValueError("Unknown stanza %r"%(I));
+
+    with private_tmp(args) as tmpdir:
+        os.mkdir(os.path.join(tmpdir,"s"));
+        os.mkdir(os.path.join(tmpdir,"tmp"));
+
+        opwd = os.getcwd();
+        with inDirectory(os.path.join(tmpdir,"s")):
+            subprocess.check_call(["git",
+                                   "--git-dir",os.path.join(opwd,".git"),
+                                   "reset","--hard","HEAD"]);
+            subprocess.check_call(["git",
+                                   "--git-dir",os.path.join(opwd,".git"),
+                                   "fetch",
+                                   "--no-tags",
+                                   "https://github.com/linux-rdma/rdma-core.git","HEAD",
+                                   "master"]);
+            base = subprocess.check_output(["git",
+                                            "--git-dir",os.path.join(opwd,".git"),
+                                            "merge-base",
+                                            "HEAD","FETCH_HEAD"]).strip();
+
+        opts = [
+            "run",
+            "--read-only",
+            "--rm=true",
+            "-v","%s:%s"%(tmpdir, workdir),
+            "-w",srcdir,
+            "-u",str(os.getuid()),
+            "-e","SYSTEM_PULLREQUEST_SOURCECOMMITID=HEAD",
+            # azp puts the branch name 'master' here, we need to put a commit ID..
+            "-e","SYSTEM_PULLREQUEST_TARGETBRANCH=%s"%(base),
+            "-e","HOME=%s"%(workdir),
+            "-e","TMPDIR=%s"%(os.path.join(workdir,"tmp")),
+        ] + map_git_args(opwd,srcdir);
+
+        if args.run_shell:
+            opts.append("-ti");
+        opts.append(env.image_name());
+
+        with open(os.path.join(tmpdir,"go.sh"),"w") as F:
+            F.write("\n".join(script))
+
+        if args.run_shell:
+            opts.append("/bin/bash");
+        else:
+            opts.extend(["/bin/bash",os.path.join(workdir,"go.sh")]);
+
+        try:
+            docker_cmd(args,*opts);
+        except subprocess.CalledProcessError, e:
+            copy_abi_files(os.path.join(tmpdir, "s/ABI"));
+            raise;
+        copy_abi_files(os.path.join(tmpdir, "s/ABI"));
+
 def args_pkg(parser):
     parser.add_argument("ENV",action=ToEnvActionPkg,choices=env_choices_pkg());
     parser.add_argument("--run-shell",default=False,action="store_true",
@@ -766,6 +903,8 @@ def cmd_pkg(args):
     for env in args.ENV:
         if env.name == "travis":
             run_travis_build(args,env);
+        elif env.name == "azure_pipelines":
+            run_azp_build(args,env);
         elif getattr(env,"is_deb",False):
             run_deb_build(args,env);
         elif getattr(env,"is_rpm",False):
-- 
2.21.0

