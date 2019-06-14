Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83B6446842
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 21:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbfFNTqz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jun 2019 15:46:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfFNTqy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jun 2019 15:46:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77BF83082134;
        Fri, 14 Jun 2019 19:46:54 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C4A45D9D2;
        Fri, 14 Jun 2019 19:46:53 +0000 (UTC)
Message-ID: <ee0c017e93e28317791b7395e257801a208c7306.camel@redhat.com>
Subject: Re: RDMA: Clean destroy CQ in drivers do not return errors
From:   Doug Ledford <dledford@redhat.com>
To:     Colin Ian King <colin.king@canonical.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Gal Pressman <galpress@amazon.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 14 Jun 2019 15:46:50 -0400
In-Reply-To: <68d62660-902c-ca49-20fd-32e92830faa7@canonical.com>
References: <68d62660-902c-ca49-20fd-32e92830faa7@canonical.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-oclBt3wpyL1/z9Jqf2cH"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 14 Jun 2019 19:46:54 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-oclBt3wpyL1/z9Jqf2cH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-06-14 at 14:59 +0100, Colin Ian King wrote:
> Hi,
>=20
> Static analysis with Coverity reported an issue with the following
> commit:
>=20
> commit a52c8e2469c30cf7ac453d624aed9c168b23d1af
> Author: Leon Romanovsky <leonro@mellanox.com>
> Date:   Tue May 28 14:37:28 2019 +0300
>=20
>     RDMA: Clean destroy CQ in drivers do not return errors
>=20
> In function bnxt_re_destroy_cq() contains the following:
>=20
>         if (!cq->umem)
>                 ib_umem_release(cq->umem);

Given that the original test that was replaced was:
	if (!IS_ERR_OR_NULL(cq->umem))

we aren't really worried about a null cq, just that umem is valid.  So,
the logic is inverted on the test (or possibly we shouldn't have
replaced !IS_ERR_OR_NULL(cq->umem) at all).

But on closer inspection, the bnxt_re specific portion of this patch
appears to have another problem in that it no longer checks the result
of bnxt_qplib_destroy_cq() yet it does nothing to keep that function
from failing.

Leon, can you send a followup fix?

> Coverity detects this as a deference after null check on the null
> pointer cq->umem:
>=20
> "var_deref_model: Passing null pointer cq->umem to ib_umem_release,
> which dereferences it"
>=20
> Is the logic inverted on that null check?
>=20
> Colin

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
2FDD

--=-oclBt3wpyL1/z9Jqf2cH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0D+aoACgkQuCajMw5X
L92tOA//WBx64wApAfYYhQxaTRKXZLJQhiLjnObsbdbdnLBZbluvKdmWTQoWeuhz
9AZD/okm8UQudNP94wn9wDJYTkrICHIB5rp/HDTD4h2Rvm4pqMwUwKD69C21kl3/
b4Ggw+i9R3jRLR+jAJk+vsT8gVpUztnrDAPeqGf68dvH/Ms8se5nCP2FPTUfm0OD
i65BNrbryB1sX1oHzkNWbf0APmPPbR1GNPlrjykwQEOFbfdsf/bJ9MUb58SnKtOP
R2ntK1epLbIhPAYYOig4/JSdKfe/D5BS8BiXZiQeVH4COyyLiSxsCGqzVQ2Vtu71
P3l27U6NaLiOW18XorOoc8J0GdEb+kS7zoas8blEdiJM48j0Pptp+wjiaOLwjTqZ
4yL79btwVY8qYbMTXCbMttYRrvk3GEeTNQt226/Cv7xwpRbP8GV239BsetOWcLb8
1Cvnu30q9cDwLOdpBC1BEyExOkHLDuWf6E3t9kaLuKhDEpt1QDPbkd6VNjNM1K3T
Rsu/99cmxDSmzfIcLn8/5Xm/qAmJtTH1tvwvmumm32ZbGQk/gxjyQYxxGb/gusL1
NJ3V+RgujDpIVmEk4oD5moeVeMILfyLHVFN7gwCOIpUq0t/qS63wyOB+TdCWmurV
fOaqfxusOYqIFQ+Jr1VT0SL/DGQ3yfNyxD7IE/17Y38i8Bqo+cU=
=B1SW
-----END PGP SIGNATURE-----

--=-oclBt3wpyL1/z9Jqf2cH--

