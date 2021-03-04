Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBB532D37C
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 13:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhCDMqL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 07:46:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231334AbhCDMqJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Mar 2021 07:46:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0E7764F23;
        Thu,  4 Mar 2021 12:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614861929;
        bh=jHiELPzOTdmAgKcmOydvnH2PdDd1Q7vJN+nh55B2NP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kS+X8ei8m8FZMXG8AHYRLrXvnKD2Bo3oZTQ5kuKsqDePY5c6zgnjgHHpsKM5CM5V7
         tGNgXEgSUwGiXB+bUN5JElObyNZLgtWmgKJHmAktv9XmVHFVQYqlKkclD6dpwiiGjf
         pH+JqRz+h+/Bw2T/e8VtHwqpY6oh0WAllibXvseKiEh+BU714oBYypLieyXyQRkiSD
         2id7zcUw+S9ZLesmFjQGgd940jMC1TlXPcgF28zJRS1SzS0r09L/MPbaJbdM6eTx9E
         AlPhbsxmJ6DmdwnDgPOvJ9zDChR3ZtcHu7fdrIyMw9GkyHlHWfwWYy7fMuuQ5txMFo
         Z8HHOxGZ/R3+A==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-next 3/3] RDMA/mlx5: Fix mlx5 rates to IB rates map
Date:   Thu,  4 Mar 2021 14:45:17 +0200
Message-Id: <20210304124517.1100608-4-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304124517.1100608-1-leon@kernel.org>
References: <20210304124517.1100608-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

Correct the map between mlx5 rates and corresponding ib rates, as they
are not always have a fixed offset between them.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 669716425e83..f56f144dbfd2 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3142,6 +3142,19 @@ enum {
 	MLX5_PATH_FLAG_COUNTER	= 1 << 2,
 };

+static int mlx5_to_ib_rate_map(u8 rate)
+{
+	static const int rates[] = { IB_RATE_PORT_CURRENT, IB_RATE_56_GBPS,
+				     IB_RATE_25_GBPS,	   IB_RATE_100_GBPS,
+				     IB_RATE_200_GBPS,	   IB_RATE_50_GBPS,
+				     IB_RATE_400_GBPS };
+
+	if (rate < ARRAY_SIZE(rates))
+		return rates[rate];
+
+	return rate - MLX5_STAT_RATE_OFFSET;
+}
+
 static int ib_to_mlx5_rate_map(u8 rate)
 {
 	switch (rate) {
@@ -4481,7 +4494,7 @@ static void to_rdma_ah_attr(struct mlx5_ib_dev *ibdev,
 	rdma_ah_set_path_bits(ah_attr, MLX5_GET(ads, path, mlid));

 	static_rate = MLX5_GET(ads, path, stat_rate);
-	rdma_ah_set_static_rate(ah_attr, static_rate ? static_rate - 5 : 0);
+	rdma_ah_set_static_rate(ah_attr, mlx5_to_ib_rate_map(static_rate));
 	if (MLX5_GET(ads, path, grh) ||
 	    ah_attr->type == RDMA_AH_ATTR_TYPE_ROCE) {
 		rdma_ah_set_grh(ah_attr, NULL, MLX5_GET(ads, path, flow_label),
--
2.29.2

