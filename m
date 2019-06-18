Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D60D4A5EB
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 17:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfFRPzM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 11:55:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729414AbfFRPzM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jun 2019 11:55:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED0FF307D90E;
        Tue, 18 Jun 2019 15:55:11 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-53.rdu2.redhat.com [10.10.112.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 53B1F9CC7;
        Tue, 18 Jun 2019 15:55:11 +0000 (UTC)
Message-ID: <97a95f7e5447b0ddf4dee15c536d72bd9fb65780.camel@redhat.com>
Subject: Re: [PATCH v2 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 18 Jun 2019 11:55:08 -0400
In-Reply-To: <20190618131019.GE6961@ziepe.ca>
References: <20190614003819.19974-1-jgg@ziepe.ca>
         <20190614003819.19974-3-jgg@ziepe.ca>
         <20190618121709.GK4690@mtr-leonro.mtl.com> <20190618131019.GE6961@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-azq5fQ3E1CFaP+D9kx+k"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 18 Jun 2019 15:55:12 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-azq5fQ3E1CFaP+D9kx+k
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-06-18 at 10:10 -0300, Jason Gunthorpe wrote:
> On Tue, Jun 18, 2019 at 03:17:09PM +0300, Leon Romanovsky wrote:
> > >  /**
> > >   * ib_set_client_data - Set IB client context
> > >   * @device:Device to set context for
> > > diff --git a/drivers/infiniband/core/nldev.c
> > > b/drivers/infiniband/core/nldev.c
> > > index 69188cbbd99bd5..55eccea628e99f 100644
> > > +++ b/drivers/infiniband/core/nldev.c
> > > @@ -120,6 +120,9 @@ static const struct nla_policy
> > > nldev_policy[RDMA_NLDEV_ATTR_MAX] =3D {
> > >  	[RDMA_NLDEV_ATTR_DEV_PROTOCOL]		=3D { .type =3D
> > > NLA_NUL_STRING,
> > >  				    .len =3D RDMA_NLDEV_ATTR_ENTRY_STRLEN
> > > },
> > >  	[RDMA_NLDEV_NET_NS_FD]			=3D { .type =3D
> > > NLA_U32 },
> > > +	[RDMA_NLDEV_ATTR_CHARDEV_TYPE]		=3D { .type =3D
> > > NLA_NUL_STRING,
> > > +				    .len =3D 128 },
> > > +	[RDMA_NLDEV_ATTR_PORT_INDEX]		=3D { .type =3D NLA_U32 },
> >=20
> > It is wrong, we already have RDMA_NLDEV_ATTR_PORT_INDEX declared in
> > nla_policy.
> > But we don't have other RDMA_NLDEV_ATTR_CHARDEV_* declarations
> > here.
>=20
> Doug can you fix it?

I haven't pushed my wip to for-next yet, so yeah, I can fix it.  We
just need to decide on what the full fix is ;-)

Drop the duplicate ATTR_PORT_INDEX, but what about a final decision on
including the outputs for possible future type checking?  You and Leon
seem to be going back and forth, and I don't have strong feelings
either way on this one.  It's just a definition statement, not like
it's a dead subroutine.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
2FDD

--=-azq5fQ3E1CFaP+D9kx+k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0JCVwACgkQuCajMw5X
L92XXQ//WHQglExziYLQfM4dAQUmTofJ2s233tRRLwdIhEdZi5q32+5fzAVuc7Kv
wmvdBQfxd1HCA83VCxYplgIidF5cosz+V84vQdooNf+/FmAfUfLohV3gfDO5O53g
QxURXRX0A/CnKN0v0tam+GCdYuxY9v9Et5pJ4VqPpC9P1wN5mZ49dQ2vaOPQGLZz
U9GlUDGcKe9hwXs1y6Aw3y5ypO2l6UbUSAtukk+Tjj7mAbj+0LRgxRBqp9uQ7tlx
vIrcM7RpEMjCmM3IraTxe3BiOBtuzeVNnOeo0/IH8jLr5SeakNDSa3tahMPeNePK
HeVt0+ZCPitIQGv560wQHGZyYb/MdtFqWam8/vzxEfUE68Bcu4DwaX4/UZg+GlSX
Z2NwEujzGSMNjhAfU8ac1EElRb5BhU1UXxZsuOif0Q0/2KsykSzSvRrSOJ7ZwDwO
zFIHTYmQ4d9qVORYdfuXCNBe3FfKNlgcldyu7HWjcVOJqb+4ypxwB1StiRSKKBU1
U1jMnnDzn8H8y1B0bKpdEDaWmyLk5PHPw7C+EWueoPVrpPvligwtZChxW+hBC1n5
k4YtwNADVhKssWgITsqMc6mCZ8Kl+S/6+ppVpVBJvaPD2LEbOFyzaL7Ux0cDY2jZ
r2YpeL8eylAyv89QhQDkxaCOfjEkh19x0D4K+iqaW7QZ+Nj6Dcw=
=S8NC
-----END PGP SIGNATURE-----

--=-azq5fQ3E1CFaP+D9kx+k--

