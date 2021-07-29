Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE873DAF81
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 00:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbhG2Wun (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 18:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbhG2Wun (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 18:50:43 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE83C0613C1
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:39 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so7564879oti.0
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BbXBWQZTw3gL3kkXaxyVIvZJ45rhET3fUXUaeK/wwz0=;
        b=CglTUo9N0JoPBLnrLFrzhoIq+8ijkIiUYRhZa3KesC2WJ9KOD0UUlOE8XGebmtzjDQ
         4G0pD5QIDmrGAuy1Wd+F+HLNYKmWoamxZZ7mHJ2bzZJ5OYnmOMhU6H1tyEqbtiDIxA1s
         P7oCjxr4KXdIkQpubZbaCZhmliKxFLnwIN/1u+rtGoSicRsCMrp8k27bmSk7CeXyBWBY
         pRVMeDUeIsfR4TpoaYXOcUNd/h+MxJPooGik1P/E38siS1YveocyRtW00a5lSZzTNHpN
         HRIRbQnYQwlEg1f+FPO3Rl/73fHrNFel7nWODHFda6mnGfxyq1ynfXJXkOc29FBmVS4D
         XJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BbXBWQZTw3gL3kkXaxyVIvZJ45rhET3fUXUaeK/wwz0=;
        b=Hb7oCBNEpifSQKkoCC0J0chQb9mO7aD9wlWjVG7B+l2WTzkSRcWQEL5Mi2q4Y86LJk
         vVXAt4v/BuScLTN0VLtduvZiOGi3ew0HtR3/WhhWf33QaB95f8mStZnH5OEmXjIJsCG4
         cj0131kgvojzwKLlVxxJK9UR+sDxV8ne5mCY7yes2wsRVVGltsXh0YU8d3hHbQgsydC0
         Aro0OH67E0cmB6Vtt1iwcHZ3EL0AVfoeTfmUXmRKZL8WVONcqExZT5pt/xV44PtlJkIt
         EUWWepzJMT2QgjDEhHLKpb2/PfOI+AjTtONHic5VlG0F9hPkbi08sa/DRwujJ97qwnEX
         vqcg==
X-Gm-Message-State: AOAM530wdb7Wrb7N9Q9HEjcgT7iz5qvKsQARM1jjJHsLItKrqppjg0I5
        Of8c9dVLF9k7qxWzP0t+Smo=
X-Google-Smtp-Source: ABdhPJyRJt0WdBZZKv0MbpSZfk8QkJrw0QaD+jV+pnrAOEsXScsr1Oe1YfWKxFhqfsWklvuIxebI3g==
X-Received: by 2002:a05:6830:215a:: with SMTP id r26mr4945312otd.244.1627599039201;
        Thu, 29 Jul 2021 15:50:39 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id r20sm856300oic.47.2021.07.29.15.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:50:38 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 07/13] RDMA/rxe: Add XRC opcodes to rxe_opcode_info
Date:   Thu, 29 Jul 2021 17:49:10 -0500
Message-Id: <20210729224915.38986-8-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729224915.38986-1-rpearsonhpe@gmail.com>
References: <20210729224915.38986-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add XRC opcodes to rxe_opcode_info.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_opcode.c | 328 +++++++++++++++++++++++++
 1 file changed, 328 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index da719abc1846..af8e05bc63b2 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -949,4 +949,332 @@ struct rxe_opcode_info rxe_opcode[RXE_NUM_OPCODE] = {
 		}
 	},
 
+	/* XRC */
+	[IB_OPCODE_XRC_SEND_FIRST]			= {
+		.name	= "IB_OPCODE_XRC_SEND_FIRST",
+		.mask	= RXE_XRCETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK
+				| RXE_RWR_MASK | RXE_SEND_MASK | RXE_START_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_SEND_MIDDLE]		= {
+		.name	= "IB_OPCODE_XRC_SEND_MIDDLE]",
+		.mask	= RXE_XRCETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK
+				| RXE_SEND_MASK | RXE_MIDDLE_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_SEND_LAST]			= {
+		.name	= "IB_OPCODE_XRC_SEND_LAST",
+		.mask	= RXE_XRCETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK
+				| RXE_COMP_MASK | RXE_SEND_MASK | RXE_END_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_SEND_LAST_WITH_IMMEDIATE]		= {
+		.name	= "IB_OPCODE_XRC_SEND_LAST_WITH_IMMEDIATE",
+		.mask	= RXE_XRCETH_MASK | RXE_IMMDT_MASK | RXE_PAYLOAD_MASK
+				| RXE_REQ_MASK | RXE_COMP_MASK | RXE_SEND_MASK
+				| RXE_END_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_IMMDT_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_IMMDT]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES
+						+ RXE_IMMDT_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_SEND_ONLY]			= {
+		.name	= "IB_OPCODE_XRC_SEND_ONLY",
+		.mask	= RXE_XRCETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK
+				| RXE_COMP_MASK | RXE_RWR_MASK | RXE_SEND_MASK
+				| RXE_START_MASK | RXE_END_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_SEND_ONLY_WITH_IMMEDIATE]		= {
+		.name	= "IB_OPCODE_XRC_SEND_ONLY_WITH_IMMEDIATE",
+		.mask	= RXE_XRCETH_MASK | RXE_IMMDT_MASK | RXE_PAYLOAD_MASK
+				| RXE_REQ_MASK | RXE_COMP_MASK | RXE_RWR_MASK
+				| RXE_SEND_MASK | RXE_START_MASK | RXE_END_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_IMMDT_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_IMMDT]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES
+						+ RXE_IMMDT_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_RDMA_WRITE_FIRST]		= {
+		.name	= "IB_OPCODE_XRC_RDMA_WRITE_FIRST",
+		.mask	= RXE_XRCETH_MASK | RXE_RETH_MASK | RXE_PAYLOAD_MASK
+				| RXE_REQ_MASK | RXE_WRITE_MASK
+				| RXE_START_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_RETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_RETH]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES
+						+ RXE_RETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_RDMA_WRITE_MIDDLE]		= {
+		.name	= "IB_OPCODE_XRC_RDMA_WRITE_MIDDLE",
+		.mask	= RXE_XRCETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK
+				| RXE_WRITE_MASK | RXE_MIDDLE_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_RDMA_WRITE_LAST]			= {
+		.name	= "IB_OPCODE_XRC_RDMA_WRITE_LAST",
+		.mask	= RXE_XRCETH_MASK | RXE_PAYLOAD_MASK | RXE_REQ_MASK
+				| RXE_WRITE_MASK | RXE_END_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_RDMA_WRITE_LAST_WITH_IMMEDIATE]		= {
+		.name	= "IB_OPCODE_XRC_RDMA_WRITE_LAST_WITH_IMMEDIATE",
+		.mask	= RXE_XRCETH_MASK | RXE_IMMDT_MASK | RXE_PAYLOAD_MASK
+				| RXE_REQ_MASK | RXE_WRITE_MASK | RXE_COMP_MASK
+				| RXE_RWR_MASK | RXE_END_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_IMMDT_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_IMMDT]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES
+						+ RXE_IMMDT_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_RDMA_WRITE_ONLY]			= {
+		.name	= "IB_OPCODE_XRC_RDMA_WRITE_ONLY",
+		.mask	= RXE_XRCETH_MASK | RXE_RETH_MASK | RXE_PAYLOAD_MASK
+				| RXE_REQ_MASK | RXE_WRITE_MASK | RXE_START_MASK
+				| RXE_END_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_RETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_RETH]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES
+						+ RXE_RETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_RDMA_WRITE_ONLY_WITH_IMMEDIATE]		= {
+		.name	= "IB_OPCODE_XRC_RDMA_WRITE_ONLY_WITH_IMMEDIATE",
+		.mask	= RXE_XRCETH_MASK | RXE_RETH_MASK | RXE_IMMDT_MASK
+				| RXE_PAYLOAD_MASK | RXE_REQ_MASK
+				| RXE_WRITE_MASK | RXE_COMP_MASK | RXE_RWR_MASK
+				| RXE_START_MASK | RXE_END_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_RETH_BYTES
+						+ RXE_IMMDT_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_RETH]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES,
+			[RXE_IMMDT]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES
+						+ RXE_RETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES
+						+ RXE_RETH_BYTES
+						+ RXE_IMMDT_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_RDMA_READ_REQUEST]			= {
+		.name	= "IB_OPCODE_XRC_RDMA_READ_REQUEST",
+		.mask	= RXE_XRCETH_MASK | RXE_RETH_MASK | RXE_REQ_MASK
+				| RXE_READ_MASK | RXE_START_MASK | RXE_END_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_RETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_RETH]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES
+						+ RXE_RETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_RDMA_READ_RESPONSE_FIRST]		= {
+		.name	= "IB_OPCODE_XRC_RDMA_READ_RESPONSE_FIRST",
+		.mask	= RXE_AETH_MASK | RXE_PAYLOAD_MASK | RXE_ACK_MASK
+				| RXE_START_MASK,
+		.length = RXE_BTH_BYTES + RXE_AETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_AETH]	= RXE_BTH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+						+ RXE_AETH_BYTES,
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
+		.mask	= RXE_AETH_MASK | RXE_PAYLOAD_MASK | RXE_ACK_MASK
+				| RXE_END_MASK,
+		.length = RXE_BTH_BYTES + RXE_AETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_AETH]	= RXE_BTH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+						+ RXE_AETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_RDMA_READ_RESPONSE_ONLY]		= {
+		.name	= "IB_OPCODE_XRC_RDMA_READ_RESPONSE_ONLY",
+		.mask	= RXE_AETH_MASK | RXE_PAYLOAD_MASK | RXE_ACK_MASK
+				| RXE_START_MASK | RXE_END_MASK,
+		.length = RXE_BTH_BYTES + RXE_AETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_AETH]	= RXE_BTH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+						+ RXE_AETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_ACKNOWLEDGE]			= {
+		.name	= "IB_OPCODE_XRC_ACKNOWLEDGE",
+		.mask	= RXE_AETH_MASK | RXE_ACK_MASK | RXE_START_MASK
+				| RXE_END_MASK,
+		.length = RXE_BTH_BYTES + RXE_AETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_AETH]	= RXE_BTH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+						+ RXE_AETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_ATOMIC_ACKNOWLEDGE]			= {
+		.name	= "IB_OPCODE_XRC_ATOMIC_ACKNOWLEDGE",
+		.mask	= RXE_AETH_MASK | RXE_ATMACK_MASK | RXE_ACK_MASK
+				| RXE_START_MASK | RXE_END_MASK,
+		.length = RXE_BTH_BYTES + RXE_ATMACK_BYTES + RXE_AETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_AETH]	= RXE_BTH_BYTES,
+			[RXE_ATMACK]	= RXE_BTH_BYTES
+						+ RXE_AETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+					+ RXE_ATMACK_BYTES + RXE_AETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_COMPARE_SWAP]			= {
+		.name	= "IB_OPCODE_XRC_COMPARE_SWAP",
+		.mask	= RXE_XRCETH_MASK | RXE_ATMETH_MASK | RXE_REQ_MASK
+				| RXE_ATOMIC_MASK | RXE_START_MASK
+				| RXE_END_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_ATMETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_ATMETH]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES
+						+ RXE_XRCETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES
+						+ RXE_ATMETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_FETCH_ADD]			= {
+		.name	= "IB_OPCODE_XRC_FETCH_ADD",
+		.mask	= RXE_XRCETH_MASK | RXE_ATMETH_MASK | RXE_REQ_MASK
+				| RXE_ATOMIC_MASK | RXE_START_MASK
+				| RXE_END_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_ATMETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_ATMETH]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES
+						+ RXE_XRCETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES
+						+ RXE_ATMETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_SEND_LAST_WITH_INVALIDATE]		= {
+		.name	= "IB_OPCODE_XRC_SEND_LAST_WITH_INVALIDATE",
+		.mask	= RXE_XRCETH_MASK | RXE_IETH_MASK | RXE_PAYLOAD_MASK
+				| RXE_REQ_MASK | RXE_COMP_MASK | RXE_SEND_MASK
+				| RXE_END_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_IETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_IETH]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES
+						+ RXE_IETH_BYTES,
+		}
+	},
+	[IB_OPCODE_XRC_SEND_ONLY_WITH_INVALIDATE]		= {
+		.name	= "IB_OPCODE_XRC_SEND_ONLY_INV",
+		.mask	= RXE_XRCETH_MASK | RXE_IETH_MASK | RXE_PAYLOAD_MASK
+				| RXE_REQ_MASK | RXE_COMP_MASK | RXE_RWR_MASK
+				| RXE_SEND_MASK | RXE_END_MASK | RXE_START_MASK,
+		.length = RXE_BTH_BYTES + RXE_XRCETH_BYTES + RXE_IETH_BYTES,
+		.offset = {
+			[RXE_BTH]	= 0,
+			[RXE_XRCETH]	= RXE_BTH_BYTES,
+			[RXE_IETH]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES,
+			[RXE_PAYLOAD]	= RXE_BTH_BYTES
+						+ RXE_XRCETH_BYTES
+						+ RXE_IETH_BYTES,
+		}
+	},
 };
-- 
2.30.2

