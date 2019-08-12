Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0CC8A20C
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 17:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfHLPNp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 11:13:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfHLPNp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Aug 2019 11:13:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 103983082D6C;
        Mon, 12 Aug 2019 15:13:45 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-57.rdu2.redhat.com [10.10.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7607B80224;
        Mon, 12 Aug 2019 15:13:44 +0000 (UTC)
Message-ID: <c0652fa46c378c7eddf51c568c7e9ad4faed3a99.camel@redhat.com>
Subject: Re: [PATCH rdma-core 0/3] get more than 32 available InfiniBand
 device names
From:   Doug Ledford <dledford@redhat.com>
To:     Haim Boozaglo <haimbo@mellanox.com>, linux-rdma@vger.kernel.org
Date:   Mon, 12 Aug 2019 11:13:41 -0400
In-Reply-To: <1565540962-20188-1-git-send-email-haimbo@mellanox.com>
References: <1565540962-20188-1-git-send-email-haimbo@mellanox.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-xvyd2cTm6X0l2xKyKf2b"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 12 Aug 2019 15:13:45 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-xvyd2cTm6X0l2xKyKf2b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-08-11 at 16:29 +0000, Haim Boozaglo wrote:
> Hi,
>=20
> This series from Vladimir Koushnir adds the ability to get
> list of InfiniBand device names greater than 32.
>=20
> Thanks
>=20
> Vladimir Koushnir (3):
>   libibumad: Support arbitrary number of IB devices
>   libibumad: Redesign resolve_ca_name to support arbitrary number of
> IB
>     devices
>   ibdiags: Support arbitrary number of IB devices in ibstat
>=20
>  debian/libibumad3.symbols             |   2 +
>  infiniband-diags/ibstat.c             |  47 +++++++-----
>  libibumad/CMakeLists.txt              |   2 +-
>  libibumad/libibumad.map               |   6 ++
>  libibumad/man/umad_free_ca_namelist.3 |  28 +++++++
>  libibumad/man/umad_get_ca_namelist.3  |  34 ++++++++
>  libibumad/umad.c                      | 141
> +++++++++++++++++++++++++---------
>  libibumad/umad.h                      |   2 +
>  8 files changed, 204 insertions(+), 58 deletions(-)
>  create mode 100644 libibumad/man/umad_free_ca_namelist.3
>  create mode 100644 libibumad/man/umad_get_ca_namelist.3
>=20

Changes have been requested from this series before it can be merged:

https://github.com/linux-rdma/rdma-core/pull/561

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-xvyd2cTm6X0l2xKyKf2b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1RgiUACgkQuCajMw5X
L93lww//eReduki6sDhp5fZ1iVP+4IyTEXZ6qXqgoZa6IdUKlPRktjsdbhwpWHX+
taAPVAllwTagYstwAJPCzRtudyb3LQ+iFzWs8/IR7j+co2cS/g0onDZaGJXEzHX7
cY0cQx/8e012PQxLwsecXe7d4G/BOqM2b8g1dee+tWhOanl3VSnTp0p3qcz0IUc9
urlHynurBzgJ6/6srb837xc/tfigTbcSLAT7F0C1F7xfI/vY2SzgrRELic0resq+
bY69aJIFllejQBIlOF392vLrmq1iEMfJ9roMfU3i6jSr+17hSOoYXTHzLWrQlHP3
E2iuKF83hTbfRV1iCqQvoD5fWMSN5oommkC3ieX+QDX6CJYz3rWYVzjtS9NKg6jt
fQcIvENT/8h6X9luMntVMIYF2oRyKgfON6Cbk5ESeXrY1wkVrZkth6G5TJoieguy
rYYkuHwGRr4WqL42SHXfQ4qvS/Tk9BZ2iTUn+Y5SeBem59JrBSqmZIl9z69UDHYi
+bqeaHguX5GMuCAMWOUcrToXAHIbszX7oFU9omeKn4ONohd8KM9GLVc3mIj6NotZ
iNjGFchBeDaAr0YVzP+NB0jyRatNCKTRo7pbvtCRTAXdq0yxbMfLxIgJrwsE0Inv
R5/S8NShjqnIcAIweY1HiUs2F1MsNGmmA/HzwsuhlZo+vmO9o3Y=
=sBKi
-----END PGP SIGNATURE-----

--=-xvyd2cTm6X0l2xKyKf2b--

