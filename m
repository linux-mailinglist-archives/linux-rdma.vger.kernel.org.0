Return-Path: <linux-rdma+bounces-22833-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /pHBMzr9TGpttAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22833-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:20:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D2471BD38
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:20:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=gR4ZXMrP;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22833-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22833-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E11E930D7255
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 13:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE43A41612A;
	Tue,  7 Jul 2026 13:12:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013003.outbound.protection.outlook.com [40.93.196.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31185417363;
	Tue,  7 Jul 2026 13:12:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429945; cv=fail; b=LEunuc41Ca5eyCViUgP6qhzPIOye5xBIhSkvOYUXkGRXsM3QItavxoc+SjP3vocwvgNErWdtOXRcWsSoZz/glxiibu3VfvFOZd5ltBjTl9Tfn/tTgfL3ciEjXezBSls4ELNPXtZE2tSO9BizxgKOioHesIMWi5rs/1RYsV5rzPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429945; c=relaxed/simple;
	bh=LMigjh95xcJieFAzkhfMMmD0iWIu48rXGRlh636quPg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9UWr0477uRLw3VlZRjzY2oTWeD98brUB1gWjE0Hv1xQLK+pKa/FwYX2K2fes0eTjHGiMP8h+GHDs1NityuuW+vB7h1BFfbujrFRulIrG9hyAEiAzYhZrmm3UcD0oMxP8bid79+Zi+BZpkILkN+krSNQvSoL3tWpW9mKgYiAQqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gR4ZXMrP; arc=fail smtp.client-ip=40.93.196.3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlW5nYh8+4luH/OWo4qzlSeWFovRJkeN2hpQVsKjEohfw4XnMcNAPNg/ovmWv9HtrByJEGE3A71uPv8aejJpjqfS7nIiuhFJWLJn4EFlufM75fTYnd0dW/F8dZTZskI6jvUozEyOhKlxx9/Kd2eqiBwEv08tjWb04xnBo2OtPGsXZWGDPHrhLXz8vuZIkh+WBl0AY3xBd5pTeDDO5fRDlk0w/ES9znPGsEPULipAcbYRUKov9uNbOnj/fblZItV6fJ5GYyv8NzWWN70DNVEAOqJvQYtgUdKu5B7F2XvrfOwVtWx2+LPxcgCytEXCGJwEOXa+NiKtA3mXEvQl0H8eRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlnGEwMF+j0D4iXeUcvDFDuT7u9LOW0fBaozN7yyLHo=;
 b=PCjIXqe7J+qkw2BKr+yeIYzXs+ZrEM8qfl1yz/SL8r8/bO0QH4fdxHuKb8nP7E+7MunJDbpB3a8ah7GNX2qLtAGZxKy2IhHDa8ZKNQHDqysTVT8o+Y/HFHIe2vqFFR442/Y4LBwvt7lQGPGfhHLxIR899OlNJVL3gOl68FF2kxMxa1JrchgDjqW7S3lqsXz3DJo+btCOFwEaHHEYu9kk6AL+QSlofabJGsp3CmMb2O1MNnD7PL6Z0KwaZwZZvs1zQLRUNDWA5xqiK3ApTO3MZdEEH68+SZ0gxRQ5PddxlqqyMGDfr7A/XQDeIl6er5dylJb+/VorTSNK2Qn6l6NoHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlnGEwMF+j0D4iXeUcvDFDuT7u9LOW0fBaozN7yyLHo=;
 b=gR4ZXMrPMdIdlSi5h3WeqGiNXOPtNzaQJcKWpsvc4emOfHe8rb6WkLGnB48DLTNdaz+u5Yp7EjerVDo451EuLCyubNCTWx5kgjNFMIkFt1v400qUCMHJP5lB+bL5ExpLsRBpXMKjMOcfGi/dzpwo38+Y1xg1iBShu33M6UgSxl/MftEVZTVYKyS7LTZ1h1q56FexCparVLMgVwapRTxpqf+ADL2Ftkf2Ry2+QW76D9aB6pDVXlTz85U0MFIk++Ap/8IUKhFOYqkYtN8QY50O6x9sjgEkgCbNEmehQIr4S0O1J5T8+Il7r197d6s93zClqXDswbMEznA8JgWxM2Y0ng==
Received: from MN0PR02CA0011.namprd02.prod.outlook.com (2603:10b6:208:530::33)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 13:12:17 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::60) by MN0PR02CA0011.outlook.office365.com
 (2603:10b6:208:530::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 13:12:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 13:12:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:11:45 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:11:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Jul
 2026 06:11:37 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Boris Pismenny
	<borisp@nvidia.com>, Chris Mi <cmi@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Jianbo Liu <jianbol@nvidia.com>, Lama Kayal
	<lkayal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Raed Salem <raeds@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Stanislav Fomichev <sdf.kernel@gmail.com>,
	"Tariq Toukan" <tariqt@nvidia.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next 14/15] net/mlx5e: Return errors from profile->enable
Date: Tue, 7 Jul 2026 16:08:57 +0300
Message-ID: <20260707130858.969928-15-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260707130858.969928-1-tariqt@nvidia.com>
References: <20260707130858.969928-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|IA0PR12MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc95463-724b-413b-896f-08dedc295f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|7416014|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	5mxeqQz0jVtKrX2Woecqz4dsmHp1F881WObR+Zt8WpX1clMH+XFNO57PFXziJPg/py2PEJIkWzEN1TrPwAnEEoi5AUndGIlUNaJv2yf/9xdQe6KIhW6Vm+XQnPYE4u50qQ/JUd0DesqduN0KElQnaL8czZ+AUvzJguBtEwYcCGq03MI1kBMrr2MV7FMhIk1/m8fv+QkDtnKrF1GLSg0v6RK15qhCt4v1jaW6N9frSqQ904NWaJutnWnAkB1mYAKK42H+i3Kza33lMWRGr6xrWV7Zt1MKF7mebW4gU+P/EMAsd2tvi3Y5AOI1SQdYNCwYBTbusKnmBARMY1OYm6T1MlmbYuwAZhUE6H+kWUawghG9g2yGmKMcEpOMMqanXWfj85Rb8BhT4g4RMDdJf7jUd9zSvCc2DXxHDosdPqZXWf18SXXPMc/9j/G7+A5z+AlSn8Q08M1FIJw2GVj/jAoG7aCuzg1giMYMGytcT3XN8Q/wS/L5vg8BNtfHDyutWzPvhJce4AX9nSlclwSXMURZkHyVvanN8sPccWzhQaaqDU7/la6IOAVfr0npvbVopo+HHbESTCNPdfTpFBGg2iAzKkYSFe843kuEuZkbS4oOUXbGZEAIe/Nu0tsIZN9ndJiiisa7fgVloj0vUydwudF6EDCzJWmFLuuNeTsrB8JO/38y7KDVQC3FMS47e/6P03LunvVc3eWjxvbOQhqUonDm2g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(7416014)(376014)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/6l1jA0VZdpCF6zLKEKbArBHnQCzUmLlDHelHG2LWgrx7JgQLpCHNin18bgnjBCK2+dU31G8gzAUqqS3H9hTjf2GG0Vw5TBCCb5SCkUfmFQbOSoLGF7FcJv4m+Pjt/AiOdob6pEw0ht/xw07kZ7F91B38pa/VsY8aCMHCPYcLvJ5eA3pf2fNvI2lbqf1+TEZiXWO1RWKrbH/Rs3KoL5jFYHbFGuCbo8nOhq236ntJWc6mE2y9K7PgzaCF0Kd+auLs/+cy5apQ/mfSUSEAwnU/PlygtNUjc2xNoZQZz3SIOjpLgbJ7OXZIMpmDsIlnCDGCZEU/eQ8a4GTQtDTjb5B1KAiwBKW5Uo2cuQn+6ziHDzar9PP02qy8cSTdKlm1Ffl2kDvEk1A0+vjlonL4pcGFTddJ16RIJZeJZtOkn82yruuQjsBDFRVRW/9qM0DEHQw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:12:17.7599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc95463-724b-413b-896f-08dedc295f0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:aleksandr.loktionov@intel.com,m:borisp@nvidia.com,m:cmi@nvidia.com,m:cratiu@nvidia.com,m:daniel.zahka@gmail.com,m:dtatulea@nvidia.com,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:jianbol@nvidia.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:raeds@nvidia.com,m:rrameshbabu@nvidia.com,m:saeedm@nvidia.com,m:sdf@fomichev.me,m:sdf.kernel@gmail.com,m:tariqt@nvidia.com,m:willemdebruijn.kernel@gmail.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:sdfkernel@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22833-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,nvidia.com,gmail.com,kernel.org,vger.kernel.org,fomichev.me];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16D2471BD38

From: Cosmin Ratiu <cratiu@nvidia.com>

profile->enable is called before enabling an mlx5 netdevice and
currently doesn't return errors. Code called from it has to either:
1. eat errors and keep going, leaving a netdevice initialized with
   missing functionality
or
2. manually clean up things that other parts of the init flow might have
   set up.

Option 1 might be useful in some cases for optional functionality but
option 2 doesn't make for good design.

Add a 3rd option for code which wants to propagate errors from
profile->enable and fail netdev init. This change is a noop for now, the
first 'user' of this option 3 will be in the next patch.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 15 +++++++++++----
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c  |  8 ++++++--
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 2270e2e550dd..3cc7283b6215 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1016,7 +1016,7 @@ struct mlx5e_profile {
 	void	(*cleanup_rx)(struct mlx5e_priv *priv);
 	int	(*init_tx)(struct mlx5e_priv *priv);
 	void	(*cleanup_tx)(struct mlx5e_priv *priv);
-	void	(*enable)(struct mlx5e_priv *priv);
+	int	(*enable)(struct mlx5e_priv *priv);
 	void	(*disable)(struct mlx5e_priv *priv);
 	int	(*update_rx)(struct mlx5e_priv *priv);
 	void	(*update_stats)(struct mlx5e_priv *priv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 775f0c6e55c9..9eadd0b6f055 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6191,7 +6191,7 @@ static int mlx5e_init_nic_tx(struct mlx5e_priv *priv)
 	return 0;
 }
 
-static void mlx5e_nic_enable(struct mlx5e_priv *priv)
+static int mlx5e_nic_enable(struct mlx5e_priv *priv)
 {
 	struct net_device *netdev = priv->netdev;
 	struct mlx5_core_dev *mdev = priv->mdev;
@@ -6222,7 +6222,7 @@ static void mlx5e_nic_enable(struct mlx5e_priv *priv)
 	mlx5e_pcie_cong_event_init(priv);
 	mlx5e_hv_vhca_stats_create(priv);
 	if (netdev->reg_state != NETREG_REGISTERED)
-		return;
+		return 0;
 	mlx5e_dcbnl_init_app(priv);
 
 	mlx5e_nic_set_rx_mode(priv);
@@ -6235,6 +6235,8 @@ static void mlx5e_nic_enable(struct mlx5e_priv *priv)
 	netdev_unlock(netdev);
 	netif_device_attach(netdev);
 	rtnl_unlock();
+
+	return 0;
 }
 
 static void mlx5e_nic_disable(struct mlx5e_priv *priv)
@@ -6616,13 +6618,18 @@ int mlx5e_attach_netdev(struct mlx5e_priv *priv)
 	if (err)
 		goto err_cleanup_tx;
 
-	if (profile->enable)
-		profile->enable(priv);
+	if (profile->enable) {
+		err = profile->enable(priv);
+		if (err)
+			goto err_cleanup_rx;
+	}
 
 	mlx5e_update_features(priv->netdev);
 
 	return 0;
 
+err_cleanup_rx:
+	profile->cleanup_rx(priv);
 err_cleanup_tx:
 	profile->cleanup_tx(priv);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index c8b76d301c92..603051ab1eaa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1262,9 +1262,11 @@ static void mlx5e_cleanup_rep_tx(struct mlx5e_priv *priv)
 	mlx5e_rep_neigh_cleanup(rpriv);
 }
 
-static void mlx5e_rep_enable(struct mlx5e_priv *priv)
+static int mlx5e_rep_enable(struct mlx5e_priv *priv)
 {
 	mlx5e_set_netdev_mtu_boundaries(priv);
+
+	return 0;
 }
 
 static void mlx5e_rep_disable(struct mlx5e_priv *priv)
@@ -1322,7 +1324,7 @@ static int uplink_rep_async_event(struct notifier_block *nb, unsigned long event
 	return NOTIFY_DONE;
 }
 
-static void mlx5e_uplink_rep_enable(struct mlx5e_priv *priv)
+static int mlx5e_uplink_rep_enable(struct mlx5e_priv *priv)
 {
 	struct net_device *netdev = priv->netdev;
 	struct mlx5_core_dev *mdev = priv->mdev;
@@ -1357,6 +1359,8 @@ static void mlx5e_uplink_rep_enable(struct mlx5e_priv *priv)
 	netdev_unlock(netdev);
 	netif_device_attach(netdev);
 	rtnl_unlock();
+
+	return 0;
 }
 
 static void mlx5e_uplink_rep_disable(struct mlx5e_priv *priv)
-- 
2.44.0


