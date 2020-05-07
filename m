Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E801C8398
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2020 09:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgEGHhR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 May 2020 03:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgEGHhR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 May 2020 03:37:17 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A62C061A10
        for <linux-rdma@vger.kernel.org>; Thu,  7 May 2020 00:37:16 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id r16so4517416edw.5
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2020 00:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YEtUYxGP6c3YM75nf+53+5ZvgqF65+6hKb/BwBYHyPI=;
        b=DxKUKKSFKxGgS+tfkOV2Q6enXeM8fpLfXXgzHZ8aZsN9ENp+twoIbi2eK0mpXT7wsR
         Zt33N2wyxxWUoW7peEHUhTOD6ng6MjNqJg3YAjM9rpUp65FWJvN3m4zw9U3TqCzqIqdR
         qKLOZ7phQFDBGrCDFf1oHEdwHsYXSIyRleqobDWa1UCewndR5LHV44SMq+hDrxjnS+8/
         t/r4qw3DSOFj+MHKkCVZyKc5S2hVUk38unvCQbF7T53G9gzgp6wcwHoODUiuZDbLAC23
         Wky3+JlD4Qy05PXJzilh1wStKNjT8xP3VckvjNqAIl/mcUhKO2/CrXT97Qq5pzdbjJz1
         CAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YEtUYxGP6c3YM75nf+53+5ZvgqF65+6hKb/BwBYHyPI=;
        b=kW0fIR99CsYOrmv8M0SDvdQ58HF5LtG2kBuAmKbwDvXClESlRjy2RYdkn95YPuGI2e
         EPO0yy8f4izTUiOkpFdQ69RTKsoZUfYd6iDAb7WApN+zFUtdFDp3fnFHo9yn2IPl3gbH
         6eiSpk24D/Sr+6Uac4oLeFZJTUl3vtFg+jOXnQTQB/ZOV7ISssR7TgPczefEylx2TBCm
         6mboXXIVJptOr/O2mg3xB/p5zZ80yLsRVRatmzqlMLihB0cM5q842GT/dB8zKBbNU61B
         ohhqkKMaXrGNuq+QtO+Jkl8Uwjc0oK2kEhVUKctayb4SfCibi9SKcSv+s/bpW6yCVwhb
         RafQ==
X-Gm-Message-State: AGi0PuaB8tuzhkXHNQ/GDn4ZQ/MrPaLCe4/aoGGs5j3fNM7N053opUat
        FfYqCD1NWl4ORsFiymtUnkoe6eqWUbbduFLa2xTExg==
X-Google-Smtp-Source: APiQypIXS2NXxL6atjZSZzxsg+2LhmOF6fxQlf9Ijva7zvEoOLw7iotmvSqzSMQ9iBEg03+gfEOzr/Vxd++b/9q7YeY=
X-Received: by 2002:aa7:d306:: with SMTP id p6mr10411834edq.35.1588837035291;
 Thu, 07 May 2020 00:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200504140115.15533-24-danil.kipnis@cloud.ionos.com>
 <202005060522.xI0z2eA6%lkp@intel.com> <CAMGffE=58PZSp3B14d_jCCKwPDr_YHoWxJs9gsmg-2Af60vnrw@mail.gmail.com>
 <20200507071256.GD78674@unreal>
In-Reply-To: <20200507071256.GD78674@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 7 May 2020 09:37:04 +0200
Message-ID: <CAMGffE==CT2cDfRpPnJze9Z9Jc-vXTX5B61PeZ29F17+n8uxKw@mail.gmail.com>
Subject: Re: [PATCH v14 23/25] block/rnbd: include client and server modules
 into kernel compilation
To:     Leon Romanovsky <leon@kernel.org>
Cc:     kbuild test robot <lkp@intel.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        kbuild-all@lists.01.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 7, 2020 at 9:13 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, May 07, 2020 at 09:05:26AM +0200, Jinpu Wang wrote:
> > Hi, Kbuild test robot,
> >
> > On Tue, May 5, 2020 at 11:34 PM kbuild test robot <lkp@intel.com> wrote:
> > >
> > > Hi Danil,
> > >
> > > I love your patch! Yet something to improve:
> > >
> > > [auto build test ERROR on block/for-next]
> > > [also build test ERROR on driver-core/driver-core-testing rdma/for-next linus/master v5.7-rc4 next-20200505]
> > > [if your patch is applied to the wrong git tree, please drop us a note to help
> > > improve the system. BTW, we also suggest to use '--base' option to specify the
> > > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > >
> > > url:    https://github.com/0day-ci/linux/commits/Danil-Kipnis/RTRS-former-IBTRS-RDMA-Transport-Library-and-RNBD-former-IBNBD-RDMA-Network-Block-Device/20200505-072234
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
> > > config: c6x-allyesconfig (attached as .config)
> > > compiler: c6x-elf-gcc (GCC) 9.3.0
> > > reproduce:
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=c6x
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >    In file included from drivers/block/rnbd/rnbd-clt.c:19:
> > > >> drivers/block/rnbd/rnbd-clt.h:19:10: fatal error: rtrs.h: No such file or directory
> > >       19 | #include <rtrs.h>
> > >          |          ^~~~~~~~
> > >    compilation terminated.
> > > --
> > >    In file included from drivers/block/rnbd/rnbd-srv.c:15:
> > > >> drivers/block/rnbd/rnbd-srv.h:16:10: fatal error: rtrs.h: No such file or directory
> > >       16 | #include <rtrs.h>
> > >          |          ^~~~~~~~
> > >    compilation terminated.
> > >
> > > vim +19 drivers/block/rnbd/rnbd-clt.h
> > looks somehow the "ccflags-y := -Idrivers/infiniband/ulp/rtrs " was
> > ignored in your case
> >
> > We'll try to repro on ourside, can you also check on your side why
> > ccflags is ignored?
>
> It should be ccflags-y := -I $(srctree)/drivers/infiniband/ulp/rtrs
>
> Thanks
>
> >
> > Thanks!
> > Jinpu
Alright, thanks for the hint, I think it is the reason.

Will fix it soon!
