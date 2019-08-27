Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0959C9F196
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 19:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfH0RaE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 13:30:04 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44943 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0RaE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 13:30:04 -0400
Received: by mail-ot1-f68.google.com with SMTP id w4so19417598ote.11;
        Tue, 27 Aug 2019 10:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lp7s9jTNmH1XT1CzC7jr2iIgsMFcBH+5gm5QDo4mxuA=;
        b=A9zTBHxM0WmsWDF/Tetl+EN3Yah3T+tNfwcNEWVUUyjVeNF2f+FaBQXvAAV4//qual
         29A+5Iwt83YIZX52UxCgeTxkyoIjMG5b2NLxsFeI/ySo+xySNaLANB3YRCZipN3MpA+o
         csKBGCyKHkR8E5ugYuQsvwD1L9/h8/YMlX08mBOVY1rADiX7RxlPhbvYZbqg/ofB0Hq7
         YiBeyr6VTsIZpfyy4td/3+VAKxmfdz37KtgOzEjB0KAnIs8iEDL+UYPyXfjjkZE7SHMg
         6I5hAFXd7HMuhpyJJ4arU+NLbUdHahBo4m8Rn0pJmRllMnlfxuBYFUF20RMx9gGUg5N9
         zOzQ==
X-Gm-Message-State: APjAAAV4Hw9YYxOwaC3Ma9lhuawhTtMu7CXp2iV2llfngB5/OJNJyz9h
        0n00HSgWcZJJfVcRMsDQZ6J3wRwb9BH7Vb/xaYc=
X-Google-Smtp-Source: APXvYqzY25m2s2+2xkANxC+qR9+JKRkF2wxjHDh4iAbFON+7jLENyc3ERXETasyThuzk2O/97gnmmMfYS046Imua1JQ=
X-Received: by 2002:a9d:61c3:: with SMTP id h3mr21336576otk.39.1566927003738;
 Tue, 27 Aug 2019 10:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190819100526.13788-1-geert@linux-m68k.org> <581e7d79ed75484beb227672b2695ff14e1f1e34.camel@perches.com>
 <CAMuHMdVh8dwd=77mHTqG80_D8DK+EtVGewRUJuaJzK1qRYrB+w@mail.gmail.com> <dbc03b4ac1ef4ba2a807409676cf8066@AcuMS.aculab.com>
In-Reply-To: <dbc03b4ac1ef4ba2a807409676cf8066@AcuMS.aculab.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Aug 2019 19:29:52 +0200
Message-ID: <CAMuHMdWHGTMwK+PO_BgsNZMpqRat1SHE-_CP0UqxEALA_OJeNg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit due to
 u64/pointer abuse
To:     David Laight <David.Laight@aculab.com>
Cc:     Joe Perches <joe@perches.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi David,

On Tue, Aug 27, 2019 at 4:17 PM David Laight <David.Laight@aculab.com> wrote:
> From: Geert Uytterhoeven
> > Sent: 19 August 2019 18:15
> ...
> > > I think a cast to unsigned long is rather more common.
> > >
> > > uintptr_t is used ~1300 times in the kernel.
> > > I believe a cast to unsigned long is much more common.
> >
> > That is true, as uintptr_t was introduced in C99.
> > Similarly, unsigned long was used before size_t became common.
> >
> > However, nowadays size_t and uintptr_t are preferred.
>
> Isn't uintptr_t defined by the same standard as uint32_t?

I believe so.

> If the former is allowed so should the latter.

You mean the other way around?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
