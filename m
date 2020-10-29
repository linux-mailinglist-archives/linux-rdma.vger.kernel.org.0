Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DC829F434
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 19:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgJ2Sl0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Oct 2020 14:41:26 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17387 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgJ2Sl0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Oct 2020 14:41:26 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9b0cdb0000>; Thu, 29 Oct 2020 11:41:31 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct
 2020 18:41:25 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 29 Oct 2020 18:41:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oz/CYlqqOdCw7/IGSCeq4abXRVkcnJOJsS7z8Ig24DjW1Pht5BZtgW/rmKC8vWuT5ReaKduDFcezdT8KyxI6LT8ttRlhUh8Er8kDdbj0lJaEEUQPxuhuomgRSnKr9/XD7vcwD/eTUGKEix4BOQHJhRjJ4Jh+sXqsnVK692RgmbFRQ2Pu7qBjfNYlULPGeYoGgqka3D1RtMFxH9/ntm5/Y8XDwwFvnw0LTTkPkRmt6KdIVYJP+pvCi5TyjbOwp+86+hKTqkCl/kN5gmnO6Rbk7oNs6du4eoXC+Sx/HCw3sTkTFF7/65SLXx9WeIX+pJNoY7ffOrXlJIZ1w3KkmVfBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Glls7vTISXRSD6YqHxBre4V7aeE/LuZZQTL9e47XHg=;
 b=kd8qY4AejJBqfrNnOe0HFQOCCw3sbfUqhSdFWXYjXC7mXqfU+/OPV0nQBA98kWhELjdbHLb2nbbMEr0mutkt6nkjK0vVDUAP7dC+G2g3Qe6EcroNZWkBSo+qe/JjNkIWOIxy3LDBZJTxvYGUyL6wpIzH5zkPNcrrbrOBvINnBWNHXlj8o5W+aXLu4SdqX76YAinPYIBcymNkS+IjXUTMYfjvVGjC6HcTGD+20ku64pIwT5938w2wF+PeIwQpzowQO6LP1WvEhmdSZyYwE1ukPZIIDgI6AqozEdzrp3Hq8jquOQ3xNyW66XLpYekjKdoHmKBtnOcGAQUKW9efWFrGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Thu, 29 Oct
 2020 18:41:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 18:41:24 +0000
Date:   Thu, 29 Oct 2020 15:41:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20201029184123.GA2920455@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:208:23d::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR06CA0022.namprd06.prod.outlook.com (2603:10b6:208:23d::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Thu, 29 Oct 2020 18:41:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kYCrT-00CFnA-38; Thu, 29 Oct 2020 15:41:23 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603996891; bh=1Glls7vTISXRSD6YqHxBre4V7aeE/LuZZQTL9e47XHg=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:Content-Type:Content-Disposition:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=UCgBT1GTvHBt4h6mwQ4C1p6dcZCBf4PSpLpkKX9+/2W1jnED9tsQuyVSR6ifrSFbh
         r3NIBwqsNgv9+YZru0YGo4dRBkRrrOwu58wueqIM432ma53zx3n+oj7qgW0zdps344
         VB3dOI5NYj4QhDzztJpB55LZVvmjSixBuaiuChyjnPp3CbWdyRNLaqRC115Ks+I/Iw
         hg1rX25ma8P6n+8uRhcfWTBkglOb8ir1M1FQMpn/UaYKsKk+nFxNxT64eGB2uAZ7nc
         /xxnfaNJn+ObvuIfiHlBcV/qv0u4I4EzdAc82ADRyO7yTbdjL9MKncFhdwj7PKI+8N
         0fnoidllf2CCA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

First rc pull request

The good news is people are testing rc1 in the RDMA world - the bad
news is testing of the for-next area is not as good as I had hoped, as
we really should have caught at least the rdma_connect_locked() issue
before now.

Here are several regression fixes for issues found by people testing
rc1.

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to a2267f8a52eea9096861affd463f691be0f0e8c9:

  RDMA/qedr: Fix memory leak in iWARP CM (2020-10-28 09:45:25 -0300)

----------------------------------------------------------------
RDMA 5.10 first rc pull request

Three notable merge window regressions that didn't get caught/fixed in
time for rc1:

- Fix in kernel users of rxe, they were broken by the rapid fix to undo
  the uABI breakage in rxe from another patch

- EFA userspace needs to read the GID table but was broken with the new
  GID table logic

- Fix user triggerable deadlock in mlx5 using devlink reload

- Fix deadlock in several ULPs using rdma_connect from the CM handler
  callbacks

- Memory leak in qedr

----------------------------------------------------------------
Alok Prasad (1):
      RDMA/qedr: Fix memory leak in iWARP CM

Bob Pearson (1):
      RDMA/rxe: Fix small problem in network_type patch

Gal Pressman (1):
      RDMA/uverbs: Fix false error in query gid IOCTL

Jason Gunthorpe (1):
      RDMA: Add rdma_connect_locked()

Parav Pandit (1):
      RDMA/mlx5: Fix devlink deadlock on net namespace deletion

 drivers/infiniband/core/cma.c                      | 48 +++++++++++++++++-----
 drivers/infiniband/core/uverbs_std_types_device.c  |  3 --
 drivers/infiniband/hw/mlx5/main.c                  |  6 ++-
 drivers/infiniband/hw/qedr/qedr_iw_cm.c            |  1 +
 drivers/infiniband/sw/rxe/rxe_av.c                 | 35 ++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_net.c                |  2 +-
 drivers/infiniband/ulp/iser/iser_verbs.c           |  2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h |  5 ---
 drivers/nvme/host/rdma.c                           |  4 +-
 include/linux/mlx5/driver.h                        | 18 ++++++++
 include/rdma/rdma_cm.h                             | 14 +------
 net/rds/ib_cm.c                                    |  5 ++-
 13 files changed, 103 insertions(+), 44 deletions(-)

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl+bDNEACgkQOG33FX4g
mxprvg//WSpcpBqrGpi0zciVV4UcBxPc7jrOEGCNhj8bWT+8wt1L/7GGVq8xviRM
chAdLzRHCChKPYWLAxOeiaOim5hMl9TR9kPHvbPc8u8HB6aqBJGoBfQzBZJgiPZO
0SCojhgcBZgERVytKveGfiNLmWAXov1rrtWz6wOmjsdlfgp3W7n6Hlh0liQQBZd4
uYytwv1IE/eatNTYJ1aMd8/4H6Tm4kmnzn3zonjMNqwkTkrpKWe9qRCTC5qEZPO8
BxVkj8sdIbkhr9xRAgsoR3pTZUBiVdzYSwPsisjuiHW4p30oAuEN6B8AzQlhkie6
2kd0RShswJ1wMoB+cYec/mE05063Kyp83/rdMJ/ZtwKENncosVNu6jdioBAderiB
ZcQalbr+yig2K6qrnnzNsokj8Lfx84X0tKzJty3FnMXv77K/YuxB54mA5BpoIRIU
LtMQq8eT8z9ELwKiR/CmZX3j9QzXzyU7TS03748XnMhRzqfg3wng09AIOkwW4S9/
G1Kl0AcwgXzEOzaPndd4Io28UBaG4rClgGMNFEwDAvcztfCfZgvtDTJ43/sO5gBM
yqJCD6B+tqifmqhW0da4v2aoWmRpXLbnYwbRUozzwW3+MFxR+opBeRdlHT6jgRWC
0rul/0eBTIjfvFQBAc8twlkVOt9vuljhxlGwe//A98CugXa6OmI=
=B0IU
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
