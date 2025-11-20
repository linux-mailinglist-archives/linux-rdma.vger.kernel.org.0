Return-Path: <linux-rdma+bounces-14651-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95519C74280
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 14:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 8C71D2FF01
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 13:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B553446B8;
	Thu, 20 Nov 2025 13:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hk5JVGdQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8859330B0E;
	Thu, 20 Nov 2025 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644507; cv=fail; b=V9s7886kbD+pH+5CHz5Mb1TwLJN5UAaYcTJ6g/y8bBNbX0GwpCH9FVE2A5aP5zETEpBfHu63SCXlMo4HTfYq+oHAbfLpb+bVN2k45dw4JUkuIQkkCbTwx45zyd8HB+GxFupjEYtV1amQJkg8CTTpSUn8zXLE8UCwoqOxKjByDCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644507; c=relaxed/simple;
	bh=rvFJmylhuuqsw4pVJiuKIF4yciWktth2pmuLyqCafpM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q96i6nhI9qfra9I1Wp8CpNivy1Ynj9yOmHoeFxCyQ8ioRySxSpTjg/I2ud4GWvJZwvZXpUUL3YJ6pPpOfHxXqQTTJsG2odhzBgA14fQIG0LVcgCDq3Z7Q2FZVPivz1fI1DMIUi3uDjy6cp0+FAIGTeegMFb/yrml/g5qEBY+020=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hk5JVGdQ; arc=fail smtp.client-ip=52.101.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cw+4+7lJZEY3HmtbcxS/zPv6XvlNgYt8521eIkRNBR+xAbtfzvephajQv4CWmHSkdWkQPdTlp5dvVuFcdQSgU+OqpJagz8WnN28hOcuHWPndtzy2ODaF96EXVKi5lqqIzj1NDyGWTjwj6kaT0X1v7Di8HlT1aQZUr8Rjeb9U1DrwZK2c//qqw9tV8kUfVI1O5ruapX/eOezRTz4S7ONJowRjg2ixKIywMyWqV4+M98iLbv7e2hQDMwNJjep5zakWcv/2RO1iEcdFU+m5G3LnLX/NXJg1PbAvKq2ucfFXBiIY+wkKwEc3WYxjPFau6WczHEa9dNzpv84hVWlqixLQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VsQcyutSzrD9+Bmx/egBEONQLk4MXX0Rt2lxYWhEaY=;
 b=cQ9k1qSv/CNZMKTcYvVUKPBas/ZYDGyXuXQlhReHO3Y9SrBZ9iN4905+XXJloNxzQRg3APM9upZMhjVa/L56rMVM2EazMRQ4q0BUXLzmjL8N68RhQQDCb+rcefoIavzUjJn1fwGStugU4qGynJzX8fNgEYYmRfs8bzUr2+zDazzivTVSB4tD94JsaGlUH1/kRqz37FH94zq4brYej+bDo9nO6E00oACALmA/CBKtXM8z5nxC+6kNHQ4f/tQ8/dfah/Phf5SDXyCmgxktxp+g2XRSjwkMcmp37TXiV47ozM0KIF45wdm/BwruWc3w5xB7XCmxaPFq/2Q7APU4gyP2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VsQcyutSzrD9+Bmx/egBEONQLk4MXX0Rt2lxYWhEaY=;
 b=hk5JVGdQSMQWz7NIeUcegfCDIflTgn01a0i0ss/Kr/QZuTNk/LqXrBeD0esR2Z2JNbk8m8t0h2r//tXo3wwiL0/K822er0vPC/6QJcHOul/Hn/Swnsh+OH80zzEzD13ri/ItbLJVC32wNQypStA03zEvAXrhOF7tBVIwbKt+8MIzmZ7cbBE781PuoUGhD1ILXca7yvAtuvHgZIk3VWYThB/73Cf6TCJ1lMRZYF6ZpOfzoJBSZySEzKSAoL5vg5AX/G92L/KODJZhQmpWA+eDfpqL+nOstHeUuqYA2Bl1WsYJnKamzs1TSi0V1yEZs6D9M7QTY7SPMA6s+8g8kn14Pw==
Received: from BN9PR03CA0354.namprd03.prod.outlook.com (2603:10b6:408:f6::29)
 by SA1PR12MB6869.namprd12.prod.outlook.com (2603:10b6:806:25d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:14:59 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::3a) by BN9PR03CA0354.outlook.office365.com
 (2603:10b6:408:f6::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 13:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:14:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:14:40 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:14:39 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 20
 Nov 2025 05:14:34 -0800
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
Subject: [PATCH net-next 14/14] net/mlx5: Document devlink rates
Date: Thu, 20 Nov 2025 15:09:26 +0200
Message-ID: <1763644166-1250608-15-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
References: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|SA1PR12MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: df631b7f-292d-42d4-0f7b-08de2836ce78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iatKkzWl2BgrXOmwFGCASxsU7MLvmd834+7tuzkPpYmT0/O8NdXPhGMCRjwU?=
 =?us-ascii?Q?7On4EbGz65L/Gdq8qZlLF5Mtxx2gDn+WLjBOACmHPeYxIRGMf3C/JV6RXdWr?=
 =?us-ascii?Q?z1mrC8E+64TYh9GZsAjjb1pzVyCzA93yJ8qIcZJiGTYoKn/gKJNrViVE2wYQ?=
 =?us-ascii?Q?1CuZpialdmPfpi3rL5TIAAPEn+Jn0aWTTjBiA+WFx4JnECm+PQif+bh8evzC?=
 =?us-ascii?Q?8IZDUgyVwvFBMotvvVNVFqc8dwI/Dtbbc7uLym4FIS4GDyVG9GDL6Uvm8FRt?=
 =?us-ascii?Q?lnbGk9jGIs//6e9jahYMJU+4u7U8TEyF596igAVlb+Axw2VsRion7eQO9iH/?=
 =?us-ascii?Q?91wZY3zAJAPQD8J6d58EpgSO0166bb2oOs/SEfM2ikcsFZVB4hUevPbJudWx?=
 =?us-ascii?Q?02/cfswXiWS0FkwIhEelrW/8nrW3Dfxj4V+5jToNcpqQCSXoWTx1WARTht/n?=
 =?us-ascii?Q?t1utvQoyBl8t3MqsrsabRkKkZH8QqqPHRy668YJDNs/kV5ikOSwCT64P7pw/?=
 =?us-ascii?Q?QqXi3SBjTthajnnMi7PZE+7rWxG0B977R7MvPlqgO10DVuRwZv0RBN+Tgk+K?=
 =?us-ascii?Q?nx5aInQBKC0f9ihQRQP9E2vwnA2dKu+fK9Mewzi29w5NXgLNw+zBqwY6A4Ak?=
 =?us-ascii?Q?VElik0MtMoiagYWWck5opHXwVOxfhUBBrV448bF4Z1Dx0pYCPUehdGIH0rDy?=
 =?us-ascii?Q?T7XRXHWRsNg/RXbS92LAadg8RJK5DuXO/zDZAurpg+hcPoLkfCzfFIIs4Qsn?=
 =?us-ascii?Q?XiePrfB7GDX6ZGKZ/xC/k56LzDoiAF2Xfn9VDMC+hElBnvqa1V1HPRzGPadD?=
 =?us-ascii?Q?jvbMGXKFfk5/JIs9ttW3EumKI1THwLjyq2ebQ8aHNfhgOmkEHFrwtKhfg1XY?=
 =?us-ascii?Q?dNs0e4z4dN11x4UQhKwGMVhgwRkl4lCLpVQ3cGV6Id1z7oHB7om2YzqV9LGs?=
 =?us-ascii?Q?dikdR3+2k4XktZRKH6kHz5JeDYFFA/sJcYbbPfLVtsyPgrWfLou11yx57Umj?=
 =?us-ascii?Q?xh/ml13yFVV2UcUrDAMQLWLWjihIMT2Pa0AieZ96pDR8z4PSF0UKwpx+WaDx?=
 =?us-ascii?Q?8P4DOf/CJxI0HD3vrwet1CaX/Qm/Q9hYY1cWHoQ1bVDtjQk+knInG3mUyxfW?=
 =?us-ascii?Q?nB34F3JcuYTcaZpSBrxpckBDfztHHzoypMPBdD28aPMqBe0EYa4DIOjqA4Qu?=
 =?us-ascii?Q?9Z+Y4gvqZqazgd9jCyMo6p1Yoc9UzAlBTvArPL2f+QKWHWci4D+zekOlHNI/?=
 =?us-ascii?Q?F9gLV4HZnD/Uwox/JLRFl+DKza7+7O/ZmZHeVq74VEJn2S2UfaWTXMV9GhuP?=
 =?us-ascii?Q?/uILExGgK7LQDdQof919oGU326ZNhKmIiaZt9mRdCFFjLBjjRACqUjQszFi/?=
 =?us-ascii?Q?vwMiCvAgO0BqLVhZ8O2JxQtrv/v3iZJoxqqlfFFn/zGbA+eejqOi+Bzrv3Ru?=
 =?us-ascii?Q?JeE46whBB0RAuQVp6UpW77o4NwoRdmhTHqvIAma8ruB6rsCsC1K+tokNx4lI?=
 =?us-ascii?Q?+0IHf7533taVhY80nAxUreb/QTMt9lbGGGnosFoLZxB6lnaKX2ljrq3w5mPI?=
 =?us-ascii?Q?/SaJVyrvMMrSHQ68GZQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:14:58.8657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df631b7f-292d-42d4-0f7b-08de2836ce78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6869

From: Cosmin Ratiu <cratiu@nvidia.com>

It seems rates were not documented in the mlx5-specific file, so add
examples on how to limit VFs and groups and also provide an example of
the intended way to achieve cross-esw scheduling.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/mlx5.rst | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
index 0e5f9c76e514..eb260fd1e880 100644
--- a/Documentation/networking/devlink/mlx5.rst
+++ b/Documentation/networking/devlink/mlx5.rst
@@ -405,3 +405,36 @@ User commands examples:
 
 .. note::
    This command can run over all interfaces such as PF/VF and representor ports.
+
+Rates
+=====
+
+mlx5 devices can limit transmission of individual VFs or a group of them via
+the devlink-rate API in switchdev mode.
+
+User commands examples:
+
+- Print the existing rates::
+
+    $ devlink port function rate show
+
+- Set a max tx limit on traffic from VF0::
+
+    $ devlink port function rate set pci/0000:82:00.0/1 tx_max 10Gbit
+
+- Create a rate group with a max tx limit and adding two VFs to it::
+
+    $ devlink port function rate add pci/0000:82:00.0/group1 tx_max 10Gbit
+    $ devlink port function rate set pci/0000:82:00.0/1 parent group1
+    $ devlink port function rate set pci/0000:82:00.0/2 parent group1
+
+- Same scenario, with a min guarantee of 20% of the bandwidth for the first VFs::
+
+    $ devlink port function rate add pci/0000:82:00.0/group1 tx_max 10Gbit
+    $ devlink port function rate set pci/0000:82:00.0/1 parent group1 tx_share 2Gbit
+    $ devlink port function rate set pci/0000:82:00.0/2 parent group1
+
+- Cross-device scheduling::
+
+    $ devlink port function rate add pci/0000:82:00.0/group1 tx_max 10Gbit
+    $ devlink port function rate set pci/0000:82:00.1/32769 parent pci/0000:82:00.0/group1
-- 
2.31.1


