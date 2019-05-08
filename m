Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBA317B81
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 16:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfEHOZq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 10:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbfEHOZq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 May 2019 10:25:46 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ADA421530;
        Wed,  8 May 2019 14:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557325544;
        bh=MW+CK2D3jtd6pw0KyjaGVz+BDEKw3XVFPSiYAI2EPJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GlK+q/6Bf+PKhNkMLC2Q0r26lB1d7uOSNiYCRm0vBIBf/NU7egEH80WJF79QGOuVL
         LNvroDnJWeWwL4CHYjuQJMZTuy98zgm97uN8marQN3XCyDcrEMe1IGzraMTJaCknD9
         vbo1axFjK5SZ8DRcNFe2e6P4npXG+xBTiYd+R9eQ=
Date:   Wed, 8 May 2019 17:25:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Bernard Metzler <BMT@zurich.ibm.com>
Subject: Re: iWARP and soft-iWARP interop testing
Message-ID: <20190508142530.GE6938@mtr-leonro.mtl.com>
References: <49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
 <20190507161304.GH6201@ziepe.ca>
 <20190508062600.GV6938@mtr-leonro.mtl.com>
 <20190508133028.GB32282@ziepe.ca>
 <20190508140644.GB6938@mtr-leonro.mtl.com>
 <20190508141841.GD32282@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508141841.GD32282@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 08, 2019 at 11:18:41AM -0300, Jason Gunthorpe wrote:
> On Wed, May 08, 2019 at 05:06:44PM +0300, Leon Romanovsky wrote:
> > On Wed, May 08, 2019 at 10:30:28AM -0300, Jason Gunthorpe wrote:
> > > On Wed, May 08, 2019 at 09:26:00AM +0300, Leon Romanovsky wrote:
> > > > On Tue, May 07, 2019 at 01:13:04PM -0300, Jason Gunthorpe wrote:
> > > > > On Mon, May 06, 2019 at 04:38:27PM -0400, Doug Ledford wrote:
> > > > > > So, Jason and I were discussing the soft-iWARP driver submission, and he
> > > > > > thought it would be good to know if it even works with the various iWARP
> > > > > > hardware devices.  I happen to have most of them on hand in one form or
> > > > > > another, so I set down to test it.  In the process, I ran across some
> > > > > > issues just with the hardware versions themselves, let alone with soft-
> > > > > > iWARP.  So, here's the results of my matrix of tests.  These aren't
> > > > > > performance tests, just basic "does it work" smoke tests...
> > > > >
> > > > > Well, lets imagine to merge this at 5.2-rc1?
> > > >
> > > > Can we do something with kref in QPs and MRs before merging it?
> > > >
> > > > I'm super worried that memory model and locking used in this driver
> > > > won't allow me to continue with allocation patches?
> > >
> > > Well, this use of idr doesn't look right to me:
> > >
> > > static inline struct siw_qp *siw_qp_id2obj(struct siw_device *sdev, int id)
> > > {
> > > 	struct siw_qp *qp = idr_find(&sdev->qp_idr, id);
> > >
> > > 	if (likely(qp && kref_get_unless_zero(&qp->ref)))
> > > 		return qp;
> > >
> > > kref_get_unless_zero is nonsense unless used with someting like rcu,
> > > and there is no rcu read lock here.
> > >
> > > Also, IDR's have to be locked..
> > >
> > > It probably wants to be written as
> > >
> > > xa_lock()
> > > qp = xa_load()
> > > if (qp)
> > >    kref_get(&qp->ref);
> > > xa_unlock()
> > >
> > > But I'm not completely sure what this is all about.. A QP cannot
> > > really exist past destroy - about the only thing that would make sense
> > > is to leave some memory around so other things can see it is failed -
> > > but generally it is better to wipe out the QP from those other things
> > > then attempt to do reference counting like this.
> >
> > No, no,, no, it is still not enough. I need to be sure that destroy path
> > always successes and kref_get(&qp->ref) doesn't guarantee that.
> >
> > The good coding pattern can be seen in rdmavt
> > https://elixir.bootlin.com/linux/latest/source/drivers/infiniband/sw/rdmavt/cq.c#L316
> > They krefing and releasing extra structure outside of user visible object.
>
> In some respects I would rather the core code put a proper memory kref
> in every object. We wanted this anyhow for the netlink restrack
> stuff, and used properly it is pretty useful.

We can do it and for sure will do it, but in meanwhile I would prefer do not
see additions of krefs in drivers.

Thanks
>
> Jason
