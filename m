Return-Path: <linux-rdma+bounces-3587-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F1091DF92
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 14:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FDA1F2263C
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 12:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FF813213D;
	Mon,  1 Jul 2024 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nz7iVDGI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124B677115
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jul 2024 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837654; cv=none; b=YJWgpJLblUtgowOMFigIl88/SvikRjNPU50LCHpAR9p1tHwNDAlDxAVSq5wAgAFDn/+7uPLZ0aC7k1jvU11yStIIsT7djKpWouqKiKUarYz53p+EaYZFwWusL5rZdCOL3UtqOMfHCACOBJZhGy4HMWEDixS1lT8LHB/BRNYhauw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837654; c=relaxed/simple;
	bh=IQXl4dEtWE9POATkoTwlvxownxHxbVVPhANJy5kzr7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X6USGRNubbCdcIcb79pxHc2ugl1K7QOuqsGxk4pIgZI1mK4RSrD6BjAPIY3+AeK3VaxvjjqWoLniEyUHz75zCC9Gnr3odYd8VPSt9v4iMQKymDbiFj9BM78+QI2q5aq8uBdAAtQuQHmg4Y5Ob+60eDtk3Pt9iuEixRKkorttYaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nz7iVDGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F35C116B1;
	Mon,  1 Jul 2024 12:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719837653;
	bh=IQXl4dEtWE9POATkoTwlvxownxHxbVVPhANJy5kzr7I=;
	h=From:To:Cc:Subject:Date:From;
	b=Nz7iVDGIJBJRRpayi546uCeM7ESQdcBYZlnFEmdhoVB/1m/nq2iFOtC1P5ko7/hVA
	 gAaFPzw5MA33vAJZ/7FDMzmN3A/kU6eYX1pw1nTVxybuZzyssDzVNrAQG+GZQ5bMCX
	 uABbC3xXT5uoLYH1eD+b2X9pJEpema/bi5mJlGfKTyFFFvOLGcB6NUS+XyZRTvVZFL
	 KPuqdqghdqkNQxaJAIfBTbqF8THuZmbHVhfQrsdoI5L+XR2GPKHrs6+jCnARssMIcc
	 rYYYmHc4AlzMTOYLgekt9sJvPAcP1WmMSSDlxZWB8m97eLQKfuqJvBUvNJCG4c47lU
	 ZlrmvktRiPxLA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	Bernard Metzler <bmt@zurich.ibm.com>,
	linux-rdma@vger.kernel.org,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next] RDMA/core: Introduce "name_assign_type" for an IB device
Date: Mon,  1 Jul 2024 15:40:48 +0300
Message-ID: <522591bef9a369cc8e5dcb77787e017bffee37fe.1719837610.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

The name_assign_type indicates how the name is provided. Currently
these types are supported:
- RDMA_NAME_ASSIGN_TYPE_UNKNOWN: Unknown or not set;
- RDMA_NAME_ASSIGN_TYPE_USER: Name is provided by the user; The
  user-created sub device, rxe and siw device has this type.

When filling nl device info, it is set in the new attribute
RDMA_NLDEV_ATTR_NAME_ASSIGN_TYPE. User-space tools like udev
"rdma_rename" could check this attribute to determine if this
device needs to be renamed or not.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/nldev.c      | 5 +++++
 drivers/infiniband/hw/mlx5/main.c    | 5 +++--
 drivers/infiniband/sw/rxe/rxe_net.c  | 1 +
 drivers/infiniband/sw/siw/siw_main.c | 1 +
 include/rdma/ib_verbs.h              | 8 ++++++++
 include/uapi/rdma/rdma_netlink.h     | 9 +++++++++
 6 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 025efce540a7..a6b80cdc96f7 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -169,6 +169,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_DRIVER_DETAILS]	= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_DEV_TYPE]		= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_PARENT_NAME]		= { .type = NLA_NUL_STRING },
+	[RDMA_NLDEV_ATTR_NAME_ASSIGN_TYPE]	= { .type = NLA_U8 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -312,6 +313,10 @@ static int fill_dev_info(struct sk_buff *msg, struct ib_device *device)
 			   dev_name(&device->parent->dev)))
 		return -EMSGSIZE;
 
+	if (nla_put_u8(msg, RDMA_NLDEV_ATTR_NAME_ASSIGN_TYPE,
+		       device->name_assign_type))
+		return -EMSGSIZE;
+
 	/*
 	 * Link type is determined on first port and mlx4 device
 	 * which can potentially have two different link type for the same
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 89083f454952..0db926b78e68 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4229,9 +4229,10 @@ static int mlx5_ib_stage_ib_reg_init(struct mlx5_ib_dev *dev)
 {
 	const char *name;
 
-	if (dev->sub_dev_name)
+	if (dev->sub_dev_name) {
 		name = dev->sub_dev_name;
-	else if (!mlx5_lag_is_active(dev->mdev))
+		ib_mark_name_assigned_by_user(&dev->ib_dev);
+	} else if (!mlx5_lag_is_active(dev->mdev))
 		name = "mlx5_%d";
 	else
 		name = "mlx5_bond_%d";
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index ca9a82e1c4c7..75d1407db52d 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -537,6 +537,7 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
 		return -ENOMEM;
 
 	rxe->ndev = ndev;
+	ib_mark_name_assigned_by_user(&rxe->ib_dev);
 
 	err = rxe_add(rxe, ndev->mtu, ibdev_name);
 	if (err) {
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index 61ad8ca3d1a2..b2b54242aa69 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -485,6 +485,7 @@ static int siw_newlink(const char *basedev_name, struct net_device *netdev)
 		else
 			sdev->state = IB_PORT_DOWN;
 
+		ib_mark_name_assigned_by_user(&sdev->base_dev);
 		rv = siw_device_register(sdev, basedev_name);
 		if (rv)
 			ib_dealloc_device(&sdev->base_dev);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index e09d4f09b602..6c5712ae559d 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2794,6 +2794,8 @@ struct ib_device {
 	enum rdma_nl_dev_type type;
 	struct ib_device *parent;
 	struct list_head subdev_list;
+
+	enum rdma_nl_name_assign_type name_assign_type;
 };
 
 static inline void *rdma_zalloc_obj(struct ib_device *dev, size_t size,
@@ -4867,4 +4869,10 @@ int ib_add_sub_device(struct ib_device *parent,
  * Return 0 on success, an error code otherwise
  */
 int ib_del_sub_device_and_put(struct ib_device *sub);
+
+static inline void ib_mark_name_assigned_by_user(struct ib_device *ibdev)
+{
+	ibdev->name_assign_type = RDMA_NAME_ASSIGN_TYPE_USER;
+}
+
 #endif /* IB_VERBS_H */
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 4b69242d7848..2f37568f5556 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -572,6 +572,8 @@ enum rdma_nldev_attr {
 
 	RDMA_NLDEV_ATTR_PARENT_NAME,		/* string */
 
+	RDMA_NLDEV_ATTR_NAME_ASSIGN_TYPE,	/* u8 */
+
 	/*
 	 * Always the end
 	 */
@@ -615,4 +617,11 @@ enum rdma_nl_counter_mask {
 enum rdma_nl_dev_type {
 	RDMA_DEVICE_TYPE_SMI = 1,
 };
+
+/* RDMA device name assignment types */
+enum rdma_nl_name_assign_type {
+	RDMA_NAME_ASSIGN_TYPE_UNKNOWN = 0,
+	RDMA_NAME_ASSIGN_TYPE_USER = 1, /* Provided by user-space */
+};
+
 #endif /* _UAPI_RDMA_NETLINK_H */
-- 
2.45.2


