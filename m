Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED3FF7E08D
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 18:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbfHAQul (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 12:50:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfHAQul (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 12:50:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1555E31F40D;
        Thu,  1 Aug 2019 16:50:41 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D9805D9CD;
        Thu,  1 Aug 2019 16:50:40 +0000 (UTC)
Message-ID: <760cfc7eb23c6dc170856a3a60226f32f8c8bf9f.camel@redhat.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Date:   Thu, 01 Aug 2019 12:50:37 -0400
In-Reply-To: <20190801164330.GH23885@mellanox.com>
References: <20190731180124.GE4832@mtr-leonro.mtl.com>
         <20190731195523.GK22677@mellanox.com>
         <20190801082749.GH4832@mtr-leonro.mtl.com>
         <20190801120007.GB23885@mellanox.com>
         <20190801120821.GK4832@mtr-leonro.mtl.com>
         <060b3e8fbe48312e9af33b88ba7ba62a6b64b493.camel@redhat.com>
         <20190801155912.GS4832@mtr-leonro.mtl.com>
         <a0dc81b63fdef1b7e877d5172be13792dda763d2.camel@redhat.com>
         <20190801162008.GF23885@mellanox.com>
         <b74a9eb67af54e8f5050e97a3ab13899de17fe0a.camel@redhat.com>
         <20190801164330.GH23885@mellanox.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-o47jkhgoYNXkCEaA8fjB"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 01 Aug 2019 16:50:41 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-o47jkhgoYNXkCEaA8fjB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-01 at 16:43 +0000, Jason Gunthorpe wrote:
> On Thu, Aug 01, 2019 at 12:40:43PM -0400, Doug Ledford wrote:
>=20
> > > It does have a lock though, the caller holds it, hence the request
> > > for
> > > the lockdep.
> >=20
> > You're right, although I think the lockdep annotation can be a
> > separate
> > patch as it's neeeded on more than just the function this patch
> > touches.
>=20
> Why? This relies on that lock, so it should have the
> lockdep_assert_held assert.

It does, but this patch is about the scheduling while atomic, adding a
lockdep assertion fix is doubling up on fixes in the patch.  A separate
patch that addes the lockdep assert to both the bind and unbind calls
makes more sense and just feels cleaner to me.

> If there are more functions with implicit locking theyt they can be
> fixed separately...

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-o47jkhgoYNXkCEaA8fjB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1DGF0ACgkQuCajMw5X
L93X4A/8Dxe4wWTP+yBZyelRCtDiaY707tL/9ieHhbQVCJObNo1/VNOlwPM00u8I
sT4s7Ya3mP9Qql6xTRShW7bm8Mfzv4T1xwwwGBPXEwcbP9mjNwPIju0fhYKRstcG
/HLiI1JtA2QtvcjZ+A9OTer3DvALzdElG8uYPE2ebP5TjX0inVQdLIX+JTZBVQoZ
aseGZ0VvVfNV0xKSheFyVgF0JnWs1h6Bkmg21SN9XwjNPcgPhvPpw8oGzBNt2E2d
2bVneoqg3i3KMiPVVMFOdjOJH1QnnzY69sEzIQe32uI6Es0d/KAXwEZOBTUmtrpj
V2y0Kwqvf1SnV70etB+d1q6KPY/cpxgtMkP+JiIbgtJUTkubw4ISRf40etOyZdLH
41+U0X84T6R7YK5YL0902f+zQHHo0P9r2/KTJIQ2VY5kUIsTialUuVzqvI7rfW4s
AEZm6jUm7NcOUv7HffU7EMdylFgysE/oYOE03/bR4N+GX0v3VwEAfor8U61fY0wd
b8jN8luSHnePijSzSfirx7r0nQxv9rCKAuHPnqGAjdjRKKsCvlu+z8irPoa2PM46
wWXtmXBCB4vO7sFF/p1geRG3qwkDjoHxfjOOUz1Rw9UZHcsnM3W2y+xQOdjwKXTu
yBICnA9BkHkY792skQEl9NCt7cHKXwr2U9VGK+KiR2T1Op7Ermw=
=hmRE
-----END PGP SIGNATURE-----

--=-o47jkhgoYNXkCEaA8fjB--

