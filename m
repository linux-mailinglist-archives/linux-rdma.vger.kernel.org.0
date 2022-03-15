Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7814D9880
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Mar 2022 11:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347000AbiCOKOX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Mar 2022 06:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346993AbiCOKOW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Mar 2022 06:14:22 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C04D76547;
        Tue, 15 Mar 2022 03:13:09 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3ABeTJ16xNgX04UnASnv56t+c4xyrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApD4m0TEAzmJKXj3VPK6OazH2etpxaI218klQusTcz4UxHQtv/xmBbVoQ9?=
 =?us-ascii?q?5OdWo7xwmQcns+qBpSaChohtq3yU/GYRCwPZiKa9kfF3oTJ9yEmj/nSHuOkUYY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWGULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIti?=
 =?us-ascii?q?j1LjmcEwWWaOUNg+L4pZUc/H6xEEc+WppieBmXBYfQR4/ZzGhm9FjyNRPtJW2Y?=
 =?us-ascii?q?Qk0PKzQg/lbWB5de817FfQcouGbcSHn4KR/yGWDKRMA2c5GFlk7NJcD/eB3GWx?=
 =?us-ascii?q?m+vkRKTRLZReG78qk0bCpW+s23px7BMbuNYIb/HpnyFnxCfcvR5/cTqPS6NlX9?=
 =?us-ascii?q?Dctj99DHLDVYM9xQTZmalLCJQJOPlMWAZcltOaumnT7NTZfrTq9ua0y6nPBigN?=
 =?us-ascii?q?r173kPMjWe/SLQ9lYmgCToWeu12D0BRcyN9GFzzeBtHW2iYfnlCPyQoUUEJW+6?=
 =?us-ascii?q?P9mgVTVzWsWYDUTX1+8qvmRjFC/V9NWbUcT/0IGsa833FCiSsHwTluzp3vslho?=
 =?us-ascii?q?dXcdAVu438geAzoLK7AuDQGsJVDhMbJohrsBebTgr0EKZ2snlADVHrrKYUzSe+?=
 =?us-ascii?q?62SoDf0PjIaRUcAaiAsXwoI+9Slq4hbs/5lZr6PC4bs1pusR262mGvM8UADa3w?=
 =?us-ascii?q?opZZj/82GEZrv2VpAfqT0czM=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AdDD+Aa9M34wukXNUpPVuk+A8I+orL9Y04lQ7?=
 =?us-ascii?q?vn2YSXRuHPBw8Pre+sjztCWE8Qr5N0tBpTntAsW9qDbnhPtICOoqTNCftWvdyQ?=
 =?us-ascii?q?iVxehZhOOIqVDd8m/Fh4pgPMxbEpSWZueeMbEDt7eZ3OCnKadc/PC3tLCvmfzF?=
 =?us-ascii?q?z2pgCSVja6Rb5Q9/DQqBe3cGPzVuNN4oEoaG/Mpbq36FcXQTVM6yAX4IRKztvN?=
 =?us-ascii?q?vO/aiWGyIuNlo27hWUlzO05PrfGxic5B0XVDRC2vMD3AH+4nTE2pk=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122648109"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Mar 2022 18:13:03 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 359534D16FD8;
        Tue, 15 Mar 2022 18:13:03 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 15 Mar 2022 18:13:02 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 15 Mar 2022 18:13:01 +0800
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>,
        <tom@talpey.com>, <tomasz.gromadzki@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liangwenpeng@huawei.com>, <yangx.jy@fujitsu.com>,
        <y-goto@fujitsu.com>, <rpearsonhpe@gmail.com>,
        <dan.j.williams@intel.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [RFC PATCH v3 3/7] RDMA/rxe: Implement RC RDMA FLUSH service in requester side
Date:   Tue, 15 Mar 2022 18:18:41 +0800
Message-ID: <20220315101845.4166983-4-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220315101845.4166983-1-lizhijian@fujitsu.com>
References: <20220315101845.4166983-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 359534D16FD8.A1C7C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It introudces a new packet format for FLUSH request.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3: Fix sparse: incorrect type in assignment; Reported-by: kernel test robot <lkp@intel.com>
V2: extend flush to include length field.
---
 drivers/infiniband/core/uverbs_cmd.c   | 17 +++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_hdr.h    | 20 ++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.c | 15 +++++++++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.h |  3 +++
 drivers/infiniband/sw/rxe/rxe_req.c    | 15 ++++++++++++++-
 include/rdma/ib_pack.h                 |  2 ++
 include/rdma/ib_verbs.h                | 10 ++++++++++
 include/uapi/rdma/ib_user_verbs.h      |  8 ++++++++
 include/uapi/rdma/rdma_user_rxe.h      |  7 +++++++
 9 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 6b6393176b3c..632e1747fb60 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2080,6 +2080,23 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
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
+			flush->length = user_wr->wr.flush.length;
+			flush->rkey = user_wr->wr.flush.rkey;
+			flush->type = user_wr->wr.flush.type;
+			flush->level = user_wr->wr.flush.level;
+
+			next = &flush->wr;
 		} else if (user_wr->opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
 			   user_wr->opcode == IB_WR_ATOMIC_FETCH_AND_ADD) {
 			struct ib_atomic_wr *atomic;
diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
index e432f9e37795..8063b5018445 100644
--- a/drivers/infiniband/sw/rxe/rxe_hdr.h
+++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
@@ -607,6 +607,25 @@ static inline void reth_set_len(struct rxe_pkt_info *pkt, u32 len)
 		rxe_opcode[pkt->opcode].offset[RXE_RETH], len);
 }
 
+/*
+ * FLUSH Extended Transport Header
+ */
+#define FETH_PLT_SHIFT 0UL
+#define FETH_SEL_SHIFT 4UL
+#define FETH_RESERVED_SHIFT 6UL
+#define FETH_PLT_MASK ((1UL << FETH_SEL_SHIFT) - 1UL)
+#define FETH_SEL_MASK (~FETH_PLT_MASK & ((1UL << FETH_RESERVED_SHIFT) - 1UL))
+
+static inline void feth_init(struct rxe_pkt_info *pkt, u8 type, u8 level)
+{
+	__be32 *p = (__be32 *)
+		    (pkt->hdr + rxe_opcode[pkt->opcode].offset[RXE_FETH]);
+	u32 feth = ((level << FETH_SEL_SHIFT) & FETH_SEL_MASK) |
+		   ((type << FETH_PLT_SHIFT) & FETH_PLT_MASK);
+
+	*p = cpu_to_be32(feth);
+}
+
 /******************************************************************************
  * Atomic Extended Transport Header
  ******************************************************************************/
@@ -910,6 +929,7 @@ enum rxe_hdr_length {
 	RXE_ATMETH_BYTES	= sizeof(struct rxe_atmeth),
 	RXE_IETH_BYTES		= sizeof(struct rxe_ieth),
 	RXE_RDETH_BYTES		= sizeof(struct rxe_rdeth),
+	RXE_FETH_BYTES		= sizeof(u32),
 };
 
 static inline size_t header_size(struct rxe_pkt_info *pkt)
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index df596ba7527d..adea6c16dfb5 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -316,6 +316,21 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 					  RXE_AETH_BYTES,
 		}
 	},
+	[IB_OPCODE_RC_RDMA_FLUSH]			= {
+		.name	= "IB_OPCODE_RC_RDMA_FLUSH",
+		.mask	= RXE_FETH_MASK | RXE_RETH_MASK | RXE_FLUSH_MASK |
+			  RXE_START_MASK | RXE_END_MASK | RXE_REQ_MASK,
+		.length = RXE_BTH_BYTES + RXE_FETH_BYTES + RXE_RETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_FETH]	= RXE_BTH_BYTES,
+			[RXE_RETH]	= RXE_BTH_BYTES +
+					  RXE_FETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_FETH_BYTES +
+					  RXE_RETH_BYTES,
+		}
+	},
 	[IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE]			= {
 		.name	= "IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE",
 		.mask	= RXE_AETH_MASK | RXE_ATMACK_MASK | RXE_ACK_MASK |
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
index 5eb89052dd66..708138117136 100644
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
 
@@ -413,11 +416,18 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 
 	/* init optional headers */
 	if (pkt->mask & RXE_RETH_MASK) {
-		reth_set_rkey(pkt, ibwr->wr.rdma.rkey);
+		if (pkt->mask & RXE_FETH_MASK)
+			reth_set_rkey(pkt, ibwr->wr.flush.rkey);
+		else
+			reth_set_rkey(pkt, ibwr->wr.rdma.rkey);
 		reth_set_va(pkt, wqe->iova);
 		reth_set_len(pkt, wqe->dma.resid);
 	}
 
+	/* Fill Flush Extension Transport Header */
+	if (pkt->mask & RXE_FETH_MASK)
+		feth_init(pkt, ibwr->wr.flush.type, ibwr->wr.flush.level);
+
 	if (pkt->mask & RXE_IMMDT_MASK)
 		immdt_set_imm(pkt, ibwr->ex.imm_data);
 
@@ -477,6 +487,9 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
 
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
index 465de3bab1e9..8f04e45b56aa 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1299,6 +1299,7 @@ struct ib_qp_attr {
 enum ib_wr_opcode {
 	/* These are shared with userspace */
 	IB_WR_RDMA_WRITE = IB_UVERBS_WR_RDMA_WRITE,
+	IB_WR_RDMA_FLUSH = IB_UVERBS_WR_RDMA_FLUSH,
 	IB_WR_RDMA_WRITE_WITH_IMM = IB_UVERBS_WR_RDMA_WRITE_WITH_IMM,
 	IB_WR_SEND = IB_UVERBS_WR_SEND,
 	IB_WR_SEND_WITH_IMM = IB_UVERBS_WR_SEND_WITH_IMM,
@@ -1393,6 +1394,15 @@ struct ib_atomic_wr {
 	u32			rkey;
 };
 
+struct ib_flush_wr {
+	struct ib_send_wr	wr;
+	u64			remote_addr;
+	u32			length;
+	u32			rkey;
+	u8			type;
+	u8			level;
+};
+
 static inline const struct ib_atomic_wr *atomic_wr(const struct ib_send_wr *wr)
 {
 	return container_of(wr, struct ib_atomic_wr, wr);
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 7ee73a0652f1..c4131913ef6a 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -784,6 +784,7 @@ enum ib_uverbs_wr_opcode {
 	IB_UVERBS_WR_RDMA_READ_WITH_INV = 11,
 	IB_UVERBS_WR_MASKED_ATOMIC_CMP_AND_SWP = 12,
 	IB_UVERBS_WR_MASKED_ATOMIC_FETCH_AND_ADD = 13,
+	IB_UVERBS_WR_RDMA_FLUSH = 14,
 	/* Review enum ib_wr_opcode before modifying this */
 };
 
@@ -797,6 +798,13 @@ struct ib_uverbs_send_wr {
 		__u32 invalidate_rkey;
 	} ex;
 	union {
+		struct {
+			__aligned_u64 remote_addr;
+			__u32 length;
+			__u32 rkey;
+			__u8 type;
+			__u8 level;
+		} flush;
 		struct {
 			__aligned_u64 remote_addr;
 			__u32 rkey;
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index f09c5c9e3dd5..3de56ed5c24f 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -82,6 +82,13 @@ struct rxe_send_wr {
 		__u32		invalidate_rkey;
 	} ex;
 	union {
+		struct {
+			__aligned_u64 remote_addr;
+			__u32	length;
+			__u32	rkey;
+			__u8	type;
+			__u8	level;
+		} flush;
 		struct {
 			__aligned_u64 remote_addr;
 			__u32	rkey;
-- 
2.31.1



