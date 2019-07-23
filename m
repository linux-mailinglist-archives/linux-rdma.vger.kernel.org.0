Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0E8A71FF1
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 21:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfGWTLf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 15:11:35 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:32932 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbfGWTLf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 15:11:35 -0400
Received: by mail-qt1-f176.google.com with SMTP id r6so38758499qtt.0
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 12:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uGkCjNnRJdgtLT8p4FzZezeOKVGZ7cf/IilSZq7RXO0=;
        b=a3xKv99dd7prErqSscRZqZJWDex6faroCxZlpQAFmFAohL7wPzpPw2FcBKLgY66Jt8
         r4YQBXnTG4N0ZpT6ZZ0UazOiSlDwxB9C1WU/P/0V35Ufmj7xHLmKjq4653K4KXrGCHfQ
         YF2qFXXDY/2dLAfcZzIWmOAsn6NSOt0+uNrvi3ZTE/RMTIfVSXD+XIxByPGODUX5R6Sw
         6cIraPMWeBUzcvu0EQJGXMy4iEjaPOC93JXJ7TMekBf7PstgeY6pI5xdBCN7DvXbJi27
         zXaZW0mkCcEGQKW8IK9/GW3KGEfoTGwRpR44Ahcl3I19xQKJUow2Bw1bEPJUYkYXenKm
         6dIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uGkCjNnRJdgtLT8p4FzZezeOKVGZ7cf/IilSZq7RXO0=;
        b=cDu2KkvF2BzTNPtWQWgl2GMbgsv5WB8e8notlzSe7H55sE/+0jhkp2lHP3qfIN8CTg
         ltuZaYLl4DZyOJ3Y1Uon8fNXqKrm1y/4mOei0LQQqcv4f8Mwp7f/OK4e91AhjnNWdJJL
         QIBadyUZ87xNEGEiV9LI8Z6JL2Q4xMK37kY2BTqnlN65b+OEyKFDR1WSvJz8Q+CP8Yns
         /ZpxUTdzDxwse8yD1Hl8Myt3b6rnwWnTSO64Ov01Qjy8fytvbsZidPgkqBeLWruxipJ7
         oRfCXHAa/2XYNlxsqISpVqhX2YDzREB3aYYUV9IzM9qExN8XcQfHoXog/Dl3RN5Y71ee
         N6oA==
X-Gm-Message-State: APjAAAW5wUoJc+homu6eCqD3xLAHznMTkjWZIqs9/aetCDMhnydOw6BO
        cPYLFO/UEhHlnXSZyQmAfewkeeP1g6yN8w==
X-Google-Smtp-Source: APXvYqyxaacbIg3mwL22nDvhWCU1WqsWdvF90elFt99vO1IA1Cz1A3jXcb+dTSMphgDy1h9mFPT1Yg==
X-Received: by 2002:ad4:5405:: with SMTP id f5mr55913277qvt.242.1563909094556;
        Tue, 23 Jul 2019 12:11:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id e1sm21881146qtb.52.2019.07.23.12.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 12:11:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hq02e-000449-D9; Tue, 23 Jul 2019 16:01:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 04/19] build/travis: Do not build packages in travis anymore
Date:   Tue, 23 Jul 2019 16:01:22 -0300
Message-Id: <20190723190137.15370-5-jgg@ziepe.ca>
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

AZP does this now and (so far) doesn't randomly fail.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 .travis.yml                 |  4 ----
 buildlib/package-build-test | 21 ---------------------
 2 files changed, 25 deletions(-)
 delete mode 100755 buildlib/package-build-test

diff --git a/.travis.yml b/.travis.yml
index 1cc2c69ca8671d..23226a679acb6b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -39,9 +39,6 @@ addons:
       - python3-dev
       - python3-pip
 
-service:
-    - docker
-
 before_script:
   - export LATEST_GCC_LINARO_URL=`wget -qO - https://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/ | grep -o '<a href=['"'"'"].*gcc-linaro-.*x86_64_aarch64-linux-gnu.tar.xz['"'"'"]'  |  sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//'`
   - export LATEST_GCC_LINARO_TAR=`basename $LATEST_GCC_LINARO_URL`
@@ -52,7 +49,6 @@ before_script:
 script:
   - buildlib/travis-build
   - buildlib/travis-checkpatch
-  - buildlib/package-build-test
   - buildlib/github-release
 deploy:
   # Deploy assets to Github releases
diff --git a/buildlib/package-build-test b/buildlib/package-build-test
deleted file mode 100755
index 29c17838e9e894..00000000000000
--- a/buildlib/package-build-test
+++ /dev/null
@@ -1,21 +0,0 @@
-#!/bin/bash
-
-# fail on errors
-set -e
-# be verbose
-set -x
-
-# Do not run these tests if we are already inside a container
-if [ -e "/.dockerenv" ] || (grep -q docker /proc/self/cgroup &>/dev/null); then
-       echo "We are running in a container, skipping ..."
-       exit 0
-fi
-
-for OS in centos7 leap
-do
-	echo
-	echo "Checking package build for ${OS} ...."
-	echo
-	buildlib/cbuild build-images ${OS}
-	buildlib/cbuild pkg --use-prebuilt-pandoc --with static ${OS}
-done
-- 
2.22.0

