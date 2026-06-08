Return-Path: <linux-rdma+bounces-21961-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RBVOGeLLJmrVkgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21961-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:04:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CA1656E79
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:04:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=SsGHCMnT;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21961-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21961-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F3CC307C7FE
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 13:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E913C3420;
	Mon,  8 Jun 2026 13:57:26 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE57714A4F0;
	Mon,  8 Jun 2026 13:57:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927046; cv=fail; b=gT/MAO57vqaF5RvL1CDwwXtFz/uWdk1+4j6R/1a15jltTKDH9Bq4ixGNnc956ti/oU5PbtpkxBj58h61oTdhHEmiQV9C7xksURXLPN+LZWmCR9u2qcsuEJDRquGYtOMhokCOKD3zgquPIYRzyFMuoutmKzKYTlDzpunsxBfu4e0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927046; c=relaxed/simple;
	bh=rQ22eNsSCZrbd/KzcTXg7qekydIYOrMDtp5ZoAHeGoE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=berWlNoKE0FrnDaQnAE4SH+3PJIPO5czSvsTIsG/uRSDW8DPqz4kjlAAhTkqdy9fd2s13+bomoc+kxQhkIKOYhgA5Qzyik8UpFV8no+u2sZO9IgPEG4KHnRD/qBGhpUa9uPR9BYKLeUSyjvfTTB21+Gyw7MQ8zzkL1k4htmYCDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SsGHCMnT; arc=fail smtp.client-ip=40.107.209.4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAJcMA/n96iy0Oyh7QEWoj+iAbuwd1Bybw1YoZXmR13pifxe/aJx9WkFuUiybdBS/X1iVuR5yaqHyG3a+eqLMjZqNg0GM4L1MnYucZI/+ahSVBsqhg7oG7RwlEDxpI/H/4iGjMtT9FgaalZX8VSlq7gpSAiwuaq0JCkByBmMnlu0o1FC5wDwsHG8MU1Gss2d3C98aSxrCg+Hc9kB7oeogxvpruvXaYNk3mxtd5kd9mW/dDVVlgl9AqHmGZJKxHgotD1mqnjv8A9UHL5RTcNDQ465+t+W5uILvRBrx09whO07xGEzjLbWW2jo0E5D/mtZKunv3N/IsaqCge3GfhLU5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQZcBLJCZHvW3Ntw1r3ypf69EVU9L+YsENmz6th/NdQ=;
 b=i28GmLG0PuQcINqYlZ6oSTgSwcZMj/7dfqgAmcUXvtDJNyM78Jkv3FDzETzouX6WGwPsUCBVhQuoAQLZA57l4pzx7oUWt9R5X6PJgE4bREOXfHN9Aqsbh9CVzAAY+Z5lDH491R8DoHQhIXFfBmoDhYXU2ONo5wg9PXz62uCiwRmTVrfWFVwaFHOdM9w+xWIIJXLeF/IxPyDE7KEL6v0cRXtwKS3ZmBmILdC6Tqf3SEwcdn/u6JoZejnZZG07bUlQuKHpUJyUEMa1t/tO35mLoFSt6xiJzUJ0FqQ6kpa4UygGZWqREz+3NilW1vDzxWFMR5Q6uLQPxIK61RiGxf9YsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQZcBLJCZHvW3Ntw1r3ypf69EVU9L+YsENmz6th/NdQ=;
 b=SsGHCMnTmnFEIvfT8f6Wq5aiFWAMnZkNGffF3bVEF/TxJ3NrFfnJdFlL7WdxVFxhiyN+WXhwW5jc4geO1vlVYqPzDcRBDoG5XIuvW+J0RODY+ga4duMrsHw9hIal6y1C+9LSxmrN5FCsqpOn/9d5XX5NoaHRyZo+ibZpmq72hqmVyAA7j/t1a9G+bhUFWIoM7TUCbGcege00LSHuMzo67ZemlWdUXg+McGF00Rw8Q+lDwUl7DPJnjcSNScc0PD9OKG1gUu0wbaJr2bBVgYGyyn8TwaoOX1nZZjKTQGoiL3P1vZYabnW28WyQINqN4pI83YCwjGoh89D80Cl7kMSRTQ==
Received: from BN9PR03CA0668.namprd03.prod.outlook.com (2603:10b6:408:10e::13)
 by CH3PR12MB7572.namprd12.prod.outlook.com (2603:10b6:610:144::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 13:57:11 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:10e:cafe::4a) by BN9PR03CA0668.outlook.office365.com
 (2603:10b6:408:10e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 13:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 13:57:11 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 06:56:54 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 06:56:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 06:56:48 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Parav Pandit <parav@nvidia.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next V2 04/15] net/mlx5: SD, make primary/secondary role determination more robust
Date: Mon, 8 Jun 2026 16:55:36 +0300
Message-ID: <20260608135547.482825-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260608135547.482825-1-tariqt@nvidia.com>
References: <20260608135547.482825-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|CH3PR12MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef6bcc4-4d0d-4cee-24de-08dec565d683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|18002099003|22082099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	VluSrtgF/04gdz/rvP9c7LKV0dnlRAbpXFZAMBMn6P/EgjUMVwDGPXJQHh31U7xLdbbiOv+Q1qTIbbNJC/juCPyC/L+EotktgWxVmvVAg/65E44xLb2N4ynt+s4KjxOfhqa5lvLwq/wQd5oSr+ufEnXjAhVCDj43SgyeE0aEQFVDlnXDI+fh+4S8tXHPslgHdx04G0bkWUG1zYCvyCl8vDKyiXGofSbOtYOBbUAKbBZSia51nB0HX8WSkPKDkN+vFmPyVoOik3JbTbWh9BUTp8SNzX7z9zSnhDUhhKOxis/U0kgT+eKk7D9BxkZRx7pe+UsN1XrYhpSW8KbcMjxcT7K/JWb8G6SMSEyNMFjlpsoyAzr+kL8TJN/XklssnNoX9cZtyNf0Rq87M5IuKqSPeB8zh3xSabjaB8Iv+pitH0wItd75SHexJaiHeT+JtemVFgo8PvoTKwkrhspgF84HeS1K0kM7ea2tcmfhqkLSRYestnXcr29891anOKm8VbgNoZQu65t2x+cNzYygxAP/wkw3JaobPUi+Gy8RKafEO6aALlsb2RNs1g2Z8D7h/Eb/w+utFdXqf8CtCI3dgsP1X+16PldejcmTX7AqcsMrdJfbCFCuunrJnj+Luhr5eeXVgqQ9GsRcpBHtTCyE6mKz2jl9jG36njlHJRbdMZtF1lTZGtUitNu0OR6bJAgTSY1jWU6KVlZqxxnpIzEgN9gzLjqKI/uFX9SrWjjM63jPNLI=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aQYUSB9ilfRNGsg+ai2cOVlXilAg4k4IkgXR7sMRgrtWmMJ5SJpepdPvKF9i1aAq/7nDJlrOxM+XLawiUp1ETIUCSCqmH3vskl4/yc9OujitXtq2MLcteA3Jbal/YG7xPsEtTtkvAC3RLX3RIqtJedUeo7w7HMm6ltstN7eqxZ2P9zI13DgSEw6BpTJdW03TopGg+US6ILtuP8/QxzImH7VZNVTh10cYFcl3i5O3seb19PqkVZs6+WvJ81qhUl4+2N3bmhc07M/NsHi4suloYM1OTWXpSv+t0F69PVLeyPCYl32BnfiODeJeWFP+oxxYBo3v7cgneSaP6FYOIDmmtMa3sRREVh26ZehDOVVQ9vvc9GiahTonsPCu1YdhijyfmK3AuY9BgDFnFqzsKLzbPpVoS5SA4g7qDPHg6wl8gFvGRMQnyWJbQN5U/xYIIKbo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 13:57:11.2439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef6bcc4-4d0d-4cee-24de-08dec565d683
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7572
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-21961-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:moshe@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:dtatulea@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9CA1656E79

From: Shay Drory <shayd@nvidia.com>

Refactor SD group registration to use devcom event-driven role
determination to ensure SD is marked as ready only after roles are fully
assigned and the group state is consistent, making outside accessors,
which will be added in downstream patches, safe to use without races.

The devcom events:
- SD_PRIMARY_SET event: each device compares bus numbers with peers
  to determine which should be primary
- SD_SECONDARIES_SET event: secondaries register themselves with the
  elected primary device

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 137 +++++++++++++-----
 1 file changed, 102 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index 25286ecd724e..41979bf6a615 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -26,6 +26,8 @@ struct mlx5_sd {
 		struct { /* primary */
 			struct mlx5_core_dev *secondaries[MLX5_SD_MAX_GROUP_SZ - 1];
 			struct mlx5_flow_table *tx_ft;
+			/* Next index for secondary registration */
+			u8 next_secondary_idx;
 		};
 		struct { /* secondary */
 			struct mlx5_core_dev *primary_dev;
@@ -374,62 +376,125 @@ static void sd_lag_cleanup(struct mlx5_core_dev *dev)
 	mutex_unlock(&ldev->lock);
 }
 
+enum {
+	SD_PRIMARY_SET,
+	SD_SECONDARIES_SET,
+};
+
+static void sd_handle_primary_set(struct mlx5_core_dev *dev,
+				  struct mlx5_core_dev *peer)
+{
+	struct mlx5_sd *peer_sd = mlx5_get_sd(peer);
+	struct mlx5_sd *sd = mlx5_get_sd(dev);
+	struct mlx5_core_dev *candidate;
+	struct mlx5_sd *candidate_sd;
+
+	/* Peer is the device that being sent to all the other devices in the
+	 * group. Hence, use peer to get the candidate device.
+	 */
+	candidate = peer_sd->primary ? peer : peer_sd->primary_dev;
+
+	if (dev->pdev->bus->number >= candidate->pdev->bus->number)
+		return;
+
+	candidate_sd = mlx5_get_sd(candidate);
+
+	sd->primary = true;
+	candidate_sd->primary = false;
+	candidate_sd->primary_dev = dev;
+	peer_sd->primary = false;
+	peer_sd->primary_dev = dev;
+}
+
+static void sd_handle_secondaries_set(struct mlx5_core_dev *dev,
+				      struct mlx5_core_dev *peer)
+{
+	struct mlx5_sd *peer_sd = mlx5_get_sd(peer);
+	struct mlx5_sd *sd = mlx5_get_sd(dev);
+	u8 idx;
+
+	/* Primary has nothing to register with itself. */
+	if (sd->primary)
+		return;
+
+	/* dev is a secondary device, peer is the primary device.
+	 * Secondary registers itself with the primary.
+	 */
+	idx = peer_sd->next_secondary_idx++;
+	peer_sd->secondaries[idx] = dev;
+	sd->primary_dev = peer;
+}
+
+static int mlx5_sd_devcom_event(int event, void *my_data, void *event_data)
+{
+	struct mlx5_core_dev *peer = event_data;
+	struct mlx5_core_dev *dev = my_data;
+
+	switch (event) {
+	case SD_PRIMARY_SET:
+		sd_handle_primary_set(dev, peer);
+		break;
+	case SD_SECONDARIES_SET:
+		sd_handle_secondaries_set(dev, peer);
+		break;
+	}
+
+	return 0;
+}
+
 static int sd_register(struct mlx5_core_dev *dev)
 {
-	struct mlx5_devcom_comp_dev *devcom, *pos;
 	struct mlx5_devcom_match_attr attr = {};
-	struct mlx5_core_dev *peer, *primary;
-	struct mlx5_sd *sd, *primary_sd;
-	int err, i;
+	struct mlx5_devcom_comp_dev *devcom;
+	struct mlx5_core_dev *primary;
+	struct mlx5_sd *sd;
+	int err;
 
 	sd = mlx5_get_sd(dev);
 	attr.key.val = sd->group_id;
 	attr.flags = MLX5_DEVCOM_MATCH_FLAGS_NS;
 	attr.net = mlx5_core_net(dev);
-	devcom = mlx5_devcom_register_component(dev->priv.devc, MLX5_DEVCOM_SD_GROUP,
-						&attr, NULL, dev);
+	devcom = mlx5_devcom_register_component(dev->priv.devc,
+						MLX5_DEVCOM_SD_GROUP,
+						&attr, mlx5_sd_devcom_event,
+						dev);
 	if (!devcom)
 		return -EINVAL;
 
 	sd->devcom = devcom;
 
-	if (mlx5_devcom_comp_get_size(devcom) != sd->host_buses)
-		return 0;
-
 	mlx5_devcom_comp_lock(devcom);
-	mlx5_devcom_comp_set_ready(devcom, true);
-	mlx5_devcom_comp_unlock(devcom);
+	if (mlx5_devcom_comp_get_size(devcom) != sd->host_buses ||
+	    mlx5_devcom_comp_is_ready(devcom))
+		goto out;
 
-	if (!mlx5_devcom_for_each_peer_begin(devcom)) {
-		err = -ENODEV;
+	/* Send SD_PRIMARY_SET event with this device.
+	 * All peers will receive this event and compare to this device.
+	 * The one with lowest bus number will be marked as primary.
+	 */
+	sd->primary = true;
+	err = mlx5_devcom_locked_send_event(devcom, SD_PRIMARY_SET,
+					    SD_PRIMARY_SET, dev);
+	if (err)
 		goto err_devcom_unreg;
-	}
-
-	primary = dev;
-	mlx5_devcom_for_each_peer_entry(devcom, peer, pos)
-		if (peer->pdev->bus->number < primary->pdev->bus->number)
-			primary = peer;
 
-	primary_sd = mlx5_get_sd(primary);
-	primary_sd->primary = true;
-	i = 0;
-	/* loop the secondaries */
-	mlx5_devcom_for_each_peer_entry(primary_sd->devcom, peer, pos) {
-		struct mlx5_sd *peer_sd = mlx5_get_sd(peer);
-
-		primary_sd->secondaries[i++] = peer;
-		peer_sd->primary = false;
-		peer_sd->primary_dev = primary;
-	}
+	/* Broadcast SD_SECONDARIES_SET. Each non-sender peer's handler runs;
+	 * the primary's handler returns early so only secondaries register.
+	 */
+	primary = sd->primary ? dev : sd->primary_dev;
+	if (!sd->primary)
+		sd_handle_secondaries_set(dev, primary);
+	mlx5_devcom_locked_send_event(devcom, SD_SECONDARIES_SET,
+				      DEVCOM_CANT_FAIL, primary);
 
-	mlx5_devcom_for_each_peer_end(devcom);
+	mlx5_devcom_comp_set_ready(devcom, true);
+out:
+	mlx5_devcom_comp_unlock(devcom);
 	return 0;
 
 err_devcom_unreg:
-	mlx5_devcom_comp_lock(sd->devcom);
-	mlx5_devcom_comp_set_ready(sd->devcom, false);
-	mlx5_devcom_comp_unlock(sd->devcom);
-	mlx5_devcom_unregister_component(sd->devcom);
+	mlx5_devcom_comp_unlock(devcom);
+	mlx5_devcom_unregister_component(devcom);
 	return err;
 }
 
@@ -672,6 +737,7 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
 		peer_sd->primary_dev = NULL;
 	}
 	primary_sd->primary = false;
+	primary_sd->next_secondary_idx = 0;
 	mlx5_devcom_comp_set_ready(sd->devcom, false);
 	mlx5_devcom_comp_unlock(sd->devcom);
 	sd_unregister(dev);
@@ -719,6 +785,7 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
 		peer_sd->primary_dev = NULL;
 	}
 	primary_sd->primary = false;
+	primary_sd->next_secondary_idx = 0;
 out_ready_false:
 	mlx5_devcom_comp_set_ready(sd->devcom, false);
 out_unlock:
-- 
2.44.0


