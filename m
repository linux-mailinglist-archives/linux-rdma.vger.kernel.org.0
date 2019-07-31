Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47F647C68E
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 17:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfGaP33 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 11:29:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfGaP33 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 11:29:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 629FBC09AD11;
        Wed, 31 Jul 2019 15:29:29 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E8A7600F8;
        Wed, 31 Jul 2019 15:29:28 +0000 (UTC)
Message-ID: <22c618d7d496787c0d682d618249de21d1dcf082.camel@redhat.com>
Subject: Re: [PATCH rdma-rc 0/2] RDMA fixes for 5.3
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Date:   Wed, 31 Jul 2019 11:29:25 -0400
In-Reply-To: <20190731081841.32345-1-leon@kernel.org>
References: <20190731081841.32345-1-leon@kernel.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-UVy2XopFG8ycMZM2BZoP"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 31 Jul 2019 15:29:29 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-UVy2XopFG8ycMZM2BZoP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-31 at 11:18 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>=20
> Hi,
>=20
> Two lock fixes in device<->client interaction, please see
> extensive commit messages for more details.
>=20
> Thanks
>=20
> Jason Gunthorpe (2):
>   RDMA/devices: Do not deadlock during client removal
>   RDMA/devices: Remove the lock around remove_client_context

I tried to figure out some way to trip either of these up, but they both
look good to me.  I'll let them sit on the list for feedback before I
take them though.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-UVy2XopFG8ycMZM2BZoP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1Bs9UACgkQuCajMw5X
L91PMBAAkgb3/qxbJl3aIuQsjWIjWgD4WZfseLdl5bdcK+vcefa8YjJJP3jkpxMx
ETJfBtPHhB+WXx2I5Ue13WL3/yWMXD/oKqbu2HHWki3PQ5g/FwC0XmDEmYbexSO4
KDeAyRZyXHIX8ck/w/bViSVTJMHB/cWESGo9I26ahtW6cpeSooyiagFIdqqKQ25o
WC48wupVS8p8afZltc6SdskRSjNZuX4LRJJyYvTte+qHhsGAiWH7lUnzJnxrQJhc
6FeBXPfsgF2oGBXjJ2H5sfmOZh+ZC+pR8/R6TjYIew5+3AvbV5Or99ZmSBgMUTcG
BBwaJJRq5ISmWeDHvu1BkrE1wBOv8TQZk/ZcGHad2TCaozh5VkCa8/8M63s25qR+
cLNc43sZN39p0rNe+eoa3/VjaM3ALBapAEQgp2EEAI9dHv2gvhBmFikmuTvmNZ18
pdQcS7G0547r0434K5hOAKwiadfxdho0oZLFxRgKFXYKvjl8sCDzQhiNdqC+V1jP
VCBvfWIMmi5Bfpj9EHu5hMa11DaX/RrNoUp1Gt8MuCYF+vqdDszZI1iohJKb4fLA
XS05b6OeBo5UmJLCrloAE7gf0df/gxvJ9R5aRiMUnPwUmZFXtSRBGrNaoFEO8DZZ
5Edv70tJkTtgqXbjHwoVpKpxsPu+SmILMosL0w6HxdBqyiS2TlI=
=hk8r
-----END PGP SIGNATURE-----

--=-UVy2XopFG8ycMZM2BZoP--

