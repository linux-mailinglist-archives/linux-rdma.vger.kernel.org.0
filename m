Return-Path: <linux-rdma+bounces-17025-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBBkChV7l2m6zAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17025-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 22:05:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 947E4162921
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 22:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96A833014696
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Feb 2026 21:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AAA326D63;
	Thu, 19 Feb 2026 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X+mVJ30X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3B530DD3B;
	Thu, 19 Feb 2026 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771535122; cv=fail; b=i4xTx99kGH39eoY9lob3N+F3XoC+KhA5npHT2SRkQNbXKd/SZOeNbtSHGi4RBHvl/J+DRlSunMtXSqiVPhZ0+S/ypaKVkLLlS3+u5RlS1KhpnzeRAumwrRuTx22tEsPHukqYWFur8eiB3JC0S1ujVnkOyw9YVqzqH5KKNxCIooM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771535122; c=relaxed/simple;
	bh=Py35zsJjuzYhux0cS35SIdX2QXUs2NG/VEtrVXz2wqQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NV9DR8FUFn4wt3tu/YbPMg8oSPNL3auZHFAn9nwuoryvDhxC7ReAuuAboU5E98v0nIdcq1wgNGfrAHm1gPpRqS++MXRO4borqr/128ObrujlxlTp6NuDWP7Tpjhl+eckIIJbtmg9Z5yyqwMrc2haXygHUAD+n/3cza31bh4yj/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X+mVJ30X; arc=fail smtp.client-ip=40.93.196.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbWXCcE+icgy4KzpF2hE7U1oVZH/98f/vJ1mzgOOrBvtAF/qWYdc9W6p1L5NGP6MrMQGbbwZ3LEBs7Wvt4MulvZG66ygFEZimEBObDloMypDxIAUHU9DSFKc5J2uLzrRpu2fi89Uujw2WcBLAVCJJSZdu+RuecalahtEKvwMgVduHMGvesm83XxrrqAaKLy235eoEUX6hYl5nNtqsvxhKoYS/vC/JDhTEnOj/maoo4b4rVC9EPEgQafl7ajLd4rrwCOOxdfs2iksPTBw12fwEIzPWr861jsA73eqM5i2iHmEsIYllmxiJDmW45MU/dyaSx77/cyIgduK4exRDZAupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0mkt8hWmrDuOjlmtYGwW5M1/NeWDPFOdd8e49cvzpA=;
 b=v2TQ2jwtopnomG9LFCTjAucW97y2r8DCrBmJMBGPkIh/I2WWV8MSNqSZol3OIZvqX56p0tEY4CNzqlEhlL7RFsZQcikjjRiBdoH6QFCp/9lLFe/jqoLRMKwXQa48VP611JssAvFrR3rWEDOY6pK1H94Hl1EUP3ei+lK9R1Q3dSujiQcV9WACy+80wtIKGw/dibqME/ibfHsDecrJEvRpsEiAjH230ttgJNJh8c8Zo2MtL1T0X/GViIUmP8zUjYxIP8uAkEIGxFIcHtVCAznvB5EZW1ttqDoLPVC1PpHjSE50WFCDP2Zy0OZOZq0BRkX396gfUDpJQwYnzXBahlL7vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0mkt8hWmrDuOjlmtYGwW5M1/NeWDPFOdd8e49cvzpA=;
 b=X+mVJ30XOreNJmeqFk1iCoF8NtyR431/NrLoPW6Etls8Lbt+gVxE3V7uucGE2QwuMRGW+ItOhtZVYFQ6gh5WB1JHkQ2tv3k6LvQ3Q16lBwjsQiTXAx204gc6GtGgYozJZphvyqg4o7B1qgLWL34fP7ekZPEp05BB4Nb5YCuqdAsGSDowCWSPmuXIb3aXI3S6dSpY7yejj3h1nQjwkltfheNwI9WZpMt5z62oCzfxUg5Kd4uWKxHTLlbkOr8Wh5Nh6NecvktvsumbRr2F7Dvx+KxLjCZxOfxbMc3U7F1tMBv9w37+DmY3D3ollUlVoiVPEYNfo0HzyxMsb9pHk0CfJA==
Received: from BN9PR03CA0857.namprd03.prod.outlook.com (2603:10b6:408:13d::22)
 by IA0PR12MB8896.namprd12.prod.outlook.com (2603:10b6:208:493::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 21:05:16 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::86) by BN9PR03CA0857.outlook.office365.com
 (2603:10b6:408:13d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 21:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 21:05:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 13:04:54 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 13:04:54 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 19
 Feb 2026 13:04:49 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <driver-core@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
CC: Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Amir Tzin
	<amirtz@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH V2] driver core: auxiliary bus: Fix sysfs creation on bind
Date: Thu, 19 Feb 2026 23:04:35 +0200
Message-ID: <20260219210435.1769394-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|IA0PR12MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ceea03-f150-42ef-ec26-08de6ffa949c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lpuot9bcYpry/QSxh9sC3zjpKfE4Lc7AM/8P8S7Hz1035+T5Q0r3L1Skd/zd?=
 =?us-ascii?Q?IudGNMnkQmpvI+YJBgSZ9w+oqJ5C5n0u/TedY9Gxhy2/MVR9rEzm0JB+jOWC?=
 =?us-ascii?Q?jGPpmL/PZ+e5+H0rzd3L+jLa262/YC6raVtqKm7LiGIgAu2NxmpMQNZv29F4?=
 =?us-ascii?Q?VRss7yKbmQoZh60i2CDNQx8O9ETwA0QTUf01+sS+MUC82lHgoPywJgjc/PCh?=
 =?us-ascii?Q?mv6c9ZBNrTw7k7RZA8rrlvFRMP2qOxGJJNil/voWXT59l/7abv9u/5qDKSZv?=
 =?us-ascii?Q?8vc02XKHOW5xyHK+9ejov05wh+i14KsVgePjnqY0dSXvZkMBiwd34oC+tVYo?=
 =?us-ascii?Q?2cY2BsEhqtFw+nkdPUqP3RhaD3xwgirljW0/HUX5MoPkyzMZ5SZT9qmb7qdc?=
 =?us-ascii?Q?jDVR3NjrgELt+YIhRVXJI5pp7Y/19pbTwxT4cX4ExI2JMi3kDPo7bFDrZ9uT?=
 =?us-ascii?Q?gr4z/YSorj1mkSMc1V9p4gl7AUYyf7SVkCwTrvzAxI2keeFcDqbHMocMT+uM?=
 =?us-ascii?Q?YUZKzcbUpXPvhG/fVM43TiaB9jd9dJbTubypQOckagK5c+shqMKLx0kbxCAE?=
 =?us-ascii?Q?ZiJIL3mZN64gwedPHmcK7e95bupfTLUuJWsYp7JX8U+7ZbntMXRqdzZb1w0/?=
 =?us-ascii?Q?aIpQd3jYs1jXzIefoH7Fdvs1mEQ4v5X/C3UXgnqNMhGO+JRsVIhPGtR8jqMa?=
 =?us-ascii?Q?cB5Yht4Zh7rtclkZr3/jCU/MrQiffv+4sA205Wnf9Om4oSZPuKX5EiNlWWGK?=
 =?us-ascii?Q?IAakE1QR6kpT7L/YdAJllR23EaII42lVbCpFeatoD74UOKjQloNjtImaCVE+?=
 =?us-ascii?Q?GwKo+luzmc3m25pgDT9Kqpzx/HL0Sw5PN6fxrcrDuMO88RgwwZ+vuH0yLP0d?=
 =?us-ascii?Q?YEugSxekFxddjDnTARjztIJWgEvcVP+NIHkLOktNg+WMg5MtYhZClMcd6ccR?=
 =?us-ascii?Q?nRW25XJCF7QAmEY+ZDK2IFQ9ZHR5c8B2hVb3QIqn9VPAxtxMhpJKAX6x0Kjq?=
 =?us-ascii?Q?4Qefg2N1cakvIdgajas/p3Z+324SPXeQTiex2vFnr/nHcPOECFFAQ0TxcgvO?=
 =?us-ascii?Q?fk7dX5yvvwS++tSJSI7ijv6LrBXHyiKTtgberXfIRakwbgfFt+ea+y0vXMli?=
 =?us-ascii?Q?DoNZNtzY4TiSzE/MtuiFzd0YCFLIbmKLr+KhmDPGvEiKwprSFguEOzUqCJjR?=
 =?us-ascii?Q?2TqJr0nw3m88AS7fDF0PSvs4pA1DWcaOe+pTl/rxs7AV0pox4iqq2XZnRaPZ?=
 =?us-ascii?Q?G4gYAiKR8puy5MNRVBlkZo8V9wg7TEZ1ilaJlwjWDpnzdUUaFvwuNF6zNvwg?=
 =?us-ascii?Q?iX2S3fhX8H1QGJKhSr6cDTblQptasl/+/brvr8AV8xd/vIUL+KkQm7NnVPKZ?=
 =?us-ascii?Q?Z1OajM1WXLcBXlq3X1DCEPJzOOygo2mYPEFVPIOfKYbIwfxDY75kWy8gLhAX?=
 =?us-ascii?Q?QkqlNxgjuieb8dT5un2hT88DtQArvg8Mn+HSGJqmQCsRBNWR0/axVdiQ3bff?=
 =?us-ascii?Q?CfqSb+mu1paSOQBhoHWHO2dSEpnCSnNEhuMeaFdn0cgBHRhK19OLburkhDxx?=
 =?us-ascii?Q?8QfYsIwRHrc0bNDS1XGue+NajsaSbZeaGdBw3mDyUEB7PEJom9MrcEDwpnkL?=
 =?us-ascii?Q?tu61063QEwxbW2iWbw7KmhVu8FDMqJsGzUvRz17gbI6FvKkoA1fJhdGZS64y?=
 =?us-ascii?Q?m/LY+GqUmfb0yE13ol2DklomDac=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	twphuWWIlbDpDbdezz9wjRkfvRfUaYLtetoMP1YsfZVuEmDYk+bOQgjnfV59FEIvNW38Xz0and8WoqoykTfz0OGLT6Ft6cmfGHMjHFEwKKCAswFjZcbI85buCAQD2Ip+WP9wHwW3UyETW3bXAomHf+M62gV+N4ggukf28qQEBfUfi3+iAzYHBL64K2l2AlB8HCJh4P8nn1y/SCoUGHpsBugn4iGv6qzqDrQtP6+BL/4JXk4FQAruY4ia9CgnIXd5kjp9hqSpSJrpCHFid/yTF2aDrsoDoPDIoLTQdtcQHhIlZi4yDCIE7zWZ6edU3gOZbNVgVA8/NVroQOhXTlVabb5M1fsMZohy63ylqDweED7/tb+hoZjO1UTBItosc5E94szZQqJT9uala4CVLzycgX+nJZ9QNDx3IsuvljyoeSi9saDbh7GBfdlktrDbsd0R
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 21:05:15.6897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ceea03-f150-42ef-ec26-08de6ffa949c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8896
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17025-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 947E4162921
X-Rspamd-Action: no action

From: Amir Tzin <amirtz@nvidia.com>

In case an auxiliary device with IRQs directory is unbinded, the
directory is released, but auxdev->sysfs.irq_dir_exists remains true.
This leads to a failure recreating the directory on bind [1].

Expose functions auxiliary_device_sysfs_irq_dir_init() and
auxiliary_device_sysfs_irq_dir_destroy(). Move the responsibility for
the IRQs directory creation and destruction to the drivers. This change
corresponds to the general concept according to which the core driver
manages the auxiliary device locking and lifetime. Now the auxiliary
device sysfs related fields, irq_dir_exists and lock, are redundant and
can be removed.

mlx5 SFs, the only users of IRQs sysfs API, must align. Create the
directory before a SF control irq is requested and destroy it upon
its release.

[1]
[] mlx5_core.sf mlx5_core.sf.2: mlx5_irq_affinity_request:167:(pid 1939):
   Failed to create sysfs entry for irq 56, ret = -2
[] mlx5_core.sf mlx5_core.sf.2: mlx5_eq_table_create:1195:(pid 1939):
   Failed to create async EQs
[] mlx5_core.sf mlx5_core.sf.2: mlx5_load:1362:(pid 1939):
   Failed to create EQs

Fixes: a808878308a8 ("driver core: auxiliary bus: show auxiliary device IRQs")
Signed-off-by: Amir Tzin <amirtz@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/base/auxiliary.c                      |  1 -
 drivers/base/auxiliary_sysfs.c                | 48 ++++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 20 ++++++++
 include/linux/auxiliary_bus.h                 | 16 +++++--
 4 files changed, 66 insertions(+), 19 deletions(-)

V2:
- Move the irq directory management from core to drivers: 
  expose auxiliary_device_sysfs_irq_dir_init()
  auxiliary_device_sysfs_irq_dir_destroy().  Drop the attribute group
  visibility approach.
  Remove the mutex from the auxiliary sysfs structure (drivers are
  responsible for concurrency). 
- Revert auxiliary_device_sysfs_irq_remove() to return void.
- Call auxiliary_device_sysfs_irq_dir_(init|destroy) in mlx5 SF device
  create/remove flows.
- Link to V1: https://lore.kernel.org/all/1761200367-922346-1-git-send-email-tariqt@nvidia.com/

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 04bdbff4dbe5..e1b8c4bc306e 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -294,7 +294,6 @@ int auxiliary_device_init(struct auxiliary_device *auxdev)
 
 	dev->bus = &auxiliary_bus_type;
 	device_initialize(&auxdev->dev);
-	mutex_init(&auxdev->sysfs.lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(auxiliary_device_init);
diff --git a/drivers/base/auxiliary_sysfs.c b/drivers/base/auxiliary_sysfs.c
index 754f21730afd..598a012ce481 100644
--- a/drivers/base/auxiliary_sysfs.c
+++ b/drivers/base/auxiliary_sysfs.c
@@ -22,22 +22,47 @@ static const struct attribute_group auxiliary_irqs_group = {
 	.attrs = auxiliary_irq_attrs,
 };
 
-static int auxiliary_irq_dir_prepare(struct auxiliary_device *auxdev)
+/**
+ * auxiliary_device_sysfs_irq_dir_init - initialize the IRQ sysfs directory
+ * @auxdev: auxiliary bus device to initialize the sysfs directory.
+ *
+ * This function should be called by drivers to initialize the IRQ directory
+ * before adding any IRQ sysfs entries. The driver is responsible for ensuring
+ * this function is called only once and for handling any concurrency control
+ * if needed.
+ *
+ * Drivers must call auxiliary_device_sysfs_irq_dir_destroy() to clean up when
+ * done.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+int auxiliary_device_sysfs_irq_dir_init(struct auxiliary_device *auxdev)
 {
-	int ret = 0;
-
-	guard(mutex)(&auxdev->sysfs.lock);
-	if (auxdev->sysfs.irq_dir_exists)
-		return 0;
+	int ret;
 
-	ret = devm_device_add_group(&auxdev->dev, &auxiliary_irqs_group);
+	ret = sysfs_create_group(&auxdev->dev.kobj, &auxiliary_irqs_group);
 	if (ret)
 		return ret;
 
-	auxdev->sysfs.irq_dir_exists = true;
 	xa_init(&auxdev->sysfs.irqs);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_dir_init);
+
+/**
+ * auxiliary_device_sysfs_irq_dir_destroy - destroy the IRQ sysfs directory
+ * @auxdev: auxiliary bus device to destroy the sysfs directory.
+ *
+ * This function should be called by drivers to clean up the IRQ directory
+ * after all IRQ sysfs entries have been removed. The driver is responsible
+ * for ensuring all IRQs are removed before calling this function.
+ */
+void auxiliary_device_sysfs_irq_dir_destroy(struct auxiliary_device *auxdev)
+{
+	xa_destroy(&auxdev->sysfs.irqs);
+	sysfs_remove_group(&auxdev->dev.kobj, &auxiliary_irqs_group);
+}
+EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_dir_destroy);
 
 /**
  * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given IRQ
@@ -45,7 +70,8 @@ static int auxiliary_irq_dir_prepare(struct auxiliary_device *auxdev)
  * @irq: The associated interrupt number.
  *
  * This function should be called after auxiliary device have successfully
- * received the irq.
+ * received the irq. The driver must call auxiliary_device_sysfs_irq_dir_init()
+ * before calling this function for the first time.
  * The driver is responsible to add a unique irq for the auxiliary device. The
  * driver can invoke this function from multiple thread context safely for
  * unique irqs of the auxiliary devices. The driver must not invoke this API
@@ -59,10 +85,6 @@ int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
 	struct device *dev = &auxdev->dev;
 	int ret;
 
-	ret = auxiliary_irq_dir_prepare(auxdev);
-	if (ret)
-		return ret;
-
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index aa3b5878e3da..b6e872d7a925 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -456,7 +456,15 @@ static void _mlx5_irq_release(struct mlx5_irq *irq)
  */
 void mlx5_ctrl_irq_release(struct mlx5_core_dev *dev, struct mlx5_irq *ctrl_irq)
 {
+	struct mlx5_irq_pool *pool = ctrl_irq_pool_get(dev);
+
 	mlx5_irq_affinity_irq_release(dev, ctrl_irq);
+
+	if (mlx5_irq_pool_is_sf_pool(pool)) {
+		struct auxiliary_device *sadev = mlx5_sf_coredev_to_adev(dev);
+
+		auxiliary_device_sysfs_irq_dir_destroy(sadev);
+	}
 }
 
 /**
@@ -489,9 +497,21 @@ struct mlx5_irq *mlx5_ctrl_irq_request(struct mlx5_core_dev *dev)
 		/* Allocate the IRQ in index 0. The vector was already allocated */
 		irq = irq_pool_request_vector(pool, 0, af_desc, NULL);
 	} else {
+		struct auxiliary_device *sadev = mlx5_sf_coredev_to_adev(dev);
+		int err;
+
+		err = auxiliary_device_sysfs_irq_dir_init(sadev);
+		if (err) {
+			irq = ERR_PTR(err);
+			goto exit;
+		}
+
 		irq = mlx5_irq_affinity_request(dev, pool, af_desc);
+		if (IS_ERR(irq))
+			auxiliary_device_sysfs_irq_dir_destroy(sadev);
 	}
 
+exit:
 	kvfree(af_desc);
 
 	return irq;
diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index 4086afd0cc6b..d052cb687e6f 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -60,8 +60,6 @@
  * @id: unique identitier if multiple devices of the same name are exported,
  * @sysfs: embedded struct which hold all sysfs related fields,
  * @sysfs.irqs: irqs xarray contains irq indices which are used by the device,
- * @sysfs.lock: Synchronize irq sysfs creation,
- * @sysfs.irq_dir_exists: whether "irqs" directory exists,
  *
  * An auxiliary_device represents a part of its parent device's functionality.
  * It is given a name that, combined with the registering drivers
@@ -145,8 +143,6 @@ struct auxiliary_device {
 	u32 id;
 	struct {
 		struct xarray irqs;
-		struct mutex lock; /* Synchronize irq sysfs creation */
-		bool irq_dir_exists;
 	} sysfs;
 };
 
@@ -222,10 +218,21 @@ int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
 #define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev, KBUILD_MODNAME)
 
 #ifdef CONFIG_SYSFS
+int auxiliary_device_sysfs_irq_dir_init(struct auxiliary_device *auxdev);
+void auxiliary_device_sysfs_irq_dir_destroy(struct auxiliary_device *auxdev);
 int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq);
 void auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev,
 				       int irq);
 #else /* CONFIG_SYSFS */
+static inline int
+auxiliary_device_sysfs_irq_dir_init(struct auxiliary_device *auxdev)
+{
+	return 0;
+}
+
+static inline void
+auxiliary_device_sysfs_irq_dir_destroy(struct auxiliary_device *auxdev) {}
+
 static inline int
 auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev, int irq)
 {
@@ -238,7 +245,6 @@ auxiliary_device_sysfs_irq_remove(struct auxiliary_device *auxdev, int irq) {}
 
 static inline void auxiliary_device_uninit(struct auxiliary_device *auxdev)
 {
-	mutex_destroy(&auxdev->sysfs.lock);
 	put_device(&auxdev->dev);
 }
 

base-commit: 8dfce8991b95d8625d0a1d2896e42f93b9d7f68d
-- 
2.44.0


