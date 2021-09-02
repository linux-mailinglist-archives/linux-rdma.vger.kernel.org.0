Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453D93FE9A9
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 09:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242956AbhIBHEb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 03:04:31 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:50095 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242875AbhIBHEb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Sep 2021 03:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1630566214; x=1662102214;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=aNvIJIxasNCrDoXPix03/CFYbVuPbiGgTXIiPFUnDfI=;
  b=jsLtPZHYIHN/ENwggNdhti4m/ArKIs/Q/9OH1m8zpO/7VqvL5Mr4I6AG
   du6j6KAzC/UiJSD2IXlpORVpsXziziUYIotcGRoGBY8ZZ5np5wqhcaHK3
   2oxWdwcJQa0PCPqY2Gx2wZF2d+SpfI0Qfr+GmNyphaLn0/a0uXJdzunYY
   Y=;
X-IronPort-AV: E=Sophos;i="5.84,371,1620691200"; 
   d="scan'208";a="137256772"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-28209b7b.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 02 Sep 2021 07:03:27 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-28209b7b.us-east-1.amazon.com (Postfix) with ESMTPS id 09EE9BBC59;
        Thu,  2 Sep 2021 07:03:24 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.176) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Thu, 2 Sep 2021 07:03:20 +0000
Subject: Re: [PATCH for-next 4/4] RDMA/efa: CQ notifications
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20210811151131.39138-1-galpress@amazon.com>
 <20210811151131.39138-5-galpress@amazon.com>
 <20210820182702.GA550455@nvidia.com>
 <7a4963ea-f028-e787-a5ba-fabf907c6d6b@amazon.com>
 <20210901115716.GG1721383@nvidia.com>
 <c8549e51-47a2-1426-b44b-f1c4ade3dce2@amazon.com>
 <20210901153659.GL1721383@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <d1b2dc01-5a42-371e-c4b6-2f9b3425f5b6@amazon.com>
Date:   Thu, 2 Sep 2021 10:03:16 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210901153659.GL1721383@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.176]
X-ClientProxiedBy: EX13D17UWB002.ant.amazon.com (10.43.161.141) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 01/09/2021 18:36, Jason Gunthorpe wrote:
> On Wed, Sep 01, 2021 at 05:24:43PM +0300, Gal Pressman wrote:
>> On 01/09/2021 14:57, Jason Gunthorpe wrote:
>>> On Wed, Sep 01, 2021 at 02:50:42PM +0300, Gal Pressman wrote:
>>>> On 20/08/2021 21:27, Jason Gunthorpe wrote:
>>>>> On Wed, Aug 11, 2021 at 06:11:31PM +0300, Gal Pressman wrote:
>>>>>> diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
>>>>>> index 417dea5f90cf..29db4dec02f0 100644
>>>>>> +++ b/drivers/infiniband/hw/efa/efa_main.c
>>>>>> @@ -67,6 +67,46 @@ static void efa_release_bars(struct efa_dev *dev, int bars_mask)
>>>>>>  	pci_release_selected_regions(pdev, release_bars);
>>>>>>  }
>>>>>>  
>>>>>> +static void efa_process_comp_eqe(struct efa_dev *dev, struct efa_admin_eqe *eqe)
>>>>>> +{
>>>>>> +	u16 cqn = eqe->u.comp_event.cqn;
>>>>>> +	struct efa_cq *cq;
>>>>>> +
>>>>>> +	cq = xa_load(&dev->cqs_xa, cqn);
>>>>>> +	if (unlikely(!cq)) {
>>>>>
>>>>> This seems unlikely to be correct, what prevents cq from being
>>>>> destroyed concurrently?
>>>>>
>>>>> A comp_handler cannot be running after cq destroy completes.
>>>>
>>>> Sorry for the long turnaround, was OOO.
>>>>
>>>> The CQ cannot be destroyed until all completion events are acked.
>>>> https://github.com/linux-rdma/rdma-core/blob/7fd01f0c6799f0ecb99cae03c22cf7ff61ffbf5a/libibverbs/man/ibv_get_cq_event.3#L45
>>>> https://github.com/linux-rdma/rdma-core/blob/7fd01f0c6799f0ecb99cae03c22cf7ff61ffbf5a/libibverbs/cmd_cq.c#L208
>>>
>>> That is something quite different, and in userspace.
>>>
>>> What in the kernel prevents tha xa_load and the xa_erase from racing together?
>>
>> Good point.
>> I think we need to surround efa_process_comp_eqe() with an rcu_read_lock() and
>> have a synchronize_rcu() after removing it from the xarray in
>> destroy_cq.
> 
> Try to avoid synchronize_rcu()

I don't see how that's possible?

>> Though I'd like to avoid copy-pasting xa_load() in order to use the
>> advanced xas_load() function.
> 
> Why would you need that? Just call xa_load() while holding the
> rcu_read_lock() if that is what you want. Can you put the whole
> function under the rcu_read_lock()?

Sure, I wasn't sure if it's OK to nest rcu_read_lock() calls.

>> Do you have any better ideas?
> 
> Other common alternative is to use the xa_lock(), but that doesn't
> seem suitable for an EQ

Right, I think I'll go with the rcu approach.
