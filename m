Return-Path: <linux-rdma+bounces-11392-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 783E4ADC525
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 10:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501C03B134E
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 08:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B8F28FFEC;
	Tue, 17 Jun 2025 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSzTH5+i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA98128DF07
	for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 08:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750149381; cv=none; b=T3iaPECHdrNoJj6BE6phSBEPivbMAb3GHIkcyFrAit6/K6ewT8KS6cfWK+moPmTYdudnMJRsCTfibpKMZLC40f5ahsXEYBWsRo1hYZR8zzxsCntX8R+dgkWasO1ySvG44T1acnhSKpS4Qvw7E32LHnQ0x7NdL+BrjXrActk5OTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750149381; c=relaxed/simple;
	bh=FmUVXHOy/7uFflW8v86PWaiPqv25V0LvZcRKBUhZPMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imdrqwrGbHJGjLu99ee2eMiNIsmyHcNADDqVXedXXmbmKTCp5uhNl5anU/SM3COrTKrikrIkeRIV6Rfnv/9YYck3iyP80uup1xDnBtu+fGsl8PDv6/FjGgoUWpC8R+7C0kt7ZH8Rcr/L4EcUAfe2/0LYu9c+/yZCdjeMm0K2kUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSzTH5+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA85FC4CEE3;
	Tue, 17 Jun 2025 08:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750149381;
	bh=FmUVXHOy/7uFflW8v86PWaiPqv25V0LvZcRKBUhZPMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lSzTH5+ii/HoOpvluWPfUS18T1Oq5/qtBO+gZnYEB11EhfE2RL2qnKQm0F+PvYQtY
	 xCcdBHOGnAT6XyLnEmEgzG3460iBh3/xLvf85UmTKQ1P4p454LhDxVQdW2JwWu3HwT
	 ozNZRoenKmcsKygm7Gy+FNd1r6+Exw2HNzgKjRQprmZJeiUnRgOkMuAkNJSsCZdUHe
	 x3JRmg3a0zJACwKX29FUSKdYdShRvSgq9cPgnHQFOMwLfUhAPXTAWUvkrqqL2tCZs9
	 1BhIwFSCuTQzGcc9pN73vc5LPPGD+c7iWNHjjmEQSkL0vYmhzoeAZNOOeYnjkRKxSR
	 TdJDtTaTfaq+w==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next 3/7] RDMA/mlx5: Check CAP_NET_RAW in user namespace for flow create
Date: Tue, 17 Jun 2025 11:35:47 +0300
Message-ID: <45aed6582b2cc3dd9f5090b75250dc7e4e2f774d.1750148509.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750148509.git.leon@kernel.org>
References: <cover.1750148509.git.leon@kernel.org>
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


