Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58F2367944
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 07:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhDVF31 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 01:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhDVF31 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Apr 2021 01:29:27 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C66C06174A
        for <linux-rdma@vger.kernel.org>; Wed, 21 Apr 2021 22:28:52 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id n184so18703827oia.12
        for <linux-rdma@vger.kernel.org>; Wed, 21 Apr 2021 22:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K3HvFw+RtgfAZ5giUI6FTWhZ270iUlqbGN0Kkgaz328=;
        b=Y5u7YvzF2GxpEZ9HhCg9d+m0Enkhad65LrNpjSJJRqD0BV1enBAiJIK6dF2+DIFEtR
         /GXe/hCfpnU69LD1S7J8IhWZbctgMBa7AfG21P3xTB5MIzyqN6si2z1Ti31S/CzADC8h
         i7uF7dXhVqDuPCBsgYm6SnkfUaG6xiJIs61H15mC9VodBh+mNCofG/Ly7Pd9v5/Mqvvh
         7l+CFq0+QJP5LyX21DMaZfIYsa5gKn9ZwpYssBc8FbixP24MEM3eD7uBJ1u/L0I8N3s7
         1WPrwyQNr69hUcSuSx0HK3Eg7lmidzOHuPw0bi27aoV6NChejrTLHHOCDTjBK9HHFKTY
         QQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K3HvFw+RtgfAZ5giUI6FTWhZ270iUlqbGN0Kkgaz328=;
        b=umLzpvwUA6zQTf2pPmXx/SwnbYrztGsCcaiF7ltN4OZwn1G6+mWHUN+5o8/1eDl5gZ
         lPtHjgJl8FXbKiYPdVCN8camie66B12YpZPHhaw2JuyrgEGWqnCEDlXeCDUtQqpQdiEx
         QbgAh1xe5fC76Jf8qlaiw08sK4BLLfjZ9wV7DIj3YQ1sAXBk7552jg6bETX9SZV5vV3v
         Ypg36VT7O0XrZT3uA50wlhAwRCkBZdNOH9PKmJc33EQkiIooU3tt8lfkHIppCshLX0xc
         CeKEiKcnj6LBW63t8oVivEp09jgvMFAzi6hIfFGPG6pVYTlHXchFGktjkfyGiUKCTMY5
         AN8Q==
X-Gm-Message-State: AOAM531NIFyNEppBtbOiiUWARorc2TBc1R9/4LrKLf37nnj//yW9DDzS
        uERutEDipx/4UOHrlRkgyjrivv0cStQ=
X-Google-Smtp-Source: ABdhPJx8djUdJz2wzHo6Bm+FI3rzmR9IuaJtfMMuxxyLlb8TISpn08SNUc+wFIJryKl93JXtk5CWow==
X-Received: by 2002:aca:1c06:: with SMTP id c6mr9308062oic.108.1619069332422;
        Wed, 21 Apr 2021 22:28:52 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e336-c4b4-ca5e-5b3f.res6.spectrum.com. [2603:8081:140c:1a00:e336:c4b4:ca5e:5b3f])
        by smtp.gmail.com with ESMTPSA id c65sm356175oia.47.2021.04.21.22.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 22:28:52 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v4 05/10] RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
Date:   Thu, 22 Apr 2021 00:28:18 -0500
Message-Id: <20210422052822.36527-6-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210422052822.36527-1-rpearson@hpe.com>
References: <20210422052822.36527-1-rpearson@hpe.com>
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

