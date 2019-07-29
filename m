Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF2E795C5
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 21:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389209AbfG2Tpx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jul 2019 15:45:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30063 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390029AbfG2Tpw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jul 2019 15:45:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10E05745DA;
        Mon, 29 Jul 2019 19:45:52 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D742260856;
        Mon, 29 Jul 2019 19:45:50 +0000 (UTC)
Message-ID: <b5775622b2e8360e77f90dddfff9aa84af48240e.camel@redhat.com>
Subject: Re: [PATCH] rdma: siw: remove unused variable
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>, bmt@zurich.ibm.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Jul 2019 15:45:48 -0400
In-Reply-To: <20190729190326.GG17990@ziepe.ca>
References: <20190726092540.22467-1-anders.roxell@linaro.org>
         <08d1942fa99465329348a1bbfd55823b590921c2.camel@redhat.com>
         <20190729190326.GG17990@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-zQeQhpw7Z5g5BWy+Sm6P"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 29 Jul 2019 19:45:52 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-zQeQhpw7Z5g5BWy+Sm6P
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-07-29 at 16:03 -0300, Jason Gunthorpe wrote:
> On Mon, Jul 29, 2019 at 02:19:35PM -0400, Doug Ledford wrote:
> > On Fri, 2019-07-26 at 11:25 +0200, Anders Roxell wrote:
> > > The variable 'p' si no longer used and the compiler rightly
> > > complains
> > > that it should be removed.
> > >=20
> > > ../drivers/infiniband/sw/siw/siw_mem.c: In function
> > > =E2=80=98siw_free_plist=E2=80=99:
> > > ../drivers/infiniband/sw/siw/siw_mem.c:66:16: warning: unused
> > > variable
> > >  =E2=80=98p=E2=80=99 [-Wunused-variable]
> > >   struct page **p =3D chunk->plist;
> > >                 ^
> > >=20
> > > Rework to remove unused variable.
> > >=20
> > > Fixes: 8288d030447f ("mm/gup: add make_dirty arg to
> > > put_user_pages_dirty_lock()")
> >=20
> > This commit hash and the commit subject does not exist in Linus'
> > tree as
> > of today.  What tree is this being merged through, and is it slated
> > to
> > merge soon or is this a for-next item?
>=20
> This is though -mm, maybe John knows what is what

Hmmm...if it's through -mm, doesn't that mean that we can't rely on the
hash because the next time Andrew's tree rebases (using quilt or
whatever it is he does) that the hash will change?  It doesn't really
matter too much...we can't take the fix anyway, it should probably be
squashed into the patch that it's fixing, and if you follow Bernard's
advice, you fix the problem by eliminating this function and changing
the sole call site to just call put_user_pages_dirty_lock() directly.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-zQeQhpw7Z5g5BWy+Sm6P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0/TOwACgkQuCajMw5X
L92IYBAArJFeJhpQQYWGFlda2rlbsvZs2yZTilsFoMR68teBg4hc31CBsF1y34LM
A/7FJ1I2fNprtBvy2Sz/vfJ4+GT0rm9gKQFtDrA4Fro2JuOEw1LsoTOD8OrWNlsN
O8CbmKT9hrSbAGsD5CAWNybAPOFltUrNR/m9XkUytfj6EX9j1ZPFQs9QIXeqtaY3
A/mFqiPGgEcc7ROLME/z+MiW8nowz6vFQlKAOn8VGc6hKYPh2xS5kLcWQtZOWj0O
KEEsv8jm/BGvdfm6lJ4NF+pf07Bhgo+YJ3f9lw2qP6Fy7nXsFE6W75dGphSxuZf6
t78pF4exsDTr5Jy9c27btebhMnxIv1stq5Ko73RhG1jPAgfOOdYdSRmgulhasqyN
MyUhfo9JMzs+RN7UL98yQnDYIQAwU5bLd1QgdtFLcJxc3sMrFRrw7jRIb3MLpCOr
wagZ3exarpjbB8MoVIAtFKkDwWoGrA6Nh3xwYm6ZvWd0J0udA5xEMJvVpBGQAZkc
O0IMlBJxdqE1STE6fRHVA54aLzMbU+oKKPNWmfK96PStVmPz2wow2VafkVJe0ftC
EJq7xTgjmNZZIviUpGmjZS5WwQ+PDCqy4BW52GUtVmuqmRVTn64x7lePVP1vCpOG
XHb6OfxrG7RljZLXFnK5UmFuMIA/VgOE86Ai35akp3UyL0MkRjg=
=hLxB
-----END PGP SIGNATURE-----

--=-zQeQhpw7Z5g5BWy+Sm6P--

