Return-Path: <linux-rdma+bounces-19433-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE2UJF3P5WkfoQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19433-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 09:01:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 935F942790E
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 09:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99B9C3001597
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 07:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4213845C5;
	Mon, 20 Apr 2026 07:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XMNkZoOH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AFC346FB5;
	Mon, 20 Apr 2026 07:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776668499; cv=fail; b=QkmIQTjl2A2dpbLzLWnReszGAGgdbRyC3vux+zAy+k4z3RBV58EhIN+iFCqlt6zWSFLUmDEMnEyzNK8GSJsTLyiK7JrCEZ+3rJ1NRQg+bjx7RukPGyfV3V9fiClSGY2cb3+l1NEPPUb/ITQxN7AARnggTKUQYOxSDDR13F1n2pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776668499; c=relaxed/simple;
	bh=u9WQWFjjxP2KOyLCA5i5Ls9NrlGVXOARJsghGouf7aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gSMTsJwfb+6aOygIURJqv5vKoJjYzy3wmi7uMIf0TolVhgtpZEzjWMjLta7LI9Pa6twyPEkC3//ZaO3nuuL7kXBaAHN8B/0mxa0c11IdZJo46AJOhjNN30jTCcoEIb5FD9XgM+mZMz4LoLHGURvfd1wzACUMiS6FYiAiE+ydm+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XMNkZoOH; arc=fail smtp.client-ip=52.101.56.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRS+x4fi3Y5/k4mkEFmKH/M7DU19xJV3AomwRkpsRlu6Qd4tS1t+FJ6P8CZ6stJIicXxAKq0JBAKSrtdrg+T8Mtv02u2enqyyTARw9tmX9CgE91/NI2cJgXCOO+xjlH74PqLeJcvPjf2XnpXclODWfF3ZiUr+hDuns/w1AdUYzOhZRO9JvRLhoRQ6/nVIAM4BrW+j8rZz+FDRy0jue9Mgclh9OsgYPYUaUcFJgwXAdzFCeFe2yiXEANfNWxJ88e681G+QIxLbK0s8lemYxL3+aKDqq/0Hcwx5VBnTyo6MTDPB3E9k7+qrAD0L/FKN5xteXS/x2jWtNTafZWnnGq0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxR7xxw6uqMKmJ8teiROeSkDaA4l7IeE0yalIFO5zoQ=;
 b=AUV6Cvf5nlH7xkm+v1z+v40403JR2shNTRsR0ld61YyqM0XOrEySLJl2oP8aZwK+oO4dc4deYPj7Q3dpoiCoxf7aaF686BAs22ptcm8MbJpWrnIjabVeZTNK/2mxOGzpO6ZJ8v0eeqjEapWDvmFRejkaXvUMV771puZMqtR+HeH9RVK6ryTFGrFQ4sefMRwMxG9Cakq39JcM0W+Y8ltHpxnskArcxsEhRADHzzdcZG+fXdEQB7WXxqa22zxrEoXbuFp5Atn1a6l0oO0+F7QDOmXhszqJn11XA3AdKG5oXCBGQeni1y8HN8kb2M3U8ZeeYzTyoC68uu3vM2Vq9k7P1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxR7xxw6uqMKmJ8teiROeSkDaA4l7IeE0yalIFO5zoQ=;
 b=XMNkZoOHFzl6xbFgtrJ7/Qdyr4NIff4/sKZIxr6TqL8KZcqZWicrcTpWnNTVA9rsXaE72gyVEVv+hPeLrBXAZHIeI/iPcB9afrFnvPVWW50m1HEh3VTlphJBxL2OvRTdXON+XlmUp3PWj8ki1HfSB1td7eJe+UdjpdSiIj4D8nJB+t4JrFKBrVnEbEP5ukQOe5U7LA4oErfmI+8zhMYkfYxbSqbxP3+wHbrIBvvXMFrDbs+xEKKuOse7iQUoHy/lMPlyGSglBZlCeYcc7cRAvn3UboIW8viR0wtVYrdUA2JDXxPW48/BsPWiDh1TmusWwgSYEbuO9W9m1hD4BK6Scw==
Received: from BL1PR13CA0436.namprd13.prod.outlook.com (2603:10b6:208:2c3::21)
 by IA0PPFD4454CAA9.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Mon, 20 Apr
 2026 07:01:33 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::35) by BL1PR13CA0436.outlook.office365.com
 (2603:10b6:208:2c3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 07:01:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 07:01:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 00:01:10 -0700
Received: from [10.221.202.31] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 00:01:03 -0700
Message-ID: <69346804-9ac9-44a8-b60a-d3e9e3d8e23a@nvidia.com>
Date: Mon, 20 Apr 2026 10:01:01 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 1/3] net/mlx5: SD: Serialize init/cleanup
To: Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Simon Horman <horms@kernel.org>, Kees Cook
	<kees@kernel.org>, Parav Pandit <parav@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20260413105323.186411-1-tariqt@nvidia.com>
 <20260413105323.186411-2-tariqt@nvidia.com>
 <77503dd8-d882-4079-9dc8-f0cab89c0a7b@redhat.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <77503dd8-d882-4079-9dc8-f0cab89c0a7b@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|IA0PPFD4454CAA9:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b75979-17c7-40dc-31d6-08de9eaaa83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	INzKvB0fHS1hkLz2HDeIA2UMNGuUbBiHjTlbh/amtwlHC+ZGMt1QkXjUXZnAhYVH7Il53I/MypxDsaMprDKZIDYKeWZhpmtZaVC2dviuGl8EC4308C7+zrMxCpGspJdt18ueKMzzyKY61oWRsTzRxpW6F8alF91+w53FYpr46GFJYLjIIbmclVfxTJYCgm7wH/DEE8lhf7xbBgpe9FOohkd7oMnUizeYPa4EMvro39IcWE111OO8VgDJiLppFp4gjk0itqvPIrxrnxkfFYwzHKq/v2BAp5qkvBh8LIZRIwAs6gm6mPYWh6v4QtuMRCKV/UToR1HhbengSJVpl5DvW1WsvlaI6GIfG1H3sksX6A4gY3yFWy2QruvLNTQ7ziPhGDAok5i39CI9E6kJtHQc8qSZeUBhtU9um7w8brBMv4JzInrqvE3qOokSYLYqDsyCbTw2ik71aGwMEftnwY5EhjxVy6HEBrFk0kPLrH8PZZUDCHzqUKkgRY2Fjc5eLzyJ+Rq9ephDdldsgjw6uxy7fvh0n6bmHBBwMSQAYavWMqzdKGhbkOzD1iqNdJuUYMHToVpGvhCaJh6vio9C4elGuZ1MTJdY4IpkEnB/rfPx4dMRP3RG0/j7mvLPn8sSlS9wr0lyCcNpHsrlplrlcjfIzWXdA105pq/+7MohTH6OsjNwIdV4kkHxVygAqwZEd5bYtIMQMm1LT33fTgq2DLFr5rO2R4zrDgjsgITO7RE6bKaunayQZcLFQ0WeabqnsgeNqZXeAfvjnX+kWx3AjpJPGw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4JSB9uOuyP12cdbFGQqXabUz/nOmroEJlbq8W20FqLcGyiy8pYu6wxBqt8m/KpoWxb3Hz6KYTqlDzxi73PqJybxdWwO3iiU7qu3Ln2me2orMkkQWWh3aqS4W5KZlCGDjzPQUDO7oE60zhsp+TFQBNeFZcN+oee2b7Mma+ymRRknAZtejrhOCwFw8eoGQZ3Sc6yOGBsbTg68EUIiVtrd+9fAK1gU4x7GZYInDqAVEC+Fpbw40yVl5Q/Fn+JzWq2up8lHta0UElHM8iZU6H1Lyibv6Om01IFQcJ7am+ubHoV5frQeCK9PdwQTF4ynm1M92Y5rUX2zBi92eDpxG9ZTnkVqdLXzwmtfCpmvHPXTVjrrRDxD193M6bxISsU1ABy3UhFb/E+JdCHbmghI77pvjcwBUAlGxlUGNbaRR1nj3Y3X9+xCd4qhE2aYHAy09Z/up
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 07:01:33.5372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b75979-17c7-40dc-31d6-08de9eaaa83b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD4454CAA9
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19433-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[104.64.211.4:from];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 935F942790E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 16/04/2026 14:00, Paolo Abeni wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 4/13/26 12:53 PM, Tariq Toukan wrote:
>> @@ -491,23 +508,35 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
>>   {
>>        struct mlx5_sd *sd = mlx5_get_sd(dev);
>>        struct mlx5_core_dev *primary, *pos;
>> +     struct mlx5_sd *primary_sd = NULL;
>>        int i;
>>
>>        if (!sd)
>>                return;
>>
>> +     mlx5_devcom_comp_lock(sd->devcom);
>>        if (!mlx5_devcom_comp_is_ready(sd->devcom))
>> -             goto out;
>> +             goto out_unlock;
>>
>>        primary = mlx5_sd_get_primary(dev);
>> +     primary_sd = mlx5_get_sd(primary);
>> +
>> +     if (primary_sd->state != MLX5_SD_STATE_UP)
>> +             goto out_unlock;
>> +
>>        mlx5_sd_for_each_secondary(i, primary, pos)
>>                sd_cmd_unset_secondary(pos);
>>        sd_cmd_unset_primary(primary);
>>        debugfs_remove_recursive(sd->dfs);
>>
>>        sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
>> -out:
>> +     primary_sd->state = MLX5_SD_STATE_DESTROYING;
>> +out_unlock:
>> +     mlx5_devcom_comp_unlock(sd->devcom);
>>        sd_unregister(dev);
>> +     if (primary_sd)
>> +             /* devcom isn't ready, reset the state */
>> +             primary_sd->state = MLX5_SD_STATE_DOWN;
> 
> Sashiko says:
> 
> ---
> Since primary_sd is only populated if devcom is ready, this condition will
> never trigger when devcom isn't ready, contrary to the comment. Instead,
> it triggers on the normal path after devcom is ready, immediately
> overwriting
> MLX5_SD_STATE_DESTROYING with MLX5_SD_STATE_DOWN outside the lock.
> Could this allow concurrent mlx5_sd_init() calls to see the down state and
> attempt hardware re-initialization while the group is still being torn down?
> Also, can this race and cause a use-after-free regression?
> During a concurrent Socket-Direct group teardown, the primary PF and
> secondary
> PF can execute mlx5_sd_cleanup() in parallel.
> If the primary PF completes its cleanup first, it will call
> sd_cleanup(primary)
> which calls kfree() on the sd structure, freeing the primary_sd memory.
> If the secondary PF is preempted just after releasing the devcom lock,
> it will resume, evaluate its local non-NULL primary_sd pointer, and
> locklessly
> write to primary_sd->state. Does this dereference the freed memory of the
> primary PF?
After some more thinks following the above comments, I change the logic
here so that devcom_set_ready(false) is done under the
mlx5_devcom_comp_lock(), making the is_ready() check in sd_init()
reliable gate for cleanup/init race cases.

> ---
> 


