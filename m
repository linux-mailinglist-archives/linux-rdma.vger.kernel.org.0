Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0923C8BEAC
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2019 18:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfHMQei (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Aug 2019 12:34:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfHMQei (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Aug 2019 12:34:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE4C330C3402;
        Tue, 13 Aug 2019 16:34:37 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-57.rdu2.redhat.com [10.10.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C89FC1001281;
        Tue, 13 Aug 2019 16:34:36 +0000 (UTC)
Message-ID: <ac9cd14a089a03bf1d19ca5a938c8d6bfa1e5f70.camel@redhat.com>
Subject: Re: [PATCH for-next 0/9] Bugfixes for 5.3-rc2
From:   Doug Ledford <dledford@redhat.com>
To:     Lijun Ou <oulijun@huawei.com>, jgg@ziepe.ca
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Tue, 13 Aug 2019 12:34:34 -0400
In-Reply-To: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
References: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-YMQO3hJ3TJlkhY0XQG1g"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 13 Aug 2019 16:34:37 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-YMQO3hJ3TJlkhY0XQG1g
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-08-09 at 17:40 +0800, Lijun Ou wrote:
> Here fixes some bugs for hip08
>=20
> Lang Cheng (1):
>   RDMA/hns: Remove unuseful member
>=20
> Lijun Ou (2):
>   RDMA/hns: Bugfix for creating qp attached to srq
>   RDMA/hns: Copy some information of AV to user
>=20
> Weihang Li (1):
>   RDMA/hns: Logic optimization of wc_flags
>=20
> Xi Wang (2):
>   RDMA/hns: Bugfix for slab-out-of-bounds when unloading hip08 driver
>   RDMA/hns: bugfix for slab-out-of-bounds when loading hip08 driver
>=20
> Yangyang Li (3):
>   RDMA/hns: Completely release qp resources when hw err
>   RDMA/hns: Modify pi vlaue when cq overflows
>   RDMA/hns: Kernel notify usr space to stop ring db
>=20
>  drivers/infiniband/hw/hns/hns_roce_ah.c     | 22 ++++++--
>  drivers/infiniband/hw/hns/hns_roce_cmd.c    |  1 -
>  drivers/infiniband/hw/hns/hns_roce_device.h |  8 ++-
>  drivers/infiniband/hw/hns/hns_roce_hem.c    | 19 ++++---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 78
> +++++++++++++++++++++++------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  4 ++
>  drivers/infiniband/hw/hns/hns_roce_main.c   | 29 +++++++----
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 25 ++++++---
>  include/uapi/rdma/hns-abi.h                 |  7 +++
>  9 files changed, 148 insertions(+), 45 deletions(-)
>=20

Patches 1, 2, 4, 5, 6, and 7 applied to for-next.

I have concerns about patches 3, 8, and 9.  I'm skipping them until you
can address the comments I made on and off list.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-YMQO3hJ3TJlkhY0XQG1g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1S5poACgkQuCajMw5X
L938uQ//eTtYa0H3qw9eGA0EVDnxmYw23SdCDZJyMB6Eb9LNK3LOVfG8ZkXKJzzM
ULvp7nvbT51pQhqD32y1ZkwRAl2lNkKUCLvCrTzpbQvV3AC6xekwfe48Ktm3gEjS
J3fwtDnLm+gasr23Rgxc5tgVu/Kfry4VBi4gcdFSLjVEBzOOOq5mM8Y/ApMgYD2A
mPpZ+RImv7Kmbxozlfo/nijcc0j+KYFQuxWJSLEkt/DI59N2m2VJvnpiJ/0gItw7
8sKroRHU6R4TZP2Omm3B9dpQW8uPhEOZccnhtgsJ4nK/axXSkg6xr7X9dm8dRe+7
ylFfVLwtvZhsbfpY3Fe5uz0Hrlj5aH0OsWVohdf59CviO6Hcnd+4y5WRcRf1rSi2
gMTCC7OiUOCu6l8J+DxlOfqEW3cc0RwPL0HeqirpiS4kinaiRMw2ZmuYFC4X8eso
LYpVfYJVr5fvKEMVqtKQsB0wDvx6AjWaV8upoJLMUgH4YLH5XBtOug9ShkYSdcQP
2nt/Sx2PJAW2sWqN65YkzM07rtiQt7mGk0gBQ8uJWqSktyj7tlz4ajty6FHjM4ku
AHPnzne/qoRSJus2/kVebIz8LJjPHASL9MUzCsvB5tNdCMAbnNnc2O3m1NsJwNKq
LJKfVVyXq9cNfQ1ErlGieWFghNHicYW8XKe94wUsclNY8lcLcRE=
=fytQ
-----END PGP SIGNATURE-----

--=-YMQO3hJ3TJlkhY0XQG1g--

