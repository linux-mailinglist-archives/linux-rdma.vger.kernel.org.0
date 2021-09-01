Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5509B3FD904
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Sep 2021 13:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243737AbhIALwC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Sep 2021 07:52:02 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:5799 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbhIALwC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Sep 2021 07:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1630497066; x=1662033066;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=wYzB6FvYoML4Do2f56RwKX3+ebfPpzZB4AulsOJx6f0=;
  b=QOK8mBItBaQc5PGeseA1VJksGLECcq92WXKXueKLlH2McMBY4QHd7uff
   Jhd7MAgue+KxM3usoD5kPjzSa9a5ETdQJR4zxBaOlcW6HQR/32gFqkSq0
   cIY5nKjOy8WoEP+y56LwpImfDT1dX26Fun3I1pWq64jSDVTF819ib55un
   Q=;
X-IronPort-AV: E=Sophos;i="5.84,369,1620691200"; 
   d="scan'208";a="136828718"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-94ef7264.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 01 Sep 2021 11:50:58 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-94ef7264.us-east-1.amazon.com (Postfix) with ESMTPS id 720F0A2AC9;
        Wed,  1 Sep 2021 11:50:56 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.162.52) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Wed, 1 Sep 2021 11:50:52 +0000
Subject: Re: [PATCH for-next 4/4] RDMA/efa: CQ notifications
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20210811151131.39138-1-galpress@amazon.com>
 <20210811151131.39138-5-galpress@amazon.com>
 <20210820182702.GA550455@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <7a4963ea-f028-e787-a5ba-fabf907c6d6b@amazon.com>
Date:   Wed, 1 Sep 2021 14:50:42 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210820182702.GA550455@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.52]
X-ClientProxiedBy: EX13D20UWC001.ant.amazon.com (10.43.162.244) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 20/08/2021 21:27, Jason Gunthorpe wrote:
> On Wed, Aug 11, 2021 at 06:11:31PM +0300, Gal Pressman wrote:
>> diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
>> index 417dea5f90cf..29db4dec02f0 100644
>> +++ b/drivers/infiniband/hw/efa/efa_main.c
>> @@ -67,6 +67,46 @@ static void efa_release_bars(struct efa_dev *dev, int bars_mask)
>>  	pci_release_selected_regions(pdev, release_bars);
>>  }
>>  
>> +static void efa_process_comp_eqe(struct efa_dev *dev, struct efa_admin_eqe *eqe)
>> +{
>> +	u16 cqn = eqe->u.comp_event.cqn;
>> +	struct efa_cq *cq;
>> +
>> +	cq = xa_load(&dev->cqs_xa, cqn);
>> +	if (unlikely(!cq)) {
> 
> This seems unlikely to be correct, what prevents cq from being
> destroyed concurrently?
> 
> A comp_handler cannot be running after cq destroy completes.

Sorry for the long turnaround, was OOO.

The CQ cannot be destroyed until all completion events are acked.
https://github.com/linux-rdma/rdma-core/blob/7fd01f0c6799f0ecb99cae03c22cf7ff61ffbf5a/libibverbs/man/ibv_get_cq_event.3#L45
https://github.com/linux-rdma/rdma-core/blob/7fd01f0c6799f0ecb99cae03c22cf7ff61ffbf5a/libibverbs/cmd_cq.c#L208

>> @@ -421,6 +551,7 @@ static struct efa_dev *efa_probe_device(struct pci_dev *pdev)
>>  	edev->efa_dev = dev;
>>  	edev->dmadev = &pdev->dev;
>>  	dev->pdev = pdev;
>> +	xa_init_flags(&dev->cqs_xa, XA_FLAGS_LOCK_IRQ);
> 
> And this is confusing too, since the above is the only reference and
> doesn't take the xa_lock why does the xa need to use LOCK_IRQ?

Oh, I'm now noticing that the load operation uses an rcu lock, not the xa_lock..
This can be replaced with xa_init().

Thanks for the review.
