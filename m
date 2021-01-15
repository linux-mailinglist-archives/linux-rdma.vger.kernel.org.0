Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA8F2F854A
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Jan 2021 20:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387715AbhAOTWY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Jan 2021 14:22:24 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2600 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbhAOTWX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Jan 2021 14:22:23 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6001eb470000>; Fri, 15 Jan 2021 11:21:43 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 15 Jan
 2021 19:21:43 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 15 Jan 2021 19:21:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql318WnV6V6oKxLhwzRd0wFlyqsJ0y0tsjObXLLspsfRD4WGqqc0wdXptdLGjFJ7NG7GH98dyVQgSC7c9FQnmp6c616wiIK4um302R9xM1XieWrYBwY7TH1CRNz1b94qNC62aG7yNBJ8avbNHyCvye5OaiLvndXFKEUg7uA7ExPYtr0Zwt5yQSPo9vEfAKDKmK7vDw2OByPFWj0TNHfqDsi3uMPnix4CX/UzC5iY8A7ZBt2fK/wIsMoWuPz3oUGjvdnSiB7xtBC6c06x91/D6ICYptX1j/t09wGnwvygIkfR45or2LzlDH/r9nq4qGMODOWsiC17m3/jZmIfzfOu2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/D3PUqldU5lR3YQKO/piSWwpCp7XwyRvE3VQgGm/DY=;
 b=OyfnZu8t6d6Bdi9jYkcRZDCoUdutGcfflXzWYnpcb+vd+ZSbWut0p2Vbn3BJPi7D5aTEaC9Gq9fH4+PnNVF3xfE99yTNmedRkhTZIalhhC758K0eXr9io8RVLKcRahlh73QtsuWx/ujNqoe31PAwXuM9iCxm8+Rm4eoctXcTqiywpNdmizmhoQ9SbDndJIqAmJx4x+xOrIrUqkEIDhVlZMWIB8zGnmoac8Ve9oiRrrO0KMVuEMHpCz/apu8iUfFzypbWGu3eD6xwp9hHAPTKflL4olxU+0tURN43yDzB+zUXWukAe9G9rvKyQ+2RysqoUu/WrsCOP8aJYEa9LL/UcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.10; Fri, 15 Jan
 2021 19:21:41 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.012; Fri, 15 Jan 2021
 19:21:41 +0000
Date:   Fri, 15 Jan 2021 15:21:40 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20210115192140.GA456837@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:208:120::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR10CA0012.namprd10.prod.outlook.com (2603:10b6:208:120::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Fri, 15 Jan 2021 19:21:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l0UfE-001urk-8U; Fri, 15 Jan 2021 15:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610738503; bh=n/D3PUqldU5lR3YQKO/piSWwpCp7XwyRvE3VQgGm/DY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:Content-Type:Content-Disposition:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=RvMD1WZvza9PKrlFUoQ786R+OTaiSHPJXzRTNgskOOJek5jEOknU9IIfEWp89kV2b
         uZTVgtxDPH3dcnBJldArPOrjDW5Knzn3rywhrSLDzFbAf824mq0H0Yn2Vvm8IF4TR7
         SCTwk0YcVORhlYNT2UoVMI01tFNcjG5DE109PHNZKxaOBdXSPLYUzKVXp3i81kn609
         Wv4XpG6qFLhdXwXqLJFSQ47qbmyF/AVWsui5uMnuGdE2wfg1IRqasWSbDQrCGclkzj
         P1DKJyUo11n41F4P/I9v9IDhy0wCtGIAdQE+aQHTdQUcpw/X9NI+GqcaTSNhxY4fDY
         tqXM0IWgaw/GQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Bit later for the first rc pull request than normal due to the
holidays, but a fairly modest set of bug fixes, nothing abnormal from
the merge window

The ucma patch is a bit on the larger side, but given the regression was
recently added I've opted to forward it to the rc stream.

Thanks,
Jason

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 7c7b3e5d9aeed31d35c5dab0bf9c0fd4c8923206:

  RDMA/cma: Fix error flow in default_roce_mode_store (2021-01-14 12:53:13 -0400)

----------------------------------------------------------------
RDMA 5.11 first RC pull request

Several bug fixes.

- Fix a ucma memory leak introduced in v5.9 while fixing the Syzkaller
  bugs

- Don't fail when the xarray wraps for user verbs objects

- User triggerable oops regression from the umem page size rework

- Error unwind bugs in usnic, ocrdma, mlx5 and cma

----------------------------------------------------------------
Aharon Landau (1):
      RDMA/umem: Avoid undefined behavior of rounddown_pow_of_two()

Dinghao Liu (1):
      RDMA/usnic: Fix memleak in find_free_vf_and_create_qp_grp

Jason Gunthorpe (1):
      RDMA/ucma: Do not miss ctx destruction steps in some cases

Leon Romanovsky (1):
      RDMA/restrack: Don't treat as an error allocation ID wrapping

Mark Bloch (1):
      RDMA/mlx5: Fix wrong free of blue flame register on error

Neta Ostrovsky (1):
      RDMA/cma: Fix error flow in default_roce_mode_store

Parav Pandit (1):
      IB/mlx5: Fix error unwinding when set_has_smi_cap fails

Tom Rix (1):
      RDMA/ocrdma: Fix use after free in ocrdma_dealloc_ucontext_pd()

 drivers/infiniband/core/cma_configfs.c       |   4 +-
 drivers/infiniband/core/restrack.c           |   1 +
 drivers/infiniband/core/ucma.c               | 135 ++++++++++++++-------------
 drivers/infiniband/core/umem.c               |   2 +-
 drivers/infiniband/hw/mlx5/main.c            |   4 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  |   2 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c |   3 +
 7 files changed, 83 insertions(+), 68 deletions(-)

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmAB60IACgkQOG33FX4g
mxq51A/+P/qlzjw7ER/eaRpwLGx1IZ49zJUeQxAILG8h4DVu+Y+3DfxmqZEGY9Lq
RP8ChRjw3aSKNik/5MJXMDWqqVAn+G/hddEzRG90yF+bTyag+hjw6ZCF6x+7S68S
/ygjduxJ0OZNkFhIMDRm7GG5DZe/kWZv/gvE+5WboL3AaVuLVFEIgmu4QUvlg3aa
SjxR+TVcjjUxPUUc1p/7Ndm0eFEKvnJSMC07Q2o4h9s9QKF0Cn39C1aRgAs7BWqd
SxGqkZbAsytrg+7W/N2uxR3l3671+Z/0uxt665mMeoL0VVTsD+usVzvTKe/Ryz7q
wiaGgASL7OW6Q3SwDjmY/8cGq7CV6NMwbK/kXuOkoTUktso/nlBtUWDD39KXY1lF
Ohhe8u6iWvwjNN3DP45ilhaui0HFEnMbbvciQhLBIj2+EmwGggThxVdFYqM6urXK
CRE9lYUXjSvzLx31YNUdgLplHioll3s0IvPJFAAVUdP1MyjhxxC81rYeDwOamVtB
nP5eGgHMMA9GvciH2ehPxlmkhZT7VvHrR2yqO8lHeKKcbdxhkx+K1z7zdiLbo7m/
7JUNWgm08DN2JlKyoe20OMUi6Z7sbWGYoWQXesahHoDOhtc2bKzCvwOji1zPKM6m
dmxVEWvWIoFIkUYUa2bOornGTMncPf4k5uQl7LEnrv7S0G925og=
=SvLN
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
