Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EA23664C0
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 07:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbhDUFV1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 01:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbhDUFV1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Apr 2021 01:21:27 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07197C06138B
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 22:20:54 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u80so7734774oia.0
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 22:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K3HvFw+RtgfAZ5giUI6FTWhZ270iUlqbGN0Kkgaz328=;
        b=D4iHHxTLrHL1mXKzCflJMJqJz4HrECiakKh6VFQTVXoicbMXFNhN07Ea3UK9O2/Txp
         EMeS6DnFrmJ4SnH5a3IyCwP4qu7Q4PFnDwm8kMwNRNWaq72BLQAQgu3BCike6frMWTkJ
         cgP8NZ2ikfxyIzy6rOv9Y9K2DkuMZGKW2rZMB2D3p/7iKHnGJGW5vQdTChPV63shr64q
         TxNDcop+jmarCeo4TfxivAqBui4dJ8qwEgRFVuFhZb6g3hbHY4Fd01hcbbedfGI9yFbh
         mkkb6eMQajjKYatl8d2r2erJsfFKviovkouOYnvAmWEjknMzaSG6XVefQKogWn6qDcJf
         Y/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K3HvFw+RtgfAZ5giUI6FTWhZ270iUlqbGN0Kkgaz328=;
        b=HTBPqpd6twIotR3d5hziL7xd02SxSizKhFhX9SFlaCa6951X1sW1VfSCzfi02EUUDv
         OQaCcnBsaKVRj8GYz0utkCEwDzQsieo+rxBIOAzTsw88Q2eA4DYBhbEougNMsvXm9XtT
         TqhNDmr2uUKW7raGDnFRlfSamjtBGx1nn+H2qodGzUjslXTGWcd4qvNNrj2oa4BljVgW
         NrTDvEkZgmdLJFmDf2T80+I4QAY/FHMwUDfsMcKJwoVAH06d6h2Z7HmiDrq7hEzUytUi
         WMMxPxlC9Gqvp9jL0CSvzN0k2T/zEDIBW6Ng4hdA1LfPxP0KMO2adx7Uq/Cf0j2ahjqt
         HNIw==
X-Gm-Message-State: AOAM531LrDm36uCl44I7ZpGvdvJsa3btGjHeH01fKKw94SyoHM9FPDmK
        ehNKAAGeQ54EM1V2GMa1l3rFDV+aeOA=
X-Google-Smtp-Source: ABdhPJwLt0ickQTvPqVbbZm0jsCeHlsYOnw8uwL1eIiHqyKYbXVALlDp13jFD09jo+41C6E7vZQ3tQ==
X-Received: by 2002:a54:4d04:: with SMTP id v4mr5493174oix.115.1618982453529;
        Tue, 20 Apr 2021 22:20:53 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-eeb0-9b2d-35df-5cd9.res6.spectrum.com. [2603:8081:140c:1a00:eeb0:9b2d:35df:5cd9])
        by smtp.gmail.com with ESMTPSA id a10sm277478otl.15.2021.04.20.22.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 22:20:53 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v3 5/9] RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
Date:   Wed, 21 Apr 2021 00:20:12 -0500
Message-Id: <20210421052015.4546-6-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210421052015.4546-1-rpearson@hpe.com>
References: <20210421052015.4546-1-rpearson@hpe.com>
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

