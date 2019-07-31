Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 318987C567
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 16:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388005AbfGaOxI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 10:53:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387926AbfGaOxH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 10:53:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A3933DE22;
        Wed, 31 Jul 2019 14:53:07 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 711A162A72;
        Wed, 31 Jul 2019 14:53:05 +0000 (UTC)
Message-ID: <09a994054e43c8bd6ee49b7d1087c9c4e793058f.camel@redhat.com>
Subject: Re: [PATCH V2] IB/core: Add mitigation for Spectre V1
From:   Doug Ledford <dledford@redhat.com>
To:     "Luck, Tony" <tony.luck@intel.com>, Ira Weiny <ira.weiny@intel.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 31 Jul 2019 10:52:53 -0400
In-Reply-To: <20190731043957.GA1600@agluck-desk2.amr.corp.intel.com>
References: <20190730202407.31046-1-tony.luck@intel.com>
         <95f5cf70-1a1d-f48c-efac-f389360f585e@embeddedor.com>
         <20190731042801.GA2179@iweiny-DESK2.sc.intel.com>
         <20190731043957.GA1600@agluck-desk2.amr.corp.intel.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-QyH2BAuw48C31a2xlFXF"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 31 Jul 2019 14:53:07 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-QyH2BAuw48C31a2xlFXF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-07-30 at 21:39 -0700, Luck, Tony wrote:
> Some processors may mispredict an array bounds check and
> speculatively access memory that they should not. With
> a user supplied array index we like to play things safe
> by masking the value with the array size before it is
> used as an index.
>=20
> Signed-off-by: Tony Luck <tony.luck@intel.com>
>=20
> ---
> V2: Mask the index *AFTER* the bounds check. Issue pointed
>     out by Gustavo. Fix suggested by Ira.
>=20
>  drivers/infiniband/core/user_mad.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/core/user_mad.c
> b/drivers/infiniband/core/user_mad.c
> index 9f8a48016b41..32cea5ed9ce1 100644
> --- a/drivers/infiniband/core/user_mad.c
> +++ b/drivers/infiniband/core/user_mad.c
> @@ -49,6 +49,7 @@
>  #include <linux/sched.h>
>  #include <linux/semaphore.h>
>  #include <linux/slab.h>
> +#include <linux/nospec.h>
> =20
>  #include <linux/uaccess.h>
> =20
> @@ -888,7 +889,12 @@ static int ib_umad_unreg_agent(struct
> ib_umad_file *file, u32 __user *arg)
>  	mutex_lock(&file->port->file_mutex);
>  	mutex_lock(&file->mutex);
> =20
> -	if (id >=3D IB_UMAD_MAX_AGENTS || !__get_agent(file, id)) {
> +	if (id >=3D IB_UMAD_MAX_AGENTS) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +	id =3D array_index_nospec(id, IB_UMAD_MAX_AGENTS);
> +	if (!__get_agent(file, id)) {
>  		ret =3D -EINVAL;
>  		goto out;
>  	}

I'm not sure this is the best fix for this.  However, here is where I
get to admit that I largely ignored the whole Spectre V1 thing, so I'm
not sure I completely understand the vulnerability and the limits to
that.  But, looking at the function, it seems we can do an early return
without ever taking any of the mutexes in the function in the case of id
>=3D IB_UMAD_MAX_AGENTS, so if we did that, would that separate the
checking of id far enough from the usage of it as an array index that we
wouldn't need the clamp to prevent speculative prefetch?  About how far,
in code terms, does this speculative prefetch occur?

This is the patch I was thinking of:

diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/u=
ser_mad.c
index 9f8a48016b41..1e507dd257ff 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -49,6 +49,7 @@
 #include <linux/sched.h>
 #include <linux/semaphore.h>
 #include <linux/slab.h>
+#include <linux/nospec.h>
=20
 #include <linux/uaccess.h>
=20
@@ -884,11 +885,18 @@ static int ib_umad_unreg_agent(struct ib_umad_file *f=
ile, u32 __user *arg)
=20
        if (get_user(id, arg))
                return -EFAULT;
+       if (id >=3D IB_UMAD_MAX_AGENTS)
+               return -EINVAL;
=20
        mutex_lock(&file->port->file_mutex);
        mutex_lock(&file->mutex);
=20
-       if (id >=3D IB_UMAD_MAX_AGENTS || !__get_agent(file, id)) {
+       /*
+        * Is our check of id far enough away, code wise, to prevent
+        * speculative prefetch?
+        */
+       id =3D array_index_nospec(id, IB_UMAD_MAX_AGENTS);
+       if (!__get_agent(file, id)) {
                ret =3D -EINVAL;
                goto out;
        }

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-QyH2BAuw48C31a2xlFXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1Bq0UACgkQuCajMw5X
L921jw/9EhWhfMF/Guidw2GPlq4vwkux/Qp+3y2kSJWsU2j5UBXYvcvoDOfkUFZC
ku20pEVPW4Zf1Lww3SUwEuQLy3Ilt/UHvFQeUaXzgTkqoOJz5Ywf6oceNvSrd+Sp
bznkCqP+cPzIz79jvYGhmIicBkgLjsN7UrXAfxycTRHQ2XAWxiQ/L8igEys4Me5O
iASc5zDMfvqmiNRe0RCxtSUJ1k6uzog9Wk7hwmD0FZ4XhI6zfuu2d483lQdIu1Un
TgFeL0fCD5zfAfVsSx55ocLjHtYoHkvsJqni79026IDNaBNotXGOYDNV3peiDXJq
U5/qfjQH5KTcOYxVqw6TUJyegxGDrudDuRS5uFRq52LcBg7d8KB6VzLcNiUcr2qp
1g6IoZjpXT/NIu+BAJC4O9/ZdxqfN4jVzz07m3ABwDycTgxXtRey30nQJfMxKV4p
77lcW5T/zdNoq6krRHnmbLQJJUGRL57jByem2IkpGIh8qkz+H5nbm2e5W125P0t4
w1qVp2Is0hj9RWW45f7gnZOk/c5OGghJhwthmZy2njvNv71JSG76cWZ+fj7kv3B1
qtEBAgszLPEZ6YhaEFJZbCHIn9UubmsLzichrCauw6PKR4Cgu5fLFggJ9eNRrf7m
tHIkdxY8qRy4wvYb1OAwBSpCZ9tt90raQ+6KyDpa/uWiKAP+vKk=
=t8Ey
-----END PGP SIGNATURE-----

--=-QyH2BAuw48C31a2xlFXF--

