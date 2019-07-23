Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED6C71FCD
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 21:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391640AbfGWTBt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 15:01:49 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38195 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391643AbfGWTBs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 15:01:48 -0400
Received: by mail-qk1-f193.google.com with SMTP id a27so31922994qkk.5
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 12:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UKmdwvw/8ttn78/lBaV+bKRv55wjOH8lCAZy5e7wk/Y=;
        b=J7qUhNen3Dz157dE2Ng4CmMJ5GsktjzuBk0xwqCsq7Gg0fu8uM2iULT2VTyInspP8j
         qjfNqQlLwC+tSfmxldjXQat/ys31GWvcBP89uQX9ANmqRyqN0y56axjNw3QpGBmr31E0
         AcbJZsLhB6p+VJzVtog0FX96AqpuQ5pDPxd4md2/HtEl8FKlG2AHzCxKsfIyG+VgZfG/
         LVPAHJSfKK2GyyBzpK3rZiP4ZRoz9p5Ib/Ic3dB6lJpuqzPBuJBFQ7ciH0ipeeeWRQtb
         jTxafsXUg9ADuWu+QYyAQd6x1NuC0UqYdxamfyN8ZCxLITW2yS6frBomryB4LKrW1LbX
         rEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UKmdwvw/8ttn78/lBaV+bKRv55wjOH8lCAZy5e7wk/Y=;
        b=IEqLEKpoEV9cikLpxsND20OKvrHU/Lh++qSljEvpubPO4AQi+QentBBbHouPbGtRfM
         g3W12EfmgaSNyK98jkhmwg2poKlUz1okIy89NQFVLraFsl67+jJ/TMjTNOK8BokcH8Ky
         qdyKlB6Sk8kJIEbkzF+6NUHr7FO1+M0Uy2OGyKQv6FF2qzE1EhHfGoTMWg6cNfQpj+CI
         PtuTTXKTEbdoRzv1QwiX+b7jpWvRoMsN28bi00HY8pdpvlPr2D19QtGHiygOpq9/IW2E
         cR4zTl048go8pebNOMH6haU1uFc/b0/LY7n2i55/+rF3rJxHSPLbpMZMTYtkLcwvLt81
         laKQ==
X-Gm-Message-State: APjAAAXDdZDPkVRgCNZ0uxHizMh+LWvQfXu4NTcBh8CDxOabesTxxoo8
        aLzDsxjBs8IINacdXc9fzdRbaHY19c4FxQ==
X-Google-Smtp-Source: APXvYqwG4XPp3FH/0xpUjVyxR2/hZmH0XFLnyWl9ztKjsNcfiTrhqbtdWPBZq806poL8TNUbJNyszw==
X-Received: by 2002:a37:274a:: with SMTP id n71mr47384474qkn.448.1563908507213;
        Tue, 23 Jul 2019 12:01:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id m44sm24417261qtm.54.2019.07.23.12.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 12:01:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hq02e-00044F-FD; Tue, 23 Jul 2019 16:01:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 05/19] build/travis: Do not run checkpatch
Date:   Tue, 23 Jul 2019 16:01:23 -0300
Message-Id: <20190723190137.15370-6-jgg@ziepe.ca>
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

AZP does this now and shows the results in a much clearer way.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 .travis.yml                |  1 -
 buildlib/travis-checkpatch | 30 ------------------------------
 2 files changed, 31 deletions(-)
 delete mode 100755 buildlib/travis-checkpatch

diff --git a/.travis.yml b/.travis.yml
index 23226a679acb6b..d20dadf8e9d90f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -48,7 +48,6 @@ before_script:
   - http_proxy= pip3 install cython
 script:
   - buildlib/travis-build
-  - buildlib/travis-checkpatch
   - buildlib/github-release
 deploy:
   # Deploy assets to Github releases
diff --git a/buildlib/travis-checkpatch b/buildlib/travis-checkpatch
deleted file mode 100755
index 5e78ec47406210..00000000000000
--- a/buildlib/travis-checkpatch
+++ /dev/null
@@ -1,30 +0,0 @@
-#!/bin/bash
-# Copyright 2017 Mellanox Technologies Ltd.
-# Licensed under BSD (MIT variant) or GPLv2. See COPYING.
-
-
-if [ "x$TRAVIS_EVENT_TYPE" != "xpull_request" ]; then
-	# Peform checkpatch checks on pull requests only
-	exit 0
-fi
-
-# The below "set" is commented, because the checkpatch.pl returns 1 (error) for warnings too.
-# And the rdma-core code is not mature enough to be warning safe
-# set -e
-
-if [ "x$TRAVIS_COMMIT_RANGE" != "x" ]; then
-	cd buildlib/
-	wget -q https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/checkpatch.pl \
-	        https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/spelling.txt
-	DIR_FOR_PATCHES_TO_CHECK=$(mktemp -d)
-	git format-patch --no-cover-letter $TRAVIS_COMMIT_RANGE ^$TRAVIS_BRANCH -o $DIR_FOR_PATCHES_TO_CHECK/
-	CHECKPATCH_OPT="--no-tree --ignore PREFER_KERNEL_TYPES,FILE_PATH_CHANGES,EXECUTE_PERMISSIONS,USE_NEGATIVE_ERRNO,CONST_STRUCT $DIR_FOR_PATCHES_TO_CHECK/*"
-	perl checkpatch.pl $CHECKPATCH_OPT
-	if [ $? -ne 0 ]; then
-		# We rerun checkpatch to simplify parsing and to understand if we failed for errors
-		# For example, the output on some arbitrary patchset of the following line without awk is:
-		# total: 1 errors, 3 warnings, 42 lines checked
-		NUMB_ERRRORS=$(perl checkpatch.pl --terse $CHECKPATCH_OPT | awk 'BEGIN {FS = "total:"} ; {sum+=$2} END {print sum}')
-		exit $NUMB_ERRRORS
-	fi
-fi
-- 
2.22.0

