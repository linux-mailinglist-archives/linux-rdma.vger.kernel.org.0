Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B3649ED83
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiA0ViL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344409AbiA0ViK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:10 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9C7C061747
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:10 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id z25-20020a0568301db900b005946f536d85so3861929oti.9
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I195ccDuUg3aeOIrfH5jOfm/YAvtHvM1sJOKVc6Rd/M=;
        b=nOqdu12x0ZyVCB7XCKPcQMTle9QMV3F9rehbYSNNQGk5CfIzfjlljOwtdHUdduXTaT
         z2363E2UADpfJn1wlWBkUtBTy/bxi/mr7shUq1vmPG18q/kRNV8Ojd5tANwlCEiMcRJH
         dgafOEkgW8q5ysrunL+iYTuGv6A8wHCwYKTk823aAf7NrFUZsiQumtPjwjSTIlFMDFfs
         TWS5fKNrf8OpG8mO/Ca9Oldr594pctgG7pYzAS8fupTR86UeXsVtJjII/T5cs5tFT9Vz
         w55+hp5vFSN60mfHwvTavjcnwA7c62CcMzM5uNsOo2XwNW1lw4Do/NXjUOAtHWITUQzc
         bDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I195ccDuUg3aeOIrfH5jOfm/YAvtHvM1sJOKVc6Rd/M=;
        b=GFVIVA0xOthrawHYfkZA1jkYPGJi+yVclTkB9x6BXiM2+EW87QjWbRr0WTNz9GeuQb
         xXkV65cNItOUNOgZC9gtx2zc8I3JOAs+HWV0dvuPt90IiJxKRWCY0mguU/WbPgPyK96X
         +gQ0uDJusMbXy5r/FsIymrYaDFx7+i/oKO0zdn3JHBSLNYVyjDSteeCz/tn5uaHDzHWc
         NJPpq3iNZGSmNA0jcHs24w22KRvZ5oAfSrITsbaHxxRommS9oRqBDLZZIqejFv3nCNbk
         HYJQTI981aVkWcffKPFDl5XTdiQtyLl9kXL7WiiCfrH/tMc7XB/CJsYOffeIGbN5Xh/8
         dgeQ==
X-Gm-Message-State: AOAM530HS78H+/Aasqv4KHFx4bjXsKhgdxRJFsY4jzmOCF8aPB0IsZlb
        Zg4bcH8DpJYamA7rT2A8C5E=
X-Google-Smtp-Source: ABdhPJz0yGcWBPuS6AhonP+bN9bVh4u+VDZzIEsWw7rgHR0jspNN7w4XioupM9sPuL19qZ9BTLePXQ==
X-Received: by 2002:a9d:6647:: with SMTP id q7mr3236990otm.268.1643319490048;
        Thu, 27 Jan 2022 13:38:10 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:09 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 06/26] RDMA/rxe: Remove qp->grp_lock and qp->grp_list
Date:   Thu, 27 Jan 2022 15:37:35 -0600
Message-Id: <20220127213755.31697-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since it is no longer required to cleanup attachments to multicast
groups when a QP is destroyed qp->grp_lock and qp->grp_list are
no longer needed and are removed.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 8 --------
 drivers/infiniband/sw/rxe/rxe_qp.c    | 3 ---
 drivers/infiniband/sw/rxe/rxe_verbs.h | 5 -----
 3 files changed, 16 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 39a41daa7a6b..9336295c4ee2 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -88,7 +88,6 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	struct rxe_mca *elem;
 
 	/* check to see of the qp is already a member of the group */
-	spin_lock_bh(&qp->grp_lock);
 	spin_lock_bh(&grp->mcg_lock);
 	list_for_each_entry(elem, &grp->qp_list, qp_list) {
 		if (elem->qp == qp) {
@@ -113,16 +112,13 @@ static int rxe_mcast_add_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	grp->num_qp++;
 	elem->qp = qp;
-	elem->grp = grp;
 	atomic_inc(&qp->mcg_num);
 
 	list_add(&elem->qp_list, &grp->qp_list);
-	list_add(&elem->grp_list, &qp->grp_list);
 
 	err = 0;
 out:
 	spin_unlock_bh(&grp->mcg_lock);
-	spin_unlock_bh(&qp->grp_lock);
 	return err;
 }
 
@@ -136,18 +132,15 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	if (!grp)
 		goto err1;
 
-	spin_lock_bh(&qp->grp_lock);
 	spin_lock_bh(&grp->mcg_lock);
 
 	list_for_each_entry_safe(elem, tmp, &grp->qp_list, qp_list) {
 		if (elem->qp == qp) {
 			list_del(&elem->qp_list);
-			list_del(&elem->grp_list);
 			grp->num_qp--;
 			atomic_dec(&qp->mcg_num);
 
 			spin_unlock_bh(&grp->mcg_lock);
-			spin_unlock_bh(&qp->grp_lock);
 			rxe_drop_ref(elem);
 			rxe_drop_ref(grp);	/* ref held by QP */
 			rxe_drop_ref(grp);	/* ref from get_key */
@@ -156,7 +149,6 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	}
 
 	spin_unlock_bh(&grp->mcg_lock);
-	spin_unlock_bh(&qp->grp_lock);
 	rxe_drop_ref(grp);			/* ref from get_key */
 err1:
 	return -EINVAL;
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 087126550caf..742073ce0709 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -188,9 +188,6 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
 		break;
 	}
 
-	INIT_LIST_HEAD(&qp->grp_list);
-
-	spin_lock_init(&qp->grp_lock);
 	spin_lock_init(&qp->state_lock);
 
 	atomic_set(&qp->ssn, 0);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 4910d0782e33..55f8ed2bc621 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -232,9 +232,6 @@ struct rxe_qp {
 	struct rxe_av		pri_av;
 	struct rxe_av		alt_av;
 
-	/* list of mcast groups qp has joined (for cleanup) */
-	struct list_head	grp_list;
-	spinlock_t		grp_lock; /* guard grp_list */
 	atomic_t		mcg_num;
 
 	struct sk_buff_head	req_pkts;
@@ -368,9 +365,7 @@ struct rxe_mcg {
 struct rxe_mca {
 	struct rxe_pool_elem	elem;
 	struct list_head	qp_list;
-	struct list_head	grp_list;
 	struct rxe_qp		*qp;
-	struct rxe_mcg		*grp;
 };
 
 struct rxe_port {
-- 
2.32.0

