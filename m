Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCC28A1FC
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 17:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfHLPKc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 11:10:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbfHLPKc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Aug 2019 11:10:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3253C30A699C;
        Mon, 12 Aug 2019 15:10:32 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-57.rdu2.redhat.com [10.10.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DC505C3FA;
        Mon, 12 Aug 2019 15:10:30 +0000 (UTC)
Message-ID: <289f2ef99bdb6d2b5adae4abbfd7db9ff3d03896.camel@redhat.com>
Subject: Re: [PATCH] RDMA/core: Fix error code in stat_get_doit_qp()
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mark Zhang <markz@mellanox.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Parav Pandit <parav@mellanox.com>,
        Majd Dibbiny <majd@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Mon, 12 Aug 2019 11:10:27 -0400
In-Reply-To: <20190811095657.GG28049@mtr-leonro.mtl.com>
References: <20190809101311.GA17867@mwanda>
         <20190811095657.GG28049@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-1qIK9eaTm6YsRAgWD4lH"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 12 Aug 2019 15:10:32 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-1qIK9eaTm6YsRAgWD4lH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-08-11 at 12:56 +0300, Leon Romanovsky wrote:
> On Fri, Aug 09, 2019 at 01:13:19PM +0300, Dan Carpenter wrote:
> > We need to set the error codes on these paths.  Currently the only
> > possible error code is -EMSGSIZE so that's what the patch uses.
> >=20
> > Fixes: 83c2c1fcbd08 ("RDMA/nldev: Allow get counter mode through
> > RDMA netlink")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/infiniband/core/nldev.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >=20
>=20
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

Thanks, applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-1qIK9eaTm6YsRAgWD4lH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1RgWQACgkQuCajMw5X
L91iLw/+KBK4MzgZ+4NAeQgnsSJMXLQzDx6Fbb+cmM+ercR74Tc7Po7bLt9xuhvZ
GrUhi6zkF6mMU1cCjYDkwOggHUf6On/yP1Bz38EswOdhwEP75zFGonF9n7EgglN7
jMoKZMkGvWDfqLz44q7awvM/YT5wDLCQ9DMMKVbYS04DHjAo6Js+oxRbP6ds4fLA
FAvVLSxWEYGdEKf15zBhRw+jW2aHJWTmnSJjTG51Rt7O39h15nkGyELziCgOxxtu
q4UrCzhfbnizdubchPVtrPYqZ/mgNLvVFywc49FnBGw/V4Uy3VlVgAr2TFeGgYmO
5ud8lTbCjM819IGT6Frn+bEntZGsewnSAmFfbOEqtLCtfcOT1jrl+8S3Ks/aM1Hl
QuXsPGK7ajSIUAWSasmYGvlqHVpIsZRcHOn/Zz7fH+zG0WAYq1Lj433Kq9KAo93l
PSL5nUNbJByh2yRYDyUnI7TEvuNTqW/lizLVT3szxz7sNGDsL00CAXWPCs1ZHoog
qhCCJhcp+UdI5wtPyQgX4wc0Vt4cNhCvyyRYmj9k6aCHgDR0xtAT+/HIxi9Q7wZQ
8JqwX/LIXGdd43YAqcJK0gjdk3usJBs57fexiOzCgVeR002qYzd4wt4bPo4Souu4
W6q7LFz0ahA9nyuLY94rtDpNFkuthfnxIHBRz5Yv9vOllO4Tir8=
=UXXB
-----END PGP SIGNATURE-----

--=-1qIK9eaTm6YsRAgWD4lH--

