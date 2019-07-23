Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C821671FF2
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 21:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfGWTLh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 15:11:37 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44709 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbfGWTLg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 15:11:36 -0400
Received: by mail-qk1-f196.google.com with SMTP id d79so31900335qke.11
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 12:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aNRHRL2bXDOUvPbzZoPO7YQ0ir+RwwwIW65S09T0+nI=;
        b=W1aBQ5F7/Z6ol6vwdgDv1hBSQdaEy8iMd241PksDdWlfPpoG5Tyi4w7T08hixiD7ws
         maFMeYAp+J2VIb+yNwW+uJENe5LUDSypiPOmuKo/eKJFo5ynEGriiK3n4sJs3ehhJMoD
         I3n/DtcHX7VJL9M5p49P4IDUiKj/CPRfOisjw6AV3v8EfyDsf6qRoOM2DgdFyvXG77cu
         yUjJFvtjZXNMP6n2T1If0V6z+CyKfwe45XsGbkmpoNqAJ39NPEN9+nlO69UG4eaJB3jF
         tfRSbCzA2mVoik/p2zkRr2cPmXLP7QSuDVYqveRbHesWygAMV3VjjhvoHu60AD/7YGts
         uSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aNRHRL2bXDOUvPbzZoPO7YQ0ir+RwwwIW65S09T0+nI=;
        b=syH9MHFUpkrHtsWPdQSa5G7VEE4ExWPec+3+5Cyk+BLrOfNU1Nyg6hZZrrhrAv5YSP
         YFIzEuuyw5YZ924+cDkTz6DpU8C8l1IM1E0cB8b2mOUhaQPIY9kqDMHnEpVjkqc4oQQg
         A6AfiZRrFjVwFgB9c9+u82c8dN6KViebUgsXn550ZUixDm0/U3pNAWQtevCTOcLEGmxW
         KOOjPsIGZF/V/TefuWH5VFA+EVMlUaP+vCEqksUOnmvjNZnEFaVRohSABORePjZyhfh1
         3OMNc/g57x2NBlbUH8+fItC/OKpTlRgrv4xNQ1x5oUBdJbxLsaZEOvTeyINOnsgDOued
         S+bQ==
X-Gm-Message-State: APjAAAU9xTRDve1a7gGxnFzoHqHLPMgg5le2kJ/CGyo35PyuA0WdwCGM
        JZRWh9fBaVqA8vVSxRN0bO436Bi59dCpig==
X-Google-Smtp-Source: APXvYqzHdz6MQqTM+b+MQ9l7Bci4+619HIKtXCGvnYcXIDS35KIFVZIAdtZX9EU9Npg8Ln1SgR6AXQ==
X-Received: by 2002:a37:4ac3:: with SMTP id x186mr49440029qka.138.1563909095568;
        Tue, 23 Jul 2019 12:11:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z8sm19099189qki.23.2019.07.23.12.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 12:11:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hq02e-00045V-Va; Tue, 23 Jul 2019 16:01:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 18/19] build: Use the CMake variable -DENABLE_WERROR to turn on WERROR mode
Date:   Tue, 23 Jul 2019 16:01:36 -0300
Message-Id: <20190723190137.15370-19-jgg@ziepe.ca>
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

This way the flag can be passed through EXTRA_CMAKE_FLAGS to rpmbuild and
debian/rules instead of hacking it in via sed/etc.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 CMakeLists.txt               |  5 +++++
 buildlib/azure-pipelines.yml | 24 ++++++++++--------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index f9353ddbc86d1e..9bb58a9b803667 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -538,6 +538,11 @@ RDMA_DoFixup("${HAVE_STATIC_ASSERT}" "assert.h")
 RDMA_AddOptCFlag(CMAKE_C_FLAGS HAVE_C_WSTRICT_PROTOTYPES "-Wstrict-prototypes")
 RDMA_AddOptCFlag(CMAKE_C_FLAGS HAVE_C_WOLD_STYLE_DEFINITION "-Wold-style-definition")
 
+if (ENABLE_WERROR)
+  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Werror")
+  message(STATUS "Enabled -Werror")
+endif()
+
 # Old versions of libnl have a duplicated rtnl_route_put, disbale the warning on those
 # systems
 if (NOT NL_KIND EQUAL 0)
diff --git a/buildlib/azure-pipelines.yml b/buildlib/azure-pipelines.yml
index 153d437d8e81e9..4eef7408af027c 100644
--- a/buildlib/azure-pipelines.yml
+++ b/buildlib/azure-pipelines.yml
@@ -43,7 +43,7 @@ stages:
               set -e
               mkdir build-gcc9
               cd build-gcc9
-              CC=gcc-9 CFLAGS="-Werror" cmake -GNinja .. -DIOCTL_MODE=both -DENABLE_STATIC=1
+              CC=gcc-9 cmake -GNinja .. -DIOCTL_MODE=both -DENABLE_STATIC=1 -DENABLE_WERROR=1
               ninja
             displayName: gcc 9.1 Compile
 
@@ -62,7 +62,7 @@ stages:
               mv CMakeLists.txt CMakeLists-orig.txt
               grep -v "# NO SPARSE" CMakeLists-orig.txt > CMakeLists.txt
               cd build-sparse
-              CC=cgcc CFLAGS="-Werror" cmake -GNinja .. -DIOCTL_MODE=both -DNO_PYVERBS=1
+              CC=cgcc cmake -GNinja .. -DIOCTL_MODE=both -DNO_PYVERBS=1 -DENABLE_WERROR=1
               ninja | grep -v '^\[' | tee out
               # sparse does not fail gcc on messages
               if [ -s out ]; then
@@ -75,7 +75,7 @@ stages:
               set -e
               mkdir build-clang
               cd build-clang
-              CC=clang-8 CFLAGS="-Werror -m32 -msse3" cmake -GNinja .. -DIOCTL_MODE=both -DNO_PYVERBS=1
+              CC=clang-8 CFLAGS="-m32" cmake -GNinja .. -DIOCTL_MODE=both -DNO_PYVERBS=1 -DENABLE_WERROR=1
               ninja
             displayName: clang 8.0 32-bit Compile
 
@@ -85,7 +85,7 @@ stages:
               echo "#error Fail" >> util/udma_barrier.h
               cd build-gcc9
               rm CMakeCache.txt
-              CC=gcc-9 CFLAGS="-Werror" cmake -GNinja .. -DIOCTL_MODE=both
+              CC=gcc-9 cmake -GNinja .. -DIOCTL_MODE=both -DENABLE_WERROR=1
               ninja
               mv ../util/udma_barrier.h.old ../util/udma_barrier.h
             displayName: Simulate non-coherent DMA Platform Compile
@@ -94,7 +94,7 @@ stages:
               set -e
               mkdir build-arm64
               cd build-arm64
-              CC=aarch64-linux-gnu-gcc-8 CFLAGS="-Werror" cmake -GNinja .. -DIOCTL_MODE=both -DNO_PYVERBS=1
+              CC=aarch64-linux-gnu-gcc-8 cmake -GNinja .. -DIOCTL_MODE=both -DNO_PYVERBS=1 -DENABLE_WERROR=1
               ninja
             displayName: gcc 8.3 ARM64 Compile
 
@@ -102,18 +102,14 @@ stages:
               set -e
               mkdir build-ppc64el
               cd build-ppc64el
-              CC=powerpc64le-linux-gnu-gcc-8 CFLAGS="-Werror" cmake -GNinja .. -DIOCTL_MODE=both -DNO_PYVERBS=1
+              CC=powerpc64le-linux-gnu-gcc-8 cmake -GNinja .. -DIOCTL_MODE=both -DNO_PYVERBS=1 -DENABLE_WERROR=1
               ninja
             displayName: gcc 8.3 PPC64EL Compile
 
-          # When running cmake through debian/rules it is hard to set -Werror,
-          # instead force it on by changing the CMakeLists.txt
           - bash: |
               set -e
-              echo 'set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Werror")' >> buildlib/RDMA_EnableCStd.cmake
-              sed -i -e 's/-DCMAKE_BUILD_TYPE=Release/-DCMAKE_BUILD_TYPE=Debug/g' debian/rules
               sed -i -e 's/ninja \(.*\)-v/ninja \1/g' debian/rules
-              debian/rules CC=clang-8 build
+              debian/rules CC=clang-8 EXTRA_CMAKE_FLAGS="-DCMAKE_BUILD_TYPE=Debug -DENABLE_WERROR=1" build
             displayName: clang 8.0 Bionic Build
           - bash: |
               set -e
@@ -164,15 +160,15 @@ stages:
             centos7:
               CONTAINER: centos7
               SPEC: redhat/rdma-core.spec
-              RPMBUILD_OPTS:
+              RPMBUILD_OPTS:  --define 'EXTRA_CMAKE_FLAGS -DCMAKE_BUILD_TYPE=Debug -DENABLE_WERROR=1'
             fedora30:
               CONTAINER: fedora
               SPEC: redhat/rdma-core.spec
-              RPMBUILD_OPTS:
+              RPMBUILD_OPTS:  --define 'EXTRA_CMAKE_FLAGS -DCMAKE_BUILD_TYPE=Debug -DENABLE_WERROR=1'
             leap:
               CONTAINER: leap
               SPEC: suse/rdma-core.spec
-              RPMBUILD_OPTS: --without=curlmini
+              RPMBUILD_OPTS:  --define 'EXTRA_CMAKE_FLAGS -DCMAKE_BUILD_TYPE=Debug -DENABLE_WERROR=1' --without=curlmini
         container: $[ variables['CONTAINER'] ]
         steps:
           - checkout: none
-- 
2.22.0

