Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF3B47E3DF
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Dec 2021 13:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243553AbhLWM7R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Dec 2021 07:59:17 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:43892 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243548AbhLWM7Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Dec 2021 07:59:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V.XbT9n_1640264354;
Received: from 30.43.106.19(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V.XbT9n_1640264354)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Dec 2021 20:59:15 +0800
Message-ID: <9496ca18-760c-f90e-8735-f7fb2982e7a4@linux.alibaba.com>
Date:   Thu, 23 Dec 2021 20:59:14 +0800
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
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <YcROKB5N7Kr1XhaN@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 12/23/21 6:23 PM, Leon Romanovsky wrote:
> On Wed, Dec 22, 2021 at 11:35:44AM +0800, Cheng Xu wrote:
>>
> 
> <...>
> 
>>>>
>>>> For the ECS instance with RDMA enabled, there are two kinds of devices
>>>> allocated, one for ERDMA, and one for the original netdev (virtio-net).
>>>> They are different PCI deivces. ERDMA driver can get the information about
>>>> which netdev attached to in its PCIe barspace (by MAC address matching).
>>>
>>> This is very questionable. The netdev part should be kept in the
>>> drivers/ethernet/... part of the kernel.
>>>
>>> Thanks
>>
>> The net device used in Alibaba ECS instance is virtio-net device, driven
>> by virtio-pci/virtio-net drivers. ERDMA device does not need its own net
>> device, and will be attached to an existed virtio-net device. The
>> relationship between ibdev and netdev in erdma is similar to siw/rxe.
> 
> siw/rxe binds through RDMA_NLDEV_CMD_NEWLINK netlink command and not
> through MAC's matching.
> 
> Thanks

Both siw/rxe/erdma don't need to implement netdev part, this is what I
wanted to express when I said 'similar'.
What you mentioned (the bind mechanism) is one major difference between
erdma and siw/rxe. For siw/rxe, user can attach ibdev to every netdev if
he/she wants, but it is not true for erdma. When user buys the erdma
service, he/she must specify which ENI (elastic network interface) to be
binded, it means that the attached erdma device can only be binded to
the specific netdev. Due to the uniqueness of MAC address in our ECS
instance, we use the MAC address as the identification, then the driver 
knows which netdev should be binded to.

Thanks,
Cheng Xu
