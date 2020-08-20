Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B23824C7F0
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 00:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgHTWrf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 18:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgHTWrY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 18:47:24 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D840DC06138B
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:20 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id z18so153060otk.6
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hSM7NQzOIbDjSO8UmZP/e3wEDyqkR4Y9mAYFzWDRwes=;
        b=EpxQPiNZwxcrfatr3V3Kmqvu7QwM5Xt4r+0rNLKo1qNkuqydM70GTJMai7iKtMuiqG
         +NDfyvp2g2RVPrKxbS/iW8uNzW0TMEXUUy3Tqg1tTpFsKWvNq6sGOzIz75ytVgLG+ocU
         OgWnPGb0FhuUJZaJujNIFLwmJXAY5gAf0RM52siLwJ1UgL7NTUykMJ0GVNsLgOYIvYTc
         Uy4EM90OfHlo0jeohetKPry2i+XVOfOrNUO8A9iUvLMadXpaK6sTHP2JY63lMW1JlPpQ
         YtBqMNd6UjQh1Gexpm2bKsWxjBAOephnA+mHhUCEpWyYv2HQYwboWOkq6Wj1AxStlXE8
         e1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hSM7NQzOIbDjSO8UmZP/e3wEDyqkR4Y9mAYFzWDRwes=;
        b=NASlYqueOcNG5EO/gJxLiEaT2IuAzCGVViURgCinTlVmzWS/lj1kUarTXQT5wD1f5D
         JBRNa1YBinqjJpLHWV3uQOaTlXDlj0yCOHEAVEXuKGhjaoawqxglJFsH6JeTjFY2Rt/I
         xVPSXWZVOBd4DhOv6J2SWb3qbMVKnKe0f1chKu16H/V+dGRYdZcbsHY7Uh6xyZfVphty
         VnoHiCoZYvuFvvFmBWRGO5O5bD+IVvi9YT02EJBZrrHRXbQ5B6OfPl0KFc5uxAkvqwhO
         Owbb/MJCLGGcQaP2WoAn0dsnKws5rDO8ME2W/VWFJrVYN6WlU6Pwz5z+DICVqeZOlJmR
         +DiA==
X-Gm-Message-State: AOAM5325AdQ+9euaOabogfQymj7IHlTvQPfSZf4ETmJpaIQ7LGIR/8Je
        wksucJrI8TDx6oJpHc8Taatw5Kucud39yg==
X-Google-Smtp-Source: ABdhPJwqfhreJ2eCUWxnvz4HYy9xlC+yNvE1V32nYnok+A+7FxgY7IogJ3nMtp+rtGEi+f0L02B0og==
X-Received: by 2002:a9d:6c93:: with SMTP id c19mr4341otr.366.1597963639363;
        Thu, 20 Aug 2020 15:47:19 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:e2a0:5228:a0c3:36eb])
        by smtp.gmail.com with ESMTPSA id o5sm4280otp.8.2020.08.20.15.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 15:47:19 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v3 08/17] rdma_rxe: Added mw object
Date:   Thu, 20 Aug 2020 17:46:29 -0500
Message-Id: <20200820224638.3212-9-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820224638.3212-1-rpearson@hpe.com>
References: <20200820224638.3212-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Set max_mw device attribute.
Changed rxe_param.c so we can create mw objects (RXE_MAX_MW != 0).
Changed mw_pool.c to use struct rxe_mw size for the mw pool.
Added new mw struct to rxe_verbs.h. Can share state enum with mr.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe.c       |  1 +
 drivers/infiniband/sw/rxe/rxe_param.h | 10 ++++++----
 drivers/infiniband/sw/rxe/rxe_pool.c  |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h | 13 +++++++++++++
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 6c2100c71874..10f441ac7203 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -54,6 +54,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 	rxe->attr.max_cq			= RXE_MAX_CQ;
 	rxe->attr.max_cqe			= (1 << RXE_MAX_LOG_CQE) - 1;
 	rxe->attr.max_mr			= RXE_MAX_MR;
+	rxe->attr.max_mw			= RXE_MAX_MW;
 	rxe->attr.max_pd			= RXE_MAX_PD;
 	rxe->attr.max_qp_rd_atom		= RXE_MAX_QP_RD_ATOM;
 	rxe->attr.max_res_rd_atom		= RXE_MAX_RES_RD_ATOM;
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 96516e251bc1..e1d485bdd6af 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -60,7 +60,8 @@ enum rxe_device_param {
 	RXE_MAX_SGE_RD			= 32,
 	RXE_MAX_CQ			= 16384,
 	RXE_MAX_LOG_CQE			= 15,
-	RXE_MAX_MR			= 256 * 1024,
+	RXE_MAX_MR			= 0x40000,
+	RXE_MAX_MW			= 0x40000,
 	RXE_MAX_PD			= 0x7ffc,
 	RXE_MAX_QP_RD_ATOM		= 128,
 	RXE_MAX_RES_RD_ATOM		= 0x3f000,
@@ -89,9 +90,10 @@ enum rxe_device_param {
 	RXE_MAX_SRQ_INDEX		= 0x00040000,
 
 	RXE_MIN_MR_INDEX		= 0x00000001,
-	RXE_MAX_MR_INDEX		= 0x00040000,
-	RXE_MIN_MW_INDEX		= 0x00040001,
-	RXE_MAX_MW_INDEX		= 0x00060000,
+	RXE_MAX_MR_INDEX		= RXE_MIN_MR_INDEX + RXE_MAX_MR - 1,
+	RXE_MIN_MW_INDEX		= RXE_MIN_MR_INDEX + RXE_MAX_MR,
+	RXE_MAX_MW_INDEX		= RXE_MIN_MW_INDEX + RXE_MAX_MW - 1,
+
 	RXE_MAX_PKT_PER_ACK		= 64,
 
 	RXE_MAX_UNACKED_PSNS		= 128,
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index fe652ce488f3..ad6f50e8b57a 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -60,7 +60,7 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
 	},
 	[RXE_TYPE_MW] = {
 		.name		= "rxe-mw",
-		.size		= sizeof(struct rxe_mr),
+		.size		= sizeof(struct rxe_mw),
 		.flags		= RXE_POOL_INDEX,
 		.max_index	= RXE_MAX_MW_INDEX,
 		.min_index	= RXE_MIN_MW_INDEX,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index c866fc5a80d6..44da74a41ccb 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -264,6 +264,7 @@ struct rxe_qp {
 	struct execute_work	cleanup_work;
 };
 
+/* common state values for mr and mw */
 enum rxe_mem_state {
 	RXE_MEM_STATE_ZOMBIE,
 	RXE_MEM_STATE_INVALID,
@@ -321,6 +322,18 @@ struct rxe_mr {
 	struct rxe_map		**map;
 };
 
+struct rxe_mw {
+	struct rxe_pool_entry	pelem;
+	struct ib_mw		ibmw;
+	struct rxe_qp		*qp;	/* type 2B only */
+	struct rxe_mr		*mr;
+	spinlock_t		lock;
+	enum rxe_mem_state	state;
+	u32			access;
+	u64			addr;
+	u64			length;
+};
+
 struct rxe_mc_grp {
 	struct rxe_pool_entry	pelem;
 	spinlock_t		mcg_lock; /* guard group */
-- 
2.25.1

