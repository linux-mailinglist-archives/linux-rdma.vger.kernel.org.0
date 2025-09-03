Return-Path: <linux-rdma+bounces-13065-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81439B42449
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 17:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DF067B32C1
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 14:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8C7313534;
	Wed,  3 Sep 2025 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="h1QnKlOv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2071.outbound.protection.outlook.com [40.92.40.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA3F3126C5;
	Wed,  3 Sep 2025 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911664; cv=fail; b=cYH6Y7ExRBC7PhBu8sZrYN5d8ASWIuAgPDNZl/wfdT/X19sDH5HXOn7rWi6GllImBfMhhCBqlDZgqUb53E2eQuz/Vn9pZjf+DSCL1m5pcJanE6Ppr5hpnFemYeNz9K/gS/VJENHAS6eW/PDbtDswIOSlxNROAdV3pqNyyQBUsRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911664; c=relaxed/simple;
	bh=KBynLJ2fDV4zXca5aZkcE3sse+GdWoLbcoViVhHjyxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tN8viawz/S8l8mSdKfoCoB+FOMDZ7VYRxj44ib513o17Ee24d1WoBoA2aDMP65fez04L3ZTlZvfS9QQauIyO2XtbN3/Mc6xAJzDwQBOD9sr9Yq/LjMubUqUTbVje8x4I7Ev6Yulx/fzdude/DJSayDCh8Q9Pk+gc5V07DpL4HyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=h1QnKlOv; arc=fail smtp.client-ip=40.92.40.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZZG2pcGOd0rHFJWr9akjbW1B/xsKBpSM2Nh6UJ3zxbv6X5164qawHLB0EGwkJeSmSP+G2A9M8WPMXos1ANXTSgfma6I1D7JlEFK5XoZqkSWf4E2QwIDjCknoCBduy9QfkQdbp1YbaCvpdSkm3kG/m/+D0LvaAlWyOzpyikx7X/rl5HifZAbVlB4BKYEr1UcQbShWgr16oqcWeGRjpgAsA5TRSZiWm41v9WEaa3s4ERfISATY8R3/+shH+TXmgOjMjtTeFXsvMofKNTyBLZsNOYOZRvFNsjwjFMCyXX6cn0Aa1+GVVOJeW5D2Yg/XBAa+skUCXxDsbO29pBaYu9FHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8TRbHZUNM/c26hmpiL7arxcnJzx4KA2dDkixrCXVT8=;
 b=P2ZaytjX19lXju8MTa9P0KebDYS+Rlce5gVbi583NAlVd1+MKIOkS1wCO0Rq7YiBZ+dTkOt5oaeUJvkfx2+EWL44xyeNEpfq20jXu4P4/v7JEpCUVPmUF4W7rEP4jeoY/oc8psxAQdxrpP+l8Lh98L3/5DPEsUiC/IEIf7JTbSH/5dJaodhTrG2KLILZMN1que+NIIVDARnY7N7yn3HWzDrq6ZraSZe6u2wsTKmMRVGxtmtcQk7vfIQiWWot/Boo4mDTDFEqMwfdhTH3z0VC+QvGQtW6RW5y7qBV7f87JAJ4u8QhOhqzzCGo2vQCRY7yRoUWQBBS35jIx8VtrS/UJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8TRbHZUNM/c26hmpiL7arxcnJzx4KA2dDkixrCXVT8=;
 b=h1QnKlOvMXEo71scyB4VtxfJ0icwyRxOx3bTyGQ3rGWbanzzCcNr8LIJvhiOf9WNaa4pnjqkKwNU//IIXopVQHjzCBVEfyiCRLuBNT1BZg9feeD00toeIBIHfpu51EgiNItjfKfj3ZthF0SRIZKzczKJEQbSBA+NF7oJJxosGcRoKX8nBAU8NPiXAZzJZtdXwbsGMLKdmowQ8v87y/ywweQOEx/fEVigRCAXBpTK5mbm110/INKZO8yt+JDzmNWYzYvZ7bIk4Q5PEnBqSxxP/h5K2mzzZHRkhkLKvZfBvGlHQc5ieIVq/JwmPgxyvNsuSbIkRneSzkO+IGneFUT6xw==
Received: from MN6PR16MB5450.namprd16.prod.outlook.com (2603:10b6:208:476::18)
 by LV8PR16MB6758.namprd16.prod.outlook.com (2603:10b6:408:25a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 15:00:59 +0000
Received: from MN6PR16MB5450.namprd16.prod.outlook.com
 ([fe80::3dfc:2c47:c615:2d68]) by MN6PR16MB5450.namprd16.prod.outlook.com
 ([fe80::3dfc:2c47:c615:2d68%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 15:00:58 +0000
From: Mingrui Cui <mingruic@outlook.com>
To: Saeed Mahameed <saeed@kernel.org>,
	Dragos Tatulea <dtatulea@nvidia.com>
Cc: Mingrui Cui <mingruic@outlook.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5e: Make DEFAULT_FRAG_SIZE relative to page size
Date: Wed,  3 Sep 2025 22:59:29 +0800
Message-ID:
 <MN6PR16MB5450D68882B26331CDDE224FB701A@MN6PR16MB5450.namprd16.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aLc9xknpad29kSnH@x130>
References: <aLc9xknpad29kSnH@x130>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To MN6PR16MB5450.namprd16.prod.outlook.com
 (2603:10b6:208:476::18)
X-Microsoft-Original-Message-ID:
 <20250903145930.582731-1-mingruic@outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR16MB5450:EE_|LV8PR16MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ff2159-62f9-468e-d4ad-08ddeafab08f
X-MS-Exchange-SLBlob-MailProps:
	qdrM8TqeFBtg1x3yx1r6QKZAk6LGeuza7tfCEg8AuPIWE64+Q182GhVYIaaeIzhqQLCbZXsFen2Q1sJ9uxWmr+XRPhCRkVkocTZXuTLoixlgGhbP+dAJOJurHaFER7KMYLzBLXmYipVWjOLKUaXVnBk+WxDcWvL/d6NKzalO6BxpD7wJfVr9bdoCo5O3MifMy6C4eU8coazOgvT3SH4cSnt5CFVUhyJvvjB61aw8YDkL2Re1gvOXLWANK59dMk+ZIIXV9/sGyNjhOVpe7ZkXuKn2tkxH8v3EAVh0oOyGLnRNaOP1YNogw/BKEslWHZQCZJQ6MUTJYz4iIKA4j5lOJdfmI0jqp1Y6lSCPVVs3XG+LESb0PW3y4av3AnYpgPr/e4fVQp0co2FHfygYQu5xD4mqu7lXcHm0hREjk0b5Vw+1WKQiXPvyqvLvhEMVcRZpBIRX4QDVsKeUEZUGv3SX6Fjq2qc7U176II3bjdgu6jmNDZeRKU2HltWF0iqtSfgSOvuN4crjyi1W37tGLV+aPODhZ138qeS9yv9Ph795mIUo9NyHEkvqEOrUOEF37KA/etgFB9iLMdaT8KiSrCu4Pz/gx68Y1mU+vs8JE6S2r4tPGeSU2eW0rwREjTYnHYcarjX41mEQHEEm0YU3TceL67/YzsuzlVDc8mfU4tFrC3nqKHHsyWImVj85tQ5mnfAp+fy2Jbxs1F3DEoZxPtAM3+Q4U3wPptvglNsOFqQSaFWM9z52YM9I3+kbguKXyKjN59edbZHzLHFb7mM9V8qNQ8EcFvdeAJAC
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|19110799012|15080799012|23021999003|8060799015|3412199025|51005399003|40105399003|440099028|3430499032|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pITa3K4Q6EpryjnjKaJYzLzz2/bscGZVRRlAkhyI7A836qW1rplBt2ow5mlT?=
 =?us-ascii?Q?XZreaEvEFBEYFViZdPzscDDBxVt9xV5mW7kCFZEf22IhXmp36GYlVFelSZ20?=
 =?us-ascii?Q?u5RZYDzlx2XAgv0I57JwVQbNiblqOuuyhJV1YZiSR6KDCFl11Ojl3/Dc68vN?=
 =?us-ascii?Q?BJFmgTK909SUTk4gK0/AObTAVqwD2rc718zLcCbQoN1NBBklLplPt0MyspIq?=
 =?us-ascii?Q?hHAfir3msf1eS7NjjH1rXaFIAaFsDjSTIa9iuz2B3khXUTTyki7VAeoxb8vX?=
 =?us-ascii?Q?Et3/b07TTfMeqmNSS5+wfXcqfMLoMDmK3aSzP2RE++C4ioMdEtNbYFXBZm8/?=
 =?us-ascii?Q?94K8NsvNupKmcbiykIwnRmGGQaPvA/daqV/q7q+y9cFmDXho51EZGlbrQ6gU?=
 =?us-ascii?Q?OTSo2i0TWxokQLm2zXmiZKPmIDBF4MS8fNejMExvy6Tryk0Jki0Gi48Myk9s?=
 =?us-ascii?Q?gT3oaNwoeLWo6pFcW05BtxAxUC/CsxBd1wBZPv5Mr5d9Ql83czSR1EHoyu85?=
 =?us-ascii?Q?NQnrdXgNvYBZWxuVIopKImsM1EEyJT4kIccafDRknV+eLOSyGIwNtjOVVUnV?=
 =?us-ascii?Q?N1no2feJGMe82+gy+fPKpPboqFOF4zEDLHjMZfmj1EvkdAn7UcgXjp/NwQ44?=
 =?us-ascii?Q?Nhc0wQ6DvASWP2WQhOf55affTTTwa3180/6wzcB862jD2VSFekn+iXNBk8iB?=
 =?us-ascii?Q?vakdm5ZudCpGY9tUN+KtYgbMkgK8KU9+oWZ+nZwciV1mKeTQfNeoOUe7sI+P?=
 =?us-ascii?Q?U4PJSLTr5M919NIAqYFns/DIYDpFHtTT9Yg6QJFG3woYZaB3mwK7Ld4XvGz2?=
 =?us-ascii?Q?YPXTQokOrhsc36wdVWdEi+I8SlPVc6/vL75wR1Yb14dmmbFHmpypCmIxh05Y?=
 =?us-ascii?Q?IUGB3Xmhx5r0zB7oqEl4BQJe7qmP9rHw2NhbQRtYbKsqSpvOoEnDz5iiJmfk?=
 =?us-ascii?Q?JPU65yhbK+Am6VVrJSK8bxJbZLMiW0+e8+W19NxQp6x8tRD5w+noWvZIZ4IO?=
 =?us-ascii?Q?XisOW4VtFxysQwu59bjzKWXYSVcxnFVcLn4dr/e2SC5B3vgiQhlfqc7ricow?=
 =?us-ascii?Q?ijRf5ot6pdBptpigS0uXhuGO01JjE4QQ1fFwRj3571ub4r3mguKxMcMv8wJT?=
 =?us-ascii?Q?baH6kU0kZJxHioB4suwdzNv5+I17NQeZLS/FzJ+yOwQt0uCEhWuiW4Q5IDvE?=
 =?us-ascii?Q?EX2Pj1nt+Q0VdeG0c2yMeoTMmciq67geMdVlxg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kb03I2fZ1EqZ5185G7pnTxvz7lFVGtrQZTjA81wsETGQjVJf/tq+7gOcU/BH?=
 =?us-ascii?Q?072GJFyEQVnPZqjhF9W7CUgh/2wC2gDmXUd2RIaWqOIXdLc+0YfIEi/oHkvF?=
 =?us-ascii?Q?todc96/RSP2jEsSw8uoy7WBYDg9LRc/VDB86Yi6q4EIxEskyBsaSE6FtRGvO?=
 =?us-ascii?Q?w4ykhWzhcfbYpZ2KdpQG0I7HzH/6cKPxERoWotCh9P5PeDQ+fW6Me+b8kRS4?=
 =?us-ascii?Q?23e36Abu1DTAUkyls40DZBmJRtlcGRc66nXvifCAxaK1cvWziDc1w+ImUAtm?=
 =?us-ascii?Q?LK4VVEHJljw1fSRNZgQYxrY7wzjlvaZxjKdMffBkgl6cmnehhsL9yu/gx8DV?=
 =?us-ascii?Q?HjoZYmVAeIITmCiYW6ozn9oMiRBuN2+1+rRgObFRboafLGZ2zpU+c/Pdegh6?=
 =?us-ascii?Q?Pn0U2Qk3/lnhcvkYEFnBbwzLCcMYaYsRtDuGxhZJ47ntz387b5lRMHwwi0lb?=
 =?us-ascii?Q?FVdQX97wZidWMMciU0//Kf9FC3Jch4o6X0tE5flGcNR0N0nNzfcj3AzhD8es?=
 =?us-ascii?Q?7vBQM8DWzF7GyYMxmNwU01atewQLQis+a3ECh5Nweiod1N+oguQdvSyWcTZk?=
 =?us-ascii?Q?L7+bQxYqt20LV9jPsOi8rNdgjdhW78fG2bjy0r0dLNBmSwXM/WWDQB5KqTub?=
 =?us-ascii?Q?fl2wyVHMKOmbo7ocCWdmFpVjo9SLsRbYKBR62Nd1MO4E97jim5CyvWQewq9x?=
 =?us-ascii?Q?FqZoux5G9mDT1dGWV7tfO5BBPLhLpjx0U4f3wIGTNGjXqomrBUxqfCR0zAEf?=
 =?us-ascii?Q?Mu/8/z9YbKivj+G0MaVXIWY+440tKMr6YIn9/UfeVaXC9GhwQ3R1OpBuJpCR?=
 =?us-ascii?Q?ePolRfwZJhuisV2bplprF6vktcOQhpN5WuVv06JBKgwn+sATOp0Bv6BMr+PW?=
 =?us-ascii?Q?setHH7vF03vZdsNXI4qxVCpOoDZCDR8Vx5nZc++vilKDJw3VP6jjYXE0FU7E?=
 =?us-ascii?Q?41kJ1vzHPXzZETebdCHwqMjCFEoeQvvUs1YAxJ6wXbdkhh2ojPpVD8cylsVJ?=
 =?us-ascii?Q?delS6ncEAvQXk9UCXdFcu+cdI8m+uxknSrERQnRfnUwUzrcJt57/X3OoqwTB?=
 =?us-ascii?Q?tEp+F3NYKLIsoIz/UddKHKNtXwY/snbvp9C8QVzHq4ZiGs2foLD8mLkgqNc9?=
 =?us-ascii?Q?BUXdcbJ+bzKUAG+c+dIQ6NfkA1n3GeimYFmvnjo2MHUsok8xwkzGm2ikwsc8?=
 =?us-ascii?Q?ioQSp0oRjf4D6RJ5Vks1V9FP52rCJi26rkMzsdQyWimgtUuw2N86mjRIHZcA?=
 =?us-ascii?Q?+6ZT0ULHzAm4Kc+JNXQtaqyt+t9U+/QqROrVGHcQcA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ff2159-62f9-468e-d4ad-08ddeafab08f
X-MS-Exchange-CrossTenant-AuthSource: MN6PR16MB5450.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 15:00:58.7456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR16MB6758

> On 02 Sep 21:00, Mingrui Cui wrote:
> >When page size is 4K, DEFAULT_FRAG_SIZE of 2048 ensures that with 3
> >fragments per WQE, odd-indexed WQEs always share the same page with
> >their subsequent WQE. However, this relationship does not hold for page
> >sizes larger than 8K. In this case, wqe_index_mask cannot guarantee that
> >newly allocated WQEs won't share the same page with old WQEs.
> >
> >If the last WQE in a bulk processed by mlx5e_post_rx_wqes() shares a
> >page with its subsequent WQE, allocating a page for that WQE will
> >overwrite mlx5e_frag_page, preventing the original page from being
> >recycled. When the next WQE is processed, the newly allocated page will
> >be immediately recycled.
> >
> >In the next round, if these two WQEs are handled in the same bulk,
> >page_pool_defrag_page() will be called again on the page, causing
> >pp_frag_count to become negative.
> >
> >Fix this by making DEFAULT_FRAG_SIZE always equal to half of the page
> >size.
> >
> >Signed-off-by: Mingrui Cui <mingruic@outlook.com>
> CC:  Dragos Tatulea <dtatulea@nvidia.com>
>
> Dragos is on a mission to improve page_size support in mlx5.
>
> Dragos, please look into this, I am not sure making  DEFAULT_FRAG_SIZE
> dependant on PAGE_SIZE is the correct way to go,
> see mlx5e_build_rq_frags_info()
>
> I believe we don't do page flipping for > 4k pages, but I might be wrong,
> anyway the code also should throw a warn_on: 

From what I saw, the handling for > 4K pages should be no different
from 4K pages.

>
> /* The last fragment of WQE with index 2*N may share the page with the
>   * first fragment of WQE with index 2*N+1 in certain cases. If WQE
>   * 2*N+1
>   * is not completed yet, WQE 2*N must not be allocated, as it's
>   * responsible for allocating a new page.
>   */
> if (frag_size_max == PAGE_SIZE) {
> 	/* No WQE can start in the middle of a page. */
> 	info->wqe_index_mask = 0;
> } else {
> 	/* PAGE_SIZEs starting from 8192 don't use 2K-sized fragments,
> 	 * because there would be more than MLX5E_MAX_RX_FRAGS of
> 	 * them.
> 	 */
> 	WARN_ON(PAGE_SIZE != 2 * DEFAULT_FRAG_SIZE);
> 	/* Odd number of fragments allows to pack the last fragment of
> 	 * the previous WQE and the first fragment of the next WQE
> 	 * into
> 	 * the same page.
> 	 * As long as DEFAULT_FRAG_SIZE is 2048, and
> 	 * MLX5E_MAX_RX_FRAGS
> 	 * is 4, the last fragment can be bigger than the rest only
> 	 * if
> 	 * it's the fourth one, so WQEs consisting of 3 fragments
> 	 * will
> 	 * always share a page.
> 	 * When a page is shared, WQE bulk size is 2, otherwise
> 	 * just 1.
> 	 */
> 	info->wqe_index_mask = info->num_frags % 2;
> }
>
> Looking at the above makes me think that this patch is correct, but a more
> careful look is needed to be taken, a Fixes tag is also required and target
> 'net' branch.
>
> Thanks,
> Saeed.

Okay, I will prepare and send a v2 patch next. I think WARN_ON() should
also be removed and surrounding comments updated accordingly. Thanks.

>
> >---
> > drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> >index 3cca06a74cf9..d96a3cbea23c 100644
> >--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> >+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> >@@ -666,7 +666,7 @@ static void mlx5e_rx_compute_wqe_bulk_params(struct mlx5e_params *params,
> > 	info->refill_unit = DIV_ROUND_UP(info->wqe_bulk, split_factor);
> > }
> >
> >-#define DEFAULT_FRAG_SIZE (2048)
> >+#define DEFAULT_FRAG_SIZE (PAGE_SIZE / 2)
> >
> > static int mlx5e_build_rq_frags_info(struct mlx5_core_dev *mdev,
> > 				     struct mlx5e_params *params,
> >-- 
> >2.43.0
> >
> >


