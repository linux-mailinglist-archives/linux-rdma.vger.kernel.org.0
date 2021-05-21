Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE5238CECF
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 22:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhEUUUl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 16:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhEUUUk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 May 2021 16:20:40 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D48C0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 21 May 2021 13:19:16 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id s19so20781156oic.7
        for <linux-rdma@vger.kernel.org>; Fri, 21 May 2021 13:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U5rPLEnmJZPFrJiSUM0o7pDJxLnxJTWiGzt2ZHYvHDE=;
        b=XrixyVO/rO3KjqwlhwiYq3z+ADX8uSseZj17rq5tCtdzg+lLWBj3UlgBC/zbAmp4o1
         asaDs9v4ifrbeU0DWdn0an0TjnGCeH8V7+FPimECZPXhYNkE8FTgHIaBY4hH6H6bBoks
         ikZyVgDUcL3XLP8jdycJOyV2ItedfZbFpQEfnMV8Ku/5uvyNO0xxOj8m18h3bn91cGPV
         a82qj+qWRpk+K1nbajXt/slwWuA+ojx6J9K1xB2sWnb9iT8R8uHzLvdxQ04f8uH3k8qe
         jV1TOxVCt9/VMo9mK0oCg8C8cf1lmIbuay2zCF5Ki4koh/qlW4Q7qsVgSPQl5m/W/8kA
         6epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U5rPLEnmJZPFrJiSUM0o7pDJxLnxJTWiGzt2ZHYvHDE=;
        b=HJEYHhsgou0A2APLrgrZn931N+MsFfgVanAdcoG99nWixDVWSxKzkdQT4VZPxqa97O
         xJVrgU8iCJfL75t0CMsODfZm95yNOUtxyETJulk1/yoYpA1aKo4EsqomF5kR5k+bVGn9
         ZNufQJ2kN6xPGP5/sBduDYKSzgidkeZzWBvomkaDM+RdGguPB284OPoI4QdLpvFmqeD+
         6CxADeDh6qpNMjDHfjvvzOCksLJH6kWXphoacLKLhUBoCvo+bXCIFoOiTmcWUb1eXXlb
         XaWjDMnsQx6UGlOErrbULWIRSSiMA2lERAFsX9oBKJmu5QWigHlVfznY3JAW9U3yUFqd
         SoUA==
X-Gm-Message-State: AOAM531mddq52Qr9UkMjnurHcST9L2h/AS8p0rrAR308MQbikcThkNyG
        ghi/C2I93doi/CahEeVM568=
X-Google-Smtp-Source: ABdhPJxIU8kIZnreyLHRMTzlj2hsAdoDNdmPxVjUXhMUjQ/74OLEoIuHQdDGZ6+1aiT60+otVoWD9Q==
X-Received: by 2002:aca:f354:: with SMTP id r81mr3547444oih.4.1621628356390;
        Fri, 21 May 2021 13:19:16 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-7300-72eb-72bd-e6db.res6.spectrum.com. [2603:8081:140c:1a00:7300:72eb:72bd:e6db])
        by smtp.gmail.com with ESMTPSA id r124sm1337245oig.38.2021.05.21.13.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:19:16 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v7 05/10] RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
Date:   Fri, 21 May 2021 15:18:20 -0500
Message-Id: <20210521201824.659565-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210521201824.659565-1-rpearsonhpe@gmail.com>
References: <20210521201824.659565-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Rxe has two mask bits WR_LOCAL_MASK and WR_REG_MASK with WR_REG_MASK
used to indicate any local operation and WR_LOCAL_MASK unused. This
patch replaces both of these with one mask bit WR_LOCAL_OP_MASK which
is clearer.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_opcode.c | 4 ++--
 drivers/infiniband/sw/rxe/rxe_opcode.h | 3 +--
 drivers/infiniband/sw/rxe/rxe_req.c    | 2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c  | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index 0cb4b01fd910..1e4b67b048f3 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -87,13 +87,13 @@ struct rxe_wr_opcode_info rxe_wr_opcode_info[] = {
 	[IB_WR_LOCAL_INV]				= {
 		.name	= "IB_WR_LOCAL_INV",
 		.mask	= {
-			[IB_QPT_RC]	= WR_REG_MASK,
+			[IB_QPT_RC]	= WR_LOCAL_OP_MASK,
 		},
 	},
 	[IB_WR_REG_MR]					= {
 		.name	= "IB_WR_REG_MR",
 		.mask	= {
-			[IB_QPT_RC]	= WR_REG_MASK,
+			[IB_QPT_RC]	= WR_LOCAL_OP_MASK,
 		},
 	},
 };
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
index 1041ac9a9233..e02f039b8c44 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -19,8 +19,7 @@ enum rxe_wr_mask {
 	WR_SEND_MASK			= BIT(2),
 	WR_READ_MASK			= BIT(3),
 	WR_WRITE_MASK			= BIT(4),
-	WR_LOCAL_MASK			= BIT(5),
-	WR_REG_MASK			= BIT(6),
+	WR_LOCAL_OP_MASK		= BIT(5),
 
 	WR_READ_OR_WRITE_MASK		= WR_READ_MASK | WR_WRITE_MASK,
 	WR_READ_WRITE_OR_SEND_MASK	= WR_READ_OR_WRITE_MASK | WR_SEND_MASK,
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 3664cdae7e1f..0d4dcd514c55 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -593,7 +593,7 @@ int rxe_requester(void *arg)
 	if (unlikely(!wqe))
 		goto exit;
 
-	if (wqe->mask & WR_REG_MASK) {
+	if (wqe->mask & WR_LOCAL_OP_MASK) {
 		if (wqe->wr.opcode == IB_WR_LOCAL_INV) {
 			struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 			struct rxe_mr *rmr;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 552a1ea9c8b7..4860e8ab378e 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -577,7 +577,7 @@ static void init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	init_send_wr(qp, &wqe->wr, ibwr);
 
 	/* local operation */
-	if (unlikely(mask & WR_REG_MASK)) {
+	if (unlikely(mask & WR_LOCAL_OP_MASK)) {
 		wqe->mask = mask;
 		wqe->state = wqe_state_posted;
 		return;
-- 
2.30.2

