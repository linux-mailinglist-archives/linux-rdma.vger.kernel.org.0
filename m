Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7517DFB5
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 18:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732670AbfHAQEn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 12:04:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731613AbfHAQEn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 12:04:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 871043246FA7;
        Thu,  1 Aug 2019 15:56:47 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 863FD60BC7;
        Thu,  1 Aug 2019 15:56:46 +0000 (UTC)
Message-ID: <578335bf30e4b12dc45ca4c8a6e74e93aff7419f.camel@redhat.com>
Subject: Re: [PATCH for-rc v3] RDMA/restrack: Track driver QP types in
 resource tracker
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Date:   Thu, 01 Aug 2019 11:56:43 -0400
In-Reply-To: <20190801121254.GL4832@mtr-leonro.mtl.com>
References: <20190801104354.11417-1-galpress@amazon.com>
         <20190801121254.GL4832@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-7+armsdRi5QC8SZUUX6W"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 01 Aug 2019 15:56:47 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-7+armsdRi5QC8SZUUX6W
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-01 at 15:12 +0300, Leon Romanovsky wrote:
> On Thu, Aug 01, 2019 at 01:43:54PM +0300, Gal Pressman wrote:
> > The check for QP type different than XRC has excluded driver QP
> > types from the resource tracker.
> > As a result, "rdma resource show" user command would not show opened
> > driver QPs which does not reflect the real state of the system.
> >=20
> > Check QP type explicitly instead of assuming enum values/ordering.
> >=20
> > Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
> > Signed-off-by: Gal Pressman <galpress@amazon.com>
> > ---
> > v3:
> > * Reword commit message
> > * Change the commit in Fixes: line
> >=20
> > v2:
> > * Improve commit message
> > ---
> >  drivers/infiniband/core/core_priv.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
>=20
> Please don't forget rdmatool patch.
>=20
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

Thanks, applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-7+armsdRi5QC8SZUUX6W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1DC7sACgkQuCajMw5X
L932ug//UHrnEQbfLL/HwAZjH6bKSy/jG4JspmgKdZdiZu4lenbBj0U4m2E4erKE
wFE0B9G6XRy9vATCNcAMop+ABU54mzwbnmR0/2spafkoLcvSuYh+anlU9zdnQyn3
nO4fYKkqnPZBPSVZEZ/kpvoh9X9qG5WD/Uvk5esLEWuWBGCJ0YhDI4KMBqoKPMlv
PMFaBmys+WYtSfgXpOen1fyFbzP4W9Ks3bI7qH6uFqHy2sTt4CECvLkaxORCDl2i
xotf181xkLZXg97v2qMEMb6EvZMHhjYn4XjNMhjiH5bQe59RbUeXlPRTPK5k9csV
/bpDxKIKLKxAYfTV/BEx91/s6DqK5jc4cma+hUGtEq1Xg4xpYTQt5bps+oSiomJv
XlDNTnzoX308H3S3MMg6BkubYRRHYDtuSCt/H1uc16eC1D5VBaIrRtKotP1hVlQM
3NgzAHcn2XoyL8tw0OhlMKBDlNBJTn3+zPfv2uf/vVhvr6Odbzp65wXJZTK5lbVQ
FZXlhQ/b2iAUz9Wsp322fzPXsof2sLDGBUOdDxv94nTBigZCSm6ZWLYoAtE3cMYy
fjAhgJv2KoM6j2PsjvloeG00K51K/e8Q+CCsw2y2Tc/RL01RLiRf3dDWlSpUOPit
bI6mEDMVfR/oPoZuEvUiLdCRexWrBkHjw+SwVez7vAVLnluU5yg=
=nzez
-----END PGP SIGNATURE-----

--=-7+armsdRi5QC8SZUUX6W--

