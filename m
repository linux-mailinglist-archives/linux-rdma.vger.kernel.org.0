Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496CA30789F
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 15:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhA1Ot3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 09:49:29 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17502 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhA1Ori (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jan 2021 09:47:38 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6012ce610000>; Thu, 28 Jan 2021 06:46:57 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Jan
 2021 14:46:55 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Jan
 2021 14:46:53 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 28 Jan 2021 14:46:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVjVCICPzvqjW3egWkB+OttZqCeX/9FucutIddBkQRlKoFsmJDTaIwiarGtkendHqkzf08rSgy3ytdyexrtj8d+VsnAHTusE0lwUBjOKgefTIwQ9INWUw57SjZb9bZC1fyBOCelDkL4p2etOj0q3M+sMHllAhept337vp9ZshYSoIN0mlVfSVJqn9j2tjO8gAGMfp7MhhoQRJ3VCtGie4eCa4mjfWZJyRqHgAwa9fm+PFo32T0tx0mL9J47m0eaR+awPDQloV+cz4kX9vJwN6FHSBXVONm1knHd/fUsxP2Z8aC1mfHpkfoKy6KgfwZrqA7yRMAz6LWvWW9gPybxFcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBE3i71Ilo56wwEYQG9LXQZfN9H326eYN8WSvDNOgjk=;
 b=AQ9aDMjFWfKJsXexYkckQRHfiC/ReueVzitCsXtehV3eEpOBm78goOusKwzZjWI4L0DIwoXtP/gxHCgkR3hL9c5QLublG/VCmlJGzleNNXI+eOzvJGDZqy0ME0+M5VSI2/bbMyHAx9nu3D2/L4ecDAEBHIfHQt6OMk4hTItWJ5pMctNB1PjMcfAQpLAhyFVS+P2tDzU0JJ1tJXhG1QILNVHF8aAZ77lmbUROMi3hVXTXmulYrQc0hPdeeDwjqM+//qO3pdPQQncWukXp9kOH70IvVsQw/wvQ/OeqHTzbSWwM/uIkctJHNeDi8MAw8QcqLGpOXsnPf2WsKTigHEXkDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3403.namprd12.prod.outlook.com (2603:10b6:5:11d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Thu, 28 Jan
 2021 14:46:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 14:46:51 +0000
Date:   Thu, 28 Jan 2021 10:46:50 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20210128144650.GA61419@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
X-ClientProxiedBy: BL1PR13CA0273.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::8) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0273.namprd13.prod.outlook.com (2603:10b6:208:2bc::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.8 via Frontend Transport; Thu, 28 Jan 2021 14:46:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l58ZO-000G0E-Gh; Thu, 28 Jan 2021 10:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611845217; bh=BBE3i71Ilo56wwEYQG9LXQZfN9H326eYN8WSvDNOgjk=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:Content-Type:Content-Disposition:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=CAE6jJiRfbHXlQfFi9cgsO0GqnxMYJhgbSOqC7EZ6KgLFOT1tj06sMHcxVAWCUhjR
         O4p/w9nB7kKl06WrbI/dzJocgCwWzArQ8Pnt0p0Yd2gnlyBXf9k8bLQLJMyshlg6+B
         L9C266VSqIJRl19lzEmC8kw5LxlpakT5EQzo4e28hKzb7eeNSxLMQ2jLQCW4L0B17q
         2SrqPn7IZVHI9AmnreX19c8I7AYC9b/IZec4EOpiRmexMWkvHnJnzwr5U40u2poUsI
         UDvEfKxtFSoAVEB2JI4K0W3g/cLx2YTyy6WMbepZYUR6dUQfaEnT0mSVehOvzzT6Mf
         zPpf3Ev4IFrzw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Nothing very exciting here, more evidence that people are infrequently
testing areas, at least.

Thanks,
Jason

The following changes since commit 19c329f6808995b142b3966301f217c831e7cf31:

  Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to f1b0a8ea9f12b8ade0dbe40dd57e4ffa9a30ed93:

  Revert "RDMA/rxe: Remove VLAN code leftovers from RXE" (2021-01-20 13:29:28 -0400)

----------------------------------------------------------------
RDMA 5.11 second RC pull request

Several recent regressions and some bug fixes

- Typo corrupting the max_recv_sge for cxgb4

- Regression from re-using kernel enums as a HW AbI in vmw_pvrdma

- Sleeping inside a spinlock in hns

- Revert the attempt to fix devlink deadlocks as the fix is more buggy

- Typo in sysfs_emit_at conversions

- Revert the removal of VLAN support in rxe

----------------------------------------------------------------
Bryan Tan (1):
      RDMA/vmw_pvrdma: Fix network_hdr_type reported in WC

Joe Perches (1):
      RDMA/usnic: Fix misuse of sysfs_emit_at

Kamal Heib (1):
      RDMA/cxgb4: Fix the reported max_recv_sge value

Martin Wilck (1):
      Revert "RDMA/rxe: Remove VLAN code leftovers from RXE"

Parav Pandit (1):
      Revert "RDMA/mlx5: Fix devlink deadlock on net namespace deletion"

Yangyang Li (1):
      RDMA/hns: Use mutex instead of spinlock for ida allocation

 drivers/infiniband/hw/cxgb4/qp.c                   |  2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        |  2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            | 11 ++++++-----
 drivers/infiniband/hw/mlx5/main.c                  |  6 ++----
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c       |  7 +++----
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h          | 14 ++++++++++++++
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c       |  2 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |  6 ++++++
 drivers/infiniband/sw/rxe/rxe_resp.c               |  5 +++++
 drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h |  5 +++++
 include/linux/mlx5/driver.h                        | 18 ------------------
 include/uapi/rdma/vmw_pvrdma-abi.h                 |  7 +++++++
 12 files changed, 51 insertions(+), 34 deletions(-)

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmASzlgACgkQOG33FX4g
mxqRiQ//Tcpfe1g12hbHocyjJ5rkQXK+2idQ09BjKtn3T/iwisaLRt7nGcTMISWF
6G45g6NGVO9Q6ni9HiF3e5dQwhkICHky8RstRfQCMr2PkX4Sd1XYM6LzvtsP1tae
mC55W0L5FQGT4atSZYyn725zJB5BqFHNOsKlFyM7fQcwcCl/rXhUXrRyPs+7n4Eb
I3cRHCQ9g9nL7gN4As703hbCGxJ6MhSbbWJHR0opUhD2Ycuv6xka8b0dEMEtG6G2
ng7FvMq6DTodzfoQ3kNaFQgNMsV++MfGFiaWI83TC3m6pptAU5wOxlLTBv3Fzvno
1vejCpFIzcxeu1sWDNQePdfsSJAOdkQFqAiggfWkHAb7Yi30j5bHYsvMR89E1YMB
taHIoaz8DdclkRZvkO+Q0UjXcD//m+NdLrTMWJLXHBK5G6eWbEuZj/Iw6MuqZyVz
KG0L8UkdwhWxDLSpY5yu+zRmmGh1iGkvyf4th2fgiG4e3gdB9XwoIZ+9lIRzd+yA
3OXXQZLC1HVtXMp6arP4eLLB29uedvSPlAPEz6Hg8pFZMZIIMwF11ZBGHiAmThTy
d/68GMYIhHYq7XaYCKTolxIuLHBoW4FWI7WAd3QbSot8dsf/j9tS7cy+FD/HblAs
2uapAMujN17m4ETcF159LjtsuHZkOROKURyL8PFl5WcA5w5YTLw=
=wHsO
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
