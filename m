Return-Path: <linux-rdma+bounces-14845-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB29C97FE4
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Dec 2025 16:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968C83A46A8
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Dec 2025 15:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9699F31ED79;
	Mon,  1 Dec 2025 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JsMsGqwS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C070B31CA5F;
	Mon,  1 Dec 2025 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764602073; cv=fail; b=A8g000VnyBCdyThC/XvOH7UfyY6fC/zJ5Bs9A8Rj3mNWJDHDIajqv1oVYzAzYjzXalsZG8+dSHjdP73DDxy85AcTdJxSIMw4HYI2f5Drocdp7K3Xdmx5gz/exQOi550RNDiBOQ6b5g0FnUjcY+HwRz8vvC/mfgor4p1Febj0dW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764602073; c=relaxed/simple;
	bh=lbC319sX0AGaMRm8Ye6PnAP1t4wssweWUQ7qBCDOuFs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FS0dc+SOWrwzWeD2gYCqA4IdTKO1/0pmbBhWGbxxOtDLBLC7SLLMQrMIjKTJqzLpVhtDoD0T0eGEcS8kLQfgnrJ/xR0gPpJSPtcUy7TMeEBgIcqo9r5qz9din+7Y/IgYQd11I00P590sKyl9/IINYxhpmEx/XNdH+w1cakRvq1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JsMsGqwS; arc=fail smtp.client-ip=40.107.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjJRqQ9pGuGm+qAZOfiAZJyfg1ZYX6esW1qVS+/+G+ScZPg738C+GSRrYQcfKYKgeJnJAfUpxZWzqkKsbwKFf+jR3sC2AfqPBn8HJsEX97hxFidHWCC9dAmTxkVG8UAaaj0KrtQuih0D/5t20qxU9xHY5cQRMdIyYIBi9E44LFXA9mj2aZePYcdA/SGDXNNYFZOHCcf3jTrKmHUjH/ZYDFpjj8OFOuf5hZcg8YffGGBKUP09yciDmAlr+x1heljyOf5+Bv2A0BLN+aO8PVdRmpRXr1BjwFRNIJKTLl3hTwrhE+GkNxAPDtmklxvMpZ6xk/VDENTB7cUTpZ6CCocGvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yU0Q1ApmwsiN8YGCTI3sVlBJJtP8zX2NYbUJIDBG/uA=;
 b=aUydl3dFnsxzN9fc8RVN8wA5aczbsgryrQqXmIHROZBhX15APEQPtdv+nU/oRDDRLtVlyS1UNThkPJyZBw5v1DK3FvEQ61sloNUAerSV1F+HL7UL1Kdka8jqwVa9hndleY3AT3lWB46vY9DgHPfz9Yu1NKZcsmjXl6Pn1v5omgkYKxrAmE8eL5PcuHiAfs04t59NNsSsBMRw3AH47+HbvMJBPmf2bGBxGBunwgcSBd3cOAAp7edcxCRc8CTDaLygUvLX/5GkIm0iF2asazK2ngqSnhBEKo2FdaZsdzIaHyPDg450bzcJqRBYEFAvXuIc69Xe5kMtN7C22Nd1Bn8bMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yU0Q1ApmwsiN8YGCTI3sVlBJJtP8zX2NYbUJIDBG/uA=;
 b=JsMsGqwSEPTTTWRVQngfke9nZEFwawbgBbIseukCmq6tfuK7xUfhkja4PtpGbJy2iHHm/mJTArBbWQA2reFawip4QIp6iEu/PDsxiMQ6FsBBs2zAkuEf8bzVdrcGZI2qmvVw4P99bxt4oGYu8a1bnmsLx1t8OgXVfQO4Q2mDJeWxDOKy0GkN0qEvEOejAiBEGvFI1onpxfd5FU8wheNvjRuud7nhS9U9lFw4y4vvBWQ9i8TYmIhCds0dbxNekvskggyw9QBztf2sMyJ67vDQ1DVG78vpxdLiQqJeWXJTPzuFDSbQS+7gN6u0gIZOa/UuKrHHmhHVwzf1aRnUj863ZA==
Received: from DS7PR06CA0054.namprd06.prod.outlook.com (2603:10b6:8:54::34) by
 SA1PR12MB8094.namprd12.prod.outlook.com (2603:10b6:806:336::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 15:14:28 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::82) by DS7PR06CA0054.outlook.office365.com
 (2603:10b6:8:54::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 15:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 15:14:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 07:14:06 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 07:14:06 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 1 Dec
 2025 07:14:01 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net 2/2] net/mlx5e: Avoid unregistering PSP twice
Date: Mon, 1 Dec 2025 17:13:28 +0200
Message-ID: <1764602008-1334866-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764602008-1334866-1-git-send-email-tariqt@nvidia.com>
References: <1764602008-1334866-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|SA1PR12MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f46389c-3e8e-4a93-9be9-08de30ec5211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9wsxzjex/vHvJVGBq5kIH07IjVQWcyFuv+9phZ2oXc0swSrEYgyJ5TKiL8c9?=
 =?us-ascii?Q?N3BrCdnJ9Ga9P1JyMOlv+Lh9fp0yWCvTndmYk6fJA8Frl0Zhghk8GyBx3/lM?=
 =?us-ascii?Q?zr3XXlK+debflUPTVVcxSm2vZekFLk2knD4aTF50vTFPLGscBr8QJF7whnMo?=
 =?us-ascii?Q?249AQTEdZ9bXQl3o4imbM+8pWWK2RB5vIQN1Rp3fFLUn7VVD2IyRQekiEbQk?=
 =?us-ascii?Q?Pov4Gq5jVEjlOM5//mjpKivjIM1Ki/+nCr8OzJdVqfkwwKM2H8m8+ANEKtwa?=
 =?us-ascii?Q?aD4ZD9qHc2zR39WH6VVCJyUUNE0zRNujuVQgGwG2ThNeTwMlD2aohryJgDU/?=
 =?us-ascii?Q?VOj+ZQQAQ/KFamIbuTpiPbjapdH8djgZRWTzKy3yw0vyDVrZ9kSwimMsiSKO?=
 =?us-ascii?Q?GdKAsjveXEgSsWrRT9G5mH6j5cr6hQznY2gPEmhImeOM5Db/Iu7xWDpUVA97?=
 =?us-ascii?Q?KpQP4nFSHv9KJ9icRWMS3bP0T4SRJrlk8rEwWUb8DbtC6kkNeBbzw2wlETvl?=
 =?us-ascii?Q?WUZQwGq93QZCtJLhIm7LTKe0F05rupnH/8jRJ5SIWYD3HB4U/e6eJ/W46kX2?=
 =?us-ascii?Q?80dkEmv7gnpDqpjyN5ohDpjJrHU5T7ypTUliXizPwobcByfYSuXhFmGKHFul?=
 =?us-ascii?Q?eKpmQOjMwHAJhAdvULtSiD4Sx0bxL5YTw3Ki1UAg72OpZCR7iHjyVhb8c9qC?=
 =?us-ascii?Q?pZ48wQlZgotwTXuci5u4lmd2+BHXszOE0Um0oCLF0DO+7hJhc7zH5mn4iyuJ?=
 =?us-ascii?Q?AAt3Z8t83K8H+rvxHn1clCqlbTE2Xs5tfrETiM6YqdcH5Yh9vjDM7bhaiZAm?=
 =?us-ascii?Q?7i2+9SPmL+82iYKvgJbKJ01ZovpcmRYR9pN3tJfrnAgBxXSrwjRJp7ueDYmp?=
 =?us-ascii?Q?vEbGjhSZeFypwqcyQDC/hnUb88M/ynE2FFAUhjwLu6KuSEuqwLGtRJTLHWBp?=
 =?us-ascii?Q?9j2/egiBUkU+X2UD/ETFawPuZvknIIC3m1+e1bDg0cBWGogc4C7o7VbnLGNq?=
 =?us-ascii?Q?pGgRlK12WseF2rkKUDJ7bIKKr429Wvbi5FyEvL0g0LAvKnZH+MdAqoi/aDo4?=
 =?us-ascii?Q?D3e3g9lXrKxZD+tXgdS3LUT9mTNl2B5+GYIL+JceGEHohsnYiWy6tFMvtxmN?=
 =?us-ascii?Q?vWeCju4Mx1HEcn6Md9bKVP2Z1AYHWxnl0hWsG2Nkmktnt5mWoit6o/pc3M+y?=
 =?us-ascii?Q?O6TX5+Qvuh7ws3QszsiF+h8elvgKdF3Ej+8A00Zp9K9mtubyzIa4PI34y4Kj?=
 =?us-ascii?Q?RAoGlQnccMXtzg4gnhSNYX1e5v4Ww9cgp/CYMNoJjhzPi6QjFmIXTH+vi2g4?=
 =?us-ascii?Q?eIW5FGOL/nOXsIw/E2pwdmq9+aodLPtIz98RFmugYqalt1ZllHpELIkQOYtf?=
 =?us-ascii?Q?PIPASJqomIy97RvRCY1GbAVF0GVaL5xzkRYzsFWCvzcRrQQKLMkv5RBIVxYd?=
 =?us-ascii?Q?ZvpRfXXufLTJyRgpZL4RU0oVeDjovTtDeiF++A4D570OeaeDc2VIp94OgoeK?=
 =?us-ascii?Q?DB3GkNZOXGk2CS/rtklzaxBtP05cfIkp4p6xIl5QnSTzHclbf/VRcNZvLXxB?=
 =?us-ascii?Q?vGtbLc8RMxmWDHn15eY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 15:14:27.9015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f46389c-3e8e-4a93-9be9-08de30ec5211
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8094

From: Cosmin Ratiu <cratiu@nvidia.com>

PSP is unregistered twice in:
_mlx5e_remove -> mlx5e_psp_unregister
mlx5e_nic_cleanup -> mlx5e_psp_unregister

This leads to a refcount underflow in some conditions:
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 2 PID: 1694 at lib/refcount.c:28 refcount_warn_saturate+0xd8/0xe0
[...]
 mlx5e_psp_unregister+0x26/0x50 [mlx5_core]
 mlx5e_nic_cleanup+0x26/0x90 [mlx5_core]
 mlx5e_remove+0xe6/0x1f0 [mlx5_core]
 auxiliary_bus_remove+0x18/0x30
 device_release_driver_internal+0x194/0x1f0
 bus_remove_device+0xc6/0x130
 device_del+0x159/0x3c0
 mlx5_rescan_drivers_locked+0xbc/0x2a0 [mlx5_core]
[...]

Do not directly remove psp from the _mlx5e_remove path, the PSP cleanup
happens as part of profile cleanup.

Fixes: 89ee2d92f66c ("net/mlx5e: Support PSP offload functionality")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5e17eae81f4b..1545f9c008f4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6805,7 +6805,6 @@ static void _mlx5e_remove(struct auxiliary_device *adev)
 	 * is already unregistered before changing to NIC profile.
 	 */
 	if (priv->netdev->reg_state == NETREG_REGISTERED) {
-		mlx5e_psp_unregister(priv);
 		unregister_netdev(priv->netdev);
 		_mlx5e_suspend(adev, false);
 	} else {
-- 
2.31.1


