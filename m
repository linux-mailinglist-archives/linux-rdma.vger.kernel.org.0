Return-Path: <linux-rdma+bounces-22314-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kJiTJtOhMmoE3AUAu9opvQ
	(envelope-from <linux-rdma+bounces-22314-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 15:32:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC9169A20B
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 15:32:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=t+ds5PxC;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22314-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22314-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CE67310E081
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D263FB7E3;
	Wed, 17 Jun 2026 13:26:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011055.outbound.protection.outlook.com [52.101.62.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878AC401A02;
	Wed, 17 Jun 2026 13:26:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702791; cv=fail; b=n5uQ9J1RYQr7DfsaWemi7UCpFJ6OSsK0u5eequz5FXa3IYigGrpoGY34tKQ2aJEw8Zjn292dFwX59+2dplyVtiLfnimFsP6KNDWMC79SItz+fZBfRSAr2bSr8E9S8AjVUvjVrWx71M5MqD4nBbKZHmRD3qL5lwUrO3nB1qO4K8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702791; c=relaxed/simple;
	bh=vF+DigRDPF1x4JuX0+2p/dt3tlWZWDnKQ5vLc2+h2fo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2Dj7zyvh7R4e7BGxMT4Bz3S/7ZaZxVFPny2gyNGJdCnpTQp5GOZ51xcpcGUAG+0B8ElKa77sBAYyPRM3rKDoWxBN9UtRxhLvdG5/3Rv/TLezKQ2NVPXnjvbwZwPURFsmPLEgC6sX9QpeqkTteYPl3EMkknS/Zhw+ssEK1ORaSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t+ds5PxC; arc=fail smtp.client-ip=52.101.62.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+YAt02ZKfpPdw6UPwMCmxVbfiHnV5Mv5/bxVsZXzZ6+ebsxllcWOTG/yAlNCcI46osXEqiPPQde7uSJAl23JohfD9RbDuxC9Ifr62m6IHz9hiIJ35kizNtRl8NruMAVP50gL8MRXSyQcArfYXKIW8PExhVz/+v12SAiYwgbbIPntP74lps5WAaUcKDsv7Dw/0WjBqmNpZuPOIck/+rCUHnaUPYaRAsAHtxHn9WispfaTDL/Egc9P2esig6kr+x3RggC/Bw2kPPQ8z9FwmM0ImeZkMKU7mHm1AEp3/yMUVbecXwt/J1HzQROj7NHLgIkhf42ny32vSpzbz9/TG6xUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zm4QkRf3GcKw1RB9HDqLy0hgAVNvlij6LZsZQIaO1QM=;
 b=j8FwUeSxotwaC8ZB55IjnnO1RcnRH/EK6+i/9ooufuR/UTEBFVUmQb4kYBaqLJSX6ziXB8svp01ajPv0ERvaNnm1VtqmhjykkeBbkBd44yMI38X2zfZo9h+3APCBYaLSvAdSFE2sSs+Z29/Vg0xO9Ry5XYWpJTWjiiiUYsxGzdkVmu7EbbyT/V6PB/FmjKaiESayaHIVdKO3YnstzbBXAkSl+ab0jM+gDJY+CyZJEBlpSDrgXfD4c5gp5x0JohG85SZ5KX5hGNk2D3icBdTJnCm1glWIvOw6ERZ9LGUayXng3tcxCHgAqvnKSGKZbrFeVC7PF8cN1QWJu74rjB8Wug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zm4QkRf3GcKw1RB9HDqLy0hgAVNvlij6LZsZQIaO1QM=;
 b=t+ds5PxCD4fpuOLXD5vql0awmdDJxfCUmbublKvUVjqVKBQObgV0lccCaTpEBURC/qhbj86NZFA5UdskUDAh2wVvYAPH41NGp+DVBEHsdymjvrdRBbyCxcG1DTHKY65t+32p53HmXGa5zWZc0vyJuqdSTRUFKuyUB0cmlEoRvas=
Received: from BN1PR14CA0025.namprd14.prod.outlook.com (2603:10b6:408:e3::30)
 by CH1PR12MB9573.namprd12.prod.outlook.com (2603:10b6:610:2ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 13:26:25 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::44) by BN1PR14CA0025.outlook.office365.com
 (2603:10b6:408:e3::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 13:26:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 13:26:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 08:26:24 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 08:26:24 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 08:26:21 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [for-next v3 3/3] RDMA/ionic: Add RCQ userspace support
Date: Wed, 17 Jun 2026 18:56:05 +0530
Message-ID: <20260617132605.1888205-4-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617132605.1888205-1-abhijit.gangurde@amd.com>
References: <20260617132605.1888205-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|CH1PR12MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ebf440c-16a7-4e91-cb48-08decc7407c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|23010399003|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Sd8Cxvy+Hpgo4VfPYX7yZnO4mTHHrbdltpJMBzaJuBS5XPwFP0bJN0GIY3dbbRRWwyEqF8UVsVK3IFxHc1NsF/CihpDA91MRjSQfLTg2gSzP6y4tnFk97IVgib0qHtKj2Tp7UN6ZGb+0nsWzTLYkBRtpb0lInSXXAWGfLYycdMbvj+wxnDKlg0ua2cZgD5//XUfQDVmDJJ6ZxxMFVrTN3YYj9aemXGKXWXCqZ83rk6BdUl8TxHwPtCCl44/wwlCK4/7Z9gGVXzeT1K+UbyC/HEtWFDiwT9n3zSCLEYZQ5L88JbVDuWwzSLqHvTiMjrK2pd1tNxyasfrWbQdenl58WdXoro/cF10IKtr02UCvLOZrxefvjmE+Dj/ZL2tb84zlyEShY9Ss+zynpjkaHNb9/PULAusTfL+QC201nN1NY+vzRZg25+j6Z+94cOwOQkR9FH7jEG1J3ilrkqKNHRYLxSm+YlCEjGfmlnZus0TqXZrS1YhH26U5xCKTXktBYJPKAsGMd/wtCWxWA+ux4RZKFbBMQjS/xQnOIoewmbLOjW1vFZA7SkeMQ4XZohvZ/Y9Xna0Eh+SyNjxRzsRchIeXGINXXGxKfNQ8lR1mRmpUc2l8BBacWg0cF/OlVN24dWO+n3S4FzBm8OByeiC7zz/hwnJUa5lY12xYzY1D3K4tLA/4mxrqS1r5+hNRNS1D4d0GuiyY4Eoq7NDVkhOQHTRlz7CGn0N2xdnbzy/62Spwaic=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UpRROf00aMMCvN5tS2gi2WOUJW/1nLrp7I9Ztk3x+mdCPoJ3Wd8kK1uDYSPhQlfJE/eitllXSGTNhSlHSmpg29p5jJOcHTIig0MX32xjyXN3gPdQjwTleZ3CwTL+P3rANq7etf4hUuQsaOLm0mv/Y76RE+ga4zdybCS12vXLwK4VveaVtgzwqi8E/eTtqLsZoAayJnpGNBk+vcWczciw50euvF6iKF1vn3OyLsiEDVDOy67FYmGqDdlrwe0rJjJ6ZXDynTfntAkkuzVU98kEWft9qs8JI3YjGK0zU3rGp7c3MKbfNGwzbJ3/bUrXFkdrswOOylWlKpMsWqEK5q+JByLB3GUdgJJ/5ejYByzkXgIfHlXLogHr3TWusqTSIzVYVOFrplkO4/OyLXDeOHEbZsncBirZSGv/nQosjiTZyyEOkQLG2YhHSFV3+vTk9hno
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 13:26:25.1684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebf440c-16a7-4e91-cb48-08decc7407c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9573
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22314-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[amd.com:server fail,tor.lore.kernel.org:server fail,vger.kernel.org:server fail];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:allen.hubbe@amd.com,m:nikhil.agarwal@amd.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:abhijit.gangurde@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECC9169A20B

Expose the Reorder Completion Queue (RCQ) capability to userspace via
ucontext response and allow userspace to specify ionic specific QP
flags during QP creation.

Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/infiniband/hw/ionic/ionic_controlpath.c | 9 ++++++---
 drivers/infiniband/hw/ionic/ionic_fw.h          | 2 ++
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c     | 1 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h     | 1 +
 include/uapi/rdma/ionic-abi.h                   | 4 +++-
 5 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index 79570da3e6a6..27058473d845 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -408,6 +408,7 @@ int ionic_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 
 	resp.udma_count = dev->lif_cfg.udma_count;
 	resp.expdb_mask = dev->lif_cfg.expdb_mask;
+	resp.rcq_sign_bit = dev->lif_cfg.rcq_sign_bit;
 
 	if (dev->lif_cfg.sq_expdb)
 		resp.expdb_qtypes |= IONIC_EXPDB_SQ;
@@ -1369,7 +1370,8 @@ static int ionic_create_qp_cmd(struct ionic_ibdev *dev,
 			       struct ionic_qp *qp,
 			       struct ionic_tbl_buf *sq_buf,
 			       struct ionic_tbl_buf *rq_buf,
-			       struct ib_qp_init_attr *attr)
+			       struct ib_qp_init_attr *attr,
+			       u32 ionic_flags)
 {
 	const u16 dbid = ionic_obj_dbid(dev, pd->ibpd.uobject);
 	const u32 flags = to_ionic_qp_flags(0, 0,
@@ -1385,7 +1387,8 @@ static int ionic_create_qp_cmd(struct ionic_ibdev *dev,
 			.len = cpu_to_le16(IONIC_ADMIN_CREATE_QP_IN_V1_LEN),
 			.cmd.create_qp = {
 				.pd_id = cpu_to_le32(pd->pdid),
-				.priv_flags = cpu_to_be32(flags),
+				.priv_flags = cpu_to_be32(flags |
+						(ionic_flags & IONIC_QP_USER_FLAGS_MASK)),
 				.type_state = to_ionic_qp_type(attr->qp_type),
 				.dbid_flags = cpu_to_le16(dbid),
 				.id_ver = cpu_to_le32(qp->qpid),
@@ -2282,7 +2285,7 @@ int ionic_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
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


