Return-Path: <linux-rdma+bounces-11336-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BB1ADAB9E
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 11:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46725188AE57
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jun 2025 09:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EE0235C17;
	Mon, 16 Jun 2025 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbS2Yt+n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E341CD15
	for <linux-rdma@vger.kernel.org>; Mon, 16 Jun 2025 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750065348; cv=none; b=gsJEWA/BOoOv4HDtPLp3AEmSOb0DqvUnVdo4tQ3A+y3LjrqLi/kDMvTY784v/yn67rjN125H71ugQJ1DY8M9jK9FKWYyWknIE28mG+CMx5aMAugF3yT9ZayuNihzbrZJlENR3CXlp6vlTI89yeAkAl1ZdSdCALIRdq5PkkhhZ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750065348; c=relaxed/simple;
	bh=hnaOUKs/6KykcwFJU2hvhvwvJ3oVvWA0r/qRv7pKDuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S78bCeM+0gMkk/dRuv4t3L+6DOnkwmgRnZsMOA6iJpO95kl9MByis/rYH9xV23+D25Xx9q7Oo9irIxF2BrxifZc/pdIH57hbWdjJ7KcyhqNL9zWAsnbKN4Oe4xNTS0mADaashKbWJ4CO8AEIYe4rMaHO4qHtAYA780u0wSK5u28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbS2Yt+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE0FC4CEEA;
	Mon, 16 Jun 2025 09:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750065348;
	bh=hnaOUKs/6KykcwFJU2hvhvwvJ3oVvWA0r/qRv7pKDuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UbS2Yt+nttMNT1gbh5of2LaKqMVUqVc17fGLzj8ORloaIGwf+NbyNzYvkaUd3uxK5
	 zH3OXEmitytWaFj5+oMT4MEUmEczvX8DRAlM6z6bXoUxjLX2CajpAOMuwLJmojo/Ym
	 Xpwte6p1FpNIpCvCHhqOuPOkcksUQwBRBfjtRKxOd6nGC8gyUDEsRki1UH19FQJkos
	 ESI7Ww8JNSF+4A1dAwXkPWJC5EcK0qsz+Q9MFINieBXlKfmNWOUXqmSkW/sNzKe/kt
	 xpD//EVZCYqVl1AtObGzs7C+xKqcMC6M00I0P0kF26XX0Y5YIw5yC3GT9xB/0gDeFp
	 fVJ2vqBjIW65w==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-rc 3/3] RDMA/mlx5: Fix vport loopback for MPV device
Date: Mon, 16 Jun 2025 12:14:54 +0300
Message-ID: <d4298f5ebb2197459e9e7221c51ecd6a34699847.1750064969.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750064969.git.leon@kernel.org>
References: <cover.1750064969.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Always enable vport loopback for both MPV devices on driver start.

Previously in some cases related to MPV RoCE, packets weren't correctly
executing loopback check at vport in FW, since it was disabled.
Due to complexity of identifying such cases for MPV always enable vport
loopback for both GVMIs when binding the slave to the master port.

Fixes: 0042f9e458a5 ("RDMA/mlx5: Enable vport loopback when user context or QP mandate")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index ce7610740412..df6557ddbdfc 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1791,6 +1791,33 @@ static void deallocate_uars(struct mlx5_ib_dev *dev,
 					     context->devx_uid);
 }
 
+static int mlx5_ib_enable_lb_mp(struct mlx5_core_dev *master,
+				struct mlx5_core_dev *slave)
+{
+	int err;
+
+	err = mlx5_nic_vport_update_local_lb(master, true);
+	if (err)
+		return err;
+
+	err = mlx5_nic_vport_update_local_lb(slave, true);
+	if (err)
+		goto out;
+
+	return 0;
+
+out:
+	mlx5_nic_vport_update_local_lb(master, false);
+	return err;
+}
+
+static void mlx5_ib_disable_lb_mp(struct mlx5_core_dev *master,
+				  struct mlx5_core_dev *slave)
+{
+	mlx5_nic_vport_update_local_lb(slave, false);
+	mlx5_nic_vport_update_local_lb(master, false);
+}
+
 int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 {
 	int err = 0;
@@ -3495,6 +3522,8 @@ static void mlx5_ib_unbind_slave_port(struct mlx5_ib_dev *ibdev,
 
 	lockdep_assert_held(&mlx5_ib_multiport_mutex);
 
+	mlx5_ib_disable_lb_mp(ibdev->mdev, mpi->mdev);
+
 	mlx5_core_mp_event_replay(ibdev->mdev,
 				  MLX5_DRIVER_EVENT_AFFILIATION_REMOVED,
 				  NULL);
@@ -3590,6 +3619,10 @@ static bool mlx5_ib_bind_slave_port(struct mlx5_ib_dev *ibdev,
 				  MLX5_DRIVER_EVENT_AFFILIATION_DONE,
 				  &key);
 
+	err = mlx5_ib_enable_lb_mp(ibdev->mdev, mpi->mdev);
+	if (err)
+		goto unbind;
+
 	return true;
 
 unbind:
-- 
2.49.0


