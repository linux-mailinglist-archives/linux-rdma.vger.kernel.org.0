Return-Path: <linux-rdma+bounces-13707-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7DCBA7801
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 23:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BC9175558
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 21:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366FD2BE03E;
	Sun, 28 Sep 2025 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pH4HyVtD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A4829B224;
	Sun, 28 Sep 2025 21:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759093365; cv=fail; b=j71G8/ZWkrZYTll0gjF//WEon+cgeGLbgKYXCq9RfSFdeUBbyQnqYSmvt0NptiU1FM7pxWjijE1J6OmSkw76klwoxeW1HE4VadbVEnaXJgJTp2MPsLDpVkbB7/eln1/nwzdiz+O1nNEGmO6DoDYdQ5RterkKIK7hyYiQbVAAiFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759093365; c=relaxed/simple;
	bh=Jr4T/+KVy/v4KYxL9ax3YrugQsn+g1EF1B1I8B9keNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5ZY/J+zZfz5lPIJAd++8jLNGESHOc2DOKvpvVtJ/pg0EwRzFw4sTIK3tsshWSEXh4+PVW5SgWTHZ4eFpq6ACAm3COrqsQsCdNYfWzxPkgxOo+yNU24M49B/woG4nNJS5VtgbO/HXmoCPKZFWsbPQWBUBBp3pW6U/rvVFXh9bMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pH4HyVtD; arc=fail smtp.client-ip=52.101.46.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeMNg5Bql7l0d5L3BHEUcq9BmooXAwSUD/FqYpFcmW4R/CiwXrf2c/K1pt12fTNFi6n69bGDX/85wEgX/nzcELoWdS7xhguekijliUye19x7OV/2Cr9BCdegoy8b9zKfd0ORblVmL71MUpsjfvuNbp6C6tpA+5JgTldg/lJZBu8w8GhhdT1W2G86wN0H1MXE0Wj4YPzks9yF96kezNyqauGUUxZBYAfIJjnkfVBM4rZihvHEAKqlUabm1yDMKT4vjoS/KYdoDmjDr8DsYqUbGOsZ35u+pLrOHaGj90fSVGZWM7fI8OdP6+hfCsM04OOUuCBzMTKN1IQCAqOxDQ+YRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfoRHPRrkolVJAXBPaD8ypmhu6J5un5v0ydFaukGbhs=;
 b=CG0Y2vQEZq8cqwRLLnIlbXBELS4VxVikrdCOvA9aTlP0Jc8zdal0cbOrFwP8AtgzAP6rOdvL0s8rAv9+RHvZWyIl5K5E7m0u7uZve2h8Sj7j/48L7FbnoaacZccVZQ7qG7y7cupQaaNxYm46esHYc/sYqoZVhckUzvG/9ZyOt98kHBZtFszkETU3aLwNWId/9sGaurXmgbqGFeSparpBWC7mpC+iAPXqM4Zu6lULtKd2VSmy3CX7uQiAB5GuY/rfNV2KYixzXwTXR6t+sVPLzKjkYj7MVQxG/vPXYCiDPzLMMboepcydzyQmTqbK02ii9FcyFKb2IqWfosYINTG/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfoRHPRrkolVJAXBPaD8ypmhu6J5un5v0ydFaukGbhs=;
 b=pH4HyVtDj5Wd90kpenNK+ZS/SOdW2BGAhsqSMd7kaMyI2mxvuSfTmfpabETzMG3M+NENiAwFf3CrsxpErD5Old/3FVIht6xxb9bFgAStE++2iyzahaU7E1kJHwUosFhSd4uixg8uDmYmOL/TLut5GYYjxrA05bOEdfPOdW8Kk/x7pQ9+SoGi2Ev8rQMLS/M/9rlJRIoTp7ilMOe68z57nOmRcdFexJGjtQLQA0qykhM+r9WRz0l4pGfEevypmCKqdyIDYusU0mE1XATAiIMIZx5i5OZDe5LhVLfafeOrtVCrMuPykLrUKHQgNHb+/K5D0kRgFGhqL6e2zfcU4Ar6ig==
Received: from BL1PR13CA0308.namprd13.prod.outlook.com (2603:10b6:208:2c1::13)
 by CY3PR12MB9578.namprd12.prod.outlook.com (2603:10b6:930:109::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Sun, 28 Sep
 2025 21:02:42 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:208:2c1:cafe::14) by BL1PR13CA0308.outlook.office365.com
 (2603:10b6:208:2c1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.4 via Frontend Transport; Sun,
 28 Sep 2025 21:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Sun, 28 Sep 2025 21:02:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 28 Sep
 2025 14:02:36 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 28 Sep 2025 14:02:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 28 Sep 2025 14:02:32 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>
Subject: [PATCH net 2/3] net/mlx5: pagealloc: Fix reclaim race during command interface teardown
Date: Mon, 29 Sep 2025 00:02:08 +0300
Message-ID: <1759093329-840612-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1759093329-840612-1-git-send-email-tariqt@nvidia.com>
References: <1759093329-840612-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|CY3PR12MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: cd479db1-193c-4ca8-6c05-08ddfed25d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wSTnKyBq27+LA3nzPKzRfhYmm0OBNqqAXQ5m5sTfytMONRGkivSJ1mVWK+ih?=
 =?us-ascii?Q?J/RPxx/i20+RNAwQmaB/T6iCe8XQlg82SmWjacQqoAIOLJ+iUz/ZW+bM22t7?=
 =?us-ascii?Q?wXmCaGPGLp8HHD/CHY7Cp6G9PJTiEsraDvblDgh2Js0boS4ywGm0SxUIhGpV?=
 =?us-ascii?Q?+hP/4XL7nhb2788DoXmvPM2doS6Zo0dyoY1zEFvPbYp8AO4oYpTEW4wvE6jq?=
 =?us-ascii?Q?oIBVwfHKbmQyi4GoAkeAonIK8ZDOPXY8CDuCPBpOAPtDXdA4+Mhy9zB8diX1?=
 =?us-ascii?Q?Tpq30X745nF9M55v+ySialFdrodHlrCMAfMsSBeNlPRAdtjv/YM2tD3NUIU9?=
 =?us-ascii?Q?tVu3eET7Gqoy1raolXkSGj615Xkgp3AReWD1+SembFhcoMF9doXelf1wfXVP?=
 =?us-ascii?Q?itZ40KoGbG10sZSZfXaqmzoKt3ZY2n2UJVJ0YTAVbI3TyxwYouyO/7yibl/W?=
 =?us-ascii?Q?xHDieTI4Y8/DSdoVmagUKyRJ7O3UKtaM7aTAH5x7zx+qjBJqixyCScwL3eaL?=
 =?us-ascii?Q?nuu7mlExn+m4yB9n1eqjmSY+LWkSizWxAqcVzTPXD/uo8TabobI80tZx0V8e?=
 =?us-ascii?Q?zSIGpGXrcuUxUn5fOwJNq0FmsQ+a6g/HsqXD1PeKXJq5/yQzlZQeo+xdxyxg?=
 =?us-ascii?Q?Il+iFwiYbApk8xnWFrEzsON+WSor51lI5rfGDi/XHebdV7wIn8tQYEyBHhyf?=
 =?us-ascii?Q?M9hZFNXZic9N9Xi+N47/zQ0A3dklbqTk8r6RyV2gELaBQ89dBFzEQtdpaept?=
 =?us-ascii?Q?/rP3Zn0an7NKBaFSO1piktvdmmBTTL7sMGNQ/PWu8JQ1bjc+QJpjKP/e5YPK?=
 =?us-ascii?Q?T4ohMeLeEkdE/1WGfQRDq18E9D8RTmQQLBZkT922PV+U8ix1Soer7m2mYspL?=
 =?us-ascii?Q?ZGipaE/5rDcnripgHRRgclEukH7wEccGM2ykOTp6mZogZ/cWNFnNNAmAjiO4?=
 =?us-ascii?Q?7XryIOQtj1eek7JJuOxWGgZVzjvB5mQwDLCNn3Iy3uNbsCClQven5hqvIO43?=
 =?us-ascii?Q?wkggpwRz5SZYnoHw8gHeMV4p/T3uHcaGjeCNZnbV+uLnDWm+JsmZNK8JBEvF?=
 =?us-ascii?Q?ZbDF7+cuJVeHEDnnVEYxUgR6TTnd6c1BqJ2bu1+NIH1BzbvkmGqrB5j0ns5i?=
 =?us-ascii?Q?n52bbUk+RlD6rvT4j2Pn5KpRh9Za4ZhRJaWqx2/9F9ig4B69BuW7xwBfTowq?=
 =?us-ascii?Q?jf6DnrPBeM0odAyvclVISU/czvk6+7/XP8PEXw1LgEBv33KQwZEdq/WzuTqs?=
 =?us-ascii?Q?datbeq0x7tialwHhhbYs06cBSMVSNmBgJsXbeVqrhSNoiLUqHdCCBYitZwS5?=
 =?us-ascii?Q?1ILUyCmfsVgemUG/G6b2Qz/xW8qGs+QiuCYP7gYqIqtS+v09mk1IkC4uYaiw?=
 =?us-ascii?Q?RghdFNg5/kLjauft8WZTf2mL3L8G78JKHbHdgbkteJY/QS5+IwPAogQPjFeF?=
 =?us-ascii?Q?BMfK6WBUHR90UDqftZa1IAIOb5EjuTkMYBqqsYKW6eFSVbUriHWu/LLB4we+?=
 =?us-ascii?Q?mI2GMLyyzSFXAMtNGbErfkhBGcMWlaqzRvpmv1bYorRSx5rRcafiLJRR6pBd?=
 =?us-ascii?Q?NwxhDyASnDqiZGF5nSg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 21:02:41.6721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd479db1-193c-4ca8-6c05-08ddfed25d62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9578

From: Shay Drory <shayd@nvidia.com>

The reclaim_pages_cmd() function sends a command to the firmware to
reclaim pages if the command interface is active.

A race condition can occur if the command interface goes down (e.g., due
to a PCI error) while the mlx5_cmd_do() call is in flight. In this
case, mlx5_cmd_do() will return an error. The original code would
propagate this error immediately, bypassing the software-based page
reclamation logic that is supposed to run when the command interface is
down.

Fix this by checking whether mlx5_cmd_do() returns -ENXIO, which mark
that command interface is down. If this is the case, fall through to
the software reclamation path. If the command failed for any another
reason, or finished successfully, return as before.

Fixes: b898ce7bccf1 ("net/mlx5: cmdif, Avoid skipping reclaim pages if FW is not accessible")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
index 9bc9bd83c232..cd68c4b2c0bf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -489,9 +489,12 @@ static int reclaim_pages_cmd(struct mlx5_core_dev *dev,
 	u32 func_id;
 	u32 npages;
 	u32 i = 0;
+	int err;
 
-	if (!mlx5_cmd_is_down(dev))
-		return mlx5_cmd_do(dev, in, in_size, out, out_size);
+	err = mlx5_cmd_do(dev, in, in_size, out, out_size);
+	/* If FW is gone (-ENXIO), proceed to forceful reclaim */
+	if (err != -ENXIO)
+		return err;
 
 	/* No hard feelings, we want our pages back! */
 	npages = MLX5_GET(manage_pages_in, in, input_num_entries);
-- 
2.31.1


