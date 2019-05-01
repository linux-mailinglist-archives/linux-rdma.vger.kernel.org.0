Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 018DA10B71
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 18:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfEAQi2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 12:38:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfEAQi2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 May 2019 12:38:28 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CDAA3C02492F;
        Wed,  1 May 2019 16:38:27 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-9.rdu2.redhat.com [10.10.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 86FE31001DF6;
        Wed,  1 May 2019 16:38:26 +0000 (UTC)
Message-ID: <78c018f572dd8f08d80734f85b347122d1c1e11c.camel@redhat.com>
Subject: Re: [PATCH for-rc 1/5] IB/hfi1: Fix WQ_MEM_RECLAIM warning
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>, Tejun Heo <tj@kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
Date:   Wed, 01 May 2019 12:38:24 -0400
In-Reply-To: <20190501162931.GA15621@ziepe.ca>
References: <20190318165205.23550.97894.stgit@scvm10.sc.intel.com>
         <20190318165501.23550.24989.stgit@scvm10.sc.intel.com>
         <20190319192737.GB3773@ziepe.ca>
         <32E1700B9017364D9B60AED9960492BC70CD9227@fmsmsx120.amr.corp.intel.com>
         <20190327152517.GD69236@devbig004.ftw2.facebook.com>
         <20190327170213.GD22899@mtr-leonro.mtl.com>
         <4A4820DA-474E-437F-B3D3-56EAA31ED58D@redhat.com>
         <20190501162931.GA15621@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-g9hLuuniLBIU3o/xyid6"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 01 May 2019 16:38:27 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-g9hLuuniLBIU3o/xyid6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-05-01 at 13:29 -0300, Jason Gunthorpe wrote:
> On Wed, May 01, 2019 at 11:21:08AM -0400, Doug Ledford wrote:
> > On Mar 27, 2019, at 1:02 PM, Leon Romanovsky <leon@kernel.org> wrote:
> > > On Wed, Mar 27, 2019 at 08:25:17AM -0700, Tejun Heo (tj@kernel.org) w=
rote:
> > > > Hello,
> > > >=20
> > > > On Tue, Mar 26, 2019 at 08:55:09PM +0000, Marciniszyn, Mike wrote:
> > > > > The latter is the ipoib wq that conflicts with our non-WQ_MEM_REC=
LAIM.  This seems excessive and pretty gratuitous.
> > > > >=20
> > > > > Tejun, what does "mem reclaim" really mean and when should it be =
used?
> > > >=20
> > > > That it may be depended during memory reclaim.
> > > >=20
> > > > > I was assuming that since we are freeing QP kernel memory held by=
 user mode programs that could be oom killed, we need the flag.
> > > >=20
> > > > If it can't block memory reclaim, it doesn't need the flag.  Just i=
n
> > > > case, if a workqueue is used to issue block IOs, it is depended upo=
n
> > > > for memory reclaim as writeback and swap-outs are critical parts of
> > > > memory reclaim.
> > >=20
> > > It looks like WQ_MEM_RECLAIM is needed for IPoIB, because if NFS runs
> > > over IPoIB, it will do those types of IOs.
> >=20
> > Because of what IPoIB does, you=E2=80=99re right that it=E2=80=99s need=
ed.  However,
> > it might be necessary to audit the wq usage in IPoIB to make sure
> > it=E2=80=99s actually eligible for the flag and that it hasn=E2=80=99t =
been set when
> > the code doesn=E2=80=99t meet the requirements of the flag.
>=20
> It isn't right - it is doing memory allocations from the work queue
> without the GFP_NOIO (or memalloc_noio_save)
>=20
> And I'm not sure it can actually tolerate failure of a memory
> allocation anyhow without blocking the dataplane.
>=20
> In other words, the entire thing hasn't been designed with the idea
> that it could be on the IO path..
>=20
> I'm not sure how things work if NFS is on the critical reclaim path in
> general - does it even work with a normal netdev? How does netdev
> allocate a neighbor for instance if it becomes required?
>=20
> Jason

What we probably need to do (but probably not this late in the rc cycle,
save it for next) is remove WQ_MEM_RECLAIM anywhere that an audit isn't
conclusive that it's safe.  As I understand it, the memory subsystem
will explore other areas of memory reclaim if these items don't have the
flag, which is better than the alternative of setting the flag on a work
queue that isn't safe and ending up in a deadlock or other abnormal
failure scenario.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-g9hLuuniLBIU3o/xyid6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlzJy4AACgkQuCajMw5X
L91TrxAAsdRxcLDMA97NAC1FyLWe13ezxIclyP5s1ljm0HwE/0eFXRzvt8WJvxAG
k8IYh8wfy9F3+1J4tsD8iNc9zuTUXvX+3O9MzW1Gu9MP/WMrmTfKZ7BkCQYTCpH1
cQcViSne88c2PZZkMW+tFmCJOTiK7NOP+EqoFqKDUxLxCa9pUQGh8KdK4eQQS8qD
LqGSxHieSQzyzGK4/zHQT6VSWls+gJbTFzZ1VXB/XJ/rqyzPCegMaGiuurIr1L9H
F5EKoRFrTDuuuAFYcmp/eXCB9HUM6YApBC8cUuBGUMdmIX/YgpJ6nwHb46yk6wgD
UlMLyWjX8PapXZ4DX5o95d0tyXC3y7QzmQSAKsQMjgwMiM+UbLB4QIh73APdQh3N
EbZ6LcbOfNjpEW1BOyqAvUIp6QrIg6E8d8g7wq9bSRFNgh3iXOEkLslI7txoyA3r
h87Z+upZFWCGkcRfdQjh6zBFgNWyTWbVoeOiI+xiNDuzO1LRHdcPfhaEvhJDYRhN
b2ciLIQ+wRxzip/bTMJg7T8l1J1VZJwLYAdPc2BG7gfYOygswT5qpzUyk4ulAl+V
jk5yRUqdN9uV/MfNlWxKluIVyZwfaRPDBk5EZIzJEyJO6tt3MZuLemqIwi4ovmQ5
d6bCG8iQpT4S8y20/PieGIrpL/06aj6IdzUdW0GhHhX2TbtEnzk=
=6Qqs
-----END PGP SIGNATURE-----

--=-g9hLuuniLBIU3o/xyid6--

