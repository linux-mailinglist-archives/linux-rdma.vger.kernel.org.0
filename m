Return-Path: <linux-rdma+bounces-22084-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wgWPMgCPKWoLZgMAu9opvQ
	(envelope-from <linux-rdma+bounces-22084-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 18:21:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 349B466B5BB
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 18:21:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=UjugvN1H;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22084-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22084-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 840AE3627548
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 15:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377AD427A10;
	Wed, 10 Jun 2026 15:42:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8798748AE12;
	Wed, 10 Jun 2026 15:42:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106172; cv=fail; b=Qucm7ux4mBqaZNZmIH5xPYSQ0/7juYef/ZIFQ60xzMtQVez/VC4yo9CnrzmNSpqw9uwXcwVqlq2YmZuBmnYr92QtEUbap//Ahk0evtgPuJDckvPcJUqjeD0/6dRW3FSQBCz0gXh5JvoaUAw3Vequ/+fsDUdMUs5pmiU4SjiEcpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106172; c=relaxed/simple;
	bh=eMYNowOFUhuRcDDp73Hi3cFIYgTd17uUvVPQt5dokHU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTl6qKQUz4fN75SUILel0hMXDgb22FqVnm77EshP4T4ext+GeRDx96Dl2eTNT8ki9wXX+PW0+JEd7wJZUtd6Cii3HMMVxli75erzHvYIfcg+MeuGTGI45pjPstdg7Zsj1JTdjV3iLTh2t9pmp1HStWxRaEbkNgxyjz/5Tku08QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UjugvN1H; arc=fail smtp.client-ip=40.107.208.23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oihNnTdGFJGXSNT6sdNTdgIzG561+lDKgZlXkOe1h9DQp2K08iAr5+pGNg+74+a5GJ0WP3BrgKWifh5TKYojbu8N1DJMaHG6EKH4f8ljW7qat4ztYSGMsts1TrIji/Kk0EcFusg73y6Na5cOKnwdkWnGz95OZx605YfAQPstD8P1mJ15IyGZuoXAP8wSf/4Yrjk4Nw9kdLhM7rk8CJslM6DzOLrbOBmuQLvBLoLppP5OG2ssJPeD4/sY3SJIp5kxxxGvfY9ko/OspX4tN4pVM2QSOAzKIEjbD0fJ2Hq5BTJvPwvkN5sigkxEE8A6xrIpLFQm6wqu/XPCFY9m0FYH3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMe7Azw7JSxyTgI/jHxFnhhmL0JukzyPj2qiasOI90w=;
 b=qe4qcbGKavhQKcUQx22i42WA1xbmnBfnsTWmOgtehAwJVaMP5e1v9+chXJVq2GE0mQDtpu8rCZalopjFS3ETglaBkX4zFnWVtKkhmYZymaXBC3dhki9n0TpRHGgQSvXAof3Z0Tnb3usO+efh1xBOyBdSMzv2E8GwZDDasg4Ncs80pMX5gj6acQEkM5lOk5ylF7uJqExE+2laF4pEuWEJ+NuMxLh7eO47MYmNq6uTL5DnTn7FgnVK2M8k5hpANHz6Rm8zg9V9V1OIUGBFq5xiVVjQNIgeomecDuNq/TxhGxh0e4uVHRMKnVqtT+UjTpsjuhFyVc6NSl24bAa6Q1QvYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMe7Azw7JSxyTgI/jHxFnhhmL0JukzyPj2qiasOI90w=;
 b=UjugvN1H67cRQC1pf2uiN+vNxvgVL2VMxnnf2TO0fHsC5K5JP5uuL6nAUkBqTwccBE7/O+a+7JJl27lMz4vQTXv3sJ0LCKGShSZSwurTDbYFqcxsM8aTC75/fu6ahB+SVHxjAg0CDOF55sp+DGQBgmxExGB4283UznhN2g4Irfo=
Received: from CH5P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::7)
 by MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 15:42:45 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::7c) by CH5P223CA0009.outlook.office365.com
 (2603:10b6:610:1f3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Wed,
 10 Jun 2026 15:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 15:42:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 10:42:44 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 10:42:41 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dwmw2@infradead.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [for-next v4 4/5] RDMA/ionic: add completion timestamp to CQE format
Date: Wed, 10 Jun 2026 21:12:15 +0530
Message-ID: <20260610154216.712374-5-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|MW4PR12MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: dc7d72fb-75c3-4e4d-a1c3-08dec706ea96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|36860700016|82310400026|1800799024|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	wU4Lxj0xetvm8pM2qceOdYfWC8nWpIReEVwBBHsVBfOFMDjQpBMsOFpdbjROiXS9gcl/9GYtppeXWft2E8wbtrANlwxvNVzYX2XxmWbdXpD/6vptfCAgHUXGPeSxxi+PTIOdEMlYVAem+oDlasRWkMCPtzLGOgEt055rfNaysHDrBNhn/nQRxFzYdCvM+Dw0k705NZZHeo40hYaqM+wPVrI/OnTeIL7PL9IT/K91tX+nZ/t2oOD530ZcX6pONb0DhZUh6aNugWeZVFd0grl39zgI6UFqQur062fEb2Ahi8lXyQoxQRrcyiwyDdf9AjXIQJQZ3RdvudwVb2a+N6WQLY2gPweeg+/IQ8XYNXWBYSbBCY/K1U+vNz0cd1nux9uSaKzZeGFCdOUscfPlTEybbHqrMsfBD9y1OXWej7DMQ4VrPPhxJ3ELjdeBo2ogC4rQV8hRN3FolsJjqw2++LmeBeVIvThRCaxPlbmbzRV9Z/xX+Y/TWIbkZzEzR7giAMHLONALfRmM0WNC4Gzo25WZ4Vb/a6SgG/DsRuTHWX5dQqEIP8SnXKolEEe8+x4BrJemsj9WHsGnVqro4EgEKN3/d2xgDV7C878XKjAJqtCnMZYzxld6kDIved+d2jp1GWZS8k/zB2EvqmyBTiJuukf7H9M9SC/cVZxgYpqQXuHgGMTZQLGO4pegKyh5/2ply9d0xsRvfwg3mVZ8fC9LuRGn6x8LYR8yt6HesOu0gn5n2Bs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(18002099003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kYNW9ESvY/FSwhPL+wePcRE0I438XbpnZc4vixKZ57+8El+YIfAH+ZDCuGdMw1i4TQqbbRMFQuC/olOoMSoxrfjis0MOI5xo8XEvWQs+j7yDTX96cC2aP5xcYkVpDt8LnPrbE31k9eUUa6V1hDixjMdNgc3xCxIYsverZPiy1i/KFxDm8/UrA0fixpzQf8c2jwXh+9G3+oVQYhb0wtA8nzWcpLTPG0j2YS4Pzz+3xLnDCab0pz4DbrKS0pZ88nlob/hUOICk3MQTsUKP5f4Gvj+TqQtRe/rU9lJvUGZ6CJ4+9IfAtZl7ulzH3qwxGTS1UgDAfRczOrLewXl8g4Jprac9T580T909y5Zk/f1CaIDJI3DOhD+lsb4IppOCEY9kN5oWFOy7UieVF5u/zmXlMPIEw5uG56ink3i+BD1aMF1rIdKEVHLfgIalSGvPE3M6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 15:42:45.2096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7d72fb-75c3-4e4d-a1c3-08dec706ea96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705
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
	TAGGED_FROM(0.00)[bounces-22084-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 349B466B5BB

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


