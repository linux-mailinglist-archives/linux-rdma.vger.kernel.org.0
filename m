Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 779829F1F8
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 20:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfH0SAE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 14:00:04 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35612 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbfH0SAD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 14:00:03 -0400
Received: by mail-oi1-f195.google.com with SMTP id a127so15683208oii.2;
        Tue, 27 Aug 2019 11:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QPO1EmTApHiHiWnABEMN8HpFXsluICv3nmTLWB1Pxpo=;
        b=neTWa/3YJ3s9xQLJKvf6EV2KWj/diZrdCj9jlSHbLGgtTRI+KseTQ2VNazL9qeEQFt
         3rhldicaN7Ocu4GnAY83r1pE2CngHrIcUW4AVC46o1bsmfh5jV4K4ZJND485ChAiOxD2
         838gw5AAoQZVCvwTzZUiukaSo5HY81fGc7ZuKIKJ/VDtAmPMU8Oi7H89Fq9pAXcubUWp
         bfP0iw0qYvhhGEEvuZ+MMDQafym3EbO6K8lUcC9SguonfdSxM6sVfi2v43ydrf65QHPG
         W7i+vtTO0BC8AQoakzu2PpZ1e29DWaXQ43g0qqda0M7XY9/V/eBNnOCMBw3lM2JTHI+q
         5u9A==
X-Gm-Message-State: APjAAAWJY90XPCKWpZh4H5Qs/XZQ7P0vN3fMzAl82sHSbRzC0/LzkD4K
        BsNKuGB4/FlN3ujiJtmm46fAMDSUnPpee7Jj50c=
X-Google-Smtp-Source: APXvYqx2Xm3M0g4Hib9pyxxnYu9i3CHaDTC409A3+Br27NP3pL+PtL3gvBqDfsrYdFlGXcdpzSQARYNZg1aZtOK24O4=
X-Received: by 2002:aca:b154:: with SMTP id a81mr99917oif.148.1566928802800;
 Tue, 27 Aug 2019 11:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190819100526.13788-1-geert@linux-m68k.org> <581e7d79ed75484beb227672b2695ff14e1f1e34.camel@perches.com>
 <CAMuHMdVh8dwd=77mHTqG80_D8DK+EtVGewRUJuaJzK1qRYrB+w@mail.gmail.com>
 <dbc03b4ac1ef4ba2a807409676cf8066@AcuMS.aculab.com> <CAMuHMdWHGTMwK+PO_BgsNZMpqRat1SHE-_CP0UqxEALA_OJeNg@mail.gmail.com>
 <20190827174639.GT1131@ZenIV.linux.org.uk>
In-Reply-To: <20190827174639.GT1131@ZenIV.linux.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Aug 2019 19:59:51 +0200
Message-ID: <CAMuHMdW0jEpE3YrA5Znq8O9e4eswARwYYerEhRLSLWxeXMbsEQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit due to
 u64/pointer abuse
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>,
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

Hi Al,

On Tue, Aug 27, 2019 at 7:46 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Tue, Aug 27, 2019 at 07:29:52PM +0200, Geert Uytterhoeven wrote:
> > On Tue, Aug 27, 2019 at 4:17 PM David Laight <David.Laight@aculab.com> wrote:
> > > From: Geert Uytterhoeven
> > > > Sent: 19 August 2019 18:15
> > > ...
> > > > > I think a cast to unsigned long is rather more common.
> > > > >
> > > > > uintptr_t is used ~1300 times in the kernel.
> > > > > I believe a cast to unsigned long is much more common.
> > > >
> > > > That is true, as uintptr_t was introduced in C99.
> > > > Similarly, unsigned long was used before size_t became common.
> > > >
> > > > However, nowadays size_t and uintptr_t are preferred.
> > >
> > > Isn't uintptr_t defined by the same standard as uint32_t?
> >
> > I believe so.
>
> It sure as hell is not.  C99 7.18.1.4:
>
> The following type designates an unsigned integer type with the property that any valid
> pointer to void can be converted to this type, then converted back to pointer to void,
> and the result will compare equal to the original pointer:
>         uintptr_t
>
> IOW, it's "large enough to represent pointers".

I did not say the two types are identical, and can be used interchangeable.

Both types are defined (at least) in
https://pubs.opengroup.org/onlinepubs/009695399/basedefs/stdint.h.html

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
