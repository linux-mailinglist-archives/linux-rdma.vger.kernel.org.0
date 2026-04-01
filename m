Return-Path: <linux-rdma+bounces-18894-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4G4NA/bzzGl9YQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18894-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 12:31:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 980AD37887B
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 12:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D03D0308AA4C
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 10:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DBB3E959A;
	Wed,  1 Apr 2026 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HpDbPYvO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1113C7E05;
	Wed,  1 Apr 2026 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039140; cv=fail; b=hqbcuW39xc7baVqLBnTsAuVnO5m1aaU14ggIFNbrWH9glQg1lTmy1vW+DdMfw3XrnTieChNmvsyWcsPS9UGpOkY36sapTHjS/LjcE1q/Hk0hI3aG0S8hruoSZ3Ep861lUIHgnVefYsB/fbFz1G1/HRxXWO7SYToQRkNIq08NN4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039140; c=relaxed/simple;
	bh=e7pD+SnWNuXw8TK1/Nyy4RHi+xAYZZyQLMDpxLtighU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYnZzxxCSVaUAPJslrV8GHlHrtHUxebHzCdvWDiWtTSMe6TvIv/tPlB1v3CEbWqjrJ02dD+98vZR+nM/M7vPUZAfxKmJAhiU1UXs7BUyUPMAXaAUowJD6I6AWszAS16+2x9C6SxyuMjeUS7GUWtXqnAx6YJ5beDEPAGQKIRLVM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HpDbPYvO; arc=fail smtp.client-ip=52.101.85.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3nqFyFmlkpFmFhBJTOUnpdlydeTJa+Q0ClWOGJ8CmNTjFRfSFHEq50PYJ9KUUGxmWGypAqthZiYWWWhiOLgT95tuoSOix9Jjt+u0xb6IiknuqoDfxBphgEAULsWvY20C1c9xq13IyfRfrWAlGgzOa5VfvvLBXIlcy5FDiMRnK2cixpcNxX2Gym2HYQtjNzzrR+IV1gpOS8EvwRzzH3T8a6SiH852Kq3Bjys/Wu55rhhqkLYK9whQKTNMdG9bLjiAoB6szNFBuxz61XgqCkfyzxurLcq7S6zsh6rHmJc460ihqqh4dum6Iatw4iFmvA8wHvlWfrCf33ag7Ng+jZT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MpHdyNS4m4ePci4dHS+YzKF8y689np9zWZJLbAXOF8=;
 b=eDDmEDrjwzMWnGVjpYxkYwF6ZaDkhtiySiwmuDWKjSt6rp4phmYd78n/Lmj5niu93sqlnnJYCV/h71yt09yu65H3frkcyNeAEp4mKbpakh1sU3zKctR+pFiiznogPaWBMqrn+8y45yxTuRy3aVANQbjrX9c1WSV6TjsOXrvoojaNv4KFrKcNKJnFM1DhF8ZhmQN1YxJvUXtFs9awaomP+Bdvia2XGA11i9Q9cC+EscdVBHvhtMxXvTb4uhmPjH+xBRKMn4mZ9IF5wC7uTWtYi1UYxVP9AMUqlIH6ZSDY8ZtPflV2/+KfxYH/U+f1aRVGUvGV1rRdT88cN2eSuHxakA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MpHdyNS4m4ePci4dHS+YzKF8y689np9zWZJLbAXOF8=;
 b=HpDbPYvOIVzhL8zHFwzapcfnXAVAksAirXcqDAj/Y+UdrhW4FwPXUKHhRl+9+ThUy1hPhq/TxbFQyLYpFl7s+kRUt+qdxkOtGI5UhUeteJuMAO2LcO9GGP2q3YEHDDuUREfqA2pSL62p1MiO26GxTY7JeqdTqtHClnb2qFIL5rU=
Received: from DS7P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::8) by
 DM3PR12MB9391.namprd12.prod.outlook.com (2603:10b6:0:3d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Wed, 1 Apr 2026 10:25:33 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:8:1ca:cafe::1e) by DS7P220CA0010.outlook.office365.com
 (2603:10b6:8:1ca::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.31 via Frontend Transport; Wed,
 1 Apr 2026 10:25:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 10:25:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 05:25:32 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 05:25:31 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 1 Apr 2026 05:25:28 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH 1/4] net: ionic: register PHC for rdma timestamping
Date: Wed, 1 Apr 2026 15:54:58 +0530
Message-ID: <20260401102501.3395305-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401102501.3395305-1-abhijit.gangurde@amd.com>
References: <20260401102501.3395305-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|DM3PR12MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: b06a32cb-b0ba-4ac4-ef48-08de8fd90181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CZThh2TfTIGkFtsCSpKdrSamQEG7NNoOx9RI1g6GqEffG2FTc7ka3vOlY42Nh1oFHZE7aBSZUqgmn9vDDbwJrSGPAuB1zoy7rA7M9uyZ/5Qnqniu1ZYWb19yiDZ1BF5ogE1pM0jd5FBOiXU0Go3nUHs8T5Fwpod/vIpEbu9jfBHyH7lRxq91h6jOd7oSAZCRo6MfFXQrYVrN4PPSq9w+cF2+TlXFWrnmNd2IgfdIiLEVXE9puuZPXY38tJhyS2C0hWxmyuZ0cEs9x6TePCyYYx4fxM2JPCcL/RfL+86DRWEvFkEgovUe48I+VhKEXlFmjQJNPEwrSaQynYRoRxBQzcsqTVJvhF+LawobCaqQtoqIYHn5GPiFk6sIuo44WgzZEmdot6pb+611uevsEarJiEjMD6FyIvEzmWjgDA2n3GFkG/TVIfuDQRXJb3vkVoLA78BO0KGVwioWn0nA5l01PFiJ3djbApZRsWv4b9HXmGLdu7BkrvDJX8jR8iFVGIUbbGv5xLNwGg69t1Mwm6aUnBh2pWfkJfM8gV8IoPVzNJAajy9n8xSpDs8nLjj7wi3WDX7/ixVZgRWdgKV6XPYgahMaJ5yoGr4bM5S9U8slgQSPo+3q+OBVmM7szupAA/LWl3dh5aexApa90+loZ4ReqOCHVPPizPvnAIn3EG+sF4/RsA/PZMWVZ/1/TUkhO8xwxfAuWiyuNKgrbQ0MQ1RpYvra2MU4ACguWnFH3fn668jYWuf2rwxE2EwQb8nDHy5TXUWk8kuBBKhTOSn2kClmIg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hqMysg/mUGGD5qmqaLDNmDVRVGdgiHt1055B83LiGQn1sCUQ8iW2R4XZ594aH6r7Gq919QdpnbqGhjJdwOeLZwubEO8T+9FCQG6ZzJW48mIMJCmsB4vdPbevRqnQ90FvvURDV0qukU1L6EtwEMIcjKxIh7sLb9Lv4MWLyQy+zhsJAdFZUYlt84Lx+PkuiAc7wEFYU+fKoOU6LIj78Fui70Z+vdJxf7Z+Ts5zvMx/ezWvWMQcGOGCRiQmS8EmTUgyMmQbrfJyCcZ8/IG9KspulSu0+ysb6km75S9BqARilG60Yqgf2QbsXJlY5wfWpNScBpUZwWbvqg6guryIc5n6F4Pb6adSw5ZctUqdNqh4XWOIO3FTAsVarC4Wp9/NgRPivsNyeudS8i53x5h41VJ6j/f/dvgPx8SmxSEAQ/GbB6QHC0UU/STmOH7lP6pYfUpT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:25:32.8334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b06a32cb-b0ba-4ac4-ef48-08de8fd90181
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9391
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18894-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 980AD37887B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


