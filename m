Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E874929AC
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 16:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345798AbiARP3H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 10:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345771AbiARP3F (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jan 2022 10:29:05 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECC8C06161C
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jan 2022 07:29:05 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id c6so16239272plh.6
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jan 2022 07:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e8bsxgP9fDmzRuw6qWFf72IvrW3wUmdFHqldah+o4J0=;
        b=DgzPo6PbYSkA1j3hhsET3Oq6gJO7Ge85+KB+0YOJp42yB32DkAmN6+yPoNo7jt4AlF
         7yBHl2KWHSndYKakV+L2pdZ0kWButRoYTpQo9PVUHzeInoz+Ul5QXG2TRmwaRqnXSK/X
         Nia5uKjZth/Gu3L/H+WqqOOTpbFm1NomF1olhKUc4Y0L63FdZGEjN8oZNRsExZAsE7eH
         xYI2niCY4KfaWhKzpjDFflUiXCVtSHlCXT9Cd+FAD65Rq46sLVku7z+3Z+cZWNCSWP8j
         NAO91SamqooTdor4AnB/wYQnrRIW5xmEfx7JHscddEtq6dBEnRheDpUTZKWhm408+OSW
         HTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8bsxgP9fDmzRuw6qWFf72IvrW3wUmdFHqldah+o4J0=;
        b=efpcr4xn6Xfpp5aleA7zMRMxquZmpHbicufm7WlHmHYwzIG5MdewBIPiXvNSxREXpL
         Pq7I+uHdDejoUhr/Go+uL25THxyhNIPN77gKdjj8k7Ejc2tfSkf6+IcTwpxa4i+Cn9MN
         jf0DlbSBKo8oPeSCdLcW71In2QF9qrSo74AD7UNwuXmRTiKlFxf8zECjESC1hWyic4jY
         xdLa/9oUJ2MMDTOcvkGQ2vHtkGYzPwZKBbJNSSB68aLe4bubZzFi8Sc8lin9Aqfk+LDT
         Vzef9kxDPyOpirE3rPnFglz5RZoXPs3tA8WDX00jBXxoNNlXVbvhfo/S/RDEQAJ9o12m
         EXYg==
X-Gm-Message-State: AOAM530oh1h2X+e/IvYdVv5Rf0K9oLlt/gQRNEZUVdVcvkoGDmYWRlMa
        ifI6jwwaoT+372ZihDVoCGOoru1+8tt1/8Ks4D2OyQ==
X-Google-Smtp-Source: ABdhPJxNTswGKXkKxb/QjEvrhY8z2s3/j4H7t9WW/RzQe54opjBvzY70VWm5TRxHTG1OLSt74CJ9s4MQ2Cy1AdyAgCQ=
X-Received: by 2002:a17:902:ce8f:b0:14a:b9c2:4e5b with SMTP id
 f15-20020a170902ce8f00b0014ab9c24e5bmr10718304plg.132.1642519744882; Tue, 18
 Jan 2022 07:29:04 -0800 (PST)
MIME-Version: 1.0
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-2-lizhijian@cn.fujitsu.com> <20220106002130.GP6467@ziepe.ca>
 <bf038e6c-66db-50ca-0126-3ad4ac1371e7@fujitsu.com> <CAPcyv4h2Cuzm_fn9fi9RqQ_iEwOwuc9qdk5x_7W=VXvsOAVPFA@mail.gmail.com>
 <050c3183-2fc6-03a1-eecd-258744750972@fujitsu.com>
In-Reply-To: <050c3183-2fc6-03a1-eecd-258744750972@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 18 Jan 2022 07:28:54 -0800
Message-ID: <CAPcyv4h2wiJ+2h8Q9PKOysJ-3bG7N7yDeBucW+jWttUjPXRJ7Q@mail.gmail.com>
Subject: Re: [RFC PATCH rdma-next 01/10] RDMA: mr: Introduce is_pmem
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aharonl@nvidia.com" <aharonl@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 18, 2022 at 12:55 AM lizhijian@fujitsu.com
<lizhijian@fujitsu.com> wrote:
>
>
>
> On 17/01/2022 02:11, Dan Williams wrote:
> > On Wed, Jan 5, 2022 at 10:13 PM lizhijian@fujitsu.com
> > <lizhijian@fujitsu.com> wrote:
> >>
> >> Add Dan to the party :)
> >>
> >> May i know whether there is any existing APIs to check whether
> >> a va/page backs to a nvdimm/pmem ?
> >>
> >>
> >>
> >> On 06/01/2022 08:21, Jason Gunthorpe wrote:
> >>> On Tue, Dec 28, 2021 at 04:07:08PM +0800, Li Zhijian wrote:
> >>>> We can use it to indicate whether the registering mr is associated with
> >>>> a pmem/nvdimm or not.
> >>>>
> >>>> Currently, we only assign it in rxe driver, for other device/drivers,
> >>>> they should implement it if needed.
> >>>>
> >>>> RDMA FLUSH will support the persistence feature for a pmem/nvdimm.
> >>>>
> >>>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> >>>>    drivers/infiniband/sw/rxe/rxe_mr.c | 47 ++++++++++++++++++++++++++++++
> >>>>    include/rdma/ib_verbs.h            |  1 +
> >>>>    2 files changed, 48 insertions(+)
> >>>>
> >>>> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> >>>> index 7c4cd19a9db2..bcd5e7afa475 100644
> >>>> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> >>>> @@ -162,6 +162,50 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
> >>>>       mr->type = IB_MR_TYPE_DMA;
> >>>>    }
> >>>>
> >>>> +// XXX: the logic is similar with mm/memory-failure.c
> >>>> +static bool page_in_dev_pagemap(struct page *page)
> >>>> +{
> >>>> +    unsigned long pfn;
> >>>> +    struct page *p;
> >>>> +    struct dev_pagemap *pgmap = NULL;
> >>>> +
> >>>> +    pfn = page_to_pfn(page);
> >>>> +    if (!pfn) {
> >>>> +            pr_err("no such pfn for page %p\n", page);
> >>>> +            return false;
> >>>> +    }
> >>>> +
> >>>> +    p = pfn_to_online_page(pfn);
> >>>> +    if (!p) {
> >>>> +            if (pfn_valid(pfn)) {
> >>>> +                    pgmap = get_dev_pagemap(pfn, NULL);
> >>>> +                    if (pgmap)
> >>>> +                            put_dev_pagemap(pgmap);
> >>>> +            }
> >>>> +    }
> >>>> +
> >>>> +    return !!pgmap;
> >>> You need to get Dan to check this out, but I'm pretty sure this should
> >>> be more like this:
> >>>
> >>> if (is_zone_device_page(page) && page->pgmap->type == MEMORY_DEVICE_FS_DAX)
> >> Great, i have added him.
> >>
> >>
> >>
> >>>
> >>>> +static bool iova_in_pmem(struct rxe_mr *mr, u64 iova, int length)
> >>>> +{
> >>>> +    struct page *page = NULL;
> >>>> +    char *vaddr = iova_to_vaddr(mr, iova, length);
> >>>> +
> >>>> +    if (!vaddr) {
> >>>> +            pr_err("not a valid iova %llu\n", iova);
> >>>> +            return false;
> >>>> +    }
> >>>> +
> >>>> +    page = virt_to_page(vaddr);
> >>> And obviously this isn't uniform for the entire umem, so I don't even
> >>> know what this is supposed to mean.
> >> My intention is to check if a memory region belongs to a nvdimm/pmem.
> >> The approach is like that:
> >> iova(user space)-+                     +-> page -> page_in_dev_pagemap()
> >>                    |                     |
> >>                    +-> va(kernel space) -+
> >> Since current MR's va is associated with map_set where it record the relations
> >> between iova and va and page. Do do you mean we should travel map_set to
> >> get its page ? or by any other ways.
> > Apologies for the delay in responding.
> >
> > The Subject line of this patch is confusing, if you want to know if a
> > pfn is in persistent memory the only mechanism for that is:
> >
> > region_intersects(addr, length, IORESOURCE_MEM, IORES_DESC_PERSISTENT_MEMORY)
> >
> > ...there is otherwise nothing pmem specific about the dev_pagemap
> > infrastructure. Yes, pmem is the primary user, but it is also used for
> > mapping "soft-reserved" memory (See: the EFI_MEMORY_SP) attribute, and
> > other users.
> >
> > Can you clarify the intent? I am missing some context.
>
> thanks for your help @Dan
>
> I'm going to implement a new ibvers called RDMA FLUSH, it will support global visibility
> and persistence placement type.
>
> In my first design, only pmem can support persistence placement type, so i need to introduce
> new attribute is_pmem to RDMA memory region where it associates to a user space address iova
> so that i can reject a persistence placement type to DRAM(non-pmem).

Ok, I think for that case you are better served using the
IORES_DESC_PERSISTENT_MEMORY designation as the gate for attempting
the flush. The dev_pagemap is otherwise only indicating the presence
of device-backed memory pages, not persistence.
