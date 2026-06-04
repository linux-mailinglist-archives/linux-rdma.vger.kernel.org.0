Return-Path: <linux-rdma+bounces-21720-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CAAGD9XUIGov8QAAu9opvQ
	(envelope-from <linux-rdma+bounces-21720-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:28:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C55C863C329
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:28:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=hlWOKF0q;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21720-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21720-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AF48302ED61
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 01:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6B6261B9C;
	Thu,  4 Jun 2026 01:28:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24125A321
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 01:27:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780536480; cv=fail; b=mSBbMJOsO5D6/0VSbGMY5thAR0QNs8kf8G1NXBLuZLEldPbKI1ydG4A0akK3ifIMlNLVn3xp+M/YT+G9jqCXHEwj+FapEYEdagtv3ULJKjoHs/p1Uo81odR0SukyZ0M1J3CDw1SWn1f5wn3cRNQznFyerzQJrE9QRG445Hio79M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780536480; c=relaxed/simple;
	bh=ITrnRi8eF6wtinPUBkxIIjSE4cDx2coZUb0WunM9bUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JTNduLc9mMJui9WMXJ1wxb2bN6sfxdIoDHY5aZhl7DKu5g+0+d746VskJvPVLQcRPBAqdQZP7WVha6AmVn6CiF3e207fu/x/SlkBz7DUKa1rSywuDE0RU+rrvrWY98MxCtH7e3i8K8kKBjyb1hVlzIRwpSM5vCrzicfEuB5KoOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hlWOKF0q; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HH/UogJtGeQIPouCi1uKVJQ0TgMBt7haEhi9VNfziPgbI426v7lsuIsRyTp+GXTiMta3PRYniwbzxrPaJtrLWcwMEI+KYiLAtdloIkkb3365+QvnqnwcsbE2em5haJAZ73AszRj5lD6BrYphsM/VuG55SXj3tZWVI08XGKGw61PBZqDSGN9s030iXMEXqvucoc46zclBt4H28kNEfOowJd7aBjAZuBnXNDNxc1gJGzkk5r6vPXmshVh20ae0HJsterGT0asd1uHVeG2Q0yWfErnp9nrE37XqZUO0NXDxbp4xZDEDuTiglKUeuanDDiNyRBtSvG7Nv0r5W4X+De87ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kURUZZn26KAiAhfSQW5D/wnLz2TSUa//Q1MCcWt8lOM=;
 b=qD+9GEQ3wAyicY+q1hh6X46ZllvQ4I4Tp4sYcen2/SW15jfHOzw04HbNlyEq2nH0eYvoXnTyGdRk8zdMkyTVtgU4T8qwomTcH/9JPSP+UDevGY0CWZ+ZfTsWsj2f78UtBrT7DngG/BS117gUPsET9Zt59Sw1iNL3sDmTACBF/ZlCVD/Qtq5kw7qiavR6CavDGzgojM1pqfQOi3ppuy/9adtWwIRN215BM3wk5gVjJ8QMzkWnIFzhDBC8v1sVWeIOQ3y1AtYImI0UtFRS1zx8cvbILbDwI9YPYHHQBlgyNimczmNZGGyTi1R16/KQaoVdbXtSb2DRn3fb3wmZaunxmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kURUZZn26KAiAhfSQW5D/wnLz2TSUa//Q1MCcWt8lOM=;
 b=hlWOKF0qcLwWdP3qqJ0ollSuQrKGTTf93KIDdnYw5UhSAotHgHiqCoO/+Y9cP0450K6OvC30hQwDoiX+ZftdytMnwHT+mtdhwG4gnwjYKfyzqmjKppXIs+unCpGnBpIq2IQ1aPAtPC6a29LXKVdWSSAEXW+QgyFW8hZtbyaQFlergpt34YXaFNoCQGWqMgEXvWsVJFMLqBuN3imBmrxY7hPKq6vLtd9w3Z2WTUg8ORHIMYMZjymuPBkirkiLQVdBUJE2k7FbTUAD3UdvIDX28AXehMhO9fuVUd7wqeBH9WawP/vlokUqXgmP9xKGbZhRs/QssokL8wSeWIBILjsRNQ==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 01:27:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 01:27:52 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Doug Ledford <dledford@redhat.com>,
	Edward Srouji <edwards@nvidia.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Matan Barak <matanb@mellanox.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Noa Osherovich <noaos@mellanox.com>,
	patches@lists.linux.dev,
	Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH 03/10] IB/mlx5: Properly support implicit ODP rereg_mr
Date: Wed,  3 Jun 2026 22:27:42 -0300
Message-ID: <3-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
In-Reply-To: <0-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3b361d-e83e-4c59-9494-08dec1d87e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	+dXHwDrI2II/oUtZrS7beAYrYoSxJF7qIuOMVpyt/fpVuJ658uxsasXJWG68d4SysMcJvBu2A1fonk+Jmt76HqmLNYoeaGboYxhxYY0W3GY1ZbmtiCXAeWlSDD1mIUWFa2Q8eZGjm76+4isn3S+4gRkufPPBZleuSZyootVmIErcR0zHTL8VmUg6813HaDIzt+vknH+CsugMn5WcQaEy581vMNJpveBHl4Ed+9AC2Amn8nVNYGZADn1CIpH9pC1ZcktD5+kD6hsdV2GR1KEU2UYjML/lMI2BuaVCyo5qzLMe8IIUnjp1ZR3VUz0fF5u/YVFfdWoVf/bk01GZM7QJYtZxfmsYt4dVSPbkuwi50LbkreV0Ir5YZe83cIaQ9dHR4RdGvcW8JdXcRelDyiomFkskixoC0cIbgSQkMw6F3yjy+kJfxX0k9ocmTc9qsBiLK0RtkgjW54qNqaU4kNX5B6Rj9CJVu4zbZXXy0HzHO8kGvTLnuVLk+KeS56WmGIeXWCA5fF9tJMuvCKsvOctGj8qVHpFUfUEr6T61WeRteDGVCJz44qVI0tDH1jnjHp9dnNClsVFXWJ6GxdLzUJQ4xGZAiDXp6qWBbvcwuPvqK5qnIEy/0DdaB6sBkPSXgN+tJTNCK8OJQj18fuJkDklujrkPBnuXoVhrp1szFD4yHHKfkXY0yKtQPbz5cUnnSwUz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lAFp5Zc/Dxdi82/8PXybvgS9IoLHLdPy/La8u3R4HvB0ghfAQ6MGZWwykQwx?=
 =?us-ascii?Q?M2kjPZX/vOyu690NzUORwO/tN7LwGh/YVcdLjv0k0SsSZiQFTPsEmtcARVQE?=
 =?us-ascii?Q?R3Q8oYTXmZUKREVg6BtaQT9CAG9ALqeLFZJJo3/tHeFJgn4hidRxtA2pyVL7?=
 =?us-ascii?Q?eWPeeySXwNOrsozW6LZzBGe3bokjABtuStgryAOLevN5rB8cTL6bW4FoxrNI?=
 =?us-ascii?Q?LiC8ySmqkJ1ZryYNsU386yz+cwcOZZYjwrr8mSCVlADQbgcyQAsOtSaaZcjH?=
 =?us-ascii?Q?+hiFq7T7TQrDyI21t3T3LExGeb6vIJynYqLHd7BPbMNJLm9Z560vfhWm+inq?=
 =?us-ascii?Q?lYt6/68X6CMVm3i3Bbt57Y+8M59krl2ux2+UXf19DCxgcZ0YsCR/kQP2sLMN?=
 =?us-ascii?Q?2k3mgAU77xuEgn/wt11azyeGf/OTq3yMtCRhUjBQPt5gk/RdJkNIb/0pZEll?=
 =?us-ascii?Q?RRUIKoBNT53sjYk3Ze7CQaB2Veh8brbSirSh7HN0023sLSsHOvnTG5pW/3Qv?=
 =?us-ascii?Q?yrU87nj4QDHWhfnWYZBOOc/axSdvmW6LKnpqgpytpquHBiU7zuQLSbtda4so?=
 =?us-ascii?Q?M2c9ymZsPckGymhCROLFVrl0jOWJrdSf9iuMnF4VFxfrm2U3igC7BS70HZKL?=
 =?us-ascii?Q?+zBbl+LbkJXgayjlodH/msumgqC2SnKHOQxsg7iJ7NGAV68atO+RN3yY3S+c?=
 =?us-ascii?Q?EeQrTnhpwwLBKJtqp9zxDGbiCuNIaDYShv9hsZIR9qh4EkE1+LJW4LazRCZA?=
 =?us-ascii?Q?9k7FkNvXXPrdWJa7PodDfpBiERoxagRve8Ur+19QNZKuuS8OU11QM7yxEMNF?=
 =?us-ascii?Q?bKW5Ybqm9OxJwpsSTZV3zot2LqM0B3hvm6OZSDXdflGyOlTsZHuy6U5pibMC?=
 =?us-ascii?Q?VgI5PXPhOxByrAogrO6/hGJZuwEoAeQM5HW8wsIdbVHsnUisPCSr1sn4IV1d?=
 =?us-ascii?Q?TMUyJSIBn2meWQyxjfYCK3xVdI/Gaf2a14yN67Q/7yB4gBHxBdrXvk7aAdiO?=
 =?us-ascii?Q?B0CQ2+FL/+HYRRIkZF3R8I6TmHWuxLk8Vxi9UMlATgtzBkMc8C7wXW/mFYs5?=
 =?us-ascii?Q?Kxun7QEzZPXm+L4yOxsHDQ98F/+mNHttYDrIPKQz737YinEBexGoMp1nWHep?=
 =?us-ascii?Q?3LNoJfQFctONehgd3cTN4I/8082RKqiDNE4rtO45ZaX6VGgcUB/K4cIcgJuu?=
 =?us-ascii?Q?dtrh+QyW1sF0i7GgUq1QlETIav26DtRhIvTeKbJImItjOmg+QACguyUm/LnW?=
 =?us-ascii?Q?XvdDyMDtfNpq478QTsi4mtBeqxYH2bX/pRrlvjsEzuLUOVzmIPlUVaM2+MJ+?=
 =?us-ascii?Q?5wye5Y3hnX/QftYYsbJMmep2eFdivB5WGyp5rL/u2kgBZEMVvpRvG3amt5xJ?=
 =?us-ascii?Q?m9UXmPspBDdpa1G/1o1qV5Cw/wq/sL832eHrox8LCFmm9cc5Zq+YMNGHd9mA?=
 =?us-ascii?Q?/Fy7bsITWBaWz/lSsvtl0ESAdvwaBDuBy8q8NW3JPY90+9CC2axohUt1uSTJ?=
 =?us-ascii?Q?Q2vpKHzEOX2M24uk5gQoR5HCsRtcLmOtOaA4lb1jIm0LnM+BV5bz3Uq9zoAv?=
 =?us-ascii?Q?r1Js5OZb289MZqGovsOM9+1J6ULRZPpu6uDXl96fsHdF4cOuSSYy6T71pGlj?=
 =?us-ascii?Q?vEGRFiBR9pWD7XYZAwhGAuGbsVSDzMJRNWf6SlSlBrzpIwjaDcMNguymZ+5+?=
 =?us-ascii?Q?6A0QNMcPSOm2naoJ2cGOAotPb7pRcEWtRLJZdX9bxUDF7XwH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3b361d-e83e-4c59-9494-08dec1d87e3a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 01:27:51.4315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhiO/W8oVCA641cNyqg/+XmkT4j2UlodW/XZm31y/B0EGh7Y5ij21P6bxZWRs+NF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21720-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:dledford@redhat.com,m:edwards@nvidia.com,m:leonro@mellanox.com,m:leonro@nvidia.com,m:matanb@mellanox.com,m:michaelgur@nvidia.com,m:noaos@mellanox.com,m:patches@lists.linux.dev,m:swise@opengridcomputing.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C55C863C329

Due to all the child mkeys in the implicit ODP configuration we cannot
change anything in place for the parent mkey. Instead the whole thing
needs to be rebuilt if any change is requested. If the user does not
specify a translation then force the implicit values which will then fall
through the logic into mlx5_ib_reg_user_mr() to allocate a completely new
MR.

Since implicit children were also touching the mr->pd, this removes
another case where the access was racy.

Fixes: ef3642c4f54d ("RDMA/mlx5: Fix error unwinds for rereg_mr")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index c0ef50d04a2698..ab0ba34448eb89 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1188,6 +1188,21 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 	if (!(flags & IB_MR_REREG_PD))
 		new_pd = ib_mr->pd;
 
+	if (mr->is_odp_implicit && !(flags & IB_MR_REREG_TRANS)) {
+		if (!(new_access_flags & IB_ACCESS_ON_DEMAND))
+			return ERR_PTR(-EOPNOTSUPP);
+
+		/*
+		 * Due to all the child mkeys we cannot actually change an
+		 * implicit MR in place. If the user did not specify a new
+		 * translation then force the fixed implicit MR values.
+		 */
+		start = 0;
+		iova = 0;
+		length = U64_MAX;
+		flags |= IB_MR_REREG_TRANS;
+	}
+
 	if (!(flags & IB_MR_REREG_TRANS)) {
 		struct ib_umem *umem;
 
-- 
2.43.0


