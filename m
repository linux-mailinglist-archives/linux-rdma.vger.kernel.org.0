Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C70FA94B72
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 19:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfHSRPN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 13:15:13 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35577 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfHSRPN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 13:15:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id g17so2372969otl.2;
        Mon, 19 Aug 2019 10:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95JNwlUH515NwkOUicNjbj9hslJ6jUMqDHL2G4dhsI0=;
        b=H+761Qcl7nbz67Ifg7WItUYUA8JuG1e/JgEdVZz5Mxl1bt9/RO9/qeqAf+2Se4zY94
         XwF0zKMpzeysxodLLMbo5rapmXFYvcbN6pkLctZED3BD5vwma0cn6mVSXFP2Vv5c7QSA
         3dQAQhcvYj/4oSptDljwcqoDL+wRHrnPcPpoGVirQOFjhu23lgTNCls6B382jAn4/Pyu
         LKSmLgWtBpuQEMBCrfpoylo0VNEuoMXC/LaiUVa1F+B9IHTAwTkFBqzgQbHk3GLv2yYr
         Tg1E7gh5ArOIdP1u3Xei9OKZOaSGDaKjt2Srg3OFGBHO9NnH9xyMTi8cBkfez0XufoQ7
         zznQ==
X-Gm-Message-State: APjAAAXxod/eTGUgNcfK/7L6D8t4efj0L48JRzgxfjbxl98qaTSiUS0q
        n5+Tls18mbFIHaUccnlD0PcI5JUYvsNCAnl+bkU=
X-Google-Smtp-Source: APXvYqw/1TsKCye2X6DuF/vtHdpIhotBMSaQqcU1yN65mTYO7PNQ1WZa7uM0bGhu6/ny2HvyeWcF4mFw4vJUuwQhjB4=
X-Received: by 2002:a9d:7a90:: with SMTP id l16mr19807031otn.297.1566234911975;
 Mon, 19 Aug 2019 10:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190819100526.13788-1-geert@linux-m68k.org> <581e7d79ed75484beb227672b2695ff14e1f1e34.camel@perches.com>
In-Reply-To: <581e7d79ed75484beb227672b2695ff14e1f1e34.camel@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Aug 2019 19:14:59 +0200
Message-ID: <CAMuHMdVh8dwd=77mHTqG80_D8DK+EtVGewRUJuaJzK1qRYrB+w@mail.gmail.com>
Subject: Re: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit due to
 u64/pointer abuse
To:     Joe Perches <joe@perches.com>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Joe,

On Mon, Aug 19, 2019 at 6:56 PM Joe Perches <joe@perches.com> wrote:
> On Mon, 2019-08-19 at 12:05 +0200, Geert Uytterhoeven wrote:
> > When compiling on 32-bit:
> >
> >     drivers/infiniband/sw/siw/siw_cq.c:76:20: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> >     drivers/infiniband/sw/siw/siw_qp.c:952:28: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> []
> > Fix this by applying the following rules:
> >   1. When printing a u64, the %llx format specififer should be used,
> >      instead of casting to a pointer, and printing the latter.
> >   2. When assigning a pointer to a u64, the pointer should be cast to
> >      uintptr_t, not u64,
> >   3. When casting from u64 to pointer, an intermediate cast to uintptr_t
> >      should be added,
>
> I think a cast to unsigned long is rather more common.
>
> uintptr_t is used ~1300 times in the kernel.
> I believe a cast to unsigned long is much more common.

That is true, as uintptr_t was introduced in C99.
Similarly, unsigned long was used before size_t became common.

However, nowadays size_t and uintptr_t are preferred.

> It might be useful to add something to the Documentation
> for this style.  Documentation/process/coding-style.rst
>
> And trivia:
>
> > > diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> []
> > @@ -842,8 +842,8 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
> >                       rv = -EINVAL;
> >                       break;
> >               }
> > -             siw_dbg_qp(qp, "opcode %d, flags 0x%x, wr_id 0x%p\n",
> > -                        sqe->opcode, sqe->flags, (void *)sqe->id);
> > +             siw_dbg_qp(qp, "opcode %d, flags 0x%x, wr_id 0x%llx\n",
> > +                        sqe->opcode, sqe->flags, sqe->id);
>
> Printing possible pointers as %llx is generally not a good idea
> given the desire for %p obfuscation.

Are they pointers? Difficult to know with all the casting...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
