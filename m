Return-Path: <linux-rdma+bounces-13459-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5F4B7F9C1
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 15:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A95621AB5
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 13:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE00332E734;
	Wed, 17 Sep 2025 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LE5vWGlu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2C531A7E6;
	Wed, 17 Sep 2025 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117013; cv=fail; b=RLk7lwBORpktyvZuA7SuOoSLMRDxaf4G2B1dCgnCDPZMw/spPpjqydNyD2BzGfxWGEKnFdNE0HtdKz6JaIoiTVCciipFcU9d6Y367G1xHTLtPpVmxplLOZtYlX4b1HClyM4dCKE2YOx5WB3bsQTuxYQX1fGqA+0SULNFuC/KkV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117013; c=relaxed/simple;
	bh=m/puMiprpzH5XhTHvGjFcs0BJcO6x3+rqFYc1wcg5mA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uJ4XlGu0Le+vONPKrdRyyO0Gf/p/ck3nJbL76ZIAAwyuTGlL5go03B6deoVick8iem3/jxlgvZaYFJy8WE7SWsfwvoHX7YnB1zxjdCub6sNc9iw8/LqjEvL/r71xJSfhSPcnZErceMhD9cwQpemlp0q2EHYBhdMpLuE3pZg+szk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LE5vWGlu; arc=fail smtp.client-ip=52.101.46.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkViuHkqr9O4Ku9UcZasVOMU6PADyiH5aJG3+13X0tTvBMf0CraKGp5XU6s8GA2elRMb3jZE4HstvF8iaNwHkirNmhcpO5K1q5kuJKnl/z9IeFQXuMPSxYwVwIAirDBqVRNdHWWmKG4ccIAsaiuzQEDoYRBulHX5iaXNPUGFpAaR1QL7zGdItu8lugO4yDaSCXVRpBC+uymAf3djv9jUcR+flx8DpiipRQqMPJqbLWbxvu5BTevJ9YRSOGz2tSR23w3ktoUVFgPAUAAvwaoe1YDPeqP4WXMl8n5G+cXCo8keSWO3cwmUxp8RuraPAXZOb6MQ21eqpmgq/7HrvaRmiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Fq8LAk5O7OqCtTNTNTZ+C7KTVhTKS7FxzEdgvBWVI8=;
 b=eRLotu6rIPOdhqGp5gIAfUkiK5G+16L8pObHDVZ3C4TbgrHgR/e0HaJxawYvcNklTxFtfyo0c8IEbrWGkjGJJJOyK1B32+MQx7rSZZ2+6BldjhAntVfVYiUSHOVCK1Fyb+0WynOBbdNTMvrCgBR6bImcCkrYhfh5Vgws+BjZTNZNirJHHSnX5p/+f9eR9KeYW6ad25bsxw0p2+9uv4Yp93daja6C+ClCFUuu0WbG773SeqkueT0elsfG2gXvxcwvWnJfDi4lmIA8TCQsycOmaOLy/K7FnwwTIMc7aeXhbsH8FTw1VnmnvQieZa6dyqm3756aIufnLG/Mu97QQJ5CBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Fq8LAk5O7OqCtTNTNTZ+C7KTVhTKS7FxzEdgvBWVI8=;
 b=LE5vWGlusFk77J0ytcNLadXuxkLYGMc4RUySslG+7rtQiz9+kYixmdPTqujFx0Y6Xdg4eoZvv7kPN9xa9kd84nIZwtRQgduA4U1EIYbRbMv9JTa3Mq9Mz1P3I4qLLTln8V6If9XUkbf/MECGn9IJLoFSQYkSnOSn62hqLxxbgig3rEhcWELbkRIJKY8zFCBVPENCTbiTalCCeMDwE6kBOqxikv16mSZoXlsIbOb17TMcSEgZ1Q1Q7tUP+BDdMjiH6nToS6kf1u/bBfD4eBP9lSmwFzUhQ1LS0uAdhlh+0xP3CzXtOgwuV+Sm0Js8zMLp1YH1WXx5hwB0AzDO1a9qjQ==
Received: from CH2PR12CA0014.namprd12.prod.outlook.com (2603:10b6:610:57::24)
 by CH3PR12MB7618.namprd12.prod.outlook.com (2603:10b6:610:14c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Wed, 17 Sep
 2025 13:50:07 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::18) by CH2PR12CA0014.outlook.office365.com
 (2603:10b6:610:57::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 13:50:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 13:50:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 17 Sep
 2025 06:49:53 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 17 Sep 2025 06:49:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 17 Sep 2025 06:49:49 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Alexei Lazar
	<alazar@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>
Subject: [PATCH net] Revert "net/mlx5e: Update and set Xon/Xoff upon port speed set"
Date: Wed, 17 Sep 2025 16:48:54 +0300
Message-ID: <1758116934-644173-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CH3PR12MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: f6cc4fac-0374-4dd9-ba9c-08ddf5f11c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G8lvM6d/PMfMCvuc1TxLkCicDJMAaz+Ljc3OX6TdqkKo0d6EsTj0Z2+g8U6X?=
 =?us-ascii?Q?g5IZKnC2KEGQwR/3FT0ykwi2Cgg58dgLpsMW9K7tpliTig/RRwFkXlBG+nrL?=
 =?us-ascii?Q?jeVqspsNNa4mXlQMzt0Ddu/GvrLtuCj6ehfEE/nrUFWNCIZ8QYDvqUQQSQ/O?=
 =?us-ascii?Q?EIAEZAnZlZdM4NYxvLeiFKT3dFZJtoG25CDkUQ2zOwDNfMX2KFIZtm3O505c?=
 =?us-ascii?Q?kQCu3yP9U9kkMcqeE+yAYe8m97kTQ12Om3hkDlKNkWqmYnyDKBveqQycYQfm?=
 =?us-ascii?Q?jHMeoQ68i/R9ve10juMBOTUXUwA73C5h2kaXUPpmp/3oEAPlwETp1pjcWoxK?=
 =?us-ascii?Q?s5eDkuUR9Db8Cvb5GtKVaBribUFdfo5U/JHkDpLmRHk5bxRQaCAu737LTZ9N?=
 =?us-ascii?Q?ZZwCyeVzaX+cm5KY4EGxMOT7t1FKSV7I5dmbBgjni3gKCNVlBAfXC0Ye3jMK?=
 =?us-ascii?Q?qi2UsbQcJoUhNRr0JY+yNqjtTSb/8kK4HQ2LE1xA1KmvoWoGH+ll4iKWs2Y1?=
 =?us-ascii?Q?fgwoF6DAkkngs+q5UoZ8ezgOsMwrNcCk2NS9WN8Le5yvNHPF6u3R9DTYKTgk?=
 =?us-ascii?Q?ldJnkLqHjgfRNBlGjc/QomrFq2kyLLbGu0bnvQJTr06GuhAp1sZuN2YV/WWm?=
 =?us-ascii?Q?2ACnRdE1/k8s4Lm3haKfZO//C+NItQo4zHqptPXos88NzfIKVyySdSiG8Ot/?=
 =?us-ascii?Q?L6mSZcxMVPV9vz2mQVOTT8I6L0yQhZc4a24wm9zNY5JPWZcRFO6XBO+2RGea?=
 =?us-ascii?Q?/r6zn2nTEPt6Dm/nN6f3KQaMs72geMrdQNVYhLhMlENVwJyS3kHuyXrfGvbT?=
 =?us-ascii?Q?/G19PQnwErmxseyU8Hj8VSVMhykTpgH1TmNTWvK9UzzGb8Wzj2+hZz+/F9h4?=
 =?us-ascii?Q?AJLkPey2QxMTY5YDdGyGapP+uTBY1sCm0TQhp9cGZEl2bwX2Mu7VtVUvZue4?=
 =?us-ascii?Q?7fHKyUgq8UmmayKWK/PQ6sSar7Pix9qoNm2jpsur9MiESmjVXLdImirDkKSY?=
 =?us-ascii?Q?LG1+yEs1E+UmcFujqxzStIgNboSuiSwETKnCuQ3dJzN2esL03ZJc31whK7h7?=
 =?us-ascii?Q?MDQ4CVomjQega/IUEkBjQh1xzenJB+XerWZbTbqgSyvIPDXBPatbfI1o2JGm?=
 =?us-ascii?Q?tTVz44syHZE6Vj6tcKRXOK5kV5lTOa0UUqPGZZ6UEH0nwXuwjMzGW3kj8qlo?=
 =?us-ascii?Q?4jIa9HFI5zz2Bkwct6CIndUEcebrPX5u8z0WgnymMFdJCRGpRnS3jtOVi0hj?=
 =?us-ascii?Q?2eBIowKNj8M9EIvjW8ifLeLcTCJAWaVggrzdfO8vfwt4P6EG4zB9xJ5WVap2?=
 =?us-ascii?Q?CkVGiJsOtuQ5W1d9CTSHYZH0IyQ1fmlxX8m0Si/d5bkbo86fPSIGp5+PjyYh?=
 =?us-ascii?Q?GJ4+aWwGZFqvIamqyspULi57N8OLER9hzTjaKYHhOuyjn+KYCgzZ2c0jO4Yg?=
 =?us-ascii?Q?5m/qBqAyUzDNtbJPEoonuBvHSFGdHKzAFHPMsebbWPk8DYenqpUQw0wyjvNU?=
 =?us-ascii?Q?WcWgdLFKljKnolqeuhNUAIVl8aniC70H7hGnLATkS6biz7NS1fdh3E9veg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 13:50:06.9190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6cc4fac-0374-4dd9-ba9c-08ddf5f11c7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7618

This reverts commit d24341740fe48add8a227a753e68b6eedf4b385a.
It caused a degradation, reported by Jakub here:
https://lore.kernel.org/all/20250910170011.70528106@kernel.org/

Fixes: d24341740fe4 ("net/mlx5e: Update and set Xon/Xoff upon port speed set")
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index e680673ffb72..15eded36b872 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -139,8 +139,6 @@ void mlx5e_update_carrier(struct mlx5e_priv *priv)
 	if (up) {
 		netdev_info(priv->netdev, "Link up\n");
 		netif_carrier_on(priv->netdev);
-		mlx5e_port_manual_buffer_config(priv, 0, priv->netdev->mtu,
-						NULL, NULL, NULL);
 	} else {
 		netdev_info(priv->netdev, "Link down\n");
 		netif_carrier_off(priv->netdev);

base-commit: 8c4748539985489b59a00b4c2ae919253b3d2762
-- 
2.31.1


