Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB161403429
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Sep 2021 08:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347718AbhIHGSB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 02:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347731AbhIHGSA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Sep 2021 02:18:00 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFE6C061757
        for <linux-rdma@vger.kernel.org>; Tue,  7 Sep 2021 23:16:53 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id c13-20020a17090a558d00b00198e6497a4fso560743pji.4
        for <linux-rdma@vger.kernel.org>; Tue, 07 Sep 2021 23:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Amzs+qVzXI0p443EvYxuZVlmrTo3jYD4cdKt9Y/ojeo=;
        b=m4Nt178OZXrtdSysxxfNxx91f5wPyZTRtQ512M+GFG1l3uCgFwjR2gqXt44Fdiso8e
         Ax+F6MsdP8KrTIbO2bULFTmJi93EZc5nzNSN9DRLW1e3uh7nt7vbzJ7oKmCT35ElE9Yp
         zxH9+wjnCRMwN9wY8/2ql83OjzIUu24F3F3efB96osqAq0cl8oVNjAZXtr4/fk2zyAZz
         o+dr10IHdr6s3iBTx6vk3gWC7c6Hf8ONCsvQv0JpYyJ9sAJ+rqQLUOLk9w4cs9FX8+2r
         oe2n79hnxu1cux8dsIUSTH4IOxZBvp9opPNePL4377ltuGGhKEaPIXC0cpuVrIQAaItm
         SdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Amzs+qVzXI0p443EvYxuZVlmrTo3jYD4cdKt9Y/ojeo=;
        b=BrB46kJb9gHkUP+4icNkvOWnxy9yct8ct71O9HxeAZro4t1G8wDph31IrXXrqIv1t0
         3p7N9h3U12lzYLe64UGL5v32NlD1iwBiEjDCFsVghMQBt8pKWNxMxp01NgWwyqM+Opvq
         mNWYyoqangsCsc8pTr4/DyLgxhPtDdaVfxOJREMHSUyMV/B65Y+2SeqE3VYnLtFwQX1u
         bvQCEOKdYqzKtDjlzPuiKYjAkpv88WT/dkXjnlsgI5dE5BmRESiue4CZkIPpaLoIHBs4
         3NZ3Mbd1swsbPuv+BO9Z4b+LZdxkT4HOEWHFtMo3vFdLd5fetrhFlUMY+RJQzDVaRSL2
         +KxA==
X-Gm-Message-State: AOAM532hxj87LlxtWETtFTCtsOPhh7FO3df56GVFWHMMTQGy4RyCP5vB
        jLb8U8Zec9XehXd3NWsomHP9HQ==
X-Google-Smtp-Source: ABdhPJzy4M8iMa8j4Ao0Rt8bRRoevTnlnQ5PGaLaKCQe2Spvl71dLUyZcoEZuheCct1OYdSLj1GQWA==
X-Received: by 2002:a17:90b:ec8:: with SMTP id gz8mr2396406pjb.41.1631081812607;
        Tue, 07 Sep 2021 23:16:52 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id n1sm971730pfv.209.2021.09.07.23.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 23:16:52 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Shunsuke Mie <mie@igel.co.jp>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        dhobsong@igel.co.jp, taki@igel.co.jp, etom@igel.co.jp
Subject: [RFC PATCH 3/3] RDMA/rxe: Support dma-buf as memory region
Date:   Wed,  8 Sep 2021 15:16:11 +0900
Message-Id: <20210908061611.69823-4-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908061611.69823-1-mie@igel.co.jp>
References: <20210908061611.69823-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement a ib device operation ‘reg_user_mr_dmabuf’. Import dma-buf
using the IB core API and map the memory area linked the dma-buf.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |   3 +
 drivers/infiniband/sw/rxe/rxe_mr.c    | 101 ++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c |  36 +++++++++
 3 files changed, 140 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 1ddb20855dee..206d9d5f8bbf 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -75,6 +75,9 @@ u8 rxe_get_next_key(u32 last_key);
 void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr);
 int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr);
+int rxe_mr_dmabuf_init_user(struct rxe_pd *pd, int fd, u64 start, u64 length,
+			    u64 iova, int access, struct rxe_mr *mr);
+
 int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr);
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_dir dir, u32 *crcp);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 8b08705ed62a..846f52aad0de 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
  */
 
+#include <linux/dma-buf.h>
+
 #include "rxe.h"
 #include "rxe_loc.h"
 
@@ -207,6 +209,105 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	return err;
 }
 
+static int rxe_map_dmabuf_mr(struct rxe_mr *mr)
+{
+	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(mr->umem);
+	struct ib_umem *umem = mr->umem;
+	int err;
+
+	err = ib_umem_dmabuf_map_pages(umem_dmabuf);
+	if (err)
+		goto err1;
+
+	err = rxe_mr_gen_map(mr, umem);
+	if (err)
+		goto err2;
+
+	return ib_umem_num_pages(umem);
+
+err2:
+	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
+err1:
+	return err;
+}
+
+/* A function called from the dma-buf exporter when the mapped pages
+ * become invalid.
+ */
+static void rxe_ib_dmabuf_invalidate_cb(struct dma_buf_attachment *attach)
+{
+	int err;
+	struct ib_umem_dmabuf *umem_dmabuf = attach->importer_priv;
+	struct rxe_mr *mr = umem_dmabuf->private;
+
+	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
+
+	/* all of memory region is immediately mapped again */
+	err = rxe_map_dmabuf_mr(mr);
+	if (err)
+		pr_err("%s: failed to map the dma-buf region", __func__);
+}
+
+static struct dma_buf_attach_ops rxe_ib_dmabuf_attach_ops = {
+	.move_notify = rxe_ib_dmabuf_invalidate_cb,
+};
+
+/* initialize a umem and map all the areas of dma-buf. */
+int rxe_mr_dmabuf_init_user(struct rxe_pd *pd, int fd, u64 start, u64 length,
+			    u64 iova, int access, struct rxe_mr *mr)
+{
+	struct ib_umem_dmabuf *umem_dmabuf;
+	int num_buf;
+	int err;
+
+	umem_dmabuf = ib_umem_dmabuf_get(pd->ibpd.device, start, length, fd,
+					 access, &rxe_ib_dmabuf_attach_ops);
+	if (IS_ERR(umem_dmabuf)) {
+		err = PTR_ERR(umem_dmabuf);
+		pr_err("%s: failed to get umem_dmabuf (%d)", __func__, err);
+		goto err1;
+	}
+
+	umem_dmabuf->private = mr;
+
+	mr->umem = &umem_dmabuf->umem;
+	mr->umem->iova = iova;
+	num_buf = ib_umem_num_pages(mr->umem);
+
+	rxe_mr_init(access, mr);
+
+	err = rxe_mr_alloc(mr, num_buf);
+	if (err)
+		goto err1;
+
+	mr->page_shift = PAGE_SHIFT;
+	mr->page_mask = PAGE_SIZE - 1;
+
+	mr->ibmr.pd = &pd->ibpd;
+	mr->access = access;
+	mr->length = length;
+	mr->iova = iova;
+	mr->va = start;
+	mr->offset = ib_umem_offset(mr->umem);
+	mr->state = RXE_MR_STATE_VALID;
+	mr->type = RXE_MR_TYPE_MR;
+
+	err = rxe_map_dmabuf_mr(mr);
+	if (err) {
+		pr_err("%s: failed to map the dma-buf region", __func__);
+		goto err2;
+	}
+
+	return 0;
+
+err2:
+	for (i = 0; i < mr->num_map; i++)
+		kfree(mr->map[i]);
+	kfree(mr->map);
+err1:
+	return err;
+}
+
 int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
 {
 	int err;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index c223959ac174..4a38c20730b3 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -959,6 +959,39 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
 	return ERR_PTR(err);
 }
 
+static struct ib_mr *rxe_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start,
+					    u64 length, u64 iova, int fd,
+					    int access, struct ib_udata *udata)
+{
+	int err;
+	struct rxe_dev *rxe = to_rdev(ibpd->device);
+	struct rxe_pd *pd = to_rpd(ibpd);
+	struct rxe_mr *mr;
+
+	mr = rxe_alloc(&rxe->mr_pool);
+	if (!mr) {
+		err = -ENOMEM;
+		goto err1;
+	}
+
+	rxe_add_index(mr);
+
+	rxe_add_ref(pd);
+
+	err = rxe_mr_dmabuf_init_user(pd, fd, start, length, iova, access, mr);
+	if (err)
+		goto err2;
+
+	return &mr->ibmr;
+
+err2:
+	rxe_drop_ref(pd);
+	rxe_drop_index(mr);
+	rxe_drop_ref(mr);
+err1:
+	return ERR_PTR(err);
+}
+
 static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 				  u32 max_num_sg)
 {
@@ -1139,6 +1172,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.query_qp = rxe_query_qp,
 	.query_srq = rxe_query_srq,
 	.reg_user_mr = rxe_reg_user_mr,
+	.reg_user_mr_dmabuf = rxe_reg_user_mr_dmabuf,
 	.req_notify_cq = rxe_req_notify_cq,
 	.resize_cq = rxe_resize_cq,
 
@@ -1181,6 +1215,8 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	}
 	rxe->tfm = tfm;
 
+	dma_coerce_mask_and_coherent(&dev->dev, DMA_BIT_MASK(64));
+
 	err = ib_register_device(dev, ibdev_name, NULL);
 	if (err)
 		pr_warn("%s failed with error %d\n", __func__, err);
-- 
2.17.1

