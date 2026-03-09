Return-Path: <linux-rdma+bounces-17815-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GvgOYsxr2kYPgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17815-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 21:46:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D602410E5
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 21:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3D68304B8F6
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 20:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA913101CE;
	Mon,  9 Mar 2026 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="MWapD+2X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022082.outbound.protection.outlook.com [40.93.195.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECFE13AA2D
	for <linux-rdma@vger.kernel.org>; Mon,  9 Mar 2026 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773089109; cv=fail; b=euWkSrpqV6kFLI4iPzAOUqSWWcuqFn64vASlKD3EjNLh7i8+380CCu4NUwonekvZMZQWeciVYmRgnlsE8O8dSpmDwwcrkfrw1EsuOhp0GnhrgnFR33Dv3PiSf5SxqEO+eXwimLsYsL0Ud0mzpHTQEBw0p6hZJWCvhaGhO0ANBTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773089109; c=relaxed/simple;
	bh=snUem20C/qkiPjhh+V6iaPfRxAqBt4vGkMKhddF0fp0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebH9XQyLVxflRPnSBBkMoNrEC9h3uAdnECqUSGqLZYOn8JenYtulUWVz4xSft3MePiRhl219GpgZhYgBuvfRG0PO+MSGXVfJmcK8xB9yi2al3IgdaicErrjzqIhK0FO+vpEieuxdl4Iggzd8kt0SDXfoRjCuY7/G99Ks1wA0ZJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=MWapD+2X; arc=fail smtp.client-ip=40.93.195.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWKzMDzmF+oRtiyDTIvILQYpnkLF4OIQvsIfnG+0LORJwLBgvoutbgW7XpxXn4n2gnzrZYKvFsEw9FxwOGu1DinyxsYn9xRh9uJ7KAh1sZ8r/R6jxcq8cNU/bJVVZBEqkpmGJu3Aj4rsoTOvOowdZgUXbtU+VMmmbfxzPy5CdejggapbZWTGKVTulFUGhUiWj/nR2p3o0iQnLU6gHDNzLFWRkuMxkdjy7oofGNyVKrMSJSffrMvP5d7EvqzJ927ncPq75s7mnnAFg2ONMtYfrSxxyRUt2Fc6xODQuz3yArCqKwzCs1zLGe79i/Y19rhXiITLf7Y3Bw4cg2Qmyg3xlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxtI5nAMUedrp8PHeIoWkWtv43LW6UIyy4VTd10NJFQ=;
 b=Q41ArILDozoIOJ+0jrlAsLbgNc9XKNPNxMhOfnhCUgWOcXcETv4yzE1JJmHcU7XRquXIkHdr5QiiveOlIJxmOM3gz+v2YXff2MAueRopwnHvSb9rV/s7m7mFZ0CIHsfcu5XiCiR9DSWhbsJ4rG2G3E5fcVj/GL5w9jNfq5ILwJQbrlSq/+9RcCjF1pCsUe4lcZJsAy3ODRFy3UGk4WWu4d2/x2uR/p3EvrpgfmegF8PfWISvCS02a11ze6GNQV8HfrYRmvZrwZ2tjg3vAhEq6K9kkGHM5YbXRFQRe7Sea+u5DsSPdiV9B8ZE6PC65u6WMBJHLlr1hOXH3OPNOi/X/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxtI5nAMUedrp8PHeIoWkWtv43LW6UIyy4VTd10NJFQ=;
 b=MWapD+2XmeX8C+QzfyV5EKaIJ4t6qyuqA6646edt14f/cMUZVPDuW0Vwr8bHgkQphxKEh0qbQgIw/t4BpuaU5ENMQC69tkbK0lcCgTsZFgyfsNvbkHvd9el9AtX0rhaEqdq3jLjTVw53D4Zu8pt3A817nbDxpjtsZte+qqRjyUfREi4/kl73bmu5TXfeoB6xJvql8cyTAaK2NS/NvMVi5VXMzzRQCSurPWZ+zqccBKqY+0Bdni6Nq2F7HbsoOjht8nD96bQrwmI1obBzX5mavewi60bqpCM8ZVPKRZ0Hc2XpfO6Upt3q2itHmgSLaGjygBwoEWQa9nKDbXjSe/wWtQ==
Received: from CH2PR02CA0028.namprd02.prod.outlook.com (2603:10b6:610:4e::38)
 by LV8PR01MB9260.prod.exchangelabs.com (2603:10b6:408:296::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.25; Mon, 9 Mar 2026 20:44:57 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::5f) by CH2PR02CA0028.outlook.office365.com
 (2603:10b6:610:4e::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 20:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Mon, 9 Mar 2026 20:45:00 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id BDECF14D715;
	Mon,  9 Mar 2026 16:44:59 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id BA32F1810D6D7;
	Mon,  9 Mar 2026 16:44:59 -0400 (EDT)
Subject: [PATCH for-next 4/4] RDMA/rdmavt: Add driver mmap callback
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Mon, 09 Mar 2026 16:44:59 -0400
Message-ID:
 <177308909972.1279894.15543003811821875042.stgit@awdrv-04.cornelisnetworks.com>
In-Reply-To:
 <177308892140.1279894.3475429390519673020.stgit@awdrv-04.cornelisnetworks.com>
References:
 <177308892140.1279894.3475429390519673020.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|LV8PR01MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: ad945f11-5995-4376-12c7-08de7e1cbb88
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	fy4vcNmDYjuRwKQ0uaCwQBGUIeHELF3L4Op95tz9XRjEjSyoPg8IRYRyNyM9DaiFk7sSwdT6B/EARHliJVidwVZeYulE0OYsoZx8fCMmniZpqyyTMGPVZwR1ZyfxSGao9nBVy4YIW2O0ZDkd0EnulCWbN7Nw28XUUC2q42I3+41B+czE0adFtfV2jEOq22wRByjMnxdEE0rknasFfE9d4lshdBvxC/sSsC+raR0f8+wPZJwOiDJUfcM4g1EgbIG4PB0SczjQuCiAChyA8bwkQoxfFxSeljhTjEqw3SnYh0EN7N/x63fjZQRkOj3slJrdepjgltNbRDFdXbR7ldlwolaMy7XhsJOoIEOpJ3YTACP2rBgkzPMSDbEfLJhfMRWfPkRyPlD1I9hZaRraoOex2VqGRU1eskw3Enow03FI6cZF76RWhZgLuJ1UFC62eKxzGxf3dlYPTDajP1exElkBr/wNgblzaDqUsG6i7SZ9QLxp+mlfqoqdv+qNoBxiy2ZpEMR5sLgb1VtGXvrk20nAi6RSWKcvfcDdOeqfObxn1obEayMPm7legl3EnV26SgvxoKeesvqxPlvty0L1YsDrNeYzYcg73G9ZGVQDv5s7nOtNYj4so0yx167EactWGtYLE0l4mbY7kxT3AwRIKoavm2AhYbkBjpotF0zhIry5/6/cTHg3YhKvjOJnAsHWLt/lsIIK2pxEEfghuGbUpRGcMaEkj+i/SZU0YHFifSrsM4mabPLXVwBV78fYxZz4P2YRvb3iY+9SxkxD5+C4+S23jA==
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Gz7gB1DWS+2YxsWgqvztVJaa3zV36w8j0/xIGZ177LjcucOjN2vliaWlXDNPS36njb7qUERbTMsenYuu2LAAlZWZGwfCL19d0tdteOjUuc/TYHAt5Saq3rMoJ+MozTxvZ3UUWFeHCJfv+dAHqH6H6/mCjmefodBHANvoGk0BNFh7WKbC1MqJZUMjAn06iSH5TjrLRod/aepYeh8n0UU/7kWs29qn/1FE0f3ews3E4vfNrDNu1/0qDAJC4AYhAWebW6Nkg/rLt9JdkqbhdFCWnkjGI022KA/hEn0biQUnnRfcQjBzIaRV6w6iZG9187pwh71H774zrl+yq2hIcSl5RS3tWsLojBbX5MmI22LXW/dcEbZgAbtPXSECIE+zu8diYjQ4DbSIDpp3gWeX3RJ8Kro7iCoBntxcWBY1IDGrBI4QQmSXNkh8MbzXEn700Hjb
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 20:45:00.2595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad945f11-5995-4376-12c7-08de7e1cbb88
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB9260
X-Rspamd-Queue-Id: 37D602410E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17815-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cornelisnetworks.com:dkim,cornelisnetworks.com:email,awdrv-04.cornelisnetworks.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

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



