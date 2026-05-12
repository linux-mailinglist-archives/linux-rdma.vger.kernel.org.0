Return-Path: <linux-rdma+bounces-20473-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOUUMZ7zAmrpywEAu9opvQ
	(envelope-from <linux-rdma+bounces-20473-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 11:32:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFB351DC8F
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 11:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 192D530BCD52
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 09:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5B24963C9;
	Tue, 12 May 2026 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hSi47p0x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013010.outbound.protection.outlook.com [40.93.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285B23A6EEF;
	Tue, 12 May 2026 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578027; cv=fail; b=FC4jzWNRVdC+pqjbQlGhv7fDDoTqb2sbeuknbUtRzKViO5XtOz6PaeRyZQvvg5B6t/3212TGwlLtThI+1NLXaUVIktN34kV1sERirJY7sLyekailn2TNI2Q7g6AIS7e/dAGw7s6YljXVWZ2r7qiNaJdqJs/hvl1e0g2+PUNc18U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578027; c=relaxed/simple;
	bh=eMYNowOFUhuRcDDp73Hi3cFIYgTd17uUvVPQt5dokHU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGuxGsOm9QpRAdINncqwIS4sSX9UhZaczsYLZtH29HdCCNNGmryVt0fPjTLl8InIFPAbsAnS9Dh5UomV799epSmEEpnVbrFotFnuldoRU/N0RzNIFpWKp8Qt3dJmqANGZoMIkVEmp9lG8ErQf/AcnE8agjzUZtzBTNj3bDBwkwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hSi47p0x; arc=fail smtp.client-ip=40.93.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wj8Qe5ipmibVmCRRnAE3tegajlKyo4yT3Y0mBa7AqQz/0hyx1NIpUI6XIDAi30M1nkoD1jXO++4+4RER/P4np8oE6QK/sR3eUI6u0nNQHfP10vYDPx4FPNINLwFCnzfdgrejymEHTjYXO3cSnUR5rn6pMlTVzQRoWlWjQ3WprUV+kHsynR8/2cOEsUzan+f7Nz1miGy53BI5lmOD7UCt+VKJO0sZRwo2QZNeo2CbKMkMEeVXNRwaM2ZNEQ16Z8s1D9elgGJdKgXe6WK/KLkDBKQai3bnheAgS0bL0L4Z4gC+ZLLrAB4x6akKbhJmNyW4E9wgvl8Q9BarUzydcFO7yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMe7Azw7JSxyTgI/jHxFnhhmL0JukzyPj2qiasOI90w=;
 b=a2C6fpB3bDklX9TQZOkphIVEA7t49oJIgB386md62tJXCew+VSQ26OfsjmYKnB62tl960OglPTGgbJ9AwPXy+eThH5OWni7B6ex6bfii8YwlVsKKwYuc1FRpqqD3O6bBOawCRkMRrMapaV9XupEtILhqt8AviR/PlFKlOw2dIW1HnEl+GwHxAhOSfdrjJ98t2Aw1X4hm6l2r2EAGkeKvuh/X+c7uLpNMuf5vm4psC9/XajvmnMettDsk1/H8ygoXmq42TmmqgRk7RE0IU4WZvPymRhNPwgqgeQgwod+zuW4qZhSn7gxcjz16IQVx2PkKha0zZUZcMYGCCnJTWjfkSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMe7Azw7JSxyTgI/jHxFnhhmL0JukzyPj2qiasOI90w=;
 b=hSi47p0xjFK+u0/L2u5s9+SJVa/+MQTKQa/7mZTe6yTix/ESL6GGEBCJMeM2ic0Godt0C9NG33dCg+zrRheqWQ1HTFldZB53td5S4K3OAjzLHaeShJjGtE0nfBkYl58iP3y/Rq+R8IXDhj5O6D7/3D4NzvnqJeZXGhL+Z3HhdOI=
Received: from BL0PR02CA0073.namprd02.prod.outlook.com (2603:10b6:208:51::14)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 09:26:55 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::3b) by BL0PR02CA0073.outlook.office365.com
 (2603:10b6:208:51::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Tue,
 12 May 2026 09:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 09:26:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 04:26:54 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 04:26:54 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 04:26:51 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [for-next v2 4/4] RDMA/ionic: add completion timestamp to CQE format
Date: Tue, 12 May 2026 14:56:23 +0530
Message-ID: <20260512092623.1157199-5-abhijit.gangurde@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f16eb7e-0063-46fb-66e7-08deb0089bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|82310400026|376014|22082099003|18002099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/AK7AMLG6NzDhX3rW5wOyoFAaMmESYYj5/4sOMVCafA4veY5U0Mv7aEPxAA21Ur2dyaILl8FptLYaScJA5V6ywtvhYcr56hIm634tv+iCIx9uZAQwCEjxdTNznI40ppfNhg6B2DifDtARVc9gEd6HLue8wLcEj/+NcVs0XTeGyUEQ4BzH8uM+RYvibtaKh1BmCL1gyiwhfZnTs77NlJQUk1xO3AjwAtsFQZmRYQDvHb+uwrBEsE+0/T4qxqWQFhRVS1Ep6Bn7euDOuOSOhk0iF2rkavfldXPa8L77PI6XTLO2cj0TaGrxJaQ+tMxgjpgU7ULlC6/lbaSq1ESCp4Eg0L6JKeRMBbbmHQyTAv9jwLFDbcEFLmSzdMRhH+C7WAcV/LHnYr5+Oo55iqqDncD19Q7ckcUldvaz3OYsTasgPwxPY6yu1iJH0ubc1PPoFMxoBdJ7TR27lIZhmsbotvwHx2Lxd2CtrKBt3TKRIe7xdnskJ350S119vaCmQlDnQHL4AiYPvAwBcfRUshVd3jVOg/3YXrB+JPIu0VPG/8kxe1JJcVDhysD+4hiVwnE5lyK6Xb2K08mYLk+vCWzubOJQJSHcgynTiJbY2oOgVTJk/Cs/1RFMxNsAFS0qDBj5iKzCdYrGidruQ6E/P2h48o8f08vTkM0hDNIP0d7LYyS6Sri9ZUaRxR2TfSrC83/cMLmQJvHQwLhIS0R6RsEJq91oWItderuMKRjtBmcsZ5xuf4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TbxN2K0I83j8ZPiBaEdyFre9xtmNYFwSaUustIhLF2QPW/0gR3qZA5j89o+SvfYQqjzsJdWECqmxSaPnNGr4PkyWYcbA5TMqDBxjlq3+eDVZGdjN47Nuy1z2ds+8aIiMQLdC619ifqLVfR9dqswBuYYJ6dei7993mtBJkmjuo2044oh3TxtvxMMq3nWR5WbVtUWHfM3g4G44A0yAO8VQte4iOPIsYK2c0qOPsmx6Uf8dqKvpE260+WDAD1TLs28AzayJiy08bTXDQzLDzXScAg207Otqp80+xq2sHFEFt8XSNHGOPigaQMICBOtsIOkhd04y4ugT0IrkHopEj5Pr5J0wQc/XyLgGqZ9QUv1hmlPD2mjZ7Y/ZLGe9KQXm/HkBYwiCJXZvGqv+PkVhWAOPqXyLj7wR9SW7wbNUy+qHZ4R0QkwMTLt3Ee7zMSLqs0Oq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 09:26:55.2128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f16eb7e-0063-46fb-66e7-08deb0089bc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301
X-Rspamd-Queue-Id: 3EFB351DC8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20473-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:mid,amd.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

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


