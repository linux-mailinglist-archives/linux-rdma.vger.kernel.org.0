Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD154033D1
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Sep 2021 07:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245528AbhIHFaw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 01:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344569AbhIHFas (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Sep 2021 01:30:48 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF9BC0617A8
        for <linux-rdma@vger.kernel.org>; Tue,  7 Sep 2021 22:29:40 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso1459993otv.3
        for <linux-rdma@vger.kernel.org>; Tue, 07 Sep 2021 22:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SSA6K+yNO+cLEa6dQ9PEN6abRHzj8+2fVqUrLKShSY0=;
        b=i6eL2xrjWOd8BKj8Tffy5OXkzrNiht0zCujlFlyRZWAnJyp9V/4cYMc1db4+xR0W9l
         qgzWEgvhnXDjqzHUaB+3E26/RSd8O8Tg5/5C7Szbzrs32srxE/dzm/EjC8Tv23YTLKkQ
         7JWM3vq/pVZ68ObDB9k/eruxMBl6p0O3GrxfXA8OwiEp/91NHk6kneeZ5qONRzSlxOJK
         jog3ING0IAplS317gaEsy36VkIbaH48Kh+yknMzIp7yk8vpvOmGEIg1BmTP82kcHeO7n
         38KKThQERsUxVNmuMebwGssmcCMaEz9ADv62FbSrOHGhQ5iPjSYkLC6ig/8QzE7c+7TY
         0o1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SSA6K+yNO+cLEa6dQ9PEN6abRHzj8+2fVqUrLKShSY0=;
        b=jtkY2yv887aJ0Y8EikrMKrmuDcH3RQuC2SYNkSs7f+6e/bqHCGytEYgd/kj8MEF3cF
         eDSh8DhMGzwLp2vwvsk/VYTzM5TBDJCe3+NSDnYWD5CEa2Fm9vC8BWSYmZdsxg4x/pQX
         TREa/CBtxV17YlOZWnjJetcK+vEkRUxJo9AwF4Iw2aFflqK+8091xNWEqBtAbZDj2RqH
         RfZfdPb3jk45+4cGJBAuOyLP6bxFHbKFCUKm4XqaVgz9RPELgKdrBU+DQCMXz14+KlNp
         3WNaklxBQRBc/vAOD8zwZj3yGbTTrPEuXHDh6D9JXPfDWU73YJ+ZN8XMUmgOox4U1u78
         mxlA==
X-Gm-Message-State: AOAM531RwPN5a+4DfwfPxTKkoeNmV+8To7/wvJuHL1p5Jniz95c8tbJ7
        vGpJ6akTBcpMkBNIpJ/I0aAspdVVGLGo6Q==
X-Google-Smtp-Source: ABdhPJxV+i3G/mU8wbnRjMnen+FtB8rPpxinQ2Nm+h+Pk9NRBWRFmJMW2rdCqJTrVHhBxaAI2Dbqxw==
X-Received: by 2002:a9d:74c5:: with SMTP id a5mr1618641otl.205.1631078980346;
        Tue, 07 Sep 2021 22:29:40 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-4049-a9c6-d3dc-35fa.res6.spectrum.com. [2603:8081:140c:1a00:4049:a9c6:d3dc:35fa])
        by smtp.gmail.com with ESMTPSA id bf6sm281183oib.0.2021.09.07.22.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 22:29:40 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        bvanassche@acm.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 5/5] RDMA/rxe: Cleanup MR status and type enums
Date:   Wed,  8 Sep 2021 00:29:28 -0500
Message-Id: <20210908052928.17375-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210908052928.17375-1-rpearsonhpe@gmail.com>
References: <20210908052928.17375-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_mr.c    | 30 ++++++++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  9 +-------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index c909e220e782..7c75f66357bc 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -27,16 +27,19 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 	struct rxe_map_set *set = mr->cur_map_set;;
 
 	switch (mr->type) {
-	case RXE_MR_TYPE_DMA:
+	case IB_MR_TYPE_DMA:
 		return 0;
 
-	case RXE_MR_TYPE_MR:
+	case IB_MR_TYPE_USER:
+	case IB_MR_TYPE_MEM_REG:
 		if (iova < set->iova || length > set->length ||
 		    iova > set->iova + set->length - length)
 			return -EFAULT;
 		return 0;
 
 	default:
+		pr_warn("%s: mr type (%d) not supported\n",
+			__func__, mr->type);
 		return -EFAULT;
 	}
 }
@@ -59,7 +62,7 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
 	mr->rkey = mr->ibmr.rkey = rkey;
 
 	mr->state = RXE_MR_STATE_INVALID;
-	mr->type = RXE_MR_TYPE_NONE;
+	mr->type = -1;
 	mr->map_shift = ilog2(RXE_BUF_PER_MAP);
 }
 
@@ -156,7 +159,7 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
 	mr->ibmr.pd = &pd->ibpd;
 	mr->access = access;
 	mr->state = RXE_MR_STATE_VALID;
-	mr->type = RXE_MR_TYPE_DMA;
+	mr->type = IB_MR_TYPE_DMA;
 }
 
 int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
@@ -226,7 +229,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	mr->umem = umem;
 	mr->access = access;
 	mr->state = RXE_MR_STATE_VALID;
-	mr->type = RXE_MR_TYPE_MR;
+	mr->type = IB_MR_TYPE_USER;
 
 	set->length = length;
 	set->iova = iova;
@@ -257,7 +260,7 @@ int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
 	mr->ibmr.pd = &pd->ibpd;
 	mr->max_buf = max_pages;
 	mr->state = RXE_MR_STATE_FREE;
-	mr->type = RXE_MR_TYPE_MR;
+	mr->type = IB_MR_TYPE_MEM_REG;
 
 	return 0;
 
@@ -360,7 +363,7 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 	if (length == 0)
 		return 0;
 
-	if (mr->type == RXE_MR_TYPE_DMA) {
+	if (mr->type == IB_MR_TYPE_DMA) {
 		u8 *src, *dest;
 
 		src = (dir == RXE_TO_MR_OBJ) ? addr : ((void *)(uintptr_t)iova);
@@ -628,8 +631,15 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 
 	/* user can only register MR in free state */
 	if (unlikely(mr->state != RXE_MR_STATE_FREE)) {
-		pr_warn("%s: mr->lkey = 0x%x not free\n",
-			__func__, mr->lkey);
+		pr_warn("%s: mr->state = %d not free\n",
+			__func__, mr->state);
+		return -EINVAL;
+	}
+
+	/* user can only register MR of type IB_MR_TYPE_MEM_REG */
+	if (unlikely(mr->type != IB_MR_TYPE_MEM_REG)) {
+		pr_warn("%s: mr->type = %d wrong type\n",
+			__func__, mr->type);
 		return -EINVAL;
 	}
 
@@ -683,7 +693,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 		return -EINVAL;
 	}
 
-	mr->state = RXE_MR_STATE_ZOMBIE;
+	mr->state = RXE_MR_STATE_INVALID;
 	rxe_drop_ref(mr_pd(mr));
 	rxe_drop_index(mr);
 	rxe_drop_ref(mr);
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 87c9e8ed55ad..9eabc8f30359 100644
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
@@ -327,7 +320,7 @@ struct rxe_mr {
 	u32			lkey;
 	u32			rkey;
 	enum rxe_mr_state	state;
-	enum rxe_mr_type	type;
+	enum ib_mr_type		type;
 	int			access;
 
 	int			map_shift;
-- 
2.30.2

