Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E49741A920
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Sep 2021 08:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbhI1G5B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Sep 2021 02:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbhI1G5B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Sep 2021 02:57:01 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC99C061575
        for <linux-rdma@vger.kernel.org>; Mon, 27 Sep 2021 23:55:22 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id o59-20020a9d2241000000b0054745f28c69so25678739ota.13
        for <linux-rdma@vger.kernel.org>; Mon, 27 Sep 2021 23:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZxLlj9n9LBr1GCX1n+mtYbcAQJX6i6hEvbuI/IWhNw=;
        b=FOOzvpyIC+Sjly6ycUfWS95YO3xxqRCvKX7VS1CNQetHpF7j6uXCZMk+DUb7/Pro0n
         3wiloRJsEntV0R0hNYDr9Yqtv6v3dznB2UGDXJm9BO0We55jzKgRL2ziJysrqh7w6eB4
         FMhJWAahfs9V5dW490gTKyE1wIMs2hmt4sFKcCiRIMclDHUEVObcRrhZbcXvEsNlYbOr
         CTSBQ+yD85iMbnXl7GIuAcEnmnxpo4j9fIM21Cx3ZFAdiegAj3ZCBWcBYeS4pxOGT6Qx
         9XtVXFzKAaANkQ41LB4pw9cadTen4s/gEGnyxKvKRKgWM07F++K7Et9tzzOeHSTJ46m6
         DiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZxLlj9n9LBr1GCX1n+mtYbcAQJX6i6hEvbuI/IWhNw=;
        b=xEKd3i0J6UFLeBAlW66dvGW/c98S9PQWlTeCF1CW8LYjlqluxaBVvJ4oH6U/YnCwvr
         V0t20vA6aQgALxCwTmv8htQs6FFTqsicxLVdCHSqr21Fr7+dfH9nYAFiyVHUSKMKuAo3
         WB5kb6pEIYLa3RPxZ5Kbm7JJBLH080j9oTPr/UYX6fp33cqwKNRz1fMXuJUJZmk+I+KB
         9BL+4tDvKWL3Ic/+CdL60kd6wOtdNtUVXvxZgybzlyIkdzlXsKT99KYedo8ebJHVQrEE
         fqT0nViLBsmX76g0kpdHs2HbEKfK9DP/9aMQ60uShrUl1Olh4Oav4helZQf4B8NI9jdK
         F6xA==
X-Gm-Message-State: AOAM533JU2OqemUqB6T5IkHU6TpBiwueNNMV8FYUa7oOOpCsdCQi3lmG
        OeQX3bh4bsh6FnpD80w1I69aaWV4zN5rUwJDrXo=
X-Google-Smtp-Source: ABdhPJzacBv487M7NMc/4Ji/2AnhOIWp/Ij1z08ckgZ9xg2FQJMuk1yBhozOoMCOIhqjzfd4rvaE9vvUIThe50XyDps=
X-Received: by 2002:a05:6830:1089:: with SMTP id y9mr3778783oto.335.1632812121612;
 Mon, 27 Sep 2021 23:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210915011220.307585-1-Rao.Shoaib@oracle.com>
 <20210927191907.GA1582097@nvidia.com> <CAD=hENd0BDMS6BL_M2rDT7N8sZySQHLbzDEfWZ0AvSd6nmFmoQ@mail.gmail.com>
 <6a6cede4-32c3-45aa-86f9-4cd35d90ab4f@oracle.com>
In-Reply-To: <6a6cede4-32c3-45aa-86f9-4cd35d90ab4f@oracle.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 28 Sep 2021 14:55:10 +0800
Message-ID: <CAD=hENeQrNPxjgxbPN0KuKF1XHT+GbEADKX1D3pP0qv=gNXN2Q@mail.gmail.com>
Subject: Re: [PATCH v1] RDMA/rxe: Bump up default maximum values used via uverbs
To:     Shoaib Rao <rao.shoaib@oracle.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 28, 2021 at 12:38 PM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>
>
> On 9/27/21 6:46 PM, Zhu Yanjun wrote:
> > On Tue, Sep 28, 2021 at 3:19 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >> On Tue, Sep 14, 2021 at 06:12:20PM -0700, Rao Shoaib wrote:
> >>> In our internal testing we have found that
> >>> default maximum values are too small.
> >>> Ideally there should be no limits, but since
> >>> maximum values are reported via ibv_query_device,
> >>> we have to return some value. So, the default
> >>> maximums have been changed to large values.
> >>>
> >>> Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
> >>> ---
> >>>
> >>> Resubmitting the patch after applying Bob's latest patches and testing
> >>> using via rping.
> >>>
> >>>   drivers/infiniband/sw/rxe/rxe_param.h | 30 ++++++++++++++-------------
> >>>   1 file changed, 16 insertions(+), 14 deletions(-)
> >> So are we good with this? Bob? Zhu?
> > I have already checked this commit. And I have found 2 problems with
> > this commit.
> > This commit changes many MAXs.
> > And now rxe is not stable enough. Not sure this commit will cause the
> > new problems.
> >
> > Zhu Yanjun
>
> Hi Zhu,
>
> A generic statement without any technical data does not help. As far as
> I am aware, currently there are no outstanding issues. If there are,
> please provide data that clearly shows that the issue is caused by this
> patch.

Hi, Shoaib

With this commit, I found 2 problems.
This is why I suspect that this commit will introduce risks.

Before a commit is sent to the upstream, please make full tests with it.

Zhu Yanjun

>
> Thanks you.
>
> Shoaib
>
> >>> -     RXE_MAX_MR_INDEX                = 0x00010000,
> >>> +     RXE_MAX_MR_INDEX                = DEFAULT_MAX_VALUE,
> >>> +     RXE_MAX_MR                      = DEFAULT_MAX_VALUE - RXE_MIN_MR_INDEX,
> >> Bob, were you saying this was what needed to be bigger to pass
> >> blktests??
> >>
> >> Jason
