Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76288249387
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 05:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgHSDmk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 23:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgHSDmk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 23:42:40 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BB1C061389
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:42:40 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id l84so19839998oig.10
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 20:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WFPGG0nXiiPcPfoBzho1rlvW+ayhqfsllFu7OdFfHrY=;
        b=tNOujEbp7qU89rZj9SqA5gDSY0uhAY4WUmTb9MLU5Huj2iohxaTHB2VSQ3g7CJSD37
         Eo02XFtFq39PlAn78tU/4XoW3c7SISk8qR0FE+dnVwm1aAuAECiiwcXEoxdWbEirEW15
         glGUBPFfDw2BGhb15mz2mHKPUTL+7vBOFwREgjQV0zEFKFbBCLHTkCrAuQWm1zRnqY+V
         mdYnZB01kSzFN5CnNbLtx3WFvPhWjhGvclNk4GB9RcZDELY1d9Q6RFZ6lAYgIBqnGiCD
         xHiqbMzICK4iCZXGYPVC15ovr075Abegdc/tC5h6pMGwgqeNiCngbSB06UyTcnFgTwqd
         E88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WFPGG0nXiiPcPfoBzho1rlvW+ayhqfsllFu7OdFfHrY=;
        b=heJgGlySZEAEWxMYyGuxUi/mOc5aNkMmlSRdRnAmjFWH8iwtZEoKkiaeDx9Epn0dwt
         adm8ro6orhkkGrcHvhzLAojNo8DM7BFNo5B/opBL2YQ201FHMvbGXUuLKW4e6smSBEI7
         HjpAnqLWOobQdsWlIfWZKe/bnWuOAiqL8kop1KLR9m4WpwxVCiPdO6RgE28z1AMBSJeU
         iyk4Haruj/MLzQCoF7Mzah1h04VLzyzVaOjlRhX3V63Giva79jUKd5fHAiBhQ81Iq/xQ
         +jc50zCInnBjhgolmu41m54dGlApLw10GuzcMstn+aNxPeq8XVPsbUSjsSEQW2MYPvaL
         nbAQ==
X-Gm-Message-State: AOAM530Mp/JTg7b2SyZ61WdeaLVtXwoqIsUZ/7ibpmVFk43twxSjvjJS
        YZQpOSEYkpqvD6sNhYR8srQ=
X-Google-Smtp-Source: ABdhPJxWXcGix9BFrgWei0Q+VI7cjvif8VhBrrw7PzX/fV2P2hWOmYQHeXl/nmlU0oG1cP52wL3SlQ==
X-Received: by 2002:aca:1c0c:: with SMTP id c12mr2084518oic.73.1597808559480;
        Tue, 18 Aug 2020 20:42:39 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:2731:80e6:14c6:1150])
        by smtp.gmail.com with ESMTPSA id 91sm4539714otn.18.2020.08.18.20.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 20:42:39 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v2 08/16] rdma_rxe: Added mw object
Date:   Tue, 18 Aug 2020 22:40:02 -0500
Message-Id: <20200819034002.8835-9-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819034002.8835-1-rpearson@hpe.com>
References: <20200819034002.8835-1-rpearson@hpe.com>
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
index 3a46df0fb4a0..bcb3530c1f85 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -64,6 +64,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 	rxe->attr.max_cq			= RXE_MAX_CQ;
 	rxe->attr.max_cqe			= (1 << RXE_MAX_LOG_CQE) - 1;
 	rxe->attr.max_mr			= RXE_MAX_MR;
+	rxe->attr.max_mw			= RXE_MAX_MW;
 	rxe->attr.max_pd			= RXE_MAX_PD;
 	rxe->attr.max_qp_rd_atom		= RXE_MAX_QP_RD_ATOM;
 	rxe->attr.max_res_rd_atom		= RXE_MAX_RES_RD_ATOM;
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 1a0d4da0ec3f..1f86951805c3 100644
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
index 59fbbb80800d..a7686772a6fc 100644
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
+	struct rxe_mem		*mr;
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

