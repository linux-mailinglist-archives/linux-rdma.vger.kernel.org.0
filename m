Return-Path: <linux-rdma+bounces-22302-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ELe1Ci1AMmoDxgUAu9opvQ
	(envelope-from <linux-rdma+bounces-22302-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 08:35:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 789F9696E12
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 08:35:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=IqHFIXjx;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22302-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22302-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57160313156B
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 06:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B9A38F64C;
	Wed, 17 Jun 2026 06:33:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5E93AFD01;
	Wed, 17 Jun 2026 06:32:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781677983; cv=fail; b=dat+xOTN8HNthVBYSD9WtfuYuHPzkOWBFdTARerCHWLpYnilhgLgnThk1ZKvhg7Qwq6ECvZwUJEhZ8CyCJd4lzaDWCv9AaNNN5yOuElYcGFsqS9CKTu4drSBAs1NB/F9RryEmCrfWIuhvcu+sB/+Nr0BlqtGwFmcvWWyix92vac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781677983; c=relaxed/simple;
	bh=YMnBS71PHgVNei00I9EVtd/pf8IgiQ+q6nuoxoj96yA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8IwRzTxPoh0n0Xe39XjZQi6NDP/XqHzA+Dij9lY2RT2q08nork33OB8rkVsX82WWssCvN1s7xiqSqNtEgwGhPVoEoMUhU08h20ed10g7ib27sYYF+CUoR6RnBfULZC13japlwruMFzvh13SYHz2iX8uvAQzCBJvQZzGDAvuyTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IqHFIXjx; arc=fail smtp.client-ip=40.107.209.62
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSDklQayoHgL3wyYUonV1wV4xhJEbGHpVJYPO0IGBUZURBJf8T233+q87TOCjpERb+uC+L+DvmbYop4Fe1dIbES4TOF3xdRkAY8yqsWIWG+82EhdEu90HP99yuy1roKxg3IxRceSyOYu506X/OwRT5xT7jYplZrOAXXhgGMdKi5UsLjcR+p45GiowsBGTC0IntHOb3lKMAaUPqDeT+Cfr33WTfovUTirVV4JH8e6+6o5b88SyUoDOjNMooGt9be6N8F+ld49i4DHxozNU35QuitqEw13lwVYYN25j+ce8cxJGGAunMEkIy6E7efRJabkT/MqI2nZyL8LxgkHfJK6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGGBPPRhY1snyy4yZVxdwlR8KQg5bbtxtEJBU6q8v6s=;
 b=XCqUVwMrgdqVYodzOBYfd2E04GBeUlBomnzjuiH6dNYq5NWwNDxS4wrwpncIoe3NPyp9SbdhAFHIQO3pKuZdZfQSseuZr2HjuGME/1V34yvMhuHERLpmiUnudxkyc8M5QgIgcXJ6MVGTIhsv2mFifZ0gFiWErHYrJ1nQUQImjre38OHIo2zBUv9LHDZiDBWgAyYqze52IBR6LL84xLSDIMLpcoC+SfrzmYUEjt4DB/V7KqSCjZ7Qkh+oAf1fTlidROgb9/iS+r9DL3wjo4CASgl2/8JwvggpYYSkhc4rL1XK8nV3yVBx6dpqRK+1m2idOD3lGaV0V+ltwKzu64kpDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGGBPPRhY1snyy4yZVxdwlR8KQg5bbtxtEJBU6q8v6s=;
 b=IqHFIXjxuRIdUXgN3NICwXQdJgPwRkQt08+ORg2Losox8VVv7TydtgKbDZNw+sxvRt0y9JMLOplf7uOuowTiTaTPvFXfKUV2BAJA+hsfPR2hWL+gBK8EMBXCUQXq4JxSUZX9FoOWmbtQN4GJti0/lnjPxD/alQA7GjyyTtXb59kSVgePQvW0OEtMUdQ/IPz/w+Of2zn/VNUpuzOXFIQtcEHgzxfXUfvwlR2sgIXuQZqxtrFwJB29XMgGqetTKr8GcaC/aGB/+9V6YmnrzmRPApoIe820/yANuy2r6z3d9YL8hkZ6SnSbp0b60n8gxmEVH4MzSAOJX+VaC+uWdD4xmQ==
Received: from CY8PR10CA0028.namprd10.prod.outlook.com (2603:10b6:930:4b::18)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 06:32:51 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::5d) by CY8PR10CA0028.outlook.office365.com
 (2603:10b6:930:4b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 06:32:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 06:32:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Jun
 2026 23:32:34 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Jun
 2026 23:32:33 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 16
 Jun 2026 23:32:28 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Shay
 Drory <shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Simon Horman <horms@kernel.org>, Maher Sanalla
	<msanalla@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Rongwei Liu
	<rongweil@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net 2/3] net/mlx5: LAG, MPESW, Fix missing complete() on devcom error
Date: Wed, 17 Jun 2026 09:32:03 +0300
Message-ID: <20260617063204.547427-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260617063204.547427-1-tariqt@nvidia.com>
References: <20260617063204.547427-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: 9096805f-e3be-4eef-f166-08decc3a4132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|82310400026|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MD7sPBxFl4SI2yy7xhzi8DglSCTUy0WGF7FFjVqanF4qjPSOhRqqURuQXF7XctDZonAW/ADQ/xS3gtDrOgz8wyrzxYO7vU2d6pIjmzsuqfa/0CBRTlrvZOSR0Y89zpeZzTzflWIPaWoyqHvmr02zlq0dQvNrRSH80W94MPhejI/gs+LFsF68EZLJXuZXmfvbs9mRuoJ+oC1XiFXc/nKk2bdDxBIR6v7OG5T+putjyUeoFxF/XftGECHixpGiWbxZYu3et27RiN7Sqzw3Lc1vTnsHtXZ+UCYFEQ5FFRO0KXoAZQYe8/GqWkEgyiLb6JthtE5qU/hahlVicIhIFG1WxG/XQFVDHbj8DNdU/eXrPsYQfM1HwLYEYS24c0W+UWSVbUzUQaOOUFJLWLpjj/gmJXXD4GKudPx3DHNzHpekW0FHYi7L5+QtcqiowOKB760Ow/HqgjoUzrhyw82ASDTzzX02gRCiyS09W3rBseQ/8I8OymbArOrj0M8XXpokmE+9nqEzimOxgcU1/RoZppCLl3QFIYfzAIQCzYz2801lUqWYwlWuuFGrEI9wNjZ60yXWrsJOGrdsAMaFZ6L5pnrjPrJdYrx46a5st0kxlKr7b/OYTZIXgavtj4y/sYfPW4QrLhEUxZamXhCo6hP48feVj1qRPXhwyYC+5dumsOABg1BV6ylQpnevxDLXY3d7mUwjAfwBnsAslj/YsNQgO6uoX+Ws2vZ+D8Xr6X8OaOzxJmw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(82310400026)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QLmUCYDeoxZxSFoOw/nrLJLFccH2yhIk7FNoUPM2NDnwfGRDiDIgc+wWsyiKV6r7Tk2871kHTrKXTBKpBEAlP7X+pw6syTfPy+ubEUXfq3lWcpjEBgIC/2PeOuLX6RgByMG2/UF822rTu0FqcEZ4ElxJ7fYup3gDfCDQstH+CykSn1F7EQzFenPMSLjqrVkCRLKv0WZZ+iUMD3mMUOmEqy0vIqYeTfV9OIePrBs4IsND33mKF3eT48inNEMQNaur3jSuG7jTbLtknVSp8g87aw/n9DcR/tz1vnlmgKm9OygG05U9wIgNxcLd2KhDoA0BUBxVFotDCigycjO9Jgg1miKM1nnLJAJxxm2hEFUMiH9bMaIQ2qYSPFlKFUu7xB7q3nD+G4v/lbtBiytE1VePm1vP2D9sH91B2Zuu7M3zSX4bMpq8WCZHQUzFciVPVJUf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 06:32:50.5540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9096805f-e3be-4eef-f166-08decc3a4132
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22302-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:horms@kernel.org,m:msanalla@nvidia.com,m:phaddad@nvidia.com,m:parav@nvidia.com,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:rongweil@nvidia.com,m:jacob.e.keller@intel.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 789F9696E12

From: Shay Drory <shayd@nvidia.com>

mlx5_mpesw_work() returned without calling complete() when
mlx5_lag_get_devcom_comp() returned NULL. A caller that queued the
work and waited on mpesww->comp would block indefinitely.

Funnel the early-return path through a new "complete" label so the
waiter is always woken.

Fixes: b430c1b4f63b ("net/mlx5: Replace global mlx5_intf_lock with HCA devcom component lock")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index 5eea12a6887a..db506ab4fa96 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -140,8 +140,10 @@ static void mlx5_mpesw_work(struct work_struct *work)
 	struct mlx5_lag *ldev = mpesww->lag;
 
 	devcom = mlx5_lag_get_devcom_comp(ldev);
-	if (!devcom)
-		return;
+	if (!devcom) {
+		mpesww->result = -ENODEV;
+		goto complete;
+	}
 
 	mlx5_devcom_comp_lock(devcom);
 	mutex_lock(&ldev->lock);
@@ -157,6 +159,7 @@ static void mlx5_mpesw_work(struct work_struct *work)
 unlock:
 	mutex_unlock(&ldev->lock);
 	mlx5_devcom_comp_unlock(devcom);
+complete:
 	complete(&mpesww->comp);
 }
 
-- 
2.44.0


