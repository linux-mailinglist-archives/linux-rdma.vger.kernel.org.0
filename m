Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED3B4BAE9F
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Feb 2022 01:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiBRAhG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 19:37:06 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiBRAhF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 19:37:05 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C456B31237
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 16:36:45 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id a7-20020a9d5c87000000b005ad1467cb59so912152oti.5
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 16:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h8YV6G4SA28VG3l3LlgZPG/Xvx1jl/CM5kjGq324Qq8=;
        b=errBIHRt9ZtTVzrpddJjCAbZp/7vDxqAmdsbur4BwpdJwRg8pfsFQ7ArpZlFnL4VL6
         RiI6Uu6cIsmSnxu81JqDHKy5S6ujS+riY8kqJIRx9CBlGnI6SjcQYQ8TI2ysFJCDyPLi
         w0UohUGINBac9j/fj/ajwQRP+9x1AqXSYiRCtN7PN0MClQDdxbQhCx5ol1xsVu+ioXQG
         UgDN3aNiuecCD6tzKM7Cwy2HCuTMtfX3c8TNPAS3AW/xQKGbbbutWtrkZwBbHeFlpQ2f
         JHXSSiPbFs9zDPjQ5pImGB0x3hAOgKDb9VjU+tLq19Nl5PDqSnFQNyQUQhewJBudl/qu
         4wsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h8YV6G4SA28VG3l3LlgZPG/Xvx1jl/CM5kjGq324Qq8=;
        b=P75dHDXfNRWsxhawXAYQLLQJ7uTDJxcNE24+vCEaLkpjQrXENXE7+HCNCiTm1Zn4Uu
         vJluwaEDneHMH+nxogOWcl0k/Ob3fO+S7UYnOhucc14GzSCnqVWSC0CPjJ1Ziy4v4DDw
         E7sluI9lLzYOY/5w20oRrVwhYgSA3cf4lj/4N445QrwByD586xOh0v8Ln2Z+tZGk4r3r
         E18y//PsqW+RIzoWv+QHPBYKBPn12kECBZ51a+HwAQ2VPXwl+QsZWbK+6dsMFHvH1TwH
         iJg5ov/AAoU7L9JylT7m6u3ggWRVV0OJG3BQBYOcg2OpXfEvE9s2LEK9484SXniL2M1T
         MP8Q==
X-Gm-Message-State: AOAM532f9/9oIrZC8gm1focAqh6vJJzM7AXyqQWoOosDcI0y+YmDqVK8
        0zVyKyJ0tE/W2oyfWGHqQDI=
X-Google-Smtp-Source: ABdhPJxwVnqtd6/5onAKUHdGsXMS4Uc1Ewg3v6xwoaG/qsSPmMoRtMh9fqvCgHB3w9tBckm7MdFylw==
X-Received: by 2002:a9d:1283:0:b0:5ad:1073:1436 with SMTP id g3-20020a9d1283000000b005ad10731436mr1766835otg.370.1645144603577;
        Thu, 17 Feb 2022 16:36:43 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-1772-15fa-cf3f-3cd5.res6.spectrum.com. [2603:8081:140c:1a00:1772:15fa:cf3f:3cd5])
        by smtp.googlemail.com with ESMTPSA id t31sm19698299oaa.9.2022.02.17.16.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:36:43 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v12 4/6] RDMA/rxe: Cleanup rxe_mcast.c
Date:   Thu, 17 Feb 2022 18:35:42 -0600
Message-Id: <20220218003543.205799-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220218003543.205799-1-rpearsonhpe@gmail.com>
References: <20220218003543.205799-1-rpearsonhpe@gmail.com>
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
index 0f0655e81d40..349a6fac2fcc 100644
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
@@ -410,22 +451,40 @@ int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid)
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
 
 /**
-- 
2.32.0

