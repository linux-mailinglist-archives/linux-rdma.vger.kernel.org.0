Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA4F77E3C3
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 22:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388761AbfHAUJb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 16:09:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbfHAUJb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 16:09:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C9564A4528;
        Thu,  1 Aug 2019 20:09:30 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE9DC60BE0;
        Thu,  1 Aug 2019 20:09:29 +0000 (UTC)
Message-ID: <7b87cbbdfc4455fd7b265449f2f3f2d4a38e7441.camel@redhat.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Date:   Thu, 01 Aug 2019 16:09:27 -0400
In-Reply-To: <20190801173320.GZ4832@mtr-leonro.mtl.com>
References: <20190731180124.GE4832@mtr-leonro.mtl.com>
         <20190731195523.GK22677@mellanox.com>
         <20190801082749.GH4832@mtr-leonro.mtl.com>
         <20190801120007.GB23885@mellanox.com>
         <20190801120821.GK4832@mtr-leonro.mtl.com>
         <060b3e8fbe48312e9af33b88ba7ba62a6b64b493.camel@redhat.com>
         <20190801155912.GS4832@mtr-leonro.mtl.com>
         <a0dc81b63fdef1b7e877d5172be13792dda763d2.camel@redhat.com>
         <20190801162356.GV4832@mtr-leonro.mtl.com>
         <5ffad7827bc72b43948fa7c4707348999434009a.camel@redhat.com>
         <20190801173320.GZ4832@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-EsXJONIJR4sHGlXKCh3q"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 01 Aug 2019 20:09:30 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-EsXJONIJR4sHGlXKCh3q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-01 at 20:33 +0300, Leon Romanovsky wrote:
> On Thu, Aug 01, 2019 at 12:42:43PM -0400, Doug Ledford wrote:
> > On Thu, 2019-08-01 at 19:23 +0300, Leon Romanovsky wrote:
> > > On Thu, Aug 01, 2019 at 12:11:20PM -0400, Doug Ledford wrote:
> > > > On Thu, 2019-08-01 at 18:59 +0300, Leon Romanovsky wrote:
> > > > > > There's no need for a lockdep.  The removal of the notifier
> > > > > > callback
> > > > > > entry is re-entrant safe.  The core removal routines have
> > > > > > their
> > > > > > own
> > > > > > spinlock they use to protect the actual notifier list.  If
> > > > > > you
> > > > > > call
> > > > > > it
> > > > > > more than once, the second and subsequent calls merely scan
> > > > > > the
> > > > > > list,
> > > > > > find no matching entry, and return ENOENT.  The only reason
> > > > > > this
> > > > > > might
> > > > > > need a lock and a lockdep entry is if you are protecting
> > > > > > against
> > > > > > a
> > > > > > race
> > > > > > with the *add* notifier code in the mlx5 driver specifically
> > > > > > (the
> > > > > > core
> > > > > > add code won't have an issue, but since you only have a
> > > > > > single
> > > > > > place
> > > > > > to
> > > > > > store the notifier callback pointer, if it would be possible
> > > > > > for
> > > > > > you
> > > > > > to
> > > > > > add two callbacks and write over the first callback pointer
> > > > > > with
> > > > > > the
> > > > > > second without removing the first, then you would leak a
> > > > > > callback
> > > > > > notifier in the core notifier list).
> > > > >=20
> > > > > atomic_notifier_chain_unregister() unconditionally calls to
> > > > > syncronize_rcu() and I'm not so sure that it is best thing to
> > > > > do
> > > > > for every port unbind.
> > > > >=20
> > > > > Actually, I'm completely lost here, we are all agree that the
> > > > > patch
> > > > > fixes issue correctly, and it returns the code to be exactly
> > > > > as
> > > > > it was before commit df097a278c75 ("IB/mlx5: Use the new mlx5
> > > > > core
> > > > > notifier
> > > > > API"). Can we simply merge it and fix the kernel panic?
> > > >=20
> > > > As long as you are OK with me adding a comment to the patch so
> > > > people
> > > > coming back later won't scratch their head about how can it
> > > > possible
> > > > be
> > > > right to do that sequence without a lock held, I'm fine merging
> > > > the
> > > > fix.
> > > >=20
> > > > Something like:
> > > >=20
> > > > /*
> > > >  * The check/unregister/set-NULL sequence below does not need to
> > > > be
> > > >  * locked for correctness as it's only an optimization, and
> > > > can't
> > > >  * be under a lock or will throw a scheduling while atomic
> > > > error.
> > > >  */
> > >=20
> > > I think that the best place will be in commit message for this
> > > explanation,
> > > but I'm fine with the comment inside code as well.
> > >=20
> > > Thanks a lot, I appreciate it.
> >=20
> > Patch (unmodified) is applied to for-rc, thanks.
>=20
> Thanks Doug, I'll prepare patch with lockdep for Jason and
> will submit it to -next later on after passing verification.

Perfect, thanks Leon.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-EsXJONIJR4sHGlXKCh3q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1DRvcACgkQuCajMw5X
L93EFBAAh6b74Zq9G4VubFBNsMEFcIHifM6AXTyeTCkxN9ROfJ1qYxY9NOJUGZ6p
Z3P0rHh87vNLW4AVO4g3SbnAqJjE8tJYTUPhEus8xaRpo3S535/i2XuSlN4k7mvf
9Z8yaop6JbLMatgeczZCZvGMKp/2BAcEXOreXJbxvHcrE47B/45ZrSikjsn5JCyM
WDF5iUpBlQFX02/XeW9WZWyNbFDLy1zBbQM8lHuChjIkAncJUrdGvlCBocjhPD0m
LhOB/HadQPlDLwLw/WLLyyK0FXBLLimW2EfC+V+M7zW4j9pAl+1pkChQhtGkCPfn
LuQk9E+MzHq8yK4YErm5hzuazrhQMYvuNnfwDFMYORvowy9K0K3TNb5Tl+n8LQO6
fp9kBx9Dfyw2YoZ7ZbMAHf2FbjiIecn3DCIu+WHH1DMoRtaVEKoiKlp9MWBy8KFc
FspQvMi28GtEQmI6zRTUJOorZk4XiZqbcHN7QdLTbJPAFtOUkl0bjRY65xAi8Qbw
gePMlNCgVq6ZgoWNEjublzwrcfibh06oww5EktaXA0iuGksUPqT0gZYA/JkC2cNl
4V8cLtfSslcDhGQVF4bjd0wRxThgm8k8js2sj7CfyZ+suKcsTxBpKwbmxenA34Fi
OmwgE1dqZ62mHs04OUeZcFkocnn59sGPjWiweGaFE1YTudc35eg=
=MZsw
-----END PGP SIGNATURE-----

--=-EsXJONIJR4sHGlXKCh3q--

