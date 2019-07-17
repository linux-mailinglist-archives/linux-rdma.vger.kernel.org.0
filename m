Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C26AE6BBC4
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2019 13:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbfGQLrE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jul 2019 07:47:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34672 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729604AbfGQLrE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jul 2019 07:47:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so11866115plt.1
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jul 2019 04:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XH7pgHFzkwihJR5psn/ZNzGH7d1Hcpwg4ypt2aGmLUk=;
        b=q9rg5oP+7QfRryee4CQfI+zTuO8vcNkAU+Zb8S/XX5gbQKX1OYbsUUbB3B8KK9hFmU
         UHgvh4Mz+Kyv0D5E5zvwH3nJNYoE2P1kzcK2Rg1yMoExsViP4+PURLjfYPF2WZhrd0MF
         a+zGI8yxCxdvE8nZGITXCK8/RaYQDCnkR7z8XELwz+GgVBZndcqvcfCaF4ihTHl0HyVo
         bFY7Esho++ViErb2avPSuS/M58xcsz7oUebcD6xLNGIpCphqGpuQ31GuhoMHpSqGmldC
         ZKZZNvAff0cBNn4NnOvQXzgW64bJR2BOmy7dIGzstZ5vq+Xgsj3OiBdAV2LIo/WRsiLm
         aMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XH7pgHFzkwihJR5psn/ZNzGH7d1Hcpwg4ypt2aGmLUk=;
        b=PBN4VBmpm5SweJBL4+POpBc/WBoZXXMGiGpjdRQqQcYF9Onsvo0GYY0MftdJiqqvkF
         lyA9wnTUp/YGnHCtTi8TcqgYEqeooX6ZJfbbCkNBnsVyxnOMPfga8UuGaZ/Lrtls7kP2
         +jb2VlPdC5EDlTuTeCS3/F2ia3GjEp4K2aYMh8ixBA8IyapSSWj9W6zm9drRJNdZSbNO
         FnsHJXhPqDk/VpMDcKjudyex9A6BoQkR+U4ZarTxPC4rurARSHvkzCdPwzqLgzkW0vio
         lSIDpsZEFJvjYiA6iaipt8AxSIYXApsfJnMcjdZC0dJZ0FKivGtF1KkAePlqKYkdd/Uw
         +nQQ==
X-Gm-Message-State: APjAAAWcUV9RhkRaGrhUCH0VK2ys2iNQI3FNDhuyP5ZgWmB1Z9wRTIVH
        AGJgBJiFYye5aRm4TgPE3R1fqqB0qu8IDFzd/CzalA==
X-Google-Smtp-Source: APXvYqz8S3jyPxed+oPtsIDmi9g4NsD5ItlfcVysZ7+qze2pU/edo+3e3aBEztJRj4XnLTpHjY2eNg/431rKCehxHqk=
X-Received: by 2002:a17:902:8689:: with SMTP id g9mr39736837plo.252.1563364023206;
 Wed, 17 Jul 2019 04:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561386715.git.andreyknvl@google.com> <d8e3b9a819e98d6527e506027b173b128a148d3c.1561386715.git.andreyknvl@google.com>
 <20190624175120.GN29120@arrakis.emea.arm.com> <20190717110910.GA12017@rapoport-lnx>
In-Reply-To: <20190717110910.GA12017@rapoport-lnx>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 17 Jul 2019 13:46:52 +0200
Message-ID: <CAAeHK+yB=d_oXOVZ2TuVe2UkBAx-GM_f+mu88JeVWqPO95xVHQ@mail.gmail.com>
Subject: Re: [PATCH v18 08/15] userfaultfd: untag user pointers
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
        Jason Gunthorpe <jgg@ziepe.ca>,
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
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 17, 2019 at 1:09 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Mon, Jun 24, 2019 at 06:51:21PM +0100, Catalin Marinas wrote:
> > On Mon, Jun 24, 2019 at 04:32:53PM +0200, Andrey Konovalov wrote:
> > > This patch is a part of a series that extends kernel ABI to allow to pass
> > > tagged user pointers (with the top byte set to something else other than
> > > 0x00) as syscall arguments.
> > >
> > > userfaultfd code use provided user pointers for vma lookups, which can
> > > only by done with untagged pointers.
> > >
> > > Untag user pointers in validate_range().
> > >
> > > Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > ---
> > >  fs/userfaultfd.c | 22 ++++++++++++----------
> > >  1 file changed, 12 insertions(+), 10 deletions(-)
> >
> > Same here, it needs an ack from Al Viro.
>
> The userfault patches usually go via -mm tree, not sure if Al looks at them :)

Ah, OK, I guess than Andrew will take a look at them when merging.

>
> FWIW, you can add
>
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

I will, thanks!

>
> > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > index ae0b8b5f69e6..c2be36a168ca 100644
> > > --- a/fs/userfaultfd.c
> > > +++ b/fs/userfaultfd.c
> > > @@ -1261,21 +1261,23 @@ static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
> > >  }
> > >
> > >  static __always_inline int validate_range(struct mm_struct *mm,
> > > -                                     __u64 start, __u64 len)
> > > +                                     __u64 *start, __u64 len)
> > >  {
> > >     __u64 task_size = mm->task_size;
> > >
> > > -   if (start & ~PAGE_MASK)
> > > +   *start = untagged_addr(*start);
> > > +
> > > +   if (*start & ~PAGE_MASK)
> > >             return -EINVAL;
> > >     if (len & ~PAGE_MASK)
> > >             return -EINVAL;
> > >     if (!len)
> > >             return -EINVAL;
> > > -   if (start < mmap_min_addr)
> > > +   if (*start < mmap_min_addr)
> > >             return -EINVAL;
> > > -   if (start >= task_size)
> > > +   if (*start >= task_size)
> > >             return -EINVAL;
> > > -   if (len > task_size - start)
> > > +   if (len > task_size - *start)
> > >             return -EINVAL;
> > >     return 0;
> > >  }
> > > @@ -1325,7 +1327,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > >             goto out;
> > >     }
> > >
> > > -   ret = validate_range(mm, uffdio_register.range.start,
> > > +   ret = validate_range(mm, &uffdio_register.range.start,
> > >                          uffdio_register.range.len);
> > >     if (ret)
> > >             goto out;
> > > @@ -1514,7 +1516,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
> > >     if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
> > >             goto out;
> > >
> > > -   ret = validate_range(mm, uffdio_unregister.start,
> > > +   ret = validate_range(mm, &uffdio_unregister.start,
> > >                          uffdio_unregister.len);
> > >     if (ret)
> > >             goto out;
> > > @@ -1665,7 +1667,7 @@ static int userfaultfd_wake(struct userfaultfd_ctx *ctx,
> > >     if (copy_from_user(&uffdio_wake, buf, sizeof(uffdio_wake)))
> > >             goto out;
> > >
> > > -   ret = validate_range(ctx->mm, uffdio_wake.start, uffdio_wake.len);
> > > +   ret = validate_range(ctx->mm, &uffdio_wake.start, uffdio_wake.len);
> > >     if (ret)
> > >             goto out;
> > >
> > > @@ -1705,7 +1707,7 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
> > >                        sizeof(uffdio_copy)-sizeof(__s64)))
> > >             goto out;
> > >
> > > -   ret = validate_range(ctx->mm, uffdio_copy.dst, uffdio_copy.len);
> > > +   ret = validate_range(ctx->mm, &uffdio_copy.dst, uffdio_copy.len);
> > >     if (ret)
> > >             goto out;
> > >     /*
> > > @@ -1761,7 +1763,7 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
> > >                        sizeof(uffdio_zeropage)-sizeof(__s64)))
> > >             goto out;
> > >
> > > -   ret = validate_range(ctx->mm, uffdio_zeropage.range.start,
> > > +   ret = validate_range(ctx->mm, &uffdio_zeropage.range.start,
> > >                          uffdio_zeropage.range.len);
> > >     if (ret)
> > >             goto out;
> > > --
> > > 2.22.0.410.gd8fdbe21b5-goog
>
> --
> Sincerely yours,
> Mike.
>
