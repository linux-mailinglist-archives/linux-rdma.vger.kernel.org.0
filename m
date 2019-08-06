Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7DD834E5
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 17:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfHFPQR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 11:16:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfHFPQR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Aug 2019 11:16:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B550776D1;
        Tue,  6 Aug 2019 15:16:16 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-53.rdu2.redhat.com [10.10.112.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79CE460127;
        Tue,  6 Aug 2019 15:16:15 +0000 (UTC)
Message-ID: <e94a97412c260616c8bd27d9dd361e496f15c67a.camel@redhat.com>
Subject: Re: [PATCH rdma-core 2/2] cxgb4: remove unused c4iw_match_device
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>
Date:   Tue, 06 Aug 2019 11:16:13 -0400
In-Reply-To: <20190806111317.GV4832@mtr-leonro.mtl.com>
References: <20190725174928.26863-1-bharat@chelsio.com>
         <20190725181424.GB7467@ziepe.ca> <20190728083749.GH4674@mtr-leonro.mtl.com>
         <20190729074612.GA30030@chelsio.com> <20190805110652.GB23319@chelsio.com>
         <20190806080902.GS4832@mtr-leonro.mtl.com>
         <20190806094849.GT4832@mtr-leonro.mtl.com>
         <20190806110812.GA6109@chelsio.com>
         <20190806111317.GV4832@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-IEhZ6WZTvxSKFGCIXKgP"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 06 Aug 2019 15:16:16 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-IEhZ6WZTvxSKFGCIXKgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-08-06 at 14:13 +0300, Leon Romanovsky wrote:
> On Tue, Aug 06, 2019 at 04:38:13PM +0530, Potnuri Bharat Teja wrote:
> > On Tuesday, August 08/06/19, 2019 at 15:18:49 +0530, Leon Romanovsky
> > wrote:
> > > On Tue, Aug 06, 2019 at 11:09:02AM +0300, Leon Romanovsky wrote:
> > > > On Mon, Aug 05, 2019 at 04:36:53PM +0530, Potnuri Bharat Teja
> > > > wrote:
> > > > > On Monday, July 07/29/19, 2019 at 13:16:20 +0530, Potnuri
> > > > > Bharat Teja wrote:
> > > > > > On Sunday, July 07/28/19, 2019 at 14:07:49 +0530, Leon
> > > > > > Romanovsky wrote:
> > > > > > > On Thu, Jul 25, 2019 at 03:14:24PM -0300, Jason Gunthorpe
> > > > > > > wrote:
> > > > > > > > On Thu, Jul 25, 2019 at 11:19:28PM +0530, Potnuri Bharat
> > > > > > > > Teja wrote:
> > > > > > > > > match_device handler is no longer needed after latest
> > > > > > > > > device binding changes.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com
> > > > > > > > > >
> > > > > > > > > ---
> > > > > > > > >  providers/cxgb4/dev.c | 41 --------------------------
> > > > > > > > > ---------------
> > > > > > > > >  1 file changed, 41 deletions(-)
> > > > > > > >=20
> > > > > > > > Do you know if we can also drop the same code in cxgb3?
> > > > > > >=20
> > > > > > > Can we simply remove cxgb3?
> > > > > > >=20
> > > > > >=20
> > > > > > I am in talks with the people here. I'll confirm it soon.
> > > > >=20
> > > > > Hi Jason/Doug/Leon,
> > > > > Chelsio is fine with removing cxgb3.
> > > >=20
> > > > Thanks a lot.
> > >=20
> > > Which parts of cxgb3 can we remove? RDMA, scsi, net or everything?
> >=20
> > I can only say RDMA. For net and scsi parts of cxgb3, the
> > corresponding
> > maintainers might request for their removal.
> > Should I send a patch removing RDMA cxgb3?
>=20
> It will be the best variant.
>=20
> Thanks
>=20
> > Thanks.

I'm not entirely sure that I want it removed yet.  The cxgb3 isn't the
most stellar device, but it will do 40GBit/s.  That's still a very
respectable speed (unlike say mthca that was mostly 10GBit/s with only a
short run of 20GBit/s devices before it switched over to mlx4).  So a
cxgb3 based home system is still something very usable.  Are we sure we
want to remove this?

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-IEhZ6WZTvxSKFGCIXKgP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1Jmb0ACgkQuCajMw5X
L9361BAAsf9svjDaaKzY+xDqTHQL23m7WxWYtqRFkzgyX1SHqu8Nx5ghKsC/Nj9Z
oC79B0ijj7vt/cYL+714D9sETGvI8mKdDx/mOCYVv06OGYtMqSdDbAnUuOIGEWyy
+ZucOiLlIdXgZfJdAkUVnUR+iGXf6HJ9LfQtp1vZwOAczUUyVRy/97WXQ27gGZNC
UnpX0sjTbxZ/XHUnM9nmZWj8NuwPpzYserXZh23eaYTBj9PNss26ZnKBS0YymYfm
FG2wkIs3SJ196p4Ms39WzhYOdBpPQkBTsjgINrpRDWvB6gZKyGYoidTEJ7UQHX+1
dNQjR2QDduM29LU/FfxVSr3R7WV1XfFfyDlOhk9JhrI+LDQ/emzYRLqBfCY8VgxP
hzUcS3dBHxRoszVjnOTJu6IAuw5nktYajcKk2eQmOmBM1b2Cc7hszyLujfwFQdAe
nslDdDZSC3qrTul6DrDs/vAEj7C7GM0Bn3Dfs/hao3pySP7pV6hMNcIHxXL45INo
iZPBdJeMfcPOXy4jRFAZ/pBWCTAXr4fylnpmMKq6sAxAvl/Tn2Y49sdbgru4a0I2
xxbrEevXD2rFKslldhhHXdV364H02nwuzLJ2/Gf2/shH+fLOtpoCi9MRM/cGGFzQ
XuNY1Rk+iGRzLXNzfTortLiLS6F4PWbHmjRZKomkGMhUfh2I1Mo=
=JOQM
-----END PGP SIGNATURE-----

--=-IEhZ6WZTvxSKFGCIXKgP--

