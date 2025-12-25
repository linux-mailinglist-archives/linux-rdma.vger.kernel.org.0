Return-Path: <linux-rdma+bounces-15219-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F15ACDDD16
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 14:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74C9C3021E8A
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 13:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ED83203A1;
	Thu, 25 Dec 2025 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I+/RtyT+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62145314B81;
	Thu, 25 Dec 2025 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766669267; cv=fail; b=K7i89/LZWCFiQRm6dF2ZT/4VY3HC4DGdylt8cmKvCn4M+ZpAdXPEtXZI078y75PD23yPVc0/zSvX+eiIjSQuxIROUh4N14J9Pv7vc1doRpqajrR1dv27dYJ2tWMADHZK80obaCGG3/9wIoZF3WuqcTL0h7zD8B+kjdV76lwpFyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766669267; c=relaxed/simple;
	bh=PxFtC596I+NJFLBjC08M/6JcK9Q5BzOdT/BiC/fmggg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uyDnY9VHYKX/heVT3ThftGn+mmAGcQwMLjDyIxt8GbnVBvgnjUETYhPgRk8MuKno66sBVuINHSXUwq4PwWKdyxG7NHpeC6cUpTyYnurii2xruQQJFeE/Dlh99ewNm9FR77M0mV6d+LC9xoQvvmAVUxZg3wQx5f2+mJ1BmHZLEao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I+/RtyT+; arc=fail smtp.client-ip=52.101.62.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7QctwQd3WYnrzVn13FGALbnCAf2fHnedD2KYVA8uYebmGJ/87iy2t/0Cg4NAdFrNrMVu1Owy5PXyMtuv73nmIouBDJI17vRe3rKHWnyyvpv2xfw5PNF9xNKmYE30zaUk4l0NR074cbGnR0hdfshvSgPeBlp1kuZ0pqiIgu6J+RLglycS3fDAMKuPZCt3WGT22vhdgOgq6HK/Mu++JZWnZMFkLQZfI6G1bGO5xC3Zmo0FOHrfT5cwTZ2n8WWWNWFj6VX7U4eS1sXWXvUXQ6hCFzZvORptemS3pxSBr8f446YMWRRESdc/SMUiPPiWacy70JgWZRhi6buRsHHXLD6NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L96GH+2QzzloARZdS/f0tx/37RhzTmW9LKHuN6JK3N0=;
 b=J2dpKF5jA/SPfQ6TnDcqL1WvVILH3pqCMameHeme/HPo46zAO4pDL14h9T7Iz7IgFgN7yQJ4e40DykYWSD4NqJvZ4LsPGGs6Vb0BAh3/+xf+QiHcgoIyc1Ict5dTJP/NoMon7vNCoe1tPKNpvhdl/f8T/2NJkXblWv4D80alUwDe60JiyQ1pX7ntrPK2anOlUzjBVzCmr+nIZF29+VLXJpwYt936izDiquqkmo2n1qGLQ4uwc6KpOwzqhzZmWzotqx+gXZUrw8CWj+OxpAcp7lG2+oRmHZOov6vJW/Ax33+E2RuaoR/CEsms7Rh7jqajSHdlBreUZdf6IzUPD+wacQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L96GH+2QzzloARZdS/f0tx/37RhzTmW9LKHuN6JK3N0=;
 b=I+/RtyT+i1rgysrSzR8LNtPQETdrTIPQ/TS2FtcuHEDlltGjjXhd/ecTPqC7cIWhc2Zjbysup++NnbdJ4HJYL0GJEV2km6hiM6g3EM+P4qE2fZ2JUWzn4k6fPOu7SAgIHfpS96zKUWCRCmMs1rQg8tGf/jN28gdPyNXGkR+PMjlPszcsW/Yn6wvrms8ObSttByBvV8/sR7fXCDNwrhdg+LxZLXybvhn8NP2Ynl44vsYBFO/scOWNtBFuwvgmyTQsAgITkj6xEXA+yFw3cDw48zBa51rAP3i+pt2nWY+rv/S9YO48bdgzrv86/G4EmDyLtVMfc9xt0/6AA/2nGWsDHQ==
Received: from CH0P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::34)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Thu, 25 Dec
 2025 13:27:41 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::1) by CH0P223CA0016.outlook.office365.com
 (2603:10b6:610:116::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.11 via Frontend Transport; Thu,
 25 Dec 2025 13:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Thu, 25 Dec 2025 13:27:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Dec
 2025 05:27:40 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 25 Dec 2025 05:27:39 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 25 Dec 2025 05:27:36 -0800
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net 3/5] net/mlx5e: Fix NULL pointer dereference in ioctl module EEPROM query
Date: Thu, 25 Dec 2025 15:27:15 +0200
Message-ID: <20251225132717.358820-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251225132717.358820-1-mbloch@nvidia.com>
References: <20251225132717.358820-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: f10eaab2-2cf4-4e69-a13b-08de43b9617d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2KRIe+1+99s9QClxLwX1XMhIBaTboLRrsdMs0MMt/OMhuDAtWoagcoVF8ylP?=
 =?us-ascii?Q?nLOgi6e7CyFeM6WQavAMiXalwO9NpInTm1pV8gDhtuWSt73Yi4tV9Uj8vL2C?=
 =?us-ascii?Q?KTc18zWZ6RCDiFUiIlGATdYDi88oGOBPu9lOQn1dWsVfsENabCabfnqhn0dM?=
 =?us-ascii?Q?tNkQQL9+l6V/vnuvU2VNkbPgQ8COEt0uHlLZIWdtBFbP1wGexb2MzpTLdqSH?=
 =?us-ascii?Q?hqOyyM5Bezmjmh6eYMoQviut85hzNvRwlz/bGbmf0gkJqcqhoc8hEeUi/y6I?=
 =?us-ascii?Q?OYXrMrJ7gEyD12R7guzKy+u7cFxlCgkApPaGf289mlkkkl6hpCGIJNgSMyka?=
 =?us-ascii?Q?g0Xwl8MfjdKp++xev0aCPAI4ncmFzlbuGvU2/toJfiva1VffzC6ENQWZp8DS?=
 =?us-ascii?Q?cp0+VV71W5VExjnvBharFtH8U4XA2M7wuvgkJvQFK26QKo8YD+PL+cKwba7c?=
 =?us-ascii?Q?S3V3UYE4qLzhjWfkbMUIV44pd7PLk4g2amFDTsrCO4eMY8RIinIkr1laBDdW?=
 =?us-ascii?Q?TIUxPSIRtScuCSu0tfxMSqRcss8dkcweg7SrvQmLHCZ3Gezcu7r8Qsmr80ZH?=
 =?us-ascii?Q?VXG5yIQrVeUd5L5YDyazR9C13dKE1gX1CaaY+WV6XAObpYCHew+F92U+clXi?=
 =?us-ascii?Q?xfL/6uSD/DUiVgJqsX49p6x/sRhMPidGIBNCrtMdbaVMlqupsufr7il8lvWq?=
 =?us-ascii?Q?GO2ma9f6ygQMom2QxNy+GDTO1fTejHoMMARTU/0axbaER1ikm4xAQ4cKqpZe?=
 =?us-ascii?Q?3JzTRSA8hmQsMB8bOkUU1qLPsd0WUH7nklqzSvijOm8v2M2iIVV+8qDCTCKJ?=
 =?us-ascii?Q?Dh4Jzd8LHlY9ptb2Yl+2y/9MD5wnZFxoFT0ja3ir4iIpH1d7HGs/ISPGs5CM?=
 =?us-ascii?Q?RI5yAglgf9TesBusWgf8m1P/aKhHtpcrxdWFqpadHtd8PsSNmGaFsq/2aFdH?=
 =?us-ascii?Q?jec86acKcFlkFlIX3mP67wfWFDayftVl+oGdh65cSM9qelqAQ/d4QtqZBy8N?=
 =?us-ascii?Q?BzZMx/lTA3F7/eEGs5Fz/gwhGawedGoJyIBgBJBVS4tA60d2gxl+z7bVG/xu?=
 =?us-ascii?Q?vPU/TwEM1XTZE7DI15VLvKkHhWb4K8/XjKTtVWFsMme2MJBwC0N/ZhvlgPEq?=
 =?us-ascii?Q?gF+DmV9DQzKpYpSDL0vY2zjWr1M7vbUsp/wWbxheH2t91cyCHB6joYXrcoVm?=
 =?us-ascii?Q?tRaSH2o3FVkZixGUykYHVgP1MvIjhrAWPR9cqx+j95wHxmdBjc4X4xaPzSxk?=
 =?us-ascii?Q?POvhx+MSs9K9CDwIn05UFFwlKoGVlL2K0N6A4qmACP4jxSZ8vsjBqQmy+GQH?=
 =?us-ascii?Q?uyDzTWxpPireAT7rh/uaBIgW2c5VYYd0+wXa7kX6prScOzg548EI3fYA2cZ2?=
 =?us-ascii?Q?5u8566pjrP/VPBZHRaqrS0qwUdhZyqjUfsJ5jE3SF9LFAgdQ9j8QH8YmDgm0?=
 =?us-ascii?Q?lLQoWG3gbdr9g61x5pvz+nclNmZ3zk+UcHwNdJoHEH6KEOLyk4SAS4RDnfIj?=
 =?us-ascii?Q?8u6a1ifc2eo3l0EtcE9ZnXbecwU6Nl0iEkAXg+qcjD/rjIfWtyZEHK4Y4rqr?=
 =?us-ascii?Q?vA+iijeTupGKigQFqyI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2025 13:27:41.4001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f10eaab2-2cf4-4e69-a13b-08de43b9617d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667

From: Gal Pressman <gal@nvidia.com>

The mlx5_query_mcia() function unconditionally dereferences the status
pointer to store the MCIA register status value.
However, mlx5e_get_module_id() passes NULL since it doesn't need the
status value.

Add a NULL check before dereferencing the status pointer to prevent a
NULL pointer dereference.

Fixes: 2e4c44b12f4d ("net/mlx5: Refactor EEPROM query error handling to return status separately")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/port.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index 85a9e534f442..8f36454dd196 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -393,9 +393,11 @@ static int mlx5_query_mcia(struct mlx5_core_dev *dev,
 	if (err)
 		return err;
 
-	*status = MLX5_GET(mcia_reg, out, status);
-	if (*status)
+	if (MLX5_GET(mcia_reg, out, status)) {
+		if (status)
+			*status = MLX5_GET(mcia_reg, out, status);
 		return -EIO;
+	}
 
 	ptr = MLX5_ADDR_OF(mcia_reg, out, dword_0);
 	memcpy(data, ptr, size);
-- 
2.34.1


