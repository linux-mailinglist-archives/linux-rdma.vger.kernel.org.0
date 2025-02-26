Return-Path: <linux-rdma+bounces-8158-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A016A4624D
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 15:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B223B01D6
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 14:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175C0221DA1;
	Wed, 26 Feb 2025 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVt56MRK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4A722171D
	for <linux-rdma@vger.kernel.org>; Wed, 26 Feb 2025 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579486; cv=none; b=Qe+6UAO2p4oQIWyj+lkWBqQzPU/jGBhIdZG9iemi40AkACkYsE1o9pdPIPpdvpUJ3HkluuMVsafDXCvYElfKDeWI6/IElH2M+lXd83JGCZ3c9AqUxXf/H7ivDot1DuIp/H8U2ZRPrFNSyZMTkJ+gFT41zYLY66sokPlNMn9I/+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579486; c=relaxed/simple;
	bh=XS5CM3/uyQ/50M01PNMvY6GGSVw/MYZm3cFCQoed3xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCmC1so+ASCCf3ItagNHWjfPvisxdkqUXXM5T8f5DyUWW2O8OfdPrDZRtx1wVUnGJKWtbb/+tAtHxOVlO+Ytc6KFGF6ACvE76MvJ4ugQFUb1Q/sfVaWW59idRmaDP8Cur0/obPOU7IwsOu9NzoN8W1VGn3+z/xmveymXQ+ZqgG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVt56MRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB17C4CED6;
	Wed, 26 Feb 2025 14:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579486;
	bh=XS5CM3/uyQ/50M01PNMvY6GGSVw/MYZm3cFCQoed3xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uVt56MRKwazbKtFqcwTqM2ILnKrJj/BZzsMZNGhYyWgtOIlGYYmwJ0fqPIhPQ7svu
	 L6yhidchGZQqNzgXVFG00icRCj0oq6TCYgczZWV9SSUN0J1FosLtAGOdzswFOHPJAX
	 fBGo1JkdMVfI24fWnS3awQq6JUX4fBaebmQ/n/qcpOn0B0DLoi66Dryy8J45CCuz50
	 la9r/TRJSjZXdiQQSfogDdiNJHFzs0jU7QP4TEfUHxcOFq4lpAG8icX5Ab01IHxep3
	 39okt0JJ6mSwJa3xVoAr5hI5jAoFlQ1+/aClpV6K/m9smHWbvtU6Q0S77Nv+iqF8V9
	 kLJQpf5gt7Ktg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next 5/6] RDMA/mlx5: Expose RDMA TRANSPORT flow table types to userspace
Date: Wed, 26 Feb 2025 16:17:31 +0200
Message-ID: <947aa307213dd9997bf74872ef548995cf67f566.1740574943.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740574943.git.leon@kernel.org>
References: <cover.1740574943.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

This patch adds RDMA_TRANSPORT_RX and RDMA_TRANSPORT_TX as a new flow
table type for matcher creation.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/fs.c           | 154 ++++++++++++++++++++--
 drivers/infiniband/hw/mlx5/fs.h           |   2 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h      |   3 +
 include/uapi/rdma/mlx5_user_ioctl_cmds.h  |   1 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h |   2 +
 5 files changed, 149 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 162814ae8cb4..6ae2801fa13f 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -12,6 +12,7 @@
 #include <rdma/mlx5_user_ioctl_verbs.h>
 #include <rdma/ib_hdrs.h>
 #include <rdma/ib_umem.h>
+#include <rdma/ib_ucaps.h>
 #include <linux/mlx5/driver.h>
 #include <linux/mlx5/fs.h>
 #include <linux/mlx5/fs_helpers.h>
@@ -690,7 +691,7 @@ static struct mlx5_ib_flow_prio *_get_prio(struct mlx5_ib_dev *dev,
 					   struct mlx5_ib_flow_prio *prio,
 					   int priority,
 					   int num_entries, int num_groups,
-					   u32 flags)
+					   u32 flags, u16 vport)
 {
 	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_flow_table *ft;
@@ -698,6 +699,7 @@ static struct mlx5_ib_flow_prio *_get_prio(struct mlx5_ib_dev *dev,
 	ft_attr.prio = priority;
 	ft_attr.max_fte = num_entries;
 	ft_attr.flags = flags;
+	ft_attr.vport = vport;
 	ft_attr.autogroup.max_num_groups = num_groups;
 	ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
 	if (IS_ERR(ft))
@@ -792,7 +794,7 @@ static struct mlx5_ib_flow_prio *get_flow_table(struct mlx5_ib_dev *dev,
 	ft = prio->flow_table;
 	if (!ft)
 		return _get_prio(dev, ns, prio, priority, max_table_size,
-				 num_groups, flags);
+				 num_groups, flags, 0);
 
 	return prio;
 }
@@ -935,7 +937,7 @@ int mlx5_ib_fs_add_op_fc(struct mlx5_ib_dev *dev, u32 port_num,
 	prio = &dev->flow_db->opfcs[type];
 	if (!prio->flow_table) {
 		prio = _get_prio(dev, ns, prio, priority,
-				 dev->num_ports * MAX_OPFC_RULES, 1, 0);
+				 dev->num_ports * MAX_OPFC_RULES, 1, 0, 0);
 		if (IS_ERR(prio)) {
 			err = PTR_ERR(prio);
 			goto free;
@@ -1413,17 +1415,51 @@ static struct ib_flow *mlx5_ib_create_flow(struct ib_qp *qp,
 	return ERR_PTR(err);
 }
 
+static int mlx5_ib_fill_transport_ns_info(struct mlx5_ib_dev *dev,
+					  enum mlx5_flow_namespace_type type,
+					  u32 *flags, u16 *vport_idx,
+					  u16 *vport,
+					  struct mlx5_core_dev **ft_mdev,
+					  u32 ib_port)
+{
+	struct mlx5_core_dev *esw_mdev;
+
+	if (!is_mdev_switchdev_mode(dev->mdev))
+		return 0;
+
+	if (!MLX5_CAP_ADV_RDMA(dev->mdev, rdma_transport_manager))
+		return -EOPNOTSUPP;
+
+	if (!dev->port[ib_port - 1].rep)
+		return -EINVAL;
+
+	esw_mdev = mlx5_eswitch_get_core_dev(dev->port[ib_port - 1].rep->esw);
+	if (esw_mdev != dev->mdev)
+		return -EOPNOTSUPP;
+
+	*flags |= MLX5_FLOW_TABLE_OTHER_VPORT;
+	*ft_mdev = esw_mdev;
+	*vport = dev->port[ib_port - 1].rep->vport;
+	*vport_idx = dev->port[ib_port - 1].rep->vport_index;
+
+	return 0;
+}
+
 static struct mlx5_ib_flow_prio *
 _get_flow_table(struct mlx5_ib_dev *dev, u16 user_priority,
 		enum mlx5_flow_namespace_type ns_type,
-		bool mcast)
+		bool mcast, u32 ib_port)
 {
+	struct mlx5_core_dev *ft_mdev = dev->mdev;
 	struct mlx5_flow_namespace *ns = NULL;
 	struct mlx5_ib_flow_prio *prio = NULL;
 	int max_table_size = 0;
+	u16 vport_idx = 0;
 	bool esw_encap;
 	u32 flags = 0;
+	u16 vport = 0;
 	int priority;
+	int ret;
 
 	if (mcast)
 		priority = MLX5_IB_FLOW_MCAST_PRIO;
@@ -1471,13 +1507,38 @@ _get_flow_table(struct mlx5_ib_dev *dev, u16 user_priority,
 			MLX5_CAP_FLOWTABLE_RDMA_TX(dev->mdev, log_max_ft_size));
 		priority = user_priority;
 		break;
+	case MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_RX:
+	case MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_TX:
+		if (ib_port == 0 || user_priority > MLX5_RDMA_TRANSPORT_BYPASS_PRIO)
+			return ERR_PTR(-EINVAL);
+		ret = mlx5_ib_fill_transport_ns_info(dev, ns_type, &flags,
+						     &vport_idx, &vport,
+						     &ft_mdev, ib_port);
+		if (ret)
+			return ERR_PTR(ret);
+
+		if (ns_type == MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_RX)
+			max_table_size =
+				BIT(MLX5_CAP_FLOWTABLE_RDMA_TRANSPORT_RX(
+					ft_mdev, log_max_ft_size));
+		else
+			max_table_size =
+				BIT(MLX5_CAP_FLOWTABLE_RDMA_TRANSPORT_TX(
+					ft_mdev, log_max_ft_size));
+		priority = user_priority;
+		break;
 	default:
 		break;
 	}
 
 	max_table_size = min_t(int, max_table_size, MLX5_FS_MAX_ENTRIES);
 
-	ns = mlx5_get_flow_namespace(dev->mdev, ns_type);
+	if (ns_type == MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_RX ||
+	    ns_type == MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_TX)
+		ns = mlx5_get_flow_vport_namespace(ft_mdev, ns_type, vport_idx);
+	else
+		ns = mlx5_get_flow_namespace(ft_mdev, ns_type);
+
 	if (!ns)
 		return ERR_PTR(-EOPNOTSUPP);
 
@@ -1497,6 +1558,12 @@ _get_flow_table(struct mlx5_ib_dev *dev, u16 user_priority,
 	case MLX5_FLOW_NAMESPACE_RDMA_TX:
 		prio = &dev->flow_db->rdma_tx[priority];
 		break;
+	case MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_RX:
+		prio = &dev->flow_db->rdma_transport_rx[ib_port - 1];
+		break;
+	case MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_TX:
+		prio = &dev->flow_db->rdma_transport_tx[ib_port - 1];
+		break;
 	default: return ERR_PTR(-EINVAL);
 	}
 
@@ -1507,7 +1574,7 @@ _get_flow_table(struct mlx5_ib_dev *dev, u16 user_priority,
 		return prio;
 
 	return _get_prio(dev, ns, prio, priority, max_table_size,
-			 MLX5_FS_MAX_TYPES, flags);
+			 MLX5_FS_MAX_TYPES, flags, vport);
 }
 
 static struct mlx5_ib_flow_handler *
@@ -1626,7 +1693,8 @@ static struct mlx5_ib_flow_handler *raw_fs_rule_add(
 	mutex_lock(&dev->flow_db->lock);
 
 	ft_prio = _get_flow_table(dev, fs_matcher->priority,
-				  fs_matcher->ns_type, mcast);
+				  fs_matcher->ns_type, mcast,
+				  fs_matcher->ib_port);
 	if (IS_ERR(ft_prio)) {
 		err = PTR_ERR(ft_prio);
 		goto unlock;
@@ -1742,6 +1810,12 @@ mlx5_ib_ft_type_to_namespace(enum mlx5_ib_uapi_flow_table_type table_type,
 	case MLX5_IB_UAPI_FLOW_TABLE_TYPE_RDMA_TX:
 		*namespace = MLX5_FLOW_NAMESPACE_RDMA_TX;
 		break;
+	case MLX5_IB_UAPI_FLOW_TABLE_TYPE_RDMA_TRANSPORT_RX:
+		*namespace = MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_RX;
+		break;
+	case MLX5_IB_UAPI_FLOW_TABLE_TYPE_RDMA_TRANSPORT_TX:
+		*namespace = MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_TX;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1831,7 +1905,8 @@ static int get_dests(struct uverbs_attr_bundle *attrs,
 		return -EINVAL;
 
 	/* Allow only DEVX object or QP as dest when inserting to RDMA_RX */
-	if ((fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_RX) &&
+	if ((fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_RX ||
+	     fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_RX) &&
 	    ((!dest_devx && !dest_qp) || (dest_devx && dest_qp)))
 		return -EINVAL;
 
@@ -1848,7 +1923,8 @@ static int get_dests(struct uverbs_attr_bundle *attrs,
 			return -EINVAL;
 		/* Allow only flow table as dest when inserting to FDB or RDMA_RX */
 		if ((fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_FDB_BYPASS ||
-		     fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_RX) &&
+		     fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_RX ||
+		     fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_RX) &&
 		    *dest_type != MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE)
 			return -EINVAL;
 	} else if (dest_qp) {
@@ -1869,14 +1945,16 @@ static int get_dests(struct uverbs_attr_bundle *attrs,
 			*dest_id = mqp->raw_packet_qp.rq.tirn;
 		*dest_type = MLX5_FLOW_DESTINATION_TYPE_TIR;
 	} else if ((fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_EGRESS ||
-		    fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_TX) &&
+		    fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_TX ||
+		    fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_TX) &&
 		   !(*flags & MLX5_IB_ATTR_CREATE_FLOW_FLAGS_DROP)) {
 		*dest_type = MLX5_FLOW_DESTINATION_TYPE_PORT;
 	}
 
 	if (*dest_type == MLX5_FLOW_DESTINATION_TYPE_TIR &&
 	    (fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_EGRESS ||
-	     fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_TX))
+	     fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_TX ||
+	     fs_matcher->ns_type == MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_TX))
 		return -EINVAL;
 
 	return 0;
@@ -2353,6 +2431,15 @@ static int mlx5_ib_matcher_ns(struct uverbs_attr_bundle *attrs,
 	return 0;
 }
 
+static bool verify_context_caps(struct mlx5_ib_dev *dev, u64 enabled_caps)
+{
+	if (is_mdev_switchdev_mode(dev->mdev))
+		return UCAP_ENABLED(enabled_caps,
+				    RDMA_UCAP_MLX5_CTRL_OTHER_VHCA);
+
+	return UCAP_ENABLED(enabled_caps, RDMA_UCAP_MLX5_CTRL_LOCAL);
+}
+
 static int UVERBS_HANDLER(MLX5_IB_METHOD_FLOW_MATCHER_CREATE)(
 	struct uverbs_attr_bundle *attrs)
 {
@@ -2401,6 +2488,26 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_FLOW_MATCHER_CREATE)(
 		goto end;
 	}
 
+	if (uverbs_attr_is_valid(attrs, MLX5_IB_ATTR_FLOW_MATCHER_IB_PORT)) {
+		err = uverbs_copy_from(&obj->ib_port, attrs,
+				       MLX5_IB_ATTR_FLOW_MATCHER_IB_PORT);
+		if (err)
+			goto end;
+		if (!rdma_is_port_valid(&dev->ib_dev, obj->ib_port)) {
+			err = -EINVAL;
+			goto end;
+		}
+		if (obj->ns_type != MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_RX &&
+		    obj->ns_type != MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_TX) {
+			err = -EINVAL;
+			goto end;
+		}
+		if (!verify_context_caps(dev, uobj->context->enabled_caps)) {
+			err = -EOPNOTSUPP;
+			goto end;
+		}
+	}
+
 	uobj->object = obj;
 	obj->mdev = dev->mdev;
 	atomic_set(&obj->usecnt, 0);
@@ -2448,7 +2555,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_STEERING_ANCHOR_CREATE)(
 
 	mutex_lock(&dev->flow_db->lock);
 
-	ft_prio = _get_flow_table(dev, priority, ns_type, 0);
+	ft_prio = _get_flow_table(dev, priority, ns_type, 0, 0);
 	if (IS_ERR(ft_prio)) {
 		err = PTR_ERR(ft_prio);
 		goto free_obj;
@@ -2834,7 +2941,10 @@ DECLARE_UVERBS_NAMED_METHOD(
 			     UA_OPTIONAL),
 	UVERBS_ATTR_CONST_IN(MLX5_IB_ATTR_FLOW_MATCHER_FT_TYPE,
 			     enum mlx5_ib_uapi_flow_table_type,
-			     UA_OPTIONAL));
+			     UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(MLX5_IB_ATTR_FLOW_MATCHER_IB_PORT,
+			   UVERBS_ATTR_TYPE(u32),
+			   UA_OPTIONAL));
 
 DECLARE_UVERBS_NAMED_METHOD_DESTROY(
 	MLX5_IB_METHOD_FLOW_MATCHER_DESTROY,
@@ -2904,8 +3014,26 @@ int mlx5_ib_fs_init(struct mlx5_ib_dev *dev)
 	if (!dev->flow_db)
 		return -ENOMEM;
 
+	dev->flow_db->rdma_transport_rx = kcalloc(dev->num_ports,
+					sizeof(struct mlx5_ib_flow_prio),
+					GFP_KERNEL);
+	if (!dev->flow_db->rdma_transport_rx)
+		goto free_flow_db;
+
+	dev->flow_db->rdma_transport_tx = kcalloc(dev->num_ports,
+					sizeof(struct mlx5_ib_flow_prio),
+					GFP_KERNEL);
+	if (!dev->flow_db->rdma_transport_tx)
+		goto free_rdma_transport_rx;
+
 	mutex_init(&dev->flow_db->lock);
 
 	ib_set_device_ops(&dev->ib_dev, &flow_ops);
 	return 0;
+
+free_rdma_transport_rx:
+	kfree(dev->flow_db->rdma_transport_rx);
+free_flow_db:
+	kfree(dev->flow_db);
+	return -ENOMEM;
 }
diff --git a/drivers/infiniband/hw/mlx5/fs.h b/drivers/infiniband/hw/mlx5/fs.h
index b9734904f5f0..0516555eb1c1 100644
--- a/drivers/infiniband/hw/mlx5/fs.h
+++ b/drivers/infiniband/hw/mlx5/fs.h
@@ -40,6 +40,8 @@ static inline void mlx5_ib_fs_cleanup(struct mlx5_ib_dev *dev)
 	 * is a safe assumption that all references are gone.
 	 */
 	mlx5_ib_fs_cleanup_anchor(dev);
+	kfree(dev->flow_db->rdma_transport_tx);
+	kfree(dev->flow_db->rdma_transport_rx);
 	kfree(dev->flow_db);
 }
 #endif /* _MLX5_IB_FS_H */
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 974a45c92fbb..ccaaef20f50d 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -276,6 +276,7 @@ struct mlx5_ib_flow_matcher {
 	struct mlx5_core_dev	*mdev;
 	atomic_t		usecnt;
 	u8			match_criteria_enable;
+	u32			ib_port;
 };
 
 struct mlx5_ib_steering_anchor {
@@ -307,6 +308,8 @@ struct mlx5_ib_flow_db {
 	struct mlx5_ib_flow_prio	rdma_tx[MLX5_IB_NUM_FLOW_FT];
 	struct mlx5_ib_flow_prio	opfcs[MLX5_IB_OPCOUNTER_MAX];
 	struct mlx5_flow_table		*lag_demux_ft;
+	struct mlx5_ib_flow_prio        *rdma_transport_rx;
+	struct mlx5_ib_flow_prio        *rdma_transport_tx;
 	/* Protect flow steering bypass flow tables
 	 * when add/del flow rules.
 	 * only single add/removal of flow steering rule could be done
diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
index fd2e4a3a56b3..18f9fe070213 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_cmds.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
@@ -239,6 +239,7 @@ enum mlx5_ib_flow_matcher_create_attrs {
 	MLX5_IB_ATTR_FLOW_MATCHER_MATCH_CRITERIA,
 	MLX5_IB_ATTR_FLOW_MATCHER_FLOW_FLAGS,
 	MLX5_IB_ATTR_FLOW_MATCHER_FT_TYPE,
+	MLX5_IB_ATTR_FLOW_MATCHER_IB_PORT,
 };
 
 enum mlx5_ib_flow_matcher_destroy_attrs {
diff --git a/include/uapi/rdma/mlx5_user_ioctl_verbs.h b/include/uapi/rdma/mlx5_user_ioctl_verbs.h
index 7c233df475e7..8f86e79d78a5 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_verbs.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_verbs.h
@@ -45,6 +45,8 @@ enum mlx5_ib_uapi_flow_table_type {
 	MLX5_IB_UAPI_FLOW_TABLE_TYPE_FDB	= 0x2,
 	MLX5_IB_UAPI_FLOW_TABLE_TYPE_RDMA_RX	= 0x3,
 	MLX5_IB_UAPI_FLOW_TABLE_TYPE_RDMA_TX	= 0x4,
+	MLX5_IB_UAPI_FLOW_TABLE_TYPE_RDMA_TRANSPORT_RX	= 0x5,
+	MLX5_IB_UAPI_FLOW_TABLE_TYPE_RDMA_TRANSPORT_TX	= 0x6,
 };
 
 enum mlx5_ib_uapi_flow_action_packet_reformat_type {
-- 
2.48.1


