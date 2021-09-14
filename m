Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC77A40B51C
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 18:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhINQoX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 12:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhINQoL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Sep 2021 12:44:11 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1190DC061574
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 09:42:54 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 6so19852858oiy.8
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 09:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PzztxkAcLUiuVPSLe9AQASCqJgbtb/3TYkJ/REhI35I=;
        b=e1A86/39dlnQw231USDJXfVW2SQMJ4QgkJ+knkoH45oyTwKG9htME3sfu8NoJMyoRA
         QpsTFeZAK+L4XeU97+U0p3QgdvclvaGsb3p+9JQXw9ik2N8WASSQLq7oWC7UuUebYWzj
         x3KszVN/Irhuei9BuCJlB06i3mc8QbRCzHIrEhj4fGlOJJQxqRbRho+UBq7AhGwKoyhU
         ffJcW4Qdd+HKGxH5vLBPu9FvFgy+Lwg+yAO6vLkt1d8eDW3DddoJhwLh3wHqf7vcIfqE
         eF8KKndNfUN36CjNFrPqBBwG1DPWOtsf6A4NeY20b6y/IDq1D4FW3342VjKECwLKUOK7
         ZnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PzztxkAcLUiuVPSLe9AQASCqJgbtb/3TYkJ/REhI35I=;
        b=bpiARN+Mo2oQwt1zPi06tRdtc0ZEPUcLtmx6xeeGmrkoRRSXKvOb1WA3jRvh6rZOHx
         AJvg2Eb3K89L7B2GbJNMwDg9zVzl4wAuPZsUbGtC4T/TxKhVFlxC54ng8IdtokfjuYn3
         i7cXjpmsYpyq65xMg8T6YygjcK+yS9v2ejADtNMLQf08NXuWfKxPn63Hllx0Uzqq5kDV
         2jVJ8ETtgNNU35VMT8PhkRjXsIhCoxLo2tAjUdrwR8pMQYo+itzbOx2YXZxAsW0lImyi
         jxIT0BmQmxsDC54HJcHnMK+XksOB5I2z0cNY9733jYfogOUcwlrllbKGkw/jJoWmOVkr
         8F/w==
X-Gm-Message-State: AOAM531AHSVQI0IXlfUifuM05vJ+iQyuyFcuyRJf4NmNIvkaS3P9LGpp
        1x3Xa/MgdZzwbEArX8G+E2o=
X-Google-Smtp-Source: ABdhPJwiBuyKcnVIBF1R3wZzRM1lRXEDYQtJkkL36Zz0yQcYFs5q5X8a749IDBqyYbDgpVyauM3rlA==
X-Received: by 2002:a05:6808:56:: with SMTP id v22mr2183501oic.49.1631637773431;
        Tue, 14 Sep 2021 09:42:53 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-61e3-00cf-5364-0046.res6.spectrum.com. [2603:8081:140c:1a00:61e3:cf:5364:46])
        by smtp.gmail.com with ESMTPSA id k1sm2850263otr.43.2021.09.14.09.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 09:42:53 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, mie@igel.co.jp, rao.shoaib@oracle.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-rc v4 2/5] RDMA/rxe: Cleanup MR status and type enums
Date:   Tue, 14 Sep 2021 11:42:04 -0500
Message-Id: <20210914164206.19768-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914164206.19768-1-rpearsonhpe@gmail.com>
References: <20210914164206.19768-1-rpearsonhpe@gmail.com>
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

