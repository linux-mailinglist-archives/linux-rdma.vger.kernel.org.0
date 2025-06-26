Return-Path: <linux-rdma+bounces-11673-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06C2AE9D2F
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 14:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03EAF16447A
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 12:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FC9E55B;
	Thu, 26 Jun 2025 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+hRQuMf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B442F1FEC
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939589; cv=none; b=OcG1QcFsGotVahvYpHJ5gSXkGA0W/O1biJvrd632T7hRhB4YigdSnGugJeTYGEgxhmXEsTol1eI1DTC4riQFbuv6bhOahRCi7e+3umkEUiaO2G5J1m39IwSKGqnr0oZna4Kjuk+L9trqEruws4oGINZQ+Bz7kwkxzOKzZsPrOvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939589; c=relaxed/simple;
	bh=FmUVXHOy/7uFflW8v86PWaiPqv25V0LvZcRKBUhZPMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MG/nC7m/Gb0WPKscNtDJsCBtdjWotPg0IvKiVRnTDVji0tmW81W+iRBa4VuSWlVYBirMByLNCLu5300mVP3MNbfSlgUnq8fPRDoHMRK3bnapV1404Ai/y9UE95n1m06oXZ9N+wpxjcr0sZXzpyFYcKf6b27f2q3OcrO+DBbDOaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+hRQuMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C552FC4CEED;
	Thu, 26 Jun 2025 12:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750939588;
	bh=FmUVXHOy/7uFflW8v86PWaiPqv25V0LvZcRKBUhZPMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O+hRQuMfXqFhypWNWKsLsMgPvlLusvZxEsgnlAn2sheWNB+ZAEdlhWGV746zP+EMG
	 z0LxcFahWaJ61g1E0il5l30cEXQ9chUfgesh5U0bAbLu7vp0nWOqTB5pXwoewZUnNe
	 2BdvEacITJ4BXq0DwZN4iCyVWgn0Nsad8HONVYsQX2uULJreiKJGfL86JVJZaCSeRE
	 fiF9GxEqxPsSKIJUlcb+omyS36WQlxUcBZJ6245OcVkas2KnlqOgoF5pfaKXCcjTMa
	 zT3pbz4jThvntwnst7KdP7BnxNsa//tMSynMpxXAxofnj6Epu2AGRc2Jo1CsApLASx
	 4sdq4EM1dbt8w==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next v1 3/7] RDMA/mlx5: Check CAP_NET_RAW in user namespace for flow create
Date: Thu, 26 Jun 2025 15:05:54 +0300
Message-ID: <a60cfc6ef2eed56dcebf632696e130c993ad7125.1750938869.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750938869.git.leon@kernel.org>
References: <cover.1750938869.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parav Pandit <parav@nvidia.com>

Currently, the capability check is done in the default
init_user_ns user namespace. When a process runs in a
non default user namespace, such check fails. Due to this
when a process is running using podman, it fails to create
the flow.

Since the RDMA device is a resource within a network namespace,
use the network namespace associated with the RDMA device to
determine its owning user namespace.

Fixes: 322694412400 ("IB/mlx5: Introduce driver create and destroy flow methods")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/fs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index ebcc05f766e1..774239d9efdc 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -2459,13 +2459,12 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
 	struct mlx5_ib_dev *dev;
 	u32 flags;
 
-	if (!capable(CAP_NET_RAW))
-		return -EPERM;
-
 	fs_matcher = uverbs_attr_get_obj(attrs,
 					 MLX5_IB_ATTR_CREATE_FLOW_MATCHER);
 	uobj =  uverbs_attr_get_uobject(attrs, MLX5_IB_ATTR_CREATE_FLOW_HANDLE);
 	dev = mlx5_udata_to_mdev(&attrs->driver_udata);
+	if (!rdma_dev_has_raw_cap(&dev->ib_dev))
+		return -EPERM;
 
 	if (get_dests(attrs, fs_matcher, &dest_id, &dest_type, &qp, &flags))
 		return -EINVAL;
-- 
2.49.0


