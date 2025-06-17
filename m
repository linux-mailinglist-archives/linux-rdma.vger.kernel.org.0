Return-Path: <linux-rdma+bounces-11406-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D81C7ADDACA
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 19:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273D51881D5F
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 17:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1345A2ECD3A;
	Tue, 17 Jun 2025 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CW4C9Lyw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCA91F4174
	for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750182048; cv=fail; b=H7b3IEBivmscDTBhUvlpIXARqdsH8UbOe5DqIUOSUOrAr0AGwnl2Ww8K9SoXvZFRzvSk/2+0a05+nSTrH1bSRY0O9KwhupITqfsLkax9qpeL9NX8xIBOzkOUpSrOnqfklr8EfAWx1VIi5KUJaq1JeWC8gjGbsSWlGAETYt2qzbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750182048; c=relaxed/simple;
	bh=B23lqNyVXB3NkCutSK2rskTDIIfqeemUsWvaN66QH/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jMuQz5vbjFisThiZsejVikT+VMY2/ZdwadU4h6AvzgcF8q9Gu+6xHEJyX9iWOZlrR4XG4dJ4W0c/VguJSU1a1h7JPCKchOQifPBKWjCWl1Z477krUX7uCu0Nxkl6SgHVcGdlTt9cC1F9J4XACZ3Xf86VlQzx1xVVEADdF92rvhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CW4C9Lyw; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spt3dDgsgJY9xPHKpj3+LSw4fV+YPP7JoY+sldWuGpSZhQLIwVqAhwL27o8rfpaMs5Y/0qHy8dBUDx4yQhKutmc1/tv3JmMvTU+nRTnPm81Hu24EqU82ViVtZUvA8bVq6ne6pMjf1s42wG8skWgh3kKv423hf2Mu/Vds6tshZLKycNTASE/fspB1ZJ9es1MBdId8BbQzWuupk+xu3puCKd4mhXobE8hM7n9OQvWmQY9l1qd2fKGJaV0W7FT4fUHcRLZlbhF6uhhCzdwTYf71NEdBf95IlIv2T945qdV7TjzpShcwOLQru5kEStL/zRVbqIemsORwiRWQJRRc23p9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YF33jiaaLyF9Wtly84o/EiAoqGwz26alYGfOa3tfGE=;
 b=YucZb4HaxwBeRaNEKyt1R7xs+sgZBpa++bUNTEL4A1Koyn90/4In7MzMKepGCctrq6gEqcJdYUQLB89S5lDG943sBAZNHovMYoiUuQAaeX0Ivw2oSoP9D5ye9AAIr9a8WPvOJ3HR0eka50JRwIcm5Ung1kEQoKcxaQTzUrjFAzTX1qNcj2hV81T7FTF08w0NLl+xt0968LIwHVxsF0VIAQKpTqqE0Yqj4kDWKk9NbPVFHgEK1w9Bsn0A6p9fgqdqnF3o9MKrmNZ/wKsloaWrp25ktVI7/CGBQ/SwkzPfeqv3UX4bJuHzZUzrs68+jF0Qxv6JL9FWgJDaSP31PoaIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YF33jiaaLyF9Wtly84o/EiAoqGwz26alYGfOa3tfGE=;
 b=CW4C9LywORVoRyWcjYtMJyUUANFf/7mkM1I7oVFBHp1iYbr+NwxeY3KC5F6JUCiGE8XDLL/NWyMcjOv0mTb4EqXT/Ar9XmjmHWUahMJFtYNQgLU9A6illHAu2qPzkPl3xLBDhZwMgMutma3mIjQjun0U+rT7sRTJA5i40/zbAlaHgqAwG6PgjAWXkE0qgrgwRLgeKeYo7yfORdN52yHpx1UczggNO6Fe4JyrIviydJEg3+6Dk5wVlsOG12ROmyieLro9CVz8LNMKDliIdvlpMI0kPoKxLxe73rxJIZQZGquCNaMA7Fv4sAy1AhtU9AKLrDpa49Xfz5/yYkmZttmMuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 17:40:44 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 17:40:44 +0000
Date: Tue, 17 Jun 2025 14:40:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Or Har-Toov <ohartoov@nvidia.com>, linux-rdma@vger.kernel.org,
	Patrisious Haddad <phaddad@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix unsafe xarray access in implicit
 ODP handling
Message-ID: <20250617174042.GA1569186@nvidia.com>
References: <a85ddd16f45c8cb2bc0a188c2b0fcedfce975eb8.1750061791.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a85ddd16f45c8cb2bc0a188c2b0fcedfce975eb8.1750061791.git.leon@kernel.org>
X-ClientProxiedBy: YT4PR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f1af4eb-b5c5-4d56-445a-08ddadc615f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lhIKh8J+nQppa+1nzhE5tBoJHHs5jrFWwipOTT32YOhWLzCFFs2Fr8tFbaGo?=
 =?us-ascii?Q?d5EUmnXGqVKMZ6WIjPk8yGU9CkHfi1DhHyiSSZl1iRxcsH2uJLuOB6ijumVb?=
 =?us-ascii?Q?1nf6+URFcTj/e6EzI2UTINzaDXNyRQahqywtjNw0b09FDYxC+ZvTr64WKeJu?=
 =?us-ascii?Q?7Z6UZX014u9nD3dVYygTS6KHrZZv6MTcguRQMOHmBSj8W+QZYHecRfU9r9OZ?=
 =?us-ascii?Q?fNCsemktdG7ikNOdbOJco/f79kBzZUiAdqo1w2jXzYgcVNyM9P9PioOqhzd/?=
 =?us-ascii?Q?Q6PitDMYeTG78Vf8AI7iwE2PJ9Q7mOcKJEliqhmBE3VqDV9K5zFiMbdQ1uPM?=
 =?us-ascii?Q?q3Q47vmk3yfI/yinbjJAqwpvvzsq6VhaT21VfhAZYXu5z3NG/UMy0fzU6Kdv?=
 =?us-ascii?Q?l4EtRzRABlR/calGEl7gCG3qGDAFa2whlvYCZKVf+UkElJWI9XYQoGaExIC5?=
 =?us-ascii?Q?A5PFmGbuL7u0GUQNJFhyMujcrGnlfO9Gl4gOF3v4/mM488kDwIPoO4VJtznH?=
 =?us-ascii?Q?wDVcfin5Ciedbi2oM4QQx44aRwTRi7flO3+5fSTriAgQIzyYbTku8EWBt1B1?=
 =?us-ascii?Q?fZJMXgBbe826SgYHxEmmjwhOT057veAvcScyvtKJH+YhNCysU93Y0VuwfvUq?=
 =?us-ascii?Q?HNP0/1KuVSv4nFFURNSFiKkheSiH8R/x/nn47ZTF/OmGxAX1Pl+9/MB8nlX7?=
 =?us-ascii?Q?3hm7di12cTSQ7dMY7C4PA2xDHmryVoQGHPQXb0+s/uGbgNNcrmqSLVp/KmVX?=
 =?us-ascii?Q?13CSFQkzauNlTO0tzDLl4mbC0xY/oW7GjRQqGKt0bbXpSs8WVaZVaWeYAZCj?=
 =?us-ascii?Q?GdoOmzMM9rp4NeqY4biAhnDnmDK4jAW//PDOjIxHXYCVMUXrTBFD96iZsVxP?=
 =?us-ascii?Q?9avqDy4vEyNRnBAzFaqKTZYjSW2q2nF8x/dwSk0lojj+RgCb4ZbExaF8YNW5?=
 =?us-ascii?Q?P1fQ9w5qW/Ym1LtroNuA+t50/RKmD2V7XkrgvrYmcmlPWg+4N41Kf8JqXlxd?=
 =?us-ascii?Q?siliXxgo5dS7TD3HpZq1i1GbLieZ/kdmTboOph/gFQmMvG/PbFgQa6VUnFx3?=
 =?us-ascii?Q?DoFIsSK5RxkLEC93jxFxf/z1/9w7E6AlWkqqcC5luLtwuIXEu5wFT1/qE1xv?=
 =?us-ascii?Q?cMc7W84eIQsfeHnTMT/Zs0zzWWvSs4JXZHnJZ1u7U54APQixzHODp+wu2QyD?=
 =?us-ascii?Q?zEzhqSqqnhyZK8KNn1PJaL2F6P+uTMZDDNVVzq+u6EVjXxH9+5IcHEqF51hX?=
 =?us-ascii?Q?vxPmdJv4w1/V7DtotJJAf+OA5X3T2ZFeRU5S3eA2wp9d0HYoK523lcnYaOuf?=
 =?us-ascii?Q?fxwJKyyvZvzvrVlDeeD1wW0edbpRD8JyHUlCeoCkoKv1GAe0N20mFUQ4Sa7k?=
 =?us-ascii?Q?x2UmFPLoCTXqXsnT9K+AwRAtk0MV7Zw38cvLs2AO1WQuh85Qqh9A6yLdxct/?=
 =?us-ascii?Q?ukVbO8INHQ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z6TdzUdd5VNuF7yNbSIndguiri6xAuAfhMCmnkMQT/M4RljYXFg9zDjYdB8P?=
 =?us-ascii?Q?/rNHgR1HeakjnlK6CobWJoAwZNDoxS3zWR1itImtcttk9o3HHUxTAWBzfPD6?=
 =?us-ascii?Q?lCDNNSLNXsTGcLCP33QLpQC5I/3qMhUudFGxhovkUzHOK7Kj/gSGm5LHi0nZ?=
 =?us-ascii?Q?rvLZ8eiwr9QhjZY/YWFghuR/DzjLLN0yRmSfOD2HhGlE+GCnyWcmmjoioYNw?=
 =?us-ascii?Q?uwk9cqMavqv/3K7CQOsOwn7M86r2KK3EW2pjBClne3+WR0XOFrw5YJAqqHD4?=
 =?us-ascii?Q?YrkVyN5dBzrQ/M+8kjW3buwiYLXFpVg9wKLlQxI7Z4Z1uERRVPyYZ/a8UyNX?=
 =?us-ascii?Q?HWoFyPjpsMFboFcx+O76OTnJ/EChvPMxGWK2JdnpWxePxEMKvz4KDL+U0nlV?=
 =?us-ascii?Q?5fGR84nvqtnOtnskPztdlON15XnXbzh5JYJ+2J/IPRKKOmCn7wGaRFBupL0U?=
 =?us-ascii?Q?5NoyQg/s/bHHCAyi1lGYYWfVPDIWr0xG7ISIEugNXpSM0OyJEKenfLWPSQSI?=
 =?us-ascii?Q?yTvkkRYuZgetaku0UGnT66GOZxaflLztcn85+ya/RNDkVbdA+4aPFz91Hv1m?=
 =?us-ascii?Q?+MYgP7XtoSgRGuEmIK8BtiaVRNILJ9rEpJvo3RKytLn++bluRBz4Ld5wx0f2?=
 =?us-ascii?Q?4RyKnmnUHdz6MUmS/ByANgPT0tNeqxyJkovo6uta5mF2zc2PHoIM+96SXUtC?=
 =?us-ascii?Q?qqyFdSIFPFP6digaHJPYDuop3vfXh65uBIgTiw7PdBcXwi8Op53b7rT9VXQ8?=
 =?us-ascii?Q?d0PQJmJGknXyxYhLqhQtX5kbVDYGoWn88B6/wlQiweCxGMCTRg68gqJU31RP?=
 =?us-ascii?Q?tgZL3kUudDL55weV7hGvXecd8W5u2/dPdfYQ1RoF8us86oy1iLY7SSYCVRxB?=
 =?us-ascii?Q?ENJjBUl/0FA237gdlzgS0dEcpTklnp+kUXTouz2qoz2CJ4FxTYPSxllgT8sC?=
 =?us-ascii?Q?cB2AEwA8aFkLWTeAMfTmKjXoU1Vh5Heboj8irmURedkcpDIe3GqALFjCgMGr?=
 =?us-ascii?Q?2PeAOW+zX0hP+Ah55+KuJX0OzwHbRSO6fOEl/3vusaFaMDwK6qRB32LNWqjf?=
 =?us-ascii?Q?HRtQfvTglO+8I7bnhxkp9LnxXN+q5v5CcZZG65az6iXrRwG+MFKws6yt628o?=
 =?us-ascii?Q?M7i7tsquNrc7rScIZ1F3oNnA2sONr7QagNaGn0M1haVi4JlbdQICNbuo3WNn?=
 =?us-ascii?Q?9xqCFsayZLtye1yhLZbNzHvaHv/27LVCsLzCPEgZ2BxCtgzKYr+K5MR0YgcF?=
 =?us-ascii?Q?tywC52F6n3LL6L6pDtk25YMeQ5fuZw/8EQzfN31HnPExFdBuyloxuT2h9vkK?=
 =?us-ascii?Q?/Je/Ag1kEUmM6gotIHW6QvqQ7msxHOTbCOrrfje0UxwaL1Wm5CkS+BJobAMC?=
 =?us-ascii?Q?y0rgCby68fIE5UziJc6wCEawm8UMFSESmmG0EUnEEints7Pj/wUjW3XhkCe2?=
 =?us-ascii?Q?N/V9HyJ9ySUoIvlnyaXyd13NyjKehLzpUkeH2zAp+LC8V0kukqCPNE7Fee7A?=
 =?us-ascii?Q?sytHB7fvzDRSLKt/Vf4H10NfqLavJh89UlxU7IYSREpHkUQj1xoTahgRRUwa?=
 =?us-ascii?Q?1/2bQdtYBUD1IoMRbv2TGdxM831blgHd5iEBSC0M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1af4eb-b5c5-4d56-445a-08ddadc615f0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 17:40:44.3267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nt9dEOVp+dnql9EGJVUDKEUNdPiSmScxQbqclA8lKbzARc1KcOJgbE6+I6U7Dao8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045

On Mon, Jun 16, 2025 at 11:17:01AM +0300, Leon Romanovsky wrote:
> From: Or Har-Toov <ohartoov@nvidia.com>
> 
> __xa_store() and __xa_erase() were used without holding the proper lock,
> which led to a lockdep warning due to unsafe RCPU usage.
> This patch replaces them with xa_store() and xa_erase(), which perform
> the necessary locking internally.
> 
> =============================
> WARNING: suspicious RCPU usage
> 6.14.0-rc7_for_upstream_debug_2025_03_18_15_01 #1 Not tainted
> -----------------------------
> ./include/linux/xarray.h:1211 suspicious rcu_dereference_protected()
> usage!
> 
> other info that might help us debug this:
> 
> rcu_scheduler_active = 2, debug_locks = 1
> 3 locks held by kworker/u136:0/219:
>     at: process_one_work+0xbe4/0x15f0
>     process_one_work+0x75c/0x15f0
>     pagefault_mr+0x9a5/0x1390 [mlx5_ib]
> 
> stack backtrace:
> CPU: 14 UID: 0 PID: 219 Comm: kworker/u136:0 Not tainted
> 6.14.0-rc7_for_upstream_debug_2025_03_18_15_01 #1
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> Workqueue: mlx5_ib_page_fault mlx5_ib_eqe_pf_action [mlx5_ib]
> Call Trace:

Don't work wrap oops messages.. Ignore the checkpatch thing that tells
you to do that.

Applied to for-rc

Thanks,
Jason

