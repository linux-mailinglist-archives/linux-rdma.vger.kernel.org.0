Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2332405E31
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Sep 2021 22:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345513AbhIIUrh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Sep 2021 16:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345646AbhIIUrf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Sep 2021 16:47:35 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B19EC061757
        for <linux-rdma@vger.kernel.org>; Thu,  9 Sep 2021 13:46:23 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id x10-20020a056830408a00b004f26cead745so4208804ott.10
        for <linux-rdma@vger.kernel.org>; Thu, 09 Sep 2021 13:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PzztxkAcLUiuVPSLe9AQASCqJgbtb/3TYkJ/REhI35I=;
        b=N9PFz8NGxgtnqN4a9RfIQM6jjgjVXVd1BAS6wlec60PSf496doyVf+9MqxrZCPY+So
         Y6urrSvhGGRdozGa/16VNMVqEJ4CBnaJABCJI1yPQ/qjyJXBI+tTdY5ShhUT1wKnz+gX
         /XbR9LQAZad1zDWbgVeDLSFKAeP8e+VrT58n4GHlbO0Zr1Io0y0HhYZJMGmtUS9epucg
         DlotuxNHPpadqMLL09bsfgze7nHQKs6gRW/ta+G25A/oHgfHA5Gsu72aDR1sdndALTcf
         jGWUT7ggraUQKHSi+p2ljkfjEbq/1sxKdwcBdSQEk937cVcx7LRvFIQQ3Rz4+mRwgsz3
         IsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PzztxkAcLUiuVPSLe9AQASCqJgbtb/3TYkJ/REhI35I=;
        b=0wMAEQ/s5TjW46CCsnBV7Evu/29Bos5L+rc3GlNmNifHC1Wt4rhI4AShFvgAsIzgoj
         i++w8O/rpg40SgC/QsN9Yw3ANvf+aRxpoNTCy4x/79ruzSoxKAzLvMC9F9pKqY9grF7S
         cWZid0tj7SPOULtF3Sw7c08TkRjFbdaB6RPnfqPpf8Tr0c2Q9+VNkngvku9bv0S8kZut
         zfz+4JxnvnTP3oYUW/VUIj3j3sA1Er1wO5UII4J1LHD3nT3fz36ve6y4jGrOPUWIU90d
         3C4zFZzfyGTT0yHu+a6kq1YTl7tah46sEFPb0XdLdRF9Jw7F6koTt0n3kemQx/tKZBDm
         Y0QQ==
X-Gm-Message-State: AOAM531nMRk68stVB1RZc7JYrXzy7uvugrLWk26+Z1d1P/kQFrCu7ob/
        CFxc7hEt/SJjHJkBu84GT+JqSM4YlYbKdA==
X-Google-Smtp-Source: ABdhPJx85cPGOlCjFjDngjkbb14NDkltjIXGjLPQTcq6lWEWYmmQuzETEDjNkhRIy1mICzLIIy3LbQ==
X-Received: by 2002:a9d:6c94:: with SMTP id c20mr1645092otr.142.1631220382641;
        Thu, 09 Sep 2021 13:46:22 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-a0a5-b98f-837d-887f.res6.spectrum.com. [2603:8081:140c:1a00:a0a5:b98f:837d:887f])
        by smtp.gmail.com with ESMTPSA id i9sm719892otp.18.2021.09.09.13.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:46:22 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        mie@igel.co.jp, bvanassche@acm.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-rc v3 3/6] RDMA/rxe: Cleanup MR status and type enums
Date:   Thu,  9 Sep 2021 15:44:54 -0500
Message-Id: <20210909204456.7476-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909204456.7476-1-rpearsonhpe@gmail.com>
References: <20210909204456.7476-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Eliminate RXE_MR_STATE_ZOMBIE which is not compatible with IBA.
RXE_MR_STATE_INVALID is better.

Replace RXE_MR_TYPE_XXX by IB_MR_TYPE_XXX which covers all the needed
types.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 20 ++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  9 +--------
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 5890a8246216..0cc24154762c 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -24,17 +24,22 @@ u8 rxe_get_next_key(u32 last_key)
 
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 {
+
+
 	switch (mr->type) {
-	case RXE_MR_TYPE_DMA:
+	case IB_MR_TYPE_DMA:
 		return 0;
 
-	case RXE_MR_TYPE_MR:
+	case IB_MR_TYPE_USER:
+	case IB_MR_TYPE_MEM_REG:
 		if (iova < mr->iova || length > mr->length ||
 		    iova > mr->iova + mr->length - length)
 			return -EFAULT;
 		return 0;
 
 	default:
+		pr_warn("%s: mr type (%d) not supported\n",
+			__func__, mr->type);
 		return -EFAULT;
 	}
 }
@@ -51,7 +56,6 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 	mr->ibmr.lkey = lkey;
 	mr->ibmr.rkey = rkey;
 	mr->state = RXE_MR_STATE_INVALID;
-	mr->type = RXE_MR_TYPE_NONE;
 	mr->map_shift = ilog2(RXE_BUF_PER_MAP);
 }
 
@@ -100,7 +104,7 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
 	mr->ibmr.pd = &pd->ibpd;
 	mr->access = access;
 	mr->state = RXE_MR_STATE_VALID;
-	mr->type = RXE_MR_TYPE_DMA;
+	mr->type = IB_MR_TYPE_DMA;
 }
 
 int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
@@ -173,7 +177,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	mr->va = start;
 	mr->offset = ib_umem_offset(umem);
 	mr->state = RXE_MR_STATE_VALID;
-	mr->type = RXE_MR_TYPE_MR;
+	mr->type = IB_MR_TYPE_USER;
 
 	return 0;
 
@@ -203,7 +207,7 @@ int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
 	mr->ibmr.pd = &pd->ibpd;
 	mr->max_buf = max_pages;
 	mr->state = RXE_MR_STATE_FREE;
-	mr->type = RXE_MR_TYPE_MR;
+	mr->type = IB_MR_TYPE_MEM_REG;
 
 	return 0;
 
@@ -302,7 +306,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 	if (length == 0)
 		return 0;
 
-	if (mr->type == RXE_MR_TYPE_DMA) {
+	if (mr->type == IB_MR_TYPE_DMA) {
 		u8 *src, *dest;
 
 		src = (dir == RXE_TO_MR_OBJ) ? addr : ((void *)(uintptr_t)iova);
@@ -564,7 +568,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 		return -EINVAL;
 	}
 
-	mr->state = RXE_MR_STATE_ZOMBIE;
+	mr->state = RXE_MR_STATE_INVALID;
 	rxe_drop_ref(mr_pd(mr));
 	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index ac2a2148027f..c6aca2293294 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -267,18 +267,11 @@ struct rxe_qp {
 };
 
 enum rxe_mr_state {
-	RXE_MR_STATE_ZOMBIE,
 	RXE_MR_STATE_INVALID,
 	RXE_MR_STATE_FREE,
 	RXE_MR_STATE_VALID,
 };
 
-enum rxe_mr_type {
-	RXE_MR_TYPE_NONE,
-	RXE_MR_TYPE_DMA,
-	RXE_MR_TYPE_MR,
-};
-
 enum rxe_mr_copy_dir {
 	RXE_TO_MR_OBJ,
 	RXE_FROM_MR_OBJ,
@@ -314,7 +307,7 @@ struct rxe_mr {
 	struct ib_umem		*umem;
 
 	enum rxe_mr_state	state;
-	enum rxe_mr_type	type;
+	enum ib_mr_type		type;
 	u64			va;
 	u64			iova;
 	size_t			length;
-- 
2.30.2

