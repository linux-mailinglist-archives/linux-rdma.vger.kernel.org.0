Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 922DF86BAA
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2019 22:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbfHHUiZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Aug 2019 16:38:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfHHUiZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Aug 2019 16:38:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC5FF61281;
        Thu,  8 Aug 2019 20:38:24 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-57.rdu2.redhat.com [10.10.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F9545C299;
        Thu,  8 Aug 2019 20:38:22 +0000 (UTC)
Message-ID: <feab2a069bf9ac1e3c627373add292a77db86be0.camel@redhat.com>
Subject: Re: [PATCH for-next V4 0/4] RDMA: Cleanups and improvements
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Kamal Heib <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Moni Shoua <monis@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Andrew Boyer <aboyer@tobark.org>
Date:   Thu, 08 Aug 2019 16:38:19 -0400
In-Reply-To: <20190808075441.GA28049@mtr-leonro.mtl.com>
References: <20190807103138.17219-1-kamalheib1@gmail.com>
         <70ab09ce261e356df5cce0ef37dca371f84c566a.camel@redhat.com>
         <20190808075441.GA28049@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-pjtn7kVoZROs0AcCYOYV"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 08 Aug 2019 20:38:25 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-pjtn7kVoZROs0AcCYOYV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-08 at 10:54 +0300, Leon Romanovsky wrote:
> On Wed, Aug 07, 2019 at 03:56:26PM -0400, Doug Ledford wrote:
> > On Wed, 2019-08-07 at 13:31 +0300, Kamal Heib wrote:
> > > This series includes few cleanups and improvements, the first
> > > patch
> > > introduce a new enum for describing the physical state values and
> > > use
> > > it
> > > instead of using the magic numbers, patch 2-4 add support for a
> > > common
> > > query port for iWARP drivers and remove the common code from the
> > > iWARP
> > > drivers.
> > >=20
> > > Changes from v3:
> > > - Patch #1:
> > > -- Introduce phys_state_to_str() and use it.
> > >=20
> > > Changes from v2:
> > > - Patch #1:
> > > -- Update mlx4 and hns to use the new ib_port_phys_state enum.
> > > - Patch #3:
> > > -- Use rdma_protocol_iwarp() instead of rdma_node_get_transport().
> > >=20
> > > Changes from v1 :
> > > - Patch #3:
> > > -- Delete __ prefix.
> > > -- Add missing dev_put(netdev);
> > > -- Initilize gid to {}.
> > > -- Return error code directly.
> > >=20
> > > Kamal Heib (4):
> > >   RDMA: Introduce ib_port_phys_state enum
> > >   RDMA/cxgb3: Use ib_device_set_netdev()
> > >   RDMA/core: Add common iWARP query port
> > >   RDMA/{cxgb3, cxgb4, i40iw}: Remove common code
> >=20
> > Thanks, series applied to for-next.
>=20
> Doug,
>=20
> First patch is not accurate and need to be reworked/discussed.
>=20
> first, it changed "Phy Test" output to be "PhyTest" and second
> "<unknown>" was changed to be "Unknown". I don't think that it is a
> big
> deal, but who knows what will break after this change.

A quick grep -r of rdma-core for "Phy Test" and "unknown" says nothing
will break, but that doesn't attest to anything else.

It is also still in my wip branch, so can be fixed directly if needed.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-pjtn7kVoZROs0AcCYOYV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1MiDsACgkQuCajMw5X
L92quRAAg4hlLZsdlftNd4EKfl8FhYHVQ02Wb8kfEVea4aiIRQkkXuxSel7/IRoH
HMqPHdhlqYre5frUG/QzKZAvflPOs0IcZhhAqJ6ZAJvWHsNxsn7HTS4qc0OHbOt5
FBq/h0QxCVnAZs/03eIlKdA+JFGEPRGmt6TGuPBnaX83pr+fwFkL4NgtN6VPRH2Z
Of4AQNU04Yeyq7AQKGkVKEU5EaOq3v/254JhqiO1rNbuMNsUIvE0Pu29GdGPPK3e
wJVtShJMUfPmSEpOwz0Jz+q3Tn7JQqOpeCfAW0j9uBY1gOG1Zc+1pyeqoW+XaZlJ
qw6p9/6w6rwBFvkp7oqK/fhlilfWONhS4QSTucSrCCGv7jP/900zkJ2kM6E4oUkT
4if5QQ5iQne4Bktq1VQfx/KWcnvOl5Dk7zLcT49NPTgKuKoPZFel3U6gDNjw5vRO
hp61rASy9wTMMtkEUtXYjzJyDAzb89Km/0wP4KmLIOJrJinihZt47J1cG+1r5HXL
vCJQKTuwz2USULG4K3eU6WxgIevJldpDKiWRv98ccQ6J95fCRIIKqjsCSBTFSHt5
isnyxPggURVCTXYDdp0YT418/CRUkCh+dzutYK0qSQjrwAqMRjctfhk+uEtqlE5j
IgwkHRIXQQrIMyRO8ytSN3X9cQMQCGGZaYbBrPii0LdBecOePY0=
=84kC
-----END PGP SIGNATURE-----

--=-pjtn7kVoZROs0AcCYOYV--

