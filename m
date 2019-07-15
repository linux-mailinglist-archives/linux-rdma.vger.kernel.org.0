Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3113E68817
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2019 13:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfGOLWB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jul 2019 07:22:01 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36421 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbfGOLWA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 Jul 2019 07:22:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id i21so15777034ljj.3;
        Mon, 15 Jul 2019 04:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gVFqb2ZAh43FCjbdEnlEQIc2JRQwHvSxVmi0yjJ0kAo=;
        b=PHsHodDxb4KtiLFGCXDUFeRaswzWlgBJeoV92SFmmlP3kyYv0P1xtwA+t/SRQ5jI4a
         aW4oAyM6WRHI3loIlxsPfdJdrnQP7lKwhECbIHlr8iT7eXp1ihyOU/9NDkaEQcJsEpUx
         NgHVebj8noMJBQ2BXFmxc9cJnA8/CZP5ye3me20P1QaJxJM5WvA85/rFBzPh3M/acgqm
         80jtwgXUm/hCZp8m/OyoXm+bLI0cHTNv+EtVBWoCAU7we9A0y901KhnQvH672gJM4QTL
         mEIQtOOXxAUzMSRlAAQGsxzVgMWtc4kdnyAiwi6GnlDUjhxtpTa/XNV/+YqANlLmgbS5
         /n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gVFqb2ZAh43FCjbdEnlEQIc2JRQwHvSxVmi0yjJ0kAo=;
        b=fUziWqeV8w+gQRAWXoB4uq0iQM83bc5XTI7YwYBqOTSJLgoyUwLsCM9bYOdIMOi97B
         h4GP/mEdr4dDT0qMWMPoqSXbN7CM3CqsL/Xf+D1UfhtMW/FBZQEEskK2+XKcoBNSRKKB
         O/QEf+ciCJ0l+DybpgaiRqnm+Zm4vO+ohFGKwXRkNE1o/VLPs4sU1Y0omqY3TvFNuAH7
         0aaTt2PZPhDnEXm0ZUqfjaMOeU3+lJk4GZsICP+yIrBwvNOCRoyvwM5CHyDlEQV7bzvJ
         5Lyw2FzBO85X5jsSxFyMOCYbhUk3ma8MMR7tJcySkPC7E74ncMeh7ytqIhuI7go0rOp4
         UvfQ==
X-Gm-Message-State: APjAAAWL+sEsHQUPvODlYNx1v8dVBXs0bfwaFJPg2cIWplZ28P8BRuV6
        6UXTtoCzH7zTeoPRcjgu4BTmQF/3DwdAO6+Wkh8=
X-Google-Smtp-Source: APXvYqz29uFTNm018kjJZXVHplrRKz3F5/gtgS4MImXtgnN/jM6PuvZjPvdIIlU8BM5o+sM2V1Yxzrx0N9s6knwKoEs=
X-Received: by 2002:a2e:3e01:: with SMTP id l1mr10882783lja.208.1563189718743;
 Mon, 15 Jul 2019 04:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <a8f2f1d2-b5d9-92fc-40c8-090af0487723@grimberg.me> <CAHg0HuxZvXH899=M4vC7BTH-bP2J35aTwsGhiGoC8AamD8gOyA@mail.gmail.com>
 <aef765ed-4bb9-2211-05d0-b320cc3ac275@grimberg.me> <CAD9gYJKcJ47ogKL4S_KMtxpS1gPHHhqqG7-GTi-2c0cOJ-LJtw@mail.gmail.com>
 <11653912-924a-965a-45fe-3abd1ca00053@grimberg.me>
In-Reply-To: <11653912-924a-965a-45fe-3abd1ca00053@grimberg.me>
From:   Jinpu Wang <jinpuwang@gmail.com>
Date:   Mon, 15 Jul 2019 13:21:47 +0200
Message-ID: <CAD9gYJ+e-RyDEq4LYL4bZBYNLwCcMqjrEV0cGVjC4k5iK7iMaA@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, bvanassche@acm.org,
        jgg@mellanox.com, dledford@redhat.com,
        Roman Pen <r.peniaev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sagi Grimberg <sagi@grimberg.me> =E4=BA=8E2019=E5=B9=B47=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:40=E5=86=99=E9=81=93=EF=BC=9A
>
>
> > Hi Sagi,
> >
> >>>> Another question, from what I understand from the code, the client
> >>>> always rdma_writes data on writes (with imm) from a remote pool of
> >>>> server buffers dedicated to it. Essentially all writes are immediate=
 (no
> >>>> rdma reads ever). How is that different than using send wrs to a set=
 of
> >>>> pre-posted recv buffers (like all others are doing)? Is it faster?
> >>> At the very beginning of the project we did some measurements and saw=
,
> >>> that it is faster. I'm not sure if this is still true
> >>
> >> Its not significantly faster (can't imagine why it would be).
> >> What could make a difference is probably the fact that you never
> >> do rdma reads for I/O writes which might be better. Also perhaps the
> >> fact that you normally don't wait for send completions before completi=
ng
> >> I/O (which is broken), and the fact that you batch recv operations.
> >
> > I don't know how do you come to the conclusion we don't wait for send
> > completion before completing IO.
> >
> > We do chain wr on successfull read request from server, see funtion
> > rdma_write_sg,
>
> I was referring to the client side
Hi Sagi,

I checked the 3 commits you mentioned in earlier thread again, I now
get your point.
You meant the behavior following commits try to fix.

4af7f7ff92a4 ("nvme-rdma: don't complete requests before a send work
request has completed")
b4b591c87f2b ("nvme-rdma: don't suppress send completions")

In this sense, ibtrs client side are not waiting for the completions
for RDMA WRITE WR to finish.
But we did it right for local invalidation.

I checked SRP/iser, they are not even wait for local invalidation, no
signal flag set.

If it's a problem, we should fix them too, maybe more.

My question is do you see the behavior (HCA retry send due to drop ack
) in the field,
is it possible to reproduce?

Thanks,
Jack
