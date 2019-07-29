Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5971879048
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 18:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfG2QFZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jul 2019 12:05:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfG2QFZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Jul 2019 12:05:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E9F683F4C;
        Mon, 29 Jul 2019 16:05:24 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15A8660856;
        Mon, 29 Jul 2019 16:05:22 +0000 (UTC)
Message-ID: <f57097de34db9778f0e5f24abc0067e0ee11b74f.camel@redhat.com>
Subject: Re: [PATCH] RDMA/hns: Fix build error
From:   Doug Ledford <dledford@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, YueHaibing <yuehaibing@huawei.com>
Cc:     oulijun@huawei.com, xavier.huwei@huawei.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Jul 2019 12:05:20 -0400
In-Reply-To: <20190724113252.GA28493@ziepe.ca>
References: <20190723024908.11876-1-yuehaibing@huawei.com>
         <20190724065443.53068-1-yuehaibing@huawei.com>
         <20190724113252.GA28493@ziepe.ca>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-CYvwRzUhBa6QpQtUigcr"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 29 Jul 2019 16:05:24 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-CYvwRzUhBa6QpQtUigcr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-24 at 08:32 -0300, Jason Gunthorpe wrote:
> On Wed, Jul 24, 2019 at 02:54:43PM +0800, YueHaibing wrote:
> > If INFINIBAND_HNS_HIP08 is selected and HNS3 is m,
> > but INFINIBAND_HNS is y, building fails:
> >=20
> > drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function
> > `hns_roce_hw_v2_exit':
> > hns_roce_hw_v2.c:(.exit.text+0xd): undefined reference to
> > `hnae3_unregister_client'
> > drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function
> > `hns_roce_hw_v2_init':
> > hns_roce_hw_v2.c:(.init.text+0xd): undefined reference to
> > `hnae3_register_client'
> >=20
> > Also if INFINIBAND_HNS_HIP06 is selected and HNS_DSAF
> > is m, but INFINIBAND_HNS is y, building fails:
> >=20
> > drivers/infiniband/hw/hns/hns_roce_hw_v1.o: In function
> > `hns_roce_v1_reset':
> > hns_roce_hw_v1.c:(.text+0x39fa): undefined reference to
> > `hns_dsaf_roce_reset'
> > hns_roce_hw_v1.c:(.text+0x3a25): undefined reference to
> > `hns_dsaf_roce_reset'
> >=20
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Fixes: dd74282df573 ("RDMA/hns: Initialize the PCI device for hip08
> > RoCE")
> > Fixes: 08805fdbeb2d ("RDMA/hns: Split hw v1 driver from hns roce
> > driver")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >  drivers/infiniband/hw/hns/Kconfig  | 6 +++---
> >  drivers/infiniband/hw/hns/Makefile | 8 ++------
> >  2 files changed, 5 insertions(+), 9 deletions(-)
>=20
> did you test this approach with CONFIG_MODULES=3Dn?

This version of the patch looks like the right fix.

Applying to for-rc, thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-CYvwRzUhBa6QpQtUigcr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl0/GUAACgkQuCajMw5X
L92dyhAAwOwf6FIG80LboLEhGbwdsAcYn/MWmplhDW38rT+sXO8TBe3D1XMwyysL
V4PTYZBB2XmXy59VKyeg35ZliGzEWyN0AMVKCffIk1JhwBABkvebWC60BoFSaHQ5
1GE+EG31UfX9FE8xY+wLeUSAyhS01pONKGEoPSgWRYciyRHEO4UfQhR8nbsFzTlm
b9CzS5Zq7czDnErMr/CeKEKSs0ecGPWkKBv+vTBUUGxhTqRzmjHV3XXiVihPUDtc
hx/Ofif6PDsa71UiFJZvjEU6kfVDbnybbTNz4SkQ4f3O5T7y959pLUD0J2MgK1pV
ljY5w1SD+IM6t7wAWElwBiU93ZEQrMyYaWZs3yzO4x3qqQu1O+eTsx/TD6kAaTu+
qYlYmtsD0np6w5uNHP2zivWMAGTKHNZ1eJwWMJhTp0343AixsK6lfAGk6knkA/5B
sGyuZfSnydEkJDtvfIuioNFpteIuBvMUjG9wxRaR/KZnufvZNK8berpmFmY09+hX
QR1wu7csB8frawvL9za4hCkKy48TuJTpBvcFjAjohgE1VAfajSr+dzyuW/kYP/hN
RY9WBBF+HgLc9QSiIjk/Ze2NNdRg1tOrR6vsWFKU2lqNCW+xonmIuSeCLG7DYBgi
AOaf0qs0CEOsNtTUXTv6s1HsAmknT5kRc36Z3aFK382FTSWAr88=
=FEc+
-----END PGP SIGNATURE-----

--=-CYvwRzUhBa6QpQtUigcr--

