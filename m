Return-Path: <linux-rdma+bounces-14724-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74286C82A77
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 23:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A4E3AE070
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 22:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B082F744C;
	Mon, 24 Nov 2025 22:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ooaeAjLH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012006.outbound.protection.outlook.com [40.93.195.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016752874ED;
	Mon, 24 Nov 2025 22:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023348; cv=fail; b=Ih7LOnl9yhTvZJeOTWrvAT7tNWNi2o0pBYMmzwJXi2cLie5mvC2zw2I8IsE2wqzHcAxUeLet0ATEWJaS4RX6z/ClvN57yQ5JNoOn8o1TpKKOwYERReFoY8dfNSLr3NxoPL3LglQgGH/Olwk9JF0RmkycAPcTztzLlRmZ0zSp4sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023348; c=relaxed/simple;
	bh=EBpIUsKseGmHiTJhv2v/yVfns+7e7rugtu5S0To7bpA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qoPv7douNu7pmxtCtObJXRTXCbf4cDm3Zh68jQo9lAbNnbiwhSeCRBZacs72v2dNxLVZxG5XC0QwJLkxTilcAW9JmEZuxaGBaCjyBPtK2NDrMGjyxWIRcZcCOe1mDRdThAinl35Ug7qhLn7ydia7t/eAsrgHfKVIKgECAANBefc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ooaeAjLH; arc=fail smtp.client-ip=40.93.195.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wo8A6PTDgyLRizxIJBeti/nkgJQNMk5a0u8EUGNUkOHH5OpHfgRSo3zlWCxrzH6aLijh73P1+OqcP8iWL0PNy00R/zQJmyZSnq2wLewlAHmQAohTdDvfSzA2QyTpp2lM666PdX7b7KMAEbm1kzjM0hncqiX3tLQPFwzQvi/d/BQavzv4JETci+biHB8em4GBTHOdP9mHIMu5LKJdxQ5XAwzmtwB7tEMMpeZhkunituBcSNvPfWdm0bGibr48C2HyGtrNLekuLq6FXH6LHvDONA+odSaXkC7mjkMgm0NzY/34ilrnZapw7Lt9ECy6KhkhTVc3nnZ0q1G/0TCcRWyvyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGhJ/OmjCEiiznrzdvMhhhKy+jyzSfOpsd969Saey9E=;
 b=DP/OQ5jfjt6xMHNnGOTWpV6XJypYoNAB349bdbXhXzrJVL0GTh9BjZI6pLIeCyRM61JNb9o+iQIWbq5FqRgxAzNw83MrJap23WDpymGP2Qxlku+eLoyeuqm31Lag2KWNYUOeXm1dXBFuWz4pWUTjcVqwmje+l0vZX6rXLRRt3c8Gi+iImlykCZSiIbbqjVtwFZyZcWbaAUFqF32yJcsxoMr2JUfVVklVN/W9uJMo1SMgwz6oZyhbyhuEMB/DTnbEa/KteuehvaxZSAVDGvL3qs+TmTwwXRqEUiW0MnaMeysjrCW+XAFRcR8E8t63QcNJY53O/t4iTAq4oB8+4m9wnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGhJ/OmjCEiiznrzdvMhhhKy+jyzSfOpsd969Saey9E=;
 b=ooaeAjLH/n+forocEeDCdI57O4sMSUw5vm/0p1ewCx0/5ZtYXfbl8ITg2I6J4wGGGn2oA8d8Dd7zD71a9gtyK3otfvOv67wcLIkS6dLszxYz5qtnJG7itsIYtjqM6zwTkwhSLXkO4puAIhw5EjI1vgDaPah1DGc2cFaUqD1+y7h5IaQxMsez5qd0igMEVUDV7XQ7CvNcQLOJQE1ne+DHF2Gjsk4IZwIyXWcY3/4TC4dBMh/NPZ12iKFSrjUxtD9i3LgxhNKny9Y4wmfk0qZ4GLRJjcQ/9PNCIZA8GYiHNffAlMmqd2cJOyXdXMC3O+9cQaa25zoggBAKf0EvOKr0cg==
Received: from SN1PR12CA0066.namprd12.prod.outlook.com (2603:10b6:802:20::37)
 by DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 22:29:02 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:802:20:cafe::63) by SN1PR12CA0066.outlook.office365.com
 (2603:10b6:802:20::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 22:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 22:29:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 14:28:50 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 14:28:49 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 14:28:44 -0800
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
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V3 02/14] documentation: networking: add shared devlink documentation
Date: Tue, 25 Nov 2025 00:27:27 +0200
Message-ID: <1764023259-1305453-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
References: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: a80630dc-6207-45d4-68d5-08de2ba8deaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vWoU5kUznB/hskPNyaYtIIFbOIimgip+rxpY4es1QW4Ri5GE/ZwaPfXVn69S?=
 =?us-ascii?Q?VUEPdV8PBDbcI37m40nlh69qsZ42kpjd5EVNrX346mCf5u14uYV8Yoo7XJyC?=
 =?us-ascii?Q?up/ikkyXqCVOiNsIIBjUt/VFYpyk7upsIJRZKxTocHAunzYyEKTN1076HKJd?=
 =?us-ascii?Q?XiEQHul1XhG6+RQtSk0i2P5rM3VGELDGydSYY33RcuChGFTp20mY+y+unjFQ?=
 =?us-ascii?Q?KJ8XmwbP8Uxk6Az9CjJ7P9CymypGrHkbz3H+tE6ca1b5ZvPfvigNJcyzzxYc?=
 =?us-ascii?Q?v5M86nVb2csfiEHOc8GUmLXA+Tbb6RXCBL0VvIpCb3tbk315d4FY2g/ThZ+y?=
 =?us-ascii?Q?vu2kjMMWaDUXLTmdCDdb9NscIXteMbXo2qILqMWYCwxwFLtKS6LppZrYYUSb?=
 =?us-ascii?Q?3ZoGBGnPWV5whKi5/ARjVdvLxQUoNDq+JyE5KBpDedk7aSKq0W0qCmDuA/bb?=
 =?us-ascii?Q?KhFowckJNxaQW04rsrdNqO7sbqBDRR3qQrE6aJFhxlYcaqywkFc92jMjTrAy?=
 =?us-ascii?Q?hedmdOAh+L5VA9jhLJYd/OJQq2Ej8u+t4D2b/sc0/ew+LJZx6K24d+K0VLFc?=
 =?us-ascii?Q?8VrppMDk7iqRdvBaXFON3lKpchRpph+zmETkHGC72Gtl5Z4mHhhvapc5T6vM?=
 =?us-ascii?Q?uAJvEkLn+WQo55qFj2oiNsjTXgPFNvaL4IvZMYp7ourZoWvD849EStSxEyy5?=
 =?us-ascii?Q?5rnnIC9NKtAYrXMwEso/wlatQOb7071HSU3ScAPhYEDERMi2DeXhQk+XD6Bz?=
 =?us-ascii?Q?59utV5qYIaWvrPmJa8++xJRTahFgqWm4S6J1//AGcp7QbEHiCT3uT9Jm+yde?=
 =?us-ascii?Q?BSctQey4pe2C08wXBaG0Y5US+htWVrjbH0/Ha2bOhT5M/kcd6FLmAFHXqUE6?=
 =?us-ascii?Q?1JMtNh4Koty/8a/gq6C69DtW87RjscsyL9RuMhne+ItE8fl2IQGcvIAUJlU6?=
 =?us-ascii?Q?uBm12hvcsmSNItw7OabevdxvYFUk6pEj2y6WeMepdHi7n40WhZ/2QRlmDuY1?=
 =?us-ascii?Q?sCiUTUe/Hc31IftV52YWbLHvivhDxlsi9fM4k6wVr8AYvtF6xRsmhfQW8XOY?=
 =?us-ascii?Q?IDW5Wwg9/t6kpfx3UDIUFKfM+4oblKs3aXMNha3HvcRXlvaRhSCTKxUF3xMr?=
 =?us-ascii?Q?u7XK65/uZ4zAN2OCZCXD8yfJjp5vdTOlbH1LybZY7HrLedyu0msZYfoYUDuV?=
 =?us-ascii?Q?7+JGmso4i7vWBfgUb6Co8ShTjz2C8Q/LIf/+iECIqbhPV/opRR8LwBA9nXk8?=
 =?us-ascii?Q?NNW4jL0V2ihZ6qV8RJvMot0vnWqMsEJlPohAQQ7/49yLvYWBOlSremHBGxaM?=
 =?us-ascii?Q?u7fZ3vn2gAaVR99gyLUTQ3Y63Hd9vwfH3dxPr/xSAbwmbIwzSkyMG2Buk6WP?=
 =?us-ascii?Q?HNe973duFy9/7g6qbtvAuMNpvhiEgpn6Nc6Mm+c/YRfxA3oQgb5gEh+aiKdQ?=
 =?us-ascii?Q?fiyD/y0dkH3GsareUOd+JSk5nS+VDkEYxJwMawk83uBN33XuUEC3KLSiLCTl?=
 =?us-ascii?Q?lg2DyUZJkw9rrUn8K//DQvkYQVWWFnulABgu0NBjNOf2YAQrt5kIhOG4et4X?=
 =?us-ascii?Q?Xaw/aMwBQeZN2BfTbbo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 22:29:02.2449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a80630dc-6207-45d4-68d5-08de2ba8deaf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230

From: Jiri Pirko <jiri@nvidia.com>

Document shared devlink instances for multiple PFs on the same chip.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../networking/devlink/devlink-shared.rst     | 66 +++++++++++++++++++
 Documentation/networking/devlink/index.rst    |  1 +
 2 files changed, 67 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst

diff --git a/Documentation/networking/devlink/devlink-shared.rst b/Documentation/networking/devlink/devlink-shared.rst
new file mode 100644
index 000000000000..8377d524998f
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-shared.rst
@@ -0,0 +1,66 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
+Devlink Shared Instances
+============================
+
+Overview
+========
+
+Shared devlink instances allow multiple physical functions (PFs) on the same
+chip to share an additional devlink instance for chip-wide operations. This
+should be implemented within individual drivers alongside the individual PF
+devlink instances, not replacing them.
+
+The shared devlink instance should be backed by a faux device and should
+provide a common interface for operations that affect the entire chip
+rather than individual PFs.
+
+Implementation
+==============
+
+Architecture
+------------
+
+The implementation should use:
+
+* **Faux device**: Virtual device backing the shared devlink instance
+* **Chip identification**: PFs are grouped by chip using a driver-specific identifier
+* **Shared instance management**: Global list of shared instances with reference counting
+
+Initialization Flow
+-------------------
+
+1. **PF calls shared devlink init** during driver probe
+2. **Chip identification** using driver-specific method to determine device identity
+3. **Lookup existing shared instance** for this chip identifier
+4. **Create new shared instance** if none exists:
+
+   * Create faux device with chip identifier as name
+   * Allocate and register devlink instance
+   * Add to global shared instances list
+
+5. **Add PF to shared instance** PF list
+6. **Set nested devlink instance** dor the PF devlink instance
+
+Cleanup Flow
+------------
+
+1. **Cleanup** when PF is removed; destroy shared instance when last PF is removed
+
+Chip Identification
+-------------------
+
+PFs belonging to the same chip are identified using a driver-specific method.
+The driver is free to choose any identifier that is suitable for determining
+whether two PFs are part of the same device. Examples include VPD serial numbers,
+device tree properties, or other hardware-specific identifiers.
+
+Locking
+-------
+
+A global per-driver mutex protects the shared instances list and individual shared
+instance PF lists during registration/deregistration.
+
+Similarly to other nested devlink instance relationships, devlink lock of
+the shared instance should be always taken after the devlink lock of PF.
diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 35b12a2bfeba..f7ba7dcf477d 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -68,6 +68,7 @@ general.
    devlink-resource
    devlink-selftests
    devlink-trap
+   devlink-shared
 
 Driver-specific documentation
 -----------------------------
-- 
2.31.1


