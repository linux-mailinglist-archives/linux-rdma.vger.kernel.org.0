Return-Path: <linux-rdma+bounces-22085-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XvI1M4uLKWqIZAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22085-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 18:06:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA03666B2A5
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 18:06:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=qNFunmKs;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22085-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22085-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99A7030C3FBF
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 15:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F18348C8BB;
	Wed, 10 Jun 2026 15:42:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFC648C8A9;
	Wed, 10 Jun 2026 15:42:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106177; cv=fail; b=BtzB7lKfrMLp/+cPhdTbx4jMiS2z1/eFbyyDnQ3iIMvsQwVmF1lUPtUWd97L9X83nzigNQbge4DkvwQGBUlt+PdheDlJnmW3gJH8AAaUwZr3ghpJ9pyITVNGjJPsk5i9Bo8wv6Yy6lZ9KS7tYxdLPd26NLJrzy2/e/KqMgvgxKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106177; c=relaxed/simple;
	bh=+LYWcbeoF3XVPcWXUYbNw4PjG1htx5gY6TXdgYoLq7U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXDkxZIwUXhRdD01HXG9cIOHj/UaYTFlppdjCo4OeqIt4HIiMan5y7zXGkEKSGy2A+NsUwuGTcjjBljfcWpJcIIwqGO8zlOdy1WVj8oh7FugZIedewsHninUw05iq/EU2BTLv1UkKxa/kGly+MlFcPdju+si5Q4nXg1NQ4wQI28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qNFunmKs; arc=fail smtp.client-ip=52.101.52.45
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYG2XxdQvTHDn+Q+6VNBDgBdnDFo7pbuzy7GnauOBxeYTK9vcNhoi8dWbelFQYSErB/13Q+ULxINklvj/LS4FdjHX7HOVzcqn9tqep2FbXIbE6ZljhsNHvZoDhHmArN79pqfZSeq3r4T9ZUZADPf3+V+HULYUx8YHEq/SnJsXOQmiU2F+aTvRddz0cuOWDfDBeLsVhA56Y42qL7T0CUVGSr46rF2RgNI3bFed0Af8oWW/59gc9QUSafntkeyTxO2vvDNNBRPpYkHpQj81B+QhNXmXkfGi7Y3jq2TwqEXKkTfYxNjhjz0KYu4dkoCVKls8i38o3qTttNGcXxSeCByPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+hf8thI24Tminl7gjsSg0wOLrAbY1qqXWMvmt9NWe8=;
 b=lgF+N3h2DOgwVnAgdS/oavwdxvltvzrViTgjlwi3CnTG0t2Q5798B6VFmluyH/P9/rB0yRA6HNdk/TuUYkx76jmISGy3VgxQPPMj+7YPM+iz/5BJbeUKGdmdVKeIYpB6bFDkpDEfL6xBhhndTvbpYOjLcZ0MkpRHhWy67x2JS0X7G1RP4M/3rwpbO6q3hrjYwIOwrCYwajLPSkS98AV6xGqwd5lxl/AuEsL4aWz7sBIWI/UbaccbPT8sAXwLEnqlb0RInv1EA2+xGDRdqnKVb6yrawMJEzU6U0MVskVO9uERPxn5HQ8R3jASbB/E7HZtyowplfZlFyNk/Ekg/sYj6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+hf8thI24Tminl7gjsSg0wOLrAbY1qqXWMvmt9NWe8=;
 b=qNFunmKsmcse6HvLuobkFl5H+1Aist+E7BFgloB4kZnl8v8iIuLnYwnGyRD0UkxjnlNsBGmqXnkkby59lQ5Ae3OLa72ksg1AFKduqRnNRDSJFRCSNQIPNCEhWfaBfL4QrPyjvcUCSB4V+soKxJSVnrPmrzjaUV209PFau4TEeoI=
Received: from CH5P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::9)
 by SA5PPF50009C446.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.15; Wed, 10 Jun
 2026 15:42:42 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::76) by CH5P223CA0020.outlook.office365.com
 (2603:10b6:610:1f3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Wed,
 10 Jun 2026 15:42:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 15:42:42 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 10:42:40 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 10:42:36 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dwmw2@infradead.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [for-next v4 3/5] RDMA/ionic: map PHC state into user space
Date: Wed, 10 Jun 2026 21:12:14 +0530
Message-ID: <20260610154216.712374-4-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|SA5PPF50009C446:EE_
X-MS-Office365-Filtering-Correlation-Id: abf4c2c1-33ee-4832-e74d-08dec706e8bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|7416014|1800799024|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	72TAY0RkK7v9yS0tKTxKVc113IGq3+DGzdY9ndrcFzLxzibLfpbuW2IZPSCzlADFpx4foUlxvAswzXgnH9+uP/wvXvDDdHXqQUYm4F0wE+YqJfMp6hPaDTMMRNjleMXGAgjjkwqOnGfZZ+rg2mBx5Zf/j2sHOz/qWpOcPl33c66G6hwG+E3QvvEn+TvIsOmBlQ/LGmyT9SjugKwMaL8GjKGDDmmsnYfWr7zm9oOcSkWVjoHxdiVGp7e1CYeriCRRd/FiEpNSJQpyUVlGEzDIM7KI/fjOLqBoptCiuhfieT3oylx66E5GFSPdEwro+/EO1aoj4bsWdCcbT9INWwdYMantuHpExOoZp1qw32ig1jllhjpCjBsQi97LBqFaK0FLsHQYf8DX3hw6/DmkD3gH/H0ciJJ7YfWbk5RlEjxEDpREBf0b0nBwDo6TJM8/UbadxOOnN8Om7gmHw9cBH2uSQDTMDnSWS6Vt+3Mkqz4ttOfvQZWHSi8kBcqAYzv/7/3GiW/pOSW1eH4KicheziFWLg3kbvbrKNgq/tl5y1hA/o1Eje9E3LF60eHOSvYibUoai5zb7vvpIjZTdt7kxUqtLkx16Ef2oT8G/Gy0/wYI8/X7eaG4MBHQoIGGDlu6T3htwyAU8cRXjEUKkJbbfyXCW5xFVaQ8VCo7chvQnORK8U3Z7es5w4npIYWsOsrUqXNPmIKD1c/R4jWu1zO/8ixcR3mq/nvgypiJs3SSHT1fxTw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(7416014)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fMNw4Ze/AGElnDKgwstUqQ2JKg8RTdXANN1QqwoMfgvTB4gfP2VjlQ4R2Sftz1jbeOw84pz3zGijeg4c9bNRQtgqnWLJyV3EEgIlWJeXIRyIOqf3hjyTA0QvKGyJIoU3RLMZ1D4ZACzi9OP7ETNhzvpDlB3jNODtxyo04itrukopKL7ru5uJi1zwXujCiUJUuP51+2HwuWvUFj4uAxZEB3uA2RSYpB/+iu1UBu1YBcjnxMwC+PVmEW+7FnVW2Vu1e3rEnXJ/dLVKCgMVRO8s1JOURSjc8zNYQd3wnPlQtYU2qP239C9FbPisLHhWJtiznqfrBlL4uFH2k1hHcuLm/ehW0nbBH2+iesnbb4TKD49Bcpgx+H6PFLPUigJvjz3G4fWwET2P39+ODRuKUpklC81GJfCI113F2Aw6gme3QxNY/ReAC95Im7QfRozau1cj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 15:42:42.1026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abf4c2c1-33ee-4832-e74d-08dec706e8bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF50009C446
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-22085-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA03666B2A5

Enable user space applications to access the PHC state page when
firmware RDMA completion timestamp is supported.

This mapping allows user space to convert RDMA completion timestamps
to system wall time without kernel transitions, minimizing latency
overhead. Applications can directly read the PHC state through mmap,
enabling efficient timestamp correlation for precision timing
applications.

Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 .../infiniband/hw/ionic/ionic_controlpath.c   | 34 +++++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_ibdev.h     |  2 ++
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c   |  2 ++
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h   |  1 +
 include/uapi/rdma/ionic-abi.h                 |  1 +
 5 files changed, 40 insertions(+)

diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index db18c315cc21..29d670fd2ddd 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -391,6 +391,16 @@ int ionic_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 		goto err_mmap_dbell;
 	}
 
+	if (dev->lif_cfg.phc_state) {
+		ctx->mmap_phc = ionic_mmap_entry_insert(ctx, PAGE_SIZE, 0,
+							IONIC_MMAP_PHC,
+							&resp.phc_offset);
+		if (!ctx->mmap_phc) {
+			rc = -ENOMEM;
+			goto err_mmap_phc;
+		}
+	}
+
 	resp.page_shift = PAGE_SHIFT;
 
 	resp.dbell_offset = db_phys & ~PAGE_MASK;
@@ -421,6 +431,8 @@ int ionic_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 	return 0;
 
 err_resp:
+	rdma_user_mmap_entry_remove(ctx->mmap_phc);
+err_mmap_phc:
 	rdma_user_mmap_entry_remove(ctx->mmap_dbell);
 err_mmap_dbell:
 	ionic_put_dbid(dev, ctx->dbid);
@@ -433,10 +445,26 @@ void ionic_dealloc_ucontext(struct ib_ucontext *ibctx)
 	struct ionic_ibdev *dev = to_ionic_ibdev(ibctx->device);
 	struct ionic_ctx *ctx = to_ionic_ctx(ibctx);
 
+	rdma_user_mmap_entry_remove(ctx->mmap_phc);
 	rdma_user_mmap_entry_remove(ctx->mmap_dbell);
 	ionic_put_dbid(dev, ctx->dbid);
 }
 
+static int ionic_mmap_phc_state(struct ionic_ibdev *dev,
+				struct vm_area_struct *vma)
+{
+	if (!(vma->vm_flags & VM_SHARED))
+		return -EINVAL;
+
+	if (vma->vm_flags & (VM_WRITE | VM_EXEC))
+		return -EPERM;
+
+	vm_flags_clear(vma, VM_MAYWRITE);
+
+	return vm_insert_page(vma, vma->vm_start,
+			      virt_to_page(dev->lif_cfg.phc_state));
+}
+
 int ionic_mmap(struct ib_ucontext *ibctx, struct vm_area_struct *vma)
 {
 	struct ionic_ibdev *dev = to_ionic_ibdev(ibctx->device);
@@ -455,6 +483,12 @@ int ionic_mmap(struct ib_ucontext *ibctx, struct vm_area_struct *vma)
 	ionic_entry = container_of(rdma_entry, struct ionic_mmap_entry,
 				   rdma_entry);
 
+	if (ionic_entry->mmap_flags & IONIC_MMAP_PHC) {
+		rc = ionic_mmap_phc_state(dev, vma);
+		rdma_user_mmap_entry_put(rdma_entry);
+		return rc;
+	}
+
 	ibdev_dbg(&dev->ibdev, "writecombine? %d\n",
 		  ionic_entry->mmap_flags & IONIC_MMAP_WC);
 	if (ionic_entry->mmap_flags & IONIC_MMAP_WC)
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
index 63828240d659..08655c4d8297 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -72,6 +72,7 @@ enum ionic_admin_flags {
 
 enum ionic_mmap_flag {
 	IONIC_MMAP_WC = BIT(0),
+	IONIC_MMAP_PHC = BIT(1),
 };
 
 struct ionic_mmap_entry {
@@ -173,6 +174,7 @@ struct ionic_ctx {
 	struct ib_ucontext	ibctx;
 	u32			dbid;
 	struct rdma_user_mmap_entry	*mmap_dbell;
+	struct rdma_user_mmap_entry	*mmap_phc;
 };
 
 struct ionic_tbl_buf {
diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
index f3cd281c3a2f..f827dce59973 100644
--- a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
@@ -40,6 +40,8 @@ void ionic_fill_lif_cfg(struct ionic_lif *lif, struct ionic_lif_cfg *cfg)
 	cfg->dbid_count = le32_to_cpu(lif->ionic->ident.dev.ndbpgs_per_lif);
 	cfg->dbpage = lif->kern_dbpage;
 	cfg->intr_ctrl = lif->ionic->idev.intr_ctrl;
+	if (lif->phc)
+		cfg->phc_state = lif->phc->state_page;
 
 	cfg->db_phys = lif->ionic->bars[IONIC_PCI_BAR_DBELL].bus_addr;
 
diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.h b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
index 20853429f623..2b29e646c193 100644
--- a/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
@@ -23,6 +23,7 @@ struct ionic_lif_cfg {
 	u64 __iomem *dbpage;
 	struct ionic_intr __iomem *intr_ctrl;
 	phys_addr_t db_phys;
+	void *phc_state;
 
 	u64 page_size_supported;
 	u32 npts_per_lif;
diff --git a/include/uapi/rdma/ionic-abi.h b/include/uapi/rdma/ionic-abi.h
index 7b589d3e9728..2c70ac149c4f 100644
--- a/include/uapi/rdma/ionic-abi.h
+++ b/include/uapi/rdma/ionic-abi.h
@@ -48,6 +48,7 @@ struct ionic_ctx_resp {
 	__u8 expdb_qtypes;
 
 	__u8 rsvd2[3];
+	__aligned_u64 phc_offset;
 };
 
 struct ionic_qdesc {
-- 
2.43.0


