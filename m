Return-Path: <linux-rdma+bounces-11936-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0200AAFB981
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 19:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0A91AA6293
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B96629ACE6;
	Mon,  7 Jul 2025 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTC3PcUE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF832264A0
	for <linux-rdma@vger.kernel.org>; Mon,  7 Jul 2025 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907865; cv=none; b=TULO0GJ7iy8mpa1arihEIFY3hPdSv3+q48h9gFnTqHPMFaFF630yn22asgR3PeGz8alrFEnlu4+VVz4eSDBgYkJWJtEHU4Lyr2ygXGP0XXUAwvmBbVMwgoMo2CIm666cUMuBpxoHZT5oz/K6NHgzQ/W8k2xHk0HgY8mEiVKkLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907865; c=relaxed/simple;
	bh=BeG26SyESsyanuseEsG4wdki2hi1fntXrB9Dr41Ux3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWdSE5WBQkYQRic5cMrV/7AR07U4EwSIjHEzZPcwEPykpFtxoYV28W+H/rhvmGwY2Anu6W+rXnZI1NIk4xFIPgyR1LgdR9omapu4VRapQaacw1oSKs0uyuQom7kRpJAUf4oFIpag0ceCSzhmLYzano5ArifRm3dl1CPij40wSkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTC3PcUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9264EC4CEE3;
	Mon,  7 Jul 2025 17:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751907865;
	bh=BeG26SyESsyanuseEsG4wdki2hi1fntXrB9Dr41Ux3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jTC3PcUE1uj+/lar+XFigkIkhfFFyWifdWDheFLjeZxYUGZ79rk94xHt01PXthnEx
	 O1+IIg6hMmvmUf0u2su5MB9y4hoCubppGkWFgQ5+1ar/KQ5xN8uQnXYPh+xgNuq9y1
	 N52dU2kdn2yyhHgeCChvPk2GDKSrR2U4pSL+sSUwLXPkB6ylq0TzEwNNJS/1/0MCt4
	 8gNTJiA37ow0IqvCi2qhEettbB61aRn0aq6ddDdlq07TnMguPF2Z6ZRoc56i635wRr
	 RZJKi/Z34LQOkUibOuwWoSGRxVxqlg8Bi+Q12S+huqH/fEq4CmZ47YLhy2E0VG7dm0
	 PYN+ESf9wUS+w==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 6/8] RDMA/mlx5: Add DMAH object support
Date: Mon,  7 Jul 2025 20:03:06 +0300
Message-ID: <53bd5a8bf373311ef1eaee0d2da45cd74d888945.1751907231.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751907231.git.leon@kernel.org>
References: <cover.1751907231.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

This patch introduces support for allocating and deallocating the DMAH
object.

Further details:
----------------
The DMAH API is exposed to upper layers only if the underlying device
supports TPH.

It uses the mlx5_core steering tag (ST) APIs to get a steering tag index
based on the provided input.

The obtained index is stored in the device-specific mlx5_dmah structure
for future use.

Upcoming patches in the series will integrate the allocated DMAH into
the memory region (MR) registration process.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Edward Srouji <edwards@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/Makefile |  1 +
 drivers/infiniband/hw/mlx5/dmah.c   | 54 +++++++++++++++++++++++++++++
 drivers/infiniband/hw/mlx5/dmah.h   | 23 ++++++++++++
 drivers/infiniband/hw/mlx5/main.c   |  5 +++
 4 files changed, 83 insertions(+)
 create mode 100644 drivers/infiniband/hw/mlx5/dmah.c
 create mode 100644 drivers/infiniband/hw/mlx5/dmah.h

diff --git a/drivers/infiniband/hw/mlx5/Makefile b/drivers/infiniband/hw/mlx5/Makefile
index 11878ddf7cc7..dd7bb377f491 100644
--- a/drivers/infiniband/hw/mlx5/Makefile
+++ b/drivers/infiniband/hw/mlx5/Makefile
@@ -8,6 +8,7 @@ mlx5_ib-y := ah.o \
 	     cq.o \
 	     data_direct.o \
 	     dm.o \
+	     dmah.o \
 	     doorbell.o \
 	     fs.o \
 	     gsi.o \
diff --git a/drivers/infiniband/hw/mlx5/dmah.c b/drivers/infiniband/hw/mlx5/dmah.c
new file mode 100644
index 000000000000..362a88992ffa
--- /dev/null
+++ b/drivers/infiniband/hw/mlx5/dmah.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#include <rdma/uverbs_std_types.h>
+#include <linux/pci-tph.h>
+#include "dmah.h"
+
+#define UVERBS_MODULE_NAME mlx5_ib
+#include <rdma/uverbs_named_ioctl.h>
+
+static int mlx5_ib_alloc_dmah(struct ib_dmah *ibdmah,
+			      struct uverbs_attr_bundle *attrs)
+{
+	struct mlx5_core_dev *mdev = to_mdev(ibdmah->device)->mdev;
+	struct mlx5_ib_dmah *dmah = to_mdmah(ibdmah);
+	u16 st_bits = BIT(IB_DMAH_CPU_ID_EXISTS) |
+		      BIT(IB_DMAH_MEM_TYPE_EXISTS);
+	int err;
+
+	/* PH is a must for TPH following PCIe spec 6.2-1.0 */
+	if (!(ibdmah->valid_fields & BIT(IB_DMAH_PH_EXISTS)))
+		return -EINVAL;
+
+	/* ST is optional; however, partial data for it is not allowed */
+	if (ibdmah->valid_fields & st_bits) {
+		if ((ibdmah->valid_fields & st_bits) != st_bits)
+			return -EINVAL;
+		err = mlx5_st_alloc_index(mdev, ibdmah->mem_type,
+					  ibdmah->cpu_id, &dmah->st_index);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int mlx5_ib_dealloc_dmah(struct ib_dmah *ibdmah,
+				struct uverbs_attr_bundle *attrs)
+{
+	struct mlx5_ib_dmah *dmah = to_mdmah(ibdmah);
+	struct mlx5_core_dev *mdev = to_mdev(ibdmah->device)->mdev;
+
+	if (ibdmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
+		return mlx5_st_dealloc_index(mdev, dmah->st_index);
+
+	return 0;
+}
+
+const struct ib_device_ops mlx5_ib_dev_dmah_ops = {
+	.alloc_dmah = mlx5_ib_alloc_dmah,
+	.dealloc_dmah = mlx5_ib_dealloc_dmah,
+};
diff --git a/drivers/infiniband/hw/mlx5/dmah.h b/drivers/infiniband/hw/mlx5/dmah.h
new file mode 100644
index 000000000000..68de72b4744a
--- /dev/null
+++ b/drivers/infiniband/hw/mlx5/dmah.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/*
+ * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#ifndef _MLX5_IB_DMAH_H
+#define _MLX5_IB_DMAH_H
+
+#include "mlx5_ib.h"
+
+extern const struct ib_device_ops mlx5_ib_dev_dmah_ops;
+
+struct mlx5_ib_dmah {
+	struct ib_dmah ibdmah;
+	u16 st_index;
+};
+
+static inline struct mlx5_ib_dmah *to_mdmah(struct ib_dmah *ibdmah)
+{
+	return container_of(ibdmah, struct mlx5_ib_dmah, ibdmah);
+}
+
+#endif /* _MLX5_IB_DMAH_H */
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index c521bce2eeff..dbe66894b224 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -50,6 +50,7 @@
 #include <rdma/ib_ucaps.h>
 #include "macsec.h"
 #include "data_direct.h"
+#include "dmah.h"
 
 #define UVERBS_MODULE_NAME mlx5_ib
 #include <rdma/uverbs_named_ioctl.h>
@@ -4181,6 +4182,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	INIT_RDMA_OBJ_SIZE(ib_ah, mlx5_ib_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_counters, mlx5_ib_mcounters, ibcntrs),
 	INIT_RDMA_OBJ_SIZE(ib_cq, mlx5_ib_cq, ibcq),
+	INIT_RDMA_OBJ_SIZE(ib_dmah, mlx5_ib_dmah, ibdmah),
 	INIT_RDMA_OBJ_SIZE(ib_pd, mlx5_ib_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_qp, mlx5_ib_qp, ibqp),
 	INIT_RDMA_OBJ_SIZE(ib_srq, mlx5_ib_srq, ibsrq),
@@ -4308,6 +4310,9 @@ static int mlx5_ib_stage_caps_init(struct mlx5_ib_dev *dev)
 	    MLX5_GENERAL_OBJ_TYPES_CAP_SW_ICM)
 		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_dm_ops);
 
+	if (mdev->st)
+		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_dmah_ops);
+
 	ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_ops);
 
 	if (IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS))
-- 
2.50.0


