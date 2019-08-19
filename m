Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3E2692375
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 14:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfHSM37 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 08:29:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33583 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfHSM37 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 08:29:59 -0400
Received: by mail-ot1-f67.google.com with SMTP id q20so1479396otl.0;
        Mon, 19 Aug 2019 05:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IsRCO1emfNARiiccHdZs3eoEu3DM3ET1Pp1CkXOgG7c=;
        b=KbU3cGv7knlXZSYgy8HVFioKVqDZPUeIptkL1PJNFo9xuxjY0G5yJEwPVFBUq2dXxo
         yqGQ5kWlQuFrnVTf03yUzh+KBDvMo0hOi/Kvi/uvp6DWp7AuLXfEqTvapGkEyTD7guqA
         Aupa3ubYeBYAE27tfiUPcYQ8xI43dKXpmvCyiuD4kbIubXQatLS9OM5zbUEhV/E1w3Vp
         UDXsjunOE+37aQnqYviEeoAmNBSu0MAXT3lcq0ZX9awrZSUMgLW5l43WxYCEbKXCJFra
         4RUC9zNpgr5BfEsQTVlN2UvDetjN+s9znMY26Mu1xzluEH3QOnEbP1gpK1gtHLMzufC0
         vt7g==
X-Gm-Message-State: APjAAAVfVGcqM/oky77vY74Os11Dqm+EmWB2C1ajQGd53e4KkdCvYEVm
        6i3rVPs965cm6oUx3rahcon8zPoASHbnm5xZ3Bk=
X-Google-Smtp-Source: APXvYqyxiYph0pDJvjP5Va17X2FnWNRTX53Dq00UbR5hvAOfNslUnZQiV3tcz6v4v3eJxd5bDY2XmcgI9Cn4evCkwug=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr18123159otk.145.1566217798737;
 Mon, 19 Aug 2019 05:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <09bcafaab07dfde728357bfe61b6a7edfa3b25c9.camel@redhat.com>
 <CAMuHMdWp+g-W0rJtVTWEiJpbhcV7GoSkub11fZPMUbhJcxMUNA@mail.gmail.com> <20190819121400.GA5058@ziepe.ca>
In-Reply-To: <20190819121400.GA5058@ziepe.ca>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Aug 2019 14:29:46 +0200
Message-ID: <CAMuHMdWbG0G8cK-Y0A+STRaJLYzsGHA9V1jJZsjddejxQ-qwcg@mail.gmail.com>
Subject: Re: [PULL REQUEST] Please pull rdma.git
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

On Mon, Aug 19, 2019 at 2:14 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Mon, Aug 19, 2019 at 12:08:16PM +0200, Geert Uytterhoeven wrote:
> > On Wed, Aug 14, 2019 at 5:00 PM Doug Ledford <dledford@redhat.com> wrote:
> > > Fairly small pull request for -rc3.  I'm out of town the rest of this
> > > week, so I made sure to clean out as much as possible from patchworks in
> > > enough time for 0-day to chew through it (Yay! for 0-day being back
> > > online! :-)).  Jason might send through any emergency stuff that could
> > > pop up, otherwise I'm back next week.
> > >
> > > The only real thing of note is the siw ABI change.  Since we just merged
> > > siw *this* release, there are no prior kernel releases to maintain
> > > kernel ABI with.  I told Bernard that if there is anything else about
> > > the siw ABI he thinks he might want to change before it goes set in
> > > stone, he should get it in ASAP.  The siw module was around for several
> > > years outside the kernel tree, and it had to be revamped considerably
> > > for inclusion upstream, so we are making no attempts to be backward
> > > compatible with the out of tree version.  Once 5.3 is actually released,
> > > we will have our baseline ABI to maintain.
> >
> > [...]
> >
> > > - Allow siw to be built on 32bit arches (siw, ABI change, but OK since
> > >   siw was just merged this merge window and there is no prior released
> > >   kernel to maintain compatibility with and we also updated the
> > >   rdma-core user space package to match)
> >
> > > Bernard Metzler (1):
> > >       RDMA/siw: Change CQ flags from 64->32 bits
> >
> > Obviously none of this was ever compiled for a 32-bit platform?!?
>
> It is puzzling that 0-day or anyone testing linux-next hasn't noticed
> this in that last 7 weeks are so..

Fair enough. The autobuilders have become a bit overloaded lately.

Still, I would expect a commit that makes a last-minute ABI change to
enable support for 32-bit platforms, to actually compile cleanly on
these 32-bit platforms.
To me, this looks like a big red flag...


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
