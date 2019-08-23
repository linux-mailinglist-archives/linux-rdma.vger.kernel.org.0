Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 039D29B4AE
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2019 18:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436811AbfHWQjW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Aug 2019 12:39:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48036 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436809AbfHWQjW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Aug 2019 12:39:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ADDDCA35B7A;
        Fri, 23 Aug 2019 16:39:21 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A120D5D9CA;
        Fri, 23 Aug 2019 16:39:20 +0000 (UTC)
Message-ID: <4caa09ed0bc30f3f3064c0014f4dae23bbfe7de1.camel@redhat.com>
Subject: Re: Re: [PATCH v3] RDMA/siw: Fix 64/32bit pointer inconsistency
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        geert@linux-m68k.org
Date:   Fri, 23 Aug 2019 12:39:17 -0400
In-Reply-To: <20190823161551.GI12968@ziepe.ca>
References: <20190823144221.GF12968@ziepe.ca>
         <0f280f83ded4ec624ab897f8a83b4ab1565f35cd.camel@redhat.com>
         <20190822173738.26817-1-bmt@zurich.ibm.com>
         <20190822184147.GO29433@mtr-leonro.mtl.com>
         <OF013F89F4.F7760460-ON0025845F.004F2CE0-0025845F.00500308@notes.na.collabserv.com>
         <OF6BB8D2A0.FBBB26D8-ON0025845F.00522370-0025845F.0052E0CD@notes.na.collabserv.com>
         <7367a14c19c1d733615ea2e4c143b28fa81f6f90.camel@redhat.com>
         <20190823161551.GI12968@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-jey04sSFGUJxs60c1fiJ"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Fri, 23 Aug 2019 16:39:21 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-jey04sSFGUJxs60c1fiJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-23 at 13:15 -0300, Jason Gunthorpe wrote:
> On Fri, Aug 23, 2019 at 12:13:54PM -0400, Doug Ledford wrote:
> > On Fri, 2019-08-23 at 15:05 +0000, Bernard Metzler wrote:
> > > > > Doug,
> > > > > May I ask you to amend this patch in a way which would
> > > > > just stop this monument of programming stupidity from
> > > > > prolonging into the future, while of course recognizing
> > > > > the impossibility of erasing it from the past?
> > > > > Exchanging the %u with %d would help me regaining
> > > > > some self-confidence ;)
> > > >=20
> > > > A
> > > >  q?a:b
> > > >=20
> > > > Expression has only a single type. There are some tricky rules
> > > > on
> > > > this, but since gcc does not complain on the %u it means
> > > > 'q?(u32):(int)' is a (u32) and the -1 is implicitly casted.
> > > >=20
> > > > The better thing to write would have been U32_MAX instead of -1
> > > >=20
> > >=20
> > > What I wanted to have though is an easy to spot invalid number
> > > for the QP. This is why I wanted to have it a negative number
> > > on the screen, which is obviously not nicely achievable. So,
> > > yeah, U32_MAX is a better idea. It will not very often be a
> > > valid QP ID...
> >=20
> > Given that this patch was still the top of my tree, I fixed this
> > up.=20
> > But, I think U32_MAX is wrong.  It should be UINT_MAX (which is what
> > I
> > used).  Otherwise it will give errors on s390 where an int is 31
> > bits
> > (and anywhere else that might have a non-32 bit int).
>=20
> qp_id returns u32 and the types of both sides of the : should be
> identical

I disagree.  I would rather the constant in a situation like this be
consistent with the format specifier, which one can see right in the
line of code, than with a type of an element of a struct, which one
would have to go look up.  And the format specifier is %u, unsigned int.

> A non-32 bit int does not exist in Linux, everything would break.

Well, s390 does have a 31 bit limit, but it's just the address space,
not the int size of the registers, so you're right, I was conflating two
different things.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-jey04sSFGUJxs60c1fiJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1gFrUACgkQuCajMw5X
L93RMg/+Kr2t2qxIwCqLq3mK5YHKdzz5AJ49RZu0pGMb3b8RqIE9EHLfZcF8WGrZ
lkt+vp53Ia6RVM1scn5dl5s3FAClJHw2dcyrurZbcEjQw9u5YCwkJK3MdH2NJT4N
q5Cx+I6GYy4NgdTJcfPPHUAyZyY6mZPZQXv6TLsTb+Z7ojeZmFNQa11PAtRI5/wr
twGhtEtyVTkdBVkFkBKHRPr7CEi7Px1WLB8/ZnwYnyvsQ9glEC2GUL+ZVyT0+5Tp
V/oMgPXdkglsGohWTNgNmB5E5RmFJd0rZ2qjnKfQ1DJAoMyT5VkLK/ZbD4OaqaIl
JfYoit5IBqN0j7RTDxcIAuzHmKSl1EYcmb51mxpPyOruJx6P2VYuL/UzKGTZD5mc
OZudzbhHpOJv9ajwLPd2lOjIiDU0Ys8STKNScK1PKC6JgkF5xHjoeRazbArgIDfR
T51pKnzP/cVXGW9CnzVES87LeBr1LvIq68r63fqZ+yRtXLYL+3F09zmng/YWDBZw
4Q9oYm4ospXxq/xIHBujQsXo1a1l9LuXjj2oENWuAlhPLTpdCg0I+Q1GG9bqvHX8
N5/rH8ImedGg6hP1jBEuBP+00Mits6v5/s0fxn30WDNdMmsct+Mhsk3qNUNGHTpq
cL1jQ2hbXySyPwGPBiv6SrzZIRK2kTDE+rGTZiEoYhW9h33ymng=
=DSPt
-----END PGP SIGNATURE-----

--=-jey04sSFGUJxs60c1fiJ--

