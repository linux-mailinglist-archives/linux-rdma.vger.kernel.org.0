Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5681B6425
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 21:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbgDWTDX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 15:03:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgDWTDX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 15:03:23 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5178F20728;
        Thu, 23 Apr 2020 19:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587668603;
        bh=Nnxy2xTWCmLeJLqD5QACKfOrxKdp1qmldgVWxNcNWK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RiPHuC1HQ374clNN8P1NwnmOpUIrLD4Gsj+DsJuALh8vneTHawvVk8/wuZ1ZPuWcy
         Ggp/WeIbK9GsxkTfdF0GWE+pSoHmVULHTF3NhznHaX2+X0OWvz1z0yxVsdmOOmROLX
         tqM/P38HTYJ+3JDHDZrnTy9Muw4VTMetPB5XtgAQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 03/18] RDMA/mlx5: Promote RSS RAW QP attribute check in higher level
Date:   Thu, 23 Apr 2020 22:02:48 +0300
Message-Id: <20200423190303.12856-4-leon@kernel.org>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200423190303.12856-1-leon@kernel.org>
References: <20200423190303.12856-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Perform check of attributes of RAW PACKET QP in separate function.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 6e2f71a48cbb..f7c32dc5cf9c 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1645,9 +1645,6 @@ static int create_rss_raw_qp_tir(struct ib_pd *pd, struct mlx5_ib_qp *qp,
 	size_t required_cmd_sz;
 	u8 lb_flag = 0;
 
-	if (init_attr->send_cq)
-		return -EINVAL;
-
 	min_resp_len = offsetof(typeof(resp), bfreg_index) + sizeof(resp.bfreg_index);
 	if (udata->outlen < min_resp_len)
 		return -EINVAL;
@@ -2693,6 +2690,9 @@ static int check_qp_attr(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 			      -EINVAL :
 			      0;
 		break;
+	case IB_QPT_RAW_PACKET:
+		ret = (attr->rwq_ind_tbl && attr->send_cq) ? -EINVAL : 0;
+		break;
 	default:
 		break;
 	}
-- 
2.25.3

