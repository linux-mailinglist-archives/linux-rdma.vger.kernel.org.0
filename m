Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0B59638E7
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 17:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfGIPv7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 11:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfGIPv6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 9 Jul 2019 11:51:58 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B06D721670;
        Tue,  9 Jul 2019 15:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562687517;
        bh=4GpBHZa2kVh9ioJ55uMeuM395cuzV+Q2J8LQxGrQRIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X+/Rb6rKAWxqhlu5+f2pECcXpxS9U8xzEvC6rLI9ZymvQN0bmfgQoGKykk6VxxE+c
         vgaSeZcdzvByvf6oGbbhC46IRPounX9PPDKrxlMg2+0+QMCOpsjl2TsUUGAuMVzt+z
         cxbPEHftb0/g2Bs0Y9eDdzbu++qA6Z/MzPCnVtH8=
Date:   Tue, 9 Jul 2019 18:51:53 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
Subject: Re: [PATCH v4 25/25] MAINTAINERS: Add maintainer for IBNBD/IBTRS
 modules
Message-ID: <20190709155153.GX7034@mtr-leonro.mtl.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-26-jinpuwang@gmail.com>
 <20190709151013.GW7034@mtr-leonro.mtl.com>
 <CAMGffEmeH7-oEENYLQ3tEnkKbO4pcb7omPeavNscVJteEnupyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEmeH7-oEENYLQ3tEnkKbO4pcb7omPeavNscVJteEnupyw@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 09, 2019 at 05:18:37PM +0200, Jinpu Wang wrote:
> On Tue, Jul 9, 2019 at 5:10 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Thu, Jun 20, 2019 at 05:03:37PM +0200, Jack Wang wrote:
> > > From: Roman Pen <roman.penyaev@profitbricks.com>
> > >
> > > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > ---
> > >  MAINTAINERS | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index a6954776a37e..0b7fd93f738d 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -7590,6 +7590,20 @@ IBM ServeRAID RAID DRIVER
> > >  S:   Orphan
> > >  F:   drivers/scsi/ips.*
> > >
> > > +IBNBD BLOCK DRIVERS
> > > +M:   IBNBD/IBTRS Storage Team <ibnbd@cloud.ionos.com>
> > > +L:   linux-block@vger.kernel.org
> > > +S:   Maintained
> > > +T:   git git://github.com/profitbricks/ibnbd.git
> > > +F:   drivers/block/ibnbd/
> > > +
> > > +IBTRS TRANSPORT DRIVERS
> > > +M:   IBNBD/IBTRS Storage Team <ibnbd@cloud.ionos.com>
> >
> > I don't know if it rule or not, but can you please add real
> > person/persons to Maintainers list? Many times, those global
> > support lists are simply ignored.
>
> Sure, we can use my and Danil 's name in next round.
>
> >
> > > +L:   linux-rdma@vger.kernel.org
> > > +S:   Maintained
> > > +T:   git git://github.com/profitbricks/ibnbd.git
> >
> > How did you imagine patch flow for ULP, while your tree is
> > external to RDMA tree?
>
> Plan was we gather the patch in the git tree, and
> send patches to the list via git send email, do we accept pull request
> from github?
> What the preferred way?

The preferred way is to start with sending patches directly
to the mailing and allow RDMA maintainers to collect and
apply them by themselves. It gives an easy way to other people
to do cross-subsystem changes and we are doing a lot of them.

Till you will be asked to send PRs the "T:" link should point to RDMA subsystem.

Thanks

>
> Thanks Leon.
> Jack
> >
> > > +F:   drivers/infiniband/ulp/ibtrs/
> > > +
> > >  ICH LPC AND GPIO DRIVER
> > >  M:   Peter Tyser <ptyser@xes-inc.com>
> > >  S:   Maintained
> > > --
> > > 2.17.1
> > >
