Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76066360028
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Apr 2021 04:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhDOCze (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Apr 2021 22:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhDOCze (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Apr 2021 22:55:34 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2847C061756
        for <linux-rdma@vger.kernel.org>; Wed, 14 Apr 2021 19:55:10 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id i81so22827286oif.6
        for <linux-rdma@vger.kernel.org>; Wed, 14 Apr 2021 19:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K3HvFw+RtgfAZ5giUI6FTWhZ270iUlqbGN0Kkgaz328=;
        b=r3trwnyqfuWIkipnN5PEhSa7cna4mJezWXpcZOnoKrNkBSlmpwrPpvcUlyp6y+qr72
         Q8vss/D3jgzebGdiTXbf9m1nTYgLt0HI1MIMOCjFA27pvLn3jw3NAMbTwtyNM0vZdUVE
         lQfO69PxBbwOKXWZSXPsZanMkzRNRyCo72oeqwBLDqOmx8qM7bG72XZhKYTQJyVqF+Xx
         389JKkJsZiE7Pp8F8JQhjyXdmwJxOFCEYO2SbVBbd68n+fT/c/ETNY1IvoZGXhM9hWH0
         gExaRH2919CEL7ORJjxBq84HpgE+uYc9hVfialbQIhgrbDkadJxJkQ0K5pY3sDXl1O9o
         0yNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K3HvFw+RtgfAZ5giUI6FTWhZ270iUlqbGN0Kkgaz328=;
        b=skDDhRXXQR1yg5wUpopxYSMN83rvr2p4ntfJqsVIrQsI6ZLrZaDl9wl37RdmMpGKKT
         YDfXQqYzgyHH0kyIbvoPaCljKXsYDux3l1wG1efj13WlI36r00gXsoqJRCH+P05Hq05j
         6TaO8HqM+tDVxs8kzYpZB7hgUDqQecYAk50zqkBxBnwL7c92SrEBN4A9q9SEUimGQqnN
         pviZcKoG7y8d+mDwJAeiL0SXB3jnKONTqSFpUcoYACoo9NWnFMPF5+miNs/tZ+nyC3rE
         EAUSYPkrvK78z+h3AIJ83yewEv+3ZEyOqvJOruilsim9ddQASx6mo7Uktd1YWyv1SWW4
         AX+A==
X-Gm-Message-State: AOAM530CEiRJb/nEoaw66ZymKQaN5j3yOktoMkpWFZXq33/TOGz/SUFK
        Z/dOh22yYg+Oj7j7UVm/Gvg=
X-Google-Smtp-Source: ABdhPJxUoKWRwnhNcOIYUZA7vx1bZabb33Xz8oTuT038iBpAzRYe7blb9mLDu9bDoAQvWMilyBmYqg==
X-Received: by 2002:a54:4005:: with SMTP id x5mr996433oie.66.1618455310176;
        Wed, 14 Apr 2021 19:55:10 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-9ee3-9764-577f-477e.res6.spectrum.com. [2603:8081:140c:1a00:9ee3:9764:577f:477e])
        by smtp.gmail.com with ESMTPSA id h8sm349661oib.55.2021.04.14.19.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 19:55:09 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v2 5/9] RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
Date:   Wed, 14 Apr 2021 21:54:26 -0500
Message-Id: <20210415025429.11053-6-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210415025429.11053-1-rpearson@hpe.com>
References: <20210415025429.11053-1-rpearson@hpe.com>
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

