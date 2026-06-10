Return-Path: <linux-rdma+bounces-22082-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NKNZB+OOKWoCZgMAu9opvQ
	(envelope-from <linux-rdma+bounces-22082-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 18:20:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F10E66B5A7
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 18:20:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=xOO+iygd;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22082-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22082-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC86935D830D
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 15:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEFE481FA6;
	Wed, 10 Jun 2026 15:42:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C645D48166E;
	Wed, 10 Jun 2026 15:42:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106162; cv=fail; b=q2AZ51/mBkXZ1ACQLiHrtjk01GM+lqq4ATZk86SP37ai1oQZhR4Y7ljxZcw1KMUUyWzb6vvDiTWldxjmsqN9gbR1LFbr32ADyXaRE4nsBYuh3Y+GtrXsjS4yKXESin/NPGAd5ON9Uy1fUuXW7M9kkBMiZ1Q5LoXUkszpEJddvpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106162; c=relaxed/simple;
	bh=g2eAC0nTAsyf3f5vlBbl0etdU3jPb+G0qabANnsbes8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CXfFvDpqa71wxQpsPzOp0bDt7Sp5AwVle/9XNwlI8OJJxwVY5PBXaIKtkVpt2ZBoGAZbnWXTXZDCJqZE3sVJKAv92ll15NsdpnVbrzSgdCyZlCF1HNG4BPpFHlqLg8WBlV74wTRkSgbYToabDtiti52OiRGMdz5v5ZKKEczts9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xOO+iygd; arc=fail smtp.client-ip=52.101.62.42
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbOcX/UAiLQntyNQfwcGf6XK1bUi58nR8v6DTPMa/5vUOiG3SeykIKidebqkHDuV01yFZq1QqAHNwv+2ufDiFkjcgGBnhT0pr5dThHIxZ8z2o+OKpNiDRLD7l9GcFJFgT2+oW6RMzWKuYJgIMQv7fsZM1eZhVzpwPRPHLK78LnJxg25xL7suS/rJ4byl+O0q7tN0B0WtPKYgtPHLhxufqEo1F2EI93YJNFceGR4sxYwoJJz+fGA+0xk32aj90ljHC2nveE1FoU7bQOFZpgO09EGvoRCQRsVThRM9AEassOF5UqpizyJHfk6zhF0fLtWLYkN1HqSqvcip/U6anaDjDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3lDx+rFY2zdyfhCSXmzK1+iP6NdBIiGSsSOuKSLJQs=;
 b=UUvfL6KWWjDRtaMArDEnqGuVP0UU5/sCrcr4CYWeQet4UA+GDt7ctdeIJ/Kgd4sxBf2hmm7foFi1ndg3G5QhpnIn3EfdL6G+l3h3+ho6wQNVCnP9Hsw1w8/UbmWhnIPXVWR0h2xb6X9M+Bdc3e3TouM7dhdAgY5xdBVmwVk+WqEFAcQB46hr5gAyOjt9OSazMIB9OJEDxog4/XE2pcth6gDfFXT15wweOwgqkjNR5fosWTufg1BYKeh5Z693K+dnPYloPuddjtBuvyF7sANW+I2Ruz3tdEcju3vOBIrdw9LWSpnoTfewFMMkA0l3llyRiz0px4dyNeftBG/jxVh0zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3lDx+rFY2zdyfhCSXmzK1+iP6NdBIiGSsSOuKSLJQs=;
 b=xOO+iygd28Ly8xhNQr9eLFN9CmTrlaXYQDXgo0wOf0UhBT2GbTueiqkWW25imYaS5fcnSCbdkhBXa7h36ZQ5jLWkokoWbw1zA0o/7HMG40b8niJbldLqRMobd+ZLZFaD8e4CUkw7yvZcDIOEDp+xDCrogctqHEgmErxdnVI7rJY=
Received: from CH2PR07CA0042.namprd07.prod.outlook.com (2603:10b6:610:5b::16)
 by LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 15:42:35 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::64) by CH2PR07CA0042.outlook.office365.com
 (2603:10b6:610:5b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Wed,
 10 Jun 2026 15:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 15:42:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 10:42:32 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 10:42:28 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dwmw2@infradead.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [for-next v4 1/5] net: ionic: register PHC for rdma timestamping
Date: Wed, 10 Jun 2026 21:12:12 +0530
Message-ID: <20260610154216.712374-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610154216.712374-1-abhijit.gangurde@amd.com>
References: <20260610154216.712374-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|LV2PR12MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a329e6-aa7f-4854-01ce-08dec706e476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|23010399003|36860700016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	XMM+sxNBh5c5o1yg/jWtygac3hZplGwztm4WlKAdTRJy92x9L+HB4c67zlDahp5qHJozsw8knu7D5C9MAcOen6eWSNUZacxueNKxac/HzvFnq2VCoGd1aJnqP4gdRMjha03J09ZfLv/27VfQ54l2WpT45SIDNmSCnw3TUQFfkyK3F/E+R+JTEhuWDvrjCa7m+leu8SrxdqM0OTJvwthhbOpkhGzl2ofKRtjDOCjY/wlh3HWzfb0vXW2NdSstx9lzgCITJ1fP7gm8cN2d2xxkMchxgHn6OKs9FXD29tbdu+AORPi5Pv8kC+MjeZohWmfhLKJcpBZa83De+XZyx9OKbnQYxQuLY42ff4KdZ6Wp4T5bQvtZTgvEso25pOp6W5aKqCL4K81OtpeE1xJMDz3ZH6E1rnqtyck41lqpcqcs+k0M121K2q1whfuUNZj4/0jchdlSR/sGFvmtFs62KU8x6ZhtCGGaaG/o7CHmK1GFp7w2iT9OnaQwUnI+Yx9x+sI0VcssexGWbsqZA+tIMs33elLHpkulneY6G4vZZuRtu4RydVlXMa9ujousZuE/aTmqC/KURW6CkdGmwLwhpyr/yJrn4IbL2iNqKcYMUS7DCIPevEuG3McZa6QdcF2Qyq41MWwDT+hp478Txd2+bHXea4cqVqkgNmKlApKXsY9HfKjjJo0VlT2bMF25aBarK2PBAViKDb2JrcSonEW7GqIe/2mouo+fcC1EMW9/xvGAJFY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hI724LqG1OFGHVSYFwEH4cTQ4H24tFqoV21Oqz9mTX9vdHeGN4znPQM0vp9Tg1y63GzfVv+aNF4vckboMAgN5wvwScbbwDH/cnefCabTzK089hg7XLhvma60YO3+ko7pYSWC6O0IqT9/GW5JnFp548+Y8TjeMyxphkFg5CFGsxXDCpaFyL/3wsg7cgCVaS2pBUE5Rl850+WpxX3O3PRwkFhZIyQbRDuYf9n7LAVYNj49PEryvJYluoMIsIFJiKw+HGQUIJLhMuFIMYnDoLY/Ox5sAsQqc2gn7T2dns/Nk1Z5WRWZUcs1O7NfaT1s4Mznv5YrfLhy9qsp2wOkT1smdLHg1OPjOnp+VBfx27JJemgosenmW9dDQ8YJ0CC3Vu6eaksKLj6+51pfM1Myd3ISS73MjWSnVW5zuTe996hFk7jlp68r41l4mJZGA6bA7B7/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 15:42:34.9317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a329e6-aa7f-4854-01ce-08dec706e476
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-22082-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:allen.hubbe@amd.com,m:nikhil.agarwal@amd.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dwmw2@infradead.org,m:abhijit.gangurde@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F10E66B5A7

Currently, the driver only registers the PTP Hardware Clock (PHC) if
Ethernet hardware timestamping is supported. Update the registration
logic to register the PHC if the device supports either Ethernet
hardware timestamping or RDMA completion timestamping.

Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 .../ethernet/pensando/ionic/ionic_ethtool.c   | 12 +++++++----
 .../net/ethernet/pensando/ionic/ionic_if.h    |  1 +
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  5 ++++-
 .../net/ethernet/pensando/ionic/ionic_phc.c   | 20 ++++++++++++-------
 4 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 78a802eb159f..154ea1bef85d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -1018,10 +1018,14 @@ static int ionic_get_ts_info(struct net_device *netdev,
 
 	info->phc_index = ptp_clock_index(lif->phc->ptp);
 
-	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-				SOF_TIMESTAMPING_TX_HARDWARE |
-				SOF_TIMESTAMPING_RX_HARDWARE |
-				SOF_TIMESTAMPING_RAW_HARDWARE;
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
+
+	if (!(lif->hw_features & IONIC_ETH_HW_TIMESTAMP))
+		return 0;
+
+	info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
+				 SOF_TIMESTAMPING_RX_HARDWARE |
+				 SOF_TIMESTAMPING_RAW_HARDWARE;
 
 	/* tx modes */
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index 23d6e2b4791e..49d451c686b7 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_if.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_if.h
@@ -1179,6 +1179,7 @@ enum ionic_eth_hw_features {
 	IONIC_ETH_HW_TX_CSUM_GENEVE	= BIT(18),
 	IONIC_ETH_HW_TSO_GENEVE		= BIT(19),
 	IONIC_ETH_HW_TIMESTAMP		= BIT(20),
+	IONIC_ETH_HW_RDMA_TIMESTAMP	= BIT(21),
 };
 
 /**
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 637e635bbf03..9d86f795f5f6 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -1498,7 +1498,8 @@ static int ionic_set_nic_features(struct ionic_lif *lif,
 	ctx.cmd.lif_setattr.features = ionic_netdev_features_to_nic(features);
 
 	if (lif->phc)
-		ctx.cmd.lif_setattr.features |= cpu_to_le64(IONIC_ETH_HW_TIMESTAMP);
+		ctx.cmd.lif_setattr.features |= lif->ionic->ident.lif.eth.config.features &
+			cpu_to_le64(IONIC_ETH_HW_TIMESTAMP | IONIC_ETH_HW_RDMA_TIMESTAMP);
 
 	err = ionic_adminq_post_wait(lif, &ctx);
 	if (err)
@@ -1549,6 +1550,8 @@ static int ionic_set_nic_features(struct ionic_lif *lif,
 		dev_dbg(dev, "feature ETH_HW_TSO_UDP_CSUM\n");
 	if (lif->hw_features & IONIC_ETH_HW_TIMESTAMP)
 		dev_dbg(dev, "feature ETH_HW_TIMESTAMP\n");
+	if (lif->hw_features & IONIC_ETH_HW_RDMA_TIMESTAMP)
+		dev_dbg(dev, "feature ETH_HW_RDMA_TIMESTAMP\n");
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_phc.c b/drivers/net/ethernet/pensando/ionic/ionic_phc.c
index 05b44fc482f8..116408099974 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_phc.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_phc.c
@@ -77,7 +77,8 @@ static int ionic_lif_hwstamp_set_ts_config(struct ionic_lif *lif,
 	bool rx_all;
 	__le64 mask;
 
-	if (!lif->phc || !lif->phc->ptp)
+	if (!lif->phc || !lif->phc->ptp ||
+	    !(lif->hw_features & IONIC_ETH_HW_TIMESTAMP))
 		return -EOPNOTSUPP;
 
 	mutex_lock(&lif->phc->config_lock);
@@ -210,7 +211,8 @@ int ionic_hwstamp_set(struct net_device *netdev,
 	struct ionic_lif *lif = netdev_priv(netdev);
 	int err;
 
-	if (!lif->phc || !lif->phc->ptp)
+	if (!lif->phc || !lif->phc->ptp ||
+	    !(lif->hw_features & IONIC_ETH_HW_TIMESTAMP))
 		return -EOPNOTSUPP;
 
 	mutex_lock(&lif->queue_lock);
@@ -228,7 +230,8 @@ void ionic_lif_hwstamp_replay(struct ionic_lif *lif)
 {
 	int err;
 
-	if (!lif->phc || !lif->phc->ptp)
+	if (!lif->phc || !lif->phc->ptp ||
+	    !(lif->hw_features & IONIC_ETH_HW_TIMESTAMP))
 		return;
 
 	mutex_lock(&lif->queue_lock);
@@ -242,7 +245,8 @@ void ionic_lif_hwstamp_recreate_queues(struct ionic_lif *lif)
 {
 	int err;
 
-	if (!lif->phc || !lif->phc->ptp)
+	if (!lif->phc || !lif->phc->ptp ||
+	    !(lif->hw_features & IONIC_ETH_HW_TIMESTAMP))
 		return;
 
 	mutex_lock(&lif->phc->config_lock);
@@ -267,7 +271,8 @@ int ionic_hwstamp_get(struct net_device *netdev,
 {
 	struct ionic_lif *lif = netdev_priv(netdev);
 
-	if (!lif->phc || !lif->phc->ptp)
+	if (!lif->phc || !lif->phc->ptp ||
+	    !(lif->hw_features & IONIC_ETH_HW_TIMESTAMP))
 		return -EOPNOTSUPP;
 
 	mutex_lock(&lif->phc->config_lock);
@@ -506,7 +511,8 @@ static const struct ptp_clock_info ionic_ptp_info = {
 
 void ionic_lif_register_phc(struct ionic_lif *lif)
 {
-	if (!lif->phc || !(lif->hw_features & IONIC_ETH_HW_TIMESTAMP))
+	if (!lif->phc ||
+	    !(lif->hw_features & (IONIC_ETH_HW_TIMESTAMP | IONIC_ETH_HW_RDMA_TIMESTAMP)))
 		return;
 
 	lif->phc->ptp = ptp_clock_register(&lif->phc->ptp_info, lif->ionic->dev);
@@ -545,7 +551,7 @@ void ionic_lif_alloc_phc(struct ionic_lif *lif)
 		return;
 
 	features = le64_to_cpu(ionic->ident.lif.eth.config.features);
-	if (!(features & IONIC_ETH_HW_TIMESTAMP))
+	if (!(features & (IONIC_ETH_HW_TIMESTAMP | IONIC_ETH_HW_RDMA_TIMESTAMP)))
 		return;
 
 	phc = devm_kzalloc(ionic->dev, sizeof(*phc), GFP_KERNEL);
-- 
2.43.0


