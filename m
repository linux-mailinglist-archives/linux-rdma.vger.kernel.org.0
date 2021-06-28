Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8593B6AC0
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 00:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbhF1WE4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Jun 2021 18:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238204AbhF1WEB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Jun 2021 18:04:01 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B93C0617AF
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 15:01:34 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w127so23778040oig.12
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 15:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f0Y/ocDdRQ4XTDM8mFWl3U3xVeDb3pxbEATe5M1rfu8=;
        b=K5kqQylNOIeWx+uBOymFKtv0aqGgao/LM8PjFMSqwZvi9jqCawYO1O0Frl6fF4n08K
         xurKKauRWRA5t1Shg6GamR60t5TQF980yxg/nJT/rPFmjR/TbfOs3iQT7iCswJFC1wdd
         l2d3GH6GeLhqdOITi1uAXaacWNh8Bf6SW1+8ewRKCPaeFJLO0rdLCSzNqd56inm7oIBU
         FwiP3Ata8qSI7oYPxf6jrDEt9A74X0qHxOaCoDzwtjyMB5sN9bTycwPWYqFiVvRY3Fvo
         Eacb1G4TLejvq/Qy9wm1MObE+2M0MoMTjCwQP70WOmp3I+XQE/YhuEmLCE8kgiY9tjos
         BCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f0Y/ocDdRQ4XTDM8mFWl3U3xVeDb3pxbEATe5M1rfu8=;
        b=NehYSpls5ybKWUa9YX+2/tCn7tN7B0Fq2JuejrdLaCivoyLeh9MA1+UYdA6jp8LFcu
         R1EpJ9y4JmGfD+dzcVEsINlEQ0cfahliU7ZfW4M50nMPSoKdeMqdXBahLWu+HZFCYAjv
         jzFFB8qKu7ek5mfozIBb8VtQLLnsN421WKH23aXCLtS0C6n1bBehqXHPTKYL1Sf2lRZc
         ZnHgS2EDGqNN5Gy9YeE28fPwLB5uQo3qLyfjKdyQ3b1Ih1tRvtrb3JBJ/Bd1FJ9VXjFN
         DFLAdv4d57IKwx40QcxuNN0qlGkgLuiNqSrrb1qVuYp6gKqOUhGqNx7EuknN5ymKpVG7
         KlJA==
X-Gm-Message-State: AOAM532k3p3m8U8NIxF9bhW9P96H4WtSns1bZRf8qZtxrk6Q9CNAZaVX
        k/Y4mg5W/kmPQ0Q2DGDffng=
X-Google-Smtp-Source: ABdhPJxgNaDGDvZOhDP4AjMFRPm1r7SGueaJ+ElE9dBH3MWk+bENsDth0CLIbteLNxwJcE/CorKXQg==
X-Received: by 2002:aca:b609:: with SMTP id g9mr22211216oif.141.1624917693909;
        Mon, 28 Jun 2021 15:01:33 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-aaa9-75eb-6e0f-9f85.res6.spectrum.com. [2603:8081:140c:1a00:aaa9:75eb:6e0f:9f85])
        by smtp.gmail.com with ESMTPSA id t12sm1137942otp.34.2021.06.28.15.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 15:01:33 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 2/5] RDMA/rxe: Change AH objects to indexed
Date:   Mon, 28 Jun 2021 17:00:41 -0500
Message-Id: <20210628220043.9851-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210628220043.9851-1-rpearsonhpe@gmail.com>
References: <20210628220043.9851-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make changes to rxe_param.h and rxe_pool.c to allow indexing of AH
objects. Valid indices are non-zero so older providers can be detected.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 4 +++-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 742e6ec93686..ec5c6331bee8 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -67,7 +67,9 @@ enum rxe_device_param {
 	RXE_MAX_MCAST_GRP		= 8192,
 	RXE_MAX_MCAST_QP_ATTACH		= 56,
 	RXE_MAX_TOT_MCAST_QP_ATTACH	= 0x70000,
-	RXE_MAX_AH			= 100,
+	RXE_MAX_AH			= 16383,
+	RXE_MIN_AH_INDEX		= 1,
+	RXE_MAX_AH_INDEX		= 16383,
 	RXE_MAX_SRQ_WR			= 0x4000,
 	RXE_MIN_SRQ_WR			= 1,
 	RXE_MAX_SRQ_SGE			= 27,
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index 0b8e7c6255a2..342f090152d1 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -26,7 +26,9 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 		.name		= "rxe-ah",
 		.size		= sizeof(struct rxe_ah),
 		.elem_offset	= offsetof(struct rxe_ah, pelem),
-		.flags		= RXE_POOL_NO_ALLOC,
+		.flags		= RXE_POOL_INDEX | RXE_POOL_NO_ALLOC,
+		.min_index	= RXE_MIN_AH_INDEX,
+		.max_index	= RXE_MAX_AH_INDEX,
 	},
 	[RXE_TYPE_SRQ] = {
 		.name		= "rxe-srq",
-- 
2.30.2

