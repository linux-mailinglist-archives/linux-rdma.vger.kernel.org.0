Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CBA47CBBA
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Dec 2021 04:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbhLVDfs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Dec 2021 22:35:48 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:54730 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229997AbhLVDfs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Dec 2021 22:35:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V.OK4mE_1640144145;
Received: from 30.43.106.56(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V.OK4mE_1640144145)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Dec 2021 11:35:46 +0800
Message-ID: <b45d0472-06d2-0541-13a2-c64ef6f189f0@linux.alibaba.com>
Date:   Wed, 22 Dec 2021 11:35:44 +0800
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
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <YcHSBnKHmR9sb6KR@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 12/21/21 9:09 PM, Leon Romanovsky wrote:
> On Tue, Dec 21, 2021 at 10:48:47AM +0800, Cheng Xu wrote:
>> Hello all,
>>
>> This patch set introduces the Elastic RDMA Adapter (ERDMA) driver, which
>> released in Apsara Conference 2021 by Alibaba.
>>
>> ERDMA enables large-scale RDMA acceleration capability in Alibaba ECS
>> environment, initially offered in g7re instance. It can improve the
>> efficiency of large-scale distributed computing and communication
>> significantly and expand dynamically with the cluster scale of Alibaba
>> Cloud.
>>
>> ERDMA is a RDMA networking adapter based on the Alibaba MOC hardware. It
>> works in the VPC network environment (overlay network), and uses iWarp
>> tranport protocol. ERDMA supports reliable connection (RC). ERDMA also
>> supports both kernel space and user space verbs. Now we have already
>> supported HPC/AI applications with libfabric, NoF and some other internal
>> verbs libraries, such as xrdma, epsl, etc,.
> 
> We will need to get erdma provider implementation in the rdma-core too,
> in order to consider to merge it.

Sure, I will submit erdma userspace provider implementation within 2
days.

>>
>> For the ECS instance with RDMA enabled, there are two kinds of devices
>> allocated, one for ERDMA, and one for the original netdev (virtio-net).
>> They are different PCI deivces. ERDMA driver can get the information about
>> which netdev attached to in its PCIe barspace (by MAC address matching).
> 
> This is very questionable. The netdev part should be kept in the
> drivers/ethernet/... part of the kernel.
> 
> Thanks

The net device used in Alibaba ECS instance is virtio-net device, driven
by virtio-pci/virtio-net drivers. ERDMA device does not need its own net
device, and will be attached to an existed virtio-net device. The
relationship between ibdev and netdev in erdma is similar to siw/rxe.

>>
>> Thanks,
>> Cheng Xu
>>
>> Cheng Xu (11):
>>    RDMA: Add ERDMA to rdma_driver_id definition
>>    RDMA/erdma: Add the hardware related definitions
>>    RDMA/erdma: Add main include file
>>    RDMA/erdma: Add cmdq implementation
>>    RDMA/erdma: Add event queue implementation
>>    RDMA/erdma: Add verbs header file
>>    RDMA/erdma: Add verbs implementation
>>    RDMA/erdma: Add connection management (CM) support
>>    RDMA/erdma: Add the erdma module
>>    RDMA/erdma: Add the ABI definitions
>>    RDMA/erdma: Add driver to kernel build environment
>>
>>   MAINTAINERS                               |    8 +
>>   drivers/infiniband/Kconfig                |    1 +
>>   drivers/infiniband/hw/Makefile            |    1 +
>>   drivers/infiniband/hw/erdma/Kconfig       |   10 +
>>   drivers/infiniband/hw/erdma/Makefile      |    5 +
>>   drivers/infiniband/hw/erdma/erdma.h       |  381 +++++
>>   drivers/infiniband/hw/erdma/erdma_cm.c    | 1585 +++++++++++++++++++++
>>   drivers/infiniband/hw/erdma/erdma_cm.h    |  158 ++
>>   drivers/infiniband/hw/erdma/erdma_cmdq.c  |  489 +++++++
>>   drivers/infiniband/hw/erdma/erdma_cq.c    |  201 +++
>>   drivers/infiniband/hw/erdma/erdma_debug.c |  314 ++++
>>   drivers/infiniband/hw/erdma/erdma_debug.h |   18 +
>>   drivers/infiniband/hw/erdma/erdma_eq.c    |  346 +++++
>>   drivers/infiniband/hw/erdma/erdma_hw.h    |  474 ++++++
>>   drivers/infiniband/hw/erdma/erdma_main.c  |  711 +++++++++
>>   drivers/infiniband/hw/erdma/erdma_qp.c    |  624 ++++++++
>>   drivers/infiniband/hw/erdma/erdma_verbs.c | 1477 +++++++++++++++++++
>>   drivers/infiniband/hw/erdma/erdma_verbs.h |  366 +++++
>>   include/uapi/rdma/erdma-abi.h             |   49 +
>>   include/uapi/rdma/ib_user_ioctl_verbs.h   |    1 +
>>   20 files changed, 7219 insertions(+)
>>   create mode 100644 drivers/infiniband/hw/erdma/Kconfig
>>   create mode 100644 drivers/infiniband/hw/erdma/Makefile
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma.h
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma_cm.c
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma_cm.h
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma_cmdq.c
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma_cq.c
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma_debug.c
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma_debug.h
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma_eq.c
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma_hw.h
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma_main.c
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma_qp.c
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma_verbs.c
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma_verbs.h
>>   create mode 100644 include/uapi/rdma/erdma-abi.h
>>
>> -- 
>> 2.27.0
>>
