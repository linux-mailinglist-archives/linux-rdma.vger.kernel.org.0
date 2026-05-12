Return-Path: <linux-rdma+bounces-20470-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPnWGUbzAmo9zAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20470-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 11:30:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD21251DBF3
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 11:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0DCA30A3459
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 09:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003D749552C;
	Tue, 12 May 2026 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uK0QWA6S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013048.outbound.protection.outlook.com [40.107.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F859379C43;
	Tue, 12 May 2026 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578012; cv=fail; b=GWT2VUiTpetHY4/0zCuWk/TvHLolFNaQIYEH7Bjrf1PgIBRU7wSC5JlQcw1EfjOsJRlsegNNtKslVCA0Efh2sNHJDxHOkZryk32P3k9+4qGODPnaI8/7N2rZoT8+fjElapncWxJHlmxz+8j4yaeFOWNJHOjxFhp5K4ej4izgDh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578012; c=relaxed/simple;
	bh=h58ngd7/kPLTVO+PqCtZ3x4djLe5jBJTwA1jNnWLGwA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuHEbwXg4NFVz9b64QLggo52+f2DQl5jBt32DA1a4TV0Tyyo2qLo2oxrqgd4I1pQbVkBXtahbv0qbl6iZSQIUExQN4Fo+722lMksuW8r+4EXLT+xjmP0Z61x+QtXgteOBKKebT2U38LDCSZQb5woUyNDwZVSWYoTTjv2TNwuIoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uK0QWA6S; arc=fail smtp.client-ip=40.107.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qacKTw69UsM1lOz1BZQIusux58cAIky7l2/EgzLtKoT/KEPKKf+ilL15QyURxrZgoH2jfRkqONh5EA5Y7C7jREUXl6gqCoF/L7vtV9itkkvnTz8PbEs4uvMwxxqejdElYsOhtyKAGN4FOC9s+PqwLoP+HQRRNsMVqEkD7x1YJSbw6VRIHDwEu4gheM6Zb+ZN6JV3cGSSGyzJgXS0YwME7n8O9Ent5wNHTSfYfBLKzZB0MD3/q/LJ8K0x9QdBeNETL69A/P8J0QPDm22pNDdPmip3nmH8p/pLr1FV8QDPdC7Pd5YH30ZrMPXJCTBxH4NnqUIjkioVfiLgXBTu69n70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zq5TrdfXYbvbUkeBYyFZ5xf0YvASFaKz2iFYBX0Amkw=;
 b=XPA5tUT4Kxs4Dg/PyCLbPaLPklPYib3tyAJfPVpn1TqAwXbvnkXeiugOCyLjkM+QTEkVp8humzQOgg+zv/5sUxid859gvULDs+8vNWYaAHU4pfC4D5fqT1q7JK7aFXO5iiGtH9kJeIY5ip/uNOGvgl/VIUf99RacV/BlX8PT3/Dks7s6YZiSUnpzmMR+AXtV7TL2IgvpLkcaeBIBBqy0EAt5yZONmz+RVXwWUDqvDFpyraxQKo5Zta39yQJlEvBejm+oCSqNaJM4eo13Aq4BSk0KU/Lf6QfM61EksTCIjMozmlp1JF+i0mRnenqjVMOf/HSty+KlB34nqPTrzlEolA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zq5TrdfXYbvbUkeBYyFZ5xf0YvASFaKz2iFYBX0Amkw=;
 b=uK0QWA6SHTNGTTGmzObxJH8CQnvhEs4VhFAB3AJl4VvySkdlYPjEbXx9NFcSw4khWNKttwU0O4zcJ5DhY+4zndNghr/0SWAnzhrVmU1ETKGckuKcjJ9otATcyY7EBtb4X6dhLu7Rf2cPT1Blgp1Y+PD3xS80QrJTMzk+xNn+OEc=
Received: from PH8PR07CA0037.namprd07.prod.outlook.com (2603:10b6:510:2cf::17)
 by SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 09:26:44 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::9a) by PH8PR07CA0037.outlook.office365.com
 (2603:10b6:510:2cf::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.16 via Frontend Transport; Tue, 12
 May 2026 09:26:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 09:26:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 12 May
 2026 04:26:43 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 May
 2026 04:26:42 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 04:26:39 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [for-next v2 1/4] net: ionic: register PHC for rdma timestamping
Date: Tue, 12 May 2026 14:56:20 +0530
Message-ID: <20260512092623.1157199-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512092623.1157199-1-abhijit.gangurde@amd.com>
References: <20260512092623.1157199-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SJ2PR12MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b31e45b-3978-437d-b66f-08deb00894d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|376014|82310400026|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	e+EKQ+50SEoJurpAu8b+6R+WHD8U5KWfY3NPMsZa092d2GrIa1J5JxEIbARZDWBNsVgtTTc4UO9BHJbCEKtq4tw2Ckg72tJYu3MiUZyuB6X5JKT2GHSxjy8O6MTm5A7AONkfHQs38EraYm/UYERTGj6JEi5yhznA+pRJ4hdEutK9nMOG6p2hdvy8VwXUN/UEzHG4H0rFzgge0tXRR1Dcc88Sqs6rts/ebknAY7E+K8mU6Uay/9MIl8mSG9NzPKfkm/1TnihglO+NoHk1kN9gemdjx9ZZ3DcXgLSuzoPbPGPzwil5G4NuBaHEkVkK3jmYULIxd17SGHZbcbp+Mu7rXspfgATIWJ5M5m8Ny9sANbJD8+WagdCYjHoju/bhUsE4mtloVIZ6usE6gonKrIvc9DYJDnVAXjZ6YwG7sTq/FCqp1JnV+WU4Hhy9gBJoks7+t4QDrVBQzwaMZri3xoWudS3FsomwSHKSg2rCWX8VEWSPvb0GHokHhHzgBF5ckpv1DI2i9mh+l8Rr+bFPtokRDzHHrS8FKKbrNm2I4Rzhwqjyn7MhMe8MXxHhPLfqRLVjEwvle1AAysKx9TFJXRvasyVdJVsjXly5PwRM9AABdEFuVxDH50H7uCcPihk+Bd5ZeanrhK3RTcHX7Mz87poAveyrudZ4xcLf6fC5ShwCFyRSqkFxJdX07hE2dAmYn1W7YJdLGruNA7Iyi+L5togB/+6j1AR9oM3tk0Yff1RdzHQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(376014)(82310400026)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RDNq+rIBbPvspqa3uNpkA7wKzsqbPrkgBozFq/njDiyimabxxAPInSb3ixbU2RpLzBTC9BsqoWX+9VjFuIgyQn+yHb/WpoWnAjU9dnGqHCZdtTygDi5u3WnOoQDE1cIRQc75GTOFNB888OXPuXJDKP2APzP/DihBJwGN1Gm/BRPyceVOzgM2oEcADkg8Wryng9cceCum2LB2Pvp5NxAfT3gFDL4O0duvaJeCyqvJeIq+Rdxg6qhMQZqnDlE+6kSQc1m7Br/PFd2lhqtx4L8AbN1lC8myeWsAXzSZxpgKQRf2S1QuD03IbqhhK/QQW0ir6zu0NwauXFVgDVBvewaY/StRhiBlSCTWWYgqf0qBnzjjy15fUBtubmOCw8MKEbV3e/uOkFtl0eKR5kXrxxiPrHt2M6qIQPJIS1ASu9HHdns4XqJGti7OEOuA8m68glUS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 09:26:43.5491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b31e45b-3978-437d-b66f-08deb00894d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182
X-Rspamd-Queue-Id: CD21251DBF3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20470-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:mid,amd.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Currently, the driver only registers the PTP Hardware Clock (PHC) if
Ethernet hardware timestamping is supported. Update the registration
logic to register the PHC if the device supports either Ethernet
hardware timestamping or RDMA completion timestamping.

Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_if.h    |  1 +
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  5 ++++-
 .../net/ethernet/pensando/ionic/ionic_phc.c   | 20 ++++++++++++-------
 3 files changed, 18 insertions(+), 8 deletions(-)

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


