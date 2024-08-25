Return-Path: <linux-rdma+bounces-4561-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0286995E1D6
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Aug 2024 07:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73DF51F21F69
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Aug 2024 05:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D112AD29;
	Sun, 25 Aug 2024 05:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YBVas4d6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A252F3E;
	Sun, 25 Aug 2024 05:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724562745; cv=fail; b=OAKX0l5ieDxzNRvGMzq+Q9Ry20Tf9Y8qbqb/6AE/9TWABL2cTI7SyI4Py4R7ZQrqywPa634IRthb1DP+GQ7/SVHCmAqyXkqeQkPOPYs5XScyMM6zB/SuhL4cY1dQmUV3Y6U2SQUjAahDu4RRUS2xYPj0ECa8pEVqi7iJao1/9AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724562745; c=relaxed/simple;
	bh=nNNQQEmXdOqrzfn8/0mfBfTaPkLxy9u4Y273kJ8nY3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bSaMOhxNt0jPzPJKDQ0Wg9wI0XQmPwh4u+n8OwsaTdjAvwOa+DZfMuKX2NZl3ZMjecC/vY6aLwmymHfgZGjZL4tRVigtEcUDGwW/lvVvbIwgEJhwNue6UPwTNSwWymq+4dFqDjh+hNyMUZfmqCJKetWU6WijZimWkfKRCNznPZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YBVas4d6; arc=fail smtp.client-ip=40.107.102.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ui0d5XFneKHtuaYn/W0NZKZD0u4Gd7xqgjUfE7ROW0PgBTxiWrLxCK+F7Gmgi3PQFHgTuoPGufPl9BJNZbCABmKlXoNurgJ/sQd7w22Md05Zjcmz/MPwwM8BhKF41M7HiKaZGi5eDupXmW64+ZkQcjEBRtngz3r+nmnjvPLQqMM19yKPUcLxttrUTqU9B7fGlGAbdIPOO332ZXDP2lOxSURNB1A7B+C1hVW7wJBQzA8iN/Fb9ZoUGaMBMM7WE2oh03AIZv5KVBWs5FiwBYjULqCT9wSGfGEJ4Ca2zcDRZ26o62jbZwKXeoIfU+IBrzsueBmXJaxxfyK59hch9L2wRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxFPAzPNDgQLuLlX0TNu3l4HZsQq0Y4KyEKMqOBQ14A=;
 b=e4UDRcP/eCpzzcFDZXEhAesgeEL8ou8a71UhQcNP8IMpXHAXvIrshjTt0781ytymZhy0GoCnAmVSgh1GVcmLJ8HY1gfSpV490cTYibUr3VVIFdFdOwUzXJ5JhBWUJn+ijnERaxXvjdD3/wMk2oH3okursGxHF4dbHTzw4U07XhZ7//yTjdG2NnFF9cVjdTE0EoaCoyoddVRCkb80sUaHjmSLftwI2lqqJiHa6ZKAd3UTNPSoMiRjErt0csTuvV2IXNh7jXKXat6rijBNgA+p6XwmhGIkPTV72apY4HN294MXauEoaaPxMxEo5dg50awVLzmhhGKD/JupN6oC0E4k/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=purestorage.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxFPAzPNDgQLuLlX0TNu3l4HZsQq0Y4KyEKMqOBQ14A=;
 b=YBVas4d6s1LeIeHqFjDlU9iql8gxjOCIM+qdJF5E86HO9gNsUBZylh+dNqutTyGvoGmt7H/BFOyPjUdTEcm9gASk+Zl7mQdcsOLGld+wXJKUFDVxaaX9p1sD5f+3KLTkPx40USlzGZqkAyTUPBKmJ72yJoGXL2z15CFrxokDxnJRIkV8E6IRH1pEOH46c3u3sLgkUfGzW1i9m6vOdY04fO+cEA5zpSHBKY8Z1Mn0frlCXQX8oYB/2+Yakk0bknv4QKwA6WWjjgySgeMfPGGw2HDGb3qpM/SAGp17dxeNc7BMSWv7ro02xW/UxNJCJ2MBQbq5CNv7mhzhqscl/QBuwQ==
Received: from MW4PR04CA0113.namprd04.prod.outlook.com (2603:10b6:303:83::28)
 by SA1PR12MB7271.namprd12.prod.outlook.com (2603:10b6:806:2b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.22; Sun, 25 Aug
 2024 05:12:18 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::2) by MW4PR04CA0113.outlook.office365.com
 (2603:10b6:303:83::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Sun, 25 Aug 2024 05:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.4 via Frontend Transport; Sun, 25 Aug 2024 05:12:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 24 Aug
 2024 22:12:07 -0700
Received: from [10.21.182.92] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 24 Aug
 2024 22:12:03 -0700
Message-ID: <87db0354-a732-4920-8b7e-0890abe5389c@nvidia.com>
Date: Sun, 25 Aug 2024 08:11:56 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Added cond_resched() to crdump collection
To: Mohamed Khalfella <mkhalfella@purestorage.com>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Yuanyuan Zhong
	<yzhong@purestorage.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shay Drori
	<shayd@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240819214259.38259-1-mkhalfella@purestorage.com>
 <ea1c88ea-7583-4cfe-b0ef-a224806c96b1@intel.com>
 <ZsUYRRaKLmM5S5K9@apollo.purestorage.com>
 <ea86913b-8fbd-4134-9ee1-c8754aac0218@nvidia.com>
 <Zsdwe0lAl9xldLHK@apollo.purestorage.com>
 <1d9d555f-33b7-4d95-8fbd-87709386583c@intel.com>
 <5fc5d450-b77f-40eb-b15d-33939719a124@nvidia.com> <ZsjJwcKAaKRyEHuU@ceto>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <ZsjJwcKAaKRyEHuU@ceto>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SA1PR12MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b5cde7-6435-4dd4-8fc3-08dcc4c47e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWk4VFFiV3YxcStqSXRrbkJyWXhFTHkzMXhDdUpSaytpK0poUXVjWFlPQUNZ?=
 =?utf-8?B?RlEwQWViTlVwd3E5azR6K1RhVS81bGpUcm0vanFjdkZaeU5nNjNZL0gwemFm?=
 =?utf-8?B?K0dFSzJSK2xuUzk5RGQxQUltNmZJMWpwcXFzUU1BcG5NRW9DNS82aDVnMXlm?=
 =?utf-8?B?YWhFWGs3U2R3NUgvMTljSUFBZnpZN1V3c210U2h6djhmODdoQ1E5MDRxb2Fo?=
 =?utf-8?B?em9QclMydjZORmF0aWZLaTduYTNlM2lkWnpFN25iMkJIWi8xNFVwZnNRVWx3?=
 =?utf-8?B?eFYwaUNldFhkd0pCWnVDRlI1TzA5S1Z3ckpFSXJvSWRDM01jRXdWSmNwS0h1?=
 =?utf-8?B?OGtpRGpjcW9GQ3YzaEM4czlRMUYwT1EzZ1E4cFI3UUhHcENmYjVTOVozL0ly?=
 =?utf-8?B?VlNZeEo3MnhHalZzTmNDNmFLQWlRNnArbjZEVm1TUnNYck5hWFBSVHF3UmVL?=
 =?utf-8?B?QVNmOVpGWFpEZGhJQjNPbzBUcUN4MzlzRnpwUkRhY2M1QkVSTDN4YVJrNEhU?=
 =?utf-8?B?ai9nTE1XQkF3L0xhRUNaL3ZuUzBWVTk0M3RnMC94TmtQVVU3Q3lOb2M5K2Z4?=
 =?utf-8?B?OGpmdmRBdXpMMUc1bGVadVhKVmJ4eXZMeFVwVEpMVjZ1OG1RK09COTJDL1Vq?=
 =?utf-8?B?SW55Ulc0WXcyZzV6cStyKzdPc0g3Z3pta3RHY3VOWko5ZkVyL1EvOG82SWlX?=
 =?utf-8?B?VFp2ZjhmMGxSVitoWmFOMlNUUnk1TDdNanFXbWZvNnlPaGxzWG1mTlhzSFl5?=
 =?utf-8?B?UW1KUENra05iVDhVeC9qQ1RrK0I1aVBxNEZmbTd4cFJtaWwrazk2OUFkY0ta?=
 =?utf-8?B?SjROZUF3TTl1QTcvU2V2Z2lnQ3JHK0VmQWpkc3FIVmdyZjdtSExWTjBWeUlH?=
 =?utf-8?B?c2Z1aFhDNm1iK2ZRL1dITXV4eC9vQjlkOGxqY2MyV2lyMnZXOGlJQ1RSbno2?=
 =?utf-8?B?UzQ5SlZVaE5yOEtSU1FNSktvZlBUaXNyQ1FZZWM3YlRzSFBmbXJSYlBiWkRP?=
 =?utf-8?B?QmdRWnlhdmZjLzlPVk9iMFpudlRlWHA3Q1B5LzV1RjlUZFBZUFFIR25paGE0?=
 =?utf-8?B?TTVqMUdOT2pCUWJ1bm1LN1g2UFFNR2FzOHFDUlNpV3J4RVRjSFhxS1loNTA1?=
 =?utf-8?B?dHphN0lrUGdiSGFreW9IdXpxRUNSTnI4cmJMcFBERnBXMVZJaENndE10S2Nu?=
 =?utf-8?B?VzM4K2xhbUJZU0VOTlloc2FmMUdRTks3OTRPY21tVysvUW1ka0k0ZGdzWWtP?=
 =?utf-8?B?eHBnUWZONU4zT3VWTmNvM01jbjJHYVVCamJFRGFaYzF0cENPbTBFd2FHcmRV?=
 =?utf-8?B?OC95WUExRUozU0tWUnROZkNDNmpEQnpnU3V2MFZoYk0rd1hFWC9zWUxQM0Rt?=
 =?utf-8?B?ZytBZ2pyY2V4VXBwM0c4L2daSjlLeVN2ZWU2dzFHVmFDVzNaazZDZ2xqSWx6?=
 =?utf-8?B?K2VwS2s1N1BzV29EWjF3MkczdDh5RmhSMDk3SGM3eFdGSC90a1hNT3NmWWVN?=
 =?utf-8?B?b29hdWpDTG9obFNHRkNlbVFHVWdpMzNRSzViZ1pBdGhCaDBzK2p4Tmp3c1Qw?=
 =?utf-8?B?TmFpY0pGTUxlSno4OURtUmxpOFp2Y3lkYWY1aS9vSjBQVDlDZUgyalJhb0Nw?=
 =?utf-8?B?S1N6d1VWSWZrelhOdmVQeHdyTzV0N2VuZDBHRkd6am93cVdxaWNCL1BQc0NI?=
 =?utf-8?B?b3h0cFBnTHpWYUhoUmxvc3pEQjMxOS9xTjhKUWk2RXhBaEJnTzZvazlGS3J2?=
 =?utf-8?B?UEY4Q3Z4RndNZkV1ZjVtT3VUa3h6bTU2ei9Ba01hOE1aTC96dERPb3YySHhx?=
 =?utf-8?B?NThGd2tHK0VvZ0taQ2RabS9zS2M0MHJFTWliRUZ3UXBpNWZxY09DRjdKU2ti?=
 =?utf-8?B?dlp2Y0h4Wk9MbjNIS0QwZTJmTkUrMFNvaytxZEpTUEljNXpmcmx0Z2F5eFR1?=
 =?utf-8?Q?vJK4R0qZ72fTibpLx4Ok7RoZSwrmOd5d?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2024 05:12:18.5788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b5cde7-6435-4dd4-8fc3-08dcc4c47e0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271



On 8/23/2024 8:41 PM, Mohamed Khalfella wrote:
> 
> On 2024-08-23 08:16:32 +0300, Moshe Shemesh wrote:
>>
>>
>> On 8/23/2024 7:08 AM, Przemek Kitszel wrote:
>>>
>>> On 8/22/24 19:08, Mohamed Khalfella wrote:
>>>> On 2024-08-22 09:40:21 +0300, Moshe Shemesh wrote:
>>>>>
>>>>>
>>>>> On 8/21/2024 1:27 AM, Mohamed Khalfella wrote:
>>>>>>
>>>>>> On 2024-08-20 12:09:37 +0200, Przemek Kitszel wrote:
>>>>>>> On 8/19/24 23:42, Mohamed Khalfella wrote:
>>>
>>>
>>>>>>
>>>>>> Putting a cond_resched() every 16 register reads, similar to
>>>>>> mlx5_vsc_wait_on_flag(), should be okay. With the numbers above, this
>>>>>> will result in cond_resched() every ~0.56ms, which is okay IMO.
>>>>>
>>>>> Sorry for the late response, I just got back from vacation.
>>>>> All your measures looks right.
>>>>> crdump is the devlink health dump of mlx5 FW fatal health reporter.
>>>>> In the common case since auto-dump and auto-recover are default for this
>>>>> health reporter, the crdump will be collected on fatal error of the mlx5
>>>>> device and the recovery flow waits for it and run right after crdump
>>>>> finished.
>>>>> I agree with adding cond_resched(), but I would reduce the frequency,
>>>>> like once in 1024 iterations of register read.
>>>>> mlx5_vsc_wait_on_flag() is a bit different case as the usleep there is
>>>>> after 16 retries waiting for the value to change.
>>>>> Thanks.
>>>>
>>>> Thanks for taking a look. Once in every 1024 iterations approximately
>>>> translates to 35284.4ns * 1024 ~= 36.1ms, which is relatively long time
>>>> IMO. How about any power-of-two <= 128 (~4.51ms)?
>>
>> OK
>>>
>>> Such tune-up would matter for interactive use of the machine with very
>>> little cores, is that the case? Otherwise I see no point [to make it
>>> overall a little slower, as that is the tradeoff].
>>
>> Yes, as I see it, the point here is host with very few cores.
> 
> It should make a difference for systems with few cores. Add to that the
> numbers above is what I was able to get from the lab. It has been seen
> in the field that collecting crdump takes more than 5 seconds causing
> issues. If this makes sense I will submit v2 with the updated commit
> message and cond_resched() every 128 iterations of register read.

Fine with me.
Thanks.


