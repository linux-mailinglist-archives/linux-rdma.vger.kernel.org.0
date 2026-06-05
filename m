Return-Path: <linux-rdma+bounces-21822-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wa8BBc9rImrdWwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21822-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 08:25:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 051A764579F
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 08:25:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=X5CtbpgR;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21822-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21822-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F286301053A
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 06:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FF6403E93;
	Fri,  5 Jun 2026 06:25:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388DF3D9021;
	Fri,  5 Jun 2026 06:25:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780640709; cv=fail; b=Di4+OANlQ9+aJY4TPxQkV0TzO8UtXg5/+0KuG4HVn1Qr1eYKNEo1jygC41BWh3u47sldBrUBQ51JbrqSsogy1SgL8A1QYzolKyPQLfCVzGHjUhUg0d4GtW7Kg3Ds/QpruZ7gnoTMV+5NGZAzFwQVUnbZt/U+1DQRP6s1SIM8Tl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780640709; c=relaxed/simple;
	bh=908YnARpC4nInlKSTzfiUyiGSnCABkxSMxCrmZy6+Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y9wcm7SdIgTClC/QiqhDfsyTfF88qMb5Fl8zVNTIUgD51vJ3UaBE61iWFsJSgxdCFlmd2wFbxy6ZDnwKJdmN+zi1pB1WAgTWRgG3jzFGwTAIQeORzgwdAOuD3Yd0Qfkx4YthxCRNx5IAWY3pface++mFigk+pWQZGRXHAadBbRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X5CtbpgR; arc=fail smtp.client-ip=52.101.53.42
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1En7l3j1MpSPf0wHE1xSycfk0UeBoKS4v5ul2EORVRhhFki7NrHOu7DUdFHcgOC/BdEJSK+1VGg8VydwqazdOoOYVVdxfFp0dOIwEu2XQ/4yD4Oh3T/Td38LbsXYdBcayDFv+doZSlt/EbfQ5BvSvremUstk6h9tU4aM4BprSZLY9BydaTfvZ4D9D3VHM9DyMFPPX4bXkeXxT/Oh7jRVNRuLrq4t1lzrnnaJzlWp8yHmS5BhEMXfgUZNzPqo4EKa86vUnGRe9g+KZ0R/Cy/+cHkJGpT+XvDAp39Lr1H808Xr3ZkcXtWPYLoQzLtA7ET016Wh1e5JDgDiiqsA9BSYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylryRy2+fxB6xii+sJXf+jiX49I4uFmkq0P1J8axuZM=;
 b=kX9m04879/Pjbpk6TOD8CVUMoYUgKWu3CxCMkdNt5sR8N1GQ1QVXjvdYrwWwCjkFf06Cfk4ds10LWPGJXgOzWg0QDp3Cjh3fa3zHr0yUWozQ+/4uKWlY6rZSTkb4PDZ5G4GMTakB6wKj/oCVio6B3hM6HInxAmR9tTHvBDacHhgZFXkj4beiIMEmlU+7nUw3bDuHFu2ifS0Ig9S4Ndu6ZEbr5LixdcVlhLKwbZAo6O+EHZeeibOxKIi7TGXfM7nvWRjeHxco0HP75eyn5J0vlBA84Jzein9kFnR/tEMGQ5hVFkk2gmPPe0IHe8QlicmoeBAqCMu+bO4aa4ET1tAjUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylryRy2+fxB6xii+sJXf+jiX49I4uFmkq0P1J8axuZM=;
 b=X5CtbpgRp80+mkcK/5zbYMeLynlWczSqwhLHobgxcY1DRmjXaHFYhD/a8n2oMQuJ1b/YXWl2kEucsSlN83wFx6BBzd3byh0oaPri4w0MD9pfqqmRprM5D+v9ffqBMDL36IC7ls1hChQvY16jDn8vU4+o82GpuYdZm2hJGvqoEgFCBGo+bw8tkhHYEgTQdIaXRtfjyo22kxeHTclEaTo/3sZfmGKS7qpShvWeJdmCLhCJ/1nkz0cPSxCvkZB+VGcyy19T48iIb6rfGLzQGwoui7FOvWQnlZl96HqwLbcGmEDqV38sa5DKKsgebzTbkS3C3/nY1IkEzuIK1aVrGzowqA==
Received: from CH5P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::28)
 by CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 06:25:03 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::aa) by CH5P222CA0010.outlook.office365.com
 (2603:10b6:610:1ee::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 06:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 06:25:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 23:24:48 -0700
Received: from [10.221.193.185] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Jun
 2026 23:24:43 -0700
Message-ID: <32b91cc1-ab63-4fee-a65e-6dcce4a49970@nvidia.com>
Date: Fri, 5 Jun 2026 09:24:39 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] net/mlx5: Only consider online CPUs in affinity
 subset check
To: Fushuai Wang <fushuai.wang@linux.dev>, <saeedm@nvidia.com>,
	<leon@kernel.org>, <tariqt@nvidia.com>, <mbloch@nvidia.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <parav@nvidia.com>,
	<moshe@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <wangfushuai@baidu.com>
References: <20260604125705.21241-1-fushuai.wang@linux.dev>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260604125705.21241-1-fushuai.wang@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: a48f39fa-12e5-43ca-0cc7-08dec2cb2d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|921020|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+Dd6QV877do3/fhLzGkFBn1ZaxLzKWdju2eIEs0Cuax7h0jwm/4mrTyIKO5PhKFhsrt+JEgzcpLTfZJrE22wMEq0VSHD18Aap0UWdcdi5D3aV/4fFuyVc/u/99/p6AFYhAiymYWhW4J8jjRE/on/g/wMD8NOLEzAQXgzzHjPooUEs+Q5p1mwVZ8vYaK7y9I/miKDmHvdlkGDBiQyuf7iAh8yxUd1FdRYDY/5sw298DjWAOemBXyJcXSaf2s5fMtB2HFVZrGN4UXVy+I1Mm8Bqv0mMb4Kqa2v7IfhBha3XJNMg3LoMby/Xn/x7OrSeLCW/W/hCt9pXjFQD8ms4umcT/jOMx1WKnH3oXxCzFRN4hYnugg9WZq/9hjANLgmuEwfyTRUyADrJW2C/giDBGK0qI2SzOAyCXy/Apdm2gdeF+hrmRuuOdKNv6jasc/7/z1LKchKIdhjBTmHJnJGHR7SBNwAEtLalgvzi2kgczEmke/Ky0o0TKozC/OgGIfp2v4HUWG+LRCrVnRF0zvrnWUu48l+88vqhssMV04qwRmana8RC4uOF5Trq8Ppobzbgp9LJj/a1f0h07p43xtzLdAW8nR4xz3YfSPuC4DZXKvn3UTK7YlS4JJzHm6/fz8kIuWu9ZsVdZpX3W97hYy0MhgVmSoH48L20smdjnQDp1y+dD9RzIhnoYxuF26CMbjFZ1Oz9ZXMAC2jZxgUxxVCquZsf7rLrtQORRk3cHyBW06kZsll7hSf5rRyMVWBQZHX6i3JG/FGJbH5zV7lYnNo4r6HjA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(921020)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EHb27X5bq3Y0oZ6vG1+Ernt3serRZDgNE0C7gzfFV4vkIWqeN/sorQmqEdKjs8e87mDk2du5BZBlVMlUYcMafC+BxFveXCo1ivU13x/qQtVT1LzFKebWuFwl3van3+9/lTBR0bEO+N6d4/mGv65LH3e1MX5EcwDxViYh9H6Y9/PhKxw69WWpq7rSe8PAQ6UNHOJJrqscIfKpewsCnldNaFZ0Xs9JVV7lgqW7FITaDEFcs4+1IIL8GON8LVP0mIlEBmG0ag70ktYW1NimGcGwsF4m1gSP3o4QtsSnR8oTMrwVR4cz1/EjHCGSXYmwFBuWQzaOonIV2+qc37i9l3aiUHPHOJhecJnXIlb11++HO4xDkZYdTpgvKZTAVmyEQXtvV/tztFB7vAaSDozkDR3tJ9NOoYYI0JGbAoAChH9+YEm8P1scOO6gr6e6YnlWTe3d
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 06:25:02.8568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a48f39fa-12e5-43ca-0cc7-08dec2cb2d79
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-21822-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fushuai.wang@linux.dev,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:parav@nvidia.com,m:moshe@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:wangfushuai@baidu.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 051A764579F



On 04/06/2026 15:57, Fushuai Wang wrote:
> External email: Use caution opening links or attachments
> 
> 
> From: Fushuai Wang <wangfushuai@baidu.com>
> 
> Hi all,
> 
> When an SF is created after a CPU has been taken offline, the IRQ affinity
> check fails because existing IRQs in the pool may have affinity masks that
> include the now-offline CPU. This causes SF creation to fail even though
> suitable online CPUs are available.
> 
> This series fixes this issue and includes a small cleanup:
> 
> Patch 1 folds cpumask_copy() into cpumask_andnot() for better code clarity
> in comp_irq_request_sf().
> 
> Patch 2 filters affinity masks to only consider effective CPUs before the
> subset check, ensuring SF creation succeeds when CPUs have been taken offline.

Thanks for the patches.
two points:
1) you need to add branch name to the title (PATCH net ...)
2) you need to keep a change-log.

The first patch is net-next material, and the second patch is net.
I think it would be better to send each one separately to its own branch.
sorry didn't notice on prev review...

> 
> --WANG
> 
> Fushuai Wang (2):
>    net/mlx5: Simplify cpumask operations in comp_irq_request_sf()
>    net/mlx5: Use effective affinity mask for IRQ selection
> 
>   drivers/net/ethernet/mellanox/mlx5/core/eq.c           | 3 +--
>   drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c | 5 ++++-
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
> --
> 2.36.1
> 


