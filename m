Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B954DA67
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 21:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfFTTkQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 15:40:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfFTTkQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 15:40:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6FA2A75734;
        Thu, 20 Jun 2019 19:40:16 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A9835C1A1;
        Thu, 20 Jun 2019 19:40:15 +0000 (UTC)
Message-ID: <64e330c9113b710fdc217ead320b11b29b35be08.camel@redhat.com>
Subject: Re: [PATCH rdma-next] RDMA: Check umem pointer validity prior to
 release
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Date:   Thu, 20 Jun 2019 15:40:13 -0400
In-Reply-To: <20190616120520.12765-1-leon@kernel.org>
References: <20190616120520.12765-1-leon@kernel.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-iWLooDhA/59G9pRHpcx+"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 20 Jun 2019 19:40:16 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-iWLooDhA/59G9pRHpcx+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-06-16 at 15:05 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>=20
> Update ib_umem_release() to behave similarly to kfree() and allow
> submitting NULL pointer as safe input to this function.
>=20
> Fixes: a52c8e2469c3 ("RDMA: Clean destroy CQ in drivers do not return
> errors")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>

Thanks, applied to for-next.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-iWLooDhA/59G9pRHpcx+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0L4R0ACgkQuCajMw5X
L933wg//Yp6KiM1HtGNwPZZovPLit4XGWXuxWmV35/UJlgIcMFo+zgSS2rKBK04j
Rp/Zc1HywDGW3ZS8G7YLtWRvkQmUOhNeVPyq0+62e2qiMEj7htFixpu84fD6fbJA
42jfcebeV4wvCy0QGpSax4HForWKcuXCULebWBgNVsn8cNF6HfwuvEhTgE6X3y1t
Y/eCeH/4kOciwOytsme+OT/2p93YsfOHf3UN7q69LUWYHVmfHj5cWkPG+sqKx2aP
yej9UNi1OkFzUprrOsnhvaxP12KtLhZT4ortlFcqW1AI6RzJRIF4aQ32Y6CpTKDn
SvmbdmKAplyLL9RB2UMVeata3V3l/d6NjIybWiaLDJNeI4slB7A2iVvyxBbAFFms
bmQi4iUgbCtrzowfCunZadi/+shj4PhNJKb39Cmm7Jo02+vKvJONFqOqQnPtMuNO
08VuF8ZshLIfeoz9kuRf1c4z1fMw52pJ0F05P8asks9AFv3buY3xBAcC+ddX06WP
zC4CyDY3rCvKwAdpOqN9MuJjUZG2nQLQhxuy3ZsHL1KL5Fjkoe0eWIBB5f18uLkl
bYT92Bm0NdkXgopghimqlP6c0YXDXm+Y9k4+JDYSvMOuGxpiZbxsDcHMPZYoNZAt
9lQS+SkHlKJ0mk8iojNcq1T4gpjqY/WimROdi107c5J6P/LZfwY=
=QNWD
-----END PGP SIGNATURE-----

--=-iWLooDhA/59G9pRHpcx+--

