Return-Path: <linux-rdma+bounces-1394-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 054AD878AAA
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 23:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F00F1F21EF4
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 22:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7988E57861;
	Mon, 11 Mar 2024 22:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="JEJ7bO0F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2139.outbound.protection.outlook.com [40.107.237.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411EC5730E;
	Mon, 11 Mar 2024 22:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710195738; cv=fail; b=PCMmMiiWnDbalx5T8Dt3ldbOsjUarhwdDeQvaL/n4y2kQtVE9kVFO6u34d1TbQ7ut2A8G7AwJtk0t45vVOcDlEJSBVDHinHrAVqlZhL3zxpZcKPyMIOEAxBiFvKxj2gSvX+L4AI9fUy4S7QodNUp09JmoIINA+AgsCzoqz8jkeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710195738; c=relaxed/simple;
	bh=jBhrxMRkKHeA6DIYU+nG0bSzKcJat+KJZW6uZckvkyA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kufnn6yokilc+MLqqOg/BVWKuivqEYByTpWvWJutcxo4QBCvCWtVMAzrLdqzwgwVLOhjvCtzh3Cc8AHt4/0PxIB8M3rEETYnsfQ6hfk3sCX1vh0PCqhRrAoDrSBV5kRTWdyxIrJjPH0RH+V0bENvNTzx6fPVLrG2qgU/Zkim8PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=JEJ7bO0F; arc=fail smtp.client-ip=40.107.237.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYh5+b/zfCjjsvVDUQfEDMn28XL/3jp0u/QBZF0Sko2ALsvQ9jOkCm7LcSNdsudrtNt4/oZRgMZ8lTaftgIF1HdOIHLtNnW0MjvnvMmG6MR3qxZfMQZFEKFEoxYj/LG2OfVa5PwPhMibSfFdKo57Y06AF43SpktbvGkOHCF2km7DA+iW6mYJZTuJKRUi9DP9cD1A3kctkU9TF/sjfJ6x68KUqk95dXSjnlyQvtZDDEbDwR8UE0ZtrT0Yt7Foz55khGp+qP3KSkJ2SUV7jdEaYijDfiPu35GiFm/5ji+7YyPUjU+rSYpkISsJItKnBjw8pNUHzbiR+kD0ErwhXKhA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TS5XDHhxVAeG0Q9cr4o02OIrFkeWzxS8OLPEM4eu2g=;
 b=c6JHh8nZo8JtkalvVGxxWIbye2AFkis9uWSSbxX4kHlue6cTncMpB71Ouyi5EH3u6ok/5kO0c3U0D65u1T/iYjlH4vee+pHogOpDWq7d1dM1dZSyFjTi5rIJHTeHmoNGCgTywo6jqgC2bLj9W/fSxwim/DDv5aiEIYhzInCjbKop0Of4aWQL3xLaqa/VJSUgAUH2yRnoX0xsze/088svS8lgwc5mQiQgJ2OVgcZFCeAPNpmBS5lm6en+CljMB49rAulcZUVoUAKkrh8E7WS71xVKlvUI65+yO4QqVdZpGwCPUv6yKhXiCMsDPzINtXT7GHMm6ZI6OXumFr7pblwGMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TS5XDHhxVAeG0Q9cr4o02OIrFkeWzxS8OLPEM4eu2g=;
 b=JEJ7bO0FW3lCtQspkV6vmfUr2IfdUZ0EfKNcIAgaojPhH3bj8PnfFdJAYomp6K8r88qNrLdtAQrh8O2v0QhGw3fOTZqSwYqakjgZiU6Jn56kq2OK9kdDbSMK3AR5krrOz3d9UuIG7b4J8DtjInQ/8d3Pueiy1j6A2qb89PZlE8FOL0uBNdS/QUFM4XfuMwm/BBdqXmSQbM5hXfGipHDAkMmD9+38ZzuLoPYr8jok9i+suSYZD/FYkg8XCbAcLuuEqnUQ/asVaB5bfkcV3CkWQ92m/+936XWvBsoGeBVq1GcOgOCKF2QaE7rPden8nooRL/GAdTjBOubZwLR1a1N65g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4817.prod.exchangelabs.com (2603:10b6:208:7c::31) by
 DM4PR01MB7716.prod.exchangelabs.com (2603:10b6:8:68::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.34; Mon, 11 Mar 2024 22:22:12 +0000
Received: from BL0PR01MB4817.prod.exchangelabs.com
 ([fe80::b62f:89e4:967b:47ff]) by BL0PR01MB4817.prod.exchangelabs.com
 ([fe80::b62f:89e4:967b:47ff%6]) with mapi id 15.20.7316.039; Mon, 11 Mar 2024
 22:22:11 +0000
Message-ID: <7d7f80fe-ceea-4bff-a01a-f1b12f31fcf2@cornelisnetworks.com>
Date: Mon, 11 Mar 2024 18:22:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] IB/hfi1: allocate dummy net_device dynamically
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 kuba@kernel.org, keescook@chromium.org,
 "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240308182951.2137779-1-leitao@debian.org>
 <6460dd4b-9b65-49df-beaf-05412e42f706@cornelisnetworks.com>
 <Ze8j8yWyXCQtwcOJ@gmail.com>
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <Ze8j8yWyXCQtwcOJ@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:208:239::19) To BL0PR01MB4817.prod.exchangelabs.com
 (2603:10b6:208:7c::31)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4817:EE_|DM4PR01MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe8881f-60d4-4cac-3998-08dc4219b275
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wPef8q8Gfw56iunDNirzPA7qRu/H6WXE7RiqkT9QETiweIxk8Cobfw1iO1qHblnl/AsyhD+LjlTKC75XJ08/xa9aMoBDVZfHMNju2cYdLxpl3q3uhfUT8KNMFjTiSPPInx4OU7oABT02olVBFOVLmF6VbHR9DjhV+678x56Js5X2uuS/xFRRz+gT3W1WJfAxCVQgleJiRmKhUN8lXoU9o/SY1+1VgHQ9BTHln8/0EJqIkkrC7bQXEKKwVNzce2QrkZ5fXeuiY7aCGSXQARGY98rH5h6OlwDVkEshVZGoDCqyfLCqBfFUgVNQDRyMQYPfnzR+8LHej/+rVUUhhQx4FcnUjAhCLB2oB6Z5tLdGBR0wkd9D3sS6n/mJicctWcRjRWvILc/zz4lLyu7vtFktTMaElgcYORGCGU/ohuiihlPkIcsBbSF7AnPfq+W+Ylbovfyy/Plx00PucwFpouAkJ4qnR88ddl6lgJJJFZJXRvoEAphGDLSvJflP0utaJ/cs7JnJLremIF/aELz2ZQ1cH2kn+53Ea4vNV8Rb/CpwaJX/y4a7e+kkIUGoWhUxEe0/8lh3BH6l0HEaf/Mo1T9QvKjMz6OSgrVRanhNDuESAciLS2LsS8SKA91WXNrXAIxnqT9QSyeGBSe8hx9ID8eSIR98G9VgG24OYhrI6FRVLbk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4817.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDcxWlhxK2l2VktHelFKczdIbUd2dHU3WlZGYW5ET1pkdERYVk1MQXlUKzJD?=
 =?utf-8?B?dldnMk5QalNDMDhxQ3FUUWQ5S3ordVBTZ2Qxd3NKZ2ViZDNWQ2wxeWNISnZP?=
 =?utf-8?B?TXUySmNTMmFvOVhhVnBFTXNueit4MHo5c3RJdnhIS1I4L3RSZEorL2IrdlU4?=
 =?utf-8?B?QllnVUVnSFZ2c3UweGtwUFZ5ZnpNNTM0aTN2d3RodnFaVXBrbzMraGZLRDVX?=
 =?utf-8?B?S3RnTGF2OHgzakhVaXovb0kxKzY5WEVxclhwWXhoUVFzSTZLTVpVNDZnR1cr?=
 =?utf-8?B?K3FCTElJa0VuSzRuTGUvMU1jK2EzaHFicXhVeDZEYUZDZytRSzNWZ2t1YUgw?=
 =?utf-8?B?Q3piSWZpUzNxdTl5cW5kM3BnbjBNaWpJdFp5aml2ZlR3SHVqb0U3cG1iMng4?=
 =?utf-8?B?SStoZVVmaFhuTHB6eHk3OFU2T3VNOWMxb3ZoM0xRVVlhOFJ3clFwdkVCMTIx?=
 =?utf-8?B?bFhCckFoMFhGbDNodEdQak1BTG9Wd09CWjBxRFc4TUZhdkxFeHo1WGZ3Rndw?=
 =?utf-8?B?cVdyc1dvYTVNWHplSU1zaitnazA3NFBEU1ZmOExrQkpwRjJUMjlCRDFta3JD?=
 =?utf-8?B?SlZkRlRSWGVWVkFRWkpWVi9MSmprRjZLdC9VM25COU5mbmNIWWxhQnFyL2x2?=
 =?utf-8?B?ekhuNzFYd1ZoMm5CTTEzMlBxK1JpekxnRGlLL2hQS2VVcGZWT3BNWVFySjM2?=
 =?utf-8?B?c2h1YTdqcDZuN3ZrYUw4WFd5SWp1ZS9mdTNBaWk0S3NRbW5lSkEvNnNUWDQv?=
 =?utf-8?B?VmU2S3NxazJ3RTN2WFd6SmVEQmRESFgyS29VU3dpeXMrUFI0V1pFM1Qrenha?=
 =?utf-8?B?TGF6bnVpQm5WTTNIVzUvMWxTM1R3MEdMcTEwOGhhVVJqWlZScHp2ZHBhbllx?=
 =?utf-8?B?cjBZVkQrQkpQOWpMZFE2YThaZmVYOTVVMVorc3RPU2xYTm5xeDdlWlp5bi9w?=
 =?utf-8?B?VWFNYk9sQUlKWTFLS09OYTdCcVRMYnhNS3VCT0M5QUFlVVRRQ2dPdkg5N09a?=
 =?utf-8?B?QVYrYkoyRjBnNWRVbEhPdlNzd1BrMmxWcjI1R3ZVR0VlcTQvdEI1QUIrK29p?=
 =?utf-8?B?SUI3Z0RIbWNzM2NYclZpUldoTjJacytUTEdVYVBWOWc3Tjl0ekhwa3RlQW4v?=
 =?utf-8?B?c293MHAycHdLMnErcHpvSkFYaE9yYnlFZk5lL3liWjJJaGU5ZGpMcmRxTEdR?=
 =?utf-8?B?R0JVajk5ZEw1bjFocnRnZWVJaVZzcDZsY3ZxL2lubUdoOElhU1d3RE80ZG0w?=
 =?utf-8?B?TnhnTmFzcFM3QXVYYzdjVDBOQitnYWFwdkdycXBKWTRzSmZoYVN4Wi9vWUpt?=
 =?utf-8?B?VVAyNkwwbE5RMndkdlc1NTJPWFp1ZU1IdlprT3d1SGFvL2IyVHpKeGo3SVlE?=
 =?utf-8?B?WTZwUGNPZjU1Zzc4QTEvbkpFK2dBS09xakl2dVJXN0RjWk1HRnV3dTljelBr?=
 =?utf-8?B?c1V5bG1FUkpVRkFWUW02YVFhUkZxcHY3c0NYYXYyTXhQcHFxcXZnVG41eXhB?=
 =?utf-8?B?dVl4TGIvb2NadE5aaXhPSHAwQUJua29oVmtPb1VIdDg5OTNZd0hLZ0lUNTdn?=
 =?utf-8?B?R1FVbmh5aC9WSU5WbzE3TlJYbUQyV1prQzByZ0dUQ0Jjam9wcDlZa1FESDgy?=
 =?utf-8?B?cFNLNjlNNlgrdVRLSlJHU3BSaVA2MzZGK0cyTnpnK2xLUjNYdmdoOTV6Nnp5?=
 =?utf-8?B?dHFKd0JLQW52TWFpL1RKRnRuek04ZjdTbXR0NEt4S0RqVFQxaDJpT3FlTGxK?=
 =?utf-8?B?YWlhVVM1ekx1bHoxYUpVMmtINmJRU0xhT0pJaTdLYXhRMElBWVVSdnZIaHVE?=
 =?utf-8?B?aVF0dkFnZEhRMk1KdFFDL1NBR3c3bWNZMTlRZEVtVnlTemRuOWppUDJwbDlJ?=
 =?utf-8?B?OS92R2FMRGYwOHljYXZFdDRReThJUGNid2dKNENiSVJxYWc3eDBZcE1WMy9L?=
 =?utf-8?B?ckFNTVBMR2xkeTFESXlVb291U2tlMSt4R3JSSjRQdWJFWEFwdFVTNkUrcWxT?=
 =?utf-8?B?OFJQYXdkVXJjbFloY0twcy85Ukh0bzhMdjJKZVd5eWMvdGY2a2xGeG5WdlJk?=
 =?utf-8?B?cTBhYlp3ZFhreVFYbDBOZ0t0NDZJb3Z3VEdMTWovTGd1bWw5bzA2UkJpZmpU?=
 =?utf-8?B?aFlyRHc4eElZTGVRQXZtbmNBcVZYaURaWlFGQXBmd0VZcXY1U1lsYzlGQW8w?=
 =?utf-8?Q?sc0tf5BCuU6UwOmwHSTyJ4Q=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe8881f-60d4-4cac-3998-08dc4219b275
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4817.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 22:22:11.6485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jeg6REARDPnJ9TNOJMk64NZa3JHNsRBwR6qI3H6OkPk+eX6BWxT1fkPKfV1ARbl5VAtQ1/5V6fK1RUX0Hcb4zN0hE8gfLQW/Zo2nm7lFoS2UE779eRGPZ76ToU9/LC6t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7716

On 3/11/24 11:32 AM, Breno Leitao wrote:
> Hello Dennis,
> 
> On Mon, Mar 11, 2024 at 08:05:45AM -0400, Dennis Dalessandro wrote:
>> On 3/8/24 1:29 PM, Breno Leitao wrote:
>>> struct net_device shouldn't be embedded into any structure, instead,
>>> the owner should use the priv space to embed their state into net_device.
>>>
>>> Embedding net_device into structures prohibits the usage of flexible
>>> arrays in the net_device structure. For more details, see the discussion
>>> at [1].
>>>
>>> Un-embed the net_device from struct iwl_trans_pcie by converting it
>>> into a pointer. Then use the leverage alloc_netdev() to allocate the
>>> net_device object at iwl_trans_pcie_alloc.
>>
>> What does an Omni-Path Architecture driver from Cornelis Networks have to do
>> with an Intel wireless driver?
> 
> That is an oversight. I will fix it in v2. Sorry about it.
> 
>>> The private data of net_device becomes a pointer for the struct
>>> iwl_trans_pcie, so, it is easy to get back to the iwl_trans_pcie parent
>>> given the net_device object.
>>>
>>> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
>>>
>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>> ---
>>>  drivers/infiniband/hw/hfi1/netdev.h    | 2 +-
>>>  drivers/infiniband/hw/hfi1/netdev_rx.c | 9 +++++++--
>>>  2 files changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/hw/hfi1/netdev.h b/drivers/infiniband/hw/hfi1/netdev.h
>>> index 8aa074670a9c..07c8f77c9181 100644
>>> --- a/drivers/infiniband/hw/hfi1/netdev.h
>>> +++ b/drivers/infiniband/hw/hfi1/netdev.h
>>> @@ -49,7 +49,7 @@ struct hfi1_netdev_rxq {
>>>   *		When 0 receive queues will be freed.
>>>   */
>>>  struct hfi1_netdev_rx {
>>> -	struct net_device rx_napi;
>>> +	struct net_device *rx_napi;
>>>  	struct hfi1_devdata *dd;
>>>  	struct hfi1_netdev_rxq *rxq;
>>>  	int num_rx_q;
>>> diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
>>> index 720d4c85c9c9..5c26a69fa2bb 100644
>>> --- a/drivers/infiniband/hw/hfi1/netdev_rx.c
>>> +++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
>>> @@ -188,7 +188,7 @@ static int hfi1_netdev_rxq_init(struct hfi1_netdev_rx *rx)
>>>  	int i;
>>>  	int rc;
>>>  	struct hfi1_devdata *dd = rx->dd;
>>> -	struct net_device *dev = &rx->rx_napi;
>>> +	struct net_device *dev = rx->rx_napi;
>>>  
>>>  	rx->num_rx_q = dd->num_netdev_contexts;
>>>  	rx->rxq = kcalloc_node(rx->num_rx_q, sizeof(*rx->rxq),
>>> @@ -360,7 +360,11 @@ int hfi1_alloc_rx(struct hfi1_devdata *dd)
>>>  	if (!rx)
>>>  		return -ENOMEM;
>>>  	rx->dd = dd;
>>> -	init_dummy_netdev(&rx->rx_napi);
>>> +	rx->rx_napi = alloc_netdev(sizeof(struct iwl_trans_pcie *),
>>> +				   "dummy", NET_NAME_UNKNOWN,
>>> +				   init_dummy_netdev);
>>
>> Again with the iwl stuff? Please do not stuff to the mailing list that doesn't
>> even compile....
>>
>>  CC [M]  drivers/infiniband/hw/hfi1/verbs.o
>>   CC [M]  drivers/infiniband/hw/hfi1/verbs_txreq.o
>>   CC [M]  drivers/infiniband/hw/hfi1/vnic_main.o
>> In file included from ./include/net/sock.h:46,
>>                  from ./include/linux/tcp.h:19,
>>                  from ./include/linux/ipv6.h:95,
>>                  from ./include/net/ipv6.h:12,
>>                  from ./include/rdma/ib_verbs.h:25,
>>                  from ./include/rdma/ib_hdrs.h:11,
>>                  from drivers/infiniband/hw/hfi1/hfi.h:29,
>>                  from drivers/infiniband/hw/hfi1/sdma.h:15,
>>                  from drivers/infiniband/hw/hfi1/netdev_rx.c:11:
>> drivers/infiniband/hw/hfi1/netdev_rx.c: In function ‘hfi1_alloc_rx’:
>> drivers/infiniband/hw/hfi1/netdev_rx.c:365:36: error: passing argument 4 of
>> ‘alloc_netdev_mqs’ from incompatible pointer type
>> [-Werror=incompatible-pointer-types]
>>   365 |                                    init_dummy_netdev);
>>       |                                    ^~~~~~~~~~~~~~~~~
>>       |                                    |
>>       |                                    int (*)(struct net_device *)
>> ./include/linux/netdevice.h:4632:63: note: in definition of macro ‘alloc_netdev’
>>  4632 |         alloc_netdev_mqs(sizeof_priv, name, name_assign_type, setup, 1, 1)
>>       |                                                               ^~~~~
>> ./include/linux/netdevice.h:4629:44: note: expected ‘void (*)(struct net_device
>> *)’ but argument is of type ‘int (*)(struct net_device *)’
>>  4629 |                                     void (*setup)(struct net_device *),
>>       |                                     ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   CC [M]  drivers/infiniband/hw/hfi1/vnic_sdma.o
> 
> Sorry, this patch is against net-next and you probably tested in Linus'
> upstream.
> 
> You need to have d160c66cda0ac8614 ("net: Do not return value from
> init_dummy_netdev()"), which is in net-next, and has this important
> change that is necessary for this patch:
> 
>     -int init_dummy_netdev(struct net_device *dev);
>     +void init_dummy_netdev(struct net_device *dev);
> 
> If you are OK with a v2, I will fix the topics reported in this thread.

You also use struct iwl_trans_pcie in hfi1 code. Fix that up, and make sure the
patch builds and I'll give it a test.

-Denny

> Thank you
> Breno

