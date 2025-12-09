Return-Path: <linux-rdma+bounces-14939-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C6CCAFFDE
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Dec 2025 14:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB7E030F4DA7
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Dec 2025 12:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04604328B78;
	Tue,  9 Dec 2025 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XsM7ZpE8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010008.outbound.protection.outlook.com [40.93.198.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93D4329C4D;
	Tue,  9 Dec 2025 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765285018; cv=fail; b=jz+z27H/Z1Am4GFf6VmozJ+ZzJ1lf8SOMSOWu4+81pK57mCDwwnKHPNy5OjuxUZtGlKYE7EPRnwSpC8KxxP52uPuNOCZfZjR0sGUOWtu1U1GAoU/gSMT2g/euDXtRhGLZwU4mfNRjes/yRdn00mkA+/RwrV4WeMAwcyBceiJbnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765285018; c=relaxed/simple;
	bh=NHspva8gO/P7quNc6KJXE6/i8V1XyZ9kvSJtRt40J+w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCh+CEggrZPS5T+cR0fWC/qh+dvLch8RjpuUP6vKtXSzD8DkEWtxcJnKm35WUlRoBM6YCHYdyzmoXFtgDGBvv2CZi3qIeN2E40uaer7CP0GyJfn2fisdSKo6Yy5b+2RK8Gb4lH7n2zNJVF3B8YUH0s/ry85fdG1zm1nrIWpU9X0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XsM7ZpE8; arc=fail smtp.client-ip=40.93.198.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CknLIt5YHebPt3NV/XNS5kpH2Sgin1P3I68UiHRQe4fgyFr+Us0teoJZrkjmxIVhakgOgb4nvKmHUXBWsrFg7UemeL8xDfZNAKsjuuZTUfEsq9FAMyqXjvJRyazzXkIFbLCPlWN2gZIbMV6mkuPsVIaBlBh9qXY9lwsp4MT1MGx1bGFxRhubMe1Sz2E0Wiw5G2/G0v+8TTiUzxDMiFbrIQkwlRtW7mC1qu6t0jPsll+/GC93O+Yh3WUXfG6OMwlHQD1XhnnlMZsgkIt3ifvNme5/9uuOABlXK1YM/R/PW1SsdrTOSPwHV31t6OPVnaqWM9PofMDXun8hrcghRX02fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCPklG2dwE2tluWXQSbZC8sEAm5aXQybxZSkDLzu5lA=;
 b=TgA3M3MYafUnF950FcQDsYAEaThSLk68vWIHCTJw1COq3xoussmI9pkcHaxyCcbfnv9eWRAElp4xqm2dpV+Gw22xltYGGYH79xzC09UNPMhJ/QIL5PGR0XtEfAJf5eNhil9PU/e08kO3gol7tG7UODKdPKhTpp/WjMJGy3Zb+8TU5oZhszLagA3Zx3wt1Xz/F85ScurijW1P66D5Vaxbd5+KgwXZXYR8kOdkiZXxnndi4Az0qY0Mi5fb7toopv7M+x17Fcw5yV3HQNmNGitbkziInmHkRfEM/zZNfafDi54Lp1nprCJc46NXgzjsU4GFHeNpCV8HcpyjpJsSCfx6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCPklG2dwE2tluWXQSbZC8sEAm5aXQybxZSkDLzu5lA=;
 b=XsM7ZpE8e36jbVdOqzXDtgSjS/2e7wTSVKWG7HlPImSYM9xb28Up+qf6AKYTlC8eXcXQPMr3kd9s7XVLODVzQHRt2ylQPoCnJzM6vTPzN5cbqGB+GcpDFYR9Vs+kxwXWwoGkxgP7gHus7RClra+iLz+Wi5IGe8IjMRIgUzA3314q7ZjC5QlbRsPch1lEjiLbFIETFaM7Leqb3VSYhH8MJQmPkcNwcrn2e/WTljE3qJVNPw26Ur1RFUyuG2uRo4mCan9KUTGw6YC6WZ546xU3XAgKB9NL03mvLUTYsEw8XBkLcEz81EdGmd1Kk4NAa4jORg0LkcCShpAIxzwKQaecTw==
Received: from SJ0PR05CA0205.namprd05.prod.outlook.com (2603:10b6:a03:330::30)
 by DS0PR12MB9346.namprd12.prod.outlook.com (2603:10b6:8:1be::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 12:56:51 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::4f) by SJ0PR05CA0205.outlook.office365.com
 (2603:10b6:a03:330::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 12:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 9 Dec 2025 12:56:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 04:56:44 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 9 Dec 2025 04:56:43 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 04:56:39 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Breno Leitao <leitao@debian.org>, Alexandre Cassen
	<acassen@corp.free.fr>
Subject: [PATCH net 2/9] net/mlx5: Drain firmware reset in shutdown callback
Date: Tue, 9 Dec 2025 14:56:10 +0200
Message-ID: <1765284977-1363052-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1765284977-1363052-1-git-send-email-tariqt@nvidia.com>
References: <1765284977-1363052-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|DS0PR12MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: f147a8b4-cd46-495d-ba33-08de37226c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HwM7SPWZuKvCrpfpi/BgpfOM6tKAxEaZwt1ctjCoL9JblA9edwQhnT2SpNOZ?=
 =?us-ascii?Q?0w55+1E3b0RcS0WBQWUhIp0y+cvbfhn9VDDenKVnhgSafR62kR+1pFcgz9gz?=
 =?us-ascii?Q?3y8oJSoxPUDuEE5FSoN1sWzijREpndPJ4ppeiyJrTtItoO1j/WchFdKKdlw8?=
 =?us-ascii?Q?CAeoWzTPDtQpU8bNvHG1GHTNRnRgeBjpNn+cPq0faCmZbFUrWMCba82RTWw8?=
 =?us-ascii?Q?2N/u3NQQjxXabmKK/PsKgPsXTKu6qWm9RMkCDyFGvHcBokZrbSabthaELgBF?=
 =?us-ascii?Q?gtkoY5N4G0Maqa2lheGU84t0VEzEGX9GVFs3XF25tcz5LTj2i/rh4EcjQs2y?=
 =?us-ascii?Q?fC7BHK/CGdeQZzTHQEHIcIsqna8Xpyj3T28sZYOYKYkoFUJehceb8h6VgrHj?=
 =?us-ascii?Q?808pDVPc17vgi1KY/xTSY/UkTWDxRxZG84D70pqsPoLHpxTeDlXFU2CTJy0R?=
 =?us-ascii?Q?nJSiuYkMbZQAltkY03T0fv/iQGeX5ZKAVds+IkM17DdERL7AHxrpqCbPyAcY?=
 =?us-ascii?Q?rvd/215PeJoTWgmoJunte/3pXvvOSEcxe14ivlAiOHyfher4OKRBjGcV5hGq?=
 =?us-ascii?Q?CIn3zfsk9w4gz5dntaJa2zRJyzjytmTZmN+4ntOi0wt0YtMIhGnMU9ZBXNcF?=
 =?us-ascii?Q?jC9XMCnpFbRa3H9hAOSTiWgUHV55vwUQHv5rzVrpk+Z1RePiOEgMgGCNnRZn?=
 =?us-ascii?Q?JWRG7oRTZc7XXgOmzQXG3ourvGopPvrnS8DEk6/6/0aV5RB6n3v69wO3N7JB?=
 =?us-ascii?Q?ZPi9VhGwAoT4LS+EApA9jdPdOANemo1HnjBZcLMD/i6rs3SMUAeR27wLR/fJ?=
 =?us-ascii?Q?map2scMBbZC3X3J1KrgJqnsTE/dwcdwKtPiWIQXp9TrxMhaOsFv6XGgSySmj?=
 =?us-ascii?Q?Yowiuyp4cS4IrEJFjdE3NWefjX1aUqdOUo9PGMXcmul2/0cvbmCvxZ7HhUXO?=
 =?us-ascii?Q?2L7UAlgPdLRO+iJ/ztsDKgqTbCmqHs7HUFC/ZPXbOsko8D/acb3kivHeVkk6?=
 =?us-ascii?Q?mgXuI5vLPznO5YjjGHYtVjcezo75DEeHjM2uy7A0MNWqAmo23A3MkTDpyrJI?=
 =?us-ascii?Q?aAXfWRNUH0PVnNFLj8pcLXkajCktJiH7l0o/eyJ7dicraiKkO7tui4eTnvbE?=
 =?us-ascii?Q?Cr3nwrJ52DQ2qaVyuOkUmMLNqHiFBy2rMOW2fcbLQzXIwi88AVVUAc5SKHGV?=
 =?us-ascii?Q?WcYVxxMoFwKAgiBPRCql5lKGevWKwYPvOLVZDX6VUKowc45N4qfShZhRQa6E?=
 =?us-ascii?Q?OoSkZ62c1j/ZzBgIZAoaS/G5eja38iEuBjk59N3S4UBt2hs7UESiK41CEOJD?=
 =?us-ascii?Q?b0LDN1XDCPRP9eHhEQEM5gX1IcA//WUUynHLcfv3NLCbmOuUhBD4zbultA7r?=
 =?us-ascii?Q?vv1dj92w8Cxj7KECWkiCb6sbWjo4tOe+DssFFkZ1B6b7Q+wp6LoUDtj0NbqI?=
 =?us-ascii?Q?S409zk0aEVnJpUsa5v3QCn9PcG6Jr3IslatCOZBzcrwKPKqTjmWN1IL1weYS?=
 =?us-ascii?Q?79XSFrR2Jjg4ak3YeS/NqgqJtlacIHvFPAKRO61Ju83zLpN5kpUPx6tfnJTM?=
 =?us-ascii?Q?6P3XnFR6EJMzQALtv/El2PDImfGGTkCO4n25xgXx?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(41080700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 12:56:51.5201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f147a8b4-cd46-495d-ba33-08de37226c1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9346

From: Moshe Shemesh <moshe@nvidia.com>

Invoke drain_fw_reset() in the shutdown callback to ensure all
firmware reset handling is completed before shutdown proceeds.

Fixes: 16d42d313350 ("net/mlx5: Drain fw_reset when removing device")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 024339ce41f1..cf53affe61ce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -2232,6 +2232,7 @@ static void shutdown(struct pci_dev *pdev)
 
 	mlx5_core_info(dev, "Shutdown was called\n");
 	set_bit(MLX5_BREAK_FW_WAIT, &dev->intf_state);
+	mlx5_drain_fw_reset(dev);
 	mlx5_drain_health_wq(dev);
 	err = mlx5_try_fast_unload(dev);
 	if (err)
-- 
2.31.1


