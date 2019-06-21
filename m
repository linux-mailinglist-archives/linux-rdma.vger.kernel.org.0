Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB5104ECA4
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2019 17:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfFUPzP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jun 2019 11:55:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfFUPzP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Jun 2019 11:55:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 28AB785541;
        Fri, 21 Jun 2019 15:55:15 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 679C060FAB;
        Fri, 21 Jun 2019 15:55:14 +0000 (UTC)
Message-ID: <412e99bbe802ee012bd0dc573d539b11089874bc.camel@redhat.com>
Subject: Re: [PATCH for-next 0/3] EFA updates 2019-06-13
From:   Doug Ledford <dledford@redhat.com>
To:     Gal Pressman <galpress@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
Date:   Fri, 21 Jun 2019 11:55:11 -0400
In-Reply-To: <20190613091014.93483-1-galpress@amazon.com>
References: <20190613091014.93483-1-galpress@amazon.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-CfuQlvCUpbo2Rp2cCY1d"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 21 Jun 2019 15:55:15 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-CfuQlvCUpbo2Rp2cCY1d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-06-13 at 12:10 +0300, Gal Pressman wrote:
> Hi all,
>=20
> Patch #1 makes use of Shiraz's new API including a fix to Jason's
> comment to check for zero return value.
> Patch #2 is a cleanup making the driver more consistent.
> Patch #3 adds more information to our error prints, which proved
> useful
> in our debugging process.
>=20
> Thanks,
> Gal
>=20
> Firas Jahjah (1):
>   RDMA/efa: Print address on AH creation failure
>=20
> Gal Pressman (2):
>   RDMA/efa: Use API to get contiguous memory blocks aligned to device
>     supported page size
>   RDMA/efa: Be consistent with success flow return value
>=20
>  drivers/infiniband/hw/efa/efa_com_cmd.c |  7 +-
>  drivers/infiniband/hw/efa/efa_main.c    |  2 +-
>  drivers/infiniband/hw/efa/efa_verbs.c   | 94 +++++++-----------------
> -
>  3 files changed, 30 insertions(+), 73 deletions(-)
>=20

Thanks, applied to for-next.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-CfuQlvCUpbo2Rp2cCY1d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0M/d8ACgkQuCajMw5X
L90bZg//eVPsP7dk+OL8rHqcG8vX9qnSFDwpKPe/UdMKUMUSl3hIf5xTUilV3nYF
xggSYnadsGHxcCUCMNYj7avpKLC4Nz9tkKYQ0OLHGUo1D63n7PWgGOBHlzEyjH5v
hUBp6O8VebVS0mzFgxWVCDp0ogpv7Rp0eFb/hLMxeyGgiAWs6rx/ean/vNaH/dgA
OrXgDxQVguEQIViIJUNK8/H3devXOa90UkMVVcntZ2iYdvNSrLQfr2N73OwnTUjw
fL78tR8EvqxohhSdeDBDNTqTYIYBgvaTzi+XxyawZ4lyjAvraPADvdG7r+dK+Ciu
0hL80Ce+RW5uZV+q2yVuAsmRl1WgesnBkyppRh+HQjtKRAS1NAVSzOHQxJByTasS
DAvMv0pqcbyYOHSormNtNG5Yobm1hq5Twi+pD2s+Gey+qCtjVcQz7NRqgeUP5+Rm
X7VDBKoklTXFyEytuk16te5NegE4cB7iJIdYdBzrVzLTeuaEvw4dtADSWmH1QLZi
OCNhDkIO6mf/lMRuzPsS1ODb4BHanHi4Oj1H0rGVIH2WTcnLwawdhv9j/8WDyGdZ
tXEC4C7pjEVdH923hteCEUWXPvFnZRXzKd+jyQL2rFbSVKYEOZ+rRfQ6q2wtmsyU
KNnP9JN7PhCdUmNOzsPYsWoXLtr6NYKY0tmx++4lMbe4RR0xNgc=
=1PQw
-----END PGP SIGNATURE-----

--=-CfuQlvCUpbo2Rp2cCY1d--

