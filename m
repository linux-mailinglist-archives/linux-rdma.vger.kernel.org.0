Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D126438B8
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2019 17:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732390AbfFMPH6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 11:07:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbfFMOBE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Jun 2019 10:01:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DBF8C30BC591;
        Thu, 13 Jun 2019 14:00:58 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BAC3119C67;
        Thu, 13 Jun 2019 14:00:57 +0000 (UTC)
Message-ID: <8f0573322765c3a0cf6843fc71136e2eb787f5bf.camel@redhat.com>
Subject: Re: [PATCH] rdma: Remove nes
From:   Doug Ledford <dledford@redhat.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Latif, Faisal" <faisal.latif@intel.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Date:   Thu, 13 Jun 2019 10:00:55 -0400
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7A5B2A8BB@fmsmsx124.amr.corp.intel.com>
References: <20190610194911.12427-1-jgg@ziepe.ca>
         <9DD61F30A802C4429A01CA4200E302A7A5B2A8BB@fmsmsx124.amr.corp.intel.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-bmHzgdF37ki7ml8Oxmht"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 13 Jun 2019 14:01:04 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-bmHzgdF37ki7ml8Oxmht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-06-12 at 18:48 +0000, Saleem, Shiraz wrote:
> > Subject: [PATCH] rdma: Remove nes
> >=20
> > From: Jason Gunthorpe <jgg@mellanox.com>
> >=20
> > This driver was first merged over 10 years ago and has not seen
> > major activity by
> > the authors in the last 7 years. However, in that time it has been
> > patched 150 times
> > to adapt it to changing kernel APIs.
> >=20
> > Further, the hardware has several issues, like not supporting 64
> > bit DMA, that make
> > it rather uninteresting for use with modern systems and RDMA.
> >=20
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > ---
> >  .../ABI/stable/sysfs-class-infiniband         |   17 -
> >  MAINTAINERS                                   |    8 -
> >  drivers/infiniband/Kconfig                    |    1 -
> >  drivers/infiniband/hw/Makefile                |    1 -
> >  drivers/infiniband/hw/nes/Kconfig             |   15 -
> >  drivers/infiniband/hw/nes/Makefile            |    3 -
> >  drivers/infiniband/hw/nes/nes.c               | 1205 -----
> >  drivers/infiniband/hw/nes/nes.h               |  574 ---
> >  drivers/infiniband/hw/nes/nes_cm.c            | 3992 -----------
> > ------
> >  drivers/infiniband/hw/nes/nes_cm.h            |  470 --
> >  drivers/infiniband/hw/nes/nes_context.h       |  193 -
> >  drivers/infiniband/hw/nes/nes_hw.c            | 3887 -----------
> > -----
> >  drivers/infiniband/hw/nes/nes_hw.h            | 1380 ------
> >  drivers/infiniband/hw/nes/nes_mgt.c           | 1155 -----
> >  drivers/infiniband/hw/nes/nes_mgt.h           |   97 -
> >  drivers/infiniband/hw/nes/nes_nic.c           | 1870 --------
> >  drivers/infiniband/hw/nes/nes_utils.c         |  915 ----
> >  drivers/infiniband/hw/nes/nes_verbs.c         | 3754 -----------
> > -----
> >  drivers/infiniband/hw/nes/nes_verbs.h         |  198 -
> >  include/uapi/rdma/nes-abi.h                   |  115 -
> >  20 files changed, 19850 deletions(-)
> >  delete mode 100644 drivers/infiniband/hw/nes/Kconfig  delete mode
> > 100644
> > drivers/infiniband/hw/nes/Makefile
> >  delete mode 100644 drivers/infiniband/hw/nes/nes.c  delete mode
> > 100644
> > drivers/infiniband/hw/nes/nes.h  delete mode 100644
> > drivers/infiniband/hw/nes/nes_cm.c
> >  delete mode 100644 drivers/infiniband/hw/nes/nes_cm.h
> >  delete mode 100644 drivers/infiniband/hw/nes/nes_context.h
> >  delete mode 100644 drivers/infiniband/hw/nes/nes_hw.c
> >  delete mode 100644 drivers/infiniband/hw/nes/nes_hw.h
> >  delete mode 100644 drivers/infiniband/hw/nes/nes_mgt.c
> >  delete mode 100644 drivers/infiniband/hw/nes/nes_mgt.h
> >  delete mode 100644 drivers/infiniband/hw/nes/nes_nic.c
> >  delete mode 100644 drivers/infiniband/hw/nes/nes_utils.c
> >  delete mode 100644 drivers/infiniband/hw/nes/nes_verbs.c
> >  delete mode 100644 drivers/infiniband/hw/nes/nes_verbs.h
> >  delete mode 100644 include/uapi/rdma/nes-abi.h
> >=20
>=20
> Thank you!
>=20
> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>

Straight forward enough.  Applied to for-next, thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
2FDD

--=-bmHzgdF37ki7ml8Oxmht
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0CVxcACgkQuCajMw5X
L927gA/+O6Z9t7R0ZUAmIukt9xf+u1GGfL0Fz2iJi0gXVTbudD/VfnNbRHb/7ZuN
79YrCqQDcg3cJDDkFmxCofaufNG9uG3owWmP6x1XNPN+s0Lw5Ir1e85zRFLKgGGI
6iUmap/DsNMCeCaLB8SWRjbxVu1LGLY+yx5+y3vwpFCJ51YGnxt9m+UWcXpcZXkG
MOHrRB/qJYSm2wASms/kVyG/4zDeYXSEygzZPFcaTSErt0NcdzyobupJfPS+yUjq
xCDepqYoxVltoLLjo1hF9p4UN6oLGjEfP81HRvBan/GZMScGkLrAob0MhhTyzieG
Mztz5SOV8XzVEuNLeuFuhbznc3Z4XvcekboVIkxXMUUVEuBhzIErqoKt0atarL0g
gqQK5v76JcM5pJxk8xWBIJ9E1VIIeTVAhdzr8cOUy5onqgjuiHgtdk5OTYufYJNI
+HEw4m6VdIAB+SMmiEKmum+uzFXjzsz/JhtGGhOIVK0E1V/kcqGMfsnX5zFrSTus
BG1iiDaaHyCdlftQJU6eq7HL6OLZiXVN85RJIf7XiuOWGe3rVqsBL2aMimK2C73q
WAkLkroPhHZNeBnM5e+l5RCMWvxkmwX7YoUbB9PhA7HY+fsXmimvtwwMXln6Jony
Ar6s4H9/iOd+WHM8qLwilik/7711kZHuUuG449YBr/PLRkzxHyE=
=/iDI
-----END PGP SIGNATURE-----

--=-bmHzgdF37ki7ml8Oxmht--

