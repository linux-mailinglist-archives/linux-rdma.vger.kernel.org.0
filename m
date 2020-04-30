Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B951BF0D5
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2020 09:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgD3HII (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Apr 2020 03:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726427AbgD3HII (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Apr 2020 03:08:08 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBB0C035495
        for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2020 00:08:07 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id f12so3636224edn.12
        for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2020 00:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ilrgyHn4HSahavwDefbY4dNtFwNc/j2Wi6eqEv+YAHw=;
        b=OoH6QPCyaZqQzTQCwTisHLWl3iL2JWLqf0ytp1yTgOtLocNy/YoXirSm47OKv1yRP+
         RJMoG4ml+Njpj+9CL0REwgz28tVN0dBJjXo+u14xNO2vl4MFEQwlD0PvMLT6KfDrHOwz
         PrEuYpIWxMHRZZiaLhYSyh9fomkqnjNUmCuuCwKhAq4CjU5jAsL8/OwRuSFBbgWCkMEw
         F6Vq20IeTnaarHU6gSv0uBf42u0Pzp8JG+mbtIKv+FjxwPk7dndeHJ2bjNqIDdp/TI9I
         v9nk2loz7VZqRqlOtWb3vzwSvzSE1ry/zww27vAAs0U9rjVqgLgwFKLRr3M/nKwQ2lhJ
         2OBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ilrgyHn4HSahavwDefbY4dNtFwNc/j2Wi6eqEv+YAHw=;
        b=SuWK2pDmG8GsFwFM2l8oedicsSj1reSKK4WqDXnrHIU5+N8Bile//VMCUMTFyUmluc
         fQVcuIejawUOi2ZF6+QcgVKq5UrQ+pVraU8oySESFYuAjAfIeacfNy1RId87UPcFtU/3
         IHDfhPxUeUCxkKAhFzvzenY0jWAtjilXZ1atdi2qH1RDifO50TsnS3B9RSvh7mCoh5/a
         vkIK+8XLH1jv/atp3UJBTiryDRPGv7ZyXMHqZInHYMyXWGRuRmzKBBP91P1b9N2YpgX5
         zkZsI38HlkWdA29AaUpxBVfdWidaPJFetgKCOOaON6KxpYx+gLIH2uJ/A5tSQyGqxmLQ
         PdPg==
X-Gm-Message-State: AGi0PuY7GwpJs6hcX73z25AifFyffnufHd7fp9/bD0OY/buNjogpMDPP
        EnTnSG06hVPlHwF1IGubpz7vaFdV8tuNIzU8M161BA==
X-Google-Smtp-Source: APiQypI+JGTwQ5nRWNJAx2DqgEPWmAT4HIKqZhHQ6ejgOQ9m4eC8eSA4MPE0Mufz5RQEnG0OqZ4dpKsXAp5ByoQ4cjE=
X-Received: by 2002:aa7:d306:: with SMTP id p6mr1323655edq.35.1588230486184;
 Thu, 30 Apr 2020 00:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
 <20200427141020.655-24-danil.kipnis@cloud.ionos.com> <20200429171804.GE26002@ziepe.ca>
In-Reply-To: <20200429171804.GE26002@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 30 Apr 2020 09:07:55 +0200
Message-ID: <CAMGffE=W2a1ZXgtKhmGMwMn74OkGwOjKi3KX8HxrBBFkzc5j6Q@mail.gmail.com>
Subject: Re: [PATCH v13 23/25] block/rnbd: include client and server modules
 into kernel compilation
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 29, 2020 at 7:18 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Apr 27, 2020 at 04:10:18PM +0200, Danil Kipnis wrote:
> > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> >
> > Add rnbd Makefile, Kconfig and also corresponding lines into upper
> > block layer files.
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> >  drivers/block/Kconfig       |  2 ++
> >  drivers/block/Makefile      |  1 +
> >  drivers/block/rnbd/Kconfig  | 28 ++++++++++++++++++++++++++++
> >  drivers/block/rnbd/Makefile | 15 +++++++++++++++
> >  4 files changed, 46 insertions(+)
> >  create mode 100644 drivers/block/rnbd/Kconfig
> >  create mode 100644 drivers/block/rnbd/Makefile
> >
> > diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> > index 025b1b77b11a..084b9efcefca 100644
> > +++ b/drivers/block/Kconfig
> > @@ -458,4 +458,6 @@ config BLK_DEV_RSXX
> >         To compile this driver as a module, choose M here: the
> >         module will be called rsxx.
> >
> > +source "drivers/block/rnbd/Kconfig"
> > +
> >  endif # BLK_DEV
> > diff --git a/drivers/block/Makefile b/drivers/block/Makefile
> > index 795facd8cf19..e1f63117ee94 100644
> > +++ b/drivers/block/Makefile
> > @@ -39,6 +39,7 @@ obj-$(CONFIG_BLK_DEV_PCIESSD_MTIP32XX)      += mtip32xx/
> >
> >  obj-$(CONFIG_BLK_DEV_RSXX) += rsxx/
> >  obj-$(CONFIG_ZRAM) += zram/
> > +obj-$(CONFIG_BLK_DEV_RNBD)   += rnbd/
> >
> >  obj-$(CONFIG_BLK_DEV_NULL_BLK)       += null_blk.o
> >  null_blk-objs        := null_blk_main.o
> > diff --git a/drivers/block/rnbd/Kconfig b/drivers/block/rnbd/Kconfig
> > new file mode 100644
> > index 000000000000..4b6d3d816d1f
> > +++ b/drivers/block/rnbd/Kconfig
> > @@ -0,0 +1,28 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +config BLK_DEV_RNBD
> > +     bool
> > +
> > +config BLK_DEV_RNBD_CLIENT
> > +     tristate "RDMA Network Block Device driver client"
> > +     depends on INFINIBAND_RTRS_CLIENT
> > +     select BLK_DEV_RNBD
> > +     help
> > +       RNBD client is a network block device driver using rdma transport.
> > +
> > +       RNBD client allows for mapping of a remote block devices over
> > +       RTRS protocol from a target system where RNBD server is running.
> > +
> > +       If unsure, say N.
> > +
> > +config BLK_DEV_RNBD_SERVER
> > +     tristate "RDMA Network Block Device driver server"
> > +     depends on INFINIBAND_RTRS_SERVER
> > +     select BLK_DEV_RNBD
> > +     help
> > +       RNBD server is the server side of RNBD using rdma transport.
> > +
> > +       RNBD server allows for exporting local block devices to a remote client
> > +       over RTRS protocol.
> > +
> > +       If unsure, say N.
> > diff --git a/drivers/block/rnbd/Makefile b/drivers/block/rnbd/Makefile
> > new file mode 100644
> > index 000000000000..450a9e4974d7
> > +++ b/drivers/block/rnbd/Makefile
> > @@ -0,0 +1,15 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +ccflags-y := -Idrivers/infiniband/ulp/rtrs
> > +
> > +rnbd-client-y := rnbd-clt.o \
> > +               rnbd-common.o \
> > +               rnbd-clt-sysfs.o
> > +
> > +rnbd-server-y := rnbd-srv.o \
> > +               rnbd-common.o \
> > +               rnbd-srv-dev.o \
> > +               rnbd-srv-sysfs.o
>
> keep lists of things sorted
>
> Jason
Will do, thanks
