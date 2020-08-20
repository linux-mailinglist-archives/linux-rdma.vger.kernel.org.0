Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA25124C7E9
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 00:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgHTWrV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 18:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgHTWrP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 18:47:15 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5A8C061385
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:15 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v6so124018ota.13
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJ78iBOtJKgSzmxm9gmcuQV2b7GcdOiNq2waT/j6EfI=;
        b=FdAC9/9OFvq0D9PM1XJ62d7fYfhH6DiQt+Ep5IboP6i3R1RkGa+fxGA/otBehUmyWt
         8prf+infQbHWtQgMGrngM899l172WOMYMcqPCJiH8WgpJGMg5nCsU3WY8q9zqzahXHbg
         gCZZSehiRl3lipiZijdkbHO4NMVB+kveygltOtN6KhRziP8pyzpAnSUGT9NW3r2mCbGA
         Li9KmigAZ34iki92xXQdyjzY10mCDJQuPiw+mAGEuCYLomNEHpby+MspROPmqMTuYWVb
         laJCIPfHhN4uo+uYq3cWMAu2FNRqE7G75cRDeuZ2+e3jGWC2mmYSNd5GoACXPuGUT9X1
         sMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJ78iBOtJKgSzmxm9gmcuQV2b7GcdOiNq2waT/j6EfI=;
        b=a0QvN5Eal0d7MrMgfuv9eS9y8xGYTx9/RieiUDvmkhg/TV1XxcKqFrvkvLehPF1/3O
         uFbYRg1MnYs7sC61XF+syMt6rsc34kDQT/a+PmMTqio7OvjbY2+kVh/E2FC2T7RHjDng
         17XlxR9eTZdN7gQyCoXihFtZoJcALNU7+Hbt4OX5x6q6S0W6NjV45m6pZZS80+ImZ+mB
         xILVoM6VyULZAr/pDcJs19fjnfIwGwZI6KWPyF5MLjJcruwJkrACVE8s+AVQTT4dYX5B
         B/3vWH3rtk5Cn+8xf+uzPMPPPPCz4EB5HbpnFZn/H9pYUojbwovNFXh8OgkLEM6GVUkI
         SjTA==
X-Gm-Message-State: AOAM530JmsO0VhQWoLgoc+nEwiZ7qwNsr2Hp1YnWRbntQCisa3faIL/w
        dXrWYOgvPS/KzRhpCyRLwsdyhkQRgGN7/A==
X-Google-Smtp-Source: ABdhPJyXTVledXwjr7ymfm/xPP5brDbTLdMTwJpVoNWtlfW41eSYAlXlKHvgi3QcebNc70XzimU8Yg==
X-Received: by 2002:a05:6830:1c1:: with SMTP id r1mr108923ota.100.1597963634652;
        Thu, 20 Aug 2020 15:47:14 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:e2a0:5228:a0c3:36eb])
        by smtp.gmail.com with ESMTPSA id k18sm750988otj.55.2020.08.20.15.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 15:47:14 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v3 02/17] rdma_rxe: Fixed style warnings
Date:   Thu, 20 Aug 2020 17:46:23 -0500
Message-Id: <20200820224638.3212-3-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820224638.3212-1-rpearson@hpe.com>
References: <20200820224638.3212-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixed several minor checkpatch warnings in existing rxe source.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  |  3 +--
 drivers/infiniband/sw/rxe/rxe_net.c   |  2 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  3 +--
 drivers/infiniband/sw/rxe/rxe_task.h  |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 13 ++++++++-----
 include/uapi/rdma/rdma_user_rxe.h     |  6 +++---
 6 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index ab1e61ca98d0..d9a527c138d3 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -665,9 +665,8 @@ int rxe_completer(void *arg)
 			 */
 
 			/* there is nothing to retry in this case */
-			if (!wqe || (wqe->state == wqe_state_posted)) {
+			if (!wqe || (wqe->state == wqe_state_posted))
 				goto exit;
-			}
 
 			/* if we've started a retry, don't start another
 			 * retry sequence, unless this is a timeout.
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 8c390da4897b..7650cf348c48 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -95,7 +95,7 @@ static struct dst_entry *rxe_find_route6(struct net_device *ndev,
 	ndst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(recv_sockets.sk6->sk),
 					       recv_sockets.sk6->sk, &fl6,
 					       NULL);
-	if (unlikely(IS_ERR(ndst))) {
+	if (IS_ERR(ndst)) {
 		pr_err_ratelimited("no route to %pI6\n", daddr);
 		return NULL;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index b6bf74b2fe06..edfd8e7a21d4 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -603,9 +603,8 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 	if (mask & IB_QP_QKEY)
 		qp->attr.qkey = attr->qkey;
 
-	if (mask & IB_QP_AV) {
+	if (mask & IB_QP_AV)
 		rxe_init_av(&attr->ah_attr, &qp->pri_av);
-	}
 
 	if (mask & IB_QP_ALT_PATH) {
 		rxe_init_av(&attr->alt_ah_attr, &qp->alt_av);
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 1b5bc405cafe..b2920a663683 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -35,7 +35,7 @@ struct rxe_task {
 /*
  * init rxe_task structure
  *	arg  => parameter to pass to fcn
- *	fcn  => function to call until it returns != 0
+ *	func => function to call until it returns != 0
  */
 int rxe_init_task(void *obj, struct rxe_task *task,
 		  void *arg, int (*func)(void *), char *name);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 9aaf3a9fed7c..c2d09998b778 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -566,6 +566,12 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	    qp_type(qp) == IB_QPT_GSI)
 		memcpy(&wqe->av, &to_rah(ud_wr(ibwr)->ah)->av, sizeof(wqe->av));
 
+	if (mask & WR_REG_MASK) {
+		wqe->mask = mask;
+		wqe->state = wqe_state_posted;
+		return 0;
+	}
+
 	if (unlikely(ibwr->send_flags & IB_SEND_INLINE)) {
 		p = wqe->dma.inline_data;
 
@@ -576,13 +582,10 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 
 			p += sge->length;
 		}
-	} else if (mask & WR_REG_MASK) {
-		wqe->mask = mask;
-		wqe->state = wqe_state_posted;
-		return 0;
-	} else
+	} else {
 		memcpy(wqe->dma.sge, ibwr->sg_list,
 		       num_sge * sizeof(struct ib_sge));
+	}
 
 	wqe->iova = mask & WR_ATOMIC_MASK ? atomic_wr(ibwr)->remote_addr :
 		mask & WR_READ_OR_WRITE_MASK ? rdma_wr(ibwr)->remote_addr : 0;
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index aae2e696bb38..d8f2e0e46dab 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -99,8 +99,8 @@ struct rxe_send_wr {
 				struct ib_mr *mr;
 				__aligned_u64 reserved;
 			};
-			__u32        key;
-			__u32        access;
+			__u32	     key;
+			__u32	     access;
 		} reg;
 	} wr;
 };
@@ -112,7 +112,7 @@ struct rxe_sge {
 };
 
 struct mminfo {
-	__aligned_u64  		offset;
+	__aligned_u64		offset;
 	__u32			size;
 	__u32			pad;
 };
-- 
2.25.1

