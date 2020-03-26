Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06340194578
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2020 18:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgCZRcB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Mar 2020 13:32:01 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:15615
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbgCZRcA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Mar 2020 13:32:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrkEgZ8WfNUdeA3tBvW1YMHHXjmoCWH6w2og4NzZS+llozPZkYzwIPKO+6cSvYCl6e3FS7AK8H2AnvImhmFe7rGCBeuB7nDkOhK5UulEsieRx4BwebKjDAMW+DfzJQWUA/lchGiSWPzRzp1SH43E4Q1bUoCn8p077sZcya7dF4pPYFAQ5205AggvnHbhtbz9IrKXKHJHHTmzckNm0LI/64Zt4YLSpzXfOG4cpqr2j7BhqrkKHtWLKdNO6tYmzdRe79ck3K8Pzvqk65hWd9CsRFakhfTxiYHjeaGv4Nu0l1KYxaurE139HUTlz2r9N0VGRUWL4Onq+us+Du12yNuT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ij7AXp3jKjUVKWOo043dZErTVYooqNwrcRB1HBb0jSU=;
 b=Lyhf/hzgaiEavjIDUsPGis3xDIu0KeMflGqabw+r0+Ky/Z7JeCooIPkJLQhRkexTklLLNChkJ2Kj/nxCjY41Lnc6HqwbvJgxdeyhdFMldHkp7vebRS7gL03eCnrOujvXKrQzFMH2dNCAW9gWA3mEO9Tpp4tTjSeK+rKazuazTgVVsrezCQbSrWf+88P3tJIwUUvXN5dpcOy9Ic28FpD9AVbHLNlEmkx1ruUkkK5xmAGHXLMXXlD9C0e4IULBbAcj/CvIbxtJCVXovFtvCs9xeqslaOP6iHuLwQaeJ/iOWWJEQFYnf4denUPDziowvLyShD3VJfVyBiwHFJMRaLz+Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ij7AXp3jKjUVKWOo043dZErTVYooqNwrcRB1HBb0jSU=;
 b=n32rpiqPLrB9a2kBxoQAvgPeDDUPO7R9ZXC2i84Hh56NlvU/8qrcAq/fAHv4CpGa5OXfPjrmvVVH6/AR+vjAUsI+YAortNwCu38qI4wmfy/5gQ1dKm2fRripA6pnh5vs3eVn4Gsl9jH/sXwxEw0Ib0SunEHygz4+Un4yle7rhpU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Thu, 26 Mar 2020 17:31:57 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3%7]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 17:31:56 +0000
Date:   Thu, 26 Mar 2020 14:31:52 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20200326173152.GA22458@ziepe.ca>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR02CA0087.namprd02.prod.outlook.com
 (2603:10b6:208:51::28) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR02CA0087.namprd02.prod.outlook.com (2603:10b6:208:51::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend Transport; Thu, 26 Mar 2020 17:31:56 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jHWMC-0005t1-Ce; Thu, 26 Mar 2020 14:31:52 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 569a518d-1c8f-422b-b33a-08d7d1ab94d8
X-MS-TrafficTypeDiagnostic: VI1PR05MB4141:
X-Microsoft-Antispam-PRVS: <VI1PR05MB41415BEA6F48B8938C14258BCFCF0@VI1PR05MB4141.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(9686003)(81156014)(81166006)(33656002)(66556008)(66946007)(66476007)(478600001)(8936002)(2906002)(44144004)(52116002)(4326008)(1076003)(86362001)(36756003)(8676002)(26005)(186003)(316002)(9786002)(9746002)(21480400003)(110136005)(5660300002)(24400500001)(2700100001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +YFrRDXWuyx6No+fJw3b/ri+An4+zYYwN08a3AS3V2z3RU0jSfOXOvySp+sDG0IDlEhAe5SeMcBjeViKp5Wn8VT/dx01cs+b+jVIdxYDpJ/Y3Bxo4ZgbZcia7rkRv54xDVtDqJJudodXyAnOzl8TxOE19BmXujClu9GyYQaKWJJqOr/viN3FWHx3V6XHfbBiBHQvnMITZVcO5fkJv21aG/G4OrLSgIfmNDWYY8BZpTM4JCmIbwGuHSdeBFb7YjHiOt5MQri7g3t38FFbMyBdznX+xFjQnkoyyZqNwFDD58c8UpTXFImoNSFdJZiwy13QaJCsyWcRnY0z5PhguAbMPbinNGIVtGpKX2eZpsX75x3HmqvbHM23mAxNta8fvQzWWU77ii9B4HhVt/Ej3iB6DM0ggqkLS+QjpzVVRA6z8ZBPCncJxPF+eNHyAyUSfXqgkpsD8qoUSkFKauTXutPnZQ77IJwvZbNewZRH4PQaNAaHLKdKiAJ71V0CWnBcjBW0v4r/R5oyI5e6Hm0KvK8eLQ==
X-MS-Exchange-AntiSpam-MessageData: VDMNgo0daxQ6ZOjC8nqp22cqdXRJglFW6ORxvVdexMLuuHWFUBY4On8ME+JVgOQWaRrWDrpBrmO0zEaKP2j0SQH6vGLwbAlG3r2g+dSfqupRzv0V0yPtZ1gLffwqoNe9Cf4w0RoT/ZDQ3V3ycxiquw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569a518d-1c8f-422b-b33a-08d7d1ab94d8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 17:31:56.5815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqqrKXjZHCx//9B+GKrNOMhTiJ9vB48BKdJMpCqhdPobFAALKfcCRExKPcC7ZIjQS+Zksod1sgGbf8EJtFBJlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4141
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

A small set of late-rc patches, mostly fixes for various crashers, some
syzkaller fixes and a mlx5 HW limitation.

Thanks,
Jason

The following changes since commit 2c523b344dfa65a3738e7039832044aa133c75fb:

  Linux 5.6-rc5 (2020-03-08 17:44:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to ba80013fba656b9830ef45cd40a6a1e44707f47a:

  RDMA/mlx5: Block delay drop to unprivileged users (2020-03-25 09:56:30 -0300)

----------------------------------------------------------------
Third RDMA 5.6 pull request

- Several MAINTAINERS updates

- Memory leak regression in ODP

- Several fixes for syzkaller related crashes. Google recently taught
  syzkaller to create the software RDMA devices

- Crash fixes for HFI1

- Several fixes for mlx5 crashes

- Prevent unprivileged access to an unsafe mlx5 HW resource

----------------------------------------------------------------
Jason Gunthorpe (4):
      RDMA/odp: Fix leaking the tgid for implicit ODP
      RDMA/nl: Do not permit empty devices names during RDMA_NLDEV_CMD_NEWLINK/SET
      RDMA/core: Fix missing error check on dev_set_name()
      RDMA/mad: Do not crash if the rdma device does not have a umad interface

Kaike Wan (1):
      IB/rdmavt: Free kernel completion queue when done

Leon Romanovsky (2):
      MAINTAINERS: Clean RXE section and add Zhu as RXE maintainer
      RDMA/mlx5: Fix access to wrong pointer while performing flush due to error

Maor Gottlieb (1):
      RDMA/mlx5: Block delay drop to unprivileged users

Mark Zhang (1):
      RDMA/mlx5: Fix the number of hwcounters of a dynamic counter

Mike Marciniszyn (2):
      IB/hfi1: Ensure pq is not left on waitlist
      RDMA/core: Ensure security pkey modify is not lost

Weihang Li (1):
      MAINTAINERS: Update maintainers for HISILICON ROCE DRIVER

 MAINTAINERS                            |  7 +++----
 drivers/infiniband/core/device.c       |  4 +++-
 drivers/infiniband/core/nldev.c        |  6 +++++-
 drivers/infiniband/core/security.c     | 11 +++--------
 drivers/infiniband/core/umem_odp.c     |  2 +-
 drivers/infiniband/core/user_mad.c     | 33 ++++++++++++++++++++++-----------
 drivers/infiniband/hw/hfi1/user_sdma.c | 25 ++++++++++++++++++++++---
 drivers/infiniband/hw/mlx5/cq.c        | 27 +++++++++++++++++++++++++--
 drivers/infiniband/hw/mlx5/main.c      |  5 +++--
 drivers/infiniband/hw/mlx5/mlx5_ib.h   |  1 +
 drivers/infiniband/hw/mlx5/qp.c        |  5 +++++
 drivers/infiniband/sw/rdmavt/cq.c      |  2 +-
 12 files changed, 94 insertions(+), 34 deletions(-)

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl585wMACgkQOG33FX4g
mxp3SA//QizT9p1gZOk0W2k7Zjz5KhBXghwvkrpQB/Uq3rI/+T5CWdA9KEBllC5f
v244t2ORngUFD82p5JhZPEN2CRA5CqSs4fX5RPwchDDKLuIZQ+I4lirxUuzW6mFJ
Em6KLm0TdeBMTB9EjupGRdV8h8iMLuI5mIJpQu5xmj+Zg4ywsnXcyZPw71HHyAkL
XWg9vXNvNr8JngM4wNwqUFfpFsiirkw3p8PJdh7DQGW4t/sts6mZ1oXL8OpfaO3X
BuYuyl4hg498NWSsW+fe/3Rc5p+zCp738IBed+AexmpTUgDCU+D3lVCRT++Ax8pH
nnyQNsto9nfHPlQaTa2VtqbtfJidfd8Y4IGoLhWzqG9zUYzFjk8E1/0sdjXagS6/
8Mf3P0+usQ0ltKcQJK6e5hrxRGH6AEN/wIkZ1IShsmugryP2L3QinFL8pOZB1sZh
jOl2eQm+s+J6l3Gv+8QRKJBJ+ratzAA3Qq/P03vwauIQfen91zfphjvQY1i1GAg0
rzB2kS2aRAEaq9v6bUVK412Kz63cVstqmJHdXYFKYgp32sCi53SCRhgiki5xcI4u
y66sdEZLj580gRbzYPxHUQldBZ20GGhkT+z6cSonM/pNf8L6uhCZZavp4GESTyB/
BDOotD1wBTICxVN4rNm/IuRvfq/uT9fC9AZVzXulLzKwIo8tXn4=
=tF52
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
