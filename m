Return-Path: <linux-rdma+bounces-22047-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OfbYBcipKGqLHgMAu9opvQ
	(envelope-from <linux-rdma+bounces-22047-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:03:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE51664E16
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:03:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=K5F3kPje;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22047-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22047-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0ED6A3017CFC
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 00:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166E145039;
	Wed, 10 Jun 2026 00:03:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62381427A
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 00:03:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781049792; cv=fail; b=O7CpijnYoHa1dffdsMhufRrEKJuAypmldgPE4XfWIpDGZp95vM4ccqOHTmadwyERP8/2h0lUq5w2323bl8RvHJEqVIFgGoLJLE3jVhnWrE+bjpOgVatZVCmj09PNXkETP45tt34QHb2GtbWFKtfTAfZLVI6O0e70uARTONMOUAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781049792; c=relaxed/simple;
	bh=EQXhjLU6mWkjZRQ5PjSadqtrWALszv3SYh1tnJTu59E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U5Y1QQxwUEEjMU5F5KPr7eyZuvmcsFkYGd+AUL2JdvssH2kq/uViLkgnPYuq3UCmXw/5LmSo5/WAVX9CZFBLM9+0ZGf+jKujoaymyR+qjl730X00wEO8zAIiyUnEovxmsaNQwpIyEvQMhBOLqf9PuRthgY+ZXDHOmVgEaixIY78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K5F3kPje; arc=fail smtp.client-ip=40.107.209.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOV91DdEnJc4Ymi7yqYCOjIPorK0G7DRS0W2TIBZh4A28m/qlotExQzcn9W09BEB2xqk8h+2vBn24Gs9AcMBvZczH6i61LEStIRS0aultttdT8DEYBracCn4iaTQb7qzI2UScD9rYVlHmNCiI8IZj58b8oldgmwUL31nFt0zjg2tPMDNZ3bKgVx4cGGuSzJYaiivlrTGahLMZ5ountsjvZyt7akOJpC35V9+ymbPw5+XnTPRdOuF65du+aifDu5mUh2EreaQvxtONg9RN8F3/vOSA7H153sZUpEnBSPwBtjrm5B0UGH3K2/KcgW6shBF+xwYmZWa1c0ds9N2Wei3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNdH1dqeeOqG2KBe9yu9xFUTHKBBazoRYHyaZjihBLw=;
 b=uFVvIEXJ9oVgLJgYf7DINFZVLVl9l7avI/eFRVUswgcRlpSQaPXm/5ojzOmw8xGP7vdh/7Lx4Y8VnmKPU1Es1l8aIdPwsJRLHjC1qYuP3Rz7uF0xzm5WTTdEy5hLEkZA6lIarkntgUCh/KmOIyNnCjKIhFbJ9QpZyYHj//geC0Ep2cczBgP0DgVz7BN1MkylvqH2aKLJzaML//ZchKXX46frUHq5+0bLreOOuhAibuozF+b6kdcYd/aOaA+m6T7kX65QVke4vqAR7zjbd00gVhSsh0rdwCJciN7dMMhWJT+weQHM1WJGGEpcXLMlbUASyoJHwbnJ5EKDxzugapIAnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNdH1dqeeOqG2KBe9yu9xFUTHKBBazoRYHyaZjihBLw=;
 b=K5F3kPjeKaUAzqa9YFXs6r/nFNhpu02SoVMA98aZczjMTeGiYRaVzuFZl3ycu8swG2YBJmIBVijy8HNGZIlGIDpKADO1k78j0HV0E2eGVQKm4a2z5Cmxf6Ne3+0l33GH0wkbshKFwuHXi3zNWfW43zHd9sW9Wu0FfPpaW/hve1b9XM+p6MyZOB/g21hheIGXkWIKIkRgzyT+sy1rpCesArlj6K3sdKh5ggSSUCmQH2MbHANXL7BSrRv5XR34o8Q7Ftv4mWJRAwVmh+Hj7q4GwIrRoBL3y7ssJRO4Nh1x8FeqNLUREFj+ClTt4YGmTDZLQXMkNGHfXcNMhUipLMkxow==
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by DS2PR12MB9663.namprd12.prod.outlook.com (2603:10b6:8:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 00:03:07 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 00:03:07 +0000
From: Michael Gur <michaelgur@nvidia.com>
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Edward Srouji <edwards@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 7/9] RDMA/core: Fix FRMR handle leak on push failure
Date: Wed, 10 Jun 2026 03:01:43 +0300
Message-ID: <20260610000145.820592-8-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260610000145.820592-1-michaelgur@nvidia.com>
References: <20260610000145.820592-1-michaelgur@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::11) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|DS2PR12MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: 61752c10-2089-4a35-ecf8-08dec683a6bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	2s+do4JoDL1kD7yoV7NZVLjak63B3fl20Yn7H3s4fMnTQWxeyezxHGNs+PDCgs2kTOy0FbPpPs7WnMdYuSCJ4BJxsK+amLXig1hC8Oqe5oGU5lWVUBfAyB/ScIqDXe7C3mlxVYrbCJnm59LTztJ3Bftmi1S1ruop+/I++L6jnIvst2MUDydKaOT9KhSh+2clv/q4Uc1VSsIbyeEbfIPlhJLyuwICNTfBIEhTGZYrB+vCij0OSaNJosukMY/wwVU9ulXKRbUp8NytIEV/fx/39b4o0BV/u+j4ZQnU02pUPc2GZ8B6TvOcxZGv8O6Lewpt6JzzER3CqLcKDYwouLnEZgHGMIbMDKQFjmXPD5tJzoALZX1nTVpVT9Ea3qiZe2YwVQ/BNSu9KgcKU3qB9goKmjNtSjt/oHn9Q9Va1JDSuJyqCGLFPCPmIS7LoZ2OKUhmaA0rIQ70SLCAoy4qTPz4R6EhV45Lr7+ymqVyBuej9iXILvMhvWKDTpmimvnWDaAAGCky8Dd0LZLLBKpdJZ8BbSvnCBoPJoLXNw09f1cXsLpwntQUlbSXWp1sdjUJtqNNP892DRYTK91MIGj7qT6UF4vFAGkYc+bKuZq5P7Kxu/rsh4pbEetOf2cFhzGu+kmaRHeCJ1u+1Gyu+/r1BB5/8GIwxGiCXCA5vYru4BWs7tdO6Ycd9n2gvBXhXSvk061b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5N3Qxq4M3r7nNFg8QNU317qn+2Y7Q+l5y/mw/6suhvaGnsdImhpiCsouZoQj?=
 =?us-ascii?Q?jRYy72Ibf2n85BhqR+gtFiB2loXFw0OGJ2Fk0cG6/xhI16qDGQz5kpAJjLiY?=
 =?us-ascii?Q?NlWOOqWKDz3MoMvOalZtJRMREHzVL7GauJZ2cwLq+gpc0Oa5knXWl6blxYqB?=
 =?us-ascii?Q?8qTBbmKm+i/zeaib4duq9qF7Ui/oBF04mHeCTFc1s7upzNSUnff0hRaX9bqY?=
 =?us-ascii?Q?xUpk3pTqcZ9W/lTmofgAOBRFehwlKibrxO8A1AAHXvGVv77ZwtCt0/xzkdL1?=
 =?us-ascii?Q?ntCFelj/7RAB7fyMG36+TJCQAEajTanaZZL6vzs/6PDAyDt322+2swLxi+62?=
 =?us-ascii?Q?4okVwIpgDc7PCSg3eFRLmW/38BEfRyylVP83QjiJIOzvoB+k3flrxz4jAK0N?=
 =?us-ascii?Q?3FSDGBCnPsDnzyrppdrQanKgV4qI+jNHq18Qs0hDXfFpcdyETPrQCQP0aj8L?=
 =?us-ascii?Q?bgjLQoBfZfksmDTcSR3JvWzvxdHVy5+ogI1w9duKp6B0o9MgpJkWD1rkhK30?=
 =?us-ascii?Q?7fXAc6Ox20fATXWNPOvs6n2SAFSpJBbV/RXmKXwAUxLbGh9KwSjlG9CkN8GY?=
 =?us-ascii?Q?g52+gzG+pvyppkvEscC8RBHOGK/mr8N5EDTWMfX+rsI1Dx+PLixyWckES4Fg?=
 =?us-ascii?Q?DxzvSyaZU9C76Vxn7N/6JS0lNMu0F+gHSNHYjLhx+TifFG3pqGfh8FW507EP?=
 =?us-ascii?Q?MChIL9Gs28bCZDw9TpnSOk0l16rwolASxylgbuSoCBEV7wWWjkjIYT06CbZP?=
 =?us-ascii?Q?P4yorhMoo7vCGBYdkNRrSpQCP4LS0uARgh9JhJj6pZ1SUC8zrRjdTVxCCUOM?=
 =?us-ascii?Q?usjY4yIFlnx+Z+8r5qW7UCOuR5PhkXLripx1zuBHv+2Tc0emuQHgZRILS5RL?=
 =?us-ascii?Q?cnI62uiU143tP/yjJwMrte7wyn0uk3Bc0A1dX2wmqOfilKuDWPxP7dEuXXtG?=
 =?us-ascii?Q?OMCdOsETzTAkxBB09RUAQiGr0tOZialfR4w8dD8kpRbrPN6gVhlAeg6p16l9?=
 =?us-ascii?Q?2SMy7QHCiKCju1AXJcINjDdsDD2NCiNUs6I8GcjJudcKq60ZtDmM7+qu+E/N?=
 =?us-ascii?Q?Q7gRuhBe2i60Lh7xPzUcMclDA2fSTNFOTD8TFb1zcEv2bJyfY0kr/6uk4rVh?=
 =?us-ascii?Q?oDMEcqwIZjaEciQ35c3yS7ho51MHQIUy+zjmopZaX5zHyhhsTxHs96pXZ/RE?=
 =?us-ascii?Q?xHfLTwOE6zc34cm1XzNGqXuUhe8Ws9JVfpSygkI9l7tf8ibHAQ90Kr3bZyRh?=
 =?us-ascii?Q?djV9dTFsVxJOlVgLX38DMXp8/V+MnVGMUXWHoCnaHggD5BBjgtdZwnvFREO6?=
 =?us-ascii?Q?fXyzhL5SvRxuWuNHIEXPy2MZsCFh79Xyr6v2o3dj86QKZJb3qyKCIcoOzB6f?=
 =?us-ascii?Q?GANPo2XKCPJEP4dKemRe0mkeVmu1Tcq8X+3adnO2tWR7pjJAxzQA1/AscXg3?=
 =?us-ascii?Q?MUjnnvXJsUZ0PpB0mZknqPE8UPZLpxnxwGvTihvYAEMYjTRXQx2t3rhJZpx/?=
 =?us-ascii?Q?9lSHKwy5POwhkhq3reCxSSWhaMEGbRC3UxufIsneKtgZPW8AZVvDwHtZBK0g?=
 =?us-ascii?Q?C5VNe3BsHl3Vw4UBWPBeYZG+XZG5q3sXH3/Dm1jsYx7ljIDfYC9ODbVhZaak?=
 =?us-ascii?Q?nkTlyVWwf+wmMv7sM+v8rxrQEwHnaVOmApqtQUZBArifAXkppW6OmtyYxraM?=
 =?us-ascii?Q?ItsgDQ4ULg17niFIFdgg9ZKIKDu1o6N0bGZhcm+jYXqFw2dxA+NPb2lKLKtx?=
 =?us-ascii?Q?pCx7XzIdLA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61752c10-2089-4a35-ecf8-08dec683a6bb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 00:03:07.4169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRfrOvJSI6N0ZAjePEY/214l9a763KKVwGpqGQJgrxRgU//sHaB8wRL3ebSfwNVbEmUR/mERYVWxHeoH7oyEKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9663
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22047-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:edwards@nvidia.com,m:yishaih@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AE51664E16

From: Michael Guralnik <michaelgur@nvidia.com>

Failure to push a handle to the pool, caused by ENOMEM on queue page
allocation, will trigger missing in_use counter update, skewing pool
state indefinitely.
Fix that by moving the handling of handle destruction in such case
into the FRMR code, ensuring the handle is either pushed to the pool
or destroyed inside the same function.

Adjust mlx5_ib call site accordingly.

Fixes: ce5df0b891ed ("IB/core: Introduce FRMR pools")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/core/frmr_pools.c | 19 +++++++++++--------
 drivers/infiniband/hw/mlx5/mr.c      |  5 +++--
 include/rdma/frmr_pools.h            |  2 +-
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
index 892aedfe03be..e214a8273df8 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -549,9 +549,8 @@ EXPORT_SYMBOL(ib_frmr_pool_pop);
  * @device: The device to push the FRMR handle to.
  * @mr: The MR containing the FRMR handle to push back to the pool.
  *
- * Returns 0 on success, negative error code on failure.
  */
-int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr)
+void ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr)
 {
 	struct ib_frmr_pool *pool = mr->frmr.pool;
 	struct ib_frmr_pools *pools = device->frmr_pools;
@@ -559,19 +558,23 @@ int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr)
 	int ret;
 
 	spin_lock(&pool->lock);
+	pool->in_use--;
+	ret = push_handle_to_queue_locked(&pool->queue, mr->frmr.handle);
+
 	/* Schedule aging every time an empty pool becomes non-empty */
-	if (pool->queue.ci == 0)
+	if (!ret && pool->queue.ci == 1)
 		schedule_aging = true;
-	ret = push_handle_to_queue_locked(&pool->queue, mr->frmr.handle);
-	if (ret == 0)
-		pool->in_use--;
 
 	spin_unlock(&pool->lock);
 
-	if (ret == 0 && schedule_aging)
+	if (ret) {
+		pools->pool_ops->destroy_frmrs(device, &mr->frmr.handle, 1);
+		return;
+	}
+
+	if (schedule_aging)
 		queue_delayed_work(pools->aging_wq, &pool->aging_work,
 			secs_to_jiffies(READ_ONCE(pools->aging_period_sec)));
 
-	return ret;
 }
 EXPORT_SYMBOL(ib_frmr_pool_push);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index c0b3a8066974..1a6a8ccf6832 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1379,9 +1379,10 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_ib_mr *mr)
 	bool is_odp = is_odp_mr(mr);
 	int ret;
 
-	if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr) &&
-	    !ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr))
+	if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr)) {
+		ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr);
 		return 0;
+	}
 
 	if (is_odp)
 		mutex_lock(&to_ib_umem_odp(mr->umem)->umem_mutex);
diff --git a/include/rdma/frmr_pools.h b/include/rdma/frmr_pools.h
index af1b88801fa4..5b57bafa3636 100644
--- a/include/rdma/frmr_pools.h
+++ b/include/rdma/frmr_pools.h
@@ -34,6 +34,6 @@ int ib_frmr_pools_init(struct ib_device *device,
 		       const struct ib_frmr_pool_ops *pool_ops);
 void ib_frmr_pools_cleanup(struct ib_device *device);
 int ib_frmr_pool_pop(struct ib_device *device, struct ib_mr *mr);
-int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr);
+void ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr);
 
 #endif /* FRMR_POOLS_H */
-- 
2.52.0


