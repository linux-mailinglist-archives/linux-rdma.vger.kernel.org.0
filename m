Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B946373C6
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Nov 2022 09:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiKXIUT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Nov 2022 03:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiKXITy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Nov 2022 03:19:54 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E874F242D
        for <linux-rdma@vger.kernel.org>; Thu, 24 Nov 2022 00:19:38 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NHrRl5ZMVzJntN;
        Thu, 24 Nov 2022 16:16:19 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 16:19:36 +0800
Subject: Re: [for-next PATCH] infiniband:cma: add a parameter for the packet
 lifetime
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>
References: <20221122090206.865-1-lengchao@huawei.com>
 <Y3zX4RnA5yrZHaqV@nvidia.com>
 <b33b0ba8-264b-340f-071d-7494c958b081@huawei.com>
 <Y355I/a/62kl0e07@nvidia.com>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <c581c96c-b9a4-d5e8-a8ba-d8fce93fe32d@huawei.com>
Date:   Thu, 24 Nov 2022 16:19:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <Y355I/a/62kl0e07@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2022/11/24 3:48, Jason Gunthorpe wrote:
> On Wed, Nov 23, 2022 at 10:13:48AM +0800, Chao Leng wrote:
>>
>>
>> On 2022/11/22 22:08, Jason Gunthorpe wrote:
>>> On Tue, Nov 22, 2022 at 05:02:06PM +0800, Chao Leng wrote:
>>>> Now the default packet lifetime(CMA_IBOE_PACKET_LIFETIME) is 18.
>>>> That means the minimum ack timeout is 2 seconds(2^(18+1)*4us=2.097seconds).
>>>> The packet lifetime means the maximum transmission time of packets
>>>> on the network, the maximum transmission time of packets is closely
>>>> related to the network. 2 seconds is too long for simple lossless networks.
>>>> The packet lifetime should allow the user to adjust according to the
>>>> network situation.
>>>> So add a parameter for the packet lifetime.
>>>>
>>>> Signed-off-by: Chao Leng <lengchao@huawei.com>
>>>> ---
>>>>    drivers/infiniband/core/cma.c | 6 +++++-
>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
>>>> index cc2222b85c88..8e2ff5d610e3 100644
>>>> --- a/drivers/infiniband/core/cma.c
>>>> +++ b/drivers/infiniband/core/cma.c
>>>> @@ -50,6 +50,10 @@ MODULE_LICENSE("Dual BSD/GPL");
>>>>    #define CMA_IBOE_PACKET_LIFETIME 18
>>>>    #define CMA_PREFERRED_ROCE_GID_TYPE IB_GID_TYPE_ROCE_UDP_ENCAP
>>>> +static unsigned char cma_packet_lifetime = CMA_IBOE_PACKET_LIFETIME;
>>>> +module_param_named(packet_lifetime, cma_packet_lifetime, byte, 0644);
>>>> +MODULE_PARM_DESC(packet_lifetime, "max transmission time of the packet");
>>>
>>> No new module parameters
>>>
>>> Maybe something in netlink would be appropriate, I'm not sure how
>>> best to deal with this.
>>>
>>> Really, the entire retransmit strategy in CM is not suitable for
>>> ethernet networks, this is just one symptom.
>> What do you think to change the CMA_IBOE_PACKET_LIFETIME to 16.
>> The maximum transmission time of packets will be about 500+ms,
>> I think this is long enough for RoCE networks.
>> 2 seconds is too long to my honest.
> 
> I don't have an informed opinion on this. I agree that 2s is too long though
> 
> Do we have any information to back up what this should be?
Assume the network is a clos topology with three layers, every packet
will pass through five hops of switches. Assume the buffer of every
switch is 128MB and the port transmission rate is 25 Gbit/s,
the maximum transmission time of the packet is 200ms(128MB*5/25Gbit/s).
Add double redundancy, it is less than 500ms.
So change the CMA_IBOE_PACKET_LIFETIME to 16,
the maximum transmission time of the packet will be about 500+ms,
it is long enough.
