Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FCF4A5214
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 23:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiAaWKJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 17:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbiAaWKI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jan 2022 17:10:08 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB1CC06173D
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:08 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id w27-20020a9d5a9b000000b005a17d68ae89so14414490oth.12
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ggLkkJhVtjmI0551cLLsUXr/tcgbpb+AmLL1Pmf4XGw=;
        b=iOLuCmBISanH0dXjHGZgViAyW2noZGgiomgT9n20PJV4/1UsVFIc38eS+yUI5uUtrw
         Ok6h15rsxPxk9SXQkrNcyUTGdpd5qHcL7YxbgIL8NZQYWYHoa5ydT8OXSC+gmlob3gRu
         lWXXWLwhB64JQsv2rp8AHCsIRX2NBW3j3Wa8vKg4nDERO1h0MEVCERvihDOQs85Qt6Da
         jjZmiuyYf+O1QY3EnOe0hKmIu96gR2QGwCbnjweJm8R8H050zFdXI+q0lAN3Uv3al2rq
         4yPHrDtugY67xaxalEnTbdWC9pPPduX32QOXxQtOQ165nxVUUU0TzSA8iBWEoMJtSJig
         c7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ggLkkJhVtjmI0551cLLsUXr/tcgbpb+AmLL1Pmf4XGw=;
        b=tSefW2nJvPAYpJKH0a9H0JY3ocgTIXq+vlBmRjfcQ7izrOwdLPnV7Gx1MTsJK6sSeH
         1fgat0wOeOEqji5Kx7HcBzikusAQoc3GG85hkA8K1ZYzkEF45ea9ylD3O9dqLUg/Ad3W
         t6YYHCsn9Wh/47+2i/R8p9B0AJjG3R7+O+/uYh3wAWunxDcnKKibJ6RYRqSXdwuvqGWx
         Qlb0rqcEzdRWh7LBaIwYZW02zdI0/stEbf+SYvzEjbytwbknSQQrJM9ezEgrRbZxRcnv
         cJK2NDuEf+G4Oj3hLM8oXP3bgpqLSpDuS9rsXJDtcEGc5sK0uGvU33VvGVlffHcS/DxT
         9l0Q==
X-Gm-Message-State: AOAM530MsRSsbWF8aQr3Id+fNuMQr72VQJBqtGoVW212Cm4BmNmtRNKv
        33NAY3v6Mvsqkx52aCyqh1E=
X-Google-Smtp-Source: ABdhPJzaHSVNgcwpoOe/1ZpZptk9JuiqT3q2zvwoBG57y4pvy3+G+Iigb6C/Kb1R3/31GX2ftoD/Sg==
X-Received: by 2002:a05:6830:34a3:: with SMTP id c35mr11176829otu.113.1643667008003;
        Mon, 31 Jan 2022 14:10:08 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-5c63-4cee-84ac-42bc.res6.spectrum.com. [2603:8081:140c:1a00:5c63:4cee:84ac:42bc])
        by smtp.googlemail.com with ESMTPSA id t21sm8304929otq.81.2022.01.31.14.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:10:07 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 05/17] RDMA/rxe: Remove rxe_drop_all_macst_groups
Date:   Mon, 31 Jan 2022 16:08:38 -0600
Message-Id: <20220131220849.10170-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220849.10170-1-rpearsonhpe@gmail.com>
References: <20220131220849.10170-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

With o10-2.2.3 enforced rxe_drop_all_mcast_groups is completely
unnecessary. Remove it and references to it.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 -
 drivers/infiniband/sw/rxe/rxe_mcast.c | 26 --------------------------
 drivers/infiniband/sw/rxe/rxe_qp.c    |  2 --
 3 files changed, 29 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 052beaaacf43..af40e3c212fb 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -40,7 +40,6 @@ void rxe_cq_disable(struct rxe_cq *cq);
 void rxe_cq_cleanup(struct rxe_pool_elem *arg);
 
 /* rxe_mcast.c */
-void rxe_drop_all_mcast_groups(struct rxe_qp *qp);
 void rxe_mc_cleanup(struct rxe_pool_elem *arg);
 int rxe_attach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
 int rxe_detach_mcast(struct ib_qp *ibqp, union ib_gid *mgid, u16 mlid);
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 34e3c52f0b72..39a41daa7a6b 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -162,32 +162,6 @@ static int rxe_mcast_drop_grp_elem(struct rxe_dev *rxe, struct rxe_qp *qp,
 	return -EINVAL;
 }
 
-void rxe_drop_all_mcast_groups(struct rxe_qp *qp)
-{
-	struct rxe_mcg *grp;
-	struct rxe_mca *elem;
-
-	while (1) {
-		spin_lock_bh(&qp->grp_lock);
-		if (list_empty(&qp->grp_list)) {
-			spin_unlock_bh(&qp->grp_lock);
-			break;
-		}
-		elem = list_first_entry(&qp->grp_list, struct rxe_mca,
-					grp_list);
-		list_del(&elem->grp_list);
-		spin_unlock_bh(&qp->grp_lock);
-
-		grp = elem->grp;
-		spin_lock_bh(&grp->mcg_lock);
-		list_del(&elem->qp_list);
-		grp->num_qp--;
-		spin_unlock_bh(&grp->mcg_lock);
-		rxe_drop_ref(grp);
-		rxe_drop_ref(elem);
-	}
-}
-
 void rxe_mc_cleanup(struct rxe_pool_elem *elem)
 {
 	struct rxe_mcg *grp = container_of(elem, typeof(*grp), elem);
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 99284337f547..a21d704dc376 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -812,8 +812,6 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 {
 	struct rxe_qp *qp = container_of(work, typeof(*qp), cleanup_work.work);
 
-	rxe_drop_all_mcast_groups(qp);
-
 	if (qp->sq.queue)
 		rxe_queue_cleanup(qp->sq.queue);
 
-- 
2.32.0

