Return-Path: <linux-rdma+bounces-18897-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAo6BlH0zGl9YQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18897-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 12:32:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F33383788C7
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 12:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B56630A4935
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 10:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3260E3F2114;
	Wed,  1 Apr 2026 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="frBARuNw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4723F2111;
	Wed,  1 Apr 2026 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039157; cv=fail; b=sOQBgpbjsxA2VgjXy6jOeFTt2cKCcFOpXEtElUNXd/nMQKXYETKQ+XziSH1DSDsLm3cFAEffGVB+gvbnO4kA2iWugtq114iUCe3K+RiEYNG/vyIJtDJT/fUXf2Nt2uqdYnhOyRtONlfDhq660fACmrtvb0PI3Ro7wSPADL+PkQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039157; c=relaxed/simple;
	bh=eMYNowOFUhuRcDDp73Hi3cFIYgTd17uUvVPQt5dokHU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7zl+UiV7zS3hPMWiCHqrNn/KSagSv06Bm22nTtC/IQJUgNZcriLlnoy+rMwlSje1chrDL8oTTjQkmD/HYTrPunqeaUmymrEzAULqifB5oS3b0P+w3hA4reQCWrgxu9aNXNw/R0NsfDCkNEF1e0Zjv1SO1PdeA18HszrcPbWLUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=frBARuNw; arc=fail smtp.client-ip=40.107.208.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2DN7S++DQrXkEqeH01xuI/DqhKpugf87sPgrwMjitLO58ySAN0xljslYKTuwzrNLD0645erpkJDpi2Vd85V7Us/T2uaE9OBufGpi6+k7OnkuKnMU1KwnDptTkna5rJ0KuMZwYwqwkj7lbj9fgiEkSFNkhN1I0RVRanQSCgfapYlGq0rykELAlu8VZMbaUZiz5PJ63Ue1LXQz69xF0bWnTdK9yCo+8ygtaBHmkdRFCXtjPsDRetMjxsrwUiKolbdqz8ipgH3w4iZF8Oj7X2nGjszlrhGaNmemJf095pm0ZopmIrg4O5S8N0Wu/zvSO2hLEes6EBV3QL4MNLiVw8esA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMe7Azw7JSxyTgI/jHxFnhhmL0JukzyPj2qiasOI90w=;
 b=toWed/BjhhXT1bi4rXbfOO9feU7DjDT/0LpIx7hhsIhukIeP6xWKZHUWUkgt2R1Qt8JRqpjWIqKHY+ZGHqwOQNOJn35vnB1BMBNAalkxVW5OL5BeX6vDw2x+znrOvYru5CUqEiYT3zPS7wG7dSuvepK9itdt/ws79RifuQHk5JSNgDkjrEdWhF9DiYDtK9taJB/e0g6NG95jk2auql6dxVNxgAzAqo4+wJ31+dpv5OoB1WZ/NvPoRuDIhLxNp1qLx7TWxUkxOQV8ySduIMJj2xn/VsF+gVo8+ArtxB0UJm4HwZfp0DLD1KPV51PEGjGrwFgTHct/8ynW/DhWQdTSJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMe7Azw7JSxyTgI/jHxFnhhmL0JukzyPj2qiasOI90w=;
 b=frBARuNwoalReaCcGyejVs7+IMBHRwJEw0W1xaw+yatlm5JODB2sciHYcywjTsb08Wzl6fOS/hpsfjN9uPW2KStAT1svGN+N8trGVfL4A5iwCWbEYblK13H8xeY8PQ4oCiosb5uhoAF8gZ6kAznbKOlElVlcynIfz83G+VEowk4=
Received: from DM6PR03CA0073.namprd03.prod.outlook.com (2603:10b6:5:333::6) by
 SAWPR12MB999142.namprd12.prod.outlook.com (2603:10b6:806:4e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 10:25:51 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::be) by DM6PR03CA0073.outlook.office365.com
 (2603:10b6:5:333::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 10:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 10:25:50 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 05:25:49 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 1 Apr 2026 05:25:46 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH 4/4] RDMA/ionic: add completion timestamp to CQE format
Date: Wed, 1 Apr 2026 15:55:01 +0530
Message-ID: <20260401102501.3395305-5-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SAWPR12MB999142:EE_
X-MS-Office365-Filtering-Correlation-Id: 6884ffcd-c2cd-4afc-dc53-08de8fd90bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	I4kDUpiUVez6sgvKdYIG2nhx6n/nrKUiuG6DBnLdVju9zgFKGUlTJVqYk868zremDbViTG7VXGpkmgxjANuOL1B2mKmVrz3c7GVDmMmt8SoUmhbHiFpMMN25nP9mWcMjaXbmrSkWot9/jTyse+tVM8r37xg5J2nWg/mGIARKxD8CuxU2YaaMtpF+5rVp7I0bT5yzjGcTHGgveOjNTnmHhWfgBBVYhMHQf9EbspjyrPjU9gKuBc7wron6TiU4NIVCaif375HLp7VOxgHml+YyWCJSPVpFM0abslpFgEZLQJqkhUCOwMQWHZbYkCr//p767OKQwUjFmpRFl5DYEuB/LaEaWC3HAaVBr+JPqxOHoSeGMlR7pTd+PbV2rh6TtOmol89WUODP0k4AveRHxa+im0o98B05/ZGWYTMFUU12+Buj8/d2NaW9dU1YJSOkau26zUREOnjcbJv4Z1CC65MfVREvP1q0EAmrBMDmd40YJD4BdIz7WBuLk58nrweoC4o0wXk9Lr72cK5Xgwil5SzF3FgZc0lxltqYV82RPSfPvuox9jSn9u7eDCsFrCMXNvUbfWgUHwIfDkReuEdwSCeA4y9R7IAklBG1tJc+K2TFpWN7gioXlhrjWE/tZzDStg9vT+AADWiCdW5RX2p3PnnjxOOPSGx0BNsD2Lx+2mVDJ221ekkL0uBO0y8N2rtIkOsBx1+MKTpL/QR8NGLYQAIAaQhFkp82/u3NcUq3swCe7q2XEOvdVXvKhoKnBZQdu/jZZiTWpcjy5OTjhHqS1dIRaQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZVSPEImS2QiqFg3W0cHxDHcZuxa6VvwTlqJuavfwne8JsiJIjpU5Vq83pEy3Kw+UAV9kYkGceGwpppOdv9+GFaUP+I5Jr+a8TEf0bMjarz8Kz8t45F7eBZreJ/z/MwLYKfdpb92p7w/7pXqgqY07yno3gajzMlfj1NgHnC3u0zcBPf0kAIro/C9tBf+Y0n4tTidK/jiXamG0pVSNyR7QrQiIO0CRvtxzzBF1m5iInLyRZGTGYKhcz0vON/Z+3IcVqAmNAxTE/Q8KeWXIViuEDkNlhpq3rosqJqKrh+GKzJl1/1NCty7jSGF4M4NeyTXXYRkttE5Ps+doCIs4nntyJJJTsvvu8kfjv4n9pUjJ+rzOqeGXrbTIIULL6nLq6BGBWjurV6yoiV9p34N5avsKC/RReypgDJD1YVFj4e9q496Q0AX6Q6wh/Az6qa+06mfH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:25:50.4282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6884ffcd-c2cd-4afc-dc53-08de8fd90bfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999142
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
	TAGGED_FROM(0.00)[bounces-18897-lists,linux-rdma=lfdr.de];
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
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: F33383788C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update the CQE structure to include hardware timestamp.
When firmware supports RDMA completion timestamps,
the hardware populates the timestamp field.

Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/infiniband/hw/ionic/ionic_datapath.c | 43 ++++++++++----------
 drivers/infiniband/hw/ionic/ionic_fw.h       | 12 ++++--
 2 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/ionic/ionic_datapath.c b/drivers/infiniband/hw/ionic/ionic_datapath.c
index aa2944887f23..3e2300f7ea10 100644
--- a/drivers/infiniband/hw/ionic/ionic_datapath.c
+++ b/drivers/infiniband/hw/ionic/ionic_datapath.c
@@ -32,6 +32,7 @@ static int ionic_flush_recv(struct ionic_qp *qp, struct ib_wc *wc)
 {
 	struct ionic_rq_meta *meta;
 	struct ionic_v1_wqe *wqe;
+	u64 wqe_idx;
 
 	if (!qp->rq_flush)
 		return 0;
@@ -40,21 +41,22 @@ static int ionic_flush_recv(struct ionic_qp *qp, struct ib_wc *wc)
 		return 0;
 
 	wqe = ionic_queue_at_cons(&qp->rq);
+	wqe_idx = le64_to_cpu(wqe->base.wqe_idx);
 
-	/* wqe_id must be a valid queue index */
-	if (unlikely(wqe->base.wqe_id >> qp->rq.depth_log2)) {
+	/* wqe_idx must be a valid queue index */
+	if (unlikely(wqe_idx >> qp->rq.depth_log2)) {
 		ibdev_warn(qp->ibqp.device,
 			   "flush qp %u recv index %llu invalid\n",
-			   qp->qpid, (unsigned long long)wqe->base.wqe_id);
+			   qp->qpid, (unsigned long long)wqe_idx);
 		return -EIO;
 	}
 
-	/* wqe_id must indicate a request that is outstanding */
-	meta = &qp->rq_meta[wqe->base.wqe_id];
+	/* wqe_idx must indicate a request that is outstanding */
+	meta = &qp->rq_meta[wqe_idx];
 	if (unlikely(meta->next != IONIC_META_POSTED)) {
 		ibdev_warn(qp->ibqp.device,
 			   "flush qp %u recv index %llu not posted\n",
-			   qp->qpid, (unsigned long long)wqe->base.wqe_id);
+			   qp->qpid, (unsigned long long)wqe_idx);
 		return -EIO;
 	}
 
@@ -133,8 +135,8 @@ static int ionic_poll_recv(struct ionic_ibdev *dev, struct ionic_cq *cq,
 {
 	struct ionic_qp *qp = NULL;
 	struct ionic_rq_meta *meta;
+	u16 vlan_tag, wqe_idx;
 	u32 src_qpn, st_len;
-	u16 vlan_tag;
 	u8 op;
 
 	if (cqe_qp->rq_flush)
@@ -144,7 +146,7 @@ static int ionic_poll_recv(struct ionic_ibdev *dev, struct ionic_cq *cq,
 
 	st_len = be32_to_cpu(cqe->status_length);
 
-	/* ignore wqe_id in case of flush error */
+	/* ignore wqe_idx in case of flush error */
 	if (ionic_v1_cqe_error(cqe) && st_len == IONIC_STS_WQE_FLUSHED_ERR) {
 		cqe_qp->rq_flush = true;
 		cq->flush = true;
@@ -160,20 +162,19 @@ static int ionic_poll_recv(struct ionic_ibdev *dev, struct ionic_cq *cq,
 		return -EIO;
 	}
 
-	/* wqe_id must be a valid queue index */
-	if (unlikely(cqe->recv.wqe_id >> qp->rq.depth_log2)) {
+	wqe_idx = le64_to_cpu(cqe->recv.wqe_idx_timestamp) & IONIC_V1_CQE_WQE_IDX_MASK;
+	/* wqe_idx must be a valid queue index */
+	if (unlikely(wqe_idx >> qp->rq.depth_log2)) {
 		ibdev_warn(&dev->ibdev,
-			   "qp %u recv index %llu invalid\n",
-			   qp->qpid, (unsigned long long)cqe->recv.wqe_id);
+			   "qp %u recv index %u invalid\n", qp->qpid, wqe_idx);
 		return -EIO;
 	}
 
-	/* wqe_id must indicate a request that is outstanding */
-	meta = &qp->rq_meta[cqe->recv.wqe_id];
+	/* wqe_idx must indicate a request that is outstanding */
+	meta = &qp->rq_meta[wqe_idx];
 	if (unlikely(meta->next != IONIC_META_POSTED)) {
 		ibdev_warn(&dev->ibdev,
-			   "qp %u recv index %llu not posted\n",
-			   qp->qpid, (unsigned long long)cqe->recv.wqe_id);
+			   "qp %u recv index %u not posted\n", qp->qpid, wqe_idx);
 		return -EIO;
 	}
 
@@ -408,7 +409,7 @@ static int ionic_comp_msn(struct ionic_qp *qp, struct ionic_v1_cqe *cqe)
 static int ionic_comp_npg(struct ionic_qp *qp, struct ionic_v1_cqe *cqe)
 {
 	struct ionic_sq_meta *meta;
-	u16 cqe_idx;
+	u16 wqe_idx;
 	u32 st_len;
 
 	if (qp->sq_flush)
@@ -430,8 +431,8 @@ static int ionic_comp_npg(struct ionic_qp *qp, struct ionic_v1_cqe *cqe)
 		return 0;
 	}
 
-	cqe_idx = cqe->send.npg_wqe_id & qp->sq.mask;
-	meta = &qp->sq_meta[cqe_idx];
+	wqe_idx = le64_to_cpu(cqe->send.npg_wqe_idx_timestamp) & qp->sq.mask;
+	meta = &qp->sq_meta[wqe_idx];
 	meta->local_comp = true;
 
 	if (ionic_v1_cqe_error(cqe)) {
@@ -811,7 +812,7 @@ static void ionic_prep_base(struct ionic_qp *qp,
 	meta->signal = false;
 	meta->local_comp = false;
 
-	wqe->base.wqe_id = qp->sq.prod;
+	wqe->base.wqe_idx = cpu_to_le64(qp->sq.prod);
 
 	if (wr->send_flags & IB_SEND_FENCE)
 		wqe->base.flags |= cpu_to_be16(IONIC_V1_FLAG_FENCE);
@@ -1205,7 +1206,7 @@ static int ionic_prep_recv(struct ionic_qp *qp,
 
 	meta->wrid = wr->wr_id;
 
-	wqe->base.wqe_id = meta - qp->rq_meta;
+	wqe->base.wqe_idx = cpu_to_le64(meta - qp->rq_meta);
 	wqe->base.num_sge_key = wr->num_sge;
 
 	/* total length for recv goes in base imm_data_key */
diff --git a/drivers/infiniband/hw/ionic/ionic_fw.h b/drivers/infiniband/hw/ionic/ionic_fw.h
index adfbb89d856c..ee23062a1762 100644
--- a/drivers/infiniband/hw/ionic/ionic_fw.h
+++ b/drivers/infiniband/hw/ionic/ionic_fw.h
@@ -332,7 +332,7 @@ struct ionic_v1_cqe {
 			__le16		old_rq_cq_cindex;
 		} admin;
 		struct {
-			__u64		wqe_id;
+			__le64		wqe_idx_timestamp;
 			__be32		src_qpn_op;
 			__u8		src_mac[6];
 			__be16		vlan_tag;
@@ -342,13 +342,19 @@ struct ionic_v1_cqe {
 			__u8		rsvd[4];
 			__be32		msg_msn;
 			__u8		rsvd2[8];
-			__u64		npg_wqe_id;
+			__le64		npg_wqe_idx_timestamp;
 		} send;
 	};
 	__be32				status_length;
 	__be32				qid_type_flags;
 };
 
+/* bits for cqe wqe_idx and timestamp */
+enum ionic_v1_cqe_wqe_idx_timestamp_bits {
+	IONIC_V1_CQE_WQE_IDX_MASK	= 0xffff,
+	IONIC_V1_CQE_TIMESTAMP_SHIFT	= 16,
+};
+
 /* bits for cqe recv */
 enum ionic_v1_cqe_src_qpn_bits {
 	IONIC_V1_CQE_RECV_QPN_MASK	= 0xffffff,
@@ -423,7 +429,7 @@ static inline u32 ionic_v1_cqe_qtf_qid(u32 qtf)
 
 /* v1 base wqe header */
 struct ionic_v1_base_hdr {
-	__u64				wqe_id;
+	__le64				wqe_idx;
 	__u8				op;
 	__u8				num_sge_key;
 	__be16				flags;
-- 
2.43.0


