Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC7B8190571
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2020 07:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgCXGCR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Mar 2020 02:02:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbgCXGCQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Mar 2020 02:02:16 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B19C2073E;
        Tue, 24 Mar 2020 06:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585029736;
        bh=dLKCtGzxYEYdFUcghJHu12iLqjWPv/+g3eRldLAEsg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sz+xcMxbmZ4LJ6aqYxRllQtvCtXGWiYz2O92VbpLO96ITF1IXBJfJfykmVJaKZqNx
         At0lcAs6IFwrId3XTsFBd3aZvlF8r+5aL45Qk9qjl2JOVXezcCqJe65EPwE0scuCAv
         ru1fzPTKf/VG3CIGolq9qicWNcSbO80lPlOpRUnc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@mellanox.com>
Subject: [PATCH rdma-next v1 5/5] IB/mlx5: Move to fully dynamic UAR mode once user space supports it
Date:   Tue, 24 Mar 2020 08:01:43 +0200
Message-Id: <20200324060143.1569116-6-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200324060143.1569116-1-leon@kernel.org>
References: <20200324060143.1569116-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Move to fully dynamic UAR mode once user space supports it.
In this case we prevent any legacy mode of UARs on the allocated context
and prevent redundant allocation of the static ones.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Reviewed-by: Michael Guralnik <michaelgur@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/cq.c      |  8 ++++++--
 drivers/infiniband/hw/mlx5/main.c    | 13 ++++++++++++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
 drivers/infiniband/hw/mlx5/qp.c      |  6 ++++++
 include/uapi/rdma/mlx5-abi.h         |  1 +
 5 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index eafedc2f697b..146ba2966744 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -764,10 +764,14 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	MLX5_SET(cqc, cqc, log_page_size,
 		 page_shift - MLX5_ADAPTER_PAGE_SHIFT);
 
-	if (ucmd.flags & MLX5_IB_CREATE_CQ_FLAGS_UAR_PAGE_INDEX)
+	if (ucmd.flags & MLX5_IB_CREATE_CQ_FLAGS_UAR_PAGE_INDEX) {
 		*index = ucmd.uar_page_index;
-	else
+	} else if (context->bfregi.lib_uar_dyn) {
+		err = -EINVAL;
+		goto err_cqb;
+	} else {
 		*index = context->bfregi.sys_pages[0];
+	}
 
 	if (ucmd.cqe_comp_en == 1) {
 		int mini_cqe_format;
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index e8787af2d74d..e355e06bf3ac 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1787,6 +1787,7 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 				     max_cqe_version);
 	u32 dump_fill_mkey;
 	bool lib_uar_4k;
+	bool lib_uar_dyn;
 
 	if (!dev->ib_active)
 		return -EAGAIN;
@@ -1845,8 +1846,14 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	}
 
 	lib_uar_4k = req.lib_caps & MLX5_LIB_CAP_4K_UAR;
+	lib_uar_dyn = req.lib_caps & MLX5_LIB_CAP_DYN_UAR;
 	bfregi = &context->bfregi;
 
+	if (lib_uar_dyn) {
+		bfregi->lib_uar_dyn = lib_uar_dyn;
+		goto uar_done;
+	}
+
 	/* updates req->total_num_bfregs */
 	err = calc_total_bfregs(dev, lib_uar_4k, &req, bfregi);
 	if (err)
@@ -1873,6 +1880,7 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	if (err)
 		goto out_sys_pages;
 
+uar_done:
 	if (req.flags & MLX5_IB_ALLOC_UCTX_DEVX) {
 		err = mlx5_ib_devx_create(dev, true);
 		if (err < 0)
@@ -1894,7 +1902,7 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	INIT_LIST_HEAD(&context->db_page_list);
 	mutex_init(&context->db_page_mutex);
 
-	resp.tot_bfregs = req.total_num_bfregs;
+	resp.tot_bfregs = lib_uar_dyn ? 0 : req.total_num_bfregs;
 	resp.num_ports = dev->num_ports;
 
 	if (offsetofend(typeof(resp), cqe_version) <= udata->outlen)
@@ -2142,6 +2150,9 @@ static int uar_mmap(struct mlx5_ib_dev *dev, enum mlx5_ib_mmap_cmd cmd,
 	int max_valid_idx = dyn_uar ? bfregi->num_sys_pages :
 				bfregi->num_static_sys_pages;
 
+	if (bfregi->lib_uar_dyn)
+		return -EINVAL;
+
 	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
 		return -EINVAL;
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index e26ba6c390ad..1a2e3cf0625e 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -139,6 +139,7 @@ struct mlx5_bfreg_info {
 	struct mutex lock;
 	u32 ver;
 	u8 lib_uar_4k : 1;
+	u8 lib_uar_dyn : 1;
 	u32 num_sys_pages;
 	u32 num_static_sys_pages;
 	u32 total_num_bfregs;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 3acdc31d75d3..875ec47a5f4f 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -697,6 +697,9 @@ static int alloc_bfreg(struct mlx5_ib_dev *dev,
 {
 	int bfregn = -ENOMEM;
 
+	if (bfregi->lib_uar_dyn)
+		return -EINVAL;
+
 	mutex_lock(&bfregi->lock);
 	if (bfregi->ver >= 2) {
 		bfregn = alloc_high_class_bfreg(dev, bfregi);
@@ -768,6 +771,9 @@ int bfregn_to_uar_index(struct mlx5_ib_dev *dev,
 	u32 index_of_sys_page;
 	u32 offset;
 
+	if (bfregi->lib_uar_dyn)
+		return -EINVAL;
+
 	bfregs_per_sys_page = get_uars_per_sys_page(dev, bfregi->lib_uar_4k) *
 				MLX5_NON_FP_BFREGS_PER_UAR;
 	index_of_sys_page = bfregn / bfregs_per_sys_page;
diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
index a65d60b44829..df1cc3641bda 100644
--- a/include/uapi/rdma/mlx5-abi.h
+++ b/include/uapi/rdma/mlx5-abi.h
@@ -79,6 +79,7 @@ struct mlx5_ib_alloc_ucontext_req {
 
 enum mlx5_lib_caps {
 	MLX5_LIB_CAP_4K_UAR	= (__u64)1 << 0,
+	MLX5_LIB_CAP_DYN_UAR	= (__u64)1 << 1,
 };
 
 enum mlx5_ib_alloc_uctx_v2_flags {
-- 
2.24.1

