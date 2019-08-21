Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45ACC97B1A
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 15:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfHUNjy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 09:39:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728026AbfHUNjy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 09:39:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF725859FE;
        Wed, 21 Aug 2019 13:39:53 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E75351001B12;
        Wed, 21 Aug 2019 13:39:52 +0000 (UTC)
Message-ID: <adc716f5d2105a3cc7978873cd0f14503ae323d8.camel@redhat.com>
Subject: Re: [PATCH] siw: Fix potential NULL pointer in siw_connect().
From:   Doug Ledford <dledford@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org,
        jgg@ziepe.ca
Date:   Wed, 21 Aug 2019 09:39:50 -0400
In-Reply-To: <20190821125645.GE3964@kadam>
References: <20190819140257.19319-1-bmt@zurich.ibm.com>
         <30814d3ca3b06c83b31f9255f140fdf2115e83e5.camel@redhat.com>
         <20190821125645.GE3964@kadam>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-hLPEN08Z+ouQfPZplcG0"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 21 Aug 2019 13:39:54 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-hLPEN08Z+ouQfPZplcG0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-08-21 at 15:56 +0300, Dan Carpenter wrote:
> On Tue, Aug 20, 2019 at 12:05:33PM -0400, Doug Ledford wrote:
> > Please take a look (I pushed it out to my wip/dl-for-rc branch) so
> > you
> > can see what I mean about how to make both a simple subject line and
> > a
> > decent commit message.  Also, no final punctuation on the subject
> > line,
> > and try to keep the subject length <=3D 50 chars total.  If you have
> > to go
> > over to have a decent subject, then so be it, but we strive for that
> > 50
> > char limit to make a subject stay on one line when displayed using
> > git
> > log --oneline.
>=20
> 50 is really small.

50 is the vim syntax highlighting suggested limit.  You can go over,
which is why I indicated it was a soft limit, but there you are.  It
leaves room for the displayed hash length to grow as well.

>   If it were based on git log --oneline output the
> limit would be 67 characters.

Only if you don't include room for the hash size to grow and other
possible things, like a tag.

>   If you look at actual kernel git commits
> then the average subject is 52.4 characters and probably the upper
> bound
> is 60+ or so.

Yep, probably largely due to that very same vim syntax highlighting :-)

> I was surprised how well I had done personally at generating subjects
> when I looked at my own git log.
>=20
> My shortest subject was commit 0746556beab1 ("bna: off by one").  That
> was from 10 years ago and is not up to my current standards.  My
> longest
> was commit 49d3d6c37a32 ("drivers/misc/sgi-gru/grukdump.c: unlocking
> should be conditional in gru_dump_context()"), but originally I used
> "gru:" as the patch prefix and Andrew changed it.  :P
>=20
> regards,
> dan carpenter

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-hLPEN08Z+ouQfPZplcG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1dSaYACgkQuCajMw5X
L90lmBAAonw13O1BH3xSGyIo5NsGfD/+4+3d3XeZuZp1Hyhx7z01QM5qsYYaSeUj
eQ99NRtMqzAn3S4nAn588qMtI30Ycba++8wehV09y+tu2UIfKV3dihBbxwjkxZJ+
xi770xNdje9ZrUNs9rQRlXEDY/ng0+nardoudODbtCY99xw618pxA2jXs95E53ok
Ty+ZiJs4MTkZzSw62Lk06VLdhz3pj1ObQH/YCMTEivs33t4+xzBKAuAEffh/+9/C
e+LreoN8eaGvfvhOX4Jm5Rlrrc07iMOhUz/f77aGaf90OFrD6NuqwXz8XoRgE8Rd
tumm14qz3y5/WK7E0HvpMd+8o1anlY7i624ifJwGiJHuT5jbsuy5/TERgj9IZ2UC
sZVZ0pe7m7EPbFbubgaFrKzLoAi+uFdhp/d0+Vkz+oxZCR5+D9B69tYwKKkB/u7q
vD7YO7dvWdJP9Z3BUXbt++x/+hRAconthv5bcfRO9gFDiZoR2ZlVnJPLF6evBWJw
KClYP5FtUB6tuo2CkCIPxMl/TRjzTzjjFA9YfVWgibEb4EjWu8GWPIiK3ia/OQoe
QqE+8f4FREQUbLcSknLE4TdKL7EAW7A3dZ9elE3Wz9/TwjFUjn0tguoxU+uOBPH4
+oBXLfB2/aeVHKKa1ZMEoL/4EhfhtAfiMRIF3gh9L9j6JaQuWqU=
=6cSW
-----END PGP SIGNATURE-----

--=-hLPEN08Z+ouQfPZplcG0--

