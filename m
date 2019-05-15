Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1DA1E84B
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 08:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfEOGcH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 May 2019 02:32:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32959 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfEOGcH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 May 2019 02:32:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id m32so2062478qtf.0;
        Tue, 14 May 2019 23:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VYpboAKKRJlruLKnHnCbgX43ysiaopLHLgeir/JVrpg=;
        b=lhwK/kBaXljZ2vsY3hC3jFdK5ZxxAlkDmqkOQOE0dMmBGrAVGrelktPw2mTNXvkvP+
         +mJRJ80d/NjElDyg2mKeYEWOXf6Cz+FpnE0/pWh8CyzTVkMU9L1YuM746gBCsR75OVC3
         EppbroDoF1QZw4HwcVsV0T017SWnEd2BOhMqQG1eVHNiR+AwZTXqaMh5mxfwMU9u5e67
         whnslZSup6r2X5Ge1/8+bmLmdW1hqLJ1MRq2d0lpU0TPwa5/e3q193M/GY0VxjHcFG3E
         rVzV31SA8bTTRAq57G0OvF11yv9CSFreJ9jmx/FDVImue7havPX6agF9WF3e9vpJoh3g
         ThUg==
X-Gm-Message-State: APjAAAWONfUeLR8Ktfzn0u3KrPZDT6UPUILCU3mliN1mwoOpz2jg4sKT
        Wrn+ul6KUDdvxTU3ZTQeRv8etli5IHwcGqfOrRE=
X-Google-Smtp-Source: APXvYqylzSp3OUk7bhW1N1ZsMzdeH5XrY20V9PXrrS4TJ3uL3dJjLLjpm8MeYqdsoVCHUXpQ9GZNHcOpfBpvurIUIhw=
X-Received: by 2002:ac8:2d21:: with SMTP id n30mr32593475qta.96.1557901925866;
 Tue, 14 May 2019 23:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190514194510.GA15465@archlinux-i9> <20190515003202.GA14522@ziepe.ca>
 <20190515050331.GC5225@mtr-leonro.mtl.com>
In-Reply-To: <20190515050331.GC5225@mtr-leonro.mtl.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 May 2019 08:31:49 +0200
Message-ID: <CAK8P3a0aH9Ezur3r7TDVMPreVKMip2HMEWhUsC_pKhOq7mE+3A@mail.gmail.com>
Subject: Re: undefined reference to `__aeabi_uldivmod' after 25c13324d03d
 ("IB/mlx5: Add steering SW ICM device memory type")
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Nathan Chancellor <natechancellor@gmail.com>,
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

On Wed, May 15, 2019 at 7:04 AM Leon Romanovsky <leonro@mellanox.com> wrote:
> On Tue, May 14, 2019 at 09:32:02PM -0300, Jason Gunthorpe wrote:
> > On Tue, May 14, 2019 at 12:45:10PM -0700, Nathan Chancellor wrote:
> > > Hi all,
> > >
> > > I checked the RDMA mailing list and trees and I haven't seen this
> > > reported/fixed yet (forgive me if it has) but when building for arm32
> > > with multi_v7_defconfig and the following configs (distilled from
> > > allyesconfig):
> > >
> > > CONFIG_INFINIBAND=y
> > > CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
> > > CONFIG_INFINIBAND_USER_ACCESS=y
> > > CONFIG_MLX5_CORE=y
> > > CONFIG_MLX5_INFINIBAND=y
> > >
> > > The following link time errors occur:
> > >
> > > arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/main.o: in function `mlx5_ib_alloc_dm':
> > > main.c:(.text+0x60c): undefined reference to `__aeabi_uldivmod'
> > > arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/cmd.o: in function `mlx5_cmd_alloc_sw_icm':
> > > cmd.c:(.text+0x6d4): undefined reference to `__aeabi_uldivmod'
> > > arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/cmd.o: in function `mlx5_cmd_dealloc_sw_icm':
> > > cmd.c:(.text+0x9ec): undefined reference to `__aeabi_uldivmod'
> >
> > Fengguang, I'm surprised that 0-day didn't report this earlier..
>
> I got many successful emails after I pushed this patch to 0-day testing.

The long division warnings can compiler specific, and depend on certain
optimization options, as compilers can optimize out certain divisions and
replace them with multiplications and/or shifts, or prove that they can be
replaced with a 32-bit division. If this is a case that gcc manages to
optimize but clang does not, it might be worth looking into whether an
optimization can be added to clang, in addition to improving the source.

     Arnd
