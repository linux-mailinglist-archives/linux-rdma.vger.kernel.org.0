Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C205DD0A2
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 22:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390441AbfJRUvb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 16:51:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728567AbfJRUvb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Oct 2019 16:51:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B76781103;
        Fri, 18 Oct 2019 20:51:31 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-37.rdu2.redhat.com [10.10.112.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 459435D9D5;
        Fri, 18 Oct 2019 20:51:30 +0000 (UTC)
Message-ID: <3b6fbc551c3a1c53e9365f6af5889ca38e141d3d.camel@redhat.com>
Subject: Re: [PATCH for-next] iw_cxgb3: remove iw_cxgb3 module from kernel.
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Don Dutile <ddutile@redhat.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        linux-rdma@vger.kernel.org, nirranjan@chelsio.com
Date:   Fri, 18 Oct 2019 16:51:27 -0400
In-Reply-To: <20191018204647.GA6087@ziepe.ca>
References: <20190930074252.20133-1-bharat@chelsio.com>
         <411c4ea1-4320-fa04-b014-7e5fe91869a8@redhat.com>
         <20191018204647.GA6087@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-fJp7rziJk7MJM4rnRMhh"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 18 Oct 2019 20:51:31 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-fJp7rziJk7MJM4rnRMhh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-10-18 at 17:46 -0300, Jason Gunthorpe wrote:
> On Wed, Oct 16, 2019 at 01:47:29PM -0400, Don Dutile wrote:
>=20
> > Isn't there a better way to mark a driver deprecated?
> >=20
> > This kind of removal makes long-term maintenance of such drivers
> > painful in downstream distros, as API changes that are rippled from
> > core through all the drivers, don't update these drivers, and when
> > backporting such API changes to downstream distros, we have to +1
> > removed drivers.
>=20
> You still have cxg3 as an enabled & supported driver? In RH8? Why?
> =20
> > It's much easier if upstream continues to update the drivers for
> > such across-the-driver-patch-changes.  heck, add a separate patch
> > that punches out a printk stating DEPRECATED (dropping a patch to
> > backport is easy! :) ).
>=20
> The whole point of doing this is to avoid this work!

People don't quit *using* hardware just because a company has quit
selling it.  When we can quit supporting it is more about whether
customers ask for support (or our records indicate lots of systems use
the hardware) than about whether the vendors still care.

That said, we probably could have dropped cxgb3 from 8.0, but I'm not
positive about that.  Just a guess.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-fJp7rziJk7MJM4rnRMhh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl2qJc8ACgkQuCajMw5X
L93eKRAAgIyQHmD2efzM4tMIiAfuMkwIWaI8u/55WWmWPTCGBEB3WPuLXE1K6GOu
MUhEXmI0AGIPJRcyQmpCYRHgtnWZFQS+7CnDNElF3qS3+dE57bZ7n3bsXAAIb/4R
pBZI+X/JDIv6hs6XjXeqirZIKMfSiT7zBjNsJ5rtgVfpJFlZ0dM8FeD7vmD+BcAf
xBDFYe8ISXFqtWG9DZvwyNRsqffY4bTKaqzmeXtKbKAKojRzmtnBAWImush63JAL
7S5SMhQCYlcXDrdXjVWGuiuZT4HZEytCOozo3JMx2up8sAH1hnU/X9lVD9kaNBno
3MG4rOFXRfqwsk6IZsa74JMOWcpUQ0JbVgoefEDBJUhS4NZQLQiA+9HiJctkggGq
+mi2VeKxBCoPRvKit7bYTc+gJFjK6N6fHmCbVo0+9NaNl1WpRCBx6mvmZyoARJRV
EzakjBc2rkC0swmr4EAtcRFYt/2NpSiAUyLeWjqIcNeN7VUiVwzqFMQV7wZ2RBR0
AakQXKBqrsbKYVIsnjiSx24rPKCHLr0mIx5LsmikF3JVUJqIwmXaLSVl2TtqXl7y
1CwZjkS32Ym8f7C7Ub9Jhq5O3lslUoawXSSknnGB0P3m98WLzRP4n/z+Nw5q3SCC
xX2TOgP2MYEG14YJ2XJ9qDC/lJvclfjS+osRrC1A71E/wf7jN8c=
=+4eA
-----END PGP SIGNATURE-----

--=-fJp7rziJk7MJM4rnRMhh--

