Return-Path: <linux-rdma+bounces-21823-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eEvYHtVsImolXAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21823-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 08:29:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D377D64581F
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 08:29:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ONzkaZ4w;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21823-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21823-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6C8A302417F
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 06:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AAD405C37;
	Fri,  5 Jun 2026 06:25:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6153D18BC3B;
	Fri,  5 Jun 2026 06:25:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780640750; cv=fail; b=Heo6ESqh+aDz564mjiWSvjJyJW/rEg5tcJozr3Ac9Y6dyCdEoBCskiekksyJppt5jpSxJGrSVgzOUSPJ2C4DFmg+4Ao/CaLAw1sM5901tKVzk7fjDuhN+bvbKOVe7AiDezwttSYmS4ZtimTHl9PvkTuVQE2Z/HXt6rwDl0lcucY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780640750; c=relaxed/simple;
	bh=ogGEysa2fUtxJplnYerIRD6NLRnamJLsg9DjSA6IwoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V1waBDKgHDAjcookKhQ+U9FSRAbiPOYEuHwgzT6cmtjvACBwJgFGVtpmb6m0kxR7kOpczMAkFYWQVsINo2a4FGyEVBvQz4jJZypZoEtj4GNfvV5aIgLjuF2rHD03G3yq44ydrMGsBuJyzI9RGlQb08XhFy3mmGw13dneRSs3DnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ONzkaZ4w; arc=fail smtp.client-ip=52.101.52.61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKKWXW1EQ2Ns6BsB0pmfZ7pt4kC3DEfT29466NQiA48auq5dcvea16ezL5Y4BzN38knrPJ9hzxqhWJmVdkCTXgPUlibjKWcoLO2HH4uiDOsCCnt0WC4kt85dbGrhVQCqde3R/YwzGPYv5qBhK88wrtkOCQwX/99a6Oe04bgXPSPMuac3LN8uvrHm+xZhcsxVLQazf84AVWF9Vis2gXpG1iMhwYJQWt6LB5t5ISPR3qDO20P8KXybR0QEz3LxLSppV5HVPtFAtzKyIEd2BAEKIlwVqrYRJ8N9ZsV/RJ20Yb8PKW+iyS/jcwYekAN+MoqEH6LNDfUBBBr7XY0TvsI3sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOoG81cKD0tBLYE/Mdnyi9yqD+np+6gLOeZDkWeUIu8=;
 b=fhkIxBSEu1S01lAu5Tb2M4RbNZFb+RtDRDgtCejVtdUloiAtAcM5jCceTtwaWU/e76wB9JNLh8UJjJnwzIhhfqU526zuMhLFtBA9Bqh+D7CEVx7En+ZVYAllsmbv21HnSY675eJYHGPst52YS7eMQhKPuGrDZruA9jiPXoEiDd0Ppgldz/pz1pqZgbxZjI9MosOEKX6l1GjwWpu7w61RpzBFqvYoC1k7rSJLoYIaaey1ohUjXPre66jYIz+TzaYeLKMHMSwQ9gwwNuHPrma8k+DRhTmXbL8Ge4PDWBoBhMvTJzoolBZjuN8IKC0U71RWySInv8Zt4VcXFMBOhPx1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOoG81cKD0tBLYE/Mdnyi9yqD+np+6gLOeZDkWeUIu8=;
 b=ONzkaZ4wEsgpE30xP71NTK3LSVB+Idp6owF7RYWI/C7n/3akw0GMhqi5PNmXvGgzXivTJ9i0bcx2QmTFI/RRbA0KaWQW5w7aypDUDwIJ71hG94gPk7jjgUHWfEHRMEINxGus2gABuCl1d4vidoVLPLbShuv2QUtsusprM4xyIR6kIMXcTMkfG/wNdOWFitFzJ8RPZ9Jzz9GCpJuVyJAyV01xtPUJbldWi9yGPFWndOEJqB2+tIfAN6j3MUIg/sdTkY9BevG2HN4Rh46O4ZtUB4u0o9spNkro2eIGRyblHpCXa5OyatjHkl7y9a7Z8V7qCBAePLPxp6MEemwhJ9O/Ug==
Received: from CH0PR03CA0333.namprd03.prod.outlook.com (2603:10b6:610:11a::7)
 by CH2PR12MB4086.namprd12.prod.outlook.com (2603:10b6:610:7c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 5 Jun 2026
 06:25:42 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::29) by CH0PR03CA0333.outlook.office365.com
 (2603:10b6:610:11a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 06:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 06:25:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 23:25:27 -0700
Received: from [10.221.193.185] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 23:25:22 -0700
Message-ID: <aa1e6365-3c75-4f0d-915f-9a2fbaa2c158@nvidia.com>
Date: Fri, 5 Jun 2026 09:25:14 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] net/mlx5: Use effective affinity mask for IRQ
 selection
To: Fushuai Wang <fushuai.wang@linux.dev>, <saeedm@nvidia.com>,
	<leon@kernel.org>, <tariqt@nvidia.com>, <mbloch@nvidia.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <parav@nvidia.com>,
	<moshe@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <wangfushuai@baidu.com>
References: <20260604125705.21241-1-fushuai.wang@linux.dev>
 <20260604125705.21241-3-fushuai.wang@linux.dev>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260604125705.21241-3-fushuai.wang@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|CH2PR12MB4086:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f193625-0ca4-47c4-03e7-08dec2cb4456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|82310400026|1800799024|921020|56012099006|22082099003|4143699003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	KjL/tmcbU133hD+qZQDLGq673OCt1qBORByH0JD11tZEvSQJ85XRJY+p8VpyLVWGhvX8LqFK2Qa/NoXs8CjPqIdAlPKmgFo0wf1Iy83txAXMfMcynrGqAkXa5XNNijl2HxS0WfhhwWrTwM4f/qapV91qe305F1pZ2uKD1m494BxEsXd9Rez/ZKt8qEPOCcpqIj5RtJjstHiJHfCZFnrPC4QRoYDqQBe+acZyLO3eO98bO6r0Wsue4gHcTt/A5liQgoi2hudWha6v+hXc3ypmoQwTvmL6Lrv2aI7ljSLILxHB8XfXDmeYHuGmYG3DO5l43UaSSf7UeQacd9QJXH1Bp7X6/e04XhM+9LYgyfFofoZrBbA9SEkwN3dJG8T1jfwKTvvH7YCCN00NcAboB+9/fN89ymn8FDRikxcnrYBcI65xRqGmPcmpyjh2Grgz2t85o+LsUUcfAph7/AI/wRl2aQy1AK7eQRJbuqbxFdZ7QJDUdL/9jEfq45Hr5hqFx0ulbSpXC6nCjzcP/4g4VGN0ivFDcJRqe8eAsfU7EW3gKW6EcGwAa/wFjZQzK/1VYH3pb1QGyPZWZ6wRfeGJSXgCGrpV7T3wU6G8lyxvM0keOdzN6rEx0WF/VWrd+g8bsFvXFysQ79xm2a78T0ZUArKYoT2BEBZeHC2Im3jEnvcUIYxLMJwz5/ZB932h2wgP1aINLRvZIqzFvHhjM1F/w9Ic/pkJQXkOQycjiXU3sD6WmIWvyuQuA6CelYXZS07uv4cxnDpUSD5voWXf/+9pXZm/zA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(82310400026)(1800799024)(921020)(56012099006)(22082099003)(4143699003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ubZ9qxf8jqE8R6jqk1neknMULx+icEpQ4PQYMfoAGasZEZATutYZ4170snt6LXnFbgwrO6xTz3sOiLNHSyZfVkIXaHciw/ilhOS3Js3dJTY3Ge4TN9y9Vaacah9M4jjg5OOAjvgoTAEbnmwiEOcsSBLbP81+a0mLC0PKKx9loNGOnCokDvX8ytRmUASYNqQL8zK+RAXR7YL/OJ8O7H2tfutyFDiDVCQr3tINT6s3sN0v7w68izHreZRt2yy/e7Hyr+vFJ825fo7wBcd3FitV4IQhYLSdw2UtznrWIc3dMFZZUT49dpTSBJmxpnLl/AY/B1SSxb3yfIPv5dwV6+d8CXzZmQI8e/1kXeOFCiAn6fXhgbnv4hW9S+9aQ/LFurgXndvlqcmqUGPwEYFFWA2eLM8QshJebYve3Pm6rs+UDunzw9dgUWKs4Gbie/B9mClV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 06:25:41.2433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f193625-0ca4-47c4-03e7-08dec2cb4456
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4086
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
	TAGGED_FROM(0.00)[bounces-21823-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fushuai.wang@linux.dev,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:parav@nvidia.com,m:moshe@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:wangfushuai@baidu.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email];
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
X-Rspamd-Queue-Id: D377D64581F



On 04/06/2026 15:57, Fushuai Wang wrote:
> External email: Use caution opening links or attachments
> 
> 
> From: Fushuai Wang <wangfushuai@baidu.com>
> 
> When an SF is created after a CPU has been taken offline, the IRQ pool may
> contain IRQs with affinity masks that include the offline CPU. Since only
> online CPUs should be considered for IRQ placement, cpumask_subset() check
> would fail because the iter_mask contains offline CPUs that are not present
> in req_mask, causing SF creation to fail.

can you please add the example/repro from the prev discussion?
Sorry I wasn't clear I want it the commit message...

> 
> Use irq_get_effective_affinity_mask() instead, which returns the IRQ's
> actual effective affinity that already excludes offline CPUs.
> 
> Fixes: 061f5b23588a ("net/mlx5: SF, Use all available cpu for setting cpu affinity")
> Suggested-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> index 994fe83da4be..c5d784cbc8e4 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> @@ -105,9 +105,12 @@ irq_pool_find_least_loaded(struct mlx5_irq_pool *pool, const struct cpumask *req
> 
>          lockdep_assert_held(&pool->lock);
>          xa_for_each_range(&pool->irqs, index, iter, start, end) {
> -               struct cpumask *iter_mask = mlx5_irq_get_affinity_mask(iter);
> +               const struct cpumask *iter_mask;
>                  int iter_refcount = mlx5_irq_read_locked(iter);

can you please keep revers xmas tree here as well?

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


