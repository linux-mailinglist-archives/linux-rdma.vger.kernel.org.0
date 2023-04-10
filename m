Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236976DCE3E
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Apr 2023 01:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDJXmw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Apr 2023 19:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjDJXmv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Apr 2023 19:42:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31821BC7
        for <linux-rdma@vger.kernel.org>; Mon, 10 Apr 2023 16:42:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiiU3h4K6pHqa/MzJPDJJ7PHYCd52sE2IrThVbCKuPyeBRHbC3YgAJV2I9nrSuLdHAp7z0TzU6pQEoN3Sf51Ve2oLyB2auXJ0LNaSr2vitPDZAJzjgYobyxF0oe01Ra7++ioBrpNEly7kSSl29CmuovYvghqziRIE71wwxBRuDKXUN4L9ePwwYPWxjr9a+Gnyjky+UMnXwIY8zErIYMM+VQAex8cdJioNQ32dlCq+ONSfjVTjh1gNXa89uNqRSRWAKBCXRyTNIX6H8NZyUhKlym3tzyPqhLMYWPmmv9vJd5cvD1pvmUOqqrKLasvv5aWsEvhkhUuBLqmD+rI9pY6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiL2yatmgshR6s3Mtark+i0EEoQDExMA5M58dc2RUrM=;
 b=J46rmfnmoY5OtbDL4OZ99e4rkdIA4rCOUmImy/AsZUdeJWCRK6NhRuAOZdDNBZvV2zsi/sBkrMQ18QORRgFoV1nLyZ5+koEZssps8+1zJURsSAkeNgx7jwsMfJ5T93GYbCztal5XL2HzD9wVbjqCW+bHjEPD+w7ySVFsIl6BFIt3gMe7/ER/8sUWCFSM4sGtcU4Nls7uy+4tYw/wH82OERyqXu9I4hAPhWwzC9JR958EkREsaOTAqbIhArwIU8lTPBAcgYbZUkoRG/WKM94ikbjxb7yo54KqwOYDmtw1EZFi97iD7P6ux0+yscZ/6bQQzKAY5hIMC79aVlT9RS3bdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiL2yatmgshR6s3Mtark+i0EEoQDExMA5M58dc2RUrM=;
 b=clkN0i9lJOCrJQUQrYvirzkWs3RdISbEN9tlIpi9bd0BdIcfIMFHcI+mN/1KXgwveFShj4EXzzHPk+/TBFpWZexNHsEDSKTKp11dSwzGr9qxcIQtWJittomh2cGjyWXMxi65SRfT7wjKOrW8/kKw53C/PCh02h1QiXPaN3FIMT8Y1De7OO/WoS1S+CIgAfhqha4UZ1CKwFP7r15t3t6qOzKnBrEHNbqcxqhQ6IIqZpqBejYu56UIoUTyeYxGVDN/h/Jx1i5ZEzR8Nca1QlP+llNbQ/G0AqBoYfTXWeXybmB/XqRljcqyFW/3RiGLzFHNtLQeB8iI5fIkMk+NXhbZIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1366.namprd12.prod.outlook.com (2603:10b6:903:40::13)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Mon, 10 Apr
 2023 23:42:48 +0000
Received: from CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::e4f4:cc5f:89a3:3e44]) by CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::e4f4:cc5f:89a3:3e44%4]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 23:42:48 +0000
Message-ID: <a7be2148-b17b-816e-b28b-1837ebcb11a1@nvidia.com>
Date:   Tue, 11 Apr 2023 07:42:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH rdma-next 1/2] IB/core: Query IBoE link speed with a new
 driver API
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
References: <cover.1681132096.git.leon@kernel.org>
 <67b6ea0621b22b77db4cd637a4f9b48a2f447898.1681132096.git.leon@kernel.org>
 <ZDSaXaFMFFde3agT@nvidia.com>
From:   Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <ZDSaXaFMFFde3agT@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To CY4PR12MB1366.namprd12.prod.outlook.com
 (2603:10b6:903:40::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR12MB1366:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4875df-2b60-424b-5273-08db3a1d4a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r3raaNp466buE7XcHWQDa/xUs6wpclnHfFLSlFBVOUWVpVynEX2I3b7UfZq8jlSVHAODuA7HnWYyzu8omnbIB69fobb51kk9L/DwDRIl5BfUJFUhCm8RNgqgvBwcoDY0VWHMojGc9DFrR7Y2TObjALszEeqELuJSwLYZsltNbVyVyt6TI56/DcMVxsU/N65nTCx93eoh1kn3ZbKRGScSWWT4YoJthlNeRK7yXdSgdxbPTUOAAdosHzzW0vzbFZE7ZZHaQcEgwTQHHCkINKYmazJg7T/yrckdp7fh/mvi7GuQR/aN1MCDfAlaYjOxOWAKa3IEfVJs0vY/AFxBaHboJpkkulA8owKI2/+Ed/RwdFducABVMZBJ3JZtZJACi0p8Gjx8st24Wc+CsMTuQs4KIE+HaRCRgEhEnuwWWLtbK8QN+IzLAqkde1zaDoSvYglnmOTO7mG5448lwgSJ521z1ePeprfOnAb4j+V/G8P7uHsQxw4hiGK+j2dZwet/J5uITFT/WrknYqNlxU3Bj7GUoChxm7DGbZnWrbwYk34SnChTYchYfh+dZ/uFwqdL/chBXfjGby2Ug78HZl3Adcz+SxbzjC1lbBMhnDwBHzn40g5BbzAgi4R/jD8BOht5fBzcC80mxUSz+8zXhpUkKpwXEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1366.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199021)(31686004)(6486002)(66556008)(478600001)(4326008)(66476007)(8676002)(66946007)(316002)(41300700001)(110136005)(86362001)(31696002)(36756003)(83380400001)(2616005)(6512007)(6506007)(26005)(53546011)(6666004)(8936002)(2906002)(5660300002)(38100700002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWhvVW9QY000L2RzY3BVOUUrVnQ3MnVEN1R0NGZ5QlNQWTZWTWthd0lXSTJh?=
 =?utf-8?B?eTNCakFBSjdUZHo4S3JGdDY2WUNMbGhpY0tkek5QK0VMQUxzaWp6TGlxNWpI?=
 =?utf-8?B?UkJJazZ3b2tYNWVobFBZeW00NDNhUmNsSWwxZXNWdmdBS3FXaHdOTHZ1dnVh?=
 =?utf-8?B?QVJralRnUzBWYjBXcUk5M3NEUnJFR0NNY2FxYjAzSFYrbjByblVlK0RVaDgv?=
 =?utf-8?B?TTZvK1Y3alE4M043dk1jcjhRbnRmK0tuN3Rmd1hUSXY3VWdQSU9mSGliNmF6?=
 =?utf-8?B?WjJaOW1xL3FKNFcrbkhRWGkzUWVoeDBKZ3Ric094cFRpeDJLUnZhWGg5WTIw?=
 =?utf-8?B?Z3h6LzY0eEc3MWFONm5tLzY0Vit1ZVkzKzBBa2h5ZGcwZUNlaVRFK2tnZ0Ft?=
 =?utf-8?B?blpCVC9jb1JYa2xiSFZ4Y1JvK1VBNXVoR0I4cit5WU4vZ0JDd1hmTm5oMzky?=
 =?utf-8?B?Q1d1L0xTcEh1Nmg5V2dMRVdIM1pKN0pZajRZUEZRVGNMSW15Tms4ZGdRZk8v?=
 =?utf-8?B?Q1Rmc2JpcFFKK2ZCOGo2MDdtd3JmTDNPaUI2dVN0U1gvWnhVNTh0dm52dUFJ?=
 =?utf-8?B?K1J3RXAvWFhSUjRwR3J5ZC9vNDN1QlNIcGRNOStONFZINUJJbkNNUkE3a3N1?=
 =?utf-8?B?NDRKb2ExcU9CdWNURTQxYVVDd1NhMDh5dC91Zm1DeTN4dnpGM0NtWXlaMFpa?=
 =?utf-8?B?NHZCVm0yanhwMktVcFJwdHh0K2p5bWI4QkZ2SUV0Q2d0QjdaT0t4eTc3S2Jx?=
 =?utf-8?B?OERqNE0zVkUyWFFxdDZaU2RaZWFJeWp3SDNBS3VjOGpvVCtsOGg4eXVMelh3?=
 =?utf-8?B?anVEZ0VwR3pZUFkrWnIrbGNqendRSE94ZmsrSHpMaDMwNXYrWkRlRTdDZHVn?=
 =?utf-8?B?ZkFLaVQ1L1lkdUxsVnpnUTM4a2JlSXhlekxzRjl1ZUhmQ1lCdmhGSDJxcGpS?=
 =?utf-8?B?ME1FeVVLTDIxZ1kyQ3NWL2hBOCtaV2xEa2Z4RnpheS9xTUh0WjRIOWJZVlFU?=
 =?utf-8?B?YmwxNXBPU0JBWnp5RFBza2JhRFlpYkVvVXhFd21rKzNJaFpkZlU2dUVid1V2?=
 =?utf-8?B?K24wSzdsUHhYV1dNZ0JQNU1BUmIwZ280elVIL0ljeExralVCNWxqYmNncURE?=
 =?utf-8?B?L3pyRzA1Y3p5bE55QnJKSkNzUEVKcHFJMEQ1WmpNYjVhR0ZkSFgzVDJoSHNx?=
 =?utf-8?B?MHIzUmoyUUVFRHV2cHRGV05JK2tTZmdxenJqS01DYWVGZWxJRmNER3kzc0h0?=
 =?utf-8?B?OUpHL04raUUvOUVsTWNiVmxpNm54ZXJmalFuUjI2SEg3VDl2NEcrMGYyZUc1?=
 =?utf-8?B?YmFaMWlOWmRMK0E3QlI2ZkNQTEJzYVNJTUxNVVV5azdtc2pVSi9teDdCcDJU?=
 =?utf-8?B?UEJuZVJadGM1VlFKRXlVa002NkZvUjhJMXBTaDREMWVGQ091OGVmQ2RvSHho?=
 =?utf-8?B?REd1NG1ER2pPY2cyR2ZiUmgydHpBYlhuQU03d3RnVUZvbVo2QVN0K1JWbXRB?=
 =?utf-8?B?dVQvOE45RjhmQzVMZzE5YndnNnExSnhuOEZIZEhHM0ZHeEJxdEtTby9EWG4v?=
 =?utf-8?B?dnk3NjE3VXpQN0xzQmliSjdzRHlEQnFEdGFrK0lhUG5iZFFLenhHT2N1Sll0?=
 =?utf-8?B?U1RJdWcySndmVFFiMWw5aytJRDFvdzZjT1Boang0ZWpsZE5hK2k2cHYvMnRm?=
 =?utf-8?B?N1l4RHFBdThWeVozMXdCZG5tbW5ob0Z2cTJNMnZtbG0vcFZiM1FaWHltZ2F1?=
 =?utf-8?B?VVNjQUw5ei9ra2ZhNDZ4ME5oT0tMUzV5OTlrNERVZ0ZhdHZmUjhHdEIzeVl4?=
 =?utf-8?B?MWV4NktBdERSNFQwbG9ZY05VLzhaSWIwU3BHbmIrSGhVZUI3NVFSZzNlTXlj?=
 =?utf-8?B?VTVHSzRUWjJYK3U1WTFKT292aDZxUldFaS9yOUxtTnJtT0hSbWRVdFV1Z1FP?=
 =?utf-8?B?NkFvVzU1QTZpMVR3YnlMTVIxNDZLOW94eEFodEN6enJ4VU5teGdNeTBxTGtq?=
 =?utf-8?B?TFQyUlowZ3FWQkgrWEdKWDNQSFBnbU14Q3J2WFA5c2hMRVpQSFFkblFrUjBk?=
 =?utf-8?B?aVJyUWJTRGlmNnhyY1VvTHp0dmdpalh2NWpVR2RMTG5HaytvZFhobHJrd3ln?=
 =?utf-8?Q?CQ/tjICYQhO9k87v5yWYirHK5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4875df-2b60-424b-5273-08db3a1d4a34
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1366.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 23:42:48.0011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6De2lpvBoX1iPXop0alZc8Hngy18e50QD4u9LIqwv/RmEJ8ZULgaYEAkpvG+jCqBH6tVz0kcQeWlNNpA6jUrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/11/2023 7:23 AM, Jason Gunthorpe wrote:
> On Mon, Apr 10, 2023 at 04:12:06PM +0300, Leon Romanovsky wrote:
>> From: Mark Zhang <markzhang@nvidia.com>
>>
>> Currently the ethtool API is used to get IBoE link speed, which must be
>> protected with the rtnl lock. This becomes a bottleneck when try to setup
>> many rdma-cm connections at the same time, especially with multiple
>> processes.
>>
>> In order to avoid it, a new driver API is introduced to query the IBoE
>> rate. It will be used firstly, and back to ethtool way if it fails.
>>
>> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>> ---
>>   drivers/infiniband/core/cma.c    |  6 ++++--
>>   drivers/infiniband/core/device.c |  1 +
>>   include/rdma/ib_addr.h           | 31 ++++++++++++++++++++-----------
>>   include/rdma/ib_verbs.h          |  3 +++
>>   4 files changed, 28 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
>> index 9c7d26a7d243..ff706d2e39c6 100644
>> --- a/drivers/infiniband/core/cma.c
>> +++ b/drivers/infiniband/core/cma.c
>> @@ -3296,7 +3296,8 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
>>   	route->path_rec->traffic_class = tos;
>>   	route->path_rec->mtu = iboe_get_mtu(ndev->mtu);
>>   	route->path_rec->rate_selector = IB_SA_EQ;
>> -	route->path_rec->rate = iboe_get_rate(ndev);
>> +	route->path_rec->rate = iboe_get_rate(ndev, id_priv->id.device,
>> +					      id_priv->id.port_num);
>>   	dev_put(ndev);
>>   	route->path_rec->packet_life_time_selector = IB_SA_EQ;
>>   	/* In case ACK timeout is set, use this value to calculate
>> @@ -4962,7 +4963,8 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
>>   	if (!ndev)
>>   		return -ENODEV;
>>   
>> -	ib.rec.rate = iboe_get_rate(ndev);
>> +	ib.rec.rate = iboe_get_rate(ndev, id_priv->id.device,
>> +				    id_priv->id.port_num);
>>   	ib.rec.hop_limit = 1;
>>   	ib.rec.mtu = iboe_get_mtu(ndev->mtu);
> 
> What do we even use rate for in roce mode in the first place?
> 
In mlx5 it is set to "address_path.stat_rate", but I believe we always 
set 0 for roce actually. Not sure about other devices?
