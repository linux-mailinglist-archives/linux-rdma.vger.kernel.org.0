Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463F94A5215
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 23:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiAaWKK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 17:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiAaWKJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jan 2022 17:10:09 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A9FC061401
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:09 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id b17-20020a9d4791000000b005a17fc2dfc1so14447686otf.1
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bBWAAFZqjiekU7uNW+ATIBkmLHIoGKYvK4qdlLNklN4=;
        b=QMidn0fHi+oQq86YaV2pXxhPPQwcu6BMX1sapvh8nvaP9O5auAx06xKGrWXKtO6Dz/
         kcUynC3qvmlS7vlh9OdpsJUl06z3x68lCUHWQ2EGUE0zVrtX0mkvb22WEPSVRhO/fu1f
         UaNB5DpU0m1jiuvRnBmKG1wYAWn0iHzOSbzHJ8P3e/2ISv26bdagicO95xLfrAOkkWgj
         2uaqkWMOslGXnJ0/0mOc0552Ohp7bVDo79sgyDxUpyHeV18VV6t8uavUjHxpX85hj+VD
         sOeCapTxGlXV8yNGrucEnInm8UZv66p0ucWwu1eemIHm7iHnNG1io8JvNdKmbgbfjFLu
         6J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bBWAAFZqjiekU7uNW+ATIBkmLHIoGKYvK4qdlLNklN4=;
        b=dB8a0unUlSzMTvbGzM2Q+7V6wivdCcORetitU4BZbDALLYopZv4Ebkd1bJ6zGRdJgw
         ZF8pOEWEWgxUtvLYJTxV08jF9DH+iBMCzj4kka2A8bcvvxu/4wUetan5iPY8jiff0Rye
         zHlWpK57ddfivAcbwxClvillDOfEs7Ana4iT31JBOBxLv5fTpX4iSIFMH6uMETV3djTz
         lfIMZxDuawJpg5MyEUnZbMXl3dBm0RQihiMLVHgCTpQfhDqeCrAFGIefiAQZZIuWMpnM
         mi5V2US93iZrJrZSYvnQzWjTEIH6daOM6OHsq3M1XyimWPKMnTq/FJv4TyVca1Jy3rqu
         WS/g==
X-Gm-Message-State: AOAM530awXvGXkJOZ+8WK12Wye0cYsh8F3nfD1U74tryr0igf86jIMtW
        2rWiR1nQszlR4679rUPGfl6vtdksVhM=
X-Google-Smtp-Source: ABdhPJymg9GxZHKfuLS/yXqSC8ovU74qtab6sfLFH1fIZoRR7y1oQPXXiVyqPv2j8l5kM6JqJ3yywQ==
X-Received: by 2002:a05:6830:2a8b:: with SMTP id s11mr13020369otu.8.1643667008757;
        Mon, 31 Jan 2022 14:10:08 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-5c63-4cee-84ac-42bc.res6.spectrum.com. [2603:8081:140c:1a00:5c63:4cee:84ac:42bc])
        by smtp.googlemail.com with ESMTPSA id t21sm8304929otq.81.2022.01.31.14.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:10:08 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 06/17] RDMA/rxe: Remove qp->grp_lock and qp->grp_list
Date:   Mon, 31 Jan 2022 16:08:39 -0600
Message-Id: <20220131220849.10170-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220849.10170-1-rpearsonhpe@gmail.com>
References: <20220131220849.10170-1-rpearsonhpe@gmail.com>
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
index a21d704dc376..58ccca96c209 100644
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

