Return-Path: <linux-rdma+bounces-17269-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHiBHGnvoGmOoAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17269-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:12:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC991B168C
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 877C6305091F
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 01:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8341F2BDC2A;
	Fri, 27 Feb 2026 01:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qnugIAtd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8012BE7AB
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 01:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154691; cv=fail; b=DjQ84WC+YiWE6q590IO85yUjwk00qZ/bj1W20HNP+CYpl8E0ljgaiojxvAFod2UkXhhp+l1Q+OIDvVQyhY4TrGIPC43LbC5IjeliTGB4OIK/NjV9FSChVALpej1TtppCeNNfQrwE0el1/92jP3JMdOStVOqlwOoMRTnumKuF/No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154691; c=relaxed/simple;
	bh=t5PF3h2t3Xrlp08yDVxD/WcQap89XMEFopKpraS0ZPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KCcZT5KlJA6XgmxbCFP2q12WVDUDPhEp38OffUHI1wMRB+CxqC6Ewhfj/yPA/hAXoV6KZeYSMuqFgN8qcizfew+ZFnpbdYAN/YrubnK2docXkw+lxrRcdaPfTsK6D0lhmG/5o5r2kC0+HPt38QWRXP1d2uIFanwtfIcyVQyJE5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qnugIAtd; arc=fail smtp.client-ip=52.101.193.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Plf5+ZxqaAcB1KKBphzpf4G11kjESzCr3W60xijWXjCHm9eOsTEQ6qqkc2sXj/yhtvHTXnwU+eeyqWtpu8BTDGbA5h3lA4XRSgfG38gyxJthBxPWSthpQsBW3r+tvp+X2FGzvwo+xeieV3Kog2aCZek8TuQBTUS/8bN1+8ST6ZYjERofR1koNyO8/YO4p4YPKFZlZFtgsZNaXB1TVIpwECf7hkhmkpp2alC3V6yesjApBxYhHSMOdm5DBww2MFRnLAiXAf7GmJrGHJfpKzgbqeuT6oN0GeCtVFG6IitRK7kTAWLjXwTj4vzHsrDlSSlmjczIllubGIMT4i5dXlDGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49HHU5rxuAYD66lgia/Gp/WGKth1OZHxBv98VzJBu+c=;
 b=LeuWJGLOYXTvkDaIhv+OxXewQHiZG8lVJ9GMbVYh64XigpIWtJf7Y1Xw/52IYwMyLkVs288Wy8FYezpldv12/d/KTE7h6rxxEZ/2nEGx41gjZSKIL2+8svWjQze0KnjyjwUL759FJLsEvjhfzFrJrHTLOz20UlGoY9rRfXHFUGPuWqexwFXlWn8i9bRKEzRhpXmg82f2Ea6UVFuOGWS7VWzYXSrA8Hq+oXNi74JAIyp1R2Oowq3QvkJbampPHyy5JC8hTynmgH0BVS25rWoS5vpMYDeRi4+NfFst2ZspNekmN95wpbw1+O3tRGY7NmIisG5AcbvAV/2VjrVOL5n2MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49HHU5rxuAYD66lgia/Gp/WGKth1OZHxBv98VzJBu+c=;
 b=qnugIAtdsdeYjtJHBnKUXdFjnYsHFWVBwEe4KyZIpGAtUBQjoAhttnWUSoCLPAQAlEtWQ6hrKhtgT9fFeM0MGhAYCt+v80ViJz/ygx2f/TBTKpKUOG2/YB58taXZvoTNbNqvFp9zefPD5eo81YxvaKuFuClhok9Oc74zszDYzQUo29AkmcPr3h5xQGR71Zzh1fHhotYa6caGJxQa3t54BHAa9mT4AzkkwJliO7RJ3aNuXQchgUEOMR/0+SYst4i+jEbYAx/jkFECVs1+TzLSMvJ1g32voXugiwIXzAoxxeE7VNaeiAX42DzIdm7ODbSSxU7UpCIO8+KBiJZkx/gCvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB9459.namprd12.prod.outlook.com (2603:10b6:610:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 01:11:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 01:11:21 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v2 13/13] RDMA/bnxt_re: Add BNXT_RE_UCNTX_CMASK_UAPI_COMPAT_SUPPORTED
Date: Thu, 26 Feb 2026 21:11:16 -0400
Message-ID: <13-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0022.namprd14.prod.outlook.com
 (2603:10b6:208:23e::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: aabc171e-c6bc-48c6-3c91-08de759d1c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	G2W2FJtfzVrQeHIOUX9AylknqcXvRevR98bhTVID55JtvhtSkA7z2b+elfgmWBrDUfDR4hAxfdm4iso2KwH4UKsSBAqQi/fgvHq/m3m3Dazt0SHjHj7sdZFjRsNShwtHglv8qyVeqdIyZuwKeT6TQBSjAVtgV4yWNtikUeDjAuqiMCxeQJYIGKLlLZSHy2tMu1Ss/o3on5cHj4vENgLOlbkKn8Su4Pqf2r5MFQRWOF1e8kum1d94fF4FAAy7cBxxFUBbF6aOClVmpJtiYqOU1E4ueicBiJWM/MjWCMj/RRQq7W9tQrR0m3sxrWnKcB1Oc3U2Wc/ykVjVtxJcc02Ax2NQwuUAzS4Vaz5wRlx2r7usZzAJO85rrKWcrn3wEXnY7JO3Tu2EBFGMRURL4Vb813UlbQOTAZps7QAkZTgWSk9SAVWUpd8Q91Lgtp8E/XDsRdyKKbebE8/Pi20oMk+cvVNF/UNJNiBvQypNBitWbx8L2FfxAQNYWnIWGe4j8ryc8zlya2SLksSgEUPRxp5+JIYXkP3SGEtsot8dAf2E+qoDxJZAc+UzEsDIsWI/970kzLHpym6xZLaeYH/IBImss9y4vtVXb/2afgjLgTgdTRrQL6QeMV+a4nIc5rnsCC3cVeMtFm+CXjtfQmH4A/KcPf3AgQxrfmq+0Q3WZxfm73F4WSvDvADESEnEl8jc3D4VIavm4W2uFjpnD/PV8RrcVVt3ZY6FNxL4sfS0Mjm/YQk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bs9PixRRE3n8ndgOpBOKq3MS0PPJz5ciaAljC9uq0VCx3PjufQ5CuVtACgW/?=
 =?us-ascii?Q?CGQZKQHpj71pYvzPYzR+r+3KZVYU0gi9+6CdloC8G+mYLKfq5B8h0V9JOJpz?=
 =?us-ascii?Q?KiOU3U/x/rYFxqtQ1DKjpavnN3CaKQEdmW2snW9DbZ0kiGFdZFLhGp32VuLE?=
 =?us-ascii?Q?tJ9ANTh2Ly0/tj79KNFUotT3zD8CHqaiKpPngDUbr89dAaN1izBlN01+LsX8?=
 =?us-ascii?Q?4FWGvvfKpSZ2i38LKcPrqKUesnjc3jEDXuv37TVDuiZTdlfaD9ij8v4kKyqO?=
 =?us-ascii?Q?Rfp9bMTuQG5E20fuO7IldcwcXMPqApxmS7dAMaRlcWW9y5ex0h1zwYL5RdJC?=
 =?us-ascii?Q?6rqNOLGw3/J+tW7zJ6HOgauin0ipdI5n9d6yZhLGmEgIjMSFLh/xkTB8/yOE?=
 =?us-ascii?Q?as61510EE2TtMzZO56mT+RWRuH3WTeA2v1WawX33Z4BuCQTQSpcPzpiFypkG?=
 =?us-ascii?Q?L7l+CpyIRJqwIYThZkYr9uUQruraPEUfLATuY8ptp3tOWuVees6vnETuHFBK?=
 =?us-ascii?Q?ETt5SL+hH2lLWYX71LaE9WJH9N36QOHE2Lm/o1kb4NT1iiSLuQojML4/uHMn?=
 =?us-ascii?Q?U3x07dS5a7bQ6QwhVnrOz4VD2HyZkv2+kd1ZEO8tfZddndrbfOcbvbpGjmXg?=
 =?us-ascii?Q?HG4IhSY4bFFy/loV0YbBdWRswMq9FuAHmXkW1YQw7NihaDU4IZ9jPUKHa3iq?=
 =?us-ascii?Q?7dIm3zlJqGxfYKf5M2kzfvWFGsHagM6soudDMaJlTG+SwUUgc5mEv3SdPKk7?=
 =?us-ascii?Q?P9HAn7z7O9KxhfvDmBPDQdF856jVtkydZlWHQ2ub909D1QZ+j18/4V+kyG1g?=
 =?us-ascii?Q?ozCsy+FqAGhazo4TqgMK37JojBZJG3zp90x/G4QgfRk2Iph8qoOlTrDupHBT?=
 =?us-ascii?Q?qXCIYSbIGKb/z/d3Ly+dVUqQyXXAF9gLxM4NNglKNownzRnMXFLr7ewgZvg6?=
 =?us-ascii?Q?Wwl2XlIceTE8qJ1KCeG+5kYg+qB5nJqVk1wqZ+Cer50klDMlPiUWcxMHDtVg?=
 =?us-ascii?Q?pcmmRarFTWMCPay+QabhhX0nX1ARaLkBuV+zlVDqlpy0wTtxiODvvfDftXlf?=
 =?us-ascii?Q?cMENuY3o4yxaBRCNgTKxuIpyaUHCvtoVC5uuQGiKDLvaDVqPCikdsPd2Hkp2?=
 =?us-ascii?Q?KjNpXPQJgSCZ2ftLgVvK/3Oob1x3I6wxyQj/tDoZUlViOCxPDQZiN5ZDx8dX?=
 =?us-ascii?Q?JgtZVX8e4OWeRJJmew+CMIiKOyW98ncOxVyupBQVitUWbADcnoZ43olryIJ8?=
 =?us-ascii?Q?tKJUN/iYR/8TJ/SEhNeko9J1F3L+s9qaGYDzex9MhXyRZUQA4ba74QYgEvVZ?=
 =?us-ascii?Q?Gwje2DZQi5rZpZtMH14haP3bc8XNwxnhEsTwPC+fRy76b3IUbax0m7xIAraK?=
 =?us-ascii?Q?JItf41zlWOSyWNzaP6rK/bkzm1rQhGQVpHGOjHRjUTU3v4YiJ1E3URU8knAO?=
 =?us-ascii?Q?Fflpfp7V3GqiFrozu/AtDWZabJgeAicROk/zs1IrSPXBKxtuWBTM3MR65Gs6?=
 =?us-ascii?Q?vgn9FReQyW1mYDWpnNDHjwqJS24BAeNX4mv7OKXBxoNQEu9z8lwCA8zjuoJE?=
 =?us-ascii?Q?yyLvZ6JfegUAdJkdnra65VHcQ8rGs5+LpVHJSiMQ8BChZAdz/L6avlPqyxQP?=
 =?us-ascii?Q?Y3AUmOUabyI59Ep8L2V/5LpE6g6ALwi97qU60O0Nr0IRerQZIycBDm1lCUCM?=
 =?us-ascii?Q?zwJEhO9S6Ld0UhbrJn1LddViuMws5BOW3BLHiDMLHxN67a4dvJuZure0+v8Z?=
 =?us-ascii?Q?SblZ8mBaGg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabc171e-c6bc-48c6-3c91-08de759d1c85
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 01:11:18.5505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wO91vcW/bk9aHrgK1HIud+gMjAG7JxcP45AY/b3PEDh2HYjRbfvsPKL6jRzWOa4f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9459
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17269-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,broadcom.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 0AC991B168C
X-Rspamd-Action: no action

Now that the driver properly implements the uAPI forwards and backwards
compatibility checks tell userspace about it.

If this flag is not set the userspace may not use any of the uAPI newer
than this commit as it will behave in unexpected ways on older kernels
that lack validation.

Userspace should test this flag before invoking any future enhanced calls
relying on changes to the driver data.

Tested-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Acked-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 3 ++-
 include/uapi/rdma/bnxt_re-abi.h          | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 62286a06db8168..8582c8a6030317 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4433,7 +4433,8 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 	}
 	spin_lock_init(&uctx->sh_lock);
 
-	resp.comp_mask = BNXT_RE_UCNTX_CMASK_HAVE_CCTX;
+	resp.comp_mask = BNXT_RE_UCNTX_CMASK_HAVE_CCTX |
+			 BNXT_RE_UCNTX_CMASK_UAPI_COMPAT_SUPPORTED;
 	chip_met_rev_num = rdev->chip_ctx->chip_num;
 	chip_met_rev_num |= ((u32)rdev->chip_ctx->chip_rev & 0xFF) <<
 			     BNXT_RE_CHIP_ID0_CHIP_REV_SFT;
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index f24edf1c75eb36..66d7edc88f8887 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -57,6 +57,7 @@ enum {
 	BNXT_RE_UCNTX_CMASK_POW2_DISABLED = 0x10ULL,
 	BNXT_RE_UCNTX_CMASK_MSN_TABLE_ENABLED = 0x40,
 	BNXT_RE_UCNTX_CMASK_QP_RATE_LIMIT_ENABLED = 0x80ULL,
+	BNXT_RE_UCNTX_CMASK_UAPI_COMPAT_SUPPORTED = 0x100ULL,
 };
 
 enum bnxt_re_wqe_mode {
-- 
2.43.0


