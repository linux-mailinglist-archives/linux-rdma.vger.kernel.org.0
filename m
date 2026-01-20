Return-Path: <linux-rdma+bounces-15737-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4746DD3C165
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 38A6D44518B
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 08:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D4F3BB9E9;
	Tue, 20 Jan 2026 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P8+6kP2M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B614E3B8D5B;
	Tue, 20 Jan 2026 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895932; cv=fail; b=a3TyCaQXsr00NQl3WvyUA+sqcCEe0UDpnQlS9g9WY9e/nIonomqrBKO55RuYvbsztlc0pBu8L3Qc6CGfirjrb+yiwS6X2f81cRCBQf4jSmJKaMzuG7L0xfGcfY5mzkYM3faHl9MGjxlvTUa2zf9O0dOR0AYmHHJ5U4mQf0zo/Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895932; c=relaxed/simple;
	bh=nBtMJd+3hkvSoU6PrNskqfdNZsmPSEsCiJPZwwVf390=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PB4QWc7GRuiywimbhTp4on6E+P9i2ZRm+YWJQVtfuqsMXPRjY44n6ZB5wKgnNGFa3fuPNIKPsCM2EwkX4qgNz0okwo2nDRhgn6Sq1uFI42WnXVqxNsPX4XmfpsUKpUChlBuEBcSvhwz9JgodDSU15dN/627PiQ+vDCHbqXbIwdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P8+6kP2M; arc=fail smtp.client-ip=52.101.52.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9tqaj4tlO8ViT3mDR1+UjaeXR5WrCwfLq2iM2shMTecELgc/KQGQqsS1DmT6aE5fmWgbrzSY+AI0mod44F2zswlfPhYOsVer5H3Hl2iVb5lKHTR5UmoPWKo2WzoYjU/32s1WJgqlPhG2eVp6WC35dCld/yGvI2cMVYEk1LA5pSDQ/+tjv35ts8ghXgZBvO8XLb+A2a9Vpwkhz5dMSWPgsPQvHtR1LaEDkAGObA6K6U1AZiJ1pi4lPLyId7b4E1FkRZKif3nCDToXHleVYeoIVPXV0Uzt4hxnbDqAZj3dHo2wCMbWsGgovvQDQ4/i2ENECFOo4jVMIgC6PhnYgw28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwt4JzvHHI1Y/vwTzWObSNYmSbVYxiK4dsVaYneuqtQ=;
 b=BDloltcgfuQvOK73ZSmjK7T4cvAjZaQoWZfDkLvjivtZSDaOq5pxEIChnJJWb7DQi/POtkKev1s8fHFHFQLatG6zFz0Pmpkpss4/GQjMSgm6kpc1vD3E3raJ8axARttypr//lo8md6HHrOlQUCqbj0U28wtUWUFDMO1rhaaEfeZivuMjCe1VF8eOZuITAXbbL1uvsQCYTJ6uOSgXnvHRF7IJ8GfOaOnTuSsEDSXSOXMvaAIZ6JTqTn97SBKPaZhJQH3/J6fh/6LftELd2wNAmWNF0YELUu3wJfacC6AssF1mK8O+UvnBjb3g5gT5+jn7l1RaLkCcKdDFT5opKxG2lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwt4JzvHHI1Y/vwTzWObSNYmSbVYxiK4dsVaYneuqtQ=;
 b=P8+6kP2MhTEKPot9jbh4+1EqJRzGH4ZT/bPMv6k6K08QPUamgG3RldgL+ezfEiXpH3FZyrs/nS/+Z3kLLUDz5hA3yd979WkTZIowEkzDIx9R7+ZbgSoE+oRIicktX8F42xnjmUz3PLqj1XzJGnhNb6+efnX6KlV+wLg8rXelbC8Qfiu67CCcWupcuXWS1yhs4x7scDzaK1ifNwk0LCXILmEc70Fesy77MDusLIhdtJ3gFdA7MibHxwY9RgXM3u4R+NAOoEFb09L9VKTkc805iFWwQ1w17IYPmS6MFt2rxZ6Wwq8AowfeOTt5Joq98RscCNyyBl6EzNUfTe0RU1Pmnw==
Received: from BLAPR03CA0106.namprd03.prod.outlook.com (2603:10b6:208:32a::21)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Tue, 20 Jan
 2026 07:58:46 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::9d) by BLAPR03CA0106.outlook.office365.com
 (2603:10b6:208:32a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 07:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 07:58:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 23:58:33 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 19 Jan 2026 23:58:32 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 23:58:27 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
	<rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>
Subject: [PATCH net-next V5 02/15] devlink: introduce shared devlink instance for PFs on same chip
Date: Tue, 20 Jan 2026 09:57:45 +0200
Message-ID: <1768895878-1637182-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1768895878-1637182-1-git-send-email-tariqt@nvidia.com>
References: <1768895878-1637182-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: 773a822d-5e57-4be6-980e-08de57f9bcd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1B7ebKeThYNEWPjJk7pMWQd5TrEh/Vzdf21K6TFbmTWmJwZNhTDt85z4CZVI?=
 =?us-ascii?Q?ecTWQOaRg4/BXcSn+2VfDDdHaq/XZmR/pramusfFaG4etfURru4nzjdq3rvs?=
 =?us-ascii?Q?b6tVw4MA0xcGQszPwzAd3dBaa6ptOI1j9qZdnuhOQjfBorCvut4wJ5cAV3Dl?=
 =?us-ascii?Q?0v7FUxE0dvzyMRlxWwsWX6sQS+At85K5o1edyR9oXwiBxC/ENXXqkc1MzcEQ?=
 =?us-ascii?Q?rb70b87A9phjoyYLMW4ZIM7qonUGeoEzeD031C/fQLss4OS8MTdMItusrqMa?=
 =?us-ascii?Q?tsorrvYSIo/UTv8Qw+WMMBF1LzF5EpJHDIAly0igj8J02pCoW5sxRzMmV3C3?=
 =?us-ascii?Q?BwQEVZzSeM/LQCK9RV/2WjRgZrjRm46tz2oULg0P9oZJch9+J4F6iOgoLR4u?=
 =?us-ascii?Q?h4gHvBm8yL3QFwcItLy9cfbrWvN76F4IY0DHdkWVMLfXTrTZRFMpngDNoRnu?=
 =?us-ascii?Q?hoeEwnd8y9i5CpxGnAUbfbraRtEyJisGpO2rA/fa8C9hbmfhHD/gO43HO0t9?=
 =?us-ascii?Q?EiZDIPfi/SIaEQIwC88OG+h1ATotH2C+BbjHPU3mPoJ3XP/dYJeTHwWL7RN3?=
 =?us-ascii?Q?mFa/kzqNFYcQ9AYyyD9pYX7zc559rJJN2sn3SvQz+/alUPbsLbOM+ln0oy/A?=
 =?us-ascii?Q?qvogDdnaSoGmkupYLg9lhKxnyZ1ZreTagUQDZFNTmZxk5k3E3m7sSo7czftP?=
 =?us-ascii?Q?iizDh+OyHzDK6AgFMyQ47HDetDwikvr4C6p0WJPZpUu/gSIOhA8ehA82v3vW?=
 =?us-ascii?Q?kfIz8rC/jzVbu/xv9UqilQjkgwALdczTjrwentF4kANQ8dvpur0zFcyhZ2Iz?=
 =?us-ascii?Q?aG7XTH36QIyNTELwTo6x6LpSFEQSlmW4tTb5D2sLB7JlxDG1D9aU8BTaPG1T?=
 =?us-ascii?Q?LP41f3LCsyBaOarDe7x6zyLASOP5z1vkEvNyunwyFxKubhxZz/1r/wNEmHm9?=
 =?us-ascii?Q?SVBRu63FEv0ZlIkra8N0/fe/6h6KpHS2NstKrID0WoO3Hi10wHvP1bJzkK0t?=
 =?us-ascii?Q?xCxi0xc6J2C4k0INIbEXdyH7mmt+tWC3nr3mf0zyd8sGPnqoS6H3ZVXJixdK?=
 =?us-ascii?Q?dQ6VxqwIpD3zhwpRWlSDLxRI33HwMth/ParfGXxuhXQrsJ5vqmndrs2ctSH8?=
 =?us-ascii?Q?ksDw/2PG0cbtR8gN/ycjIDfSNoJXJ3nUSXTf1HYuXxOfZrJjBIDdvCVOHqh/?=
 =?us-ascii?Q?IS2WyzbacVYemiAlp2jN+0aMHlSAhxbiysDuGR130TIdd933dsiny+leArLJ?=
 =?us-ascii?Q?i3bDiknBrENN+zi82i3xf13q4UtOIN14CkQSo4LuAFZYpalJtA+nqdGaBQJo?=
 =?us-ascii?Q?P04q4gYnDi+Nk2B5Os/rhzqWcX6z+JAOamrAO0w8oTF/bnBxLD/bKaSQTzIP?=
 =?us-ascii?Q?2TjqoZ+mN9QDL8RgA7IzaBOXgM/DFpB4QOl5MiC2xzsYeJG4e5i+1dRPk/+4?=
 =?us-ascii?Q?tjzsetuQi531eSrdnofyPgPHHeicB6RhU5tb08euIifa5+Znuibjo/LPQqGC?=
 =?us-ascii?Q?jNSjRA+OjWTPIVqHbGFaXdNpzUHq6JgwF6JtfH3WHSVebgLAGPQn4l48WajD?=
 =?us-ascii?Q?GQQY6AOQzII3noNXEPfDqhISpA06GlYjKghRA/DUc5efQJcH0P2PUZr2DgXl?=
 =?us-ascii?Q?rONop0WX1eEu+wcHQP7LLIRRz6nXdRcrALhOZ9XV7AYoKXV50bi/drIJFsUX?=
 =?us-ascii?Q?zYR7TA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(30052699003)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:58:45.7686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 773a822d-5e57-4be6-980e-08de57f9bcd0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325

From: Jiri Pirko <jiri@nvidia.com>

Multiple PFs may reside on the same physical chip, running a single
firmware. Some of the resources and configurations may be shared among
these PFs. Currently, there is no good object to pin the configuration
knobs on.

Introduce a shared devlink instance, instantiated upon probe of the
first PF and removed during remove of the last PF. The shared devlink
instance is backed by a faux device, as there is no PCI device related
to it. The implementation uses reference counting to manage the
lifecycle: each PF that probes calls devlink_shd_get() to get or create
the shared instance, and calls devlink_shd_put() when it removes. The
shared instance is automatically destroyed when the last PF removes.

Example:

$ devlink dev
pci/0000:08:00.0:
  nested_devlink:
    auxiliary/mlx5_core.eth.0
faux/mlx5_core_83013c12b77faa1a30000c82a1045c91:
  nested_devlink:
    pci/0000:08:00.0
    pci/0000:08:00.1
auxiliary/mlx5_core.eth.0
pci/0000:08:00.1:
  nested_devlink:
    auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.1

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/net/devlink.h |   6 ++
 net/devlink/Makefile  |   2 +-
 net/devlink/sh_dev.c  | 163 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+), 1 deletion(-)
 create mode 100644 net/devlink/sh_dev.c

diff --git a/include/net/devlink.h b/include/net/devlink.h
index cb839e0435a1..c453faec8ebf 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1644,6 +1644,12 @@ void devlink_register(struct devlink *devlink);
 void devlink_unregister(struct devlink *devlink);
 void devlink_free(struct devlink *devlink);
 
+struct devlink *devlink_shd_get(const char *id,
+				const struct devlink_ops *ops,
+				size_t priv_size);
+void devlink_shd_put(struct devlink *devlink);
+void *devlink_shd_get_priv(struct devlink *devlink);
+
 /**
  * struct devlink_port_ops - Port operations
  * @port_split: Callback used to split the port into multiple ones.
diff --git a/net/devlink/Makefile b/net/devlink/Makefile
index 000da622116a..8f2adb5e5836 100644
--- a/net/devlink/Makefile
+++ b/net/devlink/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y := core.o netlink.o netlink_gen.o dev.o port.o sb.o dpipe.o \
-	 resource.o param.o region.o health.o trap.o rate.o linecard.o
+	 resource.o param.o region.o health.o trap.o rate.o linecard.o sh_dev.o
diff --git a/net/devlink/sh_dev.c b/net/devlink/sh_dev.c
new file mode 100644
index 000000000000..acc8d549aaae
--- /dev/null
+++ b/net/devlink/sh_dev.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/device/faux.h>
+#include <net/devlink.h>
+
+#include "devl_internal.h"
+
+static LIST_HEAD(shd_list);
+static DEFINE_MUTEX(shd_mutex); /* Protects shd_list and shd->list */
+
+/* This structure represents a shared devlink instance,
+ * there is one created per identifier (e.g., serial number).
+ */
+struct devlink_shd {
+	struct list_head list; /* Node in shd list */
+	const char *id; /* Identifier string (e.g., serial number) */
+	struct faux_device *faux_dev; /* Related faux device */
+	refcount_t refcount; /* Reference count */
+	char priv[] __aligned(NETDEV_ALIGN); /* Driver private data */
+};
+
+static struct devlink_shd *devlink_shd_lookup(const char *id)
+{
+	struct devlink_shd *shd;
+
+	list_for_each_entry(shd, &shd_list, list) {
+		if (!strcmp(shd->id, id))
+			return shd;
+	}
+
+	return NULL;
+}
+
+static struct devlink_shd *devlink_shd_create(const char *id,
+					      const struct devlink_ops *ops,
+					      size_t priv_size)
+{
+	struct faux_device *faux_dev;
+	struct devlink_shd *shd;
+	struct devlink *devlink;
+
+	/* Create faux device - probe will be called synchronously */
+	faux_dev = faux_device_create(id, NULL, NULL);
+	if (!faux_dev)
+		return NULL;
+
+	devlink = devlink_alloc(ops, sizeof(struct devlink_shd) + priv_size,
+				&faux_dev->dev);
+	if (!devlink)
+		goto err_devlink_alloc;
+	shd = devlink_priv(devlink);
+
+	shd->id = kstrdup(id, GFP_KERNEL);
+	if (!shd->id)
+		goto err_kstrdup_id;
+	shd->faux_dev = faux_dev;
+	refcount_set(&shd->refcount, 1);
+
+	devl_lock(devlink);
+	devl_register(devlink);
+	devl_unlock(devlink);
+
+	list_add_tail(&shd->list, &shd_list);
+
+	return shd;
+
+err_kstrdup_id:
+	devlink_free(devlink);
+
+err_devlink_alloc:
+	faux_device_destroy(faux_dev);
+	return NULL;
+}
+
+static void devlink_shd_destroy(struct devlink_shd *shd)
+{
+	struct devlink *devlink = priv_to_devlink(shd);
+	struct faux_device *faux_dev = shd->faux_dev;
+
+	list_del(&shd->list);
+	devl_lock(devlink);
+	devl_unregister(devlink);
+	devl_unlock(devlink);
+	kfree(shd->id);
+	devlink_free(devlink);
+	faux_device_destroy(faux_dev);
+}
+
+/**
+ * devlink_shd_get - Get or create a shared devlink instance
+ * @id: Identifier string (e.g., serial number) for the shared instance
+ * @ops: Devlink operations structure
+ * @priv_size: Size of private data structure
+ *
+ * Get an existing shared devlink instance identified by @id, or create
+ * a new one if it doesn't exist. The device is automatically added to
+ * the shared instance's device list. Return the devlink instance
+ * with a reference held. The caller must call devlink_shd_put() when done.
+ *
+ * Return: Pointer to the shared devlink instance on success,
+ *         NULL on failure
+ */
+struct devlink *devlink_shd_get(const char *id,
+				const struct devlink_ops *ops,
+				size_t priv_size)
+{
+	struct devlink_shd *shd;
+
+	if (WARN_ON(!id || !ops))
+		return NULL;
+
+	mutex_lock(&shd_mutex);
+
+	shd = devlink_shd_lookup(id);
+	if (!shd)
+		shd = devlink_shd_create(id, ops, priv_size);
+	else
+		refcount_inc(&shd->refcount);
+
+	mutex_unlock(&shd_mutex);
+	return shd ? priv_to_devlink(shd) : NULL;
+}
+EXPORT_SYMBOL_GPL(devlink_shd_get);
+
+/**
+ * devlink_shd_put - Release a reference on a shared devlink instance
+ * @devlink: Shared devlink instance
+ *
+ * Release a reference on a shared devlink instance obtained via
+ * devlink_shd_get().
+ */
+void devlink_shd_put(struct devlink *devlink)
+{
+	struct devlink_shd *shd;
+
+	if (WARN_ON(!devlink))
+		return;
+
+	mutex_lock(&shd_mutex);
+	shd = devlink_priv(devlink);
+	if (refcount_dec_and_test(&shd->refcount))
+		devlink_shd_destroy(shd);
+	mutex_unlock(&shd_mutex);
+}
+EXPORT_SYMBOL_GPL(devlink_shd_put);
+
+/**
+ * devlink_shd_get_priv - Get private data from shared devlink instance
+ * @devlink: Devlink instance
+ *
+ * Returns a pointer to the driver's private data structure within
+ * the shared devlink instance.
+ *
+ * Return: Pointer to private data
+ */
+void *devlink_shd_get_priv(struct devlink *devlink)
+{
+	struct devlink_shd *shd = devlink_priv(devlink);
+
+	return shd->priv;
+}
+EXPORT_SYMBOL_GPL(devlink_shd_get_priv);
-- 
2.44.0


