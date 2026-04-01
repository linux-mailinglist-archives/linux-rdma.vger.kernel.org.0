Return-Path: <linux-rdma+bounces-18895-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFU4KhT0zGl9YQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18895-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 12:31:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6145237889A
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 12:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A7C3308F9A0
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 10:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0226A3EF0C6;
	Wed,  1 Apr 2026 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0cOYwnwx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4783EE1E2;
	Wed,  1 Apr 2026 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039147; cv=fail; b=PMg7yFUDcat5Jc6U4Cj6PdTYsYhX9v/FftvpKTPMgPpjRZTR5zKgvDqVi72lg8euexIL/wiySMDjTOrhjLcFggxxxs4tIYi4pzDUD8D09RHupqEeX1Ibg3pJdfCIe6ifw2aXOWjvnZK8AjmmwOnytuLuH3O/lP82tSzPYwckuF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039147; c=relaxed/simple;
	bh=YYyOgpcRS58FD/UYY9qiuLmvXHhIAtcVI/a5Q3FNmFU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owQCyAyyb2uE1er1ZJQJA0eyb6BPuKUyrXKgv1vu8N/Kco4MYFgoS5Uj74qMhazRhhr/oW26KOaOUhzrQLvmeEYtWZQR8k6Ig38qmmLSslDeyH2fzjEGfRQaYLcGqEdOUdyEjwKLSlzEFJP8a/OeC+ndjxAh5G89kr/BbC/LO40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0cOYwnwx; arc=fail smtp.client-ip=52.101.43.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AP87p7NQtUPJRuSm2iOV5InA9pDUwtR2zAg/Zcs9ztY8aqXdkXJQxd48o5rrBlD92Xt45cxloNl/Wzg6ivkbTpsCNPwAgj9YferX+BNFgVPaIuscMsLpMe/e+P4ozVJ22FEbF/hZfUjoqy/YyQ50KyRJCrhS5A40T17PB1Dvy2YzRNSleinzC9LelO2TGHm8FJ1NPlwtr/jh2bVIarzAkzqc8aMciOHeI3NlA+pZIq/9buFyi58h7ewzodaEJsjrJA2cB+UsDwnoOkwggWwBGhit+ERbAmjc05fpluJ92ZkQuf4i83zMVyPYkcOIQOETVarnvovOz8tUXLXsUKqRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gy3V8rzyVeA8OITbCUlZZhMBl0ptJhSAjx/DArG8XP8=;
 b=kWFAnAtGwxlINb/Xzjr84jPWx9HJxrTaiNQ+DjM+orjRaqSc8jBNmLVJZnya+dACbh3JY5mEH5ONvhffpXbwwCvGSCqaoSCoeqZuDo03n54YwSdqGL6GQQOjXhfxn46jgGj+YP++7lL6FtrtrSLmRl6fssljKQqMuFqLBcSU+j/KH8l2V50Y55aXrA9KeW2mD40EYgx35Gp9H3X+m5A3FbkDCmj9N7DsIzH6bja8PAzq1HZ//z2E90sAdGDTLpIGq7xwqyMvwqwcWzqyhTP8h5gAe59ylDgSYWTSnEEJ2zKwasa30KqyYY+ajRwxN9zAlMiFCzJ0FYomVCUD3b6c5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gy3V8rzyVeA8OITbCUlZZhMBl0ptJhSAjx/DArG8XP8=;
 b=0cOYwnwxhNtpon+GjI/rF6s0JuDdbyaUnqk2gO9ivqZkGL+OiuxsjiHHaxAyEgSPCrmNndan7LJFOTuXkvSa8s0Cc93lYgVrkd47A/Pz738MzTyzXrcK88L7DONsvWpCKnDaQrw6gDjJbue+iGOkbZMno5bKx9eu9Q084B0STr4=
Received: from MN2PR04CA0015.namprd04.prod.outlook.com (2603:10b6:208:d4::28)
 by SA1PR12MB5657.namprd12.prod.outlook.com (2603:10b6:806:234::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 10:25:40 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::1d) by MN2PR04CA0015.outlook.office365.com
 (2603:10b6:208:d4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Wed,
 1 Apr 2026 10:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 10:25:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 05:25:39 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 03:25:39 -0700
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 1 Apr 2026 05:25:35 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH 2/4] net: ionic: Add PHC state page for user space access
Date: Wed, 1 Apr 2026 15:54:59 +0530
Message-ID: <20260401102501.3395305-3-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|SA1PR12MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: 847d26a7-6932-4339-0a78-08de8fd9059e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	scrUdlenFQu5bKzolaaJwOD3246XMXbwWq6FdfusRqVQlia0ldNJdu+F05lxpwtwWxImSid409V5os7z3MIb7f1IKAtWIX920t7do9vKgcI9dFVMSJmjKub9n34pMZ+ZmRirzb+/KI1Gg4fN6q3iQzbEHsN7/+IPvVV81KTo2YOO0v4GkMU8Uj09fJEDh+zMRGfBalhbxyukGaez2LV8UaEYmcAqwh/Ghz/fXUymf2uak/lnv27zC5XQlAmzK/nAJ2KvP5x0g3q8L4ztPl2XXK+oBolqvFyoc+oH/1/pcejORQ2zDZYGArttk+adaHMGCbrRanDFm1CWQs6SKIjawBXKE/FTDUi9CL9IOxt0NQhbrohKOXs9Ul6gmVxgaRXO9sDPM0Si1Xu/vm7Vt+p+/IxICnHBCJA2sgd94FpRUfoCvQBVHy9fT+nlu9s0x2Km29jghWarQCOv+XP6EWq4EO+QtW6KXeFj3OtOdEEzlzM6oK5YLpaV3aB7qC53YLq1kAug1P4lBfaSSanVZAHBfrPOwSxi9YrLxPrKycOP/JoIAG96ZAwpqQ4OE/Uz8rTFIirq97vgE4a4ZMZt8XTCIltkWC5jPVdZ8rmngkiaefDFQrMyuyfWk6uEumsBZfG7genhIJ8iWoLcz1ejqm0N6M0YZa8cwjFJrmaDowBMMmXLAcewDlXdJ6bcP35wlpIQa/qfVNsZCmo5ZqzmginnMgiVnCgf5sfWxw6oroGlMyOoNMoUJ6gsbqCnQRp7i4Ul6Sn3pm5HN5Nqazv6lXsymw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ePwb3+rrZCHhsbfGWOh2To5LB/utBM5rGZqZlmadAkF8Zy4p9G7whQHiMTSpDI11rOC4A/vU8hJfXqLqsRgEb0zSZHrYicxKZTgX9ZQEPLW+TmI/PDVBoEgUeiopIF4KU/YbXKVXz5xkHBRhD7e0bc9FHTeB1EoSMW+fI3pNDf/JDKDd+jApNGYKbRgprNJIQGORJ0zQMAp3kV93gVm6gtWzlbN67kQt6GFQg/fQSkuDlU4r/uZv8yKtLQjuKR+RGMbuR9PySDnUq5i+HseSJgZSlqrmIaSE0YkZRi+1z8MqipmhuDLlaMv3/9gyVV44Pb5YGBNIXoraEfFXi8i0Iz6/7dAsHi88Y6O9eM0TWGqB6XpZdXbFul5ShUpc7LqeUzPfqphjtI3ddGIXQi2UAy9zObzvgRKl5KMMdO0Ts0dCaV6uMVC43EUY9S2VWALg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:25:39.7685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 847d26a7-6932-4339-0a78-08de8fd9059e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5657
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18895-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6145237889A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a page associated with the PHC that can be mapped to user space,
allowing applications to access hardware timestamp information.

In order to synchronize between kernel and user space, a sequence
number is incremented at the beginning and end of each update.
An odd number means the data is being updated while an even number
means the update is complete. To guarantee that the data structure
was accessed atomically, user space will:

repeat:
        seq1 = <read sequence>
        goto <repeat> if odd
        <read PHC state>
        seq2 = <read sequence>
        if seq1 != seq2 goto repeat

This mechanism acts as a guard against reading invalid state during
concurrent updates.

Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  3 +-
 .../net/ethernet/pensando/ionic/ionic_phc.c   | 41 +++++++++++++++++++
 include/uapi/rdma/ionic-abi.h                 | 11 +++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index 8e10f66dc50e..0b820af2b523 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -249,7 +249,7 @@ struct ionic_lif {
 };
 
 struct ionic_phc {
-	spinlock_t lock; /* lock for cc and tc */
+	spinlock_t lock; /* lock for state_page, cc and tc */
 	struct cyclecounter cc;
 	struct timecounter tc;
 
@@ -262,6 +262,7 @@ struct ionic_phc {
 	long aux_work_delay;
 
 	struct ptp_clock_info ptp_info;
+	struct ionic_phc_state *state_page;
 	struct ptp_clock *ptp;
 	struct ionic_lif *lif;
 };
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_phc.c b/drivers/net/ethernet/pensando/ionic/ionic_phc.c
index 116408099974..61eaf3834608 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_phc.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_phc.c
@@ -3,6 +3,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <rdma/ionic-abi.h>
 
 #include "ionic.h"
 #include "ionic_bus.h"
@@ -334,6 +335,26 @@ static int ionic_setphc_cmd(struct ionic_phc *phc, struct ionic_admin_ctx *ctx)
 	return ionic_adminq_post(phc->lif, ctx);
 }
 
+static void ionic_phc_state_page_update(struct ionic_phc *phc)
+{
+	struct ionic_phc_state *state = phc->state_page;
+	u32 seq;
+
+	/* read current seq */
+	seq = smp_load_acquire(&state->seq) & ~1;
+
+	/* make seq odd for updating */
+	smp_store_mb(state->seq, seq | 1);
+
+	state->tick = phc->tc.cycle_last;
+	state->nsec = phc->tc.nsec;
+	state->frac = phc->tc.frac;
+	state->mult = phc->cc.mult;
+
+	/* make seq the next even number for update completed */
+	smp_store_release(&state->seq, seq + 2);
+}
+
 static int ionic_phc_adjfine(struct ptp_clock_info *info, long scaled_ppm)
 {
 	struct ionic_phc *phc = container_of(info, struct ionic_phc, ptp_info);
@@ -361,6 +382,8 @@ static int ionic_phc_adjfine(struct ptp_clock_info *info, long scaled_ppm)
 	timecounter_read(&phc->tc);
 	phc->cc.mult = adj;
 
+	ionic_phc_state_page_update(phc);
+
 	/* Setphc commands are posted in-order, sequenced by phc->lock.  We
 	 * need to drop the lock before waiting for the command to complete.
 	 */
@@ -386,6 +409,8 @@ static int ionic_phc_adjtime(struct ptp_clock_info *info, s64 delta)
 
 	timecounter_adjtime(&phc->tc, delta);
 
+	ionic_phc_state_page_update(phc);
+
 	/* Setphc commands are posted in-order, sequenced by phc->lock.  We
 	 * need to drop the lock before waiting for the command to complete.
 	 */
@@ -415,6 +440,8 @@ static int ionic_phc_settime64(struct ptp_clock_info *info,
 
 	timecounter_init(&phc->tc, &phc->cc, ns);
 
+	ionic_phc_state_page_update(phc);
+
 	/* Setphc commands are posted in-order, sequenced by phc->lock.  We
 	 * need to drop the lock before waiting for the command to complete.
 	 */
@@ -472,6 +499,8 @@ static long ionic_phc_aux_work(struct ptp_clock_info *info)
 	/* update point-in-time basis to now */
 	timecounter_read(&phc->tc);
 
+	ionic_phc_state_page_update(phc);
+
 	/* Setphc commands are posted in-order, sequenced by phc->lock.  We
 	 * need to drop the lock before waiting for the command to complete.
 	 */
@@ -558,6 +587,12 @@ void ionic_lif_alloc_phc(struct ionic_lif *lif)
 	if (!phc)
 		return;
 
+	phc->state_page = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!phc->state_page) {
+		devm_kfree(ionic->dev, phc);
+		return;
+	}
+
 	phc->lif = lif;
 
 	phc->cc.read = ionic_cc_read;
@@ -569,6 +604,7 @@ void ionic_lif_alloc_phc(struct ionic_lif *lif)
 		dev_err(lif->ionic->dev,
 			"Invalid device PHC mask multiplier %u, disabling HW timestamp support\n",
 			phc->cc.mult);
+		free_page((unsigned long)phc->state_page);
 		devm_kfree(lif->ionic->dev, phc);
 		lif->phc = NULL;
 		return;
@@ -652,6 +688,10 @@ void ionic_lif_alloc_phc(struct ionic_lif *lif)
 	 */
 	phc->ptp_info.max_adj = NORMAL_PPB;
 
+	phc->state_page->mask = phc->cc.mask;
+	phc->state_page->shift = phc->cc.shift;
+	ionic_phc_state_page_update(phc);
+
 	lif->phc = phc;
 }
 
@@ -662,6 +702,7 @@ void ionic_lif_free_phc(struct ionic_lif *lif)
 
 	mutex_destroy(&lif->phc->config_lock);
 
+	free_page((unsigned long)lif->phc->state_page);
 	devm_kfree(lif->ionic->dev, lif->phc);
 	lif->phc = NULL;
 }
diff --git a/include/uapi/rdma/ionic-abi.h b/include/uapi/rdma/ionic-abi.h
index 7b589d3e9728..97f695510380 100644
--- a/include/uapi/rdma/ionic-abi.h
+++ b/include/uapi/rdma/ionic-abi.h
@@ -112,4 +112,15 @@ struct ionic_srq_resp {
 	__aligned_u64 rq_cmb_offset;
 };
 
+struct ionic_phc_state {
+	__u32 seq;
+	__u32 rsvd;
+	__aligned_u64 mask;
+	__aligned_u64 tick;
+	__aligned_u64 nsec;
+	__aligned_u64 frac;
+	__u32 mult;
+	__u32 shift;
+};
+
 #endif /* IONIC_ABI_H */
-- 
2.43.0


