Return-Path: <linux-rdma+bounces-13706-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A84BA77F5
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 23:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DF41755F6
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 21:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80C329E0EE;
	Sun, 28 Sep 2025 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BOz0turk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013010.outbound.protection.outlook.com [40.107.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EF729BDAA;
	Sun, 28 Sep 2025 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759093359; cv=fail; b=Y52oPlHQKrVwCL8UHBi8qZ9LSfN9lSC44TrpUIgebob0NsXNGok+tOwxj4PaDKF4xiLPhR0tRqs53Bc5Nl0eXKKJjABg12F3JHzvvIXStwwJmbJmXydpCHDkc/xqCvmJm+3ceo1AsI7q2JcPxZqSa0zcnD+dr/EKpkqpXFNZTXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759093359; c=relaxed/simple;
	bh=uSdC4nz0KMbVVNCEZ/fhobR8+91SZYIS/AjBLUCcOko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0EEPsSbcroBQL3dHwwjB3hcU/2RlRlOveyKL9gi9mPXsMeyhe4ExoC3WwbX0RlntaL3oxrB9yPKUCsDlyCevrsT4vbEJXQp7rLYCOk8Un1rlDTBwRL90XL8cM9yciJHW3VL25SP+FLinCRzOuGJ2xzDblZfZ9Yj2XfUxFBDafw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BOz0turk; arc=fail smtp.client-ip=40.107.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUfU8zU7BrJCOGnN7XdrzJ4tDf0vwJbmZcHsMJ0lOauMRJRstQL1ToXlLYPy8mAfT/Fv//LW2Z+Lp+FKo/yjwOpCQa4CsWGgNwiT4ZSGWafEvXD2eA1NqAtKEkB63IbTey56JsGhBC3ZhMSRjsuGk87SG4/Ewrxm415SJK1u6tUyg+h822WPyfzjQXsc2be/i5xEjaQ3FOWivrb7eSjbAIFipkaclkfd+p60RKzzN2X+QMTPbfFkVS8nzqfhMo0wv+J7iaHXWzw3E09wk/PPXNopovFJMnaTBy0IKhoHaJOEvNhMGFJYS+zCuknUaWhjD8pavjx83/Ji4odbpjlyaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iKyg07A9dXKPHYdX0EP3wFEMZgXWeSsG2sMqWlTdC0=;
 b=PZ5qt82vGcn7VZNzUw6soI2EyeWzVeg+z++QllEAoDDQXDLxYr4/a89d7qnYYrkbv/UyWsEDRycD4j+wFsZG5rDMW6zkagQbMtGbwxwpZwbQj9SognwqXTEBUnQZkUDT6b3GTgbF0hnC26ksVysKKFc1Cuux2mSQdZGGZReapaIAGjPICy0AuoALeSXq6NNTcCfZ5pxm7W7tAhJoTq+i1mJQkcmC0qTknYmjrDs3d/Pht6/207FcC80xmHdLVTC4l6iee8j0BrXEgmIKomGEISZoVGklQI6TGquyvLHHhDiwh9Mm3oX+DWy92qEHfD5be39/kgPfsp90xwuOHqUtTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iKyg07A9dXKPHYdX0EP3wFEMZgXWeSsG2sMqWlTdC0=;
 b=BOz0turkAmP7pM+hYKv9MKk4oo3Q7ewl0ngdsTiYIDhp3ZigH9fPba+lcfA8D19Q+T0iWFjXhSmSmQTjrib+D3hAf0yTlAj04lJd7knnTHCCIM2cJI5zuubJngoRNNLjVCFgCs3kb0ujA+Q0f7pS809th/p07g7wvrnYfFt8Gs+C8R9AbcaHOhdmpR6r605Q5gEy0Q28LcdCYsAzJCxphq8HMPoAowkqP1D6uoqfWZqqro7XMybfUbH/rPwXHHERQnKveRRj9AxZT7R3EYcuUc6mIqmoSFhwO2J+H4KV1uvoPR+drljMUllzNxMxjg2nfV2C4bq9GAHnlJQ7FqHrBg==
Received: from BL1PR13CA0329.namprd13.prod.outlook.com (2603:10b6:208:2c1::34)
 by BL3PR12MB6521.namprd12.prod.outlook.com (2603:10b6:208:3bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 21:02:32 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:208:2c1:cafe::70) by BL1PR13CA0329.outlook.office365.com
 (2603:10b6:208:2c1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.10 via Frontend Transport; Sun,
 28 Sep 2025 21:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Sun, 28 Sep 2025 21:02:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 28 Sep
 2025 14:02:32 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 28 Sep 2025 14:02:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 28 Sep 2025 14:02:27 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>
Subject: [PATCH net 1/3] net/mlx5: Stop polling for command response if interface goes down
Date: Mon, 29 Sep 2025 00:02:07 +0300
Message-ID: <1759093329-840612-2-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|BL3PR12MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: de1d43f6-0f1d-4800-6456-08ddfed257b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?93WHtUCFJh79XNrTi13un3I47aG4gEUPWjqBpMk9PT7fYjtMbyLZzC/+27Lg?=
 =?us-ascii?Q?6I1li4LMJAp0Xx2PD5GnaC3qYjdvWmxvXDGHzjkezsaOU6sWgJozlHzUfyAi?=
 =?us-ascii?Q?zo43FRz1if2CBv2EGPbI7lEcP3KmQTK16iuQ3u1V53mN8AgEc6zvh/GiuyHa?=
 =?us-ascii?Q?9Or//1aqJDjgB+R7H4PK4z9gwYa5rOo/CPpIUYbwu/1qUl/C1OVLerhtGttw?=
 =?us-ascii?Q?Q/xwM86Ku0zXQ95WIyCl8WqPlQBJ7Urv2j1kyaAVsNK2Dq1sI6KqdYKuxpxX?=
 =?us-ascii?Q?nVNFkEWFNMFKa38E+ssHJquqgVZFgE8iQ0esHQ0mEWf7Gs5qs3206VofdGj/?=
 =?us-ascii?Q?gsxLYXYNVw3vDce8TFsSJB3+tP8GDato2qvGBc/4F9Q5k/RIqrNNnnrgaQ5c?=
 =?us-ascii?Q?kFc9+l1JttPO4bAo4K8k1qb3gD+S+p1oI+Nl7SUc/0G8co9Lx5yzU0g/3c7u?=
 =?us-ascii?Q?cgwcta5t/gxaQPLXPGdWRp72eelmANxVPueZQyqT8DfcCL4iUmr+LPj1Y+s4?=
 =?us-ascii?Q?UiihwnEFcIfZIh1ms++voYxWHFRL9xVkByTZX2QTVR55xGFly6teXBzGrmY0?=
 =?us-ascii?Q?0G4YJtytQAUCCgOptqVE87Y6P9v4Hk9kBIDl0wxYuSvIuULRqIpwt6MUkeLw?=
 =?us-ascii?Q?NMuw6B53ngsN0ZJErxYdGLWZavK7uaBOWA+WkYLqqo9L7UMMO0qL4XzLelcZ?=
 =?us-ascii?Q?1EY03FcsZxkEGYB7Hm31wrufm/4EhEplK8Ecp+y2VqVEHzMwWxTuGrswrr45?=
 =?us-ascii?Q?VIgKK6H2dA82cKOpBsqVt2gStEXILo35cKwBuGNhcUcCFb5G2oTR5zLBro7/?=
 =?us-ascii?Q?CKvYFQLIeL06qAahjdXrifX3Gq6+5MQTxtDmTWi0OrBTldm2EexFcwFqvvTa?=
 =?us-ascii?Q?Ohdzi2alAF5i5e8mQnPTH+nAKz+ZM6EFBd2cRpul9LXayVGPQKnhcCyUGsaA?=
 =?us-ascii?Q?neLM+M52lw4H/8exMBZ9+wSjm5/dL5RzUsKfnYRZpido7Z2UVrAoKNzBf+0E?=
 =?us-ascii?Q?R7kTrp3FGBrvkglKDixy1R/5ql3UREOZTi7kwOdBqxg+BpJVE+6ANk7mbuDp?=
 =?us-ascii?Q?143tq3N3dRLHGeenUELH5IMQLmOOe1ef1FBpmb2st5BX1oG5qUFPCQ1EbZ0S?=
 =?us-ascii?Q?bkQ1ugsl0pGvKlsJ6lEjH9tPI0mW/31iAOjW9HUVWIbHgjMTenCTx1uDHDrv?=
 =?us-ascii?Q?BsDjnVbjQaeBNfke+e+OcMskQg77D1W1hEqh0kwzyzIddf/IsdKgTsPZa8No?=
 =?us-ascii?Q?jOLm6Je0lAj+mVwXEsHBDMc4ghbBBmKlVVG1l/qXuMmjxAPO68iLL+lcv3Jo?=
 =?us-ascii?Q?gOXlJMp1+SnR2kNHEauJFsmAxyFm9KeW/Ji+YfRkgdaAKV9/PqfIRd+i41Yc?=
 =?us-ascii?Q?bagyP6Et/1gGy5I5x0M6LFMGqmG00PBrfuEK8hg06HidLJBMxIVuIWnK/oJM?=
 =?us-ascii?Q?1pIUrOZYWwQ+AWk59xQP6matyIaG54J+M5uedED9aFaTF8J6wTp8jV0N4YQV?=
 =?us-ascii?Q?nR7aM3JazAr3zKTrb+MNUgHlQVZKT3OUXpLBsznLF8KLU1bmDGiTdKvVlZqZ?=
 =?us-ascii?Q?2I73SMCWW1L4L8/c/YQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 21:02:32.2808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de1d43f6-0f1d-4800-6456-08ddfed257b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6521

From: Moshe Shemesh <moshe@nvidia.com>

Stop polling on firmware response to command in polling mode if the
command interface got down. This situation can occur, for example, if a
firmware fatal error is detected during polling.

This change halts the polling process when the command interface goes
down, preventing unnecessary waits.

Fixes: b898ce7bccf1 ("net/mlx5: cmdif, Avoid skipping reclaim pages if FW is not accessible")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index e395ef5f356e..722282cebce9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -294,6 +294,10 @@ static void poll_timeout(struct mlx5_cmd_work_ent *ent)
 			return;
 		}
 		cond_resched();
+		if (mlx5_cmd_is_down(dev)) {
+			ent->ret = -ENXIO;
+			return;
+		}
 	} while (time_before(jiffies, poll_end));
 
 	ent->ret = -ETIMEDOUT;
@@ -1070,7 +1074,7 @@ static void cmd_work_handler(struct work_struct *work)
 		poll_timeout(ent);
 		/* make sure we read the descriptor after ownership is SW */
 		rmb();
-		mlx5_cmd_comp_handler(dev, 1ULL << ent->idx, (ent->ret == -ETIMEDOUT));
+		mlx5_cmd_comp_handler(dev, 1ULL << ent->idx, !!ent->ret);
 	}
 }
 
-- 
2.31.1


