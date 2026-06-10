Return-Path: <linux-rdma+bounces-22048-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 44+IOsWpKGqKHgMAu9opvQ
	(envelope-from <linux-rdma+bounces-22048-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:03:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AACA1664E11
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:03:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=XmXrcCD5;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22048-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22048-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 273B13018D48
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 00:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEA48287E;
	Wed, 10 Jun 2026 00:03:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9420B8C1F
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 00:03:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781049795; cv=fail; b=p+wodg9reDeBnTEYZ5cd7Wd07aXkxBI7fNhAhvj0kMW0Ko5n5djN49AXboY3RRDASIx1vmW+1rN+hZvfSXnOrxdYqelsv/Abp3oGcZXKgOI6Vi7IoeE/aGWzj3+GbVzyAavnseonhDCFy44Y12DEw3lPotuU0JN8i8VtqWPRnuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781049795; c=relaxed/simple;
	bh=NLsG0+9n6CevKRmJKjDCtSHAjsVYIO0kXRJmWDfpWbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JVmeQQ4KxqqHZ4QPyNQ1aKa5Lm8MsG4G/D2CQeN+sQT1yznCmibl7G668HOEOZCzO8oR+7ThRIw4bqja/zaXn/OXUiZhsW9MOZb8HvsBewkFNX3RBJsHClCzgzKHJlIJORkt33+puP8x3vUXAB8vUCplviYHRbcOrt8UJG2a4Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XmXrcCD5; arc=fail smtp.client-ip=52.101.85.10
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alIFuTYCuWWS17hLC4bEONcnZ93bbqZGu+KMSV/06ZLvTg8Wq2gIF+5Af6LmnYfdpBShzf8jG65Ct4imnpKuiU/8PhnhJimUu5VSwRTfdzcHhZRZrT2uFXKghsiwlR5Em0U/rTD2mdGW0ZEttrkDYf0oaf9LaLy5CTCKHl14+9GjS6OjxsAxB4aexsz1PoVRKj9wEzoZqVOn2X/3A6zighk9aYIXKqoicv1IFp0ISUUZK0t8LBHiYeoF6znF4CvQOxmG4ALgXzHxwtgDNs/+eSZhwhJ6agbtFr4VU1qLDDxByMy+Aw9b+Y5XG8W8rSZXpfSVfN0/MYZu0SxGmXDJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBB7fbQbw4VFweVkBv9/NY9O6mV8mI0UGe4tRBjvRGo=;
 b=Cak9sTYmY4ww6M+jsZq4c4MRVi8uoa9Eh6x0a1/vMCqsT6n4myFkI9MXIPpaBcj3dbVz6ITUZtOSWR8cTpxWg8n89tnLQr1niYBd/XN3+af17mN1MRNwK1bSxsvS73cgezxBANhs7XLK/eayEhOvuGZ1rHvvoHlyX0DOLdktqkAnzcn75P9pYELCwDUbPJvUV9K1RXifThzFpIKMbeFzubun003YpnoXopznfK421VR8hl+SE/CWN03whlh3K9674mCnLcSann0irCZsnpeVjNBe/6sQ3FfVaEUqgfcdjdMQJ2TYc8iApCudZ4fa2NJyBkuyyCgk4KlgiXdBRw5KRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBB7fbQbw4VFweVkBv9/NY9O6mV8mI0UGe4tRBjvRGo=;
 b=XmXrcCD5S/0UYbj/IanPq9QUGA13Hs2zS0Ft51Sm66wt+u494vuOnMPwc8VJshFdF7MK24sJIp06Hq4QHzwpobIySIlMn3dnqF5MwJViLls640hFS/BN08kB5WFBiYidyNwGZPBKjpvoMuh0x5PTJnVqOP5TXgB3yaMr54CpjsqFecObsL/NsXfOudDuRueanYG7ffRwiGFAp0SftCZddeV4eVSgq9FKAJ7bbn1BeJE+jHdNR+bOooCU3LQdd6UekQKkXI7eAn5lIBhquHwhTB1pCp4KYCUzs+d49JliBKlrh23/WEHVD+u2Mo3YaBmBNidS3GXhEDtOzOMLo/k3BA==
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by DS2PR12MB9663.namprd12.prod.outlook.com (2603:10b6:8:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 00:03:11 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 00:03:11 +0000
From: Michael Gur <michaelgur@nvidia.com>
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Edward Srouji <edwards@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 8/9] RDMA/core: Add ib_frmr_pool_drop for unrecoverable handles
Date: Wed, 10 Jun 2026 03:01:44 +0300
Message-ID: <20260610000145.820592-9-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260610000145.820592-1-michaelgur@nvidia.com>
References: <20260610000145.820592-1-michaelgur@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|DS2PR12MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: f319a45e-be0b-4d2b-d68c-08dec683a920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	XOye+3Nxx5/aX65ymfKOHopTpveOXCv1sdwyBkifGGuyWyDyz7SUL8fb3ZbkEJoNvhmhEBX54ZOkmscbiNWJ5fOe7ms3QkZo6Fa4I+1nhJmK+fI7EPrLHnMCcOKcxZWZA/B4BgDg/SNI2qFJME3CZDPcX1rQrDFuHZHb9zjW6qLwFeBVTJnJjO3QWTI29NOrce6NN9EBGEguffrMauRXrTuSn7+bS8cwjdXvAyq15AQJ4UgEwkYJbmvgfcM+m+lqIUDN5YUnSVJGVdZuAdCUI/D5FYpMO5JnABUHVx/pCXbzBYWL9deAusYpKk0xrZ9Wl9uVI0CRZI0BkH8ycy4f1qb0aLqoYStwXkZcUKAWhwTJw/GP2/68qIqpxW9ZyRSnoPoSsBeA8L8dF8RAyxSQA5euM1FglIS3jDHU78qv7hoTWbUtd5FZ3KBB7ygKKwagUvVMl89FMJXgLs4EsNv8111CEBb1osOjhINlVvJ7Qfsvu7ewScTqf4UfmZBe4nEsRLPiD205pxgop9UvIvLgY6O8hYN2n2VgACjQRs2Z1GpKPIFp56eyjf/HNCKEBz4ZT4nHLkLkCGYLOjY3WAfzBE0V+H/Af8FCPpNjay7UIX6XrCpQWC31NQk/6LTB5eVgPT1lDG5TgWSm1QOzdi/5BpvHFO4Fun+6UHJtwMBOmz+3bf8d+418HRWmQw51xmXt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HqMKseWTzaxKQ2qyM37QFXlcL0KnSVzum/uRv24K9dWsz7LPH8PE1a43UhT0?=
 =?us-ascii?Q?h6QrUFke92V0xfqbWKR8xxdB5jibXyzP6qAsd3YcIwwEFNIk6eXuZ2g+f9Jd?=
 =?us-ascii?Q?LsPX/merqBEs/wuaaPtPwMzxwdhrwj6qYuxStQpKy8MsNnwCHj8BQs1PmkFR?=
 =?us-ascii?Q?xxDY1i185+6XmD0W1u8vexkT9tlEdtJJIUnOyzbByfiAzJWgNX93AH3zRZou?=
 =?us-ascii?Q?uxFyo5/j4Gq0x8KkoPU1vSdbmO0tLpqb+IvmwoUOb8fpt7aMJClP/V5bhHG9?=
 =?us-ascii?Q?KIVAWQWju34lcRM/iYS561MmDt+3sD0poa9s97+EDmsbLOCbUr3XrrhDqWyD?=
 =?us-ascii?Q?6nql22tULPA72khwydszWggAwsSNpXhzlLf7jXNzqY8TsYkvSXrheFdqP/jv?=
 =?us-ascii?Q?Y3J5vuN3C7tDQn49EnqwyqJHvIvUqpgy8YoNE2S7BXhpgGeWcxIJYTzIAJSE?=
 =?us-ascii?Q?QfzA/XhFfSPkTgw+WWCk/HToMbxC9tK23qbUKDYqqZ1clMQXBhnpgP97qGoo?=
 =?us-ascii?Q?NSJVOCE7saH315Ry9UHJxgqCs5WTV7+G8K7Ecc/whlTAJfc72zPBa+58tN+j?=
 =?us-ascii?Q?GMQVJ8ZdNAwzYR7trxVNuNu5fR1+S6+5coHsr8zjrpEpKfSA8jSZ5JB8hpuq?=
 =?us-ascii?Q?W2f0KsFmcvQBFXLSk29Qlscg6+bTK1873kZVJt2/7vkDPyTNS8jA5wk8SegU?=
 =?us-ascii?Q?HB/ZUyop1TpBjFGyYzJqKd6TcaNGMlC3VUWQaa62NkU0nJYT4/dbPCxQzGvd?=
 =?us-ascii?Q?Rxb4oUYX1frX6GD1DrtvHBkRZS0DnkGbpbuNAesAnNtUGVIj8+K2sp0TOm3O?=
 =?us-ascii?Q?PZVCOeIMgjYT0V0cX+QOzezfCHYKokoOSOiC86I7WOG52xM9SrMC67Pt4RxK?=
 =?us-ascii?Q?Csav0BCoqeRVnMxbciDGo4FiEui+lVtwTXMj6xa92nSAGMZpFLypiy31Bc9Q?=
 =?us-ascii?Q?Yb592kpNvef7mK+Mt3BbeTqDzPNK0XLoUzo+KFqtYwyoWr7rTx6XrpN+McX5?=
 =?us-ascii?Q?u09xyX7apHfLUn4l8MInxlgfRh7bCLPf47l48rto5flBx72sR/nsO/L4rWX3?=
 =?us-ascii?Q?eUAOJ7xVR/C+4QomZfzL3cV7mANfya4XXO7Lijhf7zX4avQ/euhB2u0E4ljW?=
 =?us-ascii?Q?TUqFmn/MI/nDx2NM4WXw80UeRulFXlGJYH+IWm2xI0GFjRJr4Pzv9SVOGtY5?=
 =?us-ascii?Q?/k7y2JBtJIqAKXzNjInNoZKkrJ19mptb3Xf8O/EwZZ8D7JTON+XAAetvQPHR?=
 =?us-ascii?Q?CudTXv+wT2VR5BddOVm30/5ZtqzB76f5rxy5LltAOIKpfI9kx6cOpcxBjeSV?=
 =?us-ascii?Q?m7WxnWiAzm4XSyCmSODvsquMnDfdMrzX00ymMEMA+y87gcc1WWFuXU0db+au?=
 =?us-ascii?Q?T2xeVbOEdd6cU3o0omXguTzhiWXaigeuww72SV+Gv/oDiJCSSxK11Jo1M4Uz?=
 =?us-ascii?Q?xlKTXKnyQUK6gcZ+8y34kxHtfeeaSSRz5UOYf2y8wBo9LIHU5QowvIYi4ozY?=
 =?us-ascii?Q?7Gii0cHJkqu7hiUSN7WhW5wl6aJo1lyyMcXnCIRSIP/3NGOv6ALLlZTSkFch?=
 =?us-ascii?Q?k9/+i+pqXLxf9wFjGyJS9GbBQbtOevKRfLVrUxDj6ma54sqTje+y3u3C3+Qe?=
 =?us-ascii?Q?8jkY58Q04a+kmwL4ZKh0nepZJ0WpIHpmSpISZ7IQ0IeZFqJJfy5W0OpqoQAS?=
 =?us-ascii?Q?geBaKDUYfWV2G8NDyP8eWswk1L1yZCZOCr4LHXow/p2FgsBICze4Z6GsONB1?=
 =?us-ascii?Q?ZN5fjugEpw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f319a45e-be0b-4d2b-d68c-08dec683a920
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 00:03:11.4397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XFzzonTv2CiOURxUWEo56XuysJFyN2NsCQ/W1Zbx6VGFn5v2cs8La3Rny+KdHUMffLoMG2U/uWJfZBCjB5e8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9663
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22048-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:edwards@nvidia.com,m:yishaih@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AACA1664E11

From: Michael Guralnik <michaelgur@nvidia.com>

A driver that has popped a handle from an FRMR pool can hit failures
that leave the handle in a state where it can't safely be returned
for reuse. The driver destroys the handle itself, but the pool has
no way to learn about it, so the in_use counter drifts upward.

Add ib_frmr_pool_drop to balance the pool's accounting in this case.
Every pop is now balanced by exactly one push or drop.

Fixes: 36680ef7bceb ("RDMA/mlx5: Switch from MR cache to FRMR pools")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/core/frmr_pools.c | 15 +++++++++++++++
 include/rdma/frmr_pools.h            |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
index e214a8273df8..ce8ae4305b9c 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -578,3 +578,18 @@ void ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr)
 
 }
 EXPORT_SYMBOL(ib_frmr_pool_push);
+
+/*
+ * Drop a handle previously popped from the pool without returning it for
+ * reuse. The caller is responsible for destroying the underlying hardware
+ * resource.
+ */
+void ib_frmr_pool_drop(struct ib_mr *mr)
+{
+	struct ib_frmr_pool *pool = mr->frmr.pool;
+
+	spin_lock(&pool->lock);
+	pool->in_use--;
+	spin_unlock(&pool->lock);
+}
+EXPORT_SYMBOL(ib_frmr_pool_drop);
diff --git a/include/rdma/frmr_pools.h b/include/rdma/frmr_pools.h
index 5b57bafa3636..aed4d69d3841 100644
--- a/include/rdma/frmr_pools.h
+++ b/include/rdma/frmr_pools.h
@@ -35,5 +35,6 @@ int ib_frmr_pools_init(struct ib_device *device,
 void ib_frmr_pools_cleanup(struct ib_device *device);
 int ib_frmr_pool_pop(struct ib_device *device, struct ib_mr *mr);
 void ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr);
+void ib_frmr_pool_drop(struct ib_mr *mr);
 
 #endif /* FRMR_POOLS_H */
-- 
2.52.0


