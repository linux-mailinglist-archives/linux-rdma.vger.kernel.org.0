Return-Path: <linux-rdma+bounces-22315-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JWmmKeOhMmoH3AUAu9opvQ
	(envelope-from <linux-rdma+bounces-22315-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 15:32:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F11E269A213
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 15:32:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=bKuT9kNt;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22315-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22315-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3219311FA60
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 13:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E1F407CED;
	Wed, 17 Jun 2026 13:26:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013027.outbound.protection.outlook.com [40.93.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFA03B95E3;
	Wed, 17 Jun 2026 13:26:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702803; cv=fail; b=m0iUE73dejyGDYR1Sd6bHao+4zpskSep20usSyvbgGz0wJgfIFnhMMSqAEbrnUCR3yp36X19rS7+3ERxIP0k9qJz3Eq7odIaUs2kqwwDjGXIyk7SpU1lzpvssWgMBlzdynChSln33ZTfeUiJq2Ilhyz8AAzBHebwR31oo2eUmaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702803; c=relaxed/simple;
	bh=RFN1wJ7jEuhoj7Wt2BrYvUDSE9vScydEo9K+Jj4B8EE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5D+lKRU5k455BOOLsAbAbUheT9x0g+B3nDA5Hc+J6S3A9NGJyqpllI66fJOXgx/9yKz/enpFa1hmSETlsWghVAFO43dX62y9hfSPfLsgntp6bxigJ9TZtyfRpKf5W7dQJr7xuChlZlg9WCzZ5au8+it8GmaaHjbXMYle6h8HGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bKuT9kNt; arc=fail smtp.client-ip=40.93.201.27
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGEGO+O+2YPBAkBOYL25DupaIumYTCusb47UTxVDpRLF2xaQSPULV67noiooJE4tluBm1yjT1Os46MmSNwQgjDqehxot8v59jB5Ue5NumO3luXkevQM3rT9mFf28FNW8ayMwQnDc8tIpTlD5fw2vXav2ZZUbn6FgaeNp77Zw/nhzLPgc8GFGUTl1akVzwXZPJrO/puR6pBFAoyRBzSa+nHaarYGt4A71zKctSI/Mkn5N7+n/mKvDWW4JcIepmzMgneou9zqjSrbHHDTBsiiCKvNf4Uke12kuowZWHCldTab8jRcAlyFHnrCvumc5Xb3YkKOauQ4po0NxvdnzD5t/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmh5ZipUA3hIE+jKedAOaPG0ecwDGRUFw4Hrfdn7T+o=;
 b=GpBDO9SOq7JnXTrjJMyEiHcQkVQe/pl6nMHfRTEjeRRFvHi8CswA7S0RW+0ujyNXahNMRjuMEfmCoFbUrqHZsIqjS0lPGYcSif6ouOnBK4GS6qxfUw36GsI6YDUtkzZhxjRQ9iaFTHrGlZcvdFoHZ+pCSkrzZ6fngbC8FkkzHjzaHSCwYulKyiANhkQHaPjpxKHaKFNHqoRdQuI1lDR/GeNA22BrKUj9atGlQMjh1cN2+hw8DrTz3SvmSQTokRnOxR+XG7Xw5ywYAIXX02OMbkotQl/zs7+e/3v+CLWxNahMiyXYzdAS/Wz/FVOnsMED/unGqklsI9PTU3cA2sxD1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmh5ZipUA3hIE+jKedAOaPG0ecwDGRUFw4Hrfdn7T+o=;
 b=bKuT9kNtcsIJx6xF3XlVeIwGmYKL+PNsaag6Z1d8gqTKKGOS4d4i2+3GLBkQpBsqmi9xuh/E/GjXCEAlFfuwtA1f6XkCezeyFc/k14sXcweO9R21GZSc1NXxd2WlefUEikjGbmuggcBB24iK4snz0a0x5oNu+atsMAemljtinA4=
Received: from SN6PR2101CA0019.namprd21.prod.outlook.com
 (2603:10b6:805:106::29) by MN6PR12MB8542.namprd12.prod.outlook.com
 (2603:10b6:208:477::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 13:26:32 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::16) by SN6PR2101CA0019.outlook.office365.com
 (2603:10b6:805:106::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.2 via Frontend Transport; Wed, 17
 Jun 2026 13:26:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 13:26:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 08:26:20 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 08:26:17 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [for-next v3 2/3] RDMA/ionic: Add robust udata compatibility checks to all uapi verbs
Date: Wed, 17 Jun 2026 18:56:04 +0530
Message-ID: <20260617132605.1888205-3-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3ed2a6-4a1b-433f-5c3e-08decc740b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700016|82310400026|23010399003|22082099003|18002099003|3023799007|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	LQGwWM0v7uV2Aj7tOXrgOelD6u72q2G4c4aoSfTR9wUQewAkDIDFDBxrdRrNn5AI3/khLQUX/dnDVkvxSiTlw0oDmbabGji6WYx85URtEHz0trC0i8SYDpqOkzZT4vnrjy6kAmzcTlnFSa5X+lxyb+T/Z2r4yncwoh1+dMTnzwyRaqql3cIP0W1XdZKpHHVTA3VJH0pIJu2dRtz2I5gqUMbRZ7gvRuea+oci1uQExy/5WlYZB7Gs3rx9TZp6sGqOmZG0jm3ZVqqZasf74xoBtzLOLDxHtsDWvxhSO1o2iagD3oGIz7D+tSwV4HXV6Ens8pp2ZXHrUbKleG/Q/Gz1vnKfunR1DfTFSNhOrNf4wkbIZFQuYnx9Q5OlX52/Wb8qGm51HRwIiaVT7pLCA3vxSQ/Ro1hV6a51zd/pHe6+U7unmI9m5eFEHkWUhh6bsYcVBX784xpX7hydOyYL6m2KeU4lYBATlVUEFlCO8WW1Z3uXclAXU50oAmxpk8NYbSqRS+Vz575VvfYfIxmi/rUchE0bGCG4KPkLTXrywzBhW4EBTvHZ+XRIucwl+wxJcXB/KLK5qNolzfStRxYZJcAygWP4IXOznpnZefVkBUf2bNUULPtC657Vb2NzATfBbZNcDcnCEHxjPIi8R4UELMbrHRaSyGPIhHwPWOIwBsXXj+3iPfAdamn3o4hu8Ec091eOrrgO5fURPHMvHuhYibOzh1haZZVM83vxnnJTZyn1KDU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700016)(82310400026)(23010399003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YGcHReQ3DmNbrXyyw6/RBsb4bdoZZmq7z9ZePJf3z15tcrSbFnmUNrH34rQlKQ3MuS9qgyVd0uPIVViw3zE25IrhtsJS7mVLtAcWP9wtk7IyabEZ8bGkPyahABrxLdudsAjQlKompBaJ6FM5NFk2d7J0+UAgZuKnGGfwoggjUmWead0ME5B2P9M4IZH5/ElANqu2QHWM6Awto9OcHibTrXGReJwqlmrb3ZRAzBr8hVmaBQtEUfyMNii2/Ok9UYCN4WRryk4p04THJhHuUJphG91sl4fYup/67ta2sjaZ4ZcwlZnfIMMz6xrRfGrnEGcnsCOgSOmQG/LZVN29C7P0ik56FXfa/OuKR8d3Ccakiph+2N3VWfGCqQi1LkXRTZD+yHT+tKUFm1/qH6O3Ygrvev+NWvHvV4Fjh+AHLKrM7ztpgnFKFtEtZv6Ja1uwREqW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 13:26:31.2321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3ed2a6-4a1b-433f-5c3e-08decc740b65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542
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
	TAGGED_FROM(0.00)[bounces-22315-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[vger.kernel.org:server fail,amd.com:server fail,tor.lore.kernel.org:server fail];
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
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F11E269A213

Enable the robust udata contract by setting uverbs_robust_udata and
adding proper input validation and output handling to all verbs that
accept struct ib_udata.

For verbs with no driver request struct, add ib_is_udata_in_empty()
to reject unknown non-zero input with -EOPNOTSUPP. For verbs with no
driver response struct, add ib_respond_empty_udata() to zero-fill the
userspace output buffer. For create_ah, which already responds with
ionic_ah_resp, add the missing input validation.

This ensures the kernel correctly advertises
IB_UVERBS_CORE_SUPPORT_ROBUST_UDATA and upholds the forward/backward
compatibility rules for all verbs: create_ah, alloc_pd, dealloc_pd,
reg_user_mr, dereg_mr, alloc_mw, destroy_cq, modify_qp, and
destroy_qp.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 .../infiniband/hw/ionic/ionic_controlpath.c   | 63 +++++++++++++++++--
 drivers/infiniband/hw/ionic/ionic_ibdev.c     |  1 +
 2 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index 9d91f7667d4f..79570da3e6a6 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -487,6 +487,15 @@ int ionic_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct ionic_ibdev *dev = to_ionic_ibdev(ibpd->device);
 	struct ionic_pd *pd = to_ionic_pd(ibpd);
+	int rc;
+
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return rc;
+
+	rc = ib_respond_empty_udata(udata);
+	if (rc)
+		return rc;
 
 	return ionic_get_pdid(dev, &pd->pdid);
 }
@@ -495,10 +504,15 @@ int ionic_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct ionic_ibdev *dev = to_ionic_ibdev(ibpd->device);
 	struct ionic_pd *pd = to_ionic_pd(ibpd);
+	int rc;
+
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return rc;
 
 	ionic_put_pdid(dev, pd->pdid);
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 static int ionic_build_hdr(struct ionic_ibdev *dev,
@@ -741,6 +755,10 @@ int ionic_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	u32 flags = init_attr->flags;
 	int rc;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return rc;
+
 	rc = ionic_get_ahid(dev, &ah->ahid);
 	if (rc)
 		return rc;
@@ -877,6 +895,14 @@ struct ib_mr *ionic_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 	unsigned long pg_sz;
 	int rc;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return ERR_PTR(rc);
+
+	rc = ib_respond_empty_udata(udata);
+	if (rc)
+		return ERR_PTR(rc);
+
 	if (dmah)
 		return ERR_PTR(-EOPNOTSUPP);
 
@@ -1008,6 +1034,10 @@ int ionic_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	struct ionic_mr *mr = to_ionic_mr(ibmr);
 	int rc;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return rc;
+
 	if (!mr->ibmr.lkey)
 		goto out;
 
@@ -1027,7 +1057,7 @@ int ionic_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 out:
 	kfree(mr);
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 struct ib_mr *ionic_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type type,
@@ -1120,6 +1150,14 @@ int ionic_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 	struct ionic_mr *mr = to_ionic_mw(ibmw);
 	int rc;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return rc;
+
+	rc = ib_respond_empty_udata(udata);
+	if (rc)
+		return rc;
+
 	rc = ionic_get_mrid(dev, &mr->mrid);
 	if (rc)
 		return rc;
@@ -1292,6 +1330,10 @@ int ionic_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 	struct ionic_vcq *vcq = to_ionic_vcq(ibcq);
 	int udma_idx, rc_tmp, rc = 0;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return rc;
+
 	for (udma_idx = dev->lif_cfg.udma_count; udma_idx; ) {
 		--udma_idx;
 
@@ -1309,7 +1351,10 @@ int ionic_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 		ionic_destroy_cq_common(dev, &vcq->cq[udma_idx]);
 	}
 
-	return rc;
+	if (rc)
+		return rc;
+
+	return ib_respond_empty_udata(udata);
 }
 
 static bool pd_remote_privileged(struct ib_pd *pd)
@@ -2585,6 +2630,10 @@ int ionic_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int mask,
 	struct ionic_qp *qp = to_ionic_qp(ibqp);
 	int rc;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return rc;
+
 	rc = ionic_check_modify_qp(qp, attr, mask);
 	if (rc)
 		return rc;
@@ -2607,7 +2656,7 @@ int ionic_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int mask,
 		}
 	}
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
 
 int ionic_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
@@ -2658,6 +2707,10 @@ int ionic_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	struct ionic_cq *cq;
 	int rc;
 
+	rc = ib_is_udata_in_empty(udata);
+	if (rc)
+		return rc;
+
 	rc = ionic_destroy_qp_cmd(dev, qp->qpid);
 	if (rc)
 		return rc;
@@ -2692,5 +2745,5 @@ int ionic_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	}
 	ionic_put_qpid(dev, qp->qpid);
 
-	return 0;
+	return ib_respond_empty_udata(udata);
 }
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index b0449c75f893..ad4e9abb5bf4 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -216,6 +216,7 @@ static const struct ib_device_ops ionic_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_IONIC,
 	.uverbs_abi_ver = IONIC_ABI_VERSION,
+	.uverbs_robust_udata = true,
 
 	.alloc_ucontext = ionic_alloc_ucontext,
 	.dealloc_ucontext = ionic_dealloc_ucontext,
-- 
2.43.0


