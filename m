Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE8CE7CC69
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 21:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfGaTCy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 15:02:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbfGaTCy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 15:02:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25EC9308218D;
        Wed, 31 Jul 2019 19:02:54 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6885C5D9C8;
        Wed, 31 Jul 2019 19:02:53 +0000 (UTC)
Message-ID: <228e70ccaae68ccf4e55af4bf3313c717a095dd0.camel@redhat.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Remove DEBUG ODP code
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
Date:   Wed, 31 Jul 2019 15:02:50 -0400
In-Reply-To: <20190731140845.GA4832@mtr-leonro.mtl.com>
References: <20190731115627.5433-1-leon@kernel.org>
         <20190731140845.GA4832@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-nu58QWGOxPX4TBjr3TlH"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 31 Jul 2019 19:02:54 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-nu58QWGOxPX4TBjr3TlH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-31 at 14:08 +0000, Leon Romanovsky wrote:
> On Wed, Jul 31, 2019 at 02:56:27PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >=20
> > Delete DEBU ODP dead code which is leftover from development
>=20
> DEBU -> DEBUG
>=20
> > stage and doesn't need to be part of the upstream kernel.
> >=20
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

Patch, with spelling issue in commit message fixed, applied to for-next,=
=20
thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-nu58QWGOxPX4TBjr3TlH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1B5doACgkQuCajMw5X
L93f7g//elsk2UzZsOFZklqVflK+pQBtKrt5dWgfVevOC9F46Mbx9wbY/GK23HI3
VudosoDN0YgZVJLW1HV04J+fvu6ZAKNLij/Ltw78+pYSMiWNYVBQ+ljjvuOaCIZ6
SpfLTfTsgfUkBV3ymLdWBq4xOaZlzQNLXXVat2CxoQ+Avu7EwVzGxiXQ01cOOh3K
VAXg0rj0OjUMY6oUEZqYNArNj7RR6ODR1/8mS9OUDsD18jl/tGpu4sCnYdlWAbVR
CfYYKScyBOjIuN94D7P2ENWl1YrWlmndgHZ9aAgSey3pnulHbQedVSQyviMLSP22
lizI88B20LopLzmnU8oqaZXSQqmkWrx/9ZTpugk6soqsuOU7zGAAhoPIv0Xcc5Yi
XiAaxawpppgQRDvebG7vF9daBKIyMb5G85ZJ3en2ApbuAIA7LKJD5Urt1CfiJURH
yow2NXIn+q3tdZLVEI7WXeWk9Wk9XCJPy5HpbbAkAplfUrrDK+fShuGbwPh7ylZb
h05qhqU5KW0YbNayBP1zzcFJa3oAMNFZhZHGBK8a8jf/alCZFoUIebEko/xYIAoz
JDVkXnJERS85Nsx//Pja32WvLPof9kvCw8jvJnpFZOCPMbgwKccjhtwfJxfDl7SE
xP/2qnANEaVZpXKe8a76kaNWyC54RX7ovhVTVvvKSzTndGDUbvo=
=hJbn
-----END PGP SIGNATURE-----

--=-nu58QWGOxPX4TBjr3TlH--

