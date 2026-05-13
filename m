Return-Path: <linux-rdma+bounces-20549-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MfNCRUaBGp4DwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20549-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 08:28:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDB652E15C
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 08:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EFD1301450F
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 06:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83093D3D08;
	Wed, 13 May 2026 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nIZlSx+z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705693BF672;
	Wed, 13 May 2026 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778653709; cv=fail; b=I7YL28oo10aGyfmStA0itx0iGhmTt6zdswfeZFUbRkzfrMDuRFN0JdwIIT4zXP5ohVu5Opv16v02XOW/n+x7RPn2ySPdQmRX7CEd/244HoqgpR2KO2bQQFqnGh3uwtNZ1b23ocy6klvPLhjrSvRYXMXDQur9mHaBpAMsGRwfeDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778653709; c=relaxed/simple;
	bh=el8GMn6nW8959Gl9NSE7folRYuGP7DeK73mEqIn/ZWA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qBsKfQ7qG2JjPNRwTin6FStBFAUUYTZBEAfDg9SRqLcLdiwW/XkQlReNrTBRasfUYt7vsO4W0y1btNant04v/aIgqpbiItmWiIp7dBWkmGc4jfe1K4mCd/8kxq0h+SyhJoJLEeVc3mSQsj2jgd50Fen4QauYnQ8T+Dp3OWU4ZQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nIZlSx+z; arc=fail smtp.client-ip=52.101.61.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPy3zo6NOeCT0ugN+vMEPyfZCi85LgdZKjeXogOwYuOxHPNJIb7AoAalTxA26F4HpJoghN6Bn3DIFAozuOb/J/LSgWA6/p8Nxr72/aDls6oIiS9K0ri5A2yyyISEyLM6aGr7ZrZMZiGy2DiLwLai10rqWqzl/kiCfcy4fFNsr5x87BP6IruqGK/j1lTDTAf+evgBSWz/zEhnYo1gC2v52ebr/q4Lf6HYcHKF6izB6ZhDhWNTklw3d8JUKCiu65QDEw62fx0EfpYhKXNZnomra4bSX0YOmZjFi+TNdnx5/WrjapXHm9WkWkHQdbSWqDnOxXgcNTTvnMcl99RUkHQWsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRpS+V4WBaVuAoiTPKpV3dvO7OFRfogHAyqe1GpZ7mQ=;
 b=fHzuc/wls2YLhOn/jF4t1eZjF/9snMt3U9IH7BzQP3IHY1JC5jLmBB7APm0cd49k1zRjybTHb8IJEt89ZsErHDEtU3Ch4P+sOEcYwWbfcxWWX2FQ+5pGZIO9PNF7hSJ5oLa2vOC10VLpgBmVS7FCF5D7rxjWp1Z8AXkNL5Mhetx6ACIw61KDK3sYlktnmwXJX53VuQMeRqNQyJ0OLrxloDzlVflcosderUTOhxWHSjrp79KE2wY4jSC3ctyKLBYuwDoSSlNAYj8wiW/ind0hFImR7q1rDvCJYwy93N/RG8QLkVKELSiGtPGRmDQoMQP6LX8u35J56z5qhlQHwEZH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRpS+V4WBaVuAoiTPKpV3dvO7OFRfogHAyqe1GpZ7mQ=;
 b=nIZlSx+zAmOBDIC8Fa3epbw/twFRx2X8kT5ZE9WhUXYaNO+6eDpjPrK7cX0TpDaX7msMkOJ54frsFp5eusle5//iW/jTocxCpVoGRTlnFkigjJDjhhPff7v9hD4zfsNkSOe4KPP/qupvSR5ZfeVKD9M5A4hwT/avNdVnbA8TTEkF+vN1kL6t/HaAtDPi5ymEckt/B3SZA1PVbNxNrhpIUBxVw1vDI1fryPfbVQAL8ob3pR11iZERXm1tFl31EcF6tWIkuRGjv+xWSHYV+yDKDUJknwBrcyi0xxKF1UuGgPW49tQsikr2AOeHD+erkWyWKnRGoJqoC7tGbiD1HL6CEw==
Received: from BL1PR13CA0251.namprd13.prod.outlook.com (2603:10b6:208:2ba::16)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Wed, 13 May
 2026 06:28:23 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::a6) by BL1PR13CA0251.outlook.office365.com
 (2603:10b6:208:2ba::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Wed, 13
 May 2026 06:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 06:28:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 12 May
 2026 23:28:09 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 12 May 2026 23:28:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 12 May 2026 23:28:05 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Aya
 Levin <ayal@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>, Yael Chemla <ychemla@nvidia.com>
Subject: [PATCH net] net/mlx5e: Don't leak RSS context in case of error
Date: Wed, 13 May 2026 09:27:37 +0300
Message-ID: <20260513062737.333259-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: cd171187-a021-4866-0f1c-08deb0b8d513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	lHFk46tiue08NBSc/QGBty9evQeovwC4WyaS8UI4/TdIwa5OidEa4NGENZXrRqmymA3HNulhJqxaAldIjeMEXz5o/AhwvkrToCSof8ZvHa9KLrgAoaj43k89Vtp4okRzJ6BAYX0OCIh1ftymsAVXQdDUy9x8rr9SCn4D/ssvfe5+K1++f1ur6LTVAO1smMGE9XAncf2nynreUOF+s39MZX/itaucvk7eOdJWPBVfh/l1HYWifgwV9VaHxNVyRgRFlRxG6Dt0nY8F1rFuCEx945sP7eHtofjKSBWWOhrONrw7ffIkriNqzBxAB6PjrUD50oQomVyrcI1fGlogjthsxVhBME17eQSgo5V2IbnT33r92tl0FnkxMf+sEvFj5JslW3fIQEyI5r4vDg7dpk1Dr6b23RUH9tLKvqKNfW1w7HxGJZls5wLNa4VRyWCBonGdTsnHInL+xt4oQP74UG0xQt+cXofGwX1o7l9B7iUz9dNz+jZZfFhSoGkwpc0g+sEkWzvY5fWX/d9OzIBpXFS67Dd8ncw7v/CpJeo8OTO/LlmJnm0DGrfwKU4ZGGsvXyau6aeO24wNlpiZoGcpejImrSEZuIT4VDyRrFSm3mltsXqnf4N/7UhyOr1/rT7VLvSptW9Y7ZWRf+atMXnuK7yMJjgnI+RUl6qSbJRHLe9U4COn/rLiGKE3mMhGdfHGoiyUtjTc3BOFHAa9duadT3Dc6hIFerk3cx6Z32939zhpxCo=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dZ0WeyyZ/Z87BppdD4MyrfXhKG/L9s6sZkDF+2R8GwDrfQ5IHeZRtb2j/Zzo8E4CqvjPhHOdkivPHDQAC18EXHVIjJtjP1jcajTf4/cPjRk1Hxq142g1+GVCK+jDph8/Dw86jDwh4Zftm6as9ox0cvtUncjMFvBJ5Ljbrz5x6p9mL82rrYjdYYowIJbf3YjnlK8I/bV6iLu0r5Nt2CKN3NiYgWoo9uo9yUQVhn7xwLM6sA89aMTq4CSMn6nzjYkRUPbAS7uQ4k7LNI2NxsZDJzsh7DfpkopVFJpLRFouW2aa/B3LLwMYOBSzzC+8Vq+78RiLFut9xHQUEbuF9499NJNXZ5YVoo8yIrqkc9bUPTAqU6tvcTG2DvwivSS80R6D5Bg4nKMvO7ikSWjvM4j8yRP27VF382Mc7m212V2nWlwG45IHZaBbm1t8jzWoT+im
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 06:28:22.6021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd171187-a021-4866-0f1c-08deb0b8d513
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514
X-Rspamd-Queue-Id: 8DDB652E15C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20549-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Gal Pressman <gal@nvidia.com>

If mlx5e_rx_res_rss_set_rxfh() fails during mlx5e_create_rxfh_context(),
the RSS context is not cleaned up.
This leaves a stale entry in 'res->rss[rss_idx]' that occupies a context
slot.

Destroy the RSS context before returning the error.

Fixes: 6c2509d44636 ("net/mlx5e: Add error flow for ethtool -X command")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index bb61e2179078..99a0034b9b20 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1574,8 +1574,11 @@ static int mlx5e_create_rxfh_context(struct net_device *dev,
 					rxfh->indir, rxfh->key,
 					hfunc == ETH_RSS_HASH_NO_CHANGE ? NULL : &hfunc,
 					rxfh->input_xfrm == RXH_XFRM_NO_CHANGE ? NULL : &symmetric);
-	if (err)
+	if (err) {
+		WARN_ON(mlx5e_rx_res_rss_destroy(priv->rx_res,
+						 rxfh->rss_context));
 		goto unlock;
+	}
 
 	mlx5e_rx_res_rss_get_rxfh(priv->rx_res, rxfh->rss_context,
 				  ethtool_rxfh_context_indir(ctx),

base-commit: f5b2772d14884f4be9e718644f1203d4d0e6f0d6
-- 
2.44.0


