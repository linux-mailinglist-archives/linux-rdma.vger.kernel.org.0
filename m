Return-Path: <linux-rdma+bounces-22821-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IZMxFCP7TGrTswEAu9opvQ
	(envelope-from <linux-rdma+bounces-22821-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:12:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A71071BB96
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:12:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Df6aw+qr;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22821-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22821-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3E99302E980
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 13:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CA2414A3A;
	Tue,  7 Jul 2026 13:10:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A57941612A;
	Tue,  7 Jul 2026 13:10:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429856; cv=fail; b=aeCGjfscUvf8+RxaAl2DHLgrr7lkXOtvoZiDKcFDeCSe+mk1n6NRFXTMKvelJxfvAmd7eIarMiVu0X/dX4YdygXGIvvyN/kMpgbamIE+C3h1FMIs/hjIhk3pgw55njyfHshxXgw8h1yhDxuPxPSxYxxivDaJ2LhfcC3rUnxourU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429856; c=relaxed/simple;
	bh=1IRBONkOd58wtl9j2VInIMOuLYHgQ5RN2eMl1Jou5cE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tiUuWDu/bViD8uAcMftK0zGY/q2YA476uCqEOKtEw+yTRFaUF15Aq7IDIzXRe4/pjhZJ5mq58cXcWyktEP4U/mpLYt5lqofWlxU1EnyvhE3WonheXeW7Tow222q6dWPdnSbv+hzJNEx9DWgtb2Zkaom5fVYJpDc6hUxe8X+YPho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Df6aw+qr; arc=fail smtp.client-ip=52.101.201.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkVSc+LGS9OoZFNNn9CsSTBWjWm5JmqaSmvW/DoOX40h2+UnY04F0DOUdfOgFVYViTqHNQnYRpw2ekdA9sJRILz1QisTBZxlCdWXu2XqQ5jvYwREcamouGmax9IYs9RnyV8IrCR/k6LM1y3y4H+OBRa9lIze5lkaz7QIQyU56MD3M7Gn+qeyNOmuR19N5pzPvGoF92EAHGyVjSoHujgmKaCowgRTWwYMoociT5/syHBIh+GGASNfHLwCB3kB5jbFe8CCFiK3bfQpVYlwC4A61TcYT4mnCk/CeXJFr6sNsqA2yDiSfTPQCy2+vb0mV8RFFPVj3wbKzi3OyxaCPWGssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJYHaL0lJwHr55Sc11BNjjUDmfn0EDKDe82t1pWF1x4=;
 b=xI9IX2PLfJb4u071tAvMN1H1FpE17Bu+h0cIXDBGaujoV20LGWZaGkTLCCD7msYoF/ibn8otU70NkqyRzsYp7PlzG85+ftGwFiYMyNTxSrzt4dqbP7qI8Y6lGQ87RQwO5rmPBttLvBc0JSpZupljBD2h0p235JhASFzF6S8viSLB/aGB1mpP5Jo/ETU3XRKfYQatpUS0hDUV8VzFqIVv7/xaxgkh1YnrDQzhTHdfxECH4R3EFELZJBj4kX5328GOVRk5kLW7/rN7EI4eYhbOjFjYvwZMBZCmU39qVC1ohYj+QevSP1v+e5ZpvBV46XWu7z8EUDAC3pY+VaqW+6Jr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJYHaL0lJwHr55Sc11BNjjUDmfn0EDKDe82t1pWF1x4=;
 b=Df6aw+qrCH6EQf9K7xDp2/WEYdm+ybDe3rE+yZJ3SDimk15Dei6G3GYJCa/UIP2GODJERoqy3omQD2cNOwT78pvJkHGptPVN2EVd5Hbn5oOs8UaS6xbIcnfrsdbPOW+Q1jhevHvuRmTJt6OAlX9ZHRRBQ9Am5YZFWqrknQZLk0KTx8TLTAmYp7nB+YcFOFWG0ERzIJXpLs7BGMkeQfCmFWRdywHGDSulEvH+r8OdQxDY0lgzP5zE81uEsPHw4yd4KvyJiLHVoNV8TLjd1Oqt3z9mu0WPghAcZGjpg1zkgCYMYdU+COgSRg304R9jpjWf8bB9m9NK8i3ZziG+iPltww==
Received: from DSZP220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::12) by
 DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Tue, 7 Jul 2026 13:10:41 +0000
Received: from DS2PEPF000061C2.namprd02.prod.outlook.com
 (2603:10b6:5:280:cafe::64) by DSZP220CA0005.outlook.office365.com
 (2603:10b6:5:280::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 13:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C2.mail.protection.outlook.com (10.167.23.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 13:10:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:10:20 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:10:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Jul
 2026 06:10:13 -0700
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
Subject: [PATCH net-next 02/15] net/mlx5e: psp: Remove PSP steering mutexes
Date: Tue, 7 Jul 2026 16:08:45 +0300
Message-ID: <20260707130858.969928-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C2:EE_|DM4PR12MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0a7c4e-3dfb-4c79-1713-08dedc292522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|82310400026|36860700016|18002099003|22082099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	xS31V8dxSueFk2DN6uG2A3ZOPHI6Jvgq/n4DRFNWpVSfjTjzQuzH9CRpP0BsfCx1hNC0oTH6SFSPPC6jyWL9sLfbA9hxac6tHVyjC8GaZR4EmEnD1TpL6sU33PyhifYxrcgKa9aiPAydy9+T+FfFj7rnonzULyLTJpeoFALjHtrO5aPTE6wL+YbgN7j3Tij+szknzNb72B0zoJGCwrN36XR8O5E60mfmWxYfSAiRVbvAwLvdUWvu1RJrsuU7CE5LeICWOyyl4ufTP3pETdlPEcRoByyO6LBKvPZfR5DAoTz9E50kuNqauD24ZuOS5ipp5aarC4oUL40+f5OM6jFEI5wx6N6mYobRq8SOfjtVHPoo4h1tIGIH9hsKEp30LIGkXHfVWIiMbpkJDlzbIoY7cmn2uKakb1PJZOy2/rWW7z1FlE9ObmyLz/r1nxYxD4bAFuxCQaKIr2Z6bzKtwVQLTMyZ4Sju8IjqOhmFldno7SOC4qguwDIt5LePD12m/NRcYrdPGpcy12aiED2PRfjSZl3hfi9ZBdFdYzWQZD1aG/Plfp1yNprqRqAUxEUTTy45C0Z6aYDO5qBh1lJpdL7iE/0aPb9A0XXjFFldWd8v27vQ3W8gEn+tKYDVJuX0qaHg3yA8ba26nTfeTXmbavgf12Z1AwkCVYnyoobkuSZRNIt2Jrxvx2dbma3OKDpNF0b+cFl09QyF6B1heBKSdhkwrw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(18002099003)(22082099003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hw/+s0U20hf2Y9Xk6f1hQnDcjUTv+mYVolTDgmU9+pFcIFwftnllqsaSnbHoEZecrX6GJQqKP3DH+eNWEBnCsnDmENPMRrzmCcq6v/Qg6ukCzDDJvXglhO8nqTnXUv2du4Sq19SvoUXCSUTP5jSCvO4vJydgB/Vs6OLN8StPUE4UBvPSKg/zUbOsoAHEuXP99+YlNitpObeqFbxnBYDt9KaX9FToWA5PZNm33fqJgMrLEmpEWXPaOWJg4nRWhQ47RK1R47t74B/+vyr1H+p2ErE8TH1EHVm9TmfpYiZ8IF/hFChgJh2NuAMrmCkyieywGsFzkLf8aWdTpSLFMSswoBappOFU2CcUEa4DKY44F11ZR4YutPPutt0+B2K/L8wabnwI2lEDs7b3YswVHegBpbhQKD3eiQQFlt1L9iwKq9i4OabQCEl0l89Pw6Muv+jI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:10:40.6460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0a7c4e-3dfb-4c79-1713-08dedc292522
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:aleksandr.loktionov@intel.com,m:borisp@nvidia.com,m:cmi@nvidia.com,m:cratiu@nvidia.com,m:daniel.zahka@gmail.com,m:dtatulea@nvidia.com,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:jianbol@nvidia.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:raeds@nvidia.com,m:rrameshbabu@nvidia.com,m:saeedm@nvidia.com,m:sdf@fomichev.me,m:sdf.kernel@gmail.com,m:tariqt@nvidia.com,m:willemdebruijn.kernel@gmail.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:sdfkernel@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22821-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A71071BB96

From: Cosmin Ratiu <cratiu@nvidia.com>

PSP steering uses three mutexes to serialize steering rule init/cleanup.
But init/cleanup are already serialized with the higher level devlink
lock (for both device init and esw mode changes), so there's no need for
multiple additional mutexes.

Remove them to make room for the new changes.
Later in the series, the netdev lock will be used to serialize PSP
steering changes from multiple sources, so don't bother adding
assertions now only for them to be overwritten later.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/psp.c         | 43 +++----------------
 1 file changed, 7 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index 4f2fa6756b82..d4686b5af776 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -26,7 +26,6 @@ struct mlx5e_psp_tx {
 	struct mlx5_flow_table *ft;
 	struct mlx5_flow_group *fg;
 	struct mlx5_flow_handle *rule;
-	struct mutex mutex; /* Protect PSP TX steering */
 	u32 refcnt;
 	struct mlx5_fc *tx_counter;
 };
@@ -48,7 +47,6 @@ struct mlx5e_accel_fs_psp_prot {
 	struct mlx5_flow_destination default_dest;
 	struct mlx5e_psp_rx_err rx_err;
 	u32 refcnt;
-	struct mutex prot_mutex; /* protect ESP4/ESP6 protocol */
 	struct mlx5_flow_handle *def_rule;
 };
 
@@ -485,15 +483,14 @@ static int accel_psp_fs_rx_ft_get(struct mlx5e_psp_fs *fs, enum accel_fs_psp_typ
 	ttc = mlx5e_fs_get_ttc(fs->fs, false);
 	accel_psp = fs->rx_fs;
 	fs_prot = &accel_psp->fs_prot[type];
-	mutex_lock(&fs_prot->prot_mutex);
 	if (fs_prot->refcnt++)
-		goto out;
+		return 0;
 
 	/* create FT */
 	err = accel_psp_fs_rx_create(fs, type);
 	if (err) {
 		fs_prot->refcnt--;
-		goto out;
+		return err;
 	}
 
 	/* connect */
@@ -501,9 +498,7 @@ static int accel_psp_fs_rx_ft_get(struct mlx5e_psp_fs *fs, enum accel_fs_psp_typ
 	dest.ft = fs_prot->ft;
 	mlx5_ttc_fwd_dest(ttc, fs_psp2tt(type), &dest);
 
-out:
-	mutex_unlock(&fs_prot->prot_mutex);
-	return err;
+	return 0;
 }
 
 static void accel_psp_fs_rx_ft_put(struct mlx5e_psp_fs *fs, enum accel_fs_psp_type type)
@@ -514,18 +509,14 @@ static void accel_psp_fs_rx_ft_put(struct mlx5e_psp_fs *fs, enum accel_fs_psp_ty
 
 	accel_psp = fs->rx_fs;
 	fs_prot = &accel_psp->fs_prot[type];
-	mutex_lock(&fs_prot->prot_mutex);
 	if (--fs_prot->refcnt)
-		goto out;
+		return;
 
 	/* disconnect */
 	mlx5_ttc_fwd_default_dest(ttc, fs_psp2tt(type));
 
 	/* remove FT */
 	accel_psp_fs_rx_destroy(fs, type);
-
-out:
-	mutex_unlock(&fs_prot->prot_mutex);
 }
 
 static void accel_psp_fs_cleanup_rx(struct mlx5e_psp_fs *fs)
@@ -544,7 +535,6 @@ static void accel_psp_fs_cleanup_rx(struct mlx5e_psp_fs *fs)
 	mlx5_fc_destroy(fs->mdev, accel_psp->rx_counter);
 	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
 		fs_prot = &accel_psp->fs_prot[i];
-		mutex_destroy(&fs_prot->prot_mutex);
 		WARN_ON(fs_prot->refcnt);
 	}
 	kfree(fs->rx_fs);
@@ -553,22 +543,15 @@ static void accel_psp_fs_cleanup_rx(struct mlx5e_psp_fs *fs)
 
 static int accel_psp_fs_init_rx(struct mlx5e_psp_fs *fs)
 {
-	struct mlx5e_accel_fs_psp_prot *fs_prot;
 	struct mlx5e_accel_fs_psp *accel_psp;
 	struct mlx5_core_dev *mdev = fs->mdev;
 	struct mlx5_fc *flow_counter;
-	enum accel_fs_psp_type i;
 	int err;
 
 	accel_psp = kzalloc_obj(*accel_psp);
 	if (!accel_psp)
 		return -ENOMEM;
 
-	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
-		fs_prot = &accel_psp->fs_prot[i];
-		mutex_init(&fs_prot->prot_mutex);
-	}
-
 	flow_counter = mlx5_fc_create(mdev, false);
 	if (IS_ERR(flow_counter)) {
 		mlx5_core_warn(mdev,
@@ -623,10 +606,6 @@ static int accel_psp_fs_init_rx(struct mlx5e_psp_fs *fs)
 	mlx5_fc_destroy(mdev, accel_psp->rx_counter);
 	accel_psp->rx_counter = NULL;
 out_err:
-	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
-		fs_prot = &accel_psp->fs_prot[i];
-		mutex_destroy(&fs_prot->prot_mutex);
-	}
 	kfree(accel_psp);
 	fs->rx_fs = NULL;
 
@@ -763,17 +742,14 @@ static void accel_psp_fs_tx_destroy(struct mlx5e_psp_tx *tx_fs)
 static int accel_psp_fs_tx_ft_get(struct mlx5e_psp_fs *fs)
 {
 	struct mlx5e_psp_tx *tx_fs = fs->tx_fs;
-	int err = 0;
+	int err;
 
-	mutex_lock(&tx_fs->mutex);
 	if (tx_fs->refcnt++)
-		goto out;
+		return 0;
 
 	err = accel_psp_fs_tx_create_ft_table(fs);
 	if (err)
 		tx_fs->refcnt--;
-out:
-	mutex_unlock(&tx_fs->mutex);
 	return err;
 }
 
@@ -781,13 +757,10 @@ static void accel_psp_fs_tx_ft_put(struct mlx5e_psp_fs *fs)
 {
 	struct mlx5e_psp_tx *tx_fs = fs->tx_fs;
 
-	mutex_lock(&tx_fs->mutex);
 	if (--tx_fs->refcnt)
-		goto out;
+		return;
 
 	accel_psp_fs_tx_destroy(tx_fs);
-out:
-	mutex_unlock(&tx_fs->mutex);
 }
 
 static void accel_psp_fs_cleanup_tx(struct mlx5e_psp_fs *fs)
@@ -798,7 +771,6 @@ static void accel_psp_fs_cleanup_tx(struct mlx5e_psp_fs *fs)
 		return;
 
 	mlx5_fc_destroy(fs->mdev, tx_fs->tx_counter);
-	mutex_destroy(&tx_fs->mutex);
 	WARN_ON(tx_fs->refcnt);
 	kfree(tx_fs);
 	fs->tx_fs = NULL;
@@ -828,7 +800,6 @@ static int accel_psp_fs_init_tx(struct mlx5e_psp_fs *fs)
 		return PTR_ERR(flow_counter);
 	}
 	tx_fs->tx_counter = flow_counter;
-	mutex_init(&tx_fs->mutex);
 	tx_fs->ns = ns;
 	fs->tx_fs = tx_fs;
 	return 0;
-- 
2.44.0


