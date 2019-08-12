Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E461B8A09F
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 16:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfHLOVL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 10:21:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfHLOVL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Aug 2019 10:21:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D771D308FC4A;
        Mon, 12 Aug 2019 14:21:10 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-57.rdu2.redhat.com [10.10.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E5491001947;
        Mon, 12 Aug 2019 14:21:08 +0000 (UTC)
Message-ID: <96de3d5e500501837d9805e4cd3a96cdb28e073a.camel@redhat.com>
Subject: Re: [PATCH for-next V4 0/4] RDMA: Cleanups and improvements
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Moni Shoua <monis@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Andrew Boyer <aboyer@tobark.org>
Date:   Mon, 12 Aug 2019 10:21:06 -0400
In-Reply-To: <20190812121820.GB24457@ziepe.ca>
References: <20190807103138.17219-1-kamalheib1@gmail.com>
         <70ab09ce261e356df5cce0ef37dca371f84c566a.camel@redhat.com>
         <20190808075441.GA28049@mtr-leonro.mtl.com>
         <feab2a069bf9ac1e3c627373add292a77db86be0.camel@redhat.com>
         <20190812121820.GB24457@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-W/DlDKwHTCY4RPdvcq9s"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 12 Aug 2019 14:21:11 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-W/DlDKwHTCY4RPdvcq9s
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-08-12 at 09:18 -0300, Jason Gunthorpe wrote:
> On Thu, Aug 08, 2019 at 04:38:19PM -0400, Doug Ledford wrote:
> > On Thu, 2019-08-08 at 10:54 +0300, Leon Romanovsky wrote:
> > > On Wed, Aug 07, 2019 at 03:56:26PM -0400, Doug Ledford wrote:
> > > > On Wed, 2019-08-07 at 13:31 +0300, Kamal Heib wrote:
> > > > > This series includes few cleanups and improvements, the first
> > > > > patch
> > > > > introduce a new enum for describing the physical state values
> > > > > and
> > > > > use
> > > > > it
> > > > > instead of using the magic numbers, patch 2-4 add support for
> > > > > a
> > > > > common
> > > > > query port for iWARP drivers and remove the common code from
> > > > > the
> > > > > iWARP
> > > > > drivers.
> > > > >=20
> > > > > Changes from v3:
> > > > > - Patch #1:
> > > > >=20
> > > > > Changes from v2:
> > > > > - Patch #1:
> > > > > - Patch #3:
> > > > >=20
> > > > > Changes from v1 :
> > > > > - Patch #3:
> > > > >=20
> > > > > Kamal Heib (4):
> > > > >   RDMA: Introduce ib_port_phys_state enum
> > > > >   RDMA/cxgb3: Use ib_device_set_netdev()
> > > > >   RDMA/core: Add common iWARP query port
> > > > >   RDMA/{cxgb3, cxgb4, i40iw}: Remove common code
> > > >=20
> > > > Thanks, series applied to for-next.
> > >=20
> > > Doug,
> > >=20
> > > First patch is not accurate and need to be reworked/discussed.
> > >=20
> > > first, it changed "Phy Test" output to be "PhyTest" and second
> > > "<unknown>" was changed to be "Unknown". I don't think that it is
> > > a
> > > big
> > > deal, but who knows what will break after this change.
> >=20
> > A quick grep -r of rdma-core for "Phy Test" and "unknown" says
> > nothing
> > will break, but that doesn't attest to anything else.
> >=20
> > It is also still in my wip branch, so can be fixed directly if
> > needed.
>=20
> There is no reason to change the text so we should fix it
>=20
> Jason

Done.  Rebased to fix issue, will repush my wip branch.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-W/DlDKwHTCY4RPdvcq9s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1RddIACgkQuCajMw5X
L91mhxAAuITdlxnp9PEVMQvOYuyxNfRIJ4dvLkwpGTcgxn/ydrpek0+EVyuZAUxw
+KxSWq+CoZFJTUc3hmlsdv75KWCQhf4/LmkMXASm+L8o1IkpovtuQSR9LqMW2gp4
/uwmSefX3T9CaWa/0ruFpQ7mX8SistutJ4g1SzXiv3ipxdmmCSEatJxwUhcIGiea
6/1mcum1fSuhgmp6Y23Q7XAxykt3HczRCjzfEC2Iav9eI03wuxSZwkwBrF6pcNFv
l8+ZKaScBCu4kaUoTk94PvCnwsy20aqvKuWoNO22kQlMMEDnqMo7JlahlAlX7+y4
xfN0HW+tP2ql+6gENVgLhAE5kLM3KvMZX8mKHqQQbXgDCzjwz+XF8ExBCPOfaLD4
27Tk23LdMuU3LRgKtz1BQKHSiT+RFgrVxjNgYc3t4fKFsV8a+CKg4F0b+vaYhrj2
x2JdkMHF1Hmd8T0dPCP8agQklJMCG18e9Ds2owy6WhoDKaa8iTzyfVNKJYv94nZ/
K9/AmEF+SLO3C5w4ltrAOaSxWVi6Fe1tlXHqjR2kmjn1+q7F8B1N4Mz/VH9LgaaQ
79RcsQftJ+zsOqWR0CoM/QITV0Fz5CAWUgb7Ej9RSXYFifu2Hsk6fwgUSjpoTn3s
T1qZ17+poFHPgfS9fHdAVsujCZNR3LVlSZ0orfEMC9S3N3x/FjM=
=gm8Q
-----END PGP SIGNATURE-----

--=-W/DlDKwHTCY4RPdvcq9s--

