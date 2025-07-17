Return-Path: <linux-rdma+bounces-12262-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9A8B08CAC
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 14:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB351C250C9
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 12:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411642BDC11;
	Thu, 17 Jul 2025 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrNQoDyh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0069B1E1A17
	for <linux-rdma@vger.kernel.org>; Thu, 17 Jul 2025 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754683; cv=none; b=G8aS7uSlggzVPHLbVHWdHHUEeRJZibp/5mbBfdLxIx8ukQrVK26CuayTGFV+3E9qYzTu5TWhsh+zgGcvzopBpdli4TPFNiLm9lS0DqSh/Laz1f6Tx3dYhM7mmdbxiuRhFTp3AU6F6PBGKHO/JOAOsiT8x/I+DO9ek4L5kj9FqpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754683; c=relaxed/simple;
	bh=s7Mw0/uNanh/4VOZYLN8V9r115F6uC0FhhdQvxmA7+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAjv6grhT7PAZxcyKiM5GBwRZsNMhrHbTPv4LMZW5j+RWXh3PWfp0FHeQqPCdv4jrzA9Nz0kk/DnZzt1VJaIb27VN/djD0xngkv1k6e7jDGK2TFK6+U1th4n1y1+ewMLfY4hGeLE2NAqJbHNGjRWReEy8E+QfirfjrxdHzpEEZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrNQoDyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8BBC4CEED;
	Thu, 17 Jul 2025 12:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752754682;
	bh=s7Mw0/uNanh/4VOZYLN8V9r115F6uC0FhhdQvxmA7+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WrNQoDyh0+PXO0m3hz6jitVEx1HUuyHUsxo8U26aBtTsV6qKecYxHPHpuT0wyoXTQ
	 pM0nxFL2LkDJU6jnclr/7DXjbkuegG5OWNPAd6MZTVtT9t6oajnHvTfxvQppoCakzt
	 qpjg1SDWIGR5/sjrt+2IuffhS6QpUSNGFnk4cTDkrGYld2o92EYUyia94sX3licBov
	 gecZjSKlWTXeNDtvrw3atB1pDgb07VhSxHdLOB+l+eCdV5ZSRRLlYl6wxAGrmJDy6M
	 ssftFqWBLO+WtGSh+FfBCOpe4av619Pg2TRJxLz6gci7LWfk2Lr8qi4+zZvedjNm1h
	 +FKq0NYLXQGdQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 5/8] RDMA/core: Introduce a DMAH object and its alloc/free APIs
Date: Thu, 17 Jul 2025 15:17:29 +0300
Message-ID: <2cad097e849597e49d6b61e6865dba878257f371.1752752567.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752752567.git.leon@kernel.org>
References: <cover.1752752567.git.leon@kernel.org>
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
 .../infiniband/core/uverbs_std_types_dmah.c   | 145 ++++++++++++++++++
 drivers/infiniband/core/uverbs_uapi.c         |   1 +
 include/rdma/ib_verbs.h                       |  26 ++++
 include/rdma/restrack.h                       |   4 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  17 ++
 9 files changed, 200 insertions(+)
 create mode 100644 drivers/infiniband/core/uverbs_std_types_dmah.c

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index d49ded7e95f0b..f483e0c124445 100644
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
index f301cdce17281..3145cb34a1d20 100644
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
@@ -2736,6 +2737,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, create_user_ah);
 	SET_DEVICE_OP(dev_ops, create_wq);
 	SET_DEVICE_OP(dev_ops, dealloc_dm);
+	SET_DEVICE_OP(dev_ops, dealloc_dmah);
 	SET_DEVICE_OP(dev_ops, dealloc_driver);
 	SET_DEVICE_OP(dev_ops, dealloc_mw);
 	SET_DEVICE_OP(dev_ops, dealloc_pd);
@@ -2833,6 +2835,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_OBJ_SIZE(dev_ops, ib_ah);
 	SET_OBJ_SIZE(dev_ops, ib_counters);
 	SET_OBJ_SIZE(dev_ops, ib_cq);
+	SET_OBJ_SIZE(dev_ops, ib_dmah);
 	SET_OBJ_SIZE(dev_ops, ib_mw);
 	SET_OBJ_SIZE(dev_ops, ib_pd);
 	SET_OBJ_SIZE(dev_ops, ib_qp);
diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
index 33706dad6c0f7..a59b087611cb3 100644
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
index 3313410014cd5..a7de6f403fcaf 100644
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
index 0000000000000..453ce656c6f26
--- /dev/null
+++ b/drivers/infiniband/core/uverbs_std_types_dmah.c
@@ -0,0 +1,145 @@
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
+				      UAPI_DEF_OBJ_NEEDS_FN(dealloc_dmah),
+				      UAPI_DEF_OBJ_NEEDS_FN(alloc_dmah)),
+	{}
+};
diff --git a/drivers/infiniband/core/uverbs_uapi.c b/drivers/infiniband/core/uverbs_uapi.c
index a02916a3a79ce..e00ea63175bd8 100644
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
index 3fb1c963eeb01..9ad253687935b 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -42,6 +42,7 @@
 #include <rdma/signature.h>
 #include <uapi/rdma/rdma_user_ioctl.h>
 #include <uapi/rdma/ib_user_ioctl_verbs.h>
+#include <linux/pci-tph.h>
 
 #define IB_FW_VERSION_NAME_MAX	ETHTOOL_FWVERS_LEN
 
@@ -1846,6 +1847,27 @@ struct ib_dm {
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
+	struct ib_uobject *uobject;
+	/*
+	 * Implementation details of the RDMA core, don't use in drivers:
+	 */
+	struct rdma_restrack_entry res;
+	u32 cpu_id;
+	enum tph_mem_type mem_type;
+	atomic_t usecnt;
+	u8 ph;
+	u8 valid_fields; /* use IB_DMAH_XXX_EXISTS */
+};
+
 struct ib_mr {
 	struct ib_device  *device;
 	struct ib_pd	  *pd;
@@ -2573,6 +2595,9 @@ struct ib_device_ops {
 				  struct ib_dm_alloc_attr *attr,
 				  struct uverbs_attr_bundle *attrs);
 	int (*dealloc_dm)(struct ib_dm *dm, struct uverbs_attr_bundle *attrs);
+	int (*alloc_dmah)(struct ib_dmah *ibdmah,
+			  struct uverbs_attr_bundle *attrs);
+	int (*dealloc_dmah)(struct ib_dmah *dmah, struct uverbs_attr_bundle *attrs);
 	struct ib_mr *(*reg_dm_mr)(struct ib_pd *pd, struct ib_dm *dm,
 				   struct ib_dm_mr_attr *attr,
 				   struct uverbs_attr_bundle *attrs);
@@ -2730,6 +2755,7 @@ struct ib_device_ops {
 	DECLARE_RDMA_OBJ_SIZE(ib_ah);
 	DECLARE_RDMA_OBJ_SIZE(ib_counters);
 	DECLARE_RDMA_OBJ_SIZE(ib_cq);
+	DECLARE_RDMA_OBJ_SIZE(ib_dmah);
 	DECLARE_RDMA_OBJ_SIZE(ib_mw);
 	DECLARE_RDMA_OBJ_SIZE(ib_pd);
 	DECLARE_RDMA_OBJ_SIZE(ib_qp);
diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index 0d69ded73bf24..8a9bcf77daceb 100644
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
index ece923ab48a0c..3bb72a259c29e 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -55,6 +55,7 @@ enum uverbs_default_objects {
 	UVERBS_OBJECT_DM,
 	UVERBS_OBJECT_COUNTERS,
 	UVERBS_OBJECT_ASYNC_EVENT,
+	UVERBS_OBJECT_DMAH,
 };
 
 enum {
@@ -240,6 +241,22 @@ enum uverbs_methods_dm {
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


