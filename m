Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 924456BD37
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2019 15:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfGQNhB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 09:37:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35396 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfGQNgu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jul 2019 09:36:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so10873928pfn.2
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jul 2019 06:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=upJur9hX33jRa5ZDAABYWCcVNIU4OKrA323sUj0kiJ0=;
        b=jU/Zat9i+mrs8cSnCYXrBiEONUz0WXxyKyOECIIPiTvG8WEhtGZGjK61290IX8o36U
         OrHTHQ7Woyg/qn3+sukX8RWKFmT/Ab3vSFlM0FM2BRuiucJNWXV94DF4e2NhGQgdA44A
         dT08TPfZUZgkz0of54cXYItyNEHlQbHBkArsYbqcDoUXDHAB+kz50O9ewS939NtAQV8u
         N3pg+MG4dZM9J1oQTBELA9KEuGXZuE94dTh2nx4VJ6oW11nUXuKKdq/o5lVXbnas7dEB
         7eGFT9GZTTNoP+bU6YviC4h7qnZidfElkMDjIpsDOMoPQb/nzifgWXLs7MlD24BgMlQq
         Xslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upJur9hX33jRa5ZDAABYWCcVNIU4OKrA323sUj0kiJ0=;
        b=Te2tGPi0aVa/5f2k3gNAiASn9cEq3hzMVDDHmKy2or4KwOE2s31vjBdBpHxm8Mw1Xy
         Ld0F0YhBDg1CGKLpWGcHh9XDOXvwlv6bsqZPKDt4QvbANtyvMMkM0dQotVyqb1x950Wr
         OcceFO6Q7bH71zFwBU6hOlIsoHNlNCPhpum1X4SCgxdxTQHI72guaIP95QmhLCX4Eqrl
         OTynLk7MLbqozo0NdYVaVzrcmWnsmpV4U7uLv/WqaJ2fnON2bpkcFEjGMY9oKhXlOfaH
         s48MH+nZK4Ghwn7l1C6l3QZyPFbCYrBM5Kt0qIQopsSWBN1JSqJWgUoPpsykUM1aoR5f
         VPlw==
X-Gm-Message-State: APjAAAVFQ9VG3z6bgdmRv1Vc//EuBqCc+yNFdpQc2JbRiuanigEsQ9/O
        ej8wYlJWPslx9xLASnOuz+JNyiu8ANiE8Yq+cm+IQg==
X-Google-Smtp-Source: APXvYqz7m/UfmCxQEvGyEZmLKWfGDEQqrP2qzxF/oMVv3Ek5NDX+f4ncbRdtOgqzhkxO4Lp3vwbZe7MPyGJ1vZM4Wx0=
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr43162554pje.123.1563370608796;
 Wed, 17 Jul 2019 06:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561386715.git.andreyknvl@google.com> <ea0ff94ef2b8af12ea6c222c5ebd970e0849b6dd.1561386715.git.andreyknvl@google.com>
 <20190624174015.GL29120@arrakis.emea.arm.com> <CAAeHK+y8vE=G_odK6KH=H064nSQcVgkQkNwb2zQD9swXxKSyUQ@mail.gmail.com>
 <20190715180510.GC4970@ziepe.ca> <CAAeHK+xPQqJP7p_JFxc4jrx9k7N0TpBWEuB8Px7XHvrfDU1_gw@mail.gmail.com>
 <20190716120624.GA29727@ziepe.ca> <CAAeHK+xPPQ9QjAksbfWG-Zmnawt-cdw9eO_6GVxjEYcaDGvaRA@mail.gmail.com>
 <20190717115828.GE12119@ziepe.ca>
In-Reply-To: <20190717115828.GE12119@ziepe.ca>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 17 Jul 2019 15:36:37 +0200
Message-ID: <CAAeHK+yyQpc6cxyVeUUWUwiQYy8iAgVXmOVO=EQYSNzy9G8Q0A@mail.gmail.com>
Subject: Re: [PATCH v18 11/15] IB/mlx4: untag user pointers in mlx4_get_umem_mr
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 17, 2019 at 1:58 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Jul 17, 2019 at 01:44:07PM +0200, Andrey Konovalov wrote:
> > On Tue, Jul 16, 2019 at 2:06 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Tue, Jul 16, 2019 at 12:42:07PM +0200, Andrey Konovalov wrote:
> > > > On Mon, Jul 15, 2019 at 8:05 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > >
> > > > > On Mon, Jul 15, 2019 at 06:01:29PM +0200, Andrey Konovalov wrote:
> > > > > > On Mon, Jun 24, 2019 at 7:40 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jun 24, 2019 at 04:32:56PM +0200, Andrey Konovalov wrote:
> > > > > > > > This patch is a part of a series that extends kernel ABI to allow to pass
> > > > > > > > tagged user pointers (with the top byte set to something else other than
> > > > > > > > 0x00) as syscall arguments.
> > > > > > > >
> > > > > > > > mlx4_get_umem_mr() uses provided user pointers for vma lookups, which can
> > > > > > > > only by done with untagged pointers.
> > > > > > > >
> > > > > > > > Untag user pointers in this function.
> > > > > > > >
> > > > > > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > > > > >  drivers/infiniband/hw/mlx4/mr.c | 7 ++++---
> > > > > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > > > > > >
> > > > > > > This patch also needs an ack from the infiniband maintainers (Jason).
> > > > > >
> > > > > > Hi Jason,
> > > > > >
> > > > > > Could you take a look and give your acked-by?
> > > > >
> > > > > Oh, I think I did this a long time ago. Still looks OK.
> > > >
> > > > Hm, maybe that was we who lost it. Thanks!
> > > >
> > > > > You will send it?
> > > >
> > > > I will resend the patchset once the merge window is closed, if that's
> > > > what you mean.
> > >
> > > No.. I mean who send it to Linus's tree? ie do you want me to take
> > > this patch into rdma?
> >
> > I think the plan was to merge the whole series through the mm tree.
> > But I don't mind if you want to take this patch into your tree. It's
> > just that this patch doesn't make much sense without the rest of the
> > series.
>
> Generally I prefer if subsystem changes stay in subsystem trees. If
> the patch is good standalone, and the untag API has already been
> merged, this is a better strategy.

OK, feel free to take this into your tree, this works for me.

>
> Jason
