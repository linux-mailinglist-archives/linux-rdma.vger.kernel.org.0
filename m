Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C38E7DF71
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 17:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbfHAPut (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 11:50:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfHAPut (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 11:50:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F1663335CA;
        Thu,  1 Aug 2019 15:50:48 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B853F19C70;
        Thu,  1 Aug 2019 15:50:47 +0000 (UTC)
Message-ID: <61ecdfd04611ec9460b7675680b57a6e8d0d7919.camel@redhat.com>
Subject: Re: [PATCH rdma-rc] IB/mlx5: Fix MR registration flow to use UMR
 properly
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Guy Levi <guyle@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Date:   Thu, 01 Aug 2019 11:50:45 -0400
In-Reply-To: <20190731081929.32559-1-leon@kernel.org>
References: <20190731081929.32559-1-leon@kernel.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-krk3EhFJ7dOSTDwfpqTU"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 01 Aug 2019 15:50:49 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-krk3EhFJ7dOSTDwfpqTU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-31 at 11:19 +0300, Leon Romanovsky wrote:
> From: Guy Levi <guyle@mellanox.com>
>=20
> Driver shouldn't allow to use UMR to register a MR when
> umr_modify_atomic_disabled is set. Otherwise it will always end up
> with a
> failure in the post send flow which sets the UMR WQE to modify atomic
> access
> right.
>=20
> Fixes: c8d75a980fab ("IB/mlx5: Respect new UMR capabilities")
> Signed-off-by: Guy Levi <guyle@mellanox.com>
> Reviewed-by: Moni Shoua <monis@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

Thanks, applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-krk3EhFJ7dOSTDwfpqTU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1DClUACgkQuCajMw5X
L90ibRAAlJSTpaWuoRFcH8wy5jgonZBSQuw0nisyjj8N0dA9NAc7ONRgPHXTWhXr
GdNssasaUNdFnUP9/Hs5NW4+OemtM4RKN/PqOmzUM2koJ9ah0LfElTLYTaIV1fM5
xe5q6pCIa0FXsf0m9qzhyCPm5UyrxgvdgoqIvdDwDH8xqAOOpOWj3gisz3EVxk0F
vC+tTzfrlC8ES5/PGpOQL6UlMOrSao68Bbqic6LHnONmAlLGIlhKeUy9HusyNOpx
/N7isxe4wb7EyOTE09jdxi6jDBRrYyyM1FN7IUcDQ/TJSdngtTo0cRA+buo+0Vx/
VJqqlZXwlHuJDQZmB+xCMM/4j1eMZS/GClVItCDqxn7p9A6wW0/edqFNGVoUUvDV
PeOKuWRvTOZ2xiudv7GXVXyCYvfgvEtzdjOPdlDmg0+lxDzCA+Uc3I2pqCmhPiQB
oQo9+UKdm4ypdTEyqfmWvhbGCl2/5j8qgbWFKX/OlwJiDM8/zku/0kZUYk4jzrlX
kkSX50LJAHx76D/oFRVCWS0yXpKADJdWmSIAQFLc/7UdnaRmgv0UmxA0i6ksPna8
px29WStf+1g6Pf4r+n8sdsPWqNmz8MpOC4e9NblONHhf8qF+uT7aVJBd4d1FAdNS
QE+pjvD8+q0iAZuJ31bzXNjIoL5ppq7iE0OQfSFFNrzcHskmihE=
=Jj89
-----END PGP SIGNATURE-----

--=-krk3EhFJ7dOSTDwfpqTU--

