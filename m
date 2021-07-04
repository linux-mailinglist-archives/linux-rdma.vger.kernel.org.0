Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3F43BAF60
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jul 2021 00:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhGDWkS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Jul 2021 18:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhGDWkS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 4 Jul 2021 18:40:18 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B42C061574
        for <linux-rdma@vger.kernel.org>; Sun,  4 Jul 2021 15:37:41 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id o13-20020a9d404d0000b0290466630039caso16430511oti.6
        for <linux-rdma@vger.kernel.org>; Sun, 04 Jul 2021 15:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8x70U480Rnh/vu3i1QwDPTzsWThP+3NNt+V4zB+8eGI=;
        b=R/HRvoPzWEQ2CChknGWLe4w84WQs8ngYpCdQFhZojTeH4JqHFp6xwwpH26BG6QrKpC
         S75wG+LnBUzQGnUGL2/VLZYzbjZ3j6JRqqMVq+1GMd1ozWh0t2q8dGAFc1lTAR1ZJ4lZ
         4rFgc6soEl4WT53eyGMHHydt3pxJ+ArNiY5KbXkBAgi38XqcGfyiOvpBex3MI1vchRah
         5Fwby5Y9ckOC/nsYjemQguYamUhzScOeP2kNzu449W7UhkN4uwAP4DftxR74ws+ZtqQg
         LlC0mnAdaR94yz3simvL6C95mHWhIhIT8vQY9SxBaYFx2C36UL4skjRTl6ZajbzqWKPT
         xfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8x70U480Rnh/vu3i1QwDPTzsWThP+3NNt+V4zB+8eGI=;
        b=pD4obLtL6RT5uSuPDifwvbkT5sp/EQcQhkh7Qf5bOa2rkKEa104b7Xi/NuHGIwzQd9
         K31Sh4hknxaJ5grUHQktTLV0TPkzOaYX38KlhKfp/95bHYHp7Ts7yHEG2ImwhcxGNFRp
         CMcVdJIOYbVRIMjX6LUN935lbsDuB0UMR3owoyb1OXME8cXbDC5J+0l5DRpBT7y0ltLP
         vRr/v1/CN7SJKQuLfDh55vpmNXyb3/r08cbWU4Z9Cg43cgIhsuPCVEur2kKF9x7cWzuU
         VVJt1TL2n4pcW8FJeOD0crCoLA0SMbB2d27OYtHlB7y+FyXoSTMxjVjI590nZlE+yvdZ
         Ta0g==
X-Gm-Message-State: AOAM530lylSTXNmoEXjkdfLDCtWiyGhN4BBG+X3MBOjUDiyPRtBunGte
        WKQ4XPKy2ZaLY3Rns6eQt/P7qyMyqL4=
X-Google-Smtp-Source: ABdhPJwUvGY3RiLgkBaCUpZL56RK+fKQGDxubyaqloM/+qwyjk3f+ZEbAl8jyiiAScQ+XElj0y/NJQ==
X-Received: by 2002:a9d:57cc:: with SMTP id q12mr9020713oti.286.1625438260840;
        Sun, 04 Jul 2021 15:37:40 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e370-af2e-0f4f-b7fe.res6.spectrum.com. [2603:8081:140c:1a00:e370:af2e:f4f:b7fe])
        by smtp.gmail.com with ESMTPSA id 186sm1952471ooe.28.2021.07.04.15.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 15:37:40 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        haakon.brugge@oracle.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix memory leak in error path code
Date:   Sun,  4 Jul 2021 17:35:07 -0500
Message-Id: <20210704223506.12795-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In rxe_mr_init_user() in rxe_mr.c at the third error the driver fails to
free the memory at mr->map. This patch adds code to do that.
This error only occurs if page_address() fails to return a non zero address
which should never happen for 64 bit architectures.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Reported by: Haakon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 41 +++++++++++++++++-------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 6aabcb4de235..f49baff9ca3d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -106,20 +106,21 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
 int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr)
 {
-	struct rxe_map		**map;
-	struct rxe_phys_buf	*buf = NULL;
-	struct ib_umem		*umem;
-	struct sg_page_iter	sg_iter;
-	int			num_buf;
-	void			*vaddr;
+	struct rxe_map **map;
+	struct rxe_phys_buf *buf = NULL;
+	struct ib_umem *umem;
+	struct sg_page_iter sg_iter;
+	int num_buf;
+	void *vaddr;
 	int err;
+	int i;
 
 	umem = ib_umem_get(pd->ibpd.device, start, length, access);
 	if (IS_ERR(umem)) {
-		pr_warn("err %d from rxe_umem_get\n",
-			(int)PTR_ERR(umem));
+		pr_warn("%s: Unable to pin memory region err = %d\n",
+			__func__, (int)PTR_ERR(umem));
 		err = PTR_ERR(umem);
-		goto err1;
+		goto err_out;
 	}
 
 	mr->umem = umem;
@@ -129,15 +130,15 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 
 	err = rxe_mr_alloc(mr, num_buf);
 	if (err) {
-		pr_warn("err %d from rxe_mr_alloc\n", err);
-		ib_umem_release(umem);
-		goto err1;
+		pr_warn("%s: Unable to allocate memory for map\n",
+				__func__);
+		goto err_release_umem;
 	}
 
 	mr->page_shift = PAGE_SHIFT;
 	mr->page_mask = PAGE_SIZE - 1;
 
-	num_buf			= 0;
+	num_buf = 0;
 	map = mr->map;
 	if (length > 0) {
 		buf = map[0]->buf;
@@ -151,10 +152,10 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 
 			vaddr = page_address(sg_page_iter_page(&sg_iter));
 			if (!vaddr) {
-				pr_warn("null vaddr\n");
-				ib_umem_release(umem);
+				pr_warn("%s: Unable to get virtual address\n",
+						__func__);
 				err = -ENOMEM;
-				goto err1;
+				goto err_cleanup_map;
 			}
 
 			buf->addr = (uintptr_t)vaddr;
@@ -177,7 +178,13 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 
 	return 0;
 
-err1:
+err_cleanup_map:
+	for (i = 0; i < mr->num_map; i++)
+		kfree(mr->map[i]);
+	kfree(mr->map);
+err_release_umem:
+	ib_umem_release(umem);
+err_out:
 	return err;
 }
 
-- 
2.30.2

