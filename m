Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A8E1B6423
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 21:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbgDWTDO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Apr 2020 15:03:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgDWTDO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Apr 2020 15:03:14 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B35620728;
        Thu, 23 Apr 2020 19:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587668594;
        bh=FIXUVzDOEzuBDsv87sFrIixoMQ+XVNv6wPHEHpoS/DI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fqAVCpGF79VG5UB4vIduM3jWpDqWLx6d++w0B8g7UwQ4yzAegLZNCmzLfpRg0gvFJ
         iKvERNvFBp8KOScK5Q4JKm1ltlf2RglhSDFLLXPETBrFJxvwsO16/YuH9wGRvC4yVg
         zD2URtjT+iUcFvLvGrpKHNAQQbQS6zDn/4hxt7w8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 01/18] RDMA/mlx5: Delete unsupported QP types
Date:   Thu, 23 Apr 2020 22:02:46 +0300
Message-Id: <20200423190303.12856-2-leon@kernel.org>
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

There is no need to explicitly check unsupported QP types,
rely on  "default" keyword in switch-case to catch them.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 452683776445..04206b9c2c48 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -760,10 +760,7 @@ static int to_mlx5_st(enum ib_qp_type type)
 	case IB_QPT_SMI:		return MLX5_QP_ST_QP0;
 	case MLX5_IB_QPT_HW_GSI:	return MLX5_QP_ST_QP1;
 	case MLX5_IB_QPT_DCI:		return MLX5_QP_ST_DCI;
-	case IB_QPT_RAW_IPV6:		return MLX5_QP_ST_RAW_IPV6;
-	case IB_QPT_RAW_PACKET:
-	case IB_QPT_RAW_ETHERTYPE:	return MLX5_QP_ST_RAW_ETHERTYPE;
-	case IB_QPT_MAX:
+	case IB_QPT_RAW_PACKET:		return MLX5_QP_ST_RAW_ETHERTYPE;
 	default:		return -EINVAL;
 	}
 }
@@ -2282,14 +2279,10 @@ static void get_cqs(enum ib_qp_type qp_type,
 	case IB_QPT_RC:
 	case IB_QPT_UC:
 	case IB_QPT_UD:
-	case IB_QPT_RAW_IPV6:
-	case IB_QPT_RAW_ETHERTYPE:
 	case IB_QPT_RAW_PACKET:
 		*send_cq = ib_send_cq ? to_mcq(ib_send_cq) : NULL;
 		*recv_cq = ib_recv_cq ? to_mcq(ib_recv_cq) : NULL;
 		break;
-
-	case IB_QPT_MAX:
 	default:
 		*send_cq = NULL;
 		*recv_cq = NULL;
@@ -2434,9 +2427,6 @@ static int check_qp_type(struct mlx5_ib_dev *dev, struct ib_qp_init_attr *attr)
 	case IB_QPT_DRIVER:
 	case IB_QPT_GSI:
 		return 0;
-	case IB_QPT_RAW_IPV6:
-	case IB_QPT_RAW_ETHERTYPE:
-	case IB_QPT_MAX:
 	default:
 		goto out;
 	}
-- 
2.25.3

