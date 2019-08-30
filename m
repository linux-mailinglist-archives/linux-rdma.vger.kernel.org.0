Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5910AA3A52
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2019 17:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfH3P0p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Aug 2019 11:26:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbfH3P0p (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Aug 2019 11:26:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB298300413C;
        Fri, 30 Aug 2019 15:26:44 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 045B51000322;
        Fri, 30 Aug 2019 15:26:43 +0000 (UTC)
Message-ID: <c93f66f75d118669a263b6fa40942d6df7ee8d70.camel@redhat.com>
Subject: Re: [PATCH v2 for-next 0/2] Fixes for hip08 driver
From:   Doug Ledford <dledford@redhat.com>
To:     Weihang Li <liweihang@hisilicon.com>, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Fri, 30 Aug 2019 11:26:35 -0400
In-Reply-To: <1567068102-56919-1-git-send-email-liweihang@hisilicon.com>
References: <1567068102-56919-1-git-send-email-liweihang@hisilicon.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-azx9w0rAFHT+qB7OyCRT"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 30 Aug 2019 15:26:44 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-azx9w0rAFHT+qB7OyCRT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-29 at 16:41 +0800, Weihang Li wrote:
> Here optimizes some codes and removes some warnings by sparse tool
> checking as well as fixes some defects.
>=20
> Changelog:
> v1->v2: Remove a redundant judgment in patch(1/2) as Leon Romanovsky
> 	suggested. Fix patch(2/2) as comments from Doug Ledford. Also
> 	some modifications on title and commit message.
>=20
> Lijun Ou (1):
>   RDMA/hns: Package operations of rq inline buffer into separate
>     functions
>=20
> Yixian Liu (1):
>   RDMA/hns: Optimize cmd init and mode selection for hip08
>=20
>  drivers/infiniband/hw/hns/hns_roce_cmd.c  | 10 +---
>  drivers/infiniband/hw/hns/hns_roce_main.c |  8 +--
>  drivers/infiniband/hw/hns/hns_roce_qp.c   | 95 ++++++++++++++++++--
> -----------
>  3 files changed, 61 insertions(+), 52 deletions(-)
>=20

Thanks, applied to for-next.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-azx9w0rAFHT+qB7OyCRT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1pQCsACgkQuCajMw5X
L90Gbg/9Gth86UBPXNOzgaG7ogCXFps3bLyW1Us4CrfML9ZtaxLo+pu9d4wbx1WQ
kfQpdvvPqwRqBKD5xtuNHwDDdTjL8yZHcF2Dv+TJGo3glRRA9spBcBofFPl5/yES
sVIBs7DsGYhu4re9+7qBibF4C41eechYYIHpi7ceFRn4WSEHQFbTgAd9gHtdYbyU
kz0xMK+LaIZQnhD1jjn8tL5YSQnCcBur/L9g0+seJpdoWfnZNcMptUwL0As0eLVH
h9FwRyhU0hWBRc1T9YSA9bKl98ALdJpC1QiLLZDv0q+NRV1zO4kJBizPNg9MdDD/
eEZdQT5Fybnl9+3VxTuyQv88+pj1wvGgfMigX1NbXtVSi0uQN6BHm+2BnpM7mfml
Ru9Y09NZPXtwDiwVgvwsaL7wvmFstjfF+llPSZl9aCrv0ZIXULZ5XVPKLsItoJuR
cGIJ7fdOn+xwx8bXzov0GPgAZegXMp3Xpve8ZRdC+jDL1oTJveqp8m2w9E/D4aRr
xuAUB202L0l/hwO/OHsiazYCUlzPFLkk4Qb3zeYQ30FWbW8KSp/Qcws3CFMnjcMu
zoX4LUf9wDI4/zSqzEgtAMQF08iERKGgyHIFnA8t5hNonohVVpgDJhzR/P8zVD2k
5veO2J+2KJxocvHT8D/Vu5t05oEjKgiOVkuWyLoY7/gZc+rI0DE=
=m8dT
-----END PGP SIGNATURE-----

--=-azx9w0rAFHT+qB7OyCRT--

