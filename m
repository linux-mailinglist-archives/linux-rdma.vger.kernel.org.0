Return-Path: <linux-rdma+bounces-18999-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHqfLJKy0mlKZwcAu9opvQ
	(envelope-from <linux-rdma+bounces-18999-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 21:05:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F13E239F55B
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 21:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93C943007E24
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Apr 2026 19:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99A02EAB6F;
	Sun,  5 Apr 2026 19:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j2KNGpBr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011015.outbound.protection.outlook.com [40.93.194.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7B5433B3;
	Sun,  5 Apr 2026 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775415945; cv=fail; b=VISet8bkGvJOmN5/yfbe/VSXfTO8iRp4HMnZ9Lwq4hOmbeSiaLtlKIr8rYJuzDg721Q37xvM13NoF7ILJWMX0sot9vbWKV2+hIGpHZuml5t+6BUsH9MWFpztCt7jXtoXgBjUPYWVk7GSiN9kwd6UwN0UhMs+Qk07iPZ0SIzzcmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775415945; c=relaxed/simple;
	bh=awdvCo6CGmIgywBYESmyUqvBZrePQ91P8dAblV00UeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BW8oyNM9xvzgX8HmX0IZawFS4OwS9R7WbUskfptDHPxsvhuhZUS5MDIa44rpU/Fyuk2+haDgsE47Itdz0fmAd4g8T6pGXqoHl6Gq+qogE4qSvPULacbKn8Z4/LyxwsNeXhDYPH0R79pbj9AMRtuqYkNgLTCVGaJVl8GNwxjQpr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j2KNGpBr; arc=fail smtp.client-ip=40.93.194.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHolmXAFghR/QddUyVFbhSO0m615QRX1IOWuLghbwd9FtLVCKzZFu4BaGTAnR1TGa7sEvaVhgYw1XdOJUmdvqiFpli3pCES48g9t7Zx1hPIygpOHSbgVys7f3/7HZBU484+j1CQgsz56nfAHT0WsQ1hythlS4Oivr+1+PgSOvUuWh3JifhjTRPKPR5bPzZJ6fjmnI4BBvALZgDwHpBJ3zixyeJXcVWoMNGGqqoqU84e5lVSbGdfl3PclEog7E8OBZkAohn1jQfkzIe8YfR63oH/OaS6g8M9ZME5N0MC1rm9S2iIFIhRXZ8dSh15mIE86z65d30Goxch/Vmf6y1xosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEjwZZrlVhG68nJ6xpqtY4JFzkh8bmQy7vMqL57ixWc=;
 b=DGrg4FD8vmpSWLsannzCJ6GCM5eZC1lfZL7oIBsPEKiDYFuitl7VAc4x8HA1ZeM2uXcpYHeakinlVfy/cDUFOfRO4GSXLpWU6GRusZg2Ok2sB7+y7UlgcoF5bt8lrJUCW0ZK97DRVUN2VXJh9zFvL2NgwuKpH72glnyQduIIUG5Yxoo5ZMbq4okNjkz86ZUHByjijfRzLAsFTUwft/VPpJEusEGkLWhe9jd3Yvj6bySFnTfBpehy1DtPKSQuC6NZoo83P+vX6I6n3Cl2FcswuqGum21qOrdrfaPVCGKTXhzDtoF5sj8SA1G/i1OhO0l75d94jicIBY9L+lGGYYijTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEjwZZrlVhG68nJ6xpqtY4JFzkh8bmQy7vMqL57ixWc=;
 b=j2KNGpBrPQAR0rri1LU5Ij7dU3SWWCt0Cwn6YcTWOQ3K+SeDcajpjdqlKjeCcLGNOYEQtCFPC7HzbIK/sBsmeSa4JvReNTYvDYTe3A4EOxukEVyWh9qJIQEQNjpIZhGGpNHMSh81rydCKCjZiGW5+TQuj0FHT4HTde9aHZKTnEMZuQdBTnFtqgwNoUZGFtu0aqsnfmuh/4qLdjDtIpflCBEeIKa/GNJ9HmvHNy6YgR3NfD9iD9ShZ8yYAE9+Th40bxO4bJgORQayCcnQ5V4btNF1k9cZzs3l9badTh3yLKvvOvCjiJdGZArJHROn5ssAKsYjmN8UCdV9PI/RAz3fnA==
Received: from CH0PR08CA0022.namprd08.prod.outlook.com (2603:10b6:610:33::27)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Sun, 5 Apr
 2026 19:05:39 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::3f) by CH0PR08CA0022.outlook.office365.com
 (2603:10b6:610:33::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Sun,
 5 Apr 2026 19:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Sun, 5 Apr 2026 19:05:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 5 Apr
 2026 12:05:30 -0700
Received: from [10.221.229.87] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 5 Apr
 2026 12:05:25 -0700
Message-ID: <0faddbe5-3b2e-46af-9fbf-0c86bc32ee4b@nvidia.com>
Date: Sun, 5 Apr 2026 22:05:23 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] net/mlx5e: SD, Fix race condition in secondary
 device probe/remove
To: Jakub Kicinski <kuba@kernel.org>
CC: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Simon Horman
	<horms@kernel.org>, Kees Cook <kees@kernel.org>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260330193412.53408-1-tariqt@nvidia.com>
 <20260330193412.53408-2-tariqt@nvidia.com>
 <20260401200842.79322a24@kernel.org>
 <53c3bf8c-0b0e-4986-91f3-3eec53fc2b1a@nvidia.com>
 <20260402174531.33ff0ff6@kernel.org>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260402174531.33ff0ff6@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f4b029-cdea-493f-f76a-08de93465382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PWZ/kW9kN8DymbcJbEv2JysCDZkMzSKafStyrxvYtji8XPeV4lnzUyDe3xZbP+IlvArk38EFx4iIEiYkNZNmdppeUSGQ4aTXOcLHBKDN9EuMGhhfPocnHBP+Qxw+J02PjTc7/JE67ZpLPDbfbeDYr6+G546B73QQUKJS2zxS8qYoHDPeNxMExlTXES7qtszjm2QtDpmYo4N7lT8Pwsh/NEYV4s7qBnEc5/whjIXhINaLWrETIkgHTOy0Hc3B4UGDKHqDqsVmf1KJmHgSnX7yU0ol1QVDUcIwvTNId9Tb1TURHY2KqmZOFljvqj0ZSF6bY5+pPx69cxBCGbOuY7C8pvOo7uZgly9SE0GMC3KofEU7LcFBoiPObdnenHwXpNhAA7RDIHY+iu7/4GTlCuO1H2SZsXGeERZ+5pDBnwf6cchXEqfkaWaJcgEcaIvM1WPL9WAFKMTT3vltCtIjf7ebd1p6SsCF6eqjVUGTkbsln86LQ6CXRdTzBPel/z9foKcCxOEDetzXT0o/VRdvmgejPfxfWzY/c8RjQ8zDgq612R38dL6G76W6hrOdMt7R1u8zgxBp7OR/6aNKmJZfbCacfeRMqLLcXYd3IhSI32VTFQ1pZqoQdBUqbd1jCAshpSlCkCzyrUrHkiGGPbQtogMySrc3VZbArpeYI7O88NHjPGYqHfn0h/bl+nZASvRMhGbdUK+FZIjzpikQXn9SIa642fkR6tD43L2BA7KFATFnrReKYJGjzIllXl12BzSgG6PxWc4IDmgZ+p+ElHiagARC5g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CHwmJHxXKv2f3dkXbyl1WdIYKNWq4JiK/kOs/aW8XpL9cxcpJCV4Y+R3MNe7tOfmgVcKEdZubNm1PezcFd5a1+Nzku9z1klucndWd3Iod8kUxFPeTqqmMHZl1VL45XLU5erffWt5SCLtmBxCV92WbspTtqJIwHJK7boTHDj8VEcd0amV6rJc+VvLHHEQq9sX/JhhxXtJ2i3hq93rri3KxeuZ/B3jQBUMNvcyQn9tn5Jni2Gzl6FaxM7H7+s43OUmjrOagfNBa03PBW/3yaTM7ML/8hsM6fij7lcsrx3El3DDj3Yae3ulRJAPV3/TZei7Y3S0J8VZIipcjzqkN8k8LoMU3vt+UuGJMTcH0+Zaf11+QhMvhYGowtk4jNK7XmIrE+7Bl+WEJkinZrNoSpEr7ugyk1da7r8LeK1X34dAwFV7pLJzZSo9/CGwtFiyNO2Z
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 19:05:38.9662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f4b029-cdea-493f-f76a-08de93465382
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-18999-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: F13E239F55B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 03/04/2026 3:45, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, 2 Apr 2026 23:03:10 +0300 Shay Drori wrote:
>> On 02/04/2026 6:08, Jakub Kicinski wrote:
>>> On Mon, 30 Mar 2026 22:34:10 +0300 Tariq Toukan wrote:
>>>> From: Shay Drory <shayd@nvidia.com>
>>>>
>>>> When utilizing Socket-Direct single netdev functionality the driver
>>>> resolves the actual auxiliary device using mlx5_sd_get_adev(). However,
>>>> the current implementation returns the primary ETH auxiliary device
>>>> without holding the device lock, leading to a potential race condition
>>>> where the ETH device could be unbound or removed concurrently during
>>>> probe, suspend, resume, or remove operations.[1]
>>>>
>>>> Fix this by introducing mlx5_sd_put_adev() and updating
>>>> mlx5_sd_get_adev() so that secondaries devices would acquire the device
>>>> lock of the returned auxiliary device. After the lock is acquired, a
>>>> second devcom check is needed[2].
>>>> In addition, update The callers to pair the get operation with the new
>>>> put operation, ensuring the lock is held while the auxiliary device is
>>>> being operated on and released afterwards.
>>>
>>> Please explain why the "primary" designation is reliable, and therefore
>>> we can be sure there will be no ABBA deadlock here
>>
>> The "primary" designation is determined once in sd_register(). It's set
>> before devcom is marked ready, and it never changes after that.
>> In Addition, The primary path never locks a secondary: When the primary
>> device invoke mlx5_sd_get_adev(), it sees dev == primary and returns.
>> no additional lock is taken.
>> Therefore lock ordering is always: secondary_lock → primary_lock. The
>> reverse never happens, so ABBA deadlock is impossible.
> 
> And the device_lock instances have separate lockdep classes?
> So lockdep will also understand this?

I tested this patches with lockdep enable and didn't get a splat,
so it seems lockdep understand.

> 
>> Does the above is the explanation you looked for?
>> If not, can you elaborate?
>> If yes, to add it to the commit message in V2?
> 
> Sounds good, please add to the msg.
> 
>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>>>> index b6c12460b54a..5761f655f488 100644
>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>>>> @@ -6657,8 +6657,11 @@ static int mlx5e_resume(struct auxiliary_device *adev)
>>>>                 return err;
>>>>
>>>>         actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
>>>> -     if (actual_adev)
>>>> -             return _mlx5e_resume(actual_adev);
>>>> +     if (actual_adev) {
>>>> +             err = _mlx5e_resume(actual_adev);
>>>> +             mlx5_sd_put_adev(actual_adev, adev);
>>>> +             return err;
>>>> +     }
>>>>         return 0;
>>>
>>> Feels like I recently complained about similar code y'all were trying
>>> to add. Magically and conditionally locking something in a get helper
>>> makes for extremely confusing code.
>>
>> Do you think explicit locking API is preferred here?
>> something like:
>> new_locking_api()
>>
>> mlx5_sd_get_adev()
>>
>> new_unlocking_api()
> 
> Readability is hard, I'd just push the locking up into the callers TBH.
> Looks like there's only 4, the LoC delta isn't going to be huge.

I though about it, but AFAIU your suggestion, a race is still possible:
your suggestion is to lock the adev returned from mlx5_sd_get_adev().
but between mlx5_sd_get_adev() and the lock, the adev can be free...

Therefore, an SD helper is still needed.
do you have a preferred approach here?

thanks


