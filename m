Return-Path: <linux-rdma+bounces-16144-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEamM/X0eWnT1AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16144-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:37:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C95A090F
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 12:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F7E9306CAF1
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8885A352FBE;
	Wed, 28 Jan 2026 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dh8Zb9v2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013011.outbound.protection.outlook.com [40.107.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA82352F9C;
	Wed, 28 Jan 2026 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599723; cv=fail; b=ODIRBnBs+RdkTwtBzm1D+br7b3Z70LYje15Y/BdlCdk7DtxFYJGuD9sLWrTHH8Oymf8M4ogCvVTURx4R0ykJV7iWi6/JXFTFI7b1+MTWXrTWqSMZqJlTzyInX4DDbWxFiKntfAuEUdS5B4VxXIptfmXMy3djArfHv/PO8e63mfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599723; c=relaxed/simple;
	bh=b+OCQkwX72piVb1VU1u4eJGnNQJtFhLSHNZeRr09xHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zx43GRl85hkAfuMH64NLiSr02QTtLGdPhfKuua0uialkDGfNJZvew+0G4buOpOptVS75dE+84jqQCceDRl4tEKHo2bzInuWescRGTAFWs9hdDsvIVrDMrWFxjYu9WKviHfF7r01MHgbJiBDXbcBEF0s4YzoRSUlHHiYFb1nzwhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dh8Zb9v2; arc=fail smtp.client-ip=40.107.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hm9qUcSGJt7zUyzdmdZe9NLsnVCHFtOw4EIG0oYAwe8b5Re8iiDMuAeTllklKYLj/fveZB7LqYSMmNmYSTlMDt3aEX4df6O9EC797UvT3+XeC1IDrcG5gLhpHsyxmcA5WuZSYE/XJ3x2sSfB4mmi6z7ObYkcX02ymUaz4iwDF/IZ6VYn4+Z8ibXUd46Q4cAukkgUzWeYzIiYImGUcSk/SDpjUpzF04pUDAO0TbWzspOZbbGC1m/Zd00vI5YcXE1cuKSCzQCnxZwExs1JmNw32vHl4rDP5curpZXp6d6U6b8rbcz75WynUACkMCv1LEmjzRwy3SQ2AGMSS/EdhL9meg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU7m8Ucg+3W5NdQZfsk5rmP0GaJLgT/7ypMHaDszIBo=;
 b=Os1HlWD96ZNQ3LKPymwCMxsKQyBOiUlji0JlMCy2tNWHCYy6FtyBh7/J7fhOKZKqZ46qBKEE6WscqAtejlkl+xpqABT6WyHlx7vfMUGTUztWUawsx1o5YYxHO73MhItREUySqW9t+12EvgMs5KQYPm6hvas4Z8Pm1PCPIa1lZpcrFD7FxUotwz7d+lR23/F+CJp4Q68DIHf6Zj2Tg1LgUga3IhQixUiqv4BdQVSZqOuhlp8Lp/I2jquJKYCIUrhgWiouME4QYrfxy5w5w5v0m4Tv6QLOGyL9MEMxXiGRk0OgNkdcr/W0I3y+LWzBJIic7UeLI3CsZicpHOpbBF3MUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU7m8Ucg+3W5NdQZfsk5rmP0GaJLgT/7ypMHaDszIBo=;
 b=Dh8Zb9v2e87EdPO140qvfmzarn1gpWiqBHWvPJ3M5CxcRQKbLrc0T19hQK1+SmX5ie5qJyD2xKrOIPY9Dl/Cnxy9mYwBh5/lOLNoz8w+P+Zss4h1M2pRBi4s1QGYVteTNnAtnu2kOiQB2Uu7FCj1sKmaXLB9fpnUKLTMkkl+v7ssGUHo1hrREi/LB0X9er55sgBF8Jr9j4cgOnMIGdE5DFK7FdAHODMbpYErIomigUEUqLWAHHKZa+wob47ky7/cGRxiOjIisCspSE9JA1fvhVgXUUw3rqmz04vJMKrNjHYYSHvO1FQcn4+gHyDJkWDCMADZS0OSlJDM0+bGiF02vg==
Received: from PH8P221CA0055.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::8)
 by SJ5PPF75EAF8F39.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::999) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 11:28:36 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:349:cafe::1) by PH8P221CA0055.outlook.office365.com
 (2603:10b6:510:349::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 11:28:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 11:28:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:28:24 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 03:28:24 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 28
 Jan 2026 03:28:18 -0800
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
Subject: [PATCH net-next V7 10/14] net/mlx5: Add a shared devlink instance for PFs on same chip
Date: Wed, 28 Jan 2026 13:25:40 +0200
Message-ID: <20260128112544.1661250-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260128112544.1661250-1-tariqt@nvidia.com>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|SJ5PPF75EAF8F39:EE_
X-MS-Office365-Filtering-Correlation-Id: 516b5b19-04e4-4995-4527-08de5e606067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xZh9GyeL/hGvpSaePPijlWkiIbJUk646jCrvrbs5zMM6Q+qkAQiFZmMT+e6q?=
 =?us-ascii?Q?W7r47d1vYGFBrc+lIE97xFR15oldUNHESSDVmq40U9WLqFEtyHQMao+9Sl0u?=
 =?us-ascii?Q?QnrWqjbySnXv0T3pGOSHFhZPIoP2dR/cCTfMjTFD/PMgL+pr7BLijeCHc54n?=
 =?us-ascii?Q?wW91lc5EiEUl9NyK6esGSCgTJ5l1VtuT4YaqeG2TyAoqBRS72f4tqbb/8LGM?=
 =?us-ascii?Q?9Ax4GeXQ9llKLhlfG9rSx8Dno8cPKa1Sgzy4N9VJ3eWSmYCZjycrKC2GY+Qb?=
 =?us-ascii?Q?qrkjJ76f+W4LHUKw7LN6W0Er1ziS/5kSjQ8XntHxS0Znbt0fU3qe+q7ZLoic?=
 =?us-ascii?Q?TMQfm35vKI/Ltz2f4gM9SCUo+wooutXGnh5VmFitC3KK8Z5wv8X2jZNeUF7s?=
 =?us-ascii?Q?lCl3s79hGOFSUFVl5nUpYQnvdmLiF3JoPfTQyhEongOlQo7aFtQrdOmXu1vR?=
 =?us-ascii?Q?3QiVUawSZSb1ct7Sb9aNM7RlPzA1mdS52h+XO63RRVe57rv4LCNOie0hGa2L?=
 =?us-ascii?Q?8m0lXyjcusG4z8myOW2mjAoaTHL0qRn1ZL5DIgpJhESNf7E05c/yId2IJEYE?=
 =?us-ascii?Q?YdyOrZcvDARhInKXZZ5JhKCiEYCeMyVjEtKj/eqsXl4sNLNZhWYBPoWJEVYk?=
 =?us-ascii?Q?QFNw9QnWnu54qqDvHu3zF/cdSdgfsj+LoUgwj2Dv6jtg6dK22kRE7GR3LqC0?=
 =?us-ascii?Q?7izvmi8vsFK0ugQTUR3s9XvdrEWbFnvCu7W0ygSqZIl2sf1GfS/USLsUfBBD?=
 =?us-ascii?Q?H9xLvyGfggZdy/R0lMsSMOzapXRCJvBfbpNhEEbEowuNif+gEfc/4Udbpd+h?=
 =?us-ascii?Q?6lS4R2OwZcsYjTBYkTv5nVRgM/XDTgxytnubTIE6E1G4YI5yK0U4ksfqKjfK?=
 =?us-ascii?Q?zVyq8bWKHf/v0w7GqkayAHZlRxWrtZeKpMGWKcpOPvIVgvlTB5MpHr6voJHo?=
 =?us-ascii?Q?tXt91U3UHPDSG5OXJOgvHbm4mrzTvGCXhIeaNI0+knogvNKzM5U80OMRh5aH?=
 =?us-ascii?Q?YQm6xsZngtXSXradEnCq96dDe7UmChfo+BcnF0IIksSXCU/kzC4bvoTkuWuE?=
 =?us-ascii?Q?M8gVlwD+5ILTRYPx65tr2gI0pIbbyzPXP/mE7Q0vES78BczZeamLcCjcc1jk?=
 =?us-ascii?Q?s3TjOxwQXMBybORMYiWFhpfQxL5bpVk8W+e9NMVgwpGrmmc0j6fz8zOZM7jF?=
 =?us-ascii?Q?FG/Iq8/USWGu/LFo1KPwoZmLz+RQfgu0h4rvJHnDxajA7752dtb9lELVYwbS?=
 =?us-ascii?Q?sjb4T0c82/aHAasnCkgA33+pldyJaVhfsxG/+cmEXW84OH4u83GuXyxEfY6n?=
 =?us-ascii?Q?KXgfSER45Xo5A2zVLb2ZwxjMH4LNRLoJ6npLBAPDB/oS4NjwudD34+cndv5n?=
 =?us-ascii?Q?N5ooRlNzmsQbSm7dCMAPlheYRiSaFX1yIlVYpLOYzBUlscaQp3o5Wt6N9xCB?=
 =?us-ascii?Q?cywpws9KKax36h8Pl803dlOVkwohBB4hXCUMs4W6mmJ9dL0zQUK/W8wVned6?=
 =?us-ascii?Q?TC29W0OpaFKTiy+ggcyl2QnnrGDvVRQ/o4n0U5faCJj/shG6/rldG+2jiNAd?=
 =?us-ascii?Q?3grNzourFnNDPYZJkoEQHhuvOVnWmadIiEkWzBt0aw8u2e7rrtBVwKFA0ny/?=
 =?us-ascii?Q?hPWsinIUXXLlvv1hWA26hpDsk7t6b05hniBIGgoia9LDptr25Ab8LBQQp45j?=
 =?us-ascii?Q?k8S6Dw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:28:35.9022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 516b5b19-04e4-4995-4527-08de5e606067
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF75EAF8F39
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16144-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,mellanox.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 45C95A090F
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Use the previously introduced shared devlink infrastructure to create
a shared devlink instance for mlx5 PFs that reside on the same physical
chip. The shared instance is identified by the chip's serial number
extracted from PCI VPD (V3 keyword, with fallback to serial number
for older devices).

Each PF that probes calls mlx5_shd_init() which extracts the chip serial
number and uses devlink_shd_get() to get or create the shared instance.
When a PF removes, mlx5_shd_uninit() calls devlink_shd_put() to release
the reference. The shared instance is automatically destroyed when the
last PF removes.

Make the PF devlink instances nested in this shared devlink instance,
allowing userspace to identify which PFs belong to the same physical
chip.

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
 .../net/ethernet/mellanox/mlx5/core/Makefile  |  5 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    | 17 +++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  | 71 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  | 12 ++++
 include/linux/mlx5/driver.h                   |  1 +
 5 files changed, 104 insertions(+), 2 deletions(-)
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
index 4209da722f9a..9cd8361ca00e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -74,6 +74,7 @@
 #include "mlx5_irq.h"
 #include "hwmon.h"
 #include "lag/lag.h"
+#include "sh_devlink.h"
 
 MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
 MODULE_DESCRIPTION("Mellanox 5th generation network adapters (ConnectX series) core driver");
@@ -1520,10 +1521,16 @@ int mlx5_init_one(struct mlx5_core_dev *dev)
 	int err;
 
 	devl_lock(devlink);
+	if (dev->shd) {
+		err = devl_nested_devlink_set(dev->shd, devlink);
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
@@ -2015,6 +2022,13 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
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
@@ -2026,6 +2040,8 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_init_one:
+	mlx5_shd_uninit(dev);
+shd_init_err:
 	mlx5_pci_close(dev);
 pci_init_err:
 	mlx5_mdev_uninit(dev);
@@ -2047,6 +2063,7 @@ static void remove_one(struct pci_dev *pdev)
 	mlx5_drain_health_wq(dev);
 	mlx5_sriov_disable(pdev, false);
 	mlx5_uninit_one(dev);
+	mlx5_shd_uninit(dev);
 	mlx5_pci_close(dev);
 	mlx5_mdev_uninit(dev);
 	mlx5_adev_idx_free(dev->priv.adev_idx);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
new file mode 100644
index 000000000000..202f4ae99fa9
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#include <linux/mlx5/driver.h>
+#include <net/devlink.h>
+
+#include "sh_devlink.h"
+
+static const struct devlink_ops mlx5_shd_ops = {
+};
+
+int mlx5_shd_init(struct mlx5_core_dev *dev)
+{
+	struct pci_dev *pdev = dev->pdev;
+	unsigned int vpd_size, kw_len;
+	struct devlink *devlink;
+	const char *sn;
+	u8 *vpd_data;
+	int err = 0;
+	char *end;
+	int start;
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
+						     PCI_VPD_RO_KEYWORD_SERIALNO,
+						     &kw_len);
+		if (start < 0) {
+			err = -ENOENT;
+			goto out;
+		}
+	}
+	sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
+	if (!sn) {
+		err = -ENOMEM;
+		goto out;
+	}
+	/* Firmware may return spaces at the end of the string, strip it. */
+	end = strchrnul(sn, ' ');
+	*end = '\0';
+
+	/* Get or create shared devlink instance */
+	devlink = devlink_shd_get(sn, &mlx5_shd_ops, 0);
+	kfree(sn);
+	if (!devlink) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	dev->shd = devlink;
+out:
+	kfree(vpd_data);
+	return err;
+}
+
+void mlx5_shd_uninit(struct mlx5_core_dev *dev)
+{
+	if (!dev->shd)
+		return;
+
+	devlink_shd_put(dev->shd);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
new file mode 100644
index 000000000000..8ab8d6940227
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_SH_DEVLINK_H__
+#define __MLX5_SH_DEVLINK_H__
+
+#include <linux/mlx5/driver.h>
+
+int mlx5_shd_init(struct mlx5_core_dev *dev);
+void mlx5_shd_uninit(struct mlx5_core_dev *dev);
+
+#endif /* __MLX5_SH_DEVLINK_H__ */
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index e2d067b1e67b..3657cedc89b1 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -798,6 +798,7 @@ struct mlx5_core_dev {
 	enum mlx5_wc_state wc_state;
 	/* sync write combining state */
 	struct mutex wc_state_lock;
+	struct devlink *shd;
 };
 
 struct mlx5_db {
-- 
2.44.0


