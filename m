Return-Path: <linux-rdma+bounces-21588-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMr0Aua4HWrKdAkAu9opvQ
	(envelope-from <linux-rdma+bounces-21588-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 18:52:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1C2622D5A
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 18:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E11233017ACF
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 16:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488613016F5;
	Mon,  1 Jun 2026 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gmTJ6hmK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5758830E831;
	Mon,  1 Jun 2026 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780332768; cv=fail; b=WYDaWKpl1I2nF9Y88qXks2Qg6Z1eubsTSoBGBfPYo8kOGsCluT1TTGzuwx2astPpE48iKeiguIhgUNGXhcoGwBuMGyG2IeSWDDNAYEVPzzSCnPBHQcaEustJxYF4i0pY3Km1tgV+36Y6/0FOASPKP5hdtF8+Q1YtVDb9xmYU0hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780332768; c=relaxed/simple;
	bh=5dNrXAzt6oBekNOsuyWYiSg+0jmN2zBd+pLEklTip8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ihMN5bWpA2qua7SI8cctWgliqzPKn0JEQoHgeSyFQeXZT1+kkH+QR6YessMNQldl48jNyb3VC57tF0IUndNuHcSuy8Cj63BDVAEVIVaKuYg7Xbj6jyeP3dQloZ3/JMlomzBP9qoAg0OF4WFcSGfdMXud1cQt0nK4rz8ltCyVgL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gmTJ6hmK; arc=fail smtp.client-ip=52.101.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbBMY+h93uLjoHuIGs1jdTvTZ7R513VyAvL1RB4LF4CsDI1C7MmpGNpwxI+oBzMQX9kYHtTemc9oRa/CG/pfh2ilvOg5f+bnpFpdboHTwlZFbUf5wZ9OsiskkghkeBBZIdxgaqwa4WNrFBV0SpTcRHmeBXLuLfVx2OnWSXWnuzC/BojvLqslmxziz6cAnkX1c1ycmI2Ij5pDe3Z20ioMntI28INJh3448LvjowP+JlUhqCyzTrCsaB7PipN+h2IU9PxSGpp8XhpnsfuHJoF6tdNnQmgrT4rCZJ9533cwjVqSvt5cWVPMK9pM9QfNTKQZPCKyjwwN5fG8zgkV+AabxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jo+3jA4rlPNfae0kuRXE+IeVDtJtdZ+tHCYMu3X/XCU=;
 b=WTuYPg4e8D+GkLpBk4NQK7TCTNRibgR36KXS7s1xL9Jp34CcfCaQSp1U3Kkx0SigXhqdUHR/m0tYtvlmX9qPPWlPmOJdE9ViZKk/ICLWOAVK7x5FBBkfhPwjxG1zBDtII+Ob3Z0seef5f7LBRb4NvWWVQQ5msgMuIoiPHBbQfQ8vN3Ih545BEpnupuyWQMKPRsO1XX0v1vSgBIxWvIMDxnulaIu5aUl5v+h6O6XFGs6vxIQQFp3QiWHpeNuxNmS4awLs+jlA+HRWvEvjD5Hv/zoF06oaeL0RfYJL70PAF+dQLSoH3Gxuon9pE4Vt0CTaqoYdjoH2uI/HDXmJr2eMjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jo+3jA4rlPNfae0kuRXE+IeVDtJtdZ+tHCYMu3X/XCU=;
 b=gmTJ6hmKxZ6xS3xcN/KG5/l+91sX4lIE4+t48G8ABngWuZblESK9mwX6c8LwiQApIsSb1gdjBubVA5Ih+9kWwveZw0FTiVBIjkJMeShZDePYRR+7R0sLYA8J6SZszRSu48ImHKWxNBeupIzXiAcyun0sC9vUqDiBjttCCJIsUb88RpvqrHO9fsCCaPS+j9FSaBBNTPlxGnay7iUeMC62/zE2qAfu51P/Dvn51pyKqCchK0o5D3sgFomS1lcAZ6/79wc+nGdFFfFkGG9uMHSgREaXPTCaZPBxLqdRyxoku6Z5nEbCZPu0+6aY26W3ZQgXqE2M3V0ic4NNiZv1VfQY2w==
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
 16:52:36 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: patches@lists.linux.dev,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] RDMA/umem: Fix truncation for block sizes >= 4G
Date: Mon,  1 Jun 2026 13:52:31 -0300
Message-ID: <1-v1-88303e9e509f+f7-ib_umem_types_jgg@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 71a3b617-22c3-4674-abb3-08debffe2e17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DWpvCHgLJow/3KMDgVjWnbyuvPN67UgTPz7rS+bd5HLlmZFvH1DI66kOTICZcBiGkPoLjhnq9dwvr3r1KHTb4rOVNhyRUZhkFsMqc3UDJgI0zs3km+QQ6gys9b7X1x00KeyIeDIpskEhJDcPDy2EbY35WALc0JAHW7QT5IBhfQjqCMyOaSOEAzuhf3ak3Mv5JgRiztiJxOe1o3DuvxuwEkdyupSUsvsKhYZNqdpC8BqfPgnwJIDIvLkvNrpfYBj8VJr7HZxTG/jZtaz4Q0Czb/vE8YpYott8g/zJE6dDTjXIZjJbt7NLyUR3QdRK4Umd3VS7TmDPvyBxnpYKgIuXrdVwRyAa9RtOy3tXbIL3bAF6RgiRWLPGjeCue58WEHSNMLZh26e5DRy/Td5QiLeB8/XSoyH3lgtB4YUyCPqFK/zrf54+AcObws3aoilH067/+Y+bTNmkiOk36x0YSEPlNAAy9gTb4E9+ypbYFxaBS7+sPfXPEHbRVKowr8pAG0VNOMDVAaqWdgfta4+4FcppXYotaDMHcSeHFsHjJxQ92AXLzjftOLxQHTOedL6YUc6U+7n1vglv9vLof+KcXDXboHs61R3I3xL3NqIYmdWLaPQtqIZtAgNzJBzBIsDOpYhW5+RMeGtuA3oEAAtDu5BNctj0sNf4SfOTu5ytGvnboth7X8hZeZ87BpPMU1fF+945
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?csb1336lyaM4tnAqcaqq5wv7+iffjnnFHPz3GKjKOHgYG48z8yKdwZjydLvL?=
 =?us-ascii?Q?qSNuZCnxU1Pz07Cg2TUu1Bdy1kUYxBKV7gv1ssxmUqYLL1YNM01mh8Vach89?=
 =?us-ascii?Q?34xOdD1BsKK+GaaiU5pC4J6Ya9HQkrVWiKjW/1j8OwFWvXlk+SsZh2W7AWGN?=
 =?us-ascii?Q?5h5YspArza8BvCk6MEnxohKgdTWyPYHJtB51FdBWQnL6UYCkv8qbvHBd8qnp?=
 =?us-ascii?Q?s0wQy6RYY12X4MzvtNNRa5jSk0Lb5YfKlAD2vDJ7RUX3Y7rQIpdPlTbvhNPu?=
 =?us-ascii?Q?fPCqa2KEKSXYFsdcL4XB5ubqwD8Ml8WkOhyYbCTYwPmD/6u4qSL9kvUGi32y?=
 =?us-ascii?Q?ChFoLw/xqLZbiDdomvCVnj0toW915WpiNtVxrSOSuDm1zAfq+vBgAKoL6ohc?=
 =?us-ascii?Q?WhP0fXRmO8H66kjQkldJ9IAbRDttNmWfbrrwGYuh64Txfkrxv/kGJu7Itu4Q?=
 =?us-ascii?Q?AHed7ZcOGuQuPGohl4ja86inPzVa/rDWQT2ARzMFnSzEUi31rHScS/5z07/t?=
 =?us-ascii?Q?xTmxlSl1oqmwUpAT4LSSmUcuQ45ZxrxAdV49zX5fb+7Eq2oaDX+6QpCg9Gjb?=
 =?us-ascii?Q?q6pPcnVrJ4m64rspY1gKo7h0gxll4qaV4Gr4vlrUD/TVL+PmhGkkeZ6NZJrn?=
 =?us-ascii?Q?b5wSaqWSnj6u94mi3BRe2VIc04sMtzAwrs37k6uDGFgvcWutovnts1Zi7kIl?=
 =?us-ascii?Q?D1BGWoQkeSgkSTmGoyVnz18xdI9IKcXTLpIs2VuePzhtSUgSi0pwoGKsGlTb?=
 =?us-ascii?Q?/bkhFZfBXXn7rQWpyoN2pW0ZDfq+XKXeTvZUAqDHT4zXLsZaEer4e19uBpQS?=
 =?us-ascii?Q?VMPuW+D/L+0eAQmB620TVjgziyOH+1eQUBvIac/SCTyweWbCiwZ/1RCQLiVf?=
 =?us-ascii?Q?VvrlcC6rKgzTQodjdSIiW/dwOY9P0D/oY8JTAUdgBvSU8IHaImdeMJZ1W04K?=
 =?us-ascii?Q?YYDXxK8s5kr1+Hp9nElTv7K4nmW9rUUIhC/HalfYB5AJJYO7Jp/G67Rbahbm?=
 =?us-ascii?Q?uEXfwK78sWnoNra0AEe/IFTqRU27kjl3wBqpSKiRI1utPqczAFElPaKACHOa?=
 =?us-ascii?Q?CbOO4D8xID4HlqxR17LY3m3IluUARdPXY2bCaQe0wuEMsmBhTqhd+hF0D5eR?=
 =?us-ascii?Q?W+Ck4geqp6BSq36521MWGMbO+TELFX2+CqAmhftuYoQI3r4/UoyNtgeY+DiU?=
 =?us-ascii?Q?eHbqThWYEfbupDwzJH80tZRX5nX9/yjuveYfA8E26ooK4P6MqNiycxzKihX0?=
 =?us-ascii?Q?LW1Tk/MoPW6305Q3f2VRrc9y5rPRl3x4cvnGAncRwtxolLHzlG8KnRbi7lFf?=
 =?us-ascii?Q?tGN9ceG0jsxwBy6ARhtU+2bJNHYuPJ1cis00eiYR/YyN7ArTQNfgeN+0N1HT?=
 =?us-ascii?Q?VSH//TBcGA5p/MGbK1G2C1ER240aDBxMkJAxXBiI1O0hJOOJgWbaFEcRtt7j?=
 =?us-ascii?Q?Cy74hif/7439daLMyxR2GrRxWXSbs1HXJViQivniY87/MAQCXhLWJ+GqVt/3?=
 =?us-ascii?Q?I3zxjajsH4itmN9uc3LRGwPlQXgWfj7g5xyNGOMFolseQGisJxJIuqjUMVZn?=
 =?us-ascii?Q?M3WbzM0LDBUWuZoBvj3FnjwdLe5gYXng/kG0GyJGGz175HHzZPOtABz5xmyF?=
 =?us-ascii?Q?nLnyNN+1/8KUJJqqnmTic+kiCkbo6SnoOm4D+QDTXZv7aL032TLiB3te0tXY?=
 =?us-ascii?Q?bgAptbq9DrxtSbMdEY5aWHbCXtr4058Te44uq3FmnoM7vD2M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a3b617-22c3-4674-abb3-08debffe2e17
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 16:52:35.0506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2dxcRsiuXawDpiYchdilf6N1ibo/dtu3znkv7dzSxCkZVA8uIHWc5JGsOIhzRyr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9733
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21588-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9D1C2622D5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the iommu is used the linearization of the mapping can give a single
block that is very large split across multiple SG entries.

When __rdma_block_iter_next() reassembles the split SG entries it is
overflowing the 32 bit stack values and computed the wrong DMA addresses
for blocks after the truncation.

Use the right types to hold DMA addresses.

Cc: stable@vger.kernel.org
Fixes: a808273a495c ("RDMA/verbs: Add a DMA iterator to return aligned contiguous memory blocks")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/iter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/iter.c b/drivers/infiniband/core/iter.c
index 8e543d100657ee..3ed351e8fcf6c9 100644
--- a/drivers/infiniband/core/iter.c
+++ b/drivers/infiniband/core/iter.c
@@ -19,8 +19,8 @@ EXPORT_SYMBOL(__rdma_block_iter_start);
 
 bool __rdma_block_iter_next(struct ib_block_iter *biter)
 {
-	unsigned int block_offset;
-	unsigned int delta;
+	dma_addr_t block_offset;
+	dma_addr_t delta;
 
 	if (!biter->__sg_nents || !biter->__sg)
 		return false;
-- 
2.43.0


