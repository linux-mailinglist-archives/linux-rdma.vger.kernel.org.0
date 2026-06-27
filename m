Return-Path: <linux-rdma+bounces-22533-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fo1iMNj5P2qpawkAu9opvQ
	(envelope-from <linux-rdma+bounces-22533-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 18:27:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F926D2443
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 18:27:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cornelisnetworks.com header.s=selector1 header.b=GZAF7yk7;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22533-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22533-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cornelisnetworks.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D06A43004F21
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92CA2EFD95;
	Sat, 27 Jun 2026 16:27:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021091.outbound.protection.outlook.com [52.101.52.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71A82EFDA4
	for <linux-rdma@vger.kernel.org>; Sat, 27 Jun 2026 16:26:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782577622; cv=fail; b=cK/H+Z3QfMib2eocaZ88EI+xtmeky3KleiMrVkiBo6B9DZ2FRz8SS3orMwMDDQqXqsrjCs38KlkpvvJZo/dL36VPw9df78oAxlLsUnazM60kQDVXG7nbJSj0F2CnqDC6A9zJk0uRhtB0/5RkExWtUrS3dW+fHmlAobt9qfFCK0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782577622; c=relaxed/simple;
	bh=aYvws7P86tRrwoHZArkmBy2ajwaWGjNyVs4JSijYHcQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6pmm9TfnSyCpKuFrMOwDiUdpcRjKX8xaaxdT+BsZLZpHkpmEFpBm2UJr9Qk6cvl0Q1g9jwhiJXrr7kocOC46DTU3iAIwqdyR5TwcMHf6zmCR32ZMyGMUsCYQHvprUfV8l4ZNEFHzgNJhJfy8+5ylPVthndy9BXOrT4uuSNUgBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=GZAF7yk7; arc=fail smtp.client-ip=52.101.52.91
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LycMDWb3R/+TMAcBpEiltS9/lAkxfiVPQ9AQZf+Qw9TYquVJWWUqzYHG9bNbbQJjDA24dygQBJKDcKFM7aSpshdSA8wveySxg82e41XG6EZPcclOBXYIhqIvBON61n27iWoqh3gnC9OO68O96h9q/KNw8bYaNY9VaZzyQ4oWOOki/MAOgJ7V9b4d8RdR/42qrLOkKJ1dD+S045QSHbJWG1OZ/oEBrnG5AnSId0sRpYs1YuPK+hF/cNQ/s1xKGcIvIHyVaWomMrkeUm/Znx9PUbnJzxgYV4MuOPCYz+8069q98cwKjDGj+YKMnYJnQ1mHPPNmCW8nGea2LG93VNX0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jozylsm3mejPQD8/qViRSi3XXMj5AnjXtiCd1GNfreI=;
 b=U+UsYtsEZokFWvwV1YV3ryJLmrVJWUDgvSaEp2vUfX2HaKMmA76m1YWq236sB5wYllEeIipjwy79lyD8DCBhxJheFkDT4+EUbN5LqFWRHTkNxzGhNsddN77kvtXV1sLjAcCQw0VNOrbUQCLUXQrxfHaK/gQeNlV8HnDnJLk/afIvnbZIzBCjUHomcAR7PAWxvv9H2ZdO134wv7kYAHlJLCl9fL6NWf8P1fPtPhZ/DK91Xy0Qwjrqs0sVtCPldKAWe575FESCqNDysBdt4lg6xENPgkzdsAn0TWMHw7j9Shxma6v9qMsUlxVtTPKBHdEvd8hxRI7rwZVrO6aQk6KvDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.148.235.34) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=cornelisnetworks.com; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jozylsm3mejPQD8/qViRSi3XXMj5AnjXtiCd1GNfreI=;
 b=GZAF7yk76Pc3YtVmqsO8nhx62BtZOrjyxXaCvoW6JQfAaYvspkiajGtdsQ5hwKZ4tMid0puZsxVVosSKBCPaSviP4JP0bURpN1ZhAmFrG/ZTyZSzLZWZRQ7rzsdIY7DgPtmnlPx4q4zMl+PbMQpMcpRC8bPnm+4xsXNRoGB6eJYC6ZI07nGkTdtID4tljGvW9bxKpiBzq0RNn/usU0y3sWel8VFttN7Pc77JkHtVBbZzHxAvtdR5b7gL6sNoKUiX+bjQN56MuRLgjj1JThvO0eBGQ4ZuynfyRQpvNYD0TOyEykooALGD/vUHsvzdUpuv51X3JSjqmSk5t9JTXqF6JQ==
Received: from CH2PR08CA0021.namprd08.prod.outlook.com (2603:10b6:610:5a::31)
 by PH0PR01MB6342.prod.exchangelabs.com (2603:10b6:510:17::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.18; Sat, 27 Jun 2026 16:26:52 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::3e) by CH2PR08CA0021.outlook.office365.com
 (2603:10b6:610:5a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Sat,
 27 Jun 2026 16:26:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.148.235.34)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=cornelisnetworks.com;
Received-SPF: Fail (protection.outlook.com: domain of cornelisnetworks.com
 does not designate 50.148.235.34 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.148.235.34;
 helo=cn-mailer-00.localdomain;
Received: from cn-mailer-00.localdomain (50.148.235.34) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Sat, 27 Jun 2026 16:26:51 +0000
Received: from awdrv-04.localdomain (unknown [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id CAB96146565;
	Sat, 27 Jun 2026 12:26:50 -0400 (EDT)
Received: from [10.228.212.218] (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id C5AF11810D6C7;
	Sat, 27 Jun 2026 12:26:50 -0400 (EDT)
Subject: [PATCH v2 for-next 23/24] RDMA/hfi2: Modernize mmap to use
 rdma_user_mmap_entry infrastructure
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org
Date: Sat, 27 Jun 2026 12:26:50 -0400
Message-ID: <178257761077.371918.10395526634276702355.stgit@awdrv-04>
In-Reply-To: <178257721001.371918.6610421101075283586.stgit@awdrv-04>
References: <178257721001.371918.6610421101075283586.stgit@awdrv-04>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|PH0PR01MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: bc0ebb4d-bf3c-4a15-495d-08ded468e4bb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|22082099003|18002099003|56012099006|3023799007|55112099003;
X-Microsoft-Antispam-Message-Info:
	s24EhRkX97x/Y7ewtlBYPuhfx2Op6PxPP35WP/e4V9tSfh0JeOIKIX61wik8jjYUOo5IuIz2l0/t4Bz1C6JFZrQqce78VBANQ+4mgp6V4pFbp4QpKNchfR++pWzTHty7HG3oJniZAmmZHPmp/E3TKcuX6ACkRsFT8xzGs0EY+xigU5xns/D2zXSGNxTBRikTfPsdJG/QvgMOluM2URtlnUwdiqZYsFmqHSnsq4CzBKk72MsZRbxBEiXsWA3qu0HX8E+Osxtfkg4MzfOhfDgoqqV23cB14iQqW4nCCXJEfe8EnCGVODF/4Hv8leWw6gS4QaPz/vM8ji4fqGsrW4ydseJ+s9QKjq0lmbYcjYwqpngakCWgs4uqQoLxLn4r8WKKmzDtjhKX7Xb6OEZODeoZ53BeIPiMkuom3UMRuzY33nKjHwinXmVBQu4NTj73DCrZFVGRPvPIav/Zp/fFQE9lWuXPExPwhFGJT6MAp6IV2sKk3hl+RCziQqU+8w1fpL53WV6jAauk6HHHi9ESMdTWMaoY1T+7fdG9i2nVnr9acWvt/uZ6muuzXv86vrEDUHw2DkM0akmf3lqNYoh20vU8LMSlsb0gzCJr8yqZto1Hylk8qUznJZdnqgYDP3hI42l0uW12RyT6JDmkGQvTdm3OSi6v4NptNN828VGaOF/UycFy3Sf+OohFSFAkPzWu1NjOQT3Exwu8h4un1RMDYKHEmA==
X-Forefront-Antispam-Report:
	CIP:50.148.235.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(3023799007)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m8/g8YvZnt+uDrzZYPsjgU+gUa9MMrmC7A+e3QoAUhh5BNp2VS2GkQfoA8UQuWCy31ut5xMX0/Hu9sQVjUB7YMov+XAEXofnFBSrKHfkPaYNf7+EKqVRxR2B+owy2I1K6C/RYwnscrH5et7n0/up59GhKQxqrpq7pw/colflCJ1/2DTaxForCymMizwNIZPBaeHZ8/crj9fFS7EbGGd0G8zPmL4wWX6FpWP9s9TDh/aiWf0iIgxX3BdeWJ6yU4/u1ZEfEQZXJrn0Ab1YcTxNDYHC3A2TW/tNhJ4Pokrtf7GVYxYNAQhjmZH8Fv4UZZ4SSKhKHZmO+xC/J2X+m89vBeIT1Qo5nVG6jy0JiyCAcjhj8vQUoQFOA/J2CtzHyldM0W2zsOunHj6QlmUa5d6JPOolwU2B+g4+HxXqsmkhqbO2Y+SD2ACZuBchzrOvcnOu
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 16:26:51.1292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0ebb4d-bf3c-4a15-495d-08ded468e4bb
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[50.148.235.34];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6342
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22533-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cornelisnetworks.com:dkim,cornelisnetworks.com:email,cornelisnetworks.com:from_mime,vger.kernel.org:from_smtp,awdrv-04:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 66F926D2443

New RDMA drivers are required to use the rdma_user_mmap_entry API
instead of encoding buffer types directly into vm_pgoff tokens. Add
the mmap_entries array to hfi2_filedata to track per-context mmap
entry pointers for cleanup on context teardown. Export rvt_mmap()
from rdmavt so hfi2 can call it as a fallback for CQ/QP/SRQ mmaps
managed by rdmavt's pending_mmaps list. Also remove the dead
hfi1_tid_info struct from the hfi2 ABI header.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/hfi2.h   |  123 ++++++++++++++++++++++-------------
 drivers/infiniband/sw/rdmavt/mmap.c |    7 +-
 include/uapi/rdma/hfi2-abi.h        |   11 ---
 3 files changed, 79 insertions(+), 62 deletions(-)

diff --git a/drivers/infiniband/hw/hfi2/hfi2.h b/drivers/infiniband/hw/hfi2/hfi2.h
index 5ad8cefc7dc1..32a755c0d3d0 100644
--- a/drivers/infiniband/hw/hfi2/hfi2.h
+++ b/drivers/infiniband/hw/hfi2/hfi2.h
@@ -1284,6 +1284,12 @@ struct chip_params {
 	u32 csr_err_mask_reg;
 	u32 csr_err_clear_reg;
 
+	/*
+	 * Chip-variant operation callbacks. Function pointers are used here
+	 * to abstract differences between chip variants (e.g. JKR and future
+	 * generations). Each variant populates its own chip_params instance
+	 * with the appropriate implementations at driver init time.
+	 */
 	void (*hfi2_setextled)(struct hfi2_pportdata *ppd, u32 on);
 	void (*start_led_override)(struct hfi2_pportdata *ppd,
 				   unsigned int timeon, unsigned int timeoff);
@@ -1307,9 +1313,9 @@ struct chip_params {
 				    u32 size);
 	bool (*check_synth_status)(struct hfi2_devdata *dd);
 	void (*update_synth_status)(struct hfi2_devdata *dd);
-	u64 (*create_pbc)(struct hfi2_pportdata *ppd, bool hfi2_loopback, u64 flags,
-			  int srate_mbs, u32 vl, u32 dw_len, u32 l2, u32 dlid,
-			  u32 sctxt);
+	u64 (*create_pbc)(struct hfi2_pportdata *ppd, bool hfi2_loopback,
+			  u64 flags, int srate_mbs, u32 vl, u32 dw_len, u32 l2,
+			  u32 dlid, u32 sctxt);
 	void (*set_pio_integrity)(struct hfi2_devdata *dd, u32 pidx, u32 ctxt,
 				  int type, enum spi_cmds cmd);
 	int (*find_used_resources)(struct hfi2_devdata *dd);
@@ -1834,7 +1840,7 @@ void hfi2_pf0_cleanup(struct hfi2_devdata *dd);
 
 void hfi2_handle_linkup_change(struct hfi2_pportdata *ppd, u32 linkup);
 void hfi2_cport_handle_linkup_change(struct hfi2_pportdata *ppd,
-				struct opa_port_info *pi, u32 linkup);
+				     struct opa_port_info *pi, u32 linkup);
 void hfi2_go_port_active(struct hfi2_pportdata *ppd);
 
 void hfi2_handle_user_interrupt(struct hfi2_ctxtdata *rcd);
@@ -1854,10 +1860,14 @@ int hfi2_rcd_put(struct hfi2_ctxtdata *rcd);
 int hfi2_rcd_get(struct hfi2_ctxtdata *rcd);
 struct hfi2_ctxtdata *hfi2_rcd_get_by_index(struct hfi2_devdata *dd, u16 ctxt);
 int hfi2_handle_receive_interrupt(struct hfi2_ctxtdata *rcd, int thread);
-int hfi2_handle_receive_interrupt_nodma_rtail(struct hfi2_ctxtdata *rcd, int thread);
-int hfi2_handle_receive_interrupt_dma_rtail(struct hfi2_ctxtdata *rcd, int thread);
-int hfi2_handle_receive_interrupt_napi_fp(struct hfi2_ctxtdata *rcd, int budget);
-int hfi2_handle_receive_interrupt_napi_sp(struct hfi2_ctxtdata *rcd, int budget);
+int hfi2_handle_receive_interrupt_nodma_rtail(struct hfi2_ctxtdata *rcd,
+					      int thread);
+int hfi2_handle_receive_interrupt_dma_rtail(struct hfi2_ctxtdata *rcd,
+					    int thread);
+int hfi2_handle_receive_interrupt_napi_fp(struct hfi2_ctxtdata *rcd,
+					  int budget);
+int hfi2_handle_receive_interrupt_napi_sp(struct hfi2_ctxtdata *rcd,
+					  int budget);
 void hfi2_set_all_slowpath(struct hfi2_pportdata *ppd);
 
 extern const struct pci_device_id hfi2_pci_tbl[];
@@ -2154,20 +2164,20 @@ static inline u32 egress_cycles(u32 len, u32 rate)
 
 void hfi2_set_link_ipg(struct hfi2_pportdata *ppd);
 void hfi2_process_becn(struct hfi2_pportdata *ppd, u8 sl, u32 rlid, u32 lqpn,
-		  u32 rqpn, u8 svc_type);
+		       u32 rqpn, u8 svc_type);
 void hfi2_return_cnp(struct hfi2_ibport *ibp, struct rvt_qp *qp, u32 remote_qpn,
-		u16 pkey, u32 slid, u32 dlid, u8 sc5,
-		const struct ib_grh *old_grh);
-void hfi2_return_cnp_16B(struct hfi2_ibport *ibp, struct rvt_qp *qp, u32 remote_qpn,
-		    u16 pkey, u32 slid, u32 dlid, u8 sc5,
-		    const struct ib_grh *old_grh);
+		     u16 pkey, u32 slid, u32 dlid, u8 sc5,
+		     const struct ib_grh *old_grh);
+void hfi2_return_cnp_16B(struct hfi2_ibport *ibp, struct rvt_qp *qp,
+			 u32 remote_qpn, u16 pkey, u32 slid, u32 dlid, u8 sc5,
+			 const struct ib_grh *old_grh);
 typedef void (*hfi2_handle_cnp)(struct hfi2_ibport *ibp, struct rvt_qp *qp,
 				u32 remote_qpn, u16 pkey, u32 slid, u32 dlid,
 				u8 sc5, const struct ib_grh *old_grh);
 
 #define PKEY_CHECK_INVALID -1
-int hfi2_egress_pkey_check(struct hfi2_pportdata *ppd, u32 slid, u16 pkey, u8 sc5,
-		      int8_t s_pkey_index);
+int hfi2_egress_pkey_check(struct hfi2_pportdata *ppd, u32 slid, u16 pkey,
+			   u8 sc5, int8_t s_pkey_index);
 
 #define PACKET_EGRESS_TIMEOUT 350
 static inline void pause_for_credit_return(struct hfi2_devdata *dd)
@@ -2357,7 +2367,8 @@ void hfi2_set_up_vl15(struct hfi2_pportdata *ppd, u16 vl15buf);
 void hfi2_reset_link_credits(struct hfi2_pportdata *ppd);
 void hfi2_assign_remote_cm_au_table(struct hfi2_pportdata *ppd, u8 vcu);
 
-int hfi2_set_buffer_control(struct hfi2_pportdata *ppd, struct buffer_control *bc);
+int hfi2_set_buffer_control(struct hfi2_pportdata *ppd,
+			    struct buffer_control *bc);
 
 static inline struct hfi2_devdata *dd_from_ppd(struct hfi2_pportdata *ppd)
 {
@@ -3158,14 +3169,16 @@ static inline u64 read_iport_csr(const struct hfi2_devdata *dd, int pidx,
 				 u32 offset)
 {
 	/* IPORT CSRs are separated by rxe_iport_stride */
-	return hfi2_read_csr(dd, offset + (dd->params->rxe_iport_stride * pidx));
+	return hfi2_read_csr(dd,
+			     offset + (dd->params->rxe_iport_stride * pidx));
 }
 
 static inline void write_iport_csr(struct hfi2_devdata *dd, int pidx,
 				   u32 offset, u64 value)
 {
 	/* IPORT CSRs are separated by rxe_iport_stride */
-	hfi2_write_csr(dd, offset + (dd->params->rxe_iport_stride * pidx), value);
+	hfi2_write_csr(dd, offset + (dd->params->rxe_iport_stride * pidx),
+		       value);
 }
 
 static inline u64 read_iprc_csr(const struct hfi2_devdata *dd, int pidx, int rc,
@@ -3175,8 +3188,9 @@ static inline u64 read_iprc_csr(const struct hfi2_devdata *dd, int pidx, int rc,
 	 * IPORT receive context CSRs are separated by rxe_iport_stride and
 	 * rxe_iprc_stride.
 	 */
-	return hfi2_read_ctxt_csr(dd, offset + (dd->params->rxe_iport_stride * pidx),
-			     rc, dd->params->rxe_iprc_stride);
+	return hfi2_read_ctxt_csr(
+		dd, offset + (dd->params->rxe_iport_stride * pidx), rc,
+		dd->params->rxe_iprc_stride);
 }
 
 static inline void write_iprc_csr(struct hfi2_devdata *dd, int pidx, int rc,
@@ -3186,36 +3200,40 @@ static inline void write_iprc_csr(struct hfi2_devdata *dd, int pidx, int rc,
 	 * IPORT receive context CSRs are separated by rxe_iport_stride and
 	 * rxe_iprc_stride.
 	 */
-	hfi2_write_ctxt_csr(dd, offset + (dd->params->rxe_iport_stride * pidx), rc,
-		       dd->params->rxe_iprc_stride, value);
+	hfi2_write_ctxt_csr(dd, offset + (dd->params->rxe_iport_stride * pidx),
+			    rc, dd->params->rxe_iprc_stride, value);
 }
 
 static inline u64 read_rctxt_csr(const struct hfi2_devdata *dd, int ctxt,
 				 u32 offset)
 {
 	/* restricted rcv context CSRs are separated by rxe_rctxt_stride */
-	return hfi2_read_ctxt_csr(dd, offset, ctxt, dd->params->rxe_rctxt_stride);
+	return hfi2_read_ctxt_csr(dd, offset, ctxt,
+				  dd->params->rxe_rctxt_stride);
 }
 
 static inline void write_rctxt_csr(struct hfi2_devdata *dd, int ctxt,
 				   u32 offset, u64 value)
 {
 	/* restricted rcv context CSRs are separated by rxe_rctxt_stride */
-	hfi2_write_ctxt_csr(dd, offset, ctxt, dd->params->rxe_rctxt_stride, value);
+	hfi2_write_ctxt_csr(dd, offset, ctxt, dd->params->rxe_rctxt_stride,
+			    value);
 }
 
 static inline u64 read_kctxt_csr(const struct hfi2_devdata *dd, int ctxt,
 				 u32 offset)
 {
 	/* kernel rcv context CSRs are separated by rxe_kctxt_stride */
-	return hfi2_read_ctxt_csr(dd, offset, ctxt, dd->params->rxe_kctxt_stride);
+	return hfi2_read_ctxt_csr(dd, offset, ctxt,
+				  dd->params->rxe_kctxt_stride);
 }
 
 static inline void write_kctxt_csr(struct hfi2_devdata *dd, int ctxt,
 				   u32 offset, u64 value)
 {
 	/* kernel rcv context CSRs are separated by rxe_kctxt_stride */
-	hfi2_write_ctxt_csr(dd, offset, ctxt, dd->params->rxe_kctxt_stride, value);
+	hfi2_write_ctxt_csr(dd, offset, ctxt, dd->params->rxe_kctxt_stride,
+			    value);
 }
 
 static inline u64 read_ku_csr(const struct hfi2_devdata *dd, int ctxt,
@@ -3236,42 +3254,48 @@ static inline u64 read_uctxt_csr(const struct hfi2_devdata *dd, int ctxt,
 				 u32 offset)
 {
 	/* user per-context CSRs are separated by rxe_uctxt_stride */
-	return hfi2_read_ctxt_csr(dd, offset, ctxt, dd->params->rxe_uctxt_stride);
+	return hfi2_read_ctxt_csr(dd, offset, ctxt,
+				  dd->params->rxe_uctxt_stride);
 }
 
 static inline void write_uctxt_csr(struct hfi2_devdata *dd, int ctxt,
 				   u32 offset, u64 value)
 {
 	/* user per-context CSRs are separated by rxe_uctxt_stride */
-	hfi2_write_ctxt_csr(dd, offset, ctxt, dd->params->rxe_uctxt_stride, value);
+	hfi2_write_ctxt_csr(dd, offset, ctxt, dd->params->rxe_uctxt_stride,
+			    value);
 }
 
 static inline u64 read_sctxt_csr(const struct hfi2_devdata *dd, int ctxt,
 				 u32 offset)
 {
 	/* send context CSRs are separated by txe_sctxt_stride */
-	return hfi2_read_ctxt_csr(dd, offset, ctxt, dd->params->txe_sctxt_stride);
+	return hfi2_read_ctxt_csr(dd, offset, ctxt,
+				  dd->params->txe_sctxt_stride);
 }
 
 static inline void write_sctxt_csr(struct hfi2_devdata *dd, int ctxt,
 				   u32 offset, u64 value)
 {
 	/* send context CSRs are separated by txe_sctxt_stride */
-	hfi2_write_ctxt_csr(dd, offset, ctxt, dd->params->txe_sctxt_stride, value);
+	hfi2_write_ctxt_csr(dd, offset, ctxt, dd->params->txe_sctxt_stride,
+			    value);
 }
 
 static inline u64 read_tctxt_csr(const struct hfi2_devdata *dd, int ctxt,
 				 u32 offset)
 {
 	/* TXE send context CSRs are separated by txe_tctxt_stride */
-	return hfi2_read_ctxt_csr(dd, offset, ctxt, dd->params->txe_tctxt_stride);
+	return hfi2_read_ctxt_csr(dd, offset, ctxt,
+				  dd->params->txe_tctxt_stride);
 }
 
 static inline void write_tctxt_csr(struct hfi2_devdata *dd, int ctxt,
 				   u32 offset, u64 value)
 {
 	/* TXE send context CSRs are separated by txe_tctxt_stride */
-	hfi2_write_ctxt_csr(dd, offset, ctxt, dd->params->txe_tctxt_stride, value);
+	hfi2_write_ctxt_csr(dd, offset, ctxt, dd->params->txe_tctxt_stride,
+			    value);
 }
 
 static inline u64 read_sdma_csr(const struct hfi2_devdata *dd, int eng,
@@ -3292,28 +3316,32 @@ static inline u64 read_sdmacfg_csr(const struct hfi2_devdata *dd, int eng,
 				   u32 offset)
 {
 	/* SDMA config engine CSRs are separated by txe_sdmacfg_stride */
-	return hfi2_read_csr(dd, offset + (dd->params->txe_sdmacfg_stride * eng));
+	return hfi2_read_csr(dd,
+			     offset + (dd->params->txe_sdmacfg_stride * eng));
 }
 
 static inline void write_sdmacfg_csr(struct hfi2_devdata *dd, int eng,
 				     u32 offset, u64 value)
 {
 	/* SDMA config engine CSRs are separated by txe_sdmacfg_stride */
-	hfi2_write_csr(dd, offset + (dd->params->txe_sdmacfg_stride * eng), value);
+	hfi2_write_csr(dd, offset + (dd->params->txe_sdmacfg_stride * eng),
+		       value);
 }
 
 static inline u64 read_eport_csr(const struct hfi2_devdata *dd, int pidx,
 				 u32 offset)
 {
 	/* EPORT CSRs are separated by txe_eport_stride */
-	return hfi2_read_csr(dd, offset + (dd->params->txe_eport_stride * pidx));
+	return hfi2_read_csr(dd,
+			     offset + (dd->params->txe_eport_stride * pidx));
 }
 
 static inline void write_eport_csr(struct hfi2_devdata *dd, int pidx,
 				   u32 offset, u64 value)
 {
 	/* EPORT CSRs are separated by txe_eport_stride */
-	hfi2_write_csr(dd, offset + (dd->params->txe_eport_stride * pidx), value);
+	hfi2_write_csr(dd, offset + (dd->params->txe_eport_stride * pidx),
+		       value);
 }
 
 static inline u64 read_epsc_csr(const struct hfi2_devdata *dd, int pidx, int sc,
@@ -3323,8 +3351,9 @@ static inline u64 read_epsc_csr(const struct hfi2_devdata *dd, int pidx, int sc,
 	 * EPORT send context CSRs are separated by txe_eport_stride and
 	 * txe_epsc_stride.
 	 */
-	return hfi2_read_ctxt_csr(dd, offset + (dd->params->txe_eport_stride * pidx),
-			     sc, dd->params->txe_epsc_stride);
+	return hfi2_read_ctxt_csr(
+		dd, offset + (dd->params->txe_eport_stride * pidx), sc,
+		dd->params->txe_epsc_stride);
 }
 
 static inline void write_epsc_csr(struct hfi2_devdata *dd, int pidx, int sc,
@@ -3334,8 +3363,8 @@ static inline void write_epsc_csr(struct hfi2_devdata *dd, int pidx, int sc,
 	 * EPORT send context CSRs are separated by txe_eport_stride and
 	 * txe_epsc_stride.
 	 */
-	hfi2_write_ctxt_csr(dd, offset + (dd->params->txe_eport_stride * pidx), sc,
-		       dd->params->txe_epsc_stride, value);
+	hfi2_write_ctxt_csr(dd, offset + (dd->params->txe_eport_stride * pidx),
+			    sc, dd->params->txe_epsc_stride, value);
 }
 
 static inline u64 read_epscarr_csr(const struct hfi2_devdata *dd, int pidx,
@@ -3345,8 +3374,8 @@ static inline u64 read_epscarr_csr(const struct hfi2_devdata *dd, int pidx,
 	 * EPORT send context array CSRs are separated by txe_eport_stride and
 	 * a per-context stride of 8.
 	 */
-	return hfi2_read_ctxt_csr(dd, offset + (dd->params->txe_eport_stride * pidx),
-			     sc, 8);
+	return hfi2_read_ctxt_csr(
+		dd, offset + (dd->params->txe_eport_stride * pidx), sc, 8);
 }
 
 static inline void write_epscarr_csr(struct hfi2_devdata *dd, int pidx, int sc,
@@ -3356,8 +3385,8 @@ static inline void write_epscarr_csr(struct hfi2_devdata *dd, int pidx, int sc,
 	 * EPORT send context array CSRs are separated by txe_eport_stride and
 	 * a per-context stride of 8.
 	 */
-	hfi2_write_ctxt_csr(dd, offset + (dd->params->txe_eport_stride * pidx), sc,
-		       8, value);
+	hfi2_write_ctxt_csr(dd, offset + (dd->params->txe_eport_stride * pidx),
+			    sc, 8, value);
 }
 
 static inline u32 rhe_rcv_type_err(struct hfi2_packet *packet)
@@ -3408,7 +3437,7 @@ enum preg_op {
 };
 
 int hfi2_priv_reg_op(struct hfi2_devdata *dd, int pidx, u32 ctxt, int type,
-		enum preg_op op, u64 arg);
+		     enum preg_op op, u64 arg);
 
 enum csr_type {
 	CSR_TYPE_IPORT = 1,
@@ -3427,6 +3456,6 @@ enum csr_type {
 };
 
 u64 hfi2_read_csr_type(struct hfi2_devdata *dd, enum csr_type type, u32 off,
-		  u16 ctxt, u8 pidx_eng);
+		       u16 ctxt, u8 pidx_eng);
 
 #endif /* _HFI2_KERNEL_H */
diff --git a/drivers/infiniband/sw/rdmavt/mmap.c b/drivers/infiniband/sw/rdmavt/mmap.c
index 473f464f33fa..f0bd096f457c 100644
--- a/drivers/infiniband/sw/rdmavt/mmap.c
+++ b/drivers/infiniband/sw/rdmavt/mmap.c
@@ -32,8 +32,7 @@ void rvt_mmap_init(struct rvt_dev_info *rdi)
  */
 void rvt_release_mmap_info(struct kref *ref)
 {
-	struct rvt_mmap_info *ip =
-		container_of(ref, struct rvt_mmap_info, ref);
+	struct rvt_mmap_info *ip = container_of(ref, struct rvt_mmap_info, ref);
 	struct rvt_dev_info *rdi = ib_to_rvt(ip->context->device);
 
 	spin_lock_irq(&rdi->pending_lock);
@@ -91,8 +90,7 @@ int rvt_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 	 * CQ, QP, or SRQ is soon followed by a call to mmap().
 	 */
 	spin_lock_irq(&rdi->pending_lock);
-	list_for_each_entry_safe(ip, pp, &rdi->pending_mmaps,
-				 pending_mmaps) {
+	list_for_each_entry_safe(ip, pp, &rdi->pending_mmaps, pending_mmaps) {
 		/* Only the creator is allowed to mmap the object */
 		if (context != ip->context || (__u64)offset != ip->offset)
 			continue;
@@ -115,6 +113,7 @@ int rvt_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 done:
 	return ret;
 }
+EXPORT_SYMBOL(rvt_mmap);
 
 /**
  * rvt_create_mmap_info - allocate information for hfi1_mmap
diff --git a/include/uapi/rdma/hfi2-abi.h b/include/uapi/rdma/hfi2-abi.h
index 7b7ca198b539..5b5b619bf1a8 100644
--- a/include/uapi/rdma/hfi2-abi.h
+++ b/include/uapi/rdma/hfi2-abi.h
@@ -248,17 +248,6 @@ struct hfi2_ctxt_info {
 	__u16 sdma_ring_size; /* number of entries in SDMA request ring */
 };
 
-struct hfi1_tid_info {
-	/* virtual address of first page in transfer */
-	__aligned_u64 vaddr;
-	/* pointer to tid array. this array is big enough */
-	__aligned_u64 tidlist;
-	/* number of tids programmed by this request */
-	__u32 tidcnt;
-	/* length of transfer buffer programmed by this request */
-	__u32 length;
-};
-
 #define HFI2_TID_UPDATE_FLAGS_MEMINFO_MASK 0xfUL
 #define HFI2_TID_UPDATE_FLAGS_RESERVED_MASK \
 	(~(__u64)(HFI2_TID_UPDATE_FLAGS_MEMINFO_MASK))



