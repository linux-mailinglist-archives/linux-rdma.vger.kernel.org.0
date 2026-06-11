Return-Path: <linux-rdma+bounces-22100-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eDJhBIx/Kmr1rAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22100-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 11:27:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B49670660
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 11:27:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=0pFA08cK;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22100-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22100-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B63063056152
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 09:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3721B3A6B92;
	Thu, 11 Jun 2026 09:26:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB51399351;
	Thu, 11 Jun 2026 09:26:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781169981; cv=fail; b=jnn3cjIe++xuwLoIK8ryqTM4Ps8JEIApSipL2GzvzOLlHnT89e4P3twLNk6DlaDrYEe7UT/Dzf3zF1t+gY7Ox7lxzsO0hFFJ50PH8TRLAaQJ+4M6VWFiWCIijfJXFqk4NiMoWQdW4xO24rqDDAdZOIePGleiMcnUQHW6r/eklw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781169981; c=relaxed/simple;
	bh=FzaHNdA3Ez6EMs53SlZnZ2AAsz5baSrrzX9mqGdKA5A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0Vnh/qhvH/eY0obPWrTy1Okf4DfGJ5PRYCnI4eEA1TmgIvrfEyPlAV4WgX5WHK95CJSQEoohH9/n8866KQz2aFsThvw9YS8U+NRjTepqBeMyFkQnJq42mr1AjdL1eAJ7crvYJ9SEtA7REp+dUJFRj9egUOUNovT0O8mKS2WiEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0pFA08cK; arc=fail smtp.client-ip=52.101.53.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dErhvsVvekeFNT8cmJ5C3AR+8p8bw51BYfK7ylDahr24wWEsCxM5xAqaulq2PneZvP8a1sGhJFmpJvkZ9lmpFwsLab2ZMrAYVsOOimJT50cZpyom8IfODX/Mm6JVbj9mD2AMu1wiethXkGA0EYbFqNMaYBrI9KdgRe8u/to5jU3fIwFUFxRPpwnCzKEcHMtS0UHTP05+uBUdqO9Q6OYGYbh84gw8ebu9Mdjjmv3+rhfT07Qm8M57gAQBk2BUL3EqFYeOLdbzd3P4ad2e06zgp4SCkfCTzo678cuUD/0m1Se4OdeGWWbnN0AJNh7gTmLM8+Zx5mjy8TFl5bVP9OSFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5d/LykCjGdSbXUR6jHBAKp+MzPvemaUDDHxnzI6K5o=;
 b=YJmFWkxwYIB4Z/20aoaZrm/YZ5agi4RPfNrNRUjIPRVbkV/0BHVCPwujF6qAASHsMh/I7YJmjxqnImucJzYsY2QSwujhckxOeHNi7YNuaiKbQRzZOW08TrSO8Ovf6mGxWw6rvCrjW4ArYWZUmHNNv+ZPo1E47SQDOGSNgU6CpqK4hOTcb7gN9dWlhAIg5Vkxp7FJps3QWvDM2X7rCRjHAan6xDjmptOZYpqjfpCjzToVVgbcrtumKOvrmkvV28omD6wEWAhiuOBcStCzxMXKQTUlX1f0DThHLGOfDgFywVHPCLVbAl0TQaLRuAxmpoydugivEZX1dg8qxBhG2/GtgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5d/LykCjGdSbXUR6jHBAKp+MzPvemaUDDHxnzI6K5o=;
 b=0pFA08cKJCVaPi17MiBE6n4TAW5DGXrjz9Yvd2zB2jIyTwHLJi6AV2bCTuu6qGTqFv/eRzpTfwyHcmX5Lib/JW1JodqQq02TSksfT1H3mF5YGYSofiT9pKgjQd9MoWO3NTBdT84rsEyEla8/GgdYvKsDOrpZkqzA9BKNJ7hKfjM=
Received: from CH0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:610:b0::33)
 by LV8PR12MB9618.namprd12.prod.outlook.com (2603:10b6:408:2a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 09:26:14 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::2a) by CH0PR03CA0028.outlook.office365.com
 (2603:10b6:610:b0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 09:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 09:26:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 04:26:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 04:26:00 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 11 Jun 2026 04:25:56 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [for-next v2 2/2] RDMA/ionic: Add RCQ userspace support
Date: Thu, 11 Jun 2026 14:55:43 +0530
Message-ID: <20260611092544.783731-3-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611092544.783731-1-abhijit.gangurde@amd.com>
References: <20260611092544.783731-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|LV8PR12MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: b9a46d07-1774-4dcf-50ef-08dec79b7b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|23010399003|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	6CHv/zbg+Ju9E1va0Uw9xirrHWTSZQLjq9t2Ti2LCfbOd99meDKwI19td7Ry97Rh+ymnwo3vY9vq7WVaNUgFUoyzDkLZVdrAqZpJ8izTnvPuzZL+3WBLnaUG/stO7o7Mm2cBMZajcNMs1v9btzEwSHr1RICbzbJgATdhlGbGJyzcUYAKSMrOX52jaf91hVCADFG/IogK6vPR4OjIRdxJ5+Le5jqMVmtKyHSYn4yfnalQi1HEDe3+bvsc3nOcH7fW3Kf2UPrtZY4v29QE6JW70d2tMLucut9QIcPSXb1xSUTBAHm/C6zs20oO9MPQsE9RWW4h6pJU5HKgJZaSY1pu8fH+sDYfZNxp/LbEhmSEbK5hUbIBbQXc9UryCW0VRzen5Hareyc06UtkDVrch0JbSHeM1ezHtmkaRV4gLsykfFCwX6TelH+S6Ld7FCUiaN7YTKoRx1wbE0bn28MvzOlhValHGfNH0rrZim2BZSqNKquj25vP70UlU9Ypegr1tXAzl3ixagXFWrKr8H6oSD4qfjhXrws5MICOKsmpYow1pr03VsZAhE91HEksLYidcs5EaHYn8xdh7IemXmIEWqlgyXqqCHsDXdIoOiuteiXOkYoAM5xEwhLTuZi2qaN+LsSq39brmN1CI1GIIXu3nU9c1/TbFENZWfPjkrr0QsCfRA6QZSG42ZSesv5O+Q7auVzo/azljsPno3EIBnC/CRt0gHJbPPxM1Z9wq42NryA/j3c=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lw679owSi4biOp7Oc7wmgkkpEsVBl/N/wB4v/QlDXnNBQI+jUxfFUvQ7VDtYj/1p01i68xjGfKyqvDOgHRXUb3vQaDlzB/ycdUgx5NZ6KLv0umB9YFs8il7APexTURZrl2qPwLvn7ToSk0QY7ytX1O6yrdU+2fwLyGV43DP8H5n5emng8n4EiAMLgPVW30bPs51y9cRXc70YcEVVeW25Ig3fmGEtrZy1VOSU3JKWomGfu23Q1Qryi8bW1lkWJZ4ZndGsnlnhbUsG27wG4N5INn4XkMPsz6pIm0uQloPk23b0kuAcEyCEhV5s078hg+RaD2cPQ8Y8QFZy5g1OlG9eTKVbZz3JMJ465JzwRRX5vnlElYS+z4wEyor6WJL/zM3J1mJ16oYYDg8wvdufH9u+WCZ6p48iZIH8HUq+37xrDnAUh/uVKKF/OtIVh23Ul+dQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 09:26:13.9249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a46d07-1774-4dcf-50ef-08dec79b7b88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9618
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-22100-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73B49670660

Expose the Reorder Completion Queue (RCQ) capability to userspace via
ucontext response and allow userspace to specify ionic specific QP
flags during QP creation.

Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/infiniband/hw/ionic/ionic_controlpath.c | 11 +++++++----
 drivers/infiniband/hw/ionic/ionic_fw.h          |  2 ++
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c     |  1 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h     |  1 +
 include/uapi/rdma/ionic-abi.h                   |  4 +++-
 5 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index db18c315cc21..83e80ab6a254 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -408,6 +408,7 @@ int ionic_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 
 	resp.udma_count = dev->lif_cfg.udma_count;
 	resp.expdb_mask = dev->lif_cfg.expdb_mask;
+	resp.rcq_sign_bit = dev->lif_cfg.rcq_sign_bit;
 
 	if (dev->lif_cfg.sq_expdb)
 		resp.expdb_qtypes |= IONIC_EXPDB_SQ;
@@ -1324,7 +1325,8 @@ static int ionic_create_qp_cmd(struct ionic_ibdev *dev,
 			       struct ionic_qp *qp,
 			       struct ionic_tbl_buf *sq_buf,
 			       struct ionic_tbl_buf *rq_buf,
-			       struct ib_qp_init_attr *attr)
+			       struct ib_qp_init_attr *attr,
+			       u32 ionic_flags)
 {
 	const u16 dbid = ionic_obj_dbid(dev, pd->ibpd.uobject);
 	const u32 flags = to_ionic_qp_flags(0, 0,
@@ -1340,7 +1342,8 @@ static int ionic_create_qp_cmd(struct ionic_ibdev *dev,
 			.len = cpu_to_le16(IONIC_ADMIN_CREATE_QP_IN_V1_LEN),
 			.cmd.create_qp = {
 				.pd_id = cpu_to_le32(pd->pdid),
-				.priv_flags = cpu_to_be32(flags),
+				.priv_flags = cpu_to_be32(flags |
+						(ionic_flags & IONIC_QP_USER_FLAGS_MASK)),
 				.type_state = to_ionic_qp_type(attr->qp_type),
 				.dbid_flags = cpu_to_le16(dbid),
 				.id_ver = cpu_to_le32(qp->qpid),
@@ -2154,7 +2157,7 @@ int ionic_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 	int rc;
 
 	if (udata) {
-		rc = ib_copy_validate_udata_in(udata, req, rsvd);
+		rc = ib_copy_validate_udata_in(udata, req, ionic_flags);
 		if (rc)
 			return rc;
 	} else {
@@ -2237,7 +2240,7 @@ int ionic_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 	rc = ionic_create_qp_cmd(dev, pd,
 				 to_ionic_vcq_cq(attr->send_cq, qp->udma_idx),
 				 to_ionic_vcq_cq(attr->recv_cq, qp->udma_idx),
-				 qp, &sq_buf, &rq_buf, attr);
+				 qp, &sq_buf, &rq_buf, attr, req.ionic_flags);
 	if (rc)
 		goto err_cmd;
 
diff --git a/drivers/infiniband/hw/ionic/ionic_fw.h b/drivers/infiniband/hw/ionic/ionic_fw.h
index adfbb89d856c..4c6752bfb1de 100644
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
diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
index f3cd281c3a2f..a9044f47c913 100644
--- a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
@@ -84,6 +84,7 @@ void ionic_fill_lif_cfg(struct ionic_lif *lif, struct ionic_lif_cfg *cfg)
 	cfg->udma_count = 2;
 
 	cfg->max_stride = ident->rdma.max_stride;
+	cfg->rcq_sign_bit = ident->rdma.rcq_sign_bit;
 	cfg->expdb_mask = ionic_get_expdb(lif);
 
 	cfg->sq_expdb =
diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.h b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
index 20853429f623..e6b17055147f 100644
--- a/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
@@ -56,6 +56,7 @@ struct ionic_lif_cfg {
 	bool sq_expdb;
 	bool rq_expdb;
 	u8 expdb_mask;
+	u8 rcq_sign_bit;
 };
 
 void ionic_fill_lif_cfg(struct ionic_lif *lif, struct ionic_lif_cfg *cfg);
diff --git a/include/uapi/rdma/ionic-abi.h b/include/uapi/rdma/ionic-abi.h
index 7b589d3e9728..729cea3ccd56 100644
--- a/include/uapi/rdma/ionic-abi.h
+++ b/include/uapi/rdma/ionic-abi.h
@@ -46,8 +46,9 @@ struct ionic_ctx_resp {
 	__u8 udma_count;
 	__u8 expdb_mask;
 	__u8 expdb_qtypes;
+	__u8 rcq_sign_bit;
 
-	__u8 rsvd2[3];
+	__u8 rsvd2[2];
 };
 
 struct ionic_qdesc {
@@ -84,6 +85,7 @@ struct ionic_qp_req {
 	__u8 rq_cmb;
 	__u8 udma_mask;
 	__u8 rsvd[3];
+	__u32 ionic_flags;
 };
 
 struct ionic_qp_resp {
-- 
2.43.0


