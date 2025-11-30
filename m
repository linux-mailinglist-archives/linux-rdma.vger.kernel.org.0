Return-Path: <linux-rdma+bounces-14829-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B216EC949B0
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Nov 2025 01:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065853A492D
	for <lists+linux-rdma@lfdr.de>; Sun, 30 Nov 2025 00:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F431A2630;
	Sun, 30 Nov 2025 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bz6Ai3Ly"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010065.outbound.protection.outlook.com [52.101.85.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B49A41;
	Sun, 30 Nov 2025 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764463779; cv=fail; b=HugiqpNhnFsdXGiqxyE9p/K0BEjMd4enaaJQ1unIR4aYy91MqWiHtiiSzM9cdhjoIPWucbKmEE3haC8BycHlss+NPjzQCML0eYpILMsDd/trtrX09CLkKejRHmBwyfOrq6jQmdKqFshNx9E97YcarXA44JRSj+kOZ4lCL9uAVwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764463779; c=relaxed/simple;
	bh=l5hRUU20o8esbkXuZV0k3MTvgkXeMxAsUsEQoEldGV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YIkAbDS2Wm4S/MalN3Xyn/njFDhbGjZrytIvGF+UrwOSHar/eOEhoImpW4vYM4tq8MHAHd+3brKugcL/SJK/dg4eX+wjWFSuTPGz/d0UdPpEP0Xq9QAeVuDsM4SjZRdYmQcxnpSdrmL/ijbLbO79WLpXlBoUo/j0tVLrlY3vm/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bz6Ai3Ly; arc=fail smtp.client-ip=52.101.85.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClHSCl8h6kKovHCnPBlVqiUyhJN+RL3kllOqIOc2QZxuTLgb1RpKfFXO3+tyLJ/Lav/saQSMZFwP53oW+BDtmeJzsSFZZNI/UYpYuZAEX9jTDcnFjvZT97f3xdyDZXzerASM78f4aA+JAeb280Nn1ghzKAanEaQPcqDgGSMX0Pp1T24Es1ba40gYZysOEZgcaPxF3OO3h1zuSMKVT9Yye4lcLhLffUNqmFB76s7fQcIKQktG6v2z4TU3MFiye3O7X/7UUh2CnuAwl7dVQhQ1bAfMFm//qy7QkJ6/tVUyS/eC/1kDUq5mYp/boCE1ywaA3yd3ihueNhWNm/+KNI8SnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8u9s0psK34eFS44lE88D6CpyzpP6MQqUO7MfB8Cc69I=;
 b=c7yx8bjQCvphwmVJyPFY4NCzr3T5xajIFx8DAgnysBaVI5uljbCkQjtJ5ho4EraMXfizpLXcUmeDDH2N8AXR9OOpsVVr5aJ/ZFMBHJfxEQOJRLStjO/pMbUK+MZxgrvRr2D4NaY4D/iPagFfb0vsJPe0imJXs7qrM5tPlS9nPIXofIRacm6PRRMYu8YPeiWkhQJrg5ltKRdyQ7TH6T4O6SDOZncM/toPhuw9Hg9iJZc8/X88APViJOtm9P75L1vVBFNY0cbkhP6BK4Z6uTb4PdqpNsetkK2boMlvbg1P31r/o1dImgksDGhQWizFuMKR+V3cze7xflKggwr5LU3DFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8u9s0psK34eFS44lE88D6CpyzpP6MQqUO7MfB8Cc69I=;
 b=Bz6Ai3LyGat1LnhIwfx3+hbOgUEHFS6PHCRbEnqJEaNhhE46hKaGQZ6kUJq2RwakKvmmQKHCBXNGotFYQTc+etH6+JoI3yo3Lz9Av4ymHPvFJRbYnAghIOHMl/2sXp8Z7pvNEVOpy45kP6j42CDzAe5M/svRWXtTmLVXmIyyZzlia/ge3dv2qOeiGpRNIujDKp8fvzDBpr5KMT+0ekwrt8Rqlkg+FwenpbFC6KmWS6Oqb9+Fut2bvQwO5AScyk0oBEXGTgmktVCQZkLFVLX/1lfq9amxqrmlVav31eN1j1UqDmJ2HKG2KGWlsl/a3vji8gn6wxhARQ3F0amOH3zC1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MW4PR12MB6850.namprd12.prod.outlook.com (2603:10b6:303:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 00:49:35 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 00:49:34 +0000
Date: Sat, 29 Nov 2025 20:49:33 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc: Avihai Horon <avihaih@nvidia.com>, Eli Cohen <eli@mellanox.co.il>,
	Leon Romanovsky <leonro@nvidia.com>,
	Amit Matityahu <mitm@nvidia.com>, patches@lists.linux.dev,
	Roland Dreier <rolandd@cisco.com>, stable@vger.kernel.org,
	syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
Subject: Re: [PATCH] RDMA/cm: Fix leaking the multicast GID table reference
Message-ID: <20251130004933.GA1035120@nvidia.com>
References: <0-v1-4285d070a6b2+20a-rdma_mc_gid_leak_syz_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-4285d070a6b2+20a-rdma_mc_gid_leak_syz_jgg@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::32) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MW4PR12MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d85b5aa-aedd-4c71-6b2e-08de2faa548e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e8wNRI9nT9X6COkKWrRviy0ukFjsOXe+CxzrYyIoeTwQq6ztVgVch1OMxEJB?=
 =?us-ascii?Q?T948Iw1AN6ShURuofTevWU7OvO6m3ZMjVd/9J85ogMkxj2hkoMMpgoayqqvy?=
 =?us-ascii?Q?udcwZsJyAPP8U634R4xHrEXT2ARkkzAFeNxji3r0IJxRoGKNQGQTsxL5OlNL?=
 =?us-ascii?Q?TCuCyhX2cKhzde2jA66QFhO0n6nd3whFJoBZHSDVoq2dLUjtDAU6fkL2KJ+l?=
 =?us-ascii?Q?bSPmO55ZCYhFu23jQyLVZDx3vsRRfzW2pKq1rDHWwAbGEU5+VnP5EA6ia7Y+?=
 =?us-ascii?Q?od+CcgBhN+jqhvBetAQh/crVyzuxJNN6tuFoCBtpXh4tzCh2+Ec4ehiqlXvG?=
 =?us-ascii?Q?kDgdahBPa1tedWrOoOPLby5vrihZu2+rBtgh7cMBkWwbOA4A71ED7Szz03H0?=
 =?us-ascii?Q?QbA/B9ZkF9BYoGk+e/zyQTp0QAAPmeBhDREGhNGaXyFKV1LISVTW6lJ7AVuu?=
 =?us-ascii?Q?EMyid0Up3qmK08gAL04FI9pLaovzZ2sqWt4FYnEtFweU4vNRDRKjPjmVaNJ/?=
 =?us-ascii?Q?HfkLzAQAdLMv8rKAnIhJOOeIo6rHSB9tqV/sCu3idSRYcsx4Tcbp6IG50Ase?=
 =?us-ascii?Q?xQPBa/Tp/Wcd+drKpz/aBJZOrGE6pyNmLjD/b6Y9PrHwU5KMk0R9F51j68/w?=
 =?us-ascii?Q?x7NlnHUP1bDdWj/EPUjoB1Jz0LYXIabQkDdqM949rfdLFgylcMN6b+BOWUGK?=
 =?us-ascii?Q?5QE/YNGyOs97v3eu1SCkz7hABE9QXKHGre4J1YEfpvx4naEqzKSQk5f6UZ78?=
 =?us-ascii?Q?pTgTZ0gSP6Wf8Kr3sUwOXuNrnU+BpWaCr/X5KDa79v5VJ2f27Q0S9Iws2NSK?=
 =?us-ascii?Q?IBV32q26dkQuFqWXyGVKQ+6V0vl3ArgKRdhc7iizSWPiFv7D6ftNpBjKqb+x?=
 =?us-ascii?Q?rAU7t05W1VZO2eLxYnMR3OrPVN0sQW/5f8EFoUa4XJgtribjntsi6a6TeDK5?=
 =?us-ascii?Q?5bvzEhkqm8b3HcLMtXS2Q6V0vZuxqAsLp9rlr1x6V2T+6sb0RVlRkFqzxb6c?=
 =?us-ascii?Q?rtsKtkpBSNLTuI+LAsctctIclS7WK/oHd1w5lXuUvo8WBrASBS2Swc6bH02+?=
 =?us-ascii?Q?0w4DrIL7snguD7YZ+iYMTCTfH/vd6RmkcG9tqoA5wkIlc5owAdxD0wxdske5?=
 =?us-ascii?Q?/Q8gQKoUNRqFLeUuf+N5gVT1qdB3j1k8xbWHAY+r1heaGptA63R+edEahqrk?=
 =?us-ascii?Q?nN7xvcFtNHyyg4PO78VcxSweZn2oQC27fCfVygXClZdt4YOZ8EIVkCt16yka?=
 =?us-ascii?Q?lgRUspvodfebA59R6p+9pVmsoyCxmh8vAovfMMgHPRY5lDJR7OC8YfWXKD1p?=
 =?us-ascii?Q?SkSgKvQJ0fjEmoZ8O2/mG0vhC4k0KlIjj2maSZ2D9h1o5P4ZKLI6gk3h9NFh?=
 =?us-ascii?Q?nO9OeVexamwZhA/qVxXsewC2FVKi63pxPnvSzBurz6Mc9MrrJwFnzIgD1JvD?=
 =?us-ascii?Q?qpsFU1BCUN1fAR7AIwbA9RfHFxe7vMYgJ6znt0c7eNGLqpmepyGNCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hVPqEkaoVBYfWfx7VX4mN35ivaU9iMZ7TNjKtGlmsWnHgXwjJFhu2sDrt5S7?=
 =?us-ascii?Q?QGCk9oITR5V74f9uOT+RFL57W+N1J4c5qUgKvASoyRN7/9WefwMkPcEKM7BK?=
 =?us-ascii?Q?BKYQoelvgB6L6/SgRadw2P1aWTPFvwgiiR5afZAt+e4xGxmkbeO4GNizhY5K?=
 =?us-ascii?Q?0/MJ4tughlHDqin37ndaH79OkR9NqnJtCh8J0rZZyWOCy7RBE4VLgiLrfeGN?=
 =?us-ascii?Q?vhZezfrzj90J/C8FUVC7QPyOOv7SE4w+0Ad45Va3T+jJKrYLAR3MZArOtqK4?=
 =?us-ascii?Q?I7dwgqgKYqlD5AJsHzQEIfUhlgA31gE95Eoo9IXKKHMdXOGtJ3xSuHaZ1rzA?=
 =?us-ascii?Q?Dn0FqXMvcR0Qksvf2Nk9SfTb3cpMK6b/JjDj5XZOAmYS/FPpvUhv0+uxVpwI?=
 =?us-ascii?Q?CnBHbQCg4XSARH8QFs3PWTvwGAK97PHVsMcAhlOeHJ5BHQVaUFKFJQX8TBFy?=
 =?us-ascii?Q?gaYf/paE416XlGAAomaZLe7O3mcE/ZJmmZzyWZDRaxwlVQ88dzsQGxE9aJtO?=
 =?us-ascii?Q?o1/9X//OYc5CJa4jWyDe8TSYwQBmTTGSys3IXR/mHitJOszc7LQvtm3v9Vh7?=
 =?us-ascii?Q?ctdVPsY4ZjC6EJgSZy3lUXGA3YWkFnX3CrHUDv1RH1zfYRMk+wW1xrknkRB4?=
 =?us-ascii?Q?Z8dKP5zLA98ke7aXRZ4fVEoHj4KGJcXMhiLGwmcwVSNa3iG5M7azxfiKkkwB?=
 =?us-ascii?Q?L9RfIgHO7IxBT8YsA3enBDUW2yR/Ihu/KI9u7kEqBZssARnmSE86vniCdW9z?=
 =?us-ascii?Q?F1xKksQXv7Fp9i/1jycNILZAwxFPxYq/D80x11nXKgn0DBQTZhncmJboJCMb?=
 =?us-ascii?Q?p/y61r4PkGuIcY5d5k50G+3AlZ4fYoOk0DUb9gvveyn1TV6gfIP7ecS55ahz?=
 =?us-ascii?Q?2unfY7qeP2uoaUSXn9xdjs19HbCfws2gXaJ3YmNXCk26g7vC3LeTFHPiypI9?=
 =?us-ascii?Q?g26CEMMcwVCDUf0qtLumecWM++Q8Mt1PYK+7HCo2UWYmEUtrl23wf0hi0go5?=
 =?us-ascii?Q?8242c+0laYhXmB9St9WguQ7nh/0dHxPRIKB4fB4ftKFVSERjJru7pgqT/vMY?=
 =?us-ascii?Q?Ep3BRrbREN096CN3lHLpGfZSKmgVOSjbiNStAWjIvEGP/2vtV7RWf4FmEb1F?=
 =?us-ascii?Q?yrnX/scU+4KJhR0CVxNmshuQ3+QD79644bqhltWW8nM1LKSF0ha8b//emmSC?=
 =?us-ascii?Q?Q8lxEc9LpngW+QZXkqNQHRsQ8R9MpCzL+XQ6A8pqefM1hAIoq3GTMdv9lRtX?=
 =?us-ascii?Q?XtAvCwJSwrPXkALkLR84t5jClRL+E7bBwErpoRx3SlxO+Zz+jgai+CWwyV92?=
 =?us-ascii?Q?IE9vCQw3SkQZWR+KMeRDNu+11Yqi97qcpWOCr/jCVWFw0xia2aFoaKD4nByP?=
 =?us-ascii?Q?Xu7+8X8aP8oX6nH3Sl9oNCbFACqmaPsskd4scMt5ca3a0dpwZ3oZqUdql01R?=
 =?us-ascii?Q?F15G7syzpWUM2l3/jnuX1wQU+coeYjwIFu6qm7EJdRIyPhw7d5sKkEgFe34n?=
 =?us-ascii?Q?GnM99fDPYi0gmvIPMyYfFTKNub0eHEQvkHVm5HWABx4C3/HQtD3C6SsnmFtT?=
 =?us-ascii?Q?zcDczao+bWoyCt+5kbg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d85b5aa-aedd-4c71-6b2e-08de2faa548e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 00:49:34.6847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anTfEznb19K0arzgxm3Wuo5ivw6vYe5gqRsHhf3B832t9XzT7+x9nYm5PeX1j0Wl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6850

On Fri, Nov 28, 2025 at 08:53:21PM -0400, Jason Gunthorpe wrote:
> If the CM ID is destroyed while the CM event for multicast creating is
> still queued the cancel_work_sync() will prevent the work from running
> which also prevents destroying the ah_attr. This leaks a refcount and
> triggers a WARN:
> 
>    GID entry ref leak for dev syz1 index 2 ref=573
>    WARNING: CPU: 1 PID: 655 at drivers/infiniband/core/cache.c:809 release_gid_table drivers/infiniband/core/cache.c:806 [inline]
>    WARNING: CPU: 1 PID: 655 at drivers/infiniband/core/cache.c:809 gid_table_release_one+0x284/0x3cc drivers/infiniband/core/cache.c:886
> 
> Destroy the ah_attr after canceling the work, it is safe to call this
> twice.
> 
> Cc: stable@vger.kernel.org
> Fixes: fe454dc31e84 ("RDMA/ucma: Fix use-after-free bug in ucma_create_uevent")
> Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68232e7b.050a0220.f2294.09f6.GAE@google.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/cma.c | 2 ++
>  1 file changed, 2 insertions(+)

Bah, a hunk got lost, it should be like this:

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 95e89f5c147c2c..f00f1d3fbd9c53 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2009,6 +2009,7 @@ static void destroy_mc(struct rdma_id_private *id_priv,
 		ib_sa_free_multicast(mc->sa_mc);
 
 	if (rdma_protocol_roce(id_priv->id.device, id_priv->id.port_num)) {
+		struct rdma_cm_event *event = &mc->iboe_join.event;
 		struct rdma_dev_addr *dev_addr =
 			&id_priv->id.route.addr.dev_addr;
 		struct net_device *ndev = NULL;
@@ -2031,6 +2032,8 @@ static void destroy_mc(struct rdma_id_private *id_priv,
 		dev_put(ndev);
 
 		cancel_work_sync(&mc->iboe_join.work);
+		if (event->event == RDMA_CM_EVENT_MULTICAST_JOIN)
+			rdma_destroy_ah_attr(&event->param.ud.ah_attr);
 	}
 	kfree(mc);
 }

