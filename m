Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D848162B4F9
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 09:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbiKPIUk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Nov 2022 03:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiKPIUa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Nov 2022 03:20:30 -0500
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130DA1103;
        Wed, 16 Nov 2022 00:20:27 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="96960399"
X-IronPort-AV: E=Sophos;i="5.96,167,1665414000"; 
   d="scan'208";a="96960399"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 16 Nov 2022 17:20:24 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 484E3D3EB2;
        Wed, 16 Nov 2022 17:20:22 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7417CCFF87;
        Wed, 16 Nov 2022 17:20:21 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5993323401D1;
        Wed, 16 Nov 2022 17:20:20 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org
Cc:     Mark Bloch <mbloch@nvidia.com>, Tom Talpey <tom@talpey.com>,
        tomasz.gromadzki@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Xiao Yang <yangx.jy@fujitsu.com>, y-goto@fujitsu.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH v6 05/10] RDMA/rxe: Extend rxe packet format to support flush
Date:   Wed, 16 Nov 2022 16:19:46 +0800
Message-Id: <20221116081951.32750-6-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116081951.32750-1-lizhijian@fujitsu.com>
References: <20221116081951.32750-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27266.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27266.006
X-TMASE-Result: 10--6.410700-10.000000
X-TMASE-MatchedRID: p4zY1N5EKtazivLrJCCCm31JIA4rhsZ/1QQ6Jx/fflY6FHRWx2FGsL8F
        Hrw7frluf146W0iUu2tacZzTSiX0+dDFhoVadDNxnXdphQTSK/JgSkbYPaRxGnFKJkg2RU9v2ZX
        sky9PWr9q337+/hURJfKWMlUiyd4tOtq2MCn+D5WXfrypKnpvnn0tCKdnhB589yM15V5aWpj6C0
        ePs7A07cNbTFVOzjU86pzYB3PdaGXRm3fSPuhFIbq5sRWcXvR1v3CwvB+AlKc=
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
 drivers/infiniband/sw/rxe/rxe_opcode.h | 16 +++++----
 3 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
index e432f9e37795..e995a97c54fd 100644
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
@@ -910,6 +956,7 @@ enum rxe_hdr_length {
 	RXE_ATMETH_BYTES	= sizeof(struct rxe_atmeth),
 	RXE_IETH_BYTES		= sizeof(struct rxe_ieth),
 	RXE_RDETH_BYTES		= sizeof(struct rxe_rdeth),
+	RXE_FETH_BYTES		= sizeof(struct rxe_feth),
 };
 
 static inline size_t header_size(struct rxe_pkt_info *pkt)
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index d4ba4d506f17..55aad13e57bb 100644
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
 };
 
 struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
@@ -378,6 +384,17 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
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
 
 	/* UC */
 	[IB_OPCODE_UC_SEND_FIRST]			= {
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
index 8f9aaaf260f2..02d256745793 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -19,7 +19,8 @@ enum rxe_wr_mask {
 	WR_SEND_MASK			= BIT(2),
 	WR_READ_MASK			= BIT(3),
 	WR_WRITE_MASK			= BIT(4),
-	WR_LOCAL_OP_MASK		= BIT(5),
+	WR_FLUSH_MASK			= BIT(5),
+	WR_LOCAL_OP_MASK		= BIT(6),
 
 	WR_READ_OR_WRITE_MASK		= WR_READ_MASK | WR_WRITE_MASK,
 	WR_WRITE_OR_SEND_MASK		= WR_WRITE_MASK | WR_SEND_MASK,
@@ -47,6 +48,7 @@ enum rxe_hdr_type {
 	RXE_RDETH,
 	RXE_DETH,
 	RXE_IMMDT,
+	RXE_FETH,
 	RXE_PAYLOAD,
 	NUM_HDR_TYPES
 };
@@ -63,6 +65,7 @@ enum rxe_hdr_mask {
 	RXE_IETH_MASK		= BIT(RXE_IETH),
 	RXE_RDETH_MASK		= BIT(RXE_RDETH),
 	RXE_DETH_MASK		= BIT(RXE_DETH),
+	RXE_FETH_MASK		= BIT(RXE_FETH),
 	RXE_PAYLOAD_MASK	= BIT(RXE_PAYLOAD),
 
 	RXE_REQ_MASK		= BIT(NUM_HDR_TYPES + 0),
@@ -71,13 +74,14 @@ enum rxe_hdr_mask {
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

