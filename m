Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8FA189C2D
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 13:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgCRMnp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 08:43:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgCRMno (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 08:43:44 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A92320768;
        Wed, 18 Mar 2020 12:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584535424;
        bh=PHZ0f5kOJyCEO2otrssBy3lVfkvEANMRhxKDJqmYQMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VyaEHT9WdEuMNrASr5daEy0YfwkY/QF6C9XuqMgCyPx1AdRiDDrd7gsV/T1GgX4pO
         BmiEO7GX5Ey8NwiRFyLkbMXDrMXe9PewDvrnn2I1b+KXCb2g7ZeNT2WghDWRCrBrjz
         9xGpo8NKc2M7hmCt9cVnJ3Z2as62NICfkbtk7eLk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@mellanox.com>
Subject: [PATCH rdma-next 2/4] IB/mlx5: Extend CQ creation to get uar page index from user space
Date:   Wed, 18 Mar 2020 14:43:27 +0200
Message-Id: <20200318124329.52111-3-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318124329.52111-1-leon@kernel.org>
References: <20200318124329.52111-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Extend CQ creation to get uar page index from user space, this mode can
be used with the UAR dynamic mode APIs to allocate/destroy a UAR object.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Reviewed-by: Michael Guralnik <michaelgur@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/cq.c | 17 +++++++++++------
 include/uapi/rdma/mlx5-abi.h    |  4 ++++
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index 3dec3de903b7..eafedc2f697b 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -715,17 +715,19 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	struct mlx5_ib_ucontext *context = rdma_udata_to_drv_context(
 		udata, struct mlx5_ib_ucontext, ibucontext);
 
-	ucmdlen = udata->inlen < sizeof(ucmd) ?
-		  (sizeof(ucmd) - sizeof(ucmd.flags)) : sizeof(ucmd);
+	ucmdlen = min(udata->inlen, sizeof(ucmd));
+	if (ucmdlen < offsetof(struct mlx5_ib_create_cq, flags))
+		return -EINVAL;
 
 	if (ib_copy_from_udata(&ucmd, udata, ucmdlen))
 		return -EFAULT;
 
-	if (ucmdlen == sizeof(ucmd) &&
-	    (ucmd.flags & ~(MLX5_IB_CREATE_CQ_FLAGS_CQE_128B_PAD)))
+	if ((ucmd.flags & ~(MLX5_IB_CREATE_CQ_FLAGS_CQE_128B_PAD |
+			    MLX5_IB_CREATE_CQ_FLAGS_UAR_PAGE_INDEX)))
 		return -EINVAL;
 
-	if (ucmd.cqe_size != 64 && ucmd.cqe_size != 128)
+	if ((ucmd.cqe_size != 64 && ucmd.cqe_size != 128) ||
+	    ucmd.reserved0 || ucmd.reserved1)
 		return -EINVAL;
 
 	*cqe_size = ucmd.cqe_size;
@@ -762,7 +764,10 @@ static int create_cq_user(struct mlx5_ib_dev *dev, struct ib_udata *udata,
 	MLX5_SET(cqc, cqc, log_page_size,
 		 page_shift - MLX5_ADAPTER_PAGE_SHIFT);
 
-	*index = context->bfregi.sys_pages[0];
+	if (ucmd.flags & MLX5_IB_CREATE_CQ_FLAGS_UAR_PAGE_INDEX)
+		*index = ucmd.uar_page_index;
+	else
+		*index = context->bfregi.sys_pages[0];
 
 	if (ucmd.cqe_comp_en == 1) {
 		int mini_cqe_format;
diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
index 624f5b53eb1f..e900f9a64feb 100644
--- a/include/uapi/rdma/mlx5-abi.h
+++ b/include/uapi/rdma/mlx5-abi.h
@@ -266,6 +266,7 @@ struct mlx5_ib_query_device_resp {
 
 enum mlx5_ib_create_cq_flags {
 	MLX5_IB_CREATE_CQ_FLAGS_CQE_128B_PAD	= 1 << 0,
+	MLX5_IB_CREATE_CQ_FLAGS_UAR_PAGE_INDEX  = 1 << 1,
 };
 
 struct mlx5_ib_create_cq {
@@ -275,6 +276,9 @@ struct mlx5_ib_create_cq {
 	__u8    cqe_comp_en;
 	__u8    cqe_comp_res_format;
 	__u16	flags;
+	__u16	uar_page_index;
+	__u16	reserved0;
+	__u32	reserved1;
 };
 
 struct mlx5_ib_create_cq_resp {
-- 
2.24.1

