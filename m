Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DB748E537
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jan 2022 09:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiANIKm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jan 2022 03:10:42 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47611 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231576AbiANIKm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Jan 2022 03:10:42 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AMFIIQa5hdN3TcH2ISgYsNwxRtEvGchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENShjUHzzYYUGqDbK6JZ2WnfYtya4S28hkBu5HVytAxHVE5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvSHuOlVLa?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/h1ycdNtJ6xQ?=
 =?us-ascii?q?AEBMLDOmfgGTl9TFCQW0ahuoeWfeiXi653Kp6HBWz62qxl0N2ksJYAR4P1wB2F?=
 =?us-ascii?q?W+NQXLTkMalaIgOfe6KCqSPt9hJ57dJHDM4YWu3UmxjbcZd4iQJnFTLrH48dV2?=
 =?us-ascii?q?jgYht1HAvvfIcEebFJHYB3GJR8JJVYTDJM3mfyAh3/jfjkeo1WQzYIz7m/V5A9?=
 =?us-ascii?q?8yr7gNJzSYNPibcNLkkedo0rC/n/lGVceNdqC2XyJ/2zErubPlDn8XoY6EqO5+?=
 =?us-ascii?q?v9jxlaUwwQ7DRcSUlC7if+ni0K/UpRULEl80i4vq7UisU+mVN/wWzWmr3Oe+B0?=
 =?us-ascii?q?RQdxdF6s98g7l4q7V5RuJQ3IISzdpdtMrrok1SCYs21vPmMnmbRRtv7K9W3OQ7?=
 =?us-ascii?q?rrSpjraBMS/BQfufgddFU1cvYal+9p103ryoh9YOPbdprXI9fvYmVhmdBQDuog?=
 =?us-ascii?q?=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ACTcVJKHuJA/lezhVpLqEjceALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKKSC9Hfb0qynDpp4mPHzP6Qr5OktOpTnoAsDpKk80naQFgrX5Vo3PYOCJgg?=
 =?us-ascii?q?WVEL0=3D?=
X-IronPort-AV: E=Sophos;i="5.88,287,1635177600"; 
   d="scan'208";a="120355291"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Jan 2022 16:10:38 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id A26304D15A4C;
        Fri, 14 Jan 2022 16:10:34 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 14 Jan 2022 16:10:32 +0800
Received: from [192.168.122.212] (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 14 Jan 2022 16:10:34 +0800
Subject: Re: [RFC PATCH rdma-next 01/10] RDMA: mr: Introduce is_pmem
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <aharonl@nvidia.com>, <leon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liangwenpeng@huawei.com>, <yangx.jy@cn.fujitsu.com>,
        <rpearsonhpe@gmail.com>, <y-goto@fujitsu.com>,
        <dan.j.williams@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-2-lizhijian@cn.fujitsu.com>
 <20220106002130.GP6467@ziepe.ca>
 <bf038e6c-66db-50ca-0126-3ad4ac1371e7@fujitsu.com>
From:   "Li, Zhijian" <lizhijian@cn.fujitsu.com>
Message-ID: <4e679df5-633d-cd0c-9de3-16348b2cef35@cn.fujitsu.com>
Date:   Fri, 14 Jan 2022 16:10:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <bf038e6c-66db-50ca-0126-3ad4ac1371e7@fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: A26304D15A4C.AEA32
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Copied to nvdimm list

Thanks

Zhijian


on 2022/1/6 14:12, Li Zhijian wrote:
>
> Add Dan to the party :)
>
> May i know whether there is any existing APIs to check whether
> a va/page backs to a nvdimm/pmem ?
>
>
>
> On 06/01/2022 08:21, Jason Gunthorpe wrote:
>> On Tue, Dec 28, 2021 at 04:07:08PM +0800, Li Zhijian wrote:
>>> We can use it to indicate whether the registering mr is associated with
>>> a pmem/nvdimm or not.
>>>
>>> Currently, we only assign it in rxe driver, for other device/drivers,
>>> they should implement it if needed.
>>>
>>> RDMA FLUSH will support the persistence feature for a pmem/nvdimm.
>>>
>>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>>>   drivers/infiniband/sw/rxe/rxe_mr.c | 47 
>>> ++++++++++++++++++++++++++++++
>>>   include/rdma/ib_verbs.h            |  1 +
>>>   2 files changed, 48 insertions(+)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c 
>>> b/drivers/infiniband/sw/rxe/rxe_mr.c
>>> index 7c4cd19a9db2..bcd5e7afa475 100644
>>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
>>> @@ -162,6 +162,50 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int 
>>> access, struct rxe_mr *mr)
>>>       mr->type = IB_MR_TYPE_DMA;
>>>   }
>>>   +// XXX: the logic is similar with mm/memory-failure.c
>>> +static bool page_in_dev_pagemap(struct page *page)
>>> +{
>>> +    unsigned long pfn;
>>> +    struct page *p;
>>> +    struct dev_pagemap *pgmap = NULL;
>>> +
>>> +    pfn = page_to_pfn(page);
>>> +    if (!pfn) {
>>> +        pr_err("no such pfn for page %p\n", page);
>>> +        return false;
>>> +    }
>>> +
>>> +    p = pfn_to_online_page(pfn);
>>> +    if (!p) {
>>> +        if (pfn_valid(pfn)) {
>>> +            pgmap = get_dev_pagemap(pfn, NULL);
>>> +            if (pgmap)
>>> +                put_dev_pagemap(pgmap);
>>> +        }
>>> +    }
>>> +
>>> +    return !!pgmap;
>> You need to get Dan to check this out, but I'm pretty sure this should
>> be more like this:
>>
>> if (is_zone_device_page(page) && page->pgmap->type == 
>> MEMORY_DEVICE_FS_DAX)
>
> Great, i have added him.
>
>
>
>>
>>
>>> +static bool iova_in_pmem(struct rxe_mr *mr, u64 iova, int length)
>>> +{
>>> +    struct page *page = NULL;
>>> +    char *vaddr = iova_to_vaddr(mr, iova, length);
>>> +
>>> +    if (!vaddr) {
>>> +        pr_err("not a valid iova %llu\n", iova);
>>> +        return false;
>>> +    }
>>> +
>>> +    page = virt_to_page(vaddr);
>> And obviously this isn't uniform for the entire umem, so I don't even
>> know what this is supposed to mean.
>
> My intention is to check if a memory region belongs to a nvdimm/pmem.
> The approach is like that:
> iova(user space)-+                     +-> page -> page_in_dev_pagemap()
>                  |                     |
>                  +-> va(kernel space) -+
> Since current MR's va is associated with map_set where it record the 
> relations
> between iova and va and page. Do do you mean we should travel map_set to
> get its page ? or by any other ways.
>
>
>
>
>
>
>
>>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>>> index 6e9ad656ecb7..822ebb3425dc 100644
>>> +++ b/include/rdma/ib_verbs.h
>>> @@ -1807,6 +1807,7 @@ struct ib_mr {
>>>       unsigned int       page_size;
>>>       enum ib_mr_type       type;
>>>       bool           need_inval;
>>> +    bool           is_pmem;
>> Or why it is being stored in the global struct?
>
> Indeed, it's not strong necessary. but i think is_pmem should belongs 
> to a ib_mr
> so that it can be checked by other general code when they needed even 
> though no
> one does such checking so far.
>
>
> Thanks
> Zhijian
>
>
>
>>
>> Jason
>


