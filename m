Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4D88BA6B
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2019 15:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfHMNgB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Aug 2019 09:36:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4401 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728708AbfHMNgB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Aug 2019 09:36:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9F2230860C3;
        Tue, 13 Aug 2019 13:36:00 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-57.rdu2.redhat.com [10.10.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DAEE310013A1;
        Tue, 13 Aug 2019 13:35:59 +0000 (UTC)
Message-ID: <18d765758568c7399104cb3440673eb33c579fd5.camel@redhat.com>
Subject: Re: [PATCH rdma-rc] IB/mlx5: Fix use-after-free error while
 accessing ev_file pointer
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Yishai Hadas <yishaih@dev.mellanox.co.il>,
        Yishai Hadas <yishaih@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Date:   Tue, 13 Aug 2019 09:35:57 -0400
In-Reply-To: <20190813101003.GF29138@mtr-leonro.mtl.com>
References: <20190808081538.28772-1-leon@kernel.org>
         <20190808122615.GC1975@mellanox.com>
         <869b1416-a87b-f361-7722-bf9d231bc262@dev.mellanox.co.il>
         <20190808153411.GE1975@mellanox.com>
         <61b0f6cff0fcc1f4ee06447a9ec3eda9c4784c68.camel@redhat.com>
         <20190813101003.GF29138@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-eFdvv9/pRl8+4noxh5ly"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 13 Aug 2019 13:36:00 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-eFdvv9/pRl8+4noxh5ly
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-08-13 at 13:10 +0300, Leon Romanovsky wrote:
> On Mon, Aug 12, 2019 at 10:59:07AM -0400, Doug Ledford wrote:
> > On Thu, 2019-08-08 at 15:34 +0000, Jason Gunthorpe wrote:
> > > On Thu, Aug 08, 2019 at 06:32:00PM +0300, Yishai Hadas wrote:
> > > > > > diff --git a/drivers/infiniband/hw/mlx5/devx.c
> > > > > > b/drivers/infiniband/hw/mlx5/devx.c
> > > > > > index 2d1b3d9609d9..af5bbb35c058 100644
> > > > > > +++ b/drivers/infiniband/hw/mlx5/devx.c
> > > > > > @@ -2644,12 +2644,13 @@ static int
> > > > > > devx_async_event_close(struct
> > > > > > inode *inode, struct file *filp)
> > > > > >   	struct devx_async_event_file *ev_file =3D filp-
> > > > > > > private_data;
> > > > >=20
> > > > > This line is wrong, it should be
> > > > >=20
> > > > >    	struct devx_async_event_file *ev_file =3D
> > > > > container_of(struct
> > > > >   	                   devx_async_event_file, filp-
> > > > > > private_data, uobj);
> > > >=20
> > > > You suggested the below 2 lines instead of the above one line,
> > > > correct ? as
> > > > struct devx_async_event_file wraps uobj as its first field this
> > > > is
> > > > logically
> > > > equal, agree ?
> > >=20
> > > Yes, it is wrong only in the use of the type system, the
> > > private_data
> > > void * should only ever be cast to a ib_uobject.
> > >=20
> > > > struct ib_uobject *uobj =3D filp->private_data;
> > >=20
> > > This could be done with a cast
> > >=20
> > > > > It is also a bit redundant to store the mlx5_ib_dev in the
> > > > > devx_async_event_file as uobj->ucontext->dev is the same
> > > > > pointer.
> > > > >=20
> > > > Post hot unplug uobj->ucontext might not be accessible, isn't it
> > > > ?
> > > > Current code should be fine for that.
> > >=20
> > > That is the other kind of weird thing, all this destruction could
> > > be
> > > done on unplug..
> > >=20
> > > > Are we fine to take this patch ?
> > >=20
> > > Yes
> >=20
> > Thanks, applied to for-rc.
>=20
> Doug,
>=20
> I don't see it in WIP branch, did you push it?

Sorry, I did not.  It's been pushed now, it should be visible within a
few moments.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-eFdvv9/pRl8+4noxh5ly
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1SvL0ACgkQuCajMw5X
L93PfxAAmuxUz+h8HMuQmCgWk6sB685c07VA+4KGVYReOPuqFMOVIlDigtJ98yn1
TraQYiW0JWmmQPu5bVZu4A46drAxRTk3udjbASLnGRZklu+KWzWEus+TGxERW/hq
+Gsh3ZpwHG0zNR2fvtxq9ktvX6we8VUx6rK0Sg2oAlNKWykOaMWNGdMpSoSOknmw
McLbaswUsynITwZnAl1YG/V06VClZN9Xs+GyBd4Ue1NN1eFHohz3bvHtDKgGIipD
1ND3Gg7XLu6aYIQC5eD6ICj7LEuBhGGARBtyYD17/YCd9E4bo63EXUmc9I29hVac
1dnU9S0XbCj6pQnfM/XCuvRd0l1YIN2mfuZkCWkIk4eLGkVgNq/QYx9plYyd9wGb
SFQ1qs4Al0R4cOoYedOK9ppzZZGQucTKyHhUSK1qw3LEdSDtF5d9WI6sww/U3D9w
ao1IWXXwvgX54VMv5oEj0YKEylqqxiKqDIcyc2n+rBz6pg3Cv81h3hK8tmClV/o2
zb5x54DNTSNGi6+TH2JOVnXonK/zBJeVKdzLiPp4ae5Kvx39jKlgMrlrHp4+Kmi0
neT7N1dQvtWsVpf5b4DGfQfAzzpDKohKtyHiHhNH+ooqvz6rVIkj7GzhtMlXav23
ZwxLjyr8HCPrgq4HkhIh4BKaNuSs5k6MPNXH5tiPDs/lLuOk7OI=
=s4se
-----END PGP SIGNATURE-----

--=-eFdvv9/pRl8+4noxh5ly--

