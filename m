Return-Path: <linux-rdma+bounces-8058-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE6EA4361B
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 08:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A7C3A75D5
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 07:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4ED257429;
	Tue, 25 Feb 2025 07:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ISIeRLap"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BDA16088F;
	Tue, 25 Feb 2025 07:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740468439; cv=fail; b=M3RW92CRTS+sWiKo1PNUx1C6iPsofZlgQnknCRr6OQTLdrE2Ad+/+kG1RdBS8dXlrbZubTAnnegvWM2v0HEZENZrniHQZl+zQ9FdQI1dxph8nAlqrBwb/cIfLZDlQRL+DbhD9msR+7rbVKLC47/0QQMg3gFuWeZLpyKM1XpyA6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740468439; c=relaxed/simple;
	bh=xVf3Rrhy79qL0tBz4qALFxLNs45zLZqE9vnyTM7Kkjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVL/aUaBarVkPF9brrVJ2Qn1GhSWWurdjnuQZE4cIgam/KcbbuZYd6tpelkqo6h5Ik4dZSqzx1z2niII2taMJXsu9GTDv4FqB6a6ALeKsjyLEnTh9ZXMra5uNKboU09AX+zPuM6gumNMGLvXuVqH7Tzly/WRlBGW1OXjsn4GLtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ISIeRLap; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0dBQgTWK63TxlBNv5JmoswOkWICm6icuAa9O57Kd0ZrZN+xJipduGsTbLa6rqd/sQD1jL6MlYfx2NJDx6GSIT8pFS3IZ7htrp1BKPMRuEBpxytHJzqROrAInTy0sQubQVSnNYZcnOdAl6Qu5hXBQDyhgub/3/F3cFpop2JrX+Kxd/qTL01KREnz/MCbOZeWaWOWMdvRoVWRevK7zQMe9E7bsCvF0jyDuDZMvjWMeMIQP/ejGJj3sLEtYobkF4RbkpF2g3VDc0eyyiPgf1zs5OLFrPeeu25+WWX/SzOPsffS3YnkM6yASxhjWI7VbtX4K2ToU510oeD93Uf1zpDZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHdviLVkhgNTk1YJqCB6rnJYTmg2dCWuNEK2d6diN0Q=;
 b=h8KRSgZdRNLzmx2NUYUj5aanz8TRxOog4MBuEKafVsC7y3zb36bqVU4JsC74kHe23gxH+eG2Q04k8KQFhhNSondCXtjmzgbYahwC5q8lEj4zINkaG3On7D+qSwOGPWeA1jui7hvoT521PJTQrYqw058wcKrlfoLtgj8th5IGyD+VDqH33JKmVXWUWYQ24SxgyhNHzPr4P8yJIDPUOMods6MnyFzHufwSM9uWXx+Q4wkJkLm4w+BN9TrjZJQ85o362hnR5ByQpFxjhQyZB2vZk0Jq5VJdzholcQRt3Z29UtNn537vdw1MArfhgB5JHmWdTEXO4vnSYlUxy3qm3yDXww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHdviLVkhgNTk1YJqCB6rnJYTmg2dCWuNEK2d6diN0Q=;
 b=ISIeRLapPe8eNLhrEOJzMPua/o2aGZSjCyLXPDaZ2xJbou0rt8cu4weHW+bJhUMP73UARoSZIgB50Zow9l6r3kOD3bv2NV/Re2La5qLMatg+F7+zvyAgL8Cbt79SizeeDx+dczC8qSWD6QBk6BAV5rWfeYv3UTRtY1oFSgSHr67ubL88RnZzLZ+oQrdGPSNOky5m+elIPjsfA0dZ9vfznBRPa6/EI34vsdkdCyUl0i9Y3UsKPnRSf04uBeNORc3VVmoQm095ZTjHibM+cHy/YAq1VH7fQmwUXMLaC8mkCrInJS9Tg0LmzBmbtR2y1lC4Y7wKjmrFq3WFdk4oNh6c6g==
Received: from SJ0PR13CA0219.namprd13.prod.outlook.com (2603:10b6:a03:2c1::14)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 07:27:15 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::25) by SJ0PR13CA0219.outlook.office365.com
 (2603:10b6:a03:2c1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16 via Frontend Transport; Tue,
 25 Feb 2025 07:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 07:27:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 23:27:01 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 23:27:01 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 24
 Feb 2025 23:26:57 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Shay Drory <shayd@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net 1/3] net/mlx5: Fix vport QoS cleanup on error
Date: Tue, 25 Feb 2025 09:26:06 +0200
Message-ID: <20250225072608.526866-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: f088d792-8ab5-44e3-59bb-08dd556dd398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WcxthG5rdHRM9/PrTu4mHrmcsodvebZunYXS4r+6aXpBSiU17PIm+Yi6SGhh?=
 =?us-ascii?Q?eSV9p2bAhtSLV0f8Dgt3hZUQpQ3x3C4JoIg4G1KhGBbzes16bRv6WhwL2YRQ?=
 =?us-ascii?Q?PGKdikY9QM63g7Yd2i/7HWOweKxFJ3qNTPAJ0R71yoD1E0SVWdnsmUv1bWXR?=
 =?us-ascii?Q?kIMet8H/xFHJF4RMHE3g7fUC+Nh2agI1T1O5n/sYVNqAWYOXjNLHDWghSjO4?=
 =?us-ascii?Q?kPatrqCy/POo5brfHCWM8snaxzobAA7uyqP3QzqowaioiCo8eVfIM9DrgXsk?=
 =?us-ascii?Q?17VG1ZdSpZKjxHvC4bngXPD/e/NyV/e/T8MLSqKKRmXTUAJWASzV87XJgdks?=
 =?us-ascii?Q?qVrvQ8sILOiGOwB1LjrmyVWFzq/VXnPbvxPjixntriQmapr6qPwOjsDw0BBP?=
 =?us-ascii?Q?tlD6fp3rlEsLCcjX6MD0TK/Js5I1In8hRppytlXa3RRVD6apsGwXfIzHXnOD?=
 =?us-ascii?Q?/aNEEhybvyMHD1tOl0cGHh/wDFClaoSYXDORLWIkyDaAZoYH2mFFk28dRQsj?=
 =?us-ascii?Q?MER9fmQ19y6xB1rfrf6YVcd4f0S08CGr1nYVjl+Zo0GPXsaFYOmuQM8mjwEC?=
 =?us-ascii?Q?Ew8w5GOQBm/ohJBR+Mj47BgUXSrPT01veQxtzzzQkRXOFBB1s7czvW05LKpr?=
 =?us-ascii?Q?Th9uJ4rwx+ZmKc6FjwPC2h9zOx4oNYy3MXmloTWc+NfGjrIfXjtqYRrhA7Ig?=
 =?us-ascii?Q?bbuM2rTrNYXDph5G9fdNw1aXFT3cP/h3NeDwErKBIIcNsQbEbd1ytv/CAoT6?=
 =?us-ascii?Q?3wjj2V3+DJTB1hYw0JvNjQHTHN+R3OoAgGPgV8fqOjINNZ0e6UbzUX7XsiKi?=
 =?us-ascii?Q?2LQN2HAW+CWfqIfHyPlK4kjgysXEMBnF3tkFPYM3oh4eMiRHvbnw+whSrYee?=
 =?us-ascii?Q?x9V85loJDV4ksEfdK3eE9nyyrtY26b4swH1mmbbp3FjO3E44hZU5y+/q6HFe?=
 =?us-ascii?Q?ZYS8eqS5kHbLp8hQcAdTkDcgCuhTBUo0p8ZLDkwzKOGhf45JdvuWstPTdscs?=
 =?us-ascii?Q?D+QWFIXL7UmIN9FXF2C+qTo8+P1kZg4UZZVtWyZZKS6PgmrwP/5TKCiezR+s?=
 =?us-ascii?Q?cHOzPb0Jj7fOnuKxcEJosUB2KO9pfrfjd/lCLzRnXitdppeHK9BQAuBUeRz/?=
 =?us-ascii?Q?bGvwiyzto6Erwq1sFrFivNXeGOsUKEJ5PLUGanvjGIPVPjD/d858IjndHZUo?=
 =?us-ascii?Q?qgRGAkTHPJupyrS3MOcs1BnKJ7GnLjOrGvn0GL1BJ93eXiR4P/Fp+nJGjp7l?=
 =?us-ascii?Q?yRGjujtyUBTUhLgWun0+BSScaDprpqDlfNKK9dQh3+aRp4QG2HTlFkwBWYP1?=
 =?us-ascii?Q?1YsMRMwFYGyF4MNYqaZE90GNMhF/nM6rqbtV5fPUpubKVFBFRb5DD7gNs6ap?=
 =?us-ascii?Q?5JfJbCOyLKleeMa6WlwjFoHYajULNRH502WPKYQJlaINcsceg7v+dyHyUbY2?=
 =?us-ascii?Q?E/a8L+5HZgqt8Tcr3XSG5c//EJzRsczr9ntyPN+WZXQCzIJqgkzQa00983jb?=
 =?us-ascii?Q?fr7Z5g422KeQ37o=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 07:27:14.5314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f088d792-8ab5-44e3-59bb-08dd556dd398
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006

From: Carolina Jubran <cjubran@nvidia.com>

When enabling vport QoS fails, the scheduling node was never freed,
causing a leak.

Add the missing free and reset the vport scheduling node pointer to
NULL.

Fixes: be034baba83e ("net/mlx5: Make vport QoS enablement more flexible for future extensions")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 8b7c843446e1..07a28073a49e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -591,8 +591,11 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 	sched_node->vport = vport;
 	vport->qos.sched_node = sched_node;
 	err = esw_qos_vport_enable(vport, parent, extack);
-	if (err)
+	if (err) {
+		__esw_qos_free_node(sched_node);
 		esw_qos_put(esw);
+		vport->qos.sched_node = NULL;
+	}
 
 	return err;
 }
-- 
2.45.0


