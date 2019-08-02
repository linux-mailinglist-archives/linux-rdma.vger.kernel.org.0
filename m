Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F02F47FC60
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2019 16:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404227AbfHBOjJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Aug 2019 10:39:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404220AbfHBOjJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 2 Aug 2019 10:39:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29578307F5E8;
        Fri,  2 Aug 2019 14:39:08 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-50.rdu2.redhat.com [10.10.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 551F360623;
        Fri,  2 Aug 2019 14:39:07 +0000 (UTC)
Message-ID: <b64700fda3cd5c3cc19d6bf17c948b63a0413645.camel@redhat.com>
Subject: [PULL REQUEST] Please pull rdma.git
From:   Doug Ledford <dledford@redhat.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
Cc:     "Gunthorpe, Jason" <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 02 Aug 2019 10:39:04 -0400
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-O0kaqIfdaUKaQSfesLlu"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 02 Aug 2019 14:39:08 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-O0kaqIfdaUKaQSfesLlu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here's our second -rc pull request.  Nothing particularly special in
this one.  The client removal deadlock fix is kindy tricky, but we had
multiple eyes on it and no one could find a fault in it.  A couple
Spectre V1 fixes too.  Otherwise, all just normal -rc fodder.

Here's the boilerplate:

The following changes since commit b7165bd0d6cbb93732559be6ea8774653b204480=
:

  IB/mlx5: Fix RSS Toeplitz setup to be aligned with the HW specification (=
2019-07-25 11:45:48 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linu=
s

for you to fetch changes up to 020fb3bebc224dfe9353a56ecbe2d5fac499dffc:

  RDMA/hns: Fix error return code in hns_roce_v1_rsv_lp_qp() (2019-08-01 12=
:53:53 -0400)

----------------------------------------------------------------
Pull request for 5.3-rc2

- A couple Spectre V1 fixes (umad, hfi1)
- Fix a tricky deadlock in the rdma core code with refcounting instead
  of locks (client removal patches)
- Build errors (hns)
- Fix a scheduling while atomic issue (mlx5)
- Use after free fix (mad)
- Fix error path return code (hns)
- Null deref fix (siw_crypto_hash)
- A few other misc. minor fixes

----------------------------------------------------------------
Bernard Metzler (1):
      Do not dereference 'siw_crypto_shash' before checking

Gal Pressman (1):
      RDMA/restrack: Track driver QP types in resource tracker

Gustavo A. R. Silva (1):
      IB/hfi1: Fix Spectre v1 vulnerability

Guy Levi (1):
      IB/mlx5: Fix MR registration flow to use UMR properly

Jack Morgenstein (1):
      IB/mad: Fix use-after-free in ib mad completion handling

Jason Gunthorpe (2):
      RDMA/devices: Do not deadlock during client removal
      RDMA/devices: Remove the lock around remove_client_context

Leon Romanovsky (1):
      RDMA/mlx5: Release locks during notifier unregister

Michal Kalderon (1):
      RDMA/qedr: Fix the hca_type and hca_rev returned in device attributes

Tony Luck (1):
      IB/core: Add mitigation for Spectre V1

Wei Yongjun (1):
      RDMA/hns: Fix error return code in hns_roce_v1_rsv_lp_qp()

YueHaibing (1):
      RDMA/hns: Fix build error

 drivers/infiniband/core/core_priv.h        |   5 +-
 drivers/infiniband/core/device.c           | 102 +++++++++++++++++++------=
----
 drivers/infiniband/core/mad.c              |  20 +++---
 drivers/infiniband/core/user_mad.c         |   6 +-
 drivers/infiniband/hw/hfi1/verbs.c         |   2 +
 drivers/infiniband/hw/hns/Kconfig          |   6 +-
 drivers/infiniband/hw/hns/Makefile         |   8 +--
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c |   4 +-
 drivers/infiniband/hw/mlx5/main.c          |   7 +-
 drivers/infiniband/hw/mlx5/mr.c            |  27 +++-----
 drivers/infiniband/hw/qedr/main.c          |  10 ++-
 drivers/infiniband/sw/siw/siw_qp.c         |   6 +-
 include/rdma/ib_verbs.h                    |   4 +-
 13 files changed, 124 insertions(+), 83 deletions(-)

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-O0kaqIfdaUKaQSfesLlu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1ESwgACgkQuCajMw5X
L93gSQ/+MFROUDKYRS8mbAx1kNxOuFvhgbsTZUeDy30Nh8Yl7xy4O7VFvaDJm6Ab
THdMPD0zQOCXbHdanvDvPOm6Un53hGmTNJpeQEzw/JFblYehjXwfeD2Hw5sR2vqq
B1Mhc0Ps+ycUTqpLaSqxAYFc7P366Z71Rtbx4yxcnSS3ojSvKigF8JwZb8DkXbW2
WGkcoKLhseeVJlAb6Vei9R8dnXsPJcuWX94oYZbENKmBYTJk1lBnMW74WLqSLW/A
0Ur3Q/rKryNfuj8zNN4kYXy9YjD77tTYzqceGJIU2yz/X03sEeLCVvALp4/Bpgau
O6lDnZqErZXtwK49jKJFC2y3gKkaalodnO9vECOZZwemnpOJ9+p7bYsnMEKSwjcq
eznuyCCWXmS+zuMjmRnPIcMyYtPeHL5bXmwUC22rAgBy0INZMT1SjmBXAvLs7SSF
TyYu4tsJ26thdQkgOy46hyiuHN/hwolguqkz9odlMYI+H3laUJQ/s8ovv07dHISV
Zqi81AyEGKMWe9/psMyx1+4gol7KfXtRSEuvjmfwUhvO09Hpify5K0qGiEWwej0F
NrLqYzwyuMQxQothvRAh+ktfRUhFK1aP75rMLnwHtLimXKUY5Y+j+vYzZn46L56p
LlkgHfrEdSaFrJgCxWuMqmYNbQFndAGxQ0D8W5iTqDMMEC29NZA=
=pYZn
-----END PGP SIGNATURE-----

--=-O0kaqIfdaUKaQSfesLlu--

