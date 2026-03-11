Return-Path: <linux-rdma+bounces-18008-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MmxENGssWmzEQAAu9opvQ
	(envelope-from <linux-rdma+bounces-18008-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:56:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DF826855E
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 755D43081BE0
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 17:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1374A3E63A8;
	Wed, 11 Mar 2026 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="IqjygzVT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020129.outbound.protection.outlook.com [52.101.85.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77F03E63AF
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251754; cv=fail; b=k3dnbtx7jHywgyzOvSZgUfZl6NC3J/rhSl3i+MH5HK0iUskXiTYSuYrkBVXJZCb7cb886knQ7zWwWCIj+9K4OqWKXh/8umGRc0geh/2BiSXzhYb1UJf8FfNj2xUjuHNRl7pz3rdX0SObLEA/cdzT3Q282WUdOy7DIAYa/saih2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251754; c=relaxed/simple;
	bh=Y2Gg0JVaM0VzipGdit0TfvbWPzxn9oiTJAvwvXRIFD8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cmg2WQKhqZ92AdsK08t0hHwWKbIC7GMZiQGUHSfnOGjMIj7I0g4eRGDWR/6p3ndgGw7Tt02q7H8hT3T13JXIUv41IGr6OZz2LnksZkUYQW5X61PucVrVPo1dpghquvKCT1X4mMxQM+r3UeHDodDitT9+T/2K5T5/IppqQRveFc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=IqjygzVT; arc=fail smtp.client-ip=52.101.85.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ofkg01Ehr90Vb3wymLvOPu1Ltob9sHvc+C/+MzUkS8N6EKXwNofX57vgHGbW+Uho0e4qNxDn111nSmNBee2e12Q2uUXko8aE1+uPe4xn9IaukVIngibhK/Q/+NOCDxgty8eNSU1xPxkUmYUyRxEwHes8Kg0t3i/IUUXGFrvHdJFGtYts9Yfs3thAhZPdH6MMt+sky+E5cvfgP814EXVrTbdvC8CrX5vf4sm4CraSmRN35o5MUwbDr3CrHuZ19CLubi9m2+lzewNDJdzfNgwNHhQ6SDiz8LASWa1MJaFZApCnTR3vFDrUUsBLnXCGs0KhRhcFC/iEEXhktHA+tL9nRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FG3qe+S9+acKkN8nzSEjdxGZ0C2J7JBrOX/llqTghRg=;
 b=NinpklM3nCvzBUK+TlUTmBWxGai1j2UPd7fPjnE1MIsH1FMFmDLahgX/KForTgB587UVm93pmOuvFdGwNcSUxf/2iG1oC1Fr0VTpAXH+IQfSZu4wBfHWTQJgVgW5yWkiq1b4cnKw0WPMaGyw3Ghvt1tFgXcg6ThXNBmAjA9cI4JX5v7uogI7OzLCcuOm/w4ato7BdT8nUgub/FAr22yPtz9pyaERwAx9f1HxHLQSzQ2+tH9ipEY3q6imK1pJiSt8FOvZuAN7SvPRayC3VnvzjEMx/0G7svQpq5dCmxWFObqAzb+TdiFwm3SAcCOhlA+jlvcK5DzAcr2n6AO2tV5uMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FG3qe+S9+acKkN8nzSEjdxGZ0C2J7JBrOX/llqTghRg=;
 b=IqjygzVTEwQAkWca75v637F1RjKrjLo4q0yMeMpxbqzSrev1HEe0glVddT/bqeHf5MSkmeVX/jCwFRMpRRZgCu0GT08qN5IeIdY+4MefoP0YtJc8aV8OnREH7COb0wqp9bgUDSGNPrJ80R+e59IVn/7IL9ewP9PdsmAk/venIbj672teC1LWL0qWtLVHMW4pUqzsTSLsBvVYwSt/nRA+A35xCCmBdEPFr8usa5raNMDuWZ4/b25nH2fRV3VWvHeiskv3Nm6BmdLzPMslYr/0eVkiU9IE0hSUzD6TbwCxaQmn6YTs3YB7LdZWKinaLWK7/itjRWzSG63g2MIFv++UTg==
Received: from MN2PR16CA0063.namprd16.prod.outlook.com (2603:10b6:208:234::32)
 by PH0PR01MB7425.prod.exchangelabs.com (2603:10b6:510:4b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Wed, 11 Mar 2026 17:55:47 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::70) by MN2PR16CA0063.outlook.office365.com
 (2603:10b6:208:234::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Wed,
 11 Mar 2026 17:55:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Wed, 11 Mar 2026 17:55:46 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id 8C8A214D819;
	Wed, 11 Mar 2026 13:55:46 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 891331810D6C5;
	Wed, 11 Mar 2026 13:55:46 -0400 (EDT)
Subject: [PATCH for-next resend 24/24] RDMA/hfi2: Modernize mmap to use
 rdma_user_mmap_entry infrastructure
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org
Date: Wed, 11 Mar 2026 13:55:46 -0400
Message-ID:
 <177325174651.57064.11434534909247286935.stgit@awdrv-04.cornelisnetworks.com>
In-Reply-To:
 <177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com>
References:
 <177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|PH0PR01MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f8cde9-5a1e-41c3-82fd-08de7f976c69
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|34020700016|7142099003|55112099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Dweq8WVO/APv+G6uNwAxNHmIghN6NbTb74dVx7DZTfXAVJH6Nl0pmKA9gYdqHEyfaXkex0z3DBTNkAqeibIq6qsAeZLIc3KzKflvmHojX/7aNFlFgFGlusi+buW8Ew+psrxMtfoM6A+OQxk05h2RGWeVBPnNhHIIS6k8D4/QufxucuRmqe/1O9fCQuGhFYuQOP78JkuYMkfzdaTyrA68J+X7HIhCW+vrKLTkG0LaRqye3W7vSgs2aA/JgacCD0YICkjqNQl/aqMpuDSjfirG6KCUTu4UnoT9DO+ck2+rCIyQyUv+kor5BVcRulYT2zW7ICDR/RuqIVoJKtX1wyNJXfHkVE6l9BACfPTe1FGDdcNxyJPb24ac+DEFMVFIzyQT/enrNC9WIZzplYZKc371JzuqzRMSJ19robpI6DYvepu6GCn4h9j6/uyNN45QDByDmRCnuMY3pI56PhhaYprzV1ZltcpI56z0vPdkPr68uK3HfRZsk3aAwDzV+VBwSo3ZBVKsmqiq1kBL1TB0vKychh6a5ZSsYOa4UoM7+g4Acnhz0eBX3WxL/1auFZhC7bpZlsBSeXBAGM6D/phMn2vM0S/p/F7XJskqGxKLzeDygdhLonRVZJ1aKbqjaHw45kG/9R1p8Kr5kHpiY2lO2nTSYYyDm9FlUbPcfcV1ZqWAJESuIM641OjQIpqJbrrHLFWmW411V4xAUq7HLxcbOaNzIs6rRpYiz6g1dCqeytNZ5zTfcFzYv+NhIZ4XKJT0UbGRyRDbQHAOl3rpUeG1K/JX8A==
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(34020700016)(7142099003)(55112099003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	h0afywMbxwVQ3Pv3hXCeLSYzbrf+crB/HCNv/P/O2fEIqwW7s+EVXcK0ysGcgCmF28ycZJ4FQSkcJSZc7bQ/D1stue37vAV9OLIpSk03JxYGl4n+qPEMJcWVdrmNAtH2H1JvLstx1FUtAJq5Ln1jgBJx4w0CpzPWpJVNZTHc5ZiPgzef0rqjM1OBw8mIo/JPW02z2Td/taH8BMYHOKgFvguv73lZKZC633PJE8eAlfgyN29OrvsobRW0ERuoICk4lzKACII06jAVXy4o91q07/VGv9gEAhn7saPUa5zRu5tY9S13I31ThxEb1+bcYhr7mQiAOM2w40CgnARsV5AWWh0nYcm4VmLJ+XurSVwWQBboBNnZ0SD3ZMYo7Hv7v5W1b0ECBq293DwCCqlnMPa4gmZW/ZsMd4sSAMaAo2axaL356gm6KLQSF25WIiHTzPBd
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:55:46.8062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f8cde9-5a1e-41c3-82fd-08de7f976c69
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7425
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18008-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cornelisnetworks.com:dkim,cornelisnetworks.com:email,awdrv-04.cornelisnetworks.com:mid];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B8DF826855E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

New RDMA drivers are required to use the rdma_user_mmap_entry API
instead of encoding buffer types directly into vm_pgoff tokens.

Replace the custom rdma_mmap_token_*() scheme with the core
rdma_user_mmap_entry infrastructure:

- Define struct hfi2_user_mmap_entry embedding rdma_user_mmap_entry,
  carrying the physical address, virtual pointer, DMA address, and
  buffer type for each mappable region.

- In HFI2_METHOD_USER_INFO, replace rdma_mmap_token_*() calls with
  rdma_user_mmap_entry_insert(), storing opaque offsets in the
  response for userspace to pass back to mmap(2).

- Implement hfi2_mmap() as the ib_device_ops .mmap callback. It
  looks up the entry via rdma_user_mmap_entry_get() and dispatches
  to hfi2_do_mmap(). For CQ/QP/SRQ offsets not owned by the driver,
  it falls through to rvt_mmap().

- Use rdma_user_mmap_io() for MMIO mappings (PIO send buffers, user
  registers), providing proper device disassociation tracking via the
  core's rdma_umap_priv mechanism.

- Implement hfi2_mmap_free() as the .mmap_free callback to release
  the driver-specific entry wrapper on final unmap.

- Track all mmap entry pointers in hfi2_filedata and call
  rdma_user_mmap_entry_remove() during context teardown.

- Export rvt_mmap() from rdmavt so hfi2 can call it as a fallback
  for CQ/QP/SRQ mmaps managed by rdmavt's pending_mmaps list.

Assisted-by: opencode:developer-sonnet-4.6
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/affinity.c     |    2 
 drivers/infiniband/hw/hfi2/chip.c         |    2 
 drivers/infiniband/hw/hfi2/chip_gen.c     |    2 
 drivers/infiniband/hw/hfi2/cport.c        |    4 
 drivers/infiniband/hw/hfi2/fault.c        |    2 
 drivers/infiniband/hw/hfi2/file_ops.c     |  125 ++-------------
 drivers/infiniband/hw/hfi2/file_ops.h     |    5 -
 drivers/infiniband/hw/hfi2/hfi2.h         |    2 
 drivers/infiniband/hw/hfi2/init.c         |    4 
 drivers/infiniband/hw/hfi2/mad.c          |    4 
 drivers/infiniband/hw/hfi2/pin_system.c   |    2 
 drivers/infiniband/hw/hfi2/qsfp.c         |    2 
 drivers/infiniband/hw/hfi2/sdma.c         |    4 
 drivers/infiniband/hw/hfi2/tid_rdma.c     |    2 
 drivers/infiniband/hw/hfi2/tid_system.c   |    2 
 drivers/infiniband/hw/hfi2/user_exp_rcv.c |    2 
 drivers/infiniband/hw/hfi2/uverbs.c       |  242 +++++++++++++++++++++++------
 drivers/infiniband/hw/hfi2/uverbs.h       |   24 +++
 drivers/infiniband/hw/hfi2/verbs.c        |    6 +
 drivers/infiniband/hw/hfi2/vf2pf_lb.c     |    2 
 drivers/infiniband/sw/rdmavt/mmap.c       |    1 
 21 files changed, 262 insertions(+), 179 deletions(-)

diff --git a/drivers/infiniband/hw/hfi2/affinity.c b/drivers/infiniband/hw/hfi2/affinity.c
index 8347ab5eb440..a716a76798f0 100644
--- a/drivers/infiniband/hw/hfi2/affinity.c
+++ b/drivers/infiniband/hw/hfi2/affinity.c
@@ -207,7 +207,7 @@ static struct hfi2_affinity_node *node_affinity_allocate(int node)
 {
 	struct hfi2_affinity_node *entry;
 
-	entry = kzalloc_obj(entry, GFP_KERNEL);
+	entry = kzalloc_obj(*entry, GFP_KERNEL);
 	if (!entry)
 		return NULL;
 	entry->node = node;
diff --git a/drivers/infiniband/hw/hfi2/chip.c b/drivers/infiniband/hw/hfi2/chip.c
index 7547058acb29..2b78c964885d 100644
--- a/drivers/infiniband/hw/hfi2/chip.c
+++ b/drivers/infiniband/hw/hfi2/chip.c
@@ -12001,7 +12001,7 @@ static int init_asic_data(struct hfi2_devdata *dd)
 	int ret = 0;
 
 	/* pre-allocate the asic structure in case we are the first device */
-	asic_data = kzalloc_obj(dd->asic_data, GFP_KERNEL);
+	asic_data = kzalloc_obj(*dd->asic_data, GFP_KERNEL);
 	if (!asic_data)
 		return -ENOMEM;
 
diff --git a/drivers/infiniband/hw/hfi2/chip_gen.c b/drivers/infiniband/hw/hfi2/chip_gen.c
index ae8ec17ccc01..37001eed38ee 100644
--- a/drivers/infiniband/hw/hfi2/chip_gen.c
+++ b/drivers/infiniband/hw/hfi2/chip_gen.c
@@ -143,7 +143,7 @@ static struct opa_smp *build_cport_mad(int meth, int attr)
 {
 	struct opa_smp *mad;
 
-	mad = kzalloc_obj(mad, GFP_KERNEL);
+	mad = kzalloc_obj(*mad, GFP_KERNEL);
 	if (!mad)
 		return mad;
 	mad->base_version = OPA_MGMT_BASE_VERSION;
diff --git a/drivers/infiniband/hw/hfi2/cport.c b/drivers/infiniband/hw/hfi2/cport.c
index 026374a6e9fa..066b3e9c6098 100644
--- a/drivers/infiniband/hw/hfi2/cport.c
+++ b/drivers/infiniband/hw/hfi2/cport.c
@@ -221,7 +221,7 @@ static struct cport_work *cwalloc(int flag)
 
 	cw->flags = flag;
 	cw->n_mctxts = 1;
-	cw->req = kzalloc_obj(cw->req, GFP_KERNEL);
+	cw->req = kzalloc_obj(*cw->req, GFP_KERNEL);
 	if (!cw->req) {
 		kfree(cw);
 		return NULL;
@@ -937,7 +937,7 @@ int cport_init(struct hfi2_devdata *dd)
 	if (dd->params->chip_type == CHIP_WFR || dd->is_vf)
 		return 0;
 
-	cport = kzalloc_obj(cport, GFP_KERNEL);
+	cport = kzalloc_obj(*cport, GFP_KERNEL);
 	if (!cport)
 		goto err1;
 
diff --git a/drivers/infiniband/hw/hfi2/fault.c b/drivers/infiniband/hw/hfi2/fault.c
index 0c8127bb695b..1d942737db62 100644
--- a/drivers/infiniband/hw/hfi2/fault.c
+++ b/drivers/infiniband/hw/hfi2/fault.c
@@ -215,7 +215,7 @@ int hfi2_fault_init_debugfs(struct hfi2_ibdev *ibd)
 	struct dentry *parent = ibd->hfi2_ibdev_dbg;
 	struct dentry *fault_dir;
 
-	ibd->fault = kzalloc_obj(ibd->fault, GFP_KERNEL);
+	ibd->fault = kzalloc_obj(*ibd->fault, GFP_KERNEL);
 	if (!ibd->fault)
 		return -ENOMEM;
 
diff --git a/drivers/infiniband/hw/hfi2/file_ops.c b/drivers/infiniband/hw/hfi2/file_ops.c
index a18aa1b3d91e..9d43c8732ebc 100644
--- a/drivers/infiniband/hw/hfi2/file_ops.c
+++ b/drivers/infiniband/hw/hfi2/file_ops.c
@@ -12,6 +12,7 @@
 #include <linux/bitmap.h>
 
 #include <rdma/ib.h>
+#include <rdma/ib_verbs.h>
 
 #include "hfi2.h"
 #include "pio.h"
@@ -23,6 +24,7 @@
 #include "aspm.h"
 #include "pinning.h"
 #include "file_ops.h"
+#include "uverbs.h"
 
 #undef pr_fmt
 #define pr_fmt(fmt) DRIVER_NAME ": " fmt
@@ -95,7 +97,7 @@ struct hfi2_filedata *hfi2_alloc_filedata(struct hfi2_devdata *dd)
 
 	/* The real work is performed later in assign_ctxt() */
 
-	fd = kzalloc_obj(fd, GFP_KERNEL);
+	fd = kzalloc_obj(*fd, GFP_KERNEL);
 
 	if (!fd || init_srcu_struct(&fd->pq_srcu))
 		goto nomem;
@@ -170,19 +172,20 @@ static inline void mmap_cdbg(u16 ctxt, u16 subctxt, u8 type, u8 mapio, u8 vmf,
 		  vma->vm_end - vma->vm_start, vma->vm_flags);
 }
 
-int hfi2_do_mmap(struct hfi2_filedata *fd, u8 type, struct vm_area_struct *vma)
+int hfi2_do_mmap(struct hfi2_filedata *fd, u8 type, struct vm_area_struct *vma,
+		 struct rdma_user_mmap_entry *rdma_entry,
+		 struct ib_ucontext *ucontext)
 {
+	struct hfi2_user_mmap_entry *entry = to_hfi2_mmap(rdma_entry);
 	struct hfi2_ctxtdata *uctxt = fd->uctxt;
 	struct hfi2_devdata *dd;
 	unsigned long flags;
-	u64 memaddr = 0;
-	void *memvirt = NULL;
-	dma_addr_t memdma = 0;
+	u64 memaddr = entry->address;
+	void *memvirt = entry->memvirt;
+	dma_addr_t memdma = entry->memdma;
 	u8 mapio = 0, vmf = 0;
-	ssize_t memlen = 0;
+	ssize_t memlen = rdma_entry->npages * PAGE_SIZE;
 	int ret = 0;
-	u32 cbi;
-	u32 cbc;
 	u16 ctxt;
 	u16 subctxt;
 
@@ -197,62 +200,27 @@ int hfi2_do_mmap(struct hfi2_filedata *fd, u8 type, struct vm_area_struct *vma)
 	/*
 	 * vm_pgoff is used as a buffer selector cookie.  Always mmap from
 	 * the beginning.
-	 */ 
+	 */
 	vma->vm_pgoff = 0;
 	flags = vma->vm_flags;
 
 	switch (type) {
 	case PIO_BUFS:
 	case PIO_BUFS_SOP:
-		cbi = ctxt_bar_idx(uctxt->sc->hw_context);
-		cbc = ctxt_bar_ctxt(uctxt->sc->hw_context);
-		memaddr = ((dd->bar_maps[cbi].physaddr + TXE_PIO_SEND) +
-				/* chip pio base */
-			   (cbc * BIT(16))) +
-				/* 64K PIO space / ctxt */
-			(type == PIO_BUFS_SOP ?
-				(TXE_PIO_SIZE / 2) : 0); /* sop? */
-		/*
-		 * Map only the amount allocated to the context, not the
-		 * entire available context's PIO space.
-		 */
-		memlen = PAGE_ALIGN(uctxt->sc->credits * PIO_BLOCK_SIZE);
 		flags &= ~VM_MAYREAD;
 		flags |= VM_DONTCOPY | VM_DONTEXPAND;
 		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 		mapio = 1;
 		break;
-	case PIO_CRED: {
-		u64 cr_page_offset;
+	case PIO_CRED:
 		if (flags & VM_WRITE) {
 			ret = -EPERM;
 			goto done;
 		}
-		/*
-		 * The credit return location for this context could be on the
-		 * second or third page allocated for credit returns (if number
-		 * of enabled contexts > 64 and 128 respectively).
-		 */
-		cr_page_offset = ((u64)uctxt->sc->hw_free -
-			  	     (u64)dd->cr_base[uctxt->numa_id].va) &
-				   PAGE_MASK;
-		memvirt = (void *)dd->cr_base[uctxt->numa_id].va + cr_page_offset;
-		memdma = dd->cr_base[uctxt->numa_id].dma + cr_page_offset;
-		memlen = PAGE_SIZE;
 		flags &= ~VM_MAYWRITE;
 		flags |= VM_DONTCOPY | VM_DONTEXPAND;
-		/*
-		 * The driver has already allocated memory for credit
-		 * returns and programmed it into the chip. Has that
-		 * memory been flagged as non-cached?
-		 */
-		/* vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot); */
 		break;
-	}
 	case RCV_RHEQ:
-		memlen = rheq_size(uctxt);
-		memvirt = uctxt->rheq;
-		memdma = uctxt->rheq_dma;
 		if (!memvirt) {
 			ret = -EINVAL;
 			goto done;
@@ -263,9 +231,6 @@ int hfi2_do_mmap(struct hfi2_filedata *fd, u8 type, struct vm_area_struct *vma)
 		}
 		break;
 	case RCV_HDRQ:
-		memlen = rcvhdrq_size(uctxt);
-		memvirt = uctxt->rcvhdrq;
-		memdma = uctxt->rcvhdrq_dma;
 		break;
 	case RCV_EGRBUF: {
 		unsigned long vm_start_save;
@@ -276,7 +241,6 @@ int hfi2_do_mmap(struct hfi2_filedata *fd, u8 type, struct vm_area_struct *vma)
 		 * as multiple non-contiguous pages need to be mapped
 		 * into the user process.
 		 */
-		memlen = uctxt->egrbufs.size;
 		if ((vma->vm_end - vma->vm_start) != memlen) {
 			dd_dev_err(dd, "Eager buffer map size invalid (%lu != %lu)\n",
 				   (vma->vm_end - vma->vm_start), memlen);
@@ -320,42 +284,11 @@ int hfi2_do_mmap(struct hfi2_filedata *fd, u8 type, struct vm_area_struct *vma)
 		goto done;
 	}
 	case UREGS:
-		/*
-		 * Map the part of BAR0 that contains this context's user
-		 * registers.  RcvHdrTail is the first register in the hardware
-		 * UCTXT block.  The TidFlow table is contained within this
-		 * memory range.
-		 */
-		cbi = ctxt_bar_idx(uctxt->ctxt);
-		cbc = ctxt_bar_ctxt(uctxt->ctxt);
-		memaddr = (unsigned long)dd->bar_maps[cbi].physaddr +
-				dd->params->rcv_hdr_tail_reg +
-				(cbc * dd->params->rxe_uctxt_stride);
-		memlen = dd->params->rxe_uctxt_stride;
-		// hack: accept a 4K mmap for uregs
-		{
-		ssize_t sz = vma->vm_end - vma->vm_start;
-		if (sz != memlen && sz == PAGE_SIZE) {
-			printk("%s: UREGS override memlen to 4K\n", __func__);
-			memlen = PAGE_SIZE;
-		}
-		}
 		flags |= VM_DONTCOPY | VM_DONTEXPAND;
 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 		mapio = 1;
 		break;
 	case EVENTS:
-		/*
-		 * Use the page where this context's flags are. User level
-		 * knows where it's own bitmap is within the page.
-		 */
-		memaddr = (unsigned long)
-			(dd->events + uctxt_offset(uctxt)) & PAGE_MASK;
-		memlen = PAGE_SIZE;
-		/*
-		 * v3.7 removes VM_RESERVED but the effect is kept by
-		 * using VM_IO.
-		 */
 		flags |= VM_IO | VM_DONTEXPAND;
 		vmf = 1;
 		break;
@@ -364,16 +297,12 @@ int hfi2_do_mmap(struct hfi2_filedata *fd, u8 type, struct vm_area_struct *vma)
 			ret = -EPERM;
 			goto done;
 		}
-		memaddr = kvirt_to_phys((void *)dd->status);
-		memlen = PAGE_SIZE;
+		memaddr = kvirt_to_phys(memvirt);
+		memvirt = NULL;
 		flags |= VM_IO | VM_DONTEXPAND;
 		break;
 	case RTAIL:
 		if (!HFI2_CAP_IS_USET(DMA_RTAIL)) {
-			/*
-			 * If the memory allocation failed, the context alloc
-			 * also would have failed, so we would never get here
-			 */
 			ret = -EINVAL;
 			goto done;
 		}
@@ -381,43 +310,29 @@ int hfi2_do_mmap(struct hfi2_filedata *fd, u8 type, struct vm_area_struct *vma)
 			ret = -EPERM;
 			goto done;
 		}
-		memlen = PAGE_SIZE;
-		memvirt = (void *)hfi2_rcvhdrtail_kvaddr(uctxt);
-		memdma = uctxt->rcvhdrqtailaddr_dma;
 		flags &= ~VM_MAYWRITE;
 		break;
 	case SUBCTXT_UREGS:
-		memaddr = (u64)uctxt->subctxt_uregbase;
-		memlen = PAGE_SIZE;
 		flags |= VM_IO | VM_DONTEXPAND;
 		vmf = 1;
 		break;
 	case SUBCTXT_RCV_HDRQ:
-		memaddr = (u64)uctxt->subctxt_rcvhdr_base;
-		memlen = rcvhdrq_size(uctxt) * uctxt->subctxt_cnt;
 		flags |= VM_IO | VM_DONTEXPAND;
 		vmf = 1;
 		break;
 	case SUBCTXT_EGRBUF:
-		memaddr = (u64)uctxt->subctxt_rcvegrbuf;
-		memlen = uctxt->egrbufs.size * uctxt->subctxt_cnt;
 		flags |= VM_IO | VM_DONTEXPAND;
 		flags &= ~VM_MAYWRITE;
 		vmf = 1;
 		break;
-	case SDMA_COMP: {
-		struct hfi2_user_sdma_comp_q *cq = fd->cq;
-
-		if (!cq) {
+	case SDMA_COMP:
+		if (!fd->cq) {
 			ret = -EFAULT;
 			goto done;
 		}
-		memaddr = (u64)cq->comps;
-		memlen = PAGE_ALIGN(sizeof(*cq->comps) * cq->nentries);
 		flags |= VM_IO | VM_DONTEXPAND;
 		vmf = 1;
 		break;
-	}
 	default:
 		ret = -EINVAL;
 		break;
@@ -442,10 +357,8 @@ int hfi2_do_mmap(struct hfi2_filedata *fd, u8 type, struct vm_area_struct *vma)
 		ret = dma_mmap_coherent(&dd->pcidev->dev, vma,
 					memvirt, memdma, memlen);
 	} else if (mapio) {
-		ret = io_remap_pfn_range(vma, vma->vm_start,
-					 PFN_DOWN(memaddr),
-					 memlen,
-					 vma->vm_page_prot);
+		ret = rdma_user_mmap_io(ucontext, vma, PFN_DOWN(memaddr),
+					memlen, vma->vm_page_prot, rdma_entry);
 	} else if (memvirt) {
 		ret = remap_pfn_range(vma, vma->vm_start,
 				      PFN_DOWN(__pa(memvirt)),
diff --git a/drivers/infiniband/hw/hfi2/file_ops.h b/drivers/infiniband/hw/hfi2/file_ops.h
index 1efc69c7b322..c5c370ad11e2 100644
--- a/drivers/infiniband/hw/hfi2/file_ops.h
+++ b/drivers/infiniband/hw/hfi2/file_ops.h
@@ -20,7 +20,9 @@ int set_ctxt_pkey(struct hfi2_ctxtdata *uctxt, u16 pkey);
 int ctxt_reset(struct hfi2_ctxtdata *uctxt);
 int hfi2_get_pinning_stats(struct hfi2_filedata *fd,
 			   struct hfi2_pin_stats *stats);
-int hfi2_do_mmap(struct hfi2_filedata *fd, u8 type, struct vm_area_struct *vma);
+int hfi2_do_mmap(struct hfi2_filedata *fd, u8 type, struct vm_area_struct *vma,
+		 struct rdma_user_mmap_entry *rdma_entry,
+		 struct ib_ucontext *ucontext);
 ssize_t hfi2_do_write_iter(struct hfi2_filedata *fd, struct iov_iter *from);
 
 /*
@@ -41,6 +43,7 @@ enum mmap_types {
 	SUBCTXT_EGRBUF,
 	SDMA_COMP,
 	RCV_RHEQ,
+	MMAP_TYPE_MAX,
 };
 
 #endif /* _HFI2_FILE_OPS_H */
diff --git a/drivers/infiniband/hw/hfi2/hfi2.h b/drivers/infiniband/hw/hfi2/hfi2.h
index a522f4606d3d..458ec161d514 100644
--- a/drivers/infiniband/hw/hfi2/hfi2.h
+++ b/drivers/infiniband/hw/hfi2/hfi2.h
@@ -1848,6 +1848,8 @@ struct hfi2_filedata {
 	u32 invalid_tid_idx;
 	/* protect invalid_tids array and invalid_tid_idx */
 	spinlock_t invalid_lock;
+	/* mmap entries tracked for rdma_user_mmap infrastructure */
+	struct rdma_user_mmap_entry *mmap_entries[15]; /* MMAP_TYPE_MAX */
 };
 
 extern struct xarray hfi2_dev_table;
diff --git a/drivers/infiniband/hw/hfi2/init.c b/drivers/infiniband/hw/hfi2/init.c
index 70145b643d31..a986e29f8760 100644
--- a/drivers/infiniband/hw/hfi2/init.c
+++ b/drivers/infiniband/hw/hfi2/init.c
@@ -635,7 +635,7 @@ int register_cport_trap(struct hfi2_devdata *dd, struct cport_trap_status traps,
 	trap_val.traps = traps;
 	cur_traps.traps = dd->cport->traps;
 
-	entry = kzalloc_obj(entry, GFP_KERNEL);
+	entry = kzalloc_obj(*entry, GFP_KERNEL);
 	if (!entry)
 		return -ENOMEM;
 	entry->mask = trap_val.dw;
@@ -1351,7 +1351,7 @@ void hfi2_init_pportdata(struct pci_dev *pdev, struct hfi2_pportdata *ppd,
 
 	spin_lock_init(&ppd->cc_state_lock);
 	spin_lock_init(&ppd->cc_log_lock);
-	cc_state = kzalloc_obj(cc_state, GFP_KERNEL);
+	cc_state = kzalloc_obj(*cc_state, GFP_KERNEL);
 	RCU_INIT_POINTER(ppd->cc_state, cc_state);
 	if (!cc_state)
 		goto bail;
diff --git a/drivers/infiniband/hw/hfi2/mad.c b/drivers/infiniband/hw/hfi2/mad.c
index df77cb9bf630..b1b0b4c66f1f 100644
--- a/drivers/infiniband/hw/hfi2/mad.c
+++ b/drivers/infiniband/hw/hfi2/mad.c
@@ -412,7 +412,7 @@ static struct trap_node *create_trap_node(u8 type, __be16 trap_num, u32 lid)
 {
 	struct trap_node *trap;
 
-	trap = kzalloc_obj(trap, GFP_ATOMIC);
+	trap = kzalloc_obj(*trap, GFP_ATOMIC);
 	if (!trap)
 		return NULL;
 
@@ -3836,7 +3836,7 @@ static void apply_cc_state(struct hfi2_pportdata *ppd)
 {
 	struct cc_state *old_cc_state, *new_cc_state;
 
-	new_cc_state = kzalloc_obj(new_cc_state, GFP_KERNEL);
+	new_cc_state = kzalloc_obj(*new_cc_state, GFP_KERNEL);
 	if (!new_cc_state)
 		return;
 
diff --git a/drivers/infiniband/hw/hfi2/pin_system.c b/drivers/infiniband/hw/hfi2/pin_system.c
index 2ad8e90c3261..673ec390dd4d 100644
--- a/drivers/infiniband/hw/hfi2/pin_system.c
+++ b/drivers/infiniband/hw/hfi2/pin_system.c
@@ -192,7 +192,7 @@ add_system_pinning(struct user_sdma_request *req, unsigned long start,
 	struct sdma_mmu_node *e;
 	int ret;
 
-	e = kzalloc_obj(e, GFP_KERNEL);
+	e = kzalloc_obj(*e, GFP_KERNEL);
 	if (!e)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/infiniband/hw/hfi2/qsfp.c b/drivers/infiniband/hw/hfi2/qsfp.c
index afe91f68073f..39218f1edcd6 100644
--- a/drivers/infiniband/hw/hfi2/qsfp.c
+++ b/drivers/infiniband/hw/hfi2/qsfp.c
@@ -108,7 +108,7 @@ static struct hfi2_i2c_bus *init_i2c_bus(struct hfi2_devdata *dd,
 	struct hfi2_i2c_bus *bus;
 	int ret;
 
-	bus = kzalloc_obj(bus, GFP_KERNEL);
+	bus = kzalloc_obj(*bus, GFP_KERNEL);
 	if (!bus)
 		return NULL;
 
diff --git a/drivers/infiniband/hw/hfi2/sdma.c b/drivers/infiniband/hw/hfi2/sdma.c
index 4ee6165b3718..a3806cd49152 100644
--- a/drivers/infiniband/hw/hfi2/sdma.c
+++ b/drivers/infiniband/hw/hfi2/sdma.c
@@ -1022,7 +1022,7 @@ ssize_t sdma_set_cpu_to_sde_map(struct sdma_engine *sde, const char *buf,
 
 		do_insert = false;
 		if (!rht_node) {
-			rht_node = kzalloc_obj(rht_node, GFP_KERNEL);
+			rht_node = kzalloc_obj(*rht_node, GFP_KERNEL);
 			if (!rht_node) {
 				ret = -ENOMEM;
 				goto out;
@@ -2477,7 +2477,7 @@ static void dump_sdma_state(struct sdma_engine *sde)
 	if (in_interrupt()) {
 		size_t size = sizeof(struct hw_sdma_desc) * sde->descq_cnt;
 
-		sdi = kmalloc_obj(sdi, GFP_ATOMIC);
+		sdi = kmalloc_obj(*sdi, GFP_ATOMIC);
 		descs = kmalloc(size, GFP_ATOMIC);
 		if (!sdi || !descs) {
 			kfree(sdi);
diff --git a/drivers/infiniband/hw/hfi2/tid_rdma.c b/drivers/infiniband/hw/hfi2/tid_rdma.c
index 2b2ae1f33582..450a52bdcf0f 100644
--- a/drivers/infiniband/hw/hfi2/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi2/tid_rdma.c
@@ -232,7 +232,7 @@ bool tid_rdma_conn_reply(struct rvt_qp *qp, u64 data)
 	 * * at the responder, 0 being returned to the requester so as to
 	 *   disable TID RDMA at both the requester and the responder
 	 */
-	remote = kzalloc_obj(remote, GFP_ATOMIC);
+	remote = kzalloc_obj(*remote, GFP_ATOMIC);
 	if (!remote) {
 		ret = false;
 		goto null;
diff --git a/drivers/infiniband/hw/hfi2/tid_system.c b/drivers/infiniband/hw/hfi2/tid_system.c
index 11217d02e71c..3745d12828f0 100644
--- a/drivers/infiniband/hw/hfi2/tid_system.c
+++ b/drivers/infiniband/hw/hfi2/tid_system.c
@@ -256,7 +256,7 @@ static int sys_user_buf_init(u16 expected_count, bool notify,
 	if (!IS_ALIGNED(vaddr, max(EXP_TID_ADDR_SIZE, PAGE_SIZE)))
 		return -EINVAL;
 
-	sbuf = kzalloc_obj(sbuf, GFP_KERNEL);
+	sbuf = kzalloc_obj(*sbuf, GFP_KERNEL);
 	if (!sbuf)
 		return -ENOMEM;
 	*tbuf = &sbuf->common;
diff --git a/drivers/infiniband/hw/hfi2/user_exp_rcv.c b/drivers/infiniband/hw/hfi2/user_exp_rcv.c
index 98761a511f5e..7b389da4f248 100644
--- a/drivers/infiniband/hw/hfi2/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi2/user_exp_rcv.c
@@ -229,7 +229,7 @@ static struct hfi2_page_iter *tid_user_buf_iter_begin(struct tid_user_buf *tbuf)
 	if (!tbuf->psets || !tbuf->n_psets)
 		return ERR_PTR(-EINVAL);
 
-	iter = kzalloc_obj(iter, GFP_KERNEL);
+	iter = kzalloc_obj(*iter, GFP_KERNEL);
 	if (!iter)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/drivers/infiniband/hw/hfi2/uverbs.c b/drivers/infiniband/hw/hfi2/uverbs.c
index 8d65dba04d1d..2a829940e9a0 100644
--- a/drivers/infiniband/hw/hfi2/uverbs.c
+++ b/drivers/infiniband/hw/hfi2/uverbs.c
@@ -13,30 +13,42 @@
 
 static const u64 zero8; /* 8 bytes of 0 */
 
+/* rdmavt mmap for CQ/QP/SRQ fallback */
+#include "../../sw/rdmavt/mmap.h"
+
 /*
- * RDMA mmap token: <type> << <page offset>
- *
- * Expect type to be less than 256 (8 bits).  rdmavt reserves the bottom 256
- * tokens for the driver.  A type of zero is always considered invalid.
- * Types >= 256 are used for rdmavt's dynamic token generation.
+ * Insert a driver mmap entry into the rdma_user_mmap infrastructure.
+ * Returns 0 on success and stores the opaque offset in *offset for
+ * userspace to pass back to mmap(2).
  */
-
-/* convert RDMA mmap token to type: the first 8 bits above a page */
-static inline u8 rdma_mmap_get_type(unsigned long token)
+static int hfi2_mmap_entry_insert(struct ib_ucontext *ucontext,
+				  struct hfi2_filedata *fd,
+				  u8 type, size_t length,
+				  u64 address, void *memvirt,
+				  dma_addr_t memdma, u64 *offset)
 {
-	return token >> PAGE_SHIFT;
-}
+	struct hfi2_user_mmap_entry *entry;
+	int ret;
 
-/* calculate the token from an integer offset */
-static inline unsigned long rdma_mmap_token_i(u8 type, unsigned long offset)
-{
-	return ((unsigned long)type << PAGE_SHIFT) | offset_in_page(offset);
-}
+	entry = kzalloc_obj(*entry, GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
 
-/* calculate the token from a pointer offset */
-static inline unsigned long rdma_mmap_token_p(u8 type, void *offset)
-{
-	return rdma_mmap_token_i(type, (unsigned long)offset);
+	entry->address = address;
+	entry->memvirt = memvirt;
+	entry->memdma = memdma;
+	entry->mmap_flag = type;
+
+	ret = rdma_user_mmap_entry_insert(ucontext, &entry->rdma_entry,
+					  length);
+	if (ret) {
+		kfree(entry);
+		return ret;
+	}
+
+	*offset = rdma_user_mmap_get_offset(&entry->rdma_entry);
+	fd->mmap_entries[type] = &entry->rdma_entry;
+	return 0;
 }
 
 int hfi2_alloc_ucontext(struct ib_ucontext *ucontext, struct ib_udata *udata)
@@ -58,9 +70,17 @@ void hfi2_dealloc_ucontext(struct ib_ucontext *ucontext)
 {
 	struct rvt_ucontext *rcontext = container_of(ucontext, struct rvt_ucontext, ibucontext);
 	struct hfi2_filedata *fd;
+	int i;
 
 	fd = rcontext->priv;
 	if (fd) {
+		/* Remove all mmap entries before freeing the filedata */
+		for (i = 0; i < ARRAY_SIZE(fd->mmap_entries); i++) {
+			if (fd->mmap_entries[i]) {
+				rdma_user_mmap_entry_remove(fd->mmap_entries[i]);
+				fd->mmap_entries[i] = NULL;
+			}
+		}
 		hfi2_dealloc_filedata(fd);
 		rcontext->priv = NULL;
 	}
@@ -143,7 +163,6 @@ static int UVERBS_HANDLER(HFI2_METHOD_USER_INFO)(
 	struct hfi2_ctxtdata *uctxt = fd->uctxt;
 	struct hfi2_user_info_rsp rsp = {};
 	struct hfi2_devdata *dd;
-	unsigned long offset;
 
 	if (!uctxt)
 		return -EINVAL;
@@ -159,35 +178,137 @@ static int UVERBS_HANDLER(HFI2_METHOD_USER_INFO)(
 	 * the context's credit return address is mapped.  Calculate the offset
 	 * in the proper page.
 	 */
-	offset = ((u64)uctxt->sc->hw_free -
-		  (u64)dd->cr_base[uctxt->numa_id].va) % PAGE_SIZE;
-	rsp.sc_credits_addr = rdma_mmap_token_i(PIO_CRED, offset);
-	rsp.pio_bufbase = rdma_mmap_token_p(PIO_BUFS, uctxt->sc->base_addr);
-	rsp.pio_bufbase_sop = rdma_mmap_token_p(PIO_BUFS_SOP,
-						uctxt->sc->base_addr);
-	rsp.rcvhdr_bufbase = rdma_mmap_token_p(RCV_HDRQ, uctxt->rcvhdrq);
-	rsp.rcvegr_bufbase = rdma_mmap_token_i(RCV_EGRBUF,
-					       uctxt->egrbufs.rcvtids[0].dma);
-	rsp.sdma_comp_bufbase = rdma_mmap_token_i(SDMA_COMP, 0);
 	/*
-	 * user regs are at
-	 * (RXE_PER_CONTEXT_USER + (ctxt * RXE_PER_CONTEXT_SIZE))
+	 * Replace the old token scheme with rdma_user_mmap_entry_insert().
+	 * Each buffer type gets an entry in the xarray; the opaque offset
+	 * returned to userspace is passed back to mmap(2).
+	 */
+	{
+	struct ib_ucontext *ucontext = ib_uverbs_get_ucontext(attrs);
+	u64 cr_page_offset;
+	u32 cbi, cbc;
+	int ret;
+
+	/* PIO send buffers (write-combine MMIO) */
+	cbi = ctxt_bar_idx(uctxt->sc->hw_context);
+	cbc = ctxt_bar_ctxt(uctxt->sc->hw_context);
+	ret = hfi2_mmap_entry_insert(ucontext, fd, PIO_BUFS,
+		PAGE_ALIGN(uctxt->sc->credits * PIO_BLOCK_SIZE),
+		dd->bar_maps[cbi].physaddr + TXE_PIO_SEND + (cbc * BIT(16)),
+		NULL, 0, &rsp.pio_bufbase);
+	if (ret)
+		return ret;
+
+	ret = hfi2_mmap_entry_insert(ucontext, fd, PIO_BUFS_SOP,
+		PAGE_ALIGN(uctxt->sc->credits * PIO_BLOCK_SIZE),
+		dd->bar_maps[cbi].physaddr + TXE_PIO_SEND +
+			(cbc * BIT(16)) + (TXE_PIO_SIZE / 2),
+		NULL, 0, &rsp.pio_bufbase_sop);
+	if (ret)
+		return ret;
+
+	/*
+	 * PIO credit return (DMA-coherent). If more than 64 contexts are
+	 * enabled, the credit return spans multiple pages; map only the page
+	 * containing this context's credit return address.
+	 */
+	cr_page_offset = ((u64)uctxt->sc->hw_free -
+			  (u64)dd->cr_base[uctxt->numa_id].va) & PAGE_MASK;
+	ret = hfi2_mmap_entry_insert(ucontext, fd, PIO_CRED, PAGE_SIZE, 0,
+		(void *)dd->cr_base[uctxt->numa_id].va + cr_page_offset,
+		dd->cr_base[uctxt->numa_id].dma + cr_page_offset,
+		&rsp.sc_credits_addr);
+	if (ret)
+		return ret;
+
+	/* Receive header queue (DMA-coherent) */
+	ret = hfi2_mmap_entry_insert(ucontext, fd, RCV_HDRQ,
+		rcvhdrq_size(uctxt), 0, uctxt->rcvhdrq,
+		uctxt->rcvhdrq_dma, &rsp.rcvhdr_bufbase);
+	if (ret)
+		return ret;
+
+	/* Receive eager buffers (DMA-coherent, multi-segment) */
+	ret = hfi2_mmap_entry_insert(ucontext, fd, RCV_EGRBUF,
+		uctxt->egrbufs.size, 0, NULL, 0, &rsp.rcvegr_bufbase);
+	if (ret)
+		return ret;
+
+	/* SDMA completion queue (vmalloc'd) */
+	ret = hfi2_mmap_entry_insert(ucontext, fd, SDMA_COMP,
+		PAGE_ALIGN(sizeof(*fd->cq->comps) * fd->cq->nentries),
+		(u64)fd->cq->comps, NULL, 0, &rsp.sdma_comp_bufbase);
+	if (ret)
+		return ret;
+
+	/*
+	 * User registers (non-cached MMIO).
+	 * RcvHdrTail is the first register in the hardware UCTXT block.
 	 */
-	rsp.user_regbase = rdma_mmap_token_i(UREGS, 0);
-	offset = offset_in_page((uctxt_offset(uctxt) + fd->subctxt) *
-				sizeof(*dd->events));
-	rsp.events_bufbase = rdma_mmap_token_i(EVENTS, offset);
-	rsp.status_bufbase = rdma_mmap_token_p(STATUS, dd->status);
-	if (HFI2_CAP_IS_USET(DMA_RTAIL))
-		rsp.rcvhdrtail_base = rdma_mmap_token_i(RTAIL, 0);
+	cbi = ctxt_bar_idx(uctxt->ctxt);
+	cbc = ctxt_bar_ctxt(uctxt->ctxt);
+	ret = hfi2_mmap_entry_insert(ucontext, fd, UREGS,
+		dd->params->rxe_uctxt_stride,
+		(u64)dd->bar_maps[cbi].physaddr + dd->params->rcv_hdr_tail_reg +
+			(cbc * dd->params->rxe_uctxt_stride),
+		NULL, 0, &rsp.user_regbase);
+	if (ret)
+		return ret;
+
+	/* Events page (vmalloc'd) */
+	ret = hfi2_mmap_entry_insert(ucontext, fd, EVENTS, PAGE_SIZE,
+		(unsigned long)(dd->events + uctxt_offset(uctxt)) & PAGE_MASK,
+		NULL, 0, &rsp.events_bufbase);
+	if (ret)
+		return ret;
+
+	/* Status page (kernel virtual) */
+	ret = hfi2_mmap_entry_insert(ucontext, fd, STATUS, PAGE_SIZE,
+		0, (void *)dd->status, 0, &rsp.status_bufbase);
+	if (ret)
+		return ret;
+
+	/* Receive header tail (DMA-coherent) */
+	if (HFI2_CAP_IS_USET(DMA_RTAIL)) {
+		ret = hfi2_mmap_entry_insert(ucontext, fd, RTAIL, PAGE_SIZE, 0,
+			(void *)hfi2_rcvhdrtail_kvaddr(uctxt),
+			uctxt->rcvhdrqtailaddr_dma, &rsp.rcvhdrtail_base);
+		if (ret)
+			return ret;
+	}
+
+	/* Sub-context shared regions (vmalloc'd) */
 	if (uctxt->subctxt_cnt) {
-		rsp.subctxt_uregbase = rdma_mmap_token_i(SUBCTXT_UREGS, 0);
-		rsp.subctxt_rcvhdrbuf = rdma_mmap_token_i(SUBCTXT_RCV_HDRQ, 0);
-		rsp.subctxt_rcvegrbuf = rdma_mmap_token_i(SUBCTXT_EGRBUF, 0);
+		ret = hfi2_mmap_entry_insert(ucontext, fd, SUBCTXT_UREGS,
+			PAGE_SIZE, (u64)uctxt->subctxt_uregbase,
+			NULL, 0, &rsp.subctxt_uregbase);
+		if (ret)
+			return ret;
+
+		ret = hfi2_mmap_entry_insert(ucontext, fd, SUBCTXT_RCV_HDRQ,
+			rcvhdrq_size(uctxt) * uctxt->subctxt_cnt,
+			(u64)uctxt->subctxt_rcvhdr_base,
+			NULL, 0, &rsp.subctxt_rcvhdrbuf);
+		if (ret)
+			return ret;
+
+		ret = hfi2_mmap_entry_insert(ucontext, fd, SUBCTXT_EGRBUF,
+			uctxt->egrbufs.size * uctxt->subctxt_cnt,
+			(u64)uctxt->subctxt_rcvegrbuf,
+			NULL, 0, &rsp.subctxt_rcvegrbuf);
+		if (ret)
+			return ret;
 	}
 
-	if (dd->params->chip_type != CHIP_WFR)
-		rsp.rheq_bufbase = rdma_mmap_token_p(RCV_RHEQ, uctxt->rcvhdrq);
+	/* Receive header error queue (DMA-coherent, JKR only) */
+	if (dd->params->chip_type != CHIP_WFR) {
+		ret = hfi2_mmap_entry_insert(ucontext, fd, RCV_RHEQ,
+			rheq_size(uctxt), 0, uctxt->rheq,
+			uctxt->rheq_dma, &rsp.rheq_bufbase);
+		if (ret)
+			return ret;
+	}
+	}
 
 	return uverbs_copy_to(attrs, HFI2_ATTR_USER_INFO_RSP, &rsp,
 			      sizeof(rsp));
@@ -572,20 +693,37 @@ const struct uapi_definition hfi2_ib_defs[] = {
 	{}
 };
 
-int hfi2_rdma_mmap(struct ib_ucontext *ucontext, struct vm_area_struct *vma)
+int hfi2_mmap(struct ib_ucontext *ucontext, struct vm_area_struct *vma)
 {
 	struct rvt_ucontext *rcontext = container_of(ucontext, struct rvt_ucontext, ibucontext);
 	struct hfi2_filedata *fd = rcontext->priv;
-	unsigned long token;
-	u8 type;
+	struct rdma_user_mmap_entry *rdma_entry;
+	struct hfi2_user_mmap_entry *entry;
+	int ret;
 
-	if (!fd)
-		return -EINVAL;
+	/*
+	 * Try to look up the offset in the rdma_user_mmap xarray.
+	 * If found, this is a driver data-path buffer mmap.
+	 */
+	rdma_entry = rdma_user_mmap_entry_get(ucontext, vma);
+	if (rdma_entry) {
+		entry = to_hfi2_mmap(rdma_entry);
+		ret = hfi2_do_mmap(fd, entry->mmap_flag, vma, rdma_entry,
+				   ucontext);
+		rdma_user_mmap_entry_put(rdma_entry);
+		return ret;
+	}
 
-	token = vma->vm_pgoff << PAGE_SHIFT;
-	type = rdma_mmap_get_type(token);
+	/*
+	 * Not a driver entry -- fall through to rdmavt for CQ/QP/SRQ
+	 * mmap handling.
+	 */
+	return rvt_mmap(ucontext, vma);
+}
 
-	return hfi2_do_mmap(fd, type, vma);
+void hfi2_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
+{
+	kfree(to_hfi2_mmap(rdma_entry));
 }
 
 ssize_t hfi2_uverbs_write_iter(struct ib_ucontext *ucontext,
diff --git a/drivers/infiniband/hw/hfi2/uverbs.h b/drivers/infiniband/hw/hfi2/uverbs.h
index 2250a712875c..251c82462159 100644
--- a/drivers/infiniband/hw/hfi2/uverbs.h
+++ b/drivers/infiniband/hw/hfi2/uverbs.h
@@ -7,10 +7,32 @@
 #define HFI2_UVERBS_H
 
 #include <rdma/uverbs_ioctl.h>
+#include <rdma/ib_verbs.h>
+
+/*
+ * Driver-specific mmap entry, embedding the core rdma_user_mmap_entry.
+ * One entry is created per mappable region and tracked for the lifetime
+ * of the user context.
+ */
+struct hfi2_user_mmap_entry {
+	struct rdma_user_mmap_entry rdma_entry;
+	u64 address;
+	void *memvirt;
+	dma_addr_t memdma;
+	u8 mmap_flag;
+};
+
+static inline struct hfi2_user_mmap_entry *
+to_hfi2_mmap(struct rdma_user_mmap_entry *rdma_entry)
+{
+	return container_of(rdma_entry, struct hfi2_user_mmap_entry,
+			    rdma_entry);
+}
 
 int hfi2_alloc_ucontext(struct ib_ucontext *ucontext, struct ib_udata *udata);
 void hfi2_dealloc_ucontext(struct ib_ucontext *ucontext);
-int hfi2_rdma_mmap(struct ib_ucontext *ucontext, struct vm_area_struct *vma);
+int hfi2_mmap(struct ib_ucontext *ucontext, struct vm_area_struct *vma);
+void hfi2_mmap_free(struct rdma_user_mmap_entry *rdma_entry);
 ssize_t hfi2_uverbs_write_iter(struct ib_ucontext *ucontext,
 			       struct iov_iter *from);
 
diff --git a/drivers/infiniband/hw/hfi2/verbs.c b/drivers/infiniband/hw/hfi2/verbs.c
index 77ace101fe88..fe50706622f6 100644
--- a/drivers/infiniband/hw/hfi2/verbs.c
+++ b/drivers/infiniband/hw/hfi2/verbs.c
@@ -1832,6 +1832,8 @@ static const struct ib_device_ops hfi2_dev_ops = {
 	.process_mad = hfi2_process_mad,
 	.rdma_netdev_get_params = hfi2_ipoib_rn_get_params,
 	.write_iter = hfi2_uverbs_write_iter,
+	.mmap = hfi2_mmap,
+	.mmap_free = hfi2_mmap_free,
 };
 
 static const struct ib_device_ops cport_dev_ops = {
@@ -1865,6 +1867,8 @@ static const struct ib_device_ops vf_dev_ops = {
 	/* keep process mad in the driver */
 	.process_mad = vf_process_mad,
 	.rdma_netdev_get_params = hfi2_ipoib_rn_get_params,
+	.mmap = hfi2_mmap,
+	.mmap_free = hfi2_mmap_free,
 };
 
 /**
@@ -1999,7 +2003,7 @@ int hfi2_register_ib_device(struct hfi2_devdata *dd)
 						hfi2_comp_vect_mappings_lookup;
 	dd->verbs_dev.rdi.driver_f.alloc_ucontext = hfi2_alloc_ucontext;
 	dd->verbs_dev.rdi.driver_f.dealloc_ucontext = hfi2_dealloc_ucontext;
-	dd->verbs_dev.rdi.driver_f.mmap = hfi2_rdma_mmap;
+	/* mmap is registered via ib_device_ops, not driver_f */
 
 	/* completeion queue */
 	dd->verbs_dev.rdi.ibdev.num_comp_vectors = dd->comp_vect_possible_cpus;
diff --git a/drivers/infiniband/hw/hfi2/vf2pf_lb.c b/drivers/infiniband/hw/hfi2/vf2pf_lb.c
index 944c0a9e0670..87704e874bbb 100644
--- a/drivers/infiniband/hw/hfi2/vf2pf_lb.c
+++ b/drivers/infiniband/hw/hfi2/vf2pf_lb.c
@@ -482,7 +482,7 @@ static int lb_init(struct hfi2_devdata *dd, u8 si)
 	if (si == VF2PF_INIT_ALL)
 		return lb_init_vfs(dd);
 
-	lbd = kzalloc_obj(lbd, GFP_KERNEL);
+	lbd = kzalloc_obj(*lbd, GFP_KERNEL);
 	if (!lbd)
 		return -ENOMEM;
 
diff --git a/drivers/infiniband/sw/rdmavt/mmap.c b/drivers/infiniband/sw/rdmavt/mmap.c
index 473f464f33fa..6f9d127b3bc9 100644
--- a/drivers/infiniband/sw/rdmavt/mmap.c
+++ b/drivers/infiniband/sw/rdmavt/mmap.c
@@ -115,6 +115,7 @@ int rvt_mmap(struct ib_ucontext *context, struct vm_area_struct *vma)
 done:
 	return ret;
 }
+EXPORT_SYMBOL(rvt_mmap);
 
 /**
  * rvt_create_mmap_info - allocate information for hfi1_mmap



