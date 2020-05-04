Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012A31C3256
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 07:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgEDFmc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 01:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgEDFmc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 May 2020 01:42:32 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2615B20643;
        Mon,  4 May 2020 05:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588570951;
        bh=yUMmA4DSRpP0DHBQStLjLCxh3rjqarHL9t4sSqxuL5Y=;
        h=From:To:Cc:Subject:Date:From;
        b=LhUhdZ4uLunHoWek/u2sjfpOlsd166x9IvDQb00yY4u0288w37ffwPmWzjhLZbky8
         VV+HuPZ/MfYAlJ7riCkcvi2yKL8N8fh3Bt1NQDStM2cqGuHXCtqqqfcaKeQfmnNyWq
         qXIRRgwFt1cQH6KHP9uJlX4GVhcVLpUDiXIxR0gs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Daria Velikovsky <daria@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next v1] RDMA/mlx5: Add support for drop action in DV steering
Date:   Mon,  4 May 2020 08:42:27 +0300
Message-Id: <20200504054227.271486-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Daria Velikovsky <daria@mellanox.com>

When drop action is used the matching packet will stop
processing in steering and will be dropped. This functionality
will allow users to drop matching packets.
.
Signed-off-by: Daria Velikovsky <daria@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
Changelog:
v1: Rebased on top of https://lore.kernel.org/linux-rdma/20200504053012.270689-1-leon@kernel.org
    [PATCH rdma-next v1 0/4] Add steering support for default miss
v0: https://lore.kernel.org/linux-rdma/20200413135328.934419-1-leon@kernel.org
---
 drivers/infiniband/hw/mlx5/flow.c        | 35 ++++++++++++++----------
 include/uapi/rdma/mlx5_user_ioctl_cmds.h |  1 +
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/flow.c b/drivers/infiniband/hw/mlx5/flow.c
index 3fa66474afa6..6fa1a510c5d7 100644
--- a/drivers/infiniband/hw/mlx5/flow.c
+++ b/drivers/infiniband/hw/mlx5/flow.c
@@ -69,11 +69,10 @@ static const struct uverbs_attr_spec mlx5_ib_flow_type[] = {

 static int get_dests(struct uverbs_attr_bundle *attrs,
 		     struct mlx5_ib_flow_matcher *fs_matcher, int *dest_id,
-		     int *dest_type, struct ib_qp **qp, bool *def_miss)
+		     int *dest_type, struct ib_qp **qp, u32 *flags)
 {
 	bool dest_devx, dest_qp;
 	void *devx_obj;
-	u32 flags;
 	int err;

 	dest_devx = uverbs_attr_is_valid(attrs,
@@ -81,23 +80,28 @@ static int get_dests(struct uverbs_attr_bundle *attrs,
 	dest_qp = uverbs_attr_is_valid(attrs,
 				       MLX5_IB_ATTR_CREATE_FLOW_DEST_QP);

-	*def_miss = false;
-	err = uverbs_get_flags32(&flags, attrs,
-				 MLX5_IB_ATTR_CREATE_FLOW_FLAGS,
-				 MLX5_IB_ATTR_CREATE_FLOW_FLAGS_DEFAULT_MISS);
+	*flags = 0;
+	err = uverbs_get_flags32(flags, attrs, MLX5_IB_ATTR_CREATE_FLOW_FLAGS,
+				 MLX5_IB_ATTR_CREATE_FLOW_FLAGS_DEFAULT_MISS |
+					 MLX5_IB_ATTR_CREATE_FLOW_FLAGS_DROP);
 	if (err)
 		return err;
-	*def_miss = flags & MLX5_IB_ATTR_CREATE_FLOW_FLAGS_DEFAULT_MISS;
+
+	/* Both flags are not allowed */
+	if (*flags & MLX5_IB_ATTR_CREATE_FLOW_FLAGS_DEFAULT_MISS &&
+	    *flags & MLX5_IB_ATTR_CREATE_FLOW_FLAGS_DROP)
+		return -EINVAL;

 	if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_BYPASS) {
-		if (dest_devx && (dest_qp || *def_miss))
+		if (dest_devx && (dest_qp || *flags))
 			return -EINVAL;
-		else if (dest_qp && *def_miss)
+		else if (dest_qp && *flags)
 			return -EINVAL;
 	}

-	/* Allow only DEVX object as dest when inserting to FDB */
-	if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_FDB && !dest_devx)
+	/* Allow only DEVX object, drop as dest for FDB */
+	if (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_FDB && !(dest_devx ||
+	     (*flags & MLX5_IB_ATTR_CREATE_FLOW_FLAGS_DROP)))
 		return -EINVAL;

 	/* Allow only DEVX object or QP as dest when inserting to RDMA_RX */
@@ -166,7 +170,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
 	void *devx_obj, *cmd_in;
 	struct ib_uobject *uobj;
 	struct mlx5_ib_dev *dev;
-	bool def_miss;
+	u32 flags;

 	if (!capable(CAP_NET_RAW))
 		return -EPERM;
@@ -176,12 +180,15 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
 	uobj =  uverbs_attr_get_uobject(attrs, MLX5_IB_ATTR_CREATE_FLOW_HANDLE);
 	dev = mlx5_udata_to_mdev(&attrs->driver_udata);

-	if (get_dests(attrs, fs_matcher, &dest_id, &dest_type, &qp, &def_miss))
+	if (get_dests(attrs, fs_matcher, &dest_id, &dest_type, &qp, &flags))
 		return -EINVAL;

-	if (def_miss)
+	if (flags & MLX5_IB_ATTR_CREATE_FLOW_FLAGS_DEFAULT_MISS)
 		flow_act.action |= MLX5_FLOW_CONTEXT_ACTION_FWD_NEXT_NS;

+	if (flags & MLX5_IB_ATTR_CREATE_FLOW_FLAGS_DROP)
+		flow_act.action |= MLX5_FLOW_CONTEXT_ACTION_DROP;
+
 	len = uverbs_attr_get_uobjs_arr(attrs,
 		MLX5_IB_ATTR_CREATE_FLOW_ARR_COUNTERS_DEVX, &arr_flow_actions);
 	if (len) {
diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
index 07cf54333193..8e316ef896b5 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_cmds.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
@@ -243,6 +243,7 @@ enum mlx5_ib_flow_type {

 enum mlx5_ib_create_flow_flags {
 	MLX5_IB_ATTR_CREATE_FLOW_FLAGS_DEFAULT_MISS = 1 << 0,
+	MLX5_IB_ATTR_CREATE_FLOW_FLAGS_DROP = 1 << 1,
 };

 enum mlx5_ib_create_flow_attrs {
--
2.26.2

