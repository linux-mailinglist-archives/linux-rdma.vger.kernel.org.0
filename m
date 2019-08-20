Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B512967FE
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 19:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfHTRsA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 13:48:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42513 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbfHTRsA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 13:48:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98A4A772C7;
        Tue, 20 Aug 2019 17:47:59 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DFAB227CD2;
        Tue, 20 Aug 2019 17:47:57 +0000 (UTC)
Message-ID: <c3fa211d433088fd5384126888162d2568c39c2f.camel@redhat.com>
Subject: Re: [PATCH rdma-rc 0/8] Fixes for v5.3
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Ido Kalir <idok@mellanox.com>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Moni Shoua <monis@mellanox.com>
Date:   Tue, 20 Aug 2019 13:47:55 -0400
In-Reply-To: <20190820173812.GI29246@ziepe.ca>
References: <20190815083834.9245-1-leon@kernel.org>
         <a263ac8f6c8340f050ca28394361aa956ac94cb4.camel@redhat.com>
         <20190820173812.GI29246@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-bwhY7odoOZoMk2wDcUMX"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 20 Aug 2019 17:47:59 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-bwhY7odoOZoMk2wDcUMX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-08-20 at 14:38 -0300, Jason Gunthorpe wrote:
> On Tue, Aug 20, 2019 at 12:56:37PM -0400, Doug Ledford wrote:
> > On Thu, 2019-08-15 at 11:38 +0300, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@mellanox.com>
> > >=20
> > > Hi,
> > >=20
> > > This is a collection of new fixes for v5.3, everything here is
> > > fixing
> > > kernel crash or visible bug with one exception: patch #5 "IB/mlx5:
> > > Consolidate use_umr checks into single function". That patch is
> > > nice
> > > to have improvement to implement rest of the series.
> > >=20
> > > Thanks
> > >=20
> > > Ido Kalir (1):
> > >   IB/core: Fix NULL pointer dereference when bind QP to counter
> > >=20
> > > Jason Gunthorpe (1):
> > >   RDMA/mlx5: Fix MR npages calculation for IB_ACCESS_HUGETLB
> > >=20
> > > Leon Romanovsky (2):
> > >   RDMA/counters: Properly implement PID checks
> > >   RDMA/restrack: Rewrite PID namespace check to be reliable
> > >=20
> > > Moni Shoua (4):
> > >   IB/mlx5: Consolidate use_umr checks into single function
> > >   IB/mlx5: Report and handle ODP support properly
> > >   IB/mlx5: Fix MR re-registration flow to use UMR properly
> > >   IB/mlx5: Block MR WR if UMR is not possible
> >=20
> > Hi Leon,
> >=20
> > I took everything except Jason's patch to for-rc.  He had tagged his
> > patch in patchworks as under review by himself, mainly because there
> > are
> > some conflicts with other hmm patches I think, so he wanted to
> > process
> > all the patches himself on a distinct branch to resolve the issues.=20
> > Thanks.
>=20
> Ah, I thought that got grabbed alread

I assume you meant to when you bumped for-rc to -rc5?  Evidently, it got
missed ;-)

> Can you take it but rebase it to be the first patch on top of v5.3-rc5
> in the -rc branch?

Sure.  You can get your branch head by digging this commit out from my
wip/dl-for-rc, but just for ease, I also pushed this patch as the head
out to the official for-rc branch.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-bwhY7odoOZoMk2wDcUMX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1cMksACgkQuCajMw5X
L92PrxAAnyZ2+mal+PMwlRnZ3VLWiiwZZnVWKb8OXAGXWEaAcCWtK7S8pB6X51Ff
qZYyO3SgQ8+Ciiopm2Rj2fdvIQtuPFE7YHxGk45VHdHdk+HVlCIUg6yjuDOSRmX7
G1FIPolTmgAkNz7x6GTOtLPKQb+Key3qp8pcEOqRrfCmMBYcR89JctEqpPTGF2ep
S9/97l0TRCufk87icdQ/5UABoRu+UyhIawgzVuavoPlfDSviPmFjaN4JW2D7jvgL
+rfu7fo4mHZCds33pp8HGf8W+n7CMJtNUjW4RBRoSEyVJYZPagTSeeAb7JHuQwtK
AY0096mCBMApJFVQwpGbuqcTc/SqPDmKyedyNaTgBw68ANiQPswZY+mnX+2qOt06
t/8wAntrGx2TJccdyisawfyXKz1DTYh9w0awbiLp0v2Ri7Vspnlhguxgw8h6boJU
BoZY+0bWyM1b9ljNiin371/YP/uJyIjV+Ou8vCc4HDwVjTOeRPr23R1Qai9tll3V
TZ8XX2anEihHcmox+yENE29fowbA24yl+dKEt2JY6liwogh4Kt1PFrvK6PHml47Z
W6guas4L4vCn4TN9vyYHoh/dg49OaoGV01SxCII+ZRgfFFYdvIY3OCNwn6B6p8Tv
1RpX3qhvkqQW1Y1SMN78C9Hcw539fDuwIvp8sk7FlgRd1iEsBPM=
=sORh
-----END PGP SIGNATURE-----

--=-bwhY7odoOZoMk2wDcUMX--

