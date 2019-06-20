Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD614D98D
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 20:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfFTSiy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 14:38:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfFTSiv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 14:38:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9955388313;
        Thu, 20 Jun 2019 18:38:51 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C5DB65C1A1;
        Thu, 20 Jun 2019 18:38:48 +0000 (UTC)
Message-ID: <f4854b3abea8604e6a1dea74baa6cc53042ed677.camel@redhat.com>
Subject: Re: [PATCH rdma-next] RDMA: Convert destroy_wq to be void
From:   Doug Ledford <dledford@redhat.com>
To:     Yuval Shaia <yuval.shaia@oracle.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Date:   Thu, 20 Jun 2019 14:38:46 -0400
In-Reply-To: <20190612125518.GA3358@lap1>
References: <20190612122741.22850-1-leon@kernel.org>
         <20190612124049.GA2448@lap1> <20190612125112.GR6369@mtr-leonro.mtl.com>
         <20190612125518.GA3358@lap1>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-QYBi1/UnZ4GZsxXgUx7K"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 20 Jun 2019 18:38:51 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-QYBi1/UnZ4GZsxXgUx7K
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-06-12 at 15:55 +0300, Yuval Shaia wrote:
> On Wed, Jun 12, 2019 at 03:51:12PM +0300, Leon Romanovsky wrote:
> > On Wed, Jun 12, 2019 at 03:40:50PM +0300, Yuval Shaia wrote:
> > > On Wed, Jun 12, 2019 at 03:27:41PM +0300, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@mellanox.com>
> > > >=20
> > > > All callers of destroy WQ are always success and there is no
> > > > need
> > > > to check their return value, so convert destroy_wq to be void.
> > > >=20
> > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > > ---
> > > >  drivers/infiniband/core/verbs.c      | 12 +++++-------
> > > >  drivers/infiniband/hw/mlx4/mlx4_ib.h |  2 +-
> > > >  drivers/infiniband/hw/mlx4/qp.c      |  4 +---
> > > >  drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +-
> > > >  drivers/infiniband/hw/mlx5/qp.c      |  4 +---
> > > >  include/rdma/ib_verbs.h              |  2 +-
> > > >  6 files changed, 10 insertions(+), 16 deletions(-)
> > > >=20
> > > > diff --git a/drivers/infiniband/core/verbs.c
> > > > b/drivers/infiniband/core/verbs.c
> > > > index 2fb834bb146c..d55f491be24f 100644
> > > > --- a/drivers/infiniband/core/verbs.c
> > > > +++ b/drivers/infiniband/core/verbs.c
> > > > @@ -2344,19 +2344,17 @@ EXPORT_SYMBOL(ib_create_wq);
> > > >   */
> > > >  int ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata)
> > >=20
> > > So why this one left out of this change?
> >=20
> > This function can return -EBUSY.
>=20
> Missed that.
>=20
> > > >  {
> > > > -	int err;
> > > >  	struct ib_cq *cq =3D wq->cq;
> > > >  	struct ib_pd *pd =3D wq->pd;
> > > >=20
> > > >  	if (atomic_read(&wq->usecnt))
> > > >  		return -EBUSY;
> >=20
> > Thanks
>=20
> Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
>=20

Applied to for-next, thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-QYBi1/UnZ4GZsxXgUx7K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0L0rYACgkQuCajMw5X
L911Fw/9HQ2I9UU+nJjedKgigMOoZ5H4CiPvYVpaCGz8ViJrSq93gVrXyWKIpK92
3xiewsr/tNDeIZCxly6iAke6kLAoqbX6yHzM9D2LtZsvrJREJRKlhX49D0BpHOm5
JtDwWJatjrWD+lRnytChKNJyUeDBiBs48ABdmdxG1zzNKAPIGMni+yrQIyzPnsxm
ykptWbuNagBR9iyhLYlIuaz7Ya+tyAxBhtEGOzUx0GzlL99cGRfBlj9PQnGJLwen
EfkAzSKSDt+yeewQfucrdBc6rmloRLUT/AFIhg6bY1xp5jgPhUf0HSgJHOn8lGBL
QsLsfCvpezHby1Bk4vwPzYLqfG8xSMs3sEtlTGuodz/T7JTy0zbaZBbhpEzfuIWE
jmgsPFh5bxp8gSjV3gfm3ELhD7ck/EyzMAn4G3opJi3P48ICzj/gM8x9K/QW4gMP
58ZwjwnLUuR9vQnO3InrBoz/sxduleG/RxFizOCrUqHrlGItX+F0u6Wx9/aWvoqn
hlysfVZky9fckPaNzZw1Ry+Imei7Ivc00V48tyih3ij4DngZ+Joe8YFLrOMMqHu2
+xxD14EIbfARiVQPZ0sdMy5rRRUSu2M8IjU/uYMapmbbYgmEOFzl3NxR8QvnPoo0
0hghB1Pidjf6lfg/OFd/ErITyuDZBOfFyfEgI9pjScjgoSV2Byw=
=Z/28
-----END PGP SIGNATURE-----

--=-QYBi1/UnZ4GZsxXgUx7K--

