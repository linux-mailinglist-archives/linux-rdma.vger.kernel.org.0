Return-Path: <linux-rdma+bounces-7906-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2862AA3E458
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 19:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4C43A97E8
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 18:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01B4264F96;
	Thu, 20 Feb 2025 18:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="InWgO/iL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB17264F8D
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 18:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077758; cv=none; b=oRcwtG7LCO7KE3h5AF+p2Gz033dXLSLgzbz1AESQ5WSM+crA29JMfYt2M2mVUpK/OXROAfmNuGt69V2YWzggkSZqRVDQRBSDGjDqYZfWgtQisha2vFkV6wzO3/58rpi0jW8o70zL6xqU86mgqr1fxVl7V5DD+2uBYymqJbqhkLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077758; c=relaxed/simple;
	bh=KFiItcYA1+vfCd+hinIriGeUe9fKsH3FKL1ViQr6mGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Uo+b6LLNWiQ5XyzvUDb1zj/xCv35jRTSI8DWFJUB0NXRgM6emGfSa2ROHG52cQlnw27hz19M4F3NsgL/jclnthD+R+S/oHMUjbwDXguD+M8MfMlJQH+N9Ss5/4nTthPjwaOEjsT5dtlqt2vPH/fxlPEL2zQ69uHcQgNu1pfIPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=InWgO/iL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220c665ef4cso21449715ad.3
        for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 10:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740077756; x=1740682556; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zr+FohAS+5s358/XL5DNb3kyfI1vHkhFvhvpgEYGLio=;
        b=InWgO/iLJemDlouldjP+zHXUSKGAXRN4owAQBVQXKHIwjYo8SjJ2pbZHfqVX2hO/4K
         v0BDTLPyCt5LqXfKGsg/TWPbIZeBtwuDPNJuTPyPGUXKbS97FkIjs6GkHZxpYpHxH/D9
         E9SZu4MUxMjindphCFZgts8EPw4RFDujLyJZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740077756; x=1740682556;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zr+FohAS+5s358/XL5DNb3kyfI1vHkhFvhvpgEYGLio=;
        b=oL6xY93nCPlNAnKYTLxix7bQZ1kX1u9FBmtdwH0rKnWVfbdxs9En0fI0/K97zxM/kg
         heygGon4UAapsW5SJ9GJ+fT6B6wa1u+b5qaU4ZMSTeavStpLzADcIFpIoQk7P/m+YZud
         havb7uUwQyn+ohhP3ULQiwW2UP/a0nStXGgfYzbcC3HnczmaH16F3DBbebTA2xAlybvT
         lh+/moS4sLmxNc3yciDH4K1caD5wpWVYep1yzPwYfTQohPWX1sKF0JyEDvnizaZ4Vv3i
         E0j57pW3KOPVQiXkHdH6ZduISsFiK1MfXuP4tbddGGZbV1hdQvd1Vo4V4k0PunkIwzkf
         BLFQ==
X-Gm-Message-State: AOJu0YxaL9EiSTWqelZR4FV9aY3jfIvOgMF6+6bohujKmaspYkJnvp5V
	nDj09h5AzhzDqihy9cW4iBP3yEXWxZH72sHAGFJiNFj3rRcUx3wD1fByv3wbKg==
X-Gm-Gg: ASbGncs+7P5GdoZ7R3LfjqaNYPKnWXgMs+Y9ES/qJH8Fvwm6B+mUQ8uAvvZMWsot6om
	4JR5AwDAj6STkzHbBxZxzNqotXmcgBNGhwP2WzwUt9F3zjFJR5dJ4ju98Vdo0eoNfZ30Sv25i52
	VahpJPqwiTaP/ZMdrWZEsInG/TjOEDp14pBEFCf9Jf3pD76NZSwAe7iyhl/5oQ/pC84yDBq+sN/
	ERz2NP9FrgtghtVBtM+ZDcHv4scuOGqVr9GRM4hlqMu2UBakBiWWJzimx8xdkyhARNCgRbuQThA
	m3LBCFfn9yuPnuGmccRh1sda8tqS/BLc6RKw1HjeB8vKGabydbqldOKVpYH9UaYR/bdKBlI=
X-Google-Smtp-Source: AGHT+IG5H60oDdyi7JNgfkxGe8sLuWExbjYsWJu3/e2SJDRMel5HMa3BX5oHa9sFdtx0xPH3Zg+4fA==
X-Received: by 2002:a05:6a20:9144:b0:1ee:e24d:8fdc with SMTP id adf61e73a8af0-1eef3c883f7mr379399637.10.1740077756102;
        Thu, 20 Feb 2025 10:55:56 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-addee79a984sm9572262a12.32.2025.02.20.10.55.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2025 10:55:55 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	abeni@redhat.com,
	horms@kernel.org,
	michael.chan@broadcom.com,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 2/9] RDMA/bnxt_re: Cache the QP information
Date: Thu, 20 Feb 2025 10:34:49 -0800
Message-Id: <1740076496-14227-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
References: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

Add routines to cache the information about the QP before
destroying. This can be retrieved and used for further
debugging.

The default behavior is to capture the QPs that are moved
to error. The driver sets the flags to capture the dump
from the error asynchronous event.

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 67 ++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.h | 42 ++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/main.c     |  8 +++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h |  7 ++++
 4 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 2de101d..060143e 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -41,6 +41,7 @@
 #include <linux/pci.h>
 #include <linux/netdevice.h>
 #include <linux/if_ether.h>
+#include <linux/vmalloc.h>
 #include <net/addrconf.h>
 
 #include <rdma/ib_verbs.h>
@@ -954,6 +955,71 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
 	return rc;
 }
 
+static struct qdump_array *bnxt_re_get_next_qpdump(struct bnxt_re_dev *rdev)
+{
+	struct qdump_array *qdump;
+	u32 index;
+
+	index = rdev->qdump_head.index;
+	qdump = &rdev->qdump_head.qdump[index];
+	memset(qdump, 0, sizeof(*qdump));
+
+	index++;
+	index %= rdev->qdump_head.max_elements;
+	rdev->qdump_head.index = index;
+
+	return qdump;
+}
+
+/*
+ * bnxt_re_capture_qpdump - Capture snapshot of various queues of a QP.
+ * @qp	-	Pointer to QP for which data has to be collected
+ *
+ * This function will capture info about SQ/RQ/SCQ/RCQ of a QP which
+ * can be used to debug any issue
+ *
+ */
+void bnxt_re_capture_qpdump(struct bnxt_re_qp *qp)
+{
+	struct bnxt_qplib_qp *qpl = &qp->qplib_qp;
+	struct bnxt_re_dev *rdev = qp->rdev;
+	struct qdump_qpinfo *qpinfo;
+	struct qdump_array *qdump;
+	bool capture_snapdump;
+
+	if (rdev->snapdump_dbg_lvl == BNXT_RE_SNAPDUMP_NONE)
+		return;
+
+	capture_snapdump = test_bit(QP_FLAGS_CAPTURE_SNAPDUMP, &qpl->flags);
+	if (rdev->snapdump_dbg_lvl == BNXT_RE_SNAPDUMP_ERR &&
+	    !capture_snapdump)
+		return;
+
+	if (qp->is_snapdump_captured || !rdev->qdump_head.qdump)
+		return;
+
+	mutex_lock(&rdev->qdump_head.lock);
+	qdump = bnxt_re_get_next_qpdump(rdev);
+
+	qpinfo = &qdump->qpinfo;
+	qpinfo->id = qpl->id;
+	qpinfo->dest_qpid = qpl->dest_qpn;
+	qpinfo->is_user = qpl->is_user;
+	qpinfo->mtu = qpl->mtu;
+	qpinfo->state = qpl->state;
+	qpinfo->type = qpl->type;
+	qpinfo->wqe_mode = qpl->wqe_mode;
+	qpinfo->qp_handle = qpl->qp_handle;
+	qpinfo->scq_handle = qp->scq->qplib_cq.cq_handle;
+	qpinfo->rcq_handle = qp->rcq->qplib_cq.cq_handle;
+	qpinfo->scq_id = qp->scq->qplib_cq.id;
+	qpinfo->rcq_id = qp->rcq->qplib_cq.id;
+
+	qdump->valid = true;
+	qp->is_snapdump_captured = true;
+	mutex_unlock(&rdev->qdump_head.lock);
+}
+
 /* Queue Pairs */
 int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 {
@@ -965,6 +1031,7 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	unsigned int flags;
 	int rc;
 
+	bnxt_re_capture_qpdump(qp);
 	bnxt_re_debug_rem_qpinfo(rdev, qp);
 
 	bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index fbb16a4..8d82066 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -96,6 +96,7 @@ struct bnxt_re_qp {
 	struct bnxt_re_cq	*scq;
 	struct bnxt_re_cq	*rcq;
 	struct dentry		*dentry;
+	bool			is_snapdump_captured;
 };
 
 struct bnxt_re_cq {
@@ -113,6 +114,7 @@ struct bnxt_re_cq {
 	int			resize_cqe;
 	void			*uctx_cq_page;
 	struct hlist_node	hash_entry;
+	bool			is_snapdump_captured;
 };
 
 struct bnxt_re_mr {
@@ -267,6 +269,46 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata);
 void bnxt_re_dealloc_ucontext(struct ib_ucontext *context);
 int bnxt_re_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 void bnxt_re_mmap_free(struct rdma_user_mmap_entry *rdma_entry);
+void bnxt_re_capture_qpdump(struct bnxt_re_qp *qp);
+
+static inline const char *__to_qp_type_str(u8 type)
+{
+	switch (type) {
+	case CMDQ_CREATE_QP1_TYPE_GSI:
+	case CMDQ_CREATE_QP_TYPE_GSI:
+		return "GSI";
+	case CMDQ_CREATE_QP_TYPE_RC:
+		return "RC";
+	case CMDQ_CREATE_QP_TYPE_UD:
+		return "UD";
+	case CMDQ_CREATE_QP_TYPE_RAW_ETHERTYPE:
+		return "RAW_ETH";
+	default:
+		return "NotSupp";
+	}
+}
+
+static inline const char  *__to_qp_state_str(u8 state)
+{
+	switch (state) {
+	case CMDQ_MODIFY_QP_NEW_STATE_RESET:
+		return "RESET";
+	case CMDQ_MODIFY_QP_NEW_STATE_INIT:
+		return "INIT";
+	case CMDQ_MODIFY_QP_NEW_STATE_RTR:
+		return "RTR";
+	case CMDQ_MODIFY_QP_NEW_STATE_RTS:
+		return "RTS";
+	case CMDQ_MODIFY_QP_NEW_STATE_SQD:
+		return "SQD";
+	case CMDQ_MODIFY_QP_NEW_STATE_SQE:
+		return "SQE";
+	case CMDQ_MODIFY_QP_NEW_STATE_ERR:
+		return "ERR";
+	default:
+		return "NotSupp";
+	}
+}
 
 static inline u32 __to_ib_port_num(u16 port_id)
 {
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 87fdf69..67d2bf0 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1420,9 +1420,15 @@ static int bnxt_re_handle_qp_async_event(struct creq_qp_event *qp_event,
 	struct ib_event event = {};
 	unsigned int flags;
 
-	if (qp->qplib_qp.srq)
+	if (qp->qplib_qp.srq) {
 		srq =  container_of(qp->qplib_qp.srq, struct bnxt_re_srq,
 				    qplib_srq);
+		set_bit(SRQ_FLAGS_CAPTURE_SNAPDUMP, &srq->qplib_srq.flags);
+	}
+
+	set_bit(QP_FLAGS_CAPTURE_SNAPDUMP, &qp->qplib_qp.flags);
+	set_bit(CQ_FLAGS_CAPTURE_SNAPDUMP, &qp->scq->qplib_cq.flags);
+	set_bit(CQ_FLAGS_CAPTURE_SNAPDUMP, &qp->rcq->qplib_cq.flags);
 
 	if (qp->qplib_qp.state == CMDQ_MODIFY_QP_NEW_STATE_ERR &&
 	    rdma_is_kernel_res(&qp->ib_qp.res)) {
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 0d9487c..d1acb01 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -106,6 +106,8 @@ struct bnxt_qplib_srq {
 	u16				eventq_hw_ring_id;
 	spinlock_t			lock; /* protect SRQE link list */
 	u8				toggle;
+	unsigned long			flags;
+#define SRQ_FLAGS_CAPTURE_SNAPDUMP	1
 };
 
 struct bnxt_qplib_sge {
@@ -279,6 +281,8 @@ struct bnxt_qplib_qp {
 	u8				wqe_mode;
 	u8				state;
 	u8				cur_qp_state;
+	u16				ctx_size_sb;
+	u8				is_user;
 	u64				modify_flags;
 	u32				max_inline_data;
 	u32				mtu;
@@ -344,6 +348,8 @@ struct bnxt_qplib_qp {
 	u32				msn_tbl_sz;
 	bool				is_host_msn_tbl;
 	u8				tos_dscp;
+	unsigned long			flags;
+#define QP_FLAGS_CAPTURE_SNAPDUMP	1
 };
 
 #define BNXT_QPLIB_MAX_CQE_ENTRY_SIZE	sizeof(struct cq_base)
@@ -448,6 +454,7 @@ struct bnxt_qplib_cq {
 #define CQ_RESIZE_WAIT_TIME_MS		500
 	unsigned long			flags;
 #define CQ_FLAGS_RESIZE_IN_PROG		1
+#define CQ_FLAGS_CAPTURE_SNAPDUMP	2
 	wait_queue_head_t		waitq;
 	struct list_head		sqf_head, rqf_head;
 	atomic_t			arm_state;
-- 
2.5.5


