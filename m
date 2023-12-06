Return-Path: <linux-rdma+bounces-282-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353AD80719A
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 15:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96180B20E88
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 14:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B677D3D396;
	Wed,  6 Dec 2023 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb0/H/8z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661143C46C;
	Wed,  6 Dec 2023 14:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D00CC433CB;
	Wed,  6 Dec 2023 14:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701871314;
	bh=u0ZAwcbliV7EY/YM1uCFqSS4XX+prKe43jKs26Lzh0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pb0/H/8zyoMGz6YrAomE9djEkQuy9irf07diOlkRh8GppVtab+yoVnK8uwlgAsGWt
	 OjqytUoX2Qh91ueGvHe3n+Kj2oVeUOviZ7SD7roXHupsdNQ8fy9kEFQblIUuccGJnM
	 nygU0VMcZMqhN1CcQobLAYRqhtdzug9pLLU8TNku8s4KTFpHfYDt0083R2Pvkvpx34
	 /xkWgPJ5c78O40ywdKbWPK88yV0unpHOKws2QaUPFtBC0leKMsYXiYm0W5cxfRKH+l
	 j96mtAT1MOOuvXoHvDuJTh9qqPUk1SIZkuJutTCYedRCAZPLgaxGVCbxxCMeWBNHH2
	 CraGDg30cIA1g==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shun Hao <shunh@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next v1 2/5] RDMA/mlx5: Support handling of SW encap ICM area
Date: Wed,  6 Dec 2023 16:01:35 +0200
Message-ID: <546fe43fc700240709e30acf7713ec6834d652bd.1701871118.git.leon@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701871118.git.leon@kernel.org>
References: <cover.1701871118.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shun Hao <shunh@nvidia.com>

New type for this ICM area, now the user can allocate/deallocate
the new type of SW encap ICM memory, to store the encap header data
which are managed by SW.

Signed-off-by: Shun Hao <shunh@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/dm.c           | 5 +++++
 drivers/infiniband/hw/mlx5/mr.c           | 1 +
 include/linux/mlx5/driver.h               | 1 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h | 1 +
 4 files changed, 8 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/dm.c b/drivers/infiniband/hw/mlx5/dm.c
index 3669c90b2dad..b4c97fb62abf 100644
--- a/drivers/infiniband/hw/mlx5/dm.c
+++ b/drivers/infiniband/hw/mlx5/dm.c
@@ -341,6 +341,8 @@ static enum mlx5_sw_icm_type get_icm_type(int uapi_type)
 		return MLX5_SW_ICM_TYPE_HEADER_MODIFY;
 	case MLX5_IB_UAPI_DM_TYPE_HEADER_MODIFY_PATTERN_SW_ICM:
 		return MLX5_SW_ICM_TYPE_HEADER_MODIFY_PATTERN;
+	case MLX5_IB_UAPI_DM_TYPE_ENCAP_SW_ICM:
+		return MLX5_SW_ICM_TYPE_SW_ENCAP;
 	case MLX5_IB_UAPI_DM_TYPE_STEERING_SW_ICM:
 	default:
 		return MLX5_SW_ICM_TYPE_STEERING;
@@ -364,6 +366,7 @@ static struct ib_dm *handle_alloc_dm_sw_icm(struct ib_ucontext *ctx,
 	switch (type) {
 	case MLX5_IB_UAPI_DM_TYPE_STEERING_SW_ICM:
 	case MLX5_IB_UAPI_DM_TYPE_HEADER_MODIFY_SW_ICM:
+	case MLX5_IB_UAPI_DM_TYPE_ENCAP_SW_ICM:
 		if (!(MLX5_CAP_FLOWTABLE_NIC_RX(dev, sw_owner) ||
 		      MLX5_CAP_FLOWTABLE_NIC_TX(dev, sw_owner) ||
 		      MLX5_CAP_FLOWTABLE_NIC_RX(dev, sw_owner_v2) ||
@@ -438,6 +441,7 @@ struct ib_dm *mlx5_ib_alloc_dm(struct ib_device *ibdev,
 	case MLX5_IB_UAPI_DM_TYPE_STEERING_SW_ICM:
 	case MLX5_IB_UAPI_DM_TYPE_HEADER_MODIFY_SW_ICM:
 	case MLX5_IB_UAPI_DM_TYPE_HEADER_MODIFY_PATTERN_SW_ICM:
+	case MLX5_IB_UAPI_DM_TYPE_ENCAP_SW_ICM:
 		return handle_alloc_dm_sw_icm(context, attr, attrs, type);
 	default:
 		return ERR_PTR(-EOPNOTSUPP);
@@ -491,6 +495,7 @@ static int mlx5_ib_dealloc_dm(struct ib_dm *ibdm,
 	case MLX5_IB_UAPI_DM_TYPE_STEERING_SW_ICM:
 	case MLX5_IB_UAPI_DM_TYPE_HEADER_MODIFY_SW_ICM:
 	case MLX5_IB_UAPI_DM_TYPE_HEADER_MODIFY_PATTERN_SW_ICM:
+	case MLX5_IB_UAPI_DM_TYPE_ENCAP_SW_ICM:
 		return mlx5_dm_icm_dealloc(ctx, to_icm(ibdm));
 	default:
 		return -EOPNOTSUPP;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 7b7891116b89..12bca6ca4760 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1349,6 +1349,7 @@ struct ib_mr *mlx5_ib_reg_dm_mr(struct ib_pd *pd, struct ib_dm *dm,
 	case MLX5_IB_UAPI_DM_TYPE_STEERING_SW_ICM:
 	case MLX5_IB_UAPI_DM_TYPE_HEADER_MODIFY_SW_ICM:
 	case MLX5_IB_UAPI_DM_TYPE_HEADER_MODIFY_PATTERN_SW_ICM:
+	case MLX5_IB_UAPI_DM_TYPE_ENCAP_SW_ICM:
 		if (attr->access_flags & ~MLX5_IB_DM_SW_ICM_ALLOWED_ACCESS)
 			return ERR_PTR(-EINVAL);
 
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 4c576d19d927..cfcfa06bae18 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -688,6 +688,7 @@ enum mlx5_sw_icm_type {
 	MLX5_SW_ICM_TYPE_STEERING,
 	MLX5_SW_ICM_TYPE_HEADER_MODIFY,
 	MLX5_SW_ICM_TYPE_HEADER_MODIFY_PATTERN,
+	MLX5_SW_ICM_TYPE_SW_ENCAP,
 };
 
 #define MLX5_MAX_RESERVED_GIDS 8
diff --git a/include/uapi/rdma/mlx5_user_ioctl_verbs.h b/include/uapi/rdma/mlx5_user_ioctl_verbs.h
index 7af9e09ea556..3189c7f08d17 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_verbs.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_verbs.h
@@ -64,6 +64,7 @@ enum mlx5_ib_uapi_dm_type {
 	MLX5_IB_UAPI_DM_TYPE_STEERING_SW_ICM,
 	MLX5_IB_UAPI_DM_TYPE_HEADER_MODIFY_SW_ICM,
 	MLX5_IB_UAPI_DM_TYPE_HEADER_MODIFY_PATTERN_SW_ICM,
+	MLX5_IB_UAPI_DM_TYPE_ENCAP_SW_ICM,
 };
 
 enum mlx5_ib_uapi_devx_create_event_channel_flags {
-- 
2.43.0


