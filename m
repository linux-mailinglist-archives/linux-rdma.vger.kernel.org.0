Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D9A1E860
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 08:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfEOGmb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 02:42:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36758 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfEOGma (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 May 2019 02:42:30 -0400
Received: by mail-qt1-f193.google.com with SMTP id a17so2067635qth.3;
        Tue, 14 May 2019 23:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hR9Bh0PLOG8Q+hrTaoHg7HME+b/vR7S/Y0C9bSL9quE=;
        b=mbIHlmppzHI+wyfkFsWefnZ6YYXbMv8irSmoJ2zyfKgm4mfutbAGZNDKveQazxEAjF
         Dcw2n2k4kEVCEnqIVAZi2E0YdhXk8ZgMjaInjDvwC3jb0yodltlkcUeX1rtWYhbZ3Zof
         PkjsdPuOho2KHJUwUBX5JoYSVxAd/AtMFEt7BAkYDJulfW8gtHead6P+bNcfxV5hL7VV
         TwJl/IZ56+cUuKOCXlZ4oqH2ss+0bQY47AkLUu0/wXs3vMOgRSXXEvhtzonRQAZjvTlP
         nE2mH46F6PPAo7rgvTXWj8MKztapcAzHztz41oGHhjw/U2Ss/Y+fI+k30CtVbk4kyvCc
         BePQ==
X-Gm-Message-State: APjAAAVPYJ1Z/DqcPA1eLEsXLQrENwjXhzyG4q/tkRQr4sZljzwRfnWi
        w+IV8ct7zaclUwNtOD3ypAv50Ux6Dt+NzzPklM4=
X-Google-Smtp-Source: APXvYqzxKgjl6CB8wbBoE0vQtjeQ1HNMJTzWfJ6W9dUeXpasTUc+G7kO4vTF1yWG4NhRvGJ+kfG5/FLArPEsPr+zZH8=
X-Received: by 2002:ac8:390e:: with SMTP id s14mr11037837qtb.343.1557902549174;
 Tue, 14 May 2019 23:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190514194510.GA15465@archlinux-i9> <20190515003202.GA14522@ziepe.ca>
 <20190515050331.GC5225@mtr-leonro.mtl.com> <CAK8P3a0aH9Ezur3r7TDVMPreVKMip2HMEWhUsC_pKhOq7mE+3A@mail.gmail.com>
 <20190515064043.GA944@archlinux-i9>
In-Reply-To: <20190515064043.GA944@archlinux-i9>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 May 2019 08:42:13 +0200
Message-ID: <CAK8P3a1r3QD=pwZqG+SfDkVr_V3P7ueRT8SLss9z+M6OEQst4A@mail.gmail.com>
Subject: Re: undefined reference to `__aeabi_uldivmod' after 25c13324d03d
 ("IB/mlx5: Add steering SW ICM device memory type")
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "fengguang.wu@intel.com" <fengguang.wu@intel.com>,
        "kbuild@01.org" <kbuild@01.org>,
        Ariel Levkovich <lariel@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, Mark Bloch <markb@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 15, 2019 at 8:40 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> On Wed, May 15, 2019 at 08:31:49AM +0200, Arnd Bergmann wrote:
> > On Wed, May 15, 2019 at 7:04 AM Leon Romanovsky <leonro@mellanox.com> wrote:
> > > On Tue, May 14, 2019 at 09:32:02PM -0300, Jason Gunthorpe wrote:
> > > > On Tue, May 14, 2019 at 12:45:10PM -0700, Nathan Chancellor wrote:
> > > > > Hi all,
> > > > >
> > > > > I checked the RDMA mailing list and trees and I haven't seen this
> > > > > reported/fixed yet (forgive me if it has) but when building for arm32
> > > > > with multi_v7_defconfig and the following configs (distilled from
> > > > > allyesconfig):
> > > > >
> > > > > CONFIG_INFINIBAND=y
> > > > > CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
> > > > > CONFIG_INFINIBAND_USER_ACCESS=y
> > > > > CONFIG_MLX5_CORE=y
> > > > > CONFIG_MLX5_INFINIBAND=y
> > > > >
> > > > > The following link time errors occur:
> > > > >
> > > > > arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/main.o: in function `mlx5_ib_alloc_dm':
> > > > > main.c:(.text+0x60c): undefined reference to `__aeabi_uldivmod'
> > > > > arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/cmd.o: in function `mlx5_cmd_alloc_sw_icm':
> > > > > cmd.c:(.text+0x6d4): undefined reference to `__aeabi_uldivmod'
> > > > > arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/cmd.o: in function `mlx5_cmd_dealloc_sw_icm':
> > > > > cmd.c:(.text+0x9ec): undefined reference to `__aeabi_uldivmod'
> > > >
> > > > Fengguang, I'm surprised that 0-day didn't report this earlier..
> > >
> > > I got many successful emails after I pushed this patch to 0-day testing.
> >
> > The long division warnings can compiler specific, and depend on certain
> > optimization options, as compilers can optimize out certain divisions and
> > replace them with multiplications and/or shifts, or prove that they can be
> > replaced with a 32-bit division. If this is a case that gcc manages to
> > optimize but clang does not, it might be worth looking into whether an
> > optimization can be added to clang, in addition to improving the source.
>
> While I did run initially run into this with clang, the errors above are
> with gcc (mainly to show this was going to be a universal problem and
> not just something with clang).

Which gcc version did you use here? Anything particularly old or particularly
new? I think 0-day is on a fairly recent gcc-8, but not the latest gcc-9
release.

    Arnd
