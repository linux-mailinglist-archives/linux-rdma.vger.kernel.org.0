Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F7E634DA5
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Nov 2022 03:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbiKWCNw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Nov 2022 21:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiKWCNw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Nov 2022 21:13:52 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88033B9B9E
        for <linux-rdma@vger.kernel.org>; Tue, 22 Nov 2022 18:13:51 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NH4RL64zxzmW2r;
        Wed, 23 Nov 2022 10:13:18 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 10:13:49 +0800
Subject: Re: [for-next PATCH] infiniband:cma: add a parameter for the packet
 lifetime
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>
References: <20221122090206.865-1-lengchao@huawei.com>
 <Y3zX4RnA5yrZHaqV@nvidia.com>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <b33b0ba8-264b-340f-071d-7494c958b081@huawei.com>
Date:   Wed, 23 Nov 2022 10:13:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <Y3zX4RnA5yrZHaqV@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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



On 2022/11/22 22:08, Jason Gunthorpe wrote:
> On Tue, Nov 22, 2022 at 05:02:06PM +0800, Chao Leng wrote:
>> Now the default packet lifetime(CMA_IBOE_PACKET_LIFETIME) is 18.
>> That means the minimum ack timeout is 2 seconds(2^(18+1)*4us=2.097seconds).
>> The packet lifetime means the maximum transmission time of packets
>> on the network, the maximum transmission time of packets is closely
>> related to the network. 2 seconds is too long for simple lossless networks.
>> The packet lifetime should allow the user to adjust according to the
>> network situation.
>> So add a parameter for the packet lifetime.
>>
>> Signed-off-by: Chao Leng <lengchao@huawei.com>
>> ---
>>   drivers/infiniband/core/cma.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
>> index cc2222b85c88..8e2ff5d610e3 100644
>> --- a/drivers/infiniband/core/cma.c
>> +++ b/drivers/infiniband/core/cma.c
>> @@ -50,6 +50,10 @@ MODULE_LICENSE("Dual BSD/GPL");
>>   #define CMA_IBOE_PACKET_LIFETIME 18
>>   #define CMA_PREFERRED_ROCE_GID_TYPE IB_GID_TYPE_ROCE_UDP_ENCAP
>>   
>> +static unsigned char cma_packet_lifetime = CMA_IBOE_PACKET_LIFETIME;
>> +module_param_named(packet_lifetime, cma_packet_lifetime, byte, 0644);
>> +MODULE_PARM_DESC(packet_lifetime, "max transmission time of the packet");
> 
> No new module parameters
> 
> Maybe something in netlink would be appropriate, I'm not sure how
> best to deal with this.
> 
> Really, the entire retransmit strategy in CM is not suitable for
> ethernet networks, this is just one symptom.
What do you think to change the CMA_IBOE_PACKET_LIFETIME to 16.
The maximum transmission time of packets will be about 500+ms,
I think this is long enough for RoCE networks.
2 seconds is too long to my honest.
