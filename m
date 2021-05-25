Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213D8390BA2
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 23:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhEYVkF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 17:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhEYVkF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 17:40:05 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA885C061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 14:38:33 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so30033134otc.6
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 14:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U5rPLEnmJZPFrJiSUM0o7pDJxLnxJTWiGzt2ZHYvHDE=;
        b=IN3pYctKWMYc3MESbiQzk6vTSVeRJMjM43IsLMrogaqBCjpUAHgP7K/WvLaPO/2XZN
         XV7EMRUGIvnvjzuDoZEmnjO5podzyF7Lgpmx81aqxkV4Kl1DCmBma9KkUZKP7+at1HBM
         PNoVAUhu7OA1PvcPR9WiOpCftPQ8u/Q9uoG6PRso4mX6lHYUeSsCgTF6x+i/XjvCB2oO
         Ig19THpfdFLM4NukX1cx6BhCeWf3W9tecz7ErIY60hNV/8Sie3511hDkk2WLDsmizvJm
         FEDCzWSYSnhhcGn3m2zcncB4PRnv2c8mfKp2oQuTFeZ2xrg3I3va9pjm1hhFY1NhU5gI
         RnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U5rPLEnmJZPFrJiSUM0o7pDJxLnxJTWiGzt2ZHYvHDE=;
        b=tSpAbDV2NdXL4F4py+slVKnTi7ce+ogD3l03sKY/dcEGiBGZeEIgvaPlP+06BavsGj
         fx/QBeo/+fWHbrJB5jMSkZStxIvve13NylPedYjypDaxz+gZvFwwSojfsxcvReKItZBL
         blMktJQyapD5f3b7QoRYYbdrQANMyDY+l1MEYTibLho40gtv9k8UMF/FLXzkcMpsh3RM
         y/VJGFmwDoy/B9XsVFXB372sJmJcYoPJs37bym6JCoIqWVtBF20weKjLoo5RSg/oqpfP
         VPIytzYikJVE2CYC/4QkcI552QVNS/DpKNiu6uuMBNR1ddVfZOXKamuuLQnGZQzh7CKq
         hCQw==
X-Gm-Message-State: AOAM530tGSSm6vMbgvzH3l644faMNkK3uLh/Y1re79NI2nxssz0M7KSQ
        GfAKpAZ0NpcNTUu2m4Nx2eI=
X-Google-Smtp-Source: ABdhPJyrIXMMi3qXHOjn3megAmnNQ1jPoM9JZnL1+06r+m1VmWT6F26yaciPPlrjbdDLN1aJlR4eGw==
X-Received: by 2002:a05:6830:108c:: with SMTP id y12mr23892526oto.319.1621978713264;
        Tue, 25 May 2021 14:38:33 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e4a4-ac6f-8cca-71ad.res6.spectrum.com. [2603:8081:140c:1a00:e4a4:ac6f:8cca:71ad])
        by smtp.gmail.com with ESMTPSA id y7sm4064489oto.60.2021.05.25.14.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 14:38:32 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v8 05/10] RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
Date:   Tue, 25 May 2021 16:37:47 -0500
Message-Id: <20210525213751.629017-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210525213751.629017-1-rpearsonhpe@gmail.com>
References: <20210525213751.629017-1-rpearsonhpe@gmail.com>
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

