Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF1477122E
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 08:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbfGWG54 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 02:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729469AbfGWG5z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 02:57:55 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57B622190F;
        Tue, 23 Jul 2019 06:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563865075;
        bh=0p2AqdLl6OvvOvbQgtVfx1SfsmfUtWSjWx9s/FRzTIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fG28k9EUlArObbWJLrEsQTfmcBU9aSlPUUd1FUBreYfJPqwHVxWT/2dJjDmGoxVux
         9E54Vglpg0UJO3Z/Okz0H82T4AZvTMRKLE+t3Z7tFWwVcb+MMPZ3+98wUxlpAqYJSu
         d42EnAHJBYEqd5LFbGBheoqX4/VrhzgiZ7zlP6rM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Alex Vainman <alexv@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Eli Cohen <eli@mellanox.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagig@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc 06/10] IB/mlx5: Fix RSS Toeplitz function to be specification aligned
Date:   Tue, 23 Jul 2019 09:57:29 +0300
Message-Id: <20190723065733.4899-7-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723065733.4899-1-leon@kernel.org>
References: <20190723065733.4899-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

The specification for the Toeplitz function doesn't mention to set the
key explicitly to be symmetric. In case a symmetric functionality is
required a symmetric key can be simply used.

Fix the code accordingly.

Cc: <stable@vger.kernel.org> # 4.7
Fixes: 28d6137008b2aa ("IB/mlx5: Add RSS QP support")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Reviewed-by: Alex Vainman <alexv@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 615cc6771516..379328b2598f 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1713,7 +1713,6 @@ static int create_rss_raw_qp_tir(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 		}

 		MLX5_SET(tirc, tirc, rx_hash_fn, MLX5_RX_HASH_FN_TOEPLITZ);
-		MLX5_SET(tirc, tirc, rx_hash_symmetric, 1);
 		memcpy(rss_key, ucmd.rx_hash_key, len);
 		break;
 	}
--
2.20.1

