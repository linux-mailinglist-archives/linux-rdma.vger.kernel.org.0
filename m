Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73EF637226
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 12:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfFFKyO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 06:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfFFKyO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Jun 2019 06:54:14 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 562F3206E0;
        Thu,  6 Jun 2019 10:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559818454;
        bh=PIU3NWwOlgIDF1ALlJMGH1PjMbhgVedvjKmYuD7i7e4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/wLz4IT/NdxeEwp1BHD4PGDYVmTWTyiOSdkLyDymFfpkoDF36DXstyBcxoF6EGlZ
         bAT6x/N443kD5aIr3VO/Z87WCK1hX5XAeiFsVCQQxdtevQ56CqKkHsw79M60ltY+5x
         L3u3GnhsfxzuCVlN8J+WfTOA6zyw60qdeD+7OOa8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH rdma-next v3 08/17] IB/mlx5: Add counter set id as a parameter for mlx5_ib_query_q_counters()
Date:   Thu,  6 Jun 2019 13:53:36 +0300
Message-Id: <20190606105345.8546-9-leon@kernel.org>
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

Add counter set id as a parameter so that this API can be used for
querying any q counter.

Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index abac70ad5c7c..8b7bcf8f68fb 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -5424,7 +5424,8 @@ static struct rdma_hw_stats *mlx5_ib_alloc_hw_stats(struct ib_device *ibdev,
 
 static int mlx5_ib_query_q_counters(struct mlx5_core_dev *mdev,
 				    struct mlx5_ib_port *port,
-				    struct rdma_hw_stats *stats)
+				    struct rdma_hw_stats *stats,
+				    u16 set_id)
 {
 	int outlen = MLX5_ST_SZ_BYTES(query_q_counter_out);
 	void *out;
@@ -5435,9 +5436,7 @@ static int mlx5_ib_query_q_counters(struct mlx5_core_dev *mdev,
 	if (!out)
 		return -ENOMEM;
 
-	ret = mlx5_core_query_q_counter(mdev,
-					port->cnts.set_id, 0,
-					out, outlen);
+	ret = mlx5_core_query_q_counter(mdev, set_id, 0, out, outlen);
 	if (ret)
 		goto free;
 
@@ -5497,7 +5496,8 @@ static int mlx5_ib_get_hw_stats(struct ib_device *ibdev,
 		       port->cnts.num_ext_ppcnt_counters;
 
 	/* q_counters are per IB device, query the master mdev */
-	ret = mlx5_ib_query_q_counters(dev->mdev, port, stats);
+	ret = mlx5_ib_query_q_counters(dev->mdev, port, stats,
+				       port->cnts.set_id);
 	if (ret)
 		return ret;
 
-- 
2.20.1

