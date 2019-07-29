Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22999790CE
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 18:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfG2Q2O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jul 2019 12:28:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfG2Q2N (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jul 2019 12:28:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22DA04DB1F;
        Mon, 29 Jul 2019 16:28:13 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D26E5D9C3;
        Mon, 29 Jul 2019 16:28:11 +0000 (UTC)
Message-ID: <ee858ba02e8e560672aff68aead2323bc2136b6c.camel@redhat.com>
Subject: Re: [PATCH] infiniband: hw: cxgb3: Fix a possible null-pointer
 dereference in connect_reply_upcall()
From:   Doug Ledford <dledford@redhat.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, bharat@chelsio.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Jul 2019 12:28:09 -0400
In-Reply-To: <20190725121508.16352-1-baijiaju1990@gmail.com>
References: <20190725121508.16352-1-baijiaju1990@gmail.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-YogQSHis/dLMip/kO+pD"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 29 Jul 2019 16:28:13 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-YogQSHis/dLMip/kO+pD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-07-25 at 20:15 +0800, Jia-Ju Bai wrote:
> In connect_reply_upcall(), there is an if statement on line 730 to
> check
> whether ep->com.cm_id is NULL:
>     if (ep->com.cm_id)
>=20
> When ep->com.cm_id is NULL, it is used on line 736:
>     ep->com.cm_id->rem_ref(ep->com.cm_id);
>=20
> Thus, a possible null-pointer dereference may occur.
>=20
> To fix this bug, ep->com.cm_id is checked before being used.
>=20
> This bug is found by a static analysis tool STCheck written by us.

I think this is one of those theoretical issues that is a non-issue in
practice.  The cxgb3 driver is older than dirt and only hangs around
because people out there are still using it in a few places.  We have no
reports of bugs in this function.  I looked through the code, but it
wasn't quickly obvious why this isn't an issue, but I suspect the real
answer is "we can never have a negative status and not have a cm_id" as
a result of the design of the code.  Verifying that with an audit is
more time than I want to spend though.  So, I'm going to drop this
patch.  If you can find a plausible path by which this is actually a
bug, then we can revisit it.  But I don't want to go around changing a
known working for years driver on the basis of "my new static code
checker found this thing" versus someone who reports an actual crash
(which is what this bug would cause if it exists).

> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/infiniband/hw/cxgb3/iwch_cm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/cxgb3/iwch_cm.c
> b/drivers/infiniband/hw/cxgb3/iwch_cm.c
> index 0bca72cb4d9a..2b31c4726d3e 100644
> --- a/drivers/infiniband/hw/cxgb3/iwch_cm.c
> +++ b/drivers/infiniband/hw/cxgb3/iwch_cm.c
> @@ -733,7 +733,8 @@ static void connect_reply_upcall(struct iwch_ep
> *ep, int status)
>  		ep->com.cm_id->event_handler(ep->com.cm_id, &event);
>  	}
>  	if (status < 0) {
> -		ep->com.cm_id->rem_ref(ep->com.cm_id);
> +		if (ep->com.cm_id)
> +			ep->com.cm_id->rem_ref(ep->com.cm_id);
>  		ep->com.cm_id =3D NULL;
>  		ep->com.qp =3D NULL;
>  	}

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-YogQSHis/dLMip/kO+pD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0/HpkACgkQuCajMw5X
L90CNw//Y6UQ1pxYfjyvEe7fu8Ltg+vL3hoLkfuH5MEGWSYUdyntysX3sj3iYWtP
w4WniX9GtVbTcKZCU82FZrajQcFWvh+5+O/ouyKLeMXs6DXPej8G0zt4p8XnlI60
1uct3Kjytw3Fmr3iGk86190S3Gh1eRx8CMOZhKPKeb84VhpJg2evqu9VTjwwcCSG
a7k9sEBiXzfblUQT4kvWEDQF7ycbZtF5e2EO78gv2g+t66u5N8U+WWgzxIpLD1Jw
qeIHnvV/ymp2OzW5aHZCjJPacZOTFlTBMy2CLJCpaRU5anh1KGIsb0e/mDprNL/w
rX48cnTSQym67wq7w67HRj7mRfi+S38YEHqYlWZfkYvlf62yuKpNoQCTWTUYj8N7
biWz2bvXEpFfTN5uw1QQmfx2bOyGByyCqj23ZrvcXSPE0dZigUXAOxAfi8LyuXil
9PzLZ2ezuqxQOu5TJNTTe8kIJgFHjQZW2FrJqC40wRrcXcoqvDdQDbDmqWiNPSiw
xihr213HIzlrNf4Hu5Bv+9ai/WeH0xrF124ieW7sYRNG8uh81b2C5Ammg2hgjeLs
AU3KmQnY6gcVnlVrG0FwgxDeZi20lu8SPMwi3XMT5sq4Ytq/jXUnr0iEMUjv6NZ/
5lSdWianq6yxOKeQjDm1fYIbHHl4mhoz3k4DGySjqXuFNE2aaJU=
=dMEI
-----END PGP SIGNATURE-----

--=-YogQSHis/dLMip/kO+pD--

