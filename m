Return-Path: <linux-rdma+bounces-8061-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D75A43625
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 08:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171A1189A263
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 07:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5DA25C6EF;
	Tue, 25 Feb 2025 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p63qY2lJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E8256C6C;
	Tue, 25 Feb 2025 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740468451; cv=fail; b=HfMXjkBqMkDXGCMu8MWUzInIc8KhEavrD836Mu/l4Tu5OVblTJ4X1R2rgSyEoihdYVbF5bZMPfrOsnt2RU3WvztnDm3PrOxbq3/mf0eYAXoirrxXSpW58XmrAcAuCd2j8p/c3TuY4MwZbEvTORRBD9cdF2G+nwMlyIpBJDY5/lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740468451; c=relaxed/simple;
	bh=yMetKcXPDcHJsBe7A73xyunyWpWtwLL80VNGtIqsVAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULF5zXvSC3wwDSBMNBKcCkXKH/JeBURHbdfv8aM30VnzdHninCwI6tySqqAtFjquEZzwESeyPDSwlzEVKn84Hq+UQDOB0dOoXxGG9DjSZVkI68r1tAF9e9h9yTNeDuuxBBkPHsSc1VwBEgleGds9a+5pXwu30OXev514UY46/N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p63qY2lJ; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EycekmC7GMAZBLOM0MD1yuQlWt1kv9yZuX2sgWP7XqjMa8WeyN8aXzskUaI+t0azFkPC6jVJp+BzF7Ci69tMq4H32v6dNHwA99J1bpu4Jhnsheq8pseKSmiAzZZFohaYzAxtJefan7kiTTibVOgwzojpTOz+2gR++ggdMfh+bDwLmp2H0vWy3F+D6MJ0aeNLb8fhBzbWjNxG5DYnEzJ94SrRnDlk+QV/8bjwUhQZ4Rji/5/b8pjTlo3NrW2ZW4S+TtFQOLNqYzyi1nKH8CRZxd0EHxMo4Yr9Ik18ta0Zj3GSeXd7/6hXAYA2j8+GXrSaVz+oBgW3EyOJG/NM/pJUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk/TVLfjamrwMSjoBEyvl5+bo4M8uTGqh4RpN/BLfm0=;
 b=AU/qq1Iu/FX9NRYu4vwJGB/juEFfKEF+I0WQYkwSk+ldaNBLecqwNG95Ne68+mPWoDHIuxOapmREFtseX8fOi2TUg7J2eJxwYSK/OFjBD5X1TtAZrVDQL6QcNg2tME14aAoDjfj8EKbuPaj9cEaZeQ68ZkYe9IXmL0mCX+lK2OR3sOBl51JemekrkNrkzV1GwIeZ0avlJ9k+c24/5sEBRsts3/XtV2eTpD/dAJagexfbeCUzvoCQg2ePT6fZ+lpArljtJdUwP1aSWw6UPm801p+IckaEyoiuNrIh22EzqOnDpCgFhW2t15tVjzoSLGrJhrdaOWFfNKY7V+wU3CoDWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk/TVLfjamrwMSjoBEyvl5+bo4M8uTGqh4RpN/BLfm0=;
 b=p63qY2lJyEzjsEqt2iz8DkpdkE1fT46L1O6M36B4yJN5GRfwRMmx4Q5F+VFeh65yvDeqUV4T4kfw2wUwG6ByNfQVq4OSMHIv/PH7Dms5SIDhmWgJ8Ifqk8E659B+GsWvRyVspBDaQL5kmCxbol4/mkaJSj1K3zWNDaYH4FYcmR5X0WWCU7rF1yeO0AJgwslaD/ydzWkl99ZAyl5YcGO0TWpyuZu0xnAnRo+vFnKy5ck0BvueguGJPQdfdcAaextOlYmfjGkzM7kjVImlbtEh1QqVnTEOIactMXFXM9nEDZDXIo7OKFBr+1gpOr2aFYVhfknzICTQtkLKgscMyvPYyg==
Received: from SN4PR0501CA0045.namprd05.prod.outlook.com
 (2603:10b6:803:41::22) by MN2PR12MB4359.namprd12.prod.outlook.com
 (2603:10b6:208:265::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Tue, 25 Feb
 2025 07:27:26 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:803:41:cafe::f0) by SN4PR0501CA0045.outlook.office365.com
 (2603:10b6:803:41::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16 via Frontend Transport; Tue,
 25 Feb 2025 07:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 07:27:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 23:27:10 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 23:27:10 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 24
 Feb 2025 23:27:05 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Shay Drory <shayd@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>, "Moshe
 Shemesh" <moshe@nvidia.com>
Subject: [PATCH net 3/3] net/mlx5: IRQ, Fix null string in debug print
Date: Tue, 25 Feb 2025 09:26:08 +0200
Message-ID: <20250225072608.526866-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250225072608.526866-1-tariqt@nvidia.com>
References: <20250225072608.526866-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: ae415b4e-fa77-4dd4-9e99-08dd556dda1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e9pB5gNIFV4Vj3jOIr3mPtG5gdwt0B1GL95VNHAlmWphcQVJRCGYyjujM7f8?=
 =?us-ascii?Q?MULqASmkrdqpLwxfT8d70bke9JQFpK95Hr+JApTAHpdfgVUUuu79YZbhXaot?=
 =?us-ascii?Q?WITJBkv2eUYe8EH8JBcd3Uf9G2lCOwZYMrIMNB8MpAiV7IJx/S7xxJUZMe/F?=
 =?us-ascii?Q?K+JP4EoBRB526eM1Uyhzktol650N+AdexeQMhwL1mXDF6gQyyemwMYXaRUqE?=
 =?us-ascii?Q?R5IPWduKHZfpToIC6/AGMb16zkthM0ubOYI4THk/T4YKxCmRlZQCF0DzZhbJ?=
 =?us-ascii?Q?5j6go+LNxzbZA0GHvKpwAV3c6Uv/oTxFgKFa6cihG1yfFJRgfDsTdcmcUGKx?=
 =?us-ascii?Q?KKe3UfUvW4icjaO501H33Q3ntKEnwjdqV3Bf89gxO2Mw1Ni137Yh8mqOuyOK?=
 =?us-ascii?Q?rW49SesJwfF/N9qQjeXH86wFCxSh+e3NmafzYpWPRNmVoWvfAO7zC9ax0tcI?=
 =?us-ascii?Q?eS06CoGhslqfYXygkHBjEK+XetB/LoTMZJxeeIaNZXAbzPulJD6TnP1qVmH8?=
 =?us-ascii?Q?N6ky8DiFZRXpbW+ylPs4P94eH+azLGfInGg8b322r7ulh0PBq2bmoFAxKOQS?=
 =?us-ascii?Q?+NLOKC9mCx4iMUV4zB3GTajspp6mpUtoX59NC9eMAmEbgd08MJCymDoFKOpP?=
 =?us-ascii?Q?U3DU2nIbOXagtJW5NSyA8Qx1m8HUOD0B3lakhQSaURSOfTWqLysK9sNH0YtO?=
 =?us-ascii?Q?D4gGAyYwVaAn3YxLNA63nXWtIXJzUbj1hkB8VckXCWZTN5y2wMxYWNUKJd0N?=
 =?us-ascii?Q?bPPLT52hhnxMgrIzIWfKP/9b/5NTcw/mTOakxOVoibT0MdH5XuU89J1L830+?=
 =?us-ascii?Q?bY0KAwI3Otlt2WZgI+9W0DoaLoy6Or5c8rC1mv07ITobX54RIEehL111+rGk?=
 =?us-ascii?Q?ArruuTdmfggp97WeZHjKk3kSS2JiFyVPQlsjpmIV38t9KVj70bPQxi4Xr05D?=
 =?us-ascii?Q?x9h+jkGRNS7Q53Um1wKoITshK2qHBCDgmIfrB0QjAXxSBSsMGaHYJZ385+5/?=
 =?us-ascii?Q?pbuiqC0T/vXi5CpY99ygiKaahmbqWWLrRIorR+ahM9E7h4ebAJ/1ZYhrXUCn?=
 =?us-ascii?Q?oNWGvQA65lCZfXnCEFk9t4CpJ0VxYJYNEflZ1DDG3ZSyASaR7WrvD1R00N2o?=
 =?us-ascii?Q?8apPvF5xE4MlxyKwV/8RujKqeQ7tairjHx59FBzMkmKP4bo+vIj8NV02JI9w?=
 =?us-ascii?Q?uFnrQH0+hhYFbFZAGkvI7my1Tmtt7SSU3donzG5bVol8esAlbrfO7ffSjnNS?=
 =?us-ascii?Q?3H2+3vg69PCDdnrP9dWx46uRsmaV00aDdA9QHRcGkaWmMwGKPLSZIdpm3qFK?=
 =?us-ascii?Q?6L5O644bPzBly7gKWbbSZ9XanccZ9++6r44fmHfPoWsc58ah2vfUjtAPC/qg?=
 =?us-ascii?Q?5C6WZ+rsW4Lo5QR7/wMGS5jQkqD9aIEnS64GPnwc4sGwUA4y8Vat3bPmSsp9?=
 =?us-ascii?Q?wEdHqp64vKO9fdwUxy61uMWh1Nb1Uvr6nuygGUaFTAN0qhcZ759Vpr3Rt9f0?=
 =?us-ascii?Q?Zv3cAhgVsXBn/yA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 07:27:25.4153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae415b4e-fa77-4dd4-9e99-08dd556dda1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359

From: Shay Drory <shayd@nvidia.com>

irq_pool_alloc() debug print can print a null string.
Fix it by providing a default string to print.

Fixes: 71e084e26414 ("net/mlx5: Allocating a pool of MSI-X vectors for SFs")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501141055.SwfIphN0-lkp@intel.com/
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 7db9cab9bedf..d9362eabc6a1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -572,7 +572,7 @@ irq_pool_alloc(struct mlx5_core_dev *dev, int start, int size, char *name,
 	pool->min_threshold = min_threshold * MLX5_EQ_REFS_PER_IRQ;
 	pool->max_threshold = max_threshold * MLX5_EQ_REFS_PER_IRQ;
 	mlx5_core_dbg(dev, "pool->name = %s, pool->size = %d, pool->start = %d",
-		      name, size, start);
+		      name ? name : "mlx5_pcif_pool", size, start);
 	return pool;
 }
 
-- 
2.45.0


