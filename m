Return-Path: <linux-rdma+bounces-17430-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KhJGoQ8p2mofwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17430-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:54:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE631F6708
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 448D330BA403
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 19:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF45537F003;
	Tue,  3 Mar 2026 19:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h+B/M6Yi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF9837C913
	for <linux-rdma@vger.kernel.org>; Tue,  3 Mar 2026 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567420; cv=fail; b=JzuczDaGRPPzgXKnpS9K53q3HvKls2OpOOUFx5vDcG3xUhbdY+mzozDUe+JcAPIItPT9oKz8YxH7JI7y51ErUwYbsrQMz+6faFsP874vrqsEL8RnXhqoDAYNMZFthYrzvSX1k8g6XYVssac7t5Sw0v0giH2fQrE3fPU5ODoaT9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567420; c=relaxed/simple;
	bh=NEoGIPYCySxunIk0hOVxc/njw0QuaqOOf81GXjZIa9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iw16MFvDRURUeJsG56zRN41R/D/Ju31QwEu6PUtJzbr6W2Ksk/g+HN1sT/xZ9+M9simewnmIZe9XtB1ksDq+tCpo8uZQ0zBbvR++dkZZe/lYyblDGcLKb+iP4pA+JYP8l9GKoISjA1okttLZMQb9zzYMiNXvK76nHzV7ssIJpt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h+B/M6Yi; arc=fail smtp.client-ip=52.101.85.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZX9BorfizeJ1TAeVBjA491XfzZFY6lgH0IwyLKG8IxjI83b0Gr8IUaAgax1ZZonayznqAycM/y/FFwW/O8pTa4n1kcstfJpiSs1qCMEWa0R7z4qBKLAJQYQmtOUzAs5tWpfrwY60x2uYKozZ7Dsu6GtcVG+fCfOIvZTCmIQpWOkRopeCXnm3ORSAw7bdL48t+XhxbdHSjGZbBWzeOO2FkqFwlwKhBHyiB3YeppQuuhDOcGwCk4AniXTxXNJlux6YgL1/WmR4nBLBSNZXUaMHpqHhyibUp3pVRqdJtrTqahdR6GDdfSGNOg/rbTx69niGrsc5QhT/ag9Q0eQzD2ueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9MR4TAqfWaO+lHYrXeyER673Zgp8XywSM4X+c5IHVg=;
 b=BluhyscAohucTeNVLpx29cIIfqhVMgDuBUfthZSnAyt0WipfQEYT/0jeQJbcAQcaaMIlBPlmUWhS8KG48e/sbZLxfFI/xmQ+jxc3AmKzcRF4/yqq70eI9mh/KcC8pjHdNlgYiqh2FYU7Vsij6j6618IjapBbocDDYrozLg0jNLgo3eVWxagjJzk3omAF2SrtLJhl8F6A8NVgf2f55TJ+TjW+b0/pslwQnaNA2E7rB2Hp1kISn0f5D9KAAuXLsjI1PHysD8GYANq623aU4G3IhItvsmDUhyitpzR2W+4Awr2sVnUGWOJKy57PtteTuu9y0DykRa466qNVJk+TfgvITA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9MR4TAqfWaO+lHYrXeyER673Zgp8XywSM4X+c5IHVg=;
 b=h+B/M6YiNEBnQE2qlqjKAb+3X6+wNACBvEJrOplyVltflCfmp4Xr2FueAvLi7HvblFMZxtSmX0DfbugKwLGuYRhz9bsRPoXTbC8IP6Wt6d+xV2HTUBJpjVo1ayXorSgF0GF0hhNgbCDohUA5wXepzOtAWWyafcWVoyuirIJUrHa7bRwZYNITkIiKbUpoI2XfXDm3/Eaxf4KBv1zcUMqV+5sQgtx+tLJlji6TBfDc+6vmZYSBYwHLCGdZOUq+xPnQtlija+VCUO0SJeKF/Q2IzN/7Z4jF1fGF7gIKCoCVVpHQpElMEAONQ90AV6fB+YNUZFl2e+eRQ8LqBIVshJLE0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 19:50:14 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 19:50:14 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v3 04/13] RDMA: Add ib_copy_validate_udata_in_cm()
Date: Tue,  3 Mar 2026 15:50:01 -0400
Message-ID: <4-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::30) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: c03eb68f-ab36-4b72-f62a-08de795e147d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	K+tIbIPIuXaLTYaPJKwswM1EGdAWMYpXaNNH9r4dAf3BiUzPQnc9JySq/rFnOmELxE9elBhZ23ePKGDKfHuy1De2dXmhz4CI0fPunomNGYKk21+qBhZkxyJbJfTecPtWGZX/eTJTElqG6b9vtyiQJDI1LgFbUE+5xTUpBFRPwH3/F4rFxG/LbNr2+F+xO/p1VbCJxYTU3dQser2dGvTtzaJWWhvoWykeyG+ucRE7Cm+khlAW183d4wLJVD4vHaZUDbeSbbXRcfbDT3H13EAksIETuzYWtHH3qMDCKaMLK6fnzo7lq0tCK2wyxTxT7+CCzcIMY4uUIfGwCI0dUiT9QWHYvM4vHc96TQBSSWf7JfD681gXGzVBlRCrFgRfKtZG8ie2s4BBiMFLhjZyf6JniP8J4zt9TfQQ9J824EVglkVrMzWwVh+l6MyUS0RXn+sC4Oh+Xm+Qdce4IBZUxxmYIJ0iKkBC5Hzy8Gzhm5AxWKYaDmhyup8ML861r0qwvVW15FF/k92ouTKnZAxGR6ZLNMzE82Vu+tB2edqSd9Q5TMF7+eeCHK7VBFtImONGRJP4qgzrIMc3957Q22O84jif1G1+Dwg8X9i7nQ+riJuyus+z8+pDM7H4n35Tq4Jo/Yc4TSievw9hjVvOYyTAWJduRcg9db5OWGQwClvU1wpz5sIX5xKS05FWa8FUJEye2IMXKwlJO8jNvjylCxrjdNYX8dO+a4A8ThzZ140lhf66rps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jL+DAV+n5RLHSkEkV9Q+mthKHJcZ6aa22u1f4jP2tUblC4dr8gCw/enBJDIB?=
 =?us-ascii?Q?3GRcfe86xPnzEXCT0Tj5QhOy6wiFQ+TgufgB+KxTh45Yab7o4KeNRD1O1iLd?=
 =?us-ascii?Q?zg1HCWiR6euKnrPH7oCGXWfFx2RqfMua2nJYV/eGlogO6JyglJR/IEazE98C?=
 =?us-ascii?Q?CfRJVpqk2PDmJ+OSBZoAehrbY2g4K5/mMoGg2R0vIWa85MnSFanJu4JGAL7e?=
 =?us-ascii?Q?cCM7qIdwq2Z9Z7bsaSuW/Yyf2u0IAAdDJPu57EsEJdKVhxOT69ET/U9iLUSc?=
 =?us-ascii?Q?4fJXOTdHCjThpWwqvPKSIzaBsV54WCsL6ZVNWL16ustmybDFspb/sIb0g0Qi?=
 =?us-ascii?Q?tqeuErEWxNxH+W9s5vE5j7OA+BYQga3e3AwwHk3YTBs22OCC9wBbRNkfKLns?=
 =?us-ascii?Q?NGpbHNKFOjoDTL66IN7mugYSd0ZL8LsO71S7ez7VwdOb+lp2wW2WySwZv6Yu?=
 =?us-ascii?Q?N21gtjwCwypZ5nX3QFl1T2o1tOK+kfqqFLTOAjxA2dmoNlqukIobdfPh3zD1?=
 =?us-ascii?Q?H9A9uGRdL8DzV2Mbz8nxgvoX3cIjkDNWhrQP7cx0RauLIzC0ldxuFdeJOK2J?=
 =?us-ascii?Q?xLIzs6SSa8962nvZrdcPAm6/ZdinaxsXn61f7JgrWBEtp75LC6VkWP3+haRb?=
 =?us-ascii?Q?Xh4EI4nBzgElR0cHQl65fOzm5OORHe6mrcG9US7p4BrmtIoxrdew6l2TeqK/?=
 =?us-ascii?Q?4zQNL4dxyqgHWofXc6xRA7tcalfMv1N5cf28Mac18S1Yb+/uQR1BwOwcM9UJ?=
 =?us-ascii?Q?ak+dqi+8AZIDX7KnpixMXsxJv4iPN3f6xaF++ogPK/d6yZpvZjuTdSoSwrWc?=
 =?us-ascii?Q?/8kg06HZDxg00T9DnrkKrBCjGGWOQs1pDbsEAqhWfTdxIha1OpyxQaY+N9Rn?=
 =?us-ascii?Q?Wj8O2COupWPbyT725+BUAsQdvm4vsBk4mJGS9Cby8rW1NdtvKzsFV/0E8B/t?=
 =?us-ascii?Q?H5D+dKvGxpuXw+Rfqo9dY3wQw607eRS7HCBWs7Q6l0p8P2Ny0GUQ7MEnE4KH?=
 =?us-ascii?Q?GRkWpH5GlOCCL5S7zGyaLhI7zu6sl32Q4xIj8+E6taT66+DdKSrK26gvr5V7?=
 =?us-ascii?Q?QfoXf6pGlR7rrAktVyVCTvI/HsZZDxdVH6Mhm5lt4ygUM/5I9PEiqnuxWFyf?=
 =?us-ascii?Q?xotBrFWB93yBj5DGGj8Gc7XhgQeNvA4TAYwVy+sIfFhg0+Pffam3qUH4q47v?=
 =?us-ascii?Q?dLmTVzktu40ZB3n9m5x+O86SD5JE61Fl3NLGOGsEqd6HjnBW9F3wvM0quvuU?=
 =?us-ascii?Q?bS9Th+4vMrWOQNSBjJ1rMiApa/X9AqTM6ss8kt7DSWanKHCTqMQx7vZSKRaf?=
 =?us-ascii?Q?j+V1nmcZLMzcwbw/lxtmhJl1GQoR2pbIol5xl7sfB5oyLWOqrNNf/itiT1t4?=
 =?us-ascii?Q?O8tlKwr6QadoE03MiwVxBgFmHUz6dbkNPZzKOynCc+ksj/NsdoCG0b1v210s?=
 =?us-ascii?Q?jjUghDrvWm9vjJALg0nmpmhSjmCTw9s30E+mEDVJ0dR3Dy04nrIKyH4rJx8t?=
 =?us-ascii?Q?Cklgsdgn13z8vReCnUTax0TnCHEXFcCCbMQevmPwUQom0IaDrBXwItMwJcbD?=
 =?us-ascii?Q?7jqoB6UetLa1T60o/U1VaCMuc6/sYjv04T3PWtuiAor8oWzLsIw+sB91acn6?=
 =?us-ascii?Q?/w6Dj1iSLVmY6H72PatwIosNUImDMjPaBasTTppPxq2WqeCxU0WCmleWso3K?=
 =?us-ascii?Q?IjVkCoVX4azwcz3h3/hlYE7c3uTgn5T59kFf9hqrdiwy0dYsaa7PKvnSEtCw?=
 =?us-ascii?Q?zbwEh2FhrA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03eb68f-ab36-4b72-f62a-08de795e147d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 19:50:11.5281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LACpTy93YW9vhaWAwVtGLkVw42iIhm4tPXLCu5OEb3gjruSfc9eLeXvaAX89UxzJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
X-Rspamd-Queue-Id: 0DE631F6708
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
	TAGGED_FROM(0.00)[bounces-17430-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Action: no action

For structures with comp_mask also absorb the check of comp_mask valid
bits into the helper. This is slightly tricky because ~ might not fully
extend to 64 bits, the helper inserts an explicit type to ensure that ~
covers all bits.

Tested-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Acked-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/uverbs_ioctl.c | 12 ++++++++++++
 include/rdma/uverbs_ioctl.h            | 25 +++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index 81798c0875ed3a..5e5b00c6236fa8 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -898,3 +898,15 @@ int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
 	return 0;
 }
 EXPORT_SYMBOL(_ib_copy_validate_udata_in);
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
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index 505492443c36b5..a73016a977a12d 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -1044,4 +1044,29 @@ uverbs_get_raw_fd(int *to, const struct uverbs_attr_bundle *attrs_bundle,
 	_ib_copy_validate_udata_in(_udata, &(_req), sizeof(_req), \
 				   offsetofend(typeof(_req), _end_member))
 
+int _ib_copy_validate_udata_cm_fail(struct ib_udata *udata, u64 req_cm,
+				    u64 valid_cm);
+
+/**
+ * ib_copy_validate_udata_in_cm - Copy the req structure and check the comp_mask
+ * @_udata: The system calls ib_udata struct
+ * @_req: The name of an on-stack structure that holds the driver data
+ * @_end_member: The member in the struct that is the original end of struct
+ *               from the first kernel to introduce it.
+ * @_valid_cm: A bitmask of bits permitted in the comp_mask_field.
+ *
+ * Check that the udata input request struct is properly formed for this kernel.
+ * Then copy it into req
+ */
+#define ib_copy_validate_udata_in_cm(_udata, _req, _end_member, _valid_cm)    \
+	({                                                                    \
+		typeof((_req).comp_mask) __valid_cm = _valid_cm;              \
+		int ret =                                                     \
+			ib_copy_validate_udata_in(_udata, _req, _end_member); \
+		if (!ret && ((_req).comp_mask & ~__valid_cm))                 \
+			ret = _ib_copy_validate_udata_cm_fail(                \
+				_udata, (_req).comp_mask, __valid_cm);        \
+		ret;                                                          \
+	})
+
 #endif
-- 
2.43.0


