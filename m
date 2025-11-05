Return-Path: <linux-rdma+bounces-14266-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E3DC36744
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 16:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09A91A25F0D
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 15:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC40825BEF8;
	Wed,  5 Nov 2025 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rM2mzroU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013068.outbound.protection.outlook.com [52.103.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840901E9B22;
	Wed,  5 Nov 2025 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356895; cv=fail; b=a0Cxah+/4uN3RX1wL50nu5EJYMpzooWVx2IqbAoKKWgjPqVv9xAdVAMAvVVfV1kfkO2wi/6OYLgT0du1pPC3P/d+sGaqyn66KVmCGLf0yjj0eAvboByD07/j4TSpWK2eacujQSAiXh3bLNlz/FC4ORX891XDi5Htau8HliNz++o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356895; c=relaxed/simple;
	bh=oX2ZyY4PCvj5PuK2xBUu0ROwxskpvxUR51uqRlW/Cvw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FFTa1+nV621o0CzRLBrFTfx16PPAm7+s70l5v8JqJPpPT0kY2/QzNzMhDCuJHOPQV4gN7b3kwXIoGrU2B9OBRQRQJ+vJbg0lP3CCyoxpfO4c2K4+81CsrJ2ATBs8jW5MxOOy8X19ONGDiOEh3E2lPjFzOjn12Ch+fjAz/LTjWec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rM2mzroU; arc=fail smtp.client-ip=52.103.20.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQuXEPF+9UHl/UKIm5LqwFqxbg0nzs1oKyTQ67nHtgWZQsw9apQRr9ZY1twQgAHaeKEA++g5Yvpxa4zeYdT7hrttMCsXnwZoFCLWFxp7BGPioVZz6Rf0ffJ7Vf/b5LtjLAloR3C1uhh2qEK9jrS4+4iyFuuOlkSJKW078anaZ7OaUn5nmzIF1WTv0016mQ23jA5BKjhlVT0nWegBKgNlp5FhsTohLVxEY9zw36+c0EB3RP15LTptCRc4kbIwPSSInd+q9UzPsRcg06qVQ50irM74MDuxp6ENW6A4RJm3S/hwPpHYbgbgkFnSSWYxhulfPi5NcYt3Zee71sDaRcJkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DF9spPDmLRsnU7N6U3YINr0EThkeAn66FbLXNSQCIU8=;
 b=A7LWrd4K1q+8ae9/imgaWkvIRY16W+fsRMlD8nQieoPSqiWaQ5zUyV812R67H59VIAiLGhFor5fNLmkkhYWiwpdpBSzV9DKIjh+qL4fBA4AltA/TLBuOj9GPmJbyB3aeYiAAnLH2rxgso4Ft62akD2ABoRYjTW82p3JpOUG/OweCU5fYYqQZM9h/qMtIkFsijXZFGAcvgbToFdnjV/n73iX0CmMXLos7/fY/hjjkgnRaTEkTw+SnG+1Bfq4zWKoWejHR2EZ4ZU7twevHj1KjLQ+5xuppJzwLJ23NE2lYlmkqyPJP6mVB+1sFjf541pbrNRU0xqTe/15ty/9FTIAuqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DF9spPDmLRsnU7N6U3YINr0EThkeAn66FbLXNSQCIU8=;
 b=rM2mzroUb+c4j+ZyEta71vJc23U48hu6vUf6B/38TiB7nDrcrOmKnztKImKo//VpwP6QaZVb5PoB8R2cWciBNffFNz1wlMmvyU4QP51lAwBM2ghdiAp8XkPtitJc+6GSgb0H0VDAmsK6V0SWEM2WLV/Yo10cXwASE9W413Hv2515J1amTElXeS3KxgsfupMcqkJLf7rqbpURT3fawEyfSZLg+7ECK+jzNPZ45Q+aKbSIXxWCyBtEL4Cpz4u0XNxgKv/0+9zUTvPdco8HBh593ErKsDThi0qRWY/BAv2b/12EX9iupQw7TY8a7P0czwr8P8m9k6R3OUlTUIdCBPrM8A==
Received: from MN6PR16MB5450.namprd16.prod.outlook.com (2603:10b6:208:476::18)
 by SN7PR16MB5178.namprd16.prod.outlook.com (2603:10b6:806:359::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 15:34:49 +0000
Received: from MN6PR16MB5450.namprd16.prod.outlook.com
 ([fe80::3dfc:2c47:c615:2d68]) by MN6PR16MB5450.namprd16.prod.outlook.com
 ([fe80::3dfc:2c47:c615:2d68%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 15:34:49 +0000
From: Mingrui Cui <mingruic@outlook.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingrui Cui <mingruic@outlook.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net v3] net/mlx5e: Make DEFAULT_FRAG_SIZE relative to page size
Date: Wed,  5 Nov 2025 23:33:16 +0800
Message-ID:
 <MN6PR16MB54501AC60FA25B6C79FB2C3DB7C5A@MN6PR16MB5450.namprd16.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:196::16) To MN6PR16MB5450.namprd16.prod.outlook.com
 (2603:10b6:208:476::18)
X-Microsoft-Original-Message-ID:
 <20251105153316.528539-1-mingruic@outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR16MB5450:EE_|SN7PR16MB5178:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5fcdb7-a0cf-4188-970b-08de1c80db29
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|15080799012|23021999003|19110799012|41001999006|13031999003|461199028|5062599005|5072599009|1602099012|40105399003|4302099013|3412199025|440099028|10035399007|12091999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lXjyKxXWrQ8Xv0xhtbhFIrsNbAYe5s6JNfnrQHiNQfLkLSaa+UNQcOwZBVhs?=
 =?us-ascii?Q?O5mm2jmHASdorF86dr5Ye3JGG+UF/SZa35SPE2s++wBUjucR6L+0D2U6ejS6?=
 =?us-ascii?Q?q2Y6dyXEdrzWkh7U0AWlaNOuT082Tt/i8QIbXwbjYL4tYyM19U0eGTimkJUG?=
 =?us-ascii?Q?BWXMwNAFmgii98Hsv8l7LM7C4YtSo568FTRevCdU6z87QnZCm2BlqGQZulgw?=
 =?us-ascii?Q?E567YLU5v47tzXZIMCgrFbyrNJv+/uEjqIhmQRXgwxJJ1j+iv8BjTKdWz19F?=
 =?us-ascii?Q?Md/N2nbX/armFOkXIGCPIvVFPeIi3zouuwGWk7tm7Lbw9Sl/gAx/MwEGOaEe?=
 =?us-ascii?Q?UQwE/Q8sHSw3s9+E60knKZXG4wNQccLPa8mcaJ3Df+kKUQI8q58POHBHo38E?=
 =?us-ascii?Q?TwFu+PA/s/SsUoTN0hdyW6DL+fB2YNOhmub08o83aSTs/SrXmLBhSgBHsRRF?=
 =?us-ascii?Q?WdBxGZINAh6R7oeu1H9Ntq7s6odOZ3TJl7yIJGJrEh4EBxYzOqBLR6tdi3m6?=
 =?us-ascii?Q?e2zLr0qkxKd/nuhiXit3HEcEmKxL8p+/64yNAjGzXYIgJuwBLmHMSJ2DFUgb?=
 =?us-ascii?Q?U5LqunN9tbPYnyJR6fJV/W1gCt8hxn9EJJdSsZIwdyz6yGim/gFktZM/FBAQ?=
 =?us-ascii?Q?9+iBEmDJkLKUgxeRj3IHU/K+bGuDQ6mc9d6gwIRE2f5amsZy8TbaHk9RVp1h?=
 =?us-ascii?Q?jwVmRHGf71cilzQvlKzn8jZL+VjrJqVx8Xk4W5MlQrjxO/AQJHMaVTvCSWDs?=
 =?us-ascii?Q?1OhPdpTiBmwgSWOhqlmB+AJoenv1ccQ1zCo5ZXKwjei+ZDtl3+JqhP8B/i3G?=
 =?us-ascii?Q?aBUYT+M02Z+Jino4usxkbsPEAVXsWvVk6DBOqy+E681wsGq9kMiun5fejU8U?=
 =?us-ascii?Q?fcmdozd2nwqqA4heT6tqqRXBj6VP7tTXfNOCTaQzm9batMvlgfKx+vyAnwAn?=
 =?us-ascii?Q?DsP6Qs44GLPXSH7iUFiqmEYRF+/jEZqMf7qbHXFv7pOz24amBEgk2JLXErFR?=
 =?us-ascii?Q?oXm2D9Lj8kU+d7ffgDZpwm9FgAh592+1Ir8RpVhhLgpMsqtcnoJiGvKp3VvH?=
 =?us-ascii?Q?R8jLdEnzu5sHfhXL1tdWMRc3ZuUx79cSPheVuYH+il8z4xICDHZT28B4LSjJ?=
 =?us-ascii?Q?rRxc/boRyF3Uk5VLiKWjtsbhJbOrQDjeKU7lmm3why3SpfINj+2ow8Ej7jAs?=
 =?us-ascii?Q?PQCIUcqdg0IYywt8xwR0EqTk++bKbWWx27JCry11jaPMM6uN8Mj1gd/KoE5/?=
 =?us-ascii?Q?HO+5c0BMMN/jFKCYLl6bj3PAZaEnp+Im4UeG8NFXs9CnFr15O6vgFgRoyLnk?=
 =?us-ascii?Q?cFs+LF+f9wzxWGl394YF/UahO3l4ti5DeFYW5941Y3p+2u9MOgyuH1UzHWlf?=
 =?us-ascii?Q?cOaWaj5QgtW/W/leSPrgE0ntZ3/Cjc9D7CWjx6k11AlE4HHjY3UGlX9TclsW?=
 =?us-ascii?Q?kQ+WncJ+qfk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VjZ5+fI5VMbuSyBX8epHdyIb5Lh9ULTI3/blvxUwsxlvzUqlHeZOjRdCRKAJ?=
 =?us-ascii?Q?f29YaSYIZk/4Y9eK9l/nTOYz7xwSXi8mHL2+cyCPlEg2QdeOqt2xn3n6N3KK?=
 =?us-ascii?Q?ximyj9/UvOqGPPr0MnycrGVDk7bi+yYZArNQA/Zzlo4l/HQGvM9inP1b/Jow?=
 =?us-ascii?Q?fl4jCLK8FKRz4egNGz8nvGleVcvbWPaiGX7ozXKW9/bx0Ir1lgYyW6IjWRq8?=
 =?us-ascii?Q?8J1UzrvEuIL9S73MHMypbytScMr4MGlRPE6e6d9deZElVqFP/rQouG0eSvZ0?=
 =?us-ascii?Q?Pynm6sgufRl338QcFFX1vfN5v7vj1S/beClcsAEoFOlKPshjbC/RgcS4XJeo?=
 =?us-ascii?Q?N+zbRwspE8LW1MtfmrV6Pb8jK8gK+cEwEUB0Xgv/rtMsJ/xL7lGfkLWJDZvi?=
 =?us-ascii?Q?v+vCavYQIS6tso+uprmxanycXo3hEGWH27Yu0TNAfwtmiRWWyPhlUuUDbeK5?=
 =?us-ascii?Q?6781oAZwdg5NjCVxapUNfqEycdVwhviEwNcLWbkDvBHUbKSM3/GTb88lbzc+?=
 =?us-ascii?Q?YVX2ZaRXu8EPvKjdCvJuCxRcy964J4wjuzTyy0ZvzTXWFAZlaKRaMbx7BeoP?=
 =?us-ascii?Q?49dsdCHOo+blFU+4IxZBZHx3CTvmPW1a58qXFVx+VzNwa/trNONyUZC7TkKJ?=
 =?us-ascii?Q?rJawp6QE7uQwjjUwLBMS14q6QG5JiF0Mme7fsa+Tr7T2lByBmQDye7sITWNL?=
 =?us-ascii?Q?sgK/Z+oSJPZfywUjgWoa4J3MKAhl9xoEYSYjFVtilyVKBYxbQXG1hxDyvDEK?=
 =?us-ascii?Q?mjUtz3AB2Rzl/cix4zvgFXJNzDkP1bRcIcZD0gH44MSOA1OQR6nno8njDUxq?=
 =?us-ascii?Q?dRvWkdCJKE/ToVI2fSgiGvbG96FpcRc55pd8tyX79Mmdn+L7jAB81bUteak+?=
 =?us-ascii?Q?0TbfkL2KPH69tHaQm75+RILRiapNnszPdAxFkALPHjg+0K8BnUJuKb7DJGyD?=
 =?us-ascii?Q?GPzo+kE4Y3ZMlVUZlUuv2LxGhiYSxaHFBSRXiGn5oLoPF/UOJJNVAdEd8DuB?=
 =?us-ascii?Q?00tGr1RmvCZFirFOrjlof9pBFsNu5aoDiq785LZYXhIgGmX8ls3jFtUzrzyj?=
 =?us-ascii?Q?fgUeh7NwMXVLbs8/H8T8Pv3wp6LlqtYGCXoR09v0KWDBgqnI1sZiUwNF1Wit?=
 =?us-ascii?Q?htUYAWPOhEjCjsEtYSxyVgTKiq6HzWkka0eRgu0sEJKIREAK9jcur4ZX7sl5?=
 =?us-ascii?Q?5TPMgMTxAboZ1oEGdh7pU6QpqJuFMZ5uJt3TgXG9sODUPsScaZXtWjgFy3aN?=
 =?us-ascii?Q?z/lWQTWYMWNtYbIQFiEU1CsDR2wxKMe9iqVGIwCBew=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5fcdb7-a0cf-4188-970b-08de1c80db29
X-MS-Exchange-CrossTenant-AuthSource: MN6PR16MB5450.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:34:49.5502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR16MB5178

When page size is 4K, DEFAULT_FRAG_SIZE of 2048 ensures that with 3
fragments per WQE, odd-indexed WQEs always share the same page with
their subsequent WQE, while WQEs consisting of 4 fragments does not.
However, this relationship does not hold for page sizes larger than 8K.
In this case, wqe_index_mask cannot guarantee that newly allocated WQEs
won't share the same page with old WQEs.

If the last WQE in a bulk processed by mlx5e_post_rx_wqes() shares a
page with its subsequent WQE, allocating a page for that WQE will
overwrite mlx5e_frag_page, preventing the original page from being
recycled. When the next WQE is processed, the newly allocated page will
be immediately recycled. In the next round, if these two WQEs are
handled in the same bulk, page_pool_defrag_page() will be called again
on the page, causing pp_frag_count to become negative[1].

Moreover, this can also lead to memory corruption, as the page may have
already been returned to the page pool and re-allocated to another WQE.
And since skb_shared_info is stored at the end of the first fragment,
its frags->bv_page pointer can be overwritten, leading to an invalid
memory access when processing the skb[2].

For example, on 8K page size systems (e.g. DEC Alpha) with a ConnectX-4
Lx MT27710 (MCX4121A-ACA_Ax) NIC setting MTU to 7657 or higher, heavy
network loads (e.g. iperf) will first trigger a series of WARNINGs[1]
and eventually crash[2].

Fix this by making DEFAULT_FRAG_SIZE always equal to half of the page
size.

[1]
WARNING: CPU: 9 PID: 0 at include/net/page_pool/helpers.h:130
mlx5e_page_release_fragmented.isra.0+0xdc/0xf0 [mlx5_core]
CPU: 9 PID: 0 Comm: swapper/9 Tainted: G        W          6.6.0
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
 [...]

[2]
Unable to handle kernel paging request at virtual address 393837363534333a
Oops [#1]
CPU: 72 PID: 0 Comm: swapper/72 Tainted: G        W          6.6.0
Trace:
 walk_stackframe+0x0/0x190
 show_stack+0x70/0x94
 die+0x1d4/0x350
 do_page_fault+0x630/0x690
 entMM+0x120/0x130
 napi_pp_put_page+0x30/0x160
 skb_release_data+0x164/0x250
 kfree_skb_list_reason+0xd0/0x2f0
 skb_release_data+0x1f0/0x250
 napi_consume_skb+0xa0/0x220
 net_rx_action+0x158/0x340
 __do_softirq+0x2b8/0x480
 irq_exit+0xd4/0x120
 do_entInt+0x164/0x520
 entInt+0x114/0x120
 [...]

Fixes: 069d11465a80 ("net/mlx5e: RX, Enhance legacy Receive Queue memory scheme")
Signed-off-by: Mingrui Cui <mingruic@outlook.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v3:
  - Add a warning for page sizes above 8K as suggested.

Changes in v2:
  - Add Fixes tag and more details to commit message.
  - Target 'net' branch.
  - Remove the obsolete WARN_ON() and update related comments.
Link to v2: https://lore.kernel.org/all/MN6PR16MB5450C5EC9A1B2E2E78E8B241B71AA@MN6PR16MB5450.namprd16.prod.outlook.com/

 .../net/ethernet/mellanox/mlx5/core/en/params.c  | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index c9bdee9a8b30..87b262299ef9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -668,7 +668,7 @@ static void mlx5e_rx_compute_wqe_bulk_params(struct mlx5e_params *params,
 	info->refill_unit = DIV_ROUND_UP(info->wqe_bulk, split_factor);
 }
 
-#define DEFAULT_FRAG_SIZE (2048)
+#define DEFAULT_FRAG_SIZE (PAGE_SIZE / 2)
 
 static int mlx5e_build_rq_frags_info(struct mlx5_core_dev *mdev,
 				     struct mlx5e_params *params,
@@ -758,18 +758,16 @@ static int mlx5e_build_rq_frags_info(struct mlx5_core_dev *mdev,
 		/* No WQE can start in the middle of a page. */
 		info->wqe_index_mask = 0;
 	} else {
-		/* PAGE_SIZEs starting from 8192 don't use 2K-sized fragments,
-		 * because there would be more than MLX5E_MAX_RX_FRAGS of them.
-		 */
-		WARN_ON(PAGE_SIZE != 2 * DEFAULT_FRAG_SIZE);
+		/* PAGE_SIZEs above 8192 normally use linear SKBs. */
+		WARN_ON(PAGE_SIZE > 8192);
 
 		/* Odd number of fragments allows to pack the last fragment of
 		 * the previous WQE and the first fragment of the next WQE into
 		 * the same page.
-		 * As long as DEFAULT_FRAG_SIZE is 2048, and MLX5E_MAX_RX_FRAGS
-		 * is 4, the last fragment can be bigger than the rest only if
-		 * it's the fourth one, so WQEs consisting of 3 fragments will
-		 * always share a page.
+		 * As long as DEFAULT_FRAG_SIZE is (PAGE_SIZE / 2), and
+		 * MLX5E_MAX_RX_FRAGS is 4, the last fragment can be bigger than
+		 * the rest only if it's the fourth one, so WQEs consisting of 3
+		 * fragments will always share a page.
 		 * When a page is shared, WQE bulk size is 2, otherwise just 1.
 		 */
 		info->wqe_index_mask = info->num_frags % 2;
-- 
2.43.0


