Return-Path: <linux-rdma+bounces-19786-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAWTGx5R82khzgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19786-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 14:54:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 183CF4A2F89
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 14:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 432E3302FB4B
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 12:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2B3401A1A;
	Thu, 30 Apr 2026 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BtyYaU4l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967042E5429;
	Thu, 30 Apr 2026 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553592; cv=fail; b=NQL3ii80yFXWwyBAHDsoH9tcWneXFBtQ1IFNs9mItOm/6mga9Is6SXm9nHhbY89/9NW9/dKJyE8ap3KFJHY3UTxVm3BgMbseadCNF8+ih3JGodWzoGPB4wUevD8W0YEc72q++xdgzxKPid9TSTLWl69qG8+mj6pi+n7HaL8hz+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553592; c=relaxed/simple;
	bh=GEPdGI66r8/rkQyE8I3aKfUlDWsloz8J9BQbiTuaq0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=avTxxWCqXYPhB58Y9vQLB2+XSNbryc7lS3BGPqJl6FKtvfsdhD/GhKVaMI3SGcJT+G7kIR4h/CJFb0qCjLJx+r8cwMnvHoAODQpo5/iqmJodX7aG9MixnsX96mZIn6B6/byQz4sYWESa4IpqqwmtfYEW6ch+590EuY8011yJGOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BtyYaU4l; arc=fail smtp.client-ip=52.101.56.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9NtKnPgR39SLxVxcpY0FVJWXwZI2rxYATwPAeJIMXZiYfCSYey7SvmI85t1bqCGpmigMO4rc18lUQQZmemCUqHNd7Z+sxtkR2C7utJQuIGb1MtwU0ZsjU4M6WdWAG1zxGr8mVKau8TYwebqJlfDIhOxqHqtUVsEwx9uVHSJWoSi4OK8nWVTC/ks14sZzWZV2jVL//JVHFoFpfNOAbV2in2YrrRWFQz5+SHcMoUv/3qjJmg2e92ABzDirBYCWdiemFri5cAdTxmBtk0cTx8U1zL/uqq5twZP+QoV8MOglmrjY6pdC7QMlJIu0pTaxb/qKTvO4Xw+0SyXk63wRhgq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/pQ/Sei12piuy6m4VfqkW2mOI5J9KUguIhy0bWBark=;
 b=Q/lFIvicm0pp9ue2QhCC2E09TP9BMowE99eUeXVz43gbsL/NodPX4miBe5Xh93Kq5K6OCveLQyLbkEi0/mu6eTLHOuMKwAhm3KR9UUq9NrxB1cR4zOkWCiBcPb/PYyI98Ax25eZ8y75+D5IGYXL1SmIj9VEfTmF1YhPkUW1S5yXVC69CqidzQQ7eanEpxQ0Mon+sUqzrw1aBB94E6hJVsNaZ8RdpYvYhuepTwaynUzygpdClfVQzh6iv2iecvMQ22FjY7inWKTzriEdar/RbMxvvQUbm6D4LVD4aIvdxW8tsWhvzC3uJMFXAZp3BZIZF6uu37VqZ2dgiUFsWWiVJIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/pQ/Sei12piuy6m4VfqkW2mOI5J9KUguIhy0bWBark=;
 b=BtyYaU4lrqm4hfmxjIINoiQYfNKJkK75JDlR+K9b6P+pg76u0ltwtK39zlFV3bO7wxpL1Uqu+mdnMQJsyUrz59XzQosJduMoAus0LlxcJcKumFEahc8oOlzEZbf60FqmSSFWSLUaVG78NTO4jmwamWTtLfxXCgNupJ4FFLd8UpUJJjhi2mpjd8iQEgLdc1qObLZ6EqZD7cRFLdgjZ2TI8N1NUdvwTrc6H+2A4SItkTRNJobpb85Z2mJWAahzN5Nrp1/v3/U4Y0B7g1X6efn2gua3zMeiHDi10vd+F3KuMFrgnzDWzGagXOHRLA2PcHkOGzmcs5VG90xA4C7Fhh8QkA==
Received: from SJ0PR05CA0066.namprd05.prod.outlook.com (2603:10b6:a03:332::11)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Thu, 30 Apr
 2026 12:53:04 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::5f) by SJ0PR05CA0066.outlook.office365.com
 (2603:10b6:a03:332::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.20 via Frontend Transport; Thu,
 30 Apr 2026 12:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 12:53:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 05:52:47 -0700
Received: from [10.242.158.87] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 05:52:42 -0700
Message-ID: <7ae7acfa-cf44-4171-8871-7a7cacc779fe@nvidia.com>
Date: Thu, 30 Apr 2026 15:52:39 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V4 3/4] net/mlx5e: SD, Fix missing cleanup on probe
 error
To: Jakub Kicinski <kuba@kernel.org>, <tariqt@nvidia.com>
CC: <edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <saeedm@nvidia.com>, <mbloch@nvidia.com>,
	<leon@kernel.org>, <horms@kernel.org>, <phaddad@nvidia.com>,
	<kees@kernel.org>, <parav@nvidia.com>, <gal@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dtatulea@nvidia.com>
References: <20260428060111.221086-4-tariqt@nvidia.com>
 <20260430014209.2375731-1-kuba@kernel.org>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260430014209.2375731-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: a8b6d3e7-6520-4d60-b736-08dea6b76b11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KqHeRztxHZZ1kZyXQ+rlVfbXRhajibYuAZOQa6E1Dbd8XuFBAbUJlt/QEdU/9SWYiWKG1fkCXBmDCu+cBuXYc/UCGW0OILDLrH4YgV6zbiftSfrbAvXDOthqUiQfgLsQNOHWcrj1oNYwHaWVK6PDAue06bo0jULUBz5tno3gHgwcHrO4gug6R9NscBPwWc79dKtFOzgXq0dEnJRBRdFuDmanx2v7qYUx5v7zalrK1rn2CQUfdrT3456HxRuB4UL5gTx0EXJn13Fk5cokgqEmcdywpKDrCh/tLiAoJiuT2mwcgOvtJhOCpccwzugRkElpxRFQAJAuuCoQWvlm50vFElK8jA0gFuQA70ksv63ANfHGTpY0vlnkK1MIBz9GVKkqj+tlMPdUgYb1Dfmpr/QE+92WffgBEIpLxiAKbAJeGXn32P2P2KgreNI3rZvnC6HtPL558XBYOaVJhzbc/keLfsaMvmCSPFEGVjDEUyazMlGeIFPImS/S5RAksEg3ZDeEZlJ3beyVQS5hPK0b2UqgvuXrDo/gUevZzP6+QGYizkcTpwQxeA7yfq/voOb3J+LIJvEuBglKTVZT1LPfCZHGHxBW0Q+CUWsQsCJ48yiFS5WdQWpSVejXhx3Y+2HG8jZlpCfCY1R6MOCunJQ56EdGM91joToQagiZboPV5biZs4fXIqk66FTGlsJ0t9RC1ZrVZ/aDIgUpeZHx1QbsYhUf0fiEG5RSfjmV1DDDBud4Cbb1p/NQsswdICdY6XKOy42edOiGo57rnETsGCrsp0q3pw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ibHo02UBgRArVu3qgsPuUW6Fs46lglPZcOFeOJUithvS4OfqF/hBHF3ngiNTIbltEbhmlufmVdu9e7vPaonnZLDEBDQhQHIU1y7Irb3+kzCwzcV8IXO6o+tFk42hywHEWWgJV6ArEkSHiA4/EbrVd+WfIPcn+nnAhA2arvSizKnJzmWZj3oPC6HBc5b9HXtdDAONbEh94SctLZNxZmb9u5VpM2LypcfORtFpV11dR660sl+C5PSyZiq1N5mw4HOZxga3Iqfxq26UlWIJGGMhhBk6CT2lMXG6TwYEOdxPM8kosjzmE56PyyOmsPMnAzEts8OZga8YI9K58+PuJFFsjzHBlEIMZEkneW8XBJx1Si2tf5lFM+ULPAMIYU9/u4ipYOgqMDqMbmmtstTll5znHHxrvF+BgiPmGm01bI4u1Lzvu27J1FMu+5tjMs260fdh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:53:03.8457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b6d3e7-6520-4d60-b736-08dea6b76b11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069
X-Rspamd-Queue-Id: 183CF4A2F89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-19786-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]



On 30/04/2026 4:42, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
> 
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net/mlx5e: SD, Fix missing cleanup on probe error
> 
> This commit adds a missing mlx5_sd_cleanup() call to the probe error path.
> The commit message notes a similar gap exists on the resume path leaving
> sd == NULL on failure, but defers the fix to a follow-up series.
> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> index 5a46870c4b74..e21affd0ffc4 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> [ ... ]
>> @@ -6912,9 +6912,16 @@ static int mlx5e_probe(struct auxiliary_device *adev,
>>                return err;
>>
>>        actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
>> -     if (actual_adev)
>> -             return _mlx5e_probe(actual_adev);
>> +     if (actual_adev) {
>> +             err = _mlx5e_probe(actual_adev);
>> +             if (err)
>> +                     goto sd_cleanup;
>> +     }
>>        return 0;
>> +
>> +sd_cleanup:
>> +     mlx5_sd_cleanup(mdev);
>> +     return err;
>>   }
>>
>>   static void _mlx5e_remove(struct auxiliary_device *adev)
> 
> Will leaving the resume gap unfixed as mentioned in the commit message cause
> a NULL pointer dereference when a secondary device is later removed?
> 
> If a secondary device fails resume, sd becomes NULL. Later during removal,
> mlx5_sd_get_adev() will check !sd and return the secondary adev.
> 
> This causes _mlx5e_remove() to be executed on the secondary adev:
> 
> _mlx5e_remove()
> {
>          struct mlx5_adev *edev = container_of(adev, struct mlx5_adev, adev);
>          struct mlx5e_dev *mlx5e_dev = auxiliary_get_drvdata(adev);
>          struct net_device *netdev = mlx5e_dev->netdev;
>          ...
> }
> 
> Since _mlx5e_probe() is never called on secondary devices,
> auxiliary_get_drvdata(adev) returns NULL. Does this mean accessing
> mlx5e_dev->netdev will crash?
> 
> Would it be safer to add a NULL check for mlx5e_dev in _mlx5e_remove()
> until the proper PM lifecycle fixes are implemented?

IMO, a proper fix is needed here. PM lifecycle is implemented, the bug
is in case of error flow...


