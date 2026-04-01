Return-Path: <linux-rdma+bounces-18896-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCH6C7/0zGl9YQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18896-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 12:34:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD99378944
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 12:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF57030A35E1
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 10:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BB23F166C;
	Wed,  1 Apr 2026 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NlCH7LfL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013050.outbound.protection.outlook.com [40.93.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F1C3EF0BF;
	Wed,  1 Apr 2026 10:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039151; cv=fail; b=KijUjmMw80EWB7UpV8K9Kylm4BTHJjPaDpNMKwzIZzMxSdUKb2MGz1Z78HHHgdmiaRAJS1Dk96ctVhCG4hpojsxpUYTzGOsLukU97U2kvIOwcKD3LH0I3eE4dQ1YfqMXutFV9PE+bhsGIoc2sB1tUSBhWlI08lJxsZ4gFBS7OWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039151; c=relaxed/simple;
	bh=YM593Yj0/u+q8pFCAOh84dZA/nnCwup6Ez+9Hv2Jgbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kghfj8ka5Bx574QruQKiUOCrQMhiA3Fr1at/V7iR2veyFOl27U3sxXZzjbMBv/aQ+uJhptXeWZbJ72qOfXdJotDVNlHfJ+eNBjz3IPXJUYXFFtoM9yKdq0h6VP1jnZL4wcJdRehj8ulMeGVTksPH4TF87U4G1ybYdGmpryV2OXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NlCH7LfL; arc=fail smtp.client-ip=40.93.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GT4oWocvRRzVAVfKmt9gDvDFjpUHmAzWWNi27EJwIRRXdt9QZbyoVVKP70Y0Y3bZ0J0vNObCS+uySd7KAjKTpnkNRbFVQAS2XWYoNJxQ2T5Rg93SnG6cmTp05ffvH87EjVdEI0Om8vB3zLjtizDYZbLRtBpQ0bxjBuw29V+OeqcgVG4OjCYNy8gc6Vpgrpe9qRNFMBTONttaPtlIh2FhQFiaE6J+vVo/yqLZpvHc5wD0QOamOwiWCLKDYsTGv4PPayqLtQS8J/bpApHXbzZn77iQ19waRCyLAWoD/geZKg9p/WWU4xXY0QP9xlxg6uU09hJ9BtFf5FOKEZ1MjttK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtgvuNnxX8uBnrE8lndR6+yAHZgPnS5EJ88/sKA0P/o=;
 b=mMQalNh0jfgk0U8GXMUgU6rTBl9n1s3EIeCyIlYwsJC5hSWh3csfkSXljJ/97Lp9YQiOjXQ1aT9qLUoPv7LJI9U2/aqgMm1gkavnT2ReHr0Iiby9S2hcXjFLr9YahnMuD3ZM2Aq2UeLuftaTJ2rvnFqU0pzgTUz+KNMWYsmWtZAUBYxtbgsl3k69jqDRxNu6QikKUrHD3q8HKGMdaNFi/VkHzLqnBauWJixaPB2jsEwohwRicoLbPA4qjnpNohnsfmxc3dsPUmXrWo+4rnkkCpOi6tCR6lcvV9AsYDOKnzslu4W2gg+BzuXrFq3Xkx6PIntziTBygnfIlXrQDYa0Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtgvuNnxX8uBnrE8lndR6+yAHZgPnS5EJ88/sKA0P/o=;
 b=NlCH7LfLdFdtUIPSOld9aKY/OQ9pd3gidDq/3878Y25aqdA787E7mf8u6qzKhp4E3qtka7J62CWBb6vzow9PlWVfW49IjwDUTNqHsRqMGuPM6PMVDOces0a+1l/874IZ1aQSk34+V0oTZin7Xm9Bzc/Sc0v19r/dUWuSHD1wIrM=
Received: from MN2PR04CA0006.namprd04.prod.outlook.com (2603:10b6:208:d4::19)
 by DS0PR12MB6631.namprd12.prod.outlook.com (2603:10b6:8:d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 10:25:45 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::d2) by MN2PR04CA0006.outlook.office365.com
 (2603:10b6:208:d4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 10:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 10:25:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 1 Apr
 2026 05:25:44 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 1 Apr
 2026 05:25:44 -0500
Received: from xhdipdslab46.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 1 Apr 2026 05:25:40 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <brett.creeley@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH 3/4] RDMA/ionic: map PHC state into user space
Date: Wed, 1 Apr 2026 15:55:00 +0530
Message-ID: <20260401102501.3395305-4-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401102501.3395305-1-abhijit.gangurde@amd.com>
References: <20260401102501.3395305-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DS0PR12MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: ec84f319-9265-4563-46f5-08de8fd908ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pjpx/WyUYvecQcUs4/Q6qRmkYFL9iNQ2jd3tk9YPffKOXiYjQtIg+lx6SDABaRb9rzlQo8qguCWgQciE86QbzrvIUR5bFLCqJlqb7RQYCW4mvNe5G33sSB81xS7XsrfUFEZCzjdtbXOQJRgKeJyhdoy5/0YthQeBUDHPxovCB/7qBBTnooAN2zvkpc0pYyvFfqvKKMgd1Qh8k0VTPEkXJIJZAUbbevcdAzbPRz8Doo/G8oIhjQ6VoJ98YlSGyMTSEb72zWrxqqzhuTEVS2wfFKyUItSQs4aQYtqavougJc57kDe1MoJoq4TEQvAdBE864UoSMmzs8W3WqGXRimLLq+orABrgTToMDpYdL51nuWCgmqim+/ZbfxSxTGS1auwcLDN1GtFkrpKzFX35H+5LoZw0Fdzl/amdA17TNcFcakNBDjFNZU5n+iyqq5LyfrgO84YNK6hO7WvQA5J++IWMs7xUvEkwIUe/d5cLSpnv3NU8TlrLx9fEBmZnJJNbRLMLNYnxQCnhRHEZgs6m/pBZxS3GMUgZHjeghSX87Pi48+eN+v9jlfBBcYjw1iBs8nHuZS4POZKfI//8vgqDGaOvgvlSDSAMIbMcoGFG6uGgF33YwRdaDRAC7ppoDR3oxDrO0RwPf6gkk+cJWmXHm3KkHuK5MO/XgUqAhGyVWIF4m4nADxgbfLt+1YSM/1Qz+0PBJvms3h2aknwiE7i75JxkCZmU124kFm0xkd6+o4T4Mj3Kmx3t+gnGELRLvWvcEVSo6yCqq7PwCl27/kE9JGORiA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8t5S1SxCtS3oT/lzkteX+42o5u3FPO8EV3VWgydrqUHprNFZNbXOKN7lUIzQTaWdkvVjD03iVy3rz1/eBumSknGu3ylgbofpwpe6TCitw12N2Km8f4wss+Z7ZsmNmEAaEYfHMIJUzP9BlzFnKZ2SYf82jz/a2GYhj/uh210RkVNe5NVcMd2apkLfqwql0TEoDN/28VyxphD0/7Sbjpn/MTyw0UVv68zIa+t5C+PA+a9Tw5vzm7CAkoYz46Icii/aa5ZdbZbUJ+WVnaU2jV00xhnLmNV1kecA/Oacoshw50TfAg3mjS2qO4aDgYnC1k1iKIC22JdtEObZU5+DqKrZ6mM95ddZnWxTbFvfQXxd8WwxLxN2ztw9tRv/I2YzrIy60pDAA7lxz2xlL4ptcKA8kQYaxQGHdUdm/uAkEy9b96k6QZS1PNEwfVNZZj3/xegW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:25:45.3042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec84f319-9265-4563-46f5-08de8fd908ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6631
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18896-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhijit.gangurde@amd.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CDD99378944
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 .../infiniband/hw/ionic/ionic_controlpath.c   | 36 ++++++++++++++++++-
 drivers/infiniband/hw/ionic/ionic_ibdev.h     |  2 ++
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c   |  2 ++
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h   |  1 +
 include/uapi/rdma/ionic-abi.h                 |  1 +
 5 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index a5671da3db64..5a0b189f9855 100644
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
@@ -414,13 +424,15 @@ int ionic_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 	if (dev->lif_cfg.rq_expdb)
 		resp.expdb_qtypes |= IONIC_EXPDB_RQ;
 
-	rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+	rc = ib_respond_udata(udata, resp);
 	if (rc)
 		goto err_resp;
 
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
 
+static int ionic_mmap_phc_stage(struct ionic_ibdev *dev,
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
+		rc = ionic_mmap_phc_stage(dev, vma);
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
index f3cd281c3a2f..e3f2df1f9e6a 100644
--- a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
@@ -40,6 +40,8 @@ void ionic_fill_lif_cfg(struct ionic_lif *lif, struct ionic_lif_cfg *cfg)
 	cfg->dbid_count = le32_to_cpu(lif->ionic->ident.dev.ndbpgs_per_lif);
 	cfg->dbpage = lif->kern_dbpage;
 	cfg->intr_ctrl = lif->ionic->idev.intr_ctrl;
+	if (ident->eth.config.features & cpu_to_le64(IONIC_ETH_HW_RDMA_TIMESTAMP))
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
index 97f695510380..abd1bde0991f 100644
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


