Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1787C4188E
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 01:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437013AbfFKXFS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 19:05:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436837AbfFKXFR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jun 2019 19:05:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1BCC93084249;
        Tue, 11 Jun 2019 23:05:17 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-8.rdu2.redhat.com [10.10.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 340D51001B01;
        Tue, 11 Jun 2019 23:05:15 +0000 (UTC)
Message-ID: <0ca5427ff2654b274b64098c9fa4586895a2a84e.camel@redhat.com>
Subject: Re: [PATCH for-next] RDMA/ipoib: Remove check for ETH_SS_TEST
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Date:   Tue, 11 Jun 2019 19:05:12 -0400
In-Reply-To: <20190610131242.GX6369@mtr-leonro.mtl.com>
References: <20190530131817.6147-1-kamalheib1@gmail.com>
         <20190607120952.GJ5261@mtr-leonro.mtl.com>
         <338cf9cde79ee9d734d8d854a342731e0da7e962.camel@gmail.com>
         <20190610131242.GX6369@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-k6CnsgNM4cPz8BcTwQNN"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 11 Jun 2019 23:05:17 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-k6CnsgNM4cPz8BcTwQNN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-06-10 at 16:12 +0300, Leon Romanovsky wrote:
> On Mon, Jun 10, 2019 at 01:59:31PM +0300, Kamal Heib wrote:
> > On Fri, 2019-06-07 at 15:09 +0300, Leon Romanovsky wrote:
> > > On Thu, May 30, 2019 at 04:18:17PM +0300, Kamal Heib wrote:
> > > > Self-test isn't supported by the ipoib driver, so remove the
> > > > check
> > > > for
> > > > ETH_SS_TEST.
> > > >=20
> > > > Fixes: e3614bc9dc44 ("IB/ipoib: Add readout of statistics using
> > > > ethtool")
> > > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > > > ---
> > > >  drivers/infiniband/ulp/ipoib/ipoib_ethtool.c | 2 --
> > > >  1 file changed, 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
> > > > b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
> > > > index 83429925dfc6..b0bd0ff0b45c 100644
> > > > --- a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
> > > > +++ b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
> > > > @@ -138,7 +138,6 @@ static void ipoib_get_strings(struct
> > > > net_device
> > > > __always_unused *dev,
> > > >  			p +=3D ETH_GSTRING_LEN;
> > > >  		}
> > > >  		break;
> > > > -	case ETH_SS_TEST:
> > >=20
> > > The commit message and code doesn't match each other.
> > > Removing this specific case will leave exactly the same behaviour
> > > as
> > > before, so why should we change it?
> > >=20
> >=20
> > The idea is very simple, no point of checking ETH_SS_TEST if the
> > ipoib
> > doesn't support it.
>=20
> Please write in commit message, that "default" option means
> "unsupported" and
> there is no need in explicit declaration of unsupported ETH_SS_TEST.
>=20
> Thanks

With an appropriate fix to the commit message, applied to for-next,
thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
2FDD

--=-k6CnsgNM4cPz8BcTwQNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0AM6gACgkQuCajMw5X
L90NGg//boywrdbwne1RCnjKKeFWEK6mWBVboO8kx2SfNLuE46tcAQBXH/z+wL8l
XUPLL5qwerHprEqMIfrB0vkCzmLuRVbzU+KJpggQ8s2wWkPx9s+jEHf+HSllHMt/
+XlR3kYp1e1rQS4ZpJjATirl/jMpGjn1F/R0n7MWs8X+WdgYhIVEwrx1MxNIvumD
DrhCOWbaOjGt3/4vfqxFFlD5NNS6q8S+DiaoPqtusnkY4st+i0FDxY4/C6zYqmsi
1ua68m+UGpBaOSvt9oPfqtcmDQ2meR1cLVFaWBSqEPoLvQHUNi/dtImGVV9Kf7Ee
r+cDLdaH5HtoncQblVyaA2ejUKheGpwLLxQpP4VJATyhbWe7ucPmJulNw2ecv8nq
zwGfVQ4HvbMAznukPsYRv3bLrs3eqJyoCLv6xuHClZm8MoOKOpcR/4E/02HOGshu
5Ikw+QpE+L+Bi3Zmh5Upa0BcHxc0l9wmEiRGPqbtqlW9U3cIl9UGWPpzmRUdifh5
dGFNRv4Lrjpd4qOQd7U2a4HstSNf9RAq4SY4zy0LuUDs5fwLOmAdoe9yHas9ZL+n
9yUl6j74SPoR6YkF9bPVqfkrEEyKZpc3l7HrsEKo/UJACa8bWjyE9cUj3+fAk1la
DlUmeOagpJrIsSNK3NNp9sqltVFbf1PDYi6SBpWz0RslVbiW0Xw=
=VDXg
-----END PGP SIGNATURE-----

--=-k6CnsgNM4cPz8BcTwQNN--

