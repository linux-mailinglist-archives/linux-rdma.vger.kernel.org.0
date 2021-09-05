Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED426401051
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Sep 2021 16:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbhIEOhv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Sep 2021 10:37:51 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:3303 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237646AbhIEOhp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Sep 2021 10:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1630852603; x=1662388603;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=wZDgUphZKW6Az3qDEMEBeUAyyMLT8TiUbhzDXepBFfA=;
  b=gyUgVJW4xvrTOKsi+tz3NvHl6igsWnjmwBXDwi5vRV0CSC1/p2VQadRo
   NF2NyVA7g9pdxTB/2ZEamJaIRFf8iGxtZEjwgJglfL7MPkXisgx83A58r
   SaqqXKe1X2Pow84kFKkr3RK3EbILZoyraGdi2U70KEbiRthW7AIhxrFm5
   I=;
X-IronPort-AV: E=Sophos;i="5.85,269,1624320000"; 
   d="scan'208";a="139466939"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 05 Sep 2021 14:36:35 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 7C32B24C2BE;
        Sun,  5 Sep 2021 14:36:33 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.164) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Sun, 5 Sep 2021 14:36:28 +0000
Subject: Re: [PATCH for-next 4/4] RDMA/efa: CQ notifications
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20210902130255.GR1721383@nvidia.com>
 <3a5fb37a-dd72-e322-f7c6-790ee4e04efa@amazon.com>
 <20210902151029.GV1721383@nvidia.com>
 <f80c3b52-d38b-3045-0fcc-b27f1f7b8c0d@amazon.com>
 <20210902154124.GX1721383@nvidia.com>
 <9ffde1c4-d748-0091-0d7d-b2e2eb63aa51@amazon.com> <YTR4yhTyYi323lqe@unreal>
 <dc14a576-c696-bba7-f7a4-1fc00ff3d293@amazon.com> <YTSh+wU572k00WVS@unreal>
 <2231dfa4-2f99-5187-fa83-56052dad9979@amazon.com> <YTTCycq4KTBk6r/s@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <ed19464f-d046-bc10-ec17-180f7c54ef13@amazon.com>
Date:   Sun, 5 Sep 2021 17:36:23 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTTCycq4KTBk6r/s@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.164]
X-ClientProxiedBy: EX13D14UWB003.ant.amazon.com (10.43.161.162) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 05/09/2021 16:14, Leon Romanovsky wrote:
> On Sun, Sep 05, 2021 at 02:05:15PM +0300, Gal Pressman wrote:
>> On 05/09/2021 13:54, Leon Romanovsky wrote:
>>> On Sun, Sep 05, 2021 at 01:45:41PM +0300, Gal Pressman wrote:
>>>> On 05/09/2021 10:59, Leon Romanovsky wrote:
>>>>> On Sun, Sep 05, 2021 at 10:25:17AM +0300, Gal Pressman wrote:
>>>>>> On 02/09/2021 18:41, Jason Gunthorpe wrote:
>>>>>>> On Thu, Sep 02, 2021 at 06:17:45PM +0300, Gal Pressman wrote:
>>>>>>>> On 02/09/2021 18:10, Jason Gunthorpe wrote:
>>>>>>>>> On Thu, Sep 02, 2021 at 06:09:39PM +0300, Gal Pressman wrote:
>>>>>>>>>> On 02/09/2021 16:02, Jason Gunthorpe wrote:
>>>>>>>>>>> On Thu, Sep 02, 2021 at 10:03:16AM +0300, Gal Pressman wrote:
>>>>>>>>>>>> On 01/09/2021 18:36, Jason Gunthorpe wrote:
>>>>>>>>>>>>> On Wed, Sep 01, 2021 at 05:24:43PM +0300, Gal Pressman wrote:
>>>>>>>>>>>>>> On 01/09/2021 14:57, Jason Gunthorpe wrote:
>>>>>>>>>>>>>>> On Wed, Sep 01, 2021 at 02:50:42PM +0300, Gal Pressman wrote:
>>>>>>>>>>>>>>>> On 20/08/2021 21:27, Jason Gunthorpe wrote:
>>>>>>>>>>>>>>>>> On Wed, Aug 11, 2021 at 06:11:31PM +0300, Gal Pressman wrote:
>>>>>>>>>>>>>>>>>> diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
>>>>>>>>>>>>>>>>>> index 417dea5f90cf..29db4dec02f0 100644
>>>>>>>>>>>>>>>>>> +++ b/drivers/infiniband/hw/efa/efa_main.c
>>>>>>>>>>>>>>>>>> @@ -67,6 +67,46 @@ static void efa_release_bars(struct efa_dev *dev, int bars_mask)
>>>>>>>>>>>>>>>>>>      pci_release_selected_regions(pdev, release_bars);
>>>>>>>>>>>>>>>>>>  }
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> +static void efa_process_comp_eqe(struct efa_dev *dev, struct efa_admin_eqe *eqe)
>>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>>> +    u16 cqn = eqe->u.comp_event.cqn;
>>>>>>>>>>>>>>>>>> +    struct efa_cq *cq;
>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>> +    cq = xa_load(&dev->cqs_xa, cqn);
>>>>>>>>>>>>>>>>>> +    if (unlikely(!cq)) {
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> This seems unlikely to be correct, what prevents cq from being
>>>>>>>>>>>>>>>>> destroyed concurrently?
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> A comp_handler cannot be running after cq destroy completes.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Sorry for the long turnaround, was OOO.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> The CQ cannot be destroyed until all completion events are acked.
>>>>>>>>>>>>>>>> https://github.com/linux-rdma/rdma-core/blob/7fd01f0c6799f0ecb99cae03c22cf7ff61ffbf5a/libibverbs/man/ibv_get_cq_event.3#L45
>>>>>>>>>>>>>>>> https://github.com/linux-rdma/rdma-core/blob/7fd01f0c6799f0ecb99cae03c22cf7ff61ffbf5a/libibverbs/cmd_cq.c#L208
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> That is something quite different, and in userspace.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> What in the kernel prevents tha xa_load and the xa_erase from racing together?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Good point.
>>>>>>>>>>>>>> I think we need to surround efa_process_comp_eqe() with an rcu_read_lock() and
>>>>>>>>>>>>>> have a synchronize_rcu() after removing it from the xarray in
>>>>>>>>>>>>>> destroy_cq.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Try to avoid synchronize_rcu()
>>>>>>>>>>>>
>>>>>>>>>>>> I don't see how that's possible?
>>>>>>>>>>>
>>>>>>>>>>> Usually people use call_rcu() instead
>>>>>>>>>>
>>>>>>>>>> Oh nice, thanks.
>>>>>>>>>>
>>>>>>>>>> I think the code would be much simpler using synchronize_rcu(), and the
>>>>>>>>>> destroy_cq flow is usually on the cold path anyway. I also prefer to be certain
>>>>>>>>>> that the CQ is freed once the destroy verb returns and not rely on the callback
>>>>>>>>>> scheduling.
>>>>>>>>>
>>>>>>>>> I would not be happy to see synchronize_rcu on uverbs destroy
>>>>>>>>> functions, it is too easy to DOS the kernel with that.
>>>>>>>>
>>>>>>>> OK, but isn't the fact that the uverb can return before the CQ is actually
>>>>>>>> destroyed problematic?
>>>>>>>
>>>>>>> Yes, you can't allow that, something other than RCU needs to prevent
>>>>>>> that
>>>>>>>
>>>>>>>> Maybe it's an extreme corner case, but if I created max_cq CQs, destroyed one,
>>>>>>>> and try to create another one, it is not guaranteed that the create operation
>>>>>>>> would succeed - even though the destroy has finished.
>>>>>>>
>>>>>>> More importantly a driver cannot call completion callbacks once
>>>>>>> destroy cq has returned.
>>>>>>
>>>>>> So how is having some kind of synchronization to wait for the call_rcu()
>>>>>> callback to finish different than using synchronize_rcu()? We'll have to wait
>>>>>> for the readers to finish before returning.
>>>>>
>>>>> Why do you need to do anything special in addition to nullify
>>>>> completion callback which will ensure that no new readers are
>>>>> coming and call_rcu to make sure that existing readers finished?
>>>>
>>>> I ensure there are no new readers by removing the CQ from the xarray.
>>>> Then I must wait for all existing readers before returning from efa_destroy_cq
>>>> and freeing the cq struct (which is done by ib_core).
>>>
>>> IB/core calls to rdma_restrack_del() which wait_for_completion() before
>>> freeing CQ and returning to the users. You don't need to wait in
>>> efa_destroy_cq().
>>
>> The irq flow doesn't call rdma_restrack_get() so I'm not sure how the
>> wait_for_completion() makes a difference here.
>> And if it does then the code is fine as is? There's nothing the call_rcu() needs
>> to do.
> 
> I can't say if it is needed or not, just wanted to understand why you need
> complexity in destroy_cq path.

Well, as I said, I don't think the restrack protection is enough in this case as
it isn't aware of the concurrent eq flow.

I guess I can put a synchronize_irq() on destroy_cq flow to get rid of the race.
