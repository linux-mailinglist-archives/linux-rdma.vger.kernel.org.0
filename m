Return-Path: <linux-rdma+bounces-22042-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /6pxBrOpKGp8HgMAu9opvQ
	(envelope-from <linux-rdma+bounces-22042-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:02:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD36664DFC
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:02:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=l8szB9I3;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22042-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22042-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECC5D3018D4B
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 00:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722E811CAF;
	Wed, 10 Jun 2026 00:02:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096688C1F
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 00:02:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781049774; cv=fail; b=eDg+hZMfkKvm8yvDpPiAOG76o+QdSSf+nK3JGT6rYCrQs7PJgI6m3iIp4YTLOD5I1FQWbZ2ecXOvzvmjsj7Z7EV96mluqVig9p7GjCJaHySmEdmrK5rxV2F1K3HUI8nhmqb7znHbOYK4JhwRwawpN0uYpVzffq/UOMvm/4hdaYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781049774; c=relaxed/simple;
	bh=5wB75GZAFxJ4xwOnunww9dcblxyjM8EIDNB8pvqML98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U7ktDQbLFnpWeN3TY3rU+ulE1QHeiNw3wTU9i3TB03suYAGVNSpHoF69DpbLnoWdJgsFvepXj+XEkIJutOeXLCiDTh6LbAz/FgxcTjN8miEIGxMqxyMVRghTNM0TgHQGERH8lPI8GzU51h0ZLSg2WHU9XsAh6niLAwnIBgdAKuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l8szB9I3; arc=fail smtp.client-ip=52.101.201.67
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khG7jcIxLpIb5eR3HZHT0hnYJmhcXMKo9/4EdTnD/A/mxMre02ImSnhcEbPpsKsAquU6QYnoCa7kna3Utcc5g+t9+0yOIsfntiFVZ++QJ+FYq24nn7udeikatVSfjMd4RQJPlhZ5gSfJm0ELcZyT/vvhLyNuhKWdC9ZQmtM6oArnmdZ4uBvJDlgkBICWsnSqW0tbJIUbJoni39KNALlmPiyxJKU36s4n+UrBG5OY8xYAKg5IuWcuf0yGK7isKWE6gHlEp5gBdyWiSWagFx37BPa9SOikqpR07d7JC7RjihKwMmNxyQ9rRypNl83JrhSurzzVesGL/oaLs4dInkAUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBk/dzgJuqU46SPzqMeBNf+3P3DBEozFmR/Es+xCh6k=;
 b=sTGAHPGJYXhwpCWjBy91ASS4qW1LfcnbpuOMpuJ5ps+gXKpHdreV7nIqlT471AEPqkSm9s59yvRHy9VdzV5He2WuF5SXRmj8ib7rFx4x9Cz2z6NR8OimRHEj3PgZCyBggre73xsgd4DxycH1olJfVI0hFOT1dVh9s/Hby/5jQcf7JPGa6NRFWunC1he8jhamBCp8Z8IYqHfQDd759bad8l8ja3+W3mzBsslLI9EAEH5bRXPSfkorX04pzIcFRJeDKGj/y3bulGOUHNL0ZIuamIcqjUSgmrmQcgiVgvO5sfPnvV1sWjPt9hkAYbk710O0OLGSk34WK3rI6CTreSYO6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBk/dzgJuqU46SPzqMeBNf+3P3DBEozFmR/Es+xCh6k=;
 b=l8szB9I3K4iKAW/Gd4z81fSzw38dZitg3n0qgazJor6yov3QeOMNkoalhICEcGkFHq6dTxW88F1G9YXyqm16BWG7bloFhCxflR4BCkjgZuOTX5gG+8sfWqNAekMFvZl4YAm+UPff12ZENFYgriKb101ryC36s2+gec4biah2PvP+ZrEQEnifeg1BLsjQPO0RSXXHBgHySg7sQV5t+mxhxJy6Xz1ohkOL/91+Eb+5mlrU8hanzzItnPYRrPXIjOogSw2n7kPT/I7oyt86GqJtBmaA/F0+fCWB+Q3FU5CWEzNyBlh7rGy4tUEr9U6xmUsZJuYTIA+DG9/zUriXvtjPQw==
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by DS2PR12MB9663.namprd12.prod.outlook.com (2603:10b6:8:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 00:02:49 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 00:02:49 +0000
From: Michael Gur <michaelgur@nvidia.com>
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Edward Srouji <edwards@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 2/9] RDMA/mlx5: Fix TPH extraction in FRMR pool key
Date: Wed, 10 Jun 2026 03:01:38 +0300
Message-ID: <20260610000145.820592-3-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260610000145.820592-1-michaelgur@nvidia.com>
References: <20260610000145.820592-1-michaelgur@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::7)
 To LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|DS2PR12MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5cec9a-aa01-4390-d1fb-08dec6839c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	+z2Yc0c+7HJS1hL/1eaZ7hHGQG1NQnhXf28CLLQGtnQDi0OgM3XdqCtlDfyvjHvTIPPq5TlrDTV9PkZVJVFA8xHkOK+bTZSTgHf7YtQjr72pwcmnT1JNZaw9TPy5TaQF0ZXIPZTGjkm6p1moUcgHEnlp+hn7T2p8VmWnGEZcCOJMcWWINM0xCyE0ww1qS/msUt80l2uTWL4dNGqsQkMz1fdjJ3Hk/6EGQwN7h2w5pqICpZ2/JOzaAgjOOnqIl6Ijcq2Kus5IQysBpsaEXztd6CCyVkEnu/UQs0yHA1aTnNsqZIckNfVLicYKXCGUQfZuzzNximpXbeWNgMds0kQFepbksYMP3Yq/yLmA5bx+UUq3bWQ+a9qf+PbkLXCz0dQgbwMey4+0zY0/U77vwYXJa3GWIg0mrntRRkQ6qzfP/FPo1WbVjJQk5BPWVqwuWwBhhdws5loKpFnzBiyk9e95ORrwEX/MXiLxHK7c5aTfLK5CjJilfHsk5NBMGp6kSwspNeO9ZpE4poEhbiYQOaWlX1tg/g9e9AB8xSTKkbu9jbve0LAca4ZCZk/uz5Ch92qM1qvBSxzcXSd46BPeU41niV8nscKylB55icQ69ZqwCfmyVy2tZGm5oFi8ZkAuF0wZvw4tdypQXxXhagXMQ0Ftfh6DngJDSNZ8fc+Ek2i4Ps81kiXOBGxRlaYkyQucWrLo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hULlf/6qjQR8kOxwJFXXcUH6wL8Fg4PJA5HE8WIHBf3Qe6UQzh/a8gAAsakt?=
 =?us-ascii?Q?6eqyGoYhFpNYjkh2gyMxX6MVCjX/JhwJHqmAY+QthjXHgOFcsvNvRmiOjDDs?=
 =?us-ascii?Q?8/sYFJD7kfO3HmslURH0gYPE/bQcnYe8CAaASg+bhQWzg0NlXTn6J+gyIfkR?=
 =?us-ascii?Q?8V+NJ0Phfvvsok5w3btI/lfpxIvIxhi+rt3cgfN8cYLsQ3zaKjW5Fg5temhE?=
 =?us-ascii?Q?dgpMex6yPNfX6/FtDWk3ZfySM1VbyUzjOi5hwOsmpxmDIfaAxhToMCVtOMsY?=
 =?us-ascii?Q?81hCTAqhMDjN/llEpWfsmPRBTmsA6LdbjTylmNekcwuAYmPbm0oYiY3KDn3r?=
 =?us-ascii?Q?eSM/KTWRedcvRxaJ/PWOw6hSwKotPKJ67/Sdjh/bFxm2+IHuxdWvXGl6tNfT?=
 =?us-ascii?Q?3eh8LlnygtYowk+L4nBFseWz1E6igtxanGf+Luq5IIIgsH+MuvpWCb0NhB+D?=
 =?us-ascii?Q?lmUAUod6D2oE6e2TDyooU66iV8YSTD062eKhuISh5QcOvZUQZ2pafavPgVe/?=
 =?us-ascii?Q?gS6nqYeEMme08NmstyFfdHTxkn774tB2coJRrhmvMdngQSBRlF3HFliZdukS?=
 =?us-ascii?Q?WJaQQOM/d01K9o9uNs0iikthhmTRETTEtjTwGuIBTqSsGWuksgIjVWQwhDhE?=
 =?us-ascii?Q?EcwZTn1CjTru5pNYM03Z9Wtlcg3dZx7ijeR0l3NHfClPvzsfCAwKt6VFVDA3?=
 =?us-ascii?Q?nda+FBbs7Wpy3MztPLHCMLdDRYsvVNXHn4MYnCZ0XfOvZhhDXDxp80wlZS+Q?=
 =?us-ascii?Q?si6EOpNl51xVaQlSLoewDZPVwd+3839uMS4gEu0uILual17IYYHz8DZr9fAs?=
 =?us-ascii?Q?Rxb23/uRLG1XWz3gBaFm3hOpvVPTUtTBWBzDp1L9S4Is7VOZsf+s3IzL4hLy?=
 =?us-ascii?Q?ZRhr8GvjVLUqvKkhdqtf4bhIZ0woOX8aV0yTbKa9/AwWmJCy+b0wV2dkIN8K?=
 =?us-ascii?Q?3xh5ospbnKuaB6bt/WS96XWOTPO960JLSchsIqb3vvVC7DrDXyi9WoLe9Bz1?=
 =?us-ascii?Q?BN8JFbNoiywCc/OeFMsD5XtaW/q4IKBg/QZT9mlb3qY6B7o0TkBWW9VVsxdd?=
 =?us-ascii?Q?TFvS8VQ5XOPfShvOqZAABeEAROttBj25V+zS0n6527dQjMdnkXqvtoH9+AJS?=
 =?us-ascii?Q?xn6F54Q16r/o24xxz5r0RG78qshn2LvgBVduboI8xZS7mVIZT8JXGevh1Cb1?=
 =?us-ascii?Q?NjaGeW+P2cgjADrGX2SrfG7kpv/xTVH311BzbwfXxSH5FwUcuQYfK/LnZIOe?=
 =?us-ascii?Q?1hb6oyD5IbI0d6gxf8qddVqj6i6vYA7rMSkK87Y27V6daszVkMbSQAKcclyg?=
 =?us-ascii?Q?eVDEDfqUNyTiFAX3gaD3kD9qEU40m1lJji4OZZi9964ymDbifv+1Kto45oo2?=
 =?us-ascii?Q?OILgxUbT2liDLzt8z7QPlFNe7xYv4ESdGXdN029ShTWRGHcqOs+QOgjYChrk?=
 =?us-ascii?Q?hDtgU2xW8c6SdQuEq7Rn0bZrgBgAS1+yyZaEmkzj594frsyjF3RI7JokJcvU?=
 =?us-ascii?Q?/w9lWTpu1EUlRBOdhD5e59dO10tPpH2nqMoUkLcguOLPL7DIX6n4/QPJQukI?=
 =?us-ascii?Q?1TKtHsrO/Rg89XXYRqvWo/HDZnJfz1q6HpTSPO4N5bjfwun+T3zuuWnPNK8X?=
 =?us-ascii?Q?6WoBmRO3+ZAod1suPvyZ+b7P4Lqa5tTm5AgPgNzC1bPl6PmZj503WW/ib8fp?=
 =?us-ascii?Q?sTk8MBGxyb8oshHS1XsULxqNIBXz9ecAAm35AGz4kScjFCuSfbkRU4p8HO13?=
 =?us-ascii?Q?gWk9wV43gA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5cec9a-aa01-4390-d1fb-08dec6839c14
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 00:02:49.5453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDgBejNqJWvO4R/bh1CRqUWJrf28Bpj4CNUo3q9kK0LEl7VDbQmN3xVttQ6A6FHC4ivipBDp+NWxy9USl4tqZA==
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
	TAGGED_FROM(0.00)[bounces-22042-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: ACD36664DFC

From: Michael Guralnik <michaelgur@nvidia.com>

Fix reading the PH value from the FRMR pool key by shifting the pool key
to the relevant bits.

Fixes: 36680ef7bceb ("RDMA/mlx5: Switch from MR cache to FRMR pools")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index c174e27e2e65..c0b3a8066974 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -31,6 +31,7 @@
  * SOFTWARE.
  */
 
+#include <linux/bitfield.h>
 #include <linux/kref.h>
 #include <linux/random.h>
 #include <linux/debugfs.h>
@@ -163,9 +164,8 @@ static int get_unchangeable_access_flags(struct mlx5_ib_dev *dev,
 #define MLX5_FRMR_POOLS_KEY_VENDOR_KEY_SUPPORTED \
 	MLX5_FRMR_POOLS_KEY_ACCESS_MODE_KSM_MASK
 
-#define MLX5_FRMR_POOLS_KERNEL_KEY_PH_SHIFT 16
-#define MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK 0xFF0000
-#define MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK 0xFFFF
+#define MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK GENMASK_ULL(23, 16)
+#define MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK GENMASK_ULL(15, 0)
 
 static struct mlx5_ib_mr *
 _mlx5_frmr_pool_alloc(struct mlx5_ib_dev *dev, struct ib_umem *umem,
@@ -194,7 +194,8 @@ _mlx5_frmr_pool_alloc(struct mlx5_ib_dev *dev, struct ib_umem *umem,
 		ph ^= MLX5_IB_NO_PH;
 
 	mr->ibmr.frmr.key.kernel_vendor_key =
-		st_index | (ph << MLX5_FRMR_POOLS_KERNEL_KEY_PH_SHIFT);
+		FIELD_PREP(MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK, st_index) |
+		FIELD_PREP(MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK, ph);
 	err = ib_frmr_pool_pop(&dev->ib_dev, &mr->ibmr);
 	if (err) {
 		kfree(mr);
@@ -271,9 +272,10 @@ static int mlx5r_create_mkeys(struct ib_device *device, struct ib_frmr_key *key,
 		 get_mkc_octo_size(access_mode, key->num_dma_blocks));
 	MLX5_SET(mkc, mkc, log_page_size, PAGE_SHIFT);
 
-	st_index = key->kernel_vendor_key &
-		   MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK;
-	ph = key->kernel_vendor_key & MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK;
+	st_index = FIELD_GET(MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK,
+			     key->kernel_vendor_key);
+	ph = FIELD_GET(MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK,
+		       key->kernel_vendor_key);
 	if (ph) {
 		/* Normalize ph: swap MLX5_IB_NO_PH for 0 */
 		if (ph == MLX5_IB_NO_PH)
-- 
2.52.0


