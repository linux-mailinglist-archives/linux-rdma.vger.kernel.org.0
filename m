Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 204CAE886
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 19:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbfD2RNG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 13:13:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728520AbfD2RNF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Apr 2019 13:13:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09E2D30B8FAC;
        Mon, 29 Apr 2019 17:13:05 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-9.rdu2.redhat.com [10.10.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32A265D737;
        Mon, 29 Apr 2019 17:13:04 +0000 (UTC)
Message-ID: <a532d88432b2fd581d39faf12ce3c3c31015b45a.camel@redhat.com>
Subject: Re: [GIT PULL] Please pull rdma.git
From:   Doug Ledford <dledford@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Gunthorpe, Jason" <jgg@ziepe.ca>
Date:   Mon, 29 Apr 2019 13:13:01 -0400
In-Reply-To: <CAHk-=wiYHXxkHrbDACc1-5bqJPuiMnmwbStSYBYo82zsO=gstQ@mail.gmail.com>
References: <48cbd548d153d1d2a1cf6c4f2127a6cef5d55deb.camel@redhat.com>
         <CAHk-=wiYHXxkHrbDACc1-5bqJPuiMnmwbStSYBYo82zsO=gstQ@mail.gmail.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-gJ2yDr01R/2oc8/+BEOH"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 29 Apr 2019 17:13:05 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-gJ2yDr01R/2oc8/+BEOH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-04-29 at 09:48 -0700, Linus Torvalds wrote:
> On Mon, Apr 29, 2019 at 9:29 AM Doug Ledford <dledford@redhat.com> wrote:
> >=20
> >  drivers/infiniband/core/uverbs_main.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> This trivial one-liner is actually incorrect.
>=20
> It should use 'vmf->address', because the point of the ZERO_PAGE
> argument is to pick the page with the right virtual address alias for
> broken architectures that need those kinds.
>=20
> I'm actually surprised s390 wants it, usually it's just MIPS that has
> the horribly broken virtual address translation stuff. But it looks
> like for s390 it's at least only a performance issue (ie it causes
> some aliases in L1 that cause cacheline ping-pong rather than anything
> else).

That's what I get for listening to Jason ;-)

Well, since you have just essentially re-written the patch to be
correct, you are now the developer of origin.  Do you want to commit the
fix directly or shall I respin it for you to pull?

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-gJ2yDr01R/2oc8/+BEOH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlzHMJ0ACgkQuCajMw5X
L90H7hAAiqMvkiQirtFRy+LzigQmVVSRSaCsHB2aWnhDLuSSC4be+nysMtDjDU1u
0eMPSlMowbKK9ANeGZtsQCiJ9O+VpxItXGtivN1Zmk14HXMGqYByiYB82o1OOp6x
Wpvm5U1X/DXJVhrH3L8k9E8bIATetiKh+kFPFg4wBDGoDdkzMlYWCYcANha+q78r
Jo+PJ9vXzs6Pci6sKbxPuttn0GC9X3jEyo1mTSB/n5ydlbnG0oLtWZN32WqIGcbn
RQ+fkVNgEuI1/fzXZlvBZvYgIJ7RJZ1nR71GbHYTvmnMzpF56HkzdJXq878PMQGq
zGdHig+kjKN/yWniY9WrW32GcH6w+29Bni2eyPqzN+WeZhEThbuPDLlwWJyUNbEt
hrrDqtEiXrmUgJbKqcHYbg+MIdTMEHMWvO/6QvapJFB+1Ky7wldgPOv8mk35tEDF
4D10/OQSWDtCRdPit2/DP1WWEozycg7Kfqr2SLoqD5kW3sAM9dv4FZBeyvWMbySD
y8srkgjxh3Ups3eEY37AdAZyqi+wp1ft+/Qs05kSy72zHEfFZ/dPubITAedzdn/J
lDUqFCk+rOLd1fENS0Ie2F3jvvryeCsSzPqIV4v0CIOZnT+quJwYSKWH7wARZuIr
XZB259dmMQ5qbfQreXoDJHjdjtsHWt7YFhunSB9xcDJ7OB1tUz4=
=YO1c
-----END PGP SIGNATURE-----

--=-gJ2yDr01R/2oc8/+BEOH--

