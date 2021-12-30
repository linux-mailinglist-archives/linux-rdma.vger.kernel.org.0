Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8463481BF5
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Dec 2021 13:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbhL3MRw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Dec 2021 07:17:52 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:31739 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229463AbhL3MRv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Dec 2021 07:17:51 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AaHafN654HLHkEAeqzbi/4gxRtM/FchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS1zIDmDRNXm7VOK2LYmujet1wPYzioEwOvZ6HytEySwo5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvRH+CnULa?=
 =?us-ascii?q?eUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hgwdNCpdqyW?=
 =?us-ascii?q?C8nI6/NhP8AFRJfFkmSOIUfoe6YfCDm6ZH7I0ruNiGEL+9VJFsuMIQC4eFxAXl?=
 =?us-ascii?q?D3fMdITEJKBuEgoqe3LW+Q/J+wMs5K8ziMJEcu1lhyy3UCbAtRpWra7TD491F2?=
 =?us-ascii?q?nEiht1mGffYetpfZTdxBDzCbBJnPEkWBJM32uyvgxHXdzxetULQv6Yy6kDNwwF?=
 =?us-ascii?q?rlrvgKtzYfpqNX8o9o6oyjgoq5EygWldDaoPZkmHDrxqRaib0tXuTcOov+HeQr?=
 =?us-ascii?q?JaGWGGu+1E=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AqdwAPKw+7IIxNKNHJHcfKrPwEL1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfqWV8cjzuiWbtN9vYhsdcLy7WZVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?SVxepZnOnfKlPbexHWx6p00KdMV+xEAsTsMF4St63HyTj9P9E+4NTvysyVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.88,248,1635177600"; 
   d="scan'208";a="119750105"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Dec 2021 20:15:25 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 1276C4D15A22;
        Thu, 30 Dec 2021 20:15:21 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 30 Dec 2021 20:15:19 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 30 Dec 2021 20:15:18 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <yanjun.zhu@linux.dev>, <rpearsonhpe@gmail.com>, <jgg@nvidia.com>,
        <y-goto@fujitsu.com>, <lizhijian@fujitsu.com>,
        <tomasz.gromadzki@intel.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [RFC PATCH 2/2] RDMA/rxe: Add RDMA Atomic Write operation
Date:   Thu, 30 Dec 2021 20:14:23 +0800
Message-ID: <20211230121423.1919550-3-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 1276C4D15A22.A7E65
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch implements RDMA Atomic Write operation for RC service.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c   |  4 +++
 drivers/infiniband/sw/rxe/rxe_opcode.c | 18 ++++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.h |  3 ++
 drivers/infiniband/sw/rxe/rxe_qp.c     |  3 +-
 drivers/infiniband/sw/rxe/rxe_req.c    | 10 ++++--
 drivers/infiniband/sw/rxe/rxe_resp.c   | 49 +++++++++++++++++++++-----
 include/rdma/ib_pack.h                 |  2 ++
 include/rdma/ib_verbs.h                |  2 ++
 include/uapi/rdma/ib_user_verbs.h      |  2 ++
 9 files changed, 81 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index d771ba8449a1..5a5c0c3501de 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -104,6 +104,7 @@ static enum ib_wc_opcode wr_to_wc_opcode(enum ib_wr_opcode opcode)
 	case IB_WR_LOCAL_INV:			return IB_WC_LOCAL_INV;
 	case IB_WR_REG_MR:			return IB_WC_REG_MR;
 	case IB_WR_BIND_MW:			return IB_WC_BIND_MW;
+	case IB_WR_RDMA_ATOMIC_WRITE:		return IB_WC_RDMA_ATOMIC_WRITE;
 
 	default:
 		return 0xff;
@@ -256,6 +257,9 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 		if ((syn & AETH_TYPE_MASK) != AETH_ACK)
 			return COMPST_ERROR;
 
+		if (wqe->wr.opcode == IB_WR_RDMA_ATOMIC_WRITE)
+			return COMPST_WRITE_SEND;
+
 		fallthrough;
 		/* (IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE doesn't have an AETH)
 		 */
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index 3ef5a10a6efd..bd3639534d5a 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -103,6 +103,12 @@ struct rxe_wr_opcode_info rxe_wr_opcode_info[] = {
 			[IB_QPT_UC]	= WR_LOCAL_OP_MASK,
 		},
 	},
+	[IB_WR_RDMA_ATOMIC_WRITE]                       = {
+		.name   = "IB_WR_RDMA_ATOMIC_WRITE",
+		.mask   = {
+			[IB_QPT_RC]     = WR_INLINE_MASK | WR_ATOMIC_WRITE_MASK,
+		},
+	},
 };
 
 struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
@@ -379,6 +385,18 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 						+ RXE_IETH_BYTES,
 		}
 	},
+	[IB_OPCODE_RC_RDMA_ATOMIC_WRITE]                        = {
+		.name   = "IB_OPCODE_RC_RDMA_ATOMIC_WRITE",
+		.mask   = RXE_RETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK
+				| RXE_ATOMIC_WRITE_MASK | RXE_START_MASK
+				| RXE_END_MASK,
+		.length = RXE_BTH_BYTES + RXE_RETH_BYTES,
+		.offset = {
+			[RXE_BTH]       = 0,
+			[RXE_RETH]      = RXE_BTH_BYTES,
+			[RXE_PAYLOAD]   = RXE_BTH_BYTES + RXE_RETH_BYTES,
+		}
+	},
 
 	/* UC */
 	[IB_OPCODE_UC_SEND_FIRST]			= {
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
index 8f9aaaf260f2..a470e9b0b884 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -20,6 +20,7 @@ enum rxe_wr_mask {
 	WR_READ_MASK			= BIT(3),
 	WR_WRITE_MASK			= BIT(4),
 	WR_LOCAL_OP_MASK		= BIT(5),
+	WR_ATOMIC_WRITE_MASK		= BIT(7),
 
 	WR_READ_OR_WRITE_MASK		= WR_READ_MASK | WR_WRITE_MASK,
 	WR_WRITE_OR_SEND_MASK		= WR_WRITE_MASK | WR_SEND_MASK,
@@ -81,6 +82,8 @@ enum rxe_hdr_mask {
 
 	RXE_LOOPBACK_MASK	= BIT(NUM_HDR_TYPES + 12),
 
+	RXE_ATOMIC_WRITE_MASK   = BIT(NUM_HDR_TYPES + 14),
+
 	RXE_READ_OR_ATOMIC_MASK	= (RXE_READ_MASK | RXE_ATOMIC_MASK),
 	RXE_WRITE_OR_SEND_MASK	= (RXE_WRITE_MASK | RXE_SEND_MASK),
 	RXE_READ_OR_WRITE_MASK	= (RXE_READ_MASK | RXE_WRITE_MASK),
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index f3eec350f95c..22a1c4bcfa60 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -135,7 +135,8 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
 
 void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res)
 {
-	if (res->type == RXE_ATOMIC_MASK) {
+	if (res->type == RXE_ATOMIC_MASK ||
+			res->type == RXE_ATOMIC_WRITE_MASK) {
 		kfree_skb(res->resp.skb);
 	} else if (res->type == RXE_READ_MASK) {
 		if (res->read.mr)
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 0c9d2af15f3d..f024fb6e67c9 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -240,6 +240,10 @@ static int next_opcode_rc(struct rxe_qp *qp, u32 opcode, int fits)
 		else
 			return fits ? IB_OPCODE_RC_SEND_ONLY_WITH_INVALIDATE :
 				IB_OPCODE_RC_SEND_FIRST;
+
+	case IB_WR_RDMA_ATOMIC_WRITE:
+		return IB_OPCODE_RC_RDMA_ATOMIC_WRITE;
+
 	case IB_WR_REG_MR:
 	case IB_WR_LOCAL_INV:
 		return opcode;
@@ -463,7 +467,7 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 	if (err)
 		return err;
 
-	if (pkt->mask & RXE_WRITE_OR_SEND_MASK) {
+	if (pkt->mask & (RXE_WRITE_OR_SEND_MASK | RXE_ATOMIC_WRITE_MASK)) {
 		if (wqe->wr.send_flags & IB_SEND_INLINE) {
 			u8 *tmp = &wqe->dma.inline_data[wqe->dma.sge_offset];
 
@@ -680,13 +684,13 @@ int rxe_requester(void *arg)
 	}
 
 	mask = rxe_opcode[opcode].mask;
-	if (unlikely(mask & RXE_READ_OR_ATOMIC_MASK)) {
+	if (unlikely(mask & (RXE_READ_OR_ATOMIC_MASK | RXE_ATOMIC_WRITE_MASK))) {
 		if (check_init_depth(qp, wqe))
 			goto exit;
 	}
 
 	mtu = get_mtu(qp);
-	payload = (mask & RXE_WRITE_OR_SEND_MASK) ? wqe->dma.resid : 0;
+	payload = (mask & (RXE_WRITE_OR_SEND_MASK | RXE_ATOMIC_WRITE_MASK)) ? wqe->dma.resid : 0;
 	if (payload > mtu) {
 		if (qp_type(qp) == IB_QPT_UD) {
 			/* C10-93.1.1: If the total sum of all the buffer lengths specified for a
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 738e6b6335e5..dc9af8b06bd1 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -258,7 +258,7 @@ static enum resp_states check_op_valid(struct rxe_qp *qp,
 	case IB_QPT_RC:
 		if (((pkt->mask & RXE_READ_MASK) &&
 		     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_READ)) ||
-		    ((pkt->mask & RXE_WRITE_MASK) &&
+		    ((pkt->mask & (RXE_WRITE_MASK | RXE_ATOMIC_WRITE_MASK)) &&
 		     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_WRITE)) ||
 		    ((pkt->mask & RXE_ATOMIC_MASK) &&
 		     !(qp->attr.qp_access_flags & IB_ACCESS_REMOTE_ATOMIC))) {
@@ -362,7 +362,7 @@ static enum resp_states check_resource(struct rxe_qp *qp,
 		}
 	}
 
-	if (pkt->mask & RXE_READ_OR_ATOMIC_MASK) {
+	if (pkt->mask & (RXE_READ_OR_ATOMIC_MASK | RXE_ATOMIC_WRITE_MASK)) {
 		/* it is the requesters job to not send
 		 * too many read/atomic ops, we just
 		 * recycle the responder resource queue
@@ -413,7 +413,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 	enum resp_states state;
 	int access;
 
-	if (pkt->mask & RXE_READ_OR_WRITE_MASK) {
+	if (pkt->mask & (RXE_READ_OR_WRITE_MASK | RXE_ATOMIC_WRITE_MASK)) {
 		if (pkt->mask & RXE_RETH_MASK) {
 			qp->resp.va = reth_va(pkt);
 			qp->resp.offset = 0;
@@ -479,7 +479,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
 		goto err;
 	}
 
-	if (pkt->mask & RXE_WRITE_MASK)	 {
+	if (pkt->mask & (RXE_WRITE_MASK | RXE_ATOMIC_WRITE_MASK)) {
 		if (resid > mtu) {
 			if (pktlen != mtu || bth_pad(pkt)) {
 				state = RESPST_ERR_LENGTH;
@@ -591,6 +591,32 @@ static enum resp_states process_atomic(struct rxe_qp *qp,
 	return ret;
 }
 
+
+/* Guarantee atomicity of atomic write operations at the machine level. */
+static DEFINE_SPINLOCK(atomic_write_ops_lock);
+
+static enum resp_states process_atomic_write(struct rxe_qp *qp,
+					     struct rxe_pkt_info *pkt)
+{
+	u64 *src, *dst;
+	struct rxe_mr *mr = qp->resp.mr;
+
+	src = payload_addr(pkt);
+
+	dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, sizeof(u64));
+	if (!dst || (uintptr_t)dst & 7)
+		return RESPST_ERR_MISALIGNED_ATOMIC;
+
+	spin_lock_bh(&atomic_write_ops_lock);
+	*dst = *src;
+	spin_unlock_bh(&atomic_write_ops_lock);
+
+	/* decrease resp.resid to zero */
+	qp->resp.resid -= sizeof(u64);
+
+	return RESPST_NONE;
+}
+
 static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 					  struct rxe_pkt_info *pkt,
 					  struct rxe_pkt_info *ack,
@@ -801,6 +827,10 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
 		err = process_atomic(qp, pkt);
 		if (err)
 			return err;
+	} else if (pkt->mask & RXE_ATOMIC_WRITE_MASK) {
+		err = process_atomic_write(qp, pkt);
+		if (err)
+			return err;
 	} else {
 		/* Unreachable */
 		WARN_ON_ONCE(1);
@@ -967,9 +997,12 @@ static int send_resp(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	struct sk_buff *skb;
 	struct resp_res *res;
 
+	int opcode = pkt->mask & RXE_ATOMIC_MASK ?
+				IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE :
+				IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY;
+
 	skb = prepare_ack_packet(qp, pkt, &ack_pkt,
-				 IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE, 0, pkt->psn,
-				 syndrome);
+				 opcode, 0, pkt->psn, syndrome);
 	if (!skb) {
 		rc = -ENOMEM;
 		goto out;
@@ -980,7 +1013,7 @@ static int send_resp(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	rxe_advance_resp_resource(qp);
 
 	skb_get(skb);
-	res->type = RXE_ATOMIC_MASK;
+	res->type = pkt->mask & (RXE_ATOMIC_MASK | RXE_ATOMIC_WRITE_MASK);
 	res->resp.skb = skb;
 	res->first_psn = ack_pkt.psn;
 	res->last_psn  = ack_pkt.psn;
@@ -1003,7 +1036,7 @@ static enum resp_states acknowledge(struct rxe_qp *qp,
 
 	if (qp->resp.aeth_syndrome != AETH_ACK_UNLIMITED)
 		send_ack(qp, pkt, qp->resp.aeth_syndrome, pkt->psn);
-	else if (pkt->mask & RXE_ATOMIC_MASK)
+	else if (pkt->mask & (RXE_ATOMIC_MASK | RXE_ATOMIC_WRITE_MASK))
 		send_resp(qp, pkt, AETH_ACK_UNLIMITED);
 	else if (bth_ack(pkt))
 		send_ack(qp, pkt, AETH_ACK_UNLIMITED, pkt->psn);
diff --git a/include/rdma/ib_pack.h b/include/rdma/ib_pack.h
index a9162f25beaf..bd12e1049ef8 100644
--- a/include/rdma/ib_pack.h
+++ b/include/rdma/ib_pack.h
@@ -84,6 +84,7 @@ enum {
 	/* opcode 0x15 is reserved */
 	IB_OPCODE_SEND_LAST_WITH_INVALIDATE         = 0x16,
 	IB_OPCODE_SEND_ONLY_WITH_INVALIDATE         = 0x17,
+	IB_OPCODE_RDMA_ATOMIC_WRITE                 = 0x19,
 
 	/* real constants follow -- see comment about above IB_OPCODE()
 	   macro for more details */
@@ -112,6 +113,7 @@ enum {
 	IB_OPCODE(RC, FETCH_ADD),
 	IB_OPCODE(RC, SEND_LAST_WITH_INVALIDATE),
 	IB_OPCODE(RC, SEND_ONLY_WITH_INVALIDATE),
+	IB_OPCODE(RC, RDMA_ATOMIC_WRITE),
 
 	/* UC */
 	IB_OPCODE(UC, SEND_FIRST),
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 6e9ad656ecb7..949b3586d35b 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -971,6 +971,7 @@ enum ib_wc_opcode {
 	IB_WC_REG_MR,
 	IB_WC_MASKED_COMP_SWAP,
 	IB_WC_MASKED_FETCH_ADD,
+	IB_WC_RDMA_ATOMIC_WRITE = IB_UVERBS_WC_RDMA_ATOMIC_WRITE,
 /*
  * Set value of IB_WC_RECV so consumers can test if a completion is a
  * receive by testing (opcode & IB_WC_RECV).
@@ -1311,6 +1312,7 @@ enum ib_wr_opcode {
 		IB_UVERBS_WR_MASKED_ATOMIC_CMP_AND_SWP,
 	IB_WR_MASKED_ATOMIC_FETCH_AND_ADD =
 		IB_UVERBS_WR_MASKED_ATOMIC_FETCH_AND_ADD,
+	IB_WR_RDMA_ATOMIC_WRITE = IB_UVERBS_WR_RDMA_ATOMIC_WRITE,
 
 	/* These are kernel only and can not be issued by userspace */
 	IB_WR_REG_MR = 0x20,
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 7ee73a0652f1..3b0b509fb96f 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -466,6 +466,7 @@ enum ib_uverbs_wc_opcode {
 	IB_UVERBS_WC_BIND_MW = 5,
 	IB_UVERBS_WC_LOCAL_INV = 6,
 	IB_UVERBS_WC_TSO = 7,
+	IB_UVERBS_WC_RDMA_ATOMIC_WRITE = 9,
 };
 
 struct ib_uverbs_wc {
@@ -784,6 +785,7 @@ enum ib_uverbs_wr_opcode {
 	IB_UVERBS_WR_RDMA_READ_WITH_INV = 11,
 	IB_UVERBS_WR_MASKED_ATOMIC_CMP_AND_SWP = 12,
 	IB_UVERBS_WR_MASKED_ATOMIC_FETCH_AND_ADD = 13,
+	IB_UVERBS_WR_RDMA_ATOMIC_WRITE = 15,
 	/* Review enum ib_wr_opcode before modifying this */
 };
 
-- 
2.23.0



