Return-Path: <linux-rdma+bounces-22415-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nl38DvkcOWoinAcAu9opvQ
	(envelope-from <linux-rdma+bounces-22415-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 13:31:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB706AF157
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 13:31:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="Vrnf/D01";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22415-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22415-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA677300F7B4
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B7823E342;
	Mon, 22 Jun 2026 11:30:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A5280018;
	Mon, 22 Jun 2026 11:30:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127829; cv=fail; b=oG33qiIV7F+L37eFamCrUxXW5SwjY7Ud03HYeOlHjpwUImpjH76962WjkUTVfyY+9A26kU4IPZwN3QE4Q8XNt4dZYr+7+YXBmo8QhSlTDLdDoKTtFvdz7FGUtSQmkYG4RgYalQG/xortIBasIaDhKGNFllMqRqgEwJF/mmQ7PmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127829; c=relaxed/simple;
	bh=VADpgsXlfl1Eolsvr4vgUg4gfTt6TKQU4TJOybMF+yA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgGkimZ2yB3NG6+Ijf2Kss4GyE7l8FALap3F6i6LFuB13svMCJ9jDVWzHSLXGfST4DAwuBrOkBXxfI3pG3/xYJmmVrYu5Uowg7ViuyhOVecjcfq2GCQAket5HSqOs38LNd++A1yftj9yBuA5OOBzbNZ2EKZYe+tGmcFxrARGxBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vrnf/D01; arc=fail smtp.client-ip=52.101.61.61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvYA3ykXkEkYFI3zirnTRgALYFOUrmjXtD5gxIHXfdQTlTBjNKG89+7BHaZQsY0CbqxtWK+7+QkYE8axft6uOp+FZNX2VnzGg2nGZnJUVPImVqxhkEB3KXwn0n01Qqle5mxTYB0CqWUYPisLdeIjemtBF8X9JK7LHrp3Oda/sKBxK469ZWePGNnkwnKus36BG/dde4GhhRssDMrmHlHVYKh9PrvRwGittwysYYb6be1eQgrEbIAmFUk3kQfOehPJjaDvloqDhzZUkRW27iDq3DTWoLw8KIrFOBqJM9+8fyjxwJNVaaMTFi87kM9PM+cTG1Qj3Jv1uvPlpzwHLV5lKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwsOimAp+sdkSCeXBUAdbx2oEajToT9OII7mDo5v+zs=;
 b=v4tUjMEqcFH47coq7adQoQDEENrydWVD6pZf//EMXpjpxu+hYs/3lBC4+kaCQssyky1AwGwr6p27LFnvM/IZnZyMcwu6y9+wv18asHqrND5PUASDVHI5G3quO+bf4mpPO1Ee9ubC711uWyBxZuSgrXGvUIv07qXPGBTHGgC8jw10SQ0x7PwG+nJD1iPuYFu4wHCl08mw+vh/AnzZeVNB7H5Gpz0tgsU8OPXu9cjZpeQLB9LxUbgRjKoRh8aG+toXPok1MMaJ9ykVT4n49ijVmdia++FHVnmezSXXYyWnl0NAG9tZBSuT8hfZqt/XuGJhN+/BMpHb1a9skuAL2qfYhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwsOimAp+sdkSCeXBUAdbx2oEajToT9OII7mDo5v+zs=;
 b=Vrnf/D01Vuex9Fc1bhVOSBKsbH8UrdI2nQe2pBOxGR/+fL6z512L3RJtcdag1iIdOQjnSrL0zn5azUd6m3wMOCtJOb1afi2mySeahjPhT7uLruJjc8gW++Pvo8xzQMkT/7fcR7C/27gTwHTLt+f+ZumWx+qGvP8MW9/WaIudoPisCPgH/eVeWX8aE2P/4EygBSGFtZuvKa932nTe5CcLljpXNOQBR2ZDyZ62cpPqISIb7dOVPENcQ0Y7mD1qmGEe/jUiB0+5YbONcq+uImK1cME//Fph5ttbLzkQ4QSvnEjEJah85XDsjwb9azlcfa+fxQ2sRo+piDsJPVkLhzUxxg==
Received: from BY5PR04CA0014.namprd04.prod.outlook.com (2603:10b6:a03:1d0::24)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 11:30:23 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::60) by BY5PR04CA0014.outlook.office365.com
 (2603:10b6:a03:1d0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Mon,
 22 Jun 2026 11:30:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 11:30:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 04:30:08 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 22 Jun 2026 04:30:07 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Jun 2026 04:30:04 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Alexei Lazar <alazar@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net 3/3] net/mlx5e: Reject unsupported CB Shaper TSA in ETS validation
Date: Mon, 22 Jun 2026 14:29:25 +0300
Message-ID: <20260622112925.624795-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260622112925.624795-1-tariqt@nvidia.com>
References: <20260622112925.624795-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|MN0PR12MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: d39b87c4-585b-4743-4fdb-08ded051a5d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jzftSoZsyg7O98R1l2YQN7aGpwyCFm7eOuPI0vF6qFm1E/W1SquEV041u4DUfo0FK2BcF1RKeqTYXGgYp+YGHCG7M+BTmgqtpYXaDFSV/ILwOjF8J0MhRprSnAzAdWgJpxbenW4fV39UOUf4r6weFtzDTm0Rx/uRvdKmurEVG+9OOeSb3AzUZwZsyWxEE22FggLv5+vY9J0+dn+HGC+V9Ok9F85npITF1Pfr5kn4r+1ngF8CBMRb47HJ1T9KTWq4JeUB2ol/ixdpLr9A/Eh/eWlvGGom+CORwUI6sO65IXssB3zLkY80BaRv+DjrSbfmqJMvyvAZW5YMN/26A9U/CQSSPTsR7J5Eq1Yp+d09lRqCtLZxIrCyKjPMtuzyIBnh6/Ksz4YUOa7oKVZVovTPg1G4rvv0PTEWYUGJYe1gfhc8tLl6ji4S+2prBVWg4VcPBTNt4qesM2EKiGcUxhNPhuUUC4lRwdZV94DWud2U/hZc5cWIbZewmZHwLPtbQ6a14+B5iRsSfxw/UJOASN2emCvfpfHbbOHytBSNEsfAarq5ZdEuLXYT2Ja7i618QSipURj6IHnpFtVqUcWD/tALyJWjXm2nugnKxY+NDKIC05fTMlnVqoREU2k4Q5lf5uLIkItBuaYx9+JWy2wMK29nEG10LwiJNavCByNpxojkRX6cS1sscLugg/icibn75jwF2yzSqpZnoQOmfme8JcQmyA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N+uZukYEHiPLW/jVWS3u1XW27X45tnmo8adn3QFxM1DTxi5HA9u8kIGr5Ndti1QWP+Bn0Th7XxglLiGhLHe4YvungXH+Whd/8dXj+qNajqKcoTCLw1iuCSZHE1Tyeonz1OWE0n0zi9iOy/7qZ/wS9w4zw3jcgyhhFe4lng7jMVkVM9wBq4TGu41FY4+dBAVcMZuRULzy8gcwjDZYQNR3FTMHwyEOOUYZb3wDn1lNLbWu8eQkNEm8Q/2OEcMqIKYIEHfii+Di1aEgDKqI3o/FlkHgQqflkhFUvac46K/0pn29ooduzk4FsBy+yCx+m/W9lRYEkgDl2l2qmeS/zneiq18NRx+qePc7q4Adk7mBc8P9ueX9b9mbE8xOti7Ceniw09yTq8JMFEhGqwoah9JLg0bx8VIKOk3Cn/szmWhy8P1l+nPuBchzUOz9Us/+UpUn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 11:30:22.5954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d39b87c4-585b-4743-4fdb-08ded051a5d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22415-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:alazar@nvidia.com,m:cjubran@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BB706AF157

From: Alexei Lazar <alazar@nvidia.com>

Credit Based (CB) TSA is not supported by the mlx5 driver, so reject
any configurations that specify it.

Fixes: 08fb1dacdd76 ("net/mlx5e: Support DCBNL IEEE ETS")
Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index e4161603cdc0..602b982b1bbf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -326,6 +326,12 @@ static int mlx5e_dbcnl_validate_ets(struct net_device *netdev,
 
 	/* Validate Non ETS BW */
 	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
+		if (ets->tc_tsa[i] == IEEE_8021QAZ_TSA_CB_SHAPER) {
+			netdev_err(netdev,
+				   "Failed to validate ETS: CB Shaper is not supported\n");
+			return -EOPNOTSUPP;
+		}
+
 		if (ets->tc_tsa[i] != IEEE_8021QAZ_TSA_ETS &&
 		    ets->tc_tx_bw[i]) {
 			netdev_err(netdev,
-- 
2.44.0


