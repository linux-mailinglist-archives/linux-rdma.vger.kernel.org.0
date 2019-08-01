Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 846877DD97
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 16:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbfHAOQ2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 10:16:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbfHAOQ2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 10:16:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7012307D989;
        Thu,  1 Aug 2019 14:16:27 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A721F6013A;
        Thu,  1 Aug 2019 14:16:26 +0000 (UTC)
Message-ID: <060b3e8fbe48312e9af33b88ba7ba62a6b64b493.camel@redhat.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Date:   Thu, 01 Aug 2019 10:16:23 -0400
In-Reply-To: <20190801120821.GK4832@mtr-leonro.mtl.com>
References: <20190731083852.584-1-leon@kernel.org>
         <44863abbef5c1e233cbedfdf959fe900f7722d74.camel@redhat.com>
         <20190731170054.GF22677@mellanox.com>
         <20190731170944.GC4832@mtr-leonro.mtl.com>
         <20190731172215.GJ22677@mellanox.com>
         <20190731180124.GE4832@mtr-leonro.mtl.com>
         <20190731195523.GK22677@mellanox.com>
         <20190801082749.GH4832@mtr-leonro.mtl.com>
         <20190801120007.GB23885@mellanox.com>
         <20190801120821.GK4832@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-vQL9rswYXdZHHZzp9yAx"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 01 Aug 2019 14:16:27 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-vQL9rswYXdZHHZzp9yAx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-01 at 15:08 +0300, Leon Romanovsky wrote:
> On Thu, Aug 01, 2019 at 12:00:12PM +0000, Jason Gunthorpe wrote:
> > On Thu, Aug 01, 2019 at 11:27:49AM +0300, Leon Romanovsky wrote:
> > > On Wed, Jul 31, 2019 at 07:55:28PM +0000, Jason Gunthorpe wrote:
> > > > On Wed, Jul 31, 2019 at 09:01:24PM +0300, Leon Romanovsky wrote:
> > > > > On Wed, Jul 31, 2019 at 05:22:19PM +0000, Jason Gunthorpe
> > > > > wrote:
> > > > > > On Wed, Jul 31, 2019 at 08:09:44PM +0300, Leon Romanovsky
> > > > > > wrote:
> > > > > > > On Wed, Jul 31, 2019 at 05:00:59PM +0000, Jason Gunthorpe
> > > > > > > wrote:
> > > > > > > > On Wed, Jul 31, 2019 at 12:22:44PM -0400, Doug Ledford
> > > > > > > > wrote:
> > > > > > > > > > diff --git a/drivers/infiniband/hw/mlx5/main.c
> > > > > > > > > > b/drivers/infiniband/hw/mlx5/main.c
> > > > > > > > > > index c2a5780cb394..e12a4404096b 100644
> > > > > > > > > > +++ b/drivers/infiniband/hw/mlx5/main.c
> > > > > > > > > > @@ -5802,13 +5802,12 @@ static void
> > > > > > > > > > mlx5_ib_unbind_slave_port(struct
> > > > > > > > > > mlx5_ib_dev *ibdev,
> > > > > > > > > >  		return;
> > > > > > > > > >  	}
> > > > > > > > > >=20
> > > > > > > > > > -	if (mpi->mdev_events.notifier_call)
> > > > > > > > > > -		mlx5_notifier_unregister(mpi->mdev,
> > > > > > > > > > &mpi->mdev_events);
> > > > > > > > > > -	mpi->mdev_events.notifier_call =3D NULL;
> > > > > > > > > > -
> > > > > > > > > >  	mpi->ibdev =3D NULL;
> > > > > > > > > >=20
> > > > > > > > > >  	spin_unlock(&port->mp.mpi_lock);
> > > > > > > > > > +	if (mpi->mdev_events.notifier_call)
> > > > > > > > > > +		mlx5_notifier_unregister(mpi->mdev,
> > > > > > > > > > &mpi->mdev_events);
> > > > > > > > > > +	mpi->mdev_events.notifier_call =3D NULL;
> > > > > > > > >=20
> > > > > > > > > I can see where this fixes the problem at hand, but
> > > > > > > > > this gives the
> > > > > > > > > appearance of creating a new race.  Doing a
> > > > > > > > > check/unregister/set-null
> > > > > > > > > series outside of any locks is a red flag to someone
> > > > > > > > > investigating the
> > > > > > > > > code.  You should at least make note of the fact that
> > > > > > > > > calling unregister
> > > > > > > > > more than once is safe.  If you're fine with it, I can
> > > > > > > > > add a comment and
> > > > > > > > > take the patch, or you can resubmit.
> > > > > > > >=20
> > > > > > > > Mucking about notifier_call like that is gross anyhow,
> > > > > > > > maybe better to
> > > > > > > > delete it entirely.
> > > > > > >=20
> > > > > > > What do you propose to delete?
> > > > > >=20
> > > > > > The 'mpi->mdev_events.notifier_call =3D NULL;' and 'if
> > > > > > (mpi->mdev_events.notifier_call)'
> > > > > >=20
> > > > > > Once it leaves the lock it stops doing anything useful.
> > > > > >=20
> > > > > > If you need it, then we can't drop the lock, if you don't,
> > > > > > it is just
> > > > > > dead code, delete it.
> > > > >=20
> > > > > This specific notifier_call is protected outside
> > > > > of mlx5_ib_unbind_slave_port() by mlx5_ib_multiport_mutex and
> > > > > NULL check
> > > > > is needed to ensure single call to mlx5_notifier_unregister,
> > > > > because
> > > > > calls to mlx5_ib_unbind_slave_port() will be serialized.
> > > >=20
> > > > If this routine is now relying on locking that is not obvious in
> > > > the
> > > > function itself then add a lockdep too.
> > >=20
> > > It was "before" without lockdep and we are
> > > protecting "mpi->mdev_events.notifier_call =3D NULL;"
> >=20
> > Before the locking was relying on mpi_lock inside this function now
> > this patch changes it to relies on mlx5_ib_multiport_mutex, so it
> > needs a lockdep
>=20
> It didn't rely, but was moved by mistake. I'll add lockdep and resend.
>=20
> Thanks

There's no need for a lockdep.  The removal of the notifier callback
entry is re-entrant safe.  The core removal routines have their own
spinlock they use to protect the actual notifier list.  If you call it
more than once, the second and subsequent calls merely scan the list,
find no matching entry, and return ENOENT.  The only reason this might
need a lock and a lockdep entry is if you are protecting against a race
with the *add* notifier code in the mlx5 driver specifically (the core
add code won't have an issue, but since you only have a single place to
store the notifier callback pointer, if it would be possible for you to
add two callbacks and write over the first callback pointer with the
second without removing the first, then you would leak a callback
notifier in the core notifier list).

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-vQL9rswYXdZHHZzp9yAx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1C9DgACgkQuCajMw5X
L92+RhAAl5n4nlQtTTW4M5dau3xk5E5pcE5992ctP7vW/K5XxBIvEJbDP2nSvsJc
WL04l3E8ctJ4YVhWwD28Fb+oKNFhEnacbOxaLqUrjXVGR0G/n4MiOeBfId8VtBbe
lzTTkqONM2kT50XYF8aQLdF3BY4i47xQPB4AUme9ma550n0JMSsTsFWpBIIxpb8I
7941GLxHi13yXoyrDhgJFonpIHKGd4PPJVBN8e1dDHWHBeoqu3ybbFfPdXCqVVtL
/n9suMHZ1XCVEJgGYURc3H8zFEl1mibeL3ih3d1+zWa+lJyTp+mWKfzR4+BQJwl5
2x/ERx+zaChd4BrZ5qFObK0M9gEdQA427ERem6+g/I8bte0F4kt2YxiqAGSLuhuj
bYmYJlt7O2eYfO5mKC/I8Sd+W47ZuugiVvB4CoqpHKQ9iZTrtcKAF9+tnvP24S6D
5JXs0ruM0RIvPPgI41wcN3zrjMFfXm7QJ7nDR9II8KQsFZgiz7U/bFKOyuBAfRn0
tWHoG9CVmEljG2qLBEBb/SFsYQtW8kcBIiwe1nlwEbExu2hsQRFNgZUMzouCnIrq
F+2qhIVd3XYSUJ8HQOdohRYSVrjEWplPg7WQgsHqrNDTwshAaH+5fYzTIZjkgQAA
7IFF+6Br1O4gObbOH6E4jUFPAdiL3Di/XYQPE3wQtj4Gp2gbcGY=
=5G8f
-----END PGP SIGNATURE-----

--=-vQL9rswYXdZHHZzp9yAx--

