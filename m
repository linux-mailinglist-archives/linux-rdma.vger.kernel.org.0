Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E26C1BBDC1
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2020 14:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgD1Mll (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Apr 2020 08:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726743AbgD1Mll (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Apr 2020 08:41:41 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE090C03C1AC
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2020 05:41:40 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q8so17137748eja.2
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2020 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jb9elzh/74ZWm4bFfjq7/QUpnKgP6S86qUXhjXdPl8=;
        b=WpdqH2v/MZNbC1y2LwFDPVj6TJ8XVB8xtVoaSjQGJjuuIts2SvG/F1aCWEsMgZNz5V
         b8DiEjUBpMGtx9ZZ383qetmnIgvNvrB+SikeXNDp7lsxjyJlhoSEbJRj9vxeKb1NCZWP
         dESZdJFqkC0j6aCmKbtHVRMoZASgG4GTN2qfuvSHwNZis3DNMjshfxvnjgO1KiQHtpCE
         pJzmoHcmgfAtzMcTfD/p28CIl76uMkp/9LQP+ThqL2EI1y90zMeul+C9USJ1pS9wHiPb
         uIVe8riqcxOCdzmI1/tmJD6yWKjsHem5M9pl92ecTHEEZS091dKHfxJYYCpeUVwvanSU
         IMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jb9elzh/74ZWm4bFfjq7/QUpnKgP6S86qUXhjXdPl8=;
        b=VMoecuEHK2Q9E3HSeBxI5gFgY3L4X/FD4jStAtp/qrt+b2lTsCCFJtfSDI6WgEj0JK
         pI6CoFtWxkKxHuK3CNpHtNnSBO+KIg85RIq1Vdcy+jOCS/rkDzw/q6BBIo5FXHyDhGbS
         WI0+mX3B9FoqDpnRcBSmUw9Jkios4vG5frshIRY017RafARCrmtg9HgH6W0jZvvRf817
         E19pJPlxrTq9MluEphetbQXHWXD3i4karxaSM/N4AF+WBKKJoo3YhCXV04DjdtuQ35HK
         7xs6Gv1Bm1d0RlQ/KytsHYPX5tM7VwWeTb3wJo0el2NBJz0Wx9sjQBDNm26EkIJiYtfC
         dQEg==
X-Gm-Message-State: AGi0PuYv3+d3kdsTPre/g8ukcd9w6vcjo3RJ8GFXT+knfsQhi22S5zzX
        fNsg9jK/SuVYmBKvHBPzrLX9TCHZUdYez1m+pE2Vpw==
X-Google-Smtp-Source: APiQypIt5QxH0bocTs9uxDt53Avl+v2Af4RfA+4Dq3POVZYa8RWwnjwHZjjbmBgwTmnGmeTVQr7ZOmZVgX1p+JMfxH0=
X-Received: by 2002:a17:906:9494:: with SMTP id t20mr23467353ejx.51.1588077699476;
 Tue, 28 Apr 2020 05:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <CAMGffE=R2zaL6Ao3gZ_XvKPvG0YX5bmo18o3cJ_SLBEjZ0Mv_g@mail.gmail.com> <20200428123151.GS26002@ziepe.ca>
In-Reply-To: <20200428123151.GS26002@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 28 Apr 2020 14:41:28 +0200
Message-ID: <CAMGffEkEQ37bbG5BFixnESor8kjyLkEu4jC99a5g=xiCkyXECw@mail.gmail.com>
Subject: Re: [PATCH v12 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        linux-block@vger.kernel.org,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-rdma@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 28, 2020 at 2:31 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Sat, Apr 25, 2020 at 10:31:55AM +0200, Jinpu Wang wrote:
>
> > >  create mode 100644 Documentation/ABI/testing/sysfs-block-rnbd
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-rnbd-client
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-rnbd-server
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-rtrs-client
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-rtrs-server
> > >  create mode 100644 drivers/block/rnbd/Kconfig
> > >  create mode 100644 drivers/block/rnbd/Makefile
> > >  create mode 100644 drivers/block/rnbd/README
> > >  create mode 100644 drivers/block/rnbd/rnbd-clt-sysfs.c
> > >  create mode 100644 drivers/block/rnbd/rnbd-clt.c
> > >  create mode 100644 drivers/block/rnbd/rnbd-clt.h
> > >  create mode 100644 drivers/block/rnbd/rnbd-common.c
> > >  create mode 100644 drivers/block/rnbd/rnbd-log.h
> > >  create mode 100644 drivers/block/rnbd/rnbd-proto.h
> > >  create mode 100644 drivers/block/rnbd/rnbd-srv-dev.c
> > >  create mode 100644 drivers/block/rnbd/rnbd-srv-dev.h
> > >  create mode 100644 drivers/block/rnbd/rnbd-srv-sysfs.c
> > >  create mode 100644 drivers/block/rnbd/rnbd-srv.c
> > >  create mode 100644 drivers/block/rnbd/rnbd-srv.h
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/Kconfig
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/Makefile
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/README
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt.h
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-log.h
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-pri.h
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv.h
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs.c
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs.h
> > >
> > >
> > Hi Jason, hi Leon, hi Doug, hi all,
> >
> > We now have Reviewed-by for RNBD part from Bart (Thanks again), Do you
> > have new comments regarding RTRS, should we send another round to do a
> > rebase to latest rc?
>
> We'd need an ack from Jens before the block stuff could go through the
> RDMA tree
>
> Jason
Hi Jason
Thanks for reply.

Hi Jens,

Could you give your ack so Jason could take RNBD/RTRS through RDMA
tree, Jason mentioned in the past, we should get it ready at around
rc4ish,  so we still can get about 2 weeks of little bug fixes from
all the cross-arch compilation if any.

Thanks!
