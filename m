Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58C3163879
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 17:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfGIPSu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 11:18:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55077 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfGIPSu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jul 2019 11:18:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so3499233wme.4
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jul 2019 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bn9gSFayf8w5FKgfP36Gj02tgxyFSUDJTdBJDm+i8tg=;
        b=Fl/l3lgzHGZQGnvX1km+i2//vjtFMm7tboRZdXyZqlVZ/zohNudbzf+o9xjMZaK2Az
         V5N57leY/WuGB0G8cwGSikoy8w7pElx5oWoPiujnUpRfgjYqbV7QbbpDfMhJuEQoXfap
         h9RBFGN2VBahIrRzjB/RkR7C7LfUzYH6kdEqjuzARPuP8jfbmejdRL7KnOLOvNHbpFdL
         PZJvUryEjRfoKUWSPleETEEp020r06u4dx2Y4x4o5Xm01dkz0pUjxM20aMXyWF94QPfH
         Vbr9FS9JlnxsDniXe1EGYC3+OR4tnbLkxzYVrPEgTBzKNtELkWBN91LF1+doIGDcsXck
         ZrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bn9gSFayf8w5FKgfP36Gj02tgxyFSUDJTdBJDm+i8tg=;
        b=dp+rDQ7DEfXqvMniokIh91jgZqBeMxZV+Y1x7VypaUPAKPTC0oNURrNgax/sgCZoHS
         UvfMM3Ko0tcatdVE1pGNrSoVvfbGMl+9r+aKoPXQaMk+SGtgw68DqvUnDLXI2wIW9OFm
         bqrZUyZZaJvKoAdV6u0xUFiKFXFqbMFRn/F1mgC/hnBn/DXrusJRWctz51LfL2UP0bKH
         kWTOXkf3sax5vql1n1rAHdly09/EkS40ohLA8zn4su27zQm58ItIFKW/Iw55YCRNVt63
         NjCdf7Kax/Wp3JdZEIzGPwHzn6UJqczm7LVCsVD4Vzt0ZzZcFeRNGQTaugO4EHK7gGoq
         NYLg==
X-Gm-Message-State: APjAAAVHRKPyPm9pdUJsdZueX54e7HkKl+KYQ70NHGgNoFo9CyleyHiA
        22FS1+ifdYYtJXFZQZ12q53CfFl6c7BI9TSieLpODA==
X-Google-Smtp-Source: APXvYqzOY5ekXZ9APSUAGKE2zg52znpHx+Ch76+TC6s7UsjOKEVXrpCO7fk3ZzX1r9kovxQTrw1SEEHJYdX2omwITxY=
X-Received: by 2002:a1c:c005:: with SMTP id q5mr426342wmf.59.1562685528057;
 Tue, 09 Jul 2019 08:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-26-jinpuwang@gmail.com>
 <20190709151013.GW7034@mtr-leonro.mtl.com>
In-Reply-To: <20190709151013.GW7034@mtr-leonro.mtl.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 9 Jul 2019 17:18:37 +0200
Message-ID: <CAMGffEmeH7-oEENYLQ3tEnkKbO4pcb7omPeavNscVJteEnupyw@mail.gmail.com>
Subject: Re: [PATCH v4 25/25] MAINTAINERS: Add maintainer for IBNBD/IBTRS modules
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 9, 2019 at 5:10 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Jun 20, 2019 at 05:03:37PM +0200, Jack Wang wrote:
> > From: Roman Pen <roman.penyaev@profitbricks.com>
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >  MAINTAINERS | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a6954776a37e..0b7fd93f738d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7590,6 +7590,20 @@ IBM ServeRAID RAID DRIVER
> >  S:   Orphan
> >  F:   drivers/scsi/ips.*
> >
> > +IBNBD BLOCK DRIVERS
> > +M:   IBNBD/IBTRS Storage Team <ibnbd@cloud.ionos.com>
> > +L:   linux-block@vger.kernel.org
> > +S:   Maintained
> > +T:   git git://github.com/profitbricks/ibnbd.git
> > +F:   drivers/block/ibnbd/
> > +
> > +IBTRS TRANSPORT DRIVERS
> > +M:   IBNBD/IBTRS Storage Team <ibnbd@cloud.ionos.com>
>
> I don't know if it rule or not, but can you please add real
> person/persons to Maintainers list? Many times, those global
> support lists are simply ignored.

Sure, we can use my and Danil 's name in next round.

>
> > +L:   linux-rdma@vger.kernel.org
> > +S:   Maintained
> > +T:   git git://github.com/profitbricks/ibnbd.git
>
> How did you imagine patch flow for ULP, while your tree is
> external to RDMA tree?

Plan was we gather the patch in the git tree, and
send patches to the list via git send email, do we accept pull request
from github?
What the preferred way?

Thanks Leon.
Jack
>
> > +F:   drivers/infiniband/ulp/ibtrs/
> > +
> >  ICH LPC AND GPIO DRIVER
> >  M:   Peter Tyser <ptyser@xes-inc.com>
> >  S:   Maintained
> > --
> > 2.17.1
> >
