Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882B052DD15
	for <lists+linux-rdma@lfdr.de>; Thu, 19 May 2022 20:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243438AbiESSvb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 May 2022 14:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242580AbiESSv3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 May 2022 14:51:29 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D24159311
        for <linux-rdma@vger.kernel.org>; Thu, 19 May 2022 11:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3lx5i1dtBk+ppVXRst8oMQM6t5DHeB6crba6ndaMsVrkELm1zrh1lwvckEHt6RXdF7VoT4tKGjiLv8qAOS6+Zz+55kQMaCqkttn8uR68NF7gAfJUJkb9mKoIavvcUs7HQGSA4ZCkSUikYeWOUL1CtcTvRf17MY9N7BjBcnrtzsAGW73PEEIbqySpU51KzBrO9rRVp2gKQfbygA6GVrV8bfBlMwkrGm3XNgBvmeP/KWcvb1km/qctAFnA0yaI6PhG8J4gWLyjmIBETU1Pe7ai0LzSsEd7Ms0+GDQGv1CUiHkhev8r689bvt5Yk8E9uvm4wdJIs7CN8MCpV5Uqbvo3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iusDiyzQYsJRyhyiZ1un1ZkXZcVa/b1dlVFTlxd/gKc=;
 b=Gjut5zoVb5y0J411fmI23Djnwd8UyTZEegf4tqHEd8sx4K06bZx4I7G6VjCUzur8ALtQNMjElrPIY5krsAEgWzDAFhgTw3jBBGGq81UW130lzqxjLI6Mr76BiJQVpg2/28nl0qqzLQ0Eaie4dXQp7RkoNPPV9mDQJC6wtfl6uJOESiXGQuUM/JYtVvCqL2KlUmR6Ej/TplFa4Aeq+N1RxTo7N8wtyjsTz7dNfQr5EIOeRYMm8NFlhGyTvwKfWKZ5Yeu+F9HzGT1FcIvubop+n58rsNm/2cnFvK/ru6KgGG0ZzCFWf30Gzgf1Rg0IoD7XQBna3SVlEM/RiYHh2vsL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 DM6PR01MB5212.prod.exchangelabs.com (2603:10b6:5:56::27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Thu, 19 May 2022 18:51:26 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::f135:e76f:7ddd:f21]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::f135:e76f:7ddd:f21%3]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 18:51:25 +0000
Message-ID: <77506ee4-b4d5-7f93-cf34-0c7361f658a0@talpey.com>
Date:   Thu, 19 May 2022 14:51:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH for-next v7 10/12] RDMA/erdma: Add the erdma module
Content-Language: en-US
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Cheng Xu <chengyou@linux.alibaba.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
References: <20220421071747.1892-1-chengyou@linux.alibaba.com>
 <20220421071747.1892-11-chengyou@linux.alibaba.com>
 <20220510131724.GA1093822@nvidia.com>
 <2a46d5b3-e905-4eb5-c775-c6fc227ad615@linux.alibaba.com>
 <20220518144621.GH1343366@nvidia.com>
 <83ed54cd-7893-ea26-6bf0-780e12ca2a3e@linux.alibaba.com>
 <20220518163142.GR1343366@nvidia.com>
 <BYAPR15MB2631B46350315B486CA9ED3599D09@BYAPR15MB2631.namprd15.prod.outlook.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <BYAPR15MB2631B46350315B486CA9ED3599D09@BYAPR15MB2631.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:208:236::30) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf7732b9-c234-495f-7b9c-08da39c8936b
X-MS-TrafficTypeDiagnostic: DM6PR01MB5212:EE_
X-Microsoft-Antispam-PRVS: <DM6PR01MB52122F1F8ACA7A99D3530796D6D09@DM6PR01MB5212.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mAlFj9P5SaIg2PblanZ7DtSW88qFhVz5LtbAu6FIlJbm2eESrLzUjoGMEdnQCV1Hc4gmgC/r2+WOQVoOKrEIZFIA99fc/WjTBkwQ8ePtzJ4PpzfoAaT4jLk+WqlHEifPjJBxoD0JAHnZIeyZHjybLetGUdPVopN+jbdeFIkI9ibI4rGz7utvV/34dKNtFgDv0tSMAnFc8T4LArPkab5c+xDfDoFN1thcUY0viBDcsipq0htnyJGyC6C7fYdbTJpt2/ibdbT+U6W1EoNvErY3WQd469FZRsvl0klwuMbRMcls2jGQMmcB/xHmede2BmMHPeYDVB+3WxVZBqrSRVGRM7tDnlhjVG5JYP3nq7g1vd2z8LR23VIGNIwHPumxYNpZceLUoxO3za+lYOM9M6wgkVx2boGCl50brlFLGYzQy06UfqYp9KAA5V7GouJyQfthJJTrHVjBMKPQgBKwkEc0M7NlS4vokOmIl53nC1Nh6jyKtWzPiTMvHsbXOhOP5xC/uYv141LdrWJ+QmBPCRgFiIr9CQ1Aar8Jm/Yxd8/4xN/8Dg4bTqrWJRwNs1NPFoZg1hm54P7rTbsLWQ5mHH3zxvQcz7sSgJC6lRnPs6cUMv1+Lxr93lfdW1EoNjbGPTpNeEk7G1RE+oLM5UW/70/SxuZLLej6WHzw3oLepRxzZC8hB+W+e2aUBPS3z/No1nlEa9LAtB7zqRZ1qfXAP676rBuRrTHNTORdIuN8wU5fHXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(396003)(136003)(376002)(346002)(39830400003)(6506007)(6666004)(31686004)(186003)(36756003)(2906002)(66556008)(4326008)(52116002)(66946007)(41300700001)(110136005)(53546011)(86362001)(2616005)(31696002)(26005)(8936002)(508600001)(5660300002)(6486002)(66476007)(54906003)(316002)(38100700002)(6512007)(83380400001)(8676002)(38350700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm9jWDdOVy92TVhTK2Q3YTYxdjFNb2V3UE9rZitHWDNqRnhZTFBvS0svSWtj?=
 =?utf-8?B?Q1ZhaWJWeXgrenM3UXl5MWdnSjlPYjBLbmVrWWVORi80UlJRVnBKZTZrdVJL?=
 =?utf-8?B?UnAvaGVBNFozd2RtYzJ4MllZVEpKcVgydlJLdG5FcWw4cmY4T1NXTmpFQ0Fs?=
 =?utf-8?B?cFhieExMMURGb1lYMUlrSmx0ekpHZFRMT3kyWDNReHQxYUZNU252d3lPcldV?=
 =?utf-8?B?NFloVGlkMlZxVDhEaVAwaHFjblNCek1mWHhiNHFTOTBqWFNTK3czRVJOVzV4?=
 =?utf-8?B?YnNGV3VLeFNjd2F3eHc0OXVyd05COS9XQVpWS3RkQkY3cHh3Sk9oWWFYT2JO?=
 =?utf-8?B?QWhPR2tNNkxRRFI2VjhWakRTbzFpVkc3cmlYSy9SeWtya2VkVU5wWmFWQUp4?=
 =?utf-8?B?b2NpaEd0Zy9lblhIdE5TUTZMTlhCbndXd3c5a2VCaWY4QUo2QmttYmJzZjdw?=
 =?utf-8?B?alNzaytpZWRCcmZlcUIzVUxuY3NLZ2ZlOWZSWnEwLy94VDhYNUtJRnFQMVpw?=
 =?utf-8?B?VTMwNm1ZQitQMUF4eGtpU1Y1UXlhRkV3MVMzZHhCNG13cXROTzJFemJ1d0F3?=
 =?utf-8?B?cUpGa3QyZlpwczZoSGdxaXY3M05FbXYvZHRpK0JocTVNUlZ2RThGVGV0SmE3?=
 =?utf-8?B?dDJkdmI0bHZRNGovVFJQZGorZThMb1R3MlN2QnA5aDJaM0cwQWNBbk41eTVt?=
 =?utf-8?B?bFVQNGNETzloL0ZqcHpjc1RFdmRHelhyWUloSFEzeEZ6dm9FZEs0REVWa0Ey?=
 =?utf-8?B?b2VRcklDdnErbUYxaUVaVGVuSnNoa2ZDRHhUSEtONm8yWFlleVEzWERiLzhi?=
 =?utf-8?B?cmtNN2NHVDlzMTB1TlFWeTRSWFlYTHpaTEFHTGEwUEtwc0g4TUYwQVk2MFkx?=
 =?utf-8?B?NlBpc1hjcVJ2KzZMWXkwdWZSNjZpa0pRY3I1WWsweDBZZm9tOUFSQnhxKzI3?=
 =?utf-8?B?MHdBczJCTzNSN2tnWXQ2ZTVYYjRKTmFCem1WRG5WR1dVTVlMOEc3K1JFaDlZ?=
 =?utf-8?B?T3hlblNEVncxa3l6R3lrbW92aFdoaHZrQ0NPVTNJZzE0T3BndFdQWEZSSm84?=
 =?utf-8?B?eThsQVBoRndveVlFNEJQeTdMRWw4d3Fzd25ERGVaaC8xSCtMZ3pvTUJXRTBE?=
 =?utf-8?B?YmtqcUhNakM3VVBDTS8rOEhLdmlOMmxJQVpxY3Jtc1d3VEhxalArdUV0dlFO?=
 =?utf-8?B?NFA1N2xabUduUlJxRFV3ai9oQW1acEs4dys1a1c1Qi9SWHVwdnN2RUVVN3ZY?=
 =?utf-8?B?VTIvTm52YzRoSG95V296anhUdS8vUHloSnN4VzVzYUVvQ0tiMTJkeVdIampU?=
 =?utf-8?B?bFZNNklic1lrRWxHSExhdnNoV0NRMUJ4VkpNWkhQZnkvWk90RmJPRHFlRHo2?=
 =?utf-8?B?OEZiNXlFZ2NqVFRqenZCMlgxTXhYa3JPU1FrR1VSUnY5b0J0UGlzdnJYTi9z?=
 =?utf-8?B?bndnVFlIMW1vUU5EdnlHTkNESWYrYXRYN3hxcEFMekZUMTZqSjZZQk9mdFlo?=
 =?utf-8?B?M3VqVFRiTVJ3RUF1Z0oxS0ErLzZZcHkvNzhzUE9nOTRGSStnbnFRWG56SXdu?=
 =?utf-8?B?N2c3MitsbHd6OHQwa0kxRFNSeDNLeW9UbkJadTh5OFpUOFp3bDlyZGU3QnZn?=
 =?utf-8?B?Y3NBM0ZqTDNOMXBCWXJNZHJZdEViTytYTTZUZVNybGlMVzllS2JwRVhPcXBI?=
 =?utf-8?B?b2R0Wjk2ZG1OamVWNCtDMkVaTEN5QUF2RkM0V2ordE15YjBpaFY1RFRwSDNC?=
 =?utf-8?B?NlhlK1p4QWdFUVZzcFh1Nk9WRXlPRGxsd0dHV2tISTZJY2Q3OHc2YUk0UlFG?=
 =?utf-8?B?Vyt6YmQyRWJXR1BGNEhDYlVoTGJRL1haUCtFaG9EQlJKTC9rekRobjVNYi95?=
 =?utf-8?B?bS9haDRpaThFa3lzTWcwWG00bTJJY0x2aGROUzFjT2xCV0RINEdsOFZLTnVl?=
 =?utf-8?B?YWV6UkFJOGlvQXYzK3dZY25IbXgydFVsbk5uRzNuMVBCc29uQ2JBWmViaGh4?=
 =?utf-8?B?WTVEeFY2NytWcXp2b2V5N2pSZG5UWFNPelFWRFdIN0Fyak04V2JpM05iRmxl?=
 =?utf-8?B?d2NqK1UxZm90cXlwREQ3cWxZRU8vN2MwMSs2WUxqbmhHOWFNeDFTUnJMSXF0?=
 =?utf-8?B?bkhwekNzVzhaYm4yc2pPK0tkcVdkRGhuKzhrK2dpVUFZWDJEOEJwNW9sTDJW?=
 =?utf-8?B?NEd3LzMrN2xMeWRNa1d4ZVJlb1hYenVXcmhqME8yNTBIVXRqRndXZHJxVi91?=
 =?utf-8?B?NXdKNzAwMFlwYzJ6eU9wL1NsZEFtS1B2WlBVZWtGS3BEbHUvTzNHTzhEL0J1?=
 =?utf-8?Q?uSNPVC+un5nTB/LDcm?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7732b9-c234-495f-7b9c-08da39c8936b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 18:51:25.8539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IN46RbzI4U75lrY0MxBzmoxRzzaKLstaLezTvvyblTAwotBndTUMIQbnvZkfrYO8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5212
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/19/2022 12:20 PM, Bernard Metzler wrote:
> 
> 
>> -----Original Message-----
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Wednesday, 18 May 2022 18:32
>> To: Cheng Xu <chengyou@linux.alibaba.com>; Bernard Metzler
>> <BMT@zurich.ibm.com>; Tom Talpey <tom@talpey.com>
>> Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org;
>> KaiShen@linux.alibaba.com; tonylu@linux.alibaba.com
>> Subject: [EXTERNAL] Re: [PATCH for-next v7 10/12] RDMA/erdma: Add the erdma
>> module
>>
>> On Thu, May 19, 2022 at 12:24:22AM +0800, Cheng Xu wrote:
>>>
>>>
>>> On 5/18/22 10:46 PM, Jason Gunthorpe wrote:
>>>> On Wed, May 18, 2022 at 04:30:33PM +0800, Cheng Xu wrote:
>>>>>
>>>>>
>>>>> On 5/10/22 9:17 PM, Jason Gunthorpe wrote:
>>>>>> On Thu, Apr 21, 2022 at 03:17:45PM +0800, Cheng Xu wrote:
>>>>>>
>>>>>>> +static struct rdma_link_ops erdma_link_ops = {
>>>>>>> +	.type = "erdma",
>>>>>>> +	.newlink = erdma_newlink,
>>>>>>> +};
>>>>>>
>>>>>> Why is there still a newlink?
>>>>>>
>>>>>
>>>>> Hello, Jason,
>>>>>
>>>>> About this issue, I have another idea, more simple and reasonable.
>>>>>
>>>>> Maybe erdma driver doesn't need to link to a net device in kernel. In
>>>>> the core code, the ib_device_get_netdev has several use cases:
>>>>>
>>>>>     1). query port info in netlink
>>>>>     2). get eth speed for IB (ib_get_eth_speed)
>>>>>     3). enumerate all RoCE ports (ib_enum_roce_netdev)
>>>>>     4). iw_query_port
>>>>>
>>>>> The cases related to erdma is 4). But we change it in our patch
>> 02/12.
>>>>> So, it seems all right that we do not link erdma to a net device.
>>>>>
>>>>> * I also test this solution, it works for both perftest and NoF. *
>>>>>
>>>>> Another issue is how to get the port state and attributes without
>>>>> net device. For this, erdma can get it from HW directly.
>>>>>
>>>>> So, I think this may be the final solution. (BTW, I have gone over
>>>>> the rdma drivers, EFA does in this way, it also has two separated
>>>>> devices for net and rdma. It inspired me).
>>>>
>>>> I'm not sure this works for an iWarp device - various things expect to
>>>> know the netdevice to know how to relate IP addresses to the iWarp
>>>> stuff - but then I don't really know iWarp.
>>>
>>> As far as I know, iWarp device only has one GID entry which generated
>>> from MAC address.
>>>
>>> For iWarp, The CM part in core code resolves address, finds
>>> route with the help of kernel's net subsystem, and then obtains the
>> correct
>>> ibdev by GID matching. The GID matching in iWarp is indeed MAC address
>>> matching.
>>>
>>> In another words, for iWarp devices, the core code doesn't handle IP
>>> addressing related stuff directly, it is finished by calling net APIs.
>>> The netdev set by ib_device_set_netdev does not used in iWarp's CM
>>> process.
>>>
>>> The binded netdev in iWarp devices, mainly have two purposes:
>>>    1). generated GID0, using the netdev's mac address.
>>>    2). get the port state and attributes.
>>>
>>> For 1), erdma device binded to net device also by mac address, which can
>>> be obtained from our PCIe bar registers.
>>> For 2), erdma can also get the information, and may be more accurately.
>>> For example, erdma can have different MTU with virtio-net in our cloud.
>>>
>>> For RoCEv2, I know that it has many GIDs, some of them are generated
>>> from IP addresses, and handing IP addressing in core code.
>>
>> Bernard, Tom what do you think?
>>
>> Jason
> 
> I think iWarp (and now RoCEv2 with its UDP dependency) drivers
> produce GIDs mostly to satisfy the current RDMA CM infrastructure,
> which depends on this type of unique identifier, inherited from IB.
> Imo, more natural would be to implement IP based RDMA protocols
> connection management by relying on IP addresses.

Agreed. Exposing MAC addresses for this seems so... 20th century.

Tom.

> Sorry for asking again - why erdma does not need to link with netdev?
> Can erdma exist without using a netdev?
> 
> 
> Thanks,
> Bernard
