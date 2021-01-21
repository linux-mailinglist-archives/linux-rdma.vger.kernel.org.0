Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EAD2FED92
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 15:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbhAUOya convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 21 Jan 2021 09:54:30 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2957 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732379AbhAUNe1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 08:34:27 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DM3Gq2c3vz5KCr;
        Thu, 21 Jan 2021 21:32:35 +0800 (CST)
Received: from dggema752-chm.china.huawei.com (10.1.198.194) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 21 Jan 2021 21:33:42 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema752-chm.china.huawei.com (10.1.198.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 21 Jan 2021 21:33:42 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.002;
 Thu, 21 Jan 2021 21:33:42 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH RFC 1/7] RDMA/hns: Introduce DCA for RC QP
Thread-Topic: [PATCH RFC 1/7] RDMA/hns: Introduce DCA for RC QP
Thread-Index: AQHW7/oITeBBndE4CkiFjIHgF/TJug==
Date:   Thu, 21 Jan 2021 13:33:42 +0000
Message-ID: <96d7fb7db36e4bce8c556d0de5c8f961@huawei.com>
References: <1610706138-4219-1-git-send-email-liweihang@huawei.com>
 <1610706138-4219-2-git-send-email-liweihang@huawei.com>
 <20210120081025.GA225873@unreal>
 <8d255812177a4f53becd3c912d00c528@huawei.com>
 <20210121085325.GC320304@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/1/21 16:53, Leon Romanovsky wrote:
> On Thu, Jan 21, 2021 at 07:01:50AM +0000, liweihang wrote:
>> On 2021/1/20 16:10, Leon Romanovsky wrote:
>>> On Fri, Jan 15, 2021 at 06:22:12PM +0800, Weihang Li wrote:
>>>> From: Xi Wang <wangxi11@huawei.com>
>>>>
>>>> The hip09 introduces the DCA(Dynamic context attachment) feature which
>>>> supports many RC QPs to share the WQE buffer in a memory pool, this will
>>>> reduce the memory consumption when there are too many QPs are inactive.
>>>>
>>>> If a QP enables DCA feature, the WQE's buffer will not be allocated when
>>>> creating. But when the users start to post WRs, the hns driver will
>>>> allocate a buffer from the memory pool and then fill WQEs which tagged with
>>>> this QP's number.
>>>>
>>>> The hns ROCEE will stop accessing the WQE buffer when the user polled all
>>>> of the CQEs for a DCA QP, then the driver will recycle this WQE's buffer
>>>> to the memory pool.
>>>>
>>>> This patch adds a group of methods to support the user space register
>>>> buffers to a memory pool which belongs to the user context. The hns kernel
>>>> driver will update the pages state in this pool when the user calling the
>>>> post/poll methods and the user driver can get the QP's WQE buffer address
>>>> by the key and offset which queried from kernel.
>>>>
>>>> Signed-off-by: Xi Wang <wangxi11@huawei.com>
>>>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>>> ---
>>>>  drivers/infiniband/hw/hns/Makefile          |   2 +-
>>>>  drivers/infiniband/hw/hns/hns_roce_dca.c    | 381 ++++++++++++++++++++++++++++
>>>>  drivers/infiniband/hw/hns/hns_roce_dca.h    |  22 ++
>>>>  drivers/infiniband/hw/hns/hns_roce_device.h |  10 +
>>>>  drivers/infiniband/hw/hns/hns_roce_main.c   |  27 +-
>>>>  include/uapi/rdma/hns-abi.h                 |  23 ++
>>>>  6 files changed, 462 insertions(+), 3 deletions(-)
>>>>  create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.c
>>>>  create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.h
>>>
>>> <...>
>>>
>>>> +static struct dca_mem *alloc_dca_mem(struct hns_roce_dca_ctx *ctx)
>>>> +{
>>>> +	struct dca_mem *mem, *tmp, *found = NULL;
>>>> +	unsigned long flags;
>>>> +
>>>> +	spin_lock_irqsave(&ctx->pool_lock, flags);
>>>> +	list_for_each_entry_safe(mem, tmp, &ctx->pool, list) {
>>>> +		spin_lock(&mem->lock);
>>>> +		if (dca_mem_is_free(mem)) {
>>>> +			found = mem;
>>>> +			set_dca_mem_alloced(mem);
>>>> +			spin_unlock(&mem->lock);
>>>> +			goto done;
>>>> +		}
>>>> +		spin_unlock(&mem->lock);
>>>> +	}
>>>> +
>>>> +done:
>>>> +	spin_unlock_irqrestore(&ctx->pool_lock, flags);
>>>> +
>>>> +	if (found)
>>>> +		return found;
>>>> +
>>>> +	mem = kzalloc(sizeof(*mem), GFP_ATOMIC);
>>>
>>> Should it be ATOMIC?
>>>
>>
>> Hi Leon,
>>
>> The current DCA interfaces can be invoked by userspace through ibv_xx_cmd(),
>> but it is expected that it can work in ib_post_xx() in kernel in the future.
>> Since it may work in context of spin_lock, so we use GFP_ATOMIC.
> 
> Are you planning to invoke kzalloc in data path?
> 
> The GFP_ATOMIC will cause to use special allocation pool that is seen as precious
> resource because it must to succeed.
> 
> It is better to avoid this flag if you don't need it.
> 
> Thanks

We need to allocate memory while spin_lock is hold, how about using GFP_KERNEL or
GFP_NOWAIT?

Thanks
Weihang
