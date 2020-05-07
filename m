Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E641C8345
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2020 09:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgEGHNB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 May 2020 03:13:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgEGHNB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 May 2020 03:13:01 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E247207DD;
        Thu,  7 May 2020 07:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588835580;
        bh=IwJ8TK7JJgivvABXQYUUWOlkINcESWWFm1SmQ0uE4YA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qOBZ7uJaKfC248MnOyKHiJMjaMvNULB8tk4Cms7kSAMMj4HMV7T0pMa5CCwQSncF/
         D7Y4+R6X7VrFmYTBVC39ofjdRi9/i2fHDimgFFsHFytMEWvo8EbLjhfU9W/CdWd7zJ
         cFxR6rpahsH4YG0ASk8IXMoYUN/cxmXHP5g4eXbY=
Date:   Thu, 7 May 2020 10:12:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        kbuild-all@lists.01.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v14 23/25] block/rnbd: include client and server modules
 into kernel compilation
Message-ID: <20200507071256.GD78674@unreal>
References: <20200504140115.15533-24-danil.kipnis@cloud.ionos.com>
 <202005060522.xI0z2eA6%lkp@intel.com>
 <CAMGffE=58PZSp3B14d_jCCKwPDr_YHoWxJs9gsmg-2Af60vnrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffE=58PZSp3B14d_jCCKwPDr_YHoWxJs9gsmg-2Af60vnrw@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 07, 2020 at 09:05:26AM +0200, Jinpu Wang wrote:
> Hi, Kbuild test robot,
>
> On Tue, May 5, 2020 at 11:34 PM kbuild test robot <lkp@intel.com> wrote:
> >
> > Hi Danil,
> >
> > I love your patch! Yet something to improve:
> >
> > [auto build test ERROR on block/for-next]
> > [also build test ERROR on driver-core/driver-core-testing rdma/for-next linus/master v5.7-rc4 next-20200505]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> >
> > url:    https://github.com/0day-ci/linux/commits/Danil-Kipnis/RTRS-former-IBTRS-RDMA-Transport-Library-and-RNBD-former-IBNBD-RDMA-Network-Block-Device/20200505-072234
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
> > config: c6x-allyesconfig (attached as .config)
> > compiler: c6x-elf-gcc (GCC) 9.3.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=c6x
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    In file included from drivers/block/rnbd/rnbd-clt.c:19:
> > >> drivers/block/rnbd/rnbd-clt.h:19:10: fatal error: rtrs.h: No such file or directory
> >       19 | #include <rtrs.h>
> >          |          ^~~~~~~~
> >    compilation terminated.
> > --
> >    In file included from drivers/block/rnbd/rnbd-srv.c:15:
> > >> drivers/block/rnbd/rnbd-srv.h:16:10: fatal error: rtrs.h: No such file or directory
> >       16 | #include <rtrs.h>
> >          |          ^~~~~~~~
> >    compilation terminated.
> >
> > vim +19 drivers/block/rnbd/rnbd-clt.h
> looks somehow the "ccflags-y := -Idrivers/infiniband/ulp/rtrs " was
> ignored in your case
>
> We'll try to repro on ourside, can you also check on your side why
> ccflags is ignored?

It should be ccflags-y := -I $(srctree)/drivers/infiniband/ulp/rtrs

Thanks

>
> Thanks!
> Jinpu
