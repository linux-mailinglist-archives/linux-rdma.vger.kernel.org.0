Return-Path: <linux-rdma+bounces-21838-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2vetC7vDImqOdQEAu9opvQ
	(envelope-from <linux-rdma+bounces-21838-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 14:40:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE656483E7
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 14:40:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=arCMWo1Z;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21838-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21838-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64A9C3026C19
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 12:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7D23314B9;
	Fri,  5 Jun 2026 12:26:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796CA18C332;
	Fri,  5 Jun 2026 12:26:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662369; cv=fail; b=WsIs1hh0aDRaBA28DMzZuXvicHZ64OcYTSX9i7FUa7sqbrXFRTRVxJGakcZEBANOFxZrx95h75TdK8FvhwZ+LP8N+xyzdSEtwvFUucSGI658CFfpJSSxdW94RZ5AjmYPFojReiWKjoMr+6/gaAnPI5x7eVNc6Cllz9SRb818lBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662369; c=relaxed/simple;
	bh=Gp7KEKgeSASYU8YZhTqxHiQBu/QNReWMtTFyVLgNav4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FxJzO1By0wDD/SP2KvSHr2aVofObETSxWc7MygU6hPY1U0txNpflrD510Dze6XRkPTPk8wI+Lkh5cguUYIaCcoJcVe3yZ56CAIa09pBJaMV2PPclxF9mh001UsVuL0Gaq6zzktCurVUyi/NRtDd/LnqI/NYsrfU9+z6put/oiII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=arCMWo1Z; arc=fail smtp.client-ip=52.101.46.31
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WAZQo4m7iWRxeE94ct8JCP/EDybvqTT8aZVcycLOHJ1u5/XMYCH2gTyL/tBbdD62nGjCTQatNiE1Iffd7G6GrW5lERI2reveRk8exgWZBlekOcb7O70axuFNxHF5iqfldtBwtpAx7sGFTWiiMPjwbxbXT11LEcEGcPsGsAas5Hbq/2SLNwkGdpSYP0DxWE4VRdig+U8q+S9I3/xvhhMa2Y9H6bsTPiRsNw1OMELgcflJvkt0lFPye6C45BIzxZTtzDLxB7f+P+fBQAk7AV43uvxMPCk3ZD5LBTs2BXv8HUVz+cy+Uq+XQm3uCTkrm/9XmS4X5jr8Xf/CGPhFJoVQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEFUjfonEE2/lfdeHQE3RBb74UedUYwClCem7I76Qew=;
 b=UbcFxKXJgEMqF5IOPA2zDXmX7KUo6gWnlWJC5sNFadicPXftOFzehYA3HiIp1eumXiy3J/h2B5zP7jUYhG9f9ojBNZ+/WCIGESHI9/xg/tGXHmUGlT7Jj/Z0AKgibQrec612RpO7WgO4lhYF224l2q0aVLHzs0o69aRLdNvu4316hq2jQNUeB1BogLlPrGuEto9cWYWuvcUP1BrLH4Z+IhTGybIC59suMywUnjU88oSQhH9A/Cy3iDWz5F8EB05OFJbtbCVQP/igzYsJeSkvi9Seue21bf8VBWjO85wcdvJc9zZSS3NS+Q7pkUInPWPTGRpHiKP1x8vV4DEMOety5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEFUjfonEE2/lfdeHQE3RBb74UedUYwClCem7I76Qew=;
 b=arCMWo1Zndgq9UPS3egtqBDaZIddp6rBeHToF+/75L7bJHVmUduSlJugj+2VzE3wuZYe1YBHVygH1JDsMVgxOpGwBidvc2CkxO18QtAQKhL4KckNwi17q9d7QhnB0oQo2hYdfSrLrXykVqwvFhB5HbW4SpowIeJmLevO8oGwPncGrax+HnsDMhK6Fx83c0vG7MHuKjh/taeUYYiKuCS7PO4jyJR29Tsk1Z6OdIQ9lCuPpMlj9weO9Z9y/2DUfAoOLCbvGkPwlKwVgeb1JYqdAFAcHLMPN0FF2Y5N7rzj6WLTec7PAYraZd3SYteWfyjcBBotFSxzbVHXRN98Cy70sQ==
Received: from BY3PR05CA0002.namprd05.prod.outlook.com (2603:10b6:a03:254::7)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 12:25:57 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::58) by BY3PR05CA0002.outlook.office365.com
 (2603:10b6:a03:254::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 12:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 12:25:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Jun
 2026 05:25:42 -0700
Received: from [10.221.193.185] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Jun
 2026 05:25:36 -0700
Message-ID: <086e79e1-12df-418f-8be4-a53e1081fab7@nvidia.com>
Date: Fri, 5 Jun 2026 15:25:27 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net/mlx5: Use effective affinity mask for IRQ
 selection
To: Fushuai Wang <fushuai.wang@linux.dev>, <saeedm@nvidia.com>,
	<leon@kernel.org>, <tariqt@nvidia.com>, <mbloch@nvidia.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <parav@nvidia.com>,
	<moshe@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <wangfushuai@baidu.com>
References: <20260605102112.91772-1-fushuai.wang@linux.dev>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260605102112.91772-1-fushuai.wang@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: b78e1998-2b67-422f-d469-08dec2fd986c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|22082099003|13003099007|18002099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	bEpUdhzgSVV0HT+v5P7l/ut7k5FnEip4Zy2M60Ma3jMoSUrUH0Gd0/iut5H/nCj001Yj2aAxKr6vV825gs5S6MNcNKyou7s2W1oLXUOKJqkQxWJoT+kq4N1iKp8MCUhpzGdxQzFPY7XAj5BF0EyQmJco3EJJpz/QHrJeIOc4GUpu72G8Y5tWD0FWyKnUW2pfGJZUGT6JETMmJ9ob38HagwcaHt/j4GRqk8IO4HJqRQFwwETkBxzMX1OG0AlvemeD7bnbNrs4mtuZ+8xc4Km0mF0LlrtYNkaCPQsSVC4WUHMInFmmLAJuOPPNMf0KLA0GsBWd9Q4Sx9rP2GMGGFXmIvpOcsY1msl7qbhwrOdRO9pOD9l6PXj7wG3Kl9bPFYcVFRv+kfpAF1MZw8rlv3EHRQ8ku3HL38Vf7OZy7OwK+G4JOm5QTOTkWTdikxgznNugfTuXCTz9+STidB71Qyv3tVoEgxlALeF7iOfBv1vvu+XhhtzZiLOVm+vr/Z7aLbAxq1ZeSYNPJFRUqwDFbjR8UCT04yY9MTw6ezKXV8eq3buOn1lMNwgvDHUKD3wn8DkFvqf5VoljpNqMKHb70rKJsVLMwqMuKP2T4QZgPUhjJTn9/syuC7mOkbONY5nz+TN8ZaNQRwheOD60TqPPYl4agUf1YNIvFbX5kj05va8mZTSVfNFPLrewpclQl2BJ1DkRquV/9i5zMVQNJBWnwFCuQOB/xlvu3ucdqkTjUTJKv4GgXnXNxFBcaHxarZzmGRn10/3RUPZbzoEatTEoa/e+X4IY9eNxGEhLOjSasX6XrDM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(22082099003)(13003099007)(18002099003)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ByFBiZLLu3j5Seqf0zdogkdWHY0doR2jOBvzpfWXEGOvZWKDfJYwvsXOd4/q0ieVMvhWYEKHte9mBnZH1tAO19tEGbtoiFXRk/1Fp6OIx/Sipt8rDPAfbZgMU8iXZsCoYJBmsOFevPgvq/7LQ4UFp5R20OAzSnBIADA5HOm0UiesNyDHfqY4ED1dO3QnIyUOmPqmcTk3W7MyFJxoT97R4ZoHrnNemI0vZ2hOy8oG91Mx61zpPPKaWwNESJuJARfFUXnVOrSknbhlYTAKJKLngQMPmjXp8Obl6t6z5UtwVdx8KMKwy+9RbYp3IcuUbX+2iTv3Fydpqg8NVpPMuwZJQfhVpaYIrYLArT3rL3xw3vnbRZYY2+lytD6fJg7ZmB+XJHczhtnLmBTwTo1YMGARvO5Moio2MjpELtE7/2hKD87elaY/KasAsiUhnZ57VrM/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 12:25:57.2516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b78e1998-2b67-422f-d469-08dec2fd986c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-21838-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fushuai.wang@linux.dev,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:parav@nvidia.com,m:moshe@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:wangfushuai@baidu.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EE656483E7



On 05/06/2026 13:21, Fushuai Wang wrote:
> External email: Use caution opening links or attachments
> 
> 
> From: Fushuai Wang <wangfushuai@baidu.com>
> 
> When a sf is created after a CPU has been taken offline, the IRQ pool may
> contain IRQs with affinity masks that include the offline CPU. Since only
> online CPUs should be considered for IRQ placement, cpumask_subset() check
> would fail because the iter_mask contains offline CPUs that are not present
> in req_mask, causing sf creation to fail.
> 
> This is an example:
>    1. When mlx5 driver loads, it initializes the IRQ pools.
>       For sf_ctrl_pool with ≤64 sf:
>       - xa_num_irqs = {N, N} (There is only one slot)
>    2. When the first SF is created:
>       - The ctrl IRQ is allocated with mask=cpu_online_mask={0-191}
>    2. We take CPU 20 offline
>    3. Existing ctl irq still have mask={0-191}
>    4. Create a new SF:
>       - req_mask={0-19,21-191}
>       - iter_mask={0-191}
>       - {0-191} is NOT a subset of {0-19,21-191}
>       - least_loaded_irq=NULL
>    5. Try to allocate a new irq via irq_pool_request_irq()
>    6. xa_alloc() fails because the pool is full(There is only one slot)
>    7. sf creation fails with error
> 
> Use irq_get_effective_affinity_mask() instead, which returns the IRQ's
> actual effective affinity that already excludes offline CPUs.
> 
> Fixes: 061f5b23588a ("net/mlx5: SF, Use all available cpu for setting cpu affinity")
> Suggested-by: Shay Drory <shayd@nvidia.com>

Reviewed-by: Shay Drory <shayd@nvidia.com>

> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
> v2->v3: Separate the patchset to two patches, reverse xmas tree coding style fix.
> v1->v2: Use mlx5_irq_get_affinity_mask() api
> 
> previous discussion:
> https://lore.kernel.org/all/20260603072657.10868-1-fushuai.wang@linux.dev/T/#u
> https://lore.kernel.org/all/20260604125705.21241-1-fushuai.wang@linux.dev/T/#u
> 
>   drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> index 994fe83da4be..a0bb8ee44e35 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> @@ -105,9 +105,12 @@ irq_pool_find_least_loaded(struct mlx5_irq_pool *pool, const struct cpumask *req
> 
>          lockdep_assert_held(&pool->lock);
>          xa_for_each_range(&pool->irqs, index, iter, start, end) {
> -               struct cpumask *iter_mask = mlx5_irq_get_affinity_mask(iter);
>                  int iter_refcount = mlx5_irq_read_locked(iter);
> +               const struct cpumask *iter_mask;
> 
> +               iter_mask = irq_get_effective_affinity_mask(mlx5_irq_get_irq(iter));
> +               if (!iter_mask)
> +                       continue;
>                  if (!cpumask_subset(iter_mask, req_mask))
>                          /* skip IRQs with a mask which is not subset of req_mask */
>                          continue;
> --
> 2.36.1
> 


