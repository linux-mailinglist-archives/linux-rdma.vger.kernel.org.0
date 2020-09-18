Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363182707FC
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 23:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgIRVQD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 17:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgIRVQB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 17:16:01 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB75C0613D1
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:16:01 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id u25so6695556otq.6
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gzcRI0LUqZI0uCdAka1L6MX01AEVZ9hHG4Sx+ucGY8Y=;
        b=ok6M9iA3RZgbETYKwion0C9V2gwuflwbKKdWcIgek7ILArMqIkozMYMQHcRsLb8GbE
         q2UCWXyqmEezVEfXXhOE+b3K3OMiWkaRM9biBnXsz9SXy5Kbn36Fo15RLBFyUdOXurji
         q/MQ1HWpewUiuI5DnMx982xQRmI0yWETET0ZatwBqbm6ckugsdSqPPouIeGQPHRkuaF7
         3V5bI72UzO7qf/qCSrmcvW5GMsV92Fx0/oc34hNwzCaASvqB/Pfozzv/61Yo3wm9ZxfF
         emWpe4FXaZu2Ys2/1XIUS3hn43W5tuYX1jBUR0UttHMjPkRk1u3nfhD3Wte8wCzS9/nu
         Wd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gzcRI0LUqZI0uCdAka1L6MX01AEVZ9hHG4Sx+ucGY8Y=;
        b=SbgYorzH034NB+OdfmM6+FLyTXkuo43RLTsstOoBgr/OJ7vjIZBr8jg154lAp7YSMR
         D1D67XyE++NmFklPUdfNFt1Nigao02dZiwmDipPXlUnpJwAaN4n3nEbciSG6SvX0K68r
         00gEE/WP5Wms0gtA+Efr/RtZrAhD6MqyzQCxEHTbo1vbYo8009yYw7GG395SqA/WZGld
         IysOdet0JWizJ+ikFyATUaNNMGFsWQMz9VoXX6ZFhqzCZ+PNuxSfyuvs6yjQu3ryhROe
         uzppvtQnmzdngVOU7WKWtQ0pgp+1MJU4uddRwrgyGxl+IGQIVPfKYGiFZNCf/9yP4crn
         F2ug==
X-Gm-Message-State: AOAM5322z2lVk9WdTEQo38heQfUmRHQShi3mXn+ikEI9XopA9IHhDGb3
        pONMNKC4RUR/8aBIW30lIeA=
X-Google-Smtp-Source: ABdhPJw/lNWPSTNuhOKLZyua7VnRjS9nuM0+LCt2hIbMLb0JPIIgdQsxLng0/WfPQmvJFglJ/YMHmA==
X-Received: by 2002:a9d:6c8a:: with SMTP id c10mr5404481otr.169.1600463761005;
        Fri, 18 Sep 2020 14:16:01 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:4725:6035:508:6d87])
        by smtp.gmail.com with ESMTPSA id 91sm3194776ott.55.2020.09.18.14.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 14:16:00 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v5 11/12] rdma_rxe: Fix mcast group allocation bug
Date:   Fri, 18 Sep 2020 16:15:16 -0500
Message-Id: <20200918211517.5295-12-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918211517.5295-1-rpearson@hpe.com>
References: <20200918211517.5295-1-rpearson@hpe.com>
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
index b09c6594045a..d8831757e91e 100644
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
+	spin_lock_irqsave(&pool->pool_lock, flags);
+	grp = __get_key(pool, mgid);
+	if (grp)
+		goto done;
+
+	grp = create_grp(rxe, pool, mgid);
+	if (unlikely(!grp))
+		err = -ENOMEM;
 done:
+	spin_unlock_irqrestore(&pool->pool_lock, flags);
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

