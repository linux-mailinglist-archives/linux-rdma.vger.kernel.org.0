Return-Path: <linux-rdma+bounces-17762-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KyIBKuUrmnRGQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17762-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:36:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF6C2363EB
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 10:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 258AA3025A49
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 09:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A409537AA8F;
	Mon,  9 Mar 2026 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l3j7yCL8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010025.outbound.protection.outlook.com [52.101.193.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48935379EC1;
	Mon,  9 Mar 2026 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048974; cv=fail; b=EIMO3hqjxJHPkN8vlnfoxZS4Ga2OTIkczCmiWavciR+p9POl4GgU2DdC+N41qa8/WKG18kTSJH9z4o24j6i2cuhVn06vNGdtUVNZOYRu37cRZyBtVE7MlSehM4DiEGD0HIyqAr0+E+9thtjErycoVqXHDArJ8fIG/yOWFkMHXUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048974; c=relaxed/simple;
	bh=Lg+s4E4b4KmXNSgWcHmO1NffddwCOxedqZKIPZdoWXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpt1tz+40UNIBRJj0eMqHCRNJagK0l4W6g38xazUv6SXkUQX2J7K1VGuiSR0nBhop0Lg107bbwMWVwx4ex4J4rEJN1kubP8Lba4Rocy2SSXwXv6OY3Iq3ODxPLb/y+LazJnPdEgvYsfOokokiXJ/MA+JqsDiH4cQr9fLfXLGaKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l3j7yCL8; arc=fail smtp.client-ip=52.101.193.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyOASkcrf48dnpHKXo5MnOKXMmi3M59b54dT3l2TmpHYo3RvNOvnZ2ARCMbDfIugJBXxAfjOWexNa/WWkgjG+pCbGM3uP+Uil29+coYmUjzq9oakVnvWYcKdsuYRc16BcVr19hwBIm0F8Ys0jJmqO8U2iR6EPTlfGdopZrSz5h+1d5DwI83FxZVb7y8WD0b29YMTOUM+3WNQ9A5iTJudzeqnCvBpVrTZ0Iee40s1Dd5KnvBkcZlaRiO3RcquX0yYVE8WMDQ/s82H4ZOflVO/37jxze6odiYuo93pexCk8uuhpzAfd40m6AMwIzu2XIZkHi+7AMzKz8f1uO50AffnFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4Ydhu+Oh7eE1JCKNbwKHPhZMVS/kSBkltKVVihbos4=;
 b=uRFT8UTOtkaP36SLSgiqgm1dqLLWh48r04bD8mhtr3VwyXvXuxIpUsbRQTq8LljxeqX8mZ9uL/AqIfLC2nSjPJ0+dfrpMO1ki1A60Gas2ECwNd97vjnCkA6hpBDXMQSjV5MNDt8NrhdfWRUd86MKMimLCq8Yu3cOIGoQ/lq7TpG4LXlEEkhlnw2erbPJQyuqTtLw5N2XBf/LX0x/dg+QxUYscZBkVqri0YJjYzPEDPA34YqNPqwuiWW5fJcLLYXUE1HG0U7Jwp46Pmn48YBRm27sLD29ASmOR1cTkXMK1SIXRtDCbuILikZgrClxaHA+iEDfaSlYyOdFpx14dBk76g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4Ydhu+Oh7eE1JCKNbwKHPhZMVS/kSBkltKVVihbos4=;
 b=l3j7yCL8T6JvutrtOSbQP77PK8I4ynkS3S0+RpszkGWkoE+1Z6uHDj0wP1nFSRgTZfic3ChZnNFNktJ+ho44uvJLhHURjcxUXrhRL1YbgWaippuE4JkOcuvDlQD5e5UjcAPVkX6XAA3vB6vHr2MRyybL3bgc8jxNojwzZ4jkOT77WjwnWLPhWVSg829/dcpemg1Zi+LjR7PBw9NbA9BYXQdll8ajjQMqVO0LlS2AWDFE5PFKGnvKT/7unlIqbV0x+l2MwZn/xYcT7FjzWQlt9f8eX0IC0i/+rbim7ieL/mkZM6n8iIfUTWOfuAIPiPcvUhyipToXEMvmYXCI+0/Ewg==
Received: from SJ0PR03CA0084.namprd03.prod.outlook.com (2603:10b6:a03:331::29)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 09:36:08 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:331:cafe::c3) by SJ0PR03CA0084.outlook.office365.com
 (2603:10b6:a03:331::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 09:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 09:36:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Mar
 2026 02:35:36 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 9 Mar 2026 02:35:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Mar 2026 02:35:31 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
Subject: [PATCH mlx5-next V2 9/9] net/mlx5: Expose MLX5_UMR_ALIGN definition
Date: Mon, 9 Mar 2026 11:34:35 +0200
Message-ID: <20260309093435.1850724-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260309093435.1850724-1-tariqt@nvidia.com>
References: <20260309093435.1850724-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 48dccbe6-fc9f-49c1-74e3-08de7dbf4aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	0kAZaLuTxyl3fvibiPM3RekZeKgDkeRYmKXsd0b4phaqRI4Bjj9LPKQL1dlZodBTWS+N6yNF45ZQAPOIPWVBSIEl08FCm7olNjYHR9PLYuA1Zr1Ivz8YT5E+x4u1/Iopj/VBpamvtW1UkYX7mhgk2xOKTs3QsBxd8NrGohvQv/iYS3rcWjyd5lWkDpvebTwALdkObEktFiHErgqqKXKXeeerjFMBUg7IAT25S9PFmAxq4kd/1Sa3+dY/FE8nQ6Wzr6+a5or97+3R68c495BZ3+/RBMOwzmngcLm5Ru3YDZL8xs3OfRqdLKrA6vWSCmBe6w4wdJAMGCIXQwUL6CBKVJH2vfWQCotGv0NvkkKBNMST7lNz0xEHKHfcjXMq/IU13u8VjiCGVDURMJotK82ou98Z9ndWb1N7QU2f0f/aeb2pd1KTTKNeVAES25e9ulroW9RnP9QlHS+GAwnIivLw6pZDnmMzz4Y0lZypSA/xDi78E+dnNS0yimqJQ2i/3JZgsgHwp25ro69pJ+iWsVz715GeHsAB1QXNqm/RoENzXwUpdOZBs/qZ/J2xGXY6ocph8vWGfdubT3+oL0kcfGmoDI0NlwSAD3CRYiQPRiV9FdtiI9FMr0TnPNlglWSwjv7vqhJH2/zRSOWkre7b7e44L/0Qvu2k6cuXkO/4k05dXtZVOwolfybKG0PSsciTKMfk79YvMpHsN4LqYOObLjlYqnZ+zerihm9F23U/yLedzAXMSDrkMAyD6fLYeY9WsexbVfHm4IKBpo8u01vpgIjPrg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5Ob6o//8Ls3SzB8/1pVqox1rK9Pu+rFgOYx7ZKbkJGqoxM7QXwA6jM8LlfLjkJRjh8hmaaiBdBQHW2ljgftH8AzTksLdIYkkZtz7ak/bSxsmOvMHUzH2TYYOWzwW7occ680jzHxmR5frURGNcyK0bHPg9fd7vkjHK7urfT7f2Bq2CRvyhCLu1ekv3hW3wvhAKD82B4ncwnjgoSm/1CM6xXSgT16DOnKXk1IL+FFLHaa8ahSy9PH02yb0PcIH1cbDd3Ji1tRhFAUr7pz1jh/NrEMpQXhkz8HbTCKAW5d0ncwtctVeIDezNCPqN7kLlA+/neKA6Tqlnoen3sKh1YyfRJeLZQ45z++pMVouJl0w0TA+GfbChzSNYRGN64uN4ircIgD/WlQP6FlomOg/XawSwot5m0iD8SGB1t+gPvPNnIxqr7AcO5O0Zi6SJ2KQ1leY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 09:36:07.7400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dccbe6-fc9f-49c1-74e3-08de7dbf4aad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
X-Rspamd-Queue-Id: 7AF6C2363EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17762-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Expose HW constant value in a shared header, to be used by core/EN
drivers.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 1 -
 include/linux/mlx5/device.h     | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 665323b90b64..ff56948597dd 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -51,7 +51,6 @@ enum {
 };
 
 #define MLX5_MR_CACHE_PERSISTENT_ENTRY_MIN_DESCS 4
-#define MLX5_UMR_ALIGN 2048
 
 static void
 create_mkey_callback(int status, struct mlx5_async_work *context);
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 25c6b42140b2..07a25f264292 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -293,6 +293,7 @@ enum {
 	MLX5_UMR_INLINE			= (1 << 7),
 };
 
+#define MLX5_UMR_ALIGN (2048)
 #define MLX5_UMR_FLEX_ALIGNMENT 0x40
 #define MLX5_UMR_MTT_NUM_ENTRIES_ALIGNMENT (MLX5_UMR_FLEX_ALIGNMENT / sizeof(struct mlx5_mtt))
 #define MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT (MLX5_UMR_FLEX_ALIGNMENT / sizeof(struct mlx5_klm))
-- 
2.44.0


