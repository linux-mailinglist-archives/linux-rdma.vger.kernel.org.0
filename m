Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537782707FF
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 23:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgIRVQE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 17:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRVP7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 17:15:59 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D75BC0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:15:59 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id h9so1774821ooo.10
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MFShnD5pX/pw/lV3KitrOsdE/hzej9n350RPPyna1B8=;
        b=pQhSsgxCwvPMBRzCeUcfGCdYzGAiRfo9dahF2FDeug+SNqNKu7tR/ku6tmdYEg04fB
         ggUMN7mcDsJKag65hgmhP+GrO/ELCdPxlvpes/Ltt79ZnNWd7cBQLB5xDBIENZqoTjYJ
         hPagfhIMrNQIlgOA1Pf2L9aJIIh6Gq1jEpASCXdiX8VUQpAL9kuTpoIKGghfMo88z792
         tjXx65W0f83xYucDk/3FxcnCsIL8IDkxvMXS6NgSDjV24HI1nslKoGBr06UoxXc1NoZO
         YdbYItbnZoXHuwntjGOir10Tbx0dd0ZUY1rKUfHPoChk5lWylUoMofxVhz3c8O8sA/s4
         hr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MFShnD5pX/pw/lV3KitrOsdE/hzej9n350RPPyna1B8=;
        b=QMrt3KvHTMrPfw8lUQTjoSbrH4uRFQilOXfo7GyaAqbgT4nhriyBNv9H/SddZ9RpEG
         qI1AgV73smYbVSrSOgYnOzOfrq2P+HnMr3v81z6P98/WBinIT88lymCg6KShylKbVSK7
         X2xYe56FZb6z5InhMY22+SRJPSde+cIff0dt8/wAepcSf2IkwdfvdRI8JnZPnHwqih4p
         aXJTdHlNewjXntO+fCRBfFQUpqmspTgyjt87+U5k5seRVwcvVV4eHKp+ahy3lhDjyNfw
         UJnyxTvnRiShVYtf95hKHSnY3rt3jGFD2fGWOI1SynRYRefMve3GkMc6n+UhFMQPz6c0
         B9Qw==
X-Gm-Message-State: AOAM532bJgX0guPTL6JtDyFKfgyu1TfDd01ephh9w1ZsiD9jKEx/Js33
        AkvDCdHhx9RKPYwGdLkEZJg=
X-Google-Smtp-Source: ABdhPJzczSHgLUPd/dhBZE1oFTRmqLnSsDI0WWenZGqkZ3KJYBoRXJZozRtJo06FdFIQoFiFyRMXzA==
X-Received: by 2002:a4a:a50a:: with SMTP id v10mr25199946ook.4.1600463758631;
        Fri, 18 Sep 2020 14:15:58 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:4725:6035:508:6d87])
        by smtp.gmail.com with ESMTPSA id g7sm3035528otl.59.2020.09.18.14.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 14:15:58 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v5 08/12] rdma_rxe: Add support for extended CQ operations
Date:   Fri, 18 Sep 2020 16:15:13 -0500
Message-Id: <20200918211517.5295-9-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918211517.5295-1-rpearson@hpe.com>
References: <20200918211517.5295-1-rpearson@hpe.com>
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
 drivers/infiniband/sw/rxe/rxe_resp.c  | 20 +++++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.c | 10 ++++---
 drivers/infiniband/sw/rxe/rxe_verbs.h |  3 ++-
 include/uapi/rdma/rdma_user_rxe.h     | 38 ++++++++++++++++++++++-----
 5 files changed, 58 insertions(+), 20 deletions(-)

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
index 136c7699fed3..660f33318ec9 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -844,7 +844,7 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 {
 	struct rxe_cqe cqe;
 	struct ib_wc *wc = &cqe.ibwc;
-	struct ib_uverbs_wc *uwc = &cqe.uibwc;
+	struct rxe_uverbs_wc *uwc = &cqe.ruwc;
 	struct rxe_recv_wqe *wqe = qp->resp.wqe;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 
@@ -854,13 +854,13 @@ static enum resp_states do_complete(struct rxe_qp *qp,
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
@@ -895,6 +895,12 @@ static enum resp_states do_complete(struct rxe_qp *qp,
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
index a77f2e0ef68f..594d8353600a 100644
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
@@ -1187,6 +1187,8 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 
 	dev->uverbs_ex_cmd_mask =
 	      BIT_ULL(IB_USER_VERBS_EX_CMD_QUERY_DEVICE)
+	    | BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_CQ)
+	    | BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_CQ)
 	    ;
 
 	ib_set_device_ops(dev, &rxe_dev_ops);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index b24a9a0878c2..784ae4102265 100644
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

