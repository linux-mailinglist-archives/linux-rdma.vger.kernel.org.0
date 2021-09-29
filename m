Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A092D41BDEE
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Sep 2021 06:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243918AbhI2EVS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Sep 2021 00:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243975AbhI2EVQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Sep 2021 00:21:16 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32BDC061746
        for <linux-rdma@vger.kernel.org>; Tue, 28 Sep 2021 21:19:33 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so1328363otb.1
        for <linux-rdma@vger.kernel.org>; Tue, 28 Sep 2021 21:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wGElA4q7plQa8+h675MjByrmxCgr2foTglcxGJwe7eQ=;
        b=0XxtxdxuxQsaGrYghSepZmEg+mymN7mpDodcuer1ZfBwLDWdMD6Pjr69uI89F3um/4
         7CJ6XBqNgPlmiDn+FI+rG1zutNpgRyuU7blXeuqQPEfkeRojjbHvYChgY9aR7zdN5JNM
         gMvnoxk+mcSqrinmr1183bzXHlGGCFiCOzo1HSmuYAHq69Xd9vSlIPYnZs/66gVwAHBM
         VZFsnfKqx0jK9QdbML9HhOzaVOHbjQiVr1RGTRMox7Ngzhv84M98P2Wl4ginPQM+QwQ5
         4zmFID1o+X1fKzOBWmLNB4MvW0Uj31v/0pnfM2u22sqZ55PdC1+/NGxw4gHpbFgXx+UA
         rosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wGElA4q7plQa8+h675MjByrmxCgr2foTglcxGJwe7eQ=;
        b=M+io2sBgKtRujQ3jDfNz2uzPcbcJf3ctNfxKzejvgZ+vBpc/2FVBqGbYMUDXS7VpyA
         aIGPqDIIG3OowuDkBn0xdrEzv/CeodDsU8MOxRZ2JLzOtZjo++6iH+zlsNUB8CEA9X0H
         fI7aWHVFvkdYS9OFVN4eTBxyeuxPu/2MpLHWWf0i06il+AP5mC/Lrh6I2UBCThkN4Z6i
         TtrKLWLv6OaLzr4bfeiSFD1QEPrCQsnIIH4sB+/Gf50ROLmcqcSSgpB+tzXi/TuAw3CI
         DugjQp5W4siNjNWP7ZU+WQmxum/fJsnt0xMHv7PoJLP/WGkkVE4aLNxQXQHkKdzaZDqW
         JF2A==
X-Gm-Message-State: AOAM533RP2rwYu4k2t0ec3dJx7TOsNxtNI7dri9PEKOqdX08y5H6n52q
        2iCigs3SU2SS5eLlGo4dFxFsLw==
X-Google-Smtp-Source: ABdhPJxm3jV3B4Xb0fXgD0QDodasvr5KZQLcmb7LjX5hM3pCvIFkZs4M5h+NCuPtSHe14gi5dAALAw==
X-Received: by 2002:a9d:7116:: with SMTP id n22mr8531664otj.56.1632889173299;
        Tue, 28 Sep 2021 21:19:33 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id p2sm240861ooe.34.2021.09.28.21.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 21:19:32 -0700 (PDT)
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
        Maor Gottlieb <maorg@nvidia.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, dhobsong@igel.co.jp, taki@igel.co.jp,
        etom@igel.co.jp
Subject: [RFC PATCH v2 2/2] RDMA/rxe: Add dma-buf support
Date:   Wed, 29 Sep 2021 13:19:05 +0900
Message-Id: <20210929041905.126454-3-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210929041905.126454-1-mie@igel.co.jp>
References: <20210929041905.126454-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement a ib device operation ‘reg_user_mr_dmabuf’. Generate a
rxe_map from the memory space linked the passed dma-buf.

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |   2 +
 drivers/infiniband/sw/rxe/rxe_mr.c    | 118 ++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c |  34 ++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.h |   2 +
 4 files changed, 156 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 1ca43b859d80..8bc19ea1a376 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -75,6 +75,8 @@ u8 rxe_get_next_key(u32 last_key);
 void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr);
 int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 		     int access, struct rxe_mr *mr);
+int rxe_mr_dmabuf_init_user(struct rxe_pd *pd, int fd, u64 start, u64 length,
+			    u64 iova, int access, struct rxe_mr *mr);
 int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr);
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_dir dir);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 53271df10e47..af6ef671c3a5 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
  */
 
+#include <linux/dma-buf.h>
 #include "rxe.h"
 #include "rxe_loc.h"
 
@@ -245,6 +246,120 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	return err;
 }
 
+static int rxe_map_dmabuf_mr(struct rxe_mr *mr,
+			     struct ib_umem_dmabuf *umem_dmabuf)
+{
+	struct rxe_map_set *set;
+	struct rxe_phys_buf *buf = NULL;
+	struct rxe_map **map;
+	void *vaddr, *vaddr_end;
+	int num_buf = 0;
+	int err;
+	size_t remain;
+
+	mr->dmabuf_map = kzalloc(sizeof &mr->dmabuf_map, GFP_KERNEL);
+	if (!mr->dmabuf_map) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	err = dma_buf_vmap(umem_dmabuf->dmabuf, mr->dmabuf_map);
+	if (err)
+		goto err_free_dmabuf_map;
+
+	set = mr->cur_map_set;
+	set->page_shift = PAGE_SHIFT;
+	set->page_mask = PAGE_SIZE - 1;
+
+	map = set->map;
+	buf = map[0]->buf;
+
+	vaddr = mr->dmabuf_map->vaddr;
+	vaddr_end = vaddr + umem_dmabuf->dmabuf->size;
+	remain = umem_dmabuf->dmabuf->size;
+
+	for (; remain; vaddr += PAGE_SIZE) {
+		if (num_buf >= RXE_BUF_PER_MAP) {
+			map++;
+			buf = map[0]->buf;
+			num_buf = 0;
+		}
+
+		buf->addr = (uintptr_t)vaddr;
+		if (remain >= PAGE_SIZE)
+			buf->size = PAGE_SIZE;
+		else
+			buf->size = remain;
+		remain -= buf->size;
+
+		num_buf++;
+		buf++;
+	}
+
+	return 0;
+
+err_free_dmabuf_map:
+	kfree(mr->dmabuf_map);
+err_out:
+	return err;
+}
+
+static void rxe_unmap_dmabuf_mr(struct rxe_mr *mr)
+{
+	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(mr->umem);
+
+	dma_buf_vunmap(umem_dmabuf->dmabuf, mr->dmabuf_map);
+	kfree(mr->dmabuf_map);
+}
+
+int rxe_mr_dmabuf_init_user(struct rxe_pd *pd, int fd, u64 start, u64 length,
+			    u64 iova, int access, struct rxe_mr *mr)
+{
+	struct ib_umem_dmabuf *umem_dmabuf;
+	struct rxe_map_set *set;
+	int err;
+
+	umem_dmabuf = ib_umem_dmabuf_get(pd->ibpd.device, start, length, fd,
+					 access, NULL);
+	if (IS_ERR(umem_dmabuf)) {
+		err = PTR_ERR(umem_dmabuf);
+		goto err_out;
+	}
+
+	rxe_mr_init(access, mr);
+
+	err = rxe_mr_alloc(mr, ib_umem_num_pages(&umem_dmabuf->umem), 0);
+	if (err) {
+		pr_warn("%s: Unable to allocate memory for map\n", __func__);
+		goto err_release_umem;
+	}
+
+	mr->ibmr.pd = &pd->ibpd;
+	mr->umem = &umem_dmabuf->umem;
+	mr->access = access;
+	mr->state = RXE_MR_STATE_VALID;
+	mr->type = IB_MR_TYPE_USER;
+
+	set = mr->cur_map_set;
+	set->length = length;
+	set->iova = iova;
+	set->va = start;
+	set->offset = ib_umem_offset(mr->umem);
+
+	err = rxe_map_dmabuf_mr(mr, umem_dmabuf);
+	if (err)
+		goto err_free_map_set;
+
+	return 0;
+
+err_free_map_set:
+	rxe_mr_free_map_set(mr->num_map, mr->cur_map_set);
+err_release_umem:
+	ib_umem_release(&umem_dmabuf->umem);
+err_out:
+	return err;
+}
+
 int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
 {
 	int err;
@@ -703,6 +818,9 @@ void rxe_mr_cleanup(struct rxe_pool_entry *arg)
 {
 	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
 
+	if (mr->umem && mr->umem->is_dmabuf)
+		rxe_unmap_dmabuf_mr(mr);
+
 	ib_umem_release(mr->umem);
 
 	if (mr->cur_map_set)
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 9d0bb9aa7514..6191bb4f434d 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -916,6 +916,39 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
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
+		goto err2;
+	}
+
+	rxe_add_index(mr);
+
+	rxe_add_ref(pd);
+
+	err = rxe_mr_dmabuf_init_user(pd, fd, start, length, iova, access, mr);
+	if (err)
+		goto err3;
+
+	return &mr->ibmr;
+
+err3:
+	rxe_drop_ref(pd);
+	rxe_drop_index(mr);
+	rxe_drop_ref(mr);
+err2:
+	return ERR_PTR(err);
+}
+
 static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
 				  u32 max_num_sg)
 {
@@ -1081,6 +1114,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.query_qp = rxe_query_qp,
 	.query_srq = rxe_query_srq,
 	.reg_user_mr = rxe_reg_user_mr,
+	.reg_user_mr_dmabuf = rxe_reg_user_mr_dmabuf,
 	.req_notify_cq = rxe_req_notify_cq,
 	.resize_cq = rxe_resize_cq,
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index c807639435eb..0aa95ab06b6e 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -334,6 +334,8 @@ struct rxe_mr {
 
 	struct rxe_map_set	*cur_map_set;
 	struct rxe_map_set	*next_map_set;
+
+	struct dma_buf_map *dmabuf_map;
 };
 
 enum rxe_mw_state {
-- 
2.17.1

