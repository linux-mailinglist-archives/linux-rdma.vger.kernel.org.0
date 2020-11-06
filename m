Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07482AA0AA
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Nov 2020 00:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgKFXDj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 18:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbgKFXDi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Nov 2020 18:03:38 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EAAC0613CF
        for <linux-rdma@vger.kernel.org>; Fri,  6 Nov 2020 15:03:37 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 79so2816296otc.7
        for <linux-rdma@vger.kernel.org>; Fri, 06 Nov 2020 15:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EhfFDUF5i5qCKXgT6BjsdoPpHicleSke0j68SQ5OKdI=;
        b=jFW11lP3XPzX7ZW/zPRaHN86Ea63D4xfkpBfJNKLI/06vCJPVJIrRhjm3NyExs7TK2
         an9HA6Mrns1MMYcRJIFYedbGk2JVD5nFUC2dcFaoYsB/quxmQnqwdAP1vUx5QiiKzbou
         u9XukZIjZPx9w7De0V3DMiKwwgdJVWxvy+sOReogBW3ZyFONnWOMHOaDjf4zXGIKbKN/
         OrRnd8CAHw4bGojzW/y5l5OhzNBYR8wMZVcuQFNaR2/5iDaFM4Eak13Mg5Huo9K0nVKv
         wWJzor8WJ7JwhB0UOuur2u1g9k7iD4STrOj9yhx4Pg8D8DFnyo5OOD1Rj1nAlfMgYsao
         4pBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EhfFDUF5i5qCKXgT6BjsdoPpHicleSke0j68SQ5OKdI=;
        b=QzNnAJi+3k0QsgtJgyVB/14HMiny8l4Pikv/WNnhtpGVRm8gYqYLWb/WnivAr+BXgU
         KwaUePnh0GdmhdrTitvWnVlYDaqLZHvSBeOL/tiUKaFykL7GiImedgu55fAqWcR4dUsP
         WYWnHfHryZbU0ebKz2msvZIL6NY3iZSztGgWeNf2St2oyMdMQbeyK3K5oOdyKxEI7z6U
         jXjqVbc9zelkJOFXXB6bktDtIUqI0AKVMG6AW0ShpgN46RiEqZjeGn87rQJBC1eFRwzb
         M26Ciy4RNp16iBYPROLOBAiEq274sw4haalt36G5+cRanvYzzVXOtgk/ZA4yKxWZ9Xyh
         lieg==
X-Gm-Message-State: AOAM530xW/NwUE8SZhMpIb7r8S2XJVIFEOLi/9kNFKy8G7UqB9MT2m8q
        JurvcsHc+rrnTW/qTrzb7TU=
X-Google-Smtp-Source: ABdhPJwOLZqVErO78mn6eUi9iTQ7MKWZeOvLZ4472mYIWQaC4HHRAWQDOKmg31hIKr0iCk1a8FgQRw==
X-Received: by 2002:a9d:5a08:: with SMTP id v8mr2553005oth.242.1604703817380;
        Fri, 06 Nov 2020 15:03:37 -0800 (PST)
Received: from localhost (2603-8081-140c-1a00-f960-8e80-5b89-d06d.res6.spectrum.com. [2603:8081:140c:1a00:f960:8e80:5b89:d06d])
        by smtp.gmail.com with ESMTPSA id 19sm653324oth.63.2020.11.06.15.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 15:03:37 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 2/2] RDMA/rxe: Implement the create_cq_ex verb
Date:   Fri,  6 Nov 2020 17:03:19 -0600
Message-Id: <20201106230319.17477-3-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201106230319.17477-1-rpearson@hpe.com>
References: <20201106230319.17477-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Together with a matching commit from the rxe provider in user space
this patch implements the ibv_create_cq_ex extended verb.

Uses a RXE_CAP_CMD_EX driver capability bit to negotiate with the
provider whether to support the verb.

Adjusts the size of work completion struct in the completion queue
depending on whether the CQ belongs to the kernel or user space.
And, if user space whether the create_cq or create_cq_ex verbs was
used.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  2 +-
 drivers/infiniband/sw/rxe/rxe.h       |  2 ++
 drivers/infiniband/sw/rxe/rxe_comp.c  |  9 +++++++-
 drivers/infiniband/sw/rxe/rxe_cq.c    | 19 ++++++++++------
 drivers/infiniband/sw/rxe/rxe_resp.c  | 20 +++++++++++------
 drivers/infiniband/sw/rxe/rxe_verbs.c | 23 ++++++++++++++++----
 drivers/infiniband/sw/rxe/rxe_verbs.h | 12 ++++++-----
 include/uapi/rdma/rdma_user_rxe.h     | 31 +++++++++++++++++++++++++++
 8 files changed, 93 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index dbd84347e7df..361e7380c75b 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -74,7 +74,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 
 	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
 
-	rxe->driver_cap				= RXE_CAP_NONE;
+	rxe->driver_cap				= RXE_CAP_CMD_EX;
 }
 
 /* initialize port attributes */
diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index 623fd17df02d..2ccc52c1a2a2 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -18,6 +18,7 @@
 
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_user_verbs.h>
+#include <rdma/rdma_user_rxe.h>
 #include <rdma/ib_pack.h>
 #include <rdma/ib_smi.h>
 #include <rdma/ib_umem.h>
@@ -32,6 +33,7 @@
 #include "rxe_verbs.h"
 #include "rxe_loc.h"
 
+
 /*
  * Version 1 and Version 2 are identical on 64 bit machines, but on 32 bit
  * machines Version 2 has a different struct layout.
diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 0a1e6393250b..2c5bede91373 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -389,7 +389,7 @@ static void make_send_cqe(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		wc->byte_len		= wqe->dma.length;
 		wc->qp			= &qp->ibqp;
 	} else {
-		struct ib_uverbs_wc	*uwc	= &cqe->uibwc;
+		struct rxe_uverbs_wc	*uwc	= &cqe->ruwc;
 
 		uwc->wr_id		= wqe->wr.wr_id;
 		uwc->status		= wqe->status;
@@ -399,6 +399,13 @@ static void make_send_cqe(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 			uwc->wc_flags = IB_WC_WITH_IMM;
 		uwc->byte_len		= wqe->dma.length;
 		uwc->qp_num		= qp->ibqp.qp_num;
+
+		/* flags only for cq_ex */
+		if (qp->scq->flags &
+		    IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION) {
+			uwc->timestamp	= (u64)ktime_get();
+			uwc->realtime	= (u64)ktime_get_real();
+		}
 	}
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index 43394c3f29d4..0ca7bede8d29 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -59,9 +59,17 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 		     struct rxe_create_cq_resp __user *uresp)
 {
 	int err;
+	size_t wc_size;
 
-	cq->queue = rxe_queue_init(rxe, &cqe,
-				   sizeof(struct rxe_cqe));
+	if (cq->is_user)
+		wc_size = (cq->is_ex) ? sizeof(struct rxe_uverbs_wc)
+				      : sizeof(struct ib_uverbs_wc);
+	else
+		wc_size = sizeof(struct ib_wc);
+
+	cq->wc_size = wc_size;
+
+	cq->queue = rxe_queue_init(rxe, &cqe, wc_size);
 	if (!cq->queue) {
 		pr_warn("unable to create cq\n");
 		return -ENOMEM;
@@ -75,9 +83,6 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 		return err;
 	}
 
-	if (uresp)
-		cq->is_user = 1;
-
 	cq->is_dying = false;
 
 	tasklet_setup(&cq->comp_task, rxe_send_complete);
@@ -94,7 +99,7 @@ int rxe_cq_resize_queue(struct rxe_cq *cq, int cqe,
 	int err;
 
 	err = rxe_queue_resize(cq->queue, (unsigned int *)&cqe,
-			       sizeof(struct rxe_cqe), udata,
+			       cq->wc_size, udata,
 			       uresp ? &uresp->mi : NULL, NULL, &cq->cq_lock);
 	if (!err)
 		cq->ibcq.cqe = cqe;
@@ -121,7 +126,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
 		return -EBUSY;
 	}
 
-	memcpy(producer_addr(cq->queue), cqe, sizeof(*cqe));
+	memcpy(producer_addr(cq->queue), cqe, cq->wc_size);
 
 	/* make sure all changes to the CQ are written before we update the
 	 * producer pointer
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index c7e3b6a4af38..ab564c4db2d6 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -812,7 +812,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 {
 	struct rxe_cqe cqe;
 	struct ib_wc *wc = &cqe.ibwc;
-	struct ib_uverbs_wc *uwc = &cqe.uibwc;
+	struct rxe_uverbs_wc *uwc = &cqe.ruwc;
 	struct rxe_recv_wqe *wqe = qp->resp.wqe;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 
@@ -822,13 +822,13 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 	memset(&cqe, 0, sizeof(cqe));
 
 	if (qp->rcq->is_user) {
-		uwc->status             = qp->resp.status;
-		uwc->qp_num             = qp->ibqp.qp_num;
-		uwc->wr_id              = wqe->wr_id;
+		uwc->status		= qp->resp.status;
+		uwc->qp_num		= qp->ibqp.qp_num;
+		uwc->wr_id		= wqe->wr_id;
 	} else {
-		wc->status              = qp->resp.status;
-		wc->qp                  = &qp->ibqp;
-		wc->wr_id               = wqe->wr_id;
+		wc->status		= qp->resp.status;
+		wc->qp			= &qp->ibqp;
+		wc->wr_id		= wqe->wr_id;
 	}
 
 	if (wc->status == IB_WC_SUCCESS) {
@@ -863,6 +863,12 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 				uwc->src_qp = deth_sqp(pkt);
 
 			uwc->port_num		= qp->attr.port_num;
+
+			if (qp->rcq->flags &
+			    IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION) {
+				uwc->timestamp	= (u64)ktime_get();
+				uwc->realtime	= (u64)ktime_get_real();
+			}
 		} else {
 			struct sk_buff *skb = PKT_TO_SKB(pkt);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 070f050b9793..1b1f451ce786 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -781,28 +781,43 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 	return err;
 }
 
-static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+static int rxe_create_cq(struct ib_cq *ibcq,
+			 const struct ib_cq_init_attr *attr,
 			 struct ib_udata *udata)
 {
 	int err;
 	struct ib_device *dev = ibcq->device;
 	struct rxe_dev *rxe = to_rdev(dev);
 	struct rxe_cq *cq = to_rcq(ibcq);
+	struct rxe_create_cq_cmd cmd = {};
 	struct rxe_create_cq_resp __user *uresp = NULL;
 
 	if (udata) {
+		cq->is_user = 1;
+
 		if (udata->outlen < sizeof(*uresp))
 			return -EINVAL;
 		uresp = udata->outbuf;
-	}
 
-	if (attr->flags)
-		return -EOPNOTSUPP;
+		if (udata->inlen) {
+			if (udata->inlen < sizeof(cmd))
+				return -EINVAL;
+			err = ib_copy_from_udata(&cmd, udata, sizeof(cmd));
+			if (err)
+				return err;
+
+			cq->is_ex = cmd.is_ex;
+		} else {
+			cq->is_ex = 0;
+		}
+	}
 
 	err = rxe_cq_chk_attr(rxe, NULL, attr->cqe, attr->comp_vector);
 	if (err)
 		return err;
 
+	cq->flags = attr->flags;
+
 	err = rxe_cq_from_init(rxe, cq, attr->cqe, attr->comp_vector, udata,
 			       uresp);
 	if (err)
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index bc021f15ef06..618ee188ad9e 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -9,7 +9,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
-#include <rdma/rdma_user_rxe.h>
 #include "rxe_pool.h"
 #include "rxe_task.h"
 #include "rxe_hw_counters.h"
@@ -54,7 +53,7 @@ struct rxe_ah {
 struct rxe_cqe {
 	union {
 		struct ib_wc		ibwc;
-		struct ib_uverbs_wc	uibwc;
+		struct rxe_uverbs_wc	ruwc;
 	};
 };
 
@@ -62,11 +61,14 @@ struct rxe_cq {
 	struct ib_cq		ibcq;
 	struct rxe_pool_entry	pelem;
 	struct rxe_queue	*queue;
+	struct tasklet_struct	comp_task;
 	spinlock_t		cq_lock;
-	u8			notify;
-	bool			is_dying;
+	size_t			wc_size;
+	u32			flags;
 	int			is_user;
-	struct tasklet_struct	comp_task;
+	int			is_ex;
+	bool			is_dying;
+	u8			notify;
 };
 
 enum wqe_state {
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index 70ac031e0a88..e8bde1b6d08e 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -158,8 +158,35 @@ struct rxe_recv_wqe {
 	struct rxe_dma_info	dma;
 };
 
+struct rxe_uverbs_wc {
+	/* keep these the same as ib_uverbs_wc */
+	__aligned_u64		wr_id;
+	__u32			status;
+	__u32			opcode;
+	__u32			vendor_err;
+	__u32			byte_len;
+	union {
+		__be32		imm_data;
+		__u32		invalidate_rkey;
+	} ex;
+	__u32			qp_num;
+	__u32			src_qp;
+	__u32			wc_flags;
+	__u16			pkey_index;
+	__u16			slid;
+	__u8			sl;
+	__u8			dlid_path_bits;
+	__u8			port_num;
+	__u8			reserved;
+
+	/* any extras go here */
+	__aligned_u64		timestamp;
+	__aligned_u64		realtime;
+};
+
 enum rxe_capabilities {
 	RXE_CAP_NONE		= 0,
+	RXE_CAP_CMD_EX		= 1ULL << 0,
 };
 
 struct rxe_alloc_context_cmd {
@@ -170,6 +197,10 @@ struct rxe_alloc_context_resp {
 	__aligned_u64		driver_cap;
 };
 
+struct rxe_create_cq_cmd {
+	__aligned_u64 is_ex;
+};
+
 struct rxe_create_cq_resp {
 	struct mminfo mi;
 };
-- 
2.27.0

