Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5374348A68
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 08:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCYHtS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 03:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhCYHs5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 03:48:57 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB62C06174A
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 00:48:57 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so1113130otr.4
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 00:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S7naRHTxbsGmtlocJZn7IaHt3bsz5GoRkw0ucEZG2FE=;
        b=Xhb+r8Ttj8/nhwyz6rp18CFHaqqU0Q702sA4paBIYnrOUMiEFIWSkDLTR6eMHdSkQ9
         wJb2kbsZlT1YX2o9BxLMdt0tFwFAJIxdWzlYiXrN25IO73rDXaFQRlQT2tvrhapbjDDP
         S4uNbEQxADANcD7Ss0JHk3+9ypNM+TyXqHWYbN2oVS/SiQGV/eDwbKz+XgRF/bzM4Xuq
         BRwD883qQcfPzfGVZohGWrDcd6METu1ZodbJObpWlAVry7Dh4o1/etiv7D/Iagspk3Mj
         XW797mGy4qovkD/E1IRPnrTavLik/GcOTx7+vjxZkCS0MYf/wG307jpNyzTx5zIqQ3pG
         9YNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S7naRHTxbsGmtlocJZn7IaHt3bsz5GoRkw0ucEZG2FE=;
        b=Ah/pvD/fzmkGDuFzlLQZ5BVNsiSRG/5HM972guTTas6h/bQZcBpNaDb1oH8u49r0wo
         tAfvLgWtNNg+EeoL9hdKvGY7Hfw1YFoib+2euf9Yev36/4rxp0AY4bwnlFy7i5VyZTOY
         udVPuucAffK1KiovjeNEjq21L0BXlQrhpl+2Dl10Zk/ScS3WMGxxIn0gEojB12D4agGw
         PNcMM6H8DAjGEjQUou15415t9/xMt5ABD2YKMPBJSI3DDO1JhvQVR9ki3cojvk3KwY6n
         cZtnjcUHJ+Sw7Ni7M4eKInZdIuOnupgK5Qbv+MLS3IEPxx+QRtHE6y1/j5IkqGp1qTzV
         cocQ==
X-Gm-Message-State: AOAM531JLuacNzYw7mAi63FDDqCBrXHZaEkThewzmikaTktq7QJmbUKe
        SsZyi2vJHzGZDLLgwnFrIHhhtPaWdC8HWZZkLmU=
X-Google-Smtp-Source: ABdhPJzBcSdAivw3SGhEQ+wrOm11BVhnKAbFJ77wNttABNuIVb+y60pwuOU4eRMBXTWG1RiP2YzWGa8DJLZtMmC3ap0=
X-Received: by 2002:a9d:6c94:: with SMTP id c20mr6428149otr.59.1616658537117;
 Thu, 25 Mar 2021 00:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210314222612.44728-1-rpearson@hpe.com> <CAD=hENdyLYLYAyS0Mq_jUb-Vm3P102hiw2Lzmz=hjvgcBn1t-g@mail.gmail.com>
 <c7fd30e5-dfd8-cd95-3b69-ea94432953fd@gmail.com> <20210324170721.GN2356281@nvidia.com>
 <526172c5-b48b-4788-b9d8-7dc37c975033@gmail.com>
In-Reply-To: <526172c5-b48b-4788-b9d8-7dc37c975033@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 25 Mar 2021 15:48:45 +0800
Message-ID: <CAD=hENcgc5PNzvhqjDmPfSgG89JXzMtt10cfEWos334wAoq6oQ@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Split MEM into MR and MW
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 25, 2021 at 1:25 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 3/24/21 12:07 PM, Jason Gunthorpe wrote:
> > On Wed, Mar 24, 2021 at 11:52:19AM -0500, Bob Pearson wrote:
> >>>> +struct rxe_mw {
> >>>> +       struct rxe_pool_entry   pelem;
> >>>> +       struct ib_mw            ibmw;
> >>>> +       struct rxe_qp           *qp;    /* type 2B only */
> >>>> +       struct rxe_mr           *mr;
> >>>> +       spinlock_t              lock;
> >>>> +       enum rxe_mw_state       state;
> >>>> +       u32                     access;
> >>>> +       u64                     addr;
> >>>> +       u64                     length;
> >>>> +};
> >>>
> >>>  struct rxe_qp           *qp;    /* type 2B only */
> >>>  struct rxe_mr           *mr;
> >>>  spinlock_t              lock;
> >>>  enum rxe_mw_state       state;
> >>>  u32                     access;
> >>>  u64                     addr;
> >>>  u64                     length;
> >>>
> >>> The above member variables are not used in your commit. Why keep them
> >>> in this struct rxe_mw?
> >>>
> >>> Zhu Yanjun
> >>>
> >>
> >> There is more to come. The goal here is to implement MW and peeking ahead
> >> MWs need each of those fields. As soon as this change gets accepted I will start
> >> adding code to implement the MW verbs APIs.
> >
> > The requirement is to add things when you need them, so if these are
> > unused here they should move to the patch that requires them
> >
> > Jason
> >
> OK can do. I need to wait another day to see if Zhu is ready to accept the whole idea
> of renaming these things.

Thanks. I am fine with the idea of renaming.

Zhu Yanjun

> There are two other nits in this patch that I could change.
> There was one whitespace change that could come separately (n spaces -> tab) and Leon
> moved the MW into core since the first time I sent this in which requires reversing
> the order of the ibmw atruct and the pelem struct in mw. It has to change before the
> mw struct can actually be used. What do you think?
>
> bob
