Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4288B914A
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2019 16:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfITOBp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Sep 2019 10:01:45 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:46691 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbfITOBp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Sep 2019 10:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568988104; x=1600524104;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=aowkE49bc3ByHHUEDi9aagoFNsOCP9k2iEPG2iJHylg=;
  b=TiqjQAS7NGlzTLZ443ib6o4RJyZLIOl9wwM0McN89sueeFdyRyJsKzQ5
   +7LWeLyg8cR+OnYmyaV+f5gyRLe6fq0uFBuAfoqISQnylUTbKidRYpkC7
   Ndv08pLWOOkXEk6s7CSqWCHfdDvuzt70lGmsihy1RqpU8VT9lhTMcFp18
   E=;
X-IronPort-AV: E=Sophos;i="5.64,528,1559520000"; 
   d="scan'208";a="834980687"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 20 Sep 2019 14:00:43 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id F37E8A1897;
        Fri, 20 Sep 2019 14:00:36 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 20 Sep 2019 14:00:36 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.27) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 20 Sep 2019 14:00:31 +0000
Subject: Re: [PATCH v11 rdma-next 6/7] RDMA/qedr: Add doorbell overflow
 recovery support
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Michal Kalderon <michal.kalderon@marvell.com>,
        <mkalderon@marvell.com>, <aelior@marvell.com>,
        <dledford@redhat.com>, <bmt@zurich.ibm.com>, <sleybo@amazon.com>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-7-michal.kalderon@marvell.com>
 <20190919180224.GE4132@ziepe.ca>
 <a0e19fb2-cd5c-4394-16d6-75ac856340b4@amazon.com>
 <20190920133817.GB7095@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <82541758-3e72-d485-6923-cf3336a4297a@amazon.com>
Date:   Fri, 20 Sep 2019 17:00:25 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190920133817.GB7095@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.27]
X-ClientProxiedBy: EX13D29UWC001.ant.amazon.com (10.43.162.143) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 20/09/2019 16:38, Jason Gunthorpe wrote:
> On Fri, Sep 20, 2019 at 04:30:52PM +0300, Gal Pressman wrote:
>> On 19/09/2019 21:02, Jason Gunthorpe wrote:
>>> On Thu, Sep 05, 2019 at 01:01:16PM +0300, Michal Kalderon wrote:
>>>
>>>> @@ -347,6 +360,9 @@ void qedr_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
>>>>  {
>>>>  	struct qedr_user_mmap_entry *entry = get_qedr_mmap_entry(rdma_entry);
>>>>  
>>>> +	if (entry->mmap_flag == QEDR_USER_MMAP_PHYS_PAGE)
>>>> +		free_page((unsigned long)phys_to_virt(entry->address));
>>>> +
>>>
>>> While it isn't wrong it do it this way, we don't need this mmap_free()
>>> stuff for normal CPU pages. Those are refcounted and qedr can simply
>>> call free_page() during the teardown of the uobject that is using the
>>> this page. This is what other drivers already do.
>>
>> This is pretty much what EFA does as well.  When we allocate pages
>> for the user (CQ for example), we DMA map them and later on mmap
>> them to the user. We expect those pages to remain until the entry is
>> freed, how can we call free_page, who is holding a refcount on those
>> except for the driver?
> 
> free_page is kind of a lie, it is more like put_page (see
> __free_pages). I think the difference is that it assumes the page came
> from alloc_page and skips some generic stuff when freeing it.
> 
> When the driver does vm_insert_page the vma holds another refcount and
> the refcount does not go to zero until that page drops out of the
> vma (ie at the same time mmap_free above is called). 
> 
> Then __put_page will do the free_unref_page(), etc.
> 
> So for CPU pages it is fine to not use mmap_free so long as
> vm_insert_page is used

Thanks, I did not know this, it simplifies things.
In that case, maybe the mmap_free callback is redundant.
