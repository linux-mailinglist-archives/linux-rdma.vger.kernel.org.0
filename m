Return-Path: <linux-rdma+bounces-12078-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBD7B02EF2
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 08:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0B516C5ED
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 06:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0571A76D4;
	Sun, 13 Jul 2025 06:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+ykgVng"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF21F5EA;
	Sun, 13 Jul 2025 06:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752388670; cv=none; b=lgNcWQbe5mfhHGgD0bEnDWw8OA4ZUZAeVsxMBXDa9WkKuMtawPdAZF3rD2rsr9fK1APZT110Btm74YU7WiznDkcdsMfoGbE8cQoJK7DA+NIIeBb2+qWi1kWWHp8NvwFr5gSx2+LSpwWX+/s6nl6imGHgPG6vokR6MRxPAobRO1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752388670; c=relaxed/simple;
	bh=oiw94stA4HTHiJx8meJEs3QPG9hTc2K5BS5Ck9ZBbdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lG/+VYwQX7xXIBfq0N10pNwhJG2XWia0rp3RwOPdu5V/gxSt537dGgJ4tMrszKCDUQydtXHA+yLu7QKkOaQyd9LMjFPsDS77HkhAJ5k7uwRLpm6eUDmutCM/xBNg3aNUovrKIe/WXCpMsW+a41yMe52+3Id66OoJZ2qc/EUh614=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+ykgVng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE3DC4CEE3;
	Sun, 13 Jul 2025 06:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752388670;
	bh=oiw94stA4HTHiJx8meJEs3QPG9hTc2K5BS5Ck9ZBbdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H+ykgVngRR47ATOl6FcMpUQDgf2ouLPBTCZGrRN9v+eq0i611lH7AhbuBHFoeXkgL
	 U+8ySIGSPp3YGhQp/jVvr8XxW/clYcwr36eXevL7i/uCNvUrvBO8JlrE7DSoeYaSMu
	 QUu1WrMXbXegV28mb9ouk56Ry6hh2XZlZ49ZB0Ja22TLUs7p94v3e881+RTun8JrVx
	 c1OddPrfjOdQClkPgqgt0azJxHRH/Hf4mAzOsKL+K31TsZMHF3NBwlChHS/AlgrV5V
	 3h7dyNauYHCbd7/GJAK0WjJ5346GrfIZ+5g4VJuY1Do57X9vQ5TC65mZzsdS7oOXwA
	 y/GWo+VqLcqAg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next v1 3/8] net/mlx5: Add support for device steering tag
Date: Sun, 13 Jul 2025 09:37:24 +0300
Message-ID: <53240b2d64242ef1794733bf4b8e4719e53d4c0f.1752388126.git.leon@kernel.org>
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

Background, from PCIe specification 6.2.

TLP Processing Hints (TPH)
--------------------------
TLP Processing Hints is an optional feature that provides hints in
Request TLP headers to facilitate optimized processing of Requests that
target Memory Space. These Processing Hints enable the system hardware
(e.g., the Root Complex and/or Endpoints) to optimize platform
resources such as system and memory interconnect on a per TLP basis.
Steering Tags are system-specific values used to identify a processing
resource that a Requester explicitly targets. System software discovers
and identifies TPH capabilities to determine the Steering Tag allocation
for each Function that supports TPH.

This patch adds steering tag support for mlx5 based NICs by:

- Enabling the TPH functionality over PCI if both FW and OS support it.
- Managing steering tags and their matching steering indexes by
  writing a ST to an ST index over the PCI configuration space.
- Exposing APIs to upper layers (e.g.,mlx5_ib) to allow usage of
  the PCI TPH infrastructure.

Further details:
- Upon probing of a device, the feature will be enabled based
  on both capability detection and OS support.

- It will retrieve the appropriate ST for a given CPU ID and memory
  type using the pcie_tph_get_cpu_st() API.

- It will track available ST indices according to the configuration
  space table size (expected to be 63 entries), reserving index 0 to
  indicate non-TPH use.

- It will assign a free ST index with a ST using the
  pcie_tph_set_st_entry() API.

- It will reuse the same index for identical (CPU ID + memory type)
  combinations by maintaining a reference count per entry.

- It will expose APIs to upper layers (e.g., mlx5_ib) to allow usage of
  the PCI TPH infrastructure.

- SF will use its parent PF stuff.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   5 +
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 164 ++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/main.c    |   2 +
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   9 +
 include/linux/mlx5/driver.h                   |  20 +++
 5 files changed, 200 insertions(+)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/st.c

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index d292e6a9e22c..bd9d46c6719f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -167,5 +167,10 @@ mlx5_core-$(CONFIG_MLX5_SF) += sf/vhca_event.o sf/dev/dev.o sf/dev/driver.o irq_
 #
 mlx5_core-$(CONFIG_MLX5_SF_MANAGER) += sf/cmd.o sf/hw_table.o sf/devlink.o
 
+#
+# TPH support
+#
+mlx5_core-$(CONFIG_PCIE_TPH) += lib/st.o
+
 obj-$(CONFIG_MLX5_DPLL) += mlx5_dpll.o
 mlx5_dpll-y :=	dpll.o
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
new file mode 100644
index 000000000000..47fe215f66bf
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#include <linux/mlx5/driver.h>
+#include <linux/mlx5/device.h>
+
+#include "mlx5_core.h"
+#include "lib/mlx5.h"
+
+struct mlx5_st_idx_data {
+	refcount_t usecount;
+	u16 tag;
+};
+
+struct mlx5_st {
+	/* serialize access upon alloc/free flows */
+	struct mutex lock;
+	struct xa_limit index_limit;
+	struct xarray idx_xa; /* key == index, value == struct mlx5_st_idx_data */
+};
+
+struct mlx5_st *mlx5_st_create(struct mlx5_core_dev *dev)
+{
+	struct pci_dev *pdev = dev->pdev;
+	struct mlx5_st *st;
+	u16 num_entries;
+	int ret;
+
+	if (!MLX5_CAP_GEN(dev, mkey_pcie_tph))
+		return NULL;
+
+#ifdef CONFIG_MLX5_SF
+	if (mlx5_core_is_sf(dev))
+		return dev->priv.parent_mdev->st;
+#endif
+
+	/* Checking whether the device is capable */
+	if (!pdev->tph_cap)
+		return NULL;
+
+	num_entries = pcie_tph_get_st_table_size(pdev);
+	/* We need a reserved entry for non TPH cases */
+	if (num_entries < 2)
+		return NULL;
+
+	/* The OS doesn't support ST */
+	ret = pcie_enable_tph(pdev, PCI_TPH_ST_DS_MODE);
+	if (ret)
+		return NULL;
+
+	st = kzalloc(sizeof(*st), GFP_KERNEL);
+	if (!st)
+		goto end;
+
+	mutex_init(&st->lock);
+	xa_init_flags(&st->idx_xa, XA_FLAGS_ALLOC);
+	/* entry 0 is reserved for non TPH cases */
+	st->index_limit.min = MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX + 1;
+	st->index_limit.max = num_entries - 1;
+
+	return st;
+
+end:
+	pcie_disable_tph(dev->pdev);
+	return NULL;
+}
+
+void mlx5_st_destroy(struct mlx5_core_dev *dev)
+{
+	struct mlx5_st *st = dev->st;
+
+	if (mlx5_core_is_sf(dev) || !st)
+		return;
+
+	pcie_disable_tph(dev->pdev);
+	WARN_ON_ONCE(!xa_empty(&st->idx_xa));
+	kfree(st);
+}
+
+int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem_type,
+			unsigned int cpu_uid, u16 *st_index)
+{
+	struct mlx5_st_idx_data *idx_data;
+	struct mlx5_st *st = dev->st;
+	unsigned long index;
+	u32 xa_id;
+	u16 tag;
+	int ret;
+
+	if (!st)
+		return -EOPNOTSUPP;
+
+	ret = pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
+	if (ret)
+		return ret;
+
+	mutex_lock(&st->lock);
+
+	xa_for_each(&st->idx_xa, index, idx_data) {
+		if (tag == idx_data->tag) {
+			refcount_inc(&idx_data->usecount);
+			*st_index = index;
+			goto end;
+		}
+	}
+
+	idx_data = kzalloc(sizeof(*idx_data), GFP_KERNEL);
+	if (!idx_data) {
+		ret = -ENOMEM;
+		goto end;
+	}
+
+	refcount_set(&idx_data->usecount, 1);
+	idx_data->tag = tag;
+
+	ret = xa_alloc(&st->idx_xa, &xa_id, idx_data, st->index_limit, GFP_KERNEL);
+	if (ret)
+		goto clean_idx_data;
+
+	ret = pcie_tph_set_st_entry(dev->pdev, xa_id, tag);
+	if (ret)
+		goto clean_idx_xa;
+
+	*st_index = xa_id;
+	goto end;
+
+clean_idx_xa:
+	xa_erase(&st->idx_xa, xa_id);
+clean_idx_data:
+	kfree(idx_data);
+end:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mlx5_st_alloc_index);
+
+int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
+{
+	struct mlx5_st_idx_data *idx_data;
+	struct mlx5_st *st = dev->st;
+	int ret = 0;
+
+	if (!st)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&st->lock);
+	idx_data = xa_load(&st->idx_xa, st_index);
+	if (WARN_ON_ONCE(!idx_data)) {
+		ret = -EINVAL;
+		goto end;
+	}
+
+	if (refcount_dec_and_test(&idx_data->usecount)) {
+		xa_erase(&st->idx_xa, st_index);
+		/* We leave PCI config space as was before, no mkey will refer to it */
+	}
+
+end:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mlx5_st_dealloc_index);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index b0043cfee29b..be3be043134f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1102,6 +1102,7 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 	}
 
 	dev->dm = mlx5_dm_create(dev);
+	dev->st = mlx5_st_create(dev);
 	dev->tracer = mlx5_fw_tracer_create(dev);
 	dev->hv_vhca = mlx5_hv_vhca_create(dev);
 	dev->rsc_dump = mlx5_rsc_dump_create(dev);
@@ -1150,6 +1151,7 @@ static void mlx5_cleanup_once(struct mlx5_core_dev *dev)
 	mlx5_rsc_dump_destroy(dev);
 	mlx5_hv_vhca_destroy(dev->hv_vhca);
 	mlx5_fw_tracer_destroy(dev->tracer);
+	mlx5_st_destroy(dev);
 	mlx5_dm_cleanup(dev);
 	mlx5_fs_core_free(dev);
 	mlx5_sf_table_cleanup(dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 2e02bdea8361..1cada2f87acf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -300,6 +300,15 @@ int mlx5_set_mtppse(struct mlx5_core_dev *mdev, u8 pin, u8 arm, u8 mode);
 struct mlx5_dm *mlx5_dm_create(struct mlx5_core_dev *dev);
 void mlx5_dm_cleanup(struct mlx5_core_dev *dev);
 
+#ifdef CONFIG_PCIE_TPH
+struct mlx5_st *mlx5_st_create(struct mlx5_core_dev *dev);
+void mlx5_st_destroy(struct mlx5_core_dev *dev);
+#else
+static inline struct mlx5_st *
+mlx5_st_create(struct mlx5_core_dev *dev) { return NULL; }
+static inline void mlx5_st_destroy(struct mlx5_core_dev *dev) { return; }
+#endif
+
 void mlx5_toggle_port_link(struct mlx5_core_dev *dev);
 int mlx5_set_port_admin_status(struct mlx5_core_dev *dev,
 			       enum mlx5_port_status status);
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 3475d33c75f4..8c5fbfb85749 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -36,6 +36,7 @@
 #include <linux/kernel.h>
 #include <linux/completion.h>
 #include <linux/pci.h>
+#include <linux/pci-tph.h>
 #include <linux/irq.h>
 #include <linux/spinlock_types.h>
 #include <linux/semaphore.h>
@@ -688,6 +689,7 @@ struct mlx5_fw_tracer;
 struct mlx5_vxlan;
 struct mlx5_geneve;
 struct mlx5_hv_vhca;
+struct mlx5_st;
 
 #define MLX5_LOG_SW_ICM_BLOCK_SIZE(dev) (MLX5_CAP_DEV_MEM(dev, log_sw_icm_alloc_granularity))
 #define MLX5_SW_ICM_BLOCK_SIZE(dev) (1 << MLX5_LOG_SW_ICM_BLOCK_SIZE(dev))
@@ -757,6 +759,7 @@ struct mlx5_core_dev {
 	u32			issi;
 	struct mlx5e_resources  mlx5e_res;
 	struct mlx5_dm          *dm;
+	struct mlx5_st          *st;
 	struct mlx5_vxlan       *vxlan;
 	struct mlx5_geneve      *geneve;
 	struct {
@@ -1160,6 +1163,23 @@ int mlx5_dm_sw_icm_alloc(struct mlx5_core_dev *dev, enum mlx5_sw_icm_type type,
 int mlx5_dm_sw_icm_dealloc(struct mlx5_core_dev *dev, enum mlx5_sw_icm_type type,
 			   u64 length, u16 uid, phys_addr_t addr, u32 obj_id);
 
+#ifdef CONFIG_PCIE_TPH
+int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem_type,
+			unsigned int cpu_uid, u16 *st_index);
+int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index);
+#else
+static inline int mlx5_st_alloc_index(struct mlx5_core_dev *dev,
+				      enum tph_mem_type mem_type,
+				      unsigned int cpu_uid, u16 *st_index)
+{
+	return -EOPNOTSUPP;
+}
+static inline int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 struct mlx5_core_dev *mlx5_vf_get_core_dev(struct pci_dev *pdev);
 void mlx5_vf_put_core_dev(struct mlx5_core_dev *mdev);
 
-- 
2.50.1


