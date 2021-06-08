Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D7139EDA6
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 06:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhFHE2J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 00:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhFHE2I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 00:28:08 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C281C061789
        for <linux-rdma@vger.kernel.org>; Mon,  7 Jun 2021 21:26:16 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u11so20357404oiv.1
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 21:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U5rPLEnmJZPFrJiSUM0o7pDJxLnxJTWiGzt2ZHYvHDE=;
        b=Q66JVqYVKnfHFsA2Qzl6o4uk88+v0SQPBTsxEInZ8nllhVl5DvOiaxv2QI0ypUMkcG
         lvNfCcufia44/sZL43wK8SdqD5DHhms7IWdgnQA1z3LdOmxfqC8aXDWv1xOLlkDyTt0Z
         kT4d4t60h08yJ6XHuf9j69xCqmiN62CaTrnTs0Nd8kgRrHaSZGaQFAIwOAyMLGAdm2lQ
         JOiyy9MkJH4aFupuIkilboddPv6KxVc2vmwJqnLctsWgJO8go+mXK0Cru4K5ZlPcuCKW
         KSL0imFcHpnhloc0XeXAEH2mvC5eHfWroTgAcYRzlv3oleDpoDsv0MtTQfzQuRuUu/Db
         2xCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U5rPLEnmJZPFrJiSUM0o7pDJxLnxJTWiGzt2ZHYvHDE=;
        b=R0kCh9vqhNVXAe4KhvSPUSKlP6WIp2AGH/CQ2ymCGJunOkkWieqyzDNNtxDUtdiI44
         41h7RshSXGJlrQ+nEKpjvIMOoducAwg+UFg9O1ybDc1MvzaqA8niN62ftcpG/5Rgik1l
         kATfehT+nkaRcyrvt2laLu6q8gFKuhIOlNkq4FjUNZhGAAyYYow+AfE8lDya6Vn6z+mt
         RLoZ/L6j4A3COPPkWDLDzw/26J/aQQYpRbfNwuIEIgnvSAgOR6SIukX6UmOKhMc1FrSr
         +Q6H4RQZfw2R7gMTAuDKCvqvsDhiCCDO+3kEL9/fA1LpXVAmE3MlndpjPhv7BM3HpQpV
         dpBA==
X-Gm-Message-State: AOAM531P7oKDjoaADxFx5UTIlpMW9eXIe2ralohz8mM7n+ewQlwxAS24
        QSGYCB0PpL5ibQkIWGgpZLM=
X-Google-Smtp-Source: ABdhPJwj/dfJvzTTxtYNS6BryeviLcVBD4vTGM5c7OKixgaHHITrM5/7pzKBSf8D3Z9aOqK/0v5e2A==
X-Received: by 2002:aca:c60c:: with SMTP id w12mr1617264oif.46.1623126375643;
        Mon, 07 Jun 2021 21:26:15 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-cb25-4f27-0965-41cc.res6.spectrum.com. [2603:8081:140c:1a00:cb25:4f27:965:41cc])
        by smtp.gmail.com with ESMTPSA id s187sm2683886oig.6.2021.06.07.21.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 21:26:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, monis@mellanox.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v9 05/10] RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
Date:   Mon,  7 Jun 2021 23:25:48 -0500
Message-Id: <20210608042552.33275-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608042552.33275-1-rpearsonhpe@gmail.com>
References: <20210608042552.33275-1-rpearsonhpe@gmail.com>
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

