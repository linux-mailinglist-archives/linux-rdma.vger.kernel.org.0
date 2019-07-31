Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E006D7C6D7
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 17:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfGaPgM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 11:36:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbfGaPgM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 11:36:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7044EC09AD14;
        Wed, 31 Jul 2019 15:36:11 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A1DC15D6B2;
        Wed, 31 Jul 2019 15:36:10 +0000 (UTC)
Message-ID: <3c9eafe8ae94190128b82329711f5f3772756406.camel@redhat.com>
Subject: Re: [PATCH for-rc v2] RDMA/restrack: Track driver QP types in
 resource tracker
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Date:   Wed, 31 Jul 2019 11:36:08 -0400
In-Reply-To: <20190730152216.GF4878@mtr-leonro.mtl.com>
References: <20190730133720.62548-1-galpress@amazon.com>
         <20190730152216.GF4878@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-glG++wo3B7heJbkKHi+U"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 31 Jul 2019 15:36:11 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-glG++wo3B7heJbkKHi+U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-07-30 at 18:22 +0300, Leon Romanovsky wrote:
> On Tue, Jul 30, 2019 at 04:37:20PM +0300, Gal Pressman wrote:
> > The check for QP type different than XRC has wrongly excluded driver
> > QP
> > types from the resource tracker.
> > As a result, "rdma resource show" user command would not show opened
> > driver QPs which does not reflect the real state of the system.
> >=20
> > Check QP type explicitly instead of improperly assuming enum
> > values/ordering.
> >=20
> > Fixes: 78a0cd648a80 ("RDMA/core: Add resource tracking for create
> > and destroy QPs")
> > Signed-off-by: Gal Pressman <galpress@amazon.com>
> > ---
> > v2:
> > * Improve commit message
>=20
> Please finish review of v0 and give enough time for reviewers to see
> patch and post their notes before resending.

Gal, Leon was right in his comments to the v1 of this patch in terms of
the original code not being broken prior to the existence of driver qp
types.  This fix isn't needed until after the EFA driver is merged, and
the Fixes: tag is used in order for scripts to know if they need to take
a patch because they've already taken the patch prior.  So the Fixes tag
needs to be the EFA driver, not the original resource tracking commit,
as there is no issue unless the EFA driver is placed on top of the
original resource tracking commit.  Please resubmit with a proper commit
message and fixes tag.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-glG++wo3B7heJbkKHi+U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1BtWgACgkQuCajMw5X
L91aUg/+Mj1Kv4c6ZEfxsB8wLiRlo9Csn/aJTOZMKGHPacskhNWsFCSC242Nn4tH
MGOqKOVOkyb9TW0YWHcJnGO/Qoz4y4kLfUK0xw2Jr7Jc7h0iOCccFjpFXmtDhGB+
ASA12XYvIy/J+w/mW7ZcVnBqxoO8tVNLomTOIj8KOAjpLHsSoBUA+fCiVO02zu9l
LGFT0XsQMpr3Vq6GtYGve/A3dRlzG5VjtXOwSZmtHhBlndjFtWr/DyO6Es96Rp7a
O/ePQO6FlO6Lezn0bFbTiRsVnvAtG5fj+77MXAmLiMmp1ngJpxIMMUWgSEAWk0Jh
r3rcGGUWCT84BUpqDzv9vZFGg07TV/ri0Db61igmUSE2gjvLl5vo6E94D4xfcuQT
goioJf7+kSrm5yb87X18zEIT6CcnxK9sXxPyVMV/7iIFX6CNCJKFBV1keL62Ga/a
iP29uHfAcTBIOR7W5q5L9ukHT9rtC10/Mbl9TvN1/EcyOj+7qQvmth6llZHPOyaL
nUykYebadwRmyHbOr1leFpRXULGKbc/xiHmghFc4Oipb8DBEPcWcRsLz/L/BRaKk
YMrTUnvqZR3RUr+pgPAgvLceVwpxO8GiWR7n6itpoxIfMWsihtCRzbrWpyywOyqc
arLoHCFV5D5/ExmmpzI4wQkESUeZ6zJYgXw3v/FFSyruvXUGtu8=
=FJJt
-----END PGP SIGNATURE-----

--=-glG++wo3B7heJbkKHi+U--

