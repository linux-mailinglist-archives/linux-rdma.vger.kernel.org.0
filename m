Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6165D7DF66
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 17:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731757AbfHAPrm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 11:47:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730486AbfHAPrl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 11:47:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 632D77A186;
        Thu,  1 Aug 2019 15:47:41 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D76019934;
        Thu,  1 Aug 2019 15:47:40 +0000 (UTC)
Message-ID: <3fefc2a4b2d1996f79a16e10a10f507e937c4023.camel@redhat.com>
Subject: Re: [PATCH -next] RDMA/hns: remove set but not used variable
 'irq_num'
From:   Doug Ledford <dledford@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     oulijun@huawei.com, xavier.huwei@huawei.com, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 01 Aug 2019 11:47:37 -0400
In-Reply-To: <20190801101023.GI4832@mtr-leonro.mtl.com>
References: <20190731073748.17664-1-yuehaibing@huawei.com>
         <20190801101023.GI4832@mtr-leonro.mtl.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ZBUAEfrpWwrAsrwkHr9d"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 01 Aug 2019 15:47:41 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-ZBUAEfrpWwrAsrwkHr9d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-01 at 13:10 +0300, Leon Romanovsky wrote:
> On Wed, Jul 31, 2019 at 03:37:48PM +0800, YueHaibing wrote:
> > Fixes gcc '-Wunused-but-set-variable' warning:
> >=20
> > drivers/infiniband/hw/hns/hns_roce_hw_v2.c: In function
> > hns_roce_v2_cleanup_eq_table:
> > drivers/infiniband/hw/hns/hns_roce_hw_v2.c:5920:6:
> >  warning: variable irq_num set but not used [-Wunused-but-set-
> > variable]
> >=20
> > It is not used since
> > commit 33db6f94847c ("RDMA/hns: Refactor eq table init for hip08")
> >=20
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 --
> >  1 file changed, 2 deletions(-)
> >=20
>=20
> I'm hitting this error too.
>=20
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

Applied to for-next, thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-ZBUAEfrpWwrAsrwkHr9d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1DCZkACgkQuCajMw5X
L91CRxAAk0lcshEW7kE4MksP6LfCupyx+1/iLbc1wvumIBUN6y9heglEogDzVrqG
MLbacj8ij+nWf+Vz8sccgHeEMofex2dOiQy/IO6P2LZW/V5Lc3KapAbQ50yGGoRH
KA1H2ue9pTFDQb8pmJqNQNh85Ns7jLImXd8cjQOS9UdK3qUhHiO81nmBL7PazNGD
fUmeE+Qu7vgzp1pi8RKkXwatT3Gexx2AQXA//Am13hslSXWtHdqlVxH90lQn+vbt
LLlRSeOvgrkECkwOtNGCe1BfrkIWvN/dku4e9yItfjOD0b2hRboG2Dtk8c1Cre0l
MdduD2M6QL7FO61fkvDxoZ3jaux0Ao4tUKhyKZ4ixfCrNO95+OkN1uELpveoG0m9
U7g+45pesorUzBYVfifIKJG4tuRzomztVY/URuWXH/27GLlcfjbeU5U17OdcXv1I
zus8pqL2sHn6G3b2hWRfmAxnv8ZT19iRYMU+P4LkY2u1GkGZ5BLtPIjQaVMg12MC
nAclnvD1oJ4d84Xg6/D8aCdl0xKe5qCMcmeUqA1AmMt2XviYxHBZmtNSrdmsH8/4
SeE3bkCLWRhrX3rLBmMdLtR6hKmrErdCUc0s9SARLtbVhw9tCQWUnWJtxnwsrMNW
CyKTXhTcYiytPnyslAFIbYsJeastIIoTupRL01SJF/K0Gy+bkDQ=
=dD21
-----END PGP SIGNATURE-----

--=-ZBUAEfrpWwrAsrwkHr9d--

