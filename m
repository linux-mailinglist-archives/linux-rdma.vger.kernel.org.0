Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAB17E05C
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 18:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733084AbfHAQkr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 12:40:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732035AbfHAQkr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 12:40:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B6C530DD187;
        Thu,  1 Aug 2019 16:40:46 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C08B110018F9;
        Thu,  1 Aug 2019 16:40:45 +0000 (UTC)
Message-ID: <b74a9eb67af54e8f5050e97a3ab13899de17fe0a.camel@redhat.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Date:   Thu, 01 Aug 2019 12:40:43 -0400
In-Reply-To: <20190801162008.GF23885@mellanox.com>
References: <20190731170944.GC4832@mtr-leonro.mtl.com>
         <20190731172215.GJ22677@mellanox.com>
         <20190731180124.GE4832@mtr-leonro.mtl.com>
         <20190731195523.GK22677@mellanox.com>
         <20190801082749.GH4832@mtr-leonro.mtl.com>
         <20190801120007.GB23885@mellanox.com>
         <20190801120821.GK4832@mtr-leonro.mtl.com>
         <060b3e8fbe48312e9af33b88ba7ba62a6b64b493.camel@redhat.com>
         <20190801155912.GS4832@mtr-leonro.mtl.com>
         <a0dc81b63fdef1b7e877d5172be13792dda763d2.camel@redhat.com>
         <20190801162008.GF23885@mellanox.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-7tZenE0eIV4P49da8Zix"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 01 Aug 2019 16:40:46 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-7tZenE0eIV4P49da8Zix
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-01 at 16:20 +0000, Jason Gunthorpe wrote:
> On Thu, Aug 01, 2019 at 12:11:20PM -0400, Doug Ledford wrote:
> > On Thu, 2019-08-01 at 18:59 +0300, Leon Romanovsky wrote:
> > > > There's no need for a lockdep.  The removal of the notifier
> > > > callback
> > > > entry is re-entrant safe.  The core removal routines have their
> > > > own
> > > > spinlock they use to protect the actual notifier list.  If you
> > > > call
> > > > it
> > > > more than once, the second and subsequent calls merely scan the
> > > > list,
> > > > find no matching entry, and return ENOENT.  The only reason this
> > > > might
> > > > need a lock and a lockdep entry is if you are protecting against
> > > > a
> > > > race
> > > > with the *add* notifier code in the mlx5 driver specifically
> > > > (the
> > > > core
> > > > add code won't have an issue, but since you only have a single
> > > > place
> > > > to
> > > > store the notifier callback pointer, if it would be possible for
> > > > you
> > > > to
> > > > add two callbacks and write over the first callback pointer with
> > > > the
> > > > second without removing the first, then you would leak a
> > > > callback
> > > > notifier in the core notifier list).
> > >=20
> > > atomic_notifier_chain_unregister() unconditionally calls to
> > > syncronize_rcu() and I'm not so sure that it is best thing to do
> > > for every port unbind.
> > >=20
> > > Actually, I'm completely lost here, we are all agree that the
> > > patch
> > > fixes issue correctly, and it returns the code to be exactly as
> > > it was before commit df097a278c75 ("IB/mlx5: Use the new mlx5 core
> > > notifier
> > > API"). Can we simply merge it and fix the kernel panic?
> >=20
> > As long as you are OK with me adding a comment to the patch so
> > people
> > coming back later won't scratch their head about how can it possible
> > be
> > right to do that sequence without a lock held, I'm fine merging the
> > fix.
> >=20
> > Something like:
> >=20
> > /*
> >  * The check/unregister/set-NULL sequence below does not need to be
> >  * locked for correctness as it's only an optimization, and can't
> >  * be under a lock or will throw a scheduling while atomic error.
> >  */
>=20
> It does have a lock though, the caller holds it, hence the request for
> the lockdep.

You're right, although I think the lockdep annotation can be a separate
patch as it's neeeded on more than just the function this patch touches.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-7tZenE0eIV4P49da8Zix
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1DFgsACgkQuCajMw5X
L90SGQ//djIYlFN4UNClcWw4YFr3X3l4om0VaZzpSdbUcy3WMQW0dVjPgfE4FtVd
0fA6PWzn/veic/FjGAUqP4yvR4HgIjBenH/9eVACBJPkc75NfyiOkSiCN4UaXIHc
L/mN0AE3gRN5sUEFgBSr0EiFORZJQ4QBFcQxTsxwy1j1aDaLXFOxSQUDpJelj7u1
3/nhJDQLOMwgSMryf3AoISIm8zvfyw2oPWk+MOHPjJ01RFWgmvLd02/hO7gpUvdS
4Up02YaP/6FmtmjwXOehwLQde6dcfvjaRP2Lkpt6j8AjSpwZdYSGMPADsBeoQjqo
yCIRkyvW0Rh7kSabQ+2AjU84w/Xc3EmT/3b55ZDSVNmHdAELEhay8oLE1frNaBgZ
gVodd1aZZCNxPvcWpfOCLafbkXJ3P7dw3lLZjHdqnm/2V6OKecSA+wZe+zLvNr+s
RCkDCkCOSuzjEBjgfehUb3ifd5utn24GwMql1/cz+rpL3MHvZyzNNcO3XOIgyfM1
jAkvE7b8u5pOsqFIcvkUBYeXJZaDpslRJyo2E6ZXbuPUdmmmiedEEx3nXSbatfuL
IpRXpQqLm+I0kqx2CR1HUXlbzTZd0d7oXh8sBfNRhFgAHBS4r5J7jSi3fEHO8Djb
vJxofYcp5GwmslLUiSEhVkCIjCn0TuHu5Ol6DdPVEfYQ/2fQPVs=
=TyPV
-----END PGP SIGNATURE-----

--=-7tZenE0eIV4P49da8Zix--

