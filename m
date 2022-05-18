Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E2F52C00F
	for <lists+linux-rdma@lfdr.de>; Wed, 18 May 2022 19:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240083AbiERQYb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 May 2022 12:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240055AbiERQY2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 May 2022 12:24:28 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A158D641F
        for <linux-rdma@vger.kernel.org>; Wed, 18 May 2022 09:24:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VDec8H5_1652891062;
Received: from 192.168.0.25(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VDec8H5_1652891062)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 19 May 2022 00:24:23 +0800
Message-ID: <83ed54cd-7893-ea26-6bf0-780e12ca2a3e@linux.alibaba.com>
Date:   Thu, 19 May 2022 00:24:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH for-next v7 10/12] RDMA/erdma: Add the erdma module
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
References: <20220421071747.1892-1-chengyou@linux.alibaba.com>
 <20220421071747.1892-11-chengyou@linux.alibaba.com>
 <20220510131724.GA1093822@nvidia.com>
 <2a46d5b3-e905-4eb5-c775-c6fc227ad615@linux.alibaba.com>
 <20220518144621.GH1343366@nvidia.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20220518144621.GH1343366@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/18/22 10:46 PM, Jason Gunthorpe wrote:
> On Wed, May 18, 2022 at 04:30:33PM +0800, Cheng Xu wrote:
>>
>>
>> On 5/10/22 9:17 PM, Jason Gunthorpe wrote:
>>> On Thu, Apr 21, 2022 at 03:17:45PM +0800, Cheng Xu wrote:
>>>
>>>> +static struct rdma_link_ops erdma_link_ops = {
>>>> +	.type = "erdma",
>>>> +	.newlink = erdma_newlink,
>>>> +};
>>>
>>> Why is there still a newlink?
>>>
>>
>> Hello, Jason,
>>
>> About this issue, I have another idea, more simple and reasonable.
>>
>> Maybe erdma driver doesn't need to link to a net device in kernel. In
>> the core code, the ib_device_get_netdev has several use cases:
>>
>>    1). query port info in netlink
>>    2). get eth speed for IB (ib_get_eth_speed)
>>    3). enumerate all RoCE ports (ib_enum_roce_netdev)
>>    4). iw_query_port
>>
>> The cases related to erdma is 4). But we change it in our patch 02/12.
>> So, it seems all right that we do not link erdma to a net device.
>>
>> * I also test this solution, it works for both perftest and NoF. *
>>
>> Another issue is how to get the port state and attributes without
>> net device. For this, erdma can get it from HW directly.
>>
>> So, I think this may be the final solution. (BTW, I have gone over
>> the rdma drivers, EFA does in this way, it also has two separated
>> devices for net and rdma. It inspired me).
> 
> I'm not sure this works for an iWarp device - various things expect to
> know the netdevice to know how to relate IP addresses to the iWarp
> stuff - but then I don't really know iWarp.

As far as I know, iWarp device only has one GID entry which generated
from MAC address.

For iWarp, The CM part in core code resolves address, finds
route with the help of kernel's net subsystem, and then obtains the 
correct ibdev by GID matching. The GID matching in iWarp is indeed MAC 
address matching.

In another words, for iWarp devices, the core code doesn't handle IP 
addressing related stuff directly, it is finished by calling net APIs.
The netdev set by ib_device_set_netdev does not used in iWarp's CM
process.

The binded netdev in iWarp devices, mainly have two purposes:
   1). generated GID0, using the netdev's mac address.
   2). get the port state and attributes.

For 1), erdma device binded to net device also by mac address, which can
be obtained from our PCIe bar registers.
For 2), erdma can also get the information, and may be more accurately.
For example, erdma can have different MTU with virtio-net in our cloud.

For RoCEv2, I know that it has many GIDs, some of them are generated
from IP addresses, and handing IP addressing in core code.

> If it works at all it is not a great idea
As I explained above (I hope I explained clearly, but I'm a little worry 
about my English :) ), netdev binded by ib_device_set_netdev in iWarp
device has limit usage. Compared with the v8 (traverse the netdevs in
kernel and find the matched net device), I think don't set netdev is
better.

After I explained, how do you think about this? If it still not ok,
I will work on the v8 in the future. Otherwise, I will send a v9 patch.

Thanks,
Cheng Xu
