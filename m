Return-Path: <linux-rdma+bounces-15077-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A88CCCE84
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 18:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBC1D300F9F1
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 16:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93853624B0;
	Thu, 18 Dec 2025 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pDL6wKKP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F943624A0;
	Thu, 18 Dec 2025 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073518; cv=fail; b=L+K+gCHK0jhB1UskkgLccsmeeZcHeib63AS1tnx4Os/f4W+AIA9bjmuA+m/U8ksZIodLS+eZ0TzYqdOcWBuxxFzwDP79daHrhzLAYRVAG2rcfwBK0le/vWb6O+l4oVlInIU7OAWy+CZB+I+Pe20zdYltnZNaUb5uk5ep3s0NsC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073518; c=relaxed/simple;
	bh=WScf8tUkM2zmOCWelsIRqkwU88CYtVaHUtZgMy8aKh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwt8ONMbYcszMsaBZVAApynsnwGOCX8DkHJVGGV89XuhOMicFjiqiO/XooASqFQR+fdBGM9bshDs9hLjts9SXKKCJ1FLfJqLJKfgu0/C6N/2rFL0kR5RcybNU+RB6jwzrZXWuD9pABmLtvcTUSIB4AHtbKueE3sG5LfZw7rdR6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pDL6wKKP; arc=fail smtp.client-ip=40.93.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=al7hbsx2Ehn9b2ix/4s+BqxmMNv3CIJp0ylQnt9kQXptCpkPrfr9blSqUwxY5SSux/8I2V8NrVh3rMRQz/PaEklwNMazGt9PnEcfW8dyE7SeZaknVhwflNvg2PpXAaScM6TGuXZpJ77xTdEwW80EiUjpcUutaRUlrF1Ji7k5zkQ59E7r6upJXURWScAU+DK66HoOIq7FOCbQVJE0kHdlXLnp5pTWIhk/u6Os2guCjl/WcQd5YRyUdkndMoEw+b+aDNdJIMvvqf1Qi98XOaE/MwbK7+yVEKFdvCRfEWrBq9+DSzaBT8Q5aFM4I55KHSnB4EelVQjfLNEbW1FOcdyc4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKKuINPKcaoEY+Da/zo1Mg9DifAeD5jaZaEVMKgoYO0=;
 b=GmgDxsW1RiKcD4TRTXvt3sjrfOBNCEwjjKVMTnWz3bNJB/aFcbn6XjAikhuCAiMTtbdaYLs3XIvdSwjKuVkxjHGBzVlwUKn0mLllVq//XEBwu//E+WnSFXrZ9xAW0kv7D145gC/8gcQL6EbJwTcfnuUffnWChgRZfW4huqM4MNnBTA3iUuPWhc0I7xwg09XXDRL+d1FL93tvYFKEzMSDAlOvEH9GIvo13yi5cF5eRkOsOX6zP61/Fm9qpU7t4kbQ1HC1TAtqTq8a47zAcriBWiGSItJYUh/C7r144hoGPEsogSU9LW7nqBgr69MWk0x+xLL2mWfNrnIVJN6GYMWPgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKKuINPKcaoEY+Da/zo1Mg9DifAeD5jaZaEVMKgoYO0=;
 b=pDL6wKKPoi9drZqOMlGt07760Rd1ViRP0+v5qVGeIl+yA+IUt7HFlkoFv/11BtSOKywfG8PAzG1qoX1NHTxrP4jHN1w+Rfi1vDJfeT5k3d3hsvyRgc+T5O2GkDwhw5R1K6tQYcFM3j97UO6XMOZSOVr37StNGJ227fwoeVy9f6Bh2kGHGvjTizz7oTPgEI+iayVGg4IKBM1O+JlHd9d18eTfnloM8pQOrR76yo3ZxrQDmeqXd25YdbtzLEnQzG4JSDQUe6qZvFxobfBXRmEpLEWkoCrtqhdggKHM4TbkUTb9wmpOAnwy0mDWBj5sKhGZYGZhsiEIDowraGWf1GPKug==
Received: from CH0PR03CA0408.namprd03.prod.outlook.com (2603:10b6:610:11b::9)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 15:58:29 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::f5) by CH0PR03CA0408.outlook.office365.com
 (2603:10b6:610:11b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Thu,
 18 Dec 2025 15:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 15:58:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 07:58:10 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 07:58:04 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 18
 Dec 2025 07:57:59 -0800
From: Edward Srouji <edwards@nvidia.com>
To: <edwards@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe
	<jgg@ziepe.ca>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Or Har-Toov <ohartoov@nvidia.com>, "Maher
 Sanalla" <msanalla@nvidia.com>
Subject: [PATCH mlx5-next 01/10] net/mlx5: Add max_tx_speed and its CAP bit  to IFC
Date: Thu, 18 Dec 2025 17:57:58 +0200
Message-ID: <20251218-vf-bw-lag-mode-v1-1-7d8ed4368bea@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251218-vf-bw-lag-mode-v1-0-7d8ed4368bea@nvidia.com>
References: <20251218-vf-bw-lag-mode-v1-0-7d8ed4368bea@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766069544; l=1802;  i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;  bh=iH5nuDomUtx+sOM/Yu+qaoqkSr0LjVit6hNEIXO0yVI=;  b=DZaNilmLJ8CwUNA9a65h8Rm2hpGsmG+Sv7Bc7wWR3gdXZ1dDWbN/9GJgfocW6aSZSrnApfxBE  Ih4oYBv1FH+AHmOSAPJa6Z5Kdt1f5BT4DXHg8sHelQ1+AKeT1YZTRpq
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;  pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
Content-Transfer-Encoding: quoted-printable
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ffac22-64c0-477e-210a-08de3e4e496f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjBMQUdEK3VHUXhKeDdCTjlsQ0diWkRCWCtoL3AxLzF0WTROOXNTenBPbktE?=
 =?utf-8?B?M2NlckkySi9QR3NlUWQvQVRuaHE3SzNQS2ZTbUhtVmUxbzFSbm05NzJhRFRD?=
 =?utf-8?B?S2x5ZitUMENUS1hnMWFNMytoNk1Ed2lGVHlFa1J0RUwybUlnMjRzVGEwbmJi?=
 =?utf-8?B?cWZXc2MwRzBaalVqMThNamhFd1BJY1VKTU90UEdEcGM0N1JERXJwOEZQRDlr?=
 =?utf-8?B?SHh1UVlqc2ovaVB4YXVwMzFydzRhVG5SQjE2M0Q3MmtkYys1cElIOENMdjFO?=
 =?utf-8?B?bmFsVXFXQ0dkU3E3b2UxN1JaMEdFbEwwamsrcHdWdjRWaldla2g1YzFaREdX?=
 =?utf-8?B?bzhIZENzTXk2YVZPakgwNHQrUjdFWm5wbmtUZTNyNjFoME5SREFJWEN6NDlq?=
 =?utf-8?B?T2VBRUFRQWxDdVBJU1hYU1FDY1I3L2VPSUJFTStCZDVGKzhyUTFNa0RqdlFO?=
 =?utf-8?B?MDlXcFE3Y2krVVk5S0hFdlIvUjZSdVdwdmcyNXNYeUZyMm55QW5iczlQTW1U?=
 =?utf-8?B?anVLQk1xZ0tUbTBqZXVSam9jWGZzaVljSE41WTh3TVYydnFHKy9QcGtNdUEw?=
 =?utf-8?B?WVZSQ3JLM1NCZ0NtcWN5ZU5yMlBuT29EVTE2dXFwdk5IdlNnZ3BadktHS21t?=
 =?utf-8?B?MUdxeGJ1RXFSUTZ0SkZrdkV0RW4yclo0R0VWNlpybExBcHBPM2NzZnNPeE1D?=
 =?utf-8?B?N2pQQzNBUkk5Q3VlQkgwQms4NjJPTHdUQitKNVFNdmduN2xEM21TenFSYjBL?=
 =?utf-8?B?eW5zVkVhTkU0U3lISXlodFVCYnZzaTN3SFREVUxKNFBjbXhuT3JRdDF4RjVR?=
 =?utf-8?B?N0VDV2c1U293Y0h2MldCa1l4RkI2OE1JZUovNUwvemlNd2tTdlY0WGVhZ0Ur?=
 =?utf-8?B?LzBFcCtmcThXNXhrSDd1enZTeERCWE1BKzk1S1hCdjk5TUFkaldlTlF6OVc4?=
 =?utf-8?B?MFE5Rk5SUnVZcnpIakZ4dFZyakpBdmVhTEkxVjhoRmpMU1Q4dmYya3lzbGpn?=
 =?utf-8?B?UVNPc21YR3lUWHFUeHFJcHVOb24rMTVkelFTazYxQ2ZmT2dyWndQUUhuMnNW?=
 =?utf-8?B?eEZid3gxZG05MWZTRVRCNGhSckpOUndBNmpvZnZkbHZ6Uk9xM3VyVnNMZWUx?=
 =?utf-8?B?a21TZkpENkVIbTYzZ25RekpVMkVIaWFudlA1Y1dvU1l3cmtXMG81Y0NTT2FD?=
 =?utf-8?B?VGhvWHVIV0svYzNKbUxjck8wUjcvdFZLVnZycDM3M213NWZ6QTArbHllakpC?=
 =?utf-8?B?Tis3aW03ejJ0bEF6aVo1c1liaUZSbXVEVVRiZmNCUmdrREJBbDh2Q3VDdXh3?=
 =?utf-8?B?dUt6RGdjbFFrTDcvZXpVZXQxek9CVk1lOUdTTlJUdEJMQTJpQzJybkZQMzRY?=
 =?utf-8?B?YXVGVHh3dC9QQ05BVEVFV3VuSlF2U3lEVUNWNGFrM0RBdmRhTXpmSmErS003?=
 =?utf-8?B?WnJYTVVNWWoxL3BvNUtmaTl2a2VSZkNIdXlWdjJJeTZWMzVvM2traUloRnVZ?=
 =?utf-8?B?N1FnUUZaMkp0LzdaRnZRR3cwckpEbkVJUmg2WndrZ2hDMjdyS2pDQ1RWUjB1?=
 =?utf-8?B?aWtLL1kxTEl0bFZveEdFM3BhNjFxUFZsSWxpVnQ5TlJRcEVXc3FnRFN4OEVE?=
 =?utf-8?B?YkxjdytCVW9IQ0xaRlNQMjczQnNXOGhRbnN4U1RKWlRjOTVtZTY3QUwwSU45?=
 =?utf-8?B?b3JyT2JVYitxUVNLcEo4cm9WQWIxV2c5WmtoSWtvQW9oSjlCRlBLUGM3ejhY?=
 =?utf-8?B?NzZzMEJVN3pxNGw1RG5JSlBWMGI2RFdiZ0c5NEJ6YTFJYThGVVQ2VVFKOGdi?=
 =?utf-8?B?SXV4d2V5STd6bU04elQ1ckd4b0pSMEJQY2hOREY4T1IzSHZwRVV6VnE3amdD?=
 =?utf-8?B?ekw5Y2VBMCtZVTVMLzlBaGpaNlZHMXpWaUJQcWp4Mm5pRkJpMmNlMlFkM1BB?=
 =?utf-8?B?ckJZV3R4eTVTbERvMzd3dTRVUXppZ2R6OFZac21lZEE3Znl3WFN1eUNBTWxi?=
 =?utf-8?B?bVpxL0gzNTBUU3l5czFmaS8wbW0rYmNKS3dhQTk3bFMxeTNEZUdSYkpVMi9T?=
 =?utf-8?B?NC9ldFhPVDhWUkI5TlVENzFoWGg1d0FkdWRrY3RvQXF2aWNTOURrNVdSc3dZ?=
 =?utf-8?Q?q5hwufdimu9f19130JPOXCOZp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:58:29.2015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ffac22-64c0-477e-210a-08de3e4e496f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923

From: Or Har-Toov <ohartoov@nvidia.com>=0D
=0D
Introduce the max_tx_speed field to the query and modify_vport_state=0D
structures.=0D
=0D
Add the esw_vport_state_max_tx_speed capability bit, indicating=0D
the firmware support modifying the max_tx_speed field via the=0D
MODIFY_VPORT_STATE command.=0D
=0D
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>=0D
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>=0D
Reviewed-by: Mark Bloch <mbloch@nvidia.com>=0D
Signed-off-by: Edward Srouji <edwards@nvidia.com>=0D
---=0D
 include/linux/mlx5/mlx5_ifc.h | 9 ++++++---=0D
 1 file changed, 6 insertions(+), 3 deletions(-)=0D
=0D
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h=
=0D
index e9dcd4bf355d..e844cfa4fe0a 100644=0D
--- a/include/linux/mlx5/mlx5_ifc.h=0D
+++ b/include/linux/mlx5/mlx5_ifc.h=0D
@@ -1071,7 +1071,9 @@ struct mlx5_ifc_e_switch_cap_bits {=0D
 	u8         esw_shared_ingress_acl[0x1];=0D
 	u8         esw_uplink_ingress_acl[0x1];=0D
 	u8         root_ft_on_other_esw[0x1];=0D
-	u8         reserved_at_a[0xf];=0D
+	u8         reserved_at_a[0x1];=0D
+	u8         esw_vport_state_max_tx_speed[0x1];=0D
+	u8         reserved_at_c[0xd];=0D
 	u8         esw_functions_changed[0x1];=0D
 	u8         reserved_at_1a[0x1];=0D
 	u8         ecpf_vport_exists[0x1];=0D
@@ -5445,7 +5447,8 @@ struct mlx5_ifc_query_vport_state_out_bits {=0D
 =0D
 	u8         reserved_at_40[0x20];=0D
 =0D
-	u8         reserved_at_60[0x18];=0D
+	u8         max_tx_speed[0x10];=0D
+	u8         reserved_at_70[0x8];=0D
 	u8         admin_state[0x4];=0D
 	u8         state[0x4];=0D
 };=0D
@@ -7778,7 +7781,7 @@ struct mlx5_ifc_modify_vport_state_in_bits {=0D
 	u8         reserved_at_41[0xf];=0D
 	u8         vport_number[0x10];=0D
 =0D
-	u8         reserved_at_60[0x10];=0D
+	u8         max_tx_speed[0x10];=0D
 	u8         ingress_connect[0x1];=0D
 	u8         egress_connect[0x1];=0D
 	u8         ingress_connect_valid[0x1];=0D
=0D
-- =0D
2.47.1=0D
=0D

