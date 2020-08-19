Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD07F249381
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 05:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHSDlL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 23:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgHSDlK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 23:41:10 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AD0C061389
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:41:10 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id q9so18007485oth.5
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BFj9svqAn49bWAOym+Mk0LNETHQSVI8kSkZg1e4RA0U=;
        b=Zcme+CrZnJPUvqhMVMX4nxGNemkONZP9SCUreLhohBbSmrdHr7TfbSbOaHhqhcb2wY
         1PewsFDBSdctxNqKHt89CtPGnejiV6x7Bnw9F6SzWwYMSUT4kPFyuwLL8AwUYuI/LW5Q
         /nWTqWobduyIiq7KZvnX9PzqmgfMg4nAil6pdyuXPpwo4DrZzi6Q4TK8cziGKGsDlGLa
         iRZIUzPbwVMUCFAGgiJu8fPgQrnX6nvQLq2mQiHoVoas7uhOukW3+7sUhwfcKOTAbtkI
         T4E29K09C/QIRzw2Y8Xwu95tx6ZqXc039xFhQGFo9mbxfj3W+5WqIQmgC1rrQY65z+WR
         orbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFj9svqAn49bWAOym+Mk0LNETHQSVI8kSkZg1e4RA0U=;
        b=lvD6IS47LK696GqdDDwbadvgrh0swVTet6BjObg4JojRejErL0QRx1tCx+uLr2HNBl
         ENy3cyZr6L4OAnGL8CShahtsQ1niFEfGlbJgCT+8ZuUz8KTBT48qg7KZMXoNBF2DvCr4
         4lCibVGbM3LNC+pcvo3zsTjHiPc2hMGlABLd0AkWsmVWda1N0c9DBkK6SN5Ow4H2wJry
         yC2tXqNjsFG4CQKyzvGwiOcEIet2ALJTJgidzUckwixN4ZmWGTBr2M0+wf+5FUSDLgG0
         9PxJJgaTSwcA1l8prERfes2u4KU4+f2dhjYNz1Z9Rm3uXzsWjHuE7T1OH6pggLQ0Tj9/
         YBLg==
X-Gm-Message-State: AOAM5333Z7BjH11S2iTE/DXGXlwtTJ9gaABQ20xm+8Jdx2wDwKFw4+nN
        ZKrL5Qc+NtODIhfdfFCP7Sc=
X-Google-Smtp-Source: ABdhPJzL445+hLyYrrtYM2U5YQV+E2VMjn1MnkJOU4KcfPXkT3le8nbBWWzlXd9FIaJrdADDiQklNQ==
X-Received: by 2002:a9d:222a:: with SMTP id o39mr17103684ota.125.1597808469447;
        Tue, 18 Aug 2020 20:41:09 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:2731:80e6:14c6:1150])
        by smtp.gmail.com with ESMTPSA id m21sm4508668otr.36.2020.08.18.20.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 20:41:09 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v2 02/16] rdma_rxe: Fixed style warnings
Date:   Tue, 18 Aug 2020 22:39:50 -0500
Message-Id: <20200819034002.8835-3-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819034002.8835-1-rpearson@hpe.com>
References: <20200819034002.8835-1-rpearson@hpe.com>
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
index c4cab17188e2..d75cdc6c64d5 100644
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
index 8a7b23f6e7b6..0e6cf5aca4e8 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -579,6 +579,12 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
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
 
@@ -589,13 +595,10 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 
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

