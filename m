Return-Path: <linux-rdma+bounces-1385-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F784877F96
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 13:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4B62839D5
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 12:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E063BB48;
	Mon, 11 Mar 2024 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="DdhyWr0M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2122.outbound.protection.outlook.com [40.107.244.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A763BBCF;
	Mon, 11 Mar 2024 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710158756; cv=fail; b=ZOxUAvNyQHtJmHyM94VYjXhsYyUFOaNiqpnMcPZZNml43SzTEuIDPWZxz3If/FuFe6okpQQKdD2Sa77UuPSsywrWTHTUI6VOfIzVOuLX4nqGVceW6yNVyetNvk3K2WzQFYPJjFf0ZhVCjlIYLRlkf99C5pQAWKNHYxTPem7AMNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710158756; c=relaxed/simple;
	bh=ekdRLZ2mjwFcpqh1NWHz6eTjgtmIJed992eMLMxF7H0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cqIG3sFduPwqOP+YCFrCFNRs+2b3aPLJ4ERwMrSohi4O2a5Bc3lq8uTioK3MzNlagxKs8bkdPnAF8FyepDq6nFqeLyHFLLs3ZkW0xKcowaBrj/CKpopZRYpg1wzBJX/Wf1icdN0/D41EPmPG7jED+xePmyBDosbIyjAGEU6HSLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=DdhyWr0M; arc=fail smtp.client-ip=40.107.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iT7rLUqqcrSUd+jyLX6Wvdd/JaFjoR2jqqYoc5/xLCMz0pMNOU4d6ZIZxp0VgIinT4mKP0BQwseVCoF5tYfhSwNV0tj5HXX9WJwnkEKLdkx8Tes+waZees7iudkFQuQVsbXwfIWQu7e8/00wOQUVuDxFfBe177rrs8gmaz6mCjGXCadWd3kInbrHFS2O5Nx4L748uQ4HDMEgpXeoVAvmTND6/D+hoNeDlDeQCmpwJ+m95IwQF0yKFiKgZHJ67/IESrotsN7iOl45EpIcJo6L2W6MR9SftcP9nRNJAhtExolNWdDySSUPrt4wQ0J7jBoT+uejoo9sX0LuJJEJQzPGsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rplk1NAJtf/N8dH3n2p7QW/PAJ+sgC7w+zca+zQ3D7Y=;
 b=Gzqb9oVStIgctL76HXTd07+YWjvubh8VDtiu2ax4zHqrS1oy7sRZgl8R1ibppRiwvtSihznkIX07oYV6Hmhk8wHdqLNu1CjcvxT0Y083fVPZ8DNY9JdrSMGVK+DcsLXrbnSpLE9DVfOInz6u8AicyQfu611M3IMh7eBh0KNrd36wX5Uccc2p0gYgjIoJhdTFEhRJ6t6B70WKjFNzVCaTUJ6OtIf8X62S1F/wIQyhJdeWrmFt0D//qQ9Ri6A45EktfPBHuvz/d3/G0F+4L2mYvTH9rzwi4em34VaeucOn5juABxwuH2T47TyXa84RikHr8QcAeS5QmrakrGB9cglEQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rplk1NAJtf/N8dH3n2p7QW/PAJ+sgC7w+zca+zQ3D7Y=;
 b=DdhyWr0MozhEKGdvWU9iuOVdTKawWCeyexy4a7Wl2Sd2b+HsNp2+280eTO2IVtLVx0oLCdgUlHUBQkKSXgLA2wfv1CPNq71QG20rynjSESHWwDMCnjYFAy8/fzJdHUKiieXklZ3+XmlhSDQX5bAKvRrwdImxYvInHHOAgkbXZbqbhoTU/YzHGyPEjCsdR33zMQIJNadn/u9HCPoS+qWO1hQnXuPS5Q3JBQMiiePLef1B3nGA8CZp39jISBWR1YO4W3BnyelGL9E4fttRaunue46ozx0EtrGL5Vv5QXxvuVyiDoZTfQpg+YDTYYXO67lJlwDFwQiTHKj7bOhGVQLqeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4817.prod.exchangelabs.com (2603:10b6:208:7c::31) by
 SJ0PR01MB8183.prod.exchangelabs.com (2603:10b6:a03:4e7::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.36; Mon, 11 Mar 2024 12:05:49 +0000
Received: from BL0PR01MB4817.prod.exchangelabs.com
 ([fe80::b62f:89e4:967b:47ff]) by BL0PR01MB4817.prod.exchangelabs.com
 ([fe80::b62f:89e4:967b:47ff%6]) with mapi id 15.20.7316.039; Mon, 11 Mar 2024
 12:05:49 +0000
Message-ID: <6460dd4b-9b65-49df-beaf-05412e42f706@cornelisnetworks.com>
Date: Mon, 11 Mar 2024 08:05:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] IB/hfi1: allocate dummy net_device dynamically
To: Breno Leitao <leitao@debian.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>
Cc: kuba@kernel.org, keescook@chromium.org,
 "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240308182951.2137779-1-leitao@debian.org>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20240308182951.2137779-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:207:3c::24) To BL0PR01MB4817.prod.exchangelabs.com
 (2603:10b6:208:7c::31)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4817:EE_|SJ0PR01MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: ebbbc1af-8a2e-41b2-3d31-08dc41c396b4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y23CZHimr2lPqp/o4IU6eNddHhmHqaDjQK+UhRsudXuzAGElxB6nh4MsqU/pI4358MIPN5w62fV6ZdLiJxo7SKwAu4owOeKQsupAnAhjUgtc1plALqw2fTgvryDCqtcut5Qf5U/AdXwl6iw/KsVCQTzIdVSfnFOn5SNtHKcnT+b4bEooQVhiWus/j7p38PfTfSY67wkKGazQtl/w0jWJQmy2/8C+8Az+7SDh/Xg17/lmlMX0e4L5e4Dy03qXgpebmnfY8iywgeFRKB4kL4eexqw+Aj6MexhLSgvnPhRpR3InX2cmm5E2Jq5uYGmEZnrHNgD0UaxfUADbhHOIrFHS4N7e15Chk1kR4Hhy0aeD5TWzPOUM2p1wZCuGSFvRfk+C8x6KX1EN3OsyualsyYgXJhgtf2s0z7khSa6RW56IviIFMsuNwB895OhKyB47ABq2zBVtBO9R5UbEfOr2CaqyJHCYHb3Lkq8z2iNXaSxi5SteurjjkgAOmuEr/CXwkyAYC2Baq4FGG9GrkFkn9hf++GboFSrA9MJKKRQP7mrACqm7Y+WonN7w9yl5aIllpV5Z8pnKY0cNJ/GIuFMvQZISkmFdezHwLeZHeOgwKl6zoyHIiDqJ+NyzAZxTTrfB4C/6Rlo71MQK0R8SWpmNzQiJPZgyvNVLqAahC2HrqH7rVng=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4817.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWRhVjlhVWM2SXdKTVN2TXlSYXV6b1pVbDVTTXhJZ0FXZFNjRGJyOTBoSG4x?=
 =?utf-8?B?Z3FyV3p0MGdHN0dJMVh1TnBvVkt0aFpCM2FZZEhZdTAyTUdrcVY3ZU5nUUgr?=
 =?utf-8?B?d0NEMmd2ZjNONld5UHdHazJSR2RpRmZJc1h5T0lnbHlEV3RjcmQxek5DNGdn?=
 =?utf-8?B?RTZJVHVodjdNTUpmK2g5RHU2KzE1b1JPTmNFL3NQT0M3TlI2UzI0R3puU1I1?=
 =?utf-8?B?eHNHK3BPaXJHT0xRVkg5cEN5b0Vsc2VhREVhWTZxc2hBM05sbUpIRFBvR2ts?=
 =?utf-8?B?aFhCaEU5Q0syemZzeXRuQkJVVzVaYUttZ2dVTXhjTHVmMEIzcVBKbkxray92?=
 =?utf-8?B?RDBMOWJJMldlRWhtQXNrcWs4RFBXZHByajBSVUhGUjFScGx1ZWpmK0pDVENQ?=
 =?utf-8?B?aUJ3c1Z0ZmRXRUFZZkh1OEEwOU5xdUtvU1Vac2tiaG5MaFFDTUFTb1p0Z3hI?=
 =?utf-8?B?NHJ0Ty9QbUZxeWVvNlk2cjMwTTdLQUh4dlVwMjhGWThrVlU5c0NiT01TRUp3?=
 =?utf-8?B?d01ZWDdTWkE5V2JqYlJ3ai9lM3NUR0plaDlBTGNCWVBQWVhvREtUUHRlSVJN?=
 =?utf-8?B?VExGdEg4aUFYcTJWWU85bmRLQ0VueGpVTUp1VVQ1Wm5aY2pDZDJKZEMvSllP?=
 =?utf-8?B?MlNDVlhSZmVuK1VYczVkcTBNeW9SQk9rSlZjRWdRUkUrVXc4Y3doRjdkSHR1?=
 =?utf-8?B?MzIyZ2lhQ0xKOVAxZllJNFdZMnpvYW9VNHJHMnJrTWhwYXU4b1dFc055aGFF?=
 =?utf-8?B?SUpQZXpwcUhrdGdHRi9Jek9POXlvZU82OGtkVG1BbzRWb1VFMDFTVUpkR1U2?=
 =?utf-8?B?Rmlvai9pQVJlUlpEc1o1b2RNRHpjZ3E1WFZjM1pNajYzV0pqUG9Qa1Qycm55?=
 =?utf-8?B?UmUzSmQya0plaURuVThUdlhaSU9hNGluOGJKSnRsSEYzOVpocjZTaW1XRHFh?=
 =?utf-8?B?YllDcnJVazFPMGpNTnE3SXVGVFdlOFpSOW4rWFNxM1BSY2ZqK3dOOFZHTGhq?=
 =?utf-8?B?c2V5NGxDN0J4cUNJRWdCbzRwbmMrRnR5VzUrQTJsbVJrd3NzMEU1TlQ1SkFI?=
 =?utf-8?B?UFhWZzV6Y2puOTVvamE3SnZzOG9Zb2daZnZGOFZOYmo1QXN6dmVTTlA3cFl0?=
 =?utf-8?B?Z1l2L3dzZzNJUG4zaUd6Y0U1NER1QktuUGMzMWhFRWRsZkduTnUxSWl5SkUr?=
 =?utf-8?B?dnBHRlZGdlF2NnM3R2wrRDB5QXJOUFdWaHIwK3RtZDZPc29xcmk3OUo4MzJp?=
 =?utf-8?B?Um81QiswQjhUZTR6RTFCK3A4dFBjYjRaN3NNSkovY09EeC9XcWJkL2lzcGxz?=
 =?utf-8?B?TWp5QW5PcFRWSXFqVWxWUkNmRlM3YnY1SkpHTWFSWE8yRDBITUZERFkwUDhx?=
 =?utf-8?B?NEN6QlhLU0d5T2NQbUNJZlZqY0Via3JOOGhsMGd6VzFCaFFGd2czOFBYSzNK?=
 =?utf-8?B?MXk4QlQxYjNZcno3eGZVQ01wc1BJRGsrVXA1QWU1bk40N01CdGlZcGI1UEE0?=
 =?utf-8?B?MGoweHRmMzhzTDJCTXFUeWJuNU4wNWhjZnRNTGpjYUtpN21BVWJhc3dFTkV1?=
 =?utf-8?B?c01DNGNLU0ZCa21Pd0s2QVVpZzlEWlVHZHdydlA2ekdUK1g1NnVWZDIxMFA2?=
 =?utf-8?B?V21YUDZiNHE4cFZUSlI1UlYzZVBOQXZNWUx4ZXZpdis3U1JPZTdCUHZGMzVv?=
 =?utf-8?B?RjNuaXQvcTh5SXhpNDY1OEFacEFTT0c5bUhOVWRoSm9OZ2cyUUNKYXg3dXNI?=
 =?utf-8?B?TWZLRUpVZzF1aTNTY3hmUHgyckdnRVVxMSs4a0hUdCtkaVJkOVFBQTdueExs?=
 =?utf-8?B?L0NlTEg3elVxZERQOFZuQU14cGhHdHVsQ0hqN1ZxdzhmallLdWk1K2pPOVRn?=
 =?utf-8?B?LzdpYm5vVm9sQnlHNCtNRlAvYU9aTUlVSkRWN1dNL3BVZmlJVjdnMDVDaHoz?=
 =?utf-8?B?SjkzQjJGTzFxMGJnc1M3ZWZLVEtNVXJodTl2U3lHNUEzVGxvbERQZ0k1Ky9X?=
 =?utf-8?B?eFdpVU9ON29Pc2xzT2Nmc0Nxb3FKSFcyZzZXRVNjYzhaaEdzUnRZYVhWUTlE?=
 =?utf-8?B?WDJSWlVoUHY5V0hqTDdoaFBVZXMwcXlqRWJhSm9QY0gxYTFRTUNQdUE2T3A3?=
 =?utf-8?B?WFFUQXNsdW1oalRDN1QwU0ZZN1dKQ3l4dnRqUU5PS3VPRzlLQUExZjFJd1ZJ?=
 =?utf-8?Q?gGSgSaFcW5R50tHOUEZSIpo=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbbc1af-8a2e-41b2-3d31-08dc41c396b4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4817.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 12:05:48.3504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcBv8rg/vrCOaE8ZexDWbrVpa2mzdNCYRtSD4DKVhb9pnnJM7qRCzgDjDO5B8D/eSt+bWPScwAgqLWVbzSzd8rJXn82rtCHo2IeNtG08KEs/YTUDsoKfgf6As3Byug0N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB8183

On 3/8/24 1:29 PM, Breno Leitao wrote:
> struct net_device shouldn't be embedded into any structure, instead,
> the owner should use the priv space to embed their state into net_device.
> 
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from struct iwl_trans_pcie by converting it
> into a pointer. Then use the leverage alloc_netdev() to allocate the
> net_device object at iwl_trans_pcie_alloc.

What does an Omni-Path Architecture driver from Cornelis Networks have to do
with an Intel wireless driver?

> The private data of net_device becomes a pointer for the struct
> iwl_trans_pcie, so, it is easy to get back to the iwl_trans_pcie parent
> given the net_device object.
> 
> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/infiniband/hw/hfi1/netdev.h    | 2 +-
>  drivers/infiniband/hw/hfi1/netdev_rx.c | 9 +++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/netdev.h b/drivers/infiniband/hw/hfi1/netdev.h
> index 8aa074670a9c..07c8f77c9181 100644
> --- a/drivers/infiniband/hw/hfi1/netdev.h
> +++ b/drivers/infiniband/hw/hfi1/netdev.h
> @@ -49,7 +49,7 @@ struct hfi1_netdev_rxq {
>   *		When 0 receive queues will be freed.
>   */
>  struct hfi1_netdev_rx {
> -	struct net_device rx_napi;
> +	struct net_device *rx_napi;
>  	struct hfi1_devdata *dd;
>  	struct hfi1_netdev_rxq *rxq;
>  	int num_rx_q;
> diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
> index 720d4c85c9c9..5c26a69fa2bb 100644
> --- a/drivers/infiniband/hw/hfi1/netdev_rx.c
> +++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
> @@ -188,7 +188,7 @@ static int hfi1_netdev_rxq_init(struct hfi1_netdev_rx *rx)
>  	int i;
>  	int rc;
>  	struct hfi1_devdata *dd = rx->dd;
> -	struct net_device *dev = &rx->rx_napi;
> +	struct net_device *dev = rx->rx_napi;
>  
>  	rx->num_rx_q = dd->num_netdev_contexts;
>  	rx->rxq = kcalloc_node(rx->num_rx_q, sizeof(*rx->rxq),
> @@ -360,7 +360,11 @@ int hfi1_alloc_rx(struct hfi1_devdata *dd)
>  	if (!rx)
>  		return -ENOMEM;
>  	rx->dd = dd;
> -	init_dummy_netdev(&rx->rx_napi);
> +	rx->rx_napi = alloc_netdev(sizeof(struct iwl_trans_pcie *),
> +				   "dummy", NET_NAME_UNKNOWN,
> +				   init_dummy_netdev);

Again with the iwl stuff? Please do not stuff to the mailing list that doesn't
even compile....

 CC [M]  drivers/infiniband/hw/hfi1/verbs.o
  CC [M]  drivers/infiniband/hw/hfi1/verbs_txreq.o
  CC [M]  drivers/infiniband/hw/hfi1/vnic_main.o
In file included from ./include/net/sock.h:46,
                 from ./include/linux/tcp.h:19,
                 from ./include/linux/ipv6.h:95,
                 from ./include/net/ipv6.h:12,
                 from ./include/rdma/ib_verbs.h:25,
                 from ./include/rdma/ib_hdrs.h:11,
                 from drivers/infiniband/hw/hfi1/hfi.h:29,
                 from drivers/infiniband/hw/hfi1/sdma.h:15,
                 from drivers/infiniband/hw/hfi1/netdev_rx.c:11:
drivers/infiniband/hw/hfi1/netdev_rx.c: In function ‘hfi1_alloc_rx’:
drivers/infiniband/hw/hfi1/netdev_rx.c:365:36: error: passing argument 4 of
‘alloc_netdev_mqs’ from incompatible pointer type
[-Werror=incompatible-pointer-types]
  365 |                                    init_dummy_netdev);
      |                                    ^~~~~~~~~~~~~~~~~
      |                                    |
      |                                    int (*)(struct net_device *)
./include/linux/netdevice.h:4632:63: note: in definition of macro ‘alloc_netdev’
 4632 |         alloc_netdev_mqs(sizeof_priv, name, name_assign_type, setup, 1, 1)
      |                                                               ^~~~~
./include/linux/netdevice.h:4629:44: note: expected ‘void (*)(struct net_device
*)’ but argument is of type ‘int (*)(struct net_device *)’
 4629 |                                     void (*setup)(struct net_device *),
      |                                     ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
  CC [M]  drivers/infiniband/hw/hfi1/vnic_sdma.o


Leon, please don't accept this until the author resubmits a patch that I either
Ack or Test.

Thanks

-Denny

