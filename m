Return-Path: <linux-rdma+bounces-14769-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FE3C86F1B
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 21:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BAD33530F2
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 20:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A8733F8B4;
	Tue, 25 Nov 2025 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jILAQUoT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013043.outbound.protection.outlook.com [40.93.196.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3821033BBA0;
	Tue, 25 Nov 2025 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101280; cv=fail; b=cppN5OEv2VxoNsxtbhWxtOnqKyhiw8/qTlZntwv0l5nino+OzXCBG2RYAQ3LOCgy0C4whGhTE811tBqFtY+lTSBOTLIBSmOxHsbcGLr4d3SUWYVSePLW3DDa6TDNYphavl0gyrG/BJGGMJ/2SfhXTt7tTen8NNDf2GGQTsoAYOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101280; c=relaxed/simple;
	bh=6IcInnTRJCj0yAcET5rTQb1VR06ZxyPT/b1zQWPLppI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXyD9zNvR4RR12ZVoCuqeuVYUGaWvnbrvOe0UG3SD3fCgUA6Hny6OcGZNW4HnaD3EIkAkhvoAvbefTdvsWbCzfgXsPGSiQOvGJxJPodRquV4pQUfm1d3YYVVKDupXREAwHT8vdp890SJxYHGGjfp2IbhPFNgLzIYL2q9pkgzLW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jILAQUoT; arc=fail smtp.client-ip=40.93.196.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrkcE5b335koNEB288dNWQLdPEUBK3hXmDIAK1IP0TS31+m1lXIHEh2a57xNC9A82xnFWWMj4DyqvfgFm/PkOsNRi+Y6huxOuclRT5o14s08cbj818xh93HL7xxGCxiiMYmvZ7F8reeah9wIxrPZCss1GWOfRsX/3r/XhzpBiEsSI54TDkW0ilkdJ+iZzsnO3sLHUoh7Ybx/B3T5lkQkbdamM+j9HTV30h3p7ZOwt6sUrCiJFN9aQRP/6y/d0G2baNcIb8/lwei5Dnj9O0FBL83S8qHjxMRQIEmionWg2h2cPMyu7fUuxETcA9zD84CSVpnrM8GCQBKm0VxIXK5t+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kXsQQq/EzcLLFh1j35ysWyoWYfVT7TeApCinTU/kNc=;
 b=AUwDJo/inh+KCZv6l1X86vn5OtsT4NTms/oLk+T2fcKFefhe3qzAb3NS84ENLw+zWA6UUDbPdGDEDtmfYWa+S+fQcizNb2Jjp1MFyyGrUUnzk+N3W3UdMB7ktOb+hvaTAfwr2ddI5AKfGt/Lxa4nBtIkIe7PDLmjMBRvKaQrq+UWqC2qDt14OF2WOoppNBetQoK6lKGUkYz++w7p3X59lraVtvVo4UnVfO0BzZG9whttX2M78YSdfJ9GFekHMX96N4TPsVZG6rFtWxPdaqnX/DjD+fvuGkMj7Jklj7jl82BDnaAbxXL/pHfel2zJ2NGEJ9NgxE+3A1N7BfHWyHBAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kXsQQq/EzcLLFh1j35ysWyoWYfVT7TeApCinTU/kNc=;
 b=jILAQUoTzVWeWfVJ71BM0pVwlBCtykiWkZbCQeD4TK3jab771egX0SL1r5ixHuO6NKmch09G7Q6s9mY0y4L+tFNo7x6WXbM34+LfuyHJoeZOHboq4VUHadyBIf5YwKJWTwwpEwBcsUpgiS3gls7BNIcHETTPqLxyxQlYjb4SjMukZcDnRJegkM4rBOY4rpPjLaD7OMI8uz+qCqoiJE78SufGoqfCcz2+g+ZBnvMrQhrgwabJNLVYDMdYhw58xffOMV1nfhPhe+ZZAy06nhp9F07Fz9Rq0zQ2HEjT16erJypsu70+ibJmg+Sc2mkeGjQhx2CnGDXwHeKDWbHAdWKxVQ==
Received: from BY3PR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:254::21)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Tue, 25 Nov
 2025 20:07:50 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::3a) by BY3PR05CA0016.outlook.office365.com
 (2603:10b6:a03:254::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.4 via Frontend Transport; Tue,
 25 Nov 2025 20:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 20:07:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:07:28 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:07:28 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 25
 Nov 2025 12:07:22 -0800
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
	<rdunlap@infradead.org>
Subject: [PATCH net-next V4 09/14] net/mlx5: Introduce shared devlink instance for PFs on same chip
Date: Tue, 25 Nov 2025 22:06:08 +0200
Message-ID: <1764101173-1312171-10-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
References: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 873b9ee6-3acd-458f-e5e9-08de2c5e4f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ii9WF5FKgT27+claBYmohVFwFMyySAjWE9IKkgFVsdSUXHpmOEEAT0EkqUNe?=
 =?us-ascii?Q?2eAuf4Hk98ER0Qwyw0C8oxmzs9LWdcHSnva62kIOGtDStahwrcNlboE9xaKf?=
 =?us-ascii?Q?ejqDj2sNkaHeLVkwclQ0dTRzrBAkuODcIcQ+QzEBFVdYztX41ow1QF0DnQG+?=
 =?us-ascii?Q?IWSH3Wz8JiTI65riaLBRw9VlGnK5Q7ds9d35W8lsM6ZsIvAadijAn3Aeb1ai?=
 =?us-ascii?Q?RQQbfjVWof08qacoy3yUncxxhjAx/rN/cCa+4ycGKYIfUgVAC9aEnOvm4P8e?=
 =?us-ascii?Q?Ikn3ga7iZuPp0eT6O9t9E2PfWGr6SlFRgY/3nsOd1XLh8C0QH4ILv9uBVM0q?=
 =?us-ascii?Q?7B7XeMFWA4GByV+W2yzkyvytdjjGgmPmsekGFRb98YHCMLQ8Jr2OabjfTmNe?=
 =?us-ascii?Q?lNOeEDq42dzth0izm2yWapk+P0u+EbtJkA6Rz9LsGL3t98gKkO42qPleaAb+?=
 =?us-ascii?Q?LPb7PzU2/8LceI6hHqxK5pAvCAax9MUwlSHF8grr2rI9eujeRsdZhUPmj2uV?=
 =?us-ascii?Q?3Fu1NowXD9NrjZlduHDUcBZJ0CZ1cGhqDbX+1zcTXZ1qAwoRSUTda6EKy52/?=
 =?us-ascii?Q?Oh648Ng06CpGcZRv7ECMTTKsuDn9ESEguEbYeg8S1lAPw3vBdn9nTgbb0HZ7?=
 =?us-ascii?Q?sVlGSLKalFjtL7HKFiQXmWzOD/qDI6RgaX/6TWia741moNq52byW4yhPuAfL?=
 =?us-ascii?Q?OWK26kzLRZvkgwcSycAz2ucGWPOEO12yGBI3rJeszY9khI9QSH/MTuibKLir?=
 =?us-ascii?Q?K0f40PhFZ47A4LdqOVB48qqpe+XG0idwWofaUiYuaMRFrSvp29IyvZy/VG2x?=
 =?us-ascii?Q?THsmlHcnYFxCertj8YoTHv/Olz+y6nBCLh7bh+MS8fcvWwAFkuqa6kNLmMKy?=
 =?us-ascii?Q?wWbDCWQ49B+mKPB1PPFfUdvtuLJLoH05P///U+HxUlvfvePWbuL6T+aNnPwk?=
 =?us-ascii?Q?JdWCLPeA1avAWRiGvx6OoRsV1SxKNVipDb1lvfzklZPKi8Rh6tzm9FEBM8bP?=
 =?us-ascii?Q?deAKC1TK+5ovitPy26RfhPrgO4JAkLrcMbPb2M75WrH8wcA+iinrOlSPChHy?=
 =?us-ascii?Q?Hh/XnHIw6T6j4bh5NkvUixzAT67PUZNXYqwKdyDrUUDN47YE8/4eyhotwecq?=
 =?us-ascii?Q?VnaGONQZq/EeBv5pnT62F7q3qRaH9WfkO6NTyRUiNlwnTzmTwoutB7V5JGkC?=
 =?us-ascii?Q?2/MQj31LwVJaSDGF7scpLtFf6vatAktcdzD+dHonwqwL3r1tmvNq4S16N2n2?=
 =?us-ascii?Q?F+zpxZTkmouxsS6yz8AWupQKdGEVjm2LRWkpPYfgrDI6dgisjkMRA26DIa0z?=
 =?us-ascii?Q?gFMlZHNZC9UYUHD5BZ5iaJ2O/cUPXJTBHFJ581K35cuW+ddALbxoHdZNjG30?=
 =?us-ascii?Q?GaeCQjk/MmPwwEo/iVQpY1DFCuTPZE/ACUcOMkE1Jcr3dUyIezKof1TME6QZ?=
 =?us-ascii?Q?x2Oq4T0uHoA83wBg6IsiwCBEoF0eQpXYoTJUSfHtHrnLGYpB5E6v5MC7XItW?=
 =?us-ascii?Q?+a0NkLbPk73GhCr+s5S9hP8zJZqQJ+aJusN+h2aJsEuXXMLYgMDuefRSsYS4?=
 =?us-ascii?Q?3xVghwV+le5Fpti3PS4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 20:07:50.1169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 873b9ee6-3acd-458f-e5e9-08de2c5e4f50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092

From: Jiri Pirko <jiri@nvidia.com>

Multiple PFs may reside on the same physical chip, running a single
firmware. Some of the resources and configurations may be shared among
these PFs. Currently, there is not good object to pin the configuration
knobs on.

Introduce a shared devlink, instantiated upon probe of the first PF,
removed during remove of the last PF. Back this shared devlink instance
by faux device, as there is no PCI device related to it.

Make the PF devlink instances nested in this shared devlink instance.

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
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  18 ++
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  | 166 ++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  |  13 ++
 include/linux/mlx5/driver.h                   |   5 +
 5 files changed, 205 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 8ffa286a18f5..d39fe9c4a87c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -16,8 +16,9 @@ mlx5_core-y :=	main.o cmd.o debugfs.o fw.o eq.o uar.o pagealloc.o \
 		transobj.o vport.o sriov.o fs_cmd.o fs_core.o pci_irq.o \
 		fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o dev.o events.o wq.o lib/gid.o \
 		lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o diag/fs_tracepoint.o \
-		diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o diag/reporter_vnic.o \
-		fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o lib/nv_param.o
+		diag/fw_tracer.o diag/crdump.o devlink.o sh_devlink.o diag/rsc_dump.o \
+		diag/reporter_vnic.o fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o \
+		lib/nv_param.o
 
 #
 # Netdev basic
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 024339ce41f1..a8a285917688 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -74,6 +74,7 @@
 #include "mlx5_irq.h"
 #include "hwmon.h"
 #include "lag/lag.h"
+#include "sh_devlink.h"
 
 MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX series) core driver");
@@ -1520,10 +1521,17 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
 	int err;
 
 	devl_lock(devlink);
+	if (dev->shd) {
+		err = devl_nested_devlink_set(priv_to_devlink(dev->shd),
+					      devlink);
+		if (err)
+			goto unlock;
+	}
 	devl_register(devlink);
 	err = mlx5_init_one_devl_locked(dev);
 	if (err)
 		devl_unregister(devlink);
+unlock:
 	devl_unlock(devlink);
 	return err;
 }
@@ -2015,6 +2023,13 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto pci_init_err;
 	}
 
+	err = mlx5_shd_init(dev);
+	if (err) {
+		mlx5_core_err(dev, "mlx5_shd_init failed with error code %d\n",
+			      err);
+		goto shd_init_err;
+	}
+
 	err = mlx5_init_one(dev);
 	if (err) {
 		mlx5_core_err(dev, "mlx5_init_one failed with error code %d\n",
@@ -2026,6 +2041,8 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_init_one:
+	mlx5_shd_uninit(dev);
+shd_init_err:
 	mlx5_pci_close(dev);
 pci_init_err:
 	mlx5_mdev_uninit(dev);
@@ -2047,6 +2064,7 @@ static void remove_one(struct pci_dev *pdev)
 	mlx5_drain_health_wq(dev);
 	mlx5_sriov_disable(pdev, false);
 	mlx5_uninit_one(dev);
+	mlx5_shd_uninit(dev);
 	mlx5_pci_close(dev);
 	mlx5_mdev_uninit(dev);
 	mlx5_adev_idx_free(dev->priv.adev_idx);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
new file mode 100644
index 000000000000..e39a5e20e102
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/device/faux.h>
+#include <linux/mlx5/driver.h>
+#include <linux/mlx5/vport.h>
+
+#include "sh_devlink.h"
+
+static LIST_HEAD(shd_list);
+static DEFINE_MUTEX(shd_mutex); /* Protects shd_list and shd->list */
+
+/* This structure represents a shared devlink instance,
+ * there is one created for PF group of the same chip.
+ */
+struct mlx5_shd {
+	/* Node in shd list */
+	struct list_head list;
+	/* Serial number of the chip */
+	const char *sn;
+	/* List of per-PF dev instances */
+	struct list_head dev_list;
+	/* Related faux device */
+	struct faux_device *faux_dev;
+};
+
+static const struct devlink_ops mlx5_shd_ops = {
+};
+
+static int mlx5_shd_faux_probe(struct faux_device *faux_dev)
+{
+	struct devlink *devlink;
+	struct mlx5_shd *shd;
+
+	devlink = devlink_alloc(&mlx5_shd_ops, sizeof(struct mlx5_shd),
+				&faux_dev->dev);
+	if (!devlink)
+		return -ENOMEM;
+	shd = devlink_priv(devlink);
+	faux_device_set_drvdata(faux_dev, shd);
+
+	devl_lock(devlink);
+	devl_register(devlink);
+	devl_unlock(devlink);
+	return 0;
+}
+
+static void mlx5_shd_faux_remove(struct faux_device *faux_dev)
+{
+	struct mlx5_shd *shd = faux_device_get_drvdata(faux_dev);
+	struct devlink *devlink = priv_to_devlink(shd);
+
+	devl_lock(devlink);
+	devl_unregister(devlink);
+	devl_unlock(devlink);
+	devlink_free(devlink);
+}
+
+static const struct faux_device_ops mlx5_shd_faux_ops = {
+	.probe = mlx5_shd_faux_probe,
+	.remove = mlx5_shd_faux_remove,
+};
+
+static struct mlx5_shd *mlx5_shd_create(const char *sn)
+{
+	struct faux_device *faux_dev;
+	struct mlx5_shd *shd;
+
+	faux_dev = faux_device_create(sn, NULL, &mlx5_shd_faux_ops);
+	if (!faux_dev)
+		return NULL;
+	shd = faux_device_get_drvdata(faux_dev);
+	if (!shd)
+		return NULL;
+	list_add_tail(&shd->list, &shd_list);
+	shd->sn = sn;
+	INIT_LIST_HEAD(&shd->dev_list);
+	shd->faux_dev = faux_dev;
+	return shd;
+}
+
+static void mlx5_shd_destroy(struct mlx5_shd *shd)
+{
+	list_del(&shd->list);
+	kfree(shd->sn);
+	faux_device_destroy(shd->faux_dev);
+}
+
+int mlx5_shd_init(struct mlx5_core_dev *dev)
+{
+	u8 *vpd_data __free(kfree) = NULL;
+	struct pci_dev *pdev = dev->pdev;
+	unsigned int vpd_size, kw_len;
+	struct mlx5_shd *shd;
+	const char *sn;
+	char *end;
+	int start;
+	int err;
+
+	if (!mlx5_core_is_pf(dev))
+		return 0;
+
+	vpd_data = pci_vpd_alloc(pdev, &vpd_size);
+	if (IS_ERR(vpd_data)) {
+		err = PTR_ERR(vpd_data);
+		return err == -ENODEV ? 0 : err;
+	}
+	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3", &kw_len);
+	if (start < 0) {
+		/* Fall-back to SN for older devices. */
+		start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
+						     PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
+		if (start < 0)
+			return -ENOENT;
+	}
+	sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
+	if (!sn)
+		return -ENOMEM;
+	/* Firmware may return spaces at the end of the string, strip it. */
+	end = strchrnul(sn, ' ');
+	*end = '\0';
+
+	guard(mutex)(&shd_mutex);
+	list_for_each_entry(shd, &shd_list, list) {
+		if (!strcmp(shd->sn, sn)) {
+			kfree(sn);
+			goto found;
+		}
+	}
+	shd = mlx5_shd_create(sn);
+	if (!shd) {
+		kfree(sn);
+		return -ENOMEM;
+	}
+found:
+	list_add_tail(&dev->shd_list, &shd->dev_list);
+	dev->shd = shd;
+	return 0;
+}
+
+void mlx5_shd_uninit(struct mlx5_core_dev *dev)
+{
+	struct mlx5_shd *shd = dev->shd;
+
+	if (!dev->shd)
+		return;
+
+	guard(mutex)(&shd_mutex);
+	list_del(&dev->shd_list);
+	if (list_empty(&shd->dev_list))
+		mlx5_shd_destroy(shd);
+}
+
+void mlx5_shd_lock(struct mlx5_core_dev *dev)
+{
+	if (!dev->shd)
+		return;
+	devl_lock(priv_to_devlink(dev->shd));
+}
+
+void mlx5_shd_unlock(struct mlx5_core_dev *dev)
+{
+	if (!dev->shd)
+		return;
+	devl_unlock(priv_to_devlink(dev->shd));
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
new file mode 100644
index 000000000000..54ce0389cfea
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_SH_DEVLINK_H__
+#define __MLX5_SH_DEVLINK_H__
+
+int mlx5_shd_init(struct mlx5_core_dev *dev);
+void mlx5_shd_uninit(struct mlx5_core_dev *dev);
+void mlx5_shd_lock(struct mlx5_core_dev *dev);
+void mlx5_shd_unlock(struct mlx5_core_dev *dev);
+void mlx5_shd_nested_set(struct mlx5_core_dev *dev);
+
+#endif /* __MLX5_SH_DEVLINK_H__ */
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 1c54aa6f74fb..29fd4dff1cd1 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -735,6 +735,8 @@ enum mlx5_wc_state {
 	MLX5_WC_STATE_SUPPORTED,
 };
 
+struct mlx5_shd;
+
 struct mlx5_core_dev {
 	struct device *device;
 	enum mlx5_coredev_type coredev_type;
@@ -798,6 +800,9 @@ struct mlx5_core_dev {
 	enum mlx5_wc_state wc_state;
 	/* sync write combining state */
 	struct mutex wc_state_lock;
+	/* node in shared devlink list */
+	struct list_head shd_list;
+	struct mlx5_shd *shd;
 };
 
 struct mlx5_db {
-- 
2.31.1


