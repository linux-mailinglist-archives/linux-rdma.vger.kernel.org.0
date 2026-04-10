Return-Path: <linux-rdma+bounces-19216-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AI2QLWJI2WlToAgAu9opvQ
	(envelope-from <linux-rdma+bounces-19216-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 20:58:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EA53DBB89
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 20:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C2F03012D72
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 18:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED80F31B80D;
	Fri, 10 Apr 2026 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="ICmrbY1+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020101.outbound.protection.outlook.com [52.101.193.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB17733D51B
	for <linux-rdma@vger.kernel.org>; Fri, 10 Apr 2026 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775847514; cv=fail; b=oL8iDOElfiRfI1CD6n3FG1LG9NSFBePV4yoMUa+qEBWmqTPz7t7rxsx5glagQnPqzSsFPrGMn7nlI8+aEC8zV7qM1FtHzn3X3zPpHlb5Fh++LWwG4QUW13I0YOuF7SA2j8todY87rqTN+foq0fMk4GCpLU5Ummpi76tYyEY0XQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775847514; c=relaxed/simple;
	bh=uVsXNjXwHvR85TT2wq4Mb6kfnmjmTyew49wE4SfuLE4=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=N/PX12Kzcr9XS7i+OmgejT44XM4a3bnQyOAG1ElywoAFQKxNEaPUgH1LN87vPz3IQ/yJgEdZVljWG/4XhkII+oZ/rVCX2GNbJGYcMjZXL7/EctdPAcOminEFQkYXlJr9NolNJgs1ee+n0FPja4MLoVI+2bQk/9CgGRBOzEIlxg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=ICmrbY1+; arc=fail smtp.client-ip=52.101.193.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aijh0r1CPH6u52AF3apIHqFxMgpVwZwSLzCuiDKL5a81ytRkQWy8BaIZTw7k/nR9+kE7DOOE6v59otsUdLP//KOCqcDIDQYqotSJCBZ3vz5vLn44ht3fPXSVVdSlR8yP03JHTbt5df9BtkqHKv8ZW/CAdifuiQe9y6Fy2w7Gv9GoMUJEtsSRhe5969/0OOlBVgViyBmt6FHO46+ft1tJYe7UQFHfUvdoJZOvGQH+ybe8+omb7ffVa0Yg84xPwhkr2T47nrLN7oMjPoQ8k7XS6ZL6V3Vc+L4wzUx9MO2uyV0IiAyvTdediyQ+86j9sO8TdcuFv3CYbxOn70Ls5Xrs/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfXY6xKVDt8t0r6D+T7o6GEtxCqCKaIPVuTCG9RiOXw=;
 b=UvDJu0Phi1Pu6iNGY8k3M02XqeCj3GZbgTrpQbjVspSXZ5fQNMoy0udyHQrcyuL+eTQBOXZ49KDGex+ToY3cW/WASBdBuLP3v+u1V273fsdnc1bnUj1yO8ukcZVe5ltzE7elISEHC9srFqPE6D+eCH4/ubS926256myBJF2LIKWLa5SL8Hhu1A41A1beI4lRBKEc38T3jktwAgYZkbgg+G3xTuUy72QE7ZaPdJHwiO9asmUKvi+IyyDSIN7ZYgf8lbE1GkPEHyVsrbXEijKqfCc4tlL3IjMMT12G6miYsG3GWuvofb26u3xGKp90z5Vz2PTNsYtvqfWHwGCmt0npqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.148.235.34) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfXY6xKVDt8t0r6D+T7o6GEtxCqCKaIPVuTCG9RiOXw=;
 b=ICmrbY1+Q24nQyzanNoshs7VtDvUB7JiWK3S8hXI3gpfn9ekuaJ8EVOexiWy8cdRaTFeg3ppf+j1e1qmHHEz4OYmbtnKiqO67MOYIyfaX03kBQKn3vIuBs9EZNbgS/+rexb7ovSEKKrsuiLhqOwxQifndx7K1EFjUj7Pj0fxkq4zfR4FdUIz17H8acFDeX7N3dWJ1YFjHoqvojc6RN2daT+yCxrI8G1V/r2j7898hSyXt/AfATl85CoiYpYcXzauWnTE7I6RD6U9TR4aIKav6kqvtFaGT9JrDU0+2fzsRnbnxu4bjyyL60XNUbGYG21DA04xxrE5bKinLjiMAFasow==
Received: from SN7PR18CA0016.namprd18.prod.outlook.com (2603:10b6:806:f3::20)
 by DS1PR01MB8773.prod.exchangelabs.com (2603:10b6:8:220::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.41; Fri, 10 Apr 2026 18:58:27 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:f3:cafe::ed) by SN7PR18CA0016.outlook.office365.com
 (2603:10b6:806:f3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.43 via Frontend Transport; Fri,
 10 Apr 2026 18:58:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.148.235.34)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=cornelisnetworks.com;
Received-SPF: Fail (protection.outlook.com: domain of cornelisnetworks.com
 does not designate 50.148.235.34 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.148.235.34;
 helo=cn-mailer-00.localdomain;
Received: from cn-mailer-00.localdomain (50.148.235.34) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 10 Apr 2026 18:58:26 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id 12B661470B9;
	Fri, 10 Apr 2026 14:58:26 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id EAB69181263AA;
	Fri, 10 Apr 2026 14:58:25 -0400 (EDT)
Subject: [PATCH for-next] RDMA/umem: Initialize iova for dmabuf umem
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Nick Child <nchild@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Fri, 10 Apr 2026 14:58:25 -0400
Message-ID:
 <177584750586.341184.13583748105422169656.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|DS1PR01MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: 867be72a-0756-412d-cc5e-08de973325d3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	nLQYogWmhQWWTYbgW9GAkowEX9XsfJv0PWDSdahE8KVokOAvh8FwUx+M2RaoWJrD2aN5vvU2StD20xlHo+oCe7wkG+r8XDPTiGI1GsVNqM1p0/PQY249QtDlsW6P5vAFwyUr/6l83DcccRbq76V8qIh52zLptjcwfPEbV7//AwRYmgqA1KXIAGxzscI+RdnoLhl48UnI5EJhPywlhlby8Qet7de12a8icaf4ED1yRPTHerMHlpVAiLbZPjxtgO31+zuhYSLwrr2B5DZt+zzBvvfyQinLwtF7lEUHs4ooaY8kFLeCqeES4gYIrfZ9ZAtMAH0LpWYo42Hj39jrg5kgEQIOSy18iSbVd9UIZBVNrmzYNN72FP2XerWka5FX2wo8dLRKR0OIa9zAHJ4Z7G0tReotR9II4UQ05Bt+lxlGbJvYp9Mj+e+7WpPs5+g04kdQi8Yzd0wTh7FagOzLilOwcslnDU4U+js0zaRa2FBCzyaCRUUHAxjlLgHj5BqVOtYJhk/eZTDdZ/aX9TGZeSGZybswDwOwRcHQZgc0I/eO5X6i815wISdD8DnFpdabFviWqM2RuJJNWGIlPgM+Z5vXKiL3LXPVMnhNC1/Z30hq743HdPcGGbRuR6HU2bX1Q5vmksjkEyfFvzYgUSSjX3KpvyzdDmcrS53jZBnBET0bBa6NWPcpnesVaoyQSSmwp8B1jeqQ9B1PeyMv6MHopEz2qJTKnT9H/0mfXdApvXNMvI8i/CCPI5pFxa3krX3ayIe/skVNmKBm8eTt5kYv8zXmig==
X-Forefront-Antispam-Report:
	CIP:50.148.235.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:c-50-148-235-34.hsd1.mn.comcast.net;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	auT8wsMWbqxZUjyyEAVeYCe6YkYku/zkhKZjybGSu03pUWgTAdnbYdFpkvke9ILIhDBP/x/M7f4lxaxfJ9BW19yF9EkWvvCjAOjAZ53y42hEwn8yOgizO9as30jRvUGP1y0Yo/zrtgRLdA8jJXe1H9TMZUhhOxsdPAnx3QLgupoEqJETsQz1pglbcbwaYA8bXc1LAtDDdu++ue2l3sj9WPDiVezUPt70CiU3+AqsiMF5D1b0SqwlbHag+O5j3rDqjtJMCzNVyZggArZFdVo/aFsmr3BjnNGjvvjtn54u9OzhKUKqfOxDf6y35MOJdjOJxL05HNj+VOCc8EZ0UIfWvVIYY6T12ylw/sNAH15nY06ueKq81L4MUiB1peSn9oS1ssJVg+Hn1oRskWuaSpbn1ffm/mvoeTisSJsHtyMnyl4o8ceyVngZ+zoaZaBthW/t
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 18:58:26.5701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 867be72a-0756-412d-cc5e-08de973325d3
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[50.148.235.34];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8773
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-19216-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cornelisnetworks.com:dkim,cornelisnetworks.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 65EA53DBB89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nick Child <nchild@cornelisnetworks.com>

Ensure iova is initialized in ib_umem_dmabuf_get_with_dma_device(),
otherwise calculation erors can occur in ib_umem_num_dma_blocks() and
dependent functions like rdma_umem_for_each_dma_block() won't iterate
properly.

As of commit 4fbc3a52cd4d ("RDMA/core: Fix umem iterator when PAGE_SIZE is
greater then HCA pgsz") rdma_umem_for_each_dma_block() iterates at most
ib_umem_num_dma_blocks() times. ib_umem_num_dma_blocks() calculates the
number of blocks by extending iova + length to page boundaries.
Previously, a call to ib_umem_dmabuf_get_pinned_with_dma_device() followed
by rdma_umem_for_each_dma_block() would leave iova uninitialized and
iteration would only cover a subset of blocks if the memory did not
begin on a boundary.

For example, if page size is 4096 and a dmabuf is registered with offset
512 and length 4096 then ib_umem_num_dma_blocks() would previously (and
incorrectly) return 1.

Defaulting the iova to the offset value is okay since it can be adjusted
later via ib_umem_find_best_pgsz().

Fixes: 4fbc3a52cd4d ("RDMA/core: Fix umem iterator when PAGE_SIZE is greater then HCA pgsz")
Signed-off-by: Nick Child <nchild@cornelisnetworks.com>
---
 drivers/infiniband/core/umem_dmabuf.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index f5298c33e581..f6b7ae4ee2db 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -146,6 +146,11 @@ ib_umem_dmabuf_get_with_dma_device(struct ib_device *device,
 	umem->ibdev = device;
 	umem->length = size;
 	umem->address = offset;
+	/*
+	 * Drivers should call ib_umem_find_best_pgsz() to set the iova
+	 * correctly.
+	 */
+	umem->iova = offset;
 	umem->writable = ib_access_writable(access);
 	umem->is_dmabuf = 1;
 



