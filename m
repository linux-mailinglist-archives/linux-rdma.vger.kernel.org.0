Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCB6DCEBE
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 20:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394841AbfJRSwn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 14:52:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfJRSwn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Oct 2019 14:52:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F1EC693CB;
        Fri, 18 Oct 2019 18:52:43 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-37.rdu2.redhat.com [10.10.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A9565C1B5;
        Fri, 18 Oct 2019 18:52:42 +0000 (UTC)
Message-ID: <e04b1d8cb6769fb9bca59182eed066142f87c42b.camel@redhat.com>
Subject: Re: [PATCH for-rc] RDMA/qedr: Fix reported firmware version
From:   Doug Ledford <dledford@redhat.com>
To:     Kamal Heib <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>
Date:   Fri, 18 Oct 2019 14:52:39 -0400
In-Reply-To: <20191007210730.7173-1-kamalheib1@gmail.com>
References: <20191007210730.7173-1-kamalheib1@gmail.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-lSM2wIwmHzw+nperXWau"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 18 Oct 2019 18:52:43 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-lSM2wIwmHzw+nperXWau
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-08 at 00:07 +0300, Kamal Heib wrote:
> Remove spaces from the reported firmware version string.
> Actual value:
> $ cat /sys/class/infiniband/qedr0/fw_ver
> 8. 37. 7. 0
>=20
> Expected value:
> $ cat /sys/class/infiniband/qedr0/fw_ver
> 8.37.7.0
>=20
> Fixes: ec72fce401c6 ("qedr: Add support for RoCE HW init")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>

Thanks, applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-lSM2wIwmHzw+nperXWau
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2qCfcACgkQuCajMw5X
L92AIw//ZgaDbeKQ2lPY65dkmgaO+XB9jN+X8Tw++FgcLKz7wXZy16Oq2k+BIWsJ
qrSUogX3zuHwGuPWGVkb2mQtPQrHLG1xFDaYMmNnTT0ICWuGr0f4pykgWACQ3dEX
3Gk+9CAjlOKx/wZpLlmAWfeC5ms4bAu95cKOuv2uZg17yICnTTRqql/OehcRCFQ9
XqLStiFD0hvbpB1vvRIs7qF7pNkEpwKNq9rRCkFZB4NogO9hDtbxA16tf4I0p9GT
X/qlGeAVHKTRZ0/6+2BsoYNzU94XM397vnWKgoXPmTB3hZCCq8voEUHRl7tXBmSJ
Zat6sNS5RdLE9QsPvfFrEEc6dAt9fi9XW3H5QZTLjZsn67uGgDWuI0eoJjiBRSu9
t+gA/otuibq0+E+LR1c3NV4mxA1Y00fGS8bO8gKGUPaVibM6yirn/jzRX2mF2wHA
vNcwlxMaI8w9lUgsO1T0yJXkJ9Bb12woeGKHk0Z2vNFI0IljYw8OhsdFSjSmzWM5
QqUlnXP0rxJL38rAI/aJEFzfE6untYVreESYwPAD9+1/An99TLHpnuvnyHAEQDCs
d5eFDxFaoLMFInLZ2SSNSUKmSBVgR00CfdzGrDfwSBUoVCj/n/x8y41/CeUQeEE8
ZBZpAFZ5DK/oJNtQ0HLuT+4GzxdYXj8qypYc0+Hio5EuCUvx5Fw=
=z1DA
-----END PGP SIGNATURE-----

--=-lSM2wIwmHzw+nperXWau--

