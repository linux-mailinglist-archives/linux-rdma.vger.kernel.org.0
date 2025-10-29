Return-Path: <linux-rdma+bounces-14120-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD2CC1BC2A
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 16:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20DFC34B067
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22692DF13B;
	Wed, 29 Oct 2025 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZB81OTZ+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E450529BD9B;
	Wed, 29 Oct 2025 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752695; cv=fail; b=NLwplO7VU9GM0RCR7Y88pYbQ99MTvMsPrV3iTYILAYBo2dvHHZyHx791mXJ2E8bqlNEJtDMP/jqNuy6jLCrE9JgpYv4GVkrlNExVZeLBlJOrYFDk3o01SgGp81n5Rkcl7a9TjgRzer99z9NpbtHO2gz0bFh4U6ocVvIH9dY3pdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752695; c=relaxed/simple;
	bh=HSe5ucQxhoJacZd9nvTsZF+9DZ3ny6fuBG+0diuXuQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1aQ802PiB8/XcEYsoGzne6YbZ2Ul463AyALZjI2xd/7V1Xa/fGWaiqoJOYEVHWLTVPJ1o8NL148dsYZcSmikev8rvoYAT8mKoD/PFrNZ2im1NGsjV9ji02V/Cp0A6u8nxpuTJ7c/s6FsKi58sQ94NbukNztmuNiiRgT57FzUdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZB81OTZ+; arc=fail smtp.client-ip=40.107.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFeTRgoKJXJe1bGlc9+B1H2wgj/pgTZlOKHoUvs87WHBd8nUsSOPdo+gl7kh+M1Iq3WrH2p7iSlRSRYrw3dfuhAkCZ+mbUqs8HTZClcdeq5GsfKuThE3Jws/+aOMXgOE+NCDgIWj0bbn5psm9CgRDx7t1yv8WZGC4vTW3UMZ2R/hVQCaTS5vDtdrjWbN84aY3+NAcZwJQbe4VIz2BDtx7cCJ0GM1S4UeUiRwLegBotSY/GFw+cgZH4wigsS1UA3SSrQxiMWV/ifgpUykZEkWEpX8HbCfFA9tIXz31WILAmD+dibBhT87RSW6yxRZHGkTHvxvgPFyQDs6l+k4mDm6bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFrx3K9tw4QHrfL9SDZzoACKIY6wionHekJYEEuWIhw=;
 b=qEl7hXiU8ktbO8W93Qsg15jOE/NX6yPcFo56BE34VokBuUN0onpGGywhWs7Doz7mxybtilgR2TMQx5eFKL8zwYRu65vpd0PVjEVZJp6zrs1kcpeEjXnKB8aoCaP7jlkNdGm6DbiZb+AxluNO1Xd1cRsNGEeVBM0yVxihArlP9XO5UnyK55SOjxA5eGxNAiIEcbsw6QIAHbqkpPYbr5NXtDJndj6JYIQk1tP0b7JaG/MDLpWGEmhX9pzRbTJ+7IZvSJKtBlDMm33Yma7T9OoZsd798PX3d78TMwlfAfUDfgLq9Be2H+Uc8dchwV/ACG2iMUBhEiW9BJwXJJ2OrfI7Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFrx3K9tw4QHrfL9SDZzoACKIY6wionHekJYEEuWIhw=;
 b=ZB81OTZ+B0b1uxjZBSpiNuFvJjokGoYAU7cOUJIb/alSQ78ces8HyFk3pU9YYcoBjQUZ0VS+laOeuuMaUDW2H5xpyqnZvjHOujIY6LFSYXmGhjhh+ZAP5WgyXDbiPJrJFVQrWlw9tH1LeFJ4SlonvcBZPivy/9mXdxyrA2Bof5BY5LPGzz3qYVDQ8IUA+cbY/0ZudFinDlIBxD1W76xh9U8ilrBqR8VbN9od4/Uy9/yL4al19ZJeNi456FXwkSIpYLcETmH5qLt6Rhi58NuflwemlyGNBhT7nmydDia/2W05khwCla6i1DopTjoHcWM0WQgV/KorjgjuoVsiwxZV9w==
Received: from BL1PR13CA0002.namprd13.prod.outlook.com (2603:10b6:208:256::7)
 by CH1PR12MB9645.namprd12.prod.outlook.com (2603:10b6:610:2af::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Wed, 29 Oct
 2025 15:44:45 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::7e) by BL1PR13CA0002.outlook.office365.com
 (2603:10b6:208:256::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 15:44:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 15:44:45 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 29 Oct
 2025 08:44:24 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 08:44:23 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 29
 Oct 2025 08:44:18 -0700
From: Edward Srouji <edwards@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Edward Srouji <edwards@nvidia.com>
Subject: [PATCH mlx5-next 3/7] net/mlx5: fs, set non default device per namespace
Date: Wed, 29 Oct 2025 17:42:55 +0200
Message-ID: <20251029-support-other-eswitch-v1-3-98bb707b5d57@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20251029-support-other-eswitch-v1-0-98bb707b5d57@nvidia.com>
References: <20251029-support-other-eswitch-v1-0-98bb707b5d57@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|CH1PR12MB9645:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa0547d-317f-4386-05c3-08de170215d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXpkbUlJS1JhcWdlNWU1M0RYb0I5VXZkSzlhQjRDUTFkZDFUZUR0SFpBNVVT?=
 =?utf-8?B?WDU1VmpXNUVDV0pySW5CWkd4Tklpc2daYU9ZWTFTb20xVG5GZHpaRitCRmlZ?=
 =?utf-8?B?OCtUY0d3blgzL3hZaXVYR0NLV2ExM2gveFFseHlYTm1LbVpBMXZ1REhGaE9Z?=
 =?utf-8?B?OXVDaG5yamVyMzFSbXgvU2M1dWZsaktnMzlNSlp4NXhGN3NrUEMxVnJIQ2N6?=
 =?utf-8?B?RmhYeDZTSC8yYXJtSkk3Q3lXWlRkT0xBUGg3Z0twV0ZOdDg2NlJGWVVXZ3ht?=
 =?utf-8?B?WVdvS3hsOG9xb0pQc3prWnAvTUdTU3hCaW8rSGxmbkZoSkFQVUpSZ2ltSGZ1?=
 =?utf-8?B?N2JMZkNnVWd2R0tVdEdDbjg5czJEdVVxMkMrdUVzTjlxS0h6MWNQc0VIZEd3?=
 =?utf-8?B?RERVejRBQWVGdHNEeElsUGUvaGE3dEorOU5DUjQxY0pFOFB3Z2lnNDFtOVp6?=
 =?utf-8?B?UEVYb2tjbi9DR0x6c2Z3dWpHU01xMk5FbXJSd1E5bWNFbkFPQ0loZ2ZFSFdh?=
 =?utf-8?B?N1RnMTNZc2pTL3Vta2VQbGh2RWtxQUhxSXZkV2JHZmV5anhyekJiVXVWd1U2?=
 =?utf-8?B?TlY1ZzAvN1VRdzQweEVKa0VUL1hwNjZ0MEdHYnljSmIyRmpSTnpBT1IwclBQ?=
 =?utf-8?B?VkhVUXRaelcvdmZiWUY0eSszTHlpRm5Vcm5xZG9ZblR5SFFDYlJiOEhHZmJa?=
 =?utf-8?B?emRxOWxGOXk2eFNXQ01VY1ZyNElQTUF1WmMrQXV4azlRK3AwVkVWdVBxQUJq?=
 =?utf-8?B?YWVLZUsxaC9BNUlOVzVRVFlPSWxkNitIUDUrYVJqZXE5TUZTNXFVMlFLVUtp?=
 =?utf-8?B?MDZOTjdqVHA1NHJGMW1YYlpSN3hPcnAxZkQyUHJOSXBndy9TL0JGcGgycmxG?=
 =?utf-8?B?YWVoS1RxUHBWWWo2RkFXTWFnM2xtVVVYcjMzL1BzQ0QyeXdZVVkvelpQdlE1?=
 =?utf-8?B?SVpkNURmQTlRNGNnWTlyQWdMRE5LZG9Od2xaaEdVOTEwM3U4dWwwdkJaWlVN?=
 =?utf-8?B?NnRBeTBLTnNIZlkzMUhDSFR1SG91SE1kU1dOY3dPbGxsdFpEQ292U1hvTkt2?=
 =?utf-8?B?VWZ5UlJ6T0h5UTQ1L2Q2UHQzd2FGRElQL0ZheUhJeExpMytqcTVHTmMxNGM4?=
 =?utf-8?B?Q2VxaGc5TmFnLzVpZ0FWUUNpaTNPNUpuTkY2RHlldlcxeFducFN1WTJBZXBP?=
 =?utf-8?B?SXppZTg4Q1hoaENlQU96VDVNK2xVdUJ1OVQ0UlZLVFkxeWJQTjIwSVJaOTlo?=
 =?utf-8?B?RTI3U1ZsdDZXc3VKZXJqRVRTZFByVnZURlpWWkF6ZkdMemN4eXUxVW83MGox?=
 =?utf-8?B?VU1FQ251RnhFVG84eERxOStNU2pGK3lvWC85WFJYb0I2eGxITnVRT3BPNWty?=
 =?utf-8?B?djFzRTllajZvaE5sYUF6WFliOUhUM2tpR2hOVlFhQlN0cU12djl0OXcyMkFX?=
 =?utf-8?B?UXdYUzIyUmFwOEhmaHdjaU1BL0tTS3Z3L0hZUThKWlY2KytrNkdpVXZXUy8z?=
 =?utf-8?B?RzQ2S3ZRRFBrYlpPeW9pWjlUMlVCdWgrb3oyZlZPUWFaWVNjbkM0TzZUNEpq?=
 =?utf-8?B?S3MvSjlWMUhXQlRzS284dENCdk5oTWljcUVqdklDTEtvNTZSOXl2QUlkczJD?=
 =?utf-8?B?VXpGbWVTZit1QTdtd0VBRCtOdlZmNzZIRjBqTWhMcEZ0WHUrbG5pTE1zZ2h5?=
 =?utf-8?B?UHVuUm90cWxFMzRJT1dFckVnSHdTRW9ZeldGc0xIanVabDhKdFFMUkQramtI?=
 =?utf-8?B?eksrWGxLOHlQbTc2WUh6S0tUQlZ1ZmxiSEdMNjdRaG9SV0pLc1JkNmFVWUI1?=
 =?utf-8?B?WlpKS0ZUL0VGSHFaZmJCRjZVaWlxcDRpaWxuaGQ3M3NWeHNBZnF2MUxXeTZE?=
 =?utf-8?B?NTN1S1MwSXN3QTlWcUpKSlUwSUJLbGhXYXR2dkVIMURTRFVqeEVwTXRPMWVi?=
 =?utf-8?B?VzNoY2ExMTVGK3VIelJ6a1MyK2dPOVl0RXIvb25qcWh2QlBwcG82R2lGdjBy?=
 =?utf-8?B?NnI5dXNMUHVUNWpyMXpSLzhPR2dVVjVsZmJPMEdmTUg3WkVOenJsN0FMRktS?=
 =?utf-8?B?ZVBDRmw3cjIwNTdOdHJTalZOeHVuRmdOcWk2UEZkZi9xUWcyd2xzazJGdE1v?=
 =?utf-8?Q?RfDX08YPugGxYm8rdCDVqfdDG?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:44:45.4960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa0547d-317f-4386-05c3-08de170215d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9645

From: Patrisious Haddad <phaddad@nvidia.com>

Add mlx5_fs_set_root_dev() function which swaps the root namespace
core device with another one for a given table_type.

It is intended for usage only by RDMA_TRANSPORT tables in case of LAG
configuration, to allow the creation of tables during LAG always
through the LAG master device, which is valid since during LAG the
master is allowed to manage the RDMA_TRANSPORT tables of its slaves.

In addition move the table_type enum to global include to allow its use
in a downstream patch in the RDMA driver.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 56 +++++++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h | 18 --------
 include/linux/mlx5/fs.h                           | 22 +++++++++
 3 files changed, 78 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 87e381c82ed3..5b210c54a592 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3308,6 +3308,62 @@ init_rdma_transport_tx_root_ns_one(struct mlx5_flow_steering *steering,
 	return ret;
 }
 
+static bool mlx5_fs_ns_is_empty(struct mlx5_flow_namespace *ns)
+{
+	struct fs_prio *iter_prio;
+
+	fs_for_each_prio(iter_prio, ns) {
+		if (iter_prio->num_ft)
+			return false;
+	}
+
+	return true;
+}
+
+int mlx5_fs_set_root_dev(struct mlx5_core_dev *dev,
+			 struct mlx5_core_dev *new_dev,
+			 enum fs_flow_table_type table_type)
+{
+	struct mlx5_flow_root_namespace	**root;
+	int total_vports;
+	int i;
+
+	switch (table_type) {
+	case FS_FT_RDMA_TRANSPORT_TX:
+		root = dev->priv.steering->rdma_transport_tx_root_ns;
+		total_vports = dev->priv.steering->rdma_transport_tx_vports;
+		break;
+	case FS_FT_RDMA_TRANSPORT_RX:
+		root = dev->priv.steering->rdma_transport_rx_root_ns;
+		total_vports = dev->priv.steering->rdma_transport_rx_vports;
+		break;
+	default:
+		WARN_ON_ONCE(true);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < total_vports; i++) {
+		mutex_lock(&root[i]->chain_lock);
+		if (!mlx5_fs_ns_is_empty(&root[i]->ns)) {
+			mutex_unlock(&root[i]->chain_lock);
+			goto err;
+		}
+		root[i]->dev = new_dev;
+		mutex_unlock(&root[i]->chain_lock);
+	}
+	return 0;
+err:
+	while (i--) {
+		mutex_lock(&root[i]->chain_lock);
+		root[i]->dev = dev;
+		mutex_unlock(&root[i]->chain_lock);
+	}
+	/* If you hit this error try destroying all flow tables and try again */
+	mlx5_core_err(dev, "Failed to set root device for RDMA TRANSPORT\n");
+	return -EINVAL;
+}
+EXPORT_SYMBOL(mlx5_fs_set_root_dev);
+
 static int init_rdma_transport_rx_root_ns(struct mlx5_flow_steering *steering)
 {
 	struct mlx5_core_dev *dev = steering->dev;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 0a9a5ef34c21..1c6591425260 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -103,24 +103,6 @@ enum fs_node_type {
 	FS_TYPE_FLOW_DEST
 };
 
-enum fs_flow_table_type {
-	FS_FT_NIC_RX          = 0x0,
-	FS_FT_NIC_TX          = 0x1,
-	FS_FT_ESW_EGRESS_ACL  = 0x2,
-	FS_FT_ESW_INGRESS_ACL = 0x3,
-	FS_FT_FDB             = 0X4,
-	FS_FT_SNIFFER_RX	= 0X5,
-	FS_FT_SNIFFER_TX	= 0X6,
-	FS_FT_RDMA_RX		= 0X7,
-	FS_FT_RDMA_TX		= 0X8,
-	FS_FT_PORT_SEL		= 0X9,
-	FS_FT_FDB_RX		= 0xa,
-	FS_FT_FDB_TX		= 0xb,
-	FS_FT_RDMA_TRANSPORT_RX	= 0xd,
-	FS_FT_RDMA_TRANSPORT_TX	= 0xe,
-	FS_FT_MAX_TYPE = FS_FT_RDMA_TRANSPORT_TX,
-};
-
 enum fs_flow_table_op_mod {
 	FS_FT_OP_MOD_NORMAL,
 	FS_FT_OP_MOD_LAG_DEMUX,
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index 6325a7fa0df2..fe721557bd1d 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -128,6 +128,24 @@ enum {
 	FDB_PER_VPORT,
 };
 
+enum fs_flow_table_type {
+	FS_FT_NIC_RX          = 0x0,
+	FS_FT_NIC_TX          = 0x1,
+	FS_FT_ESW_EGRESS_ACL  = 0x2,
+	FS_FT_ESW_INGRESS_ACL = 0x3,
+	FS_FT_FDB             = 0X4,
+	FS_FT_SNIFFER_RX	= 0X5,
+	FS_FT_SNIFFER_TX	= 0X6,
+	FS_FT_RDMA_RX		= 0X7,
+	FS_FT_RDMA_TX		= 0X8,
+	FS_FT_PORT_SEL		= 0X9,
+	FS_FT_FDB_RX		= 0xa,
+	FS_FT_FDB_TX		= 0xb,
+	FS_FT_RDMA_TRANSPORT_RX	= 0xd,
+	FS_FT_RDMA_TRANSPORT_TX	= 0xe,
+	FS_FT_MAX_TYPE = FS_FT_RDMA_TRANSPORT_TX,
+};
+
 struct mlx5_pkt_reformat;
 struct mlx5_modify_hdr;
 struct mlx5_flow_definer;
@@ -355,4 +373,8 @@ u32 mlx5_flow_table_id(struct mlx5_flow_table *ft);
 
 struct mlx5_flow_root_namespace *
 mlx5_get_root_namespace(struct mlx5_core_dev *dev, enum mlx5_flow_namespace_type ns_type);
+
+int mlx5_fs_set_root_dev(struct mlx5_core_dev *dev,
+			 struct mlx5_core_dev *new_dev,
+			 enum fs_flow_table_type table_type);
 #endif

-- 
2.47.1

