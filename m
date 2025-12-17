Return-Path: <linux-rdma+bounces-15041-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F69CC5B7F
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 02:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D846F3016347
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 01:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10618253359;
	Wed, 17 Dec 2025 01:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rrvD2wGI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010058.outbound.protection.outlook.com [52.101.193.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38452257423;
	Wed, 17 Dec 2025 01:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765935864; cv=fail; b=iu15rVnV7QTs2GNFfAUXIAwtR64DmR1EEfV6lQnIX/P3uiUkdWwZEtr/5duXx8+XO8J67ZI+M8bWujEYw6a+KY9FMizcEShiQSjHwtnTdEUemvV9lcj6rBrHIq1vNSySn1EAzadTgxmlpGahA3eBykvweR+34qae+zIlA40tpbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765935864; c=relaxed/simple;
	bh=WDRFHWCVB5EiTt8vRgWzdrdh49jHdECES0z8m6Eb8wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fHmIS2bWLuRFAqY8zEovhgDZF5TzFEygrGu+4ykQVw21d/Y+m8RJP3vw/YK2pujigyazYNEnm3jvNnD3NuJLDtyTJ8xh5NWoctrZRYEV1DH+Nm9Wryu95bIrKmfClCQih1Y2baRlWYi6ZLEkA27214LwpXocIUCsNCp1jk39ONY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rrvD2wGI; arc=fail smtp.client-ip=52.101.193.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERUe9xH4jmVsQAVPs4Yl6oJ3yckAsGlIkKh68veDfAKxvf7/Sf6FxtYz5cXF6qhbIHQDcqCXR//R6SHy8BPfWEwB+5aD3DnrFNbKZz0LiMrXlPe3WAVamU8ARxcdgckToFmJ5rgoU4FWrwUV6JWDtKCz6cappWmTDnMSBjbTUPXUIDFneyGhG81ATgLJRpuUFYSgyKwiRMH67fMM6pJmd80RBPikGjfkVCgv7OUDKYYGAIGoPps3Cy43FqxrnhBygWDqLWz2iJ80N7Rv3qoWEYV42v2oZY5PQCOBLfWw7wvhVyEWSqeXRzhtQ3u3b3liR/dCNeGh0V86u7c0ROYMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZL7Eyag0XjeNtWGgTgLgwg/4ckpGWXqsLsVHvp6jSkM=;
 b=XM4pl9BpE6z5mGRCELktpGezCJJat6RLxp1OUoz4xyc61t/QFAPp5CUowEAgViz5GyrQnPmlKOVVKz3YE4iXpnTqyhlw0OUIwqZi5Bzw8upCnhZ0zhvOWDDgT9n0zwP181+J/yEIbRp31ocJsNSvOjUZKYDEXqxWP1a/adbJCjYllUQUEnPqEyyn3tsvYGRDmYe/2cWq+sVLDsTnRq95ZGmiyNmcFq2xt+oyWKR9WIhrzrTFW0kuiaYlj2+lFNjBqYUO6nBK5HANEof8h8ys0qi/mn3cvZi3g4vWO9At69cFbnY1sDLUUasarumTqiBDN7u3kjrey7kZNUBgrUmUag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZL7Eyag0XjeNtWGgTgLgwg/4ckpGWXqsLsVHvp6jSkM=;
 b=rrvD2wGIY6WW3/0uyTgZM6UplfM10+T04p0xVHi5WPN4j36PYwhnwApLQ+8tznqda9IkVzSKllhnw/er2LutV9frwVRkhx7qS9ol+LV1GEU15nJcEgvbc2OktfEdZh2aFInDIsFbXLtS9O+GThDHjtXFEsZyo5CPAE9CXbnomqS2n7vKYDjQzP/eBV00tpvJyr6uxQ5IuqZuxBw4zuOrkBxvJaNALfzYksDi7imzqhdZvgXemTjyjAWcnmnst/mMyjs7tEtsPOUHG8ZD5d1EIxWLeUEXzaIaCwXOzMGkfuFgkgeDWP851jjTlxCfJ53HRyBj0W3BiSVdb5hGJkh73Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 01:44:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 01:44:19 +0000
Date: Tue, 16 Dec 2025 21:44:18 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc: Doug Ledford <dledford@redhat.com>, Mark Bloch <markb@mellanox.com>,
	patches@lists.linux.dev, stable@vger.kernel.org,
	syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Subject: Re: [PATCH] RDMA/core: Check for the presence of LS_NLA_TYPE_DGID
 correctly
Message-ID: <20251217014418.GA148079@nvidia.com>
References: <0-v1-3fbaef094271+2cf-rdma_op_ip_rslv_syz_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-3fbaef094271+2cf-rdma_op_ip_rslv_syz_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR18CA0007.namprd18.prod.outlook.com
 (2603:10b6:208:23c::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 235cb71f-0e20-4035-d3bc-08de3d0dcbd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lv3Cm/EDuCwIwIMvDekUO1qxHNFQSHL8A9SjbYRJJftxd7JFQeyZrco9K1SY?=
 =?us-ascii?Q?2/MEmub1ZLiW8VlVIUahVh2kwFKalBPGXqi6uMhTrQoODsoHCySCrQ1kF345?=
 =?us-ascii?Q?RPAMm+dEMdemJrJYIyB1bNGtiwCQlhv4pUOkn7cp0wHOgfbPMG1OQvUxISsa?=
 =?us-ascii?Q?R2ia5hzfVU59RnUsTdxyatUhLYEOJqepSbyea4zFe2bKLskw4gt5PnwVW5VM?=
 =?us-ascii?Q?Al8DS4sOvn26Nr9UTH4SQSoLrQ3M00ggmgC59V0pqpVtJ9ysW2lm0QUKbnkp?=
 =?us-ascii?Q?I6xhytYWaIdHqvUb6rfkekgDQ1tinS8KMMiSBu8xk7NVqGZGmOPCbhd9GgVi?=
 =?us-ascii?Q?caHs0PSiULYqvL/7SPxKtZJCkWsyP9PKUWkc46e/p9F58um2Tiy1LjW17ML8?=
 =?us-ascii?Q?xnlzjGwx1Y/T2yErELSJW5l9+pz/vQa/MsiK0C2goWWpLLTCw5qU7UinAoVl?=
 =?us-ascii?Q?J+0JZ/dbdyVyAwej+f19axKnvmTWcbw27hV8T8WtobMSIXN+ojeuVL1ANGYj?=
 =?us-ascii?Q?5tUfLrr5vxnXmYpYCuUTRcU/8nmoe+KwTeK7TBXfvxq9esKPOFc7XxcYIes+?=
 =?us-ascii?Q?aPde8k1abW/Nx3aKn8SL0o1l7S5smj3Pk0++Y+ACPlTTnTliWPirA4Cu71Mh?=
 =?us-ascii?Q?6WwIhVaAA7eLjoyk/hHMn4jfBlKosXtHtPRkJqtRRZRwfeu6bpW2h5CccBZP?=
 =?us-ascii?Q?Y8gHXaRNZ7qJUT6Nb/RU9E2PwrQxMG1TMO8pQkG0lgrC6sFw6ngnbG8lzIXD?=
 =?us-ascii?Q?G1q3rvKpYAbOu0/P2sEdRzdxMsiyOCUkxzUf3GwvT0AoKX1GzUoTtUCY5ES6?=
 =?us-ascii?Q?6GlCKY4bflC2K3qqcLvgr8tUPc0/HL86mvGUi2kvL2GrOs2V8bGTonVCJhhF?=
 =?us-ascii?Q?sMwwpk8yhn+1Z8FVXbjgmvYxXREqBSuM/O/tLZJvtDo4+TovH6PHeaJp0kK1?=
 =?us-ascii?Q?rMXX61z8c8BHYTeUQQQFxzw77ew7iPDjvBolUnKfE09tIhS/1aPVAyGXujhz?=
 =?us-ascii?Q?PeqEhJ8LibQLaOQcak044q+kInzo/ypxORPUAfhiZbo35CY1ECEpY4wUPqDa?=
 =?us-ascii?Q?wWsXdA0gHnxu839sXe5K4fDlC+Q/vkWcPF6ZWIpoch5ePmfHeqhgrHwBMHYx?=
 =?us-ascii?Q?vfD5yDTvuyADwLw5oow0f/MtuytB6THIYGvepF+kUq2ayziWK6npSAeDQBgH?=
 =?us-ascii?Q?bR95JrXIb7kai8h7An5Aur9/eYf9NLE4c3m3m1eP3modrmLXRIxbMfMlyyrS?=
 =?us-ascii?Q?TRrC+ktc8zlUL6l3arR57CdfBej2/vMULRBy7jTKEiK7x2zGnbZhE03M7zKE?=
 =?us-ascii?Q?8gtlZ3dm3KhM/HdWYfTi8pDc8jGQwvA9QsB3/lY3G/TsQ3jM71E5T3u54sxy?=
 =?us-ascii?Q?asveKidbbQ7CdzHqMh2b1vGbGsb4zsoniBv7XXUD7p9RTCW+yCk9FdqrT38T?=
 =?us-ascii?Q?UEYhDuRbg3YjqsNlhCZC4/z4fEgTO7O1oLghhbWaUE9cSC77pDRJbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XITsrceL4420SmU9qmuAqjU2n9083DnyS3vC+D0gG4nj20GriQBYr2ciWePg?=
 =?us-ascii?Q?nMAYcdFoyVJ1qPCLQ1v4nmXZHhvlqK+kHqmmWsuWW82SH6wFmiQbal58E4BY?=
 =?us-ascii?Q?+3W2gWarT/kprH66+8LxPYQdxWjazevZ8jWDC3k95RDWi9T2GMs0+McMNLyp?=
 =?us-ascii?Q?oHHv/23vob0pufQbVCuqzvwB8J/4PqrNf+WM2r5PdxC3rmRBzCYSIo/umy/M?=
 =?us-ascii?Q?ScD9c2P2gUVra8UfQVyN9mxzqVt1OXtO33Q6/QFz87tTjPQGwub7YGIXu9sQ?=
 =?us-ascii?Q?LM7XTK3HuacDlcOfINuSi1RTnZ72/PHqf/uVPWuqjDKlPMJN9UI3TnvejvnU?=
 =?us-ascii?Q?MVAqoh4W/y6rIXSCxln0ezw6clT14vpxaOpvqiA5hQOTePZKI/wxvE/1ObVG?=
 =?us-ascii?Q?X16VeXSV9b7W02I9RO2GxPXxD23zE/A3urGcybzaKapVKKZYyv/T6TjvSQNF?=
 =?us-ascii?Q?LCDSFSK3bzMEder1HW+phitw26TXEnjDvesJJ2R8Pl5vulWN9qxmyLIHAaEp?=
 =?us-ascii?Q?1cjpSjbLBNG48s5kFxNuBNq3zCNqCSt/oR6t/Jd9o5MoH15UJPuhWbcrds9D?=
 =?us-ascii?Q?bIWFYEYqqUFkLMVl3MtEuWeJcZ3U2LHBIDr5BaD52RJiUL5WsBagBD9IUnwM?=
 =?us-ascii?Q?lBY9Qw/6sQjxbe1uJSUycAuIA5y8Ss6kukZG08/bRvZDOWDK7HwdFkf8/Ho6?=
 =?us-ascii?Q?TMLJ1bo4RKOXi92HhZTja7P++7JpNEjvI+K3wEWCcyiqiC/L/afeEY8727ty?=
 =?us-ascii?Q?XpjtUVvuj+pyF+ICFaDbFom38JklgIor8QSUtnc4GL3K89eDwLk4biXKHizq?=
 =?us-ascii?Q?i/aFlSO1t7d8PzcEsicKAbUfwVuCT9VpjOxwqTYLXQMiXXrXuVGxj5UY6LxL?=
 =?us-ascii?Q?Eb0qgoKbZuLtsEfT5azkAFfW3kDeozBgy+NQRJa4IxgRwMlBC7JceJxrrY9P?=
 =?us-ascii?Q?qTFFSiWBSH7oJGcJtYgpbmCzrZkRGEFF8uHpyKRIomXmfT8qylFLZ1LZN8NY?=
 =?us-ascii?Q?KuijE/n+xay+iDiyamqRGZ3b0gyTY7w0+FSeo2dqRK8Tzq1AWNr7UtyBn9/s?=
 =?us-ascii?Q?Moil2d9LPAG8UesXWq2fwauJoqaBK/7CMzk/YA6Ergp4HQ5ug8f4fW1dBaNf?=
 =?us-ascii?Q?/x1UqJyq86xDi3v1p1/yG/Iso22nqFcjVtJOLNIvP1dhnZIFgRwmhbbClV9d?=
 =?us-ascii?Q?/gpAr2UbtuaG6Cl9Sp/h8FG+rNXGdXl0IXS1P4AtJNCHTLU+aq58N4WLKU50?=
 =?us-ascii?Q?hP1eEQ2kL69S/xTywhYtPzpKnJA/cVrqSBeDcIUoENe3UWiXCmclusqaZizU?=
 =?us-ascii?Q?h3evG0l7zUVOpZa5xuNJdb8CZVD9S2NJtq2WaYQ9Uqwf8hmtoVe7UtZOsB7s?=
 =?us-ascii?Q?43LetnjrbL5J5Xm1J2fdzmPOjUY8/n4qKKLh0VVWlteglJC/KdN+ZxnSNXln?=
 =?us-ascii?Q?RDj+WHGrIiXpbk7KiiXIDT4AEJlUehZxkLSewcxGChVaWuVnGJNVDe4oJjvV?=
 =?us-ascii?Q?nGJtmBFzQypaoB2LYlVxa4/E/61t9+ODyTgsn2S7U+ZGKWB6lzuYEYtbJJLm?=
 =?us-ascii?Q?EP49U+DN9Y8BB1Famxs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 235cb71f-0e20-4035-d3bc-08de3d0dcbd0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 01:44:19.9163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZS3gripPJBI4WdAuIzO/LS2WHEUgrZwoepFfExqLfUxZO11Bo4qLUN3/nBJEYzy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710

On Fri, Nov 28, 2025 at 01:37:28PM -0400, Jason Gunthorpe wrote:
> The netlink response for RDMA_NL_LS_OP_IP_RESOLVE should always have a
> LS_NLA_TYPE_DGID attribute, it is invalid if it does not.
> 
> Use the nl parsing logic properly and call nla_parse_deprecated() to fill
> the nlattrs array and then directly index that array to get the data for
> the DGID. Just fail if it is NULL.
> 
> Remove the for loop searching for the nla, and squash the validation and
> parsing into one function.
> 
> Fixes an uninitialized read from the stack triggered by userspace if it
> does not provide the DGID to a kernel initiated RDMA_NL_LS_OP_IP_RESOLVE
> query.
> 
>     BUG: KMSAN: uninit-value in hex_byte_pack include/linux/hex.h:13 [inline]
>     BUG: KMSAN: uninit-value in ip6_string+0xef4/0x13a0 lib/vsprintf.c:1490
>      hex_byte_pack include/linux/hex.h:13 [inline]
>      ip6_string+0xef4/0x13a0 lib/vsprintf.c:1490
>      ip6_addr_string+0x18a/0x3e0 lib/vsprintf.c:1509
>      ip_addr_string+0x245/0xee0 lib/vsprintf.c:1633
>      pointer+0xc09/0x1bd0 lib/vsprintf.c:2542
>      vsnprintf+0xf8a/0x1bd0 lib/vsprintf.c:2930
>      vprintk_store+0x3ae/0x1530 kernel/printk/printk.c:2279
>      vprintk_emit+0x307/0xcd0 kernel/printk/printk.c:2426
>      vprintk_default+0x3f/0x50 kernel/printk/printk.c:2465
>      vprintk+0x36/0x50 kernel/printk/printk_safe.c:82
>      _printk+0x17e/0x1b0 kernel/printk/printk.c:2475
>      ib_nl_process_good_ip_rsep drivers/infiniband/core/addr.c:128 [inline]
>      ib_nl_handle_ip_res_resp+0x963/0x9d0 drivers/infiniband/core/addr.c:141
>      rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
>      rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>      rdma_nl_rcv+0xefa/0x11c0 drivers/infiniband/core/netlink.c:259
>      netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>      netlink_unicast+0xf04/0x12b0 net/netlink/af_netlink.c:1346
>      netlink_sendmsg+0x10b3/0x1250 net/netlink/af_netlink.c:1896
>      sock_sendmsg_nosec net/socket.c:714 [inline]
>      __sock_sendmsg+0x333/0x3d0 net/socket.c:729
>      ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2617
>      ___sys_sendmsg+0x271/0x3b0 net/socket.c:2671
>      __sys_sendmsg+0x1aa/0x300 net/socket.c:2703
>      __compat_sys_sendmsg net/compat.c:346 [inline]
>      __do_compat_sys_sendmsg net/compat.c:353 [inline]
>      __se_compat_sys_sendmsg net/compat.c:350 [inline]
>      __ia32_compat_sys_sendmsg+0xa4/0x100 net/compat.c:350
>      ia32_sys_call+0x3f6c/0x4310 arch/x86/include/generated/asm/syscalls_32.h:371
>      do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
>      __do_fast_syscall_32+0xb0/0x150 arch/x86/entry/syscall_32.c:306
>      do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:331
>      do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:3
> 
> Cc: stable@vger.kernel.org
> Fixes: ae43f8286730 ("IB/core: Add IP to GID netlink offload")
> Reported-by: syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/68dc3dac.a00a0220.102ee.004f.GAE@google.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/addr.c | 33 ++++++++++-----------------------
>  1 file changed, 10 insertions(+), 23 deletions(-)

Applied to for-rc

Jason

