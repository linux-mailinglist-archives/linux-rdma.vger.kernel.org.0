Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728484895F9
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jan 2022 11:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243617AbiAJKH5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jan 2022 05:07:57 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:54099 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234093AbiAJKHy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jan 2022 05:07:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V1PizWf_1641809271;
Received: from 30.43.105.228(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V1PizWf_1641809271)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 Jan 2022 18:07:52 +0800
Message-ID: <c0e687ce-65fe-6535-6231-7570f077c3a6@linux.alibaba.com>
Date:   Mon, 10 Jan 2022 18:07:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH rdma-next 00/11] Elastic RDMA Adapter (ERDMA) driver
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com,
        tonylu@linux.alibaba.com
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
 <YcHSBnKHmR9sb6KR@unreal>
 <b45d0472-06d2-0541-13a2-c64ef6f189f0@linux.alibaba.com>
 <YcROKB5N7Kr1XhaN@unreal>
 <9496ca18-760c-f90e-8735-f7fb2982e7a4@linux.alibaba.com>
 <20220107142417.GW6467@ziepe.ca>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20220107142417.GW6467@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/7/22 10:24 PM, Jason Gunthorpe wrote:
> On Thu, Dec 23, 2021 at 08:59:14PM +0800, Cheng Xu wrote:
>>
>>
>> On 12/23/21 6:23 PM, Leon Romanovsky wrote:
>>> On Wed, Dec 22, 2021 at 11:35:44AM +0800, Cheng Xu wrote:
>>>>
>>>
>>> <...>
>>>
>>>>>>
>>>>>> For the ECS instance with RDMA enabled, there are two kinds of devices
>>>>>> allocated, one for ERDMA, and one for the original netdev (virtio-net).
>>>>>> They are different PCI deivces. ERDMA driver can get the information about
>>>>>> which netdev attached to in its PCIe barspace (by MAC address matching).
>>>>>
>>>>> This is very questionable. The netdev part should be kept in the
>>>>> drivers/ethernet/... part of the kernel.
>>>>>
>>>>> Thanks
>>>>
>>>> The net device used in Alibaba ECS instance is virtio-net device, driven
>>>> by virtio-pci/virtio-net drivers. ERDMA device does not need its own net
>>>> device, and will be attached to an existed virtio-net device. The
>>>> relationship between ibdev and netdev in erdma is similar to siw/rxe.
>>>
>>> siw/rxe binds through RDMA_NLDEV_CMD_NEWLINK netlink command and not
>>> through MAC's matching.
>>>
>>> Thanks
>>
>> Both siw/rxe/erdma don't need to implement netdev part, this is what I
>> wanted to express when I said 'similar'.
>> What you mentioned (the bind mechanism) is one major difference between
>> erdma and siw/rxe. For siw/rxe, user can attach ibdev to every netdev if
>> he/she wants, but it is not true for erdma. When user buys the erdma
>> service, he/she must specify which ENI (elastic network interface) to be
>> binded, it means that the attached erdma device can only be binded to
>> the specific netdev. Due to the uniqueness of MAC address in our ECS
>> instance, we use the MAC address as the identification, then the driver
>> knows which netdev should be binded to.
> 
> It really doesn't match our driver binding model to rely on MAC
> addreses.
> 
> Our standard model would expect that the virtio-net driver would
> detect it has RDMA capability and spawn an aux device to link the two
> things together.
> 
> Using net notifiers to try to link the lifecycles together has been a
> mess so far.
Thanks for your explanation.

I guess this model requires the netdev and its associated ibdev share
the same physical hardware (pci device or platform device)? ERDMA is a
separated pci device. Only because that ENIs in our cloud are
virtio-net devices, and we let ERDMA binded to virtio-net. Actually it
also can work with other type of netdev.

As you and Leon said, using net notifiers is not a good way. And I'm
modifying our bind mechanism, using RDMA_NLDEV_CMD_NEWLINK to fix it.

Thanks,
Cheng Xu

> Jason
