Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF444B34E0
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 08:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbfIPGs3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 02:48:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfIPGs2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Sep 2019 02:48:28 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F9F42067B;
        Mon, 16 Sep 2019 06:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568616508;
        bh=CejFUJlxbN+gHlCt2f1OuAzwLwMMSUIzAemf6lYSuiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xqITfbwbFKWS3k3sjn0lk9lAG/o8uaRA4QUlfAbqQUzQNNJr8AIYlwHC/VAuSl/+/
         oX9y3LNCQKZ2JgWZEe54UAyJm85KnGHGt6pIUo28ubbK6NsxBRFyMUU96DOk46/ZL8
         FsY3T+/e80fOE87o9kCB/DDF+REIOoF7hk0opc+Y=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Danit Goldberg <danitg@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH 1/2] IB/mlx5: Free page from the beginning of the allocation
Date:   Mon, 16 Sep 2019 09:48:17 +0300
Message-Id: <20190916064818.19823-2-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916064818.19823-1-leon@kernel.org>
References: <20190916064818.19823-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Danit Goldberg <danitg@mellanox.com>

After the allocation of a page for wqe pointer, the pointer is
shifted. Therefore it is necessary to keep the original address, and
free it at the end.

Fixes: 0f51427bd097 ("RDMA/mlx5: Cleanup WQE page fault handler")
Signed-off-by: Danit Goldberg <danitg@mellanox.com>
Reviewed-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 0a59912a4cef..416e750808eb 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1205,7 +1205,7 @@ static void mlx5_ib_mr_wqe_pfault_handler(struct mlx5_ib_dev *dev,
 {
 	bool sq = pfault->type & MLX5_PFAULT_REQUESTOR;
 	u16 wqe_index = pfault->wqe.wqe_index;
-	void *wqe = NULL, *wqe_end = NULL;
+	void *wqe, *wqe_start = NULL, *wqe_end = NULL;
 	u32 bytes_mapped, total_wqe_bytes;
 	struct mlx5_core_rsc_common *res;
 	int resume_with_error = 1;
@@ -1226,12 +1226,13 @@ static void mlx5_ib_mr_wqe_pfault_handler(struct mlx5_ib_dev *dev,
 		goto resolve_page_fault;
 	}

-	wqe = (void *)__get_free_page(GFP_KERNEL);
-	if (!wqe) {
+	wqe_start = (void *)__get_free_page(GFP_KERNEL);
+	if (!wqe_start) {
 		mlx5_ib_err(dev, "Error allocating memory for IO page fault handling.\n");
 		goto resolve_page_fault;
 	}

+	wqe = wqe_start;
 	qp = (res->res == MLX5_RES_QP) ? res_to_qp(res) : NULL;
 	if (qp && sq) {
 		ret = mlx5_ib_read_user_wqe_sq(qp, wqe_index, wqe, PAGE_SIZE,
@@ -1286,7 +1287,7 @@ static void mlx5_ib_mr_wqe_pfault_handler(struct mlx5_ib_dev *dev,
 		    pfault->wqe.wq_num, resume_with_error,
 		    pfault->type);
 	mlx5_core_res_put(res);
-	free_page((unsigned long)wqe);
+	free_page((unsigned long)wqe_start);
 }

 static int pages_in_range(u64 address, u32 length)
--
2.20.1

