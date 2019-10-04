Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4D08CBB69
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 15:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388197AbfJDNP2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 09:15:28 -0400
Received: from mail-yb1-f173.google.com ([209.85.219.173]:38383 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387870AbfJDNP1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 09:15:27 -0400
Received: by mail-yb1-f173.google.com with SMTP id x4so2091388ybr.5
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 06:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/UcVhX9GaoSfCR5Nzgmo8T8FLFMJ0xd65q4Shx2Kmts=;
        b=aVs4zyKIMELcbbp0OrZDIIRM6M9FqgqBWOj7D/V0OOVxjk/TCK1tb1H33aayEVT9Fq
         NOF79kJ75vl2d2aHQWCNVE3mdS8xv2agwN5v/GWtJcU0doJRauKDjzYg6Q6Aok4YYi3b
         mqNPN9hT3Q49dLWzDmTUjRAHeblmpVkFSji5wQrOx6/uMD4mWAJGCY15WvCoWVOEjYTY
         zLXisVJYNrNI9DPaiv0kVngz338cFFvM+h3OzJgZEFf8gZFZm7Iiy5tpDfP2d3CkVb0j
         V4Ux/4E3Ys8h0MioMBqFvf8jY+vH9oklDJ5qpoyn4dUJxko+npNTfqsfS9FFgD1YpKeU
         TCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/UcVhX9GaoSfCR5Nzgmo8T8FLFMJ0xd65q4Shx2Kmts=;
        b=KZz643HD3D8pkkGAF620hyy4oFys6JAGRTaRfrV4amgV+IrLZh7rHhzJlJLocX2ClY
         82U0j7bz7fgKHmiNp4UU1T1kSpzy4hbwsk9DNAvro9oQAXaifAKGg/Ed3y2pRrc93tIi
         1tD0vLUXVRZtF2R7Hh0c1g/eeQ+Vez347Ir5bJ4S+5lwsxykMuq55BU1JFF6uoaUfW3K
         hBiZZU6XHolczev6u1IDM61X+s37qmAYzOiKZX0EDFVi1DDZoMbj3BKuyeHL1uBvL3Ak
         pmx9nujY1TsUy2seL5fUJ/UAVbHzN1YYE0ZdyTsMBpnF7hBuQHrc1O1+ACCQyITDZgdr
         C1RA==
X-Gm-Message-State: APjAAAV1NO0E0JrbKnZetaC3Xfxn5gashtF49oCtC0jFpPTxNuz/5s4i
        ymDTr87PKeicx4ODen81P7GhVZPmCrzH9savI7b0bQ==
X-Google-Smtp-Source: APXvYqzwEQFavuGTQfqs5oMner1fD3hr86iQqTMlgoG4RfUPbRmbA3D9aQz/XYkIYsRESetVSOBhZBfVuAsxsNy+MeI=
X-Received: by 2002:a25:8149:: with SMTP id j9mr1749501ybm.132.1570194926383;
 Fri, 04 Oct 2019 06:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191003201858.11666-1-dave@stgolabs.net> <20191004002609.GB1492@ziepe.ca>
In-Reply-To: <20191004002609.GB1492@ziepe.ca>
From:   Michel Lespinasse <walken@google.com>
Date:   Fri, 4 Oct 2019 06:15:11 -0700
Message-ID: <CANN689G3chM1FjFPdCNm9_OQxazs7YP1PuZLpqGtq=qzaZ0Hbw@mail.gmail.com>
Subject: Re: [PATCH -next 00/11] lib/interval-tree: move to half closed intervals
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

On Thu, Oct 3, 2019 at 5:26 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> Hurm, this is not entirely accurate. Most users do actually want
> overlapping and multiple ranges. I just studied this extensively:

(Just curious, are you the person we discussed this with after the
Maple Tree talk at LPC 2019 ?)

I think we have two separate API problems there:
- overlapping vs non-overlapping intervals (the interval tree API
supports overlapping intervals, but some users are confused about
this)
- closed vs half-open interval definitions

It looks like you have been looking mostly at the first issue, which I
expect could simplify several interval tree users considerably, while
Davidlohr is addressing the second issue here.

> radeon_mn actually wants overlapping but seems to mis-understand the
> interval_tree API and actively tries hard to prevent overlapping at
> great cost and complexity. I have a patch to delete all of this and
> just be overlapping.
>
> amdgpu_mn copied the wrongness from radeon_mn
>
> All the DRM drivers are basically the same here, tracking userspace
> controlled VAs, so overlapping is essential
>
> hfi1/mmu_rb definitely needs overlapping as it is dealing with
> userspace VA ranges under control of userspace. As do the other
> infiniband users.

Do you have a handle on what usnic is doing with its intervals ?
usnic_uiom_insert_interval() has some complicated logic to avoid
having overlapping intervals, which is very confusing to me.

> vhost probably doesn't overlap in the normal case, but again userspace
> could trigger overlap in some pathalogical case.
>
> The [start,last] allows the interval to cover up to ULONG_MAX. I don't
> know if this is needed however. Many users are using userspace VAs
> here. Is there any kernel configuration where ULONG_MAX is a valid
> userspace pointer? Ie 32 bit 4G userspace? I don't know.
>
> Many users seemed to have bugs where they were taking a userspace
> controlled start + length and converting them into a start/end for
> interval tree without overflow protection (woops)
>
> Also I have a series already cooking to delete several of these
> interval tree users, which will terribly conflict with this :\
>
> Is it really necessary to make such churn for such a tiny API change?

My take is that this (Davidlohr's) patch series does not necessarily
need to be applied all at once - we could get the first change in
(adding the interval_tree_gen.h header), and convert the first few
users, without getting them all at once, as long as we have a plan for
finishing the work. So, if you have cleanups in progress in some of
the files, just tell us which ones and we can leave them out from the
first pass.

Thanks,

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
