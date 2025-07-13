Return-Path: <linux-rdma+bounces-12079-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA0DB02EF4
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 08:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB740189DE60
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 06:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A241B87E9;
	Sun, 13 Jul 2025 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ex8HICSC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92E71AA7A6
	for <linux-rdma@vger.kernel.org>; Sun, 13 Jul 2025 06:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752388679; cv=none; b=fs7QYncfKGgbdyxm2GCGZLlgtc2dp+VJZISSq59UR1m8j9kG9qsl/u9Gtj/dESJmAS6Zp1L4GDTwZK+p0ARbw+xZ7SJ8kbijFCKywwgQ/O4fYwRHNUZYtC6DNL56+uVQ0RXXaoCtL276MqrCbefww+ljciaJUFGOtThUxb5GuYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752388679; c=relaxed/simple;
	bh=nPApRO+xcCaf13Pri9bJDL3kVlXaFTbB3FM2Crr1UAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6HAfcEnpGIQyY2IlwsrgPk2zuZx7BzwqXDdlIjRb6oJlW80nv0VJYCZZC1aRHF5K+ZuNVU580TbzRM/i+zvKzH4Vl3njT9jtfJyQgSod78E1gCKJm18gQSkF4hytNCaQaKg7HIEr8KVkhSZ7a/YRxas0N8Sw+/nrIQZqCHr91o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ex8HICSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0691CC4CEE3;
	Sun, 13 Jul 2025 06:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752388678;
	bh=nPApRO+xcCaf13Pri9bJDL3kVlXaFTbB3FM2Crr1UAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ex8HICSCo31sIv0YP0b6aF5zQmbi6dqbYH009MEfAPUFsp3c1MKxenKm5bi55febz
	 8OJPdID8ODDcpdw6M5oGjU+R9UbL6aIiS3Yztcj8k3y/NdTLBsIAQmJF9GaPno+7qY
	 VRwLBK1yjJxGAzvYeylSm53nhHPBB9mZNnf58C0+YRZcMFv0beVQblfL4TmYO+h0AW
	 Qfjby9vYbOChdr+NDN960hfULvIUm2xaErSVpvL2DQKg4f7wNtmNi8bC/82Ym8iYvw
	 8z4UP6HLM3mvwDLsTLk/ADXosDFxVmCTxEA4+URKOdKZI3BmZ0sM+aiGoCDl0h22XS
	 GOgNWA4DD6Sog==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 5/8] RDMA/core: Introduce a DMAH object and its alloc/free APIs
Date: Sun, 13 Jul 2025 09:37:26 +0300
Message-ID: <b1ff9b142f785a52009b288567bf4e15dd34ecb8.1752388126.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752388126.git.leon@kernel.org>
References: <cover.1752388126.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

Introduce a new DMA handle (DMAH) object along with its corresponding
allocation and deallocation APIs.

This DMAH object encapsulates attributes intended for use in DMA
transactions.

While its initial purpose is to support TPH functionality, it is
designed to be extensible for future features such as DMA PCI multipath,
PCI UIO configurations, PCI traffic class selection, and more.

Further details:
----------------
We ensure that a caller requesting a DMA handle for a specific CPU ID is
permitted to be scheduled on it. This prevent a potential security issue
where a non privilege user may trigger DMA operations toward a CPU that
it's not allowed to run on.

We manage reference counting for the DMAH object and its consumers
(e.g., memory regions) as will be detailed in subsequent patches in the
series.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Edward Srouji <edwards@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/Makefile              |   1 +
 drivers/infiniband/core/device.c              |   3 +
 drivers/infiniband/core/rdma_core.h           |   1 +
 drivers/infiniband/core/restrack.c            |   2 +
 .../infiniband/core/uverbs_std_types_dmah.c   | 147 ++++++++++++++++++
 drivers/infiniband/core/uverbs_uapi.c         |   1 +
 include/rdma/ib_verbs.h                       |  28 ++++
 include/rdma/restrack.h                       |   4 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  17 ++
 9 files changed, 204 insertions(+)
 create mode 100644 drivers/infiniband/core/uverbs_std_types_dmah.c

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index d49ded7e95f0..f483e0c12444 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -33,6 +33,7 @@ ib_umad-y :=			user_mad.o
 ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
 				rdma_core.o uverbs_std_types.o uverbs_ioctl.o \
 				uverbs_std_types_cq.o \
+				uverbs_std_types_dmah.o \
 				uverbs_std_types_flow_action.o uverbs_std_types_dm.o \
 				uverbs_std_types_mr.o uverbs_std_types_counters.o \
 				uverbs_uapi.o uverbs_std_types_device.o \
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 1ca6a9b7ba1a..4a98afbf8430 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2708,6 +2708,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, add_sub_dev);
 	SET_DEVICE_OP(dev_ops, advise_mr);
 	SET_DEVICE_OP(dev_ops, alloc_dm);
+	SET_DEVICE_OP(dev_ops, alloc_dmah);
 	SET_DEVICE_OP(dev_ops, alloc_hw_device_stats);
 	SET_DEVICE_OP(dev_ops, alloc_hw_port_stats);
 	SET_DEVICE_OP(dev_ops, alloc_mr);
@@ -2735,6 +2736,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, create_user_ah);
 	SET_DEVICE_OP(dev_ops, create_wq);
 	SET_DEVICE_OP(dev_ops, dealloc_dm);
+	SET_DEVICE_OP(dev_ops, dealloc_dmah);
 	SET_DEVICE_OP(dev_ops, dealloc_driver);
 	SET_DEVICE_OP(dev_ops, dealloc_mw);
 	SET_DEVICE_OP(dev_ops, dealloc_pd);
@@ -2832,6 +2834,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_OBJ_SIZE(dev_ops, ib_ah);
 	SET_OBJ_SIZE(dev_ops, ib_counters);
 	SET_OBJ_SIZE(dev_ops, ib_cq);
+	SET_OBJ_SIZE(dev_ops, ib_dmah);
 	SET_OBJ_SIZE(dev_ops, ib_mw);
 	SET_OBJ_SIZE(dev_ops, ib_pd);
 	SET_OBJ_SIZE(dev_ops, ib_qp);
diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
index 33706dad6c0f..a59b087611cb 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -156,6 +156,7 @@ extern const struct uapi_definition uverbs_def_obj_counters[];
 extern const struct uapi_definition uverbs_def_obj_cq[];
 extern const struct uapi_definition uverbs_def_obj_device[];
 extern const struct uapi_definition uverbs_def_obj_dm[];
+extern const struct uapi_definition uverbs_def_obj_dmah[];
 extern const struct uapi_definition uverbs_def_obj_flow_action[];
 extern const struct uapi_definition uverbs_def_obj_intf[];
 extern const struct uapi_definition uverbs_def_obj_mr[];
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index 3313410014cd..a7de6f403fca 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -100,6 +100,8 @@ static struct ib_device *res_to_dev(struct rdma_restrack_entry *res)
 		return container_of(res, struct rdma_counter, res)->device;
 	case RDMA_RESTRACK_SRQ:
 		return container_of(res, struct ib_srq, res)->device;
+	case RDMA_RESTRACK_DMAH:
+		return container_of(res, struct ib_dmah, res)->device;
 	default:
 		WARN_ONCE(true, "Wrong resource tracking type %u\n", res->type);
 		return NULL;
diff --git a/drivers/infiniband/core/uverbs_std_types_dmah.c b/drivers/infiniband/core/uverbs_std_types_dmah.c
new file mode 100644
index 000000000000..1965ee3e6e3d
--- /dev/null
+++ b/drivers/infiniband/core/uverbs_std_types_dmah.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#include "rdma_core.h"
+#include "uverbs.h"
+#include <rdma/uverbs_std_types.h>
+#include "restrack.h"
+
+static int uverbs_free_dmah(struct ib_uobject *uobject,
+			    enum rdma_remove_reason why,
+			    struct uverbs_attr_bundle *attrs)
+{
+	struct ib_dmah *dmah = uobject->object;
+	int ret;
+
+	if (atomic_read(&dmah->usecnt))
+		return -EBUSY;
+
+	ret = dmah->device->ops.dealloc_dmah(dmah, attrs);
+	if (ret)
+		return ret;
+
+	rdma_restrack_del(&dmah->res);
+	kfree(dmah);
+	return 0;
+}
+
+static int UVERBS_HANDLER(UVERBS_METHOD_DMAH_ALLOC)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct ib_uobject *uobj =
+		uverbs_attr_get(attrs, UVERBS_ATTR_ALLOC_DMAH_HANDLE)
+			->obj_attr.uobject;
+	struct ib_device *ib_dev = attrs->context->device;
+	struct ib_dmah *dmah;
+	int ret;
+
+	if (!ib_dev->ops.alloc_dmah || !ib_dev->ops.dealloc_dmah)
+		return -EOPNOTSUPP;
+
+	dmah = rdma_zalloc_drv_obj(ib_dev, ib_dmah);
+	if (!dmah)
+		return -ENOMEM;
+
+	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_ALLOC_DMAH_CPU_ID)) {
+		ret = uverbs_copy_from(&dmah->cpu_id, attrs,
+				       UVERBS_ATTR_ALLOC_DMAH_CPU_ID);
+		if (ret)
+			goto err;
+
+		if (!cpumask_test_cpu(dmah->cpu_id, current->cpus_ptr)) {
+			ret = -EPERM;
+			goto err;
+		}
+
+		dmah->valid_fields |= BIT(IB_DMAH_CPU_ID_EXISTS);
+	}
+
+	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_ALLOC_DMAH_TPH_MEM_TYPE)) {
+		dmah->mem_type = uverbs_attr_get_enum_id(attrs,
+					UVERBS_ATTR_ALLOC_DMAH_TPH_MEM_TYPE);
+		dmah->valid_fields |= BIT(IB_DMAH_MEM_TYPE_EXISTS);
+	}
+
+	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_ALLOC_DMAH_PH)) {
+		ret = uverbs_copy_from(&dmah->ph, attrs,
+				       UVERBS_ATTR_ALLOC_DMAH_PH);
+		if (ret)
+			goto err;
+
+		/* Per PCIe spec 6.2-1.0, only the lowest two bits are applicable */
+		if (dmah->ph & 0xFC) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		dmah->valid_fields |= BIT(IB_DMAH_PH_EXISTS);
+	}
+
+	dmah->device = ib_dev;
+	dmah->uobject = uobj;
+	atomic_set(&dmah->usecnt, 0);
+
+	rdma_restrack_new(&dmah->res, RDMA_RESTRACK_DMAH);
+	rdma_restrack_set_name(&dmah->res, NULL);
+
+	ret = ib_dev->ops.alloc_dmah(dmah, attrs);
+	if (ret) {
+		rdma_restrack_put(&dmah->res);
+		goto err;
+	}
+
+	uobj->object = dmah;
+	rdma_restrack_add(&dmah->res);
+	uverbs_finalize_uobj_create(attrs, UVERBS_ATTR_ALLOC_DMAH_HANDLE);
+	return 0;
+err:
+	kfree(dmah);
+	return ret;
+}
+
+static const struct uverbs_attr_spec uverbs_dmah_mem_type[] = {
+	[TPH_MEM_TYPE_VM] = {
+		.type = UVERBS_ATTR_TYPE_PTR_IN,
+		UVERBS_ATTR_NO_DATA(),
+	},
+	[TPH_MEM_TYPE_PM] = {
+		.type = UVERBS_ATTR_TYPE_PTR_IN,
+		UVERBS_ATTR_NO_DATA(),
+	},
+};
+
+DECLARE_UVERBS_NAMED_METHOD(
+	UVERBS_METHOD_DMAH_ALLOC,
+	UVERBS_ATTR_IDR(UVERBS_ATTR_ALLOC_DMAH_HANDLE,
+			UVERBS_OBJECT_DMAH,
+			UVERBS_ACCESS_NEW,
+			UA_MANDATORY),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_ALLOC_DMAH_CPU_ID,
+			   UVERBS_ATTR_TYPE(u32),
+			   UA_OPTIONAL),
+	UVERBS_ATTR_ENUM_IN(UVERBS_ATTR_ALLOC_DMAH_TPH_MEM_TYPE,
+			    uverbs_dmah_mem_type,
+			    UA_OPTIONAL),
+	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_ALLOC_DMAH_PH,
+			   UVERBS_ATTR_TYPE(u8),
+			   UA_OPTIONAL));
+
+DECLARE_UVERBS_NAMED_METHOD_DESTROY(
+	UVERBS_METHOD_DMAH_FREE,
+	UVERBS_ATTR_IDR(UVERBS_ATTR_FREE_DMA_HANDLE,
+			UVERBS_OBJECT_DMAH,
+			UVERBS_ACCESS_DESTROY,
+			UA_MANDATORY));
+
+DECLARE_UVERBS_NAMED_OBJECT(UVERBS_OBJECT_DMAH,
+			    UVERBS_TYPE_ALLOC_IDR(uverbs_free_dmah),
+			    &UVERBS_METHOD(UVERBS_METHOD_DMAH_ALLOC),
+			    &UVERBS_METHOD(UVERBS_METHOD_DMAH_FREE));
+
+const struct uapi_definition uverbs_def_obj_dmah[] = {
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(UVERBS_OBJECT_DMAH,
+				      UAPI_DEF_OBJ_NEEDS_FN(dealloc_dmah)),
+	{}
+};
diff --git a/drivers/infiniband/core/uverbs_uapi.c b/drivers/infiniband/core/uverbs_uapi.c
index a02916a3a79c..e00ea63175bd 100644
--- a/drivers/infiniband/core/uverbs_uapi.c
+++ b/drivers/infiniband/core/uverbs_uapi.c
@@ -631,6 +631,7 @@ static const struct uapi_definition uverbs_core_api[] = {
 	UAPI_DEF_CHAIN(uverbs_def_obj_cq),
 	UAPI_DEF_CHAIN(uverbs_def_obj_device),
 	UAPI_DEF_CHAIN(uverbs_def_obj_dm),
+	UAPI_DEF_CHAIN(uverbs_def_obj_dmah),
 	UAPI_DEF_CHAIN(uverbs_def_obj_flow_action),
 	UAPI_DEF_CHAIN(uverbs_def_obj_intf),
 	UAPI_DEF_CHAIN(uverbs_def_obj_mr),
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 1d123812a1f9..3be9aa04ac07 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -42,6 +42,7 @@
 #include <rdma/signature.h>
 #include <uapi/rdma/rdma_user_ioctl.h>
 #include <uapi/rdma/ib_user_ioctl_verbs.h>
+#include <linux/pci-tph.h>
 
 #define IB_FW_VERSION_NAME_MAX	ETHTOOL_FWVERS_LEN
 
@@ -1846,6 +1847,29 @@ struct ib_dm {
 	atomic_t	   usecnt;
 };
 
+/* bit values to mark existence of ib_dmah fields */
+enum {
+	IB_DMAH_CPU_ID_EXISTS,
+	IB_DMAH_MEM_TYPE_EXISTS,
+	IB_DMAH_PH_EXISTS,
+};
+
+struct ib_dmah {
+	struct ib_device *device;
+	u32 cpu_id;
+	enum tph_mem_type mem_type;
+	u8 ph;
+	struct ib_uobject *uobject;
+
+	u8 valid_fields; /* use IB_DMAH_XXX_EXISTS */
+	atomic_t usecnt;
+
+	/*
+	 * Implementation details of the RDMA core, don't use in drivers:
+	 */
+	struct rdma_restrack_entry res;
+};
+
 struct ib_mr {
 	struct ib_device  *device;
 	struct ib_pd	  *pd;
@@ -2569,6 +2593,9 @@ struct ib_device_ops {
 				  struct ib_dm_alloc_attr *attr,
 				  struct uverbs_attr_bundle *attrs);
 	int (*dealloc_dm)(struct ib_dm *dm, struct uverbs_attr_bundle *attrs);
+	int (*alloc_dmah)(struct ib_dmah *ibdmah,
+			  struct uverbs_attr_bundle *attrs);
+	int (*dealloc_dmah)(struct ib_dmah *dmah, struct uverbs_attr_bundle *attrs);
 	struct ib_mr *(*reg_dm_mr)(struct ib_pd *pd, struct ib_dm *dm,
 				   struct ib_dm_mr_attr *attr,
 				   struct uverbs_attr_bundle *attrs);
@@ -2726,6 +2753,7 @@ struct ib_device_ops {
 	DECLARE_RDMA_OBJ_SIZE(ib_ah);
 	DECLARE_RDMA_OBJ_SIZE(ib_counters);
 	DECLARE_RDMA_OBJ_SIZE(ib_cq);
+	DECLARE_RDMA_OBJ_SIZE(ib_dmah);
 	DECLARE_RDMA_OBJ_SIZE(ib_mw);
 	DECLARE_RDMA_OBJ_SIZE(ib_pd);
 	DECLARE_RDMA_OBJ_SIZE(ib_qp);
diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index 0d69ded73bf2..8a9bcf77dace 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -56,6 +56,10 @@ enum rdma_restrack_type {
 	 * @RDMA_RESTRACK_SRQ: Shared receive queue (SRQ)
 	 */
 	RDMA_RESTRACK_SRQ,
+	/**
+	 * @RDMA_RESTRACK_DMAH: DMA handle
+	 */
+	RDMA_RESTRACK_DMAH,
 	/**
 	 * @RDMA_RESTRACK_MAX: Last entry, used for array dclarations
 	 */
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index e7b827e281d1..a0b1130423f0 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -55,6 +55,7 @@ enum uverbs_default_objects {
 	UVERBS_OBJECT_DM,
 	UVERBS_OBJECT_COUNTERS,
 	UVERBS_OBJECT_ASYNC_EVENT,
+	UVERBS_OBJECT_DMAH,
 };
 
 enum {
@@ -236,6 +237,22 @@ enum uverbs_methods_dm {
 	UVERBS_METHOD_DM_FREE,
 };
 
+enum uverbs_attrs_alloc_dmah_cmd_attr_ids {
+	UVERBS_ATTR_ALLOC_DMAH_HANDLE,
+	UVERBS_ATTR_ALLOC_DMAH_CPU_ID,
+	UVERBS_ATTR_ALLOC_DMAH_TPH_MEM_TYPE,
+	UVERBS_ATTR_ALLOC_DMAH_PH,
+};
+
+enum uverbs_attrs_free_dmah_cmd_attr_ids {
+	UVERBS_ATTR_FREE_DMA_HANDLE,
+};
+
+enum uverbs_methods_dmah {
+	UVERBS_METHOD_DMAH_ALLOC,
+	UVERBS_METHOD_DMAH_FREE,
+};
+
 enum uverbs_attrs_reg_dm_mr_cmd_attr_ids {
 	UVERBS_ATTR_REG_DM_MR_HANDLE,
 	UVERBS_ATTR_REG_DM_MR_OFFSET,
-- 
2.50.1


