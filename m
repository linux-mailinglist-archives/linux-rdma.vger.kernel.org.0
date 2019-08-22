Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3A6799617
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 16:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbfHVOPT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 10:15:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfHVOPT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Aug 2019 10:15:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 075143082A6C;
        Thu, 22 Aug 2019 14:15:18 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B08BE60925;
        Thu, 22 Aug 2019 14:15:13 +0000 (UTC)
Message-ID: <fbc950ac651d49e7f88dc483570b1ea3e56b980f.camel@redhat.com>
Subject: Re: [PATCH v1 00/24] Shared PD and MR
From:   Doug Ledford <dledford@redhat.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     jgg@ziepe.ca, leon@kernel.org, monis@mellanox.com,
        parav@mellanox.com, danielj@mellanox.com, kamalheib1@gmail.com,
        markz@mellanox.com, johannes.berg@intel.com, willy@infradead.org,
        michaelgur@mellanox.com, markb@mellanox.com,
        dan.carpenter@oracle.com, bvanassche@acm.org, maxg@mellanox.com,
        israelr@mellanox.com, galpress@amazon.com, denisd@mellanox.com,
        yuvalav@mellanox.com, dennis.dalessandro@intel.com,
        will@kernel.org, ereza@mellanox.com, jgg@mellanox.com,
        linux-rdma@vger.kernel.org,
        Shamir Rabinovitch <srabinov7@gmail.com>
Date:   Thu, 22 Aug 2019 10:15:11 -0400
In-Reply-To: <20190822084102.GA2898@lap1>
References: <20190821142125.5706-1-yuval.shaia@oracle.com>
         <20190821233736.GG5965@iweiny-DESK2.sc.intel.com>
         <20190822084102.GA2898@lap1>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-7PzAS4z6Vp9b3tMhCizS"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 22 Aug 2019 14:15:18 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-7PzAS4z6Vp9b3tMhCizS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-22 at 11:41 +0300, Yuval Shaia wrote:
> On Wed, Aug 21, 2019 at 04:37:37PM -0700, Ira Weiny wrote:
> > On Wed, Aug 21, 2019 at 05:21:01PM +0300, Yuval Shaia wrote:
> > > Following patch-set introduce the shared object feature.
> > >=20
> > > A shared object feature allows one process to create HW objects
> > > (currently
> > > PD and MR) so that a second process can import.
>=20
> Hi Ira,
>=20
> > For something this fundamental I think the cover letter should be
> > more
> > detailed than this.  Questions I have without digging into the code:
> >=20
> > What is the use case?
>=20
> I have only one use case but i didn't added it to commit log just not
> to
> limit the usage of this feature but you are right, cover letter is
> great
> for such things, will add it for v2.
>=20
> Anyway, here is our use case: Consider a case of server with huge
> amount
> of memory and some hundreds or even thousands processes are using it
> to
> serves clients requests. In this case the HCA will have to manage
> hundreds
> or thousands MRs. A better design maybe would be that one process will
> create one (or several) MR(s) which will be shared with the other
> processes. This will reduce the number of address translation entries
> and
> cache miss dramatically.

Unless I'm misreading you here, it will be at the expense of pretty much
all inter-process memory security.  You're talking about one process
creating some large MRs just to cover the overall memory in the machine,
then sharing that among processes, and all using it to reduce the MR
workload of the card.  This sounds like going back to the days of MSDos.
It also sounds like a programming error in one process could expose
potentially all processes data buffers across all processes sharing this
PD and MR.

I get the idea, and the problem you are trying to solve, but I'm not
sure that going down this path is wise.

Maybe....maybe if you limit a queue pair to send/recv only and no
rdma_{read,write}, then this wouldn't be quite as bad.  But even then
I'm still very leary of this "feature".

>=20
> > What is the "key" that allows a MR to be shared among 2
> > processes?  Do you
> > introduce some PD identifier?  And then some {PDID, lkey} tuple is
> > used to ID
> > the MR?
> >=20
> > I assume you have to share the PD first and then any MR in the
> > shared PD can be
> > shared?  If so how does the MR get shared?
>=20
> Sorry, i'm not following.
> I think the term 'share' is somehow mistake, it is actually a process
> 'imports' objects into it's context. And yes, the workflow is first to
> import the PD and then import the MR.
>=20
> > Again I'm concerned with how this will interact with the RDMA and
> > file system
> > interaction we have been trying to fix.
>=20
> I'm not aware of this file-system thing, can you point me to some
> discussion on that so i'll see how this patch-set affect it.
>=20
> > Why is SCM_RIGHTS on the rdma context FD not sufficient to share the
> > entire
> > context, PD, and all MR's?
>=20
> Well, this SCM_RIGHTS is great, one can share the IB context with
> another.
> But it is not enough, because:
> - What API the second process can use to get his hands on one of the
> PDs or
>   MRs from this context?
> - What mechanism takes care of the destruction of such objects
> (SCM_RIGHTS
>   takes care for the ref counting of the context but i'm referring to
> the
>   PDs and MRs objects)?
>=20
> The entire purpose of this patch set is to address these two
> questions.
>=20
> Yuval
>=20
> > Ira
> >=20
> > > Patch-set is logically splits to 4 parts as the following:
> > > - patches 1 to 7 and 18 are preparation steps.
> > > - patches 8 to 14 are the implementation of import PD
> > > - patches 15 to 17 are the implementation of the verb
> > > - patches 19 to 24 are the implementation of import MR
> > >=20
> > > v0 -> v1:
> > > 	* Delete the patch "IB/uverbs: ufile must be freed only when not
> > > 	  used anymore". The process can die, the ucontext remains until
> > > 	  last reference to it is closed.
> > > 	* Rebase to latest for-next branch
> > >=20
> > > Shamir Rabinovitch (16):
> > >   RDMA/uverbs: uobj_get_obj_read should return the ib_uobject
> > >   RDMA/uverbs: Delete the macro uobj_put_obj_read
> > >   RDMA/nldev: ib_pd can be pointed by multiple ib_ucontext
> > >   IB/{core,hw}: ib_pd should not have ib_uobject pointer
> > >   IB/core: ib_uobject need HW object reference count
> > >   IB/uverbs: Helper function to initialize ufile member of
> > >     uverbs_attr_bundle
> > >   IB/uverbs: Add context import lock/unlock helper
> > >   IB/verbs: Prototype of HW object clone callback
> > >   IB/mlx4: Add implementation of clone_pd callback
> > >   IB/mlx5: Add implementation of clone_pd callback
> > >   RDMA/rxe: Add implementation of clone_pd callback
> > >   IB/uverbs: Add clone reference counting to ib_pd
> > >   IB/uverbs: Add PD import verb
> > >   IB/mlx4: Enable import from FD verb
> > >   IB/mlx5: Enable import from FD verb
> > >   RDMA/rxe: Enable import from FD verb
> > >=20
> > > Yuval Shaia (8):
> > >   IB/core: Install clone ib_pd in device ops
> > >   IB/core: ib_mr should not have ib_uobject pointer
> > >   IB/core: Install clone ib_mr in device ops
> > >   IB/mlx4: Add implementation of clone_pd callback
> > >   IB/mlx5: Add implementation of clone_pd callback
> > >   RDMA/rxe: Add implementation of clone_pd callback
> > >   IB/uverbs: Add clone reference counting to ib_mr
> > >   IB/uverbs: Add MR import verb
> > >=20
> > >  drivers/infiniband/core/device.c              |   2 +
> > >  drivers/infiniband/core/nldev.c               | 127 ++++-
> > >  drivers/infiniband/core/rdma_core.c           |  23 +-
> > >  drivers/infiniband/core/uverbs.h              |   2 +
> > >  drivers/infiniband/core/uverbs_cmd.c          | 489
> > > +++++++++++++++---
> > >  drivers/infiniband/core/uverbs_main.c         |   1 +
> > >  drivers/infiniband/core/uverbs_std_types_mr.c |   1 -
> > >  drivers/infiniband/core/verbs.c               |   4 -
> > >  drivers/infiniband/hw/hns/hns_roce_hw_v1.c    |   1 -
> > >  drivers/infiniband/hw/mlx4/main.c             |  18 +-
> > >  drivers/infiniband/hw/mlx5/main.c             |  34 +-
> > >  drivers/infiniband/hw/mthca/mthca_qp.c        |   3 +-
> > >  drivers/infiniband/sw/rxe/rxe_verbs.c         |   5 +
> > >  include/rdma/ib_verbs.h                       |  43 +-
> > >  include/rdma/uverbs_std_types.h               |  11 +-
> > >  include/uapi/rdma/ib_user_verbs.h             |  15 +
> > >  include/uapi/rdma/rdma_netlink.h              |   3 +
> > >  17 files changed, 669 insertions(+), 113 deletions(-)
> > >=20
> > > --=20
> > > 2.20.1
> > >=20

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-7PzAS4z6Vp9b3tMhCizS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1eo28ACgkQuCajMw5X
L910jA/+O77x+tkd/b4LBhbBsORAcPf5hUeb7XbIHPL7xiXDtLHNkDKQJdX7cvzM
HGpgQ3Wjg94VJFVTUpKhPXlTMGmWZe8wq2mI37B5mQlADyTmYxlJgWoMCg3iRHub
ChksvkSkqncyK+0QR3fydAA/shiZGrP8+SJ1P6tnbtX/qKUpKUeh3KPf9z3YchoX
MV2ZtOqSF/9rDFDMN4FYD+fnMK4h9HZES3R7t4txqVmUYYN3FXoAbnYofXirysGU
ISKM8AaXgs/yBAqDwYJdEbp/HxoR9ihUdtT1Bam7QiWfls3W4slsB4hfyRqzakH+
xIXcxHQ5p+4hQLlVWoHUG513AGN0nt2fdIJu+xPeoIIOuiSezOsC5MILPM8FY90H
DljRiBwMeCBOoH9lbOw5KcxQK0ZBkJ62Ef4utEtLoKGJNFiJFRs+JKHwmVUMUG0X
EJ7eaKzqQz3WFK0f+8/7HyYlnv6GC+78tyeK2JHJzeBMk78kvR3U/X2nyDtPFBit
xefQTy33D5PSLP2qdz+ViMi1Mt+bydFH6h9BA+asmcOhwrby4qhRfphOPuZiEjTv
QOp+WpWIyDHuteR/TV6bAxQuCA+5StGYsHJQdkrQLHZ7scG+tBrlQKmj77yRno1l
b27Q9FMBwW8CISMwP9suzKNYyRXCkvXlA5hM3gulVMAZlCvllS8=
=6sm8
-----END PGP SIGNATURE-----

--=-7PzAS4z6Vp9b3tMhCizS--

