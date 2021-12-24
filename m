Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914CB47EC8D
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Dec 2021 08:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351824AbhLXHIb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Dec 2021 02:08:31 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:48493 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351780AbhLXHIA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Dec 2021 02:08:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V.bvSYp_1640329677;
Received: from 30.43.105.239(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V.bvSYp_1640329677)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 24 Dec 2021 15:07:58 +0800
Message-ID: <bab9e1f4-21d5-efcc-f6b6-360f80725561@linux.alibaba.com>
Date:   Fri, 24 Dec 2021 15:07:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH rdma-next 00/11] Elastic RDMA Adapter (ERDMA) driver
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
 <YcHSBnKHmR9sb6KR@unreal>
 <b45d0472-06d2-0541-13a2-c64ef6f189f0@linux.alibaba.com>
 <YcROKB5N7Kr1XhaN@unreal>
 <9496ca18-760c-f90e-8735-f7fb2982e7a4@linux.alibaba.com>
 <YcR9PVDS2jFsrJ4N@unreal>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <YcR9PVDS2jFsrJ4N@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 12/23/21 9:44 PM, Leon Romanovsky wrote:
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
> Nothing prohibits from you to implement this MAC check in RDMA_NLDEV_CMD_NEWLINK.
> I personally don't like the idea that bind logic is performed "magically".
> 

OK, I agree with you that using RDMA_NLDEV_CMD_NEWLINK is better. But it
means that erdma can not be ready to use like other RDMA HCAs, until
user configure the link manually. This way may be not friendly to them.
I'm not sure that our current method is acceptable or not. If you
strongly recommend us to use RDMA_NLDEV_CMD_NEWLINK, we will change to
it.

Thanks,
Cheng Xu

> BTW,
> 1. No module parameters
> 2. No driver versions
> 

Will fix them.

> Thanks
> 
>>
>> Thanks,
>> Cheng Xu
