Return-Path: <linux-rdma+bounces-12080-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE14B02EF6
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 08:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D6A166463
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 06:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EAB19E96A;
	Sun, 13 Jul 2025 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKWam5gf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC504197A6C
	for <linux-rdma@vger.kernel.org>; Sun, 13 Jul 2025 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752388682; cv=none; b=HvVYd9Hs+HkeSKQJ56Mv/l66HlM1ZIfbhMjPGuWlU3uuGZ+WnOVzqZMbPxul/B0AX7pSLqH5Xupr3pJLj6T8ALQ8CvNxIL/KL30vj/BsbFyn/ZYdr2/b5WoQSCldgRyqGlZhgytBXzNmKGM42iueEeeDDH9rcKpvti5dxpInuMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752388682; c=relaxed/simple;
	bh=DYwVd7n+2m5nXrf/LfckNG1IMpv5V11pwX6vriNAkWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLyovMcHmD68qd2mb4S4Biob/a0ov99V9o3r6I+fhGPRFWDvXsXUlREe4BAVpCVd/LjwAkZODUgi25RBk2Lk//RH7e5AH6MJz6Ahs0D9gZz6PuubFYVZzSa8PXMWF+J5rt6FhvH22QxSM/S3Dmc68isyI+gYm9s/5v1XSYZynuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKWam5gf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E2AC4CEE3;
	Sun, 13 Jul 2025 06:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752388682;
	bh=DYwVd7n+2m5nXrf/LfckNG1IMpv5V11pwX6vriNAkWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CKWam5gf2g04OpCgffyflmBmmP4LXezQPyxmTUS/tW0D/S0bAzHPAglC2JO4saFP/
	 H7Wvyh3qC+1JlIXI2WW/mPBJbTTajSqqVFW+60XOdqLh0kU5fHUG4iffMjmqxMTApE
	 hO/dUbJgSLHKtNvhwAiKPvF18vfGNuE1Bbb8wJynBZ9agO1zTZB0K3AKdj5NQzDtcO
	 qViwxphu1JqP1SbPbvZ2SmV908r7I1A5gHcevZr4NMgO8X5HF/dYeTpDB3rph+87Al
	 7ggdk6C12HHs+bZd8zEJKI6S0Ezb+LIoxxQNdWO60kBtybSKusv+qFiAL+grgwsQWi
	 SMNc6QZCPl4BQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 6/8] RDMA/mlx5: Add DMAH object support
Date: Sun, 13 Jul 2025 09:37:27 +0300
Message-ID: <ce0a44b2eb00ae67ddd14e2f54b94c07c09f02b6.1752388126.git.leon@kernel.org>
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
2.50.1


