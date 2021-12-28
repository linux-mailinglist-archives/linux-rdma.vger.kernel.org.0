Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAC648072D
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Dec 2021 09:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbhL1ICY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Dec 2021 03:02:24 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47599 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235495AbhL1ICW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Dec 2021 03:02:22 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AiGnAeqAlo2CqFRVW/3fiw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fUFO9gjgj0TYOymsaXmuEP/vYYmCmfo9/b9yx8UhQu5WAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK49CMmhfnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9TiieJntJwwdNlu4GyS?=
 =?us-ascii?q?BsyI+vHn+F1vxxwSngvY/AZpOabSZS4mYnJp6HcSFP22/hnFloxO40A9854BGh?=
 =?us-ascii?q?P8boTLzVlRgKShfCnwujjErFEicEqLc2tN4Qa0llkzDjfAukrR4jORari5cJRw?=
 =?us-ascii?q?zoxwMtJGJ72Y8sGZDtvZRLPSx1SM0gaCdQ1m+LArn3ydDtwq1+Po6czpW/Jw2R?=
 =?us-ascii?q?Z2bjkKt3TfvSMW8RZn0/erWXDl0z8CBUdP9y3zySE/nOlwOTImEvTXIMUCa399?=
 =?us-ascii?q?fNwhlCX7nIcBQdQVlahp/S9zEmkVLp3L00S5zprt6Q3/WS1QdTnGR61uniJulg?=
 =?us-ascii?q?bQdU4O+815ymfy6fM7kCSDwA5opRpADA9nJZuA2V0iRnSxJW0bQGDeYa9ERq1n?=
 =?us-ascii?q?op4ZxvraUD59VM/WBI=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Adt8IOq9tVvkgwGevW2xuk+A8I+orL9Y04lQ7?=
 =?us-ascii?q?vn2YSXRuHPBw8Pre5cjztCWE7gr5N0tBpTntAsW9qDbnhPtICOoqTNCftWvdyQ?=
 =?us-ascii?q?iVxehZhOOIqVDd8m/Fh4pgPMxbEpSWZueeMbEDt7eZ3OCnKadc/PC3tLCvmfzF?=
 =?us-ascii?q?z2pgCSVja6Rb5Q9/DQqBe3cGPzVuNN4oEoaG/Mpbq36FcXQTVM6yAX4IRKztvN?=
 =?us-ascii?q?vO/aiWGyIuNlo27hWUlzO05PrfGxic5B0XVDRC2vMD3AH+4nTE2pk=3D?=
X-IronPort-AV: E=Sophos;i="5.88,241,1635177600"; 
   d="scan'208";a="119657414"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Dec 2021 16:01:53 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 50FDC4D15A28;
        Tue, 28 Dec 2021 16:01:51 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Dec 2021 16:01:50 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 28 Dec 2021 16:01:48 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liweihang@huawei.com>, <liangwenpeng@huawei.com>,
        <yangx.jy@cn.fujitsu.com>, <rpearsonhpe@gmail.com>,
        <y-goto@fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [RFC PATCH rdma-next 06/10] RDMA/rxe: Implement RC RDMA FLUSH service in requester side
Date:   Tue, 28 Dec 2021 16:07:13 +0800
Message-ID: <20211228080717.10666-7-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 50FDC4D15A28.A04D9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

a RC FLUSH packet consists of:
+----+------+------+
|BTH | FETH | RETH |
+----+------+------+

oA19-2: FLUSH shall be single packet message and shall have no payload.
oA19-5: FLUSH BTH shall hold the Opcode = 0x1C

FLUSH Extended Transport Header(FETH)
+-----+-----------+------------------------+----------------------+
|Bits |   31-6    |          5-4           |        3-0           |
+-----+-----------+------------------------+----------------------+
|     | Reserved  | Selectivity Level(SEL) | Placement Type(PLT)  |
+-----+-----------+------------------------+----------------------+

Selectivity Level (SEL) – defines the memory region scope the FLUSH
should apply on. Values are as follows:
• b’00 - Memory Region Range: FLUSH applies for all preceding memory
         updates to the RETH range on this QP. All RETH fields shall be
         valid in this selectivity mode. RETH:DMALen field shall be between
         zero and (2 31 -1) bytes (inclusive).
• b’01 - Memory Region: FLUSH applies for all preceding memory updates
         to RETH.R_key on this QP. RETH:DMALen and RETH:VA shall be
         ignored in this mode.
• b'10 - Reserved.
• b'11 - Reserved.

Placement Type (PLT) – Defines the memory placement guarantee of
this FLUSH. Multiple bits may be set in this field. Values are as follows:
• Bit 0 if set to '1' indicated that the FLUSH should guarantee Global
  Visibility.
• Bit 1 if set to '1' indicated that the FLUSH should guarantee
  Persistence.
• Bits 3:2 are reserved

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 drivers/infiniband/core/uverbs_cmd.c   | 16 ++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_hdr.h    | 24 ++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.c | 13 +++++++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.h |  3 +++
 drivers/infiniband/sw/rxe/rxe_req.c    | 10 ++++++++++
 include/rdma/ib_pack.h                 |  2 ++
 include/rdma/ib_verbs.h                |  9 +++++++++
 include/uapi/rdma/ib_user_verbs.h      |  7 +++++++
 include/uapi/rdma/rdma_user_rxe.h      |  6 ++++++
 9 files changed, 90 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 6b6393176b3c..ed54fb0fd13d 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2080,6 +2080,22 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 			rdma->rkey = user_wr->wr.rdma.rkey;
 
 			next = &rdma->wr;
+		} else if (user_wr->opcode == IB_WR_RDMA_FLUSH) {
+			struct ib_flush_wr *flush;
+
+			next_size = sizeof(*flush);
+			flush = alloc_wr(next_size, user_wr->num_sge);
+			if (!flush) {
+				ret = -ENOMEM;
+				goto out_put;
+			}
+
+			flush->remote_addr = user_wr->wr.flush.remote_addr;
+			flush->rkey = user_wr->wr.flush.rkey;
+			flush->type = user_wr->wr.flush.type;
+			flush->level = user_wr->wr.flush.level;
+
+			next = &flush->wr;
 		} else if (user_wr->opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
 			   user_wr->opcode == IB_WR_ATOMIC_FETCH_AND_ADD) {
 			struct ib_atomic_wr *atomic;
diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
index e432f9e37795..e37aa1944b18 100644
--- a/drivers/infiniband/sw/rxe/rxe_hdr.h
+++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
@@ -607,6 +607,29 @@ static inline void reth_set_len(struct rxe_pkt_info *pkt, u32 len)
 		rxe_opcode[pkt->opcode].offset[RXE_RETH], len);
 }
 
+/*
+ * FLUSH Extended Transport Header(FETH)
+ * +-----+-----------+------------------------+----------------------+
+ * |Bits |   31-6    |          5-4           |        3-0           |
+ * +-----+-----------+------------------------+----------------------+
+ *       | Reserved  | Selectivity Level(SEL) | Placement Type(PLT)  |
+ * +-----+-----------+------------------------+----------------------+
+ */
+#define FETH_PLT_SHIFT 0UL
+#define FETH_SEL_SHIFT 4UL
+#define FETH_RESERVED_SHIFT 6UL
+#define FETH_PLT_MASK ((1UL << FETH_SEL_SHIFT) - 1UL)
+#define FETH_SEL_MASK (~FETH_PLT_MASK & ((1UL << FETH_RESERVED_SHIFT) - 1UL))
+
+static inline void feth_init(struct rxe_pkt_info *pkt, u32 type, u32 level)
+{
+	u32 *p = (u32 *)(pkt->hdr + rxe_opcode[pkt->opcode].offset[RXE_FETH]);
+	u32 feth = ((level << FETH_SEL_SHIFT) & FETH_SEL_MASK) |
+		   ((type << FETH_PLT_SHIFT) & FETH_PLT_MASK);
+
+	*p = cpu_to_be32(feth);
+}
+
 /******************************************************************************
  * Atomic Extended Transport Header
  ******************************************************************************/
@@ -910,6 +933,7 @@ enum rxe_hdr_length {
 	RXE_ATMETH_BYTES	= sizeof(struct rxe_atmeth),
 	RXE_IETH_BYTES		= sizeof(struct rxe_ieth),
 	RXE_RDETH_BYTES		= sizeof(struct rxe_rdeth),
+	RXE_FETH_BYTES		= sizeof(u32),
 };
 
 static inline size_t header_size(struct rxe_pkt_info *pkt)
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index 3ef5a10a6efd..d61c8b354af4 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -316,6 +316,19 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 						+ RXE_AETH_BYTES,
 		}
 	},
+	[IB_OPCODE_RC_RDMA_FLUSH]			= {
+		.name	= "IB_OPCODE_RC_RDMA_FLUSH",
+		.mask	= RXE_FETH_MASK | RXE_RETH_MASK | RXE_FLUSH_MASK
+				| RXE_START_MASK | RXE_END_MASK | RXE_REQ_MASK,
+		.length = RXE_BTH_BYTES + RXE_FETH_BYTES + RXE_RETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_FETH]	= RXE_BTH_BYTES,
+			[RXE_RETH]	= RXE_BTH_BYTES	+ RXE_FETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+					+ RXE_FETH_BYTES + RXE_RETH_BYTES,
+		}
+	},
 	[IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE]			= {
 		.name	= "IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE",
 		.mask	= RXE_AETH_MASK | RXE_ATMACK_MASK | RXE_ACK_MASK
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
index 8f9aaaf260f2..dbc2eca8a92c 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -48,6 +48,7 @@ enum rxe_hdr_type {
 	RXE_DETH,
 	RXE_IMMDT,
 	RXE_PAYLOAD,
+	RXE_FETH,
 	NUM_HDR_TYPES
 };
 
@@ -63,6 +64,7 @@ enum rxe_hdr_mask {
 	RXE_IETH_MASK		= BIT(RXE_IETH),
 	RXE_RDETH_MASK		= BIT(RXE_RDETH),
 	RXE_DETH_MASK		= BIT(RXE_DETH),
+	RXE_FETH_MASK		= BIT(RXE_FETH),
 	RXE_PAYLOAD_MASK	= BIT(RXE_PAYLOAD),
 
 	RXE_REQ_MASK		= BIT(NUM_HDR_TYPES + 0),
@@ -80,6 +82,7 @@ enum rxe_hdr_mask {
 	RXE_END_MASK		= BIT(NUM_HDR_TYPES + 10),
 
 	RXE_LOOPBACK_MASK	= BIT(NUM_HDR_TYPES + 12),
+	RXE_FLUSH_MASK		= BIT(NUM_HDR_TYPES + 13),
 
 	RXE_READ_OR_ATOMIC_MASK	= (RXE_READ_MASK | RXE_ATOMIC_MASK),
 	RXE_WRITE_OR_SEND_MASK	= (RXE_WRITE_MASK | RXE_SEND_MASK),
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 5eb89052dd66..a3e9351873e2 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -220,6 +220,9 @@ static int next_opcode_rc(struct rxe_qp *qp, u32 opcode, int fits)
 				IB_OPCODE_RC_SEND_ONLY_WITH_IMMEDIATE :
 				IB_OPCODE_RC_SEND_FIRST;
 
+	case IB_WR_RDMA_FLUSH:
+		return IB_OPCODE_RC_RDMA_FLUSH;
+
 	case IB_WR_RDMA_READ:
 		return IB_OPCODE_RC_RDMA_READ_REQUEST;
 
@@ -418,6 +421,10 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 		reth_set_len(pkt, wqe->dma.resid);
 	}
 
+	/* Fill Flush Extension Transport Header */
+	if (pkt->mask & RXE_FETH_MASK)
+		feth_init(pkt, ibwr->wr.flush.type, ibwr->wr.flush.level);
+
 	if (pkt->mask & RXE_IMMDT_MASK)
 		immdt_set_imm(pkt, ibwr->ex.imm_data);
 
@@ -477,6 +484,9 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 
 			memset(pad, 0, bth_pad(pkt));
 		}
+	} else if (pkt->mask & RXE_FLUSH_MASK) {
+		// oA19-2: shall have no payload.
+		wqe->dma.resid = 0;
 	}
 
 	return 0;
diff --git a/include/rdma/ib_pack.h b/include/rdma/ib_pack.h
index a9162f25beaf..d19edb502de6 100644
--- a/include/rdma/ib_pack.h
+++ b/include/rdma/ib_pack.h
@@ -84,6 +84,7 @@ enum {
 	/* opcode 0x15 is reserved */
 	IB_OPCODE_SEND_LAST_WITH_INVALIDATE         = 0x16,
 	IB_OPCODE_SEND_ONLY_WITH_INVALIDATE         = 0x17,
+	IB_OPCODE_RDMA_FLUSH                        = 0x1C,
 
 	/* real constants follow -- see comment about above IB_OPCODE()
 	   macro for more details */
@@ -112,6 +113,7 @@ enum {
 	IB_OPCODE(RC, FETCH_ADD),
 	IB_OPCODE(RC, SEND_LAST_WITH_INVALIDATE),
 	IB_OPCODE(RC, SEND_ONLY_WITH_INVALIDATE),
+	IB_OPCODE(RC, RDMA_FLUSH),
 
 	/* UC */
 	IB_OPCODE(UC, SEND_FIRST),
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 51d58b641201..d336f2f8bb69 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1297,6 +1297,7 @@ struct ib_qp_attr {
 enum ib_wr_opcode {
 	/* These are shared with userspace */
 	IB_WR_RDMA_WRITE = IB_UVERBS_WR_RDMA_WRITE,
+	IB_WR_RDMA_FLUSH = IB_UVERBS_WR_RDMA_FLUSH,
 	IB_WR_RDMA_WRITE_WITH_IMM = IB_UVERBS_WR_RDMA_WRITE_WITH_IMM,
 	IB_WR_SEND = IB_UVERBS_WR_SEND,
 	IB_WR_SEND_WITH_IMM = IB_UVERBS_WR_SEND_WITH_IMM,
@@ -1391,6 +1392,14 @@ struct ib_atomic_wr {
 	u32			rkey;
 };
 
+struct ib_flush_wr {
+	struct ib_send_wr	wr;
+	u64			remote_addr;
+	u32			rkey;
+	u32			type;
+	u32			level;
+};
+
 static inline const struct ib_atomic_wr *atomic_wr(const struct ib_send_wr *wr)
 {
 	return container_of(wr, struct ib_atomic_wr, wr);
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 7ee73a0652f1..4b7093f58259 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -784,6 +784,7 @@ enum ib_uverbs_wr_opcode {
 	IB_UVERBS_WR_RDMA_READ_WITH_INV = 11,
 	IB_UVERBS_WR_MASKED_ATOMIC_CMP_AND_SWP = 12,
 	IB_UVERBS_WR_MASKED_ATOMIC_FETCH_AND_ADD = 13,
+	IB_UVERBS_WR_RDMA_FLUSH = 14,
 	/* Review enum ib_wr_opcode before modifying this */
 };
 
@@ -797,6 +798,12 @@ struct ib_uverbs_send_wr {
 		__u32 invalidate_rkey;
 	} ex;
 	union {
+		struct {
+			__aligned_u64 remote_addr;
+			__u32	rkey;
+			__u32	type;
+			__u32	level;
+		} flush;
 		struct {
 			__aligned_u64 remote_addr;
 			__u32 rkey;
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index f09c5c9e3dd5..45f1b5b25414 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -82,6 +82,12 @@ struct rxe_send_wr {
 		__u32		invalidate_rkey;
 	} ex;
 	union {
+		struct {
+			__aligned_u64 remote_addr;
+			__u32	rkey;
+			__u32	type;
+			__u32	level;
+		} flush;
 		struct {
 			__aligned_u64 remote_addr;
 			__u32	rkey;
-- 
2.31.1



