Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAF913D5E9
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 09:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbgAPI0e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 03:26:34 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:36871 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgAPI0e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 03:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1579163194; x=1610699194;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3IvNN/T1Q6pyNv2EnvGBlZ4o4bkWCOTfZ4LCeHhEhBA=;
  b=eReerOzqI7KzDdJsN6wwsIonLxi+pYjy4e6NUDZViJjaQp+/35yKAkpg
   ej4R/fbrL0iNCHZU/p9voOqxq/qelJhzXXSbzO0ulJG6Ev4zxxiPGhYSn
   xf4ni70lE75yYrUlMQEsN1d2BYn+TqjMKKStCBvMfN6xe6qW3CE/ERVKd
   8=;
IronPort-SDR: 4UI5Z9UU405ltOMT6GyKEp2jn5O/ilqUhzpiXwy1xQFl9OYbOXxIRAkE79vZTLtrnn7e1qZoIb
 AGPaP6YfCSug==
X-IronPort-AV: E=Sophos;i="5.70,325,1574121600"; 
   d="scan'208";a="11774902"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 16 Jan 2020 08:26:32 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (Postfix) with ESMTPS id A5ABAC06CE;
        Thu, 16 Jan 2020 08:26:31 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Thu, 16 Jan 2020 08:26:31 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.7) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 16 Jan 2020 08:26:27 +0000
Subject: Re: [PATCH for-next 6/6] RDMA/efa: Do not delay freeing of DMA pages
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20200114085706.82229-1-galpress@amazon.com>
 <20200114085706.82229-7-galpress@amazon.com> <20200115195104.GA929@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <2d4750ff-96ee-557d-3e52-1138dd7bebb8@amazon.com>
Date:   Thu, 16 Jan 2020 10:26:12 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200115195104.GA929@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.7]
X-ClientProxiedBy: EX13P01UWB001.ant.amazon.com (10.43.161.59) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 15/01/2020 21:51, Jason Gunthorpe wrote:
> On Tue, Jan 14, 2020 at 10:57:06AM +0200, Gal Pressman wrote:
>> When destroying a DMA mmapped object, there is no need to delay the
>> pages freeing to dealloc_ucontext as the kernel itself will keep
>> reference count for these pages.
> 
> Why does the commit message talk about dealloc_ucontext but doesn't
> change dealloc_ucontext?

The commit message is wrong :\, we should not delay the free_pages_exact to the
mmap_free callback. We can "put" them on destroy flow and the pages will be
freed by the last consumer (either unmap or destroy).

> 
>> +	free_pages_exact(cq->cpu_addr, cq->size);
>> 	rdma_user_mmap_entry_remove(cq->mmap_entry);
> 
> This is out of order, the pages can't be freed until the entry is
> removed.

Right, I think the order is correct except rdma_user_mmap_entry_remove should be
moved to the beginning of the function.

> 
> There is also a bug in rdma_user_mmap_entry_remove(),
> entry->driver_removed needs to be set while holding the xa_lock or
> this is not the required fence.

I see you sent a patch, I'll take a look.
Thanks for the review.
