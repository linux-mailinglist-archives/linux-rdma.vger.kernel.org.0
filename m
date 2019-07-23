Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50C5871FEE
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 21:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfGWTLd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 15:11:33 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:37979 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbfGWTLd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 15:11:33 -0400
Received: by mail-qt1-f171.google.com with SMTP id n11so42966688qtl.5
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 12:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WeLeHSW5IWfJdV5bVLUG5dsIV+T04rqjlm+2/mArvng=;
        b=MuPSKhOrMkztA/YpagsNpBrCe/s4lb+iTFuCrvx5UyM8Laq7Tp9c/o318Evt6+A7Ff
         raOdkq72dQkY6/po3SW/ENa4lv5YvEuheOf1bir5DAwXCojcS+7Zk7OG+lfcEkgqJ6c/
         f7w4JV9nqxQddCOk5UnxzJN0i3zUrfsJm19WkEfT0asOXJ3jrELCw+YxwQ9YiFruxO/W
         WMPeOnYXcVCfBhzsWLGlpvBGTjoDufvtbZdMfbveRbae6XVCM6jx6xkF06zBoy0Agkvp
         bVj7P6q6LZA5CEobxpDx45gaI3dDWHc86jjsvseNgSdk662U/4oIaKef+1nifin9r6Qr
         2BGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WeLeHSW5IWfJdV5bVLUG5dsIV+T04rqjlm+2/mArvng=;
        b=tho+XWi1zBfVZsK3EJpMcdneMEq6bEi7kNQ2cogy/700AJrBJ/SmnoIXy1Q5OHtWga
         21jyacq+bJDnFAsXK+7nCdt38Aa3OpHCh1Y/fjq1/ZyFdwNIKX94asNp5jrl+SpH0ZjF
         5p9X4LvvsZKiqDkZYIkpOjObYZxrhksEVClacOOH3Xl4lD3ywBZXExHM9g9jL1T325fN
         fBPaCen3sXyi6L6hHV/PcUd5HjmT+xXjNmU6QVMwdb0qxFsbZOL8iOJuNeSCgwtcgBPG
         KbanBMxqP+GPPpNqr8oO86wv4dlYTgFi9K2i+N/PY6KbthSIhFprKYj8c4GOUo1BPsez
         ufxg==
X-Gm-Message-State: APjAAAULzrfdZT+UttILXUrKTqH0t4fXndOaSVsvchydkaT7qec025ML
        99IoLo400XHGUYpyq9QyGXBOnyrD+luERg==
X-Google-Smtp-Source: APXvYqxDD0/iqTQXR/B4n/DKM1iygVKBoohZ3RWLcU3T4N0ZeSt9BmHmXUMV4nCO3sn0jFsJon+rYg==
X-Received: by 2002:ac8:2bd4:: with SMTP id n20mr55312288qtn.131.1563909091246;
        Tue, 23 Jul 2019 12:11:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r36sm23191245qte.71.2019.07.23.12.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 12:11:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hq02f-00045b-0L; Tue, 23 Jul 2019 16:01:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 19/19] build/azp: Have Azure Pipelines create releases when tags are made
Date:   Tue, 23 Jul 2019 16:01:37 -0300
Message-Id: <20190723190137.15370-20-jgg@ziepe.ca>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723190137.15370-1-jgg@ziepe.ca>
References: <20190723190137.15370-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Build a draft release and push the source .tar.gz to GitHub's releases
page.

For some reason this relies on an Azure Pipeline's user-specific service
connection instead of the existing app installation:

https://github.com/MicrosoftDocs/vsts-docs/issues/4260

This is done in a dedicated YAML file as it runs with a separate
configuration on AZP that authorizes it to use the write-access service
connections.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 .travis.yml                          | 17 ----------
 buildlib/azure-pipelines-release.yml | 48 ++++++++++++++++++++++++++++
 buildlib/github-release              |  7 ----
 3 files changed, 48 insertions(+), 24 deletions(-)
 create mode 100644 buildlib/azure-pipelines-release.yml
 delete mode 100755 buildlib/github-release

diff --git a/.travis.yml b/.travis.yml
index 82f16d65e0a646..e00b0165215b4d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -43,20 +43,3 @@ before_script:
   - http_proxy= pip3 install cython
 script:
   - buildlib/travis-build
-  - buildlib/github-release
-deploy:
-  # Deploy assets to Github releases
-  # https://docs.travis-ci.com/user/deployment/releases/
-  provider: releases
-  api_key:
-    # This is encrypted OAth token generated by
-    # Travis CLI tool (travis setup releases) limited to specific repo.
-    secure: ok/WMzFgsSnk+NZ850QEUESHRfJ4Ae7T8eA4dcx4fuw2RqybAh8wjxrLP5GKR27WrzB3hKHHTi7fgE0VtBY024kGJ/+wlQXHN1p89JvCiQlGOKkxy5YIlS4GUhwwkqgoU+hmifxl1i+9yCuowHPIM4WoP+NR+IZgvMahlrdPCS2OleFtrqyaHZbC/Usdt0WZLeQzG+rVLec/NvPnVOn81e17yuAuluHAzu+qcV94szqe/zwDzG8RUUKXaeDEQ3JQja4bCLL/kTkWR8JGsfwvcqc9Ut4Ry2b7uEWp5/FIcxUGWviKRgRzEdcT40iMMiJbIrH7gYp66Ymr/dypqUfc4u/xSb4AmpTMcYGUXJxsdzKyL6d/7HbuHIIVc5o1V/L5mdaIjeO5KjTFjMMD5KoSXfBlNIGk2as1JD/99lxJ3VlpQGwI5390+Tyl8o4Ao4aBXSCG96PDK4+UkYFht/wrw+UoYdV07u3x7zz21O3N3Lu5733hDvcvyOW6uIzoeLQ5O62/3Pq+DOFRs/nnRiW8/gjIkEQAyj/GGxw/taslpFJFcdVt/MSueV4t5OCI2YdGA/NxG/c4FIGy+dntV5BB6Gld8KkP/PP74yzJ1o/PRDRExTbsQzrdisDrVIf0r4pxTTsw1gXRE5r6S0tQ5aNoXAQ5h4xiwAIGqqBF4HESJjA=
-  file: rdma-core-*.tar.gz
-  # Allow asterisks in file names.
-  file_glob: true
-  skip_cleanup: true
-  # Limit scope of deploy to specific repo.
-  on:
-    repo: linux-rdma/rdma-core
-    tags: true
diff --git a/buildlib/azure-pipelines-release.yml b/buildlib/azure-pipelines-release.yml
new file mode 100644
index 00000000000000..fd5e4a1e43270d
--- /dev/null
+++ b/buildlib/azure-pipelines-release.yml
@@ -0,0 +1,48 @@
+# See https://aka.ms/yaml
+# This pipeline runs to produce GitHub releases when tags are pushed. The
+# pipeline is never run from a PR and has access to all the build secrets,
+# including write permission to GitHub.
+
+trigger:
+  tags:
+    include:
+      - v*
+
+resources:
+  containers:
+    - container: azp
+      image: ucfconsort.azurecr.io/rdma-core/azure_pipelines:25.0
+      endpoint: ucfconsort_registry
+
+stages:
+  - stage: Release
+    jobs:
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
+              CC=gcc-9 cmake -GNinja ..
+              ninja docs
+
+              cd ..
+              python3 buildlib/cbuild make-dist-tar build-pandoc
+            displayName: Prebuild Documentation
+
+          - task: GithubRelease@0
+            displayName: 'Create GitHub Release'
+            inputs:
+              githubConnection: github_release
+              repositoryName: linux-rdma/rdma-core
+              assets: ./*.tar.gz
+              action: create
+              isDraft: true
+              addChangeLog: true
diff --git a/buildlib/github-release b/buildlib/github-release
deleted file mode 100755
index 8fc536fb8b1074..00000000000000
--- a/buildlib/github-release
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/bash
-
-set -e
-
-if [[ $TRAVIS_TAG == v* ]] && [ "$TRAVIS_OS_NAME" = "linux" ]; then
-    buildlib/cbuild make-dist-tar --tag "$TRAVIS_TAG" build-travis
-fi
-- 
2.22.0

