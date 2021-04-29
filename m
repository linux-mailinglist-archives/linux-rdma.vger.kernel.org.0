Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C14F36EFAB
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Apr 2021 20:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhD2SuB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Apr 2021 14:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241054AbhD2SuB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Apr 2021 14:50:01 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF545C06138C
        for <linux-rdma@vger.kernel.org>; Thu, 29 Apr 2021 11:49:14 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id u80so33887632oia.0
        for <linux-rdma@vger.kernel.org>; Thu, 29 Apr 2021 11:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K3HvFw+RtgfAZ5giUI6FTWhZ270iUlqbGN0Kkgaz328=;
        b=O8H+nlwMbD7C5knyXSOJ9vPZ3fm4Ga84kH7bgH8AbkMCVIpEv+PIKyaTUWSWG72Sff
         2zKhsb9kpRyiJOyn9Eh5/ZKLNN3jt1eQu6XCFHTbLdGhaE6rFaiJlV9ri7rJ2dEJ6hI8
         nfI4Ykguwmlt6N6uZ7HfCBaHnVfNIThi+xgswhhQiShPqpSGbyXROO22pVcgkvBHR9/6
         RutKmreq1FlWAH6d4NQPEz1NCeX/xmyEFelIHdBu6arv1YAEhhdd4BWyCsiprM+WU6Ka
         aOOzbwcUs2Zt9j+9vJ/lpiKgGi+GbQL4OUM8JaB6Y+eUBeJB+tZ7ehczLm4yjLlGC1KF
         VZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K3HvFw+RtgfAZ5giUI6FTWhZ270iUlqbGN0Kkgaz328=;
        b=W5EQR8/NvTl9LCDk2tM1mk5SKSaZgxsnQ3Dsz8me3fBE7mcMgxkV6AehaexPdzf3tX
         D8IL5PD0MazlUp1c2d25j7Zk9ZrmxyZ6mUCGN6dTbe1ojfjIbrW3ie7A94wYlxry7hAw
         14tSV3Lw1h++cz/d8Q7jOIpddq+uQNML+18gghkhuQj+t5IYC5LNZ3WeAbhyUKMCRHez
         S76P6rX3UzvQyhPMibRyuNqNDLBvlV82/T67f7sXQaqmzLbY9aRYVyEzWoaQ2JZen2vn
         BGEvGgimobVHVnVeT7n/3D1QOwqvBVqsHjlz27c7mGRy1gco0syLFgNo5c0iW3CC6gQK
         H5cQ==
X-Gm-Message-State: AOAM5327wqorbvQISuT7LmABkf/XxAE9o7xB2pz7rcLXnRCDZccQKaE7
        L7jdNAoLKIgLRkR3VT/z5sE=
X-Google-Smtp-Source: ABdhPJx8HCt9y8vATF5K3xH3L1s7sv610Gg6bCWPrSMTLePjCqwPuzomQXbh4OUB1KL2Q8guInvbjA==
X-Received: by 2002:a05:6808:1cc:: with SMTP id x12mr8140919oic.114.1619722154227;
        Thu, 29 Apr 2021 11:49:14 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-a63d-9643-fc29-df2a.res6.spectrum.com. [2603:8081:140c:1a00:a63d:9643:fc29:df2a])
        by smtp.gmail.com with ESMTPSA id w26sm143182otm.27.2021.04.29.11.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 11:49:13 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v6 05/10] RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
Date:   Thu, 29 Apr 2021 13:48:50 -0500
Message-Id: <20210429184855.54939-6-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210429184855.54939-1-rpearson@hpe.com>
References: <20210429184855.54939-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Rxe has two mask bits WR_LOCAL_MASK and WR_REG_MASK with
WR_REG_MASK used to indicate any local operation and WR_LOCAL_MASK
unused. This patch replaces both of these with one mask bit
WR_LOCAL_OP_MASK which is clearer.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
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
index fff81bf78a86..d22f011a20f3 100644
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
2.27.0

