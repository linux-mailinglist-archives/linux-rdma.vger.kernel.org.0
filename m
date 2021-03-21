Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D7934329E
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Mar 2021 13:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhCUMzM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Mar 2021 08:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhCUMyp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Mar 2021 08:54:45 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6EAC061574
        for <linux-rdma@vger.kernel.org>; Sun, 21 Mar 2021 05:54:43 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id o19-20020a9d22130000b02901bfa5b79e18so13218326ota.0
        for <linux-rdma@vger.kernel.org>; Sun, 21 Mar 2021 05:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PFkx+QKdncdxQho2dQSjuAjNXS9K4yLkC3qcGX5CEZM=;
        b=Jh/DH6kydMSIAPxtUNPTSnZDohnqxwE/ZFY2DPA9VcC0HkfEZPcSZmkcyuS9YXeOg/
         z3AUujdoeMb43M/bl/7tk00YUheUHK5LJf8l3re0YwrNmemrkPYCkBBEg3gD/onszvjq
         lLBqqatl6MS3gA9LtLMm0f08b2fwwVpqn2u8Xr/4kVXLjZCg3GDp/NleG+jeaJCHMzLQ
         kdrfxOB/gxQpiKEIKdIiUjNHsuf9GUnEQV9BjUsm87DoVLhCIknopKkE+ujNkqo2gllQ
         BNSObXR2VJnL/MNy7un6tuP1O5Ydh+xYAQIml6AJLQRrnRX8w83dv5H8nHemNxyCeeit
         aojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PFkx+QKdncdxQho2dQSjuAjNXS9K4yLkC3qcGX5CEZM=;
        b=aawFwlDZN4rTr1O+gGVswDMNQDx2XogHPa9643JOt557TPy43HH/Q/xgVAHUSzZn2f
         IoPVCQBvRhls8I0c4qTmr/iwqg6IMZ45U/qhR0ZGRqT3NIAVwcERmebRuSeD8TcUtibm
         yvRDNL54leQ6zDxLfCRf0rIBaZAAZ05x0Hm4+q6CE2HbENYeE1F+qM0dRPGea9PrrPz6
         2qXoqUvmD7rjwRe1w6FxaCvg2B2qiYkkNJQSVdHQX/ssxQcNZ5VPZf6RZw7Kx9Z8vYcd
         /BL/+1tUYctJq1vulv+bZ4QSASv1QAONUzlqGIuHxm8UVPC2z8NArN88KAI9e1lnwYow
         Q6bg==
X-Gm-Message-State: AOAM532/M8C24YaZr1Gxm2Ud5wGdDp5y/Ec3evedrHJCDKjCWBSZDNRK
        +ctOncyQhY8+Ji2az73QWIAnqaW1uwzO+kgFUTA=
X-Google-Smtp-Source: ABdhPJwjc9PwLI4XyaEyBALrnFXAqNKGs2UQhPddE82Gn0BhYSjhanPm3Y8PazySfsLKG/4QSrMe+l0jodEhNcSg1nQ=
X-Received: by 2002:a9d:28d:: with SMTP id 13mr8049764otl.278.1616331282673;
 Sun, 21 Mar 2021 05:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=hENdqu3v5_PJwQF2=zQ6ifGZD_DUJtUStoiCA5byru5phaA@mail.gmail.com>
 <CAD=hENf07aKBivP93tN9CAR4oZ9jEygmVKowpxGTdAAV9pjpEA@mail.gmail.com>
 <20210312140104.GX2356281@nvidia.com> <CAD=hENcNLNvX1isjUYutfsDrXzjpJZWBMaB4EkeBMTz7F4x=pw@mail.gmail.com>
 <20210319130059.GQ2356281@nvidia.com> <CAD=hENfH6CZ5AFZ4jVTguA75eLFk0w1JVMzu0od_XGQPfxHTtw@mail.gmail.com>
 <20210319134845.GR2356281@nvidia.com> <CAD=hENcN8dfD9ZGQ-2in2dUeJ9Wzd2+WFWFbhUgovxwCrETL1A@mail.gmail.com>
 <20210320203832.GJ2356281@nvidia.com> <CAD=hENf2mcmCk+22dt8H_O1FRFUQzcLqiknEzoOma=_VR0fz+g@mail.gmail.com>
 <20210321120725.GK2356281@nvidia.com>
In-Reply-To: <20210321120725.GK2356281@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sun, 21 Mar 2021 20:54:31 +0800
Message-ID: <CAD=hENeP0LNGgZdQ6sc+xVN9OAh2C3RQJFVRcmxKJfKdFoOvPQ@mail.gmail.com>
Subject: Re: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 21, 2021 at 8:07 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Sun, Mar 21, 2021 at 04:06:07PM +0800, Zhu Yanjun wrote:
> > > > > You are reporting 4k pages, if max_segment is larger than 4k there is
> > > > > no such thing as "too big"
> > > > >
> > > > > I assume it is "too small" because of some maths overflow.
> > > >
> > > >  459                 while (n_pages && page_to_pfn(pages[0]) == paddr) {
> > > >  460                         if (prv->length + PAGE_SIZE >
> > > > max_segment)  <--it max_segment is big, n_pages is zero.
> > >
> > > What does n_pages have to do with max_segment?
> >
> > With the following snippet
> > "
> >         struct ib_umem *region;
> >         region = ib_umem_get(pd->device, start, len, access);
> >
> >         page_size = ib_umem_find_best_pgsz(region,
> >                                            SZ_4K | SZ_2M | SZ_1G,
> >                                            virt);
> > "
>
> Can you please stop posting random bits of code that do nothing to
> answer the question?
>
> > IMHO, you can reproduce this problem in your local host.
>
> Uh, no, you need to communicate effectively or stop posting please.

can you read the following link again

https://patchwork.kernel.org/project/linux-rdma/patch/CAD=hENeqTTmpS5V+G646V0QvJFLVSd3Sq11ffQFcDXU-OSsQEg@mail.gmail.com/#24031643

In this link, I explained it in details.

Since the max_segment is very big, so normally the prv->length +
PAGE_SIZE is less than max_segment, it will loop over and over again,
until n_pages is zero,
then the function __sg_alloc_table_from_pages will exit. So the
function __sg_alloc_table_from_pages has few chances to call the
function sg_set_page.

This behavior is not like the function ib_umem_add_sg_table. In
ib_umem_add_sg_table, the "max_seg_sz - sg->length" has more chances
to be greater than (len << PAGE_SHIFT).
So the function sg_set_page is called more times than
__sg_alloc_table_from_pages.

The above causes the different sg lists from the 2 functions
__sg_alloc_table_from_pages and ib_umem_add_sg_table.

The most important thing is "if (prv->length + PAGE_SIZE >
max_segment)" in __sg_alloc_table_from_pages and "if ((max_seg_sz -
sg->length) >= (len << PAGE_SHIFT))" in the function
ib_umem_add_sg_table.

When max_segment is UINT_MAX, the different test in the 2 functions
causes the different sg lists.

Zhu Yanjun

>
> Jason
