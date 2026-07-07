Return-Path: <linux-rdma+bounces-22828-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ILWIF7f8TGpLtAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22828-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:18:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C89F871BD02
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:18:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=EfL5kEGm;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22828-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22828-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CF3D30C2F8F
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 13:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943CE419316;
	Tue,  7 Jul 2026 13:11:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013026.outbound.protection.outlook.com [40.107.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80329416129;
	Tue,  7 Jul 2026 13:11:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429904; cv=fail; b=l6Nf60fJvkO+AUPWtrxRVczu9431pkAvTgx7+o6C8QlaA+EXV7MAsvzDB/amueg7tFtT9bKWpdUNbsQbaHTAEDz8+eGGVRRZ5F9FKn2fnUMBt/teNQyB8TdFlKjC5/sI0H0xg56+4sozUu71VSlbWQKg4pkA9WXSEMsIs+pHCh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429904; c=relaxed/simple;
	bh=zxUfNISE5g2w6WHYolirH44HjuUtsM+aCADhnQfNUGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NO+DPRGpmsiX7v7V4XUMyQDRU+N3jrIBEE8HiZOFmTKtt4BgWbbizgCF0yZZiBd1sJNvs12LvLzqNHnTJvesmufswH//Yc8gG670LvyifdgLUzbI2HWplwOyzz+zoiKz6NSfS/3GtlMIPRv91fDyuAYUaKaG4LUQr2r/nj+THh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EfL5kEGm; arc=fail smtp.client-ip=40.107.201.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+IeGo7bWnAHQ74MR43ACQo+2lz/u8HixW0Ugj/boKY1DcauPxgJ6XmQrcfjEnESfcebRJROtkqwxyJA9Of69vFliNXplLq3r05ffrHlf0ZBFuV3jgTfuq5Uab9tBdbPrMqmQ99geml/xNBiu5QZ+0Q1QX0tltC3tER+mqt9iwinTv1lo06HrOS7lZKOUQRnt5FByIvkw0q9JVgC7BPtL5ZB4S6ct8xQY6EBSpzaYBpHdWRKE8fyhBX0WgWVpgYuDvQU0eZwNePWhJ7vtt3xwALZpCGwmWnYNPwOSuQDanzcCYiMg8Jm1iLKZA0gsF+IjPfb2T+Zzkpan2NDTiAGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKci/p2oy3eQdI03DV3n3ahAPAH92CKFCpketS/b5/0=;
 b=jy9y23Wz0yih7gdip8xoTbFM5/OG+Hdw03vnXLHsSziWrhE4sMnKodV1UfsZC/Mhl/E09wIcFXr9AJFiisFFRv7cjVDnDSw4XsMSo9OVwFRlmWRpLKk8y+yXSCRJPMV/ONhQReI+xy7IVEP+7OdTq9K81UlLIhuZhXtokG+ZJMjqoISWY+07LPDkFvF/ITcRTOzKpB3H7kzqk02P8lX1T8+dmajVMnpnW0UclcHEM6LExj8kLwV/fGTqOnJVRDdLWLW8bttI3P1OlFW+9Erl1wheFysbRNhaou0gKYsQt8e9ZlEram589fpq5WInfV/W3pkFH/xAUUI6NgBFWCVd8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKci/p2oy3eQdI03DV3n3ahAPAH92CKFCpketS/b5/0=;
 b=EfL5kEGmf83Vsa/z1o25cYcpcfFo/Z61+SL2t0Uy5rACsnSdraVpN4GuCypqNWTaUxwFh+bABymrytJT8+zs2vfNdT2nb4gDAQSAFXBd/n/W5FHpTBn1ODFtaNqESLkQswPu8+g2G4vBcVdnaaCiZ2L3VUvTbVhEPW1ePG8qMtu0tSTZgYItspysOAaTR1JIQ9vD0edfTWfdEwGU/zdvQP+uY6MMSnPJOmALaBT7mMxWsyR3pPnVkislfhkKbRpLI719mHweqg5/Jctg6/ubXXzxWZ3hWRmlIr2+msCRPUVd9UJ9AoaETuv5aKzfaO+2ubrf7C8ZbcWK4/CGc2XCoA==
Received: from MW4PR03CA0137.namprd03.prod.outlook.com (2603:10b6:303:8c::22)
 by SJ2PR12MB9192.namprd12.prod.outlook.com (2603:10b6:a03:55d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 13:11:36 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::af) by MW4PR03CA0137.outlook.office365.com
 (2603:10b6:303:8c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 13:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Tue, 7 Jul 2026 13:11:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:11:17 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:11:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Jul
 2026 06:11:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Boris Pismenny
	<borisp@nvidia.com>, Chris Mi <cmi@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Jianbo Liu <jianbol@nvidia.com>, Lama Kayal
	<lkayal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Raed Salem <raeds@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Stanislav Fomichev <sdf.kernel@gmail.com>,
	"Tariq Toukan" <tariqt@nvidia.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next 10/15] net/mlx5e: psp: Add an RX steering table
Date: Tue, 7 Jul 2026 16:08:53 +0300
Message-ID: <20260707130858.969928-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260707130858.969928-1-tariqt@nvidia.com>
References: <20260707130858.969928-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|SJ2PR12MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: edd991c1-b584-4876-657d-08dedc2945ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|23010399003|1800799024|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Q5faA0UT8y3DVWwdMJrbjvNeaRmgoqh+bPPkluK5pjPhmdtPFTPn8/MMxwExftBT7QCx6vgDPaCSWorAliPW9KmTko8Y/j69CxtNd9bVV3gkdFpxrE+cuWjmNRaNgjRaaXwD5pZF8/xA+3W6aS8b1CihWFLF8SITlwaTNeI6OvTSLoU9ZOjg/Zb0GiJ1BCgqHUUNHseDMAIgeAe/gC2LPNAfeJ/5QWE7q4rt0KHTeXJSQi6tBNxHEtK1RTRbpwPWaFzQ0BmT7yL42F82hTdUQv4gOQIbg4B2W3ZWrdPO+jhetd6s8jJakLTWKLRUsPTmgqFh1ag46/rim8Ol/vn+ScNyBuVisQo+6o0+c+R0v2t/r+evGFqLtpYtsCyd+OQkbCxDwkiPmMgyhoLggJbJkSw+SYcaQw+uEb9VnhotOiX9G1vkFaZ8h8VWxGYZT0kwqIC988aYbcONhkJeBgqQPvPciE00Do31eS6aHK1RtDshR/YzqG5iKZSY2Ifv/najes0QIrSzNvMNDyNIlzjTcnGzxBMQHMM4Z75sjKGurjQ7PTS1I/HlMqLZf5WPoEumiueZjhDuAW8vZx1OwQeKDLleqQmkGRSzoQHQyhxhZxfJL2nQ10NE3lHikx2drqJgJfBBw8zB8gnD3qJzY4/p2BeawXBv55bWXEhvZqQMjZEqQlmncJEXijKrOJM7Q1/K
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(23010399003)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ydZnwXI1F/L1/+H0VLMh7+7lYvk7vGY54/Dj5N5MZmd354isEZa85YADjXkWTi8ZknSPSjNfzu9dYhWIxCDp09IY7r/9eJrU+ldwlDc5WVN/wB5P116cUB4caIMs8buSnc1jSBSx/J/zod5/TI72p65ruMHY1bqlKhGjs50orlPyl5BzvLSH8BYO3lGDDkTBjKLEv0/8aJNFT0GFLHkQ0eSqfedtK4Ef025U/hf/RQflaL0V999BkkazMEdEI6E8lQL9BVrwW/Tpke4DLUQ1Ho/Z5lKMr+IY2Di++fidYKJhHy0wUj0ZaI2rKcSV5e2+FvsQto9f+dWIXBMd2HQf7n2OHHvaWACllATKqGDBefmDQENOM8xQxOiUmbwYgZ0PFqmILworiuS7M8iYd9d1bB6tdi/HRJWx854IUuqYwcEaqE78bFFn9i3HUl6JZyPS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:11:35.8921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edd991c1-b584-4876-657d-08dedc2945ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:aleksandr.loktionov@intel.com,m:borisp@nvidia.com,m:cmi@nvidia.com,m:cratiu@nvidia.com,m:daniel.zahka@gmail.com,m:dtatulea@nvidia.com,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:jianbol@nvidia.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:raeds@nvidia.com,m:rrameshbabu@nvidia.com,m:saeedm@nvidia.com,m:sdf@fomichev.me,m:sdf.kernel@gmail.com,m:tariqt@nvidia.com,m:willemdebruijn.kernel@gmail.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:sdfkernel@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22828-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,nvidia.com,gmail.com,kernel.org,vger.kernel.org,fomichev.me];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C89F871BD02

From: Cosmin Ratiu <cratiu@nvidia.com>

Successfully decrypted PSP traffic is currently forwarded to the UDP
v4/v6 TTC default destination from its respective PSP rx_check table.

In preparation for flattening out RX steering and for decapsulation
support (which needs to handle non-UDP traffic as well), add an RX table
which directs traffic to either the UDP v4/v6 default TTC destinations,
or back to the TTC table itself for further processing. There can be no
loops as non-UDP traffic will not go through PSP processing again.

This is now used as a destination for successfully decrypted PSP
packets. The rx_counter is also incremented there, freeing the rx_check
rule for PSP_OK for atomic destination update in a future patch.

Use this opportunity to separate RX flow table levels from IPsec, as
reusing random IPsec ft levels as PSP isn't clear and now is a good
opportunity to separate them.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   7 +-
 .../mellanox/mlx5/core/en_accel/psp.c         | 149 +++++++++++++++---
 2 files changed, 136 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index 091b80a67189..4973fb473ff0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -88,13 +88,18 @@ enum {
 #ifdef CONFIG_MLX5_EN_ARFS
 	MLX5E_ARFS_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
 #endif
-#if defined(CONFIG_MLX5_EN_IPSEC) || defined(CONFIG_MLX5_EN_PSP)
+#if defined(CONFIG_MLX5_EN_IPSEC)
 	MLX5E_ACCEL_FS_ESP_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
 	MLX5E_ACCEL_FS_ESP_FT_ERR_LEVEL,
 	MLX5E_ACCEL_FS_POL_FT_LEVEL,
 	MLX5E_ACCEL_FS_POL_MISS_FT_LEVEL,
 	MLX5E_ACCEL_FS_ESP_FT_ROCE_LEVEL,
 #endif
+#if defined(CONFIG_MLX5_EN_PSP)
+	MLX5E_ACCEL_FS_PSP_FT_LEVEL = MLX5E_INNER_TTC_FT_LEVEL + 1,
+	MLX5E_ACCEL_FS_PSP_ERR_FT_LEVEL,
+	MLX5E_ACCEL_FS_PSP_RX_FT_LEVEL,
+#endif
 };
 
 struct mlx5e_flow_steering;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index f8b289c50a42..c45241025b16 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -43,7 +43,6 @@ struct mlx5e_psp_rx_decrypt_table {
 	struct mlx5_flow_group *miss_group;
 	struct mlx5_flow_handle *miss_rule;
 	struct mlx5_modify_hdr *rx_modify_hdr;
-	struct mlx5_flow_destination default_dest;
 	struct mlx5e_psp_rx_check_table check;
 	struct mlx5_flow_handle *rule;
 };
@@ -56,12 +55,21 @@ struct mlx5e_psp_rx {
 	struct mlx5_fc *rx_bad_counter;
 };
 
+struct mlx5e_psp_rx_table {
+	struct mlx5_flow_table *ft;
+	struct mlx5_flow_group *miss_group;
+	struct mlx5_flow_handle *miss_rule;
+	struct mlx5_flow_handle *udp_rules[ACCEL_FS_PSP_NUM_TYPES];
+};
+
 struct mlx5e_psp_fs {
 	struct mlx5_core_dev *mdev;
 	struct mlx5e_psp_tx_table *tx_fs;
 	/* Rx manage */
 	struct mlx5e_flow_steering *fs;
 	struct mlx5e_psp_rx *rx_fs;
+
+	struct mlx5e_psp_rx_table rx;
 };
 
 /* PSP RX flow steering */
@@ -158,6 +166,106 @@ static void accel_psp_fs_destroy_counter(struct mlx5_core_dev *dev,
 	}
 }
 
+static void accel_psp_fs_rx_ft_destroy(struct mlx5e_psp_rx_table *rx)
+{
+	int i;
+
+	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++)
+		accel_psp_fs_del_flow_rule(&rx->udp_rules[i]);
+	accel_psp_fs_del_flow_rule(&rx->miss_rule);
+	accel_psp_fs_destroy_flow_group(&rx->miss_group);
+	accel_psp_fs_destroy_ft(&rx->ft);
+}
+
+static int accel_psp_fs_rx_ft_create(struct mlx5e_psp_fs *fs,
+				     struct mlx5e_psp_rx_table *rx)
+{
+	struct mlx5_ttc_table *ttc = mlx5e_fs_get_ttc(fs->fs, false);
+	struct mlx5_flow_destination dest[2] = {};
+	struct mlx5_flow_table_attr ft_attr = {};
+	struct mlx5_core_dev *mdev = fs->mdev;
+	MLX5_DECLARE_FLOW_ACT(flow_act);
+	struct mlx5_flow_handle *rule;
+	struct mlx5_flow_spec *spec;
+	int i, err = 0;
+
+	spec = kzalloc_obj(*spec);
+	if (!spec)
+		return -ENOMEM;
+
+	ft_attr.max_fte = 1 + ACCEL_FS_PSP_NUM_TYPES;
+	ft_attr.level = MLX5E_ACCEL_FS_PSP_RX_FT_LEVEL;
+	ft_attr.prio = MLX5E_NIC_PRIO;
+	ft_attr.autogroup.num_reserved_entries = 1;
+	err = accel_psp_fs_create_ft(fs, &ft_attr, &rx->ft);
+	if (err) {
+		mlx5_core_err(mdev, "fail to create psp rx ft err=%d\n", err);
+		goto out_err;
+	}
+
+	err = accel_psp_fs_create_miss_group(rx->ft, &rx->miss_group);
+	if (err) {
+		mlx5_core_err(mdev, "fail to create psp rx miss_group err=%d\n",
+			      err);
+		goto out_err;
+	}
+
+	/* Add miss rule */
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
+		MLX5_FLOW_CONTEXT_ACTION_COUNT;
+	flow_act.flags = FLOW_ACT_IGNORE_FLOW_LEVEL;
+	dest[0].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+	dest[0].ft = mlx5_get_ttc_flow_table(ttc);
+	dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
+	dest[1].counter = fs->rx_fs->rx_counter;
+	rule = mlx5_add_flow_rules(rx->ft, NULL, &flow_act, dest, 2);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		mlx5_core_err(mdev, "fail to create psp rx rule, err=%d\n",
+			      err);
+		goto out_err;
+	}
+	rx->miss_rule = rule;
+
+	/* Add UDP v4/v6 rules */
+	spec->match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
+	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+			 outer_headers.ip_version);
+	MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, spec->match_criteria,
+			 ip_protocol);
+	MLX5_SET(fte_match_set_lyr_2_4, spec->match_value, ip_protocol,
+		 IPPROTO_UDP);
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
+		MLX5_FLOW_CONTEXT_ACTION_COUNT;
+	flow_act.flags = 0;
+	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
+		int version = i == ACCEL_FS_PSP4 ? 4 : 6;
+
+		MLX5_SET(fte_match_param, spec->match_value,
+			 outer_headers.ip_version, version);
+		dest[0] = mlx5_ttc_get_default_dest(ttc, fs_psp2tt(i));
+		dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
+		dest[1].counter = fs->rx_fs->rx_counter;
+		rule = mlx5_add_flow_rules(rx->ft, spec, &flow_act, dest,
+					   2);
+		if (IS_ERR(rule)) {
+			err = PTR_ERR(rule);
+			mlx5_core_err(mdev,
+				      "fail to create psp rx UDP%d rule err=%d\n",
+				      version, err);
+			goto out_err;
+		}
+		rx->udp_rules[i] = rule;
+	}
+	goto out_spec;
+
+out_err:
+	accel_psp_fs_rx_ft_destroy(rx);
+out_spec:
+	kvfree(spec);
+	return err;
+}
+
 static
 void accel_psp_fs_rx_check_ft_destroy(struct mlx5e_psp_fs *fs,
 				      struct mlx5e_psp_rx_check_table *check)
@@ -205,12 +313,11 @@ static int accel_psp_add_drop_rule(struct mlx5_flow_table *ft,
 
 static
 int accel_psp_fs_rx_check_ft_create(struct mlx5e_psp_fs *fs,
-				    struct mlx5e_psp_rx_decrypt_table *decrypt,
 				    struct mlx5e_psp_rx_check_table *check)
 {
 	struct mlx5_flow_table_attr ft_attr = {};
+	struct mlx5_flow_destination dest = {};
 	struct mlx5_core_dev *mdev = fs->mdev;
-	struct mlx5_flow_destination dest[2];
 	struct mlx5_flow_act flow_act = {};
 	struct mlx5_flow_handle *fte;
 	struct mlx5_flow_spec *spec;
@@ -223,7 +330,7 @@ int accel_psp_fs_rx_check_ft_create(struct mlx5e_psp_fs *fs,
 	ft_attr.max_fte = 4;
 	ft_attr.autogroup.num_reserved_entries = 1;
 	ft_attr.autogroup.max_num_groups = 2;
-	ft_attr.level = MLX5E_ACCEL_FS_ESP_FT_ERR_LEVEL;
+	ft_attr.level = MLX5E_ACCEL_FS_PSP_ERR_FT_LEVEL;
 	ft_attr.prio = MLX5E_NIC_PRIO;
 	err = accel_psp_fs_create_ft(fs, &ft_attr, &check->ft);
 	if (err) {
@@ -242,13 +349,10 @@ int accel_psp_fs_rx_check_ft_create(struct mlx5e_psp_fs *fs,
 
 	accel_psp_setup_syndrome_match(spec, PSP_OK);
 	/* create fte */
-	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
-			  MLX5_FLOW_CONTEXT_ACTION_COUNT;
-	dest[0].type = decrypt->default_dest.type;
-	dest[0].ft = decrypt->default_dest.ft;
-	dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dest[1].counter = fs->rx_fs->rx_counter;
-	fte = mlx5_add_flow_rules(check->ft, spec, &flow_act, dest, 2);
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+	dest.ft = fs->rx.ft;
+	fte = mlx5_add_flow_rules(check->ft, spec, &flow_act, &dest, 1);
 	if (IS_ERR(fte)) {
 		err = PTR_ERR(fte);
 		mlx5_core_err(mdev, "fail to add psp rx check ok rule err=%d\n",
@@ -330,7 +434,8 @@ static void setup_fte_udp_psp(struct mlx5_flow_spec *spec, u16 udp_port)
 
 static int
 accel_psp_fs_rx_decrypt_ft_create(struct mlx5e_psp_fs *fs,
-				  struct mlx5e_psp_rx_decrypt_table *decrypt)
+				  struct mlx5e_psp_rx_decrypt_table *decrypt,
+				  struct mlx5_flow_destination *default_dest)
 {
 	u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
 	struct mlx5_modify_hdr *modify_hdr = NULL;
@@ -348,7 +453,7 @@ accel_psp_fs_rx_decrypt_ft_create(struct mlx5e_psp_fs *fs,
 
 	/* Create FT */
 	ft_attr.max_fte = 2;
-	ft_attr.level = MLX5E_ACCEL_FS_ESP_FT_LEVEL;
+	ft_attr.level = MLX5E_ACCEL_FS_PSP_FT_LEVEL;
 	ft_attr.autogroup.num_reserved_entries = 1;
 	ft_attr.autogroup.max_num_groups = 1;
 	ft_attr.prio = MLX5E_NIC_PRIO;
@@ -370,8 +475,8 @@ accel_psp_fs_rx_decrypt_ft_create(struct mlx5e_psp_fs *fs,
 
 	/* Create miss rule */
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
-	rule = mlx5_add_flow_rules(decrypt->ft, spec, &flow_act,
-				   &decrypt->default_dest, 1);
+	rule = mlx5_add_flow_rules(decrypt->ft, spec, &flow_act, default_dest,
+				   1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
 		mlx5_core_err(mdev,
@@ -446,17 +551,17 @@ static int accel_psp_fs_rx_create(struct mlx5e_psp_fs *fs, enum accel_fs_psp_typ
 	struct mlx5_ttc_table *ttc = mlx5e_fs_get_ttc(fs->fs, false);
 	struct mlx5e_psp_rx_decrypt_table *decrypt;
 	struct mlx5e_psp_rx *rx_fs = fs->rx_fs;
+	struct mlx5_flow_destination dest = {};
 	int err;
 
 	decrypt = &rx_fs->decrypt[type];
-	decrypt->default_dest = mlx5_ttc_get_default_dest(ttc,
-							  fs_psp2tt(type));
 
-	err = accel_psp_fs_rx_check_ft_create(fs, decrypt, &decrypt->check);
+	err = accel_psp_fs_rx_check_ft_create(fs, &decrypt->check);
 	if (err)
 		return err;
 
-	err = accel_psp_fs_rx_decrypt_ft_create(fs, decrypt);
+	dest = mlx5_ttc_get_default_dest(ttc, fs_psp2tt(type));
+	err = accel_psp_fs_rx_decrypt_ft_create(fs, decrypt, &dest);
 	if (err)
 		goto out_err_ft;
 
@@ -549,6 +654,7 @@ void mlx5_accel_psp_fs_cleanup_rx_tables(struct mlx5e_priv *priv)
 		/* remove FT */
 		accel_psp_fs_rx_destroy(fs, i);
 	}
+	accel_psp_fs_rx_ft_destroy(&priv->psp->fs->rx);
 }
 
 int mlx5_accel_psp_fs_init_rx_tables(struct mlx5e_priv *priv)
@@ -563,6 +669,10 @@ int mlx5_accel_psp_fs_init_rx_tables(struct mlx5e_priv *priv)
 	fs = priv->psp->fs;
 	ttc = mlx5e_fs_get_ttc(fs->fs, false);
 
+	err = accel_psp_fs_rx_ft_create(fs, &fs->rx);
+	if (err)
+		return err;
+
 	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
 		struct mlx5e_psp_rx_decrypt_table *decrypt;
 		struct mlx5_flow_destination dest = {};
@@ -586,6 +696,7 @@ int mlx5_accel_psp_fs_init_rx_tables(struct mlx5e_priv *priv)
 		mlx5_ttc_fwd_default_dest(ttc, fs_psp2tt(i));
 		accel_psp_fs_rx_destroy(fs, i);
 	}
+	accel_psp_fs_rx_ft_destroy(&fs->rx);
 
 	return err;
 }
-- 
2.44.0


