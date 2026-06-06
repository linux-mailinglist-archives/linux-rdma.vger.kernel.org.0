Return-Path: <linux-rdma+bounces-21893-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JtHbAi+qI2qcwgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21893-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 07:03:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ECC64C78E
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 07:03:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=sKDcOcmZ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21893-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21893-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 037E63066559
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Jun 2026 05:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B194E30D3F6;
	Sat,  6 Jun 2026 05:00:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FAA30C345;
	Sat,  6 Jun 2026 05:00:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780722037; cv=fail; b=UFsiVVUk3RYEJAUMEaUwgp2zq3hHELSgim+3FRas0ucVsRBsEl3ewu4kDySQqALIV9h3nECz8r2OcRsVNHEzy4MZGwY22Up2tSD+Bj29bJZgxLa5Qoqgml2c/AY3a+TLu17UXWn/L/r7ivuKy5fNhcWx+GbXhP9TBwOI9yIlcMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780722037; c=relaxed/simple;
	bh=eMYNowOFUhuRcDDp73Hi3cFIYgTd17uUvVPQt5dokHU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aIdtclpicL5dMIcQVZ5gf5/eaKNlYa0cM6+drTU7r5DApmVUR9+qRraiHrxP9he8DH6fJDymhk0iO+1jn0UCoOzuUdhNyR44MKj1FHfkaRhTww1XcQGn5L1Njrxydoo02xMb3VUWinvPOMJaLGYPPN7SyUjE6+q+WjLhAHP3/7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sKDcOcmZ; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyGOoLPZOIVQFF1dgJjhE/xWfVMAhIm8bWxHjg+zkiFfjsPYwAUGnhUJ6az2x7tsEtuSZrJ3bYr3DgJK0Uob6JDHaYrmeh7MVS9QhEaZQU2JrOxN6inCd0SYWdQ11EN6135EdxVlF8/1og1/++PRrHItQLZPLgVlXqvkNaOEKe2s0i7qJKzikOBoUbjojSD7/qrmRKHYBcaSeCznZK6P029fpxESZOlnfZRv7WtL4cYYD4FoHUbrn+6Zie5c18nZzOEoX12xOv9bacOHBW79+aqj4jnhlcnM3Shk57h0YP0q88qbUCQw+sQpEyVbExRmuED85vAQ6OAHtUGqK08T6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMe7Azw7JSxyTgI/jHxFnhhmL0JukzyPj2qiasOI90w=;
 b=kwfdIHs2pE+KMkC134N/17hu2yc/MEj9y4hTNaJ2KgQqNFL5ySotjYlGVJMK+s5lCjgINFyoYE3M7aoiV6fIzfWmrboqYzqfOifZZFpfG2dSwhBQWsDZzIjm5JUKIxhaGnUIT4HvXFdm/5Z+SJoqcr594QQb+Mgw/dB9T/EriHss5OJ425FzyNJgXpVSN1EaRYM4280uOr4phY6zv9BF3e/5c1DRFpQLH33AHx70Yv85Kt8GRoNxYNLmGtdI9GP/yiM/OTpcOYBcpUPHc5TzfpfG4AMOWpzSWBtRTnZbJOgpaokpWHXBxvWGBXybheOteQwgGSLocHkLzMPIzZg1AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMe7Azw7JSxyTgI/jHxFnhhmL0JukzyPj2qiasOI90w=;
 b=sKDcOcmZr1aNX0gtHl54/IAM5MdOG/khgzs9DfkiAzaDMeE54CGv8jS+gHVKsHyzCHmKVFLirCTuzhRwRUOgC+4slqfD9aZahYoAg9I7O/xSs77NK6vLeQzhovgx77nBlxSd0qVTheTR7SwTcOahthFTgWtUUUoTotOdGf/CQDM=
Received: from BL1P221CA0032.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::11)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Sat, 6 Jun 2026
 05:00:31 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:5b5:cafe::51) by BL1P221CA0032.outlook.office365.com
 (2603:10b6:208:5b5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.10 via Frontend Transport; Sat, 6
 Jun 2026 05:00:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Sat, 6 Jun 2026 05:00:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 6 Jun
 2026 00:00:31 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sat, 6 Jun
 2026 00:00:30 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Sat, 6 Jun 2026 00:00:27 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [for-next v3 4/5] RDMA/ionic: add completion timestamp to CQE format
Date: Sat, 6 Jun 2026 10:30:02 +0530
Message-ID: <20260606050003.3648306-5-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 5239e630-7b58-4d05-243c-08dec3888909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|7416014|82310400026|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Nu1Utg0jbSeLPwp4Rs9kCGXu7aAIe6JEeLGZga6rP3p8BihINjWtJO2LJbIav+Rloa2myiYElLWxyN9QHrFAJmXGpsG+/5hqUHn9SXaseX1YQm0Nq34YnGim/c+Tjx1UPd/O1T/sFLUJ6SFO4SJ2iMY16sJsEFANatKX95qYMKd+hHM9DfQhoYCH1iG1LUX2VQ+a6z83+rzg3XHOamGo6OhUkG32OEPT9TigPR8gtOmJZZMt0J0ajiG06yQkaQeHV1scTrPEvaxYs1bjUXKX2mA80LBl4NTkzKepW9SS9+o2hrU7dLuLPioVj4U3kL5Rg2LjTKtn0YqpQFcTDCACVtRheokHEgHLVU+oMT9L7tuHaZZaFXAMa3NvCh/L6bMjxKRc9F42If96uIPLkvEubiMf2Ng0zsfS6oGoPHSGsQxDEhe3dtE3i+ovtSZh8loZ5PXZ2Kjokf1FeG9FsgRsUOfjPErradSntPRYVfXa/IobTW5wy6AghMedzlDtgLNrXS2oUWm2GFPUXlXnuKOdUPW9fqEM7zEMFfvnz1dFxSjMXxA5saz1/i2lQN01Xo+fFos3weB3FDWseQYHI1yC17WB822v9UUwcqlxmG9gkDneU0ROcS1Iun96Nw1lsRSML2/CrNGUX0qprnE44tREhDIjOojMQGnDNeWrpGjPv3QTjr4aVCH9BrjMPz7YK0O/Lop4fcqsfhd4yqakzxde4b8mO+dbOCoTg37tfgvefLc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(7416014)(82310400026)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/Qx59mWQakXG0rtCuyf3wUsGvHKNtLa2jaqbUgqw9Q0YgOTSKx12DfX2o0QzU3EMNk+KaAPA77me49/o5A3yk99jtBl2x6dxTYmuiIe8+zCH/DYn6thYy2hNXYoUsHXWemJOtCZHCGXaG8KPw6OP3rxmKcTpKChsIOufEIgRfcEPswGdzX0KD4mWd89s8RJgzPr7sGnRP9S432xxiT56bLUO28j17F4dm+QXCMAPbXrQzmV93oWryHubuwQ83gxGk7jJAImrk9njsYacVdNqcZ7ic32b1FC0KkOmy5KxziamueROEY0sPZiOtXCDME3pLjn4l7UAhY4XYpq+RGqaZsKRX/KPFXMXeBNjuAfiDOo5w0kOlCbLdBbWocVbyCn2U1ztY1qb7CppOCeiwplDX+ldHcP9u2LRZPWFTFb/v7TxNmvvustEHQov2M3G0lzZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2026 05:00:31.4873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5239e630-7b58-4d05-243c-08dec3888909
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-21893-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:mid,amd.com:dkim,amd.com:from_mime,amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99ECC64C78E

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


