Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B80CD854A0
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 22:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbfHGUrt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 16:47:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730045AbfHGUrt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 16:47:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A8A6811D8;
        Wed,  7 Aug 2019 20:47:49 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-53.rdu2.redhat.com [10.10.112.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E2275D772;
        Wed,  7 Aug 2019 20:47:48 +0000 (UTC)
Message-ID: <a9cb1d33ec5c7d30e044c331d351a6495305f2e6.camel@redhat.com>
Subject: Re: [PATCH] IB/mlx5: Check the correct variable in error handling
 code
From:   Doug Ledford <dledford@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Wed, 07 Aug 2019 16:47:45 -0400
In-Reply-To: <20190807123236.GA11452@mwanda>
References: <20190807123236.GA11452@mwanda>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-QKp/f/v2t+6NumgNjUwF"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 07 Aug 2019 20:47:49 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-QKp/f/v2t+6NumgNjUwF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-08-07 at 15:32 +0300, Dan Carpenter wrote:
> The code accidentally checks "event_sub" instead of "event_sub-
> >eventfd".
>=20
> Fixes: 759738537142 ("IB/mlx5: Enable subscription for device events
> over DEVX")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-QKp/f/v2t+6NumgNjUwF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1LOPEACgkQuCajMw5X
L903jA/9E4n/DIgJE5MbY7snCWoJibwzvy+Kc3vC4t2MoS8lORuLU9+rRCX1RqEP
acQKazYsac4TKv/SG7MgDWYbd92qqiHLfuIgUzLbAxgzyEUeY09ET+EolCZTwPAH
d+vk1tAyKaBaJu0WLgZ5r8/XimPwVGBvxmmZRar1DcyGnK1WySXXjj9qb2US6aCU
YVTxVhQ22vB1aVZ66fOPq6It2GGaTdLChz0iChTgaP9AldSirzbvsrDt+QGTzzPa
BIJ0civiFRRky8Jt1OGjVprkMo4BNTY1BYxOjppdDlI4sowMhNpIuyIgmFWnv9sW
fqNaYiEhsEAfM1wRcv5apImpgNJmaLhnGqHHQRYS6l2ykB1n+JpTunqYYW0EtjBV
7Sni7E47fTjpPi19mTfRLfu80yE1+y/FjRnwPvKAEXg92gsZbUsy4bZf9lRHu5VJ
8mh4XA2Xmql3ReOn3i7Q3/Ke7nNpPGF0GxkDATaxQm8kLqxXVdqCJxghfp+N++As
mvWpmpsCymGpl1K5Kw0qMasKm2YLtoWiKoyYVyjTvB1bzyE2T+GtrgNoMtrciDUp
npE0e9Ser099L7ZGekeU6nGdLXZEPZUutl/GDm3/uDfYk+fitsNtEStimtyUCSkd
3fpiuZYWd0M8KKUFP9/4A8dcMB9QTnwwnWQUNPouDfxsuxzkl5I=
=lqiY
-----END PGP SIGNATURE-----

--=-QKp/f/v2t+6NumgNjUwF--

