Return-Path: <linux-rdma+bounces-4482-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B69F95ADC4
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 08:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0023EB2141C
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 06:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E42139D09;
	Thu, 22 Aug 2024 06:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AAPn3ah3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F804A933;
	Thu, 22 Aug 2024 06:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308857; cv=fail; b=UPUU/NxZIJjJfETOotXOPVfgJfCyUEX2mz4w/F3MrAmdcnXUbw6gIUho0ryPH8d7czQR+ABoOkgS8/QvnalrMA5WGKk+jAruk/ZRIxyGcmhERTTMTi2XWcq9ltWyKjzTaizul0c/yGFGxznK3B0Qd9W8tSLJI43R/mksfPAIgLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308857; c=relaxed/simple;
	bh=T9PbKa2AIDqLZUbSwyo4xXfcG9loyeAuNyf76H/zLsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r7p70CQdZK8PFk+JUQHz/V+ZhUsemL8+LYfFu+C/bgJrgbnHF/OF0U4Jh1HZwQYIGYwllw/65MWjHwBB+2eohTN/btQOYBQaEGXNpvgallca8GPmtiEIbVrWVn4GquqZy/JKo4SZTyMKG11Kcw3Wl7ORSQf8pucGkvKXmRW4rvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AAPn3ah3; arc=fail smtp.client-ip=40.107.101.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJSxOFfkE/deJmWHtZHY52LPDm2TFmEYNYKjcOUa4MnpmHNpbu/mLOqhTgbfh4HPRxi1BemPI3nZ8jnyHzXmYfxyUs01mgYZJt5tBzldHh+o/2ULOK/cp9P4I/Ez1Mxokv4X8fnc+rePw7jQcVdMKbP2L/oR8Cmu8bhQ97Ft96B4o35+t2AEg4f5h7LlHzNWnw9Y9XerJhvA8IiNGdl7eRfCvzS00E29Dcp3wQu/Me0cQYjyBciCAYNJ1H9qKB/0XULiNcmEcVYxGKpkS8l3bwVJq4Q+PqvsgnU2lERZdUl5jHNRCUdFGeWBx7973HPCh/rv1KA0UFKJf2/pfNJGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6M4w6g+zsoxYg5IL0MvlqWLn8DtCCZLayDnQE7Z2vo=;
 b=I7lg40x+hPnLnUTZenZ8PN17WK0ZXzywglcyPnuUGGAvYmTg5UoGVair1z94IE+mS45dH/m2nziGDeaE7vNQ70SoztKSCY/Wjc3rMeNjBhp6LW/EzNGuKLPXHNp9Uj0YVzFZgsLEt8roU+n4JXD3pG07aRJAYragqdks90c3fsBU9nUQkXjaSVuGxQ9aFrBel/S86phy5869hemArKki1w1sSt5pj6B3KZX+dn/QMiLQ7422Y7bs7Jldcpx0OG9ZlRpqMhzF21zNW5zBcLQS6Xf3koAExcWVAmZu1oXqigRgXgrfrBZ6UVn399FnUZf5mvSeYbYs/s2YbTEe2h6TYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=purestorage.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6M4w6g+zsoxYg5IL0MvlqWLn8DtCCZLayDnQE7Z2vo=;
 b=AAPn3ah3kphpRDVqIm+lm4+PF/Q04WS1qlkwCGoy/OQ/bo/eCxZJPUdjnKb1FxU9fLzTr6dqEs0Ye+cbUJ5toRJIjzB7PDSScnZCUxAHVhNFavHWdWS4v3j7KxnQ3x0x7H7U5uhl7Fp7DHNCMsQdPI9nS2/O1EnQgffKXofZVDyLavn5DXWxRcOLspAkTZHI2PWaLZSP/8BcGMaEWE81mA3EWdyGMoowkbd0K6dbu3FIR3FsMv3rx0pBE0xAAtzpxFvr6MZKFdb5As4aCufu7E8m/Wzc3aeDgPkukM4bPa5TtilAzLriTlnDGwL7rhChIHElxiQw5R9NH1rcUm8y2Q==
Received: from BN9PR03CA0064.namprd03.prod.outlook.com (2603:10b6:408:fc::9)
 by BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 06:40:51 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::3f) by BN9PR03CA0064.outlook.office365.com
 (2603:10b6:408:fc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17 via Frontend
 Transport; Thu, 22 Aug 2024 06:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 06:40:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 23:40:32 -0700
Received: from [172.27.33.61] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 23:40:28 -0700
Message-ID: <ea86913b-8fbd-4134-9ee1-c8754aac0218@nvidia.com>
Date: Thu, 22 Aug 2024 09:40:21 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Added cond_resched() to crdump collection
To: Mohamed Khalfella <mkhalfella@purestorage.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>
CC: Yuanyuan Zhong <yzhong@purestorage.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Shay Drori <shayd@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240819214259.38259-1-mkhalfella@purestorage.com>
 <ea1c88ea-7583-4cfe-b0ef-a224806c96b1@intel.com>
 <ZsUYRRaKLmM5S5K9@apollo.purestorage.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <ZsUYRRaKLmM5S5K9@apollo.purestorage.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: feab166b-2cb4-4b8b-a213-08dcc2755d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3Q0TmoyVkxPam5ENTVvVUwzc2U5OWEzNEtiejBTUGdKbE84RnNNeTkxbGFp?=
 =?utf-8?B?WUl1Z0RnZTNuajJWQ2JBSWJxbzFqN3hMMThDKzZvRDV1aGxLdisreUs5Qmto?=
 =?utf-8?B?Q3JBTEphU2MvYThlSklLVGVDeThFQVpiUlBMRlpMK3dKSXQzajFrWjdhZDJ2?=
 =?utf-8?B?akpXNUtsNG1WZWxic0dObllObFJWWktnS1JLQytsRG1KbVhyZnJVRnMyYkho?=
 =?utf-8?B?TVlVZStlUTBvbERnb1FxSVVMZy9OUmpEd3hPYkxRZzZBZlJNZmtHQVJjYVVZ?=
 =?utf-8?B?a0JreXNmUWNQU1YyUFJNcmpuTnZab2VWME1KT0FQbWEyOXByZjNOcStuQVZD?=
 =?utf-8?B?ZGxTaWxtMG4xWmFBT0FEYzdERVFpUGpSZkhXWFpHMENuTllGeW9FSXNjUkEz?=
 =?utf-8?B?ajJqd0xZazA1QktZZlBvYUpEK01qem1uM3BtNDIwOFlpN0NXVmJ1cjJsTC9k?=
 =?utf-8?B?VkhPRkpKMzZKUloySDg1YkRZNlkzUHFhczc4cENwYUxpMTlYN3JjYW1TN0Ev?=
 =?utf-8?B?VHNWUHlTTjBEZVNvMWx4T0xRdjFJVVpEdmMzMkpGOWRMcUZWbVZrbk5DYnNV?=
 =?utf-8?B?MDJMUXhOV2JKUWRuajFWRGMyMkxYSERhQU9XaTR5ai9QYlBUaTJ6NndsZlJz?=
 =?utf-8?B?ZmRvVVlOOTA0Tnlxb3ZlZDFRQzJnN0RUd1AvenZhSFB5MktKZjkrSlU4VEtK?=
 =?utf-8?B?WGdaTVVJRWk3d2tXZ1p0MnpwU3RxYWlGTndDMnhGWVdWTlJ1Q1FVM2hZTmY2?=
 =?utf-8?B?UnV5QW9MbjRWL1BneVNpNHMrUWlDdTRidk1hS2Zya1FsVk5FQkpuenhrd2dv?=
 =?utf-8?B?dU1XcThVU2oyMXRFLy9TZGRpSkQwdmFoQklGZS96cFJoVFR6SjB3UnZJUzA1?=
 =?utf-8?B?UStjR0h0ZHh5MjdGckZheVpJanN6bkVvK0tNcHRLcHdBQittK29KNzhlQllw?=
 =?utf-8?B?Q1ByY0JtcGFlbDJDSWhsckx4REovUFJlQWUrN0hJWlFRRllmeHVCTER5T0xN?=
 =?utf-8?B?L00rSWR1LzZoV3dDT24rcnI0aXlJSUk5YUdGeTlqeG1wazNsdWpPejV6TVQz?=
 =?utf-8?B?TzJneDJEYnBucVBUU1dJeGxvYS9MaGxNMXJVVzZTWXFYZDNEK24zeUlEbFNG?=
 =?utf-8?B?amF5dnhuWlV6VE15aDdVUjZ6Yk5KN0FCZmY2MDduTmk3SE04V25vcWN6VnF6?=
 =?utf-8?B?UGNma2pJVlNzbVBsWXpSNVBxYjdXckpVdHNYOVdyM3VuQnliMlkxbHdWZ29m?=
 =?utf-8?B?aXRoaC9obmJwTmJhRGsyRTFBeUprU0NZOGpHdUtrVk9PSThqdlhwTElvcFNi?=
 =?utf-8?B?UFlKWG1tNitacGoyaGU5ekFycnRtYkY4OG0rM0JhMlkrOFE3TmpXMDFtaWha?=
 =?utf-8?B?MGEzWDcyenZjeU1jK3k4dmt1bEZlbmV4aFlaQUhHVzJLWkdWUmhZWndkeFIv?=
 =?utf-8?B?Y29rZzYwKytMYllORTJ1b3hsM2lvZkpNdGhXMENUWEhpZnEvTFRIbXEydUEv?=
 =?utf-8?B?aEhDbzdqOEZYOCtnb3ZEQ1pNWHVhUlB1VEZKRVUrTElsMjZMQzZ3aWdTS2Jz?=
 =?utf-8?B?dUNaM2lXcHhtNXdFcmtOUldxVldiTER3UjNUWmZQYkZKRU4xUFpGRkNtYlZ5?=
 =?utf-8?B?TitIaU9EUFBIenpyNVVvSG1wem1WSmJlbFZLeGxiVGwzWG5Mcmg4ZW9pWEtl?=
 =?utf-8?B?NkxxbXdSUG5LZjlWYXYxc0grVzFMc2hTaDhvZ2cvMXQxVGhNcFhFWG8zWk1y?=
 =?utf-8?B?RFk5Q1ByaFhZZDZJWVZoQVY0SUdsVmxHU3MwT3NuQnA5OXhTeHY1d1BRQ2Fi?=
 =?utf-8?B?VG9RSGVwVzk5TTN3b2RyQmlJSWRTNWpVV09iSGV3QzQvWFJsdXNqVzBQcmdG?=
 =?utf-8?B?VWo4b2tUVWFyNXpoU1MvK1g0UDEzT0NQa004bzJqNmFqZ3BOWEJZamp4SjVo?=
 =?utf-8?Q?iIMGNCrcwEjVaJxbd/e1Ro+RxEGv3rlT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 06:40:50.5021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feab166b-2cb4-4b8b-a213-08dcc2755d00
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257



On 8/21/2024 1:27 AM, Mohamed Khalfella wrote:
> 
> On 2024-08-20 12:09:37 +0200, Przemek Kitszel wrote:
>> On 8/19/24 23:42, Mohamed Khalfella wrote:
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
>>> index d0b595ba6110..377cc39643b4 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
>>> @@ -191,6 +191,7 @@ static int mlx5_vsc_wait_on_flag(struct mlx5_core_dev *dev, u8 expected_val)
>>>              if ((retries & 0xf) == 0)
>>>                      usleep_range(1000, 2000);
>>>
>>> +           cond_resched();
>>
>> the sleeping logic above (including what is out of git diff context) is
>> a bit weird (tight loop with a sleep after each 16 attempts, with an
>> upper bound of 2k attempts!)
>>
>> My understanding of usleep_range() is that it puts process to sleep
>> (and even leads to sched() call).
>> So cond_resched() looks redundant here.
> 
> This matches my understanding too. usleep_range() should put the thread
> to sleep, effectively releasing the cpu to do other work. The reason I
> put cond_resched() here is that pci_read_config_dword() might take long
> time when that card sees fatal errors. I was not able to reproduce this
> so I am okay with removing this cond_resched().
> 
>>
>>>      } while (flag != expected_val);
>>>
>>>      return 0;
>>> @@ -280,6 +281,7 @@ int mlx5_vsc_gw_read_block_fast(struct mlx5_core_dev *dev, u32 *data,
>>>                      return read_addr;
>>>
>>>              read_addr = next_read_addr;
>>> +           cond_resched();
>>
>> Would be great to see how many registers there are/how long it takes to
>> dump them in commit message.
>> My guess is that a single mlx5_vsc_gw_read_fast() call is very short and
>> there are many. With that cond_resched() should be rather under some
> 
> I did some testing on ConnectX-5 Ex MCX516A-CDAT and here is what I saw:
> 
> - mlx5_vsc_gw_read_block_fast() was called with length = 1310716
> - mlx5_vsc_gw_read_fast() does 4 bytes at a time but the did not read
>    full 1310716 bytes. Instead it was called 53813 times only. There are
>    jumps in read_addr.
> - On average mlx5_vsc_gw_read_fast() took 35284.4ns
> - In total mlx5_vsc_wait_on_flag() called vsc_read() 54707 times with
>    average runtime of 17548.3ns for each call. In some instances vsc_read()
>    was called more than once until mlx5_vsc_wait_on_flag() returned. Mostly
>    one time, but I saw 5, 8, and in one instance 16 times. As expected,
>    the thread released the cpu after 16 iterations.
> - Total time to read the dump was 35284.4ns * 53813 ~= 1.898s
> 
>> if (iterator % XXX == 0) condition.
> 
> Putting a cond_resched() every 16 register reads, similar to
> mlx5_vsc_wait_on_flag(), should be okay. With the numbers above, this
> will result in cond_resched() every ~0.56ms, which is okay IMO.

Sorry for the late response, I just got back from vacation.
All your measures looks right.
crdump is the devlink health dump of mlx5 FW fatal health reporter.
In the common case since auto-dump and auto-recover are default for this 
health reporter, the crdump will be collected on fatal error of the mlx5 
device and the recovery flow waits for it and run right after crdump 
finished.
I agree with adding cond_resched(), but I would reduce the frequency, 
like once in 1024 iterations of register read.
mlx5_vsc_wait_on_flag() is a bit different case as the usleep there is 
after 16 retries waiting for the value to change.
Thanks.

