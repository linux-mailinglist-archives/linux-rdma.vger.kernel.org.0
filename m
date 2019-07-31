Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 906E97C7AE
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 17:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfGaPy7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 11:54:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfGaPy6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 11:54:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F2A14E93D;
        Wed, 31 Jul 2019 15:54:58 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 656975D6D0;
        Wed, 31 Jul 2019 15:54:57 +0000 (UTC)
Message-ID: <ccc04779d78c8856f3dd3ef57299a59df5686bc3.camel@redhat.com>
Subject: Re: [PATCH][next] RDMA/core: fix spelling mistake "Nelink" ->
 "Netlink"
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Colin King <colin.king@canonical.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 31 Jul 2019 11:54:54 -0400
In-Reply-To: <20190731082837.GO4878@mtr-leonro.mtl.com>
References: <20190731080144.18327-1-colin.king@canonical.com>
         <20190731082837.GO4878@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-TiHXGszeHh0v77g7ujL8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 31 Jul 2019 15:54:58 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-TiHXGszeHh0v77g7ujL8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-31 at 11:28 +0300, Leon Romanovsky wrote:
> On Wed, Jul 31, 2019 at 09:01:44AM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >=20
> > There is a spelling mistake in a warning message, fix it.
> >=20
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/infiniband/core/netlink.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
>=20
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

Thanks, applied to for-next.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-TiHXGszeHh0v77g7ujL8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1Buc4ACgkQuCajMw5X
L93xDg/+L2blb3qy7x0h7UHlovEAcdgNtq8TTtGnS51i2gGaE0uLdfLC6JI7ohJJ
SdeGHdxhrSRSeS0SbT1Q865JcmWlpt0fUpC109bAS78fhtsH/7ySJ1cKrZpCdCi3
M/U7cGXKnZcdSqwBKYBpDzMQZzugOl5Q2tvRYeFv+8wuTFp7WReexDaZWeA0hEH9
eOzsCHp4kR4/x4hIZw/feI4oAuI0MZtYawIqrR75Zj0JzXwWz1OpHMx0qJe58+cB
N2lysGUmzgnID3iJXDKDmx1tWP4+d2WYFJ1Keeo9DhgcaCGBjuMmfW07LL0e2zou
zuId8Xe5GwdOLpAIESPB7D+lANfVZpsJSDx+ge1x6gzQollIjA0bBnjds+28Z43G
SEgbDmZSmhedEUiE/GnkJcQJxMKVE1bOD5RtcodqKmq1Vc4UCAK6oABE2peVzqSI
3im0kHf26dvknZXh77ews4U5qIRERxLPDycGb8EuRvAe7yiF3G61qCKeeiTreDXH
IIhjxPeCOhgpHh2WYSIyWZceWuZNnIx7e0UL9qvoYX+MnssfJdT7PoVgIZPRSxaX
ifjk/AD79B1K6RpqdsrnyzGhmM6GCllsSPpR1kVlBn/pNqC8FIe3Jt5o0W86hh1U
306tkS3oABmJyTLiW1TcrNMuAiJj5nFLeWxAzE28A1Mf6+HfBcQ=
=inNQ
-----END PGP SIGNATURE-----

--=-TiHXGszeHh0v77g7ujL8--

