Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07FFF71FCB
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 21:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391651AbfGWTBs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 15:01:48 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35325 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391637AbfGWTBs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 15:01:48 -0400
Received: by mail-qt1-f195.google.com with SMTP id d23so42974904qto.2
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 12:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XRdZj1Zvb8MX9SSm2nB0KIj52rEnPTFvLcvMpWBeU2I=;
        b=pUzrn1OMw3yQlb0HMThEKw5aYK21dXyIWwB26ns4BrUNeEDnd5jX2/coFZ4jA4ZmG2
         oTUU5E2F1EHx1/nxUjdoAS2D1coYmhjujgccyxQDlNCqkfaPCyf7iMvmduxAgJay3Sfm
         C338aKkdmGBxFRW3nOaDH4lN+xRNa2StLZffQDlpo/5vX8WiCl1Q0VOXsM+u1G8HIIQx
         wmNNsjHvrtPeB3fACELpJnv2HA1OBVDCBy1r2tXLVtTXo6mQEkiRj9KNcJmjXSFH5Dlc
         DeGlh39ni85d4ip8y8ar6fYtOWN2g/sGf51jsNJMypYiF9PX0yRBXquNv3o/9PKITT6M
         zQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRdZj1Zvb8MX9SSm2nB0KIj52rEnPTFvLcvMpWBeU2I=;
        b=bR1ivxEyfDANNqhR0jufYp56k9HSSizMwyoqoQ0g20S1aM+YRn5ykO9hlUA4N8BbCE
         8Ff0e65BMusa3O7d5usqnX0aZh705dTa7gE06ffy66djuLrjHm87VY5q6/bIedFzKCM/
         Zn+WHh2DGVFlhfKVqLRViGcT305pZ0oU35s3cBU6GFnVwTcsvs6rr7CLTOrVPBnDXBo+
         /WR26IWU8Lmt1qnheIqPkG5lIMRJzpC0jacZEKyA7Wvjsdps/kUDq5pHWG3vU/RyD15S
         3JB+5OyHVqURJeZMNax4xg6SGjETX8s1FBaccEAcEWb8XhhugQd4KsYv3kTbKhJ2dLIM
         k2AQ==
X-Gm-Message-State: APjAAAVzihfcO4MIhsPHxm/G6LWuvIbBGMeH5mV09cbCT3LKtQQwhiOh
        mWR1sFWRxZ3drzkEBSF5mWaXfLaOjLZvfQ==
X-Google-Smtp-Source: APXvYqwOc07k7WtyS1BkTmiypkjQTDtIyD9GPaLr3aQQrdE7eUVc0MEp+LHrUN7EF61nmpflOeJ19g==
X-Received: by 2002:ac8:689a:: with SMTP id m26mr54220249qtq.192.1563908506875;
        Tue, 23 Jul 2019 12:01:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 39sm24021537qts.41.2019.07.23.12.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 12:01:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hq02e-00044p-NX; Tue, 23 Jul 2019 16:01:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 11/19] build/azp: Run a test compile on ppc64el as well
Date:   Tue, 23 Jul 2019 16:01:29 -0300
Message-Id: <20190723190137.15370-12-jgg@ziepe.ca>
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

Now that we have bionic this is fairly simple to get a cross compile
environment, use the same approach as for ARM64.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 buildlib/azure-pipelines.yml |  8 ++++++++
 buildlib/cbuild              | 16 +++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/buildlib/azure-pipelines.yml b/buildlib/azure-pipelines.yml
index f6f71ac0adfa42..1d4e1f317bbe0f 100644
--- a/buildlib/azure-pipelines.yml
+++ b/buildlib/azure-pipelines.yml
@@ -90,6 +90,14 @@ stages:
               ninja
             displayName: gcc 8.3 ARM64 Compile
 
+          - bash: |
+              set -e
+              mkdir build-ppc64el
+              cd build-ppc64el
+              CC=powerpc64le-linux-gnu-gcc-8 CFLAGS="-Werror" cmake -GNinja .. -DIOCTL_MODE=both -DNO_PYVERBS=1
+              ninja
+            displayName: gcc 8.3 PPC64EL Compile
+
           # When running cmake through debian/rules it is hard to set -Werror,
           # instead force it on by changing the CMakeLists.txt
           - bash: |
diff --git a/buildlib/cbuild b/buildlib/cbuild
index 0be5d498bc1ae8..6e9a9cec9cd6cd 100755
--- a/buildlib/cbuild
+++ b/buildlib/cbuild
@@ -457,6 +457,15 @@ class azure_pipelines(bionic):
         "libnl-route-3-dev:arm64",
         "libsystemd-dev:arm64",
         "libudev-dev:arm64",
+    } | {
+        # PPC 64 cross compiler
+        "gcc-8-powerpc64le-linux-gnu",
+        "libgcc-8-dev:ppc64el",
+        "libc6-dev:ppc64el",
+        "libnl-3-dev:ppc64el",
+        "libnl-route-3-dev:ppc64el",
+        "libsystemd-dev:ppc64el",
+        "libudev-dev:ppc64el",
     }
     to_azp = True;
     name = "azure_pipelines";
@@ -471,12 +480,13 @@ class azure_pipelines(bionic):
                      "deb [arch=amd64] http://apt.llvm.org/bionic/ llvm-toolchain-bionic-8 main",
                      "15CF4D18AF4F7421");
         self.add_source_list(tmpdir,"arm64.list",
-                             """deb [arch=arm64] http://ports.ubuntu.com/ bionic main universe
-deb [arch=arm64] http://ports.ubuntu.com/ bionic-security main universe
-deb [arch=arm64] http://ports.ubuntu.com/ bionic-updates main universe""");
+                             """deb [arch=arm64,ppc64el] http://ports.ubuntu.com/ bionic main universe
+deb [arch=arm64,ppc64el] http://ports.ubuntu.com/ bionic-security main universe
+deb [arch=arm64,ppc64el] http://ports.ubuntu.com/ bionic-updates main universe""");
 
         res.lines.insert(1,"ADD etc/ /etc/");
         res.lines.insert(1,"RUN dpkg --add-architecture i386 &&"
+                         "dpkg --add-architecture ppc64el &&"
                          "dpkg --add-architecture arm64 &&"
                          "sed -i -e 's/^deb /deb [arch=amd64,i386] /g' /etc/apt/sources.list");
         return res;
-- 
2.22.0

