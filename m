Return-Path: <linux-rdma+bounces-21890-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 394ADgSrI2odwwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21890-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 07:07:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A55E964C80B
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 07:07:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=hwAphD2K;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21890-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21890-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 346F730732C0
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Jun 2026 05:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E573009E1;
	Sat,  6 Jun 2026 05:00:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013007.outbound.protection.outlook.com [40.93.196.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7B0305692;
	Sat,  6 Jun 2026 05:00:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780722027; cv=fail; b=RvtuLSjZBL9o9ZgZrcTv0BId8xza0LFZaSFoew2KZGVyoAPxRLvY6uWpUdoC2hlyw8FjA1ja5BQSQIMd7K8mfJbJRO/q52W/mFtP91K0AHqXGesDEO40wGkkfFcZ69/0hPHJ3KEuagyEtVYg6MaHYd1FRzqPEtTw0zjpMLePW7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780722027; c=relaxed/simple;
	bh=IjST8vZIALvzLYyb8n7MgJiMD2i4/LpKK/fsA2k1PGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mY02V/zdMNH3GOfN7gUPxQAHrNtXMcfgb8flz4uRrdCp2aPZ9eB+3yu+V07kjJ3qDQwSMA9T1lnnrPTpRI/weRZoEwmlacCRWZ5Q/mfRuBSaIkUb6kuXd2hjeT1aIP6wbk/u3Z0UXr5OBcQFkQXRHm6yX05INadSaQxE8ARKrSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hwAphD2K; arc=fail smtp.client-ip=40.93.196.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcVkY46rd57XmvfsoLLA7eJXCmtfvJx2WNaFVFA0x5sbXVCoE0jBQ4T6mbvQiZ4inL6NFATq7lIJE7XMHQf8kqWlGABL8BJ3jTIU8llEoE/TqAfTexXZWlfNx+2Ybu5Ne1WlEqWGB6GysAzI8pmnwYOPoRUzONySVnDUIyDrgwuOZBz8qCFxKZvR5QQMQTjN4JJBsoEi/RmzE6GC3zRwCZ9OdpbMI/021NXN7kUbaCrvVGWy1ODa3QoerSCd2C7KNEY4Z1y4ULhWoJ4wo8qYS3f1u8U1LLCwhBj3Z9EYbgnpSVBh92hzFtKbAbatQMiHsyK0xnMygNic41+C0/hbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S//2UJiHLTwgfj/LXgoJslXzZYdA6b4Gqj8qJIJPv40=;
 b=MRJzPQbBYWf3SFuQAV9hAWjD6NfLlCGIWgNABfFgYLvCTo+KGtYn4EVc2qLx8etrQgUmC+Fft0h6EqISFDyNjkOsQ6ci3qPmSwHiAKEu1Kea1azRpqAf+oZQJH3ymgojZnlEm7pcWZ62IGhgnL+rJYFeLNtsSd2l21tMCT4tFA5EhsL0Bn9jNNZDUvIkzbmcwT+l0GwPKVbf9RoMu4n3XtIQH7YYVH+SLGDWFyex3laBeALKMTtpBQ7bYxFd+EKCx3rUhjLxsL9aQyYY0EJFJGTi7fm5+UKWi8cMO/K8FyMNWAj9SCS8W9D8z9eMJXejWw97PzpQmEkw6lUAKtea8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S//2UJiHLTwgfj/LXgoJslXzZYdA6b4Gqj8qJIJPv40=;
 b=hwAphD2Kz0NLRLPQmCP1CyMh+BvHH8QAiVscGDputuwpoxRUUKtiwidMeNjYnoRHWvWhgJ6Yq7UVOrE10H+dIV2MaCRuXODE4Aw3jOm/1R+IJ2uSAT9dMQPS/cM5hhY20W4VJBcP7Bx4ajm5rnBNPa15kzRTe99wbbTGjNc9Wjc=
Received: from BLAPR03CA0110.namprd03.prod.outlook.com (2603:10b6:208:32a::25)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sat, 6 Jun 2026
 05:00:22 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::37) by BLAPR03CA0110.outlook.office365.com
 (2603:10b6:208:32a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.10 via Frontend Transport; Sat, 6
 Jun 2026 05:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sat, 6 Jun 2026 05:00:21 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 6 Jun
 2026 00:00:19 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 6 Jun 2026 00:00:15 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [for-next v3 1/5] net: ionic: register PHC for rdma timestamping
Date: Sat, 6 Jun 2026 10:29:59 +0530
Message-ID: <20260606050003.3648306-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260606050003.3648306-1-abhijit.gangurde@amd.com>
References: <20260606050003.3648306-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DM6PR12MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b8177a-0e2f-47e7-f6f6-08dec3888342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|22082099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	+3t5MjR9K45jFMdLq6ASTq20BZ8k+EU4HKtdIppfkdJnuKnTxW//3Z+i6UVs3Awz87dCHYxHJbuuePQQ8VTVAnZythksNUXizn4trOirPCAvB61GyzysJTJWrPzdr2gls/t4WiZvKEWOqjwKQPpp0KU5yPBLpUNYZvKK9F85U4YKOjPvPrmOIoRWS8Aurf4Ifmyb5EpuWKmrLG8EcDT3AySTwj/o2CuhGEOzmnZnJhj/JRv/UfnnLtl97nPiLpbcsUfUeT8zR63NcvwsWG+9/UBo5KOlmVr2/AZafx/fXF/xybKONA7OUmQUL5PJeig3b1QHFCF8WDKrJqCOFkBi1RQJu+vnI/sk6916jWfjk0Pw5/e0PiIUKxjjisdRv6WxU6qfEJHwTcqFwTPIF7eT/kCYXWo8huk484qDivpWOt0MIuE1Z9oeXZTQ8DspOw0jNJkbr/gBmuhJUlR7OzBWfsp7NnRf0N8z9GITZsLQ0vSAQizBVGGIy0XOyPaNlRiR/6EVUFwPztIoaKWdR5KlBzC6jb44Dd4CX+wU6ncBk8ny1z7uV2KYpgCiZEv7JRE1A+1jR1bay0a6hwnN892GOYFuqpJfrkvl+PWwCrvZUYJbwC9qF/fgPHADBS2RBXOI5+MLKNBlP829ZzEsBHZgzVG9Jyr5r+AwWBLvVmU0bM8X9QAN9UEEOUrLd4eLRYeE+tTaMFWeKvgkDFAdHsi3UoUYgNu6Rchhv+ksEVR2Y7Q=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(22082099003)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	huflukWCSeDCdILLuNCfyYQIhr8yzOCKs1oRfnSV/Z2uzJ1+yrhPZEaTup0ERGsZuq4+BTye3Xc2rqz1PbHdUso0sxk5DsgqbdET3IljWTOxOIX3aLfyRn/roXWO2JE7LXArsjW3bijbL3Xhzu72560GKtbQ0U7UMX7dIgpOOwjvN5Y8LMcPUMY9/onR/8UDsZN6alrKw4xJUKz5v+Ttaoyo8N1myV978nv/XQww9AuvUKsy92VpHjadbovm7P4w1aa9zY56VjZYr3DSZMFTkza+aYOw7Rtidv8LrrE9PVfS1PlLgmk8L2q/dHtMIEICxvXS5ZBvGcLm5CfWh0NF/57O6u+KVi8N6GJeE2WmmpP4tLzLH4Fcet8jNlXZajueKPZfUnUjlm2p6PiqE6dvWPh8knSIPrhn9jqivgPTrgDKdQQey78naOHW5R5Yso5b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2026 05:00:21.7999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b8177a-0e2f-47e7-f6f6-08dec3888342
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-21890-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:allen.hubbe@amd.com,m:nikhil.agarwal@amd.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:abhijit.gangurde@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:mid,amd.com:dkim,amd.com:from_mime,amd.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A55E964C80B

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
index 2d9efadb5d2a..c0a0ec0c718e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -1026,10 +1026,14 @@ static int ionic_get_ts_info(struct net_device *netdev,
 
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
index 47559c909c8b..3c34d5913729 100644
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
index b28966ae50c2..e23491dc9d4d 100644
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
index 9f5c81d44f99..1e4e7772bd5d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_phc.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_phc.c
@@ -76,7 +76,8 @@ static int ionic_lif_hwstamp_set_ts_config(struct ionic_lif *lif,
 	bool rx_all;
 	__le64 mask;
 
-	if (!lif->phc || !lif->phc->ptp)
+	if (!lif->phc || !lif->phc->ptp ||
+	    !(lif->hw_features & IONIC_ETH_HW_TIMESTAMP))
 		return -EOPNOTSUPP;
 
 	mutex_lock(&lif->phc->config_lock);
@@ -188,7 +189,8 @@ int ionic_lif_hwstamp_set(struct ionic_lif *lif, struct ifreq *ifr)
 	struct hwtstamp_config config;
 	int err;
 
-	if (!lif->phc || !lif->phc->ptp)
+	if (!lif->phc || !lif->phc->ptp ||
+	    !(lif->hw_features & IONIC_ETH_HW_TIMESTAMP))
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
@@ -212,7 +214,8 @@ void ionic_lif_hwstamp_replay(struct ionic_lif *lif)
 {
 	int err;
 
-	if (!lif->phc || !lif->phc->ptp)
+	if (!lif->phc || !lif->phc->ptp ||
+	    !(lif->hw_features & IONIC_ETH_HW_TIMESTAMP))
 		return;
 
 	mutex_lock(&lif->queue_lock);
@@ -226,7 +229,8 @@ void ionic_lif_hwstamp_recreate_queues(struct ionic_lif *lif)
 {
 	int err;
 
-	if (!lif->phc || !lif->phc->ptp)
+	if (!lif->phc || !lif->phc->ptp ||
+	    !(lif->hw_features & IONIC_ETH_HW_TIMESTAMP))
 		return;
 
 	mutex_lock(&lif->phc->config_lock);
@@ -250,7 +254,8 @@ int ionic_lif_hwstamp_get(struct ionic_lif *lif, struct ifreq *ifr)
 {
 	struct hwtstamp_config config;
 
-	if (!lif->phc || !lif->phc->ptp)
+	if (!lif->phc || !lif->phc->ptp ||
+	    !(lif->hw_features & IONIC_ETH_HW_TIMESTAMP))
 		return -EOPNOTSUPP;
 
 	mutex_lock(&lif->phc->config_lock);
@@ -491,7 +496,8 @@ static const struct ptp_clock_info ionic_ptp_info = {
 
 void ionic_lif_register_phc(struct ionic_lif *lif)
 {
-	if (!lif->phc || !(lif->hw_features & IONIC_ETH_HW_TIMESTAMP))
+	if (!lif->phc ||
+	    !(lif->hw_features & (IONIC_ETH_HW_TIMESTAMP | IONIC_ETH_HW_RDMA_TIMESTAMP)))
 		return;
 
 	lif->phc->ptp = ptp_clock_register(&lif->phc->ptp_info, lif->ionic->dev);
@@ -530,7 +536,7 @@ void ionic_lif_alloc_phc(struct ionic_lif *lif)
 		return;
 
 	features = le64_to_cpu(ionic->ident.lif.eth.config.features);
-	if (!(features & IONIC_ETH_HW_TIMESTAMP))
+	if (!(features & (IONIC_ETH_HW_TIMESTAMP | IONIC_ETH_HW_RDMA_TIMESTAMP)))
 		return;
 
 	phc = devm_kzalloc(ionic->dev, sizeof(*phc), GFP_KERNEL);
-- 
2.43.0


