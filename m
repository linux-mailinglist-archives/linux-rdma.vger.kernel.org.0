Return-Path: <linux-rdma+bounces-21587-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMajFgS5HWrKdAkAu9opvQ
	(envelope-from <linux-rdma+bounces-21587-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 18:53:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6395622D72
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 18:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BC6A30128FC
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 16:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A039D37F74A;
	Mon,  1 Jun 2026 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gL6OFnHp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7804B32863D;
	Mon,  1 Jun 2026 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780332766; cv=fail; b=qs3BbINBJlfW9m4W8VM5OJqWM3XXgKorf4avDLB7Ibf0nADFHPs73tjf4ZWs99ou7EUxvchiCe7dOFDMm31+v8XlXIGAOVkRB6d8VU57WcUS9dYuCcc/qK/OB6Z8ETFmgndf7vBcK80lgPLy66jZBrT31mxvgNcmCqwAUefP+Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780332766; c=relaxed/simple;
	bh=zQupztFJJZiwpCy8iO4H6q9L4tChbIMU6k+uCgoVIkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nDp5FYfBO/Db756O1d+7NpG7s/mbmGjtaB17jnIRYyRqEOGv1dgZVvRDhIanBOqyhJg9LuuGMJiW/UFps3+PHLlxZw1E0CMiNhORwCjHtRO0c0clBwcmpHDbW+bwiJFZdnLAEUM/ZToVQR3TujJ0Y1HBlJpr0YxEasd/XPaGg2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gL6OFnHp; arc=fail smtp.client-ip=52.101.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjcB8Gjx5ajfgHqPoP/cKvuBM+a4nYk0W8aRLdt6lwd9mTf2dZUOc0cCjGsy3w2TW8ypJ+qVYIZpWps5AU1/G8D1tsxlOZhCj27JuMZpK8+Q4ARQFUate8T3bcaFPLZcl1EQ2+kMi74ekNmlpyyJfTWmYDRyhb1+ib0ksjFWEobJzUEkk51Y4IWzjiydIhxVGa/hrAUYM0j/gGGQA5+1871/qBYDNk837xC2BxLxd5iflfMHV9GP1VN43LarIfB7rvo4XtZAUFGY2D3nvs8b5Kxwx+xrLq0QEsLmxOsWxScrOEnisa0nA+tPQZNppdQBZMZMcwrLINKE4jtZ/eJMdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpy/DHd/au9Cp49Z62ZPg1wXc8xZ93N81yOeI9EVOqg=;
 b=V7Y5vyvfFSu2hok4Zkk8LgLXD+7FFODaCRY6BdxHVDhXtDXHVOoJMUohxzcwctqjdnCz+iVnC8sJdaXmr6yIM2AbDJxDTOMHqWNADhqh7KxTId0x5R1CT2WgrsM2Iw1XkHDjmVO8FYq+9p/8hvc2FNH1Rjd3v65PHi94PDzXBsEwgxxugS9Pg5Fy96/iUCMWrZ8NOCJ/bY40p5XXFkDsbbj5ZbezlxOP8Vqq2ZjpAbZxWOg4okXzg739a4WnUN8uv5G0IG0SN/vuWu8SZ8Nny1XIMneePDPKKnKNCdCw9f4FcOoP5BudtyAuAs4hyVgK8mv9HEGyjdwG0KSlla12/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpy/DHd/au9Cp49Z62ZPg1wXc8xZ93N81yOeI9EVOqg=;
 b=gL6OFnHp1+E1tpMtOU104sMGAG7BjiANuFkzlE26Ju4RH7BdMz2Z+OYw/IA0oK62Ob6LkIjswP2wmKVeYR2yzKCy5q1Xug8mbykWmU5aIWy4QAtlT0eigyTjkdDvYib65nkbTlALHclIHHyJ0tXU+eQn6SlAgRyeP5aBCvz/UiXwCJ+Deugni5alaU01nw8UJDJQ/Kz+HXQIJJk9GQd9acjdtsgZoFMKCChkJHSY+hzPPjUJOBb1oD+sMuN4qunMWWjfjOA36TKHNELI18sUirC5UcBh5fNN5TgGkw8RNPfKvCUCBCzysVzW4JvGvEWLx2KOnZa/11u8z8ltAgmwCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 16:52:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 16:52:35 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: patches@lists.linux.dev,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] RDMA/umem: Be careful about boundary conditions in ib_umem_find_best_pgsz()
Date: Mon,  1 Jun 2026 13:52:32 -0300
Message-ID: <2-v1-88303e9e509f+f7-ib_umem_types_jgg@nvidia.com>
In-Reply-To: <0-v1-88303e9e509f+f7-ib_umem_types_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: 210592f1-04cb-4108-e178-08debffe2ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xqNpeUAOYLM1uNi1I/jW7pt5WZQfAI++VhUh7fBAw+9d6hjM8jWeXVyVyQrvdgcYBPuelPDNMvn82AqUL6IiUZ4VQDj8IaQeNASp0ANjRcRuVOx8M+DmU/6FS+jOqccAYWEpwe5BBRnHToVo2ckaEkEzp/PM3HJy2WJvBlrz6ThwujX4RUTPMjSRdcJ1I2C90HL2Qlh6J0a/YCdNqLWP+UtZhepm/ayyXs8p0gLr466Zwx7mVo9+5zWX0X+R/B5ZyABvIpVibV+xz6Pu7g6/7UF7Ckq+Xci5kHvCco3BJsTEmOfOacszhVrWz/dEPXvG6jEKu5WeU6kpeSaRYY2bMuEOx0hvsIV6iKbpEOx+hwKzc2x+O1F3Lz7BPkIFWPgpSmt4v4dms+8M/Xp/lyPplpT32hzpFGU3LioiEW2mXCEf84qQyvF/09YCXQmQ/9bZmyJkq6N06cAf41UbqM+PQgCiWpA1gDhsp/StRR/XazzanhBXyLOrfUxdBshbieGemGDIx/sc5AqfcDw2ycwAgpIwuCIk53YGxAUwNnz+7zVa6eH6ghkH5HlCzbx2dae4+A3tikkSYRaxK0+TsyfFfKPZkXMfnI3JrBKM6SdDBwcmEShZNSoeVudG8V3Nrou/MNxAvq9L1XVTM148CuTqBN+dJ85XoeeleyCxb3qNAznuhDyEjk5SYc9cQBlEltGe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RO+vaPeEryrnSqtMqP5MstK5OkFSscPNussYQ3plT6FEuS5tav05L0lT7U1H?=
 =?us-ascii?Q?Vxq5zaJRDxJSSLSQLp6OFE79PNZriKrT5tVb32lAvethAxdth3ZYfMC68RJk?=
 =?us-ascii?Q?1g3nnO59txWOrtnMJ/etZeJ/42JCzPqGXDRXIV4gaewtAwOQYLR/xTEYJgvG?=
 =?us-ascii?Q?Nq/gfN9pJRyAbz8+7EcGlKeVVWjW4TYKGFc8tcnrIrEA5JdOjRZM52JqjnL/?=
 =?us-ascii?Q?bCtWDHwv6sjhMI3hpGCLVrTQ5+YXyZMRF0Tx2aAlTHRK086WeDnOkKVPndrV?=
 =?us-ascii?Q?iWWnvzIsP5izCgkIwIcltNRz3OAuM9kMpvh7rHRYFD6L7CHgogFEIA7xfUU+?=
 =?us-ascii?Q?JKtKoLlU37/4adDEL6ZNR3hIG5NOjLsWZWMfMlr31goeSYHkLTC3C8EG97pV?=
 =?us-ascii?Q?HNbNGugx45ZmFerjtaapBFIJd9bDsw0jhOlGEjjeVrGy82s9/HBawsNKMlLl?=
 =?us-ascii?Q?2pIek4sou9B0Meey6PtL4sdq2TRQ2IU/5QDEtqAVTB9yyTDsz9EGEpjbOvEK?=
 =?us-ascii?Q?QDbkvLRGwQAPLn/69jBl/CxC7Ge6A+IZ8FMRo1l0tSoUK/fPhLCoiKEh+Bus?=
 =?us-ascii?Q?XFSnSc+P4MdTOlscptTjfaVzeI8yrttGIGi+vzbNvPoywYrsOfopL8R+aRL3?=
 =?us-ascii?Q?BuO6+tu77AE0o8UkYUnI/mdx1suQx0juR9d6Ok1Ktbvd+vviBhDkVVnhqePX?=
 =?us-ascii?Q?FhCDzMXdoY05XcqIcmjbwzlmTzafq0UotP3fKgRGYHrq5fDRSSPSnGMJdV7w?=
 =?us-ascii?Q?hcbrVjpGg5MEsefUpp7shr212KNja03w9b89YsJ6mrdCWi6YizodQIF7hmk8?=
 =?us-ascii?Q?IoxhzIfG8GTv1hMYebkNcPjN4CLnOop4vo3g/N0MdeaN+R1XBxk09PeM07dM?=
 =?us-ascii?Q?dmW+xS2VD8WGW/M4dfqZdwGGTotGFbDK6K0ZH96yfXJogoyX+CInKWTwDKro?=
 =?us-ascii?Q?rjEHRmEY7rb01nXydWcBwXSHJmjc/xBpdql/X8PmoKGg4XUj8IBa0z+32AMP?=
 =?us-ascii?Q?yYiG8RMdOYJXqmhFjdE9ZE/hRbDqBiSpxGlN059OBrWUJFuGCMLEobi6IEpk?=
 =?us-ascii?Q?Hu2vV9Zdjf7nv+h1AVzFrYq1n1RW1qpqxMbzvQHijveuAO7gBB8b52JYgYWh?=
 =?us-ascii?Q?4sVVYps4iY16K+RyBanztvnOj+AX5f0q0m2PlSZGXfJKGuSB8REJXM+VMxu6?=
 =?us-ascii?Q?Qfl46yXKwuAQ6i3tQqDjTNuSr1/LfF8bADHbQvUwa1AcYjCW26xHOXAOoiYE?=
 =?us-ascii?Q?wOcj+wVVoAYDZwcwfUx+hLwmbA3RcHeZjRNnBNtyKjSj6R5AySkcDLnCNIRL?=
 =?us-ascii?Q?hXJPQqzFWx1Cs4GKIZMbRF7XbPWj/OCeqsKDskBR2QjinbInJ7y4CHAzuiud?=
 =?us-ascii?Q?5lBEPx9F2HkkDZw/0pmR+YddVmeFen3SeA1mF931xOYCaW+btl8YL8HJRc7o?=
 =?us-ascii?Q?dcrF0hpsVoP6+2TCFSrnzumx0I/c06NGhihqpZcRfGlvbO2ySRAW2nOTWNne?=
 =?us-ascii?Q?+U0F/F+1o38K8jeWdxI4ulVgAJSxFnvvcisqCIxDrl08DR+fq5qP8pTtGlSY?=
 =?us-ascii?Q?AYz6omioN8hK5ziS40DXqX/AU7mPmlfzh8ysVdYadEbNgUEmeb0zY5+xu7E2?=
 =?us-ascii?Q?JStUM5pUx9m0dNSewkMSlePFi8Wy4oS/A2SOB06x/w6G1t0kEy3wdyfrWGRF?=
 =?us-ascii?Q?S71ZJh1HIjZBP09vMmOli4dD5Etmfwm+CKrmAxYETzsoYqCI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210592f1-04cb-4108-e178-08debffe2ddd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 16:52:34.8278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VzEID0iqIV6iwGlQ2wnQor4n/8XnfXDG3fKwzGUAHv63aOTDT1lJHThDp5e8+2o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9733
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21587-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: C6395622D72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Several corner cases, especially important on 32 bits:

- umem->iova is u64, the function argument should pass in u64 or
  iova will be truncated
- Check that the length is not too large for the iova
- Check that lengths > 4G don't overflow the GENMASK

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/umem.c | 18 ++++++++++++------
 include/rdma/ib_umem.h         |  4 ++--
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index e424a9de66c177..fd8f3888da5227 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -84,14 +84,17 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
  */
 unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 				     unsigned long pgsz_bitmap,
-				     unsigned long virt)
+				     u64 virt)
 {
 	unsigned long curr_len = 0;
 	dma_addr_t curr_base = ~0;
-	unsigned long va, pgoff;
+	unsigned long pgoff;
 	struct scatterlist *sg;
-	dma_addr_t mask;
+	unsigned long mask = 0;
+	unsigned int bits;
 	dma_addr_t end;
+	u64 last_va;
+	u64 va;
 	int i;
 
 	umem->iova = va = virt;
@@ -109,9 +112,12 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 	 * number of required pages. Compute the largest page size that could
 	 * work based on VA address bits that don't change.
 	 */
-	mask = pgsz_bitmap &
-	       GENMASK(BITS_PER_LONG - 1,
-		       bits_per((umem->length - 1 + virt) ^ virt));
+	if (check_add_overflow(umem->length - 1, virt, &last_va))
+		return 0;
+	bits = bits_per(virt ^ last_va);
+	if (bits < BITS_PER_LONG)
+		mask = pgsz_bitmap & GENMASK(BITS_PER_LONG - 1, bits);
+
 	/* offset into first SGL */
 	pgoff = umem->address & ~PAGE_MASK;
 
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index bc1e6ed73b3f49..4c8f433ba246f3 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -109,7 +109,7 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		      size_t length);
 unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 				     unsigned long pgsz_bitmap,
-				     unsigned long virt);
+				     u64 virt);
 
 /**
  * ib_umem_find_best_pgoff - Find best HW page size
@@ -234,7 +234,7 @@ static inline int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offs
 }
 static inline unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 						   unsigned long pgsz_bitmap,
-						   unsigned long virt)
+						   u64 virt)
 {
 	return 0;
 }
-- 
2.43.0


