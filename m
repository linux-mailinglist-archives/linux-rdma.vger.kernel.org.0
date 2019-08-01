Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEA47DF5D
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 17:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfHAPrZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 11:47:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731959AbfHAPrP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 11:47:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 86B09317F332;
        Thu,  1 Aug 2019 15:47:15 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F7E85D9CA;
        Thu,  1 Aug 2019 15:47:14 +0000 (UTC)
Message-ID: <bb41e13212673b194635741573f23cae10142ac8.camel@redhat.com>
Subject: Re: [PATCH rdma-rc 0/2] RDMA fixes for 5.3
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Date:   Thu, 01 Aug 2019 11:47:12 -0400
In-Reply-To: <22c618d7d496787c0d682d618249de21d1dcf082.camel@redhat.com>
References: <20190731081841.32345-1-leon@kernel.org>
         <22c618d7d496787c0d682d618249de21d1dcf082.camel@redhat.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-DHDe1xQHtvsiU0G3PgYx"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 01 Aug 2019 15:47:15 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-DHDe1xQHtvsiU0G3PgYx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-31 at 11:29 -0400, Doug Ledford wrote:
> On Wed, 2019-07-31 at 11:18 +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >=20
> > Hi,
> >=20
> > Two lock fixes in device<->client interaction, please see
> > extensive commit messages for more details.
> >=20
> > Thanks
> >=20
> > Jason Gunthorpe (2):
> >   RDMA/devices: Do not deadlock during client removal
> >   RDMA/devices: Remove the lock around remove_client_context
>=20
> I tried to figure out some way to trip either of these up, but they
> both
> look good to me.  I'll let them sit on the list for feedback before I
> take them though.
>=20

Applied to for-rc, thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-DHDe1xQHtvsiU0G3PgYx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1DCYAACgkQuCajMw5X
L902mBAAsywYFg+zkVwFTR1wP1qtjkXO28PQenL6KQLBzgYVAlfjcXjyagSwcpwl
XUN60JJAnSftvddHiC1tV3Ssmf8akycRDIIw5a3x5eZSWB1T60YAKyKTKfoVlsYV
Qix9yAbgMBvbD1xemhMlgI+f5YZa2wgqcdybeDICeBiZhbAiDrcaq7w4g4MXtIpR
ZgeToHxMRCaede4HlwYQF4iej0CHThGIW69fN3I0oJjQtpnZQ2dI2DuJYOsnJ+XV
Ruya8oiljM9v67iMlqFq2E+wEB8UOhYSt2YGx5R8b1OJVtHZ5WFmc/D4LE6vd8o8
+FRQ2xxX4to0Py6dW2tYjrKfWrGrlJb7TO2KX8iH3E+o9gwU2b4ck7u6srNLfizv
r0ETO7vwkTWcprEY5egIqIQ0aNU2iBBToNxmEZJcfbK/kfL8mfwaOaKzviuLf9ez
whti0iAQvOqOcErzHidRSIiExNvkFC61WXz4+yskKlLoyhHpjB0eq9kgb16Qj5Rp
R2vpwYA4NvmeMV+raMxUI1CDdAP+wXQUqSgbV/Ei3vgrsxJMBMryCJYuPbckAWBt
UTrgiDKUihD+Dw9P8nj5nQEoW9v+6r5Hbxb68q48KM5DT7gfMZv+Y0D1/b7oKRsA
LnEDPnQq8dacdvdqiUIfTeiUUrnBqY0RqsCfBwdyD8wbb3hDjrw=
=TF5C
-----END PGP SIGNATURE-----

--=-DHDe1xQHtvsiU0G3PgYx--

