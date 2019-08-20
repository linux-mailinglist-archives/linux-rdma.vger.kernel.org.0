Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36430966A1
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 18:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfHTQlT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 12:41:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728554AbfHTQlT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 12:41:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C2551C08EC0B;
        Tue, 20 Aug 2019 16:41:18 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0657E1DB;
        Tue, 20 Aug 2019 16:41:17 +0000 (UTC)
Message-ID: <98ee3762eb9859b4b48c52ab32f089c1f3c9d097.camel@redhat.com>
Subject: Re: [PATCH for-rc 0/5] Fixes TID packet ordering issues
From:   Doug Ledford <dledford@redhat.com>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 20 Aug 2019 12:41:15 -0400
In-Reply-To: <20190815192013.105923.63792.stgit@awfm-01.aw.intel.com>
References: <20190815192013.105923.63792.stgit@awfm-01.aw.intel.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-L6V/uJSWYQ0ER/BX4KtK"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 20 Aug 2019 16:41:18 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-L6V/uJSWYQ0ER/BX4KtK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-15 at 15:20 -0400, Mike Marciniszyn wrote:
> This patch patch series fixes a issues caused
> by packet ordering when adaptive routing is in
> use.
>=20
> ---
> Kaike Wan (5):
>       IB/hfi1: Drop stale TID RDMA packets
>       IB/hfi1: Unsafe PSN checking for TID RDMA READ Resp packet
>       IB/hfi1: Add additional checks when handling TID RDMA READ RESP
> packet
>       IB/hfi1: Add additional checks when handling TID RDMA WRITE DATA
> packet
>       IB/hfi1: Drop stale TID RDMA packets that cause TIDErr
>=20
>=20
>  drivers/infiniband/hw/hfi1/tid_rdma.c |   76 ++++++++++++----------
> -----------
>  1 file changed, 27 insertions(+), 49 deletions(-)
>=20

Thanks, series applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-L6V/uJSWYQ0ER/BX4KtK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1cIqsACgkQuCajMw5X
L90i0Q//eOulkBSPIHOgtLPRkw1Qtr3fRCu7ME9w0ynB55hGeSRmVzMNJdCkeUbX
fnRetOq+PZkrAHzjHo6JoAUEPPcWSeYo0B6gESAW3bZjcLYNw/lTvv3Ga8OwN7zD
zIcIHHpkFHzkPPJ4T7hZXg5AYZ1WcUpTL8mj7qgQnnrWTLgEnYApPPAcna26Bkj8
4PsB/lMAHt0D21R2OGxDZgIqque1FqTrPlImBa316TMtLsLVNesrOog+o1zGkc7e
bPha5wjQAzE6x0jUlkhN76hr2VnOSXbLRQubuTn3/DbK01V/ctY/ri8HeRr57bm1
db1DOn3PGbolSY8H1UIx/Go5F3otQ9SFawxfbBhjqv5STMEEPazQO6AxuBKv8SH7
LXkQB5NraceJYCedGzZBMTtW/CFy9hMwHlLuLsfGOyw1FJfuS1jDz4CjXHVqD5mx
7js7VGVCJnQIW/KToW8vYL1mzPOlaQ1e6hHOiHkp1SvxIh/hxGAa5WgWsGyueG8m
mtMAe12XF6GpMsYtlz74BdrR8wBIEBzg6h9peUIU/fOqgEBqNBsMQrMKECGoeqG7
nUlxtGkxu5V4tpoed3zvc2u2X9G+s9FPialtmcdagUH7iWntY3wG3Bd2vQNRgCem
SWFC/nhmQ+FAHaV7rugKX0YeHU8MSUOc8lBbYInb4y4wQTbfP9A=
=GhLS
-----END PGP SIGNATURE-----

--=-L6V/uJSWYQ0ER/BX4KtK--

