Return-Path: <linux-rdma+bounces-12708-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAE0B249A0
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 14:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DAF1AA0F7C
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 12:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604772DE6F3;
	Wed, 13 Aug 2025 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zf/qnoPr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218272C0F83
	for <linux-rdma@vger.kernel.org>; Wed, 13 Aug 2025 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755088884; cv=none; b=cNvZCZX5p3POEnJopd+LDjNkywMD6GJ4Ci16ukiTsoE1I1Mg9fh/TiZoKuTff8gf/LZQAZlyysEYkoM0arsXzn8Ai4x2hB66OfllIaDzvI6khIS0FSq8iulT7lwPam2/krnRtu2Hbq+Cx8e/MfDxaufjiRh1V/WHw5RvMUznOA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755088884; c=relaxed/simple;
	bh=4mLqSmNAHigFA6hhAxFIg0h7rqh4XJ+kd1BeV20nQNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBoB1V147JTgAxDwXSx/OJrob531QfU4/yott8Q8g5kHUw3aI6T1+eHo/JiHUgo4h6nQx/ERHyI3Nok+pWi5QNCpxkTWYaQqpw5ZzQwi0CHhIkZdiYBg9pQ1WY/3KjrsF3jUwzMMACWfnGoPaC99Z+GuTrBbCn52jJj5M9T3/98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zf/qnoPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5DFC4CEEB;
	Wed, 13 Aug 2025 12:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755088883;
	bh=4mLqSmNAHigFA6hhAxFIg0h7rqh4XJ+kd1BeV20nQNk=;
	h=From:To:Cc:Subject:Date:From;
	b=Zf/qnoPrMw57wW2UOX5cDwVPx21KIarVHkIMC4x/BOgTJ8L7bGE/VVq2AbXgcrdAH
	 01dDc7nNd5e2b5R6Ju+juYlJnm1BIUbxXbzETfktS5qER/1OnyUWKu3dbJOBsMRc1V
	 GwrE25Dqyer7x7m2CJ3LehlacSPYNDsnvotPfenHS+vc5fgDnjb1oXHSRJBxTwM0oF
	 3LTRzyn6RzQPzQW7mlM0u959o34Dpwa8CP2nqurLxeZjTVzntLaSvRHmbrq3YJ7ZMg
	 tpsY6BU4Pt9DQ97bub6NTY3TpiGkTN49PYbZXMdVoCJJcqLutN1pXKZZBrQW3odP6H
	 d6UQCIzNnlhCQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Fix vport loopback forcing for MPV device
Date: Wed, 13 Aug 2025 15:41:19 +0300
Message-ID: <cfc6b1f0f99f8100b087483cc14da6025317f901.1755088808.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Previously loopback for MPV was supposed to be permanently enabled,
however other driver flows were able to over-ride that configuration
and disable it.

Add force_lb parameter that indicates that loopback should always be
enabled which prevents all other driver flows from disabling it.

Fixes: a9a9e68954f2 ("RDMA/mlx5: Fix vport loopback for MPV device")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c    | 19 +++++++++++++++----
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index de5339170876..1fbc0351063d 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1839,7 +1839,8 @@ static void deallocate_uars(struct mlx5_ib_dev *dev,
 }
 
 static int mlx5_ib_enable_lb_mp(struct mlx5_core_dev *master,
-				struct mlx5_core_dev *slave)
+				struct mlx5_core_dev *slave,
+				struct mlx5_ib_lb_state *lb_state)
 {
 	int err;
 
@@ -1851,6 +1852,7 @@ static int mlx5_ib_enable_lb_mp(struct mlx5_core_dev *master,
 	if (err)
 		goto out;
 
+	lb_state->force_enable = true;
 	return 0;
 
 out:
@@ -1859,16 +1861,22 @@ static int mlx5_ib_enable_lb_mp(struct mlx5_core_dev *master,
 }
 
 static void mlx5_ib_disable_lb_mp(struct mlx5_core_dev *master,
-				  struct mlx5_core_dev *slave)
+				  struct mlx5_core_dev *slave,
+				  struct mlx5_ib_lb_state *lb_state)
 {
 	mlx5_nic_vport_update_local_lb(slave, false);
 	mlx5_nic_vport_update_local_lb(master, false);
+
+	lb_state->force_enable = false;
 }
 
 int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 {
 	int err = 0;
 
+	if (dev->lb.force_enable)
+		return 0;
+
 	mutex_lock(&dev->lb.mutex);
 	if (td)
 		dev->lb.user_td++;
@@ -1890,6 +1898,9 @@ int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 
 void mlx5_ib_disable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 {
+	if (dev->lb.force_enable)
+		return;
+
 	mutex_lock(&dev->lb.mutex);
 	if (td)
 		dev->lb.user_td--;
@@ -3597,7 +3608,7 @@ static void mlx5_ib_unbind_slave_port(struct mlx5_ib_dev *ibdev,
 
 	lockdep_assert_held(&mlx5_ib_multiport_mutex);
 
-	mlx5_ib_disable_lb_mp(ibdev->mdev, mpi->mdev);
+	mlx5_ib_disable_lb_mp(ibdev->mdev, mpi->mdev, &ibdev->lb);
 
 	mlx5_core_mp_event_replay(ibdev->mdev,
 				  MLX5_DRIVER_EVENT_AFFILIATION_REMOVED,
@@ -3694,7 +3705,7 @@ static bool mlx5_ib_bind_slave_port(struct mlx5_ib_dev *ibdev,
 				  MLX5_DRIVER_EVENT_AFFILIATION_DONE,
 				  &key);
 
-	err = mlx5_ib_enable_lb_mp(ibdev->mdev, mpi->mdev);
+	err = mlx5_ib_enable_lb_mp(ibdev->mdev, mpi->mdev, &ibdev->lb);
 	if (err)
 		goto unbind;
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index a6c83ce2f0ee..4fc2c0ca2af3 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1111,6 +1111,7 @@ struct mlx5_ib_lb_state {
 	u32			user_td;
 	int			qps;
 	bool			enabled;
+	bool			force_enable;
 };
 
 struct mlx5_ib_pf_eq {
-- 
2.50.1


