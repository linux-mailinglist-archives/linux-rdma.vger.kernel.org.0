Return-Path: <linux-rdma+bounces-19785-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGaYOdVN82lnzQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19785-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 14:40:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E18804A2D45
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 14:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 843BD3009F0E
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 12:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190E5407580;
	Thu, 30 Apr 2026 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OiaKLycd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D3E407561;
	Thu, 30 Apr 2026 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777552816; cv=fail; b=gc/nZsbhi1IEfUVZrfKyC0mkAOubdKrBdVPRT/wiMuKyML/zyPuSYZAH4yN6JCfijIB+DJ5jckPp8rCelWK///IiKcVMbVpNNxSfhAl1PtzclO+Ubw/YkxfOLgIEtlMqVTOfmBuTn8P8YggleZN1aYljmQy1UIsQDbh2l0fdGug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777552816; c=relaxed/simple;
	bh=NMq+YOxwFCO0bFM7YU7wsqJdn6xGxmn8xIyozC5t8RE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDRiAVxFDDoFDaZNFghDN7FJ2ojTlYoFYBgI/M2+p/jy+8Zqk6zdhj8Wt2uTOXAyfFARhDuXILzjvH/hyfRGyhcUmETZg5MnM4eBlbz1K5YH4n9qNhBqLvA9o8+Shc1gMzZ2jHK3q3uIetn0Y9VaX5JJu2eZbCkI0nMljOsrTw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OiaKLycd; arc=fail smtp.client-ip=52.101.43.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NELMLC4SqIh4O5PT4NaqJawBJaAQmeklHeZwk9WmUoJ2renITkvit+9jCeUykUWO5NmGPBLrC/MIGqAgeIXelNidrSL+e6YpXOgL72fVUlSZPzshyH5W9bqAP4uF18evGiWfvPctBYeZ2hx+QbcD7jJbAqESGucUN1S1ETQsie2RLNETs1CRh/xItaeswkCIz43Zeefzirs2Q+Aj5/w99JunOGkTO3f9ltwHO3ZMP59dXyXmDkDClIvt0Lo7RIWWlmgjsYNlhIST/FlA1QqlxXYIb/CpBlQK+tlq/8ZusPxjLfEo9WGd1e42MJ43pqA3te9IyOrYGjYR0TycnSJSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TbUUoZjvSR0gATb+Bq3mHH+f2rvmZUePtmEa3yRhS4=;
 b=huY3sLIdSPiLdvklmFtr3ngCQx4rnme/52c0O6K8I1kMsXEo7Tmfx3yxOsnUS61kUTBOkktD9hQnoMHoiOoilpIwuzOcRlm5h5OwLZxOLh3OxaLIciujviuHxOhhP2Z26Qe2xUpjtnOer8r7ruR8eiYJ8/Avsc2OMOaYJuoo07JO0UwLrFb96dEr1pY3sbZpoGRR1yFlAL4GEwBI5vUCDAk4gct7an5z3OYQEBMKvEnAkii1w1kHJpqwIisGjQ+G78pxES4wV+SzAS/H5KYiWypk8NfPDmWOVcFdfzLHUcAlHROnfksZM5Psro1wJTxTNSxxlLpOkNma0eDt3eaY2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TbUUoZjvSR0gATb+Bq3mHH+f2rvmZUePtmEa3yRhS4=;
 b=OiaKLycdhB+YORokN8QIc1ZB2LV4WEpNObhMbVzhppxiVCTDkqzXO3I9wUAif7vDpftIwsddGNpK5NIdK+9goKHDhyIHX2UGgpnvBGemmgwSLBZPvF8Zo/FOpddUnvnBGu6PAfHQRrJ/WrccCCAWAcbWqbrU8G4Cnx8J5MOyBh4=
Received: from PH8PR21CA0015.namprd21.prod.outlook.com (2603:10b6:510:2ce::12)
 by CY8PR12MB7267.namprd12.prod.outlook.com (2603:10b6:930:55::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 12:40:02 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::7b) by PH8PR21CA0015.outlook.office365.com
 (2603:10b6:510:2ce::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.7 via Frontend Transport; Thu,
 30 Apr 2026 12:40:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 12:40:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 30 Apr
 2026 07:40:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Apr
 2026 07:39:59 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 07:39:56 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH 3/3] RDMA/ionic: Support QP transport mode selection in create and modify
Date: Thu, 30 Apr 2026 18:09:31 +0530
Message-ID: <20260430123931.3256130-4-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430123931.3256130-1-abhijit.gangurde@amd.com>
References: <20260430123931.3256130-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|CY8PR12MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1aaaf1-5e1b-45a9-0bae-08dea6b5989d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+uyQ7Ae/5QTSdm3zwf/YcTKcWnHCRt/Z5KWD4QKLZT+HBfIw1yz+5FVJfbougt4eJdgD9knYB57wFqGPvGfRq5tXZuI5T2pppVzTf27xqNEcZtpaKryjYcd224DA4j08UlvcqLRd183ACCq/BzUS4LBwe9vvhV+BxJyNLUatFCdlCxYEWeEF1HZrCuQnVwgLwHUksKhlUzGglAU0+0d8kL63lfLxRrx4LoZxpZalh/vG+iGNTwWMDZNIn+F5kzBNjHZjkzgJXSEH+prEMCOSxWWKdAL/7r0SaXs/8fUl6rQ00gQ2MGN7sVrwHndvylJtDb0y5Edx6LAU4dd88/3hfb1RHnLubcH+6sroi1rMz2VZ8rEkqIOiXTFZapFhyi7J73dLHXOP3UCi4mqMjjIr2gLJh2gcQgczwX2xodG58HUP+lX+FTfXQq8GK/wCZxSTXWi8wRRWLlqWrPqBdGHYJ1ct+Vf+VnJOfd59FYlAJUS/24xph4zC0YfYhkLh6PddJLSTi2Otloe0ZQDQuqBJnH9/7viwlrSoOChFn0+2m2+WEKpfaggr9Y1U8w8Lcy1/RRz3+gjPOp9BqGF6FkB2ppTkZMDAIVzAHa55UNwbLKhxkUIJbxbYbbko9NN8T+/0/R3y6+j9BxqOzJBfGb5yWiJWVIOOt8p0c7XaYBJi60L6a6OY3HmNps7ertfsauF+5UbsmLfyOKqpY6aNSf8H/9YXk5+BDnCWQ0CAqZACJQuhoJbFyBCUImaNF8T8h+58+MR2aIwqOR8VhSavEq2HXw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eSCkrXLAv3zctPD34AHl/mEgqvnF+LZgHrG3cqTqYOQU2r4e7CTvY3qK9fuaXpBhnREGsS06VuiNL/6aqhQb0Z/faq+gMmVv2pdKrrCzN2JirDHSmOcnAySXBKV/iO//kZzGtDvqJ37cJkmH/42Y4zFvHr5ZR3iXirZoRtZ/wdSF3btsahp6RR06QxVPvbB0FSlG0351tm9bI30vSeeIkKh+1XPmtaULDkwVDWEaJu9WbghSJ5hXAVwxYMKsriCJjZoVijOIPxYWaTSBk7ZjuWYcdpDQCTpwQMJv16smfTcI9B+wGomJQKm9GyXuPv154WCA+rT26QtBerSFYW/HPP/J7FkI5glh/Q5PcDpTw8zNQoxZ1GDLpad52ZF87+I6qzHT04nROdZhmcHr6Y/nuL8G3hE078zrPw1e79GxfBxBChoXpfsADU2dYLI6Nzkz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:40:01.2287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1aaaf1-5e1b-45a9-0bae-08dea6b5989d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7267
X-Rspamd-Queue-Id: E18804A2D45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19785-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

Allow userspace to specify the QP transport mode and number of
reorder completion queue paths during QP creation and modification.

Extend ionic_qp_req with transport_mode, num_rcq_paths, and
ionic_flags fields. The transport mode selects the firmware QP type,
ionic_flags are forwarded in the upper bits of priv_flags during
QP creation, and num_rcq_paths is passed to firmware during QP
modify.

Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 .../infiniband/hw/ionic/ionic_controlpath.c    | 16 +++++++++++-----
 drivers/infiniband/hw/ionic/ionic_fw.h         | 18 +++++++++++++++---
 drivers/infiniband/hw/ionic/ionic_ibdev.h      |  1 +
 include/uapi/rdma/ionic-abi.h                  |  5 ++++-
 4 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index 6bb645713d6b..5a6d4036ea98 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -1326,7 +1326,9 @@ static int ionic_create_qp_cmd(struct ionic_ibdev *dev,
 			       struct ionic_qp *qp,
 			       struct ionic_tbl_buf *sq_buf,
 			       struct ionic_tbl_buf *rq_buf,
-			       struct ib_qp_init_attr *attr)
+			       struct ib_qp_init_attr *attr,
+			       u32 ionic_flags,
+			       enum ionic_qp_transport_mode transport_mode)
 {
 	const u16 dbid = ionic_obj_dbid(dev, pd->ibpd.uobject);
 	const u32 flags = to_ionic_qp_flags(0, 0,
@@ -1342,8 +1344,9 @@ static int ionic_create_qp_cmd(struct ionic_ibdev *dev,
 			.len = cpu_to_le16(IONIC_ADMIN_CREATE_QP_IN_V1_LEN),
 			.cmd.create_qp = {
 				.pd_id = cpu_to_le32(pd->pdid),
-				.priv_flags = cpu_to_be32(flags),
-				.type_state = to_ionic_qp_type(attr->qp_type),
+				.priv_flags = cpu_to_be32(flags |
+						(ionic_flags & IONIC_QP_USER_FLAGS_MASK)),
+				.type_state = to_ionic_qp_type(attr->qp_type, transport_mode),
 				.dbid_flags = cpu_to_le16(dbid),
 				.id_ver = cpu_to_le32(qp->qpid),
 			}
@@ -1412,6 +1415,7 @@ static int ionic_modify_qp_cmd(struct ionic_ibdev *dev,
 					  (attr->rnr_retry << 4)),
 				.rnr_timer = attr->min_rnr_timer,
 				.retry_timeout = attr->timeout,
+				.mrc_num_paths = qp->num_rcq_paths,
 				.type_state = state,
 				.id_ver = cpu_to_le32(qp->qpid),
 			}
@@ -2156,7 +2160,7 @@ int ionic_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 	int rc;
 
 	if (udata) {
-		rc = ib_copy_validate_udata_in(udata, req, rsvd);
+		rc = ib_copy_validate_udata_in(udata, req, ionic_flags);
 		if (rc)
 			return rc;
 	} else {
@@ -2203,6 +2207,7 @@ int ionic_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 
 	qp->sig_all = attr->sq_sig_type == IB_SIGNAL_ALL_WR;
 	qp->has_ah = attr->qp_type == IB_QPT_RC;
+	qp->num_rcq_paths = req.num_rcq_paths;
 
 	if (qp->has_ah) {
 		qp->hdr = kzalloc_obj(*qp->hdr);
@@ -2239,7 +2244,8 @@ int ionic_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 	rc = ionic_create_qp_cmd(dev, pd,
 				 to_ionic_vcq_cq(attr->send_cq, qp->udma_idx),
 				 to_ionic_vcq_cq(attr->recv_cq, qp->udma_idx),
-				 qp, &sq_buf, &rq_buf, attr);
+				 qp, &sq_buf, &rq_buf, attr, req.ionic_flags,
+				 req.transport_mode);
 	if (rc)
 		goto err_cmd;
 
diff --git a/drivers/infiniband/hw/ionic/ionic_fw.h b/drivers/infiniband/hw/ionic/ionic_fw.h
index adfbb89d856c..3a31cd9073ca 100644
--- a/drivers/infiniband/hw/ionic/ionic_fw.h
+++ b/drivers/infiniband/hw/ionic/ionic_fw.h
@@ -105,6 +105,8 @@ enum ionic_qp_flags {
 	IONIC_QPF_SQ_CMB		= BIT(13),
 	IONIC_QPF_RQ_CMB		= BIT(14),
 	IONIC_QPF_PRIVILEGED		= BIT(15),
+
+	IONIC_QP_USER_FLAGS_MASK	= GENMASK(31, 16),
 };
 
 static inline int from_ionic_qp_flags(int flags)
@@ -218,6 +220,11 @@ static inline int ionic_to_ib_status(int sts)
 	}
 }
 
+enum ionic_qp_transport_mode {
+	IONIC_QPT_TRANSPORT_ROCE_V2 = BIT(0),
+	IONIC_QPT_TRANSPORT_MRC = BIT(1),
+};
+
 /* admin queue qp type */
 enum ionic_qp_type {
 	IONIC_QPT_RC,
@@ -228,16 +235,21 @@ enum ionic_qp_type {
 	IONIC_QPT_XRC_INI,
 	IONIC_QPT_XRC_TGT,
 	IONIC_QPT_XRC_SRQ,
+	IONIC_QPT_MRC,
 };
 
-static inline int to_ionic_qp_type(enum ib_qp_type type)
+static inline int to_ionic_qp_type(enum ib_qp_type type,
+				   enum ionic_qp_transport_mode tm)
 {
 	switch (type) {
 	case IB_QPT_GSI:
 	case IB_QPT_UD:
 		return IONIC_QPT_UD;
 	case IB_QPT_RC:
-		return IONIC_QPT_RC;
+		if (tm == IONIC_QPT_TRANSPORT_MRC)
+			return IONIC_QPT_MRC;
+		else
+			return IONIC_QPT_RC;
 	case IB_QPT_UC:
 		return IONIC_QPT_UC;
 	case IB_QPT_XRC_INI:
@@ -808,7 +820,7 @@ struct ionic_admin_mod_qp {
 	__le32		ah_id_len;
 	__u8		en_pcp;
 	__u8		ip_dscp;
-	__u8		rsvd2;
+	__u8		mrc_num_paths;
 	__u8		type_state;
 	union {
 		struct {
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
index 63828240d659..24a7f93e1f00 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -253,6 +253,7 @@ struct ionic_qp {
 	u8			has_sq:1;
 	u8			has_rq:1;
 	u8			sig_all:1;
+	u8			num_rcq_paths;
 
 	struct list_head	qp_list_counter;
 
diff --git a/include/uapi/rdma/ionic-abi.h b/include/uapi/rdma/ionic-abi.h
index fb0d13094c12..bd02e4541d85 100644
--- a/include/uapi/rdma/ionic-abi.h
+++ b/include/uapi/rdma/ionic-abi.h
@@ -85,7 +85,10 @@ struct ionic_qp_req {
 	__u8 sq_cmb;
 	__u8 rq_cmb;
 	__u8 udma_mask;
-	__u8 rsvd[3];
+	__u8 num_rcq_paths;
+	__u8 transport_mode;
+	__u8 rsvd;
+	__u32 ionic_flags;
 };
 
 struct ionic_qp_resp {
-- 
2.43.0


