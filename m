Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416DE358F5C
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 23:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhDHVlT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 17:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDHVlS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 17:41:18 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C9AC061760
        for <linux-rdma@vger.kernel.org>; Thu,  8 Apr 2021 14:41:07 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id d12so3679868oiw.12
        for <linux-rdma@vger.kernel.org>; Thu, 08 Apr 2021 14:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K3HvFw+RtgfAZ5giUI6FTWhZ270iUlqbGN0Kkgaz328=;
        b=hXcpU+D7cL1uTTR157s96m0lF2Brsl9Ls0/7vPQQSzv6ezsyFma38NqGOlWsofuTMi
         N/N33UK1nMfy0GlRE8cymSGI/zCR4sQlXcRUsHAchZdb/ucwxJv9yEa7CiLQyJyBFcBz
         guA5DrB5TtFmFeTmlDVg6ITG8J9eCqUERnuoJtvXukI3j0xkZc/dz4P9hj+UW+6Iikf2
         bSYBFcXkxbcLmZLPL0Wg6JP8WaRXHBNBnDVboP+TBpM6rVDo3Y43gre33ptNFe53ZDf0
         VB9esUuodRSZCu2zmAUR/CD905cv4z8gSj38zEmlQBwgUy425OL0vuUoHBAPTdz8kgYD
         3L9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K3HvFw+RtgfAZ5giUI6FTWhZ270iUlqbGN0Kkgaz328=;
        b=aB0DKN+k+0HV7DuMzw3t8T37CCKr/Lne6CfWBXVlkeX85FaK6LFd/ATOHhgr0Gtls6
         M5ZlH5aWA+Mc5izjlH9WRlCiAZQeQ0PLOLwAVz8NLLJoN8TvQt5pwiGEttFHHE0CNhpk
         8UxDOh3S85GllMX/AOS/c1gU+zCxY/7k1azEJoVKygLVikA7NE+OulOAqenS06S9K9y7
         AoMTN6QhI6ao1vl8VAVD85cgsP7eVQN1kWA2285B27SGwb6WDyoF/eE8Z0/SWSNLkj31
         b0Kru+0WvR5Na9WstWYuvKqElUvFEGFaNS627MzDRRdNSA3E71w98ZJG7v8i68kbpixO
         Ktiw==
X-Gm-Message-State: AOAM530THSs05HR3IzaC3uELuydYDLF8tG8+ndMVAsKS4j+IkLoWf5RR
        APvocF5w3vj5nvO+aYGDzGM=
X-Google-Smtp-Source: ABdhPJxdyse7PkQrd5pJ0PcrA6dXZ0/Y1A6X6BtDNB4FBddvt3SFwygU/8gEIoNbFxgjBJD2qOhZ5w==
X-Received: by 2002:a05:6808:f0a:: with SMTP id m10mr8074423oiw.48.1617918066554;
        Thu, 08 Apr 2021 14:41:06 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-9d4e-47e2-9152-a38a.res6.spectrum.com. [2603:8081:140c:1a00:9d4e:47e2:9152:a38a])
        by smtp.gmail.com with ESMTPSA id g11sm154050ots.34.2021.04.08.14.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 14:41:06 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, xyzxyz2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next 5/9] RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
Date:   Thu,  8 Apr 2021 16:40:37 -0500
Message-Id: <20210408214040.2956-6-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210408214040.2956-1-rpearson@hpe.com>
References: <20210408214040.2956-1-rpearson@hpe.com>
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

