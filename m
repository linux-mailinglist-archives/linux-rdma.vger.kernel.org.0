Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0997C273379
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Sep 2020 22:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgIUUER (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Sep 2020 16:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgIUUER (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Sep 2020 16:04:17 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92616C061755
        for <linux-rdma@vger.kernel.org>; Mon, 21 Sep 2020 13:04:17 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m12so13554600otr.0
        for <linux-rdma@vger.kernel.org>; Mon, 21 Sep 2020 13:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FYwKkNRp9uCds/YjAuYWixK/yGwzj9/mfnhHuXBMfrg=;
        b=AGvrRMzbp+14ikjHWEL/alfwHBHcjbL5C9TqTO+UNMbtxLapEUA2jsCXPZbh2+6TiO
         j7MQevaSTtdoQbGAYsxPwnEHvYUrfjTiqtVSc1urtfm1jCSAIA04gG3bLJgPRR6xdKRl
         IMRoo3c39eUcZik2c5Cew2x/IvTMqiaAk39zVMj6VAPNzyKjcBqGQMzS3HpGoFZwXHwf
         xtCNwe1OlbAnWEAAYPgTV4+Vn8LyDL3S5ZZ1IZBdXwPY+3eaHXyGRUMXYzHZaf3FsOJ3
         RQmT8GYBFiwY397ZXFC49HgFvvmhoUrEzAZA/QOqHzDEzsm1hEgDIZBgqvvg3PP3f93f
         yCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FYwKkNRp9uCds/YjAuYWixK/yGwzj9/mfnhHuXBMfrg=;
        b=aqqYV6OnlklLmAA+AGc9f881Dp+/UmemRzVk8AdkImecE+5SkaC8arCFM2MeWMe5ud
         Ryc616CX6CnjLzIzvbe6G1EdXAaj0o3a1oAQ1efYEpR192uI/M4ST1hWXZK6px2ZtJIJ
         /YkjaJi5GuqnoOwjzJM1/QifchNo+Um7Lu6IMZ2UTJnWI+X/3js41eAGrZsGN70aamYC
         19fcZs3qe9vrpkm3yl4tFAvBWrL2e5/7f2KczSEJLWUlLez8SDzQdXEplnu5/Q15+iyt
         //xco1OKQvp23pNpqvA4NAHm5JECnFpvu9q03zcIwooRGvgFMGu1LMF7ilfdUj6xPeRH
         BNFQ==
X-Gm-Message-State: AOAM531IrTcih9fNl83sFTsW4sIjNCmma1Z2Jm05ck5E2go6bIepXfSj
        4D0gAmgUb5nu2S9Fpg6Dcew=
X-Google-Smtp-Source: ABdhPJy0JiKllYfCHkExIIJ9lqh2xHMzWCoS+czXuWCBk6RGYRvsndaWdtZ9JpIPa2mYnVVRcNFDNQ==
X-Received: by 2002:a05:6830:1bf9:: with SMTP id k25mr730415otb.310.1600718656936;
        Mon, 21 Sep 2020 13:04:16 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:9211:f781:8595:d131])
        by smtp.gmail.com with ESMTPSA id 187sm7007095oie.42.2020.09.21.13.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 13:04:16 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v6 11/12] rdma_rxe: Fix mcast group allocation bug
Date:   Mon, 21 Sep 2020 15:03:55 -0500
Message-Id: <20200921200356.8627-12-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921200356.8627-1-rpearson@hpe.com>
References: <20200921200356.8627-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch does the following:
  - Cleans up multicast group create to use an atomic
    sequence of lookup followed by allocate. This fixes an
    error that occurred when two QPs were attempting to attach
    to the same mcast address at the same time.
  - Fixes a bug in rxe_mcast_get_grp not initializing err = 0.
    If the group is found in get_key the routine can return an
    uninitialized value to caller.
  - Changes the variable elem to mce (for mcast elem).
    This is less likely to confuse readers because of the ambiguity
    with elem as pool element which is also used.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 108 ++++++++++++++------------
 1 file changed, 60 insertions(+), 48 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index b09c6594045a..541cc68a8a94 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -7,44 +7,56 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
-int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
-		      struct rxe_mc_grp **grp_p)
+/* caller should hold mc_grp_pool->pool_lock */
+static struct rxe_mc_grp *create_grp(struct rxe_dev *rxe,
+					    struct rxe_pool *pool,
+					    union ib_gid *mgid)
 {
 	int err;
 	struct rxe_mc_grp *grp;
 
-	if (rxe->attr.max_mcast_qp_attach == 0) {
-		err = -EINVAL;
-		goto err1;
-	}
-
-	grp = rxe_get_key(&rxe->mc_grp_pool, mgid);
-	if (grp)
-		goto done;
-
-	grp = rxe_alloc(&rxe->mc_grp_pool);
-	if (!grp) {
-		err = -ENOMEM;
-		goto err1;
-	}
+	grp = __alloc(&rxe->mc_grp_pool);
+	if (unlikely(!grp))
+		return NULL;
 
 	INIT_LIST_HEAD(&grp->qp_list);
 	spin_lock_init(&grp->mcg_lock);
 	grp->rxe = rxe;
-
-	rxe_add_key(grp, mgid);
+	add_key(grp, mgid);
 
 	err = rxe_mcast_add(rxe, mgid);
-	if (err)
-		goto err2;
+	if (unlikely(err)) {
+		drop_key(grp);
+		rxe_drop_ref(grp);
+		return NULL;
+	}
 
+	return grp;
+}
+
+/* atomically lookup or create mc group */
+int rxe_mcast_get_grp(struct rxe_dev *rxe, union ib_gid *mgid,
+		      struct rxe_mc_grp **grp_p)
+{
+	int err = 0;
+	struct rxe_mc_grp *grp;
+	struct rxe_pool *pool = &rxe->mc_grp_pool;
+	unsigned long flags;
+
+	if (unlikely(rxe->attr.max_mcast_qp_attach == 0))
+		return -EINVAL;
+
+	write_lock_irqsave(&pool->pool_lock, flags);
+	grp = __get_key(pool, mgid);
+	if (grp)
+		goto done;
+
+	grp = create_grp(rxe, pool, mgid);
+	if (unlikely(!grp))
+		err = -ENOMEM;
 done:
+	write_unlock_irqrestore(&pool->pool_lock, flags);
 	*grp_p = grp;
-	return 0;
-
-err2:
-	rxe_drop_ref(grp);
-err1:
 	return err;
 }
 
@@ -52,13 +64,13 @@ int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 			   struct rxe_mc_grp *grp)
 {
 	int err;
-	struct rxe_mc_elem *elem;
+	struct rxe_mc_elem *mce;
 
 	/* check to see of the qp is already a member of the group */
 	spin_lock_bh(&qp->grp_lock);
 	spin_lock_bh(&grp->mcg_lock);
-	list_for_each_entry(elem, &grp->qp_list, qp_list) {
-		if (elem->qp == qp) {
+	list_for_each_entry(mce, &grp->qp_list, qp_list) {
+		if (mce->qp == qp) {
 			err = 0;
 			goto out;
 		}
@@ -69,8 +81,8 @@ int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 		goto out;
 	}
 
-	elem = rxe_alloc(&rxe->mc_elem_pool);
-	if (!elem) {
+	mce = rxe_alloc(&rxe->mc_elem_pool);
+	if (!mce) {
 		err = -ENOMEM;
 		goto out;
 	}
@@ -79,11 +91,11 @@ int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	rxe_add_ref(grp);
 
 	grp->num_qp++;
-	elem->qp = qp;
-	elem->grp = grp;
+	mce->qp = qp;
+	mce->grp = grp;
 
-	list_add(&elem->qp_list, &grp->qp_list);
-	list_add(&elem->grp_list, &qp->grp_list);
+	list_add(&mce->qp_list, &grp->qp_list);
+	list_add(&mce->grp_list, &qp->grp_list);
 
 	err = 0;
 out:
@@ -96,7 +108,7 @@ int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 			    union ib_gid *mgid)
 {
 	struct rxe_mc_grp *grp;
-	struct rxe_mc_elem *elem, *tmp;
+	struct rxe_mc_elem *mce, *tmp;
 
 	grp = rxe_get_key(&rxe->mc_grp_pool, mgid);
 	if (!grp)
@@ -105,15 +117,15 @@ int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	spin_lock_bh(&qp->grp_lock);
 	spin_lock_bh(&grp->mcg_lock);
 
-	list_for_each_entry_safe(elem, tmp, &grp->qp_list, qp_list) {
-		if (elem->qp == qp) {
-			list_del(&elem->qp_list);
-			list_del(&elem->grp_list);
+	list_for_each_entry_safe(mce, tmp, &grp->qp_list, qp_list) {
+		if (mce->qp == qp) {
+			list_del(&mce->qp_list);
+			list_del(&mce->grp_list);
 			grp->num_qp--;
 
 			spin_unlock_bh(&grp->mcg_lock);
 			spin_unlock_bh(&qp->grp_lock);
-			rxe_drop_ref(elem);
+			rxe_drop_ref(mce);
 			rxe_drop_ref(grp);	/* ref held by QP */
 			rxe_drop_ref(grp);	/* ref from get_key */
 			return 0;
@@ -130,7 +142,7 @@ int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 void rxe_drop_all_mcast_groups(struct rxe_qp *qp)
 {
 	struct rxe_mc_grp *grp;
-	struct rxe_mc_elem *elem;
+	struct rxe_mc_elem *mce;
 
 	while (1) {
 		spin_lock_bh(&qp->grp_lock);
@@ -138,24 +150,24 @@ void rxe_drop_all_mcast_groups(struct rxe_qp *qp)
 			spin_unlock_bh(&qp->grp_lock);
 			break;
 		}
-		elem = list_first_entry(&qp->grp_list, struct rxe_mc_elem,
+		mce = list_first_entry(&qp->grp_list, struct rxe_mc_elem,
 					grp_list);
-		list_del(&elem->grp_list);
+		list_del(&mce->grp_list);
 		spin_unlock_bh(&qp->grp_lock);
 
-		grp = elem->grp;
+		grp = mce->grp;
 		spin_lock_bh(&grp->mcg_lock);
-		list_del(&elem->qp_list);
+		list_del(&mce->qp_list);
 		grp->num_qp--;
 		spin_unlock_bh(&grp->mcg_lock);
 		rxe_drop_ref(grp);
-		rxe_drop_ref(elem);
+		rxe_drop_ref(mce);
 	}
 }
 
-void rxe_mc_cleanup(struct rxe_pool_entry *arg)
+void rxe_mc_cleanup(struct rxe_pool_entry *pelem)
 {
-	struct rxe_mc_grp *grp = container_of(arg, typeof(*grp), pelem);
+	struct rxe_mc_grp *grp = container_of(pelem, struct rxe_mc_grp, pelem);
 	struct rxe_dev *rxe = grp->rxe;
 
 	rxe_drop_key(grp);
-- 
2.25.1

