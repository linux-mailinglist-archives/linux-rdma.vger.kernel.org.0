Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27D71FF073
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2020 13:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgFRLZU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jun 2020 07:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbgFRLZS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Jun 2020 07:25:18 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A22E20663;
        Thu, 18 Jun 2020 11:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592479517;
        bh=tCDTu2P1wn6W8lV3v0IlQX0mONxE1iRUsFx1GiNZCpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZ7e//Wpmus5ZcJFnI3rMlLZtFfkK0Vmls9GPbqBi7ahpd91LFpjHQAK9UZjX+Qmy
         d+PifOfkJMvi4lCeuIONax0EeYTnKMgRLGEscx5+CTk7oNQvXtxsjC0UAKwv4SZUNx
         Ax9y+0X3Gk3Zvv3+ZyhR/tYF1G8jCPdZHH7M+gmk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-rc 1/2] RDMA/mlx5: Remove ECE limitation from the RAW_PACKET QPs
Date:   Thu, 18 Jun 2020 14:25:06 +0300
Message-Id: <20200618112507.3453496-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200618112507.3453496-1-leon@kernel.org>
References: <20200618112507.3453496-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Like any other QP type, rely on FW for the RAW_PACKET QPs to decide
if ECE is supported or not. This fixes an inability to create RAW_PACKET
QPs with latest rdma-core with the ECE support.

Fixes: e383085c2425 ("RDMA/mlx5: Set ECE options during QP create")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index dbe82cdb8d2c..0e42c50373d9 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -2873,7 +2873,6 @@ static int mlx5_ib_destroy_dct(struct mlx5_ib_qp *mqp)
 static int check_ucmd_data(struct mlx5_ib_dev *dev,
 			   struct mlx5_create_qp_params *params)
 {
-	struct ib_qp_init_attr *attr = params->attr;
 	struct ib_udata *udata = params->udata;
 	size_t size, last;
 	int ret;
@@ -2885,14 +2884,7 @@ static int check_ucmd_data(struct mlx5_ib_dev *dev,
 		 */
 		last = sizeof(struct mlx5_ib_create_qp_rss);
 	else
-		/* IB_QPT_RAW_PACKET doesn't have ECE data */
-		switch (attr->qp_type) {
-		case IB_QPT_RAW_PACKET:
-			last = offsetof(struct mlx5_ib_create_qp, ece_options);
-			break;
-		default:
-			last = offsetof(struct mlx5_ib_create_qp, reserved);
-		}
+		last = offsetof(struct mlx5_ib_create_qp, reserved);
 
 	if (udata->inlen <= last)
 		return 0;
-- 
2.26.2

