Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47FE504C7A
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Apr 2022 08:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiDRGPa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Apr 2022 02:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiDRGPa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Apr 2022 02:15:30 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48B4117E1F
        for <linux-rdma@vger.kernel.org>; Sun, 17 Apr 2022 23:12:51 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AJTi1B6sv71VqjpU8BLoHauvGy+fnVNRcMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3nWNLWzqDO6rZMGLyfd0lOYi18BhVscTXn9Y2TANvpS5gHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x/RGQ6YnSHuCmULS?=
 =?us-ascii?q?cY3goLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1cvJq/W?=
 =?us-ascii?q?UErL4XCheYcTwJFVSp5OMWq/ZeeeyPh7ZDJnxCun3zEhq8G4FsNFZcA9+9tGmZ?=
 =?us-ascii?q?I9eQVAD8IZxGHwemxxdqTS/NlwNsuLc/6FIIZpnxkizreCJ4OXZfGSr7Yo9BC2?=
 =?us-ascii?q?zI5itJNHN7fYdYUbXxkaxGoSwxGPFUKDtQsnPqAgnj5bi0epF+LzYI17Gf7yhJ?=
 =?us-ascii?q?w3LnkdtHSf7SiQcRTg1bdvG7D9kznDRwAct+S0zyI9jSrnOCnoM9RcOr+D5Xhr?=
 =?us-ascii?q?rgz3gLVnTdVVXUruZKAiaHRoiaDtxh3ciT4IhYTkJU=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A7ZJZCa+dI99rOwcj3w1uk+A8I+orL9Y04lQ7?=
 =?us-ascii?q?vn2YSXRuHPBw8Pre+sjztCWE8Qr5N0tBpTntAsW9qDbnhPtICOoqTNCftWvdyQ?=
 =?us-ascii?q?iVxehZhOOIqVDd8m/Fh4pgPMxbEpSWZueeMbEDt7eZ3OCnKadc/PC3tLCvmfzF?=
 =?us-ascii?q?z2pgCSVja6Rb5Q9/DQqBe3cGPzVuNN4oEoaG/Mpbq36FcXQTVM6yAX4IRKztvN?=
 =?us-ascii?q?vO/aiWGyIuNlo27hWUlzO05PrfGxic5B0XVDRC2vMD3AH+4nTE2pk=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123644285"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Apr 2022 14:12:48 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 3AD004D1716F;
        Mon, 18 Apr 2022 14:12:48 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 18 Apr 2022 14:12:49 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 18 Apr 2022 14:12:50 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <yanjun.zhu@linux.dev>, <rpearsonhpe@gmail.com>, <jgg@nvidia.com>,
        <y-goto@fujitsu.com>, <lizhijian@fujitsu.com>,
        <tomasz.gromadzki@intel.com>, <ira.weiny@intel.com>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v4 2/3] RDMA/rxe: Support RDMA Atomic Write operation
Date:   Mon, 18 Apr 2022 14:12:43 +0800
Message-ID: <20220418061244.89025-3-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220418061244.89025-1-yangx.jy@fujitsu.com>
References: <20220418061244.89025-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 3AD004D1716F.AA329
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch implements RDMA Atomic Write operation for RC service.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c   |  4 ++
 drivers/infiniband/sw/rxe/rxe_opcode.c | 19 ++++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.h |  3 ++
 drivers/infiniband/sw/rxe/rxe_qp.c     |  2 +-
 drivers/infiniband/sw/rxe/rxe_req.c    | 13 ++++++-
 drivers/infiniband/sw/rxe/rxe_resp.c   | 51 ++++++++++++++++++++++----
 include/rdma/ib_pack.h                 |  2 +
 include/rdma/ib_verbs.h                |  2 +
 include/uapi/rdma/ib_user_verbs.h      |  2 +
 include/uapi/rdma/rdma_user_rxe.h      |  1 +
 10 files changed, 88 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 138b3e7d3a5f..305e19fe43d2 100644
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
index d4ba4d506f17..b194e8ac581f 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -101,6 +101,12 @@ struct rxe_wr_opcode_info rxe_wr_opcode_info[] = {
 			[IB_QPT_UC]	= WR_LOCAL_OP_MASK,
 		},
 	},
+	[IB_WR_RDMA_ATOMIC_WRITE]			= {
+		.name   = "IB_WR_RDMA_ATOMIC_WRITE",
+		.mask   = {
+			[IB_QPT_RC]	= WR_ATOMIC_WRITE_MASK,
+		},
+	},
 };
 
 struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
@@ -378,6 +384,19 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 					  RXE_IETH_BYTES,
 		}
 	},
+	[IB_OPCODE_RC_RDMA_ATOMIC_WRITE]			= {
+		.name	= "IB_OPCODE_RC_RDMA_ATOMIC_WRITE",
+		.mask   = RXE_RETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
+			  RXE_ATOMIC_WRITE_MASK | RXE_START_MASK |
+			  RXE_END_MASK,
+		.length	= RXE_BTH_BYTES + RXE_RETH_BYTES,
+		.offset	= {
+			[RXE_BTH]	= 0,
+			[RXE_RETH]	= RXE_BTH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_RETH_BYTES,
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
index c9e382bc4a66..4937724dbfa9 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -129,7 +129,7 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
 
 void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res)
 {
-	if (res->type == RXE_ATOMIC_MASK)
+	if (res->type == RXE_ATOMIC_MASK || res->type == RXE_ATOMIC_WRITE_MASK)
 		kfree_skb(res->resp.skb);
 	res->type = 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index e2659663b283..cf5176a3bd97 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -237,6 +237,10 @@ static int next_opcode_rc(struct rxe_qp *qp, u32 opcode, int fits)
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
@@ -465,6 +469,11 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_av *av,
 		}
 	}
 
+	if (pkt->mask & RXE_ATOMIC_WRITE_MASK) {
+		memcpy(payload_addr(pkt), wqe->wr.wr.rdma.atomic_wr, paylen);
+		wqe->dma.resid -= paylen;
+	}
+
 	return 0;
 }
 
@@ -663,13 +672,13 @@ int rxe_requester(void *arg)
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
index 4ee923352056..446f93042b5e 100644
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
@@ -590,6 +590,34 @@ static enum resp_states process_atomic(struct rxe_qp *qp,
 	return ret;
 }
 
+static enum resp_states process_atomic_write(struct rxe_qp *qp,
+					     struct rxe_pkt_info *pkt)
+{
+#ifdef CONFIG_64BIT
+	u64 src, *dst;
+	struct rxe_mr *mr = qp->resp.mr;
+	int paylen = payload_size(pkt);
+
+	memcpy(&src, payload_addr(pkt), paylen);
+
+	dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, paylen);
+	/* check vaddr is 8 bytes aligned. */
+	if (!dst || (uintptr_t)dst & 7)
+		return RESPST_ERR_MISALIGNED_ATOMIC;
+
+	/* Do atomic write after all prior operations have completed */
+	smp_store_release(dst, src);
+
+	/* decrease resp.resid to zero */
+	qp->resp.resid -= sizeof(paylen);
+
+	return RESPST_NONE;
+#else
+	pr_err("32-bit arch doesn't support 8-byte atomic write\n");
+	return RESPST_ERR_UNSUPPORTED_OPCODE;
+#endif /* CONFIG_64BIT */
+}
+
 static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
 					  struct rxe_pkt_info *pkt,
 					  struct rxe_pkt_info *ack,
@@ -846,6 +874,10 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
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
@@ -1012,9 +1044,12 @@ static int send_resp(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
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
@@ -1025,7 +1060,7 @@ static int send_resp(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	rxe_advance_resp_resource(qp);
 
 	skb_get(skb);
-	res->type = RXE_ATOMIC_MASK;
+	res->type = pkt->mask & (RXE_ATOMIC_MASK | RXE_ATOMIC_WRITE_MASK);
 	res->resp.skb = skb;
 	res->first_psn = ack_pkt.psn;
 	res->last_psn  = ack_pkt.psn;
@@ -1048,7 +1083,7 @@ static enum resp_states acknowledge(struct rxe_qp *qp,
 
 	if (qp->resp.aeth_syndrome != AETH_ACK_UNLIMITED)
 		send_ack(qp, pkt, qp->resp.aeth_syndrome, pkt->psn);
-	else if (pkt->mask & RXE_ATOMIC_MASK)
+	else if (pkt->mask & (RXE_ATOMIC_MASK | RXE_ATOMIC_WRITE_MASK))
 		send_resp(qp, pkt, AETH_ACK_UNLIMITED);
 	else if (bth_ack(pkt))
 		send_ack(qp, pkt, AETH_ACK_UNLIMITED, pkt->psn);
diff --git a/include/rdma/ib_pack.h b/include/rdma/ib_pack.h
index a9162f25beaf..519ec6b841e7 100644
--- a/include/rdma/ib_pack.h
+++ b/include/rdma/ib_pack.h
@@ -84,6 +84,7 @@ enum {
 	/* opcode 0x15 is reserved */
 	IB_OPCODE_SEND_LAST_WITH_INVALIDATE         = 0x16,
 	IB_OPCODE_SEND_ONLY_WITH_INVALIDATE         = 0x17,
+	IB_OPCODE_RDMA_ATOMIC_WRITE                 = 0x1D,
 
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
index b3bb4dd068b6..18d706892e97 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -985,6 +985,7 @@ enum ib_wc_opcode {
 	IB_WC_REG_MR,
 	IB_WC_MASKED_COMP_SWAP,
 	IB_WC_MASKED_FETCH_ADD,
+	IB_WC_RDMA_ATOMIC_WRITE = IB_UVERBS_WC_RDMA_ATOMIC_WRITE,
 /*
  * Set value of IB_WC_RECV so consumers can test if a completion is a
  * receive by testing (opcode & IB_WC_RECV).
@@ -1325,6 +1326,7 @@ enum ib_wr_opcode {
 		IB_UVERBS_WR_MASKED_ATOMIC_CMP_AND_SWP,
 	IB_WR_MASKED_ATOMIC_FETCH_AND_ADD =
 		IB_UVERBS_WR_MASKED_ATOMIC_FETCH_AND_ADD,
+	IB_WR_RDMA_ATOMIC_WRITE = IB_UVERBS_WR_RDMA_ATOMIC_WRITE,
 
 	/* These are kernel only and can not be issued by userspace */
 	IB_WR_REG_MR = 0x20,
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 7dd903d932e5..175ade79e358 100644
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
 
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index f09c5c9e3dd5..845da9cb04fd 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -86,6 +86,7 @@ struct rxe_send_wr {
 			__aligned_u64 remote_addr;
 			__u32	rkey;
 			__u32	reserved;
+			__u8	atomic_wr[8];
 		} rdma;
 		struct {
 			__aligned_u64 remote_addr;
-- 
2.34.1



