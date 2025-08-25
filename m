Return-Path: <linux-rdma+bounces-12895-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D80FB3443B
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 16:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC571885D20
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 14:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16718301005;
	Mon, 25 Aug 2025 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EbdKzVRH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE577301014;
	Mon, 25 Aug 2025 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132535; cv=fail; b=sXXPinece1mP31kW9bL9rFKlvgHikDcCq8PRPZWtljR9XWQl2tgGd3/Uab3OVg2p0HexxoecsT1Xucu/fr40GX7RqkbgLXm+v/Xw/lc3m6CdHgVZ/ML9uXg8/M6BLHLNjG2dbZnwRv3goZxrFC4ASTmFecn8VfcxltFESM7AFyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132535; c=relaxed/simple;
	bh=JE1eBLNmX3rogJ4DLnXySTyZtnQasbQx+L8iX7fMxAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UO8hO2+yXypE2FWznLh3QM5nbhNX1c82csiFFf+u/a3QgowvMshSCdRV/GG5DY1JhdpG/TVumhKJEGanIlMUGCg0MqkYMa9X9fuuHx+WTDdp52N3Op0/cRXZEQt4YI/QM+K6B+h7VGfTq1b2rMt6vAspjMusj2lWzcdMhIeF+vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EbdKzVRH; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6UXcxE0N4fSwl5BsgptD3TM9CPXLzQSbDYBaFr7PiUJBpQmEL9h7mOBMRuRQ8Y50S02bDPztmHpk2BZTO13HeyGFFrCpS9FRXbWm2+ds1pNzxYaRp06/Wf/RVv9qPdJKuDHqF6rRItnAXkwSQqdrmHr4K/VMdsaxqCq4DJ4A7GnRRK8VPYDVKCGfKp/OnHA5QCmg5z8yUqP+Edp4JPy243nxfpObrSCP8siyxnHU2G5t0Uxcg2uGQYrkdQW9Z3j+/G35Jkd7WU9XP1Ra6+8tijZ2p12szOd7HCBi+MgEqCBfl0jx9PXu2xYYjeqx0b/iKpImrPT02jMnwONGGKaUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YC6jKf1uXNMAXAqRNuaoFXzlguS77lxoOrcxLGKaz/Y=;
 b=GBJvA/BrzofPFAaUm/O2H8HtXIqAa/Podm/BUx0QHai0WDiaaIc7DkDd8rV8VCVYUPS7WXiiuA4bXG14dsXfviAquFgU1yK5CLyFzNsUnvuhqQEZIzLrcyNGb7ajFNLqryhhXad5lCZIN7Au24N01B1Z5IJT2LTZIqX0LFs4TcfK52FHrnduKECY+VXvDqoO7WVoteJTESWRLbF0KdEx2ZsKCC2gaeabrJx0o8F79UvqPESw6Gy5KOBidrMKWzg//TdjC2X9zbB83klrzgrW32EF7xUr6OaMINqIaESKA+yzoX9sPkV4EmsBLuAhg4K7IyTSRldX+laCmn3OJYj8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YC6jKf1uXNMAXAqRNuaoFXzlguS77lxoOrcxLGKaz/Y=;
 b=EbdKzVRH7hJvpxcIjE0S08EijFS7JPGSgCdIgx4zNqSjo7jtpcYsQ43gde4kQFwwIBwRYXbPdV3BzfT0Fpqvx1zkTQuOPXBbVqVHoe/BA0eX6pTMXH/n7/Y9MkQRqC1dCJgglFEpsOpebvABJwmAcV5jj40tJL1RUzHNeD4m5hTeoacWtsMk6cARBniOM0AgyuZeatCjerGZTgV4QKGTUTQZRqPh9Z8boyQkzLf98FKghWbPgUZAUanMqIw/pZb4V8eQPHMT0TEfFDXZwODcWncxmLRW4bCriifHVkH8bLtCebLGfRVoeKiTTFwUQq1hjlV3uN44sZn/w2b8PT38mg==
Received: from CH0PR04CA0076.namprd04.prod.outlook.com (2603:10b6:610:74::21)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Mon, 25 Aug
 2025 14:35:24 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::2d) by CH0PR04CA0076.outlook.office365.com
 (2603:10b6:610:74::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Mon,
 25 Aug 2025 14:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 14:35:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 07:35:09 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 25 Aug 2025 07:35:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 25 Aug 2025 07:35:05 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, "Akiva
 Goldberger" <agoldberger@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Jiri
 Pirko" <jiri@resnulli.us>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net V2 05/11] net/mlx5: Reload auxiliary drivers on fw_activate
Date: Mon, 25 Aug 2025 17:34:28 +0300
Message-ID: <20250825143435.598584-6-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825143435.598584-1-mbloch@nvidia.com>
References: <20250825143435.598584-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b535f87-aeb3-480d-3aa3-08dde3e4a0c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NqbYFDWTK6u45FXnBlTV0REFYBg7RnqLldChRUFd2F/zaXVXV9Jkm0jvaTGq?=
 =?us-ascii?Q?6QbYAOK7eg8Z1eVN7UkHkGPOjQ6T4oWG9jv6NGKIt6bQHHf9AfeGKHKWizAI?=
 =?us-ascii?Q?PmNQlbB0WdNJHw4R2Y63Tifgz+f9bzeNZ9ryp3DJW6NQ4rG+/mFmymZJmgBJ?=
 =?us-ascii?Q?0IkTGsVGpICCz0AWmyEqVjJHiH1RPcZc8w+EQGoLG5CgAMvyRkF7la5icnCK?=
 =?us-ascii?Q?e4Q+Sx3ytBKwr4VjOyOEXN+fBwEtifgZrEz6kUgaEITs4a/L8WrJEWRLNnTR?=
 =?us-ascii?Q?X5uc0B8dnwwGil9jF3LxvCurxVM8bnR/P6qzT84ll2aJC5Oq7goEYOboQiq6?=
 =?us-ascii?Q?F+3Om+Ri6EnJ9iYBlS7g3TcVb2v5m3xL42+OoMXbq9gAyeIOx+Iz/jP88cQh?=
 =?us-ascii?Q?X+LFV9X93FVbqrU37I9p9EUe2+iu+f7RvJK4np9QVNwa/cQhR3gSFN0XWKO4?=
 =?us-ascii?Q?yqoCVAFA8ieXHqBGFEPOZxhdI09PivcvdSFSRKEde+He/0cHyJqfEdQE9FBN?=
 =?us-ascii?Q?olM3+vwDyXeGT2iE1czQeuecAD5e2fw0iLP5TXLYR/8xaax+VlnZAD9ZuRgG?=
 =?us-ascii?Q?Rw2xOLkTb3ARvvu7UqWPXek2YEIghkgeRbQK20jZAnwsAnQTbrdJf5Q36zse?=
 =?us-ascii?Q?CjIpIg4gK83PlpvB34L/vXnI4dgVHJrSiI4+GZMjbZcrH9FAz3dlMEmVj8fI?=
 =?us-ascii?Q?eH2L059GArvHfLh16nEpcYbdDFmHd66KNGcccr0hUEwAG+m8/hoS6LGzPbhk?=
 =?us-ascii?Q?ida+LA74LqSsHhpy+anvOAVgrPMdsutRNUrs8vEAIOyDAs6Yg4GyCN0clvRu?=
 =?us-ascii?Q?pp2lOtAnsvT9sTrl8+3fpeSjR83+WKlxS35XsPLgdt3XUofrXTmNYJg6rU6P?=
 =?us-ascii?Q?+Oqn+c3U/Tc5pJC7sOt+BPqj0okRuDnWJ2Cb83jogpSRs5vGTGMAdxjaQtBr?=
 =?us-ascii?Q?0NtqRxy6D2TpYWmGchEvLlg5Ls5L2Lsx8X0P2TNq1shUWhV2QaoEYBFxH2cr?=
 =?us-ascii?Q?rL02wVC3QNrUfEes0XJ+4KCvScRTLFKHQZNFDf0n83q1OI/I7+/gueMSLe9R?=
 =?us-ascii?Q?PTh+KOoeJN7opjjNECLYdpF1X0slZOZ1YKmGlEJ21aujNOxpo3Rxm3QNCw5l?=
 =?us-ascii?Q?T9uH0eB49S0+a5oJyof8vSTrE4pZzJXtA/pRLWK/u9aU2HetYB8F9FqNrOLR?=
 =?us-ascii?Q?qMJ5UwUSziF6U3IRoJPmFzzvTwL+0cQIU3XYyVAoszJ1qAeOQUm6+AHjOkSI?=
 =?us-ascii?Q?Ky293HfdOa3Z5NYYWsndFuPA3zXCBPBmGLJI8Z1OJ/rIa+0Q9Xtl4MTzhguN?=
 =?us-ascii?Q?TMxRxILjQdJh/9VDCbbAN6wD4I98Vx5182+nsmofQvurifiu8nFY2HxHt1jg?=
 =?us-ascii?Q?2WPU5b+fW6pWpt3ciH7rquzWIqUW92kTFdsl2CKm6jI+u0VuR1f3fqeqwFUM?=
 =?us-ascii?Q?UAmrZTDg5Yq1fNPwc2z1YkF8ZEzNSQuk9kM0t3fBFm8fEpF8pH7hLWZpxORX?=
 =?us-ascii?Q?A0vzPj4OCHo5voDxnCgYf5ZqK07gWh8UtFkN?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:35:24.3984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b535f87-aeb3-480d-3aa3-08dde3e4a0c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097

From: Moshe Shemesh <moshe@nvidia.com>

The devlink reload fw_activate command performs firmware activation
followed by driver reload, while devlink reload driver_reinit triggers
only driver reload. However, the driver reload logic differs between the
two modes, as on driver_reinit mode mlx5 also reloads auxiliary drivers,
while in fw_activate mode the auxiliary drivers are suspended where
applicable.

Additionally, following the cited commit, if the device has multiple PFs,
the behavior during fw_activate may vary between PFs: one PF may suspend
auxiliary drivers, while another reloads them.

Align devlink dev reload fw_activate behavior with devlink dev reload
driver_reinit, to reload all auxiliary drivers.

Fixes: 72ed5d5624af ("net/mlx5: Suspend auxiliary devices only in case of PCI device suspend")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Akiva Goldberger <agoldberger@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 3ffa3fbacd16..26091e7536d3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -160,7 +160,7 @@ static int mlx5_devlink_reload_fw_activate(struct devlink *devlink, struct netli
 	if (err)
 		return err;
 
-	mlx5_unload_one_devl_locked(dev, true);
+	mlx5_unload_one_devl_locked(dev, false);
 	err = mlx5_health_wait_pci_up(dev);
 	if (err)
 		NL_SET_ERR_MSG_MOD(extack, "FW activate aborted, PCI reads fail after reset");
-- 
2.34.1


