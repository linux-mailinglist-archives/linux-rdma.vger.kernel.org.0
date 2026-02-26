Return-Path: <linux-rdma+bounces-17219-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLs/NHhSoGnriAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17219-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:02:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9691A7268
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0777C30F4DFE
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 13:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA0636166B;
	Thu, 26 Feb 2026 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WNlR+aIn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011047.outbound.protection.outlook.com [40.93.194.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB533A1D18;
	Thu, 26 Feb 2026 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113972; cv=fail; b=l8bz96x9Xhic9qefByUeQFkm5y4gx6QKhVx8Dp6j4+mmSQGxg/wcFs7cHMk/KkrEV/eJEkduFrZzYVo2rVPYZ6csX4DGHdCfPp/c7vA+c/FYAts3WswWojz8rpSBHWkwzaR71Y1T7Kj+Bcx0Y0HoYPrmbn1UPT20kRlpPy1vN2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113972; c=relaxed/simple;
	bh=WKTMRxDcmHtySXYGShaXFcKgQDn+Vp8MpdO8IkR3e98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ebFna0RHS6bYoBOiyX+d+2Stun4q/uXBe+VSXNq/EeQVAdkqGskcD20N8JRQAo42cdRgLVqL6FC++Jqgq2fuGGwr5o+UnD8R6k2M2/vR9K4MSRp81Y8nfYLPDHFATSnFrbnVNqvXofyt1LG1NZUQ41KPZFrok5rqvYfOVOKSSAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WNlR+aIn; arc=fail smtp.client-ip=40.93.194.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBOiwq713MruYE4gRvl7p5TqGTS3lf1QSk+KSsVK8EGadjZ8F6+CoYdOvhEhkFLp02ug7e6duUz0YhwsK9jM2EmiyvDk+UjkFQayRNi6jeXo4AJTRvSK7DLvZkKBvhbDYLmJA16ZR1Rqai9AJozuqCjKxr6vTNwudrozyjug8C8Gq/pacjEsNqt3cMcZDRcPKcWCO5f0k4GUjHpShA9MEZzkU86e5oyteq+Sro86p/p9aCKeJ3DktVUKXsENsP4yJbQWC6uz7fOkKs2tTh1sx2jsdcLMZbxVgBq9RPGObIXZ2Y5pR+HPhA3Lj2aPkzj3aBFUTTRodZjUmN22BeSKwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcDOBfyiuTr65kS3bbK96ae+o88ffiUVeayzrFFdrfo=;
 b=LEcmEQHQE4yDaO8TOsRBEAegM+TnNsXH+qZulpwQf2N1Y5YFFTtO+KibAopiiGt++s0qrN1HRI4ITUfJ/l08oVaeLHiy2BreCD2TJF0I0Ooo+1DWoTX2XJU5I+QOPVDVVEZYyaw7EUdjqAbRKxIQUaY49pk3tr6GJ5GuCuYFl0OluyUaEckA1diTlglwZreOYeOZxVDSnKmcfaBEo7/lB/3crj1bcP3w5tXcwwIv9476R1fD7Z18bG2chu5KtXcIBgjdM2GSCCeZXmN/vyL1D+Vtfr4ysVwsBAwCbPkml4UUElnO8tUVNVf5zQqKLWWvjLXqsa4ELcCgs8aQuJSTAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcDOBfyiuTr65kS3bbK96ae+o88ffiUVeayzrFFdrfo=;
 b=WNlR+aInLtuqNrZhgTUuV+UPlbWn/RhFMLUagIrGbjfoLOWZVzyKoMBaamQbRehiVfV4Uu02ihddSKE/M0PWfkZXDLSR42sJ5uz7Iq4Jz373O+uHByfrnSE5PxPnpFg1QJBzShdpRXDj775m/bNabuXYoZwB6ndExM5Sxq4ihfdnCBgEmnNdz4n1M0ljGoHkAdCRfyGtYPZGCDUoMjxw3KHrVfG+JcWbqWNhjjITVFBETvIG1uI+LISD4Kaf4VQEQMO6+yJRwD/HMerOS03ZfcpqSX8pMDeYjT3uGvE3uLVHZa6pUC0f6G4JeTlq+IWUg+XpQRjx4cN+H4WoMJUk0w==
Received: from PH8P221CA0059.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::10)
 by CH3PR12MB8481.namprd12.prod.outlook.com (2603:10b6:610:157::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 13:52:42 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:349:cafe::a7) by PH8P221CA0059.outlook.office365.com
 (2603:10b6:510:349::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Thu,
 26 Feb 2026 13:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 13:52:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 05:52:27 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Feb 2026 05:52:27 -0800
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 05:52:23 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Thu, 26 Feb 2026 15:52:06 +0200
Subject: [PATCH rdma-next v4 01/11] RDMA/mlx5: Move device async_ctx
 initialization
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260226-frmr_pools-v4-1-95360b54f15e@nvidia.com>
References: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
In-Reply-To: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Chiara Meiohas <cmeiohas@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772113939; l=2278;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=5YOde9uwxuGK2MT54KB21UN+zziadu5GV04s4VXzhqA=;
 b=gJb+zYH1c8qJcgx3bJ9hLEQKOkenoi6nOMD6pIayihhGTumI0bozVPl54/PgrNNV4KyRhnP1N
 g1oY+mzRGjvCtXk8tgKQy/UddAR5rnbEBap89McELOdoUp/643pqavD
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|CH3PR12MB8481:EE_
X-MS-Office365-Filtering-Correlation-Id: e3487981-3512-40b2-247d-08de753e4fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	c4Vcmma0ZS8GA5nlTnlPK6tILQ180Viih8QOJLGkHRlB0HgVA53E2eJcgteJ+GUiDkHSgaVx0eRJJgFUypNB9y7QCDDEgJr2a/rNLfSspX+B6Rkwz8b3QYpTbHsgf0q9w1Gkh5ko9OVIAtO/5Dh4DKvmI3uOZKeuPDyGLklg1U9qn1edmLoepVhsaILnXiPDkJZlInIzpXmcTxftiIvBQi26gBQReqB3U879JX2aIYpLdFTzW6AIOA5VRhtg7HtNJQCM75ZN2t8S0ECkmVOfgMNnLGh3vpRzF0Q4EH8hPmacjXU1xbAC5YD04xbyft/0Zpzy/h5jApD+Y2V/evmhFY/BLQFocP3QhpbxPsj/lgBt61Q8lL4nnX+ZZUd++Www9NDcy/aKKOpbdXsIlAYW8YNNDCejj4LF6+r/DAo1fBIiq5ev27cxCBdwe9WwWGQ5OddMekFEkK6Q26rSIrSD+z56jmbTNLLzskUrkk9FejlnAWiHnwjipAEruiWVjhuVogdNAPDyL+DQ91hVF9Vz33lcRM269ag3XpjBusUvC53xNFDZZLZ7sdrxwQcpUq+O0Dz6zzDHlvbuIPj4osTcEL/YaWm/pT5+t4zeX6rfrhH6sQburd1mdNC8t2/5O7kC14HJYH9vY9vb+5IYv0I2tQS9Qe9QPBirprebp2IlKD8Uhg2+KAj2RVpaXW1KPeECu3ocWV1aBKc4ZOXddTDc6F3SEC+g+G/ci99YRa7mynpzfAaWYKLP+Q7J5DC8d2lMITl+L/74MPAr4kbJrZjEYi+p0y2RJN6UiVPXVg3LX5aZhWuTtamT9k1nMDNnR0nOWneK/A1kOPxgWaaCJTYZp/4FaIvjXhHAmm794fTxgPQ=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nTiFSprr/VfFcYUqJtHNRqiG+7AUeBO/DqSv2k4Cyom489CxnIbhaqFzuaWBe0Fycv7Jb/cSL1/i5V/99iyZ7D7fcrv50/6Ix9Y9cNWsRgR/jyZiB7HAwCCaMuh3h3YzQNgaTXVKw9fdBrhpOd34/1QlpCRMSaj/7sQ7BSyTH7vujkJHImQhmZnq5ioDtBKV9oDv1+pt6rM9JE9DrUuzD8Ha898HAEhOwD/WuYjdmbM6zfv5IDm5rYRiFoI2+GIOd9bLReEXq7RzFtQo1u5KZBptod6NjIlmTqStenUdmxLWsNG/MpvfKdOVUKw63zLB21nvAhm3jQNuzs8vymIJ7cPztm0d92PUk4E/xUjqISZJkDv54icwXcyZbZlmWWn/x2V5B2otOnQS9aGRYjXM4oxy/N2lJNkPzuYZcsmz5pu3PZCRiWiqZO5XI0W7aD76
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:52:41.8641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3487981-3512-40b2-247d-08de753e4fc0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8481
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17219-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[cmeiohas.nvidia.com:query timed out,edwards.nvidia.com:query timed out,michaelgur.nvidia.com:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7F9691A7268
X-Rspamd-Action: no action

From: Chiara Meiohas <cmeiohas@nvidia.com>

Move the async_ctx initialization from mlx5_mkey_cache_init() to
mlx5_ib_stage_init_init() since the async_ctx is used by both the MR
cache and DEVX.

Also add the corresponding cleanup in mlx5_ib_stage_init_cleanup() to
properly release the async_ctx resources.

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 3 +++
 drivers/infiniband/hw/mlx5/mr.c   | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 635002e684a55fcc2f6c42127f67abba38809b08..c4d2fc58e7a8a8fc65b4585a9e26aadffde899aa 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4418,6 +4418,7 @@ static const struct uapi_definition mlx5_ib_defs[] = {
 
 static void mlx5_ib_stage_init_cleanup(struct mlx5_ib_dev *dev)
 {
+	mlx5_cmd_cleanup_async_ctx(&dev->async_ctx);
 	mlx5_ib_data_direct_cleanup(dev);
 	mlx5_ib_cleanup_multiport_master(dev);
 	WARN_ON(!xa_empty(&dev->odp_mkeys));
@@ -4487,6 +4488,8 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	if (err && err != -EOPNOTSUPP)
 		goto err_dd;
 
+	mlx5_cmd_init_async_ctx(mdev, &dev->async_ctx);
+
 	return 0;
 err_dd:
 	mlx5_ib_data_direct_cleanup(dev);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 665323b90b64f78d0f556bafddfacd42904feb87..6cb21290082079fcfa61d8a3b5de3970d38836ba 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -978,7 +978,6 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 		return -ENOMEM;
 	}
 
-	mlx5_cmd_init_async_ctx(dev->mdev, &dev->async_ctx);
 	timer_setup(&dev->delay_timer, delay_time_func, 0);
 	mlx5_mkey_cache_debugfs_init(dev);
 	mutex_lock(&cache->rb_lock);
@@ -1040,7 +1039,6 @@ void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 	flush_workqueue(dev->cache.wq);
 
 	mlx5_mkey_cache_debugfs_cleanup(dev);
-	mlx5_cmd_cleanup_async_ctx(&dev->async_ctx);
 
 	/* At this point all entries are disabled and have no concurrent work. */
 	mlx5r_destroy_cache_entries(dev);

-- 
2.49.0


