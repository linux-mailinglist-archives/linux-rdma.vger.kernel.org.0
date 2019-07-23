Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6035F71FC8
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 21:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391641AbfGWTBq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 15:01:46 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:37326 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfGWTBq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 15:01:46 -0400
Received: by mail-qk1-f177.google.com with SMTP id d15so31894625qkl.4
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 12:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zIff7Uf/Rm++2DAFA4aFIst6xKKCYsuK2JlZRwYIiV0=;
        b=ZoTMFRE6E1QqjALDSl3Vzsq06OwMy5Op2boo7s9Zcd88/kglvHp/aCaiuPj/CyfvVE
         PODZLwbNJ3ktVyovgjr6XjqmjTkvuSFh5S0uFeDbVxcFchROmrpvq30vXzBLf3V1flti
         euUbLsUimK8vo05fNPD6iQv//aYwxubm3obL26LJOyQCkyWyqOyNOZ9x6ZDBXspC1X1h
         aVUV4kun3Q9xetL2eKkcfHW0dCQZzYaTCrtnLiCR8qnvaRcBqCnR4h5yh0OEb7LBtIV2
         ot1lOelzW4EBzTjrq9uF50mCEHF4KgaLYaArczD9wCPRbz/XYfYaTOdWYUiKhhSWPLWm
         GmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zIff7Uf/Rm++2DAFA4aFIst6xKKCYsuK2JlZRwYIiV0=;
        b=DjJiMoRY/vO9Hx14iHOWzzzfknsWZmNSoPXwaD2nT8grBHyrSTO9nzfrsw5YruHS9K
         CMjVi7ryP/LcgaRlkDs43QPytu6OS4+kLgmCmQLkMblIiRp1VctXaT9vTir9imqyuW8D
         33x1P4k1jiC0sGJB8+P4aJWoHYVnu7mr/OdvGekGBXqgi3100UQ1oOP1/x4RRjL8Xwpn
         P5Njw0QxN9g+0u9bwWQ452EoaQDPtBSc7lmHdzOlFyaYOp8hSr8KoxpGQmJgyKx4o1Kl
         gzJnXj897+kNKmTPOt+iHdvbK2DwMJl00OOGNcWXDbiPRWlxcKFt0PEU04H/Dh+atlKP
         0VqA==
X-Gm-Message-State: APjAAAVvBaMxekT/gI0s1oxwcBtLj/ubZh+y628//XqAw3oqP1pb1Gof
        usl+/gjEzo5gnYk/xL6pVz/NpWkwZvFKpg==
X-Google-Smtp-Source: APXvYqy7rsXReobd71JTKN7vf0W+8crIKL4YTvTYn5d1nXRinGFTXnDNiidUgB1Jwcac0T5/fg31dA==
X-Received: by 2002:ae9:e856:: with SMTP id a83mr48812326qkg.321.1563908504820;
        Tue, 23 Jul 2019 12:01:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id i23sm19591095qtm.17.2019.07.23.12.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 12:01:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hq02e-00044L-Go; Tue, 23 Jul 2019 16:01:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 06/19] build/travis: Do not cross compile for ARM64
Date:   Tue, 23 Jul 2019 16:01:24 -0300
Message-Id: <20190723190137.15370-7-jgg@ziepe.ca>
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

AZP does this now, and does a better job as it has all the cross compile
system libraries available.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 .travis.yml           | 5 -----
 buildlib/travis-build | 7 +------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index d20dadf8e9d90f..82f16d65e0a646 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -40,11 +40,6 @@ addons:
       - python3-pip
 
 before_script:
-  - export LATEST_GCC_LINARO_URL=`wget -qO - https://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/ | grep -o '<a href=['"'"'"].*gcc-linaro-.*x86_64_aarch64-linux-gnu.tar.xz['"'"'"]'  |  sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//'`
-  - export LATEST_GCC_LINARO_TAR=`basename $LATEST_GCC_LINARO_URL`
-  - wget -q http://releases.linaro.org/$LATEST_GCC_LINARO_URL
-  - mkdir $HOME/aarch64 && tar xf $LATEST_GCC_LINARO_TAR -C $HOME/aarch64 --strip 1
-  - rm $LATEST_GCC_LINARO_TAR
   - http_proxy= pip3 install cython
 script:
   - buildlib/travis-build
diff --git a/buildlib/travis-build b/buildlib/travis-build
index f84b77fc782147..48c1c8f68f146d 100755
--- a/buildlib/travis-build
+++ b/buildlib/travis-build
@@ -7,7 +7,7 @@ set -e
 # Echo all commands to Travis log
 set -x
 
-mkdir build-travis build32 build-sparse build-aarch64
+mkdir build-travis build32 build-sparse
 
 # Build with latest clang first
 cd build-travis
@@ -22,11 +22,6 @@ cd ../build32
 CC=gcc-8 CFLAGS="-Werror -m32 -msse3" cmake -GNinja .. -DENABLE_RESOLVE_NEIGH=0 -DIOCTL_MODE=both -DNO_PYVERBS=1
 ninja
 
-# aarch64 build to check compilation on ARM 64bit platform
-cd ../build-aarch64
-CC=$HOME/aarch64/bin/aarch64-linux-gnu-gcc CFLAGS="-Werror -Wno-maybe-uninitialized" cmake -GNinja .. -DENABLE_RESOLVE_NEIGH=0 -DIOCTL_MODE=ioctl -DNO_PYVERBS=1
-ninja
-
 # Run sparse on the subdirectories which are sparse clean
 cd ../build-sparse
 mv ../CMakeLists.txt ../CMakeLists-orig.txt
-- 
2.22.0

