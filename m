Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0BCB8A1C3
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 16:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfHLO7L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 10:59:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfHLO7L (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Aug 2019 10:59:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D986B3004E6C;
        Mon, 12 Aug 2019 14:59:10 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-57.rdu2.redhat.com [10.10.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB5597D4C4;
        Mon, 12 Aug 2019 14:59:09 +0000 (UTC)
Message-ID: <61b0f6cff0fcc1f4ee06447a9ec3eda9c4784c68.camel@redhat.com>
Subject: Re: [PATCH rdma-rc] IB/mlx5: Fix use-after-free error while
 accessing ev_file pointer
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Yishai Hadas <yishaih@dev.mellanox.co.il>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Date:   Mon, 12 Aug 2019 10:59:07 -0400
In-Reply-To: <20190808153411.GE1975@mellanox.com>
References: <20190808081538.28772-1-leon@kernel.org>
         <20190808122615.GC1975@mellanox.com>
         <869b1416-a87b-f361-7722-bf9d231bc262@dev.mellanox.co.il>
         <20190808153411.GE1975@mellanox.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5BSzHKLlp69MadQ4SzC6"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 12 Aug 2019 14:59:10 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-5BSzHKLlp69MadQ4SzC6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-08 at 15:34 +0000, Jason Gunthorpe wrote:
> On Thu, Aug 08, 2019 at 06:32:00PM +0300, Yishai Hadas wrote:
> > > > diff --git a/drivers/infiniband/hw/mlx5/devx.c
> > > > b/drivers/infiniband/hw/mlx5/devx.c
> > > > index 2d1b3d9609d9..af5bbb35c058 100644
> > > > +++ b/drivers/infiniband/hw/mlx5/devx.c
> > > > @@ -2644,12 +2644,13 @@ static int devx_async_event_close(struct
> > > > inode *inode, struct file *filp)
> > > >   	struct devx_async_event_file *ev_file =3D filp-
> > > > >private_data;
> > >=20
> > > This line is wrong, it should be
> > >=20
> > >    	struct devx_async_event_file *ev_file =3D
> > > container_of(struct
> > >   	                   devx_async_event_file, filp-
> > > >private_data, uobj);
> >=20
> > You suggested the below 2 lines instead of the above one line,
> > correct ? as
> > struct devx_async_event_file wraps uobj as its first field this is
> > logically
> > equal, agree ?
>=20
> Yes, it is wrong only in the use of the type system, the private_data
> void * should only ever be cast to a ib_uobject.
>=20
> > struct ib_uobject *uobj =3D filp->private_data;
>=20
> This could be done with a cast
>=20
> > > It is also a bit redundant to store the mlx5_ib_dev in the
> > > devx_async_event_file as uobj->ucontext->dev is the same pointer.
> > > =20
> > Post hot unplug uobj->ucontext might not be accessible, isn't it ?
> > Current code should be fine for that.
>=20
> That is the other kind of weird thing, all this destruction could be
> done on unplug..
>=20
> > Are we fine to take this patch ?
>=20
> Yes

Thanks, applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-5BSzHKLlp69MadQ4SzC6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1RfrsACgkQuCajMw5X
L93uCw//aQKNqL1OlOn0KWWC5u1Ox1AVcDOi4RgHqKg2JJTrEXNDGw3meTiUPLfT
o7YbPLSKI5B8VtR/6BMFNVRnhUXiQtQ7VuF87GxsMWS3rN6ur77GYUzyx6c9B3If
CdQNfq8GMRdAk8vXWq3f12Q0/Pu8ZM9QbANYT/BH4NkEmBmykRdntkABMDh2dkWC
7DwinKSIyPl3n/dIeCykfPP1NsILOUSJcnfvC6Xs/Qe9j4yTyF/D44rVwD1vGLjX
U0fF9CC6TXiwuWWZVtALG6W1Ts8r0/F/nvtVjuy5URR6Kx2ywvTqyF0ZtQlqMqd8
KikV4wMd2i163BJskxIqzxr42mYNBdmt7jK3DOWeDgjXMlSl8ica6gNl2nt6hsZn
edYaKIriL39IoI06TU2ETHSU809+Eybs3tHvwIrM1EgeZ/gdw25yf6LdJqHwLE3c
6pq8j85V+VwnVDlAZfNjmTDS6JJIRJVg1CuhXHTgnMgb35DaDPxmUV5ce2thGacN
7rFfAHNNITrCDqw1D2gZWY/Y318HkRvVTmltA7fL4XYN8nOFmxaDTVnZ4nsV/Gqo
mRBA/uYi8A4cJTN415F+VMyjbsJ8C1eSKYriahXX+gIfzYK4GeV3khspDmb43H8c
M3JVChg3SVPdVBOOFas9G2T0M5oCKG8WFRjtAKmmp9kxb+WmJbw=
=vUCn
-----END PGP SIGNATURE-----

--=-5BSzHKLlp69MadQ4SzC6--

