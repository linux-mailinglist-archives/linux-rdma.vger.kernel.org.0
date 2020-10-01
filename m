Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E124B2805DE
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 19:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733003AbgJARtL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 13:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732958AbgJARtE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Oct 2020 13:49:04 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6536EC0613E2
        for <linux-rdma@vger.kernel.org>; Thu,  1 Oct 2020 10:49:04 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 185so6464878oie.11
        for <linux-rdma@vger.kernel.org>; Thu, 01 Oct 2020 10:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OTM7HhrEOp3XZ1ea8pFtsfLCSR50LhwxJ1vlV2pEwrI=;
        b=VtUIk8r59EqJkXofNIfHGE+xc9fKqiH9rzEeneftln8yKKoJU3w6vIQ2tlnMN6iB0N
         amxWM79mRypMJdnjACWZNKZLyEYUEafMqfjodhQr1rZ0JpNcH1RG4qdRed5g9JeJO4kp
         k7ouxtpL5agW722xGvT55ISydyt70tO22HUapE0GakNSeJOo2PxHpxgo/2IHaQiWQFeg
         ryL0dBWsMNI2meyYBtv6xJKA16BDE41XUEUubOvM2V8+dEeZTulNItNeq29T4o+LQ74P
         Dd41XdjdxjpE5NusU1QxtvVLbwq3KwWUa82wyYnxUuL107wm4D+3dpt66B0/6rePmpfh
         kM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OTM7HhrEOp3XZ1ea8pFtsfLCSR50LhwxJ1vlV2pEwrI=;
        b=tghSSB/NYLz0hlSNz7IXlsQm3PyX2eIw1Md7lM89vStBTgx0R4WlyJplXB5n0Dd2Zv
         9UqzHgMlbOENs/xnXNoD0NP2jPgTzXUf8iXXKAeAgW+KYYR0ptHhmCvKOQZcBgD4rTX8
         iR/ORHbG9jSIl67F0VQ+5b+NzhFYqPWw/6snCXqQBNuSawnI8vEJqmu8CprJ9WKTAe9x
         ZM0LYpFqhivMcX9TwVZwu2nhm4F+oyNc6rTrC93ISVt+VA6b7rzDNuNj1TnHHX8/HP8m
         5SnPS5+7Pj4VhHZ8VJofOn5JVe/x4V4psKEier2/ojnwNRuMFRw0Oh3bsAUtnWCrlAQe
         EnFA==
X-Gm-Message-State: AOAM533j9pjK7kyGOzuxWNbmd4eTN4Aim79rk4iIP78CkuM8oDF4QODy
        oNUZXg7tq9Ap+XmbxAg53VCsyEPbacE=
X-Google-Smtp-Source: ABdhPJzw2qmJSk+AH8tOz7dtKNSTLRNYUjkC6nv5f3UauObLhcivyPhG+Jb71ka8OS8Ea98BN5Sm9A==
X-Received: by 2002:aca:d845:: with SMTP id p66mr671781oig.47.1601574543823;
        Thu, 01 Oct 2020 10:49:03 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:d01f:9a3e:d22f:7a6])
        by smtp.gmail.com with ESMTPSA id k2sm1191923oiw.20.2020.10.01.10.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:49:03 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v7 11/19] rdma_rxe: Add support for extended CQ operations
Date:   Thu,  1 Oct 2020 12:48:39 -0500
Message-Id: <20201001174847.4268-12-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001174847.4268-1-rpearson@hpe.com>
References: <20201001174847.4268-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add private members to user/kernel wc struct to carry
extensions used by cq_ex.
Add timestamps on completion.
Add ignore overrun support.
Add commands to user API bitmasks.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  |  7 ++++-
 drivers/infiniband/sw/rxe/rxe_resp.c  |  8 +++++-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 10 ++++---
 drivers/infiniband/sw/rxe/rxe_verbs.h |  3 ++-
 include/uapi/rdma/rdma_user_rxe.h     | 38 ++++++++++++++++++++++-----
 5 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 8b81d3b24a8a..72745ffcf118 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -390,7 +390,7 @@ static void make_send_cqe(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 		wc->byte_len		= wqe->dma.length;
 		wc->qp			= &qp->ibqp;
 	} else {
-		struct ib_uverbs_wc	*uwc	= &cqe->uibwc;
+		struct rxe_uverbs_wc	*uwc = &cqe->ruwc;
 
 		uwc->wr_id		= wqe->wr.wr_id;
 		uwc->status		= wqe->status;
@@ -400,6 +400,11 @@ static void make_send_cqe(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 			uwc->wc_flags = IB_WC_WITH_IMM;
 		uwc->byte_len		= wqe->dma.length;
 		uwc->qp_num		= qp->ibqp.qp_num;
+		if (qp->scq->flags &
+		    IB_UVERBS_CQ_FLAGS_TIMESTAMP_COMPLETION) {
+			uwc->timestamp	= (u64)ktime_get();
+			uwc->realtime	= (u64)ktime_get_real();
+		}
 	}
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 2aae311f9063..58d3783063bb 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -887,7 +887,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 {
 	struct rxe_cqe cqe;
 	struct ib_wc *wc = &cqe.ibwc;
-	struct ib_uverbs_wc *uwc = &cqe.uibwc;
+	struct rxe_uverbs_wc *uwc = &cqe.ruwc;
 	struct rxe_recv_wqe *wqe = qp->resp.wqe;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 
@@ -943,6 +943,12 @@ static enum resp_states do_complete(struct rxe_qp *qp,
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
index 2695b286cd8e..6be0aa9cf1f3 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -749,7 +749,8 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 	return err;
 }
 
-static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+static int rxe_create_cq(struct ib_cq *ibcq,
+			 const struct ib_cq_init_attr *attr,
 			 struct ib_udata *udata)
 {
 	int err;
@@ -764,13 +765,12 @@ static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		uresp = udata->outbuf;
 	}
 
-	if (attr->flags)
-		return -EINVAL;
-
 	err = rxe_cq_chk_attr(rxe, NULL, attr->cqe, attr->comp_vector);
 	if (err)
 		return err;
 
+	cq->flags = attr->flags;
+
 	err = rxe_cq_from_init(rxe, cq, attr->cqe, attr->comp_vector, udata,
 			       uresp);
 	if (err)
@@ -1188,6 +1188,8 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 
 	dev->uverbs_ex_cmd_mask =
 	      BIT_ULL(IB_USER_VERBS_EX_CMD_QUERY_DEVICE)
+	    | BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_CQ)
+	    | BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_CQ)
 	    ;
 
 	ib_set_device_ops(dev, &rxe_dev_ops);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index e8d9c8388345..54429d8a06fb 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -53,7 +53,7 @@ struct rxe_ah {
 struct rxe_cqe {
 	union {
 		struct ib_wc		ibwc;
-		struct ib_uverbs_wc	uibwc;
+		struct rxe_uverbs_wc	ruwc;
 	};
 };
 
@@ -62,6 +62,7 @@ struct rxe_cq {
 	struct rxe_pool_entry	pelem;
 	struct rxe_queue	*queue;
 	spinlock_t		cq_lock;
+	u32			flags;
 	u8			notify;
 	bool			is_dying;
 	int			is_user;
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index d49125682359..95352e050ab4 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -98,29 +98,27 @@ struct rxe_send_wr {
 			__aligned_u64	length;
 			union {
 				__u32		mr_index;
-				__aligned_u64	reserved1;
+				__aligned_u64   pad1;
 			};
 			union {
 				__u32		mw_index;
-				__aligned_u64	reserved2;
+				__aligned_u64   pad2;
 			};
 			__u32	rkey;
 			__u32	access;
 			__u32	flags;
 		} umw;
-		/* The following are only used by the kernel
-		 * and are not part of the uapi
-		 */
+		/* below are only used by the kernel */
 		struct {
 			__aligned_u64	addr;
 			__aligned_u64	length;
 			union {
 				struct ib_mr	*mr;
-				__aligned_u64	reserved1;
+				__aligned_u64   reserved1;
 			};
 			union {
 				struct ib_mw	*mw;
-				__aligned_u64	reserved2;
+				__aligned_u64   reserved2;
 			};
 			__u32	rkey;
 			__u32	access;
@@ -184,6 +182,32 @@ struct rxe_recv_wqe {
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
 struct rxe_create_cq_resp {
 	struct mminfo mi;
 };
-- 
2.25.1

