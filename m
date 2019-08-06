Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7D0835F6
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 17:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387473AbfHFPzn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 11:55:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729638AbfHFPzn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Aug 2019 11:55:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B35930BCB83;
        Tue,  6 Aug 2019 15:55:42 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-53.rdu2.redhat.com [10.10.112.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EDAE610002B9;
        Tue,  6 Aug 2019 15:55:41 +0000 (UTC)
Message-ID: <1243687059f6579fd5bc6c95192f8470dc19dc44.camel@redhat.com>
Subject: Re: [PATCH rdma-core 2/2] cxgb4: remove unused c4iw_match_device
From:   Doug Ledford <dledford@redhat.com>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Date:   Tue, 06 Aug 2019 11:55:22 -0400
In-Reply-To: <20190806153513.GA6210@chelsio.com>
References: <20190725174928.26863-1-bharat@chelsio.com>
         <20190725181424.GB7467@ziepe.ca> <20190728083749.GH4674@mtr-leonro.mtl.com>
         <20190729074612.GA30030@chelsio.com> <20190805110652.GB23319@chelsio.com>
         <20190806080902.GS4832@mtr-leonro.mtl.com>
         <20190806094849.GT4832@mtr-leonro.mtl.com>
         <20190806110812.GA6109@chelsio.com>
         <20190806111317.GV4832@mtr-leonro.mtl.com>
         <e94a97412c260616c8bd27d9dd361e496f15c67a.camel@redhat.com>
         <20190806153513.GA6210@chelsio.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Z9h86VDwmACQSrBaHqlD"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 06 Aug 2019 15:55:42 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-Z9h86VDwmACQSrBaHqlD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-08-06 at 21:05 +0530, Potnuri Bharat Teja wrote:
> On Tuesday, August 08/06/19, 2019 at 20:46:13 +0530, Doug Ledford
> wrote:
> > On Tue, 2019-08-06 at 14:13 +0300, Leon Romanovsky wrote:
> > > On Tue, Aug 06, 2019 at 04:38:13PM +0530, Potnuri Bharat Teja
> > > wrote:
> > > > On Tuesday, August 08/06/19, 2019 at 15:18:49 +0530, Leon
> > > > Romanovsky
> > > > wrote:
> > > > > On Tue, Aug 06, 2019 at 11:09:02AM +0300, Leon Romanovsky
> > > > > wrote:
> > > > > > On Mon, Aug 05, 2019 at 04:36:53PM +0530, Potnuri Bharat
> > > > > > Teja
> > > > > > wrote:
> > > > > > > On Monday, July 07/29/19, 2019 at 13:16:20 +0530, Potnuri
> > > > > > > Bharat Teja wrote:
> > > > > > > > On Sunday, July 07/28/19, 2019 at 14:07:49 +0530, Leon
> > > > > > > > Romanovsky wrote:
> > > > > > > > > On Thu, Jul 25, 2019 at 03:14:24PM -0300, Jason
> > > > > > > > > Gunthorpe
> > > > > > > > > wrote:
> > > > > > > > > > On Thu, Jul 25, 2019 at 11:19:28PM +0530, Potnuri
> > > > > > > > > > Bharat
> > > > > > > > > > Teja wrote:
> > > > > > > > > > > match_device handler is no longer needed after
> > > > > > > > > > > latest
> > > > > > > > > > > device binding changes.
> > > > > > > > > > >=20
> > > > > > > > > > > Signed-off-by: Potnuri Bharat Teja <
> > > > > > > > > > > bharat@chelsio.com
> > > > > > > > > > > ---
> > > > > > > > > > >  providers/cxgb4/dev.c | 41 ----------------------
> > > > > > > > > > > ----
> > > > > > > > > > > ---------------
> > > > > > > > > > >  1 file changed, 41 deletions(-)
> > > > > > > > > >=20
> > > > > > > > > > Do you know if we can also drop the same code in
> > > > > > > > > > cxgb3?
> > > > > > > > >=20
> > > > > > > > > Can we simply remove cxgb3?
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > I am in talks with the people here. I'll confirm it
> > > > > > > > soon.
> > > > > > >=20
> > > > > > > Hi Jason/Doug/Leon,
> > > > > > > Chelsio is fine with removing cxgb3.
> > > > > >=20
> > > > > > Thanks a lot.
> > > > >=20
> > > > > Which parts of cxgb3 can we remove? RDMA, scsi, net or
> > > > > everything?
> > > >=20
> > > > I can only say RDMA. For net and scsi parts of cxgb3, the
> > > > corresponding
> > > > maintainers might request for their removal.
> > > > Should I send a patch removing RDMA cxgb3?
> > >=20
> > > It will be the best variant.
> > >=20
> > > Thanks
> > >=20
> > > > Thanks.
> >=20
> > I'm not entirely sure that I want it removed yet.  The cxgb3 isn't
> > the
> > most stellar device, but it will do 40GBit/s.  That's still a very
> > respectable speed (unlike say mthca that was mostly 10GBit/s with
> > only a
> > short run of 20GBit/s devices before it switched over to mlx4).  So
> > a
> > cxgb3 based home system is still something very usable.  Are we sure
> > we
> > want to remove this?
>=20
> Hi Doug,
> Thanks for the suggestion. I took this discussion forward assuming
> that we=20
> need to remove drivers which are not/least maintained. T3 adapters
> have=20
> reached end of life long ago. Most of the times I see some
> features/changes=20
> regressing due to cxgb3's limited support. based on all these I have
> put this=20
> proposal of removing cxgb3 in front of the team at Chelsio. They are
> okay with=20
> removing it.
> I now doubt if I missed something. Do you think otherwise?
> BTW cxgb3 has supported speed is 1/10 Gbps.

[ Adding the list back in because I don't want to have to repeat this ]

I could have sworn we have 40Gig cxgb3 hardware in our lab, but it
appears I was wrong.  If we had it, it's been pulled and what's left is
all 10GigE stuff.

I did a quick search on EBay (which is where I know a lot of people go
to get dirt cheap prices on stuff like old cards to build their home
networks with) and it didn't really turn up much in the way of cxgb3
gear.  There was plenty of gear that would use the cxgb4 driver instead.
So, I'm more on board with removing this driver now.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-Z9h86VDwmACQSrBaHqlD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1JouoACgkQuCajMw5X
L92pZQ/+K4ThghjFPgLw0OmHBLDQFUm3mRxx+785nE1ifnyR1z3C4NyqHUr2aaUi
yMFoT0TxgR7Y8biAFn/L/wunIcDXymEdYb2WC6VW4y0b+8pd37IPsjCdtgKtjNMf
rEcBQevFpDc0/lja7IcRnA6rTmC2mQbMn3ljVQwbMi3ObcNLeE+9k52zQDBTLxqT
iDm9aiYklBe/ZGr4v0+PR+2MVTzH3F7Il1sPhEndr2WvN4jkgLPgTpXE01ehxCRu
NbgulEJgk9Q2q3kVvybJ2Igm1POj4KtoJx6Vi0M6v9T0Kg3L9PbA9x9mZ029GReA
0Se3FP/7HzK/Q+kzzsrcCikmtvInoIpDGfM8mRzRAGaKdO5QIa0nGrz96uxZ3Xv3
dnML/snMdeIqN29i40Rh1j9vf28Uplc4RtoZPZGZ8cxaEszJdhUd48Pd4T1+JH61
W1F2z+1JHLimVt5GaAwwDxA4VCBgcNtiWkSPBCJTMyW1UlIRZJ2fpKnw6lkvyYvC
ozj2KPkx0V29PQyrvfTOHD06BiSRNwzoOXOmVuvI+9pkeWenA176xTR4s+pnVP/w
CdAgB82seK07N1a1njRrXOHjDCOgEpTAOAEAruZtTH2wdENOGlv5nnLaYgL1T8BD
fVLE4zdmnK0kI6CrZSXYwtJ+Su23ZYgj/nEdoa3v2aUm2Z8yFUE=
=kgZP
-----END PGP SIGNATURE-----

--=-Z9h86VDwmACQSrBaHqlD--

