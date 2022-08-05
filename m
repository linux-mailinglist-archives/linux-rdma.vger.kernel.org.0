Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FF658A747
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Aug 2022 09:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240120AbiHEHkZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Aug 2022 03:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240237AbiHEHkL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Aug 2022 03:40:11 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C513D75393;
        Fri,  5 Aug 2022 00:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1659685204; i=@fujitsu.com;
        bh=0/T7xN6P2RLjUJ/goz9fWNYkCJxhMqfVYxGHi4a2fQ0=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Xa9hr7HKirmOr/IzQYPhVicCV4/XRbORWX+3wX5kfw9d+kdV/v//qE4RMlLwZb8U2
         OAPWhic5AyJ8DvuNc2xQaYWygyWfM5bUzsxKkEEw3++9UcsP0pRvWGJiwvKP0wsWZI
         LhplUb3m981Rbz5sGrAJnkXoueQd/MZrXjzAsd0Ddiauj4MT/e3UIaMNTo3JJNb2z3
         T89KQlMPwx33WJTk9GeWTC1wxbMlk4pKbrI94dU8QK0Jtc8ojF876icRfQ1IObTI7K
         qqEZKchKrbP4OE42EXxTR0jN3vxkVrPfDsYT0Er6oPQITXkWLZv93lI+IMhBnZ2Jpg
         ichfYRv9rFMCw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRWlGSWpSXmKPExsViZ8ORpBt88k2
  Swbb/QhZzv8tZTJ96gdFi5owTjBZTfi1ltri8aw6bxbNDvSwWH6YeYbb4MnUas8WpX6eYLP5e
  +sdmcf5YP7sDt8fOWXfZPRbvecnksWlVJ5tHb/M7No/LT64wenzeJOex9fNtlgD2KNbMvKT8i
  gTWjE039jAXHLSv+Ncwn7WB8bppFyMXh5DABkaJoz+nMEM4S5gk3l55xATh7GeU+LB0OmMXIy
  cHm4CGxL2Wm4wgCRGBTkaJR/3H2EAcZoHzTBLTNv1jB6kSFgiWOL51LTOIzSKgIjHl/DpWEJt
  XwFHi167DbCC2hICCxJSH78FqOAWcJDZ9WwW2QQio5mjLQhaIekGJkzOfgNnMAhISB1+8AKrn
  AOpVkpjZHQ8xpkJi1qw2JghbTeLquU3MExgFZyHpnoWkewEj0ypGi6SizPSMktzEzBxdQwMDX
  UNDU11DXSO9xCrdRL3UUt3y1OISXUO9xPJivdTiYr3iytzknBS9vNSSTYzACEspZmTawbis76
  feIUZJDiYlUd5zx98kCfEl5adUZiQWZ8QXleakFh9ilOHgUJLgDToBlBMsSk1PrUjLzAFGO0x
  agoNHSYR3HUgrb3FBYm5xZjpE6hSjPcf5nfv3MnNMnf1vPzPHcjA582vbAWYhlrz8vFQpcV4j
  kDYBkLaM0jy4obDkdIlRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMO89kCk8mXklcLtfAZ3FB
  HQW1//XIGeVJCKkpBqY1A0ClWdM1Hup3LkoR8fIPyu40XHD9Arl3HsOywr3JCT/NZ189Jr42p
  0a3sfq9Oazrzv09U9vz5ITWkGrbTLV13zTMlh/2CjoutFqGcVX/w7wv5b2VDp8Skm2KXENdyT
  rV9cbxj99PZ9NPCJwvuK00uumjIY7WsHXTB76b9ObYNdj0qVyLOHw1PVRAglOAfvdFZPZJNZ+
  n/lppl/QFY57UxZ4X043qVDk3DuP88lq+SNrbi53XM0pqxoS8L52TaLhl6aHx3tOCdokf7a5e
  qPXYYd02+Frs6NaVRlcZz2+5ecaPW3N4/6VvrXrnsjZqsRe+V+8ZeLayvhlWiuPr3nTmn+cN8
  f/S3Pi5M4g7SX/lFiKMxINtZiLihMBAt5FlckDAAA=
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-21.tower-591.messagelabs.com!1659685203!311870!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11292 invoked from network); 5 Aug 2022 07:40:03 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-21.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 5 Aug 2022 07:40:03 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id CDA797C;
        Fri,  5 Aug 2022 08:40:02 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id C198F1AE;
        Fri,  5 Aug 2022 08:40:02 +0100 (BST)
Received: from 4084fd6ad2a8.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 5 Aug 2022 08:39:57 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>,
        "Leon Romanovsky" <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     Xiao Yang <yangx.jy@fujitsu.com>, <y-goto@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        Tom Talpey <tom@talpey.com>, <tomasz.gromadzki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v4 3/6] RDMA/rxe: Implement RC RDMA FLUSH service in requester side
Date:   Fri, 5 Aug 2022 07:46:16 +0000
Message-ID: <1659685579-2-4-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1659685579-2-1-git-send-email-lizhijian@fujitsu.com>
References: <1659685579-2-1-git-send-email-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We implement new packet for FLUSH request.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V4: Remove flush union for legecy API, add WR_FLUSH_MASK
V3: Fix sparse: incorrect type in assignment; Reported-by: kernel test robot <lkp@intel.com>
V2: extend flush to include length field.
---
 drivers/infiniband/sw/rxe/rxe_hdr.h    | 20 ++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.c | 21 +++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.h |  4 ++++
 drivers/infiniband/sw/rxe/rxe_req.c    | 15 ++++++++++++++-
 include/rdma/ib_pack.h                 |  2 ++
 include/rdma/ib_verbs.h                |  1 +
 include/uapi/rdma/ib_user_verbs.h      |  1 +
 include/uapi/rdma/rdma_user_rxe.h      |  7 +++++++
 8 files changed, 70 insertions(+), 1 deletion(-)

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
index d4ba4d506f17..45dc752bd31a 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -101,6 +101,12 @@ struct rxe_wr_opcode_info rxe_wr_opcode_info[] = {
 			[IB_QPT_UC]	= WR_LOCAL_OP_MASK,
 		},
 	},
+	[IB_WR_RDMA_FLUSH]			= {
+		.name   = "IB_WR_RDMA_FLUSH",
+		.mask   = {
+			[IB_QPT_RC]	= WR_FLUSH_MASK,
+		},
+	},
 };
 
 struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
@@ -314,6 +320,21 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
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
index 8f9aaaf260f2..9274c2016339 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -20,6 +20,7 @@ enum rxe_wr_mask {
 	WR_READ_MASK			= BIT(3),
 	WR_WRITE_MASK			= BIT(4),
 	WR_LOCAL_OP_MASK		= BIT(5),
+	WR_FLUSH_MASK			= BIT(6),
 
 	WR_READ_OR_WRITE_MASK		= WR_READ_MASK | WR_WRITE_MASK,
 	WR_WRITE_OR_SEND_MASK		= WR_WRITE_MASK | WR_SEND_MASK,
@@ -48,6 +49,7 @@ enum rxe_hdr_type {
 	RXE_DETH,
 	RXE_IMMDT,
 	RXE_PAYLOAD,
+	RXE_FETH,
 	NUM_HDR_TYPES
 };
 
@@ -63,6 +65,7 @@ enum rxe_hdr_mask {
 	RXE_IETH_MASK		= BIT(RXE_IETH),
 	RXE_RDETH_MASK		= BIT(RXE_RDETH),
 	RXE_DETH_MASK		= BIT(RXE_DETH),
+	RXE_FETH_MASK		= BIT(RXE_FETH),
 	RXE_PAYLOAD_MASK	= BIT(RXE_PAYLOAD),
 
 	RXE_REQ_MASK		= BIT(NUM_HDR_TYPES + 0),
@@ -80,6 +83,7 @@ enum rxe_hdr_mask {
 	RXE_END_MASK		= BIT(NUM_HDR_TYPES + 10),
 
 	RXE_LOOPBACK_MASK	= BIT(NUM_HDR_TYPES + 12),
+	RXE_FLUSH_MASK		= BIT(NUM_HDR_TYPES + 13),
 
 	RXE_READ_OR_ATOMIC_MASK	= (RXE_READ_MASK | RXE_ATOMIC_MASK),
 	RXE_WRITE_OR_SEND_MASK	= (RXE_WRITE_MASK | RXE_SEND_MASK),
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index f63771207970..2f0161b90fa7 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -241,6 +241,9 @@ static int next_opcode_rc(struct rxe_qp *qp, u32 opcode, int fits)
 				IB_OPCODE_RC_SEND_ONLY_WITH_IMMEDIATE :
 				IB_OPCODE_RC_SEND_FIRST;
 
+	case IB_WR_RDMA_FLUSH:
+		return IB_OPCODE_RC_RDMA_FLUSH;
+
 	case IB_WR_RDMA_READ:
 		return IB_OPCODE_RC_RDMA_READ_REQUEST;
 
@@ -421,11 +424,18 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 
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
 
@@ -484,6 +494,9 @@ static int finish_packet(struct rxe_qp *qp, struct rxe_av *av,
 
 			memset(pad, 0, bth_pad(pkt));
 		}
+	} else if (pkt->mask & RXE_FLUSH_MASK) {
+		/* oA19-2: shall have no payload. */
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
index aa174cdcdf5a..16db9eb3467a 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1314,6 +1314,7 @@ struct ib_qp_attr {
 enum ib_wr_opcode {
 	/* These are shared with userspace */
 	IB_WR_RDMA_WRITE = IB_UVERBS_WR_RDMA_WRITE,
+	IB_WR_RDMA_FLUSH = IB_UVERBS_WR_RDMA_FLUSH,
 	IB_WR_RDMA_WRITE_WITH_IMM = IB_UVERBS_WR_RDMA_WRITE_WITH_IMM,
 	IB_WR_SEND = IB_UVERBS_WR_SEND,
 	IB_WR_SEND_WITH_IMM = IB_UVERBS_WR_SEND_WITH_IMM,
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index a58df0ebcb79..808cf7a39498 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -784,6 +784,7 @@ enum ib_uverbs_wr_opcode {
 	IB_UVERBS_WR_RDMA_READ_WITH_INV = 11,
 	IB_UVERBS_WR_MASKED_ATOMIC_CMP_AND_SWP = 12,
 	IB_UVERBS_WR_MASKED_ATOMIC_FETCH_AND_ADD = 13,
+	IB_UVERBS_WR_RDMA_FLUSH = 14,
 	/* Review enum ib_wr_opcode before modifying this */
 };
 
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

