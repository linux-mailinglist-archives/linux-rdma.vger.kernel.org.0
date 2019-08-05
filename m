Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B475582198
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Aug 2019 18:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfHEQWq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Aug 2019 12:22:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfHEQWp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Aug 2019 12:22:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4C91C05168C;
        Mon,  5 Aug 2019 16:22:45 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7C135C1D6;
        Mon,  5 Aug 2019 16:22:44 +0000 (UTC)
Message-ID: <756bae898c9480ceca2124378bd94ccdbdef84a9.camel@redhat.com>
Subject: Re: [PATCH for-next v2 0/2] Ratelimited ibdev printk functions
From:   Doug Ledford <dledford@redhat.com>
To:     Gal Pressman <galpress@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 05 Aug 2019 12:22:41 -0400
In-Reply-To: <20190801171447.54440-1-galpress@amazon.com>
References: <20190801171447.54440-1-galpress@amazon.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/IdSzUy5j2sa8a+qCyVZ"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 05 Aug 2019 16:22:45 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-/IdSzUy5j2sa8a+qCyVZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-01 at 20:14 +0300, Gal Pressman wrote:
> Hello,
>=20
> This implements ratelimited ibdev printk functions, similar to their
> dev_*_ratelimited counterparts.
>=20
> I've submitted the first patch before [1] without usage, I'm now
> adding
> the corresponding EFA patch as well.
>=20
> cxgb4, hfi1, mlx4, vmw_pvrdma, rdmavt and rxe could also benefit from
> this if they move to ibvdev prints:

[ snip ]

Thanks, series applied, and now the other drivers can convert to ibvdev
prints ;-)

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-/IdSzUy5j2sa8a+qCyVZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1IV9EACgkQuCajMw5X
L90lWg//RITBG/Qf/M3OSf7Tm+F1NXYuomLIGisQ1KsASsOdZ+XQWLInHA8cmXJy
x2yzt1zdSngpexUdLuaMTT+ZYkusC/fjOzxJ9DLOx2AV2ph+BRWQ4beJbBpiIPVL
XEhBPApLTbWfRPUs//10+cbRpBurcx4DF6yESE20Evc/YixvOnKoRPgAjsKqX9VC
crztoPJt9wwrdimfjhGx0H3/k+YZam8rYHNeR9A8G/hAg5FGRGrpKH7W944XL8Eu
7gYcXzsWWRO4uylglXDFWxcfNLRymYQLbVKANjuoeLUCEnbRqJ1W+BtfN4AmhNxZ
PfPGrbRFfxkVZhbSqAgYLCmvDJacxbde1m7vElzXRwQc8DwIv8U33ixu5uPnlNKx
wTxcotxi4xqo2Jg5fojwHvOS1zog3ST9peFk+SkYvOWMZUkij81QklcpcHG2erQc
2hOrq3wMN0qEeGNUVFpNCO91rUx1Lm9a1Wg3M5SXsLGcnos1PEM0pVYVcdEhS5Pr
dj7aVvGsxQGIgDqhrUqo9NWqy+yEofoMrVi6d/YZmWlPy2ZRLS8eqNSQm1Ai/bT0
Id/CLBLbURct8EL/ckGXfUjRalsnVki5ZUa5EE+ZLnxPy+ffww0aO2FH0MRzapeK
yuSZ6A0xNdZrbXq40bo3NDoM9N8P8PtZ6tdM3kD2dVBr7NAh0/4=
=DTcR
-----END PGP SIGNATURE-----

--=-/IdSzUy5j2sa8a+qCyVZ--

