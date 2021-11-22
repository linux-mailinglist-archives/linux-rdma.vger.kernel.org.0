Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB8A458D0B
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 12:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhKVLMP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Nov 2021 06:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbhKVLLo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Nov 2021 06:11:44 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595E4C061574
        for <linux-rdma@vger.kernel.org>; Mon, 22 Nov 2021 03:08:38 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p18so13724572plf.13
        for <linux-rdma@vger.kernel.org>; Mon, 22 Nov 2021 03:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zWlby2sFftHMLmve376Nr7mmMkSU248+Ur4FH61bHpc=;
        b=0rKS43idbB+hATRIgfuw+HwVROS1wVMp1IWzOKdaA0HUjwDtvVMb970KswaOpBWOE0
         yx3jSQTvMmyMUkW3djgyG+1GcHjZ2fvqA9C08xBdBfEEcaMgEgNcOwlN9IkhWipMktBz
         sGFFxBZX/15TKe+RzqptXBEZeqXLDnXNvDLm8jWMpqrsCU8zYGWmvaZVfDi/zdmrTiYK
         4UOChwQt+pA5N67fe+VdAiA8pzI3tQRaNorzE8EBOqiCRoCPFHertZpLsK5XfQCPDBUm
         sJgQOxu0Mdc2J9fwoo01/uXGy0TQrJhmVUvloxajLk9LN1baJhhZT7QDtD1LCOYUiZbc
         95rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zWlby2sFftHMLmve376Nr7mmMkSU248+Ur4FH61bHpc=;
        b=cTu2DDpkeGV46iVEKNPSdpZxSkmsUnX0nwso5sHSdq3N7Lb9uNZbhX9su7hw+WYSkS
         QohneMIZ5/KcIH1OuPjL4ViYXMmChRaoMdsn0FcwAt4NIsHNvM5L6c2p9Nfk41AVkZxi
         24NC/aQynCriI77MXp5TKcq+Kerkbj0qOxGGp3hKlXKcdnLP7Rmdht+4kLng8rpUYlo1
         Q3Vl1wnrTwW+fm1lEpu7huN9ulZKnDj+zYam4PbDDxQpyY816ffjFCXJ9VA/dTZe6qim
         y1zyu9rkE20ZPllHY67XK703lrWGZqOxsTVlds6FKYsXs0jZk6ii+sbxf8rq/X09TbGN
         FRlg==
X-Gm-Message-State: AOAM531J4Uq/l2pB5Cg/0CWl76cASccYDbxPbmjFwNklzUAgwfRzUou2
        ocNXBk+rKuaMvRymWkd5sRIhlg==
X-Google-Smtp-Source: ABdhPJwGV7PdqdYCWBksNRXXGS0hy/fqd8dJUJXINnVkFj0H9VrDJgpVsnczgdxodacHp9K/lZzWAA==
X-Received: by 2002:a17:903:2045:b0:142:3d07:2866 with SMTP id q5-20020a170903204500b001423d072866mr106231404pla.17.1637579317824;
        Mon, 22 Nov 2021 03:08:37 -0800 (PST)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id h6sm9572816pfh.82.2021.11.22.03.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 03:08:37 -0800 (PST)
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
Subject: [RFC PATCH v4 2/2] RDMA/rxe: Add dma-buf support
Date:   Mon, 22 Nov 2021 20:08:17 +0900
Message-Id: <20211122110817.33319-3-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211122110817.33319-1-mie@igel.co.jp>
References: <20211122110817.33319-1-mie@igel.co.jp>
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
 drivers/infiniband/sw/rxe/rxe_mr.c    | 113 ++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.c |  34 ++++++++
 3 files changed, 149 insertions(+)

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
index 53271df10e47..b954e5647f82 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
  */
 
+#include <linux/dma-buf.h>
+#include <linux/dma-buf-map.h>
 #include "rxe.h"
 #include "rxe_loc.h"
 
@@ -245,6 +247,114 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	return err;
 }
 
+static int rxe_map_dmabuf_mr(struct rxe_mr *mr,
+			     struct ib_umem_dmabuf *umem_dmabuf)
+{
+	struct rxe_map_set *set;
+	struct rxe_phys_buf *buf = NULL;
+	struct rxe_map **map;
+	void *vaddr;
+	int num_buf = 0;
+	int err;
+	size_t remain;
+	struct dma_buf_map dmabuf_map;
+
+	err = dma_buf_vmap(umem_dmabuf->dmabuf, &dmabuf_map);
+	if (err || dmabuf_map.is_iomem)
+		goto err_out;
+
+	set = mr->cur_map_set;
+	set->page_shift = PAGE_SHIFT;
+	set->page_mask = PAGE_SIZE - 1;
+
+	map = set->map;
+	buf = map[0]->buf;
+
+	vaddr = dmabuf_map.vaddr;
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
+err_out:
+	return err;
+}
+
+static void rxe_unmap_dmabuf_mr(struct rxe_mr *mr)
+{
+	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(mr->umem);
+	struct rxe_map *map = mr->cur_map_set->map[0];
+	struct dma_buf_map dma_buf_map =
+		DMA_BUF_MAP_INIT_VADDR((void *)(uintptr_t)map->buf->addr);
+
+	dma_buf_vunmap(umem_dmabuf->dmabuf, &dma_buf_map);
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
@@ -703,6 +813,9 @@ void rxe_mr_cleanup(struct rxe_pool_entry *arg)
 {
 	struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
 
+	if (mr->umem && mr->umem->is_dmabuf)
+		rxe_unmap_dmabuf_mr(mr);
+
 	ib_umem_release(mr->umem);
 
 	if (mr->cur_map_set)
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 0aa0d7e52773..dc7d27b3cb90 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -940,6 +940,39 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
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
@@ -1105,6 +1138,7 @@ static const struct ib_device_ops rxe_dev_ops = {
 	.query_qp = rxe_query_qp,
 	.query_srq = rxe_query_srq,
 	.reg_user_mr = rxe_reg_user_mr,
+	.reg_user_mr_dmabuf = rxe_reg_user_mr_dmabuf,
 	.req_notify_cq = rxe_req_notify_cq,
 	.resize_cq = rxe_resize_cq,
 
-- 
2.17.1

