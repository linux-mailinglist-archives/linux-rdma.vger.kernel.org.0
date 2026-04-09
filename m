Return-Path: <linux-rdma+bounces-19191-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHfcGqoM2Gm5WggAu9opvQ
	(envelope-from <linux-rdma+bounces-19191-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 22:31:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C46713CF845
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 22:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1C803037463
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 20:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ADA33E351;
	Thu,  9 Apr 2026 20:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CPvfCwcD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B5D309EF9;
	Thu,  9 Apr 2026 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766584; cv=fail; b=S7uP78pQvXHBOpqYof68UuM3TQEaHM6033Kv9m4O9kiW4yFRDoY/iUByoy0PCt/JN29vcZIXz8w91It8h+BF0BtC5x40XTVvS1lWOQoT4Ocz+Zmr32OL91HExLEcm6E23yBggKx7Yd/iAEIZc8yUA8uYQj99f5GdqR5aXwkKI50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766584; c=relaxed/simple;
	bh=AENdkvUgn7HD55kDB6yCKGlS/6lo5qooM9vFh+5B8LA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqKby5wiWC6Thwc1TFIJ8CVaozKmh4Yuj7VH/u3MfnnSH5qI/aUaeEmZOLcLIDjSYnWlKDYE+WyssYU4XaN+GT4YgyUjXrkXZByfVHfvk9isKETAjXQY5SaTwEI57jrJNFieAV4xPtE2i8btNShyvpZU8LTJAxe2xPARbuhSYpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CPvfCwcD; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cb+3tJ12o+4aGXeMXXsrIMNlK7O2SZQcpzpOk8aWED8k2qG+mrhY044a7OSm5r6lhcSjsD2uakEcrE1BkYYyZGITiQCU9/udMx/1r7S6dpFH/Qvlqb+/vV/Am0nX+FidcnmsqWjooCgksd0ROUxj0iCHfiOYoEZaUOFT6GL6BkaGKj6FnOZDQSlih+mLjNfvIypy5Il5Kg4lRrTcl9v4hrnmv1R99rf3yq8i8odR5Kw72r0Rx2VhZaBuvfNGaWhsWDFh4qgXUucI7womwuVkFTkWjivX60A6sHkd+C6mwXdmik9KKomtowUO4oSYkW+9ozTaeHHg5Xa9btLhdbBugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ipfkbbr6+4IiOwulHLSvxPmuWRbhqtcHMbRfSCSj+TA=;
 b=kjg8sBq93AXbmSErojvKHNLzuyGu/3SboWAp+4Byftb/qkfNvVWnGNkrCivELOjk+crXodrRTqCndc8LpODS23NhAG8DwxqtnqsYFZeeEqc8a84mJqBguaVodiqBICFqey3TeWgbJFYj3TyEdbCobQvkFkBLw+4gwdLdoMmmgJB/TpMdkMURYV4otQuQn7tljcQ74YEEvCfQEXXbukINaeK4onV4cubS98laUwWgBTLqlgYmDyBqWOqP28TXY7XgFagpWHVCgs/gJMH2atHprmlWS0+GQ7v9fpKbbKlmxvsGvjdgEcI6gbYGyGS8+Izf3vK7+BTuuxDv9NvzMBOdMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ipfkbbr6+4IiOwulHLSvxPmuWRbhqtcHMbRfSCSj+TA=;
 b=CPvfCwcD0+Q/PVQAgkHU2cy35GDlbbv/Wl/+N58PJCA59MlTDkHrQgvALxc8sixEzX2x6PxW7kv/edoTCJgEt5hb+bM+Is+cj5J6MJCKnAoyJQwOL4EfQX5bzVTvJsxJSmsNZP6cnmXVSbhFN+vC6/AFiCTPanXB1cHMiuQfpgC3kplWYDC3AYLTcmXft2QOax+RPM9KnqkStCxXiMJxHSdtauHVh/bkrvW+n0IFEh+taV6O2Mx2duRcZwAk5LKJJAAcMfMFg4DGDQwfIjld6YM78CoiNJRyaUlpB7zet2S4y9dy1Sn+JbVZnINg2FRgPJ9oP7DIWBN2f31dOtyjBg==
Received: from CH2PR15CA0026.namprd15.prod.outlook.com (2603:10b6:610:51::36)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 20:29:38 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::e5) by CH2PR15CA0026.outlook.office365.com
 (2603:10b6:610:51::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Thu,
 9 Apr 2026 20:29:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 20:29:37 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 13:29:15 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 13:29:14 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 9 Apr
 2026 13:29:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Boris Pismenny <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Kees Cook
	<kees@kernel.org>, Lama Kayal <lkayal@nvidia.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Gal Pressman <gal@nvidia.com>, "Roy
 Novich" <royno@nvidia.com>, Roi Dayan <roid@nvidia.com>, Raed Salem
	<raeds@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net 1/2] net/mlx5e: Fix features not applied during netdev registration
Date: Thu, 9 Apr 2026 23:28:51 +0300
Message-ID: <20260409202852.158059-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260409202852.158059-1-tariqt@nvidia.com>
References: <20260409202852.158059-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d6491a-eb57-4103-618a-08de9676b873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rcD2LYZLjVJomXBitwpbl4xkbvqiC1VE1OkxhjnIxuvcNBR9PAe03KCZSay6sqc1ynGhIXCNwBZfBH1iuvNVnQUnHmeiyGRsAOUHOTN1HqVlDIWtnxIcogzFDpeLCcbP0KW03aRExtyi2w1LYJOQlru8b8JyQmVTPvxb5c2eDjPFAQ4urRLScUn0YsbooMpcz9uzI+IbBYBJxOcnsNDqvfnkVcjjVq+M3WEq4CtARXoJCel+QSNIYjHESFAwRvwdoaif62216hHZt8Fh/xE/kYPWNaMjsl6/DeMucIv7bW2vpZgEJrNu6SfewnpBMm8gE4ojITQ8V3l5StYEj550uBTFK4yvXFwQn+umZbwvvd8mVCorseKMpN8oLHz9e5/EF2pscEGvKI8+C4gWV6fwMRUlH/IS10WXVuggbthsPsm5nlwDWX9aN9f3uBpreDFDPtJmHpveivG9PsWcst776noksdCUjhElVmvsunwGx0BYH2ijUkaQT3gqaHoc27E6kLDC8wRPfa2OIuGC/X1Fh2KWepUSkHSwKPRV2HXN4CLVSgdK0GeBHVQFBD2Sja0rsChVrzvt5lQqmLyqBbJpHx0hfpnZCYGhkBZTcWX96B1osj2VQbQwHRAm+4WCSsGKa4Qxaeov53YniAeg1Xi6NKOLJGdgXBegv8fLaQx7nVaSRtX6+JssxHWKrXpAxsc8Rgkpv+UYOjislzrlQ+o/PTNx1Ar95iOpk9QqeOHj/ig6sf+dqs5PInsMiTDTfgTbutUnaX8ZXSQokCg6tOHaYA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3Frdytjy7Fr6toyWFqBGIMBrLn8XjXPvrIXBTzER1noNqlJZuIZnzJm1Nr6YI/j16lAE5lo+Mv4XAeTiIDxDBzqqMdkYuXyrEPEeecVA45KdulALWCIli+wN/K0YmsIs6We8ChhvlwFTRp/OMMYwaelNRuvmagIkCTCLJdHwxVtISdpcIj+8LrG5Td0f4p00cO5O8OMESw4WfnJvHiGE/sEVhTDBuP8eprvZbmvFZImvSRdCcuM5NAYjo9vimQQ8yLywxhTT4ji90v9cUOpcRqxOMDqoddgicN0VbsWWHfz7EBXvfrwelwmu1QblzEkmHMlVcn8k9d3Wr7kVtwCEgFBbHYmq9hi55So48yTzuDYgqRDODcpqDNCrSavUj4rvpbe8/sUZ5bEnNeX6Y4bTmAyKrKIxatuhuWlZkhgPXlWDMyNlydvs2w4L+4QlLKfp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 20:29:37.6458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d6491a-eb57-4103-618a-08de9676b873
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19191-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C46713CF845
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Gal Pressman <gal@nvidia.com>

mlx5e_fix_features() returns early when the netdevice is not present.
This is correct during profile transitions where priv is cleared, but it
also incorrectly blocks feature fixups during register_netdev(), when
the device is also not yet present.

It is not trivial to distinguish between both cases as we cannot use
priv to carry state, and in both cases reg_state == NETREG_REGISTERED.

Force a netdev features update after register_netdev() completes, where
the device is present and fix_features() can actually work.

This is not a pretty solution, as it results in an additional features
update call (register_netdevice() already calls
__netdev_update_features() internally), but it is the simplest,
cleanest, and most robust way I found to fix this issue after multiple
attempts.

This fixes an issue on systems where CQE compression is enabled by
default, RXHASH remains enabled after registration despite the two
features being mutually exclusive.

Fixes: ab4b01bfdaa6 ("net/mlx5e: Verify dev is present for fix features ndo")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index b6c12460b54a..0b8b44bbcb9e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6756,6 +6756,14 @@ static int _mlx5e_probe(struct auxiliary_device *adev)
 		goto err_resume;
 	}
 
+	/* mlx5e_fix_features() returns early when the device is not present
+	 * to avoid dereferencing cleared priv during profile changes.
+	 * This also causes it to be a no-op during register_netdev(), where
+	 * the device is not yet present.
+	 * Trigger an additional features update that will actually work.
+	 */
+	mlx5e_update_features(netdev);
+
 	mlx5e_dcbnl_init_app(priv);
 	mlx5_core_uplink_netdev_set(mdev, netdev);
 	mlx5e_params_print_info(mdev, &priv->channels.params);
-- 
2.44.0


