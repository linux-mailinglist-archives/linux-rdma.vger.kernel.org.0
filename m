Return-Path: <linux-rdma+bounces-7626-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5BBA2EB29
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 12:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 958D27A445F
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 11:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09811957FF;
	Mon, 10 Feb 2025 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USebTi4h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEF8158538
	for <linux-rdma@vger.kernel.org>; Mon, 10 Feb 2025 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739187171; cv=none; b=lXsDuOyz0dcaJ7A/8uxwpzFeD9HgFEb5YXOImhgJ2G5fbVH77NNyeRObBFj66bKyjGXsHpvkcVuakliijJYdcUH68J2lfytZaOCw3JIGW/Ic+I5DGoTBZNb6krWRbpxwoHO2KrF3cgLpjZSJh6owLS90/DuJMoDOpKHMS0ZRNXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739187171; c=relaxed/simple;
	bh=Q6sr3qmH3DVJ0Ivs5AodKQaq7twPqQLCyqbpAcZwQPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kB2NyyitTc4c4aEOLIokyk97FzanH0tkNFBOCtlyV8ER4kT9SrxvhFQlh0onRziVw1oshz+5hstZvku/BjqZlEiZiF3t1/Rd8xxFCbEUpb+eo7JdLrCKo96cN3UkmcYtZliAlImxIuBxUmiA9vinbDg20nRcCV+935xWqYGQps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USebTi4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F94FC4CED1;
	Mon, 10 Feb 2025 11:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739187170;
	bh=Q6sr3qmH3DVJ0Ivs5AodKQaq7twPqQLCyqbpAcZwQPk=;
	h=From:To:Cc:Subject:Date:From;
	b=USebTi4hp8zEm+Bggdw72Z81KAE3B1EyfItLvviyvc/xGMWyZ/vW7ma59XqhBm7S8
	 F6EpL4p57zI9MDS5DZ0bF71Mc3odL+ddDL3mU5yHCvMveunK4844YCHoFZL5N+ZFOU
	 BqdELAjs12Q8CqlGS8r/aI9eHFwzFnF79cO+c8d42LOPgV9oFSN9qEtFxNhPbif8T6
	 Tn0SmMvzZPf7ujaaId4wdjZjsrENV0MFQ7LfCR5VYX/NcALQnNmI4RCxLTlGJTnIxd
	 jDhL6kBLqfhhVtoRPgw5KHiMA8RtHlQN80NWxHWpAC4lD73+f5GWJmD/aEznXy8JwY
	 HRZ/XrJR5LfAg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-rc] RDMA/mlx5: Fix AH static rate parsing
Date: Mon, 10 Feb 2025 13:32:39 +0200
Message-ID: <18ef4cc5396caf80728341eb74738cd777596f60.1739187089.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Previously static rate wasn't translated according to our PRM but simply
used the 4 lower bytes.

Correctly translate static rate value passed in AH creation attribute
according to our PRM expected values.

In addition change 800GB mapping to zero, which is the PRM
specified value.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/ah.c | 3 ++-
 drivers/infiniband/hw/mlx5/qp.c | 6 +++---
 drivers/infiniband/hw/mlx5/qp.h | 1 +
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/ah.c b/drivers/infiniband/hw/mlx5/ah.c
index 505bc47fd575..99036afb3aef 100644
--- a/drivers/infiniband/hw/mlx5/ah.c
+++ b/drivers/infiniband/hw/mlx5/ah.c
@@ -67,7 +67,8 @@ static void create_ib_ah(struct mlx5_ib_dev *dev, struct mlx5_ib_ah *ah,
 		ah->av.tclass = grh->traffic_class;
 	}
 
-	ah->av.stat_rate_sl = (rdma_ah_get_static_rate(ah_attr) << 4);
+	ah->av.stat_rate_sl =
+		(mlx5r_ib_rate(dev, rdma_ah_get_static_rate(ah_attr)) << 4);
 
 	if (ah_attr->type == RDMA_AH_ATTR_TYPE_ROCE) {
 		if (init_attr->xmit_slave)
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index d0d877e1b499..1356f8fcd507 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3449,11 +3449,11 @@ static int ib_to_mlx5_rate_map(u8 rate)
 	return 0;
 }
 
-static int ib_rate_to_mlx5(struct mlx5_ib_dev *dev, u8 rate)
+int mlx5r_ib_rate(struct mlx5_ib_dev *dev, u8 rate)
 {
 	u32 stat_rate_support;
 
-	if (rate == IB_RATE_PORT_CURRENT)
+	if (rate == IB_RATE_PORT_CURRENT || rate == IB_RATE_800_GBPS)
 		return 0;
 
 	if (rate < IB_RATE_2_5_GBPS || rate > IB_RATE_800_GBPS)
@@ -3598,7 +3598,7 @@ static int mlx5_set_path(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 		       sizeof(grh->dgid.raw));
 	}
 
-	err = ib_rate_to_mlx5(dev, rdma_ah_get_static_rate(ah));
+	err = mlx5r_ib_rate(dev, rdma_ah_get_static_rate(ah));
 	if (err < 0)
 		return err;
 	MLX5_SET(ads, path, stat_rate, err);
diff --git a/drivers/infiniband/hw/mlx5/qp.h b/drivers/infiniband/hw/mlx5/qp.h
index b6ee7c3ee1ca..2530e7730635 100644
--- a/drivers/infiniband/hw/mlx5/qp.h
+++ b/drivers/infiniband/hw/mlx5/qp.h
@@ -56,4 +56,5 @@ int mlx5_core_xrcd_dealloc(struct mlx5_ib_dev *dev, u32 xrcdn);
 int mlx5_ib_qp_set_counter(struct ib_qp *qp, struct rdma_counter *counter);
 int mlx5_ib_qp_event_init(void);
 void mlx5_ib_qp_event_cleanup(void);
+int mlx5r_ib_rate(struct mlx5_ib_dev *dev, u8 rate);
 #endif /* _MLX5_IB_QP_H */
-- 
2.48.1


