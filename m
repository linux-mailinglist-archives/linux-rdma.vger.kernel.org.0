Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B066C85424
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 21:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfHGT4c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 15:56:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729976AbfHGT4c (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 15:56:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 202DE3082B13;
        Wed,  7 Aug 2019 19:56:32 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-53.rdu2.redhat.com [10.10.112.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5335600C6;
        Wed,  7 Aug 2019 19:56:29 +0000 (UTC)
Message-ID: <70ab09ce261e356df5cce0ef37dca371f84c566a.camel@redhat.com>
Subject: Re: [PATCH for-next V4 0/4] RDMA: Cleanups and improvements
From:   Doug Ledford <dledford@redhat.com>
To:     Kamal Heib <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Moni Shoua <monis@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Andrew Boyer <aboyer@tobark.org>
Date:   Wed, 07 Aug 2019 15:56:26 -0400
In-Reply-To: <20190807103138.17219-1-kamalheib1@gmail.com>
References: <20190807103138.17219-1-kamalheib1@gmail.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-DAIs20DGVOMOMo3dOW8D"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 07 Aug 2019 19:56:32 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-DAIs20DGVOMOMo3dOW8D
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-08-07 at 13:31 +0300, Kamal Heib wrote:
> This series includes few cleanups and improvements, the first patch
> introduce a new enum for describing the physical state values and use
> it
> instead of using the magic numbers, patch 2-4 add support for a common
> query port for iWARP drivers and remove the common code from the iWARP
> drivers.
>=20
> Changes from v3:
> - Patch #1:
> -- Introduce phys_state_to_str() and use it.=20
>=20
> Changes from v2:
> - Patch #1:
> -- Update mlx4 and hns to use the new ib_port_phys_state enum.
> - Patch #3:
> -- Use rdma_protocol_iwarp() instead of rdma_node_get_transport().
>=20
> Changes from v1 :
> - Patch #3:
> -- Delete __ prefix.
> -- Add missing dev_put(netdev);
> -- Initilize gid to {}.
> -- Return error code directly.
>=20
> Kamal Heib (4):
>   RDMA: Introduce ib_port_phys_state enum
>   RDMA/cxgb3: Use ib_device_set_netdev()
>   RDMA/core: Add common iWARP query port
>   RDMA/{cxgb3, cxgb4, i40iw}: Remove common code

Thanks, series applied to for-next.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-DAIs20DGVOMOMo3dOW8D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1LLOsACgkQuCajMw5X
L93oUBAAmWm24sqnRJQzylblVpI4FH56/0+Ykg+S9UqajYLOpFE4face7BlKMQMK
qSn7x56kuEMb0BEzyHpUXWUOFlof3lvA16CiKDE7RXcZRGUf8CwBOw+JCz3oMK4Q
STPOIbeTsItFjsH2750okik8HAxSOt/v/p6ElUd6pVl0YSZG9jLAs37K1zPQAi2z
4KiZzzuqUI5gpZgT23yR+iwccDOp4wF/sLfTy8HskfBNVK2oImeyW22mLyCVfXcA
JRkBinJAuLmz6lWefWrUhmeCG7BWnNoqUjsO0wJxQZUtbrVKT887WKbH+Zk066+K
XkFrYOlSkGJxQFT6aZ4EMaprPjEbJ35tMFOuas0TNnoKbPdVR7uIIB9LW2eFErHI
0fd7zVaVN1EUHoHlRAtjFhY45eVGpT7jt3cK8hTsV5w1eFDGUp7lMtQXoOECmxgs
9+bpD9U5CYPqMPG6t56oxM6m1sACsGe7litlIwPStTl5TCNI/nASmvcXNyFFE3wS
ia4gBainFMp1RYre+9WIUUSABD9nU9XfGYOC+aEniSUwQCf/J2+btcBXPV4e8242
e1xDIv1NtD7Fgq4PbjkVLusWlmjll8okjJCKzQ4Z826OgfxyN7/rZ9TpapgGbmtI
9DeizE/28Lfj2qZqQJOtNI3a2qDPOK3O5VnRc1S5epe8b9hS8Ug=
=4rQD
-----END PGP SIGNATURE-----

--=-DAIs20DGVOMOMo3dOW8D--

