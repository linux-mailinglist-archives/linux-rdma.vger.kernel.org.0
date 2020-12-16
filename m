Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57FBB2DC989
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 00:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbgLPXRT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Dec 2020 18:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730782AbgLPXRS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Dec 2020 18:17:18 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975D7C061285
        for <linux-rdma@vger.kernel.org>; Wed, 16 Dec 2020 15:16:02 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id s2so29854893oij.2
        for <linux-rdma@vger.kernel.org>; Wed, 16 Dec 2020 15:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tFN4GfjJ+3JUFU0+MXiNzXNZ+QcrK3QOX7uArKKgoYc=;
        b=mg0SJX6tUpUif9uH0YQuxxSez/JS7mAYWeJEQH8UTwnDyLCEMvhhG2GiVdTqtA0ovt
         +cN2tksdZEF/1I31jHg/eTLyofW2jFomvVbbMG1v7yn0q1HZ6QiRTLCjkVODF2uK6SI2
         6069lLBRknzIvatX/7ogTGuS7FoAnymtth29Kh+v9uPHhm4nlOLgXR9oVJbf+dLVy3l1
         41VcPoXidKM+RvikFfixCFLbnAt6Sc4G3gHfK/v30Y4KrRdtT4zvqtqP0KHgZlHMzICW
         Rd3zFXLVrpUPi3jdcRgNUR/GTl2cJLw1GgeW5xADcZJDRmJu7id3ZVvY++gG6F0pesbG
         yIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tFN4GfjJ+3JUFU0+MXiNzXNZ+QcrK3QOX7uArKKgoYc=;
        b=aJvoiucIwecB8iIZ+d2OWwvTAq+y8GHdHwVOM/aBCQqL6lWPMuc9qu6I2IS/dCfxhU
         EkrHIl/YqJW54kZn8PncvHrFZrE0P4Jp6tsTHgwvAUIsXo8FdpUBJthJrFvw8dGav4zh
         UgqMafvviOdvAucYcaW70p9ND00puerA9NKWMI3G2HPG6uosq1b6Pw1oGRSyJTifXXBe
         tCY1gRXYKMHPsjcRqHyp4+jdTkiHplqtYwGp2r1lLAZpTqlRUKMhgaMHXGaPQGnYG66F
         IMQUyOwb5+2JSeBvFnrdyOAtCxJCKvzbjLh8hiGvplT1FjTubhuaCxgq/9z3sJoeKX3k
         Bk6g==
X-Gm-Message-State: AOAM531ygNgPUChWWnzS9xLjxzqYWEsCF+JheuFIFLLnF2+vsTCYKOEi
        wk+OH+56DIQ3S847sSTvVw0=
X-Google-Smtp-Source: ABdhPJw8yrzJ28SSfsAR9VdsBxl6/pMSmsVpR817T3Lt8m9k2wxxiUUqf3IsKLj0AuLl1z28zvk5ig==
X-Received: by 2002:aca:b06:: with SMTP id 6mr3233607oil.74.1608160562079;
        Wed, 16 Dec 2020 15:16:02 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-6a03-8d89-0aec-a801.res6.spectrum.com. [2603:8081:140c:1a00:6a03:8d89:aec:a801])
        by smtp.gmail.com with ESMTPSA id f18sm793437otf.55.2020.12.16.15.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 15:16:01 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 7/7] RDMA/rxe: Fix race in rxe_mcast.c
Date:   Wed, 16 Dec 2020 17:15:50 -0600
Message-Id: <20201216231550.27224-8-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201216231550.27224-1-rpearson@hpe.com>
References: <20201216231550.27224-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix a race in rxe_mcast.c that occurs when two QPs try at the
same time to attach a multicast address. Both QPs lookup the mgid
address in a pool of multicast groups and if they do not find it
create a new group elem.

Fix this by locking the lookup/alloc/add key sequence and using
the unlocked APIs added in this patch set.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 64 +++++++++++++++++----------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index c02315aed8d1..5be47ce7d319 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -7,45 +7,61 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
+/* caller should hold mc_grp_pool->pool_lock */
+static struct rxe_mc_grp *create_grp(struct rxe_dev *rxe,
+				     struct rxe_pool *pool,
+				     union ib_gid *mgid)
+{
+	int err;
+	struct rxe_mc_grp *grp;
+
+	grp = rxe_alloc_nl(&rxe->mc_grp_pool);
+	if (!grp)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&grp->qp_list);
+	spin_lock_init(&grp->mcg_lock);
+	grp->rxe = rxe;
+	rxe_add_key_nl(grp, mgid);
+
+	err = rxe_mcast_add(rxe, mgid);
+	if (unlikely(err)) {
+		rxe_drop_key_nl(grp);
+		rxe_drop_ref(grp);
+		return ERR_PTR(err);
+	}
+
+	return grp;
+}
+
 int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
 		      struct rxe_mc_grp **grp_p)
 {
 	int err;
 	struct rxe_mc_grp *grp;
+	struct rxe_pool *pool = &rxe->mc_grp_pool;
+	unsigned long flags;
 
-	if (rxe->attr.max_mcast_qp_attach == 0) {
-		err = -EINVAL;
-		goto err1;
-	}
+	if (rxe->attr.max_mcast_qp_attach == 0)
+		return -EINVAL;
 
-	grp = rxe_pool_get_key(&rxe->mc_grp_pool, mgid);
+	write_lock_irqsave(&pool->pool_lock, flags);
+
+	grp = rxe_pool_get_key_nl(pool, mgid);
 	if (grp)
 		goto done;
 
-	grp = rxe_alloc(&rxe->mc_grp_pool);
-	if (!grp) {
-		err = -ENOMEM;
-		goto err1;
+	grp = create_grp(rxe, pool, mgid);
+	if (IS_ERR(grp)) {
+		write_unlock_irqrestore(&pool->pool_lock, flags);
+		err = PTR_ERR(grp);
+		return err;
 	}
 
-	INIT_LIST_HEAD(&grp->qp_list);
-	spin_lock_init(&grp->mcg_lock);
-	grp->rxe = rxe;
-
-	rxe_add_key(grp, mgid);
-
-	err = rxe_mcast_add(rxe, mgid);
-	if (err)
-		goto err2;
-
 done:
+	write_unlock_irqrestore(&pool->pool_lock, flags);
 	*grp_p = grp;
 	return 0;
-
-err2:
-	rxe_drop_ref(grp);
-err1:
-	return err;
 }
 
 int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
-- 
2.27.0

