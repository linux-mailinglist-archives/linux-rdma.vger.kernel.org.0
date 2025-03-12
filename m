Return-Path: <linux-rdma+bounces-8606-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E175FA5DBFF
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 12:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8593A7F1D
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 11:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8234C23F422;
	Wed, 12 Mar 2025 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I7JSH/zs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FFA23F411;
	Wed, 12 Mar 2025 11:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780248; cv=fail; b=FwkrXP1vGOwF8jJboJGwlf/Bk5Cf/LczpZS+ohYerfuI2gKULSg1o+eXAV9k4B0qRCOIaqqWLH7sqeJ/XhJdWr0fAHg30yFODhibVRh0cTCJeiSZwmS6fhz7EfBv88IEx0q64zJtnwnGeHHris31QtRL6cVsiGh63Z6vX3YNBnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780248; c=relaxed/simple;
	bh=EvzNUqC8J/I9MypngWCwtjvei3hstFliAH2SEkwqZlo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwwLSzUzCOPQyXn22BmHkcwhb+DxM8pQAgxxB67YZ/+WoW3pT+z6cVpX1ZJ91jc7KUVZxxfhpKl81WEkxjQWpOYNHJdnMLXlcVJPDATsXu2hw4dvTb/lq/ZPvlqFfuZlfNHkQkNeanH9UpO79BNqV0tuiyaZARifLE4rCQrWTAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I7JSH/zs; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmHCJJwhLHeDNw7Z6mQFndpXoLarS1AND6HQQlanQgGTrPCFt7tklx8RpxaSAS2QqP7GbBhqWcorjB08+vM1f9JXyKuK3p3naBnWAly0YRpXdnZ2i2bHJEfMFVlIlNSOoknO2z0ZbL9AD98Yg0McIOfUXbHtYM48/Aq4aJzk3deSxBPnPl75+nVYsk793zFUWycYcvNSxZq++yJbk8OzPFuduHIh8e45bm55QEWJGKg5Idzrj079NtQ1B13K0KWmMbI1COY3IGqokHZeuV29n1G+pveXhqOIn1hU9qS71oxlqhaBpzyiTXPjiI89c6Z86QpixXWW2I4h9oZYTMd8Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2c642CR1u8hy1el1nGXgWeZQ9LgwJwESGm0q5NgOh+A=;
 b=F1k9n5kRy9P0TdaaAKf3hFSa4rUbuWQjfP5iazELpL+nxhsLouY4Qd/WG3Es1LjQZ7IibeET6xujycpx4rBVVukbpx5XyYZ1oU6a36rSpLuPS3NP5NFOCa7C+UjRD6Hm32Ks0hZfdePGDrvguxmjTz5g2RcVHOaZ/AsX6tQmkCL1d1pwP2dolneOkKEJdh68XZ+chu/zTQp8gzFdc4Z6seik/cmYDResbaT3JGiiw3swJq9BVZgmXSf04AjhnJL7u/WFnjDD9hRJcPWDaSvEv2kos4+iEF5pqnHNYa56XcV6BUbq4pSI1hIa7Vl6cQTE85L2kPtZFflI1avjqwCAjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2c642CR1u8hy1el1nGXgWeZQ9LgwJwESGm0q5NgOh+A=;
 b=I7JSH/zs12lOpEVX5xL7IzPXrfXDkwFDwTG94AVsGD0gL9nIZKZ49lESqNq3n4Z3NP16Mu9L8oGrpMHoNKNPcKvJGDeNuw2MMm0RHGh2BDea/ZJKOGUBnIUFKsfGXLIITXJJCvoYKidYwhdvu2TUMpCr6p2aUMQolcLQOxahEfT9PQHgR8pWPFbd3Yx24MnYAE0YQSQZgD9LMngk9ifV8g/O149LXQSKTXxIGfn2qR8PgWx3raQMIB8UOqQXt+Fi4aQgaP+DdnQR5KL6aVdK0DB5MSUs4BT7x5w5+5zQvIqJL35HwcTGYwuyaDRaQhDGGeQj7WGcxjaoMgYbe+rB7Q==
Received: from SJ0PR03CA0206.namprd03.prod.outlook.com (2603:10b6:a03:2ef::31)
 by SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:50:40 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::ce) by SJ0PR03CA0206.outlook.office365.com
 (2603:10b6:a03:2ef::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Wed,
 12 Mar 2025 11:50:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 11:50:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Mar
 2025 04:50:25 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Mar
 2025 04:50:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 12
 Mar 2025 04:50:21 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [PATCH net-next 3/3] net/mlx5: HWS, log the unsupported mask in definer
Date: Wed, 12 Mar 2025 13:49:54 +0200
Message-ID: <1741780194-137519-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1741780194-137519-1-git-send-email-tariqt@nvidia.com>
References: <1741780194-137519-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|SJ2PR12MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c0ea07-0a83-4690-9d51-08dd615c1c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qZCQoI7P90c5kKIhsdIIUgxfY+PuiIXQ+tyGQ2kt42ZNmKEH3OUdq7TEegaS?=
 =?us-ascii?Q?l+KXBbxg2CBgyRTa7tzEBTJh8vCP9qfcyp1a83SF7owErTVMnfAdTdR2sCb2?=
 =?us-ascii?Q?7NmiM8vnk/SGwgi9j6ooT7B0LT/UPGzTbk5K0vTqtWbk3useIeh0EroFqjUW?=
 =?us-ascii?Q?j3gegMy+a0YwC92/BQfOj+qxAOKYqDeSftRezBCNI4yIV8tjLuywO4Bvi2AC?=
 =?us-ascii?Q?zKSD3bnQKKDqE3TgBa1FGe8t0h6SfwTjq4sBcd3UVGajt50mxBhsFAkPBGz/?=
 =?us-ascii?Q?VMdigf+GLXfdOXWws1z6Uftv3NDSROK50BbWqMa19lEaA9IuUGaC9cHwjVNY?=
 =?us-ascii?Q?23DOXbCEmc2xn8p1GkEo38cXxxf5KOJMHQRqaRWIFE6bObWKbOEOMEng8NjI?=
 =?us-ascii?Q?OiWuGuJafBjDxjUEE+Io3FC6VpvhrHPf+xeqNngApA1kNiwiBJm4pMfqfmfJ?=
 =?us-ascii?Q?JcPR/U1cbMoukAuO5GK4JTldtB3bhoazJNDqzHZj2/pX2bt8mLxqDIarVGPN?=
 =?us-ascii?Q?7vC9CPhRTFuKdRSvaHuq0EhXwVjBYTH2yGqKrcPuULo6NcchePi/EAObKwBn?=
 =?us-ascii?Q?SMcaxxLxq1tR3YG47/w1CwncZlCa+IkXeyrQ0T9Sp5YGc5HMg2S+Ump57zEp?=
 =?us-ascii?Q?Eruwr7p+rUvD4xmlJIFOuaA8CrwxEYJGiZD0U0MuD+7PXMEcVnXjMmfAjhRA?=
 =?us-ascii?Q?xfokwZ0q+Sf6GnXwtpe8zjFhrnX9IqHjhP2NH9vq44H8oeRYkAYUAAxaKoXE?=
 =?us-ascii?Q?36M/a+Lehk5l5uJGGUkXXrTQu4axsbXO1+TmCqDEhK0Lawi4jb0S9tmbuaoN?=
 =?us-ascii?Q?pm7wz67x//CQjMco7gl1TxpTnzy78OpdZOITYoGyGwVdIMxa9sTIPf4LQMkJ?=
 =?us-ascii?Q?h8jxE+BJvax1pQbmETCv54MG1uCJ/DsxX9tIyR702vu4jYTU9v+dYZeC5qvm?=
 =?us-ascii?Q?rCrRw1vo6Hke7r283J+Qr5iqxG2h44/Fv31uufHbdKv7G8GrmxqpIHK/ek5h?=
 =?us-ascii?Q?ek8AXt25j4Y9p6onOaSBNFelgDZ87vR3pa9oo9H50g1q+9gIh0KCAWqF44er?=
 =?us-ascii?Q?OXXx8R30rSRSGdg8Jk4wM397F4tWH7P9hjiav5A0MyUsRnnM38Hbo7phGuAT?=
 =?us-ascii?Q?013OicpQe1I41/gxyMK1E5g2hSbcN0lySAkfMOzWUpjShn2XagX+GfC2+p4y?=
 =?us-ascii?Q?1hsfNvPMiiPWuyJ8UrNsoQBPoys1/CogDwv46YwdGy/TGDkSaoHYIrotEtCN?=
 =?us-ascii?Q?GBTX+/cpj9yqZoQpryxKNRxxpWYlBJXYeVL56YUayYFwiJZjaHNIcfc5eE1a?=
 =?us-ascii?Q?GlT+4SZkYbsTaEkINevvLlENTtdK4eClz3T/Y+yJFzCXA0zhcTjZlPL7v2+q?=
 =?us-ascii?Q?VuirKQo6DLKX9WCGJ9KLkNxzaB7icW3b86isKYC1JSNtL+ODQRD1cVH0qD85?=
 =?us-ascii?Q?dJa5/MpEn+/FJmL9xLlEpx5MDkmWGMshHUvIulcRAF1OKERBC1fDPJJzyas8?=
 =?us-ascii?Q?4czjuLkwGJeaUGc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:50:40.0074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c0ea07-0a83-4690-9d51-08dd615c1c9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8784

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

If a user requested to match on an unsupported combination of fields,
print the unsupported combination in the error message.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
index c4851d5584b7..c8cc0c8115f5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
@@ -500,7 +500,8 @@ hws_definer_check_match_flags(struct mlx5hws_definer_conv_data *cd)
 	return 0;
 
 err_conflict:
-	mlx5hws_err(cd->ctx, "Invalid definer fields combination\n");
+	mlx5hws_err(cd->ctx, "Invalid definer fields combination: match_flags = 0x%08x\n",
+		    cd->match_flags);
 	return -EINVAL;
 }
 
-- 
2.31.1


