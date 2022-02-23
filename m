Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D987D4C1F5D
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 00:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244716AbiBWXIP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 18:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244717AbiBWXIO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 18:08:14 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E46E12765
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 15:07:45 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id q5so665577oij.6
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 15:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=romtMJKtpyWJ2vGgfrYWZGHob+oyOiudg6/6oHjcTbM=;
        b=iNkv7zquTECiSmd6k1rYEHNG0GEQH7wlFZtKHWr/DRELDDAOyILw/JRRGHTtB+fPGR
         EzHu5+P8OC6XaZoyoeocOLW9iFfXOHxGnMLPxHMjq5mS4tAPA5Guu+T11hWJH2dZOrbr
         88ziBlldBnPCAwAcn6Z2g9vAxzadl/H62HYw181hQvrnMNIG5dQVYXe+T5HRHBhiLIEt
         FVy93k4OaM/ipicN9420F86zf/qxwVctwtjSxGXhRKjkyOvM4z4X0JhDeffIp3wANTHp
         tmC/PaSa4Ada3u1JpDdep4Jn6IqM+nzT/em9HCv0xspyT3pv9IMbi+ckgYi2+upJk3vZ
         St9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=romtMJKtpyWJ2vGgfrYWZGHob+oyOiudg6/6oHjcTbM=;
        b=ifOzR1UOdlvwrStjCAjVDCgBxIBhqqf+FHAHmV2PYbwckRP7++UQCMvMDQpG/0GwnI
         AunBJkMioxM+ak37c0NbTVaFV5PClQa0/XRaJplvxWsJ8fIyEpdwUS+YvkQBSWz3dagT
         PDiz0OpubMOJ4KodX/H6ZYdS6Bm8m1vIgrlleEvkhpROCHvXOT6OTUH/MDPW81i/DLYi
         my3s7YUSVFLG6d0kL69Qm8uvH5LQFNMbl86aaAcwaLntjMYKbgm396nnJ2T5IRgMsplr
         9Ijp7jwP/m3iUkwsC9Ril1ltgFcaqqXKPIJsPhLYv2R+t09Vsj0NNzK1v6+m8ICzZhN8
         /gvA==
X-Gm-Message-State: AOAM533glgpXsuNqfXJ5Yn00s8HIZT1C0FDl5v+IfdLzUhUuzmq6aZlA
        KDRIvfXGO40Y+STWkTHIbcq4kGv8sgI=
X-Google-Smtp-Source: ABdhPJyG7z29wVF8U7F0cllkCI6nF4EuzYziYsFmXUevY+uQcge7VsF4j0OvaxJTNLDPnoceuAnEjw==
X-Received: by 2002:a05:6808:13cb:b0:2d3:7f26:1c52 with SMTP id d11-20020a05680813cb00b002d37f261c52mr1051330oiw.309.1645657664546;
        Wed, 23 Feb 2022 15:07:44 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-809e-284a-c7bf-c6d9.res6.spectrum.com. [2603:8081:140c:1a00:809e:284a:c7bf:c6d9])
        by smtp.googlemail.com with ESMTPSA id y3sm505030oiv.21.2022.02.23.15.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 15:07:44 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v13 for-next 4/6] RDMA/rxe: Cleanup rxe_mcast.c
Date:   Wed, 23 Feb 2022 17:07:06 -0600
Message-Id: <20220223230706.50332-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220223230706.50332-1-rpearsonhpe@gmail.com>
References: <20220223230706.50332-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Finish adding subroutine comment headers to subroutines in
rxe_mcast.c. Make minor api change cleanups.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 97 +++++++++++++++++++++------
 1 file changed, 78 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 66c1ae703976..c399a29b648b 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -1,12 +1,33 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * Copyright (c) 2022 Hewlett Packard Enterprise, Inc. All rights reserved.
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
  */
 
+/*
+ * rxe_mcast.c implements driver support for multicast transport.
+ * It is based on two data structures struct rxe_mcg ('mcg') and
+ * struct rxe_mca ('mca'). An mcg is allocated each time a qp is
+ * attached to a new mgid for the first time. These are indexed by
+ * a red-black tree using the mgid. This data structure is searched
+ * for the mcg when a multicast packet is received and when another
+ * qp is attached to the same mgid. It is cleaned up when the last qp
+ * is detached from the mcg. Each time a qp is attached to an mcg an
+ * mca is created. It holds a pointer to the qp and is added to a list
+ * of qp's that are attached to the mcg. The qp_list is used to replicate
+ * mcast packets in the rxe receive path.
+ */
+
 #include "rxe.h"
-#include "rxe_loc.h"
 
+/**
+ * rxe_mcast_add - add multicast address to rxe device
+ * @rxe: rxe device object
+ * @mgid: multicast address as a gid
+ *
+ * Returns 0 on success else an error
+ */
 static int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	unsigned char ll_addr[ETH_ALEN];
@@ -16,6 +37,13 @@ static int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
 	return dev_mc_add(rxe->ndev, ll_addr);
 }
 
+/**
+ * rxe_mcast_delete - delete multicast address from rxe device
+ * @rxe: rxe device object
+ * @mgid: multicast address as a gid
+ *
+ * Returns 0 on success else an error
+ */
 static int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	unsigned char ll_addr[ETH_ALEN];
@@ -216,7 +244,7 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 
 /**
  * rxe_cleanup_mcg - cleanup mcg for kref_put
- * @kref:
+ * @kref: struct kref embnedded in mcg
  */
 void rxe_cleanup_mcg(struct kref *kref)
 {
@@ -299,9 +327,17 @@ static int __rxe_init_mca(struct rxe_qp *qp, struct rxe_mcg *mcg,
 	return 0;
 }
 
-static int rxe_attach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
-				  struct rxe_mcg *mcg)
+/**
+ * rxe_attach_mcg - attach qp to mcg if not already attached
+ * @qp: qp object
+ * @mcg: mcg object
+ *
+ * Context: caller must hold reference on qp and mcg.
+ * Returns: 0 on success else an error
+ */
+static int rxe_attach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 {
+	struct rxe_dev *rxe = mcg->rxe;
 	struct rxe_mca *mca, *tmp;
 	unsigned long flags;
 	int err;
@@ -358,17 +394,19 @@ static void __rxe_cleanup_mca(struct rxe_mca *mca, struct rxe_mcg *mcg)
 	kfree(mca);
 }
 
-static int rxe_detach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
-				   union ib_gid *mgid)
+/**
+ * rxe_detach_mcg - detach qp from mcg
+ * @mcg: mcg object
+ * @qp: qp object
+ *
+ * Returns: 0 on success else an error if qp is not attached.
+ */
+static int rxe_detach_mcg(struct rxe_mcg *mcg, struct rxe_qp *qp)
 {
-	struct rxe_mcg *mcg;
+	struct rxe_dev *rxe = mcg->rxe;
 	struct rxe_mca *mca, *tmp;
 	unsigned long flags;
 
-	mcg = rxe_lookup_mcg(rxe, mgid);
-	if (!mcg)
-		return -EINVAL;
-
 	spin_lock_irqsave(&rxe->mcg_lock, flags);
 	list_for_each_entry_safe(mca, tmp, &mcg->qp_list, qp_list) {
 		if (mca->qp == qp) {
@@ -378,16 +416,11 @@ static int rxe_detach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
 			 * mcast group falls to zero go ahead and
 			 * tear it down. This will not free the
 			 * object since we are still holding a ref
-			 * from the get key above
+			 * from the caller
 			 */
 			if (atomic_read(&mcg->qp_num) <= 0)
 				__rxe_destroy_mcg(mcg);
 
-			/* drop the ref from get key. This will free the
-			 * object if qp_num is zero.
-			 */
-			kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
-
 			spin_unlock_irqrestore(&rxe->mcg_lock, flags);
 			return 0;
 		}
@@ -398,6 +431,14 @@ static int rxe_detach_mcg(struct rxe_dev *rxe, struct rxe_qp *qp,
 	return -EINVAL;
 }
 
+/**
+ * rxe_attach_mcast - attach qp to multicast group (see IBA-11.3.1)
+ * @ibqp: (IB) qp object
+ * @mgid: multicast IP address
+ * @mlid: multicast LID, ignored for RoCEv2 (see IBA-A17.5.6)
+ *
+ * Returns: 0 on success else an errno
+ */
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 {
 	int err;
@@ -410,20 +451,38 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 	if (IS_ERR(mcg))
 		return PTR_ERR(mcg);
 
-	err = rxe_attach_mcg(rxe, qp, mcg);
+	err = rxe_attach_mcg(mcg, qp);
 
 	/* if we failed to attach the first qp to mcg tear it down */
 	if (atomic_read(&mcg->qp_num) == 0)
 		rxe_destroy_mcg(mcg);
 
 	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
+
 	return err;
 }
 
+/**
+ * rxe_detach_mcast - detach qp from multicast group (see IBA-11.3.2)
+ * @ibqp: address of (IB) qp object
+ * @mgid: multicast IP address
+ * @mlid: multicast LID, ignored for RoCEv2 (see IBA-A17.5.6)
+ *
+ * Returns: 0 on success else an errno
+ */
 int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
 {
 	struct rxe_dev *rxe = to_rdev(ibqp->device);
 	struct rxe_qp *qp = to_rqp(ibqp);
+	struct rxe_mcg *mcg;
+	int err;
+
+	mcg = rxe_lookup_mcg(rxe, mgid);
+	if (!mcg)
+		return -EINVAL;
 
-	return rxe_detach_mcg(rxe, qp, mgid);
+	err = rxe_detach_mcg(mcg, qp);
+	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
+
+	return err;
 }
-- 
2.32.0

