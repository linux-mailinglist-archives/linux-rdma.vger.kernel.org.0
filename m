Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A67D7CC50
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 20:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfGaSv4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 14:51:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfGaSv4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 14:51:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9BC733082E91;
        Wed, 31 Jul 2019 18:51:55 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B48925D9C5;
        Wed, 31 Jul 2019 18:51:54 +0000 (UTC)
Message-ID: <805ad5c2714ad2fb4c9b92eb99a256e8998334f9.camel@redhat.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Date:   Wed, 31 Jul 2019 14:51:42 -0400
In-Reply-To: <20190731180124.GE4832@mtr-leonro.mtl.com>
References: <20190731083852.584-1-leon@kernel.org>
         <44863abbef5c1e233cbedfdf959fe900f7722d74.camel@redhat.com>
         <20190731170054.GF22677@mellanox.com>
         <20190731170944.GC4832@mtr-leonro.mtl.com>
         <20190731172215.GJ22677@mellanox.com>
         <20190731180124.GE4832@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Y7q+uNUaBGgOplPgHnb9"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 31 Jul 2019 18:51:55 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-Y7q+uNUaBGgOplPgHnb9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-31 at 21:01 +0300, Leon Romanovsky wrote:
> On Wed, Jul 31, 2019 at 05:22:19PM +0000, Jason Gunthorpe wrote:
> > On Wed, Jul 31, 2019 at 08:09:44PM +0300, Leon Romanovsky wrote:
> > > On Wed, Jul 31, 2019 at 05:00:59PM +0000, Jason Gunthorpe wrote:
> > > > On Wed, Jul 31, 2019 at 12:22:44PM -0400, Doug Ledford wrote:
> > > > > > diff --git a/drivers/infiniband/hw/mlx5/main.c
> > > > > > b/drivers/infiniband/hw/mlx5/main.c
> > > > > > index c2a5780cb394..e12a4404096b 100644
> > > > > > +++ b/drivers/infiniband/hw/mlx5/main.c
> > > > > > @@ -5802,13 +5802,12 @@ static void
> > > > > > mlx5_ib_unbind_slave_port(struct
> > > > > > mlx5_ib_dev *ibdev,
> > > > > >  		return;
> > > > > >  	}
> > > > > >=20
> > > > > > -	if (mpi->mdev_events.notifier_call)
> > > > > > -		mlx5_notifier_unregister(mpi->mdev, &mpi-
> > > > > > >mdev_events);
> > > > > > -	mpi->mdev_events.notifier_call =3D NULL;
> > > > > > -
> > > > > >  	mpi->ibdev =3D NULL;
> > > > > >=20
> > > > > >  	spin_unlock(&port->mp.mpi_lock);
> > > > > > +	if (mpi->mdev_events.notifier_call)
> > > > > > +		mlx5_notifier_unregister(mpi->mdev, &mpi-
> > > > > > >mdev_events);
> > > > > > +	mpi->mdev_events.notifier_call =3D NULL;
> > > > >=20
> > > > > I can see where this fixes the problem at hand, but this gives
> > > > > the
> > > > > appearance of creating a new race.  Doing a
> > > > > check/unregister/set-null
> > > > > series outside of any locks is a red flag to someone
> > > > > investigating the
> > > > > code.  You should at least make note of the fact that calling
> > > > > unregister
> > > > > more than once is safe.  If you're fine with it, I can add a
> > > > > comment and
> > > > > take the patch, or you can resubmit.
> > > >=20
> > > > Mucking about notifier_call like that is gross anyhow, maybe
> > > > better to
> > > > delete it entirely.
> > >=20
> > > What do you propose to delete?
> >=20
> > The 'mpi->mdev_events.notifier_call =3D NULL;' and 'if
> > (mpi->mdev_events.notifier_call)'
> >=20
> > Once it leaves the lock it stops doing anything useful.
> >=20
> > If you need it, then we can't drop the lock, if you don't, it is
> > just
> > dead code, delete it.
>=20
> This specific notifier_call is protected outside
> of mlx5_ib_unbind_slave_port() by mlx5_ib_multiport_mutex and NULL
> check
> is needed to ensure single call to mlx5_notifier_unregister, because
> calls to mlx5_ib_unbind_slave_port() will be serialized.

But looking at the code, it doesn't appear mlx5_notifier_unregister
requires there to only be a single call.  It's safe to call it multiple
times for the same notifier.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-Y7q+uNUaBGgOplPgHnb9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1B4z4ACgkQuCajMw5X
L91YCw//ShJTPrAms6hy8JBaetc+GRGEVzhyCAqZcR02oX2YOKP5sizzMqMetdum
oIgKdSn9rUoD0eAryFGhkb2er9nJ8510By3KGl4x4OskIlTYZ4bLfG3nvvxtf0e3
phvoYXTH+lc2LuFVQLFwr7tGZ4WXHBLKGle6uPJqfgps3LN+BK9HSGToP8l5csPH
zdJzHVCr33SHD968OKRMDDLfWnn5jUTHFBB4dPC55/BAQPJOxNYLnKZMbMyOSYbY
WYv2W6npEeTgZ44TKXX4+kCOzaC+IbPpx4G4xBa1Kpj+uHmjSBG0+to5Pi+wpnCf
1ZmwjomWTZwsSQp+4Isn4s5dKuHzp9zx4rBQcrqfXaAq+aMlp+lVNKW45dgj9cAK
J0n1+xRrm288267EU0al5ZIN/jr9nKV9SqWuPSzHIg4E7tyMMxmG9W98sKml8gHi
Hei3v3UNXRPb5GMRSJdp/VC1vN8i/ONqGfiYEe0nUyThD/m0guH3aFpk/8Lc5Uk4
rhCmyyuHE+jeXBp0JSPGhPr78UXxxz93C3OwRtI/360NGAsW37+oAkjQyp8ms2Wq
ofAonOd7idPx4wbxhYQZ+Xx6uB+q6LxhxOXlC4JWiTvvEwUgeCqJnbFz5VUpYnnQ
qCwv4gK/lKiz+jDED41JWKClQAmduoGn6iGy3il6tMIZs2Ceu0A=
=m80s
-----END PGP SIGNATURE-----

--=-Y7q+uNUaBGgOplPgHnb9--

