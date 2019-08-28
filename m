Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2A2FA0520
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 16:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfH1Oia (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 10:38:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfH1Oia (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Aug 2019 10:38:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 379F83018ED8;
        Wed, 28 Aug 2019 14:38:30 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E5BA60610;
        Wed, 28 Aug 2019 14:38:29 +0000 (UTC)
Message-ID: <31789d5f705c7907f161be598552d013f0ea202d.camel@redhat.com>
Subject: Re: [PATCH v3] RDMA/siw: Fix IPv6 addr_list locking
From:   Doug Ledford <dledford@redhat.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, jgg@ziepe.ca
Date:   Wed, 28 Aug 2019 10:38:26 -0400
In-Reply-To: <20190828130355.22830-1-bmt@zurich.ibm.com>
References: <20190828130355.22830-1-bmt@zurich.ibm.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-OchvXjnfJancbAuw5HTz"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 28 Aug 2019 14:38:30 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-OchvXjnfJancbAuw5HTz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-08-28 at 15:03 +0200, Bernard Metzler wrote:
> Walking the address list of an inet6_dev requires
> appropriate locking. Since the called function
> siw_listen_address() may sleep, we have to use
> rtnl_lock() instead of read_lock_bh().
>=20
> Also introduces sanity checks if we got a device
> from in_dev_get() or in6_dev_get().
>=20
> Reported-by: Bart Van Assche <bvanassche@acm.org>
> Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>

Applied to for-rc, thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-OchvXjnfJancbAuw5HTz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1mkeIACgkQuCajMw5X
L90ZiA/9HwLiETL8MK4cA3bW8yc91CkFeh/qXfyLM/aDQM4ZixLcCbGUgT07nXj/
tJ3wSAmRqsL6wHiel99Kg9KdC5u1i55Y31dyNgQsFmG2+Z143YxoX9O9fQD4qecG
msQAe8M1Wc83q6E1l8KpRQ+bk7h+T+Wd9ZXPTgh/c28T8OwgzA2joLl/jpO4TECT
QdSHoRoKqoU83+2MhqAD2/yaom2bJBPGD1GJXc+9dMnqCLXI8STKQ/11+GsEbYvT
/F097/N98FCIu494g7yJvP45jqLVAVtSrZBzBFbCXm6sL7EgKtnkT0ylxvc302iy
61XzmYutH1PtRw82Fp9ID3BolvTWJbuyO/bEGUyAKzap7OCfsVFZ4VbelepUYpjB
k+hP37vpFUcypcakWCxLE/Qu1BbJpTNawoCMkaqAnbB9RgVglP7Kl9wqMbjlU4e9
JQ3OX02smHG4C4S94w3c//+/iaMmZamzq96uTzvunMySuOJ6UkxBke8orGPudulF
sjP5uN18WUNKE9VrS3cHehtQstZaA/GeBSuQy9cJUiOYLSG4oHZRyfycM0UtTJgw
5Qrp628iBwxphdb6XiULIOVOc8NLeyKWtbsLN088y5mbp2G5ldC3otVbyYmW/849
F/4TzEfjgEDMN7xsWaDQH+gkaFmc+VHOZ7ek2txXkodozPdKlcs=
=WOtJ
-----END PGP SIGNATURE-----

--=-OchvXjnfJancbAuw5HTz--

