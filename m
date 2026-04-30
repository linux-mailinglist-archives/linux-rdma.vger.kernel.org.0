Return-Path: <linux-rdma+bounces-19784-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHCRB71N82lnzQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19784-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 14:40:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAAD4A2D2F
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 14:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA0943007AC5
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 12:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3995340757B;
	Thu, 30 Apr 2026 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E70OyMNc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013068.outbound.protection.outlook.com [40.93.201.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A8740628A;
	Thu, 30 Apr 2026 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777552805; cv=fail; b=Kklg2KKfOZzqeycqkDXGIzPLeHlaQSOEO3Yr8jLskFwTvnIaD0aUTPUqlcLRFd0Zo7Yccays82Pb+ZHkvbrUF8+/G+EvjayrKKSh41VSqVku3QwWTQgZv9xK6hsVkB25excwbPQqNM9SYQa0BfZct6LVnS43ku+jfWVDSX5UqJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777552805; c=relaxed/simple;
	bh=mAD9bxnFNWzGIc5LxjDZYLBRYlXXQp2yLA/7oRDma54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdvMMyvmeP27kd0ctKRm1/btyrM8V5fRQ/iJ7hd1MZuuVfVn1Jyo4UehmKaCrgVVfEHh2mns5/5MX57QMruUAaTywfbmMdQEFE6mpUMykJMJsqZO70yjQ664QqQA8ka1ZAZAdqSzBmWF0GViHQdMnFd4YelpTepQUekW2OebBqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E70OyMNc; arc=fail smtp.client-ip=40.93.201.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYoNoWwij8a3yZyPgpmWqm8R7fO0BQ7Orp1O4JEsYDOCWlYLw2o2C4rlaEPx26SYniVD/bXNbP5P2INsZnY1nUe9pKhmrSnO2SgRoKl49qQSjAXNdTg8TQbNvkUDMOwSuLURzI1Nd5Mc5DWE3ie1YW0UfZbh55mFvAnVTPxvzGNZwhFtPp27esgamvy6OCXsxOp5NPwWVmPE+a1SasX3u5c6jOrkeQUDxnevFwX0tvwZR0rNxqmSaNVNT2fzsQbQXEGVCXfmDG4BRjiIHHfVbK0LFTlfnAL1zscRrywPFq2zHLPMYzeYxguhcxCTaSmdA5lyTHzBfx9BsJQSnCPmag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIyErQ/hIk0HsI2dAyzQJBHQpE2Wd8DLMHvlHmEgd/g=;
 b=phKSDPfIJFWQ+q9om4dl2u6JMigN1BZRHfUAp2Ee+sD/HRpN3keeura2mzwiHth9nii3Oa3WcRX5KmKPFTwl4elAJKIi495/pd9CTk5M+pEuOvKEuYQMqDiyrNhP7HGSfocm8FoqtobQ/z8ONQD4vBpL+9RkWrRCdKQ5zNXhvj+PWtpchI8NaDswkC8SsTmq1F8qZMLnQUfvY1dnv7491lhFwCdde0tC9jQ2nqYJec9GNSFVo2OZfHkoP88YFbWNbXbq8elTuPqFQxo5DPnwRz7mSeYUsCcTCKm7XnGTwuqS4H8Ivrl0LqgGTwTWJmbd2CLd/fVaFhH5tdhpwL3u4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIyErQ/hIk0HsI2dAyzQJBHQpE2Wd8DLMHvlHmEgd/g=;
 b=E70OyMNcnyezBsNXqeQ3HC/1UPt1OrtgpY1M1W1mZjTW5ehRPzya5EG0F7u9naGxh5rJOX+YioNuy9/MSI5pWgdLC2hZRILcLrWGNRjq8Qr66j/18MYvDTxfv6H0wcCYNSn8v/OhI4Z/SjBg8xBiSSvBQscqZFg/WiOdX+HN4dA=
Received: from SJ0PR13CA0132.namprd13.prod.outlook.com (2603:10b6:a03:2c6::17)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 12:39:57 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::5d) by SJ0PR13CA0132.outlook.office365.com
 (2603:10b6:a03:2c6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.5 via Frontend Transport; Thu,
 30 Apr 2026 12:39:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 30 Apr 2026 12:39:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 07:39:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 07:39:56 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 07:39:52 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH 2/3] RDMA/ionic: Expose QP transport mode and RCQ sign bit to userspace
Date: Thu, 30 Apr 2026 18:09:30 +0530
Message-ID: <20260430123931.3256130-3-abhijit.gangurde@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|CH2PR12MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: f58be35b-89da-4b10-0bbe-08dea6b5962e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	clZJWCgpAXA/kTtMohzqF8W4FhynYz28X/h1b01vUKZKffeqEJx6hrq8qeO7M5RUkXSv1sFb8VjwSMlbCWW9pub/VUD4aZLYN5nZ2VvSi5sb+m4pAuT8rLt/1Rygh+kf0rl2GSamZxRTq34jxmUZianUyMs2kopOJ4G//V4ct9OepdDTawjmX+jUQ8rC95aRBHjU21HM2tj6jRKO5MsINqrhEkVBL7AckQh7mPRpa2smKco76ms+0xSnzFk9ZK7yn+ZdEBrNqYqbSGIZMxASQFU7JA1xtb9jSD+7o0I/iKjzKui8zsjFbh10YURIZN88uiYwQO3nTwyBnysa9fOPIq59IP9qKECnDqKSD2ees+w4HX7wWHtmwRXyVV5KIWEGWRWcGAIeCRB/tloxJApJp/ShIZNbqFsrRfG/4KSEWco8NEEtcKRL/dao8cYeQyewE1avFIvMB3rvQa7yCz3wwbPCVckOmWowy+QdMpCdTemVO595d+ZkYwQ6JyimA55i6LKWUxuTVqoCBanEUcmBA0bfWtp03Hp3VrVWEo/q+kghCpH1GjDWs8KFXa+tbVzkiX1fAttVoPdGaK7/k5gGX2IRUuq28Gx1B3RIlWcSTdxwGiW+tQ5Hq1vOQVzlFZMMQ6tsiRBfuZIbogaIVta7SUDsFHFfvKotE84Dikpr8ZZxJg2lKjoeSAhRuyWVjlM/djiQ3AlDhgzUbdq/0D6Q2285wXEXo6FTpcQ6UvHX3tKLKD50v9ac4ZQ6vgHZoKMGPn/vSMK4X1A0UZXgayhxuQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tk93KT9UEZn2rtn+ryBMLZxgGSOYkwh3rXD6RFYcRPNq/J1nhZ1liGtcozWJy9i6YVdvz2tkpE0+CsrGTUelJejpJPu11Ivx9kf40Ds8dmQa+EU/zRMnqwvRB2TcmgdGdsxeBkVwtG2dMkJKG/GYmHw6JJ6tmkzzpBiqNMhzWjJMqZswkgGjbSocPk4+s9cBIlFdbLF60mmF+d6/+m3WIUxZfrQArw2yD7QziyNiFqCUesBydTzJ+3bKExIvqunJjff1Gz4RNhlSPusjwEUSzFObDT1MKU4SytRg6kZ/R+rvAwSgvMxiRkOWf3QADttjwjYzD3tTo6HkDMEXpYurhPho+FERN8TDSuOKH/7+cZO7NnJ/r620oF9nJ3vUHGhmCL9PT4RFc5K/se+v/NPE91m+6M6R6zNWvaM0GYi/+50VPRrbt1aPK0OzhF0o1Xwl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:39:57.0658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f58be35b-89da-4b10-0bbe-08dea6b5962e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
X-Rspamd-Queue-Id: 3EAAD4A2D2F
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-19784-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

Read the default_qp_transport_mode and rcq_sign_bit fields from the
RDMA LIF identity reported by firmware, store them in the driver's
lif_cfg, and expose them to userspace via the ucontext response.

The default_qp_transport_mode indicates which QP transport type the device
uses. The rcq_sign_bit indicates the Reorder Completion Queue
(RCQ) sign bit capability.

Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/infiniband/hw/ionic/ionic_controlpath.c | 4 +++-
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c     | 2 ++
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h     | 2 ++
 include/uapi/rdma/ionic-abi.h                   | 4 +++-
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index 7051a81cca94..6bb645713d6b 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -408,13 +408,15 @@ int ionic_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 
 	resp.udma_count = dev->lif_cfg.udma_count;
 	resp.expdb_mask = dev->lif_cfg.expdb_mask;
+	resp.rcq_sign_bit = dev->lif_cfg.rcq_sign_bit;
+	resp.default_qp_transport_mode = dev->lif_cfg.default_qp_transport_mode;
 
 	if (dev->lif_cfg.sq_expdb)
 		resp.expdb_qtypes |= IONIC_EXPDB_SQ;
 	if (dev->lif_cfg.rq_expdb)
 		resp.expdb_qtypes |= IONIC_EXPDB_RQ;
 
-	rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+	rc = ib_respond_udata(udata, resp);
 	if (rc)
 		goto err_resp;
 
diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
index f3cd281c3a2f..2a27dd22e4c4 100644
--- a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
@@ -84,6 +84,8 @@ void ionic_fill_lif_cfg(struct ionic_lif *lif, struct ionic_lif_cfg *cfg)
 	cfg->udma_count = 2;
 
 	cfg->max_stride = ident->rdma.max_stride;
+	cfg->rcq_sign_bit = ident->rdma.rcq_sign_bit;
+	cfg->default_qp_transport_mode = ident->rdma.default_qp_transport_mode;
 	cfg->expdb_mask = ionic_get_expdb(lif);
 
 	cfg->sq_expdb =
diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.h b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
index 20853429f623..abf169d2727a 100644
--- a/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
@@ -56,6 +56,8 @@ struct ionic_lif_cfg {
 	bool sq_expdb;
 	bool rq_expdb;
 	u8 expdb_mask;
+	u8 rcq_sign_bit;
+	u8 default_qp_transport_mode;
 };
 
 void ionic_fill_lif_cfg(struct ionic_lif *lif, struct ionic_lif_cfg *cfg);
diff --git a/include/uapi/rdma/ionic-abi.h b/include/uapi/rdma/ionic-abi.h
index 7b589d3e9728..fb0d13094c12 100644
--- a/include/uapi/rdma/ionic-abi.h
+++ b/include/uapi/rdma/ionic-abi.h
@@ -46,8 +46,10 @@ struct ionic_ctx_resp {
 	__u8 udma_count;
 	__u8 expdb_mask;
 	__u8 expdb_qtypes;
+	__u8 rcq_sign_bit;
+	__u8 default_qp_transport_mode;
 
-	__u8 rsvd2[3];
+	__u8 rsvd2;
 };
 
 struct ionic_qdesc {
-- 
2.43.0


