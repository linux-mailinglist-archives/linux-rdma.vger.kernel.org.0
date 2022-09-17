Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2AF5BB5C0
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIQDKw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIQDKt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:10:49 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A174D26D
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:10:47 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1274ec87ad5so54801639fac.0
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9I4wcPZ1fJouFFXV3leJFvUefnvjt0shk2pKmQXTP1E=;
        b=YXCqBUwuxGgqIcAfYfMsvClujDL2dPLVjuYhyxa+MAA/6k7hK12PVvI7BMtmw7MDEq
         lEe40Y9pT7Xwb5tywyeaK/OoBoujdWK1vBPyBAGVByA4bVbAriJzTwJ25nFhjTbgAPAi
         tF1onP87fFA5fFQqkEE43NEdnE8mmTtSO+j/HzwS7PHGlk3Ya0mgy4g0xIVpVfPCNN+h
         vSqzp6BxC5KCwh4lQ6lbsqkEtZMFm0DJ9ObcrqFaLlWooGMFbkbLkJ/u9yAABgENXMXk
         D4O7pq6iPt2LoUFmsob6egKaqAXFwdYSwT7xRw4sjnLfdgMxwIz/7eGF+hXxXIbijWGO
         hjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9I4wcPZ1fJouFFXV3leJFvUefnvjt0shk2pKmQXTP1E=;
        b=TmfAjkMv2AtQ0CzXOmCsFnqSQfKnug04eu+feqouVDJrH3OFeKUxmjijmBgEV8mtU+
         hL+pqJKXfMDHCFFj0O7nimdDaVBSyUrqN0F5QnXiMyPVg3c7pWmG9Y3QQv7475Xao4Fw
         roWplNQ7euAemzvd4kwsCnrPAvSt6e3yWqOXwy8fjnvK2T+oJax+Ukkw8Jpnk68umJMg
         ntLr8ltPzBzaiPo6AdXLEf5GjCu2ULmmz3GQUxZxT5T5n24P3NYEwLfhhi8/HnYIabNC
         tX8VdgX71rFFUeTyoXKMCZJrW4DCuY8Lge2si7W8940i0+gQzxuHURfBBtMqO3VqgkJX
         +ULA==
X-Gm-Message-State: ACgBeo2j+anYDkamUqqZGdFSOJhBJfqf83AyBtygUWuJsIVBl2cG9nA0
        mxbvpJs5mp6KyaQoPTOYiMOJTZqylxM=
X-Google-Smtp-Source: AA6agR5sWev4p3/aj8vgewp4mYyYm+Me5bYKrdKJ0xS7isIvQtVhJ+xKsgGvF18lbcbeuYcHyIz5Ow==
X-Received: by 2002:a05:6870:3048:b0:127:aa64:a40f with SMTP id u8-20020a056870304800b00127aa64a40fmr10317759oau.23.1663384246817;
        Fri, 16 Sep 2022 20:10:46 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id be36-20020a05687058a400b000f5e89a9c60sm4464800oab.3.2022.09.16.20.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:10:46 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 04/13] RDMA/rxe: Extend opcodes and headers to support xrc
Date:   Fri, 16 Sep 2022 22:10:23 -0500
Message-Id: <20220917031028.21187-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220917031028.21187-1-rpearsonhpe@gmail.com>
References: <20220917031028.21187-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_75_100
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extend rxe_hdr.h to include the xrceth header and
extend opcode tables in rxe_opcode.c to support xrc operations
and qps.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_hdr.h    |  36 +++
 drivers/infiniband/sw/rxe/rxe_opcode.c | 379 +++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_opcode.h |   4 +-
 3 files changed, 395 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
index e432f9e37795..e947bcf75209 100644
--- a/drivers/infiniband/sw/rxe/rxe_hdr.h
+++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
@@ -900,6 +900,41 @@ static inline void ieth_set_rkey(struct rxe_pkt_info *pkt, u32 rkey)
 		rxe_opcode[pkt->opcode].offset[RXE_IETH], rkey);
 }
 
+/******************************************************************************
+ * XRC Extended Transport Header
+ ******************************************************************************/
+struct rxe_xrceth {
+	__be32			srqn;
+};
+
+#define XRCETH_SRQN_MASK	(0x00ffffff)
+
+static inline u32 __xrceth_srqn(void *arg)
+{
+	struct rxe_xrceth *xrceth = arg;
+
+	return be32_to_cpu(xrceth->srqn);
+}
+
+static inline void __xrceth_set_srqn(void *arg, u32 srqn)
+{
+	struct rxe_xrceth *xrceth = arg;
+
+	xrceth->srqn = cpu_to_be32(srqn & XRCETH_SRQN_MASK);
+}
+
+static inline u32 xrceth_srqn(struct rxe_pkt_info *pkt)
+{
+	return __xrceth_srqn(pkt->hdr +
+		rxe_opcode[pkt->opcode].offset[RXE_XRCETH]);
+}
+
+static inline void xrceth_set_srqn(struct rxe_pkt_info *pkt, u32 srqn)
+{
+	__xrceth_set_srqn(pkt->hdr +
+		rxe_opcode[pkt->opcode].offset[RXE_XRCETH], srqn);
+}
+
 enum rxe_hdr_length {
 	RXE_BTH_BYTES		= sizeof(struct rxe_bth),
 	RXE_DETH_BYTES		= sizeof(struct rxe_deth),
@@ -909,6 +944,7 @@ enum rxe_hdr_length {
 	RXE_ATMACK_BYTES	= sizeof(struct rxe_atmack),
 	RXE_ATMETH_BYTES	= sizeof(struct rxe_atmeth),
 	RXE_IETH_BYTES		= sizeof(struct rxe_ieth),
+	RXE_XRCETH_BYTES	= sizeof(struct rxe_xrceth),
 	RXE_RDETH_BYTES		= sizeof(struct rxe_rdeth),
 };
 
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index 6b1a1f197c4d..4ae926a37ef8 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -15,51 +15,58 @@ struct rxe_wr_opcode_info rxe_wr_opcode_info[] = {
 	[IB_WR_RDMA_WRITE]				= {
 		.name	= "IB_WR_RDMA_WRITE",
 		.mask	= {
-			[IB_QPT_RC]	= WR_INLINE_MASK | WR_WRITE_MASK,
-			[IB_QPT_UC]	= WR_INLINE_MASK | WR_WRITE_MASK,
+			[IB_QPT_RC]		= WR_INLINE_MASK | WR_WRITE_MASK,
+			[IB_QPT_UC]		= WR_INLINE_MASK | WR_WRITE_MASK,
+			[IB_QPT_XRC_INI]	= WR_INLINE_MASK | WR_WRITE_MASK,
 		},
 	},
 	[IB_WR_RDMA_WRITE_WITH_IMM]			= {
 		.name	= "IB_WR_RDMA_WRITE_WITH_IMM",
 		.mask	= {
-			[IB_QPT_RC]	= WR_INLINE_MASK | WR_WRITE_MASK,
-			[IB_QPT_UC]	= WR_INLINE_MASK | WR_WRITE_MASK,
+			[IB_QPT_RC]		= WR_INLINE_MASK | WR_WRITE_MASK,
+			[IB_QPT_UC]		= WR_INLINE_MASK | WR_WRITE_MASK,
+			[IB_QPT_XRC_INI]	= WR_INLINE_MASK | WR_WRITE_MASK,
 		},
 	},
 	[IB_WR_SEND]					= {
 		.name	= "IB_WR_SEND",
 		.mask	= {
-			[IB_QPT_GSI]	= WR_INLINE_MASK | WR_SEND_MASK,
-			[IB_QPT_RC]	= WR_INLINE_MASK | WR_SEND_MASK,
-			[IB_QPT_UC]	= WR_INLINE_MASK | WR_SEND_MASK,
-			[IB_QPT_UD]	= WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_GSI]		= WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_RC]		= WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_UC]		= WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_UD]		= WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_XRC_INI]	= WR_INLINE_MASK | WR_SEND_MASK,
 		},
 	},
 	[IB_WR_SEND_WITH_IMM]				= {
 		.name	= "IB_WR_SEND_WITH_IMM",
 		.mask	= {
-			[IB_QPT_GSI]	= WR_INLINE_MASK | WR_SEND_MASK,
-			[IB_QPT_RC]	= WR_INLINE_MASK | WR_SEND_MASK,
-			[IB_QPT_UC]	= WR_INLINE_MASK | WR_SEND_MASK,
-			[IB_QPT_UD]	= WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_GSI]		= WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_RC]		= WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_UC]		= WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_UD]		= WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_XRC_INI]	= WR_INLINE_MASK | WR_SEND_MASK,
 		},
 	},
 	[IB_WR_RDMA_READ]				= {
 		.name	= "IB_WR_RDMA_READ",
 		.mask	= {
-			[IB_QPT_RC]	= WR_READ_MASK,
+			[IB_QPT_RC]		= WR_READ_MASK,
+			[IB_QPT_XRC_INI]	= WR_READ_MASK,
 		},
 	},
 	[IB_WR_ATOMIC_CMP_AND_SWP]			= {
 		.name	= "IB_WR_ATOMIC_CMP_AND_SWP",
 		.mask	= {
-			[IB_QPT_RC]	= WR_ATOMIC_MASK,
+			[IB_QPT_RC]		= WR_ATOMIC_MASK,
+			[IB_QPT_XRC_INI]	= WR_ATOMIC_MASK,
 		},
 	},
 	[IB_WR_ATOMIC_FETCH_AND_ADD]			= {
 		.name	= "IB_WR_ATOMIC_FETCH_AND_ADD",
 		.mask	= {
-			[IB_QPT_RC]	= WR_ATOMIC_MASK,
+			[IB_QPT_RC]		= WR_ATOMIC_MASK,
+			[IB_QPT_XRC_INI]	= WR_ATOMIC_MASK,
 		},
 	},
 	[IB_WR_LSO]					= {
@@ -71,34 +78,39 @@ struct rxe_wr_opcode_info rxe_wr_opcode_info[] = {
 	[IB_WR_SEND_WITH_INV]				= {
 		.name	= "IB_WR_SEND_WITH_INV",
 		.mask	= {
-			[IB_QPT_RC]	= WR_INLINE_MASK | WR_SEND_MASK,
-			[IB_QPT_UC]	= WR_INLINE_MASK | WR_SEND_MASK,
-			[IB_QPT_UD]	= WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_RC]		= WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_UC]		= WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_UD]		= WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_XRC_INI]	= WR_INLINE_MASK | WR_SEND_MASK,
 		},
 	},
 	[IB_WR_RDMA_READ_WITH_INV]			= {
 		.name	= "IB_WR_RDMA_READ_WITH_INV",
 		.mask	= {
-			[IB_QPT_RC]	= WR_READ_MASK,
+			[IB_QPT_RC]		= WR_READ_MASK,
+			[IB_QPT_XRC_INI]	= WR_READ_MASK,
 		},
 	},
 	[IB_WR_LOCAL_INV]				= {
 		.name	= "IB_WR_LOCAL_INV",
 		.mask	= {
-			[IB_QPT_RC]	= WR_LOCAL_OP_MASK,
+			[IB_QPT_RC]		= WR_LOCAL_OP_MASK,
+			[IB_QPT_XRC_INI]	= WR_LOCAL_OP_MASK,
 		},
 	},
 	[IB_WR_REG_MR]					= {
 		.name	= "IB_WR_REG_MR",
 		.mask	= {
-			[IB_QPT_RC]	= WR_LOCAL_OP_MASK,
+			[IB_QPT_RC]		= WR_LOCAL_OP_MASK,
+			[IB_QPT_XRC_INI]	= WR_LOCAL_OP_MASK,
 		},
 	},
 	[IB_WR_BIND_MW]					= {
 		.name	= "IB_WR_BIND_MW",
 		.mask	= {
-			[IB_QPT_RC]	= WR_LOCAL_OP_MASK,
-			[IB_QPT_UC]	= WR_LOCAL_OP_MASK,
+			[IB_QPT_RC]		= WR_LOCAL_OP_MASK,
+			[IB_QPT_UC]		= WR_LOCAL_OP_MASK,
+			[IB_QPT_XRC_INI]	= WR_LOCAL_OP_MASK,
 		},
 	},
 };
@@ -918,6 +930,327 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 		}
 	},
 
+	/* XRC */
+	[IB_OPCODE_XRC_SEND_FIRST]			= {
+		.name	= "IB_OPCODE_XRC_SEND_FIRST",
+		.mask	= RXE_XRCETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
+			  RXE_RWR_MASK | RXE_SEND_MASK | RXE_FIRST_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_SEND_MIDDLE]		= {
+		.name	= "IB_OPCODE_XRC_SEND_MIDDLE",
+		.mask	= RXE_XRCETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
+			  RXE_SEND_MASK | RXE_MIDDLE_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_SEND_LAST]			= {
+		.name	= "IB_OPCODE_XRC_SEND_LAST",
+		.mask	= RXE_XRCETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
+			  RXE_COMP_MASK | RXE_SEND_MASK | RXE_LAST_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_SEND_LAST_WITH_IMMEDIATE]		= {
+		.name	= "IB_OPCODE_XRC_SEND_LAST_WITH_IMMEDIATE",
+		.mask	= RXE_XRCETH_MASK | RXE_IMMDT_MASK | RXE_PAYLOAD_MASK |
+			  RXE_REQ_MASK | RXE_COMP_MASK | RXE_SEND_MASK |
+			  RXE_LAST_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_IMMDT_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_IMMDT]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES +
+					  RXE_IMMDT_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_SEND_ONLY]			= {
+		.name	= "IB_OPCODE_XRC_SEND_ONLY",
+		.mask	= RXE_XRCETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
+			  RXE_COMP_MASK | RXE_RWR_MASK | RXE_SEND_MASK |
+			  RXE_ONLY_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_SEND_ONLY_WITH_IMMEDIATE]		= {
+		.name	= "IB_OPCODE_XRC_SEND_ONLY_WITH_IMMEDIATE",
+		.mask	= RXE_XRCETH_MASK | RXE_IMMDT_MASK | RXE_PAYLOAD_MASK |
+			  RXE_REQ_MASK | RXE_COMP_MASK | RXE_RWR_MASK |
+			  RXE_SEND_MASK | RXE_ONLY_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_IMMDT_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_IMMDT]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES +
+					  RXE_IMMDT_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_RDMA_WRITE_FIRST]		= {
+		.name	= "IB_OPCODE_XRC_RDMA_WRITE_FIRST",
+		.mask	= RXE_XRCETH_MASK | RXE_RETH_MASK | RXE_PAYLOAD_MASK |
+			  RXE_REQ_MASK | RXE_WRITE_MASK | RXE_FIRST_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_RETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_RETH]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES +
+					  RXE_RETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_RDMA_WRITE_MIDDLE]		= {
+		.name	= "IB_OPCODE_XRC_RDMA_WRITE_MIDDLE",
+		.mask	= RXE_XRCETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
+			  RXE_WRITE_MASK | RXE_MIDDLE_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_RDMA_WRITE_LAST]			= {
+		.name	= "IB_OPCODE_XRC_RDMA_WRITE_LAST",
+		.mask	= RXE_XRCETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK |
+			  RXE_WRITE_MASK | RXE_LAST_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_RDMA_WRITE_LAST_WITH_IMMEDIATE]		= {
+		.name	= "IB_OPCODE_XRC_RDMA_WRITE_LAST_WITH_IMMEDIATE",
+		.mask	= RXE_XRCETH_MASK | RXE_IMMDT_MASK | RXE_PAYLOAD_MASK |
+			  RXE_REQ_MASK | RXE_WRITE_MASK | RXE_COMP_MASK |
+			  RXE_RWR_MASK | RXE_LAST_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_IMMDT_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_IMMDT]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES +
+					  RXE_IMMDT_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_RDMA_WRITE_ONLY]			= {
+		.name	= "IB_OPCODE_XRC_RDMA_WRITE_ONLY",
+		.mask	= RXE_XRCETH_MASK | RXE_RETH_MASK | RXE_PAYLOAD_MASK |
+			  RXE_REQ_MASK | RXE_WRITE_MASK | RXE_ONLY_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_RETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_RETH]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES +
+					  RXE_RETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_RDMA_WRITE_ONLY_WITH_IMMEDIATE]		= {
+		.name	= "IB_OPCODE_XRC_RDMA_WRITE_ONLY_WITH_IMMEDIATE",
+		.mask	= RXE_XRCETH_MASK | RXE_RETH_MASK | RXE_IMMDT_MASK |
+			  RXE_PAYLOAD_MASK | RXE_REQ_MASK | RXE_WRITE_MASK |
+			  RXE_COMP_MASK | RXE_RWR_MASK | RXE_ONLY_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_IMMDT_BYTES +
+			  RXE_RETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_RETH]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES,
+			[RXE_IMMDT]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES +
+					  RXE_RETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES +
+					  RXE_RETH_BYTES +
+					  RXE_IMMDT_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_RDMA_READ_REQUEST]			= {
+		.name	= "IB_OPCODE_XRC_RDMA_READ_REQUEST",
+		.mask	= RXE_XRCETH_MASK | RXE_RETH_MASK | RXE_REQ_MASK |
+			  RXE_READ_MASK | RXE_ONLY_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_RETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_RETH]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES +
+					  RXE_RETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_RDMA_READ_RESPONSE_FIRST]		= {
+		.name	= "IB_OPCODE_XRC_RDMA_READ_RESPONSE_FIRST",
+		.mask	= RXE_AETH_MASK | RXE_PAYLOAD_MASK | RXE_ACK_MASK |
+			  RXE_FIRST_MASK,
+		.length = RXE_BTH_BYTES + RXE_AETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_AETH]	= RXE_BTH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_AETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_RDMA_READ_RESPONSE_MIDDLE]		= {
+		.name	= "IB_OPCODE_XRC_RDMA_READ_RESPONSE_MIDDLE",
+		.mask	= RXE_PAYLOAD_MASK | RXE_ACK_MASK | RXE_MIDDLE_MASK,
+		.length = RXE_BTH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_RDMA_READ_RESPONSE_LAST]		= {
+		.name	= "IB_OPCODE_XRC_RDMA_READ_RESPONSE_LAST",
+		.mask	= RXE_AETH_MASK | RXE_PAYLOAD_MASK | RXE_ACK_MASK |
+			  RXE_LAST_MASK,
+		.length = RXE_BTH_BYTES + RXE_AETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_AETH]	= RXE_BTH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_AETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_RDMA_READ_RESPONSE_ONLY]		= {
+		.name	= "IB_OPCODE_XRC_RDMA_READ_RESPONSE_ONLY",
+		.mask	= RXE_AETH_MASK | RXE_PAYLOAD_MASK | RXE_ACK_MASK |
+			  RXE_ONLY_MASK,
+		.length = RXE_BTH_BYTES + RXE_AETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_AETH]	= RXE_BTH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_AETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_ACKNOWLEDGE]			= {
+		.name	= "IB_OPCODE_XRC_ACKNOWLEDGE",
+		.mask	= RXE_AETH_MASK | RXE_ACK_MASK | RXE_ONLY_MASK,
+		.length = RXE_BTH_BYTES + RXE_AETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_AETH]	= RXE_BTH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_AETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_ATOMIC_ACKNOWLEDGE]			= {
+		.name	= "IB_OPCODE_XRC_ATOMIC_ACKNOWLEDGE",
+		.mask	= RXE_AETH_MASK | RXE_ATMACK_MASK | RXE_ACK_MASK |
+			  RXE_ONLY_MASK,
+		.length = RXE_BTH_BYTES + RXE_ATMACK_BYTES + RXE_AETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_AETH]	= RXE_BTH_BYTES,
+			[RXE_ATMACK]	= RXE_BTH_BYTES +
+					  RXE_AETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_AETH_BYTES +
+					  RXE_ATMACK_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_COMPARE_SWAP]			= {
+		.name	= "IB_OPCODE_XRC_COMPARE_SWAP",
+		.mask	= RXE_XRCETH_MASK | RXE_ATMETH_MASK | RXE_REQ_MASK |
+			  RXE_ATOMIC_MASK | RXE_ONLY_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_ATMETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_ATMETH]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES +
+					  RXE_ATMETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_FETCH_ADD]			= {
+		.name	= "IB_OPCODE_XRC_FETCH_ADD",
+		.mask	= RXE_XRCETH_MASK | RXE_ATMETH_MASK | RXE_REQ_MASK |
+			  RXE_ATOMIC_MASK | RXE_ONLY_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_ATMETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_ATMETH]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES +
+					  RXE_ATMETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_SEND_LAST_WITH_INVALIDATE]		= {
+		.name	= "IB_OPCODE_XRC_SEND_LAST_WITH_INVALIDATE",
+		.mask	= RXE_XRCETH_MASK | RXE_IETH_MASK | RXE_PAYLOAD_MASK |
+			  RXE_REQ_MASK | RXE_COMP_MASK | RXE_SEND_MASK |
+			  RXE_LAST_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_IETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_IETH]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES +
+					  RXE_IETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_SEND_ONLY_WITH_INVALIDATE]		= {
+		.name	= "IB_OPCODE_XRC_SEND_ONLY_INV",
+		.mask	= RXE_XRCETH_MASK | RXE_IETH_MASK | RXE_PAYLOAD_MASK |
+			  RXE_REQ_MASK | RXE_COMP_MASK | RXE_RWR_MASK |
+			  RXE_SEND_MASK | RXE_ONLY_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_IETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_IETH]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES +
+					  RXE_XRCETH_BYTES +
+					  RXE_IETH_BYTES,
+		}
+	},
 };
 
 static int next_opcode_rc(struct rxe_qp *qp, u32 opcode, int fits)
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
index d2b6a8232e92..5528a47f0266 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -30,7 +30,7 @@ enum rxe_wr_mask {
 
 struct rxe_wr_opcode_info {
 	char			*name;
-	enum rxe_wr_mask	mask[WR_MAX_QPT];
+	enum rxe_wr_mask	mask[IB_QPT_MAX];
 };
 
 extern struct rxe_wr_opcode_info rxe_wr_opcode_info[];
@@ -44,6 +44,7 @@ enum rxe_hdr_type {
 	RXE_ATMETH,
 	RXE_ATMACK,
 	RXE_IETH,
+	RXE_XRCETH,
 	RXE_RDETH,
 	RXE_DETH,
 	RXE_IMMDT,
@@ -61,6 +62,7 @@ enum rxe_hdr_mask {
 	RXE_ATMETH_MASK		= BIT(RXE_ATMETH),
 	RXE_ATMACK_MASK		= BIT(RXE_ATMACK),
 	RXE_IETH_MASK		= BIT(RXE_IETH),
+	RXE_XRCETH_MASK		= BIT(RXE_XRCETH),
 	RXE_RDETH_MASK		= BIT(RXE_RDETH),
 	RXE_DETH_MASK		= BIT(RXE_DETH),
 	RXE_PAYLOAD_MASK	= BIT(RXE_PAYLOAD),
-- 
2.34.1

