Return-Path: <linux-rdma+bounces-20583-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gO15Ir2TBGqrLgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20583-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 17:07:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB42535C2F
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 17:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA6E9302A7E1
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE066472786;
	Wed, 13 May 2026 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cjwbLUVu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A2345BD4E
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684426; cv=fail; b=Xxy8OOEB4pKhOIHhg4njfX5Hm/rXRrl4AOf8l89Ps9kGj84RMjgCA/l0TheAgMsJ2Gte6sOfptz85dTxAZj7zjawKutID0c6fLQyY9YJysiWYB1SqELkhdczKR3zwJpy0uuRHNrYfg2YN/CTRJ7LDXgjQw0dKYnjOZHab7MqmmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684426; c=relaxed/simple;
	bh=4IAblxrmuhnuy7bEw5eqjPYSlmX1gr1kcP7ZPEqkanw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PbHdDljuzwP5Hn9+u3KdjPmEu8cKMH2IbgAH9f0S4ghl4kM4Y+lyvKm7xc7a6aJjIu4gL7ForoNOkwfUyYSNHBXoY+FKiUKW0HsP4uL8sKF2B8igoJvL9holohYJG78uxUogs0wm60AFXxfvWJEMfjs//eoWbjmMrHZbfwk4ZY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cjwbLUVu; arc=fail smtp.client-ip=52.101.43.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLJcdY79zS8OlFzIrVbMc2cgauL5yC1jbuJoFLhGB5RezWWD775BY+6Lp7VJ1BRdglynLn7+jRzFxr4rXttQmBBcS+ezsPn95NPgr0savXszWejD3sAgKbwKbJvmeFCu/XQrnJf97yTEdhwCbzRyK+0ZvhUBZOfJofTswYSN3BvuK2571CMFk7TmUOJhv7SJSFyFr6aOyHgyb+e1+o2L/rvRxk3Xo4Bgg+c7Ap1ygdTuqoZLHAj/Ce8Hfqijdq5uq+X8Zutt7CnVETaUVRvcYqRECwDsok+7kShbZt9L56ZagfFfinzoqoCUfvoQBzDJ7CJAd4TjNP8nIbngu1vpug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwNO+MifZkZBsic55rjQ6b/cHoy/DnRtlejDLIdWFSw=;
 b=sDO26qjWqPpqE6Zl6CNhpdnFaFv23UyULD1jZZMbZEIkBKWoYQF2Gr6uQfzEjW2Pc63vJ+60gcA/g0QAYYH0pJ1dtHe8Xe2+JWjLl+W2ogG3k+yatS6FHaKhopldtbGqV/+72RMwOTCaWfMqOHihXiBWPofazlkPWpQ/73AEkIzL7vFN8kOOycd8WmbFiWKrWMXwV0JZ268WStbEpXkvC8VV2/yVWJZZShhiy8gJD2yeD8dhlK5mufeTkuV8Z3zacS+ZTYLE56bkpuAKeIuqzEeuT1bHgvwZ0Jyjraa0lXahrK03AF5EoIl0xjEN4cYrXtV1MzVZdKZsOoEMOf3cXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwNO+MifZkZBsic55rjQ6b/cHoy/DnRtlejDLIdWFSw=;
 b=cjwbLUVuZdfiDKDHfS4YBpIRbgOy34QLoy0uOY3Ep/2jSlfdDCnKnOC8+RZXMkZmHb5yFD6pxVRhGvdWxXhGsitkbBjOsXsInnTFcGAzCeNsY9Tz6FuA9WCpGHKdnDSE7MG3FHIzabrIAoQzUAC9EveNfkwqsEGofbjmtkwwAGPDnq9BBcqVLoDCpyZMkt1CtqtzkTB0axv2ICy0QZfNpu2W93n1dPutlGSVHVKujRzFCs+lJ3M/Hq3kmda4SeeFdyX7/dMvtzJ/ty4sFGp/4shgykU/ueLcE0BPu6+YNVXs8dmfxplZPQH41eylWz4mmD5gLIIBeqrbrusQfDlrEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ1PR12MB6291.namprd12.prod.outlook.com (2603:10b6:a03:456::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 15:00:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 15:00:18 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: patches@lists.linux.dev,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH rc] RDMA/core: Do not read wild stack memory in uverbs_get_handler_fn()
Date: Wed, 13 May 2026 12:00:16 -0300
Message-ID: <0-v1-c4e9da262868+24d-ib_handler_fn_fix_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0139.namprd02.prod.outlook.com
 (2603:10b6:208:35::44) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ1PR12MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: e23d9a62-5e3d-41ba-a56a-08deb100589d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	m7ueRW+DifygMkiwdcgZzwOMPCbbr1f+cjsISM/jwfRVnAVVKEoQC8rvvpEioJp/g15l9rvNvxA996NpDc1gI/GtAXIEq/j8Mqx/XSEAUtSIzUbdHFSeKXmn+1Az1Kd/sQXUgxBCnO7vkME9lGWuvfMMZNxAntvnVHqz1lPNB/HiBBExQJWN8brpP0Ar1dy5KksGAiKsrRMWZzwg5dvJ4+TJFTnoAufRFlPFtHZyKQFJrz2aH05JuRnrRZEtcGweHNXz2bOql5T4ztk9OStqBYMGJteS+gBGTbrGRstiFk4/G4OyU35yZdEE19g/vl2AFwbHWR+YSmGxQ/5kdGtkeWHFBvcPE7PKxXpjXDn7yj4l3MT78sTIAkdFf0ZxusbyOHbFkf2imjuLt5Pf0fWHyIjjJTkhvLZGQAEROKHPpS3rt/lpzrnbPZwLFYqoN1nJ+WZwlMvycvQhGIfC79ECCoolgTHy/Qmz0dfPLl4p9p0mghlB3iKM4hyGg4v9ByZf+4xVvbmPKtcC0VIu+JSG2DGJ/kmtPpi/sHZpuf64+IzfNkW2rTVbnhQ2sRzUmVQqb2VGQpGqfgs/qdXfdgLsL30TLPA0AFJRF7vBFf+hwWl3PR3iPHeXI+AuutcUpap3O8AtTyXPs/XpyPZ88MR7XZIkgF+1IR+84zCUx9V+Ycd6r0dTSesPxCePvEKiX3xb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zMv18vgqTiqdpO3ctSTMlzOqDiFrzVVOokYHl07ZK+P8GFmWNyPGjS2gJdcR?=
 =?us-ascii?Q?hFFBUghQ/kYEJgnc069aays2DQnetunGgtLCQ5uTtPAXyIXTBgafMOujXE5d?=
 =?us-ascii?Q?iBFonOEVmfxOFJgdbjnwmxdAqcAXoNQcSvsvTt9JiHXIDbC6AOfk4pwq36BC?=
 =?us-ascii?Q?I0oDSXNvcFLaaEt2T5EP5/hPohwGQDAo3QcwUnoF/WgAekM9pH7fY2cLXYA1?=
 =?us-ascii?Q?eazLxRYiiR6umYwhCqcWJag7sGO10ubRQJ+w7CrkN0cRlcX/m4+CUOpq7w/H?=
 =?us-ascii?Q?l5v1WOSjZ2mzWFkF2LnQzYtuBCzpclfovygJzw/o6ogMENmElUAA7gk6f4JG?=
 =?us-ascii?Q?n4Oj9mr11Ib1eOwQpFPBsFY32xzRZ5u9kq9usI2bvYLwOZilFSr94C+/KA3O?=
 =?us-ascii?Q?/RSAWrAZLn2S5jhWsA+NdYrc1usdRJORCsuyjiw46QlAxSGTI7UMdhmb1hkL?=
 =?us-ascii?Q?FF9BIGKfopcyk7RzK7u9aU8GT75VKIE8wlKYRaJQJk1bPUkzNDOKMGbkUG0p?=
 =?us-ascii?Q?DhmIN7eCs4TZ55snUROMScB5MM4tPKba0Qmo3y9fePnT4LwIthdYmj+ibtp0?=
 =?us-ascii?Q?Wg82H1EPCwIwvzj3hM5qzlvMbp7dQXzcmbyYQYqnLU2tDsEeihsy6BGSbgm8?=
 =?us-ascii?Q?XpVcQmqg90hemyGvjK1YRZZ5oRnS5u75VrQFtBPc0MClb7DQP3KsvXJvdiZv?=
 =?us-ascii?Q?/nMJ/nTWBhD4JuD9J7helBYgJ7eFn5jlvMvmqkla0ZZv2lWqStYBibnbZVfn?=
 =?us-ascii?Q?8lO+guuqMgg0vFLO4cp8ZUJ0B1sv0I+9Q28HCHBxIH5y1f6JAULoB+pODdmG?=
 =?us-ascii?Q?qAxezpbpD3gv5gWKZZeXehtEm9KjZWKr3Hd9A972f4KaKUryLP/+30jdxhxz?=
 =?us-ascii?Q?AnrAxlWcsY9b5C0HN8RIRn3R+StM/SUTgJEyv73UFJvw6flGS0+ICAeUb5lB?=
 =?us-ascii?Q?QVxRgiPybBtWBOisnpM2pJ09zMhKZCQwDMDXYfD+WWplpzBvWhe1vIXCeuEw?=
 =?us-ascii?Q?29dC5SkT3Cheqfcig2ysqc+fVCCVyR+s8COA9R/xu1MV1ewz2/aB8LdyD6/b?=
 =?us-ascii?Q?mGIC4J6hCRtkSw+gras9C9OpclnQpGAq32yHr+qAxbjavSc5Z/xcBZ1rfv8e?=
 =?us-ascii?Q?h9Lcawa9wwpAzdqzjovtubPNLFILAp+Ncw4HwIjdCdKx2oz3Wz9hUKfonAuq?=
 =?us-ascii?Q?pifZs6bjz+7MWhdMuSnHgPkCquDl/YL2WQqqDFciyO8UxI6KJq9WOvWnhHa/?=
 =?us-ascii?Q?2GzIV/jYuSwF7tccESzGMb6bKXS/ekfLYxGVdAFF8K/elqtYIiPsg6Ycg3GY?=
 =?us-ascii?Q?ZjljWRt6fPQtGqfC99Mec49ttQ/L+qcrUna+sLgGas6oQKzu6GbmAlb7KXCc?=
 =?us-ascii?Q?a73rfPhtSBtfLLPkKCN702vcq4p/0jpbQqCXinnxHwQpNDX8gqhXvSmMX514?=
 =?us-ascii?Q?C5YLqaV1VltdIr2Atq3qkSiv2vVlNI8m8oqnqzJK4x79x9UUfydbpDmWc5b2?=
 =?us-ascii?Q?lqoDa3oyOB9bUzehI66QgCrMPVbiAly8WHxn3/3QueukvqGRK2gaIy3+Ol9X?=
 =?us-ascii?Q?efj4upVx4eemoYNE0w3CpoRk5G68JN6efo1fgN/rgvR6iCC4cusmTDckqbsc?=
 =?us-ascii?Q?eWj28ZlyWaJt27lhfNMNQc+GWsbv/GBi7ieS1+roXn/SU/g4MR0xlPOPNRuj?=
 =?us-ascii?Q?JrbCYEc1B2ZnVbjHzohZZNZ0lSUaBll6uxArVTjsV8j4qGwj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23d9a62-5e3d-41ba-a56a-08deb100589d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 15:00:18.0369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1otUBjA0mCE4r7OG/t5re8aYLfv3/lB73mej2o5xhD/ezscQY0PZXaFyEw0TGgMh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6291
X-Rspamd-Queue-Id: 1FB42535C2F
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-20583-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Sashiko points out the legacy write path in ib_uverbs_write() does
allocate a struct uverbs_attr_bundle, but it doesn't wrap it in a
bundle_priv so downcasting here isn't safe.

Instead lift the method_elm out of the bundle_priv and use it for the
debug function. The legacy write path will leave it set as NULL since the
write method_elm uses a different type.

Cc: stable@vger.kernel.org
Fixes: 1de9287ece44 ("RDMA: Add ib_copy_validate_udata_in()")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/uverbs_ioctl.c | 31 +++++++++++++-------------
 include/rdma/uverbs_ioctl.h            |  1 +
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index b61af625e679b2..e185af57dc1a93 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -50,7 +50,6 @@ struct bundle_priv {
 	size_t internal_used;
 
 	struct radix_tree_root *radix;
-	const struct uverbs_api_ioctl_method *method_elm;
 	void __rcu **radix_slots;
 	unsigned long radix_slots_len;
 	u32 method_key;
@@ -74,12 +73,10 @@ uverbs_api_ioctl_handler_fn uverbs_get_handler_fn(struct ib_udata *udata)
 {
 	struct uverbs_attr_bundle *bundle =
 		rdma_udata_to_uverbs_attr_bundle(udata);
-	struct bundle_priv *pbundle =
-		container_of(&bundle->hdr, struct bundle_priv, bundle);
 
 	lockdep_assert_held(&bundle->ufile->device->disassociate_srcu);
 
-	return srcu_dereference(pbundle->method_elm->handler,
+	return srcu_dereference(bundle->method_elm->handler,
 				&bundle->ufile->device->disassociate_srcu);
 }
 
@@ -445,13 +442,13 @@ static int ib_uverbs_run_method(struct bundle_priv *pbundle,
 	struct uverbs_attr_bundle *bundle =
 		container_of(&pbundle->bundle, struct uverbs_attr_bundle, hdr);
 	size_t uattrs_size = array_size(sizeof(*pbundle->uattrs), num_attrs);
-	unsigned int destroy_bkey = pbundle->method_elm->destroy_bkey;
+	unsigned int destroy_bkey = bundle->method_elm->destroy_bkey;
 	unsigned int i;
 	int ret;
 
 	/* See uverbs_disassociate_api() */
 	handler = srcu_dereference(
-		pbundle->method_elm->handler,
+		bundle->method_elm->handler,
 		&pbundle->bundle.ufile->device->disassociate_srcu);
 	if (!handler)
 		return -EIO;
@@ -469,12 +466,12 @@ static int ib_uverbs_run_method(struct bundle_priv *pbundle,
 	}
 
 	/* User space did not provide all the mandatory attributes */
-	if (unlikely(!bitmap_subset(pbundle->method_elm->attr_mandatory,
+	if (unlikely(!bitmap_subset(bundle->method_elm->attr_mandatory,
 				    pbundle->bundle.attr_present,
-				    pbundle->method_elm->key_bitmap_len)))
+				    bundle->method_elm->key_bitmap_len)))
 		return -EINVAL;
 
-	if (pbundle->method_elm->has_udata)
+	if (bundle->method_elm->has_udata)
 		uverbs_fill_udata(bundle, &pbundle->bundle.driver_udata,
 				  UVERBS_ATTR_UHW_IN, UVERBS_ATTR_UHW_OUT);
 	else
@@ -499,7 +496,7 @@ static int ib_uverbs_run_method(struct bundle_priv *pbundle,
 	 * assume that the driver wrote to its UHW_OUT and flag userspace
 	 * appropriately.
 	 */
-	if (!ret && pbundle->method_elm->has_udata) {
+	if (!ret && bundle->method_elm->has_udata) {
 		const struct uverbs_attr *attr =
 			uverbs_attr_get(bundle, UVERBS_ATTR_UHW_OUT);
 
@@ -520,7 +517,7 @@ static int ib_uverbs_run_method(struct bundle_priv *pbundle,
 
 static void bundle_destroy(struct bundle_priv *pbundle, bool commit)
 {
-	unsigned int key_bitmap_len = pbundle->method_elm->key_bitmap_len;
+	unsigned int key_bitmap_len = pbundle->bundle.method_elm->key_bitmap_len;
 	struct uverbs_attr_bundle *bundle =
 		container_of(&pbundle->bundle, struct uverbs_attr_bundle, hdr);
 	struct bundle_alloc_head *memblock;
@@ -608,7 +605,7 @@ static int ib_uverbs_cmd_verbs(struct ib_uverbs_file *ufile,
 	}
 
 	/* Space for the pbundle->bundle.attrs flex array */
-	pbundle->method_elm = method_elm;
+	pbundle->bundle.method_elm = method_elm;
 	pbundle->method_key = attrs_iter.index;
 	pbundle->bundle.ufile = ufile;
 	pbundle->bundle.context = NULL; /* only valid if bundle has uobject */
@@ -617,10 +614,12 @@ static int ib_uverbs_cmd_verbs(struct ib_uverbs_file *ufile,
 	pbundle->radix_slots_len = radix_tree_chunk_size(&attrs_iter);
 	pbundle->user_attrs = user_attrs;
 
-	pbundle->internal_used = ALIGN(pbundle->method_elm->key_bitmap_len *
-					       sizeof(*container_of(&pbundle->bundle,
-							struct uverbs_attr_bundle, hdr)->attrs),
-					       sizeof(*pbundle->internal_buffer));
+	pbundle->internal_used = ALIGN(
+		pbundle->bundle.method_elm->key_bitmap_len *
+			sizeof(*container_of(&pbundle->bundle,
+					     struct uverbs_attr_bundle, hdr)
+					->attrs),
+		sizeof(*pbundle->internal_buffer));
 	memset(pbundle->bundle.attr_present, 0,
 	       sizeof(pbundle->bundle.attr_present));
 	memset(pbundle->uobj_finalize, 0, sizeof(pbundle->uobj_finalize));
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index e2af17da3e32ce..c89428030d61ae 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -635,6 +635,7 @@ struct uverbs_attr_bundle {
 		struct ib_uverbs_file *ufile;
 		struct ib_ucontext *context;
 		struct ib_uobject *uobject;
+		const struct uverbs_api_ioctl_method *method_elm;
 		DECLARE_BITMAP(attr_present, UVERBS_API_ATTR_BKEY_LEN);
 	);
 	struct uverbs_attr attrs[];

base-commit: a2009b0ca05ea2a937109e3844769209c07f93c3
-- 
2.43.0


