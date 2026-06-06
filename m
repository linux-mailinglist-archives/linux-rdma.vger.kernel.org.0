Return-Path: <linux-rdma+bounces-21891-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ffn6JPOpI2pwwgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21891-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 07:02:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3438764C76A
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 07:02:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=4g093we6;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21891-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21891-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F80B3052635
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Jun 2026 05:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCA33093B5;
	Sat,  6 Jun 2026 05:00:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191563043BE;
	Sat,  6 Jun 2026 05:00:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780722031; cv=fail; b=d2l+uhit3SsqymCLTNUhuKH41K6oY28JzUQMJWAaYzuE4Ot1cSNLOED2hNm5ox5vTphDaw6+rJgrjMTl/7LxRynddCqWypQ2KAvu3JtYQdUlF+jHauVIncNgSp4z+MSGl5jJW/OUmM+XeLB/cU6GfQbljx4mHJISJca9NylZTXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780722031; c=relaxed/simple;
	bh=EwtdOObtBNwqHNMzyUGh6rYm3h0c29dIUdKiRuwaYdE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=olgBWkEjLi93nWOp8wjlsG9Zm7H4VLsHYCzazzsgCGUdHHO/iDj7KfCK1qPnpUKtXgjfqceQ322+BSEF5NDxfyLrFWIEQ+NMTomuxBxF6nHI4d2s3WR3OgiA9FzBoHVgeicl4zZ7h73p6NZyyOo8uTx+TyBNUEhRfRy6QUVtr3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4g093we6; arc=fail smtp.client-ip=52.101.56.9
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1TXNZ6D3J+ecCf/nUbVpIMN98i5qQvVfBp+S4hyENsfRmmRmnHEsLHPLfiC+pi9m7mJla1KwbdCrS2esLKu+xTjOz66KYxUAnKhSTFSCadW1cZSDCbvHkM7Wj2uPD8lqaxh1tp+Yq2hNhnwG3AjABfWA/Q2cUI7OTXHrU0YTAv6YzuQ+g5wn7nQqn6ti/B2uB6UaiEeBTXOIyjCKRMNIMtImSEu8/NkepWO8WpmjfxYa6Mv6WIcL4SCjEHVqgJkX8pJs1rAOOOmDhe4hHf+uZtwRcUxWtRzHLtj3+nREYXkl0zyoQzZadgatz6w3nihj3GC4r0Oi9ryK9DTKfAngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWCNdfWImQ/YrniVM7t/ARc07qVhaO5DYF9alCttMbA=;
 b=iuStVBbvM6dnXMJ+n9Zza6o4CXZ/JPsd8mxU75+TBOa/YAOnsWbn8CR31PrX9mFKC8tzlvi7tkiA+ov9id4fvkQjQtcafIs8DjmTJfRt50gNG8YEHS1ggiKdYOUg7FQCE8IGJeQ0Z9abnTOByW9GayQ2Dxi00b5COBL70CW9k1EClJ4oSET8K2j0nJuxtbhxTKu2CZ4lQ31WiEsT43nvt2cXdEQ+DmQNkfU/zQY/5Cig5ZDUhQ7Bsd3kQhRO6INKr+f6gdFC0PFS/HC2Rf2wbpUZC3HfsFG7stmA7l06+PzX118fKwsS4lP/D6iXk7lToHVsG+4ezJ4zUVr8cwc9FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWCNdfWImQ/YrniVM7t/ARc07qVhaO5DYF9alCttMbA=;
 b=4g093we65GwuaDii9Zkun5si9T9mtiNeJ2QjxsjdSOBxZfjH3iVvH06Ua9Ftva1S+kD1H8y9RFwHU52eLer4avPQzsnEgwiga9OB8m4OQMj5sSICGG26wV9c2xSAqfHYzgau862014zbkbmMs1blnaVe/ITHVpaxX/vKCZICgmE=
Received: from BY5PR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:1d0::20)
 by IA1PR12MB8262.namprd12.prod.outlook.com (2603:10b6:208:3f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Sat, 6 Jun 2026
 05:00:24 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::31) by BY5PR04CA0010.outlook.office365.com
 (2603:10b6:a03:1d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.10 via Frontend Transport; Sat, 6
 Jun 2026 05:00:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sat, 6 Jun 2026 05:00:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 6 Jun
 2026 00:00:23 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 6 Jun
 2026 00:00:23 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 6 Jun 2026 00:00:19 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [for-next v3 2/5] net: ionic: Add PHC state page for user space access
Date: Sat, 6 Jun 2026 10:30:00 +0530
Message-ID: <20260606050003.3648306-3-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|IA1PR12MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: 709df8b7-266d-4c2d-2f12-08dec388848c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|22082099003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	a8EWgqlEh257v8L7WbVQwGfNfQr5GAoFXAgqmgpxlH5zJlAL2NmkgkUeBMrFwqUIrFbB4qntC1bfdq/Oxly+mLQ3hBpbTAJ+HzkM4V7A5VlV7EkCmXfcoi/JQU0Pvms3oJSFH6oXrzwHGt4Q3VQsTqfMVOhedIjuGA8YVJFKKvv8hadvSrEcvuyL2aFII877tlSv9+w842iofthGbpQpuvMihSzP0bbusbwiU1OXuQQ+bDeFNMw0ESacm+d7GBAHNar6Mpbt4eOOEsoDwp3GsOm87ZYegzYin6zRx0amSdghWnktjaKczI787JZ3ZlZPZQJKU3fV7Mnz7sMTUks4tYf3Re/0ePNQse07Qar78fV6UQsJNQWrBKcoNx8D3jKAcLvX2zm8bopb1WuPr1H1cMH4J1DhDyvQj7wDfswh0olgC/RG26z/0t1RIZDkxoGJt7TJyg9PSWb6W79HByEody6bQYyIGuMw/v41JAvfSmvLyMab2hwgBAMkzSyKJXc9Tljb4MmVD/jdnVkCPXLIbruU0KcX+/BO9IvrxVzU3Azz5LiLaD2OLmpP65rrOpVmPTyH6REy09bOdFOkva5u0u0Q0X5xeWPxbeMRuL2V3h5Rqou+bcTG2nODUQQg71xU6kYMFrYTnGUDRLfci+m4du1xYObXLoRVVNGzyccyopiuIbpzW+l7HXVUHyNprF14z3olKwkk5tgU+/1AM8rJognN3krGAsaFZKuUExFGXT4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9t6inLUbCHif2khSGrtvAxfjm3AsMIhJScP52ZkpxZncjmrveb9TWlAnr3HjDZR/2F5TuSCbS5Fj2UefG/SLK44DoZEtL77jxw2ZNPKwFHC5T/4fY6/1AaPb4cQgsYZ+5NYPL6bf3pOff46mb7iGe4XuexQU8CLuW3chCCHUrDsiAB6C/EpiOR7vq4Q76Gid9/DoaCj2eBIFvi5/e/s0VRxa7L5qT34iKxZQnLDjXYiHBCpXUYu+MZU70haZhO9SV3XSKsSR4coIDUAZLatOLYTZcItbW/hqa7lc5j69DPvPkfhQ73l99vVL0Y/ONVqpqbGMmDFsLZ2WzBzd1aYdBPAFoD7+AN9ULfNrA+PTOadfcPiM9FtXAg8iC1RoVnW+vZMVCW9ybB0tcXVP4RKsfF8WbLL4w87vwMi2uWi2+l856zc8RwWka5wHiy0bzux5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2026 05:00:23.9238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 709df8b7-266d-4c2d-2f12-08dec388848c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8262
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-21891-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:mid,amd.com:dkim,amd.com:from_mime,amd.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3438764C76A

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
index 43bdd0fb8733..1c74ecd16475 100644
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
index 1e4e7772bd5d..6c93eafadffc 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_phc.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_phc.c
@@ -3,6 +3,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <uapi/rdma/ib_user_verbs.h>
 
 #include "ionic.h"
 #include "ionic_bus.h"
@@ -319,6 +320,26 @@ static int ionic_setphc_cmd(struct ionic_phc *phc, struct ionic_admin_ctx *ctx)
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
@@ -346,6 +367,8 @@ static int ionic_phc_adjfine(struct ptp_clock_info *info, long scaled_ppm)
 	timecounter_read(&phc->tc);
 	phc->cc.mult = adj;
 
+	ionic_phc_state_page_update(phc);
+
 	/* Setphc commands are posted in-order, sequenced by phc->lock.  We
 	 * need to drop the lock before waiting for the command to complete.
 	 */
@@ -371,6 +394,8 @@ static int ionic_phc_adjtime(struct ptp_clock_info *info, s64 delta)
 
 	timecounter_adjtime(&phc->tc, delta);
 
+	ionic_phc_state_page_update(phc);
+
 	/* Setphc commands are posted in-order, sequenced by phc->lock.  We
 	 * need to drop the lock before waiting for the command to complete.
 	 */
@@ -400,6 +425,8 @@ static int ionic_phc_settime64(struct ptp_clock_info *info,
 
 	timecounter_init(&phc->tc, &phc->cc, ns);
 
+	ionic_phc_state_page_update(phc);
+
 	/* Setphc commands are posted in-order, sequenced by phc->lock.  We
 	 * need to drop the lock before waiting for the command to complete.
 	 */
@@ -457,6 +484,8 @@ static long ionic_phc_aux_work(struct ptp_clock_info *info)
 	/* update point-in-time basis to now */
 	timecounter_read(&phc->tc);
 
+	ionic_phc_state_page_update(phc);
+
 	/* Setphc commands are posted in-order, sequenced by phc->lock.  We
 	 * need to drop the lock before waiting for the command to complete.
 	 */
@@ -543,6 +572,12 @@ void ionic_lif_alloc_phc(struct ionic_lif *lif)
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
@@ -554,6 +589,7 @@ void ionic_lif_alloc_phc(struct ionic_lif *lif)
 		dev_err(lif->ionic->dev,
 			"Invalid device PHC mask multiplier %u, disabling HW timestamp support\n",
 			phc->cc.mult);
+		free_page((unsigned long)phc->state_page);
 		devm_kfree(lif->ionic->dev, phc);
 		lif->phc = NULL;
 		return;
@@ -637,6 +673,12 @@ void ionic_lif_alloc_phc(struct ionic_lif *lif)
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
 
@@ -647,6 +689,7 @@ void ionic_lif_free_phc(struct ionic_lif *lif)
 
 	mutex_destroy(&lif->phc->config_lock);
 
+	free_page((unsigned long)lif->phc->state_page);
 	devm_kfree(lif->ionic->dev, lif->phc);
 	lif->phc = NULL;
 }
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 3b7bd99813e9..4e1406034682 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -1377,4 +1377,37 @@ enum ib_uverbs_raw_packet_caps {
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


