Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AB039ED2A
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 05:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhFHDwL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 23:52:11 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:45888 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhFHDwK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Jun 2021 23:52:10 -0400
Received: by mail-oi1-f177.google.com with SMTP id w127so20243142oig.12
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 20:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4V1UKngQb1OfdlMJvAzivz52HPO3vyo6u+Kdok2BV68=;
        b=sqkxVOnRnoz/b2srZ+7OLyfPVFnOjEe4sCYUrfm+Q/UcQjV94ZvFEJEQahMyKtGPbf
         r7yQqbWQJHOg5+N2ReSn8ee5BZ9gdGAz38c7J9zAKPpbtYr3SW2qfreoqa+idOV4rEJs
         rjN4FnCeYGmWDyiHNGE5pKN4B78frLx59QE9UT5JNFrScBk6oby5ElLpdnOJ7arau0ge
         K66fS/F5cnPjjhxVo/nPQxQRcmq4o4Ua7QcDnWyiRzf/RLLf6j1F9/bfsC1BQzE8Goe6
         ASSws2EEAiuI3vLTTZSEQbvfn8Ki9YFTdvkObm2bibfG5opErWNn3tJSuuomU0vFjY5l
         tW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4V1UKngQb1OfdlMJvAzivz52HPO3vyo6u+Kdok2BV68=;
        b=MyqA7SheoBEpOyFATsd62Xs0rcJkXMcnzkZeb7boVDU0Z5lXdaMpdp1hP69fUk/2Vu
         MN0zwgLMLh7fVjFKA4mKcJQRzuOAHCKBdOIa5GsMF/6+efFTuvwTm0qtNVhIxBWEGgOr
         OBbUyBcicaEsGlO/SclrubwirBROz/qu/xg0IBoyVJ6IYS9F71axViHG5gVhzPxaAUFB
         iQh97XGYPomflcMsgnCm16vlc31a06mW3AodheZ5xiNuhF9vVEWuwvj+3Fqf70BPjX86
         UC4jb4c9hIWEZFRMqIe2cNuoCbuk1qcbbOc/jpJbLX1cr2dBxtYChiP/O94sjosPMVq1
         PoKw==
X-Gm-Message-State: AOAM533TUS/hetEfkwKUf95BRf+4C1ka7Xe1Us2a9ezyxB/Nw5+7NeQY
        KGq2eEQUSb0Irz0Zo84oZc7k2ImTv6TS1UkLslQ=
X-Google-Smtp-Source: ABdhPJxnoEe6hrRu3lDnUl/N/3M0a1FK9i74y1FpdyICd8/oNO7yZ6eUL3Z6qnpFx9nWJKfqDkbkI34Ew6Olb52/wyg=
X-Received: by 2002:aca:2404:: with SMTP id n4mr1542587oic.169.1623124144914;
 Mon, 07 Jun 2021 20:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210604230558.4812-1-rpearsonhpe@gmail.com> <CAD=hENcwwjS8X2R24+cFRyyrA5_k=F5LuC4bx1tzCVW969uvuQ@mail.gmail.com>
 <YL389Dqd8+akhb1i@unreal> <CAD=hENd6J=1eTPn3u8M5rvym1xP_A30DnreKOCvi+hLTh0iuNw@mail.gmail.com>
 <e0be8fe4-dcda-ddbe-faa4-104d36442b96@gmail.com> <CAD=hENeoK7971B4koPPaJ+u_DL=VSgL8zoF3GZXexozSHuK8pA@mail.gmail.com>
 <95a4ddf1-fcbc-51fd-6cc7-932f065c61bf@gmail.com>
In-Reply-To: <95a4ddf1-fcbc-51fd-6cc7-932f065c61bf@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 8 Jun 2021 11:48:53 +0800
Message-ID: <CAD=hENdJeroo5+MaxBFMKfF8zJjVkEbMXFffUjBKZjODLxQgvg@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix qp reference counting for atomic ops
To:     "Pearson, Robert B" <rpearsonhpe@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 8, 2021 at 10:01 AM Pearson, Robert B <rpearsonhpe@gmail.com> wrote:
>
>
> On 6/7/2021 8:39 PM, Zhu Yanjun wrote:
> > On Tue, Jun 8, 2021 at 12:14 AM Pearson, Robert B <rpearsonhpe@gmail.com> wrote:
> >>
> >> On 6/7/2021 6:12 AM, Zhu Yanjun wrote:
> >>> On Mon, Jun 7, 2021 at 7:03 PM Leon Romanovsky <leon@kernel.org> wrote:
> >>>> On Mon, Jun 07, 2021 at 04:16:37PM +0800, Zhu Yanjun wrote:
> >>>>> On Sat, Jun 5, 2021 at 7:07 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >>>>>> Currently the rdma_rxe driver attempts to protect atomic responder
> >>>>>> resources by taking a reference to the qp which is only freed when the
> >>>>>> resource is recycled for a new read or atomic operation. This means that
> >>>>>> in normal circumstances there is almost always an extra qp reference
> >>>>>> once an atomic operation has been executed which prevents cleaning up
> >>>>>> the qp and associated pd and cqs when the qp is destroyed.
> >>>>>>
> >>>>>> This patch removes the call to rxe_add_ref() in send_atomic_ack() and the
> >>>>>> call to rxe_drop_ref() in free_rd_atomic_resource(). If the qp is
> >>>>> Not sure if it is a good way to fix this problem by removing the call
> >>>>> to rxe_add_ref.
> >>>>> Because taking a reference to the qp is to protect atomic responder resources.
> >>>>>
> >>>>> Removing rxe_add_ref is to decrease the protection of the atomic
> >>>>> responder resources.
> >>>> All those rxe_add_ref/rxe_drop_ref in RXE are horrid. It will be good to delete them all.
> >>>>
> >>> I made tests with this commit. After this commit is applied, this
> >>> problem disappeared.
> >> You were testing MW when you saw this bug. Does that mean that now MW is
> >> working for you?
> > Your MW patches are huge. After these patches are applied, I found 2
> > problems in my test environment.
>
> The trace you showed looked like the pyverbs tests all passed and then
> there were leaked QP/PD/CQ. I also saw those. After fixing the QP
> reference count bug (not in MW) I did not see any errors from the
> pyverbs tests of MW. Or any other errors for that matter. What was the
> other problem? Was that the memory barrier one (also not in MW)?
>
> Mostly I want to know if you currently see any errors in the kernel
> related to MW. The test case bug (in test_qpex.py) is a separate issue

The current test cases in rdma-core just confirm a regression in RXE.

Zhu Yanjun

> that is not a rxe bug at all.
>
> Bob
>
> > So IMO, can you send the test cases about MW to rdma-core? So we can
> > verify these MW patches with them.
> >
> > In previous mails, you mentioned these MW test cases.
> >
> > Thanks a lot.
> > Zhu Yanjun
> >
> >>> Zhu Yanjun
> >>>
> >>>> Thanks
