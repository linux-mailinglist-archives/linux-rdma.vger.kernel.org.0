Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 763751E858
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 08:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbfEOGks (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 02:40:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42369 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfEOGkr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 May 2019 02:40:47 -0400
Received: by mail-ed1-f66.google.com with SMTP id l25so2533910eda.9;
        Tue, 14 May 2019 23:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pB4/bDOJvccGfJ1FOhE3igeaMzQW1LB7DA9kw3mGwcA=;
        b=fqYjW9xMBghHq0o/g67BmnEErWnQO3Q528XrcViy3Ry3AQWeUQ9G/R6U5IHeD1DwbN
         yTejvLC/cc/pz3/Ibl2THEL83zztlPPqicbWEe2+FRupGDatdW9MBaKw2XpJCVNnYIwe
         y6kuXS4I4/JzdOPoPBsisfkRwmUPadQTAdwWwRJ/3jvwtfSB7FtLM+0y7mB9XVq/n1SZ
         aHq80r9aWWdQSMNUtXhhkr4THYUU/PBkcYtfJeqwCALI51lMxU1jF5p/f5TrBv5H6UEm
         krUjx5hEQ557n+saixph+x+sOi/9Ry4BAHfSZBGH2XBllYG8vcFdlYFkvqIk/HiHq/B8
         2gdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pB4/bDOJvccGfJ1FOhE3igeaMzQW1LB7DA9kw3mGwcA=;
        b=YA9uX0HG8qf3gsdEl1zy1NcrL3ip9d2cSc8c8mYfFJ9iG33W+okNdB5iANl56V342L
         hGSGNG82mGj13oYmG8Ar8WS43kfRi7MQzu/sx34cevfQsrzghpuAlExTyVWaEAM1LN8r
         usEs1sQdx5jspzXxhLidbDcnpNgQwmQw0tu5zPJoEHkfyhQPaboB7IqxlrhGhLrzG2mW
         9uAHeLuUghl2goI3nM23rlMRC/3BCOZNeJs/8f302v762ciorb9q0A8H2qGJAGIAfXsa
         oL9MklQ4DYyeCKgYv79nuOVG5V6fZASl4VRZBds6XtIZuuF1A/j2dTPmMPE9P8DYfLzj
         sLDw==
X-Gm-Message-State: APjAAAWFrlsXs/iTqsznyzhqFLZD13DRvk7BD7IYASumzvAemJRsh6rQ
        x8MARWo1kKV2bTp7Oyknsvs=
X-Google-Smtp-Source: APXvYqxA7DciqvkmfZQQEWutHMBRO/nY3I3WvtxPUmgJFu6C8mxugQzAm6gBZpy4Kw6cHtHzjKbKOA==
X-Received: by 2002:a50:b82d:: with SMTP id j42mr41043980ede.186.1557902445899;
        Tue, 14 May 2019 23:40:45 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id v2sm465028eds.69.2019.05.14.23.40.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 23:40:45 -0700 (PDT)
Date:   Tue, 14 May 2019 23:40:43 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "fengguang.wu@intel.com" <fengguang.wu@intel.com>,
        "kbuild@01.org" <kbuild@01.org>,
        Ariel Levkovich <lariel@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, Mark Bloch <markb@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: undefined reference to `__aeabi_uldivmod' after 25c13324d03d
 ("IB/mlx5: Add steering SW ICM device memory type")
Message-ID: <20190515064043.GA944@archlinux-i9>
References: <20190514194510.GA15465@archlinux-i9>
 <20190515003202.GA14522@ziepe.ca>
 <20190515050331.GC5225@mtr-leonro.mtl.com>
 <CAK8P3a0aH9Ezur3r7TDVMPreVKMip2HMEWhUsC_pKhOq7mE+3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0aH9Ezur3r7TDVMPreVKMip2HMEWhUsC_pKhOq7mE+3A@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 15, 2019 at 08:31:49AM +0200, Arnd Bergmann wrote:
> On Wed, May 15, 2019 at 7:04 AM Leon Romanovsky <leonro@mellanox.com> wrote:
> > On Tue, May 14, 2019 at 09:32:02PM -0300, Jason Gunthorpe wrote:
> > > On Tue, May 14, 2019 at 12:45:10PM -0700, Nathan Chancellor wrote:
> > > > Hi all,
> > > >
> > > > I checked the RDMA mailing list and trees and I haven't seen this
> > > > reported/fixed yet (forgive me if it has) but when building for arm32
> > > > with multi_v7_defconfig and the following configs (distilled from
> > > > allyesconfig):
> > > >
> > > > CONFIG_INFINIBAND=y
> > > > CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
> > > > CONFIG_INFINIBAND_USER_ACCESS=y
> > > > CONFIG_MLX5_CORE=y
> > > > CONFIG_MLX5_INFINIBAND=y
> > > >
> > > > The following link time errors occur:
> > > >
> > > > arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/main.o: in function `mlx5_ib_alloc_dm':
> > > > main.c:(.text+0x60c): undefined reference to `__aeabi_uldivmod'
> > > > arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/cmd.o: in function `mlx5_cmd_alloc_sw_icm':
> > > > cmd.c:(.text+0x6d4): undefined reference to `__aeabi_uldivmod'
> > > > arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/cmd.o: in function `mlx5_cmd_dealloc_sw_icm':
> > > > cmd.c:(.text+0x9ec): undefined reference to `__aeabi_uldivmod'
> > >
> > > Fengguang, I'm surprised that 0-day didn't report this earlier..
> >
> > I got many successful emails after I pushed this patch to 0-day testing.
> 
> The long division warnings can compiler specific, and depend on certain
> optimization options, as compilers can optimize out certain divisions and
> replace them with multiplications and/or shifts, or prove that they can be
> replaced with a 32-bit division. If this is a case that gcc manages to
> optimize but clang does not, it might be worth looking into whether an
> optimization can be added to clang, in addition to improving the source.
> 
>      Arnd

While I did run initially run into this with clang, the errors above are
with gcc (mainly to show this was going to be a universal problem and
not just something with clang).

Nathan
