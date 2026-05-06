Return-Path: <linux-rdma+bounces-20049-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCKTMIjB+mnRSQMAu9opvQ
	(envelope-from <linux-rdma+bounces-20049-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 06:20:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3CE4D6170
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 06:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E9035301C013
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 04:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7449E2ED848;
	Wed,  6 May 2026 04:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oDBFNNy6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE24E2DE709;
	Wed,  6 May 2026 04:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778041210; cv=fail; b=RtAZXN+qtS6YMucNTyEkaqHnFH7w2mA35TIrxHLwOHx8MocmaJyH8WKjel3S5GZqAUuA9ftOCZDJrTLwiTZ+Zbh/Sns9SoIU9aeU9bJBvXaVfBKKRJ4uFySCjChccoAURN86wYHSORYFVMmKNpuoDnUsMPY7MjWBYIgmF2yrIMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778041210; c=relaxed/simple;
	bh=cMIlYysNC+MC4E0bnrrIX7CR9Hogu+tvVp3AnmLUX3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgJJgmUSaj1aSxupwpsCuVPdz+CoVvSXiSGxiAr7V+yRUDVWZGhxoxnkIBPofnM0+z5k3t/snKym29sVWDusTs9Rn+zxDeHHuuqssU6tt5oSKJeqKml2csSL8Cd8ZAPt2HT+oK/UoeKrWE44I0yg0i3zjStSi3K8WNEUt7Q3JX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oDBFNNy6; arc=fail smtp.client-ip=52.101.48.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThOy16xnpMmbkNLnGgBkOYA/DvG7l5ZIc6kWYLcP8ZKzx/rt7qA5WbO03z+cq5rZMDVFk/gk33Hb6wx6bLNFcBcScNbTi1JC4zk67APyMcX0oUBr2FxX0N8WbBQNI2rc8JGdLesO3dttRi1DwOpucDzc7YWtG/fLBhYahJTBMx4dWGhtvMD+mVwnGPnwHbVnKp/1l883HRW995p1wxMarbh3mBvERepij993nNVKFjkA597vAdRP9mAdfvkzSWCKwZZIIoGHD+ZpJ1kyTcyOg2f9bRmM7Oi6TG647oPRzk1fDQ9FC9hCef/prQXu02TYOOu+UsmAL6oDltJioxi6Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=loxh/tfa5RltgON5lVqQGtfk1VLbUqgiCIGb3PMMvtI=;
 b=GVcGO88yWHnAtWxQiAW5EtganafpetZ6zt1qdYt7MypxkF2h3euh5V8LVcfojw4eoP4y2zqa+DOOyp2NfLqh7cbME2nL0GIWZ66GcNAcg7USpJGqFyV5HfCoRqMnOL5VIpzAuMtNJefMYMGueb9eTnnYsYF/oiJiV2keQXc9popStyuEY9Qb/f2oc8TpDhFKkhKo1ydU3kqYtDJ/b+4OOlWEVDdl3YecGW9ddPsNzYxCaP/oNZUT35xy+xR41z3GBO+6L6guLgppXcGQCX1ZTVJ58SvMemj7QTZlKhGrKsvJEQatQfWGqXyGIv6pS+wMwJTb6FYj+EJbLIW/HdhfHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loxh/tfa5RltgON5lVqQGtfk1VLbUqgiCIGb3PMMvtI=;
 b=oDBFNNy6AMTTAdeAjpVe/CLsj41hUrFFNidJ4/tx7FutkA8dyqHb3/SYGyhHkjDQ7cM43qKzqgGhT0Sz/5+sRO0OivTS5qFQ8gKD7u8PY9txfeNUPCgvbH5Nolddu2DIjAw8hWWUSndgITII/2oHcNTmXoDF2aYKbLwR3VPznHY=
Received: from PH7PR17CA0071.namprd17.prod.outlook.com (2603:10b6:510:325::28)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 04:19:58 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::93) by PH7PR17CA0071.outlook.office365.com
 (2603:10b6:510:325::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 04:19:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 04:19:58 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 23:19:55 -0500
From: Eric Joyner <eric.joyner@amd.com>
To: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Abhijit Gangurde <abhijit.gangurde@amd.com>, Allen Hubbe
	<allen.hubbe@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next 3/4] RDMA/ionic: Add debugfs support
Date: Tue, 5 May 2026 21:19:34 -0700
Message-ID: <20260506041935.1061-4-eric.joyner@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260506041935.1061-1-eric.joyner@amd.com>
References: <20260506041935.1061-1-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: bd33de8f-f25b-4533-edde-08deab26bbe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	P1HCPXSPyvGy/2yk/cdwypPKgfjR7uOoiMnH52WQJzszSwrcokDUnP0zzPk/y8SyrScWmByIDZGwk5jwl45AXuXVUkUlKIMo1MeL0p67IGdef/HJyHsbulL0Xzf6HID5taSKMW40ycckYrAw2JA+VsbPcR83u/+xANbZ/VxDSKrwiD5eADcmUOvkglS77iuBYbWFbTGxyvXzpwdR6Z2TLbyUsXq4hbO/UQqlpE1BJlUXdjM203AHXfNzZtMsQAxYDODtt4QVYyXn4STRSauWlZgaGF251qlz2bfihKCVoMGGlfT5Id/4TYxi4j0BjpX8fCgHPF+bjuJ3n3RLM0+lXFw68BMqDmtw6XcQBlSB7ieZd4cCnmMjBP8FW7DaF5LcrqBrJK5cLgaIcjQbkW54kOQWwfQI36+z8K9LzaPTlGgCTbrDkOIGStc1vXgWu1u9VRt/snfhe1zH2Ow0iVcCTcf5sAZn57CE1F6/r3fQ4Vh+rXZhwS9wacIsc/DDe3IjDTg4dbqlMIOQXa2oeyAOj4IjiHDGB5uh1B/tZF7foV+qOGpGfPugR4CFIEACF587YV3+FXwYKk92mopanBbzCiOqeiPpCfBJ6cCTvCLAZOs0RGp+aqspHwWSupC9tzxUqM6npaBTLsMbtJj/J1RBd2tQBVR9m0HbgIqZDI3iJjb3Sz/yAnGguLNumA2okgUqHBDvNWcQmxdpOhaJ/fCJn86xYuwGjQdLEm9rxnhVkPM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wGfeKRAtlnpWJrjUrd7SzkVzkt8bLZ9Ax+O8o0Z70IGa/dd2LVQ8IWRNG6lLm2FOxJsiJRT/LbPA+PJ9ipjBR60+PjHXf19GLSFXprktqgyuk6ePNypaq0RKOAa37DaBnjn8qD3elWKJJ/62/NnbYniZ5Gmlh70Q/yLTqkiV5fLJzXIBeV4G+ySFFDCMvMVvasdjoU3vW68hMl+TcH6Fq03iWQBPDt0TugLborIIlsDRMFX4f0XWeaDOiLdnggGOAzBruy3v4aezjp9OkI03rrbh2hm5A3BDBmIc7ywfXIyQGNx6QjL3tCz3Vscf9VEJpoY+f0MjPoOFUrE7Wy/H6BRfWIWS2ZRivxdK7eT7Z4V9TLjUzMB49Ajy9NgiAKRxcXHUUrnlZrzRUdW0Zl4zMNyArpi/F6ioGXYn3XeB8IGmehoeCrhQIQJP7OQE6JS+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 04:19:58.2095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd33de8f-f25b-4533-edde-08deab26bbe9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376
X-Rspamd-Queue-Id: AD3CE4D6170
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
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20049-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Allen Hubbe <allen.hubbe@amd.com>

Adds a per-RDMA device debugfs folder under the parent ionic ethernet
device's folder for the LIF. Exports RDMA-specific debug information and
various queue information.

Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Co-developed-by: Eric Joyner <eric.joyner@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 drivers/infiniband/hw/ionic/Makefile          |   2 +-
 drivers/infiniband/hw/ionic/ionic_admin.c     |   4 +
 .../infiniband/hw/ionic/ionic_controlpath.c   |  14 +
 drivers/infiniband/hw/ionic/ionic_debugfs.c   | 750 ++++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_ibdev.c     |   3 +
 drivers/infiniband/hw/ionic/ionic_ibdev.h     |  29 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c   |   3 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h   |   2 +
 8 files changed, 806 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/hw/ionic/ionic_debugfs.c

diff --git a/drivers/infiniband/hw/ionic/Makefile b/drivers/infiniband/hw/ionic/Makefile
index 957973742820..65bb4eaf0c13 100644
--- a/drivers/infiniband/hw/ionic/Makefile
+++ b/drivers/infiniband/hw/ionic/Makefile
@@ -6,4 +6,4 @@ obj-$(CONFIG_INFINIBAND_IONIC)	+= ionic_rdma.o
 
 ionic_rdma-y :=	\
 	ionic_ibdev.o ionic_lif_cfg.o ionic_queue.o ionic_pgtbl.o ionic_admin.o \
-	ionic_controlpath.o ionic_datapath.o ionic_hw_stats.o
+	ionic_controlpath.o ionic_datapath.o ionic_hw_stats.o ionic_debugfs.o
diff --git a/drivers/infiniband/hw/ionic/ionic_admin.c b/drivers/infiniband/hw/ionic/ionic_admin.c
index 6e3cf87025b6..3ef8bcdf8095 100644
--- a/drivers/infiniband/hw/ionic/ionic_admin.c
+++ b/drivers/infiniband/hw/ionic/ionic_admin.c
@@ -586,6 +586,7 @@ static struct ionic_aq *__ionic_create_rdma_adminq(struct ionic_ibdev *dev,
 
 	INIT_WORK(&aq->work, ionic_admin_work);
 	aq->armed = false;
+	ionic_dbg_add_aq(dev, aq);
 
 	return aq;
 
@@ -600,6 +601,7 @@ static struct ionic_aq *__ionic_create_rdma_adminq(struct ionic_ibdev *dev,
 static void __ionic_destroy_rdma_adminq(struct ionic_ibdev *dev,
 					struct ionic_aq *aq)
 {
+	ionic_dbg_rm_aq(aq);
 	kfree(aq->q_wr);
 	ionic_queue_destroy(&aq->q, dev->lif_cfg.hwdev);
 	kfree(aq);
@@ -1032,6 +1034,7 @@ static struct ionic_eq *ionic_create_eq(struct ionic_ibdev *dev, int eqid)
 		goto err_cmd;
 
 	ionic_intr_mask(dev->lif_cfg.intr_ctrl, eq->intr, IONIC_INTR_MASK_CLEAR);
+	ionic_dbg_add_eq(dev, eq);
 
 	return eq;
 
@@ -1053,6 +1056,7 @@ static void ionic_destroy_eq(struct ionic_eq *eq)
 {
 	struct ionic_ibdev *dev = eq->dev;
 
+	ionic_dbg_rm_eq(eq);
 	eq->enable = false;
 	free_irq(eq->irq, eq);
 	flush_work(&eq->work);
diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index 850435ec0072..0ea053369cba 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -153,6 +153,8 @@ int ionic_create_cq_common(struct ionic_vcq *vcq,
 		goto err_xa;
 	}
 
+	ionic_dbg_add_cq(dev, cq);
+
 	return 0;
 
 err_xa:
@@ -176,6 +178,7 @@ void ionic_destroy_cq_common(struct ionic_ibdev *dev, struct ionic_cq *cq)
 	if (!cq->vcq)
 		return;
 
+	ionic_dbg_rm_cq(cq);
 	xa_erase_irq(&dev->cq_tbl, cq->cqid);
 
 	kref_put(&cq->cq_kref, ionic_cq_complete);
@@ -918,6 +921,7 @@ struct ib_mr *ionic_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
 		goto err_cmd;
 
 	ionic_pgtbl_unbuf(dev, &mr->buf);
+	ionic_dbg_add_mr(dev, mr);
 
 	return &mr->ibmr;
 
@@ -988,6 +992,7 @@ struct ib_mr *ionic_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 offset,
 		goto err_cmd;
 
 	ionic_pgtbl_unbuf(dev, &mr->buf);
+	ionic_dbg_add_mr(dev, mr);
 
 	return &mr->ibmr;
 
@@ -1017,6 +1022,7 @@ int ionic_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 			return rc;
 	}
 
+	ionic_dbg_rm_mr(mr);
 	ionic_pgtbl_unbuf(dev, &mr->buf);
 
 	if (mr->umem)
@@ -1064,6 +1070,8 @@ struct ib_mr *ionic_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type type,
 	if (rc)
 		goto err_cmd;
 
+	ionic_dbg_add_mr(dev, mr);
+
 	return &mr->ibmr;
 
 err_cmd:
@@ -1135,6 +1143,8 @@ int ionic_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
 	if (rc)
 		goto err_cmd;
 
+	ionic_dbg_add_mr(dev, mr);
+
 	return 0;
 
 err_cmd:
@@ -1152,6 +1162,7 @@ int ionic_dealloc_mw(struct ib_mw *ibmw)
 	if (rc)
 		return rc;
 
+	ionic_dbg_rm_mr(mr);
 	ionic_put_mrid(dev, mr->mrid);
 
 	return 0;
@@ -2364,6 +2375,8 @@ int ionic_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 		qp->rq_cqid = cq->cqid;
 	}
 
+	ionic_dbg_add_qp(dev, qp);
+
 	return 0;
 
 err_resp:
@@ -2643,6 +2656,7 @@ int ionic_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 	if (rc)
 		return rc;
 
+	ionic_dbg_rm_qp(qp);
 	xa_erase_irq(&dev->qp_tbl, qp->qpid);
 
 	kref_put(&qp->qp_kref, ionic_qp_complete);
diff --git a/drivers/infiniband/hw/ionic/ionic_debugfs.c b/drivers/infiniband/hw/ionic/ionic_debugfs.c
new file mode 100644
index 000000000000..bff110f6d553
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_debugfs.c
@@ -0,0 +1,750 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2018-2026, Advanced Micro Devices, Inc. */
+
+#include <linux/ctype.h>
+#include <linux/debugfs.h>
+#include <linux/module.h>
+
+#include "ionic_ibdev.h"
+
+static void ionic_umem_show(struct seq_file *s, const char *w,
+			    struct ib_umem *umem, u8 page_size_log2)
+{
+	seq_printf(s, "%sumem.length:\t%#lx\n", w, umem->length);
+	seq_printf(s, "%sumem.address:\t%#lx\n", w, umem->address);
+	seq_printf(s, "%sumem.page_size:\t%llu\n", w, 1ULL << page_size_log2);
+	seq_printf(s, "%sumem.writable:\t%d\n", w, umem->writable);
+	seq_printf(s, "%sumem.nmap:\t%d\n", w, umem->sgt_append.sgt.nents);
+	seq_printf(s, "%sumem.offset():\t%#x\n", w, ib_umem_offset(umem));
+	seq_printf(s, "%sumem.num_pages():\t%lu\n",
+		   w, ib_umem_num_pages(umem));
+}
+
+static void ionic_umem_dump(struct seq_file *s, struct ib_umem *umem,
+			    u8 page_size_log2)
+{
+	int sg_i, page_i, page_count;
+	struct scatterlist *sg;
+	u64 page_dma, pg_sz;
+
+	pg_sz = 1 << page_size_log2;
+	for_each_sgtable_dma_sg(&umem->sgt_append.sgt, sg, sg_i) {
+		page_dma = sg_dma_address(sg);
+		page_count = sg_dma_len(sg) >> page_size_log2;
+
+		for (page_i = 0; page_i < page_count; ++page_i) {
+			seq_printf(s, "%#llx\n", page_dma);
+			page_dma += pg_sz;
+		}
+	}
+}
+
+static void ionic_tbl_buf_show(struct seq_file *s, const char *w,
+			       struct ionic_tbl_buf *buf)
+{
+	seq_printf(s, "%stbl_limit:\t%u\n", w, buf->tbl_limit);
+	seq_printf(s, "%stbl_pages:\t%u\n", w, buf->tbl_pages);
+	seq_printf(s, "%stbl_size:\t%zu\n", w, buf->tbl_size);
+	seq_printf(s, "%stbl_dma:\t%#llx\n", w, buf->tbl_dma);
+	seq_printf(s, "%spage_size_log2:\t%u\n", w, buf->page_size_log2);
+}
+
+static void ionic_tbl_buf_dump(struct seq_file *s, struct ionic_tbl_buf *buf)
+{
+	int page_i;
+
+	if (!buf->tbl_buf)
+		return;
+
+	for (page_i = 0; page_i < buf->tbl_pages; ++page_i)
+		seq_printf(s, "%llx\n", buf->tbl_buf[page_i]);
+}
+
+static void ionic_q_show(struct seq_file *s, const char *w,
+			 struct ionic_queue *q)
+{
+	seq_printf(s, "%ssize:\t%#llx\n", w, (u64)q->size);
+	seq_printf(s, "%sdma:\t%#llx\n", w, (u64)q->dma);
+	seq_printf(s, "%sprod:\t%#06x (%#llx)\n",
+		   w, q->prod, (u64)q->prod << q->stride_log2);
+	seq_printf(s, "%scons:\t%#06x (%#llx)\n",
+		   w, q->cons, (u64)q->cons << q->stride_log2);
+	seq_printf(s, "%smask:\t%#06x\n", w, q->mask);
+	seq_printf(s, "%sdepth_log2:\t%u\n", w, q->depth_log2);
+	seq_printf(s, "%sstride_log2:\t%u\n", w, q->stride_log2);
+	seq_printf(s, "%sdbell:\t%#llx\n", w, q->dbell);
+}
+
+static void ionic_q_dump(struct seq_file *s, struct ionic_queue *q)
+{
+	seq_hex_dump(s, "", DUMP_PREFIX_OFFSET, 16, 1, q->ptr, q->size, true);
+}
+
+static int ionic_dev_info_show(struct seq_file *s, void *v)
+{
+	struct ionic_ibdev *dev = s->private;
+	struct ionic_lif_cfg *lif_cfg;
+
+	lif_cfg = &dev->lif_cfg;
+
+	seq_printf(s, "lif_index:\t%d\n", lif_cfg->lif_index);
+	seq_printf(s, "dbid:\t%u\n", lif_cfg->dbid);
+
+	seq_printf(s, "rdma_version:\t%u\n", lif_cfg->rdma_version);
+	seq_printf(s, "rdma_minor_version:\t%u\n", lif_cfg->minor_version);
+	seq_printf(s, "qp_opcodes:\t%u\n", lif_cfg->qp_opcodes);
+	seq_printf(s, "admin_opcodes:\t%u\n", lif_cfg->admin_opcodes);
+	seq_printf(s, "reset_cnt:\t%u\n", dev->reset_cnt);
+
+	seq_printf(s, "aq_base:\t%u\n", lif_cfg->aq_base);
+	seq_printf(s, "cq_base:\t%u\n", lif_cfg->cq_base);
+	seq_printf(s, "eq_base:\t%u\n", lif_cfg->eq_base);
+
+	seq_printf(s, "aq_count:\t%u\n", lif_cfg->aq_count);
+	seq_printf(s, "eq_count:\t%u\n", lif_cfg->eq_count);
+
+	seq_printf(s, "aq_qtype:\t%u\n", lif_cfg->aq_qtype);
+	seq_printf(s, "sq_qtype:\t%u\n", lif_cfg->sq_qtype);
+	seq_printf(s, "rq_qtype:\t%u\n", lif_cfg->rq_qtype);
+	seq_printf(s, "cq_qtype:\t%u\n", lif_cfg->cq_qtype);
+	seq_printf(s, "eq_qtype:\t%u\n", lif_cfg->eq_qtype);
+
+	seq_printf(s, "max_stride:\t%u\n", lif_cfg->max_stride);
+
+	seq_printf(s, "sq_expdb:\t%u\n", lif_cfg->sq_expdb);
+	seq_printf(s, "rq_expdb:\t%u\n", lif_cfg->rq_expdb);
+	seq_printf(s, "expdb_mask:\t%u\n", lif_cfg->expdb_mask);
+
+	seq_printf(s, "udma_count:\t%u\n", lif_cfg->udma_count);
+	seq_printf(s, "udma_qgrp_shift:\t%u\n", lif_cfg->udma_qgrp_shift);
+
+	if (dev->aq_vec[0])
+		seq_printf(s, "AQ[0] admin_state:\t%u\n",
+			   atomic_read(&dev->aq_vec[0]->admin_state));
+
+	seq_printf(s, "size_pdid:\t%u\n", dev->inuse_pdid.inuse_size);
+	seq_printf(s, "size_mrid:\t%u\n", dev->inuse_mrid.inuse_size);
+	seq_printf(s, "next_mrkey:\t%u\n", dev->next_mrkey);
+	seq_printf(s, "size_cqid:\t%u\n", dev->lif_cfg.cq_count);
+	seq_printf(s, "size_qpid:\t%u\n", dev->lif_cfg.qp_count);
+
+	seq_printf(s, "page_size_supported:\t0x%llX\n",
+		   lif_cfg->page_size_supported);
+	seq_printf(s, "stats_type:\t0x%0X\n", lif_cfg->stats_type);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ionic_dev_info);
+
+static int ionic_eq_info_show(struct seq_file *s, void *v)
+{
+	struct ionic_eq *eq = s->private;
+	struct ionic_intr __iomem *intr;
+
+	seq_printf(s, "eqid:\t%u\n", eq->eqid);
+	seq_printf(s, "intr:\t%u\n", eq->intr);
+
+	ionic_q_show(s, "q.",  &eq->q);
+	seq_printf(s, "enable:\t%u\n", eq->enable);
+	seq_printf(s, "armed:\t%u\n", eq->armed);
+	seq_printf(s, "irq:\t%u\n", eq->irq);
+	seq_printf(s, "name:\t%s\n", eq->name);
+
+	/* interrupt control readback */
+	intr = &eq->dev->lif_cfg.intr_ctrl[eq->intr];
+	seq_printf(s, "intr_coalesce_init:\t%#x\n", ioread32(&intr->coal_init));
+	seq_printf(s, "intr_mask:\t%#x\n", ioread32(&intr->mask));
+	seq_printf(s, "intr_credits:\t%#x\n", ioread32(&intr->credits));
+	seq_printf(s, "intr_mask_assert:\t%#x\n", ioread32(&intr->mask_assert));
+	seq_printf(s, "intr_coalesce:\t%#x\n", ioread32(&intr->coal));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ionic_eq_info);
+
+static int ionic_eq_q_show(struct seq_file *s, void *v)
+{
+	struct ionic_eq *eq = s->private;
+
+	ionic_q_dump(s, &eq->q);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ionic_eq_q);
+
+static int ionic_mr_info_show(struct seq_file *s, void *v)
+{
+	struct ionic_mr *mr = s->private;
+
+	seq_printf(s, "mrid:\t%u\n", mr->mrid);
+
+	ionic_tbl_buf_show(s, "", &mr->buf);
+
+	if (mr->umem)
+		ionic_umem_show(s, "", mr->umem, mr->buf.page_size_log2);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ionic_mr_info);
+
+static int ionic_mr_umem_show(struct seq_file *s, void *v)
+{
+	struct ionic_mr *mr = s->private;
+
+	ionic_umem_dump(s, mr->umem, mr->buf.page_size_log2);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ionic_mr_umem);
+
+static int ionic_mr_tbl_buf_show(struct seq_file *s, void *v)
+{
+	struct ionic_mr *mr = s->private;
+
+	ionic_tbl_buf_dump(s, &mr->buf);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ionic_mr_tbl_buf);
+
+static int ionic_cq_info_show(struct seq_file *s, void *v)
+{
+	struct ionic_cq *cq = s->private;
+
+	seq_printf(s, "cqid:\t%u\n", cq->cqid);
+	seq_printf(s, "eqid:\t%u\n", cq->eqid);
+
+	if (cq->q.ptr) {
+		ionic_q_show(s, "", &cq->q);
+		seq_printf(s, "arm_any_prod:\t%#06x\n", cq->arm_any_prod);
+		seq_printf(s, "arm_sol_prod:\t%#06x\n", cq->arm_sol_prod);
+	}
+
+	if (cq->umem)
+		ionic_umem_show(s, "", cq->umem, PAGE_SHIFT);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ionic_cq_info);
+
+static int ionic_cq_q_show(struct seq_file *s, void *v)
+{
+	struct ionic_cq *cq = s->private;
+
+	ionic_q_dump(s, &cq->q);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ionic_cq_q);
+
+static int ionic_cq_umem_show(struct seq_file *s, void *v)
+{
+	struct ionic_cq *cq = s->private;
+
+	ionic_umem_dump(s, cq->umem, PAGE_SHIFT);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ionic_cq_umem);
+
+static int ionic_aq_info_show(struct seq_file *s, void *v)
+{
+	struct ionic_aq *aq = s->private;
+
+	seq_printf(s, "armed:\t%u\n", aq->armed);
+	seq_printf(s, "aqid:\t%u\n", aq->aqid);
+	seq_printf(s, "cqid:\t%u\n", aq->cqid);
+
+	if (aq->q.ptr)
+		ionic_q_show(s, "", &aq->q);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ionic_aq_info);
+
+static int ionic_aq_q_show(struct seq_file *s, void *v)
+{
+	struct ionic_aq *aq = s->private;
+
+	ionic_q_dump(s, &aq->q);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ionic_aq_q);
+
+static int ionic_aq_wqe_show(struct seq_file *s, void *v)
+{
+	struct ionic_aq *aq = s->private;
+	struct ionic_v1_admin_wqe *wqe;
+
+	wqe = &aq->debug_wr->wqe;
+
+	seq_hex_dump(s, "", DUMP_PREFIX_OFFSET, 16, 1, wqe, sizeof(*wqe),
+		     true);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ionic_aq_wqe);
+
+static int ionic_aq_cqe_show(struct seq_file *s, void *v)
+{
+	struct ionic_aq *aq = s->private;
+	struct ionic_v1_cqe *cqe;
+
+	cqe = &aq->debug_wr->cqe;
+
+	seq_hex_dump(s, "", DUMP_PREFIX_OFFSET, 16, 1, cqe, sizeof(*cqe),
+		     true);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ionic_aq_cqe);
+
+struct ionic_dbg_admin_wr {
+	struct ionic_aq *aq;
+	struct ionic_admin_wr wr;
+	void *data;
+	dma_addr_t dma;
+};
+
+static int ionic_aq_data_show(struct seq_file *s, void *v)
+{
+	struct ionic_aq *aq = s->private;
+	struct ionic_dbg_admin_wr *wr;
+
+	wr = container_of(aq->debug_wr, struct ionic_dbg_admin_wr, wr);
+
+	dma_sync_single_for_cpu(aq->dev->lif_cfg.hwdev, wr->dma, PAGE_SIZE,
+				DMA_FROM_DEVICE);
+
+	seq_hex_dump(s, "", DUMP_PREFIX_OFFSET, 16, 1,
+		     wr->data, PAGE_SIZE, true);
+
+	dma_sync_single_for_device(aq->dev->lif_cfg.hwdev, wr->dma, PAGE_SIZE,
+				   DMA_FROM_DEVICE);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ionic_aq_data);
+
+static int ionic_qp_info_show(struct seq_file *s, void *v)
+{
+	struct ionic_qp *qp = s->private;
+
+	seq_printf(s, "qpid:\t%u\n", qp->qpid);
+	seq_printf(s, "udma_idx:\t%u\n", qp->udma_idx);
+	seq_printf(s, "state:\t%d\n", qp->state);
+
+	if (qp->sq.ptr) {
+		ionic_q_show(s, "sq.", &qp->sq);
+		seq_printf(s, "sq_msn_prod:\t%#06x\n",
+			   qp->sq_msn_prod);
+		seq_printf(s, "sq_msn_cons:\t%#06x\n",
+			   qp->sq_msn_cons);
+	}
+
+	if (qp->sq_umem)
+		ionic_umem_show(s, "sq.", qp->sq_umem, PAGE_SHIFT);
+
+	seq_printf(s, "sq_is_cmb:\t%d\n", !!(qp->sq_cmb & IONIC_CMB_ENABLE));
+	if (qp->sq_cmb & IONIC_CMB_ENABLE) {
+		seq_printf(s, "sq_is_expdb:\t%d\n",
+			   !!(qp->sq_cmb & IONIC_CMB_EXPDB));
+		seq_printf(s, "sq_cmb_order:\t%d\n", qp->sq_cmb_order);
+		seq_printf(s, "sq_cmb_pgid:\t%d\n", qp->sq_cmb_pgid);
+		seq_printf(s, "sq_cmb_addr:\t%#llx\n",
+			   (u64)qp->sq_cmb_addr);
+	}
+
+	seq_printf(s, "sq_flush:\t%d\n", qp->sq_flush);
+	seq_printf(s, "sq_flush_rcvd:\t%d\n", qp->sq_flush_rcvd);
+	seq_printf(s, "sq_spec:\t%d\n", qp->sq_spec);
+	seq_printf(s, "sq_cqid:\t%u\n", qp->sq_cqid);
+
+	if (qp->rq.ptr)
+		ionic_q_show(s, "rq.", &qp->rq);
+
+	if (qp->rq_umem)
+		ionic_umem_show(s, "rq.", qp->rq_umem, PAGE_SHIFT);
+
+	seq_printf(s, "rq_is_cmb:\t%d\n", !!(qp->rq_cmb & IONIC_CMB_ENABLE));
+	if (qp->rq_cmb & IONIC_CMB_ENABLE) {
+		seq_printf(s, "rq_is_expdb:\t%d\n",
+			   !!(qp->rq_cmb & IONIC_CMB_EXPDB));
+		seq_printf(s, "rq_cmb_order:\t%d\n", qp->rq_cmb_order);
+		seq_printf(s, "rq_cmb_pgid:\t%d\n", qp->rq_cmb_pgid);
+		seq_printf(s, "rq_cmb_addr:\t%#llx\n",
+			   (u64)qp->rq_cmb_addr);
+	}
+
+	seq_printf(s, "rq_flush:\t%d\n", qp->rq_flush);
+	seq_printf(s, "rq_spec:\t%d\n", qp->rq_spec);
+	seq_printf(s, "rq_cqid:\t%u\n", qp->rq_cqid);
+
+	if (qp->has_ah) {
+		bool is_ip4 = false, is_ip6 = false;
+		struct ib_ud_header *hdr = qp->hdr;
+
+		seq_printf(s, "hdr_eth_smac:\t%pM\n", hdr->eth.smac_h);
+		seq_printf(s, "hdr_eth_dmac:\t%pM\n", hdr->eth.dmac_h);
+
+		if (hdr->eth.type == cpu_to_be16(ETH_P_8021Q)) {
+			seq_printf(s, "hdr_eth_vlan:\t%u\n",
+				   be16_to_cpu(hdr->vlan.tag));
+			is_ip4 = hdr->vlan.type == cpu_to_be16(ETH_P_IP);
+			is_ip6 = hdr->vlan.type == cpu_to_be16(ETH_P_IPV6);
+		} else {
+			is_ip4 = hdr->eth.type == cpu_to_be16(ETH_P_IP);
+			is_ip6 = hdr->eth.type == cpu_to_be16(ETH_P_IPV6);
+		}
+
+		if (is_ip4) {
+			seq_printf(s, "hdr_ip4_saddr:\t%pI4\n", &hdr->ip4.saddr);
+			seq_printf(s, "hdr_ip4_daddr:\t%pI4\n", &hdr->ip4.daddr);
+			seq_printf(s, "hdr_ip4_ttl:\t%u\n", hdr->ip4.ttl);
+			seq_printf(s, "hdr_ip4_tos:\t%u\n", hdr->ip4.tos);
+		}
+
+		if (is_ip6) {
+			seq_printf(s, "hdr_ip6_saddr:\t%pI6\n",
+				   hdr->grh.source_gid.raw);
+			seq_printf(s, "hdr_ip6_daddr:\t%pI6\n",
+				   hdr->grh.destination_gid.raw);
+			seq_printf(s, "hdr_ip6_flow_label:\t%u\n",
+				   be32_to_cpu(hdr->grh.flow_label));
+			seq_printf(s, "hdr_ip6_hop_limit:\t%u\n",
+				   hdr->grh.hop_limit);
+			seq_printf(s, "hdr_ip6_traffic_class:\t%u\n",
+				   hdr->grh.traffic_class);
+		}
+
+		seq_printf(s, "hdr_udp_sport:\t%u\n", be16_to_cpu(hdr->udp.sport));
+		seq_printf(s, "hdr_udp_dport:\t%u\n", be16_to_cpu(hdr->udp.dport));
+	}
+
+	seq_printf(s, "dcqcn_profile:\t%d\n", qp->dcqcn_profile);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ionic_qp_info);
+
+static int ionic_qp_sq_show(struct seq_file *s, void *v)
+{
+	struct ionic_qp *qp = s->private;
+
+	ionic_q_dump(s, &qp->sq);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ionic_qp_sq);
+
+static int ionic_qp_sq_umem_show(struct seq_file *s, void *v)
+{
+	struct ionic_qp *qp = s->private;
+
+	ionic_umem_dump(s, qp->sq_umem, PAGE_SHIFT);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ionic_qp_sq_umem);
+
+static int ionic_qp_rq_show(struct seq_file *s, void *v)
+{
+	struct ionic_qp *qp = s->private;
+
+	ionic_q_dump(s, &qp->rq);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ionic_qp_rq);
+
+static int ionic_qp_rq_umem_show(struct seq_file *s, void *v)
+{
+	struct ionic_qp *qp = s->private;
+
+	ionic_umem_dump(s, qp->rq_umem, PAGE_SHIFT);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ionic_qp_rq_umem);
+
+void ionic_dbg_add_eq(struct ionic_ibdev *dev, struct ionic_eq *eq)
+{
+	char name[8];
+
+	eq->debug = NULL;
+
+	if (!dev->debug_eq)
+		return;
+
+	snprintf(name, sizeof(name), "%u", eq->eqid);
+
+	eq->debug = debugfs_create_dir(name, dev->debug_eq);
+	if (IS_ERR(eq->debug))
+		eq->debug = NULL;
+	if (!eq->debug)
+		return;
+
+	debugfs_create_file("info", 0440, eq->debug, eq,
+			    &ionic_eq_info_fops);
+
+	debugfs_create_file("q", 0440, eq->debug, eq,
+			    &ionic_eq_q_fops);
+}
+
+void ionic_dbg_rm_eq(struct ionic_eq *eq)
+{
+	debugfs_remove_recursive(eq->debug);
+
+	eq->debug = NULL;
+}
+
+void ionic_dbg_add_cq(struct ionic_ibdev *dev, struct ionic_cq *cq)
+{
+	char name[8];
+
+	cq->debug = NULL;
+
+	if (!dev->debug_cq)
+		return;
+
+	snprintf(name, sizeof(name), "%u", cq->cqid);
+
+	cq->debug = debugfs_create_dir(name, dev->debug_cq);
+	if (IS_ERR(cq->debug))
+		cq->debug = NULL;
+	if (!cq->debug)
+		return;
+
+	debugfs_create_file("info", 0440, cq->debug, cq,
+			    &ionic_cq_info_fops);
+
+	if (cq->q.ptr)
+		debugfs_create_file("q", 0440, cq->debug, cq,
+				    &ionic_cq_q_fops);
+
+	if (cq->umem)
+		debugfs_create_file("umem", 0440, cq->debug, cq,
+				    &ionic_cq_umem_fops);
+}
+
+void ionic_dbg_rm_cq(struct ionic_cq *cq)
+{
+	debugfs_remove_recursive(cq->debug);
+
+	cq->debug = NULL;
+}
+
+void ionic_dbg_add_aq(struct ionic_ibdev *dev, struct ionic_aq *aq)
+{
+	struct ionic_dbg_admin_wr *wr;
+	char name[8];
+
+	mutex_init(&aq->debug_mutex);
+
+	aq->debug = NULL;
+
+	if (!dev->debug_aq)
+		return;
+
+	snprintf(name, sizeof(name), "%u", aq->aqid);
+
+	aq->debug = debugfs_create_dir(name, dev->debug_aq);
+	if (IS_ERR(aq->debug))
+		aq->debug = NULL;
+	if (!aq->debug)
+		return;
+
+	debugfs_create_file("info", 0440, aq->debug, aq,
+			    &ionic_aq_info_fops);
+
+	if (aq->q.ptr)
+		debugfs_create_file("q", 0440, aq->debug, aq,
+				    &ionic_aq_q_fops);
+
+	wr = kzalloc_obj(*wr);
+	if (!wr)
+		goto err_wr;
+
+	wr->data = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!wr->data)
+		goto err_data;
+
+	wr->dma = dma_map_single(dev->lif_cfg.hwdev, wr->data, PAGE_SIZE,
+				 DMA_FROM_DEVICE);
+	if (dma_mapping_error(dev->lif_cfg.hwdev, wr->dma))
+		goto err_dma;
+
+	wr->wr.wqe.op = IONIC_V1_ADMIN_DEBUG;
+	wr->wr.wqe.cmd.stats.dma_addr = cpu_to_le64(wr->dma);
+	wr->wr.wqe.cmd.stats.length = cpu_to_le32(PAGE_SIZE);
+
+	init_completion(&wr->wr.work);
+
+	aq->debug_wr = &wr->wr;
+
+	debugfs_create_file("dbg_wr_wqe", 0440, aq->debug, aq,
+			    &ionic_aq_wqe_fops);
+
+	debugfs_create_file("dbg_wr_cqe", 0440, aq->debug, aq,
+			    &ionic_aq_cqe_fops);
+
+	debugfs_create_file("dbg_wr_data", 0440, aq->debug, aq,
+			    &ionic_aq_data_fops);
+
+	return;
+
+err_dma:
+	kfree(wr->data);
+err_data:
+	kfree(wr);
+err_wr:
+	return;
+}
+
+void ionic_dbg_rm_aq(struct ionic_aq *aq)
+{
+	struct ionic_ibdev *dev = aq->dev;
+	struct ionic_dbg_admin_wr *wr;
+
+	debugfs_remove_recursive(aq->debug);
+
+	aq->debug = NULL;
+
+	mutex_destroy(&aq->debug_mutex);
+
+	if (!aq->debug_wr)
+		return;
+
+	wr = container_of(aq->debug_wr, struct ionic_dbg_admin_wr, wr);
+
+	dma_unmap_single(dev->lif_cfg.hwdev, wr->dma, PAGE_SIZE, DMA_FROM_DEVICE);
+	kfree(wr->data);
+	kfree(wr);
+}
+
+void ionic_dbg_add_qp(struct ionic_ibdev *dev, struct ionic_qp *qp)
+{
+	char name[8];
+
+	qp->debug = NULL;
+
+	if (!dev->debug_qp)
+		return;
+
+	snprintf(name, sizeof(name), "%u", qp->qpid);
+
+	qp->debug = debugfs_create_dir(name, dev->debug_qp);
+	if (IS_ERR(qp->debug))
+		qp->debug = NULL;
+	if (!qp->debug)
+		return;
+
+	debugfs_create_file("info", 0440, qp->debug, qp,
+			    &ionic_qp_info_fops);
+
+	if (qp->sq.ptr)
+		debugfs_create_file("sq", 0440, qp->debug, qp,
+				    &ionic_qp_sq_fops);
+
+	if (qp->sq_umem)
+		debugfs_create_file("sq_umem", 0440, qp->debug, qp,
+				    &ionic_qp_sq_umem_fops);
+
+	if (qp->rq.ptr)
+		debugfs_create_file("rq", 0440, qp->debug, qp,
+				    &ionic_qp_rq_fops);
+
+	if (qp->rq_umem)
+		debugfs_create_file("rq_umem", 0440, qp->debug, qp,
+				    &ionic_qp_rq_umem_fops);
+}
+
+void ionic_dbg_rm_qp(struct ionic_qp *qp)
+{
+	debugfs_remove_recursive(qp->debug);
+
+	qp->debug = NULL;
+}
+
+void ionic_dbg_add_mr(struct ionic_ibdev *dev, struct ionic_mr *mr)
+{
+	char name[8];
+
+	mr->debug = NULL;
+
+	if (!dev->debug_mr)
+		return;
+
+	snprintf(name, sizeof(name), "%u", ionic_mrid_index(mr->mrid));
+
+	mr->debug = debugfs_create_dir(name, dev->debug_mr);
+	if (IS_ERR(mr->debug))
+		mr->debug = NULL;
+	if (!mr->debug)
+		return;
+
+	debugfs_create_file("info", 0440, mr->debug, mr,
+			    &ionic_mr_info_fops);
+
+	if (mr->umem)
+		debugfs_create_file("umem", 0440, mr->debug, mr,
+				    &ionic_mr_umem_fops);
+
+	if (mr->buf.tbl_buf)
+		debugfs_create_file("buf", 0440, mr->debug, mr,
+				    &ionic_mr_tbl_buf_fops);
+}
+
+void ionic_dbg_rm_mr(struct ionic_mr *mr)
+{
+	debugfs_remove_recursive(mr->debug);
+
+	mr->debug = NULL;
+}
+
+void ionic_dbg_add_dev(struct ionic_ibdev *dev, struct dentry *parent)
+{
+	if (IS_ERR_OR_NULL(parent))
+		return;
+
+	dev->debug = debugfs_create_dir("rdma", parent);
+	if (IS_ERR(dev->debug))
+		dev->debug = NULL;
+	if (!dev->debug)
+		return;
+
+	debugfs_create_file("info", 0440, dev->debug, dev,
+			    &ionic_dev_info_fops);
+
+	dev->debug_aq = debugfs_create_dir("aq", dev->debug);
+	if (IS_ERR(dev->debug_aq))
+		dev->debug_aq = NULL;
+
+	dev->debug_cq = debugfs_create_dir("cq", dev->debug);
+	if (IS_ERR(dev->debug_cq))
+		dev->debug_cq = NULL;
+
+	dev->debug_eq = debugfs_create_dir("eq", dev->debug);
+	if (IS_ERR(dev->debug_eq))
+		dev->debug_eq = NULL;
+
+	dev->debug_mr = debugfs_create_dir("mr", dev->debug);
+	if (IS_ERR(dev->debug_mr))
+		dev->debug_mr = NULL;
+
+	dev->debug_qp = debugfs_create_dir("qp", dev->debug);
+	if (IS_ERR(dev->debug_qp))
+		dev->debug_qp = NULL;
+}
+
+void ionic_dbg_rm_dev(struct ionic_ibdev *dev)
+{
+	debugfs_remove_recursive(dev->debug);
+
+	dev->debug = NULL;
+	dev->debug_cq = NULL;
+	dev->debug_eq = NULL;
+	dev->debug_mr = NULL;
+	dev->debug_qp = NULL;
+}
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index 356ad9fe150f..69e6164e0f1e 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -294,6 +294,7 @@ static void ionic_destroy_ibdev(struct ionic_ibdev *dev)
 	ionic_stats_cleanup(dev);
 	ionic_destroy_rdma_admin(dev);
 	ionic_destroy_resids(dev);
+	ionic_dbg_rm_dev(dev);
 	WARN_ON(!xa_empty(&dev->qp_tbl));
 	xa_destroy(&dev->qp_tbl);
 	WARN_ON(!xa_empty(&dev->cq_tbl));
@@ -318,6 +319,7 @@ static struct ionic_ibdev *ionic_create_ibdev(struct ionic_aux_dev *ionic_adev)
 	xa_init_flags(&dev->cq_tbl, GFP_ATOMIC);
 
 	ionic_init_resids(dev);
+	ionic_dbg_add_dev(dev, dev->lif_cfg.dbg_ctx);
 
 	rc = ionic_rdma_reset_devcmd(dev);
 	if (rc)
@@ -364,6 +366,7 @@ static struct ionic_ibdev *ionic_create_ibdev(struct ionic_aux_dev *ionic_adev)
 	ionic_destroy_rdma_admin(dev);
 err_reset:
 	ionic_destroy_resids(dev);
+	ionic_dbg_rm_dev(dev);
 	xa_destroy(&dev->qp_tbl);
 	xa_destroy(&dev->cq_tbl);
 	ib_dealloc_device(&dev->ibdev);
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
index 7a8e4b59da1c..300d17882db5 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -115,6 +115,13 @@ struct ionic_ibdev {
 	void			*hw_stats_buf;
 	struct rdma_stat_desc	*hw_stats_hdrs;
 	struct ionic_counter_stats *counter_stats;
+	struct dentry		*debug;
+	struct dentry		*debug_aq;
+	struct dentry		*debug_cq;
+	struct dentry		*debug_eq;
+	struct dentry		*debug_mr;
+	struct dentry		*debug_qp;
+
 	int			hw_stats_count;
 };
 
@@ -133,6 +140,7 @@ struct ionic_eq {
 
 	int			irq;
 	char			name[32];
+	struct dentry		*debug;
 };
 
 struct ionic_admin_wr {
@@ -167,6 +175,9 @@ struct ionic_aq {
 	struct ionic_admin_wr_q	*q_wr;
 	struct list_head	wr_prod;
 	struct list_head	wr_post;
+	struct dentry		*debug;
+	struct ionic_admin_wr	*debug_wr;
+	struct mutex		debug_mutex; /* for debug_wr */
 };
 
 struct ionic_ctx {
@@ -215,6 +226,7 @@ struct ionic_cq {
 
 	/* infrequently accessed, keep at end */
 	struct ib_umem		*umem;
+	struct dentry		*debug;
 };
 
 struct ionic_vcq {
@@ -304,6 +316,7 @@ struct ionic_qp {
 	int			dcqcn_profile;
 
 	struct ib_ud_header	*hdr;
+	struct dentry		*debug;
 };
 
 struct ionic_ah {
@@ -323,6 +336,7 @@ struct ionic_mr {
 	int			flags;
 
 	struct ib_umem		*umem;
+	struct dentry		*debug;
 	struct ionic_tbl_buf	buf;
 	bool			created;
 };
@@ -514,4 +528,19 @@ int ionic_pgtbl_init(struct ionic_ibdev *dev,
 		     int limit,
 		     u64 page_size);
 void ionic_pgtbl_unbuf(struct ionic_ibdev *dev, struct ionic_tbl_buf *buf);
+
+/* ionic_debugfs.c */
+void ionic_dbg_add_dev(struct ionic_ibdev *dev, struct dentry *parent);
+void ionic_dbg_rm_dev(struct ionic_ibdev *dev);
+void ionic_dbg_add_eq(struct ionic_ibdev *dev, struct ionic_eq *eq);
+void ionic_dbg_rm_eq(struct ionic_eq *eq);
+void ionic_dbg_add_cq(struct ionic_ibdev *dev, struct ionic_cq *cq);
+void ionic_dbg_rm_cq(struct ionic_cq *cq);
+void ionic_dbg_add_aq(struct ionic_ibdev *dev, struct ionic_aq *aq);
+void ionic_dbg_rm_aq(struct ionic_aq *aq);
+void ionic_dbg_add_mr(struct ionic_ibdev *dev, struct ionic_mr *mr);
+void ionic_dbg_rm_mr(struct ionic_mr *mr);
+void ionic_dbg_add_qp(struct ionic_ibdev *dev, struct ionic_qp *qp);
+void ionic_dbg_rm_qp(struct ionic_qp *qp);
+
 #endif /* _IONIC_IBDEV_H_ */
diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
index 800555eb47ac..53e41b1b3e8d 100644
--- a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
@@ -51,6 +51,7 @@ void ionic_fill_lif_cfg(struct ionic_lif *lif, struct ionic_lif_cfg *cfg)
 		cfg->page_size_supported = IONIC_PAGE_SIZE_SUPPORTED;
 
 	cfg->rdma_version = ident->rdma.version;
+	cfg->minor_version = ident->rdma.minor_version;
 	cfg->qp_opcodes = ident->rdma.qp_opcodes;
 	cfg->admin_opcodes = ident->rdma.admin_opcodes;
 
@@ -90,6 +91,8 @@ void ionic_fill_lif_cfg(struct ionic_lif *lif, struct ionic_lif_cfg *cfg)
 	    !!(lif->qtype_info[IONIC_QTYPE_TXQ].features & IONIC_QIDENT_F_EXPDB);
 	cfg->rq_expdb =
 	    !!(lif->qtype_info[IONIC_QTYPE_RXQ].features & IONIC_QIDENT_F_EXPDB);
+
+	cfg->dbg_ctx = lif->dentry;
 }
 
 struct net_device *ionic_lif_netdev(struct ionic_lif *lif)
diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.h b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
index 18e7c7f13579..500925c429f6 100644
--- a/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
@@ -14,6 +14,7 @@
 struct ionic_lif_cfg {
 	struct device *hwdev;
 	struct ionic_lif *lif;
+	struct dentry *dbg_ctx;
 
 	int lif_index;
 	int lif_hw_index;
@@ -49,6 +50,7 @@ struct ionic_lif_cfg {
 	u8 udma_qgrp_shift;
 
 	u8 rdma_version;
+	u8 minor_version;
 	u8 qp_opcodes;
 	u8 admin_opcodes;
 
-- 
2.17.1


