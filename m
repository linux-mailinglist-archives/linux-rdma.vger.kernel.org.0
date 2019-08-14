Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9526A8D6C1
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2019 16:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfHNO7O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Aug 2019 10:59:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfHNO7O (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 14 Aug 2019 10:59:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0BEB641C9;
        Wed, 14 Aug 2019 14:59:13 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com (ovpn-112-57.rdu2.redhat.com [10.10.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF0BA27BB8;
        Wed, 14 Aug 2019 14:59:12 +0000 (UTC)
Message-ID: <09bcafaab07dfde728357bfe61b6a7edfa3b25c9.camel@redhat.com>
Subject: [PULL REQUEST] Please pull rdma.git
From:   Doug Ledford <dledford@redhat.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
Cc:     "Gunthorpe, Jason" <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 14 Aug 2019 10:59:07 -0400
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-9C7C2VeN3jiOYx/dWxTp"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 14 Aug 2019 14:59:13 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


--=-9C7C2VeN3jiOYx/dWxTp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Fairly small pull request for -rc3.  I'm out of town the rest of this
week, so I made sure to clean out as much as possible from patchworks in
enough time for 0-day to chew through it (Yay! for 0-day being back
online! :-)).  Jason might send through any emergency stuff that could
pop up, otherwise I'm back next week.

The only real thing of note is the siw ABI change.  Since we just merged
siw *this* release, there are no prior kernel releases to maintain
kernel ABI with.  I told Bernard that if there is anything else about
the siw ABI he thinks he might want to change before it goes set in
stone, he should get it in ASAP.  The siw module was around for several
years outside the kernel tree, and it had to be revamped considerably
for inclusion upstream, so we are making no attempts to be backward
compatible with the out of tree version.  Once 5.3 is actually released,
we will have our baseline ABI to maintain.

Here's the boiler plate:

The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d=
:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linu=
s

for you to fetch changes up to 2c8ccb37b08fe364f02a9914daca474d43151453:

  RDMA/siw: Change CQ flags from 64->32 bits (2019-08-13 12:22:06 -0400)

----------------------------------------------------------------
Pull request for 5.3-rc3

- Fix a memory registration release flow issue that was causing a
  WARN_ON (mlx5)
- If the counters for a port aren't allocated, then we can't do
  operations on the non-existent counters (core)
- Check the right variable for error code result (mlx5)
- Fix a use after free issue (mlx5)
- Fix an off by one memory leak (siw)
- Actually return an error code on error (core)
- Allow siw to be built on 32bit arches (siw, ABI change, but OK since
  siw was just merged this merge window and there is no prior released
  kernel to maintain compatibility with and we also updated the
  rdma-core user space package to match)

Signed-off-by: Doug Ledford <dledford@redhat.com>

----------------------------------------------------------------
Bernard Metzler (1):
      RDMA/siw: Change CQ flags from 64->32 bits

Dan Carpenter (3):
      IB/mlx5: Check the correct variable in error handling code
      RDMA/siw: Fix a memory leak in siw_init_cpulist()
      RDMA/core: Fix error code in stat_get_doit_qp()

Mark Zhang (1):
      RDMA/counter: Prevent QP counter binding if counters unsupported

Yishai Hadas (2):
      IB/mlx5: Fix implicit MR release flow
      IB/mlx5: Fix use-after-free error while accessing ev_file pointer

 drivers/infiniband/core/counters.c    |  6 ++++++
 drivers/infiniband/core/nldev.c       |  8 ++++++--
 drivers/infiniband/core/umem_odp.c    |  4 ----
 drivers/infiniband/hw/mlx5/devx.c     | 11 ++++++-----
 drivers/infiniband/hw/mlx5/odp.c      | 24 +++++++++---------------
 drivers/infiniband/sw/siw/Kconfig     |  2 +-
 drivers/infiniband/sw/siw/siw.h       |  2 +-
 drivers/infiniband/sw/siw/siw_main.c  |  4 +---
 drivers/infiniband/sw/siw/siw_qp.c    | 14 ++++++++++----
 drivers/infiniband/sw/siw/siw_verbs.c | 16 +++++++++++-----
 include/uapi/rdma/siw-abi.h           |  3 ++-
 11 files changed, 53 insertions(+), 41 deletions(-)

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-9C7C2VeN3jiOYx/dWxTp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAl1UIbsACgkQuCajMw5X
L93Waw/7BBwYtlEzdT4fP+3PmeLNrqQ6jz+2uM0TMsBIR8ggOvXubpfnTv7+jqta
scsZI1i4ClqNfPo397+aQyj/GHTJpieb+5EoUYg1aEYyOoLd0OElSGVKGbbQZsjr
UZYZ//7iuKICpQ1H9bhWLWAA4kxwiYRj+8g9jFXplLwyyy/V571Ua5QCN6Noszhe
pSei/VmzKbQVd0ZfUF4NmgntAzrOEVanFQAmZyAhi8cIWFK/9N/mOU6QtAewZ+Hw
VRHyVx05Mycp5j0Z2B7HDSJFtGAxr8HXxL9RLwsl6PIG+akFo/PrCVtMkzT8Kz1z
Kk29LJSvWPoh2lEVftxYRKqLUOBGQRl7YgxSsv1S64Yz7ccLIAx3khxb11Ss0BsK
42m4Wb9NulY9ObtVnkz2XUaSQ6EDMoyXKrfZHI61HZN58LzY3CoDoy6TuugEdTHo
q0ttcalAd/w8aHurhBzQVJ35Quv14akpgpUnUb+TlxeGAOLz8e7bCNfSvkQfb6+w
kycEUXgNsOX0zbV/KkCU2r2a7jQuuI5oIT/+msCF3lJmdx7FkNssZNU5b8jJY70l
ZlEuMTvmJkvPsGyIsR/JiOd/M1MzlpgAURp58Wa/Qenq4jl9vCje9Ud5fuhnesxK
pjeX2DV+Xz/WOBuI1FOKrWp6f15+5tZCx01ycquX0/vV8tn2cto=
=4r9B
-----END PGP SIGNATURE-----

--=-9C7C2VeN3jiOYx/dWxTp--

