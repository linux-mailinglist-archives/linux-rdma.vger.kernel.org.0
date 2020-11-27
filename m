Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDB62C6758
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Nov 2020 15:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbgK0OA4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Nov 2020 09:00:56 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5299 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730152AbgK0OA4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Nov 2020 09:00:56 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc1069f0000>; Fri, 27 Nov 2020 06:01:03 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Nov
 2020 14:00:56 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 27 Nov 2020 14:00:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoiLoJwIGAhAf/pH/QugLm30pU2PiTZohV3Fn2H8i35yZTAAAXYBXI+28b0hE1EWp43MhmCJ1+RF3rIH2K9cNHOCvUvy0y2ftr70yVoGveLVgQU9Q00TBlbZMo9eV4QmuNh4XZa5GE5g+tyqRDXdEldTNBVhX+7PdmwVK6/XN29n8w5H4ASFk9UldCSQ+g7di5ARSjqK1eKPEbNK9oicyFGNJRcpI6xJ3LBOk+FO8cC29kwqLTVR0n8b4/GMMEb8QIdPlYgGP77ka3nVCpHHhsb7eU5vl06HwbYIFy+4AGqU0TgViKoLDJUoFOZqg4ASp6IxA4GGkdV5cZuBhuzMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPnNnQOKEO9MOHhAdZ7yA6gM1k8ZRJTrxObYzmxzteU=;
 b=M2KOI0XfCE6gKN/6juX9X2PxvDeeUzcxkVNcjlUV+0xR7xsTq6H4RHyR2Pro/UxoHVtUDBmoSr+9FGjHxTQ11+eDlnSuNhq1sQ0NRrgFOM8ouOh960LBKZfFk//AHpVuVgserpcfkxhAE8xklWvT3IcpfjwvuYk/Yzu05+OvbWK71yCcLtjmJ1IFQxBTObLIC2ObGckAwh9+D84cwUun51r8T+qOP5OsWpV15/JpzWaRMEfEQpntKjugCXryAswpKUqMy+qTFk9LHks9IN2revHWZoAX6vD4r1hBzClh2ssGI4fq5hpuY1wJTIKqzzh4aIgocpZrRZswEpf4K62FpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3402.namprd12.prod.outlook.com (2603:10b6:5:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Fri, 27 Nov
 2020 14:00:54 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.025; Fri, 27 Nov 2020
 14:00:54 +0000
Date:   Fri, 27 Nov 2020 10:00:52 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20201127140052.GA644971@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:208:239::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR08CA0024.namprd08.prod.outlook.com (2603:10b6:208:239::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 14:00:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kieIu-002hzb-Mp; Fri, 27 Nov 2020 10:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606485663; bh=lPnNnQOKEO9MOHhAdZ7yA6gM1k8ZRJTrxObYzmxzteU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:Content-Type:Content-Disposition:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=eU8GgHZGnLj5EhoiechV0RZxdrGnDjMEvJ3nq6PCYaVykuuiBqnsnNyQ56ihJOnkm
         a6RkSeL6pCt2i65ArapX7vdSDcGWwrT49LoSFoO5dGJqGWefmDMGIgbA7m10vpR+rp
         o6dlqApYJo4rGN+FeHdvsQiyxPLs5Qn4Qg9IuFsWt/wtIgp5WeCOSMnoZxNUR0P9Xd
         c0RqO3nG09m0/58CA3NEz9dDLRIBkBhbPjUCy7lK1SnZO7uThz6PIvutWQ7QDa+7FZ
         yuqCvjRXzZLVLc0+ppTy8K9FRmx7ziovFhC+zkm28LxwQPGa7eWM2VEzqX12fClSlz
         e/zsoM1BFoRog==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Two security issues and several small bug fixes. Things seem to have
stabilized for this release here.

The following changes since commit 418baf2c28f3473039f2f7377760bd8f6897ae18:

  Linux 5.10-rc5 (2020-11-22 15:36:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 17475e104dcb74217c282781817f8f52b46130d3:

  RDMA/hns: Bugfix for memory window mtpt configuration (2020-11-26 10:57:32 -0400)

----------------------------------------------------------------
RDMA 5.10 fourth rc pull request

Two notable security issues and a collection of minor fixes:

- Significant out of bounds access security issue in i40iw

- Fix misuse of mmu notifiers in hfi1

- Several errors in the register map/usage in hns

- Missing error returns in mthca

----------------------------------------------------------------
Dennis Dalessandro (1):
      IB/hfi1: Ensure correct mm is used at all times

Shiraz Saleem (1):
      RDMA/i40iw: Address an mmap handler exploit in i40iw

Wenpeng Liang (2):
      RDMA/hns: Fix wrong field of SRQ number the device supports
      RDMA/hns: Fix retry_cnt and rnr_cnt when querying QP

Xiongfeng Wang (1):
      IB/mthca: fix return value of error branch in mthca_init_cq()

Yixian Liu (1):
      RDMA/hns: Bugfix for memory window mtpt configuration

 drivers/infiniband/hw/hfi1/file_ops.c      |  4 +-
 drivers/infiniband/hw/hfi1/hfi.h           |  2 +-
 drivers/infiniband/hw/hfi1/mmu_rb.c        | 68 +++++++++++++++---------------
 drivers/infiniband/hw/hfi1/mmu_rb.h        | 16 ++++++-
 drivers/infiniband/hw/hfi1/user_exp_rcv.c  | 12 ++++--
 drivers/infiniband/hw/hfi1/user_exp_rcv.h  |  6 +++
 drivers/infiniband/hw/hfi1/user_sdma.c     | 13 +++---
 drivers/infiniband/hw/hfi1/user_sdma.h     |  7 ++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  9 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_main.c   |  5 ---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c  | 37 +++-------------
 drivers/infiniband/hw/mthca/mthca_cq.c     | 10 +++--
 13 files changed, 98 insertions(+), 93 deletions(-)

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl/BBpIACgkQOG33FX4g
mxqp5w/+LC0s2iv7I1AykXdkCbXK6BnemZ8prViXvJvrUIMkegrbFc2BBchdm2ow
4iX+Uoao+l5Rt5a+iIRE0ZQPkHkygS/L1Dsxo90NwzGnmXDaGyNY2gRHYDYeUU0D
J2/96ZtZhrRA2Yajkvli6+gKTLYM6xvsC2/CIYXaJsR6WCvooBS+Zup8w2nOhh9O
lFz4urUnWadFZtqw7noM6ruZIwisIMS6WVkX7CWEsk45NcWUyDlSjcCSr04yZ4rQ
3GY9MaZeDKTC0TkRJmPNknU2/J0gR5txoiaBeeGCWv/w3ovK/gK1Tv4PTz+ueaEc
d0cVGiFm0uEpwQqaD/m5gZ/nNrbCRGMG8UVMMVWKnU7iYd7qw5elOtxHVLP3vb/J
6Tlnk1RGwLPr+fO/vOGDMurc2gqrHOWsbzVNE61Ww0GeMhyXyKQ4O2R0ceM0TEGh
7aCC7DmvkLwMuVXVa0vpcwelTAK6ycRSUFavalO65DRj58k/7y+KNZzUggNRp9Nz
cNfEsHNMjFVaWLYjoYWUjS1LtPPm0n9aU+YXzpQJB+uSfb8gQo7di2grdrSPQEWO
Rtm4Ik8x+6A4EGPF8F3mg2haF0fBeYi6VZh8giut1dYbq1uxWu60xOotrPKxOIqw
fpnOt2+PtFa/N8mv208AQXPpe96gtLblcco/W0eXwp84XuoRDh8=
=EMbV
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
