Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4C685345
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 20:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389402AbfHGSxW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 14:53:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389389AbfHGSxW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 14:53:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 54078629C0;
        Wed,  7 Aug 2019 18:53:21 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-53.rdu2.redhat.com [10.10.112.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B56A19C69;
        Wed,  7 Aug 2019 18:53:20 +0000 (UTC)
Message-ID: <19b1f6ad96bc2dc4d2134c32a2e79c11986ea038.camel@redhat.com>
Subject: Re: Re: [PATCH 1/1] Make user mmapped CQ arming flags field 32 bit
 size to remove 64 bit architecture dependency of siw.
From:   Doug Ledford <dledford@redhat.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
Date:   Wed, 07 Aug 2019 14:53:17 -0400
In-Reply-To: <OF3FCBE885.788F61B5-ON0025844F.002DF52F-0025844F.0061F0FB@notes.na.collabserv.com>
References: <20190806173526.GJ11627@ziepe.ca>
        ,<20190806163901.GI11627@ziepe.ca> <20190806153105.GG11627@ziepe.ca>
         <20190806121006.GC11627@ziepe.ca>
         <20190805141708.9004-1-bmt@zurich.ibm.com>
         <20190805141708.9004-2-bmt@zurich.ibm.com>
         <OFCF70B144.E0186C06-ON0025844E.0050E500-0025844E.0051D4FA@notes.na.collabserv.com>
         <OF8985846C.2F1A4852-ON0025844E.005AADBA-0025844E.005B3A41@notes.na.collabserv.com>
         <OF3F75D9B9.20A30B62-ON0025844E.005D311D-0025844E.005D8CF2@notes.na.collabserv.com>
         <OF3FCBE885.788F61B5-ON0025844F.002DF52F-0025844F.0061F0FB@notes.na.collabserv.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+bRc2u2izotTzf38/TZM"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 07 Aug 2019 18:53:21 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-+bRc2u2izotTzf38/TZM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-08-07 at 17:49 +0000, Bernard Metzler wrote:
>=20
> It hurts, but I did finally setup qemu with a ppc image to check,
> and so you are right!
>=20
> ...
>=20
> #ifdef __BIG_ENDIAN__
>=20
> seem to be available in both kernel and user land...
>=20
> But, general question: siw in its current shape isn't out
> for long, older versions from github are already broken with
> the abi. So, silently changing the abi at this stage of siw
> deployment is no option? It's a hassle to see an old mistake
> carried along forever with that #ifdef statement...no?

I was thinking about that myself.

This really hasn't been out long enough to completely tie our hands
here.  A point update to rdma-core will resolve any user side issues.=20
Are they doing stable kernel patches for the last kernel?  If so, we can
fix it both places.  No distros have picked up the original ABI in this
short of a window and managed to get it into a shipped product, so we
can notify any that might have picked up the broken version and get that
updated too if we don't dilly dally and make the call quickly.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-+bRc2u2izotTzf38/TZM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1LHh0ACgkQuCajMw5X
L9291xAAjjNSnH9oA0Zfhzx3c4bg1r4UxAVOw4eo7sD0tLiAlDtVKDtI7Jhv0Dvz
6rlJAYmgB0XVWgLccRDCG0bF2w1a0x/KGcQZYM2LsFjpGP9lCjwyKJowhxYvoKra
bmAvk/tHVeHaAysJSwNvV9dSwMqOARb3Zba8pn7n2zSGGi3zFPzmr3zT8uAdnm3b
p3W7xi3wYaVzY7O17Lh9rJUqxwnzGODqsaf1NPSi4NEhHlas1rWeghubuc61QnjC
8YzCh9kHkL3qdEleB0dTvNeQxGLFyMuJdnImPo/fvaylaouqD8K06tVdKyo5EvrR
LG8iTfsUrX5zVdjoxcbDMLHsoh7FhC4GV0jh5gl0UA39RZlEe0zWq79oZc48FbgA
fcpgY9Zlq/HUqE3h91s6sgTy0JtrBrfbp3QUFOoHtWHxO8S9gDG9AuePBxck/ZnZ
nOJtaCAlAujpPSVW2gG05WBfl2a6IjXNFeZg39lIZyxVYDZgXLRLshtgpzKmgJGj
GcOSRqzuHr2jCqZAQMVl9/x4Qirj03fOpnSkaa1ZfltkcerwoabvZ0FRpWPhSZbe
7MZ6x8yOzyahSJULl0hPw+XgX+NgmBGFkj3TXkhFO1YG6WjNTx5wtrXG+Mn4CPDF
FzoidgTIQsV4zAoXmsZk6bGUPFN1XqJ/4qD3/neOiSo9/OmtQ94=
=pNDD
-----END PGP SIGNATURE-----

--=-+bRc2u2izotTzf38/TZM--

