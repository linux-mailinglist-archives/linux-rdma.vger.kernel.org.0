Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD1D965D7
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 18:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfHTQFh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Aug 2019 12:05:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfHTQFh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 12:05:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED5B3C08EC0A;
        Tue, 20 Aug 2019 16:05:36 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 29E0F1E0;
        Tue, 20 Aug 2019 16:05:35 +0000 (UTC)
Message-ID: <30814d3ca3b06c83b31f9255f140fdf2115e83e5.camel@redhat.com>
Subject: Re: [PATCH] siw: Fix potential NULL pointer in siw_connect().
From:   Doug Ledford <dledford@redhat.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     dan.carpenter@oracle.com, jgg@ziepe.ca
Date:   Tue, 20 Aug 2019 12:05:33 -0400
In-Reply-To: <20190819140257.19319-1-bmt@zurich.ibm.com>
References: <20190819140257.19319-1-bmt@zurich.ibm.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-PyETOunzfDMX5zzkcrbG"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 20 Aug 2019 16:05:37 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-PyETOunzfDMX5zzkcrbG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-08-19 at 16:02 +0200, Bernard Metzler wrote:
> Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_cm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/sw/siw/siw_cm.c
> b/drivers/infiniband/sw/siw/siw_cm.c
> index 9ce8a1b925d2..fc97571a640b 100644
> --- a/drivers/infiniband/sw/siw/siw_cm.c
> +++ b/drivers/infiniband/sw/siw/siw_cm.c
> @@ -1515,7 +1515,7 @@ int siw_connect(struct iw_cm_id *id, struct
> iw_cm_conn_param *params)
>  		}
>  	}
>  error:
> -	siw_dbg_qp(qp, "failed: %d\n", rv);
> +	siw_dbg(id->device, "failed: %d\n", rv);
> =20
>  	if (cep) {
>  		siw_socket_disassoc(s);
> @@ -1540,7 +1540,8 @@ int siw_connect(struct iw_cm_id *id, struct
> iw_cm_conn_param *params)
>  	} else if (s) {
>  		sock_release(s);
>  	}
> -	siw_qp_put(qp);
> +	if (qp)
> +		siw_qp_put(qp);
> =20
>  	return rv;
>  }

Hi Bernard,

We try to avoid empty commit messages.  I know in this case the subject
really carries the important info, but it looks better when displaying
the commit if there is something in the message body.

Also, please preface the subject with RDMA/siw: as we like to have the
RDMA subsystem preface the individual subcomponent element in the
subject line (some people still use IB, which is what used to be
preferred, but RDMA is preferred today).

I fixed both of those things up and applied this to for-rc, thanks.

Please take a look (I pushed it out to my wip/dl-for-rc branch) so you
can see what I mean about how to make both a simple subject line and a
decent commit message.  Also, no final punctuation on the subject line,
and try to keep the subject length <=3D 50 chars total.  If you have to go
over to have a decent subject, then so be it, but we strive for that 50
char limit to make a subject stay on one line when displayed using git
log --oneline.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-PyETOunzfDMX5zzkcrbG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1cGk0ACgkQuCajMw5X
L93PZw/8CLeisvTNs4TBeK/egoViFNk/H9YrwiALmmy6WWbcbz1RCdgL39xDKr3g
Sc0NaW4OG9LFQ+yHfKkf/047xhyC+8vTG+XFJ9tsbqzPrP3SqoTwNKucQygOdMEK
YIDA7zCD2Lr9Bsa1rCRoCG2cKqlKuNw9lPsMW7u69yRbU6vaVvjjD7mYiFrqvSrL
QK1Lvf4vRDpfemBn0s0karQR21sYXkEhPfFmkOp9HPpCzcpy7AtsyhJKkbqNgKRn
KBO6w5BatUrHqCizydv8G2ayfr2w7vn3F2hpRinxa/ZnLHAw8kMmR5iu19cgD5fu
+3X23rNedGwuotIkzXpZKcgIMQuzmh/dAlCZWqcKh9zaBX6DgE+Fj7IpO0sw5k39
HtachhUU7czNzsweKnWcmrKZrbuJwBqezaHsUPd6/zi6l2i4hdgtyNehhvLVcU8x
/599Qs0NFFzGlY++K0CCkMvbjdxObcU+fA5CKWWm7eUQNRyICjPWnlB3t5U8mAtB
EpzaEghbrFFan8jlgUSJWN678P5ZWqP5O6CloNhpf07BcRxqBeRraumx4f8uCfoQ
z+1m76zjb6fy9yW/FtB5gII1br0StCG31m1HxbhaxakhEiyoGIZwM23JDnE4BRB8
RxmuuR3MiEWpTnQ1+9RaBXbxJ5Rwu2ZezXrBrbkQxlQXSy6kP/U=
=/p4/
-----END PGP SIGNATURE-----

--=-PyETOunzfDMX5zzkcrbG--

