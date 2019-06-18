Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F854ABD0
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 22:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbfFRU3G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 16:29:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730176AbfFRU3G (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jun 2019 16:29:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4F4F300181C;
        Tue, 18 Jun 2019 20:29:00 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23A6F10190A2;
        Tue, 18 Jun 2019 20:29:00 +0000 (UTC)
Message-ID: <b3cfa59d9d8e35ea56362d75d0d2be3f71c864dc.camel@redhat.com>
Subject: Re: [PATCH for-rc v2] RDMA/efa: Handle mmap insertions overflow
From:   Doug Ledford <dledford@redhat.com>
To:     Gal Pressman <galpress@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 18 Jun 2019 16:28:48 -0400
In-Reply-To: <82786c0b-510e-9aa7-cb18-28a84cec9420@amazon.com>
References: <20190618130732.20895-1-galpress@amazon.com>
         <20190618184808.GN6961@ziepe.ca>
         <82786c0b-510e-9aa7-cb18-28a84cec9420@amazon.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-dXZX6gv9M25ZRQx6lS7x"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 18 Jun 2019 20:29:05 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-dXZX6gv9M25ZRQx6lS7x
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-06-18 at 22:33 +0300, Gal Pressman wrote:
> On 18/06/2019 21:48, Jason Gunthorpe wrote:
> > On Tue, Jun 18, 2019 at 04:07:32PM +0300, Gal Pressman wrote:
> > > When inserting a new mmap entry to the xarray we should check for
> > > 'mmap_page' overflow as it is limited to 32 bits.
> > >=20
> > > Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
> > > Signed-off-by: Gal Pressman <galpress@amazon.com>
> > > Changelog:
> > > v1->v2
> > > * Bring back the ucontext->mmap_xa_page assignment before
> > > __xa_insert
> > >  drivers/infiniband/hw/efa/efa_verbs.c | 21 ++++++++++++++++-----
> > >  1 file changed, 16 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/infiniband/hw/efa/efa_verbs.c
> > > b/drivers/infiniband/hw/efa/efa_verbs.c
> > > index 0fea5d63fdbe..fb6115244d4c 100644
> > > +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> > > @@ -204,6 +204,7 @@ static u64 mmap_entry_insert(struct efa_dev
> > > *dev, struct efa_ucontext *ucontext,
> > >  			     void *obj, u64 address, u64 length, u8
> > > mmap_flag)
> > >  {
> > >  	struct efa_mmap_entry *entry;
> > > +	u32 next_mmap_page;
> > >  	int err;
> > > =20
> > >  	entry =3D kmalloc(sizeof(*entry), GFP_KERNEL);
> > > @@ -216,15 +217,19 @@ static u64 mmap_entry_insert(struct efa_dev
> > > *dev, struct efa_ucontext *ucontext,
> > >  	entry->mmap_flag =3D mmap_flag;
> > > =20
> > >  	xa_lock(&ucontext->mmap_xa);
> > > +	if (check_add_overflow(ucontext->mmap_xa_page,
> > > +			       (u32)(length >> PAGE_SHIFT),
> > > +			       &next_mmap_page))
> > > +		goto err_unlock;
> > > +
> > >  	entry->mmap_page =3D ucontext->mmap_xa_page;
> > > -	ucontext->mmap_xa_page +=3D DIV_ROUND_UP(length, PAGE_SIZE);
> >=20
> > Why did DIV_ROUND_UP become >> ?
>=20
> Since length is guaranteed to be a multiple of PAGE_SIZE.

Thanks, applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-dXZX6gv9M25ZRQx6lS7x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0JSYAACgkQuCajMw5X
L90/oBAAvYZQsPblZ5a7TRjJjtumfdVum3fCDpswkw0F1GK4+CPqh7jP0lIgXBK9
35QwxuPUGKQTm1fA35YL9ZVr3rdQECGNJGP4l/QuaKTGF12ViOV6rdEQ9OTovvVo
SyV5OMe50NQI+ChIBTJQwkYimTyx2XhImziaqApoY7VZXKfNAizl7qQKSwqqFtd0
YJQ37h3aalWRQUf4N1x6mH2KTowJzt1R4YfUWpnVxRj7xJsocSq7IA+C4SyfQ+P9
QR0CjY3TFALjcb+yfyNRWWX/s6pqqH4iu653GB+xsK0x43wAZB5d0eZ+IcTgFNYO
5MgnLe4KhWIUWPPV0xjlQcaDWX9bL5dgT5XU9NUVCqdWTf8UY03tTO8gkK0U8eMY
6O1Q0LaCpsBcRgei7bkE7Sry3PbO8ZTIXaICrp9eKinV1qmd+O/zki18E3jRpCxI
F0J6MIXZXNSyQb1XzD3R7QU81iBxPYempBHc6gm/vnmlx3svJ+rlanGodgaDbsMw
6AhGk+xWDDCi3FrB3+5b0w+eTKNA+ZAARL4NLetbU/aPhQyQyXFr7/D8iNtMeD2f
YEw9FXKiyUdQlJUgzxDkhrxRwcDbjlVm/5lRFxwPylD0EstScTnzcch+XIMpiPq7
grv1onBqutNZbcBBbqqdTgMlomsp415RcBYhYMhMylIBh2S559Y=
=BpE4
-----END PGP SIGNATURE-----

--=-dXZX6gv9M25ZRQx6lS7x--

