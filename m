Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFFC6443E4
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Dec 2022 14:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbiLFNDB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Dec 2022 08:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiLFNCV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Dec 2022 08:02:21 -0500
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2606C775;
        Tue,  6 Dec 2022 05:02:19 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="98835149"
X-IronPort-AV: E=Sophos;i="5.96,222,1665414000"; 
   d="scan'208";a="98835149"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP; 06 Dec 2022 22:02:17 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 301B6DD996;
        Tue,  6 Dec 2022 22:02:16 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 68C64BF4AF;
        Tue,  6 Dec 2022 22:02:15 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 59DE22340E31;
        Tue,  6 Dec 2022 22:02:14 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, tom@talpey.com,
        tomasz.gromadzki@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH 05/10] RDMA/rxe: Extend rxe packet format to support flush
Date:   Tue,  6 Dec 2022 21:01:56 +0800
Message-Id: <20221206130201.30986-6-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206130201.30986-1-lizhijian@fujitsu.com>
References: <20221206130201.30986-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27306.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27306.007
X-TMASE-Result: 10--6.410700-10.000000
X-TMASE-MatchedRID: p4zY1N5EKtazivLrJCCCm31JIA4rhsZ/1QQ6Jx/fflY6FHRWx2FGsL8F
        Hrw7frluf146W0iUu2tacZzTSiX0+dDFhoVadDNxnXdphQTSK/JgSkbYPaRxGnFKJkg2RU9v2ZX
        sky9PWr9q337+/hURJcELHyhROniB5POQ5JvcZ5LwlvzzUUaf2X0tCKdnhB589yM15V5aWpj6C0
        ePs7A07fyjtizU0rhj5YpIBaBIqitnLN+5mM+907bwGnXrujJUjStCvk3nFDM=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extend rxe opcode tables, headers, helper and constants to support
flush operations.

Refer to the IBA A19.4.1 for more FETH definition details

Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V5: new FETH structure and simplify header helper
    new names and new patch split scheme, suggested by Bob.
---
 drivers/infiniband/sw/rxe/rxe_hdr.h    | 47 ++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.c | 17 ++++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.h | 14 +++++---
 3 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
index 804594b76040..46f82b27fcd2 100644
--- a/drivers/infiniband/sw/rxe/rxe_hdr.h
+++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
@@ -607,6 +607,52 @@ static inline void reth_set_len(struct rxe_pkt_info *pkt, u32 len)
 		rxe_opcode[pkt->opcode].offset[RXE_RETH], len);
 }
 
+/******************************************************************************
+ * FLUSH Extended Transport Header
+ ******************************************************************************/
+
+struct rxe_feth {
+	__be32 bits;
+};
+
+#define FETH_PLT_MASK		(0x0000000f) /* bits 3-0 */
+#define FETH_SEL_MASK		(0x00000030) /* bits 5-4 */
+#define FETH_SEL_SHIFT		(4U)
+
+static inline u32 __feth_plt(void *arg)
+{
+	struct rxe_feth *feth = arg;
+
+	return be32_to_cpu(feth->bits) & FETH_PLT_MASK;
+}
+
+static inline u32 __feth_sel(void *arg)
+{
+	struct rxe_feth *feth = arg;
+
+	return (be32_to_cpu(feth->bits) & FETH_SEL_MASK) >> FETH_SEL_SHIFT;
+}
+
+static inline u32 feth_plt(struct rxe_pkt_info *pkt)
+{
+	return __feth_plt(pkt->hdr + rxe_opcode[pkt->opcode].offset[RXE_FETH]);
+}
+
+static inline u32 feth_sel(struct rxe_pkt_info *pkt)
+{
+	return __feth_sel(pkt->hdr + rxe_opcode[pkt->opcode].offset[RXE_FETH]);
+}
+
+static inline void feth_init(struct rxe_pkt_info *pkt, u8 type, u8 level)
+{
+	struct rxe_feth *feth = (struct rxe_feth *)
+		    (pkt->hdr + rxe_opcode[pkt->opcode].offset[RXE_FETH]);
+	u32 bits = ((level << FETH_SEL_SHIFT) & FETH_SEL_MASK) |
+		   (type & FETH_PLT_MASK);
+
+	feth->bits = cpu_to_be32(bits);
+}
+
 /******************************************************************************
  * Atomic Extended Transport Header
  ******************************************************************************/
@@ -909,6 +955,7 @@ enum rxe_hdr_length {
 	RXE_ATMETH_BYTES	= sizeof(struct rxe_atmeth),
 	RXE_IETH_BYTES		= sizeof(struct rxe_ieth),
 	RXE_RDETH_BYTES		= sizeof(struct rxe_rdeth),
+	RXE_FETH_BYTES		= sizeof(struct rxe_feth),
 };
 
 static inline size_t header_size(struct rxe_pkt_info *pkt)
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index fb196029048e..5c0d5c6ffda4 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -101,6 +101,12 @@ struct rxe_wr_opcode_info rxe_wr_opcode_info[] = {
 			[IB_QPT_UC]	= WR_LOCAL_OP_MASK,
 		},
 	},
+	[IB_WR_FLUSH]					= {
+		.name   = "IB_WR_FLUSH",
+		.mask   = {
+			[IB_QPT_RC]	= WR_FLUSH_MASK,
+		},
+	},
 	[IB_WR_ATOMIC_WRITE]                       = {
 		.name   = "IB_WR_ATOMIC_WRITE",
 		.mask   = {
@@ -384,6 +390,17 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 					  RXE_IETH_BYTES,
 		}
 	},
+	[IB_OPCODE_RC_FLUSH]					= {
+		.name	= "IB_OPCODE_RC_FLUSH",
+		.mask	= RXE_FETH_MASK | RXE_RETH_MASK | RXE_FLUSH_MASK |
+			  RXE_START_MASK | RXE_END_MASK | RXE_REQ_MASK,
+		.length = RXE_BTH_BYTES + RXE_FETH_BYTES + RXE_RETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_FETH]	= RXE_BTH_BYTES,
+			[RXE_RETH]	= RXE_BTH_BYTES + RXE_FETH_BYTES,
+		}
+	},
 	[IB_OPCODE_RC_ATOMIC_WRITE]                        = {
 		.name   = "IB_OPCODE_RC_ATOMIC_WRITE",
 		.mask   = RXE_RETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
index a470e9b0b884..cea4e0a63919 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -20,6 +20,7 @@ enum rxe_wr_mask {
 	WR_READ_MASK			= BIT(3),
 	WR_WRITE_MASK			= BIT(4),
 	WR_LOCAL_OP_MASK		= BIT(5),
+	WR_FLUSH_MASK			= BIT(6),
 	WR_ATOMIC_WRITE_MASK		= BIT(7),
 
 	WR_READ_OR_WRITE_MASK		= WR_READ_MASK | WR_WRITE_MASK,
@@ -48,6 +49,7 @@ enum rxe_hdr_type {
 	RXE_RDETH,
 	RXE_DETH,
 	RXE_IMMDT,
+	RXE_FETH,
 	RXE_PAYLOAD,
 	NUM_HDR_TYPES
 };
@@ -64,6 +66,7 @@ enum rxe_hdr_mask {
 	RXE_IETH_MASK		= BIT(RXE_IETH),
 	RXE_RDETH_MASK		= BIT(RXE_RDETH),
 	RXE_DETH_MASK		= BIT(RXE_DETH),
+	RXE_FETH_MASK		= BIT(RXE_FETH),
 	RXE_PAYLOAD_MASK	= BIT(RXE_PAYLOAD),
 
 	RXE_REQ_MASK		= BIT(NUM_HDR_TYPES + 0),
@@ -72,13 +75,14 @@ enum rxe_hdr_mask {
 	RXE_WRITE_MASK		= BIT(NUM_HDR_TYPES + 3),
 	RXE_READ_MASK		= BIT(NUM_HDR_TYPES + 4),
 	RXE_ATOMIC_MASK		= BIT(NUM_HDR_TYPES + 5),
+	RXE_FLUSH_MASK		= BIT(NUM_HDR_TYPES + 6),
 
-	RXE_RWR_MASK		= BIT(NUM_HDR_TYPES + 6),
-	RXE_COMP_MASK		= BIT(NUM_HDR_TYPES + 7),
+	RXE_RWR_MASK		= BIT(NUM_HDR_TYPES + 7),
+	RXE_COMP_MASK		= BIT(NUM_HDR_TYPES + 8),
 
-	RXE_START_MASK		= BIT(NUM_HDR_TYPES + 8),
-	RXE_MIDDLE_MASK		= BIT(NUM_HDR_TYPES + 9),
-	RXE_END_MASK		= BIT(NUM_HDR_TYPES + 10),
+	RXE_START_MASK		= BIT(NUM_HDR_TYPES + 9),
+	RXE_MIDDLE_MASK		= BIT(NUM_HDR_TYPES + 10),
+	RXE_END_MASK		= BIT(NUM_HDR_TYPES + 11),
 
 	RXE_LOOPBACK_MASK	= BIT(NUM_HDR_TYPES + 12),
 
-- 
2.31.1

