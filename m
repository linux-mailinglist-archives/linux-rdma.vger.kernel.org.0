Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F2E47F1BE
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Dec 2021 03:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhLYC51 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Dec 2021 21:57:27 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:49512 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229559AbhLYC50 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Dec 2021 21:57:26 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V.ftfxy_1640401043;
Received: from 192.168.0.121(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V.ftfxy_1640401043)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 25 Dec 2021 10:57:24 +0800
Message-ID: <97ed2a89-32d6-9d0c-4084-40a6d7ebda28@linux.alibaba.com>
Date:   Sat, 25 Dec 2021 10:57:21 +0800
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
 <bab9e1f4-21d5-efcc-f6b6-360f80725561@linux.alibaba.com>
 <YcYQ6WvZuh3hlVKN@unreal>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <YcYQ6WvZuh3hlVKN@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 12/25/21 2:26 AM, Leon Romanovsky wrote:
> On Fri, Dec 24, 2021 at 03:07:57PM +0800, Cheng Xu wrote:
>>
>>
>> On 12/23/21 9:44 PM, Leon Romanovsky wrote:
>>> On Thu, Dec 23, 2021 at 08:59:14PM +0800, Cheng Xu wrote:
>>>>
>>>>
>>>> On 12/23/21 6:23 PM, Leon Romanovsky wrote:
>>>>> On Wed, Dec 22, 2021 at 11:35:44AM +0800, Cheng Xu wrote:
>>>>>>
>>>>>
>>>>> <...>
>>>>>
>>>>>>>>
>>>>>>>> For the ECS instance with RDMA enabled, there are two kinds of devices
>>>>>>>> allocated, one for ERDMA, and one for the original netdev (virtio-net).
>>>>>>>> They are different PCI deivces. ERDMA driver can get the information about
>>>>>>>> which netdev attached to in its PCIe barspace (by MAC address matching).
>>>>>>>
>>>>>>> This is very questionable. The netdev part should be kept in the
>>>>>>> drivers/ethernet/... part of the kernel.
>>>>>>>
>>>>>>> Thanks
>>>>>>
>>>>>> The net device used in Alibaba ECS instance is virtio-net device, driven
>>>>>> by virtio-pci/virtio-net drivers. ERDMA device does not need its own net
>>>>>> device, and will be attached to an existed virtio-net device. The
>>>>>> relationship between ibdev and netdev in erdma is similar to siw/rxe.
>>>>>
>>>>> siw/rxe binds through RDMA_NLDEV_CMD_NEWLINK netlink command and not
>>>>> through MAC's matching.
>>>>>
>>>>> Thanks
>>>>
>>>> Both siw/rxe/erdma don't need to implement netdev part, this is what I
>>>> wanted to express when I said 'similar'.
>>>> What you mentioned (the bind mechanism) is one major difference between
>>>> erdma and siw/rxe. For siw/rxe, user can attach ibdev to every netdev if
>>>> he/she wants, but it is not true for erdma. When user buys the erdma
>>>> service, he/she must specify which ENI (elastic network interface) to be
>>>> binded, it means that the attached erdma device can only be binded to
>>>> the specific netdev. Due to the uniqueness of MAC address in our ECS
>>>> instance, we use the MAC address as the identification, then the driver
>>>> knows which netdev should be binded to.
>>>
>>> Nothing prohibits from you to implement this MAC check in RDMA_NLDEV_CMD_NEWLINK.
>>> I personally don't like the idea that bind logic is performed "magically".
>>>
>>
>> OK, I agree with you that using RDMA_NLDEV_CMD_NEWLINK is better. But it
>> means that erdma can not be ready to use like other RDMA HCAs, until
>> user configure the link manually. This way may be not friendly to them.
>> I'm not sure that our current method is acceptable or not. If you
>> strongly recommend us to use RDMA_NLDEV_CMD_NEWLINK, we will change to
>> it.
> 
> Before you are rushing to change that logic, could you please explain
> the security model of this binding?
> 
> I'm as an owner of VM can replace kernel code with any code I want and
> remove your MAC matching (or replace to something different). How will
> you protect from such flow?

In our MOC architecture, virtio-net device (e.g, virtio-net back-end) is
fully offloaded to MOC, not in host hypervisor. One virtio-net device
belongs to a vport, and if it has a peer erdma device, erdma device also
belongs to the vport. The protocol headers of the network flows in the
virtio-net and erdma devices must be consistent with the vport
configurations (mac address, ip, etc. ) by checking the OVS rules.

Back to the question, we can not prevent attackers from modifying the
code, making devices binding wrongly in the front-end, or in some worse
cases, making driver sending invalid commands to devices. If binding
wrongly, the erdma network will be unreachable, because the OVS module
in MOC hardware can distinguish this situation and drop all the invalid
network packets, and this has no influence to other users.

> If you don't trust VM, you should perform binding in hypervisor and
> this erdma driver will work out-of-the-box in the VM.

As mentioned above, we also have the binding configuration in the
back-end (e.g, MOC hardware), only when the configuration is correct of
the front-end, the erdma can work properly.

Thanks,
Cheng Xu

> Thanks
> 
