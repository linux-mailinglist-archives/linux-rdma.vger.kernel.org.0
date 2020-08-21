Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CF924D6E8
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 16:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgHUOGS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Aug 2020 10:06:18 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7842 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgHUOGR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Aug 2020 10:06:17 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3fd4ca0001>; Fri, 21 Aug 2020 07:06:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 21 Aug 2020 07:06:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 21 Aug 2020 07:06:16 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Aug
 2020 14:06:16 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 21 Aug 2020 14:06:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPBmCm5sPL6M9LYuvhyG+Y2Y+nNmNDPX/HGE+bK75wop9iLTObBH7QSHamxsYVyTNAQmWkSaR1/D+3oWkKpnqCyyY1PXqbEOlES/q/cmzsQ+LPoqazWD76kMkLLaHEJw8uOZ81kYRg8trX13QnRdguUXBpBVh4uNBQA7nWfig+gf/HyeUj8Jxy5ZjEXEfOpZ7mCoY1guXoeGFLboo2xMOips0AVJS64uHf7yp7KY7NUDH+Fkd41wl6Okc1Xb8jbflMNUKdkcrUHLOIEbmpt1xSByka4/LuNZt+ETBUGXrwUihpUK9k9I5D1o6++iYT9gfMcBvjxHKHkLhlAItQM9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqDYb91BMdDkJ+gmkxiAp2gFYUV1XUxF6FersnWqlQ8=;
 b=gF3KjFm3FhEdMn3WddxEUOos25fE980yT10oL17bJneUt4oTvSBv9ZXkP9p42/MI729WpmML/zRGeOe/sUqudy45FzXvMLZSNMFvEGJBemvVd6UP3B8aSqwoCuRx/tPQKXke4FhonDAp4bwnJx/Wib6IRbkjfOedbUz99TWIzQfB47VpGlJJbmPxsgnOfw+N2+Lg00Nc5jxBO5wNrFFFO1y0ifjbB+2ceLjlR2A2avIuWXqmDcwMiI9bGRvf+k00DdtJac0OPQR7K/otkOvf7V/aMWp1MVFLBTBGsqeEBkg7u2EUAuRPFOFssOzD9WIuxPwOGF8ggnII0j5qJSYx/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 21 Aug
 2020 14:06:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.025; Fri, 21 Aug 2020
 14:06:14 +0000
Date:   Fri, 21 Aug 2020 11:06:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20200821140612.GA2665062@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::13) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:208:1a0::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 14:06:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k97gK-00BBOX-Rw; Fri, 21 Aug 2020 11:06:12 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 202c3628-a469-437e-552e-08d845db5d62
X-MS-TrafficTypeDiagnostic: DM6PR12MB3210:
X-Microsoft-Antispam-PRVS: <DM6PR12MB321044531EB3FC6F90B59D32C25B0@DM6PR12MB3210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4Tx1u3M7aQnuiKDmXopXIvu0xpfYtvhgpDRz4HK1tzTDZpD+ywuBM9D0rxHc9tsnydphkW6EsXMpNaVsP1uMmc4OkEU0jk42rR6SrQeYaZai2ghDjavVdK29/mFAdQ1YrLP+MDy5b8M8yRnOkpEZXEezFSGmFTs+ABGs5mvAbYrocGejBWc73NDNc0G6zxcFTmmALbiRrLv3yjbrs+yHVCydItCNLka3sNX8Jo2gabb0H5D6z81S2IFo/7WLpD35AXsbSIHksw8r5+KXYJFI3kNNTP7VP4Bgyuaei2Zn0tiMRbdRH8SMR0vu4SIivLfMdwp0FJOV+fMuhhubnHLTlw/NbgqUGvLab7EaDTfVtzU1VHpZuSu3UjfnJLgVLYw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(44144004)(110136005)(26005)(316002)(9786002)(21480400003)(9746002)(83380400001)(36756003)(186003)(426003)(8936002)(8676002)(478600001)(66946007)(2906002)(86362001)(4326008)(33656002)(1076003)(2616005)(66476007)(5660300002)(66556008)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: t5rwdiUy6w+zyzS/F6zma38yq98mt2y2+nlg7Gm4Eiu7Gusfy0iq74Q6UvT1z137HIgJDFT7QL6X10mHXC2xcW4xw+O4Glk82j7+I6cBaMgEPIpeJM3e+3JldPW0L60rL1c7n8PdqUjccMexho9ICPNtklsYJakIipDXYgd2qFx9vKf7GTH85eGCLo7QJF7ndan9IyS9Zdh99hz7Bl587SgkA62TGRQzDWEtac4priu60mehQKphb58dKNhFeu9fYf0rS2t+28MJTvWANhtWVMRU7RIxqvvM7DnoBQDWRiamT8u/u1Ng13shTZ7vCU6YrYiRiyM7v+lxneMvHTmk53PXfMRyD/1htgXs2gEPHqg1vXQ6Twk0AMtCGOOdoywF+K91+zAYl2reAaC0601UvOZtA9L1RQuwpjdkrVHIrPcTg9MlFE2WgUkotTB09cctNvEPIoov4L/He+805846PQSIm/QFe4vR5mp7UzqmmHGw1rXaVEng7ydJ9x9I5yTTOWGpekHsdcv5L/SSdr1dYfbkJyMmmL8MyjGs29knHcYBEv8aufLQbwutd0vM83MUTaXhv0hXicyk9GrhrDZAAY6yDTl7O6cqbj5X/LKUt3Hk5kuPQfgMyfTSmbNMpOzkZwv2pxDIsXY+bq3Vkdzlhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 202c3628-a469-437e-552e-08d845db5d62
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 14:06:14.7040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cnJucWA9iZc87hDEz++5X9+waMbb/fbSylHrQIHbF0wzlRB8YVWuIDKRlDxrdU3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3210
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598018762; bh=gqDYb91BMdDkJ+gmkxiAp2gFYUV1XUxF6FersnWqlQ8=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:Content-Type:Content-Disposition:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=DMqOHCoTyN7Dm2iwcN5Wrgd0h+PYrY9zjvqa1wIXuLUuqAyrYxhr36AZ9gf3LKolt
         7ZLHBQZiwkMhPxhY9Zgpk0jXBuuS9waapNFSEKHbK+HXksdTxXIr/b8q4siFbvHlmP
         i6sDWTnAJPR6G/2bVSv6MHV4uQH+OdiUcoXGDRWXErjlBYBkoZJ2wY68np7DHg+MA7
         9mYK+RIo4e3B0x/uem7gPLUBIyzsLgbJMsJ9V42YrbbteXbQVunCDJg6g43gIyh1I4
         /yvUdJ+kpCMIFkxmNRmzghMpyo6nWlm5BsytBf1qKRph1utRIEoCIA/KcvxHpbDKAl
         3GO+5WIkh0VoA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

First rc pull request

Nothing exciting, just a few bug fixes and a MAINTAINERS file update.

There is a small merge conflict in the .mailmap, it has been sorted in your
tree and Leon's entry was moved.

It should be resolved by adding the new line at the new sorted position:

  Leon Romanovsky <leon@kernel.org> <leon@leon.nu>
  Leon Romanovsky <leon@kernel.org> <leonro@mellanox.com>
 +Leon Romanovsky <leon@kernel.org> <leonro@nvidia.com>

Thanks,
Jason

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to f6da70d99c96256f8be0cbb4dd72d45d622c7823:

  MAINTAINERS: Update Mellanox and Cumulus Network addresses to new domain (2020-08-21 10:48:48 -0300)

----------------------------------------------------------------
RDMA first 5.9rc pull request

One regression from 5.8 and a few bugs from earlier kernels.

- Various spelling corrections in kernel prints

- Bug fixes in hfi1 and bntx_re

- Revert a 5.8 patch in hns

- Batch update for Mellanox and Cumulus maintainers emails

----------------------------------------------------------------
Colin Ian King (3):
      RDMA/hns: Fix spelling mistake "epmty" -> "empty"
      RDMA/usnic: Fix spelling mistake "transistion" -> "transition"
      RDMA/core: Fix spelling mistake "Could't" -> "Couldn't"

Kaike Wan (1):
      RDMA/hfi1: Correct an interlock issue for TID RDMA WRITE request

Leon Romanovsky (1):
      MAINTAINERS: Update Mellanox and Cumulus Network addresses to new domain

Selvin Xavier (1):
      RDMA/bnxt_re: Do not add user qps to flushlist

Weihang Li (1):
      Revert "RDMA/hns: Reserve one sge in order to avoid local length error"

 .mailmap                                    |  2 +
 MAINTAINERS                                 | 58 ++++++++++++++---------------
 drivers/infiniband/core/device.c            |  2 +-
 drivers/infiniband/hw/bnxt_re/main.c        |  3 +-
 drivers/infiniband/hw/hfi1/tid_rdma.c       |  1 +
 drivers/infiniband/hw/hns/hns_roce_device.h |  2 -
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  9 ++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  4 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  5 +--
 drivers/infiniband/hw/hns/hns_roce_srq.c    |  2 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c |  2 +-
 12 files changed, 45 insertions(+), 47 deletions(-)

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl8/1NIACgkQOG33FX4g
mxqUHA/+JgxuCtadYqHefBGkaAsjpIrq+YcuUx0S31EmjA2XxKA1C0ZoE71Sblw+
77w0ftWrtQ1v7gXH5i/DmyqJ3HAqUOoFe+9y05KSHi0t+MMmD2C023T4hU+AlyRI
pP+Dp/XJuw12UnD7LR8bU5JJMt9MZqqfqR1oLbr1Xir6U6OkxnnerXcK7/pYi/Jc
k75v3OeZhGzlwOffQHEGWCLZjthjnMRZ6vG7TOwBgGi92qoKZRZ0+m6DpmF+/8XU
YKG450TUlZYqwTxcdQikfQUosO2VZHHj/5pXQv1xsftbyJ0QjPP/aFqRBdxjS9N8
x/E2jl8+udVJqp5gk7D8DumFbGorcMJ4CmZLUWOnedMipOYcJRQCFeCWBsxwdOwr
fj19WIOd0vHKU3f9RsrMN5iHv86hpQeIUiS3assntVDyYjAsZI6DQ8D+oe34V8jU
CgHB0qbzUaR94/NLbKo12haNHW/8I4ApbzBB1YL+WAzphgEskPQEUuQ206f1/18O
Phndmw0wHUZrqUfSt/HGkZvwNpErYF6xCZwhTWwxqXcjgAxIZI8vZOtqDziyZeqm
b7onGAk2QQjs3XbPqqSGlJ+5PZ06xT6UcupuMJWwE0fyFHqNBim5lUnUSIahb1li
pQdtpykVgrJyTAfy7W2qM5BAg31JrPCmKTT9g3JZdTPfv3RFS3c=
=TUBA
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
