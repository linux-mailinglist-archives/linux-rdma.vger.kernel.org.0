Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48DF2A85F8
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 19:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbgKESQn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 13:16:43 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:35005 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729862AbgKESQn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Nov 2020 13:16:43 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa441890002>; Fri, 06 Nov 2020 02:16:41 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Nov
 2020 18:16:41 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 5 Nov 2020 18:16:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R642JVGx+r9FgdZO0ChQXNWC/W7e19MnslxuhvTOmFFNjTGvMZgJfbTJNJxrVZoNNVd27ytAb5xbCpHKZNyCa+G8MhOiAGnE0OhEbqcrOQDSY/nCzyzvjNWff7+tFlMDqNbHQOa5obRQXXj7D+PKDXx/5pR3KA690kbKbkGg1CF5H3I23zQaB8qFnaARPWMPKUtqQKu/Ij9jfFTTl3rUaNEx1JD49ERo2dctDOskY9C1qJjWYGLACgGErcrs2Xo84iBVsCWaMLapGUHnOsV+oGEbEYG/uIpdpKDjSICT3IImQ7/0XE4DTkYYx9JlHNnEMJo2YDpyobZQEUw+rPo+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qt2MBORNprEcbhifb092rJzzK4Mjx7pU047ykOASX2k=;
 b=jfatVrvXQPJqfuYLwBo9U1b10J4Y7/WQvGehaaA5O2/M6UIVohcDa8575NcdsN4RSBuHCSf+nq0STCTXG3QGooERI+Aa0BbY0YfBQx+tq2L+F4oQpjwGAGRa1VN39r0q3OEhPsdVegX0SPKfH71v2AERRULU6GHneoljkS9YNy1v/Woa9ci1AsxajuvUuIzXxVyu71B4WO6x0PwQCwR0gzcLbMa0Z6DRH6KWXcQxvKjMcoY6tLOjfa4GBfFH3ggYqJG/9EGE78PwQi9LaGN9Z2d2OhvDZSqbFgaPUN06o75Vq4MGMGYl+RcMDCMWMl5h9jNCcp9cbrF2yjzyUjjImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1146.namprd12.prod.outlook.com (2603:10b6:3:73::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 5 Nov
 2020 18:16:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 18:16:38 +0000
Date:   Thu, 5 Nov 2020 14:16:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20201105181636.GA80666@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
X-ClientProxiedBy: BL0PR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:207:3d::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0051.namprd02.prod.outlook.com (2603:10b6:207:3d::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 5 Nov 2020 18:16:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kajoK-000Kzu-Q0; Thu, 05 Nov 2020 14:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604600201; bh=qt2MBORNprEcbhifb092rJzzK4Mjx7pU047ykOASX2k=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:Content-Type:Content-Disposition:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=oAmFxl54NDjB3ShrKyIYkkh7hiAorTqjLQVV3ow9PPhlDm/ILhdY1mNIhsepTu8Eq
         mq1wsgn/zZyb+5SOcWJieAiOp/V6+ndH7gMUJCVKC/p1b45WJIxp+KSmYm4gjV4tH5
         8gqKNg9sNG8SMQyRsyaZpwI0t1fY5ZEmzk1rwax9Edy+6D/NvThlHZ+xNeBNgCtls9
         RBCcgeyibislyFHi7xdsn8jR8zuMHYwArt+RmCmoLQa+R0TyZb8WmFPkvGIpet3cb2
         BUkeivJfPRRyF3YTkfpoSMEA14mcjx95LBZc68VLS7CIeZ1IqqVeViYhOJK9JAGgMs
         Z0JEUOSOYNXqg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

This rc cycle continues to be challenging with an abnormal number of
regressions.

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 21fcdeec09ff461b2f9a9ef4fcc3a136249e58a1:

  RDMA/srpt: Fix typo in srpt_unregister_mad_agent docstring (2020-11-05 11:38:29 -0400)

----------------------------------------------------------------
RDMA 5.10 second rc pull request

A few more merge window regressions that didn't make rc1:

- New validation in the DMA layer triggers wrong use of the DMA layer in
  rxe, siw and rdmavt

- Accidental change of a hypervisor facing ABI when widening the port
  speed u8 to u16 in vmw_pvrdma

- Memory leak on error unwind in SRP target

----------------------------------------------------------------
Adit Ranadive (1):
      RDMA/vmw_pvrdma: Fix the active_speed and phys_state value

Jason Gunthorpe (1):
      RDMA/srpt: Fix typo in srpt_unregister_mad_agent docstring

Maor Gottlieb (1):
      IB/srpt: Fix memory leak in srpt_add_one

Parav Pandit (1):
      RDMA: Fix software RDMA drivers for dma mapping error

 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h |  2 +-
 drivers/infiniband/sw/rdmavt/vt.c               |  7 +++++--
 drivers/infiniband/sw/rxe/rxe_verbs.c           |  6 +++++-
 drivers/infiniband/sw/siw/siw_main.c            |  7 +++++--
 drivers/infiniband/ulp/srpt/ib_srpt.c           | 13 ++++++++-----
 5 files changed, 24 insertions(+), 11 deletions(-)

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl+kQYIACgkQOG33FX4g
mxp2MhAAnO+gJaicBUqkAixpXnxoNd0CMajHyAtIdY3RcgRrNBOaaIFXtigWR+2V
0aJIfBIpnNraHUr5DWydCqM7g3o16PFQkszmIOHzvpl/JGRRYzs0Hhi+yZIIjyQR
gEUizH6uOWFHjlgEASRV7BCar8obSkfb3Dt4HKpRSEZVpPqhbNhPq4gZO6cpkE7R
S5sMN+YCdbpXrX6q/BFZsTOnFH1j3aRChuxTxZfjQO1+ioGgjOMTbzVP8p+wNzke
WFjmHV4NR4OLi4HzPxEp+8lBcvtDlzogEF+/qld8nzu7hxRoK9KeSniIH6XhDjkS
cADN1pvJeY5HMHbzbRasNkFno8InZZn89e1dzNl4y8reefLOjMetSB0TQrj5rYmC
PupsyAzqDFeGY18ZGSwuhJ4f2E2o2+Wqvhqy7LQw/omNv5beLityg5xaWluXVBGm
2Y3n1jdlaIXGJhCTeafysEDxcZsrHwrR0YKwYiSa6tC+z5NPHrkX1KQlZertTCi2
OzSI60vTEKqurIqNbIhn/2tTIv+jkImOZYdmHpVxrhrZTLyaJfewX0+N/YGYrN9f
JIFSLsva5blMRp/vPrdXvFj/frJ9bWM5mxDO2PbTRLKo923cVBlomHtqyqWAMksu
2eW749WXKzwBiIJnkIKho3UP4J5fWBa3bAfe9BDiLg9GylSL8Os=
=HsWj
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
