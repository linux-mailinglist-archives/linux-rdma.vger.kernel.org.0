Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 760D285498
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 22:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389310AbfHGUpI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 16:45:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389167AbfHGUpH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 16:45:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8AEEF85540;
        Wed,  7 Aug 2019 20:45:07 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-53.rdu2.redhat.com [10.10.112.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DC7260BE1;
        Wed,  7 Aug 2019 20:45:06 +0000 (UTC)
Message-ID: <c216167668414237b37ab8f9a286f5d1ee1ad61d.camel@redhat.com>
Subject: Re: [PATCH rdma-rc] RDMA/counter: Prevent QP counter binding if
 counters unsupported
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Zhang <markz@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Date:   Wed, 07 Aug 2019 16:45:03 -0400
In-Reply-To: <20190807101819.7581-1-leon@kernel.org>
References: <20190807101819.7581-1-leon@kernel.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-zE9a4x7KDqNcJBJpohSD"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 07 Aug 2019 20:45:07 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-zE9a4x7KDqNcJBJpohSD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-08-07 at 13:18 +0300, Leon Romanovsky wrote:
> From: Mark Zhang <markz@mellanox.com>
>=20
> In case of rdma_counter_init() fails, counter allocation and QP bind
> should not be allowed.
>=20
> Fixes: 413d3347503b ("RDMA/counter: Add set/clear per-port auto mode
> support")
> Fixes: 1bd8e0a9d0fd ("RDMA/counter: Allow manual mode configuration
> support")
> Signed-off-by: Mark Zhang <markz@mellanox.com>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

Looks good, applied to for-rc, thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-zE9a4x7KDqNcJBJpohSD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1LOE8ACgkQuCajMw5X
L93uhBAAs5slzPhhjE7mjpk2Qn7W4jDxn+7CurAVQ8P91MPHAIEt+FiM5lj2Dqjn
C2Pu1ltx21G8PDpjz7QwgF/OBuaFJYw1Gfhvrm7Kn+u9n3EAjkDu/4dCQ4xBWU5U
zJ80O2hdhwzFcaQZNgHHP4UhZmgyY/MjUe0G0rWE/078JYqZx2SFXsAc7Thyx55r
bSY56Ka6/ikGrZzDHKzqq7Di0u6Rzbs9kPKpNqpjvdHv5nMb4vQOoeDf28Qb3sAo
qpKYrNaE23PNICOHafrFaJfGyHMeJBqfx9fpHUHnmRy8xR/CNdAoYoGtPVg9HzoH
oe++032w9HZJLIAVkMMLWAdvc+zqoyHjF4XAQ+k7/sXj3zZwcF3gteZ6qyWHRNSq
tAJKXw3hFiTeRHwhaNnDz1CeY5wPhrfq8SX5I4IKIrQ8x5RG+zGnNCn49657LcyJ
UsRnuW5cfQHhvToVym3yyXSzqeQgCXcaMwbsG2SVxVbl8GhjnvgUlTDQS5d/wN7g
vuxL/BC24AKk3CRRvWMuqd0t9k3D23NATkRF4OF5VI9hrOIH2WmM6Z8eBSLfoMpT
EqyH534s+sUpmnP9/SdCOnTFy5VBeJPOwnerblmLEad0GIdhx9FPDCIpTnccannZ
qRLZD1yky1WTVqYCdrO3B0OIHuC94inT/OWA8/Gd6rzf5bQta1E=
=l+vo
-----END PGP SIGNATURE-----

--=-zE9a4x7KDqNcJBJpohSD--

