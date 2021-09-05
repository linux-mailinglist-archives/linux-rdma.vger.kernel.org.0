Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C423B400E91
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Sep 2021 09:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbhIEH0l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Sep 2021 03:26:41 -0400
Received: from smtp-fw-80007.amazon.com ([99.78.197.218]:65422 "EHLO
        smtp-fw-80007.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhIEH0k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Sep 2021 03:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1630826737; x=1662362737;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ryTnZq6a6Z8KGGM7DCnpGd8sUM4SP7U/9c+IXKpu6+E=;
  b=fqo+M6CyRUIoUp3nE3HhRiGuOjOB12k/OrYk+TGswSiwnV+iAtEolQX+
   Q+6KYDcitRIEbTU9rsZ/3VlmwvSUdymz8BsowYc8lUG7NoZ6awQL/i0wG
   MjG9qmCHmojY/47b/ws7vkVwaxwFiIyofPM/iE+tnDiQEcLj8ehpewpic
   8=;
X-IronPort-AV: E=Sophos;i="5.85,269,1624320000"; 
   d="scan'208";a="24587052"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-1e-42f764a0.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP; 05 Sep 2021 07:25:28 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-42f764a0.us-east-1.amazon.com (Postfix) with ESMTPS id C78EFB050F;
        Sun,  5 Sep 2021 07:25:26 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.241) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Sun, 5 Sep 2021 07:25:22 +0000
Subject: Re: [PATCH for-next 4/4] RDMA/efa: CQ notifications
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20210820182702.GA550455@nvidia.com>
 <7a4963ea-f028-e787-a5ba-fabf907c6d6b@amazon.com>
 <20210901115716.GG1721383@nvidia.com>
 <c8549e51-47a2-1426-b44b-f1c4ade3dce2@amazon.com>
 <20210901153659.GL1721383@nvidia.com>
 <d1b2dc01-5a42-371e-c4b6-2f9b3425f5b6@amazon.com>
 <20210902130255.GR1721383@nvidia.com>
 <3a5fb37a-dd72-e322-f7c6-790ee4e04efa@amazon.com>
 <20210902151029.GV1721383@nvidia.com>
 <f80c3b52-d38b-3045-0fcc-b27f1f7b8c0d@amazon.com>
 <20210902154124.GX1721383@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <9ffde1c4-d748-0091-0d7d-b2e2eb63aa51@amazon.com>
Date:   Sun, 5 Sep 2021 10:25:17 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210902154124.GX1721383@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.241]
X-ClientProxiedBy: EX13D47UWC002.ant.amazon.com (10.43.162.83) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 02/09/2021 18:41, Jason Gunthorpe wrote:
> On Thu, Sep 02, 2021 at 06:17:45PM +0300, Gal Pressman wrote:
>> On 02/09/2021 18:10, Jason Gunthorpe wrote:
>>> On Thu, Sep 02, 2021 at 06:09:39PM +0300, Gal Pressman wrote:
>>>> On 02/09/2021 16:02, Jason Gunthorpe wrote:
>>>>> On Thu, Sep 02, 2021 at 10:03:16AM +0300, Gal Pressman wrote:
>>>>>> On 01/09/2021 18:36, Jason Gunthorpe wrote:
>>>>>>> On Wed, Sep 01, 2021 at 05:24:43PM +0300, Gal Pressman wrote:
>>>>>>>> On 01/09/2021 14:57, Jason Gunthorpe wrote:
>>>>>>>>> On Wed, Sep 01, 2021 at 02:50:42PM +0300, Gal Pressman wrote:
>>>>>>>>>> On 20/08/2021 21:27, Jason Gunthorpe wrote:
>>>>>>>>>>> On Wed, Aug 11, 2021 at 06:11:31PM +0300, Gal Pressman wrote:
>>>>>>>>>>>> diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
>>>>>>>>>>>> index 417dea5f90cf..29db4dec02f0 100644
>>>>>>>>>>>> +++ b/drivers/infiniband/hw/efa/efa_main.c
>>>>>>>>>>>> @@ -67,6 +67,46 @@ static void efa_release_bars(struct efa_dev *dev, int bars_mask)
>>>>>>>>>>>>      pci_release_selected_regions(pdev, release_bars);
>>>>>>>>>>>>  }
>>>>>>>>>>>>
>>>>>>>>>>>> +static void efa_process_comp_eqe(struct efa_dev *dev, struct efa_admin_eqe *eqe)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +    u16 cqn = eqe->u.comp_event.cqn;
>>>>>>>>>>>> +    struct efa_cq *cq;
>>>>>>>>>>>> +
>>>>>>>>>>>> +    cq = xa_load(&dev->cqs_xa, cqn);
>>>>>>>>>>>> +    if (unlikely(!cq)) {
>>>>>>>>>>>
>>>>>>>>>>> This seems unlikely to be correct, what prevents cq from being
>>>>>>>>>>> destroyed concurrently?
>>>>>>>>>>>
>>>>>>>>>>> A comp_handler cannot be running after cq destroy completes.
>>>>>>>>>>
>>>>>>>>>> Sorry for the long turnaround, was OOO.
>>>>>>>>>>
>>>>>>>>>> The CQ cannot be destroyed until all completion events are acked.
>>>>>>>>>> https://github.com/linux-rdma/rdma-core/blob/7fd01f0c6799f0ecb99cae03c22cf7ff61ffbf5a/libibverbs/man/ibv_get_cq_event.3#L45
>>>>>>>>>> https://github.com/linux-rdma/rdma-core/blob/7fd01f0c6799f0ecb99cae03c22cf7ff61ffbf5a/libibverbs/cmd_cq.c#L208
>>>>>>>>>
>>>>>>>>> That is something quite different, and in userspace.
>>>>>>>>>
>>>>>>>>> What in the kernel prevents tha xa_load and the xa_erase from racing together?
>>>>>>>>
>>>>>>>> Good point.
>>>>>>>> I think we need to surround efa_process_comp_eqe() with an rcu_read_lock() and
>>>>>>>> have a synchronize_rcu() after removing it from the xarray in
>>>>>>>> destroy_cq.
>>>>>>>
>>>>>>> Try to avoid synchronize_rcu()
>>>>>>
>>>>>> I don't see how that's possible?
>>>>>
>>>>> Usually people use call_rcu() instead
>>>>
>>>> Oh nice, thanks.
>>>>
>>>> I think the code would be much simpler using synchronize_rcu(), and the
>>>> destroy_cq flow is usually on the cold path anyway. I also prefer to be certain
>>>> that the CQ is freed once the destroy verb returns and not rely on the callback
>>>> scheduling.
>>>
>>> I would not be happy to see synchronize_rcu on uverbs destroy
>>> functions, it is too easy to DOS the kernel with that.
>>
>> OK, but isn't the fact that the uverb can return before the CQ is actually
>> destroyed problematic?
> 
> Yes, you can't allow that, something other than RCU needs to prevent
> that
> 
>> Maybe it's an extreme corner case, but if I created max_cq CQs, destroyed one,
>> and try to create another one, it is not guaranteed that the create operation
>> would succeed - even though the destroy has finished.
> 
> More importantly a driver cannot call completion callbacks once
> destroy cq has returned.

So how is having some kind of synchronization to wait for the call_rcu()
callback to finish different than using synchronize_rcu()? We'll have to wait
for the readers to finish before returning.
