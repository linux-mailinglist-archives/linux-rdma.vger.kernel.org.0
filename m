Return-Path: <linux-rdma+bounces-6196-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AA89E2402
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 16:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAA82B36348
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 13:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9448D1EF0A9;
	Tue,  3 Dec 2024 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clZVwI/w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518171EE019;
	Tue,  3 Dec 2024 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233544; cv=none; b=Rjyj5a63kmjfSeHb5GfPGXgjuU/s/1KKdmuv//qasrqItbDrLirh7RQUK5wOsEonks6TzyFp8H0y20h8IvHzSE+tSIY1C6U/kGq6r7kJy02QcVXS+glS38QCWeK58/h9VC2ekWo4g3MSLU5ptJF+fCvv74IxY24FFaIgpIEsPXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233544; c=relaxed/simple;
	bh=cErb3bV+SAPedDc/tB1CJu1WvUbR1ZitnEExBcebm5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=inBNY98NOS4oorManOSwuGNnymYzBDpislhPOJVOSivcG4u2RrKA+nDPezSAfWDV5zFYmasf1Mia+limzXzKko/YmdY99QDHvlCNb0o/KSyf6XRvHEG59gxHIZPvDNw73XA/vJU7vT9ARS9BgeC6wJOmIT42BKR1u4GUXPl+Bfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clZVwI/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DBDC4CED8;
	Tue,  3 Dec 2024 13:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733233543;
	bh=cErb3bV+SAPedDc/tB1CJu1WvUbR1ZitnEExBcebm5I=;
	h=From:To:Cc:Subject:Date:From;
	b=clZVwI/w0M9tVPUL2Fh+MVrC/V1CJxMg6uDiUiCNchFKjBCOOvBiCuLkb/XYN8SQG
	 aXRacd9A4GptIovAa0y7LePwyLo1BAzH/UtQd80Nt8n9s53GDosAEsWbL8Xz5iw1YA
	 n9aqhyYhZ+1lYOsXJiYTfrQGnTx5lff0cFe2ws+o7Haj6ulRFd1RIX243OV3pjp5Qf
	 KBK4tzroFlS0Ihzq7lHN9QP4erkrH3vVALzzRHNSbBOVhBIK6G5JdWcB/9bBIWnEl2
	 wj6zIo/Gn9lKSGpHPFSdyVO1uUnTPo/YUwoE67TivDZoZRuU2RAXxhKktwlSi89a0c
	 TCEbuVZr8cPmg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	Daniel Jurgens <danielj@mellanox.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Parav Pandit <parav@mellanox.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next] RDMA/mlx5: Enforce same type port association for multiport RoCE
Date: Tue,  3 Dec 2024 15:45:37 +0200
Message-ID: <88699500f690dff1c1852c1ddb71f8a1cc8b956e.1733233480.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Different core device types such as PFs and VFs shouldn't be affiliated
together since they have different capabilities, fix that by enforcing
type check before doing the affiliation.

Fixes: 32f69e4be269 ("{net, IB}/mlx5: Manage port association for multiport RoCE")
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 6 ++++--
 include/linux/mlx5/driver.h       | 6 ++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index bc7930d0c564..c2314797afc9 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3639,7 +3639,8 @@ static int mlx5_ib_init_multiport_master(struct mlx5_ib_dev *dev)
 		list_for_each_entry(mpi, &mlx5_ib_unaffiliated_port_list,
 				    list) {
 			if (dev->sys_image_guid == mpi->sys_image_guid &&
-			    (mlx5_core_native_port_num(mpi->mdev) - 1) == i) {
+			    (mlx5_core_native_port_num(mpi->mdev) - 1) == i &&
+			    mlx5_core_same_coredev_type(dev->mdev, mpi->mdev)) {
 				bound = mlx5_ib_bind_slave_port(dev, mpi);
 			}
 
@@ -4785,7 +4786,8 @@ static int mlx5r_mp_probe(struct auxiliary_device *adev,
 
 	mutex_lock(&mlx5_ib_multiport_mutex);
 	list_for_each_entry(dev, &mlx5_ib_dev_list, ib_dev_list) {
-		if (dev->sys_image_guid == mpi->sys_image_guid)
+		if (dev->sys_image_guid == mpi->sys_image_guid &&
+		    mlx5_core_same_coredev_type(dev->mdev, mpi->mdev))
 			bound = mlx5_ib_bind_slave_port(dev, mpi);
 
 		if (bound) {
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index fc7e6153b73d..4f9e6f6dbaab 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1202,6 +1202,12 @@ static inline bool mlx5_core_is_vf(const struct mlx5_core_dev *dev)
 	return dev->coredev_type == MLX5_COREDEV_VF;
 }
 
+static inline bool mlx5_core_same_coredev_type(const struct mlx5_core_dev *dev1,
+					       const struct mlx5_core_dev *dev2)
+{
+	return dev1->coredev_type == dev2->coredev_type;
+}
+
 static inline bool mlx5_core_is_ecpf(const struct mlx5_core_dev *dev)
 {
 	return dev->caps.embedded_cpu;
-- 
2.47.0


