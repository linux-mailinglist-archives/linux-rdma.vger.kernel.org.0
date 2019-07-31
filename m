Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5C37C747
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 17:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfGaPrv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 11:47:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbfGaPrv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 11:47:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 838C73091754;
        Wed, 31 Jul 2019 15:47:50 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A6FC660852;
        Wed, 31 Jul 2019 15:47:49 +0000 (UTC)
Message-ID: <742cfa9cf055225e73237ef21a5858ec442dbcd8.camel@redhat.com>
Subject: Re: [PATCH rdma-core] srp_daemon: check that port LID is valid
 before calling create_ah
From:   Doug Ledford <dledford@redhat.com>
To:     Sergey Gorenko <sergeygo@mellanox.com>, bvanassche@acm.org
Cc:     linux-rdma@vger.kernel.org,
        Vladimir Koushnir <vladimirk@mellanox.com>
Date:   Wed, 31 Jul 2019 11:47:47 -0400
In-Reply-To: <20190730105455.15080-1-sergeygo@mellanox.com>
References: <20190730105455.15080-1-sergeygo@mellanox.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-LyXnVDbKXu+TQaSHicBe"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 31 Jul 2019 15:47:50 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-LyXnVDbKXu+TQaSHicBe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-07-30 at 10:54 +0000, Sergey Gorenko wrote:
> From: Vladimir Koushnir <vladimirk@mellanox.com>
>=20
> The default LID that is given to the port is not valid (a valid LID
> value
> is > 0 and < 0xc000), so in case the port didn't get a valid lid from
> the
> SM there is no need to call create_ah.
>=20
> Signed-off-by: Vladimir Koushnir <vladimirk@mellanox.com>
> Signed-off-by: Sergey Gorenko <sergeygo@mellanox.com>
> ---

Thanks, applied.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-LyXnVDbKXu+TQaSHicBe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1BuCMACgkQuCajMw5X
L93CqQ//cE0NUQ4xSLiUN3eOwlyvlVW8/64pzhsYuN2CVc89s5WRzaNkbXPP/1ZA
0zsNL22Qgfiyz5hsrBDDctn05uNNwfKLRnXHBk6f5aABQ7ZPTrStRbBBnTNaqqsJ
GtGXEbon/pB59ZHnUkXLsajrr+jZytvnKo3PqD7D+EMXuduNmpx5iqw3RZ8AbJXh
CrPSdRJTqvhUTrabgoRLaIp5tsPfHlwrEE9PGLnmJ3NfEKNOSO0ShSpE9gR6lNYP
Nm2EpUnWcfkw2ioDfvklg1DH3ziGokXbsWQG375D8tNk796t0RfsmSbuNqnoLWoS
yRHZ386P6VMyGFbVpYVPZZnRQe8sJ2DwtusWGjJPEkVymgm2QylJ4wQRLphtfN1p
svzpUnFFSIKEd8J+4gbBn6OH1L5MFskHg5aUVp7VoGQzaXzPmeIs3NTjcbQPkYYt
po/zpOv3MTvrimNa+Y2GaL5qQ9HtBcsrwbtl/YDVh7vJsB83kYUBF2DMTSgtLFRu
yiwyeITZmW9+lAVhkkHwOyYeL8ZjmqrryRhBEDw5+Y1l0pLSFKj1BNQ6fOAX/WIw
qnruHgRtzAfkXKbGvzs0UHbTLO4xn0TtX86o39a5775BXsMWqxZYDmgBjP4NfvuQ
pxunGnOueocXtiFdxvwMsIArGR1TWGl0Ecc01EgS2XYtoy/ifm8=
=2t5/
-----END PGP SIGNATURE-----

--=-LyXnVDbKXu+TQaSHicBe--

