Return-Path: <linux-rdma+bounces-22591-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zSYjDaGpQ2oLegoAu9opvQ
	(envelope-from <linux-rdma+bounces-22591-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 13:33:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D541A6E3A69
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 13:33:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=s2JKN2fV;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22591-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22591-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 507DE30923B0
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 11:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FB5403AE1;
	Tue, 30 Jun 2026 11:30:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0197234751E;
	Tue, 30 Jun 2026 11:30:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819054; cv=fail; b=eD5Tey+zGBKBd9t24pSWc8tmGexeJMBCON7QBPUOeF6jco92WxKeIrLo0CoIxgVknfEC229S6cb5+28aOTxSIht+nQ8HSgIKoGCF/9YiV0aDXrDW0Jjg3gScAtYo13l7rWkFtEShQkae9gpKrpZ/ga7MTdD81rafvYSCR3tvqus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819054; c=relaxed/simple;
	bh=hEzMoHO6d3kxWhrW/Db12G66FEYAhvFqIZJIHXnezZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9Mx4js8JzRlqhzEUlvQaCqeqf7wOLgvoSGg3YRIYNvhbyvw3tZ5NvhrF+BaceyfmYDFPuAEHR4LC1xQVv8vWvPsmc3EmU5F9vq+3bzWe6TNfi/sbBgUjnTbJ5uaixBTprHfVmREXcIjmE2O6aVDFZytc6XMkyVppixQ5xrx968=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s2JKN2fV; arc=fail smtp.client-ip=52.101.43.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rguOlG3s7h+raGAdd6KfQRnEj5QoRR3/GK5Rm6d1DWtNalpd9IZjZOxGPFuDzqJ028K4UWM0gRSP1dkDeAccB5bzyICWMI3X7ri35Pf/66dDgWZl9hqSzHnIhVPC1v5FyFFfaE+Fa8XSoWlctExMfRGQPxCnaLpl/g3g8YJ9fGrKAqaWalTuSw1bSf/bqUtrh5TK+Q6Pe5KTxBZT71rB7mw+I776jCLcbxKpiX89CT182GcRvZRqMe2OxlbA8KyPRc38MFseXO+HJW+/ulZ1Sax6NrAUM+yx9BPbuUUcR6Ewe45odrx+birhS/Lvhmo+bXM+NK5VMHkMC5RiOdEj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeISEZi/oJ0Y+kgnm5e+yQ0K7lhVV8k7kLiFcVZWAkM=;
 b=TXC4euJsvP2EE5CmhrjYUV444u65+OQS4x9x9r6Uvlw4VL0/KXvPNGzgfEK/+YWS63dX0RS+G+HaiwJ4kR0kNRRzQ3etCccUvQrt1Iuuc7ztcaPVCr4jKYTtBFVTZUBkt1n2YUs5nR2bqwyjsmO+OmNUVh8qbJ29hD4Zib8Hip3aYM+EoNqk6R4l2K+x8T8u/47PR0/GfCvYov2dWF5vxloiv5RTjEwbi2wduWRADoB0a9EWITVnLSlcJFVxVDRTHN74zo6ofHV+ll0+figiOnoj9XPO4WdBzZnW5tq2v/ae3iswHtSQdcwyoh6Z6JXYN0lGpXDpxLVGE/P359ZPpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeISEZi/oJ0Y+kgnm5e+yQ0K7lhVV8k7kLiFcVZWAkM=;
 b=s2JKN2fVBLhB87L5uKqwRVdWStuLe/WJSClegc6LmKeClL1e4rcBA5ipeCVGSqzpBVUAnYj5f6xj7ux17DYnxk28w1aE5YCZ10sfRJORrGKPxnDcuy5i3yGLiReWDO7MpaOKXheGrG+cAUa2CE/bnUDk59lP01aka8nDAjJDkmxGrF99xWVSfhRpWH3A1/JbajPcoICC/mGbAtc7c84Xg/WFTjWWU9EIKhhsCBDltnS5OvGfYUVJe2Cwux6Xf/LMK7RKwIjzLSttxaTy59TluoIAPnrlvIfQaVTeJEDi+6WNB0usrc7vEq+ejfLsKswGnTqYBfC5jf1YEqGw4s52kw==
Received: from MN0P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::10)
 by DS5PPF18A985A10.namprd12.prod.outlook.com (2603:10b6:f:fc00::645) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 30 Jun
 2026 11:30:47 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:531:cafe::21) by MN0P222CA0009.outlook.office365.com
 (2603:10b6:208:531::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 11:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 11:30:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 04:30:26 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Jun
 2026 04:30:25 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 30
 Jun 2026 04:30:20 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Edward Srouji <edwards@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Kees Cook <kees@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Maher Sanalla <msanalla@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Rongwei Liu <rongweil@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Shay Drori <shayd@nvidia.com>, Simon Horman
	<horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V2 3/3] net/mlx5e: TC, skip peer flow cleanup when LAG seq is unavailable
Date: Tue, 30 Jun 2026 14:29:17 +0300
Message-ID: <20260630112917.698313-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260630112917.698313-1-tariqt@nvidia.com>
References: <20260630112917.698313-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DS5PPF18A985A10:EE_
X-MS-Office365-Filtering-Correlation-Id: aa220dff-c3c1-49fa-b9e3-08ded69b0781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|23010399003|1800799024|36860700016|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Da6v6PQIJNePjtZB4ioS9BhQ0ZkzonQu81BFYzSEEYD2mmPHvHtNvBDo6taGJ8x7InH+FzTZ95c2rI4nTeCkYiOKZQr9fJoxbEcQWRFS6nkPj0RlF8+up34zW1dFDsLHMzgVsfhxLFS1dKSuPzhC3Oq6jtmv9I95JofuPZSEHQowuxydyNh35rJNWNBqCkAxpBE7+13QDoyFUgj4Z9objznmeFvdaEII2wd5UcjKk/d1oxLCBAoV7WXbi1bWP9B0aSamavDE5Yb0KvOolnLwBrMxxiB/O+inzj0JYSn1O/CjP8a330s5STX/Y1pBhDL6p6xHytsiSPVVQMm1TRskVsbNSpHLmj9eZBmQW4+vBH0YCniQeLjl8JGRbySzkExvBFVMLxqdW/W1nUYDRLs4XarQ/xIkxGM4uduAb8iBwkho0DRbMbnZeeQ9FjEXf4lPOWaB8sOgZxZI1CAxAGFAXOqaTvk2lAK+Ol14cnIp4chff1t/Sv8qvn84CCptWxTW4gbDfyf00V2uBbYxyMUKJWxMUMvFyrk9iHH0bmblFIDyvNKuU0wM/o4BrbQy+RqhHlnbqHA3G7HTIYMXXglKXjPabBEiagtpMTC7NGukygYWIFDO8JbuyAFxxpJ4hL5xYy1F2ssQp85dessWHfBsZ2aLGnTGKB+jSZTrpk64dt5DIjXun1kS9d7KSJwOD1TcY4CsWt4ydr+4Nxj8uTSkhg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(23010399003)(1800799024)(36860700016)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hgFVjdp27CrpiSAp+W1CExcy1MpCNN8oZR9xxC0LiaphLqaNca9d0mvVCn9F1JQdiOcxoevhrj88hvxYrQ09GL0cDrFl4s0zjjuW21QiQ2l2z3ep0xZ9t//HT3vAxZjWg20WeiSLaXwokA+JhA46MZMPyeoJT9KPS6JKc2YRBpwEF3MJT+TKbiWfAFFdH9bgIKTbmCK3fticYPjwY/f2FpjSLzySWB7r8DovlNDHSmZAIFWLXiLDRVcuI97YKsXao8QaSvhQxyodj9lrJBhOHC3L07BDhplx/Ak+ITnmi+CYNMMRgKRVooVstytP132Ggg6puQtYdEN3dj696/JOa7/HO5h+cnIOC6mHYlgryi1vAYioPvFKpi5e4F373+6f8g8yYwqq9fo4+lpMt4BOPoNS2TQXIhdMkgx9vOMXCkW/+CyEb6uWJLL5Qj3c1kcj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 11:30:46.5569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa220dff-c3c1-49fa-b9e3-08ded69b0781
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF18A985A10
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22591-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:edwards@nvidia.com,m:jacob.e.keller@intel.com,m:kees@kernel.org,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:msanalla@nvidia.com,m:mbloch@nvidia.com,m:moshe@nvidia.com,m:ohartoov@nvidia.com,m:rongweil@nvidia.com,m:saeedm@nvidia.com,m:shayd@nvidia.com,m:horms@kernel.org,m:tariqt@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D541A6E3A69

From: Shay Drory <shayd@nvidia.com>

mlx5_lag_get_dev_seq() will return error when the peer isn't in the LAG
or when no device is marked as master. Result bad memory access and kernel
crash[1].

Hence, skip the peer when lookup fails.

Note: In case there are peer flows, they are cleaned before LAG cleared
the master mark.

[1]
RIP: 0010:mlx5e_tc_del_fdb_peers_flow+0x3d/0x350 [mlx5_core]
Call Trace:
 <TASK>
 mlx5e_tc_clean_fdb_peer_flows+0xc1/0x130 [mlx5_core]
 mlx5_esw_offloads_unpair+0x3a/0x400 [mlx5_core]
 mlx5_esw_offloads_devcom_event+0xee/0x360 [mlx5_core]
 mlx5_devcom_send_event+0x7a/0x140 [mlx5_core]
 mlx5_esw_offloads_devcom_cleanup+0x2f/0x90 [mlx5_core]
 mlx5e_tc_esw_cleanup+0x28/0xf0 [mlx5_core]
 mlx5e_rep_tc_cleanup+0x19/0x30 [mlx5_core]
 mlx5e_cleanup_uplink_rep_tx+0x36/0x40 [mlx5_core]
 mlx5e_cleanup_rep_tx+0x55/0x60 [mlx5_core]
 mlx5e_detach_netdev+0x96/0xf0 [mlx5_core]
 mlx5e_netdev_change_profile+0x5b/0x120 [mlx5_core]
 mlx5e_netdev_attach_nic_profile+0x1b/0x30 [mlx5_core]
 mlx5e_vport_rep_unload+0xdd/0x110 [mlx5_core]
 __esw_offloads_unload_rep+0x81/0xb0 [mlx5_core]
 mlx5_eswitch_unregister_vport_reps+0x1d7/0x220 [mlx5_core]
 mlx5e_rep_remove+0x22/0x30 [mlx5_core]
 device_release_driver_internal+0x194/0x1f0
 bus_remove_device+0xe8/0x1b0
 device_del+0x159/0x3c0
 mlx5_rescan_drivers_locked+0xbc/0x2d0 [mlx5_core]
 mlx5_unregister_device+0x54/0x80 [mlx5_core]
 mlx5_uninit_one+0x73/0x130 [mlx5_core]
 remove_one+0x78/0xe0 [mlx5_core]
 pci_device_remove+0x39/0xa0

Fixes: 971b28accc09 ("net/mlx5: LAG, replace mlx5_get_dev_index with LAG sequence number")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 910492eb51f2..1bc7b9019124 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -5547,6 +5547,9 @@ void mlx5e_tc_clean_fdb_peer_flows(struct mlx5_eswitch *esw)
 
 	mlx5_devcom_for_each_peer_entry(devcom, peer_esw, pos) {
 		i = mlx5_lag_get_dev_seq(peer_esw->dev);
+		if (i < 0)
+			continue;
+
 		list_for_each_entry_safe(flow, tmp, &esw->offloads.peer_flows[i], peer[i])
 			mlx5e_tc_del_fdb_peers_flow(flow);
 	}
-- 
2.44.0


