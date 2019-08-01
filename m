Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5425F7E0A7
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 18:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbfHAQ6P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 12:58:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfHAQ6P (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 12:58:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C56D1C0BA162;
        Thu,  1 Aug 2019 16:58:14 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 714E7100032A;
        Thu,  1 Aug 2019 16:58:13 +0000 (UTC)
Message-ID: <64747a477cca5b066dd9ae8a3f26f69f37207d41.camel@redhat.com>
Subject: Re: [PATCH] RDMA/hns: Fix error return code in
 hns_roce_v1_rsv_lp_qp()
From:   Doug Ledford <dledford@redhat.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Colin Ian King <colin.king@canonical.com>
Cc:     linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Thu, 01 Aug 2019 12:58:10 -0400
In-Reply-To: <20190801012725.150493-1-weiyongjun1@huawei.com>
References: <20190801012725.150493-1-weiyongjun1@huawei.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-S1pTOHu1eOQms7iLaqVT"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 01 Aug 2019 16:58:14 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-S1pTOHu1eOQms7iLaqVT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-01 at 01:27 +0000, Wei Yongjun wrote:
> Fix to return error code -ENOMEM from the rdma_zalloc_drv_obj() error
> handling case instead of 0, as done elsewhere in this function.
>=20
> Fixes: e8ac9389f0d7 ("RDMA: Fix allocation failure on pointer pd")
> Fixes: 21a428a019c9 ("RDMA: Handle PD allocations by IB/core")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>


Thanks, applied to for-rc.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-S1pTOHu1eOQms7iLaqVT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1DGiMACgkQuCajMw5X
L92COBAAjzK3u3pLoF522VMnvbRpyUySBtHMVzeCEd9AWjnp1eqtNwih97EtniO/
pqhIpX/x3O7IdlMgsUSUZ8/pYwCcyEpWSLZcmBBtiYgtdDZJ5LffTGgnq95rRnHX
NP1yPDqnEUQRQsoJYpWl2wx2izB94ml+RWgWuEhO6jIm3dHvquLwQfP1RwjTvvBs
kgFkU5s3vRnfPD3wyihKx8g9eihdFXiu//JjL+feL53MYd116xQm0/E1hqV3c1ld
4YwVUf1L3My0HEDkfLqYYt+FqoBB64+8hMXzAXpa10eDAqmsM6Jg/yOsx6YCnhET
66Fa58vl0geGBTvZE9HmyILq7q/UtaTRErMEHpanUyoXw/JRZb5DRHiRb7qfld6y
wGt83+R2rN3OOfzwq4ZMNvRCIuXezW2SOgYg2a0zshmB8K2pE4cpGhQQtaapRMJ2
eMx9Vzze9kXgR5IgxfIJnJY6DoiaEx4gxclXEsaHaYWl7iwCEyTPL5FiInVWNKJi
bCBjNQDOumeQjlUBvmikxqn6/Ob5LyjBAM5F/lES6u+YZvTiYjGzY1sHWXYAmo+i
pZ3WKbomSvJm18IEgDNFhgifG+ZkyjycIbAgk4ZkU5oCRj2no5zYLyevnpOxY5n5
gFu+o+SlVtamLIZJ9Shco/EsPdDFHwNlYwDfdJsKaBtEHc9yumc=
=XPLG
-----END PGP SIGNATURE-----

--=-S1pTOHu1eOQms7iLaqVT--

