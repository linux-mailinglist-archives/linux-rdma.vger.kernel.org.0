Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD3E4B34E2
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 08:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfIPGsc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Sep 2019 02:48:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfIPGsb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Sep 2019 02:48:31 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E01CF20890;
        Mon, 16 Sep 2019 06:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568616511;
        bh=qjavJG0clGn/ep2R+HjCfih45FUkK2h7e204CKMOeRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=duGS/M2EtKD+InlYZ6iCNSXLWL5pua+KT94o3eY1gXffwVVoO/eyR67+yUHmSWFz5
         tcnXcRBkddA5FKlWu/3ZZrNFv/lkFW9yYaVF2AdbS4hlRwvWjWxod3jcFIh8FpVpLi
         pYvsk6NxEXlVqIRH+3HCYRPCgojmveC81BEkcVW0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Danit Goldberg <danitg@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH 2/2] IB/mlx5: Free mpi in mp_slave mode
Date:   Mon, 16 Sep 2019 09:48:18 +0300
Message-Id: <20190916064818.19823-3-leon@kernel.org>
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

ib_add_slave_port() allocates a multiport struct but never frees it.
Don't leak memory, free the allocated mpi struct during driver unload.

Fixes: 32f69e4be269 ("{net, IB}/mlx5: Manage port association for multiport RoCE")
Signed-off-by: Danit Goldberg <danitg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 0569bcab02d4..14807ea8dc3f 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6959,6 +6959,7 @@ static void mlx5_ib_remove(struct mlx5_core_dev *mdev, void *context)
 			mlx5_ib_unbind_slave_port(mpi->ibdev, mpi);
 		list_del(&mpi->list);
 		mutex_unlock(&mlx5_ib_multiport_mutex);
+		kfree(mpi);
 		return;
 	}

--
2.20.1

