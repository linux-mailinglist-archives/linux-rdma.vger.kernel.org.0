Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 708E47923E
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 19:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfG2Rgf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jul 2019 13:36:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728435AbfG2Rgf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jul 2019 13:36:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D32493079B65;
        Mon, 29 Jul 2019 17:36:34 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 083295C1A1;
        Mon, 29 Jul 2019 17:36:33 +0000 (UTC)
Message-ID: <9c4975b8fed483c0911f27f4b90c0566962ada3d.camel@redhat.com>
Subject: Re: [bug report] rdma/siw: queue pair methods
From:   Doug Ledford <dledford@redhat.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 29 Jul 2019 13:36:31 -0400
In-Reply-To: <OF61E386ED.49A73798-ON00258444.003BD6A6-00258444.003CC8D9@notes.na.collabserv.com>
References: <20190726081056.GA27059@mwanda>
         <OF61E386ED.49A73798-ON00258444.003BD6A6-00258444.003CC8D9@notes.na.collabserv.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-vp4QY5OEGgUpxUS5q0kZ"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 29 Jul 2019 17:36:34 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-vp4QY5OEGgUpxUS5q0kZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-07-27 at 11:03 +0000, Bernard Metzler wrote:
> -----"Dan Carpenter" <dan.carpenter@oracle.com> wrote: -----
>=20
> > To: bmt@zurich.ibm.com
> > From: "Dan Carpenter" <dan.carpenter@oracle.com>
> > Date: 07/26/2019 10:11AM
> > Cc: linux-rdma@vger.kernel.org
> > Subject: [EXTERNAL] [bug report] rdma/siw: queue pair methods
> >=20
> > Hello Bernard Metzler,
> >=20
> > The patch f29dd55b0236: "rdma/siw: queue pair methods" from Jun 20,
> > 2019, leads to the following static checker warning:
> >=20
> > 	drivers/infiniband/sw/siw/siw_qp.c:226 siw_qp_enable_crc()
> > 	warn: variable dereferenced before check 'siw_crypto_shash' (see
> > line 223)
> >=20
> > drivers/infiniband/sw/siw/siw_qp.c
> >   219  static int siw_qp_enable_crc(struct siw_qp *qp)
> >   220  {
> >   221          struct siw_rx_stream *c_rx =3D &qp->rx_stream;
> >   222          struct siw_iwarp_tx *c_tx =3D &qp->tx_ctx;
> >   223          int size =3D crypto_shash_descsize(siw_crypto_shash) +
> >                                                 ^^^^^^^^^^^^^^^^
> > Dereferenced inside function.
> >=20
> >   224                          sizeof(struct shash_desc);
> >   225 =20
> >   226          if (siw_crypto_shash =3D=3D NULL)
> >                    ^^^^^^^^^^^^^^^^^^^^^^^^
> > Checked too late.
> >=20
> >   227                  return -ENOENT;
> >   228 =20
> >   229          c_tx->mpa_crc_hd =3D kzalloc(size, GFP_KERNEL);
> >   230          c_rx->mpa_crc_hd =3D kzalloc(size, GFP_KERNEL);
> >   231          if (!c_tx->mpa_crc_hd || !c_rx->mpa_crc_hd) {
> >   232                  kfree(c_tx->mpa_crc_hd);
> >   233                  kfree(c_rx->mpa_crc_hd);
> >   234                  c_tx->mpa_crc_hd =3D NULL;
> >   235                  c_rx->mpa_crc_hd =3D NULL;
> >   236                  return -ENOMEM;
> >   237          }
> >   238          c_tx->mpa_crc_hd->tfm =3D siw_crypto_shash;
> >   239          c_rx->mpa_crc_hd->tfm =3D siw_crypto_shash;
> >   240 =20
> >   241          return 0;
> >   242  }
> >=20
> > regards,
> > dan carpenter
> >=20
> >=20
>=20
> Hi Dan,
> many thanks for catching this one! The fix of course is simple:
>=20

Hi Bernard,

This patch was ignored by patchworks for some reason.  If I hadn't
noticed that it was here, but not in patchworks and also not applied
previously by Jason, it would have been missed entirely.  I suspect it's
because the patch was embedded in a reply, but I'm not sure as that
normally seems to work.  In any case, I might suggest next time you
reply to the bug report that you have a fix, and then use git send-email=
=20
to send the patch, just to be on the safe side in terms of things
getting lost.

With all that said, applied to for-rc along with some fix ups to the log
message (added Reported-by: and Fixes: tags).

> From c13b5da99aea7766a61aabe33e9943618f4505cf Mon Sep 17 00:00:00 2001
> From: Bernard Metzler <bmt@zurich.ibm.com>
> Date: Sat, 27 Jul 2019 12:38:32 +0200
> Subject: [PATCH] Do not dereference 'siw_crypto_shash' before checking
>=20
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_qp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/sw/siw/siw_qp.c
> b/drivers/infiniband/sw/siw/siw_qp.c
> index 11383d9f95ef..e27bd5b35b96 100644
> --- a/drivers/infiniband/sw/siw/siw_qp.c
> +++ b/drivers/infiniband/sw/siw/siw_qp.c
> @@ -220,12 +220,14 @@ static int siw_qp_enable_crc(struct siw_qp *qp)
>  {
>  	struct siw_rx_stream *c_rx =3D &qp->rx_stream;
>  	struct siw_iwarp_tx *c_tx =3D &qp->tx_ctx;
> -	int size =3D crypto_shash_descsize(siw_crypto_shash) +
> -			sizeof(struct shash_desc);
> +	int size;
> =20
>  	if (siw_crypto_shash =3D=3D NULL)
>  	return -ENOENT;
> =20
> +	size =3D crypto_shash_descsize(siw_crypto_shash) +
> +		sizeof(struct shash_desc);
> +
>  	c_tx->mpa_crc_hd =3D kzalloc(size, GFP_KERNEL);
>  	c_rx->mpa_crc_hd =3D kzalloc(size, GFP_KERNEL);
>  	if (!c_tx->mpa_crc_hd || !c_rx->mpa_crc_hd) {

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-vp4QY5OEGgUpxUS5q0kZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0/Lp8ACgkQuCajMw5X
L91kkQ//ZYZbJeitlECD1jzqR97LVUSqPZ6VaVvwoSXQFJcVtJVQZVZgXB6WPqU3
cQvJvs+viRaxs8VbcGgJ8P/XsudalmvdjxPJjPucEycP+OLYjLeR4DsjeSabgQCY
95YGUrrhPh6YxHX+IwQ/fKdKPUH53GmOVZJkXuHyecFnizY6tHkLD1bVa3Bvnma9
U7sAZWsZIdxl2I6Rd3ROGajzWxFFclxsWcmU7+ceTrsslc/kRBeitL7ZU3uL5qaF
mEw5U80CWfNtnV8QQT7Skp35MroDUwVMMwZMBtBi1Ya7UOk7lGLg9AxkkyBH5ul0
W8wRS3izMixALxG0DpEt5ynVIhCbrgtA8FZFhiZnYCyWTCWwPiw1alYqRbfm5P/1
NpIJctBPGQAbB7/iC7HS9oMkGVfsnLYEkvk2Kpw4VPJiYS+QOrAYige58KSEPx+c
yaaSiap1o9xxe1o/PHaabgHjp7zOday2DA7QfMalHpqUZrulbrk5xITaF4amlsis
4jQuILIGRavuTyAJ63II1awjiGnh+R6SqbDqOmBG3c0WFFHBYB4sNHBuoTLydYGz
xjPxGaYoIgVFS4PeRv2oo1k3HyO+antiBFIVipqkFmKwex8+4fU/TI79hsVLisJ8
4GHtCiFBiaojy3h1dpG16CaMftOKzMD7aNzMeE3E/1NcxLBvAJ4=
=6f56
-----END PGP SIGNATURE-----

--=-vp4QY5OEGgUpxUS5q0kZ--

