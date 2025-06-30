Return-Path: <linux-rdma+bounces-11766-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA3EAEE62F
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 19:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7A0178963
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 17:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11452E54AC;
	Mon, 30 Jun 2025 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="X/AV7EXC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2122.outbound.protection.outlook.com [40.107.92.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B607B292B44
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 17:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306294; cv=fail; b=Lz5kjIASzcuZ49o/TEQVaF8tpPLEioDuP4MMiKf5OBiXnvgDT2EcP3TWzZNBhupG1ZhK/K9lF6bxcT9dopq2JJZ/4myWp5hXLpugFQkrHtUaS+0rclz25Q4f44EUcWot2fw6zGx9UbnOf/qgovuPAKnkR0GiPU6HIbOeHhPpjoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306294; c=relaxed/simple;
	bh=snUem20C/qkiPjhh+V6iaPfRxAqBt4vGkMKhddF0fp0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSgNEiNVsif6A3NWf0BOqxo0oZ1ymWf0XdBR2dxK/IAHUtU6Dg/x7K/op3LTweYURQoRfk4Bc5fKPcedXjm0jq89DucfqEsGDuF5NQKuqRzuUR5FQyY38x9BcvWGoQSL4mqooPXq65soZNxzrGbdG8WwNU8A+Ilw5kwR1+0RA/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=X/AV7EXC; arc=fail smtp.client-ip=40.107.92.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0NAQnu6IlEjAirpKQmFrU6SS+yiXQIemOt6zTNrzlfEOhfFYiu8ILElJD5oGm5PkU5yMSVZ++RrIN+Nap5OPWidvHYOuKUf/m9k/kTmk5mZWVWwST3H3DuR9HdVUZ7s5qzAhVH+q7qVAm+DDHJXoQsy+l0KQV05bOWQcTlwdoCWc6k3KZKQZmIFiTpbDETsHwqwl4+aiTKlWn2F/EokOzlnjQa7zDtqGEyaNOKuyI9Bshqy0awQFTlawPxQHDCrf1zHoOXXIMgvPJoA1L4QLrEPLR5il3Tmfcf7sQ3m5nYr3JWG33milCVYe2ezugGUITXuxSwRo3ckmLwYc4JRIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxtI5nAMUedrp8PHeIoWkWtv43LW6UIyy4VTd10NJFQ=;
 b=gU6MQkSfBmUepiNtGwXyxCtWthG3QUOA2FG54zYVda0qKV+m5se1A6hlxrTZTr0M/6Xuz2eKdIYb8OcUK9wup9M0JPliBJdI9QTT2ZBq1hVarb3NgEu7X985yZQh15ozX7txpnxHf7yBrSwSv/cz8qBtcJ2PYuYxsegAi9XZyLQjc6/zoZjxNONiNh9xHkNfs1DufRtgQYkceiSX/7PA9umhgaVWF5CVgIQVuN1HGolYsjgzsRxIz0YsMXseBRy3ohRpnJQokRg0XKn59gdDOvhEGhOEFEukseqFqtlBhlIacLmT4NIvjdteouM7bRNE7K7ojeL5AkgdNigV7mlaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxtI5nAMUedrp8PHeIoWkWtv43LW6UIyy4VTd10NJFQ=;
 b=X/AV7EXCooplJe8X5jUt9qEXyjIjVGB6SJNMnaqHa0nco18m0YizCNJmBzyAtAct+FjIUBFsl3T5dIHJlBAzg4cSF0W2c/zit6FMRAIkWKJB/gcAVC2+mzBf+7uUFyPooeFCAOIqjN4A/cxEllyn0UTVssS+u3A2fP9GIm030XZme7MkjLIFJmyPDHKriM7RruIgHZcMcZ2g677BQYrQwoP60BvbByuO3qBgHwpPr7wtHyY+d2Bio+xUvEUJ6uI2mThDP2YAfPuARpQ5SRvflN+izWwRfx9W5RHV1n8NAmgrjipLRR5fqQFQ6JTzkZjABkfAQNKAZIjYum8JHBWuDA==
Received: from SA0PR11CA0192.namprd11.prod.outlook.com (2603:10b6:806:1bc::17)
 by SA1PR01MB8624.prod.exchangelabs.com (2603:10b6:806:38e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.30; Mon, 30 Jun 2025 17:58:08 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::c0) by SA0PR11CA0192.outlook.office365.com
 (2603:10b6:806:1bc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Mon,
 30 Jun 2025 17:58:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 30 Jun 2025 17:58:08 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id C0BA314D71F;
	Mon, 30 Jun 2025 13:58:06 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id C50E71811CE6E;
	Mon, 30 Jun 2025 11:30:07 -0400 (EDT)
Subject: [PATCH for-next 04/23] RDMA/rdmavt: Add driver mmap callback
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Mon, 30 Jun 2025 11:30:07 -0400
Message-ID:
 <175129740775.1859400.14288398945361388150.stgit@awdrv-04.cornelisnetworks.com>
In-Reply-To:
 <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
References:
 <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|SA1PR01MB8624:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef9284b-7722-4929-d109-08ddb7ffabe9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFpteVgweWRpOE9xVm9tQW9WNnU2L1dzSURDaHhpVEQzQzJMQmxYSnJ3dHRM?=
 =?utf-8?B?My9TbHhuUzF1YWVYRC96RktxTVBmdjY0M1UwOEZkRTJ1eWdDMzErTUZmdDE4?=
 =?utf-8?B?bUNxWmhLNU5PbFY2WHl4QWJYRDZ6bHNSVlQyd3c4STFwdnRNS3ZJUmphRkkz?=
 =?utf-8?B?MVhud0pvZjZ3RUNMNmRVTFRTNW02QVBhRVlLU1pZRnpFczdjdWQ5bWxpaTVk?=
 =?utf-8?B?N0pIVTlTL0RKSzh4T3F4aUtkMG5yc1NTclArOFlZMUJ0WHZ3U0YzVy83dC9n?=
 =?utf-8?B?aC9obUVUb1BqNTc4U2hsVTJveXZtb2hibnZ6RGlVTVFjOXE3eU1obHZodkgz?=
 =?utf-8?B?cGc2QTc1dURuZDFCVXI3OHU3YkFTc09SRTRqb09tYVd6MmlLMDI1eVpJaFpU?=
 =?utf-8?B?NzAxcEMwUHVyTWpvV1RRRmpTMzRNemg5NnhKYVQ2RWd6c1hJTjIzVitZZUY2?=
 =?utf-8?B?U3BDZGRLVkoxTGgvY3U1L3pxM09PcFRBc01XOUFLaVUzbWFheGFoNzM4NkY5?=
 =?utf-8?B?K09xa3Rwd1lSZWlwRVNNd2FZcEJFQWRnN2lYMytKTXBKVnNRUURLYS9FbHNx?=
 =?utf-8?B?TjJNSFhrZkp6aXV3UDBRZWVhN2pnNGdlYzNuVE50NGpGNG4yTmVTQ3FCcFVs?=
 =?utf-8?B?b3piWERDZ1hNaGhDWmJVemtJZkNDQ3c5ZDJGeXlmRkZZY04weFdPK3VPeGl2?=
 =?utf-8?B?UzVMZ2ZNTzk0dUorUFYrYWZDR1FtVTRtMm9JcFE5ekprYUpRc3h0YWdFOFdM?=
 =?utf-8?B?TlVJazFLTWxIRkdTUTRtRng5dmtzT2E2dmtsNy9BUk1zK0pORlpLeU1EUy9M?=
 =?utf-8?B?K1UxSFBZRGkvRDFXWlpSTTVEbjhkekY1L0pYT1RtU1NCS3VEcm1wYnlsOEZQ?=
 =?utf-8?B?aXBZNXV3eFZ0Q1VvK2twRkdQZWM4RHl3QjZUYy9sQU0vMDN4NTRyVkMyS0kw?=
 =?utf-8?B?VVNsNW1Ta3BQT1NMZzlJcTZDR2R3aVRtR01IRHM3RzhUU2kwajkwbVBIS3JT?=
 =?utf-8?B?c3cxbkJ2ejc2blhKZnNranVLRUZwQnA5SVRiTE9FSjV5cmtzWUJqUythNTJS?=
 =?utf-8?B?MnlFQjZRbnVhN0dEU3lGdHRLbStRZmtRUnpNZHpFNjlYUVlpUXFJY2xFcUlr?=
 =?utf-8?B?NFZlMEdXQVB2NzdiRGFycWtoZ2k0bVpjbmZtUzJZVjIrYXVBanJCQ2Q0SEJQ?=
 =?utf-8?B?bnJOdisxeDEyeGMwbXJmR294T3BkdzdLMmx6alZNQlpzVnJFd0h4anVpeE5U?=
 =?utf-8?B?dDhoQVJQUVk5S0dHSEo1WVpuMktyTUY0Z0FZd2p5Mk5xWWdqaHFqQzRTUS9h?=
 =?utf-8?B?Rm0xbHpoZWpLUk5uTSt3T3pOQ0xRcFJORlh0NnF0SHI1WGhLNU4ya3VGMlFo?=
 =?utf-8?B?ZG15Q0QvOE1iMEsvNlFpbTU1bHo1eUhVeFNrTXZTWVF4R1RhSzNaQ0g1cmZB?=
 =?utf-8?B?aEQwMDVtd3BLR2RZc2hhN3ZrSldKUEdOVWdIOTlOMG5QTnR0anIwQkhRZGd2?=
 =?utf-8?B?NW1JQit1L25BYTRyRHM1TWhHUVlCb2NzeDVQUGMxMUdMRmNRNlRRZzVzRElN?=
 =?utf-8?B?MXVtdmN5WVFoazcxeDlyMURCNnlYenBGMnU4US9ncEFXRHB2bDVoUUdRNWtM?=
 =?utf-8?B?SVZvS3Exck1FSE1ZWEtpUGNsbzV1ZXgwUW1qZlhEUVQvTjAweDJEaFV6cjFE?=
 =?utf-8?B?ZkxsMjU3Sm9QWDVkckpaRUlpYnpseE9WR0FnVnFpamtkdDhEbllxYkg4a1Nh?=
 =?utf-8?B?Q3JrNlo3bW9uZFhjTkdaSGVwOERXN05MSzJNTUZPR0ZhaHhRSG10NUxkVWZ0?=
 =?utf-8?B?bkFrSHRMdkp2dHZoeS9EMVVMS01rK2NoQ0Iwa2RJcjVZOWxLSTI2b1ArRFpS?=
 =?utf-8?B?ZHJ0aFVIcXR0YS9RRFZmZEZ1c0hkVTFZQXdwWHJnU01VU0c3VFFpY3hFU3Zv?=
 =?utf-8?B?NmRNT3l3UDNrbFRZSU1wY0tPSmFmNHp1SCsySG56eFJZdlhzSUNpMzgxWHh0?=
 =?utf-8?B?dTB4bXNUV1RJL05FOEd5b0t2Z3JNWHVPRTR4OXc0SklJRFZHR3huTzljK0lD?=
 =?utf-8?Q?E+kGpO?=
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:58:08.3958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef9284b-7722-4929-d109-08ddb7ffabe9
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8624

From: Dean Luick <dean.luick@cornelisnetworks.com>

Add a reserved range and a driver callback to allow the driver to
have custom mmaps.

Generated mmap offsets are cookies and are not related to the size of
the mmap.  Advance the mmap offset by the minimum, PAGE_SIZE, rather
than the size of the mmap.

Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/sw/rdmavt/mmap.c |   22 +++++++++++++++++-----
 include/rdma/rdma_vt.h              |    3 +++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/mmap.c b/drivers/infiniband/sw/rdmavt/mmap.c
index 46e3b3e0643a..473f464f33fa 100644
--- a/drivers/infiniband/sw/rdmavt/mmap.c
+++ b/drivers/infiniband/sw/rdmavt/mmap.c
@@ -9,6 +9,11 @@
 #include <rdma/uverbs_ioctl.h>
 #include "mmap.h"
 
+/* number of reserved mmaps for the driver */
+#define MMAP_RESERVED 256
+/* start point for dynamic offsets */
+#define MMAP_OFFSET_START (MMAP_RESERVED * PAGE_SIZE)
+
 /**
  * rvt_mmap_init - init link list and lock for mem map
  * @rdi: rvt dev struct
@@ -17,7 +22,7 @@ void rvt_mmap_init(struct rvt_dev_info *rdi)
 {
 	INIT_LIST_HEAD(&rdi->pending_mmaps);
 	spin_lock_init(&rdi->pending_lock);
-	rdi->mmap_offset = PAGE_SIZE;
+	rdi->mmap_offset = MMAP_OFFSET_START;
 	spin_lock_init(&rdi->mmap_offset_lock);
 }
 
@@ -73,6 +78,13 @@ int rvt_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 	struct rvt_mmap_info *ip, *pp;
 	int ret = -EINVAL;
 
+	/* call driver if in reserved range */
+	if (offset < MMAP_OFFSET_START) {
+		if (rdi->driver_f.mmap)
+			return rdi->driver_f.mmap(context, vma);
+		return -EINVAL;
+	}
+
 	/*
 	 * Search the device's list of objects waiting for a mmap call.
 	 * Normally, this list is very short since a call to create a
@@ -129,9 +141,9 @@ struct rvt_mmap_info *rvt_create_mmap_info(struct rvt_dev_info *rdi, u32 size,
 
 	spin_lock_irq(&rdi->mmap_offset_lock);
 	if (rdi->mmap_offset == 0)
-		rdi->mmap_offset = ALIGN(PAGE_SIZE, SHMLBA);
+		rdi->mmap_offset = MMAP_OFFSET_START;
 	ip->offset = rdi->mmap_offset;
-	rdi->mmap_offset += ALIGN(size, SHMLBA);
+	rdi->mmap_offset += PAGE_SIZE;
 	spin_unlock_irq(&rdi->mmap_offset_lock);
 
 	INIT_LIST_HEAD(&ip->pending_mmaps);
@@ -159,9 +171,9 @@ void rvt_update_mmap_info(struct rvt_dev_info *rdi, struct rvt_mmap_info *ip,
 
 	spin_lock_irq(&rdi->mmap_offset_lock);
 	if (rdi->mmap_offset == 0)
-		rdi->mmap_offset = PAGE_SIZE;
+		rdi->mmap_offset = MMAP_OFFSET_START;
 	ip->offset = rdi->mmap_offset;
-	rdi->mmap_offset += size;
+	rdi->mmap_offset += PAGE_SIZE;
 	spin_unlock_irq(&rdi->mmap_offset_lock);
 
 	ip->size = size;
diff --git a/include/rdma/rdma_vt.h b/include/rdma/rdma_vt.h
index 8671c6da16bb..7d8de561f71b 100644
--- a/include/rdma/rdma_vt.h
+++ b/include/rdma/rdma_vt.h
@@ -366,6 +366,9 @@ struct rvt_driver_provided {
 
 	/* deallocate a ucontext */
 	void (*dealloc_ucontext)(struct ib_ucontext *context);
+
+	/* driver mmap */
+	int (*mmap)(struct ib_ucontext *context, struct vm_area_struct *vma);
 };
 
 struct rvt_dev_info {



