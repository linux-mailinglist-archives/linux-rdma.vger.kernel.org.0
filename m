Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F76317DFD
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 18:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfEHQTT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 May 2019 12:19:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfEHQTT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 May 2019 12:19:19 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41C1E20644;
        Wed,  8 May 2019 16:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557332357;
        bh=x+NiTu1PnvDqqxI3u2/N8IBeebiSaOfNMJ5EYaZVm8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fGhoACzi4mY6BSSj/UCSLXUtZwY+OvH8RUL173GEsLXw2yKw8YlXOlfBFp+GFTLlK
         IOCI0IXrd5LkK2G4trdFeafviMlEgpVugiE3Ukf0ECaXNrdIddaLKRoU7yFKvnEadi
         djtzjm5B/idargRkAm3ajXfayquuZrKbJGuWxEgo=
Date:   Wed, 8 May 2019 19:19:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: iWARP and soft-iWARP interop testing
Message-ID: <20190508161903.GH6938@mtr-leonro.mtl.com>
References: <20190508142530.GE6938@mtr-leonro.mtl.com>
 <49b807221e5af3fab8813a9ce769694cb536072a.camel@redhat.com>
 <20190507161304.GH6201@ziepe.ca>
 <20190508062600.GV6938@mtr-leonro.mtl.com>
 <20190508133028.GB32282@ziepe.ca>
 <20190508140644.GB6938@mtr-leonro.mtl.com>
 <20190508141841.GD32282@ziepe.ca>
 <OF5AD65D44.561F332B-ON002583F4.0050EC64-002583F4.0053DCBB@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF5AD65D44.561F332B-ON002583F4.0050EC64-002583F4.0053DCBB@notes.na.collabserv.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 08, 2019 at 03:15:59PM +0000, Bernard Metzler wrote:
> -----"Leon Romanovsky" <leon@kernel.org> wrote: -----
>
> >To: "Jason Gunthorpe" <jgg@ziepe.ca>
> >From: "Leon Romanovsky" <leon@kernel.org>
> >Date: 05/08/2019 04:25PM
> >Cc: "Doug Ledford" <dledford@redhat.com>, "linux-rdma"
> ><linux-rdma@vger.kernel.org>, "Bernard Metzler" <BMT@zurich.ibm.com>
> >Subject: Re: iWARP and soft-iWARP interop testing
> >
> >On Wed, May 08, 2019 at 11:18:41AM -0300, Jason Gunthorpe wrote:
> >> On Wed, May 08, 2019 at 05:06:44PM +0300, Leon Romanovsky wrote:
> >> > On Wed, May 08, 2019 at 10:30:28AM -0300, Jason Gunthorpe wrote:
> >> > > On Wed, May 08, 2019 at 09:26:00AM +0300, Leon Romanovsky
> >wrote:
> >> > > > On Tue, May 07, 2019 at 01:13:04PM -0300, Jason Gunthorpe
> >wrote:
> >> > > > > On Mon, May 06, 2019 at 04:38:27PM -0400, Doug Ledford
> >wrote:
> >> > > > > > So, Jason and I were discussing the soft-iWARP driver
> >submission, and he
> >> > > > > > thought it would be good to know if it even works with
> >the various iWARP
> >> > > > > > hardware devices.  I happen to have most of them on hand
> >in one form or
> >> > > > > > another, so I set down to test it.  In the process, I ran
> >across some
> >> > > > > > issues just with the hardware versions themselves, let
> >alone with soft-
> >> > > > > > iWARP.  So, here's the results of my matrix of tests.
> >These aren't
> >> > > > > > performance tests, just basic "does it work" smoke
> >tests...
> >> > > > >
> >> > > > > Well, lets imagine to merge this at 5.2-rc1?
> >> > > >
> >> > > > Can we do something with kref in QPs and MRs before merging
> >it?
> >> > > >
> >> > > > I'm super worried that memory model and locking used in this
> >driver
> >> > > > won't allow me to continue with allocation patches?
> >> > >
> >> > > Well, this use of idr doesn't look right to me:
> >> > >
> >> > > static inline struct siw_qp *siw_qp_id2obj(struct siw_device
> >*sdev, int id)
> >> > > {
> >> > > 	struct siw_qp *qp = idr_find(&sdev->qp_idr, id);
> >> > >
> >> > > 	if (likely(qp && kref_get_unless_zero(&qp->ref)))
> >> > > 		return qp;
> >> > >
> >> > > kref_get_unless_zero is nonsense unless used with someting like
> >rcu,
> >> > > and there is no rcu read lock here.
> >> > >
> >> > > Also, IDR's have to be locked..
> >> > >
> >> > > It probably wants to be written as
> >> > >
> >> > > xa_lock()
> >> > > qp = xa_load()
> >> > > if (qp)
> >> > >    kref_get(&qp->ref);
> >> > > xa_unlock()
> >> > >
> >> > > But I'm not completely sure what this is all about.. A QP
> >cannot
> >> > > really exist past destroy - about the only thing that would
> >make sense
> >> > > is to leave some memory around so other things can see it is
> >failed -
> >> > > but generally it is better to wipe out the QP from those other
> >things
> >> > > then attempt to do reference counting like this.
> >> >
> >> > No, no,, no, it is still not enough. I need to be sure that
> >destroy path
> >> > always successes and kref_get(&qp->ref) doesn't guarantee that.
> >> >
> >> > The good coding pattern can be seen in rdmavt
> >> >
> >https://urldefense.proofpoint.com/v2/url?u=https-3A__elixir.bootlin.c
> >om_linux_latest_source_drivers_infiniband_sw_rdmavt_cq.c-23L316&d=DwI
> >BAg&c=jf_iaSHvJObTbx-siA1ZOg&r=2TaYXQ0T-r8ZO1PP1alNwU_QJcRRLfmYTAgd3Q
> >CvqSc&m=W8K4_QR3oPmfyY52_46Q1ICeIMJr5MSNJIsPe9AgVBM&s=sWDpPSRP82Q7pD_
> >Q0fUJl44yuL42iMKHv0AKta4KGUo&e=
> >> > They krefing and releasing extra structure outside of user
> >visible object.
> >>
> >> In some respects I would rather the core code put a proper memory
> >kref
> >> in every object. We wanted this anyhow for the netlink restrack
> >> stuff, and used properly it is pretty useful.
> >
> >We can do it and for sure will do it, but in meanwhile I would prefer
> >do not
> >see additions of krefs in drivers.
> >
>
> Without questioning the concept here, moving allocation and freeing
> of core resources to the mid layer may induce complex changes at
> driver level. Especially for a SW driver, which references those
> objects on the fast path. Following the approach rdmavt takes,
> that results in a split of objects between driver and mid layer.
> So we abandon the idea of folding driver state and mid layer
> state into one object.
> I can think of such a thing for memory objects. What is the time
> line for those changes to the mid layer? Will it be part of 5.2?

I'm doing CQ now and it can be faster if I wouldn't need to fix driver
code in that area.

>
> I guarantee I'll do those changes when really needed, but I'd
> leave a rather stable current state. I am not saying I am reluctant
> to do so.

They are needed now, please ensure that all _destroy_ flows success
and don't return before they kfreed referenced object.

I don't want to see code like we have in nes:
destroy_cq()
{
   if (...)
      // memory leak
      return;

   kfree(cq);
}

Thanks

>
>
> Thanks,
> Bernard.
>
