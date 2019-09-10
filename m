Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56FC5AF2E5
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2019 00:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfIJWVg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Sep 2019 18:21:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38990 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfIJWVg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Sep 2019 18:21:36 -0400
Received: by mail-io1-f66.google.com with SMTP id d25so41337689iob.6;
        Tue, 10 Sep 2019 15:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zNmBqBiKCk6tuEuyxER70RAEgALJreQQf3E9yiwzkPY=;
        b=r99ohcwKO6on8GYUYhTUw3dsqLewE0ODeVEZotLOrqQA43sN7r9DokEoVlVL1HCflz
         ZrIQGgVoQcHuQjS3o+DIz8ULnED9bDJELls0lDm+ApttHrAtHexW5gXonlKkxaTu18rz
         SLQF7oTk9o9ikcFExf8wrtkOUbv//fzps+EprldpFg1fbUuhCjsNR0nfeORSB5iWpXxf
         XVCtKWJwvHzdq2H2hkAwLtN+ymRgQqjyl7kVFf6lD0cnbgvRyhxgwAQR00kMjF3PCw1A
         TYrtAiW1IrrYvOX3/4drPB6XRbAQdn9rV4a4zDeYJIJa9RXQFBmOwQTCNLG5vEQa4SlE
         9c1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zNmBqBiKCk6tuEuyxER70RAEgALJreQQf3E9yiwzkPY=;
        b=qRX7svBTsuJ1SFd4FGKV2qTxfBQRYAsbR64quTcgDDiCL8Xu4ApnIOmgjFV/SgDVox
         LBCrEc+t2Iyb2K5yrAHSawTyG8d8c70S79t1eZpheUaYknn1J3FjObbzAGhdYPRwaj8c
         xx6xCzdwmqAAOttEyFMDyIVhgHtuGjpBU2F3huPgbferXy1cCdrUnSSFGfY3hsVUd5Yq
         A2VFIhh5NAvlEuXnm+mS42v1somCwJqGnKKm4WS/FtVV/DtraY4/H0AUR5CWfZypS0th
         WM8soELSbzhkq7ZVWpLCWw1+EQ6GJtX+nxwbiSxDAe0FBjgrXAwrcRtxBCPblsLxcPuh
         xhtg==
X-Gm-Message-State: APjAAAV+lgsMHXpok2X1WSfWv2Kk2pyoG2bVbwM2pfhVRCK8creOqvLm
        oaZoMI5cPL9TRJL0wmICHtU=
X-Google-Smtp-Source: APXvYqzGodRMVSnOXMqK629VGLR8xwRkydp5Rwp2qc2P+lInChSSTK3xgA3CoFbTTSOw3XXP+BnoSQ==
X-Received: by 2002:a02:7113:: with SMTP id n19mr33640058jac.82.1568154095088;
        Tue, 10 Sep 2019 15:21:35 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id u6sm14814127iop.18.2019.09.10.15.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 15:21:34 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA: fix goto target to release the allocated memory
Date:   Tue, 10 Sep 2019 17:21:19 -0500
Message-Id: <20190910222120.16517-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In bnxt_re_create_srq, when ib_copy_to_udata fails allocated memory
should be released by goto fail.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 098ab883733e..4a91ffe2c676 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1398,7 +1398,7 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 			dev_err(rdev_to_dev(rdev), "SRQ copy to udata failed!");
 			bnxt_qplib_destroy_srq(&rdev->qplib_res,
 					       &srq->qplib_srq);
-			goto exit;
+			goto fail;
 		}
 	}
 	if (nq)
-- 
2.17.1

