Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A15511D7FB
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 21:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbfLLUkb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 15:40:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26194 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726814AbfLLUka (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 15:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576183228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/txWHtOS7CYUGVWLtw//Sh6pvKk2GHMB8GVwnPHT7Dk=;
        b=P0JB0fFXvNf4fxWsejPVXDQ42uQxXtAIMmyDMv+zrT3hS0sZnXKNmiW11tyzngWoPYSJh7
        08heYchp3LBBCSisseEAWyWnTQpUJsvRcjyYEfEmN+Ehe8Z1BqFhAlDxZqHnPuaoVVFXWP
        I+xd9mSwULELEDUSBXJiDBXbX2d6SRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-8vkFRiCzPMytfe9J1vL0qQ-1; Thu, 12 Dec 2019 15:40:25 -0500
X-MC-Unique: 8vkFRiCzPMytfe9J1vL0qQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A8B48024E2;
        Thu, 12 Dec 2019 20:40:23 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-42.rdu2.redhat.com [10.10.112.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D03725D9CA;
        Thu, 12 Dec 2019 20:40:21 +0000 (UTC)
Message-ID: <272765b9a22aae90e33dc4c560e0f50adbb945c6.camel@redhat.com>
Subject: Re: [PATCH rdma-rc 0/3] Fixes for 5.5
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Eli Cohen <eli@mellanox.co.il>, Ido Kalir <idok@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Raed Salem <raeds@mellanox.com>
Date:   Thu, 12 Dec 2019 15:40:19 -0500
In-Reply-To: <20191212091214.315005-1-leon@kernel.org>
References: <20191212091214.315005-1-leon@kernel.org>
Organization: Red Hat, Inc.
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-DcqxJ9up6S0Th7PyEUK3"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=-DcqxJ9up6S0Th7PyEUK3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-12-12 at 11:12 +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>=20
> Hi,
>=20
> Three unrelated fixes packed together.
>=20
> Thanks
>=20
> Maor Gottlieb (1):
>   IB/mlx5: Fix steering rule of drop and count
>=20
> Mark Zhang (1):
>   RDMA/counter: Prevent auto-binding a QP which are not tracked with
> res
>=20
> Parav Pandit (1):
>   IB/mlx4: Follow mirror sequence of device add during device removal
>=20
>  drivers/infiniband/core/counters.c |  3 +++
>  drivers/infiniband/hw/mlx4/main.c  |  9 +++++----
>  drivers/infiniband/hw/mlx5/main.c  | 13 ++++++-------
>  3 files changed, 14 insertions(+), 11 deletions(-)
>=20
> --
> 2.20.1
>=20

Thanks, applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-DcqxJ9up6S0Th7PyEUK3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl3ypbMACgkQuCajMw5X
L90PiRAAu67XcXWtAPOshahwgeE/Hj8ebsh9qtmFGu0FHe2M8SjPz9cfo0KC60m3
d2pGm5UgnYugc22xhS842+dNB2zzPI7WymMO+Hd6K7GvblBNp2MV/4188zoMKwSU
uvuxdt6G4FyY+ylT6hV0R11dlDuTL5Ehx0Tz5Bh7f73a+kTqDdDM/Oz6nXleCKT3
Pwm1WQJZA/uhL350XQOWxsmbq55lFj1JTGlMD/zlbtPQlYwsEtKOyYdYmBVIU4NX
2IF24omv4Q5bLCIOoZaYgg4dclVxNm4D7zgPHi7DYE+aHKqyeACgIg73r7NvU3t/
5l7kooitW/of9JViW73mFEdlHtfHA46l6GN0PywHAhvjZ73VGQPHyy4A5URcPLIM
2F70kAkOO9XbAUYan+FFVNLqxR9X5iU63hH7ehOWYtxQDrUc2/Yd8YnBqDZq35/r
OI3FIxIDtm62ibrCHmE3vRkmmV5alU1BN00A4gtkYkunq8GdJrZtsPuu6290+Exe
T5SUdyzMwJoYmzXQnM2G/AO/u2LFsLKLMP1dFdigUEWZRFXwdZPvTC5pN0nWQX8x
uIrTiI2wszUJacDk0UndOsCd6CkhnYSETBb1DKl8WIvkIq7RjKO/g9+ruRrg/SkT
wXpvrnPsO2fN+aV9nHxR44ZJjg/bQo0IlbHQEt3YvsXtlYrQULY=
=cDqp
-----END PGP SIGNATURE-----

--=-DcqxJ9up6S0Th7PyEUK3--

