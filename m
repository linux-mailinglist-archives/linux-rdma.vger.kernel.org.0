Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7BE3964B6
	for <lists+linux-rdma@lfdr.de>; Mon, 31 May 2021 18:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbhEaQIo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 May 2021 12:08:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233532AbhEaQGc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 31 May 2021 12:06:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A01A46135B;
        Mon, 31 May 2021 16:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622477091;
        bh=kCp6aYVcCujGkUJXPmilT6hK0GNRhSCg0OjUQI2yIfs=;
        h=From:To:Cc:Subject:Date:From;
        b=KNMvZrkJ2PavU3B+WRaBIFd4tiuP93GNjhhP9Wwh4KJ7vlDFzvHJ2a4uTy8avCf1x
         Cj9vXucRadATI9pX4KlWAYIwztfjxs8Ho4cAcrzn8veyJd+9PaGJEhWgk8uGEDV5SQ
         BVs9n4MrTDS7tIxMvCIX5t1IDp4KMXLvQjNhQgGWkUicyxXtmszRKXavqn42VZXd3c
         ZhdRSzljcWofnNmIP5gQpExUCAUe7yDu7vsCuN1YCvwvUY0l3A4lZEZTs9P+3k1jBq
         8BxHZy0TSAXCzxEKeulDtLDP7PzQLJxSasN8V2Oscyox3lR8qjr/3OrSI7oAsB65VQ
         4uE6yUI+6Qd1Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Don't add slave port to unaffiliated list
Date:   Mon, 31 May 2021 19:04:44 +0300
Message-Id: <2726e6603b1e6ecfe76aa5a12a063af72173bcf7.1622477058.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The mlx5_ib_bind_slave_port() doesn't remove multiport device from the
unaffiliated list, but mlx5_ib_unbind_slave_port() did it. This unbalanced
flow caused to the situation where mlx5_ib_unaffiliated_port_list was changed
during iteration.

Fixes: 32f69e4be269 ("{net, IB}/mlx5: Manage port association for multiport RoCE")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 9357ed28813c..e541a9f5f163 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3192,8 +3192,6 @@ static void mlx5_ib_unbind_slave_port(struct mlx5_ib_dev *ibdev,
 
 	port->mp.mpi = NULL;
 
-	list_add_tail(&mpi->list, &mlx5_ib_unaffiliated_port_list);
-
 	spin_unlock(&port->mp.mpi_lock);
 
 	err = mlx5_nic_vport_unaffiliate_multiport(mpi->mdev);
@@ -3342,6 +3340,8 @@ static void mlx5_ib_cleanup_multiport_master(struct mlx5_ib_dev *dev)
 				mlx5_ib_dbg(dev, "unbinding port_num: %u\n",
 					    i + 1);
 				mlx5_ib_unbind_slave_port(dev, dev->port[i].mp.mpi);
+				list_add_tail(&dev->port[i].mp.mpi->list,
+					      &mlx5_ib_unaffiliated_port_list);
 			}
 		}
 	}
-- 
2.31.1

