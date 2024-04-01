Return-Path: <linux-rdma+bounces-1710-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E209893CE0
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 17:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E93D1F22ABF
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 15:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C7E4644E;
	Mon,  1 Apr 2024 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="lmpKvegl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2097.outbound.protection.outlook.com [40.107.223.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C98208D1;
	Mon,  1 Apr 2024 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711985676; cv=fail; b=mXLDVXoDIQVeEG/atzaY3HyYTy0dUcvTt8njfFotcNVCNSe+hFj/0JvAHbm+F5w9mt88kfJqKLo7DBD6BFVOJYGSqWCsprmyAAYi1AhiBBntv5gIYnM6xPzuwshtX6sAkVxIeqTNF1Iw+0OXhQ4R5aD1X6Xt00jNIOoqReT1nck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711985676; c=relaxed/simple;
	bh=dQMMo1Jvm2iva8u9t0WuMDA+CX7pjvb6gUeIGOj34/M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PQwNAx/CncplWCsKOFWfftN+PikkmRhfB8UHBRSInTHyNfnRNtdMjUJ+mIATAgEHOtxixawrKzYj5gb9JckJLai2OwtsisISYEE0TunpScMaMcLPmhUia0pxip3xVrApGcpcCPoEGH+9GWR7k6LEL3OApM5xoVHfbq0+Hw69Vec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=lmpKvegl; arc=fail smtp.client-ip=40.107.223.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgIsGjotd+DKEg2NQfkNcfzpvdI5ZpJJCVWdsSOI1e8068E0zWBxJsmuEf78hiq5rZLgMIBvRAQWqrrgsMnXIJjn+CnNB/w4szNa3Fty4XKFOE5h/OVRNjtdq1Qt5cMtqqgwR5FFmH7Pr8Ov6LgIaOPJ4hrznMkx1/uP8pcjuMQWUmCxLSF8IlARy0h6dNTTaAf02fSLvaqUItUlAOWT1YkIpQY6Xbl3te2L2w4SzDeQq0Y8F0cqOO+52LXu+hh3Q4Z8BJNcePm1NL9bPRe7OC+IZyTUFILYOTaeAmgWUxRQeh50guDz2CbTxHw5i9mxg8v4RaFigFAxYl1jD2h6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccXKZNM9HZwsMa6/nfRcsF8JK2K/VVNjF7fWNm7U+3s=;
 b=JQrAkm2LDHPthBAtQZakXAClk9rbX7siiv+hnJTQCad2t/WJi2lRon39LFeh/IIy7v3+NQfScv8spbxa8UkNwTXnH3UI6H0LlrEQWDOU+yoQmXMIYzOT7bY4dgOlZlVwstD6dt4LN6ItBjwn6xf2xXDg/OrTaSjmkpU5GxJ1sRntT9ntKk15FrIr9bOlocQsbfIOqdRZNXhCAxu9BX4vqSQQs/SFiQkw8oKZSL57pyrr+7rmem4i7lGpNVFSvCZbkKTqPj/XsRvsCxrz/junJEXKwjHC9NIPE9FDzjz4+SU3c1iZJPQtXEa+Br04qRMnTGOcMynbjsi9SnSWHznSuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccXKZNM9HZwsMa6/nfRcsF8JK2K/VVNjF7fWNm7U+3s=;
 b=lmpKvegl61FvsglbGsHAKpv6v4Gfc+YE0/MhPikanQ0lJ0jUDc5lXmOofMPnreS2+QV95jJsXaozCR+uqQtRJwOYqkXKT7CtBuH9AIRrdVpuZwtIN/hTFjj6KEqjCbAaEkG+SsMCgSy9VzEG9EefIqbCYUxNMkAnKcT8Qzn/xRqCzrUJFxo1gus9x8TLXC3t/8mARYRfoI8jTZvG/+ddgfTJWHZAnSExeLvCA4yCArAO7vDl+mnPeKFR7SeqQJj1/9w9g/gJHgCC+DMbhmI2nG4/toJ5SshZk8chg66zwZZbtZIoxF0kmbN6APOrhs4z+d2pC+loBkoTZjYwp7VPDQ==
Received: from SJ0PR01MB6158.prod.exchangelabs.com (2603:10b6:a03:2a0::15) by
 MN0PR01MB7635.prod.exchangelabs.com (2603:10b6:208:377::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Mon, 1 Apr 2024 15:34:27 +0000
Received: from SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::82ae:ed8b:de46:cff2]) by SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::82ae:ed8b:de46:cff2%4]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 15:34:27 +0000
Message-ID: <2453e7d4-fd50-42ae-a322-490e7e691dc6@cornelisnetworks.com>
Date: Mon, 1 Apr 2024 11:34:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] IB/hfi1: allocate dummy net_device dynamically
To: Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 keescook@chromium.org, "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240319090944.2021309-1-leitao@debian.org>
 <20240401115331.GB73174@unreal> <20240401075306.0ce18627@kernel.org>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20240401075306.0ce18627@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:208:e8::45) To SJ0PR01MB6158.prod.exchangelabs.com
 (2603:10b6:a03:2a0::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6158:EE_|MN0PR01MB7635:EE_
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A6akYaRKHYm28PMqkrvNng7A6RlVogYR5+9db9iEBuZx0vwCG/IU1Ce7kqO4jxqbvMIDJrZfVovvKl1BE15DYLWE0FWDTVyNk2nJThbmrj28XXfZCdo2zQ31XMDbqGQV3bGZM1R4AVFZhpUsQQC7eK1isXyUN8/dVZ0EZ8fvhjiaLUKLnCtfJeBoCLMBfwaI/o8w/YvE2c8frznHRzW4MO6LZGZTqRsAbeT52uV5C440AV3jolQ4XOz/Oe01YD4nCA5HayAeIrd6gXTBKvDWLRqm6Yp45EIY73iOqBQwJpy5g2G3umFD/2TXLbuXPyETRvKQrYLSjMkInUhH2UDEGirh/h1gEl2xVhFzJfFZUhTQllIBy24jp7m7XIJSWcPUt4ZYkzLcSPRYbiWOpude7mlTBBJL7L982df8wrPiZY4qNUIZMFSnhp/wN9K+GprD61xr15DdM9sFUyj8RtbzihZH/pLZ5+4OvHUI1ayzLOKnrAswQYgTI2TcG8R52Z2Dv5qT95cfgISJPuO6gD9MbMeX0aQQwrPbmE6nEl64lwg4O8e5fkYjsh30xmVF7bTx+RHL+AHPoNCIYECkbPzfj48xSS+wCHddd17MxhHdwfkwFrw1KeId8RYe8D9/mxZ503w2vSp6hEYU6gGfIX6dLzFG5I5IMHum/1dQC8GsM8s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6158.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmR3aEJBUWNlL3p2c1BpYjMvQ2NFOVdHWU1sYjQyQmhkQ0tSeTVYZmxQVXZ1?=
 =?utf-8?B?bHF0MGpXdHhaUk40ZG12STJGVlp1VThQQVU5cktORk0rOHc1ZzFkRWpZR1Q2?=
 =?utf-8?B?Wmx6cG9LT3lNeVV1NTZhNUZZa24vYUZTeEQwaXRwUDh6TVZVYVVRT1NqbGFv?=
 =?utf-8?B?NlNHbEx4M3JjMUZza2dQUmVtVW9EaGFqaWNYQ0RyTEpGVmVoaEJmM0JBRmlF?=
 =?utf-8?B?UG5jWGZyQWhGMUJFdG1HRm13c21WU1UwZmpGemZjNUNaUTBBWXJMSkxrM3JM?=
 =?utf-8?B?VlAweWw0LzQrejR2MkVZVEwzcU9Ia2t1bDBzOWRDS295RDkvVmVDMmFlN0hY?=
 =?utf-8?B?K01yRnJLQ3hPdnJBWVIyRTFKNFBiT2N5UXdFc3VPN2J1dVJFbHZ0OUJPbk1D?=
 =?utf-8?B?Rm5kbWNySEpLU0lPWjZpNzV6VmczTStoSHNHOG5xMHVQakFrOVIvOCtDYm0w?=
 =?utf-8?B?Vkx4UGoxeHhxekVXeUtWKzI3Qmx3SDFOZkxSQllQbU5TU1ZkdUN1YW5pdUFP?=
 =?utf-8?B?WDN6WTFBbElYUU5Ld2RTSnR4QUZXem41b04wT3dKYnlKanB3ZXRMRGVyMUlK?=
 =?utf-8?B?azlhc2RibG1YWEp4VkJsUnNwZ1JpVnlRZ2FYeURyc1QwU1VuTkdGdzVBMFgr?=
 =?utf-8?B?dFlyaG9zcm9VRWhibTJPVnhyM2cwaWp2TmFhdHFDR0hZdUU2UnlYNWhEZDI4?=
 =?utf-8?B?MGZCeExrTlFyeWY2K3lVbDNuUmpib2lhUy8yaGdxNlVnODllbUpiWHY0VHRV?=
 =?utf-8?B?akd0ZUN1QVNKQWl2OTkyQ084S2QySjd4SUhRV1lROEpBa0d3dkVmTkRRVWdU?=
 =?utf-8?B?dWxpK0p6WHVLb2dXK3IxNE9lcUwzK3pSY0hpMHFuRXRKcHNWdjBCejR0YTF4?=
 =?utf-8?B?dWI2ekJJeXRMNGhGeXhZUWNmUnFzMk8zZkJJbGprSnFEUWovQ091L0tFOGwz?=
 =?utf-8?B?TjZIZExFcmM4UFFzaWkrN0t3QXNjRCtKZU8xemN2d2R4dmdOZklRUU5MQ2Jx?=
 =?utf-8?B?dU44VGJCblJsdXl4eWYwRVk4VWpNOUg5bCtNdlovWHZORnRvSElETXp3c0Nl?=
 =?utf-8?B?YlBxb1lHVkVFUE9jSldya2UvN21Qam1IYWdPaVRINDArajVuUEVhSk51QUJn?=
 =?utf-8?B?YjB4dXl1M0UvS25KZHlQVGs4V3BtTHprNFlpNzNvaTk4OHNYZzRCUzRVVGM5?=
 =?utf-8?B?UncrcXZYUnRVazRua1lOck1yK3hib05QT2JnR3ZYU1pBMnZNWDh5VHRPQjI0?=
 =?utf-8?B?SExGQUYyanhsRGp1enpMaE5YQ0xxUWFEdDd5WFovenluMlVlT1JBc2xKZGx1?=
 =?utf-8?B?ZkFmMkdidXprUEUrdXluVFlUbklEcDVtWms2NkFSQWx0T2JaT2NoSXBYV2xv?=
 =?utf-8?B?cHVGZDJlMlRlUXRleDVpNklySkFYRlpCVXhTM1lDNXF5MFlnbFZaTlAzRDJR?=
 =?utf-8?B?Rkx4Ui9FUzNQVHNPblFNMllnaDZLVHgxWkwvNmRURTBYWHNKdXMvSE1pU3Ur?=
 =?utf-8?B?RGs3cTgweG5NQ0NzWTFKN01saHZvMmZ0ZDRVajI0aHAwOGJZcG1IRnNMQW8r?=
 =?utf-8?B?S2cvaHdOQ2lUK1JqdnFCRjNHZGJscVdCM2RTY0dUNkNMamJjK3BTSHFoTDBn?=
 =?utf-8?B?ZXJGN2hjTThVaVBuQVhUc0tWMGRUOGRNZEJPdlB1amZOSjl6QnJqSlRGT09T?=
 =?utf-8?B?aGNveStZS1R4NjlTUERqMmQ3cW9ET1hmazlGZnd4VWp3b3R2NDROSitST3k0?=
 =?utf-8?B?ZHkya2lmUnNzbXBlZjNYRUJPcmkvSjNBNDh4cGFYenQ0VVI4aUMvZUovNDl1?=
 =?utf-8?B?Lzgza2p3UTNzRlFrRy8rRFdMdWkrV3hZVnlsbTFmNUF2anZFNG9oSTFYc2ZO?=
 =?utf-8?B?OGdNenMzU0R1V2xzNWNvbjJiMVdMekpIWDJrZW51aC84ejVMc1FwSGE5Vnlx?=
 =?utf-8?B?NVgyOExIYmxHNTJhWVhYY0pKYkdzczFzZ3hXOGgxQVdGSGJub3cwOGFXQ0VX?=
 =?utf-8?B?Wk5KbWgrU2wzTmFCZFgvNUVWaGQyeDZvN2tEa2dXMDRDV2xNTnQyK2Q5Z3Ry?=
 =?utf-8?B?MHgzVlNncUJmYTdVQVBlbWVuaE1nZmhBblFHU1hxSGl3QVBHM1dYdzlRdGFK?=
 =?utf-8?B?MFcyTFBwVlphTjVhS04yWVAwL0dGd282Rm12UUVRYURQUEhEOFUvRUR2blov?=
 =?utf-8?Q?ScRB4h1HUMOek8QpuWLLjSY=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7533148-aa2b-4e60-25a6-08dc5261372c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6158.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 15:34:27.2795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcRbU42ZXTWJSUIZ4MloM7WqljQ9chtbSqchpvxvx6Htg6SyxFjK5tVb2iTixq3KsCXMbxKnYx0e7Bu1NgmuI/YBYcXidzpyIYwayaZUoeYDdIL8uFpxB2qRhO1ZNVP9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7635

On 4/1/24 10:53 AM, Jakub Kicinski wrote:
> On Mon, 1 Apr 2024 14:53:31 +0300 Leon Romanovsky wrote:
>> On Tue, Mar 19, 2024 at 02:09:43AM -0700, Breno Leitao wrote:
>>> Embedding net_device into structures prohibits the usage of flexible
>>> arrays in the net_device structure. For more details, see the discussion
>>> at [1].
>>>
>>> Un-embed the net_device from struct hfi1_netdev_rx by converting it
>>> into a pointer. Then use the leverage alloc_netdev() to allocate the
>>> net_device object at hfi1_alloc_rx().
>>>
>>> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
>>>
>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>> Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>  
>>
>> Jakub,
>>
>> I create shared branch for you, please pull it from:
>> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=remove-dummy-netdev
> 
> Did you merge it in already?
> Turned out that the use of init_dummy_netdev as a setup function
> is broken, I'm not sure how Dennis tested this :(
> We should have pinged you, sorry.

This is what I tested, Linus 6.8 tag + cherry pick + Breno patch. So if
something went in that broke it I didn't have it in my tree.

commit 311810a6d7e37d8e7537d50e26197b7f5f02f164 (linus-master)
Author: Breno Leitao <leitao@debian.org>
Date:   Wed Mar 13 03:33:10 2024 -0700

    IB/hfi1: allocate dummy net_device dynamically

    struct net_device shouldn't be embedded into any structure, instead,
    the owner should use the priv space to embed their state into net_device.

    Embedding net_device into structures prohibits the usage of flexible
    arrays in the net_device structure. For more details, see the discussion
    at [1].

    Un-embed the net_device from struct hfi1_netdev_rx by converting it
    into a pointer. Then use the leverage alloc_netdev() to allocate the
    net_device object at hfi1_alloc_rx().

    [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/

    Signed-off-by: Breno Leitao <leitao@debian.org>

    ----
    PS: this diff needs d160c66cda0ac8614 ("net: Do not return value from
    init_dummy_netdev()") in order to apply and build cleanly.

commit 1e06cffe69e6519f8ede42c60f13ad3a7ddb09b7
Author: Amit Cohen <amcohen@nvidia.com>
Date:   Mon Feb 5 12:30:22 2024 +0200

    net: Do not return value from init_dummy_netdev()

    init_dummy_netdev() always returns zero and all the callers do not check
    the returned value. Set the function to not return value, as it is not
    really used today.

    Signed-off-by: Amit Cohen <amcohen@nvidia.com>
    Reviewed-by: Ido Schimmel <idosch@nvidia.com>
    Reviewed-by: Jiri Pirko <jiri@nvidia.com>
    Reviewed-by: Simon Horman <horms@kernel.org>
    Link: https://lore.kernel.org/r/20240205103022.440946-1-amcohen@nvidia.com
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>

commit e8f897f4afef0031fe618a8e94127a0934896aba (tag: v6.8)
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Mar 10 13:38:09 2024 -0700

    Linux 6.8




