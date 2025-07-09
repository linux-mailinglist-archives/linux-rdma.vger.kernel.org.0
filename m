Return-Path: <linux-rdma+bounces-12003-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E915AFE936
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 14:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE951C81972
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 12:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F7B2DECB4;
	Wed,  9 Jul 2025 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BT4BLa0/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F612DAFBA;
	Wed,  9 Jul 2025 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064970; cv=fail; b=foMvuPT5l+T0TF56zyBmV2LSitcklhAh53ujFp+cbcOh58q06k/bqaSlSbTz7y7fDT5ushhyZaU23S5l5I9fi38wDLuqAZFUEwRKgrwxt2R9/88ijoV92dFTTC6YtdfDIu2HU3Fw9rlna2tcebgyl0r2p9DHYQ70uBIq/XemNmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064970; c=relaxed/simple;
	bh=GKZNOVA172g6S4HTHcDlEoCX8QHz/7HbD2gvk2MSmH0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMTQFaOuxbD/l8MnDvdZWIOofNtG31anIcXC8faOtRPdxahBgFnau8JsZDY2MWkL5kGiuw20YqwdKNZ/dvWhOgPNPz/DwB7SNlHTl8GMLVVFElcNGOAwVEBN8Z9k9t+wj94jtlBeLQZGa1sNrCGgAWtpnEUF6VZaMPMPKY44wvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BT4BLa0/; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AU/kQVOj0x85dAv1e2Y9o22loNjbqAIIO4CngSSngem+jzo6IlrCKk6alhp2BQ3YncWO4Mb2zK/Dg3zITr0jOofeT4RgMigNf16a4Ws4IIPLNPEnXFbkoGliUQ9LBn/gWdsnXozsy/81gs8M4jPnf3aZxfrjUSm/vmym0kihFB4OJbXhGnfiapynGtd6JYrIZhQFz0sPVzH0l46JBz6P9y7KCuqrxzNdMvpWDxk16ZGXWM5FrvM/bpWEWXJ820xiTQ1J1bPhGYDJDz/tuABr3zDmKMZG/0uFQ0nsEaafN9/FWwo/a5X7lzGKiOMqkjU+aMNgJafgfy/8pekp24kjQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Z6KtQUHZ2prjCrgvM+UanEo4/Xte80VJ5dsxlToEM8=;
 b=Vn2fHp18fSO7DRadLAm0GuWY3wqr+3jGDBn3U7ZnJE9TuAp2F//11PdRKoob0XP2AAgYxFLxhVs0AiVLNsgqWT1WMno5WLvwfBKU8ffgYYPgMpWy5e9vTwZkIPpvXhMowsnoWyJdCsGNFg+EUNU9nzfVlAU9cOCM3Nr1W45n8LmdGanYz5EYnvKjXq+lZfSyLrEgrpphyUjX6AL085uXkbKVBgUBKlqd8xkPPEdpP2SEkuhFxo3+Ss/Zi4gZQPZ19Og7dbp5+QmGsoAmvD5FZrQFYmrnsYLUdDQmyKFREkEa61gXAM8s/zqvaX/QgUAWLhecBKPLZpQUYR2YbEF97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Z6KtQUHZ2prjCrgvM+UanEo4/Xte80VJ5dsxlToEM8=;
 b=BT4BLa0/57dHEeENjU9aP9poEm7YfQzUdTeSZZNU20X4Ixdc16zdVLGCURBtCvWobCTFLoz0NN8JiCbpbJyy5+IWW4k6UWxs15ayivLPzhajKmmqR6jC/WUeEVcaHsP9QpQRQ8db06Nr4lePHJsNlH0pSl8OBYZW2dKVxsrHF171Oo6gktBlcvTr1XJIMmIvP3kANnXNmCq2uGhPca57Fyh5Lcu0tKq9DGDjtR+xBFW7Ps1xGpA59RGKL33jRB73Pt1om+0Nd6SWiJu+qKzSfyiQTaEuw9kpUiBUMsL2/GeyJjuXB11MIbMBxeRkp2k3BfmzVBPeL4inarEy2JRkvA==
Received: from MN2PR22CA0013.namprd22.prod.outlook.com (2603:10b6:208:238::18)
 by SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 12:42:44 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::ad) by MN2PR22CA0013.outlook.office365.com
 (2603:10b6:208:238::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Wed,
 9 Jul 2025 12:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Wed, 9 Jul 2025 12:42:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 05:42:28 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Jul 2025 05:42:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 05:42:25 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Gal Pressman <gal@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH mlx5-next 1/2] net/mlx5: Expose disciplined_fr_counter through HCA capabilities in mlx5_ifc
Date: Wed, 9 Jul 2025 15:41:06 +0300
Message-ID: <1752064867-16874-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752064867-16874-1-git-send-email-tariqt@nvidia.com>
References: <1752064867-16874-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 81654a9b-b181-4a5d-a3fa-08ddbee619fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MldER3hxYTJJN2hSUk9KdFpHTEUzaWYrbWFUQytQcm04MmZvL0Z3aDZTekty?=
 =?utf-8?B?dVVVT3lwd3BTUkE4czVKczFSNWM2RFozNkU3ekhtbGFSMkVWZklCYXpBa0dG?=
 =?utf-8?B?ZXNiMGNzZGxOWC9wa3c3Wk02cUVTeGgyakRDNWxYWHl4cklvQXBNTmV0cVY1?=
 =?utf-8?B?Wk1oSE5iQmZsUEpSdDE4aDRsRGR2N1lheCtFNXh6ak9ZU1B6SHY2c1RzNmh0?=
 =?utf-8?B?VTNvTFo0dVNyMUNJVm84UGdITk0xQVNGcGxtUUFON2lSMUFoMXlHbVhPUFBj?=
 =?utf-8?B?Qk8wMEF0MlpQTVMzRmljSmpXMFE1THNDQVlTTkQvaVJraFJLbmVEbXdQT1dS?=
 =?utf-8?B?cURYZU1sVjdnT1Q1emF3NVlmL05EOVEwektNMXVhWWxLT1R2aEJGU2p2S25V?=
 =?utf-8?B?b1NMSmhrVlpoSGErSjlPTVQyK0d4ZDlhV0ZFN0ZTZTVVY3pEaVVNZEVMMmJZ?=
 =?utf-8?B?MHY5MzlTbnNQeTVKZzhQaFdEVm53WjhLRXJQYWNoNjl0eDUrZXZESlNUdVly?=
 =?utf-8?B?ck9ncnBiT3lOaXpHeXhKSEtJQ2lna0pKTGpyZ0FXWGxFamhTa1FmcExYd21W?=
 =?utf-8?B?YTNQTTBGRXh4NFF3MWJZbmo5OGhzNU5XamcrQ0pMR0RyM0lFQUlzM3VwU2xl?=
 =?utf-8?B?Zkszd2tZM0ZaRmtXdFdKdThlbE1SMVl4bGF0bHVpdmJpeHRQbmtab2ZwSm9p?=
 =?utf-8?B?a3Bzb0dJUXA1MGdHWUpQWm9BRzhHU05wL0tyNk8rWE1BMlZHdGs3UVV2TGMx?=
 =?utf-8?B?a2hUNDcxNWZyYmxBMGwwYklTYzhpaXRGZlZsemRCZjhmV3E2WkJJY2I0Q1RM?=
 =?utf-8?B?Q2hyM2JnSkdSYUNYS1NTZGxUWVRlN0NyOTJITHhuM1JNSGVwUDZYd3k4K0Vo?=
 =?utf-8?B?TE14M2w5TEV0cytFQitaRVkvWE9GUS9yeHN1Yk1Xc1gyVC9iNFhGZ3QyTTdD?=
 =?utf-8?B?RWFzU3Y1L1FCTTdrVFg4Nll3R2JPSVV6eVRCVktCTjNsK200MHpaQ2JOam1W?=
 =?utf-8?B?Q3dGWm5UakpLTC9kRnRkaWNLai9qKzgycDlIMURKVGlKd0QxdmNoQzBJWitu?=
 =?utf-8?B?WUU2d04vNlNLSVo5c0NVMkViTEZoMzFia001djJTM0R5SDRXa2psN1hFM2lF?=
 =?utf-8?B?UTBtV1RwT3ZYd2ZEWDVDcjRoeDZSNHdtU0krR1MrakpvUFI5UEQ4cVpMQzBY?=
 =?utf-8?B?ZHFQb0tPM0huY013LzJqaEhiZzJSS2I2QTBjSWxIc01Wb2dlTXU4V3ExNzJq?=
 =?utf-8?B?bVA4cDE0M2QyMUFqRFR4a0lJZGlrbWxLZjJyUC9FeVYwZ28zSCtlWExjMjdo?=
 =?utf-8?B?WXhtRnRnd2FwSXhUeHROUjhFcXBKMTV6eUJSUFBvL0diRW5DSkpWTkpaODNX?=
 =?utf-8?B?a0NKR3VTd1prSjdiOTRRWG03WHpMUVFqODN2eCthcUtNTzQ0Y2QwdmpqSWxF?=
 =?utf-8?B?d2tjOXNVZzlPaWlxZTRPK0ZRVUhJeTlzbSszeDJiOEt6enZpSWYrNUFLcitZ?=
 =?utf-8?B?dE1IRlk0VGY2SEt3VkRhKzFvelI1L1R3MGt1Ums2K0FkRUZGK1E5NjJZTlZo?=
 =?utf-8?B?WStGZUE4dENQTkFFYVhKeDhKb3RBdUI1KzJUQ2pwbTEydDYrbHFnZ1RmVkNv?=
 =?utf-8?B?bmRBQkZhWFpwYjMzWTBmbEpPZXV1ZDhhS2pRYWVzYndldDA3cEIzdW5iUUMw?=
 =?utf-8?B?L3I2M21Lbzc0ejc5aU1ld2JpWG1YZ09LWEowSHNCYzI0MWVkeDVSODJyUXlx?=
 =?utf-8?B?cmZwbTVLU1d3ak04cjRKWnRGSTVCUU9IbktkUE1VaW9ReDFWT3V4M09RdHA5?=
 =?utf-8?B?R1JPbkZyaEo3aHNrKzdkTEltTnlaQnRPb1NyYVJqVTNlTzBGL2RBd3A3YTJD?=
 =?utf-8?B?NDI3SDJmbmxaZFQyd0w3b1lQbjMwSEllZFVJdHBSRzVxeTZYYlNOTFRJOTl4?=
 =?utf-8?B?QkVGaHRmNmo1SERSV29TRThNR2Q2cStWc3paZ29laTFQcTRZS3hRYTBJNmRi?=
 =?utf-8?B?cUNFYzVUMjhTUklFcE9lRTllK0QyV0ZEb0p5amErMWk3cklvNWJ6VG1BYnUv?=
 =?utf-8?Q?hrsik/?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 12:42:44.3025
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81654a9b-b181-4a5d-a3fa-08ddbee619fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191

From: Carolina Jubran <cjubran@nvidia.com>

Introduce the `disciplined_fr_counter` capability bit to indicate that
the device’s free-running cycle counter is disciplined to real-time.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 0e93f342be09..e03fa6cd4509 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1846,7 +1846,8 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 
 	u8         log_bf_reg_size[0x5];
 
-	u8         reserved_at_270[0x3];
+	u8         disciplined_fr_counter[0x1];
+	u8         reserved_at_271[0x2];
 	u8	   qp_error_syndrome[0x1];
 	u8	   reserved_at_274[0x2];
 	u8         lag_dct[0x2];
-- 
2.31.1


