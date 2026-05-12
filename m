Return-Path: <linux-rdma+bounces-20471-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ9jGKr0AmrpywEAu9opvQ
	(envelope-from <linux-rdma+bounces-20471-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 11:36:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D02151DDA7
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 11:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A456303F9B8
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 09:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648D54963C1;
	Tue, 12 May 2026 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KP1gMnio"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461B0393DC8;
	Tue, 12 May 2026 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578017; cv=fail; b=BH+gATeAshRsDHKf7o5HDwilPswgPaovDJg94WLACxIddNCVyKls98/aBTI649lwxHHtITX4wuejGRe/GLdXGYEgGXBO9LPQVE7BbTTkhop7dx4G39IY/34uXg+vq6jTZskvhn3DPxhokKoVtrUJ/V7cB9mcXvWqPxcdWlmnRho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578017; c=relaxed/simple;
	bh=Q14/zPe09fEF88WxlDRCMGE5DAKpLt/JTAnXrNzTkpI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmSs7RZq6lXdK9jS8YoWvVmSW4vbytpbtt3+S0miRqmkDK7kvIipY5NjZU8hFaven1nqvkIjaAeTwAorK9KuJWSMjHSqUtQhxP/ZP3pq4KGaAI6QuQoj1BKxdBPLTRnF/Ch0gxDxQVbbcLHel7TTcGcQx7HoHHbNMsVxnzbDp9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KP1gMnio; arc=fail smtp.client-ip=52.101.62.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfJcwG8jvdWhZBW0Zxb755rpLIqYrLKi4/mh+nry3V3D5Gp+R0v/VQqHU7mZF2zPPjkA0fpBysoVG0Se/Agpg4O63VlZb8KHZ6AoHOygwDyr6EhKGK5w+Ko+e7IVdHPJBBKyejKf6DgjyLnI3rzqYP79AkHnOFW2GHDock8y95qa3m/SiuLtBHTTT6hj70myeEfEtNem/Kk5tpS6rQiE6JBQs8I+xeg6uCJcYWVXV765IdsCWgnKX/+Xy21LphSOIeBT+m0yl3G0HB7/tSgSsw3z1Nz+XZJPCpAhqUAMtMRPDhSgavh1xH2pmlMsQe+qfrvCQHrGtYdet6lAbeX2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLbnSgumpezlQwZLY3GjIdRK1x/M76B9CVxpDuFmXmc=;
 b=DmGl8WIXmP0tUJoUaGiSJh1tPaXoXLR4CTVW6SH6GLuESzcteD1wf78/YYP0ixCet9UPPxHzYeG/aV9rRTXa3I3PJeGQgUp9ZmOwac3So/330uW62uMJE+qKppkckpaZvNtzlhCoaRGWb4yW+wjPYwUCWgHgbWHMcYc1iY/aAKsv923CDky9L8gb8e5sfIWB3GfklAhD3QVnM2HocDbdoTr9vzLAw3kHfTQpzOZjBva3DzWjP9GY7jR2uYFuTvGSYnT7uzI+OQRDeKqLAxZhNeq4HTMH0/1CyHIHRfvzHdK6VDkC5EHVxRunxrCe7XrSYHIh0M7Y3VJvDjeSwJTxDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLbnSgumpezlQwZLY3GjIdRK1x/M76B9CVxpDuFmXmc=;
 b=KP1gMniod9JCmJHxUeAY9PQOK/jg1y+vhtHegpLxlPW7yF34GACEo875Bjr0DVQA/eXV3igmOa6z3pbXRA90uMsDhm5XtLgUJwKSxL1rVInYVRXrHCfFull/RIXT2thp3ecG0l/283A9gYYFL9yb8NafqY7EbEVz0zGtUIXB+Nk=
Received: from BL1PR13CA0228.namprd13.prod.outlook.com (2603:10b6:208:2bf::23)
 by LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 09:26:47 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::74) by BL1PR13CA0228.outlook.office365.com
 (2603:10b6:208:2bf::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.16 via Frontend Transport; Tue, 12
 May 2026 09:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 09:26:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 12 May
 2026 04:26:47 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 May
 2026 04:26:46 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 04:26:43 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [for-next v2 2/4] net: ionic: Add PHC state page for user space access
Date: Tue, 12 May 2026 14:56:21 +0530
Message-ID: <20260512092623.1157199-3-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|LV3PR12MB9167:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d22c37-9f9c-4a22-2d7e-08deb0089714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|11063799003|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	lqS81uj5dEATKNZ4vQbSwP3grXBnJc9y0ZqaX2UXpaIfvVr0SkOd2zp1WP0Hxvk3O2qAt7kNYzSbqdgSqctHN0/EKl+zKzokvo5HcaKX6LjVWL6LZU/Bd5ej89nOmGOM7oBhxmzYZWkIzAb+SbDdMVkopa4mK4Pmv/Cjz0es/AhQZy78uwNEYurY1gOZf4RAtBHadZ3/8cVfMVkttRTiu0fSP5G3DD35CNTq4t4sauk/AVTFyA7zKIAsWEfY3c/XnUv92VTyAVt+kPbwGDCSrkubqgxsZ2Gvf+L1KVt9/sjer/GOSLDFhPNPnGMtK9miEVUCIKaRagrvkt+s+Rq6JEXaPUG17EATJ91aeDrD3fMe+kh70WV61qWlqTNeRksIz16WGzjoZb/jQCMeWu0EgrvgiJlGvbAD6+rTae52vgChcBMk2XspH5rw7eoAgRUELfvaIvqc/6rLKW8kMtYjuCGymi1vINRQ1IE+uF+9r4Yw29oPHl/l4hw5+f1ITxuzQtGN54bsWovQPNrhTXp3MK2I0GexiOE9PsX2/Qltcxnuy6y2CSn1BCTJSyZwyYW66IuJJxb4NiJoIfWVjXUdGtLpMLx28p8KUdsNEyb8X2EJsJY3pooUKkcUV/ZxhXH/zYvaqv2y79FNG9zXUtQkmMDQceUGS4SGYygMsvncnLJYmqHECz45HV+JNgg43kQM+4sFGqP/9nAlaGKyecm8C0lEOt5BFa0VOH8obap7oTQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(11063799003)(22082099003)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Dq0cKNJlTcXG1Eos02xtPiiBnAIu/uLpAF4QPlhQY6Fz41yy8rouETkT5Cg/lRkRCNjzIGxLp5L3Gjc76bcag05ZPgNmzsHO9/qFQ2LJwTobRBJ18fVyniBLCDiNdIZhesIpljgxaxlbDDdC9dQf1ZPYUxWBexuJtRIKPkMfQ4Otd4X1pNFgZOrxM+TBvwmeo8u8Z+khshev/ImgauIAbqFb4aVm8zapt7qSX0VWC1e7pb5QVz5fWSGATIOcIdA1pct2QRZHrY2LQ6DwGXN1Kbqfv5p3kIuO0TSrSRI+gR7nEluLedSriQIYRaRy1I6otnAQ0rRxGKqVwyb7rhzDiwXr12mCieXuqn97S80rfY0i02rKBbnEQMgK9+AO0onIiPxCwDZkBpVfSTvfEdLCebPIek1VPXtyemZDINAQxyTjgFZ2KsgXbUbJUbWElEhh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 09:26:47.3656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d22c37-9f9c-4a22-2d7e-08deb0089714
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167
X-Rspamd-Queue-Id: 6D02151DDA7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20471-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:email,amd.com:mid,amd.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

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
 .../net/ethernet/pensando/ionic/ionic_phc.c   | 42 +++++++++++++++++++
 include/uapi/rdma/ib_user_verbs.h             | 33 +++++++++++++++
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index 8e10f66dc50e..3f344ed2ce35 100644
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
+	struct ib_uverbs_phc_state *state_page;
 	struct ptp_clock *ptp;
 	struct ionic_lif *lif;
 };
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_phc.c b/drivers/net/ethernet/pensando/ionic/ionic_phc.c
index 116408099974..8f7f8323c500 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_phc.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_phc.c
@@ -3,6 +3,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <uapi/rdma/ib_user_verbs.h>
 
 #include "ionic.h"
 #include "ionic_bus.h"
@@ -334,6 +335,26 @@ static int ionic_setphc_cmd(struct ionic_phc *phc, struct ionic_admin_ctx *ctx)
 	return ionic_adminq_post(phc->lif, ctx);
 }
 
+static void ionic_phc_state_page_update(struct ionic_phc *phc)
+{
+	struct ib_uverbs_phc_state *state = phc->state_page;
+	u32 seq;
+
+	/* read current seq */
+	seq = smp_load_acquire(&state->seq) & ~1;
+
+	/* make seq odd for updating */
+	smp_store_mb(state->seq, seq | 1);
+
+	state->cycles = phc->tc.cycle_last;
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
@@ -652,6 +688,11 @@ void ionic_lif_alloc_phc(struct ionic_lif *lif)
 	 */
 	phc->ptp_info.max_adj = NORMAL_PPB;
 
+	phc->state_page->mask = phc->cc.mask;
+	phc->state_page->shift = phc->cc.shift;
+
+	ionic_phc_state_page_update(phc);
+
 	lif->phc = phc;
 }
 
@@ -662,6 +703,7 @@ void ionic_lif_free_phc(struct ionic_lif *lif)
 
 	mutex_destroy(&lif->phc->config_lock);
 
+	free_page((unsigned long)lif->phc->state_page);
 	devm_kfree(lif->ionic->dev, lif->phc);
 	lif->phc = NULL;
 }
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 3b7bd99813e9..7e175280801b 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -1377,4 +1377,37 @@ enum ib_uverbs_raw_packet_caps {
 	IB_UVERBS_RAW_PACKET_CAP_DELAY_DROP = 1 << 3,
 };
 
+/*
+ * struct ib_uverbs_phc_state - timecounter state shared with userspace
+ *
+ * Drivers that use a software timecounter over a free-running hardware
+ * cycle counter can map this page read-only into userspace, allowing
+ * conversion of hardware timestamps to system time without a syscall.
+ *
+ * Synchronization uses a sequence counter (@seq): the kernel sets it
+ * to an odd value before updating, then to the next even value after.
+ * Userspace must retry the read if @seq is odd or changed during the read.
+ *
+ * @seq:             Sequence counter (even = stable, odd = update in progress)
+ * @rsvd:            Reserved
+ * @mask:            Cycle counter bitmask
+ * @cycles:          Cycle counter value at last update
+ * @nsec:            Nanoseconds at last update
+ * @frac:            Fractional nanoseconds at last update
+ * @mult:            Cycle-to-nanosecond multiplier
+ * @shift:           Cycle-to-nanosecond shift
+ * @overflow_period: Max interval (nsec) between reads before counter wraps
+ */
+struct ib_uverbs_phc_state {
+	__u32 seq;
+	__u32 rsvd;
+	__aligned_u64 mask;
+	__aligned_u64 cycles;
+	__aligned_u64 nsec;
+	__aligned_u64 frac;
+	__u32 mult;
+	__u32 shift;
+	__aligned_u64 overflow_period;
+};
+
 #endif /* IB_USER_VERBS_H */
-- 
2.43.0


