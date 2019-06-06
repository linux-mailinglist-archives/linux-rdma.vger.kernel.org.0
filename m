Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 212F43722A
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 12:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfFFKy2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 06:54:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbfFFKy2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Jun 2019 06:54:28 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A77220874;
        Thu,  6 Jun 2019 10:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559818467;
        bh=cFcl4thWeDyTmat6/H9721ZB9KtkbXfHrWJ4/rQF2Fw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yCss0J2JYAnQKkMievHnJymKZxS/ru154uAFBNQoGEVzYqVPgBlfzy+Qbbrd7wH+P
         ilAaNOksWr3mQLq4MMkihk/Ha+1qyXtcF1qzwFRHrxok1CdQmpeM8qZ9eC5ERCSHFJ
         Wz0VHL/8J8J5enWnITjVZyzxZtmOu0UVgwKkZ+7U=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH rdma-next v3 12/17] IB/mlx5: Add counter_alloc_stats() and counter_update_stats() support
Date:   Thu,  6 Jun 2019 13:53:40 +0300
Message-Id: <20190606105345.8546-13-leon@kernel.org>
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

Add support for ib callback counter_alloc_stats() and
counter_update_stats().

Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 66c94a060718..65fa42c722c3 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -5533,6 +5533,27 @@ static int mlx5_ib_get_hw_stats(struct ib_device *ibdev,
 	return num_counters;
 }
 
+static struct rdma_hw_stats *
+mlx5_ib_counter_alloc_stats(struct rdma_counter *counter)
+{
+	struct mlx5_ib_dev *dev = to_mdev(counter->device);
+	struct mlx5_ib_port *port = &dev->port[counter->port - 1];
+
+	/* Q counters are in the beginning of all counters */
+	return rdma_alloc_hw_stats_struct(port->cnts.names,
+					  port->cnts.num_q_counters,
+					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
+}
+
+static int mlx5_ib_counter_update_stats(struct rdma_counter *counter)
+{
+	struct mlx5_ib_dev *dev = to_mdev(counter->device);
+	struct mlx5_ib_port *port = &dev->port[counter->port - 1];
+
+	return mlx5_ib_query_q_counters(dev->mdev, port,
+					counter->stats, counter->id);
+}
+
 static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
 				   struct ib_qp *qp)
 {
@@ -6505,6 +6526,8 @@ static const struct ib_device_ops mlx5_ib_dev_hw_stats_ops = {
 	.get_hw_stats = mlx5_ib_get_hw_stats,
 	.counter_bind_qp = mlx5_ib_counter_bind_qp,
 	.counter_unbind_qp = mlx5_ib_counter_unbind_qp,
+	.counter_alloc_stats = mlx5_ib_counter_alloc_stats,
+	.counter_update_stats = mlx5_ib_counter_update_stats,
 };
 
 static int mlx5_ib_stage_counters_init(struct mlx5_ib_dev *dev)
-- 
2.20.1

