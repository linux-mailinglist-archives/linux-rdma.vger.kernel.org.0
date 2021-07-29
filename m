Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C413DAF80
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 00:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhG2Wun (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 18:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbhG2Wum (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 18:50:42 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A90C0613CF
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:39 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id e3-20020a4ab9830000b029026ada3b6b90so1990096oop.0
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NNn2l29M4t+nQR7CV1Zgcm1yYDdlmkl9/gMb0fNyS5M=;
        b=vXWkENX2u7SWjdAeh+jEoJLTBEk8X4VhGXH+5+Fa6PnEzBLVyLagfyD6dy6J/fQtQr
         qi/NEI2rK9eLSVJTCtClEeYY9fOy5fzjy/qTKFeqJ5kDBciKGEesUqpeDOH4kavTvFzV
         kMkpysLcJaKy9NrVx88pqJx3TZmbKuCydB9bG1zWURidfWQWvWO6GPqw5vB9qyWYUcFn
         NwCLKlmS2zU0BWc+MXMf8xyi2NGTkjbQ4d5Ln3T5e2Fa5forsa8dwx3a3bRVfjR5QrWw
         5KusRHmozMrDNRTWdWx7sEMHTFbj+ybtT91oRDU6o3eqc0f6NlMFDcsOquyNI7wh9Olf
         iIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NNn2l29M4t+nQR7CV1Zgcm1yYDdlmkl9/gMb0fNyS5M=;
        b=s5LukmOAeEN37Zt6Es4tH+nh9S39cRwKtgkwg/3C4VsDsk6slRuGtqbDaaMZntJGVH
         vpQmMXvMH6c0n1itm1U7X25wBrQm+kVH9JBar1xg1jTHfIXh9nN1KykwPJXcK3SpoGDr
         NqDAMCUxJnGCIbyReRf9PrhuMhHz+a4Ami/eIOWp1c730MAIClo2kJa9ltre/4qJ8WZl
         pE/coTE7SME4mCK72NumOhI4z3Kl1qjCAy7g4gERnifKw6tp+faUvfzxQoOdQEtOX2gm
         FScTevomjHSJC0mYORpujUi8GsnQ36enb+A23+xkSEx0ny/YXGPaXggACC0c5wccjsBR
         kJ8Q==
X-Gm-Message-State: AOAM531UWOwLhk9YZDT3oC4wVO4eG/bvwI3klGHQoAN1ghHjbZLaFzAs
        XePZlyoPhXSSDJxJcDRZ/CPUz/WJwzU=
X-Google-Smtp-Source: ABdhPJx39+YwgOOYMCG4Dt3N0bOje05kPvT01yJ6heiMhXEYb61ActR6eqOUo3BAPQhudFtVtwDKAg==
X-Received: by 2002:a4a:b6ca:: with SMTP id w10mr4396535ooo.17.1627599038417;
        Thu, 29 Jul 2021 15:50:38 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id c8sm779164oto.17.2021.07.29.15.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:50:38 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 06/13] RDMA/rxe: Add XRC QP type to rxe_wr_opcode_info
Date:   Thu, 29 Jul 2021 17:49:09 -0500
Message-Id: <20210729224915.38986-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729224915.38986-1-rpearsonhpe@gmail.com>
References: <20210729224915.38986-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add IB_QPT_XRC_INI QP type to rxe_rw_opcode_info.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_opcode.c | 61 +++++++++++++++-----------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index 3ef5a10a6efd..da719abc1846 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -15,53 +15,60 @@ struct rxe_wr_opcode_info rxe_wr_opcode_info[] = {
 	[IB_WR_RDMA_WRITE]				= {
 		.name	= "IB_WR_RDMA_WRITE",
 		.mask	= {
-			[IB_QPT_RC]	= WR_INLINE_MASK | WR_WRITE_MASK,
-			[IB_QPT_UC]	= WR_INLINE_MASK | WR_WRITE_MASK,
+			[IB_QPT_RC]	 = WR_INLINE_MASK | WR_WRITE_MASK,
+			[IB_QPT_UC]	 = WR_INLINE_MASK | WR_WRITE_MASK,
+			[IB_QPT_XRC_INI] = WR_INLINE_MASK | WR_WRITE_MASK,
 		},
 	},
 	[IB_WR_RDMA_WRITE_WITH_IMM]			= {
 		.name	= "IB_WR_RDMA_WRITE_WITH_IMM",
 		.mask	= {
-			[IB_QPT_RC]	= WR_INLINE_MASK | WR_WRITE_MASK,
-			[IB_QPT_UC]	= WR_INLINE_MASK | WR_WRITE_MASK,
+			[IB_QPT_RC]	 = WR_INLINE_MASK | WR_WRITE_MASK,
+			[IB_QPT_UC]	 = WR_INLINE_MASK | WR_WRITE_MASK,
+			[IB_QPT_XRC_INI] = WR_INLINE_MASK | WR_WRITE_MASK,
 		},
 	},
 	[IB_WR_SEND]					= {
 		.name	= "IB_WR_SEND",
 		.mask	= {
-			[IB_QPT_SMI]	= WR_INLINE_MASK | WR_SEND_MASK,
-			[IB_QPT_GSI]	= WR_INLINE_MASK | WR_SEND_MASK,
-			[IB_QPT_RC]	= WR_INLINE_MASK | WR_SEND_MASK,
-			[IB_QPT_UC]	= WR_INLINE_MASK | WR_SEND_MASK,
-			[IB_QPT_UD]	= WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_SMI]	 = WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_GSI]	 = WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_RC]	 = WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_UC]	 = WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_UD]	 = WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_XRC_INI] = WR_INLINE_MASK | WR_WRITE_MASK,
 		},
 	},
 	[IB_WR_SEND_WITH_IMM]				= {
 		.name	= "IB_WR_SEND_WITH_IMM",
 		.mask	= {
-			[IB_QPT_SMI]	= WR_INLINE_MASK | WR_SEND_MASK,
-			[IB_QPT_GSI]	= WR_INLINE_MASK | WR_SEND_MASK,
-			[IB_QPT_RC]	= WR_INLINE_MASK | WR_SEND_MASK,
-			[IB_QPT_UC]	= WR_INLINE_MASK | WR_SEND_MASK,
-			[IB_QPT_UD]	= WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_SMI]	 = WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_GSI]	 = WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_RC]	 = WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_UC]	 = WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_UD]	 = WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_XRC_INI] = WR_INLINE_MASK | WR_WRITE_MASK,
 		},
 	},
 	[IB_WR_RDMA_READ]				= {
 		.name	= "IB_WR_RDMA_READ",
 		.mask	= {
-			[IB_QPT_RC]	= WR_READ_MASK,
+			[IB_QPT_RC]	 = WR_READ_MASK,
+			[IB_QPT_XRC_INI] = WR_READ_MASK,
 		},
 	},
 	[IB_WR_ATOMIC_CMP_AND_SWP]			= {
 		.name	= "IB_WR_ATOMIC_CMP_AND_SWP",
 		.mask	= {
-			[IB_QPT_RC]	= WR_ATOMIC_MASK,
+			[IB_QPT_RC]	 = WR_ATOMIC_MASK,
+			[IB_QPT_XRC_INI] = WR_ATOMIC_MASK,
 		},
 	},
 	[IB_WR_ATOMIC_FETCH_AND_ADD]			= {
 		.name	= "IB_WR_ATOMIC_FETCH_AND_ADD",
 		.mask	= {
-			[IB_QPT_RC]	= WR_ATOMIC_MASK,
+			[IB_QPT_RC]	 = WR_ATOMIC_MASK,
+			[IB_QPT_XRC_INI] = WR_ATOMIC_MASK,
 		},
 	},
 	[IB_WR_LSO]					= {
@@ -73,34 +80,38 @@ struct rxe_wr_opcode_info rxe_wr_opcode_info[] = {
 	[IB_WR_SEND_WITH_INV]				= {
 		.name	= "IB_WR_SEND_WITH_INV",
 		.mask	= {
-			[IB_QPT_RC]	= WR_INLINE_MASK | WR_SEND_MASK,
-			[IB_QPT_UC]	= WR_INLINE_MASK | WR_SEND_MASK,
-			[IB_QPT_UD]	= WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_RC]	 = WR_INLINE_MASK | WR_SEND_MASK,
+			[IB_QPT_XRC_INI] = WR_INLINE_MASK | WR_WRITE_MASK,
 		},
 	},
 	[IB_WR_RDMA_READ_WITH_INV]			= {
 		.name	= "IB_WR_RDMA_READ_WITH_INV",
 		.mask	= {
-			[IB_QPT_RC]	= WR_READ_MASK,
+			[IB_QPT_RC]	 = WR_READ_MASK,
+			/* TODO get rid of this no such thing for RoCE */
 		},
 	},
 	[IB_WR_LOCAL_INV]				= {
 		.name	= "IB_WR_LOCAL_INV",
 		.mask	= {
-			[IB_QPT_RC]	= WR_LOCAL_OP_MASK,
+			[IB_QPT_RC]	 = WR_LOCAL_OP_MASK,
+			[IB_QPT_UC]	 = WR_LOCAL_OP_MASK,
+			[IB_QPT_XRC_INI] = WR_LOCAL_OP_MASK,
 		},
 	},
 	[IB_WR_REG_MR]					= {
 		.name	= "IB_WR_REG_MR",
 		.mask	= {
-			[IB_QPT_RC]	= WR_LOCAL_OP_MASK,
+			[IB_QPT_RC]	 = WR_LOCAL_OP_MASK,
+			[IB_QPT_UC]	 = WR_LOCAL_OP_MASK,
+			[IB_QPT_XRC_INI] = WR_LOCAL_OP_MASK,
 		},
 	},
 	[IB_WR_BIND_MW]					= {
 		.name	= "IB_WR_BIND_MW",
 		.mask	= {
-			[IB_QPT_RC]	= WR_LOCAL_OP_MASK,
-			[IB_QPT_UC]	= WR_LOCAL_OP_MASK,
+			[IB_QPT_RC]	 = WR_LOCAL_OP_MASK,
+			[IB_QPT_UC]	 = WR_LOCAL_OP_MASK,
 		},
 	},
 };
-- 
2.30.2

