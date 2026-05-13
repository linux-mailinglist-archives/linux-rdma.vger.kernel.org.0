Return-Path: <linux-rdma+bounces-20589-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M5lIA+2BGplNQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20589-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:34:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0F05381C0
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F315D300E153
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 17:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2A54DBD95;
	Wed, 13 May 2026 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BhaWul4+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A44DC538
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693623; cv=fail; b=KXfJ+AJ4iXGWM4ebXQA0bxY63Z3R3MckParS9vULun6mU+sX/C5Fuj41NeobHjJ/6YArN33Wj2ZSh5WsWXb99aZq1PDl83JKoHRxD2OD/T6Az2RIgKCiG8Mldfftb3dJeSH7Y4YqOLnvXPYEf8X22q+Bal7H74JlyIxzmPxhICY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693623; c=relaxed/simple;
	bh=iLTBjYvhOz7T3h/eWpL2za8Fp0NuSCUbwNdkfXNOA7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p5DCD+zPJGkW06d0BxlnNfS6ejPMY8ZqewEH+3fVsxwHjIDsEjgthANkOHIS3ADN/Tv/bG3/X2Y+bLC2ZAJzVSo5GPJU3cCxFxabnDUhfEWHcC+ZVXrJuFD46C3nQgCHozEEr5X6PD35/KOgdMaenBgQGnpQo6rxYIMnckpoSCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BhaWul4+; arc=fail smtp.client-ip=52.101.52.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIl5sslA5p75pMHYmtGGlXl7P8oXZ5x3fWEellyJSnHrQsnjuVvpSrP+4tEzKEoiANEX/MxLBrJiT8ZYabdPTUNnI0UREoLgpN4eMkzVAWWsQVUjJrwF8zomPxS9+mECRIAmm/k3a/RpbfYHgGz3cPxt+7P5fyhVqnkMHFyRQPULycWPuEZDjJ9bcMCTT3ZQziNPvoIoKwloi61AdzTJln6gLDP9sFSPYSGPN2vK98N/NouYc//KZ1C2a7eia1B8ul9TFJjgD9ny9kmC6cVajZka3hA5wp0JiEeMHK4BWsYh45qxAPn3d9fR4ZrZRdDBb3ULPUt9xODnmtvmCvgp3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n34tPP6/IIOVDBKAxc50c+srbmFY873zIFI8e6KiLi4=;
 b=psAiexTdOJrVQll+4USeJgT6+EIV7qK5SY2A8KcUQu8QumOwdKkKfSBMYpl9qz1PF2PU4e7yHrdnRIzS126NwP7ut9LyGqKSRLXDieRMHONqEXlEs7MYIgdQMyUU7vwMdEzlQTt26xlRsZomns7VRhz3BH5WvKCXAxUh0Ph8OEB64Pgc+rZPMDH8XC/TUgPxJP7nYk6FCicIviUj4GFEmkJEcMStE69KyABfemUE26Qe0fIYpGQI2bST5gMR6FqMBpeHupuedEiEiD58DA/c9TkdkZDLUpEKt/4BA4bftdcfTIExvcRI+p81De7rkZFLGx71y2PL9qRWSIVjej5w8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n34tPP6/IIOVDBKAxc50c+srbmFY873zIFI8e6KiLi4=;
 b=BhaWul4+uaDAXqhGN+sO3Ow9vlKlZ/6Qsah0q74FjlCDHZ9DuJ5dQoWMp49JRPGiXm3hM/BVKAYJxe5BTaX8QzYytDTm03K7pLv8Ot+SCW1yEpyrMdNf2JwWr90d6f/LufVF+EvN2fd7kSErsX8wzn+RE0HHX9N2FEkQk432muKr8k93cvniIvKxtCj61I8BAfBM0ANTbFM5G+KSURu9tMjIRyU80o2R59p3WSBffsmQxXykVfmlFQODB2dODJ41IQzkurqrX7N5nHrwwWCgJwp0wlrfyeA3PNxp34+tCyU5vs1IWt8Ugrn6NKCDDy82PS1RLXK1nUZ4832UrJkacA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 17:33:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 17:33:30 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	patches@lists.linux.dev,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH 1/6] RDMA/core: Move the _ib_copy_validate_udata* functions to ib_core_uverbs
Date: Wed, 13 May 2026 14:33:23 -0300
Message-ID: <1-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
In-Reply-To: <0-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P222CA0028.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::30) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: e0186de3-91d2-49cb-f04f-08deb115bf5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	LOumQU4qEqthA+XjqRe643Y3g+nfM5JKPDd7az26sWj640/pBRNOmI6fy77K45dPwhzAWEuL/tKR+4v/2EimYAJgS0ax+kX/xfirn4uIJ3RJUq234IVIF8N4jD88dqNlUvaae/KtGb5YlgR1B/98vuvrKlTagLNoQyBMabHMInlIY7g32u1xWMGcu4VPT4Bgqxs2ud8hHMJma0VaessZkIIrg4vvLliaHGz3nF8nPuaG9fu/8lYRybUzPx1hDDS1fxHX/jlj4r+yakitXSSBx8FvHnQerh7uCyXxNl+sOaGcjInyQAdM4ECjJywM+8KLEF9340L4EdL3vLRTDNuKK9xdL/jrEaFaz8/QCnCb03Qe6DaCD9ERGDmlRu4W+U1oAj4hexTtuUZ3+OW5NNs6u+x9rwHOg3U21EPMhFr8WW1ZmSbc9BpWEqVQn4ofQ63/KL8rJUAJfmn6kZV+pJ7Bj1D7Xm+6fDXWy5JnQ+2eR+MgoVOaOBWOPnujg9dA33rr+T71pEfduSKa0dLHIqTEmG7rIDizAmz3dJ5ornMJOWnsQ/7V+HOBXTZyPTiPVqFtAqm3fEN2QTlfEWssIccjgC9LoayrZ8Zt90RlGB/auAEyqH5hNkcrO7ON5BS83Iy4tUlL6xnxVTWMImZvQZM4nUwMs48gYlMyX7/Q2G4/ZgmOZGw1Zji2SqW3xZAl72Yf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(11063799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mmj5W+7beh9qb+CV/O2Ujh/pk4GPogyaej9SFi90xRCIpefOW2xdkab2HC9X?=
 =?us-ascii?Q?eGH24OYkOqe5ocM/Zf9d+Ju8ZbvHNcGqhvT5EMGXeQLA/GC0goKJpZANeQPX?=
 =?us-ascii?Q?ROqF4GlyjvnC1Kz/ck3L8BzM/piGtcqbm83KMpIiCBnDS7dK5DLhKFL1nm6I?=
 =?us-ascii?Q?wXRJoZLV7NCPhMJQWmPVXvKl0FYU7QpnB+gIOrBGKx84pJWaR8mz+RZB5CRs?=
 =?us-ascii?Q?AUVqF2m0t56O4F5tTqq+HKxyaDdaK+V4lfkd3gf514Zff+YgVbNYALnJKZdQ?=
 =?us-ascii?Q?Vi7DHiB+6EXj8aQxuqr/AQHBnKwbjImSq9+UKWXRRr6W3uNYcMZz1PmkSNpd?=
 =?us-ascii?Q?0/TBQqFaBU4zGM78eW1O3vpWmMSd063J3Nzq9bpKkmL9M6AbmB9dbDnXB2pj?=
 =?us-ascii?Q?0KC6b/i/RhS2f6BuG9t6H072FUY6HcXgtBP2NVyYF/H7bXj8DKGzdJG0oaQC?=
 =?us-ascii?Q?rtMNEKe/OglB78CNvzRw6+6zp6k9wQv/ZTQfEwrVasYy4aAFe4GJLNf2DZQu?=
 =?us-ascii?Q?OO8EHRngOvEkqO3R28vEtCQQ9WNTdn1w1usxYd1z+q09PLBIMO8NshhoL/z0?=
 =?us-ascii?Q?z16FKZfNNFc1AVpGgozn+LEaYPpBufKiCwmh+CjLoEKHJV8fHpKDl14Jd1Nm?=
 =?us-ascii?Q?r6NnYe8pTueKyTEfTS3HvPiCkv0AGvpvP3IXpAVtC/1uQlQ98nFzGvb+8a6i?=
 =?us-ascii?Q?ZKW1DELsc8DasPEZF1idp5WZflSsr9ZBRniMJbGeIbCBe+/NdbJnlejuOhTO?=
 =?us-ascii?Q?GAAy+k6tBXxrMGBrneOrpToIsUMRxPaek1x/QqYVv0IQGKcXcpveVkx5B3Cz?=
 =?us-ascii?Q?KFsbV+j7HWQlBE1uljmddOqQ+S6szJoUVp2v7cE06NFb2spIdFpA9Yk7M19j?=
 =?us-ascii?Q?tg4UikdCDVyKoCiHHe3Fo8wxsbE42HnPnArmifEnhescl6ICnp2YJOfyREqw?=
 =?us-ascii?Q?zaZlKmtFryAuRnFWnf/EiRH/pQGSVI4QSxwVMm73NaS5W0sw6u76uSLyd7Rj?=
 =?us-ascii?Q?q4Ztco8QueKe0Y4GQfPbBibR2jDqZkll/Z474pT4GHsjhlnP8P9v/nOgcPBL?=
 =?us-ascii?Q?rBPwhblGMbayZtkSiAdlunQJkYxaJanJdGBFTsWa0bwTlNyfI4BsDm9tsw+1?=
 =?us-ascii?Q?B4HSn0tnyZN4P7m8Pwp3Vy0G0YBJ5Cv7z1ZKF78mIlxd2us2yJpWAX3JoBt1?=
 =?us-ascii?Q?2ZcExlISsL3roWkqWALKralTXtY763q4FKgAnrhv94lJiYWb7tp/x5GPzE6M?=
 =?us-ascii?Q?6HZOj98IaOeOm0FUnFnbrnAtl15lSxFmHyQYylBwLkd6W49u2bQ8xdKJe4Wa?=
 =?us-ascii?Q?4rcgrQfxhxW/6lLMsks9mtUmtG6cLf3zkwac36MVae4mDX3w33n59UvHMrh0?=
 =?us-ascii?Q?Dbqd3vctaLrvKd7d48x/e139HY96DKzAzU7mNEe5/iik0wCAG+hpV9N6j2fw?=
 =?us-ascii?Q?tlTtTttorkcHcLroV8VdREFXavBoEAcN0uNPHSPXfW+6+pg8efa3yl/0LhDe?=
 =?us-ascii?Q?SS9EWIEnifpUpkOOVGJrgHKnwXongcj+H8tkl89UErXFaT1y1PayDVKqR1Tj?=
 =?us-ascii?Q?wtaP1VXpWr+ECn+upxiLGSBv+sNuHphyEDlh4TlYLfMQccdYocSQWmIMG1qE?=
 =?us-ascii?Q?iWVTc7U/cPTp4p/EYvlAvweVkO+MRA9aAtlV+cYwOgm1GC9zluGzRkBc3L9/?=
 =?us-ascii?Q?z9yOiuB1GFuyUmr+XwX6lzQi2xP6NQbdHm+lb30XrpmOaJ+U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0186de3-91d2-49cb-f04f-08deb115bf5f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 17:33:30.0116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7GzJcZP7n7oPb3JmPS0PxGNaGPRBUTUE5h+bQ9SkVsa425sZxjFe0eilFJPg9SF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852
X-Rspamd-Queue-Id: 3A0F05381C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20589-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action

It was incorrect to place them in uverbs_ioctl because that makes every
driver depends on ib_uverbs.ko, which is undesired. ib_core_uverbs.c is
for functions used by alot of drivers that are linked into ib_core
instead.

Fixes: 1de9287ece44 ("RDMA: Add ib_copy_validate_udata_in()")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/ib_core_uverbs.c |  87 ++++++++++++++++
 drivers/infiniband/core/uverbs.h         |  35 +++++++
 drivers/infiniband/core/uverbs_ioctl.c   | 122 -----------------------
 3 files changed, 122 insertions(+), 122 deletions(-)

diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/core/ib_core_uverbs.c
index 1f7a5c119cc9c1..c94d03857318eb 100644
--- a/drivers/infiniband/core/ib_core_uverbs.c
+++ b/drivers/infiniband/core/ib_core_uverbs.c
@@ -9,6 +9,7 @@
 #include <linux/dma-resv.h>
 #include "uverbs.h"
 #include "core_priv.h"
+#include "rdma_core.h"
 
 MODULE_IMPORT_NS("DMA_BUF");
 
@@ -416,3 +417,89 @@ struct ib_device *rdma_udata_to_dev(struct ib_udata *udata)
 }
 EXPORT_SYMBOL(rdma_udata_to_dev);
 
+uverbs_api_ioctl_handler_fn uverbs_get_handler_fn(struct ib_udata *udata)
+{
+	struct uverbs_attr_bundle *bundle =
+		rdma_udata_to_uverbs_attr_bundle(udata);
+	struct bundle_priv *pbundle =
+		container_of(&bundle->hdr, struct bundle_priv, bundle);
+
+	lockdep_assert_held(&bundle->ufile->device->disassociate_srcu);
+
+	return srcu_dereference(pbundle->method_elm->handler,
+				&bundle->ufile->device->disassociate_srcu);
+}
+
+int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
+			       size_t kernel_size, size_t minimum_size)
+{
+	int err;
+
+	if (udata->inlen < minimum_size) {
+		ibdev_dbg(
+			rdma_udata_to_dev(udata),
+			"System call driver input udata too small (%zu < %zu) for ioctl %ps called by %pSR\n",
+			udata->inlen, minimum_size,
+			uverbs_get_handler_fn(udata),
+			__builtin_return_address(0));
+		return -EINVAL;
+	}
+
+	err = copy_struct_from_user(req, kernel_size, udata->inbuf,
+				    udata->inlen);
+	if (err) {
+		if (err == -E2BIG) {
+			ibdev_dbg(
+				rdma_udata_to_dev(udata),
+				"System call driver input udata not zero from %zu -> %zu for ioctl %ps called by %pSR\n",
+				minimum_size, udata->inlen,
+				uverbs_get_handler_fn(udata),
+				__builtin_return_address(0));
+			return -EOPNOTSUPP;
+		}
+		ibdev_dbg(
+			rdma_udata_to_dev(udata),
+			"System call driver input udata EFAULT for ioctl %ps called by %pSR\n",
+			uverbs_get_handler_fn(udata),
+			__builtin_return_address(0));
+		return err;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(_ib_copy_validate_udata_in);
+
+int _ib_copy_validate_udata_cm_fail(struct ib_udata *udata, u64 req_cm,
+				    u64 valid_cm)
+{
+	ibdev_dbg(
+		rdma_udata_to_dev(udata),
+		"System call driver input udata has unsupported comp_mask %llx & ~%llx = %llx for ioctl %ps called by %pSR\n",
+		req_cm, valid_cm, req_cm & ~valid_cm,
+		uverbs_get_handler_fn(udata), __builtin_return_address(0));
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(_ib_copy_validate_udata_cm_fail);
+
+int _ib_respond_udata(struct ib_udata *udata, const void *src, size_t len)
+{
+	size_t copy_len;
+
+	/* 0 length copy_len is a NOP for copy_to_user() and doesn't fail. */
+	copy_len = min(len, udata->outlen);
+	if (copy_to_user(udata->outbuf, src, copy_len))
+		goto err_fault;
+	if (copy_len < udata->outlen) {
+		if (clear_user(udata->outbuf + copy_len,
+			       udata->outlen - copy_len))
+			goto err_fault;
+	}
+	return 0;
+err_fault:
+	ibdev_dbg(
+		rdma_udata_to_dev(udata),
+		"System call driver out udata has EFAULT (%zu into %zu) for ioctl %ps called by %pSR\n",
+		len, udata->outlen, uverbs_get_handler_fn(udata),
+		__builtin_return_address(0));
+	return -EFAULT;
+}
+EXPORT_SYMBOL(_ib_respond_udata);
diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index 6d4295277e0e5f..a74a2dff1301ed 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -229,6 +229,41 @@ int uverbs_dealloc_mw(struct ib_mw *mw);
 void ib_uverbs_detach_umcast(struct ib_qp *qp,
 			     struct ib_uqp_object *uobj);
 
+struct bundle_alloc_head {
+	struct_group_tagged(bundle_alloc_head_hdr, hdr,
+		struct bundle_alloc_head *next;
+	);
+	u8 data[];
+};
+
+struct bundle_priv {
+	/* Must be first */
+	struct bundle_alloc_head_hdr alloc_head;
+	struct bundle_alloc_head *allocated_mem;
+	size_t internal_avail;
+	size_t internal_used;
+
+	struct radix_tree_root *radix;
+	const struct uverbs_api_ioctl_method *method_elm;
+	void __rcu **radix_slots;
+	unsigned long radix_slots_len;
+	u32 method_key;
+
+	struct ib_uverbs_attr __user *user_attrs;
+	struct ib_uverbs_attr *uattrs;
+
+	DECLARE_BITMAP(uobj_finalize, UVERBS_API_ATTR_BKEY_LEN);
+	DECLARE_BITMAP(spec_finalize, UVERBS_API_ATTR_BKEY_LEN);
+	DECLARE_BITMAP(uobj_hw_obj_valid, UVERBS_API_ATTR_BKEY_LEN);
+
+	/*
+	 * Must be last. bundle ends in a flex array which overlaps
+	 * internal_buffer.
+	 */
+	struct uverbs_attr_bundle_hdr bundle;
+	u64 internal_buffer[32];
+};
+
 long ib_uverbs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 
 struct ib_uverbs_flow_spec {
diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index b61af625e679b2..33feb88d652b6a 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -35,54 +35,6 @@
 #include "rdma_core.h"
 #include "uverbs.h"
 
-struct bundle_alloc_head {
-	struct_group_tagged(bundle_alloc_head_hdr, hdr,
-		struct bundle_alloc_head *next;
-	);
-	u8 data[];
-};
-
-struct bundle_priv {
-	/* Must be first */
-	struct bundle_alloc_head_hdr alloc_head;
-	struct bundle_alloc_head *allocated_mem;
-	size_t internal_avail;
-	size_t internal_used;
-
-	struct radix_tree_root *radix;
-	const struct uverbs_api_ioctl_method *method_elm;
-	void __rcu **radix_slots;
-	unsigned long radix_slots_len;
-	u32 method_key;
-
-	struct ib_uverbs_attr __user *user_attrs;
-	struct ib_uverbs_attr *uattrs;
-
-	DECLARE_BITMAP(uobj_finalize, UVERBS_API_ATTR_BKEY_LEN);
-	DECLARE_BITMAP(spec_finalize, UVERBS_API_ATTR_BKEY_LEN);
-	DECLARE_BITMAP(uobj_hw_obj_valid, UVERBS_API_ATTR_BKEY_LEN);
-
-	/*
-	 * Must be last. bundle ends in a flex array which overlaps
-	 * internal_buffer.
-	 */
-	struct uverbs_attr_bundle_hdr bundle;
-	u64 internal_buffer[32];
-};
-
-uverbs_api_ioctl_handler_fn uverbs_get_handler_fn(struct ib_udata *udata)
-{
-	struct uverbs_attr_bundle *bundle =
-		rdma_udata_to_uverbs_attr_bundle(udata);
-	struct bundle_priv *pbundle =
-		container_of(&bundle->hdr, struct bundle_priv, bundle);
-
-	lockdep_assert_held(&bundle->ufile->device->disassociate_srcu);
-
-	return srcu_dereference(pbundle->method_elm->handler,
-				&bundle->ufile->device->disassociate_srcu);
-}
-
 /*
  * Each method has an absolute minimum amount of memory it needs to allocate,
  * precompute that amount and determine if the onstack memory can be used or
@@ -860,77 +812,3 @@ void uverbs_finalize_uobj_create(const struct uverbs_attr_bundle *bundle,
 		  pbundle->uobj_hw_obj_valid);
 }
 EXPORT_SYMBOL(uverbs_finalize_uobj_create);
-
-int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
-			       size_t kernel_size, size_t minimum_size)
-{
-	int err;
-
-	if (udata->inlen < minimum_size) {
-		ibdev_dbg(
-			rdma_udata_to_dev(udata),
-			"System call driver input udata too small (%zu < %zu) for ioctl %ps called by %pSR\n",
-			udata->inlen, minimum_size,
-			uverbs_get_handler_fn(udata),
-			__builtin_return_address(0));
-		return -EINVAL;
-	}
-
-	err = copy_struct_from_user(req, kernel_size, udata->inbuf,
-				    udata->inlen);
-	if (err) {
-		if (err == -E2BIG) {
-			ibdev_dbg(
-				rdma_udata_to_dev(udata),
-				"System call driver input udata not zero from %zu -> %zu for ioctl %ps called by %pSR\n",
-				minimum_size, udata->inlen,
-				uverbs_get_handler_fn(udata),
-				__builtin_return_address(0));
-			return -EOPNOTSUPP;
-		}
-		ibdev_dbg(
-			rdma_udata_to_dev(udata),
-			"System call driver input udata EFAULT for ioctl %ps called by %pSR\n",
-			uverbs_get_handler_fn(udata),
-			__builtin_return_address(0));
-		return err;
-	}
-	return 0;
-}
-EXPORT_SYMBOL(_ib_copy_validate_udata_in);
-
-int _ib_copy_validate_udata_cm_fail(struct ib_udata *udata, u64 req_cm,
-				    u64 valid_cm)
-{
-	ibdev_dbg(
-		rdma_udata_to_dev(udata),
-		"System call driver input udata has unsupported comp_mask %llx & ~%llx = %llx for ioctl %ps called by %pSR\n",
-		req_cm, valid_cm, req_cm & ~valid_cm,
-		uverbs_get_handler_fn(udata), __builtin_return_address(0));
-	return -EOPNOTSUPP;
-}
-EXPORT_SYMBOL(_ib_copy_validate_udata_cm_fail);
-
-int _ib_respond_udata(struct ib_udata *udata, const void *src, size_t len)
-{
-	size_t copy_len;
-
-	/* 0 length copy_len is a NOP for copy_to_user() and doesn't fail. */
-	copy_len = min(len, udata->outlen);
-	if (copy_to_user(udata->outbuf, src, copy_len))
-		goto err_fault;
-	if (copy_len < udata->outlen) {
-		if (clear_user(udata->outbuf + copy_len,
-			       udata->outlen - copy_len))
-			goto err_fault;
-	}
-	return 0;
-err_fault:
-	ibdev_dbg(
-		rdma_udata_to_dev(udata),
-		"System call driver out udata has EFAULT (%zu into %zu) for ioctl %ps called by %pSR\n",
-		len, udata->outlen, uverbs_get_handler_fn(udata),
-		__builtin_return_address(0));
-	return -EFAULT;
-}
-EXPORT_SYMBOL(_ib_respond_udata);
-- 
2.43.0


