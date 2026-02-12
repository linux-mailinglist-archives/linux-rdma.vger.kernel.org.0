Return-Path: <linux-rdma+bounces-16783-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPzvJg+tjWmz5wAAu9opvQ
	(envelope-from <linux-rdma+bounces-16783-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 11:35:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E96712C8DA
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 11:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54257316DF6E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 10:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D8E2ECE8F;
	Thu, 12 Feb 2026 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="omszJtS6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011017.outbound.protection.outlook.com [40.93.194.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEEC1C28E;
	Thu, 12 Feb 2026 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770892413; cv=fail; b=arUsmvGVpBpYG48AsOKRkO/bhJ4UrHQYKu36KZ/HByo+WGTDzJPcUemmUp4+vu4s0fCHauFHMzOGR0Vfzc3j2wpDYnRmgXg8oUDoAkdSF0I2tOotMbdz0beCIzfZ7fRMoH7Ka5CavQgldzSwpGS56mQVOe5s51YZe65ngzh0Tow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770892413; c=relaxed/simple;
	bh=m9XGp2AGYjOC7j+oStyePQ8FjZv/+nBJL+36/ge8G3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SRluwxPkv61gcmic6iaHZHn0arRYPleSlKM8rdkoWPO7jBGz0v9GVLN8i3iPWBpzjbrLGwDQXTlrW4rRlybiJFtsgWGhTDv4BPj8+Rfs18978iua1W6bjiGefCnH8igDv6FSJuakiiPIenMLMjaStqDns9R4AviC+J6qlzAlmZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=omszJtS6; arc=fail smtp.client-ip=40.93.194.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zf/su1o+oz2LtmIveiav+0jerOConVciwok1SGU8+yF8LZZaD0orGX89Yun6/D3qhYGLbKS5xBzWS/cEANroVdolj4QTPDzC9U5+QAh+j5KIC5dBGv5XwnzSOmdZiztfduUDzOol3SQ3E2XkbbBkMms/BssEs6j5u41+yGQwXqW91ExnK6hsn3oyCeCo9T6yEsQKhfhzJjx4b+CVvvtgmss/Sh5N4JBbPumru5YSGxccoTrJWm5iiKnpGYxqJV5XlmDa7FXzImtkPfA8xQCHwP8ypAIz2xEM8MvRIetT7GoW3yxa5Ho4zAG9mwpVAIJDoIhNz5w+SDgYg0lSy7FCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdUpuF7rrOyGjGKU+RqEGro+54XTf3TCeaemWgG9TYk=;
 b=wbDXxOO43fXzIDoyjsB1DBGQMuvKG5XQYjhv25XE8HrIokurHfdKqPRSOvLfBjyNJkFDA2D1vlK9+qfPR/PNFwXPiDBhHdlfAQGM4jgrVNPidORNcdpR9WgE9GvM/2qSQKIoBWm6PD/2Z/eHgr8w9eN5+WG6LRF3pyat7KiqwrZEY0mKJ+KTJhEuFC5bsbHXI6C7EpVK8PW7K+G45ZS/GVEvkuGRRYpSQtH/aRrAyM+N/plDU+tEa3OPDg84pgAYsHFngvz9VmgWYhI8Dkr/PimWULE5tlD3p6Fs4jRqxHKfd5MhGcJJpYQa8wqX6zG+JF8B5SYenRpWhY6SgUAGnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdUpuF7rrOyGjGKU+RqEGro+54XTf3TCeaemWgG9TYk=;
 b=omszJtS6FhZbbevwxTtCMm5xSxXOL/QacFvZAq4yg+FdTYwebHptU7SlG1NWJCx6njwlSa+4gaOdxSY4b6OOPjs+EaDROELdX6Xvs66bieLkGuwNsnCKLVJoQH1w0WjjAzztzBfXTEf4Ges0LDL/xxMh5dQ6M8rAPVnwmLDgKinQfcHC39DoM7vL7555uZgYZ9vK9UiqvJf60r745St3Dn1wLmDecYM1FohjXykxnitAlLDUGBOY6/70AaW8nY+K21IyKgZWQZbq4NEasJd3So6SapHLRdmMSUd9hWgnA5FK8PxcKIpJx7Il3L0p4UwS9YQnJ7E/wvXdg8LtGXw+Fw==
Received: from PH7P220CA0142.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::12)
 by MW6PR12MB8949.namprd12.prod.outlook.com (2603:10b6:303:248::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 10:33:28 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::98) by PH7P220CA0142.outlook.office365.com
 (2603:10b6:510:327::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Thu,
 12 Feb 2026 10:33:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 10:33:27 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 02:33:10 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 02:33:09 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 12
 Feb 2026 02:33:06 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net 4/6] net/mlx5e: MACsec, add ASO poll loop in macsec_aso_set_arm_event
Date: Thu, 12 Feb 2026 12:32:15 +0200
Message-ID: <20260212103217.1752943-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260212103217.1752943-1-tariqt@nvidia.com>
References: <20260212103217.1752943-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|MW6PR12MB8949:EE_
X-MS-Office365-Filtering-Correlation-Id: a58d191e-3cc9-411a-4a76-08de6a22289e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+EjGYokyCNh49iCbXB5/NWbuF1Grjjt+AqryCfUUfw5MPNe3nZf8a7GP8uiv?=
 =?us-ascii?Q?rRHJGsg87l/s9geZE1U/jT77oxJXTRUJey4bPYBbKSKWXtZnMfHETq1jNV/X?=
 =?us-ascii?Q?gKMUlCE1BIKaYXN/tMnNOcBsNlcI1MqYj6pmAXMd1+7mwcpXlUpbxMFj9IKM?=
 =?us-ascii?Q?XuyFDix68vk4Amy3GxdAMvohNZB7a07HY6T7AXHUA6eCEFIofX++XhvNU5zv?=
 =?us-ascii?Q?6KRFtOYVzjacrHZ7cPz+T/IADsDOZaoEH9R9ac3o8pLmGs7mDzpvV6WxmOll?=
 =?us-ascii?Q?TzIANDxqGewsjnSBtXCx/i7NV+f9NfaNHI2Cyw+P+TKXwgkB1p8W3dwmMeL1?=
 =?us-ascii?Q?g3zfcK4hdyQ6PXBdNITlSaypjhA8BaT5f1elaA3BaM9qkMy2T1Mr1+n3Y14/?=
 =?us-ascii?Q?chGZFAbLUVhguFYTGrChwwqHuTqoOo6Vq0vKN97voqoWl1y9wDq4+72/8s0m?=
 =?us-ascii?Q?7Rd2+BBGGaF4F86J6WsPiWFRUomtPhWpvKglXyxRWc9JIUGFwDZ67Y0VPKZV?=
 =?us-ascii?Q?mgg/BCBiC60YV/md4qlV53UMCTJlXcCYwQ1rkTXy9wsT1lmz/kCuYuOSy+aE?=
 =?us-ascii?Q?TvSE4xrkeYf3k3jl9Dy+G90Ud6Jz1S6qo8pgiI9mwwm/q0Uh0n6zUoPTPGyE?=
 =?us-ascii?Q?TMtan+DILV5BnHQ328ImET+8SkFpyi9LwlxCqljRKlLg7M3mWjgmWA80lQcM?=
 =?us-ascii?Q?Zf98yXhbgacA137/ukWfMWTAT2z5IyVCSncK1t0YHxTA9efkf2+5rjuhWs9q?=
 =?us-ascii?Q?dz0HpdSZQTXG7iQnJ80XHOBkXm0w5ytESMd3xML95rPjuaR5bTz+R+FbXxLp?=
 =?us-ascii?Q?NJa/EhJzz0JNn2VLaxpz1lk2kLDhQtVrjnoB+GTC+gFRhs3+FV6HQOVDf48q?=
 =?us-ascii?Q?C3Idp/5QRMpreoUu6ccvnRS73McA56nmjtujBDctQ+DF9xEKW8t0cvJQbwXT?=
 =?us-ascii?Q?w5E5fHgDvphCOmvqxik4I8s/01ra2mK6K5F2ET2EUwCW+tDAUS2O6WG07CoO?=
 =?us-ascii?Q?Jg9MU428gl2rmufkzNSzJpS2i60o8UsAx9iqbBSK09wivtRt9wBaOMPb8NMq?=
 =?us-ascii?Q?/4DYeGm7161cOMsKm3/5TKDoUldSoqh6ZrEiWfvLEBuXuVaw11APisEV4D2n?=
 =?us-ascii?Q?OjjtXqtpPXWydYScVmSUaxXiH38TkqY5NrJrH3VQwrOq1NDYcEC06UsqC7+e?=
 =?us-ascii?Q?tBvML8Ndc/SoFipJnIdbiYaKlnWJGsozDnkcXy3d007KfL/HRuGN+KJyR8Bk?=
 =?us-ascii?Q?txzHkNrat/w8GkSz8cmY8Exhrfww/E6WOeLC8N1Cmd4d0dhMyI2sDv8LBHIr?=
 =?us-ascii?Q?dxsmtOSqZBzg0IPEo8fawvjHunwdP0MKb0zur0jfJEWWeIGtjnuTSUOFc2cS?=
 =?us-ascii?Q?v4rPtOtMCbcEWLhADREiJdE3hr4S+Z7Q4JMknX+K1J6QKIG2YVEbv4cVEQbL?=
 =?us-ascii?Q?9dIOWT4iJntUZC6o1Fhi97vy4SEylr5mURjMwAuWDvNEBK4P/BO5D4a+77qW?=
 =?us-ascii?Q?k8rUXqA8ZFDSigqxuoTAtOc4nMEeadnUCEQYy7QlELIJioSfJFfL69NTX+wI?=
 =?us-ascii?Q?QyePDR5wanJSxjHMupUKEgz/FLjn5ruzAHILuHdkxBPwkp4pg/GLNgggp/9f?=
 =?us-ascii?Q?FIdJYUpHWuu63ofNzW8tzleOc4BYVul5EmSrScpZe91NoVsHXcMdN5PomNu3?=
 =?us-ascii?Q?hOFIJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kRQFrUzj6MY3/aE3VRJmQOP3P37TPPItCRJMtO5v5z9GqAu5GeoxaQxn9hhP2iukID7CAlK9P4SgGtNtnbwNXNQHbGgm5dDUkYEo0cYc9xUMV1ZJOFCZriEjarW9CTTPK34fs9tSoXJ42RlQvK7Px295ZDDt2UXldNfN6rXzXUcgYg97P9uGtYUAae81jPiLlPFVtUW1WGT1Z6Za6Dc8GZCReOAuTWdSCDM7ppuBTjSMG8q9NYh2as1pRThwfoE5N5+E39XdcY/PQPDkiBaolyJisCoLaHctZntsx8pEGshniLKmxFMgQqWqTD4C0/alipYAtBFhZGN9MFUDGYYVd4BxR1UdtR0X6NI3FUpGy8pT1u9Ye2cYbMbp3wD7zpWua3bp2rUUDMhkrJlRaWNmX0WcieDhrdb0TpnyoRZxxLrHOArZUPi5pwzyiW1SQmFv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 10:33:27.4775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a58d191e-3cc9-411a-4a76-08de6a22289e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8949
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16783-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3E96712C8DA
X-Rspamd-Action: no action

From: Gal Pressman <gal@nvidia.com>

The macsec_aso_set_arm_event function calls mlx5_aso_poll_cq once
without a retry loop. If the CQE is not immediately available after
posting the WQE, the function fails unnecessarily.

Add a poll loop with timeout, consistent with other ASO polling code
paths in the driver.

Fixes: 739cfa34518e ("net/mlx5: Make ASO poll CQ usable in atomic context")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index 2b3556fbfc42..e64a46be1cbd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -1374,6 +1374,7 @@ static int macsec_aso_set_arm_event(struct mlx5_core_dev *mdev, struct mlx5e_mac
 	struct mlx5e_macsec_aso *aso;
 	struct mlx5_aso_wqe *aso_wqe;
 	struct mlx5_aso *maso;
+	unsigned long expires;
 	int err;
 
 	aso = &macsec->aso;
@@ -1385,7 +1386,10 @@ static int macsec_aso_set_arm_event(struct mlx5_core_dev *mdev, struct mlx5e_mac
 			   MLX5_ACCESS_ASO_OPC_MOD_MACSEC);
 	macsec_aso_build_ctrl(aso, &aso_wqe->aso_ctrl, in);
 	mlx5_aso_post_wqe(maso, false, &aso_wqe->ctrl);
-	err = mlx5_aso_poll_cq(maso, false);
+	expires = jiffies + msecs_to_jiffies(10);
+	while ((err = mlx5_aso_poll_cq(maso, false)) &&
+	       time_is_after_jiffies(expires))
+		usleep_range(2, 10);
 	mutex_unlock(&aso->aso_lock);
 
 	return err;
-- 
2.44.0


