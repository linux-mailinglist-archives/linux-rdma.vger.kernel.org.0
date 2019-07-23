Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8CB671FC9
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 21:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfGWTBq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 15:01:46 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:36011 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391640AbfGWTBq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 15:01:46 -0400
Received: by mail-qt1-f178.google.com with SMTP id z4so42982471qtc.3
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 12:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zAcLiIDtMqGzReNRQfmKQ9kFL9wK5rZw0K8FPf3Fba4=;
        b=ZxPmjB7Yv3yBVDYZ/xJkgRHwwgtScxV/+MwRJcH0BZEUh+gFlvuNba7dsXU/aWg+f5
         q569HCeXbtB0V68zuFymynUgpLXcu8uWlJCEJ/+TuBzke7yIL5PGDiQlsZHy8jVcccGp
         VAv28gG/UUPVso5nUDcsO2UkTAAJmjENkqa510KaGc6i3lQNAPNmpaIhksVhNxqjtMtF
         2PkhmOMgux7EUbYJeTeCKA3R8/LS2qfCRPAxj5OMH2KJ+KHa/IqfqOMWQ7pn05gGHTHM
         8mrpYnb7JKecOzsDxwsbmGYqGizbX1LUiIEq5xY2a9SVhZgboeqCZR5VIwB8TwKxuwNA
         N2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zAcLiIDtMqGzReNRQfmKQ9kFL9wK5rZw0K8FPf3Fba4=;
        b=XkJ8XBtISsN/6+4N3deH+Gz49u88rfEM7GiTuuNEJRS1Dmy9Mtt7/dQpV8wQMehkub
         FtWdV0ZjtAsZZTj668nLSUCcSTfoLHcVoDrU1eu93WfqPl7dXh5ihbJnhAL4skkOXhxE
         Fmqmd1UBhqtH7CgJi4bmfNXfhyXXW6VwgovevdkyNn3Y79AwlP6qjHNE2AptARW4fPN+
         bZ52SER9iJXq/V4pr2e/jiXLrrUV39Yj9Zx4Op4UlRurgpHtbtZ7vjvlf7Tceucg9z81
         AAFUI6z0w2OOa7+YWWFJ5cjB0thZ5Yg7saETV5cFPZn+jodehKpodyGDxdF1O2sQGWV2
         b1uw==
X-Gm-Message-State: APjAAAUEZjsU57e55eAzZLrbZxgME4g/hOSs/P7b0X2lo+SsFB9Vcthe
        0hgTwIx6GwLX7lM+hrIa4xtz4ckLFK2QnA==
X-Google-Smtp-Source: APXvYqw9UfFEP4Y97eiyMHktWPFMwCIBSSqBkkt9VvvXLejgne3Mo8cEx5BppFp18Ty1QymAALOSxQ==
X-Received: by 2002:ac8:1195:: with SMTP id d21mr19455787qtj.278.1563908505595;
        Tue, 23 Jul 2019 12:01:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s7sm19061254qtq.8.2019.07.23.12.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 12:01:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hq02e-00044j-MR; Tue, 23 Jul 2019 16:01:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 10/19] build/azp: Use clang 8.0 for building
Date:   Tue, 23 Jul 2019 16:01:28 -0300
Message-Id: <20190723190137.15370-11-jgg@ziepe.ca>
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

Latest release

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 buildlib/azure-pipelines.yml | 10 +++++-----
 buildlib/cbuild              |  5 ++++-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/buildlib/azure-pipelines.yml b/buildlib/azure-pipelines.yml
index f488bfe607c482..f6f71ac0adfa42 100644
--- a/buildlib/azure-pipelines.yml
+++ b/buildlib/azure-pipelines.yml
@@ -67,9 +67,9 @@ stages:
               set -e
               mkdir build-clang
               cd build-clang
-              CC=clang-7 CFLAGS="-Werror -m32 -msse3" cmake -GNinja .. -DIOCTL_MODE=both -DNO_PYVERBS=1
+              CC=clang-8 CFLAGS="-Werror -m32 -msse3" cmake -GNinja .. -DIOCTL_MODE=both -DNO_PYVERBS=1
               ninja
-            displayName: clang 7.0 32-bit Compile
+            displayName: clang 8.0 32-bit Compile
 
           - bash: |
               set -e
@@ -97,12 +97,12 @@ stages:
               echo 'set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Werror")' >> buildlib/RDMA_EnableCStd.cmake
               sed -i -e 's/-DCMAKE_BUILD_TYPE=Release/-DCMAKE_BUILD_TYPE=Debug/g' debian/rules
               sed -i -e 's/ninja \(.*\)-v/ninja \1/g' debian/rules
-              debian/rules CC=clang-7 build
-            displayName: clang 7.0 Bionic Build
+              debian/rules CC=clang-8 build
+            displayName: clang 8.0 Bionic Build
           - bash: |
               set -e
               fakeroot debian/rules binary
-            displayName: clang 7.0 Bionic .deb Build
+            displayName: clang 8.0 Bionic .deb Build
 
       - job: SrcPrep
         displayName: Build Source Tar
diff --git a/buildlib/cbuild b/buildlib/cbuild
index 34051e55c24e81..0be5d498bc1ae8 100755
--- a/buildlib/cbuild
+++ b/buildlib/cbuild
@@ -432,7 +432,7 @@ class azure_pipelines(bionic):
         "abi-compliance-checker",
         "abi-dumper",
         "ca-certificates",
-        "clang-7",
+        "clang-8",
         "fakeroot",
         "gcc-9",
         "git",
@@ -467,6 +467,9 @@ class azure_pipelines(bionic):
         self.add_ppa(tmpdir,
                      "deb http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu bionic main",
                      "60C317803A41BA51845E371A1E9377A2BA9EF27F");
+        self.add_ppa(tmpdir,
+                     "deb [arch=amd64] http://apt.llvm.org/bionic/ llvm-toolchain-bionic-8 main",
+                     "15CF4D18AF4F7421");
         self.add_source_list(tmpdir,"arm64.list",
                              """deb [arch=arm64] http://ports.ubuntu.com/ bionic main universe
 deb [arch=arm64] http://ports.ubuntu.com/ bionic-security main universe
-- 
2.22.0

