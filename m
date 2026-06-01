Return-Path: <linux-rdma+bounces-21586-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDa7IFa6HWoidQkAu9opvQ
	(envelope-from <linux-rdma+bounces-21586-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 18:59:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3FC622ED6
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 18:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7BF53040212
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 16:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED9A3446C7;
	Mon,  1 Jun 2026 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KxbJkOPn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD0F32BF51;
	Mon,  1 Jun 2026 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780332760; cv=fail; b=c0CEgg1nYXASY5VnvpTopWR7HIUYMWeMTeG6PROr3J3dsQbTNHXFEb26WlD2PqSfCT47068LWi77dN3RDBtE1rq/M8LbiPw6t3NLIXQcMaC/ptpnFQmD/0cQEyv3/PIMRt0ftJ4oWc3u/SJ+Q00tsRyL0meit3D0/KveulOtl5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780332760; c=relaxed/simple;
	bh=25WbcCCJZ9o6zdZmUKPYLQ0o5cMNxd0i0LbaW+qKils=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oAE+gu61ceZ4nNXQGXoUrBlpDT54mYSasZOURfrmGnzEl9WvwBZ1sW6YMF9+gSgs20xWJ+V61/pRMXRmrRVVWjyNYI48Cfdu5GlBZgSchYqQZQPzPR5tmzmfHRClefFhjOUy+9lC/L2d/AIJdkj7NJOIBzsaSBIgCpUpIQ2Zzyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KxbJkOPn; arc=fail smtp.client-ip=52.101.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AM4LG0+3jTLBiSQPg8fgnMAEsnnQRHBYnMZyhRVLjNmbVrDxNMKI8j3ZJyE3caRThqFI9cBUd8gR/3aRDcV/z/IIh5ZS7DHotflWwfGkZ/5QpDSvptinH/oR+FWKCiK2sn7CBafqQ/QxK+5vn6250CewW5mAYbJfZ2M8ZMaW06Tj/HXq5svf2iVjAnMPLlX0ZNmH9GAYmEQ4Yl1xqX1ywLTVMpxub0pOg6DbSIOeB87HzJ1UoscOtSYwYQOIF17Wg3+dEBIYOamNxq11wgVXvaCukEVkmjqy7McwdDtb5RHw9lYYCNzqfrsoCP2TcLR4oRHKrCj3Ch5nMt6xGfOFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIwo9gPHDAbCSN1f4VO+YROk0qWIA+kOSJGWPuVYPvM=;
 b=JVfsjUyR0sRiylle+ZgDxxDsSbKOI+DDqMQ8UYtp5MM2Ww6pkuJk57/YkTacfl6jvKqNhmYfM3+hm/bK3U+Z52ZNNhWwKMUWPGPQ2/RPp6jvghnk5MB9IWDemQHWzbteZhYZ5dV06WSMBgtZM0aj88Vl8Y4QPcmIJU3owsiv8syrwirtGzgY6ot0PE2di+bWXiHsW6KjtQXFrOvQtuz2zzYogCKk2dtDJpw+kXBT7+E9pxkc4HP7Hk987UMJwQ1Sx2vWdTjqHUuuFp4qeZQVVao7/0iJDNfyfenhzZTeS52OgQGc19VHoCnyOasrOwmx7hSEr8GzzbeIz/WyyDNPJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIwo9gPHDAbCSN1f4VO+YROk0qWIA+kOSJGWPuVYPvM=;
 b=KxbJkOPn1baUDWumOT1MWH8lGQz3H45sljnGOOUY0wAqZ5z5jofLXtIVRiQnGxIejOw8VXwiUoHlKrWCS9oiITz0QmvSAzim/aH/hR6+RnIcY0EKWuhTSAfkUZ5AM8FP01/LR99v0W3R0CK/AFzeY6U+IbSXCrZRAiQapZJZ9C2F9Y40LGFezw3ASHrHPmaD1vnQ5Ms+AkfVRpJt51bfU5cD13reMfxHYqX9Kcf7XRp013uon95GFkyZokBNq47TDofyvvDr3QF2iIp+iNd5pSFob8ZTofdnHwMLIud51p89zfox7Ekz4n4E2JhIXH91j0Gn81/YfNUOyCyeom0ZVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB9733.namprd12.prod.outlook.com (2603:10b6:8:225::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 16:52:35 +0000
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
Subject: [PATCH 3/3] RDMA/umem: Make ib_umem_is_contiguous() safe on 32 bit
Date: Mon,  1 Jun 2026 13:52:33 -0300
Message-ID: <3-v1-88303e9e509f+f7-ib_umem_types_jgg@nvidia.com>
In-Reply-To: <0-v1-88303e9e509f+f7-ib_umem_types_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:408:f5::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB9733:EE_
X-MS-Office365-Filtering-Correlation-Id: 34dca651-eb6c-47e7-099a-08debffe2dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	afR2VVswy07Fe8ZUZxa6N6D0g8nnoRFIAhaGJiH7CDP6k6JKA1mgd6+sTn57IUsp61ouzvVsVtyflJHe98t7X4vKAbaRnDSEZL0xQbMM/HKkoHh3OvHqkSUhRTaGW/qsngqt4ts56BUgzmBtQue6zTjVQf5nV0XH6vNnsApEdTUK0l5mQWvGHUKx+OAFOzNsZIgN13hdZ7skdbZOD1aYcphrNGako2KKQ6ia5vAAE7fyif7ve+2nIShX5Z9OgE5HvN9i/L0+CB795G+PwI9jRgkcGoxzWU/32svPIUPlUYGh9moQQfVfb7yS1QZuB9dShTtRTX3llhRQhzKdyt8q/J/hN9F/v101JU8oDK/1/rMCNPN27fzkVPzVNMRf2icPxwIyvo51lHQre3W9ZTSe37Hfyd+BG87pI/439ZNSh9nQzcgNm7YVKCDhKuqyEoEZ3T2MivGFuSbB+caJuoXwHtdxVuGpGGzsS4kIg8K6YlUNQiu2Ik2xCaVgzp7btd0IcOE1NPdyxaugm+xQ9d2A+dWJwy48qg1MdB68b3+CyRfj5ydoFiumwrXjVN8VSwpT9jLqId1VcRaAhsqUTB8/gfqJ2REwsdAPvezL0TgvHCNNg5mpfdUmBf0d48vAApsWovq9nyJltMAtse3n0IFCwscEN9+nUt2jnPCmi8nBrOG1EpqqSFvFwp31lapzwye1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PfgdCjzP4FpmYn6Qf/UDz0HU6SH7YBq+DhaNuWzhwMc4CbjmSKDloKwMdegv?=
 =?us-ascii?Q?dDmndwgiKWc1ApwssIJ6on+HtyPw50+38p6vQ8JKTA6t0oKdcEZB7ZCS5U3+?=
 =?us-ascii?Q?fqDECZ7XBZM26CEElWVZjHGZhxp0WZ7Jj8KZqy2Gzo3Zqzn8OlKC/gnXxAst?=
 =?us-ascii?Q?OlxK0Ml379Pd/Twrrv+xyVSTYnrgryYB6qDEc2wbeQ8HEHIR64D7m2bj3pk/?=
 =?us-ascii?Q?ogcGZ/Y4cbTkbI/8q29eoEs5qBCHJCqVSfG/nvHdIPt6jSBRIIiE5C0U8qKS?=
 =?us-ascii?Q?+E9T8TglV3xjJLdrJhNFaunWGYjhWW28mkJWy/tSAtJI0GmDnwAxBgTAslWa?=
 =?us-ascii?Q?PrpoYAYdg6aYb7r36XDHnMHwd3bgiMffg8pd3vWEKxCMD0SxqAnJd3lGoZ2E?=
 =?us-ascii?Q?7Qp2n7YQDgMkcGtLSFDIH/zxTzmAR9IJu9aH0NB7olE5lLK4rspuY151cUSU?=
 =?us-ascii?Q?NRwouLxxxPeTJXLXHIyV0TdNy1G6ejMPo4W9CKYDa6I+UDBJgdpTpW7IubmP?=
 =?us-ascii?Q?w1kyjaMGstW5HHKMWHeB0N4G76dFEZBFVtpNPlhDBe4/1CAY5u5UrtxlSQwp?=
 =?us-ascii?Q?OvhJy+o1dZ811/Olq0qbiZGPPZO4cbMwcPvm1P44uj7fdUwUKgPjtujWiyzR?=
 =?us-ascii?Q?M0qug3hl5a1UxdhSdBiWjKNBu/uL3L9jbDFwEpPRbkt6ThHRFxOLrm6W0f7t?=
 =?us-ascii?Q?BM+yxoXAXY04R/zrJaj1k1QyfGhTLbeOZJbxF4JcV7B1Ojl/RIadYPw2UF0H?=
 =?us-ascii?Q?7eK9cwzqatLi42FS+mJdaxSxmZd24uyS/jifrwlFtrP8HhXd1vumS5FJTRtE?=
 =?us-ascii?Q?tlsxwQ1v5/KlIsjX2Pivwnr75nu22dO/ynhjxEjnlhf4cPOUASCSki9m2otz?=
 =?us-ascii?Q?XWnbTnT2+7O002s5QfTk6Al9yjxQ4yFwiS+DUNE4XYN6LCzll3beHQXBm+2u?=
 =?us-ascii?Q?OAhdnRtJQqLGaHcOcg6fGeuFByLm+Oyt/GSYd+93/zKmDHUdDuVviaqA1Ml+?=
 =?us-ascii?Q?MmhxfEyUUn+iroThB5snDbP4r8OrQF9MIfayZ8hPAJwe39+JYIhmxuiEH6A0?=
 =?us-ascii?Q?W5wVAZrMt4R3SyIjNGdjmlXW2vxHMwD5REQE/onNRPQzXgzuQl4G3q0g8xwj?=
 =?us-ascii?Q?YH68oiwKmfeo0jCpsr3R++aJkTKPmFz+f1l0RXwtmVoy+zl2XxrYDEYstDvb?=
 =?us-ascii?Q?kGQppbOYSGwPspNq+BZ9uTa8myJwHo8bUCKkZAlsg6PN5LdotOgzhEMItkDT?=
 =?us-ascii?Q?fyaY/tkT485PKQpLWlvteZEHvAt2oi9OLhKqS9UoHTJAxN5X6aaHi2FSnvhf?=
 =?us-ascii?Q?vbW4hDmUwgsXuX2mTf8YAV1ieI9ypAWb2QEPO7Vw2x3KmQ3SQIdyyZf6Q3M+?=
 =?us-ascii?Q?fyRhtU+VDqfmbh6j2LsZ21/aOmmSyfjwvI/JnwqfFbYdf21HRgzbkpViCDsd?=
 =?us-ascii?Q?OTiWOhwbbjWqRFXCqFGKrda0J35xf6rrTJRHCtnH/cTUkQlmO7ZOs+TyKVao?=
 =?us-ascii?Q?16a05Uiy1+eApn4eFFrhyxVvVw81hiqDdMjMklpoUo9FAvAVw+iveYlHBUEQ?=
 =?us-ascii?Q?R5igT97GMMORJ6hUejgz0Eh72ZWztFaCpSdZO5vYMRaYWp5ap1IypE2jFAMl?=
 =?us-ascii?Q?YZKt/EEi8SBDUnzVEhpAp1ywmk3StjC6zQlGWSF02RNblTyCLT8Mhb2ynRp+?=
 =?us-ascii?Q?hY1fBStub8POPzxZ0omGTm8J+JaWnlhRgsuqkTr5r+T9uygW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dca651-eb6c-47e7-099a-08debffe2dd1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 16:52:34.7331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: De5WlMxG2PK7f7kdRnRk5z0TADVnHmK11tX1gyQ5O9g6Dzr4vgk6CLkKUidveSp+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9733
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21586-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: CA3FC622ED6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko points out the roundup_pow_of_two() only uses unsigned long but
dma_addr_t can be u64.

Change this algorithm to be simpler, compute the page size, if any page
size is found and it results in a single block then it is contiguous.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/rdma/ib_umem.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 4c8f433ba246f3..bb4005a9c69066 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -145,16 +145,11 @@ static inline unsigned long ib_umem_find_best_pgoff(struct ib_umem *umem,
 
 static inline bool ib_umem_is_contiguous(struct ib_umem *umem)
 {
-	dma_addr_t dma_addr;
 	unsigned long pgsz;
 
-	/*
-	 * Select the smallest aligned page that can contain the whole umem if
-	 * it was contiguous.
-	 */
-	dma_addr = ib_umem_start_dma_addr(umem);
-	pgsz = roundup_pow_of_two((dma_addr ^ (umem->length - 1 + dma_addr)) + 1);
-	return !!ib_umem_find_best_pgoff(umem, pgsz, U64_MAX);
+	pgsz = ib_umem_find_best_pgsz(umem, ULONG_MAX,
+				      ib_umem_start_dma_addr(umem));
+	return pgsz && ib_umem_num_dma_blocks(umem, pgsz) == 1;
 }
 
 struct ib_umem_dmabuf *ib_umem_dmabuf_get(struct ib_device *device,
-- 
2.43.0


