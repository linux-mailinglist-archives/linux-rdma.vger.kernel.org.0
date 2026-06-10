Return-Path: <linux-rdma+bounces-22083-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mzQuG9GJKWrhYwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22083-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 17:59:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A0F66B1A3
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 17:59:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=OcKukJLk;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22083-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22083-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1076630BC584
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 15:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D2D48A2C2;
	Wed, 10 Jun 2026 15:42:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FA5427A10;
	Wed, 10 Jun 2026 15:42:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106167; cv=fail; b=sz6zIUR0iMg8WvQYKdINXm5maCth9GAFEZ4N2fF+WQT00rHu1Pz/AWYelLhnfhUV8Vhtl8t9VDwsHfCwxf1cArt975Ymw9e4zzBm+CGw1NKCL6+zKW7p7HsRy+tJs5eVDxfFUqorm4mX37Yv8QUlQbd8n3xvO56TXoucFmganw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106167; c=relaxed/simple;
	bh=liLPDbBNOke35+Zp09BbqB2AaAu7e3MpGO/95nKdis4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcOiQNkma8SLbnRPsAVvImrn3GZT4nfaW3DUK7uYk4tdte80k5Cf6itgq/1clFsxQ9m0ZWW0nPRJj/Kd/OywXOot50qp/uE2c5wJnexd6UE5pKS0zwLsmpZ/ldPYXwxY1yI2SMC0wbM1gsldPaeXno6HN9jNyq/eH7dx4Z/RU34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OcKukJLk; arc=fail smtp.client-ip=52.101.57.6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGpfwL1RjhWUydMb2W1NSrjPwmoiZJVST2vZ1VtHETQ9mXEiI5QoeoIjraZmQHFPbqHk0HvNprxEVhaKKXmPLyyyuH8piXzM12Bx8KqsMXCRGjfrKyKyeib27E6KLvuP82/7No2sQ+JWgIqiHmz+Ee+Ms4qxruGqP0j378OGG0aUXpA0YppWr/Sj7/vMFgv+6aisx7U0cxxMK5hZbu4looTfbp+QivH5XcVv7CvqXQU0B3LzIQjREYp9W8UC5PtSQPqZJUFONIBzMDdEsXeeLCGRGDwC1EJcvxHYCk45pznwlIXS6CXC7JYARYXvUfUxstqjTmcot1e25JkmT6gMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAAiTDKFe6GWFfHuZMBSPI3th78AEvWXikXMpvbIpn0=;
 b=mrN7SHrlqwAJ8Y8ZNZ1cpnM7fPuA9N+3h8d9olo8PQv/NgBFB0q/uCdZh7XtrFOqRTpwFoR3V4fGa6xZjMOFyAuC5GvK+7lOPCuVs6z5IJW5KFcRp2RB2o/BoyBV4yLjVEdqZ8hDNR3qA7jCi6OEd2WU5ypdsNF9IQDSh4stUcqRZFg/dRBTyTBLOT1+qn97uzjFM9y75MkQN3VbUWSDNYQUCD7eW5Auk5sBKlw5CO6iyP2y3V2HbjzuXsuf+WUKV7MHZi9aksmUqxHkDjLWdsntGP8+zpBG4n8qDcM9lK6xT7Fr62OO6AKIIBY1olN/9MHuam1C72CXfeArJ1vEqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAAiTDKFe6GWFfHuZMBSPI3th78AEvWXikXMpvbIpn0=;
 b=OcKukJLkbLQMZy0QcVy+BAP4zbjbrLB2TKdDXmBAOrYxdhedm92EflZXw90Q3LOhoTGRFmzvyVCPvkxkCl/30mJYGJl9UFWqrARBgoAIiYhlyFMc9cVbzCtI0QfDUP0iRGby/aLQAgqi4DGiT1EDzhem5H65kzsOI8NBdvA/T60=
Received: from CH5P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::10)
 by SJ5PPFABE38415D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 15:42:38 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::73) by CH5P223CA0002.outlook.office365.com
 (2603:10b6:610:1f3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Wed,
 10 Jun 2026 15:42:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 15:42:38 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 10:42:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 08:42:36 -0700
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 10:42:32 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dwmw2@infradead.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [for-next v4 2/5] net: ionic: Add PHC state page for user space access
Date: Wed, 10 Jun 2026 21:12:13 +0530
Message-ID: <20260610154216.712374-3-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|SJ5PPFABE38415D:EE_
X-MS-Office365-Filtering-Correlation-Id: 766e3c2b-26be-4d21-027d-08dec706e66f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|56012099006|18002099003|3023799007|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	L7IbA8uNvjW5n6AyoLPX0q+WdYjYBZQP/vUhFjec1EappfjVR8vRBqXj5/icOhrVogLapvlQhs3yfJCJ2KZrOywgWnWDdVYKbyC9iiXjWBhgCz38lPAYKC2OH6b/RpCY6PzmhpHxsv80HJXEESTTPhXxy4Au4A4e+rPE71Qyxaray0EL5ytwm2l5LQQ3mhpPYM6EvDPCcxyWJjKecGF0tu5YqPjSjFYBoMdk58m/NWKTBDh6RliDVi4CaRRtg2rkdjLC1aunwhZanKpteD4YZanaH2RDI3CaAqZPh8ieNGISkd72L9DJj8+Z2LLFL1ImjVzQjkxtx8tS3JQDv0qI81HTBqGKz3gJhnc6dkrDjzu5maGAtO+UlSpFsqY0mg+YQ6i+dvZq4jZ3zGUBJLqFoafntHsJVULZKh15jcqzd4DNLoqMKkdxJ2wqFKW7w6Dxed/I5rQ6i7jLy6hICipaa6fgkFxsKReYEmtoTUoNZ2MRpqZQGwKq9AXRVnLoWAM2X5oK2iW4YNC4V2Rc+h/qHDdggdwsMlvtkCXI/07gnqXgXPP0adbrymCzpLbMsWoj8KUZREE7tLFCJhoyx9oYBdGS3gU7FawXzC07xyB8APLeeyQpl7qePUtoYGN1QjrjgA3P/DHxAq7LY/tOJVG6aiOprULi2nWNI+zm6g9ov3inMOQvwD9AgVwdFhzCQH322U+EZp54oRvHQIWLWfu1m7EXOSA8CbznwsKuufiHDxQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(56012099006)(18002099003)(3023799007)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	THr8sXMlKqAMhmb9v9RGY2hTmX79/nnm+R0gKEzzQ7MIekf1FUmnX97qvFcSl8ckfLOm2uhEqBvq8zxeiczD7cuqdCsnNAm9MUoobjYrRE9dtwakXhUBxHN9zQIh0D2pvZ4n3bLE8lPc/uEVqCIY66ZfmPovxAPKfEVeZHnlb0yRMQfhPvqxUWKnc3HEH+Ir7a8mKEYp3ogHtl6Y2XCfGrXYQjspO3SVi75dG2m4p/Ey0ruF9ANsYoXkxDNWSHsYjztQohcshtz3+EVEL85FVDjjbON8zvxYdDNsNxe5rsImg2RExFntLu7JuC3uQqRISP3fcLrPqFG+zT3AAP/zEdF7w3/IvHq7iVr+jcAmSqJRuh1zdjKnsEJ2z00VYhoOczCKGCFVB6xrCsIJwUHsY9ljjgG6avRqjb597XUqmc6SAoTEvBLm1SxkpZ6aSUjz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 15:42:38.2405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 766e3c2b-26be-4d21-027d-08dec706e66f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFABE38415D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-22083-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9A0F66B1A3

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
 .../net/ethernet/pensando/ionic/ionic_phc.c   | 43 +++++++++++++++++++
 include/uapi/rdma/ib_user_verbs.h             | 33 ++++++++++++++
 3 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index 8e10f66dc50e..42581ddd18ae 100644
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
+	struct ib_uverbs_clock_info *state_page;
 	struct ptp_clock *ptp;
 	struct ionic_lif *lif;
 };
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_phc.c b/drivers/net/ethernet/pensando/ionic/ionic_phc.c
index 116408099974..4b8d80a55b72 100644
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
+	struct ib_uverbs_clock_info *state = phc->state_page;
+	u32 sign;
+
+	/* read current sign */
+	sign = smp_load_acquire(&state->sign) & ~1;
+
+	/* make sign odd for updating */
+	smp_store_mb(state->sign, sign | 1);
+
+	state->cycles = phc->tc.cycle_last;
+	state->nsec = phc->tc.nsec;
+	state->frac = phc->tc.frac;
+	state->mult = phc->cc.mult;
+
+	/* make sign the next even number for update completed */
+	smp_store_release(&state->sign, sign + 2);
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
@@ -652,6 +688,12 @@ void ionic_lif_alloc_phc(struct ionic_lif *lif)
 	 */
 	phc->ptp_info.max_adj = NORMAL_PPB;
 
+	phc->state_page->mask = phc->cc.mask;
+	phc->state_page->shift = phc->cc.shift;
+	phc->state_page->overflow_period = delay;
+
+	ionic_phc_state_page_update(phc);
+
 	lif->phc = phc;
 }
 
@@ -662,6 +704,7 @@ void ionic_lif_free_phc(struct ionic_lif *lif)
 
 	mutex_destroy(&lif->phc->config_lock);
 
+	free_page((unsigned long)lif->phc->state_page);
 	devm_kfree(lif->ionic->dev, lif->phc);
 	lif->phc = NULL;
 }
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index d2aeadb6d2f9..565301594634 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -1379,4 +1379,37 @@ enum ib_uverbs_raw_packet_caps {
 	IB_UVERBS_RAW_PACKET_CAP_DELAY_DROP = 1 << 3,
 };
 
+/*
+ * struct ib_uverbs_clock_info - timecounter state shared with userspace
+ *
+ * Drivers that use a software timecounter over a free-running hardware
+ * cycle counter can map this page read-only into userspace, allowing
+ * conversion of hardware timestamps to system time without a syscall.
+ *
+ * Synchronization uses a sequence counter (@sign): the kernel sets bit 0
+ * before updating, then advances by 2 after. Userspace must retry the read
+ * if @sign is odd or changed during the read.
+ *
+ * @sign:            Sequence counter (bit 0 = update in progress)
+ * @resv:            Reserved
+ * @nsec:            Nanoseconds at last update
+ * @cycles:          Cycle counter value at last update
+ * @frac:            Fractional nanoseconds at last update
+ * @mult:            Cycle-to-nanosecond multiplier
+ * @shift:           Cycle-to-nanosecond shift
+ * @mask:            Cycle counter bitmask
+ * @overflow_period: Max interval (nsec) between reads before counter wraps
+ */
+struct ib_uverbs_clock_info {
+	__u32 sign;
+	__u32 resv;
+	__aligned_u64 nsec;
+	__aligned_u64 cycles;
+	__aligned_u64 frac;
+	__u32 mult;
+	__u32 shift;
+	__aligned_u64 mask;
+	__aligned_u64 overflow_period;
+};
+
 #endif /* IB_USER_VERBS_H */
-- 
2.43.0


