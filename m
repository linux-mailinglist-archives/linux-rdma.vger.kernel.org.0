Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2B20E9FD
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 20:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfD2SRm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 14:17:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728748AbfD2SRm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Apr 2019 14:17:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A4CD30832F4;
        Mon, 29 Apr 2019 18:17:42 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-9.rdu2.redhat.com [10.10.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6836060851;
        Mon, 29 Apr 2019 18:17:41 +0000 (UTC)
Message-ID: <acf2b9a82e0c28a9c63d04a8153e1ff4fc814327.camel@redhat.com>
Subject: Re: [GIT PULL] Please pull rdma.git
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Gunthorpe, Jason" <jgg@ziepe.ca>
Date:   Mon, 29 Apr 2019 14:17:35 -0400
In-Reply-To: <20190429180055.GX6705@mtr-leonro.mtl.com>
References: <48cbd548d153d1d2a1cf6c4f2127a6cef5d55deb.camel@redhat.com>
         <CAHk-=wiYHXxkHrbDACc1-5bqJPuiMnmwbStSYBYo82zsO=gstQ@mail.gmail.com>
         <a532d88432b2fd581d39faf12ce3c3c31015b45a.camel@redhat.com>
         <20190429180055.GX6705@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-2eZdFUzIMtb2itTLVoq5"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 29 Apr 2019 18:17:42 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-2eZdFUzIMtb2itTLVoq5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-04-29 at 21:00 +0300, Leon Romanovsky wrote:
> On Mon, Apr 29, 2019 at 01:13:01PM -0400, Doug Ledford wrote:
> > On Mon, 2019-04-29 at 09:48 -0700, Linus Torvalds wrote:
> > > On Mon, Apr 29, 2019 at 9:29 AM Doug Ledford <dledford@redhat.com> wr=
ote:
> > > >  drivers/infiniband/core/uverbs_main.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > This trivial one-liner is actually incorrect.
> > >=20
> > > It should use 'vmf->address', because the point of the ZERO_PAGE
> > > argument is to pick the page with the right virtual address alias for
> > > broken architectures that need those kinds.
> > >=20
> > > I'm actually surprised s390 wants it, usually it's just MIPS that has
> > > the horribly broken virtual address translation stuff. But it looks
> > > like for s390 it's at least only a performance issue (ie it causes
> > > some aliases in L1 that cause cacheline ping-pong rather than anythin=
g
> > > else).
> >=20
> > That's what I get for listening to Jason ;-)
> >=20
> > Well, since you have just essentially re-written the patch to be
> > correct, you are now the developer of origin.  Do you want to commit th=
e
> > fix directly or shall I respin it for you to pull?
>=20
> Linus already committed it.
>=20
> The whole breakage is mystery for me, the patch which introduced
> breakage, got successful build report from 0-build.

Yeah, successful 0-day build is a good indicator, but not a guarantee.=20
You just can't test all possible permutations and sometimes things slip
by.  But it's still way better than 20 years ago when half the patches
weren't even compile tested before coming to Linus ;-)


--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-2eZdFUzIMtb2itTLVoq5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlzHP78ACgkQuCajMw5X
L92gIhAAhHD/7IR34R4xzYk2X98RUqCX2VTgKH7h6OBT64zivmEk/LD2La5hIztt
BwcUg1rPJRW57zRBCLHjvVuc81nxgKHBs7LEoOlk8CRrE/kao2MyzvaOBwAr/k/K
6Gj29sYFNGh0MX7/zPsccMCHR5B0vyJyn2C5XDyTflEhC2QKXiXJCKkq3cQZ63uv
21bpojWSYrYoedrTFzzakZkapX2qCxK53jKZWcqllNzjtNAbMlPctuNAReoa15bd
fUYQg6ZUQ1XhZ8H1aVBDICKvFNK1D0eNdGjhpaIlwGGCpEYzPo+EJknlIpQzJIR5
IuAbVVZ04pGpzVL71Z+XXCC3B4M4O0Gxr+6yHZ7sGD/76KZM6cAdu572kFWDoJ/J
1gAC+svTgHat7kbH/YZXaVAED7Bf5mPbcq0pfSeAbbdwtktMgNcm1rwURc/ByAFT
MQ/0X3Hz0x9gtglnX+OgBCuf/JcSSsfNHJrG7fB5UAxxrMs6gVwk1s51Ayo7Gr+l
1Grn7ESSb0cQMgs4VmzkZGzE/FtuWMor+idFp/ytSI7UrhPYTswDftVt8/9WuK7m
GteXJ0BF39SDp0UZMrY+SYRJXI8mjLSoANn/JSA+7UOMPOdKJB/rI6y1K7HM/qZD
VoWKibOfLnv58LF653qlXAAp3pmoBDLDTMktwWCWgVlEhZyTJHM=
=8lQW
-----END PGP SIGNATURE-----

--=-2eZdFUzIMtb2itTLVoq5--

