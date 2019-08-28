Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B508A0655
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 17:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfH1PbF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 11:31:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfH1PbF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Aug 2019 11:31:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8B3236899;
        Wed, 28 Aug 2019 15:31:04 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-63.rdu2.redhat.com [10.10.112.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C5AC45DA8B;
        Wed, 28 Aug 2019 15:31:03 +0000 (UTC)
Message-ID: <d8f70a3e7bf0cd2da5873c75509dc39b0510c83d.camel@redhat.com>
Subject: Re: [PATCH for-next 0/9] Fixes for hip08 driver
From:   Doug Ledford <dledford@redhat.com>
To:     Lijun Ou <oulijun@huawei.com>, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linuxarm@huawei.com
Date:   Wed, 28 Aug 2019 11:31:00 -0400
In-Reply-To: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
References: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-HrFDf95R7oyRI9A3ZjKb"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 28 Aug 2019 15:31:04 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-HrFDf95R7oyRI9A3ZjKb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-08-21 at 21:14 +0800, Lijun Ou wrote:
> Here optimizes some codes and removes some warnings
> by sparse tool checking as well as fixes some defects.
>=20
> Lang Cheng (3):
>   RDMA/hns: Modify the data structure of hns_roce_av
>   RDMA/hns: Fix cast from or to restricted __le32 for driver
>   RDMA/hns: Add reset process for function-clear
>=20
> Lijun Ou (3):
>   RDMA/hns: Refactor the codes of creating qp
>   RDMA/hns: Remove the some magic number
>   RDMA/hns: Fix wrong assignment of qp_access_flags
>=20
> Wenpeng Liang (2):
>   RDMA/hns: Remove if-else judgment statements for creating srq
>   RDMA/hns: Delete the not-used lines
>=20
> Yixian Liu (1):
>   RDMA/hns: Refactor cmd init and mode selection for hip08
>=20
>  drivers/infiniband/hw/hns/hns_roce_ah.c     |  23 +--
>  drivers/infiniband/hw/hns/hns_roce_cmd.c    |  14 +-
>  drivers/infiniband/hw/hns/hns_roce_device.h |  17 +-
>  drivers/infiniband/hw/hns/hns_roce_hem.c    |  34 ++--
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  49 +++---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 256
> +++++++++++++++++++---------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   5 +-
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  18 +-
>  drivers/infiniband/hw/hns/hns_roce_mr.c     |   7 +-
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 108 +++++++-----
>  drivers/infiniband/hw/hns/hns_roce_srq.c    |  30 +---
>  11 files changed, 314 insertions(+), 247 deletions(-)
>=20

I took patches 3-9 into for-next.  Please fixup and resend 1 and 2.=20
Thanks.

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-HrFDf95R7oyRI9A3ZjKb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1mnjQACgkQuCajMw5X
L91RphAAnFiwKztaZEAc5cLAIRuR/3xEkc3BE3tytONLA83mYeV6CLdrmtxO25p3
aixOH4ddX/eA4RCXhkn5TwWY8ZPs1BSOAw0Hpcu3HkC8MjEdFp5trEIXk/RfZoHt
YdHnz7dLRXLvh0vVr5QhoTjljF960YDZVVaIqbx2LMtumINSEOyyDL6ijZu18wbD
jNxhN0Co2bftx8/B/NeV5STS8vxQAMWccBl+yFdvacuScAIl9tkow8scpAB0PCMc
UsFPuy6VTkHndCqUwLX9Mb0wXaWjRmu9B9J0Cfe3NCh+lc5VEOpLMtL6cJDtQ66a
tV9SLoHgbCcVeTHa5ka15UToeUK5pEhil7kzSwMaJ4CfXl0j9u4BJl00A1Q1J41Z
dWM2ySrhKosH3SRnVp5+Hm8fqausOujWcVyYQT/KuIOHH5P+Yi1uE7Ox2xswFviz
WPn5nI4BvWjpCnjHBGAx57geXuoQmBhcjzSGJ475l65xP1rmDnyCk0ZdvEFN7Gl5
UShuEpW5Lf5XpY9k/nKH4CZ9bZk+HETE9H5X9AFEOmNGmwgKJTtvtD8Jzy/tYDwo
DjMVM0ihJ1MnpjLUQm8icDMo5boxoHL7eUtF4XorF0O08RK2B9l3R4S2zFTEkZWt
EcvL8SYUm0oAAfG+NApvpD7Bue6BYPe23BOkjqD+ngCQZdUZHzY=
=jJWV
-----END PGP SIGNATURE-----

--=-HrFDf95R7oyRI9A3ZjKb--

