Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9173CF5F6
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbhGTHhG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:37:06 -0400
Received: from mail-bn8nam11on2078.outbound.protection.outlook.com ([40.107.236.78]:39200
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234224AbhGTHhD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:37:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMZNSFUByASdX/quJLbc+Lvw4JviXg7UMElkAwx/GxM6nW+aOukMf0ZgM+q8Js7VDjJO458olrYGaYPM1MvzGZKgE5NszwNYy753GzzMytAuk4vftdI9fayWj2LXC52iohtH9t/FF5ONFrQ0j4wzXHS1gDyrP1NfX+uGV3EtNpNCER4x5yi50F1WA9RgS2Xdg8aUYw7FZ0Q+nc1fq94xcM4GZacAT6KPmnssbwCtj+x8i7N+n+UNwsYvH0sEHxsENuANXi0yVsQ3SvZMgpWTt11FjaJb8Pqsn1ZxVr4mmXZl6R5JBqyqWnlK5HDprPETKQSH8vyE8RftRtheFCsqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmSNZrB2B7aVgNse+rQJCWHaV0dIu9XBTSZgI9toLP8=;
 b=dB5OLrDbIy5pwKwt6Pm3R8BYGfNPDbNKWwLfnaaSucvU6aaKEQHPY1/llzdSE41nWuMiaaiqA0XdbOFoO08dEF4w/FX+JtD0Hj/NTeSC8Y+taQZ5KsFuPFS/AWX94nIBO4ntLRziRYM5bnK3HC2NbBC2dmVuBtrLFrldoAXImGQmyws83qBgEMvgHAWxXD6jtN6uHsW5RqltPI9Z7L96OeffQR7K7uog9iLfPvVqU8S7+PeADs2rN6qCqN2SJ3WDzxI9BpFO18eSTVw3amTl+l/Co+IuM4Hjr1XFgIIJciSSRMuMgMNVVS+nJlM5z8Ws9Kvr6aWkbODBPksLiw+v9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmSNZrB2B7aVgNse+rQJCWHaV0dIu9XBTSZgI9toLP8=;
 b=Y073avEtfaSjyc/4ax5fCPmBPpn43hjVs5dZ8mF8mtZrpDrjNMlefD0G2m0VGP/iQWZjXyqoi7W4mx1A/HBZbS+yEFaHuctKAt80mYVyu6umPYl4JbU3zF2edfDj7KA6g9SoUyqtbdac2G/k660UmA+oVU3h9qamYpkd+Swj/qXI4k4gCMj+M5fwtHYcLOloEaxmFFyj4jhBoZ9CbCFn9ewHmJZEOQStQWhpOAm7crbt7U9GaL4FWXu3mhaNBWZ4umUp387A5iGwIXyJlsoiNEJ08frdtK3T5IWGPRKA/i6X9/xZmziQF5HHTXH7b6VUaZRvT3lWwgXu/IVgSbX3Tg==
Received: from BN9PR03CA0045.namprd03.prod.outlook.com (2603:10b6:408:fb::20)
 by MN2PR12MB3999.namprd12.prod.outlook.com (2603:10b6:208:158::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Tue, 20 Jul
 2021 08:17:40 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::ec) by BN9PR03CA0045.outlook.office365.com
 (2603:10b6:408:fb::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 08:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:17:40 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:17:31 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:17:31 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:17:29 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>
Subject: [PATCH rdma-core 02/27] mlx5: Introduce mlx5dv_get_vfio_device_list()
Date:   Tue, 20 Jul 2021 11:16:22 +0300
Message-ID: <20210720081647.1980-3-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6581d4b9-ed8a-447e-a7d4-08d94b56d78c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3999:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3999692A758F0109265302BEC3E29@MN2PR12MB3999.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +wg1/HFoDK/3Z/a77M1PafPbI1ZqDwDhpcQAmeRAmo9pg+h03IC1QhlPc5lU7Ghd6jFiNNMwsueer0pK8TXcSe0Vzqs/WfgCcTZkLVvE4SfOxxDRbVTXEZ5EsuhpCJKxxcRwd5vc4wBAikz9KX9wt7N6SWielXIwOttJxqjn3+W/GsO+tjMD16+s4qdXTf5QM+MHc3l2emzD3vyju2Z4iEgMe29MIisdnkE8BzXLCmR1ALm0hBQXKLvxteLTC7ovrvYu/p0+rWwtlOY1GTtLBowTgMRnQK66s/cSrlBxQIpFKiffYIjsdyXdJvPrEnk61pSVGr/Cz296Q9/Y9u9meMWH17kQX3Ij4L97IDxllgKQLk0dK17UXc5M787kbwkZU8VYCRFlok9gaVODYUU0FgYKTnqF3PmkKqaPhDDXY3aV6rGtllITVPZWyYVd14UhQE0OXoMi7RPTYyvSy58fgGb01xZSlpU7ZTb9FGGJgYc9tPOcDh1Ij72vxdeONJiZJgVE6bXCXyJBo/joxDMI7D3IsRBj8gvh4EoTIFQ9v4zbuvNugrm73K+YTOol9jBkjjVZup4Emw+OqKICHb0/BmAtlYbFHD8wLEI+FB+g/FAeh7Wqn2fSQROANXiPMP6ezuqk4cLqZYHU/c1fxtxPKoOv5Yzlk/BDpy9eFp0vTFtw05P2kZ8sVZGEPtes7Zj7qLWA2QYrmu0Buat9IFU2Gg==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36860700001)(19627235002)(4326008)(83380400001)(7636003)(86362001)(5660300002)(1076003)(70586007)(70206006)(356005)(30864003)(2616005)(47076005)(336012)(508600001)(2906002)(8676002)(426003)(82310400003)(107886003)(6666004)(54906003)(7696005)(8936002)(36756003)(6916009)(186003)(36906005)(316002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:17:40.3516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6581d4b9-ed8a-447e-a7d4-08d94b56d78c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3999
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Introduce mlx5dv_get_vfio_device_list() API for getting list of mlx5
devices which can be used over VFIO.

A man page with the expected usage was added.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 debian/ibverbs-providers.symbols                   |   2 +
 providers/mlx5/CMakeLists.txt                      |   3 +-
 providers/mlx5/libmlx5.map                         |   5 +
 providers/mlx5/man/CMakeLists.txt                  |   1 +
 .../mlx5/man/mlx5dv_get_vfio_device_list.3.md      |  64 +++++++
 providers/mlx5/mlx5.c                              |   4 +-
 providers/mlx5/mlx5.h                              |   1 +
 providers/mlx5/mlx5_vfio.c                         | 190 +++++++++++++++++++++
 providers/mlx5/mlx5_vfio.h                         |  27 +++
 providers/mlx5/mlx5dv.h                            |  13 ++
 10 files changed, 307 insertions(+), 3 deletions(-)
 create mode 100644 providers/mlx5/man/mlx5dv_get_vfio_device_list.3.md
 create mode 100644 providers/mlx5/mlx5_vfio.c
 create mode 100644 providers/mlx5/mlx5_vfio.h

diff --git a/debian/ibverbs-providers.symbols b/debian/ibverbs-providers.symbols
index 294832b..64e29b1 100644
--- a/debian/ibverbs-providers.symbols
+++ b/debian/ibverbs-providers.symbols
@@ -28,6 +28,7 @@ libmlx5.so.1 ibverbs-providers #MINVER#
  MLX5_1.18@MLX5_1.18 34
  MLX5_1.19@MLX5_1.19 35
  MLX5_1.20@MLX5_1.20 36
+ MLX5_1.21@MLX5_1.21 37
  mlx5dv_init_obj@MLX5_1.0 13
  mlx5dv_init_obj@MLX5_1.2 15
  mlx5dv_query_device@MLX5_1.0 13
@@ -133,6 +134,7 @@ libmlx5.so.1 ibverbs-providers #MINVER#
  mlx5dv_map_ah_to_qp@MLX5_1.20 36
  mlx5dv_qp_cancel_posted_send_wrs@MLX5_1.20 36
  _mlx5dv_mkey_check@MLX5_1.20 36
+ mlx5dv_get_vfio_device_list@MLX5_1.21 37
 libefa.so.1 ibverbs-providers #MINVER#
 * Build-Depends-Package: libibverbs-dev
  EFA_1.0@EFA_1.0 24
diff --git a/providers/mlx5/CMakeLists.txt b/providers/mlx5/CMakeLists.txt
index 69abdd1..45e397e 100644
--- a/providers/mlx5/CMakeLists.txt
+++ b/providers/mlx5/CMakeLists.txt
@@ -11,7 +11,7 @@ if (MLX5_MW_DEBUG)
 endif()
 
 rdma_shared_provider(mlx5 libmlx5.map
-  1 1.20.${PACKAGE_VERSION}
+  1 1.21.${PACKAGE_VERSION}
   buf.c
   cq.c
   dbrec.c
@@ -30,6 +30,7 @@ rdma_shared_provider(mlx5 libmlx5.map
   dr_table.c
   dr_send.c
   mlx5.c
+  mlx5_vfio.c
   qp.c
   srq.c
   verbs.c
diff --git a/providers/mlx5/libmlx5.map b/providers/mlx5/libmlx5.map
index af7541d..3e8a4d8 100644
--- a/providers/mlx5/libmlx5.map
+++ b/providers/mlx5/libmlx5.map
@@ -189,3 +189,8 @@ MLX5_1.20 {
 		mlx5dv_qp_cancel_posted_send_wrs;
 		_mlx5dv_mkey_check;
 } MLX5_1.19;
+
+MLX5_1.21 {
+        global:
+		mlx5dv_get_vfio_device_list;
+} MLX5_1.20;
diff --git a/providers/mlx5/man/CMakeLists.txt b/providers/mlx5/man/CMakeLists.txt
index bb6499d..91aebed 100644
--- a/providers/mlx5/man/CMakeLists.txt
+++ b/providers/mlx5/man/CMakeLists.txt
@@ -22,6 +22,7 @@ rdma_man_pages(
   mlx5dv_dump.3.md
   mlx5dv_flow_action_esp.3.md
   mlx5dv_get_clock_info.3
+  mlx5dv_get_vfio_device_list.3.md
   mlx5dv_init_obj.3
   mlx5dv_is_supported.3.md
   mlx5dv_map_ah_to_qp.3.md
diff --git a/providers/mlx5/man/mlx5dv_get_vfio_device_list.3.md b/providers/mlx5/man/mlx5dv_get_vfio_device_list.3.md
new file mode 100644
index 0000000..13c8e63
--- /dev/null
+++ b/providers/mlx5/man/mlx5dv_get_vfio_device_list.3.md
@@ -0,0 +1,64 @@
+---
+layout: page
+title: mlx5dv_get_vfio_device_list
+section: 3
+tagline: Verbs
+---
+
+# NAME
+
+mlx5dv_get_vfio_device_list - Get list of available devices to be used over VFIO
+
+# SYNOPSIS
+
+```c
+#include <infiniband/mlx5dv.h>
+
+struct ibv_device **
+mlx5dv_get_vfio_device_list(struct mlx5dv_vfio_context_attr *attr);
+```
+
+# DESCRIPTION
+
+Returns a NULL-terminated array of devices based on input *attr*.
+
+# ARGUMENTS
+
+*attr*
+:	Describe the VFIO devices to return in list.
+
+## *attr* argument
+
+```c
+struct mlx5dv_vfio_context_attr {
+	const char *pci_name;
+	uint32_t flags;
+	uint64_t comp_mask;
+};
+```
+*pci_name*
+:      The PCI name of the required device.
+
+*flags*
+:       A bitwise OR of the various values described below.
+
+        *MLX5DV_VFIO_CTX_FLAGS_INIT_LINK_DOWN*:
+        Upon device initialization link should stay down.
+
+*comp_mask*
+:       Bitmask specifying what fields in the structure are valid.
+
+# RETURN VALUE
+Returns the array of the matching devices, or sets errno and returns NULL if the request fails.
+
+# NOTES
+Client  code  should open all the devices it intends to use with ibv_open_device() before calling ibv_free_device_list().  Once it frees the array with ibv_free_device_list(), it will be able to
+use only the open devices; pointers to unopened devices will no longer be valid.
+
+# SEE ALSO
+
+*ibv_open_device(3)* *ibv_free_device_list(3)*
+
+# AUTHOR
+
+Yishai Hadas <yishaih@nvidia.com>
diff --git a/providers/mlx5/mlx5.c b/providers/mlx5/mlx5.c
index e172b9d..46d7748 100644
--- a/providers/mlx5/mlx5.c
+++ b/providers/mlx5/mlx5.c
@@ -62,7 +62,7 @@ static void mlx5_free_context(struct ibv_context *ibctx);
 #endif
 
 #define HCA(v, d) VERBS_PCI_MATCH(PCI_VENDOR_ID_##v, d, NULL)
-static const struct verbs_match_ent hca_table[] = {
+const struct verbs_match_ent mlx5_hca_table[] = {
 	VERBS_DRIVER_ID(RDMA_DRIVER_MLX5),
 	HCA(MELLANOX, 0x1011),	/* MT4113 Connect-IB */
 	HCA(MELLANOX, 0x1012),	/* Connect-IB Virtual Function */
@@ -2410,7 +2410,7 @@ static const struct verbs_device_ops mlx5_dev_ops = {
 	.name = "mlx5",
 	.match_min_abi_version = MLX5_UVERBS_MIN_ABI_VERSION,
 	.match_max_abi_version = MLX5_UVERBS_MAX_ABI_VERSION,
-	.match_table = hca_table,
+	.match_table = mlx5_hca_table,
 	.alloc_device = mlx5_device_alloc,
 	.uninit_device = mlx5_uninit_device,
 	.alloc_context = mlx5_alloc_context,
diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
index ac2f88c..3862007 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -94,6 +94,7 @@ enum {
 
 extern uint32_t mlx5_debug_mask;
 extern int mlx5_freeze_on_error_cqe;
+extern const struct verbs_match_ent mlx5_hca_table[];
 
 #ifdef MLX5_DEBUG
 #define mlx5_dbg(fp, mask, format, arg...)				\
diff --git a/providers/mlx5/mlx5_vfio.c b/providers/mlx5/mlx5_vfio.c
new file mode 100644
index 0000000..69c7662
--- /dev/null
+++ b/providers/mlx5/mlx5_vfio.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#define _GNU_SOURCE
+#include <config.h>
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <string.h>
+#include <sys/param.h>
+
+#include "mlx5dv.h"
+#include "mlx5_vfio.h"
+#include "mlx5.h"
+
+static struct verbs_context *
+mlx5_vfio_alloc_context(struct ibv_device *ibdev,
+			int cmd_fd, void *private_data)
+{
+	return NULL;
+}
+
+static void mlx5_vfio_uninit_device(struct verbs_device *verbs_device)
+{
+	struct mlx5_vfio_device *dev = to_mvfio_dev(&verbs_device->device);
+
+	free(dev->pci_name);
+	free(dev);
+}
+
+static const struct verbs_device_ops mlx5_vfio_dev_ops = {
+	.name = "mlx5_vfio",
+	.alloc_context = mlx5_vfio_alloc_context,
+	.uninit_device = mlx5_vfio_uninit_device,
+};
+
+static bool is_mlx5_pci(const char *pci_path)
+{
+	const struct verbs_match_ent *ent;
+	uint16_t vendor_id, device_id;
+	char pci_info_path[256];
+	char buff[128];
+	int fd;
+
+	snprintf(pci_info_path, sizeof(pci_info_path), "%s/vendor", pci_path);
+	fd = open(pci_info_path, O_RDONLY);
+	if (fd < 0)
+		return false;
+
+	if (read(fd, buff, sizeof(buff)) <= 0)
+		goto err;
+
+	vendor_id = strtoul(buff, NULL, 0);
+	close(fd);
+
+	snprintf(pci_info_path, sizeof(pci_info_path), "%s/device", pci_path);
+	fd = open(pci_info_path, O_RDONLY);
+	if (fd < 0)
+		return false;
+
+	if (read(fd, buff, sizeof(buff)) <= 0)
+		goto err;
+
+	device_id = strtoul(buff, NULL, 0);
+	close(fd);
+
+	for (ent = mlx5_hca_table; ent->kind != VERBS_MATCH_SENTINEL; ent++) {
+		if (ent->kind != VERBS_MATCH_PCI)
+			continue;
+		if (ent->device == device_id && ent->vendor == vendor_id)
+			return true;
+	}
+
+	return false;
+
+err:
+	close(fd);
+	return false;
+}
+
+static int mlx5_vfio_get_iommu_group_id(const char *pci_name)
+{
+	int seg, bus, slot, func;
+	int ret, groupid;
+	char path[128], iommu_group_path[128], *group_name;
+	struct stat st;
+	ssize_t len;
+
+	ret = sscanf(pci_name, "%04x:%02x:%02x.%d", &seg, &bus, &slot, &func);
+	if (ret != 4)
+		return -1;
+
+	snprintf(path, sizeof(path),
+		 "/sys/bus/pci/devices/%04x:%02x:%02x.%01x/",
+		 seg, bus, slot, func);
+
+	ret = stat(path, &st);
+	if (ret < 0)
+		return -1;
+
+	if (!is_mlx5_pci(path))
+		return -1;
+
+	strncat(path, "iommu_group", sizeof(path) - strlen(path) - 1);
+
+	len = readlink(path, iommu_group_path, sizeof(iommu_group_path));
+	if (len <= 0)
+		return -1;
+
+	iommu_group_path[len] = 0;
+	group_name = basename(iommu_group_path);
+
+	if (sscanf(group_name, "%d", &groupid) != 1)
+		return -1;
+
+	snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
+	ret = stat(path, &st);
+	if (ret < 0)
+		return -1;
+
+	return groupid;
+}
+
+static int mlx5_vfio_get_handle(struct mlx5_vfio_device *vfio_dev,
+			 struct mlx5dv_vfio_context_attr *attr)
+{
+	int iommu_group;
+
+	iommu_group = mlx5_vfio_get_iommu_group_id(attr->pci_name);
+	if (iommu_group < 0)
+		return -1;
+
+	sprintf(vfio_dev->vfio_path, "/dev/vfio/%d", iommu_group);
+	vfio_dev->pci_name = strdup(attr->pci_name);
+
+	return 0;
+}
+
+struct ibv_device **
+mlx5dv_get_vfio_device_list(struct mlx5dv_vfio_context_attr *attr)
+{
+	struct mlx5_vfio_device *vfio_dev;
+	struct ibv_device **list = NULL;
+	int err;
+
+	if (!check_comp_mask(attr->comp_mask, 0) ||
+	    !check_comp_mask(attr->flags, MLX5DV_VFIO_CTX_FLAGS_INIT_LINK_DOWN)) {
+		errno = EOPNOTSUPP;
+		return NULL;
+	}
+
+	list = calloc(1, sizeof(struct ibv_device *));
+	if (!list) {
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	vfio_dev = calloc(1, sizeof(*vfio_dev));
+	if (!vfio_dev) {
+		errno = ENOMEM;
+		goto end;
+	}
+
+	vfio_dev->vdev.ops = &mlx5_vfio_dev_ops;
+	atomic_init(&vfio_dev->vdev.refcount, 1);
+
+	/* Find the vfio handle for attrs, store in mlx5_vfio_device */
+	err = mlx5_vfio_get_handle(vfio_dev, attr);
+	if (err)
+		goto err_get;
+
+	vfio_dev->flags = attr->flags;
+	vfio_dev->page_size = sysconf(_SC_PAGESIZE);
+
+	list[0] = &vfio_dev->vdev.device;
+	return list;
+
+err_get:
+	free(vfio_dev);
+end:
+	free(list);
+	return NULL;
+}
diff --git a/providers/mlx5/mlx5_vfio.h b/providers/mlx5/mlx5_vfio.h
new file mode 100644
index 0000000..6ba4254
--- /dev/null
+++ b/providers/mlx5/mlx5_vfio.h
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#ifndef MLX5_VFIO_H
+#define MLX5_VFIO_H
+
+#include <stddef.h>
+#include <stdio.h>
+
+#include <infiniband/driver.h>
+
+struct mlx5_vfio_device {
+	struct verbs_device vdev;
+	char *pci_name;
+	char vfio_path[IBV_SYSFS_PATH_MAX];
+	int page_size;
+	uint32_t flags;
+};
+
+static inline struct mlx5_vfio_device *to_mvfio_dev(struct ibv_device *ibdev)
+{
+	return container_of(ibdev, struct mlx5_vfio_device, vdev.device);
+}
+
+#endif
diff --git a/providers/mlx5/mlx5dv.h b/providers/mlx5/mlx5dv.h
index 2eba232..e657527 100644
--- a/providers/mlx5/mlx5dv.h
+++ b/providers/mlx5/mlx5dv.h
@@ -1474,6 +1474,19 @@ struct mlx5dv_context_attr {
 
 bool mlx5dv_is_supported(struct ibv_device *device);
 
+enum mlx5dv_vfio_context_attr_flags {
+	MLX5DV_VFIO_CTX_FLAGS_INIT_LINK_DOWN = 1 << 0,
+};
+
+struct mlx5dv_vfio_context_attr {
+	const char *pci_name;
+	uint32_t flags; /* Use enum mlx5dv_vfio_context_attr_flags */
+	uint64_t comp_mask;
+};
+
+struct ibv_device **
+mlx5dv_get_vfio_device_list(struct mlx5dv_vfio_context_attr *attr);
+
 struct ibv_context *
 mlx5dv_open_device(struct ibv_device *device, struct mlx5dv_context_attr *attr);
 
-- 
1.8.3.1

