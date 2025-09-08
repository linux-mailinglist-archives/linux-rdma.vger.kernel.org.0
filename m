Return-Path: <linux-rdma+bounces-13158-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 552A5B48FC4
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 15:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ABB6172CEE
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 13:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CE330BB95;
	Mon,  8 Sep 2025 13:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="P75JsP/x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2082.outbound.protection.outlook.com [40.92.47.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8EB30B528;
	Mon,  8 Sep 2025 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338592; cv=fail; b=gtQTS82z9KIYhQ+t47QYSstafP4NW/6F7VMnJ8HhYMh9JKDjN3xY1EM2YPPf5OYVe2TPumnqp/QelxNJpkH+kNZgLVmLw5Rp1kJhvRdajzVoBIIWuUTlgufPhhI3TYDy2xtF3Vhpa7RNZareRfhDfI8Yn77xyZtNnJzKE7cFcH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338592; c=relaxed/simple;
	bh=XP5JDPnbBnMibKrc3zVjk4nKk3V9Jj70avHj+if30hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ldhJXt0UcZo3QosLoprPlF7B8toU39qsifnMAyz7RKaU+clRQjGK/6ZoRGMbcwj5az1cHzRfQEpYvP8V76PfljnrjwFHyWMa/MGH+Gr5gejRvRQr0aE6AyE4/rV+LSzb288InGduugO28dpIuWTtmjYZV9aGjnQZHYAL2kX3Gcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=P75JsP/x; arc=fail smtp.client-ip=40.92.47.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcZtrXRJ0ydDWIAxcdAX42MpE2NFbPTVmdO4I9U3xyAF+Fgd/rMIM1Z8d8r9+X8GX7Bq6Vlah+xMuNJHc+fLifmIad8M9DqLoG2TRlmkyRg+3FM6AhXrreWTrRDLKrbSNJzXXWU7kE3BdgdefqWfJBKP2i2fuxbs406vqQqBdWf39sEdOJbql/cCWWu1DOT2IECVHAW3Y0grSMG19eb0fA8yKA4mW0LFRUcu1DBtSPWXnmxPtKSimjKKEFMau4s7YkqKlCzEgMJK9mWSYlRfTzgslh3kMDq80IN1ytuJaOSCvRzV1m/3PpapYGBrFABHSjIjNLKlnFwBmu2+rdrOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJMSiOVShnYvX3ZzsOi9WokRjdqJR0ertXqZNG10o/c=;
 b=K/md1n8Y68Y78uRVIcX4QubFvC2EAbHwIUNgztxWeEaT83bkydLiA1znO+0lnjjDwFFfIjGdjd6eEC+R/NALQUfWHjtqxIoiHjnugQrodWTyASfeVJDGOeQFJaBTr16CsRO4heEw9D/QMgOVPp/i6rmTHYSUq9z5HZ6H0XfdqFQN+rHLTpVsRMes0iO+w2Bmee2gdHhhvnSt7CeTk7LOKqyi2h6jERzACBxQDTvuxtV9fzspkTcwfByOQASgnofw7tikNDh833LNhcTdOlqQPOCbecF4ZrznyG2vxKuZxwYoCv9tNqxE9joLNE7XTJJFdIGoTcX5PJdxv/ejWezLBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJMSiOVShnYvX3ZzsOi9WokRjdqJR0ertXqZNG10o/c=;
 b=P75JsP/xbB7cQVFRATF/H6dmNV8pmJuDLcippMQhJFtEWp8oq2JtND8llj5UbMD95jmMdUI7AsdJH8uTgtxCqn7YPs2g2cSInKXftbZYpravi2qnysv1lpWTNOw3kP+24wbzSJArHtFf43rxUfRt+FsATWufnvhMXtnYEZAydPMHA+I1dreGcdUHB+czf0S8wfc+X6YmND9rhLZY7XzxB67K7urWBuv0wnFMS49lY9uncJ9IUMndb01mjv1Oo4nFw9iLbk0Xk7M+YDle1fKIVQXXjAYeAbqR0fduPqTs+WnuJt/hHDf+Mcq2znKKZDjXcWw/zi75WWR46Mw5X2MfTA==
Received: from MN6PR16MB5450.namprd16.prod.outlook.com (2603:10b6:208:476::18)
 by DM8PR16MB4421.namprd16.prod.outlook.com (2603:10b6:8:e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.19; Mon, 8 Sep 2025 13:36:28 +0000
Received: from MN6PR16MB5450.namprd16.prod.outlook.com
 ([fe80::3dfc:2c47:c615:2d68]) by MN6PR16MB5450.namprd16.prod.outlook.com
 ([fe80::3dfc:2c47:c615:2d68%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 13:36:28 +0000
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
Date: Mon,  8 Sep 2025 21:35:32 +0800
Message-ID:
 <MN6PR16MB545062E2EBB54C553CE059CFB70CA@MN6PR16MB5450.namprd16.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <l3st5aik5jtsexq6yng5el5txeif4itbg35kl2ft32zhi3pmef@kn4x6bo4ws7s>
References: <l3st5aik5jtsexq6yng5el5txeif4itbg35kl2ft32zhi3pmef@kn4x6bo4ws7s>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To MN6PR16MB5450.namprd16.prod.outlook.com
 (2603:10b6:208:476::18)
X-Microsoft-Original-Message-ID:
 <20250908133532.598761-1-mingruic@outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR16MB5450:EE_|DM8PR16MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b38f677-7693-47f5-cc28-08ddeedcb64c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|5072599009|461199028|19110799012|23021999003|15080799012|440099028|40105399003|3412199025|12091999003|3430499032|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9XixD3sNLLYxF5eNBmY65+lYZf1mG3uu4TFgnSshXIyp+zEmLeGAIHqHkmu+?=
 =?us-ascii?Q?PMShKYnOQOkUWHVbPZ8MS3zwYfcqMeXPUH5zM0v37P1pzR7cWrjLe/JyFP+Z?=
 =?us-ascii?Q?YzBL0NRl7laVgSdqY4l+T2j+4+dJPSfDAre+HVAK1doMNLkg073IjUydYxOa?=
 =?us-ascii?Q?fqJ4vaBouy6Cspd3fY/A1uiMt4vJgmMYxkOJ8SH8qx4ariqEn9GLpi23mFff?=
 =?us-ascii?Q?2hM3u7OYs4I9yPxxTGOAmwoPLdvob5tW8Se92cexL663Zr2kjazijJL6Zt6j?=
 =?us-ascii?Q?VzBP+KCPvmrg5W1Qmh/wflodqMHPvb5Ekrq6EirUrAMAdrDAoitbw+q7EL2M?=
 =?us-ascii?Q?WICqrXZ5OhPuq7jW5G4clAd5QoY/tjxQskUP33e+wcf/ZYUixrqaVoot53+B?=
 =?us-ascii?Q?YfDcfpS6438agy/RR7awVMd9cQq+qQYmudjpf1qnhEEsmS6WSLempJAkNIP1?=
 =?us-ascii?Q?4hrWZMEi8f2Wz+BgEATwS8ZonjEcGxuvyYZahZOaftVAbHslZ7PWDWKtLZdU?=
 =?us-ascii?Q?R6il+Q/HkTruzixjPQ9ZvyvCAY6VjZd8UhoL7FSB6Lt85+eFkUvZq6YSFK0f?=
 =?us-ascii?Q?NI3CFIQD9/trutF9wTXcniPWjtwRXpkHugZeDEjmTZz9cGn2y2CWhxTf4Q8T?=
 =?us-ascii?Q?bNphaAPW8HhxbzoNrWgnwyynPC++NzUN4L6B3WP5SK2q8pp8xjSZOSCUn/al?=
 =?us-ascii?Q?aom/Dv38zYCHGCyn/XKb/06an5NTW9TzoybFv7dPvghlPfFryznn4Ia/2qY6?=
 =?us-ascii?Q?hUrudSHkOWckeor5WGiXGm0JByh1XRcZQePW5g3bDAHe6rBPFEFQkOjSbNFz?=
 =?us-ascii?Q?VeUUdcZ+w3iRgbbWHAAqzNhNoYix1y5+6AWu4V7jF9UVYrNIUFSRUecYJ2Xl?=
 =?us-ascii?Q?pjH7oLb9nSWRwhKWt/JwngIUXxz2fcxEbLnkOYVsx56jnnLobTHQdAee3kY0?=
 =?us-ascii?Q?DSszhMlqb4GAP+mSs6uFgqUxbSHQHCjRsvwQhdsa3zCrvpzg67kFfc2OSbhC?=
 =?us-ascii?Q?LCWI0tBm2v7M8ykAvHZemNA4zDIEjvjiYPOAmBST5KW5gK8NdGjea5Cuxm5s?=
 =?us-ascii?Q?14jNoMv4c7ZWDATR9pKQxqUMORH7uwm1yDfzUp3z65436bUBCbCQkNs97fbT?=
 =?us-ascii?Q?b3UtIQq7pVqMcuyw44p89IxbTAiK8K4HxAqSYIktIY2G4w9GP6pYn7dTzkPn?=
 =?us-ascii?Q?DgXpM3ZGtAZIwf6wzONtCiYbFIHcyqnG6RmyIA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5sGUofCGYyF5rlnufFVsOQehWzjF423zPxNNoJtAcUMJ6XtTeBWxolTpKVui?=
 =?us-ascii?Q?lWUlNDfcEhGQTpfjp23k7IgHzIZt6UvH8S4fts6RT2A8ywA23eCfj3WuTAAr?=
 =?us-ascii?Q?uM23eV5ldny7J34FIIiNUa5aaxaGlNiUW5AOqcRRxZf/ZrN9eLVbCTrlFm8X?=
 =?us-ascii?Q?GWwOAuDNi1/M+qTMnfhaBTwhNGXBr6zeiKvgE3tSIJSJVgybMNUgr12va8y6?=
 =?us-ascii?Q?OMe6Hohn382QzG8ijvRIl6xkty536y53hTXIv+noye/W0hCpDfB8TH35Vl6m?=
 =?us-ascii?Q?7pqNt42pgxliIAx77J44GZWxNoyyVI+199WOF8gF84dBE4WV8id3SAZMzt+v?=
 =?us-ascii?Q?H7qnX/j7SwKzUxnl3xQt/6LYO3bGnD8qZKH/Fh9Dqh7sEoNpIC5veBm2ahWk?=
 =?us-ascii?Q?UPdBGr9n5PO2PW8v7eQp6Q7i03YqZYNP+Ej3jaE/FU+84MWVJpgHurflnRI1?=
 =?us-ascii?Q?D5XWLD6ejhIEMSUPN8C5DZot24Tln98Q980uRaqaCdGCw7VbitlYqlFDiTzb?=
 =?us-ascii?Q?bqIdJLjWF8A2/lPapm8alDqntldX1A0ukweE067j3uxLoqvjHe9DWgOaahPF?=
 =?us-ascii?Q?pl7g8AnBvpFi8RO2FaDemeOagvCkcZbiyFVSQVaTQaMteget1psnZP9K6wg1?=
 =?us-ascii?Q?GIvuQQWjcH04ejTNm9ejlRazRxkobngfO1/gAl5nitJmLgdQrNKIL+zWRe8o?=
 =?us-ascii?Q?xl6k5AAkTePNGVL4ANgYNlbajcSWnV/klZsTB5IqVHi0lHtV8Hx9ixRY2vL5?=
 =?us-ascii?Q?/95KvRayCoEqAPvEb1jZbzQ+9CFLyrrPrCm//j2sqpUnrcxb15W0uIIExqe4?=
 =?us-ascii?Q?TCvj1prYThPx4IZaN1TMxTc3j/SfrHH2001gpGLqiTjfCn5496c2ekYfs9Wu?=
 =?us-ascii?Q?fvdnjon8zNhqQBu1E0FljxBwlfhgwAh+LSXF3+E04GuNtCz/xOXbz64MHwUw?=
 =?us-ascii?Q?YS+Ew0+LygjoQgv9uenYfQG9NNCErJzXfCvdqDbjt0JWTzvIFq3WY6TxCuk7?=
 =?us-ascii?Q?ekRBb4VAzWgbX2P8RKW5sb0yvPy7ovgZ28E3q9EJPbb5MIWzc7SyjF0ql1bH?=
 =?us-ascii?Q?qKtFqlKDwcc5gUn0mi0PzMDilLO5fVKd3Sf44wdClFdZFxT4Xw02MkzCIXot?=
 =?us-ascii?Q?pe+pTC+6OIOG3DNrUllJuKq8oHScEIKzTEdXE54QmukQXdsLeWGHStcsgdgc?=
 =?us-ascii?Q?zT1M48ayVdgFJIqeC5zomhpSaZZsYMqtAWFCTo1NQEptVhoPHbGAC3gFfEKZ?=
 =?us-ascii?Q?0V7Qf2OCFB12svaGe8AI9wweX29nSc3tdleS11mnNg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b38f677-7693-47f5-cc28-08ddeedcb64c
X-MS-Exchange-CrossTenant-AuthSource: MN6PR16MB5450.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 13:36:28.3470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR16MB4421

> On Tue, Sep 02, 2025 at 09:00:16PM +0800, Mingrui Cui wrote:
> > When page size is 4K, DEFAULT_FRAG_SIZE of 2048 ensures that with 3
> > fragments per WQE, odd-indexed WQEs always share the same page with
> > their subsequent WQE. However, this relationship does not hold for page
> > sizes larger than 8K. In this case, wqe_index_mask cannot guarantee that
> > newly allocated WQEs won't share the same page with old WQEs.
> > 
> > If the last WQE in a bulk processed by mlx5e_post_rx_wqes() shares a
> > page with its subsequent WQE, allocating a page for that WQE will
> > overwrite mlx5e_frag_page, preventing the original page from being
> > recycled. When the next WQE is processed, the newly allocated page will
> > be immediately recycled.
> > 
> > In the next round, if these two WQEs are handled in the same bulk,
> > page_pool_defrag_page() will be called again on the page, causing
> > pp_frag_count to become negative.
> > 
> > Fix this by making DEFAULT_FRAG_SIZE always equal to half of the page
> > size.
> >
> Was there an actual encountered issue or is this a code clarity fix?
> 
> For 64K page size, linear mode will be used so the constant will not be
> used for calculating the frag size.
> 
> Thanks,
> Dragos

Yes, this was an actual issue we encountered that caused a kernel crash.

We found it on a server with a DEC-Alpha like processor, which uses 8KB page
size and runs a custom-built kernel. When using a ConnectX-4 Lx MT27710
(MCX4121A-ACA_Ax) NIC with the MTU set to 7657 or higher, the kernel would crash
during heavy traffic (e.g., iperf test). Here's the kernel log:

WARNING: CPU: 9 PID: 0 at include/net/page_pool/helpers.h:130
mlx5e_page_release_fragmented.isra.0+0xdc/0xf0 [mlx5_core]
Modules linked in: ib_umad ib_ipoib ib_cm mlx5_ib ib_uverbs ib_core ipv6
mlx5_core tls
CPU: 9 PID: 0 Comm: swapper/9 Tainted: G        W          6.6.0 #23
 walk_stackframe+0x0/0x190
 show_stack+0x70/0x94
 dump_stack_lvl+0x98/0xd8
 dump_stack+0x2c/0x48
 __warn+0x1c8/0x220
 warn_slowpath_fmt+0x20c/0x230
 mlx5e_page_release_fragmented.isra.0+0xdc/0xf0 [mlx5_core]
 mlx5e_free_rx_wqes+0xcc/0x120 [mlx5_core]
 mlx5e_post_rx_wqes+0x1f4/0x4e0 [mlx5_core]
 mlx5e_napi_poll+0x1c0/0x8d0 [mlx5_core]
 __napi_poll+0x58/0x2e0
 net_rx_action+0x1a8/0x340
 __do_softirq+0x2b8/0x480
 irq_exit+0xd4/0x120
 do_entInt+0x164/0x520
 entInt+0x114/0x120
 __idle_end+0x0/0x50
 default_idle_call+0x64/0x150
 do_idle+0x10c/0x240
 cpu_startup_entry+0x70/0x80
 smp_callin+0x354/0x410
 __smp_callin+0x3c/0x40

Although this was on a custom kernel and processor, I believe this issue is
generic to any system using an 8KB page size. Unfortunately, I don't have an
Alpha server running a mainline kernel to verify this directly, and most
mainstream architectures don't support 8KB page size.

I also tried to modify some conditions in the driver to force it to fall back
into non-linear mode on an ARMv8 server configured with a 16KB page size, and
was then able to trigger the same warning and crash. So I suspect this issue
would also occur on 16KB page size if the NIC can be configured with a larger
MTU.

Best regards,
Mingrui Cui

