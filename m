Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64985AA0A4
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Sep 2022 22:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiIAUGp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 16:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiIAUGo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 16:06:44 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82056BD4B
        for <linux-rdma@vger.kernel.org>; Thu,  1 Sep 2022 13:06:42 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-11f11d932a8so25928369fac.3
        for <linux-rdma@vger.kernel.org>; Thu, 01 Sep 2022 13:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=dtTa4rrPfsVhVlpu09jMmL/WSQpygwsLFIzFVIU4HPs=;
        b=nFfl325u/WcuVRerl0T0u653x6X/u3hL2nTAStjkXAZTJgnWsOaZmVpkEudsEvwgKe
         ToQ/fMt8fZWTeG5MkEwxY8w3FQ2tAoqezIoBO2KHAWqY5KldsT+crEv6ApZjTM2pol8g
         y1UJAIBCbIuGI+utZ3IjypT/UVtHzUicJx8z4alSxPUfudMDW61tpZRtaGOewRmd5n5t
         V8tOTqn409TshewtLsA6TAU6cmOzntsCg32/gR/aTNVaEinh286miyqoCnVS1oPOwmKS
         K1HXm2fGB8fLX1m0vMmFp0P4lNh3SnrageHkHyCNt2xE37KI0S91c16HLIl1chSLdqmS
         cD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=dtTa4rrPfsVhVlpu09jMmL/WSQpygwsLFIzFVIU4HPs=;
        b=6OWG60gIEd1zsDZh6wjFJErYXokVCpmUusr5KbEl56Igj9VD4QjcWjOirA/2KkObSB
         MDZViCRMBqj3mgCCtU3gKuRa76XTSayGpHr2vz9EwHQPL0IJudb0BvzILeL8q9G+aels
         DDMJKJyK8uqlsukghjnNAb/TxBbQiV/vGDb9TFTVvqMdgbJJDz+4JLVDyZZeMnc+vgzs
         /MzdRkorndVQS1ntk0cuxe3xC3a15TRvndfJ8Dw2dQn2xp0d9qCOl9CI8wbzho10rM6S
         9UWUlKroIj1G51joFKra6wBiDcN95Kj4SAthEZD3drIeiyMm1BZbQvqf1jsnslw24wNe
         ppXg==
X-Gm-Message-State: ACgBeo3AjESqXxt6jzm1J/jTWKKZkyr+Cp6OMFOMyA2Qqrz2cCdzHFlW
        7Tl4j19vXEMfgb6R2OsxBS0=
X-Google-Smtp-Source: AA6agR5hJHqfjun949vr46REXJH478Pkq13c20/dwpF6Mq+gPxaouLvLKdf6s6xFim64SvqM2sfARQ==
X-Received: by 2002:a05:6808:1717:b0:334:9342:63f1 with SMTP id bc23-20020a056808171700b00334934263f1mr410195oib.77.1662062802144;
        Thu, 01 Sep 2022 13:06:42 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id bc14-20020a056808170e00b0032f0fd7e1f8sm75057oib.39.2022.09.01.13.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 13:06:41 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, lizhijian@fujitsu.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com, jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-rc v6] RDMA/rxe: Fix pd ref counting in rxe mr verbs.
Date:   Thu,  1 Sep 2022 15:04:27 -0500
Message-Id: <20220901200426.3236-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move referencing pd in mr objects ahead of any possible errors
so that it will always be set in rxe_mr_complete() to avoid
seg faults when rxe_put(mr_pd(mr)) is called. Adjust the reference
counts so that each call to rxe_mr_init_xxx() takes one reference.
This reference count is dropped in rxe_mr_cleanup() in error paths
in the reg mr verbs and the dereg mr verb. Minor white space cleanups.

These errors have been seen in rxe_mr_init_user() when there isn't
enough memory to create the mr maps. Previously the error return
path didn't reach setting ibpd in mr->ibmr which caused a seg fault.

Fixes: 364e282c4fe7e ("RDMA/rxe: Split MEM into MR and MW")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v6:
  Separated from other patch in original series and resubmitted
  rebased to current for-rc.
  Renamed from "RDMA/rxe: Set pd early in mr alloc routines" to
  "RDMA/rxe: Fix pd ref counting in rxe mr verbs"
  Added more text to describe the change.
  Added fixes line.
  Simplified the patch by leaving pd code in rxe_mr.c instead of
  moving it up to rxe_verbs.c
v5:
  Dropped cleanup code from patch per Li Zhijian.
  Split up into two small patches.
v4:
  Added set mr->ibmr.pd back to avoid an -ENOMEM error causing
  rxe_put(mr_pd(mr)); to seg fault in rxe_mr_cleanup() since pd
  is not getting set in the error path.
v3:
  Rebased to apply to current for-next after
  	Revert "RDMA/rxe: Create duplicate mapping tables for FMRs"
v2:
  Moved setting mr->umem until after checks to avoid sending
  an ERR_PTR to ib_umem_release().
  Cleaned up umem and map sets if errors occur in alloc mr calls.
  Rebased to current for-next.
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 24 ++++++++++++++----------
 drivers/infiniband/sw/rxe/rxe_verbs.c | 27 +++++++--------------------
 2 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 850b80f5ad8b..5f4daffccb40 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -107,7 +107,9 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
 {
 	rxe_mr_init(access, mr);
 
+	rxe_get(pd);
 	mr->ibmr.pd = &pd->ibpd;
+
 	mr->access = access;
 	mr->state = RXE_MR_STATE_VALID;
 	mr->type = IB_MR_TYPE_DMA;
@@ -125,9 +127,12 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	int err;
 	int i;
 
+	rxe_get(pd);
+	mr->ibmr.pd = &pd->ibpd;
+
 	umem = ib_umem_get(pd->ibpd.device, start, length, access);
 	if (IS_ERR(umem)) {
-		pr_warn("%s: Unable to pin memory region err = %d\n",
+		pr_debug("%s: Unable to pin memory region err = %d\n",
 			__func__, (int)PTR_ERR(umem));
 		err = PTR_ERR(umem);
 		goto err_out;
@@ -139,7 +144,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 
 	err = rxe_mr_alloc(mr, num_buf);
 	if (err) {
-		pr_warn("%s: Unable to allocate memory for map\n",
+		pr_debug("%s: Unable to allocate memory for map\n",
 				__func__);
 		goto err_release_umem;
 	}
@@ -147,7 +152,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	mr->page_shift = PAGE_SHIFT;
 	mr->page_mask = PAGE_SIZE - 1;
 
-	num_buf			= 0;
+	num_buf = 0;
 	map = mr->map;
 	if (length > 0) {
 		buf = map[0]->buf;
@@ -161,7 +166,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 
 			vaddr = page_address(sg_page_iter_page(&sg_iter));
 			if (!vaddr) {
-				pr_warn("%s: Unable to get virtual address\n",
+				pr_debug("%s: Unable to get virtual address\n",
 						__func__);
 				err = -ENOMEM;
 				goto err_cleanup_map;
@@ -175,7 +180,6 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 		}
 	}
 
-	mr->ibmr.pd = &pd->ibpd;
 	mr->umem = umem;
 	mr->access = access;
 	mr->length = length;
@@ -201,22 +205,21 @@ int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
 {
 	int err;
 
+	rxe_get(pd);
+	mr->ibmr.pd = &pd->ibpd;
+
 	/* always allow remote access for FMRs */
 	rxe_mr_init(IB_ACCESS_REMOTE, mr);
 
 	err = rxe_mr_alloc(mr, max_pages);
 	if (err)
-		goto err1;
+		return err;
 
-	mr->ibmr.pd = &pd->ibpd;
 	mr->max_buf = max_pages;
 	mr->state = RXE_MR_STATE_FREE;
 	mr->type = IB_MR_TYPE_MEM_REG;
 
 	return 0;
-
-err1:
-	return err;
 }
 
 static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
@@ -630,6 +633,7 @@ void rxe_mr_cleanup(struct rxe_pool_elem *elem)
 	int i;
 
 	rxe_put(mr_pd(mr));
+
 	ib_umem_release(mr->umem);
 
 	if (mr->map) {
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index e264cf69bf55..95df3b04babc 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -902,18 +902,15 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	rxe_get(pd);
 	rxe_mr_init_dma(pd, access, mr);
 	rxe_finalize(mr);
 
 	return &mr->ibmr;
 }
 
-static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
-				     u64 start,
-				     u64 length,
-				     u64 iova,
-				     int access, struct ib_udata *udata)
+static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
+				     u64 length, u64 iova, int access,
+				     struct ib_udata *udata)
 {
 	int err;
 	struct rxe_dev *rxe = to_rdev(ibpd->device);
@@ -921,26 +918,19 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	struct rxe_mr *mr;
 
 	mr = rxe_alloc(&rxe->mr_pool);
-	if (!mr) {
-		err = -ENOMEM;
-		goto err2;
-	}
-
-
-	rxe_get(pd);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
 
 	err = rxe_mr_init_user(pd, start, length, iova, access, mr);
 	if (err)
-		goto err3;
+		goto err_cleanup;
 
 	rxe_finalize(mr);
 
 	return &mr->ibmr;
 
-err3:
-	rxe_put(pd);
+err_cleanup:
 	rxe_cleanup(mr);
-err2:
 	return ERR_PTR(err);
 }
 
@@ -961,8 +951,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 		goto err1;
 	}
 
-	rxe_get(pd);
-
 	err = rxe_mr_init_fast(pd, max_num_sg, mr);
 	if (err)
 		goto err2;
@@ -972,7 +960,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 	return &mr->ibmr;
 
 err2:
-	rxe_put(pd);
 	rxe_cleanup(mr);
 err1:
 	return ERR_PTR(err);

base-commit: 45baad7dd98f4d83f67c86c28769d3184390e324
-- 
2.34.1

