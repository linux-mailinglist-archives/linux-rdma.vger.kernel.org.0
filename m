Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0967A4191A
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 01:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392038AbfFKXmj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 19:42:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389600AbfFKXmj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jun 2019 19:42:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E78D781DFB;
        Tue, 11 Jun 2019 23:42:35 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-8.rdu2.redhat.com [10.10.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A8637A420;
        Tue, 11 Jun 2019 23:42:34 +0000 (UTC)
Message-ID: <cdd2493633c2b260fc3ded61af1909c41fde4da2.camel@redhat.com>
Subject: Re: [PATCH 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Date:   Tue, 11 Jun 2019 19:42:31 -0400
In-Reply-To: <20190605183252.6687-3-jgg@ziepe.ca>
References: <20190605183252.6687-1-jgg@ziepe.ca>
         <20190605183252.6687-3-jgg@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-RGgCe+MTpdcG5j4DaqqQ"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 11 Jun 2019 23:42:39 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-RGgCe+MTpdcG5j4DaqqQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-06-05 at 15:32 -0300, Jason Gunthorpe wrote:
> +static int __ib_get_client_nl_info(struct ib_device *ibdev,
> +                                  const char *client_name,
> +                                  struct ib_client_nl_info *res)
> +{
> +       unsigned long index;
> +       void *client_data;
> +       int ret =3D -ENOENT;
> +
> +       if (!ibdev) {
> +               struct ib_client *client;

I agree with Leon, this function would look better as two separate
functions.  But that's more cosmetic than anything else.  It's
unfortunate that the two loops are so close to identical, but vary in
such subtle ways that it prevents a reasonable joining of the loops.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
2FDD

--=-RGgCe+MTpdcG5j4DaqqQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0APGcACgkQuCajMw5X
L914Xg/8DEX7eR3Rn8PARHhU1hfRSOmlxG0AP8sBc9jljjkRXr8OjI98sbTJ4+tK
YYdqwkY5kt6Xp0tQmlM9jte+r58VA3wEnHFqOPEaz3068J9JeKkV2HD5ZmXHaHIY
owKMcLBunZyNLiD0c6EYyYy5W3aEv676t3Mx3TcobOu+UrK4SA47w6j4c5XKn6ND
adnCjqeauh7Fs+IuEHRDsxNUABL12f7KM1ptOhCw8MLdX1wkwT4YaK4IY/r7gANb
SpWdDq7rGPL3RMTipHRtj+V+J0DXu3u9iK6jsH9p/hH+GCEbQTuU7sCut5f3V4nD
X8DH7eIvXaBH8B2/Bi1rNa4iQQw4WrnCnOdUOmrV+5q70hUAn6Lpj/V91E15maJZ
aI9PcJOzAFPFHuSs0bOUriFH6DVnRdf4ZjDpK4CaTHGTv9F+NNjyk59Naf5nHWAn
CfXsgX+YZNiWwlF/oHNi2pPIUXjXzbcW7oH2f5wMK4g561t2dHJ/j0L3cxnvUIHA
XtSNR5e8wuzsI7Ds7wrsKB7rKxCROw4qulVPCGfvqNGG2yWBgK9uWJUd6BcnBRe3
AqiSWK01O4O1IA1Gi9nZTOVj9aIpwr65kZXUieu7yeHS9vFjFjMF0Tov3V9tMemp
NCTKNC8M2Lpe+u5ygsOq9IQhBK05cdwby3N5TsPluKezJWG3rMY=
=+glX
-----END PGP SIGNATURE-----

--=-RGgCe+MTpdcG5j4DaqqQ--

