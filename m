Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76B5137227
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 12:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfFFKyR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 06:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfFFKyR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Jun 2019 06:54:17 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC9C620868;
        Thu,  6 Jun 2019 10:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559818457;
        bh=SDlVeSBYONutuInxvmuxq2Vmp+HHmqmg3Qevxg7LEFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E6STE0CZQTS6VLvz5QEk9wmIdXKeMgNmE7pFa5X/a7PZ+EzZWALZGjdPuvkZ7iKVA
         aRZXf49HfsPyhY8Ugu5NWHfgjlmIU4K0mmHBrqz5SqL5XzZrImz07RFFk+xsJt3dav
         YWCikYF+blObbgpc/wbGz2OGpDykBvecNQfjz0d4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH rdma-next v3 09/17] IB/mlx5: Support statistic q counter configuration
Date:   Thu,  6 Jun 2019 13:53:37 +0300
Message-Id: <20190606105345.8546-10-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606105345.8546-1-leon@kernel.org>
References: <20190606105345.8546-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

Add support for ib callbacks counter_bind_qp() and counter_unbind_qp().

Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 53 +++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 8b7bcf8f68fb..66c94a060718 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -5533,6 +5533,57 @@ static int mlx5_ib_get_hw_stats(struct ib_device *ibdev,
 	return num_counters;
 }
 
+static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
+				   struct ib_qp *qp)
+{
+	struct mlx5_ib_dev *dev = to_mdev(qp->device);
+	u16 cnt_set_id = 0;
+	int err;
+
+	if (!counter->id) {
+		err = mlx5_cmd_alloc_q_counter(dev->mdev,
+					       &cnt_set_id,
+					       MLX5_SHARED_RESOURCE_UID);
+		if (err)
+			return err;
+		counter->id = cnt_set_id;
+	}
+
+	err = mlx5_ib_qp_set_counter(qp, counter);
+	if (err)
+		goto fail_set_counter;
+
+	return 0;
+
+fail_set_counter:
+	mlx5_core_dealloc_q_counter(dev->mdev, cnt_set_id);
+	counter->id = 0;
+
+	return err;
+}
+
+static int mlx5_ib_counter_unbind_qp(struct ib_qp *qp, bool force)
+{
+	struct mlx5_ib_dev *dev = to_mdev(qp->device);
+	struct rdma_counter *counter = qp->counter;
+	int err;
+
+	err = mlx5_ib_qp_set_counter(qp, NULL);
+	if (err && !force)
+		return err;
+
+	/*
+	 * Deallocate the counter if this is the last QP bound on it;
+	 * If @force is set then we still deallocate the q counter
+	 * no matter if there's any error in previous. used for cases
+	 * like qp destroy.
+	 */
+	if (atomic_read(&counter->usecnt) == 1)
+		return mlx5_core_dealloc_q_counter(dev->mdev, counter->id);
+
+	return 0;
+}
+
 static int mlx5_ib_rn_get_params(struct ib_device *device, u8 port_num,
 				 enum rdma_netdev_t type,
 				 struct rdma_netdev_alloc_params *params)
@@ -6452,6 +6503,8 @@ static void mlx5_ib_stage_odp_cleanup(struct mlx5_ib_dev *dev)
 static const struct ib_device_ops mlx5_ib_dev_hw_stats_ops = {
 	.alloc_hw_stats = mlx5_ib_alloc_hw_stats,
 	.get_hw_stats = mlx5_ib_get_hw_stats,
+	.counter_bind_qp = mlx5_ib_counter_bind_qp,
+	.counter_unbind_qp = mlx5_ib_counter_unbind_qp,
 };
 
 static int mlx5_ib_stage_counters_init(struct mlx5_ib_dev *dev)
-- 
2.20.1

