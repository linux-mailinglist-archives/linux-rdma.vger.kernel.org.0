Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 702537DFD3
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 18:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbfHAQLY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 12:11:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbfHAQLY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 12:11:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D331D3143555;
        Thu,  1 Aug 2019 16:11:23 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F259760625;
        Thu,  1 Aug 2019 16:11:22 +0000 (UTC)
Message-ID: <a0dc81b63fdef1b7e877d5172be13792dda763d2.camel@redhat.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Date:   Thu, 01 Aug 2019 12:11:20 -0400
In-Reply-To: <20190801155912.GS4832@mtr-leonro.mtl.com>
References: <44863abbef5c1e233cbedfdf959fe900f7722d74.camel@redhat.com>
         <20190731170054.GF22677@mellanox.com>
         <20190731170944.GC4832@mtr-leonro.mtl.com>
         <20190731172215.GJ22677@mellanox.com>
         <20190731180124.GE4832@mtr-leonro.mtl.com>
         <20190731195523.GK22677@mellanox.com>
         <20190801082749.GH4832@mtr-leonro.mtl.com>
         <20190801120007.GB23885@mellanox.com>
         <20190801120821.GK4832@mtr-leonro.mtl.com>
         <060b3e8fbe48312e9af33b88ba7ba62a6b64b493.camel@redhat.com>
         <20190801155912.GS4832@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ZHwAK1/j+KaZSU7psla1"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 01 Aug 2019 16:11:23 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-ZHwAK1/j+KaZSU7psla1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-01 at 18:59 +0300, Leon Romanovsky wrote:
> > There's no need for a lockdep.  The removal of the notifier callback
> > entry is re-entrant safe.  The core removal routines have their own
> > spinlock they use to protect the actual notifier list.  If you call
> > it
> > more than once, the second and subsequent calls merely scan the
> > list,
> > find no matching entry, and return ENOENT.  The only reason this
> > might
> > need a lock and a lockdep entry is if you are protecting against a
> > race
> > with the *add* notifier code in the mlx5 driver specifically (the
> > core
> > add code won't have an issue, but since you only have a single place
> > to
> > store the notifier callback pointer, if it would be possible for you
> > to
> > add two callbacks and write over the first callback pointer with the
> > second without removing the first, then you would leak a callback
> > notifier in the core notifier list).
>=20
> atomic_notifier_chain_unregister() unconditionally calls to
> syncronize_rcu() and I'm not so sure that it is best thing to do
> for every port unbind.
>=20
> Actually, I'm completely lost here, we are all agree that the patch
> fixes issue correctly, and it returns the code to be exactly as
> it was before commit df097a278c75 ("IB/mlx5: Use the new mlx5 core
> notifier
> API"). Can we simply merge it and fix the kernel panic?

As long as you are OK with me adding a comment to the patch so people
coming back later won't scratch their head about how can it possible be
right to do that sequence without a lock held, I'm fine merging the fix.

Something like:

/*
 * The check/unregister/set-NULL sequence below does not need to be
 * locked for correctness as it's only an optimization, and can't
 * be under a lock or will throw a scheduling while atomic error.
 */

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-ZHwAK1/j+KaZSU7psla1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1DDygACgkQuCajMw5X
L92T8RAAuK+rfX9LjOM4InQhYpOJJNRX2qwUOEBbzO7/ud905Jo50WvSr4N2+eWC
X64xhTFKOGVGwzpuwpjdWCunV9yOCmZjKcxx9Nb9lNKIyZPh7HqFAhku5nP82OEr
7h9EVlUbmLW+GBsCSRpLtAg2ykH3YwawRpqJAR11JsGnv+pQyQjACdaqss/1MMRe
KkjYroy6OSpS8YonAWAGFf0bIGepkJuf4kz+7+jWi3hbhWVhh6G2hR/tyrR8Jy21
itAMETFu8fDhUgRw8tpmKLv//y3wI3gPmrRwcHHPwmftnH5/pT2stcO2kFFhChtD
ojU/3YUtdTTo0KDpYpQVPfEV0R7VB1pMfQ5yLx5uuddvo901Wp5+6bQzx48wBYIA
j5WeUEeLh+fOjYFk793OK3a0oF13WbRaGM9DJpJlH3YAojoXNfJJPpNVBLgxfg0u
HqgyC6fyufN2ETlq+8nMTq0wnekmgRZwkS1cIUuG8LdGxOMlAFqa6B+Q0r6swUFN
L5zpP3S2abGkB0LCDOVGtauXHsQWnGpoQbdxToW/EB+FJ8NfrFOB3mEhZdKbKo4B
TxPxp3eMlDgb0IvDTKaQLetTbOmOcIrsip7JH9YOqfZaPacVS4LG0w+Gbsf+Xfft
UQ5LnUDg+XTnayouP1WveUkFPvodBrcnxTSZrGmv1iyxYgZ3NUQ=
=DreM
-----END PGP SIGNATURE-----

--=-ZHwAK1/j+KaZSU7psla1--

