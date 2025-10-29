Return-Path: <linux-rdma+bounces-14124-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706A0C1BD7B
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 16:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795B26E84CA
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Oct 2025 15:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF4733F373;
	Wed, 29 Oct 2025 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OT8+Wxaa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010066.outbound.protection.outlook.com [40.93.198.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1971634F492;
	Wed, 29 Oct 2025 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752712; cv=fail; b=UhDEMuj1pbL4BAVOdHKSRAV+m49cFq7tMarNDEGl3+J5bjhoEFwMAKUvmX4BdQU99/Bd8AMLNE2aTT+xcC9c9nLwuf5yQf2Ukm4tqyhkLjWqdjGx4BdNXleayBeD6k5om5w65Bv3J3Qxv0/pZSb6cftpvHhAKXG5URurx5DM0Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752712; c=relaxed/simple;
	bh=uZBMLG9BajTNM4qJIPMs1sj3diaQshfvjvwUZ8iToc4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEKordNPQFJJ68Zl4+/XUJTs9OKl2Mz8KmjSXN7zNzXpdtRcUCd6QtCBG6PGYUlp+RsoGlGrLPisvZnfE7qbyyWzeTT4L76ydMm/Ft/JnI0KWHkoeZPdxWGiKWXVWiomETP/wRwBrGsfxFFOGt0oGQONAX7N5q86Bb36iRn8Al4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OT8+Wxaa; arc=fail smtp.client-ip=40.93.198.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueKH26lbdVAUnW1kV1G76Drncw0B52HTko/9DFplwNBX/0tLuHdxQp2LgaA7siIpsRRyqxPAGJ7etzCMqnyce/prgSbkPHDlD6+FCE0VjeSYH7Y1hkcf2ceCnp8g8QjD04Ee8JGQdNf1qaBMp6Uo9md1Pm15ojTtMIE9kaE7wJZYGnyi5TkLwM3ES2Ln/gR0lAImZu3fcD+QMxkoQq1iIkvAPNjB/NUtEi1+xZV5D6nnkMi0DxQe/DKtRVLzMo/iqW/oOhWFv3mRLPZIIbFEpgJAVYeUSinzWDYTbPxABcSBqsPyVZ6/BXJA76PKmDW9aXtEjWbD2A+memnhKRK8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+QzVj86aIknba7Wu10UbufhguRSw7Xf/GdgDC0dNow=;
 b=HeG6PeWcgiN6O49HiDQm8+ykVCitgBScP4D9esrnKjEs8D3jj7gnhmJbDZ0SNpMcfxvn0dwlVjk3Z94l61BAJe6xEVLHzDHriq9Ibn9qnWhDzN2G57XuULS9sH5DQr50vsF/hT1hHxKORoBEtOic+PrW5uZIH2GLOugZmDzVfDRdzL3iOz+YT4tIVqpaO3i8qzPqBmoeJKVo1WJddDxZHBU9w0p3dwMlIzNbb3/lk4DKlxqrCMuPitGA9/jzVgB3vzaviWfWcUd6QtWWLa6IpMblv0LnTsMQlvf0plZB3TymQq99UNGl/dEgs/hQv9qMS8lR8jsF4pf9/VOD9bIvVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+QzVj86aIknba7Wu10UbufhguRSw7Xf/GdgDC0dNow=;
 b=OT8+WxaasbzmtgOIcx96CyxMJmUAkizxIaG9XYyNm/PoYyGwHei1eWoyA70v7ab6KJACD3pzVlei2wJBbDWQMkNQw+xO05BqGauw2dQGF9FdBBKuypWFPb87bnVBBw1lUC/lzGt5w5VsKw9IJgPxCTGh1GSFquHGpiUMCIISIq3PmJ2Z4JdksjGh1Wkwx4cv0GmngOJs+pogylwubEjjiXAhf2zt7sFwlSKuxuBEcY5Y3DWK3lfogsBMz3WemKkVZgrqRKSip50TxGIdVzFLSgwjbf9cu8SwpyS2fIBTposRyohWniQ+LSs0hQjPWOQScftBqczZDz2tYsZ1czvb0g==
Received: from BN0PR04CA0035.namprd04.prod.outlook.com (2603:10b6:408:e8::10)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 15:45:00 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:e8:cafe::44) by BN0PR04CA0035.outlook.office365.com
 (2603:10b6:408:e8::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 15:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 15:45:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 29 Oct
 2025 08:44:44 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 08:44:43 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 29
 Oct 2025 08:44:38 -0700
From: Edward Srouji <edwards@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Edward Srouji <edwards@nvidia.com>
Subject: [PATCH rdma-next 6/7] RDMA/mlx5: Refactor _get_prio() function
Date: Wed, 29 Oct 2025 17:42:58 +0200
Message-ID: <20251029-support-other-eswitch-v1-6-98bb707b5d57@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20251029-support-other-eswitch-v1-0-98bb707b5d57@nvidia.com>
References: <20251029-support-other-eswitch-v1-0-98bb707b5d57@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5f8fac-953d-4e98-7e33-08de17021eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0VLczRYK3p5bjVLOXdxL09hc2FVdWNaYm8zWU9xdUZ5MmNqRHVmZXpOam0x?=
 =?utf-8?B?aGp6U0cwa3VOZXNhSFVkSDdpblAxTHB5T0wrQ3pCR1B6NHRtZTNIYWxTQWZy?=
 =?utf-8?B?R1d6SWwzdnkyVEI0MXpzZFFvSFJmVFQ5WWhiQkd6YXBybHZWRFJQNGlrb2M1?=
 =?utf-8?B?Qklpa0pnODZkcmd2OEV1dE1VaU9Za0p4RDVrSzQ0amlaZE9JR0ZYU2xmZTlL?=
 =?utf-8?B?dzQ3NFNPU3pFR0NDeWcvYTI3M3dzc3h2bXRzV1hPRldiYitxeWJZQ0ZOeWFD?=
 =?utf-8?B?OWhmWnFPaTRSQ1VFQVBaMlBWRHJwTkR5NW5vdmprN0pRcllUSzNXb2hYZDVx?=
 =?utf-8?B?a2h2dGhYS0ZoL2Ftb3FZYkdjV3BDSzM5dFF1cnQyQXJvZHVvSEhCZGZ0RCtv?=
 =?utf-8?B?Y2NVZ3N3K2s3RzJ2K1lMTnlXRE9BR3g4UTQ2OHlJeXlhVkJpMGhvS3BkTEhP?=
 =?utf-8?B?eVlmYzIvSE40L0kxVHBSVEdmZzRSSzRlRnp2QW5hTllSWCtFVGduaytOZ2RB?=
 =?utf-8?B?cTBLdGpPeFpwQVhGdFhCSmhwdkpsTVVORTd3MTJkNm82R1BzVDhGV3JPUWd3?=
 =?utf-8?B?MExaaWl0VHpQVEkycjRUUS9jeHI1YTl0OXhlbUtFVVpudE1pOFBYUlZ2WVBX?=
 =?utf-8?B?SjgxcnFuK1BBaWZUZi9EbWZ3ZmQvMS9QU2dydlFKWGRJYVdsK2YyZkUvbncz?=
 =?utf-8?B?N2ZheXNndkNtcG4xRjNCSEdJR0VDUlp4dkU5bFVid2FBOW50OTVLTlp0amZs?=
 =?utf-8?B?QU1VT054R1I3Wmhnb2pIN1VEdmdpeDBZUkRQeDgrVlFCNVhrRUJzZ1NwaWNF?=
 =?utf-8?B?bk9Ta2QrN2RCdXhiWEhJU2pha0JhU1J5ejF3THlWK0phNXJuZTJIWkNaOXJM?=
 =?utf-8?B?a1dPU05oSHYyVEorMEs5aitadkdwdmpEVVc0SitOTElxUDNGZGo3K3dUbWFu?=
 =?utf-8?B?dXovQ2JjNWN5azlXOE8zaTdrMml5WThBblVJUmdwenBTQmN5eWZyRzBtWFp1?=
 =?utf-8?B?M0NFOGNidGdJN2UwNkJrQlc4S2pON2tOT3VCeklkMDhBTHg4blNQUmZBOGUr?=
 =?utf-8?B?Zml4VmZtSGtURm53UkZISHU4b0hNYW93S0QzTENpVWFMQWtTbUpNdlVpSlJH?=
 =?utf-8?B?UUxkNzVNTzVDeHYvNE9Xb0JFRCtrR0MzNlNPVXZTTWZKbVVDQTE0VFhZUDhU?=
 =?utf-8?B?SEpFRkUvYXhsa0FVVGV4bmxib1FtK2ZreGVtSWxyRm1wUGZFUkdLTTFjbGJy?=
 =?utf-8?B?MjJocWFRUnNTYlhRTG90OHpsWFZxZUN1NmtpeE5EYmVqcUY5VGRrRHo3aEc0?=
 =?utf-8?B?TnZzRC9SNlZhMjdQcXpNSHBLUEJTNzdsWXF5cEF2QTc4d0l4cU5TZCtTZGd3?=
 =?utf-8?B?LzBya3Fxa1NuZmhwSFdITyswK2MwbUFCWUxOQlRuK2ZSWVpkSk1LS01vZHFt?=
 =?utf-8?B?cE1KRFQ1bzl5MmxKbnRCM3J1SzAwU1dLL2lDc0xRMWpoY2Jlekd0Z0VhdUpH?=
 =?utf-8?B?R2dvY0FuNVg3NEx1cWZMaXFSeVhHdFQybzV6MlM1blVEeTNiQVFtaXlld3hy?=
 =?utf-8?B?MmRnRHFpM25td3NIMjFoM0VZWjJjZTJzMk1DaGVTSm5VN0ZubllSQ01ZR0ov?=
 =?utf-8?B?dUlHVmRiNGZ2bktBaFJQQnEzdVZTbGJucDAzRlVOK295V2h4S0Z5cjN2M3ps?=
 =?utf-8?B?OWxrMGhtS0lBa2Jrd0dPRUVXYjdlWnJHTlZJNzc2L3dSMXJGQ2d4NE5YQmVy?=
 =?utf-8?B?anE1M1ljb2FxNU83R2t0TEhENHpUSmlQKzFuaTFROXNJb2ZPRWlhTklqK04y?=
 =?utf-8?B?V3V2b0VaWk5zWlpnNWdid3NiUUc3dW8vaEhPZ3JpRzNyR1ZwQlR5VVN0RnA4?=
 =?utf-8?B?dy9vdFl4NHM4S0Q2VUlQWGYzUUxOdGdZZFdJWktNb0pkenhUbzFmUHNYZXZR?=
 =?utf-8?B?ZUpDSUwrVFo4VEFhYzFlbFRBeVNOZ2QvRjFOYndPalpEUkhiczV5aHpFNEVV?=
 =?utf-8?B?dFVZWkQ5YXpoazd0ZVhDWjhJYXdXcU90MmhGaUVLWHBETGhIZDN5ZGJZU0lC?=
 =?utf-8?B?Q0E1VWpZRWFHMGZZaHo0YmZuYmc3V2hwaTNPemFLM0xoZmU3ZGpKYS9WQ0NK?=
 =?utf-8?Q?98iA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:45:00.3976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5f8fac-953d-4e98-7e33-08de17021eb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359

From: Patrisious Haddad <phaddad@nvidia.com>

Refactor the _get_prio() function to remove redundant arguments by
reusing the existing flow table attributes struct instead of passing
attributes separately. This improves code clarity and maintainability.

In addition allows downstream patch to add new parameter without
needing to change __get_prio() arguments.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/fs.c | 49 +++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index b0f7663c24c1..c8a25370aa79 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -691,22 +691,13 @@ static bool __maybe_unused mlx5_ib_shared_ft_allowed(struct ib_device *device)
 	return MLX5_CAP_GEN(dev->mdev, shared_object_to_user_object_allowed);
 }
 
-static struct mlx5_ib_flow_prio *_get_prio(struct mlx5_ib_dev *dev,
-					   struct mlx5_flow_namespace *ns,
+static struct mlx5_ib_flow_prio *_get_prio(struct mlx5_flow_namespace *ns,
 					   struct mlx5_ib_flow_prio *prio,
-					   int priority,
-					   int num_entries, int num_groups,
-					   u32 flags, u16 vport)
+					   struct mlx5_flow_table_attr *ft_attr)
 {
-	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_flow_table *ft;
 
-	ft_attr.prio = priority;
-	ft_attr.max_fte = num_entries;
-	ft_attr.flags = flags;
-	ft_attr.vport = vport;
-	ft_attr.autogroup.max_num_groups = num_groups;
-	ft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
+	ft = mlx5_create_auto_grouped_flow_table(ns, ft_attr);
 	if (IS_ERR(ft))
 		return ERR_CAST(ft);
 
@@ -720,6 +711,7 @@ static struct mlx5_ib_flow_prio *get_flow_table(struct mlx5_ib_dev *dev,
 						enum flow_table_type ft_type)
 {
 	bool dont_trap = flow_attr->flags & IB_FLOW_ATTR_FLAGS_DONT_TRAP;
+	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_flow_namespace *ns = NULL;
 	enum mlx5_flow_namespace_type fn_type;
 	struct mlx5_ib_flow_prio *prio;
@@ -797,11 +789,14 @@ static struct mlx5_ib_flow_prio *get_flow_table(struct mlx5_ib_dev *dev,
 	max_table_size = min_t(int, num_entries, max_table_size);
 
 	ft = prio->flow_table;
-	if (!ft)
-		return _get_prio(dev, ns, prio, priority, max_table_size,
-				 num_groups, flags, 0);
+	if (ft)
+		return prio;
 
-	return prio;
+	ft_attr.prio = priority;
+	ft_attr.max_fte = max_table_size;
+	ft_attr.flags = flags;
+	ft_attr.autogroup.max_num_groups = num_groups;
+	return _get_prio(ns, prio, &ft_attr);
 }
 
 enum {
@@ -950,6 +945,7 @@ static int get_per_qp_prio(struct mlx5_ib_dev *dev,
 			   enum mlx5_ib_optional_counter_type type)
 {
 	enum mlx5_ib_optional_counter_type per_qp_type;
+	struct mlx5_flow_table_attr ft_attr = {};
 	enum mlx5_flow_namespace_type fn_type;
 	struct mlx5_flow_namespace *ns;
 	struct mlx5_ib_flow_prio *prio;
@@ -1003,7 +999,10 @@ static int get_per_qp_prio(struct mlx5_ib_dev *dev,
 	if (prio->flow_table)
 		return 0;
 
-	prio = _get_prio(dev, ns, prio, priority, MLX5_FS_MAX_POOL_SIZE, 1, 0, 0);
+	ft_attr.prio = priority;
+	ft_attr.max_fte = MLX5_FS_MAX_POOL_SIZE;
+	ft_attr.autogroup.max_num_groups = 1;
+	prio = _get_prio(ns, prio, &ft_attr);
 	if (IS_ERR(prio))
 		return PTR_ERR(prio);
 
@@ -1223,6 +1222,7 @@ int mlx5_ib_fs_add_op_fc(struct mlx5_ib_dev *dev, u32 port_num,
 			 struct mlx5_ib_op_fc *opfc,
 			 enum mlx5_ib_optional_counter_type type)
 {
+	struct mlx5_flow_table_attr ft_attr = {};
 	enum mlx5_flow_namespace_type fn_type;
 	int priority, i, err, spec_num;
 	struct mlx5_flow_act flow_act = {};
@@ -1304,8 +1304,10 @@ int mlx5_ib_fs_add_op_fc(struct mlx5_ib_dev *dev, u32 port_num,
 		if (err)
 			goto free;
 
-		prio = _get_prio(dev, ns, prio, priority,
-				 dev->num_ports * MAX_OPFC_RULES, 1, 0, 0);
+		ft_attr.prio = priority;
+		ft_attr.max_fte = dev->num_ports * MAX_OPFC_RULES;
+		ft_attr.autogroup.max_num_groups = 1;
+		prio = _get_prio(ns, prio, &ft_attr);
 		if (IS_ERR(prio)) {
 			err = PTR_ERR(prio);
 			goto put_prio;
@@ -1903,6 +1905,7 @@ _get_flow_table(struct mlx5_ib_dev *dev, u16 user_priority,
 		bool mcast, u32 ib_port)
 {
 	struct mlx5_core_dev *ft_mdev = dev->mdev;
+	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_flow_namespace *ns = NULL;
 	struct mlx5_ib_flow_prio *prio = NULL;
 	int max_table_size = 0;
@@ -2026,8 +2029,12 @@ _get_flow_table(struct mlx5_ib_dev *dev, u16 user_priority,
 	if (prio->flow_table)
 		return prio;
 
-	return _get_prio(dev, ns, prio, priority, max_table_size,
-			 MLX5_FS_MAX_TYPES, flags, vport);
+	ft_attr.prio = priority;
+	ft_attr.max_fte = max_table_size;
+	ft_attr.flags = flags;
+	ft_attr.vport = vport;
+	ft_attr.autogroup.max_num_groups = MLX5_FS_MAX_TYPES;
+	return _get_prio(ns, prio, &ft_attr);
 }
 
 static struct mlx5_ib_flow_handler *

-- 
2.47.1

