Return-Path: <linux-rdma+bounces-13400-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 479FFB591A7
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 11:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5C02A6250
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 09:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B340A29BD94;
	Tue, 16 Sep 2025 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="X0CVTVwc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2059.outbound.protection.outlook.com [40.92.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E7228CF42;
	Tue, 16 Sep 2025 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013354; cv=fail; b=fKveRYFYXYVf0geUAlolxpYFjcJ+J10fcroY0/DRUN+K/JzMSnW3U4pBHeRUCYJZW4GnPtGtxjK+geODfL1tEOgWx43aXI+mNfbCEyNXmtPtKhxA+fGu9QqxSYraUL+owf6d0Q91eGA57/tIym+8s2K0wpWv9xKeKqD0+tPwKZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013354; c=relaxed/simple;
	bh=akefh9s5IzR6xuJ0UHyBOcEL8/haPSPMjwQg4fXG5sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nu0jErrdaryEBUlRyRX1NjWJ4eYqRl3Za/vd7sB/4NBbDIMO0hcTKq7ykDoaJxeiq3hxPC8iQTEtAdZGUQpQ6OSWV+P9dWanSFJYYU8z4yvIfWng3ydpdyrDo+ZATsA+Zl0OOJacJF/BPzu/yuTz5zQeerUVq112Qvkf70BR0ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=X0CVTVwc; arc=fail smtp.client-ip=40.92.20.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egIH0PfJLHXXqagW5p/grtgR2EejmKg47g8773Zhugbv0X4Bg8k1T+3B6YrO+0s8+MsRpPkxISDCvg3psRTiNKOMkWHZ9WwqjtGeittUcJ4b4mOLHpmxIMSuL1bHeQt3Co2RzLIcEDIiMp7vh2x+0RUjsqhb3OzuWTIHvt9erpmJEUZ5Hw1T2RWcfJdyXD8jSxF620xmMjqgQum3qX7bHQOQxOkBLuR5Oc76H6/X+AefKhyC969TXNDnNBJj64MvqZqfia9ojj+RdOsQwUhP2qrcNqUYpNy3c6ANjJcc5HFTTiL8G7Tbypt6VTG7JUnbO0pkaQ/caUE4PiFAL0+P0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7+ef7kvdw5eaZ2znnmtj+6Gjrnmxvb49SMis6Al1A8=;
 b=x8Ba3iNHjC8kvYUp9r4YW5EwWPDhIpzJVzZPMn3ox0ljB+rRXaPetYyVyztr2XSydETkdvJGYdaNmJyi0Pa/tdalchiau8O7O/2ZdFuv67MPdC9flidvVmSoh2irv9F7NJS+okvebJkbUfBoQUXempVMc6nKfGyZar20wOuilQQ/jE1dqKAouwlBGpZ9Us3Y/tD6YxFHdbjToNrgBKJ7u2rTMBT84p3/C+OYeUN4zo/ppGA5os4ghJFWBE20NNvsZoKuiwgcsWHTBktVAptOOiP1Hts1Sty9Z1sYom84JsHbZmyF0jm0KzDrOgVT/zEx+C4kL4lOTWMCbe4Zom6CVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7+ef7kvdw5eaZ2znnmtj+6Gjrnmxvb49SMis6Al1A8=;
 b=X0CVTVwcuEHQWZ0gUPmsAUpkPLC5uYnksSXYmEYczhHTnW4L/yBAMRQJ9Qq85TWn+D/PCmYkd/DBf6Z83heA+LubhEm33hLRh/vyM+tj1MgWcOzk8plVSCYpXW1CDZqoBxx6xiDB+1y1IImVuY9WGzU16zNGhNlOOy4WXzQ3JC1y5T3gwl5v+bD8Nht2dBuzhf3FxgormgurgDqr6K/gebpJHpZT1BukU60v2pA9S/aQEY68tcGy3l6B9yTK3FxrBhfMfyQXcKE1FQsdqp/V99xxTGUUVtQJYmTuGDCBaIqLBcIa3BixaLKuRTV/gpa7xpB8HvLDa27xZncy4SWnpQ==
Received: from MN6PR16MB5450.namprd16.prod.outlook.com (2603:10b6:208:476::18)
 by BLAPR16MB3876.namprd16.prod.outlook.com (2603:10b6:208:271::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 09:02:30 +0000
Received: from MN6PR16MB5450.namprd16.prod.outlook.com
 ([fe80::3dfc:2c47:c615:2d68]) by MN6PR16MB5450.namprd16.prod.outlook.com
 ([fe80::3dfc:2c47:c615:2d68%4]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 09:02:29 +0000
From: Mingrui Cui <mingruic@outlook.com>
To: dtatulea@nvidia.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	mbloch@nvidia.com,
	mingruic@outlook.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com
Subject: Re: [PATCH] net/mlx5e: Make DEFAULT_FRAG_SIZE relative to page size
Date: Tue, 16 Sep 2025 17:01:33 +0800
Message-ID:
 <MN6PR16MB5450D5D96A644541A10B548CB714A@MN6PR16MB5450.namprd16.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <gns4qcq7gz24conarxktc5hl3hzgwiltqqotg2675ra2uz7awv@rszzlmr7kztr>
References: <gns4qcq7gz24conarxktc5hl3hzgwiltqqotg2675ra2uz7awv@rszzlmr7kztr>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::14)
 To MN6PR16MB5450.namprd16.prod.outlook.com (2603:10b6:208:476::18)
X-Microsoft-Original-Message-ID:
 <20250916090133.643241-1-mingruic@outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR16MB5450:EE_|BLAPR16MB3876:EE_
X-MS-Office365-Filtering-Correlation-Id: 94036940-b2c0-4c60-d448-08ddf4ffc387
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|5072599009|461199028|15080799012|23021999003|10035399007|3412199025|40105399003|440099028|3430499032|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UYMMLNdMkrKAzKThT6AqgsuCdODI+DCgipRFB0FpBvbflFcQAQs0s5zk2P8X?=
 =?us-ascii?Q?RHdhyn0QxZgCC7PC0vxidObzfYYTN4Co9OqXiRtEZwFFl5EyskA/sRUnncQF?=
 =?us-ascii?Q?9/d3cNRF2dVu1nby4eOOavMLLP1XuSKmlYBP2SnTa9Y5iAiJTxYapx+SJijm?=
 =?us-ascii?Q?mUBS23jUKcevNNz8j48ngx3s3xlc81zzojygqloFhSVlapJ6sPWmO03aBuOn?=
 =?us-ascii?Q?+IkhgR8MJ7rcPAjhvPs3oeCRqKQmyuWyEod7X6G+pQl2gvDe+a0Ac2fIlvoD?=
 =?us-ascii?Q?PmrWuNgieVhJ56K2BVh61wo1z3z2nZriBHi5VzN2DxzUY0z19S6KcAUavWmz?=
 =?us-ascii?Q?FU5/a+IKFP5r4ZAQzy8OwzqKjC30nbW4dd23LlKkb1TjcWRljy3DmLk6rcyK?=
 =?us-ascii?Q?B0fnHvfCTenxveIXyS9aOp8xQqGoCdDH2ap8EJqt8K+qrCZcTkw9RWzRFnRz?=
 =?us-ascii?Q?+JzBkwzTR/aGd15YBTg9HyEcHdedZe0sVIqTFhYZU/SM2OuYX2PT2Td9Cjrt?=
 =?us-ascii?Q?fbOag9L7C386iNsMd5YUnyDpw4L7YMOGRSrGUUDoMNU79pvmz8w1/nSnGCu4?=
 =?us-ascii?Q?MsLXfFXyMMXZSh/KngP0xvK2xgW88xVlJ3+vsQ1T+WikkelMsFhbR8sU8A0U?=
 =?us-ascii?Q?Ks7WGva9E6ZXyU9NESwXhudB5Rs2YsvkAQ2qXwlPI/PqAmVNeqDTIMSrOMTm?=
 =?us-ascii?Q?C5l2slpyy8YVYyVi4AbK1wtsrPyy0ADrtt/vkTgETvlJXHpI7sOHIy980c+9?=
 =?us-ascii?Q?Mxd7Qv1fkEzVpMXOpTUzfc6yT98M/LQU8Axn+KKJjnDjEhgTZb7oYY+9tXY6?=
 =?us-ascii?Q?CYNlIQTq4n7uO75X6qb3GGCMdtqH6QNG/5S4pAVmS0kPeBhJGEz5WyI1P2Qb?=
 =?us-ascii?Q?VqJGFvK2Q6vn7xz9SSRvgISQYMCDG/W/jtRIQtSu2TVgtUhLp7fthTVpegO3?=
 =?us-ascii?Q?YPYRDT0yFXJT7liAaAMBNpGrx+JN5kP04aud/avQpenZiKi6Q1nEekpGP1zP?=
 =?us-ascii?Q?C7L2okCHCzlSN+VtTknOCxGU+qeCCRyV3d/jJMNZDUX8WQYugYnMN32stpBn?=
 =?us-ascii?Q?N9VukmgDtJYxBNX59awPSou2Lve5b4U4sOjNzTHNROPTSkdYhRxwrrH/b39F?=
 =?us-ascii?Q?HiORq4/L4pnHtiiR3povAVWs++nbJgBHSPh5bx4RP8MnWQYYq4SqTsig7ewe?=
 =?us-ascii?Q?bU+UfL2iO4cE458L?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0SCwbqiTgNBOYWQTcFIWIe/oB7rkRdVUdgL5mhzqNjyh3rGLJ3YZapo6Mi0H?=
 =?us-ascii?Q?AwMb/JFmaSUL6YFiSMDXGr1h5pkYiVT6MujeLL4vHzwGBXm82o+RFmED5P5R?=
 =?us-ascii?Q?boYHy42OTxaCGBlwCzZ00rYgwaXD+TJSuuOzs4nVDGv9IzCZBxDdmifR4ed3?=
 =?us-ascii?Q?hZ/rTTgFVATLY3/526gjDZcujJlxvuoojTJqEZnR/KWUjoJguNYYwyw7+xDL?=
 =?us-ascii?Q?fmKtyMfHtdr0ewh32wFDEbtkMruTV/xSThEEHSI+YnqWR2L/paayO6dpuX5p?=
 =?us-ascii?Q?1QZFFAX5czvznT8dFIntHASo4nAJM/el7v4U8xCSRbGAle5iTWo32rXix40D?=
 =?us-ascii?Q?BsUukLHPN68bRYKqvEY6cj/fU89jhRbDAMDR0SGKpQvYirGtGIApoluauAFn?=
 =?us-ascii?Q?WoLSxMZaZODLTfl4DZ+1vwJ7N4odTOs7X95A5W+CuBwhrXMetzzL82vkF51y?=
 =?us-ascii?Q?0XLLoZgHfC7QURpz727zm26fE9se8pzbJrxPmOmPf5Umw4utwjJnd8ILeJ5E?=
 =?us-ascii?Q?Ig7kD9WW62oDQ8w8zB8d2FwEQ3b/0folqFWNiXG93iP4E2/oxJJG4XZzV6fh?=
 =?us-ascii?Q?+LTIjYXvFa7DbObD1EwsuEWra+Olc+Abtb6R9zpOmYxNVQrZmS4VY2945UcS?=
 =?us-ascii?Q?VtZOuFTptaGtgxKW+EKjUIxdF/cAVYtariohHh0JxVoOdwuSdgf8Cdh/fwTq?=
 =?us-ascii?Q?rjohdaVQps86vKWISMPhIum+vzwSKiLe8wZFSNpEhuhJyLGEtpBJIRwpWF2P?=
 =?us-ascii?Q?Tr2dCTsEdsvDSUnYEu9+jKdXdIxdsHQeaAva6B3l3usKJh/Ocve4VChKdOtS?=
 =?us-ascii?Q?oicnYsG0gM0rPVn1dgRC23DJCPeSZfcO46us89S3yQyExqrkFKIWN9PF5QWq?=
 =?us-ascii?Q?z1luxwchpwdYJ3/tjlwFZ1mAIsQbqmuZXEISgLL2eEKd7XZva5UbohydBnFj?=
 =?us-ascii?Q?hHLV7x6pbc/5GkBt6/VrwWA0BOTqw8hnh7NypCEMyPVuIn0jDks5zZ665hpB?=
 =?us-ascii?Q?9zX0mybbdE1N0uSBFKAcxpDKpHL5FUGNZWO05rCLpTI5BACfCz/2jfJoVw2G?=
 =?us-ascii?Q?++0NGPMIhNrVQ8UxMp3oVOk70GQ+07gkoogKi/ezehIO/d/LHn7jLFf5y2YX?=
 =?us-ascii?Q?m9H9DjHwxNdIHNqgn1nflIrBaUvhcsUnDILxHZdzfsKmwRtmgRhK7Y0RHIQk?=
 =?us-ascii?Q?lGXhCX02sz0PcNHGfzrcy3/Y2DTiUp1Jk1r+tnRYupTCnYSCUcFR6Cmohzzt?=
 =?us-ascii?Q?CHsjhB6FEs9WE+6Oq6py9DkdqyGw4VUD7Z98ArrRKQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94036940-b2c0-4c60-d448-08ddf4ffc387
X-MS-Exchange-CrossTenant-AuthSource: MN6PR16MB5450.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:02:29.3703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR16MB3876

On Mon, Sep 15, 2025 at 01:28:11PM +0000, Dragos Tatulea wrote:
> On Mon, Sep 08, 2025 at 02:25:48PM +0000, Dragos Tatulea wrote:
> > On Mon, Sep 08, 2025 at 09:35:32PM +0800, Mingrui Cui wrote:
> > > > On Tue, Sep 02, 2025 at 09:00:16PM +0800, Mingrui Cui wrote:
> > > > > When page size is 4K, DEFAULT_FRAG_SIZE of 2048 ensures that with 3
> > > > > fragments per WQE, odd-indexed WQEs always share the same page with
> > > > > their subsequent WQE. However, this relationship does not hold for page
> > > > > sizes larger than 8K. In this case, wqe_index_mask cannot guarantee that
> > > > > newly allocated WQEs won't share the same page with old WQEs.
> > > > > 
> > > > > If the last WQE in a bulk processed by mlx5e_post_rx_wqes() shares a
> > > > > page with its subsequent WQE, allocating a page for that WQE will
> > > > > overwrite mlx5e_frag_page, preventing the original page from being
> > > > > recycled. When the next WQE is processed, the newly allocated page will
> > > > > be immediately recycled.
> > > > > 
> > > > > In the next round, if these two WQEs are handled in the same bulk,
> > > > > page_pool_defrag_page() will be called again on the page, causing
> > > > > pp_frag_count to become negative.
> > > > > 
> > > > > Fix this by making DEFAULT_FRAG_SIZE always equal to half of the page
> > > > > size.
> > > > >
> > > > Was there an actual encountered issue or is this a code clarity fix?
> > > > 
> > > > For 64K page size, linear mode will be used so the constant will not be
> > > > used for calculating the frag size.
> > > > 
> > > > Thanks,
> > > > Dragos
> > > 
> > > Yes, this was an actual issue we encountered that caused a kernel crash.
> > > 
> > > We found it on a server with a DEC-Alpha like processor, which uses 8KB page
> > > size and runs a custom-built kernel. When using a ConnectX-4 Lx MT27710
> > > (MCX4121A-ACA_Ax) NIC with the MTU set to 7657 or higher, the kernel would crash
> > > during heavy traffic (e.g., iperf test). Here's the kernel log:
> > > 
> Tariq and I had a closer look at mlx5e_build_rq_frags_info() and noticed
> that for the given MTU (7657) you should have seen the WARN_ON() from
> [1]. Unless you are running XDP or a higher MTU in which case
> frag_size_max was reset to PAGE_SIZE [2]. Did you observe this warning?
> 
> [1] https://elixir.bootlin.com/linux/v6.17-rc5/source/drivers/net/ethernet/mellanox/mlx5/core/en/params.c#L762
> [2] https://elixir.bootlin.com/linux/v6.17-rc5/source/drivers/net/ethernet/mellanox/mlx5/core/en/params.c#L710

Yes, that WARN_ON() is triggered when setting MTU to 7657 above. Here is the
log:

WARNING: CPU: 129 PID: 4368 at drivers/net/ethernet/mellanox/mlx5/core/en/params.c:824 mlx5e_build_rq_param+0x25c/0x1050 [mlx5_core]
Modules linked in: ib_umad ib_ipoib ib_cm mlx5_ib ib_uverbs ib_core uio_pdrv_genirq dm_mod sch_fq_codel mlx5_core tls efivarfs ipv6
CPU: 129 PID: 4368 Comm: ifconfig Not tainted 6.6.0 #23
Trace:
 walk_stackframe+0x0/0x190
 show_stack+0x70/0x94
 dump_stack_lvl+0x98/0xd8
 dump_stack+0x2c/0x48
 __warn+0x1c8/0x220
 warn_slowpath_fmt+0x20c/0x230
 mlx5e_build_rq_param+0x25c/0x1050 [mlx5_core]
 mlx5e_build_channel_param+0x60/0x6d0 [mlx5_core]
 mlx5e_open_channels+0xc8/0x1400 [mlx5_core]
 mlx5e_safe_switch_params+0xe0/0x1c0 [mlx5_core]
 mlx5e_change_mtu+0x13c/0x390 [mlx5_core]
 mlx5e_change_nic_mtu+0x38/0x60 [mlx5_core]
 dev_set_mtu_ext+0x12c/0x270
 dev_set_mtu+0x6c/0xf0
 dev_ifsioc+0x6d0/0x740
 dev_ioctl+0x54c/0x770
 sock_ioctl+0x368/0x4e0
 sys_ioctl+0x610/0xec0
 do_entSys+0xbc/0x1d0
 entSys+0x12c/0x130

I plan to remove this WARN_ON in v2 patch, as it becomes obsolete after changing
DEFAULT_FRAG_SIZE.

Thanks,
Mingrui Cui

