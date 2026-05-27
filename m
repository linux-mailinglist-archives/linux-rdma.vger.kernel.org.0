Return-Path: <linux-rdma+bounces-21361-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPi9GFvsFmruvgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21361-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:06:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BF05E49C6
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 15:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4B8A3062CF4
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 12:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB2F40DFAF;
	Wed, 27 May 2026 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GieWEG/S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E6F40C5DA;
	Wed, 27 May 2026 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886583; cv=fail; b=ILVJ0eDiaf7VftAMpj8jQD210rb9MwUsSq5cJiGBbNjQeildVpbg36JasNmkWVd90e3MyiLdgRdLaFzK3aFFR2INN9yojlYd1Fukco2Jf212B6uAEUAjq5o2ax/3Fve9D6oLMsMj9dP5gThaz2tsa30KrmYlvpSG/g8AKnSP1h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886583; c=relaxed/simple;
	bh=iYFVl1tkEG3DYTeIVGEzION54xNxSWEgk0c68DGW1mg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxvWfG3LYicMxwRQJlewP9qtPdiZlnUDrDTevXCmkkwYcOJWBUGF6IHs5DBouuO+nGkJAXSdMu3HaL+Xwrpt3PWoOKuc9/z9wk4KH1ufTNiqBHED1hcyR6YlEqSJvbtroM74/uw34rg+e+YpRbu+iWi0bSktLOgvgcD/gHg/ZzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GieWEG/S; arc=fail smtp.client-ip=52.101.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlSx5PfBa0XqfRUc1gTJ2hMD/0bbAJVAlNwLsU8doYl6Bb2J11YOwfnEAypjTcqKUtHNuidOSe/Umz6Hi2uwLAMIauN0M+KmhaAY0qwL6pg+EOhVHuBlmJZwOr/vZNDKqoWxXtYB1DwoaErGs/ikEiCrAnhe6YqC4PbCskMzShzQjy30aNDCN4UqW/bwjg805nufaADitruDcW2uKyAOTCh07NULmifnyRwKoflgnd8UMV92uSfmMzZVBwtWn5YVKJGKg7Mjs92Hjbjg4+LSzLQhvMsQrco9J1jLBfB8zQZEG72VTehKF8S/rZAMpjgiyMY2SrE2HUCBALaInZpgGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13bKDN+yJoAWv4Vmtd0JcCJhu6XFQTHrhY2dY+8E+so=;
 b=NjlA+AFneC09Q/nLPBtucaQXp4hx5IABVH4GcgQ3FKCj7b1SVMvfrnmn+WswJP/i1C3v5RHHsy+o+Y7aoPjENPmbRfphspgdaet7Ee5yrtrrriIklwFRLi3KYh8CWOJd5ZdKLH55hrJ6+QYAaKYJj4cbwZ23CxtIkfJYXQnIhmekrJIe98ZmcW9Shy9uF3saWY/1hdrv+Zeoyf3drRQ9IhiAg5CIcHdT7U/SCwU8hLCJ6bsufQp7OcjkQwRn6N2UIdBOBK+KSIvu6xXaZp07rrQVt72TEg4MmQjtWGlxyKzwWWSi5UhYygS7CedTp8Z5PjHFocDzAmjG6AA6f75u1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13bKDN+yJoAWv4Vmtd0JcCJhu6XFQTHrhY2dY+8E+so=;
 b=GieWEG/StpjbY0DZa7K9WV6o0s/0UC85TDBGocSBtP3UUkk7IsQtaTYqlgGAsBNw9QEA52jvLFgp4fbJRmc4vo5bDP1PwLnOVuOydENU+1nvIqEvIq+Ko4GjdxqrDdpMMi+Vh4VSWG+8jnqZDlMrLrXRnc8PPxR+TYWVIG7qeHcMaqtySjE/yVKYUFnu9pwz6Wc7waL26EXfoyoGIab4z6HnssFxWSCB/QAL6rQxePviAEFIJKo8CpLtMaGKr/0/XXGtAwVaNug6Uky1dWASwrTfg9KEVdmG0CJ2PbCXLHvWnUmRRTB5VzIYgIImFaP9UZCuQkzqVSJQ2WW39yUVog==
Received: from SJ0PR13CA0131.namprd13.prod.outlook.com (2603:10b6:a03:2c6::16)
 by IA1PR12MB8080.namprd12.prod.outlook.com (2603:10b6:208:3fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 12:56:16 +0000
Received: from CO1PEPF00012E63.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::83) by SJ0PR13CA0131.outlook.office365.com
 (2603:10b6:a03:2c6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 12:56:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF00012E63.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 12:56:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 05:55:58 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 27 May 2026 05:55:58 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 27 May 2026 05:55:53 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Kees Cook <kees@kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next 09/13] net/mlx5: LAG, block multipath LAG for SD devices
Date: Wed, 27 May 2026 15:54:23 +0300
Message-ID: <20260527125427.385976-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260527125427.385976-1-tariqt@nvidia.com>
References: <20260527125427.385976-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E63:EE_|IA1PR12MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca3c54c-997c-4efb-76ee-08debbef5704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ojBC4H4M8DCccmGQuyWnqWEHBEZJS8IZotRfOiAgAdaGQ2o/kj/icjq/rZu1BKv3plPl82ZrGELu+0J+feEUzfdEiu7foewSQs95mEcAFkhfYPR1JnpMu9z1jjEyboinR/z7vQpeqvgGXKuRDM/PzXsKVsY7eIsMRgIzYClr4cYusdk6lG8GMrGr1zOLyKnXZCyzE+4jyDH0kYSv1iIg9xLmQpigiQeyk8fHuSPQAYBt9gTw7ASFe1A4zysOpJx5ryp6bXEH2zMu4G52fQLCveesLYyP0feIuxPYocsBnzhOkwiWaZcsLCdlDkAIW/A2DcILM0C4w/W1wAEuJNNXwd1S5r9EkNhq9yq7Ekn0tGfRnTiLuEk1ZEkmD2BApwUwBYM3Wi2HWrwXASH3iCGcvWCpAHyM6xlgMzXHxlrn5rVfSru2RT3hhGQQu5+j4y3+wqKtf+mBY7JR9W7B8wfu6pzPF46OgATSmQSz4Vyt3ImjZ5LJWJ/9ZhBHZn4jKPzLPP2hpE3l2IiSuMyxj83via8fHNKYZIOn2UouRZPJXGDp5eEPBxjZgxxoVcskfOrIZfr+y4t7UUJB0M4jPybJISlWH8PBBZqX4jouiVep2GwBXH2p7Vnvm2OXZoAFgMVfjQFno01RbmfQfgEIJtB8dMM6xsqs8hnHOKUS1Z63srq264yOp6Z6+eYL9ZNialxJTpBq1CBKylcR9hklrsMyI+D/kbVoqAzwd3sv4RlWq7E=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SzOuJpNMFE+4fALt2PqwNObxb66uUSjU1wBaUN5ejOqpq2dE0bsOrbozLfHyi8BLMe/sfVjINujCOtHoP6/wwNwbA8b2JDJXLzY5af4kqRh3n3GZTwL9H+0xkFawsWuTNhJbBqZNIg6NKe5KMuOycKMYfrnFL16EtlQq6RHIKEjOG5pgSIwLNdzHI4uZw9LMDfvOT0AW8iJA5o0hcvl6FHsI/CUSGUwAZbpYV3aE4U0RyYYUaJVMX/C72Azv83AbXhasiVRJu106KMn5vej4wcmfz791VZUPJxhR1hYM1U93mkDLl8uNoVhRVSCja2PXknYypV6w8A9SaWkDH4UdhfChR9GfWywkS5DD4dpPtyF1zOpSRKRJlOoEtICePOvgkYJY+cK8k9nCts9ULOkRIEqRXYzKVebqazM6r8rz7HwQrWbGfhnQEC8qgQEl7VYC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 12:56:16.3680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca3c54c-997c-4efb-76ee-08debbef5704
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8080
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21361-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 63BF05E49C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

SD devices are not compatible with multipath LAG since they use
dedicated SD LAG for cross-socket connectivity. Add an SD check
to the multipath prereq validation to prevent multipath LAG
activation on SD-configured ports.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c
index f42e051fa7e7..65c76bd748c6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mp.c
@@ -26,6 +26,10 @@ static bool mlx5_lag_multipath_check_prereq(struct mlx5_lag *ldev)
 	if (__mlx5_lag_is_active(ldev) && !__mlx5_lag_is_multipath(ldev))
 		return false;
 
+	if (__mlx5_lag_is_sd(ldev, mlx5_lag_pf(ldev, idx0)->dev) ||
+	    __mlx5_lag_is_sd(ldev, mlx5_lag_pf(ldev, idx1)->dev))
+		return false;
+
 	if (ldev->ports > MLX5_LAG_MULTIPATH_OFFLOADS_SUPPORTED_PORTS)
 		return false;
 
-- 
2.44.0


