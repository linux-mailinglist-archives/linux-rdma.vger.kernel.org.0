Return-Path: <linux-rdma+bounces-6439-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B433A9ECD7F
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 14:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0917C1886435
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 13:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F3B2368EF;
	Wed, 11 Dec 2024 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CvMTdugj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C20C2336B1;
	Wed, 11 Dec 2024 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924649; cv=fail; b=XfrQXRAZwWkTCu7S3Rby+/2vM6um38VyqGPv3RK4zI1uiWPsmzSuRO7i9TH8WvwEMQAf8txwtY9mE7U2LTpzmtZqoAJ7R3lDe9UrrzdbHHQFAAqh9PJUwctrW/IHQOHVSw/9PGuq9iyShKpXFBMiLUqpZJwl2aypzz2U8cHE/ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924649; c=relaxed/simple;
	bh=u/CR+HvQavwZV9N0aQqfo4KV5Jrw2vFmJapYu+VMBu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQWBM831eLnmjh7k8gvSAsEep+b+fTcrzB4awyF2iWMuAUOrKTIM22W6FBTtqM1iomx+TDSXMw9byfK9R3Usb0BgqiNIC72mPr9Sq7o9LEuhxpfT7ZyCiS+3sTJqGoEOZabXKCPEBJqRjvZOYPW+QBKR+KU3sOiDNNXcvWjbRas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CvMTdugj; arc=fail smtp.client-ip=40.107.101.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7e0mzJ3sQBthrpUr7Z/m+eBmmX4X+ILnw1FVoufgJQCMea9Rkou95i3UZa8byQFA2DQ7JwXxAzM7GWTCcjMFZSj73Uygm7xwIn3bJqawFjMJg5AxJsNXAtf3bk7VJ76Qg9fh/PsMQsY/3pnAxsBFFID0mW6oaR7IA06m53WSXHQrPt09VClam/SmNQx6JGgDKgupcocGhKnYMF2ScoGrd5+5IEXqQVg0Q586clzB3GeQshDToYXD9REi2IDlc4cBjPjF3PXAewxLn4xJjieonXiMqQBvbBIMiiJtqmefvFf9KW4MtqQmkRdmtjdLWXpita4+YGQv7J/Fbjcia+tog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29DKQUyW4N1TAyyWKuddTU2DeDvcyT1KV+dB5i5nOB0=;
 b=TiemX8zsz4Ured4AG/DUWB6gwc1XlmZKsJEgObGnwQkPbW1hJ2XHb3sM10/vnG6CGSPzfaXOt+xwvj+Q1PKaShDiGCcA36amCqSIsC+iIy76QuGU/CmeotsutYUhGPunebtHa5aHSb+CiaEPO2HRpdPDMoDS/UAZKGLBrO0HlnnsGfZGXSW1//Ut9bnKUL/61XntC2blg8aHrpJzje9KoNK7wz1Lc7UnCQv/lOHiZeP3IkHRdraZfLKyZ/IMy3tbXiQu788t2VGbeuvxN87dm00mhPwuW1UdTks6gPkmxniQybl8okihqmPY9n9hk7R82X/GP5T3c4yNgVw7/xEk1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29DKQUyW4N1TAyyWKuddTU2DeDvcyT1KV+dB5i5nOB0=;
 b=CvMTdugjgltu77sOtOpL3mI1rlNileJhiY4DQ3nRMvRjB/Mqe5PauBrslxljOwrwMUb4qCdI7Fv6NjjTytaitmUtfDFuyaE7hwhZXfn42zJXJdALzMmPxSTKLVaWxGMTJQ8xRGTnt9KfbF1nypwxi2H/wDC6+Nu6hJxwHR59zOYeHZLug75dukgPkGt5UEtiOnCvjBjK55tm+5OkR7P64YsEiocsZH9DzqOwmvkjpG7LW0Dk/Giq09jNCgs46XXZBpJICH0nGe+7zQlsSydJYRUsGffGyC3dL3XZ7F2X6YsyBZ4lOAri9vTFLgbsRw1WuaLvuAOWBAf0eDwvlzKOJg==
Received: from CY5P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::43) by
 SN7PR12MB7933.namprd12.prod.outlook.com (2603:10b6:806:342::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.25; Wed, 11 Dec
 2024 13:43:57 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:b:cafe::e4) by CY5P221CA0028.outlook.office365.com
 (2603:10b6:930:b::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Wed,
 11 Dec 2024 13:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 13:43:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 05:43:41 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 05:43:40 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 11 Dec
 2024 05:43:37 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Rongwei Liu
	<rongweil@nvidia.com>, Shay Drory <shayd@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 01/12] net/mlx5: Add device cap abs_native_port_num
Date: Wed, 11 Dec 2024 15:42:12 +0200
Message-ID: <20241211134223.389616-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241211134223.389616-1-tariqt@nvidia.com>
References: <20241211134223.389616-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|SN7PR12MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 853bb437-7544-408d-af3f-08dd19e9dc1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O15O2CXKg0vUCziWMj7iFHXKJvzbf80PgPxulaJCJc8GDPVySxnJqt1zTnZV?=
 =?us-ascii?Q?wPpgu3d+mKfW+4zFCZuF0od20D1JnsHytNeWKdTZ4DobDlBhzZfKa0aFWEdc?=
 =?us-ascii?Q?biE0SO0DCDueBtHSp0dJpWsysXWMewUPVt4iFrpkaqGhFbAM9YXsRJDiFhEd?=
 =?us-ascii?Q?OPk3OK7a9oOkXYzPvXjP698fjKlB+jm+0/bZBTA7/U5q9XnpvgktQZ9oesem?=
 =?us-ascii?Q?e/mw3DS6lL+JDOrfrWTVMJ899lUl0SiH9EsYXfulghuc8U+wPWib4qyS4vGK?=
 =?us-ascii?Q?bdu62w542u4PneZboQcx2kOQSXzMODDTNDFwoOPZLoxwVhmV3Lwap1/fKqJz?=
 =?us-ascii?Q?d7x/ngMNVrZTJ+1w5N6/R5kAMvUb5ZXLym0nHTzWcmLTg963dSYWSW6LBQ+A?=
 =?us-ascii?Q?nDG2y6imZrj3Kk4nMHz2Y/7B6zIA4u3es4YIfzDJl/TVZvKsJL62sIgue8AX?=
 =?us-ascii?Q?yal3eqqlGvm+e1ZDjfEXcJhYiRLP4ynOIwPhudX2hMW6++pReomJtEur36Lj?=
 =?us-ascii?Q?7ddB++KjccqM1STSPbYLnSpghoH1GYa3vQ0oz8COsEBIpxD6EY6d+11tXz/i?=
 =?us-ascii?Q?MBrFAb6BhEdclZ4sAPNUxrLqEmUCS+ic10XIyLoPOyRGK54FVzC7zW2OqSOd?=
 =?us-ascii?Q?eshKcqTXMxz2ixgCanvvGnh1yI02hacEULcOo/dHfLUt9zURdAc1iuzNSahh?=
 =?us-ascii?Q?QfJxHipDFDTyZTHv9Q8aUXK69yrx6BcidAY/bWAFTv34G3uSbb6CY6UelXt2?=
 =?us-ascii?Q?rtwZZ6FKPTxT60v5XZj9o/XmtOzOHgfumhdG3cMi69dvitO7sQ7Ma+C7R0KM?=
 =?us-ascii?Q?fXcCJj3yojcPgq7ycVfgeCOAu1C1uO/wnDYZz2aaiYaj/7fsSPt+4Io44qgH?=
 =?us-ascii?Q?s56a7yjej/nzlTUmCnLoJ0scgdG1BhHjc+zM4CcsgoLsP6oUIDOrIkvRr/9W?=
 =?us-ascii?Q?a/11/zNKJNBSaODsTXEhvBjdo645Erq72GCOos5vh5UTSvSVglY2ksnakM+h?=
 =?us-ascii?Q?Rp1eWD7tAMsCuKBpG6axNxTcDGk+GCwj+hvxbiBPgEFY7y054mM3G/UqFBeq?=
 =?us-ascii?Q?D57k567YSrdkt4ctKDL7Uy7rNiv3+IfoCEy584uSEKZtnmDXCgJNtXLUK4lv?=
 =?us-ascii?Q?Hu4D3ATI1kJKhVDYGOGpCb/kpPCxCUAmOYI/eaJl1pl6EsaPvYt+PBTGEfGt?=
 =?us-ascii?Q?3RO04+l6jXd/Xcet7NKFg4mvR1jVosWxzWIznTkOzW67pIkTwCbt6AurmrW9?=
 =?us-ascii?Q?JXyi6mGDN1sQKMTcyy3JO0GPhnMm2azoKNg/lPN77o+ak7Rg03C5XA6Yy1C2?=
 =?us-ascii?Q?K2YzdGVxHWzcBxuVQjSHSbk7ksrnFvIXSP2bDETFWx9eI8iLzunYdyYc+jRu?=
 =?us-ascii?Q?ghZYZ3ME72q9C6uAyhFHLPXlFATJb1yS5DcXDAX/4Z9ORyWXmskipPUl9AxP?=
 =?us-ascii?Q?hlMC38e01qOdBeEsPzwuNKECKOPKc5h/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 13:43:56.6054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 853bb437-7544-408d-af3f-08dd19e9dc1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7933

From: Rongwei Liu <rongweil@nvidia.com>

When the abs_native_port_num is set, the native_port_num reported
by the device may not be continuous and bigger than the num_lag_ports.

Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 5451ff1d4356..43b3cb4bf8d1 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1599,7 +1599,8 @@ enum {
 struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_0[0x6];
 	u8         page_request_disable[0x1];
-	u8         reserved_at_7[0x9];
+	u8         abs_native_port_num[0x1];
+	u8         reserved_at_8[0x8];
 	u8         shared_object_to_user_object_allowed[0x1];
 	u8         reserved_at_13[0xe];
 	u8         vhca_resource_manager[0x1];
-- 
2.44.0


