Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6D620A452
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2020 19:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406968AbgFYR4U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jun 2020 13:56:20 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:64407 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405512AbgFYR4U (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Jun 2020 13:56:20 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef4e53f0000>; Fri, 26 Jun 2020 01:56:16 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 25 Jun 2020 10:56:16 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 25 Jun 2020 10:56:16 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 25 Jun
 2020 17:56:15 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 25 Jun 2020 17:56:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/e9Erd4+84HCvLwi4LTrRIuDq/zcDxP5MS8KW8MZ09yizAUgl1ef92SXAnJU/3YroP++qnImCVEJ/c8gpo+Kmw/Z3GakY0sPIMhGbxDZak4vt8ITQleeB1Zq8+6NEoZcEMRHT2yBWj+Ai/vZtL0BYlqnUFl2bXvqEMRkSVITzq1H0UdaYspAeGceLvLB8Xh8EXx74Z0R+Vp2vYrO09WWF7KZ4T0yUmIEeFe6GnuFLzOGuUwpsmpeZc2LGH6Ufgaxhi4M3QJFYkN694mFn1JJdDNEpCOHBW/QImmcsta7uIGCP9Fl3MpETu1x96ePodHmPrQ8xF7UzuvW9SuJprWyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5ztpjsoDbVIxU99fROYBlRPv8WUJ+46fIzh70iSCYw=;
 b=axznUf40LKYY+nook8MOP0HXUf3MrLu0/0WqxYZwF8zLvgp2+DApvxEx9oGx0lrhVPA5TmU3JIYjFxX1AJ0KxmOR3xgOIfIXeQSey08ZsFy3i3yEgBis4HBSs7zRSsTyp+XkE7QQ4jBzXmeTz0kn0gm1+u1MKMnbIkXFuA9fSpYty7DvCMN5fayFfHzLwd7a6xgyV+ewktyeAn06JXhUOhjOy5JytTca5WpfUFd8H9QlqOWfkDEk7fay51IP78rCUaeOSG3CT+e6zY6W6i8Ru2shFEA0DYe0C+IBYR5/9vvowU5Znvwybs6DB5LnRzOEqBoiOFb0Lf1jz1a+7cuZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 25 Jun
 2020 17:56:12 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3109.027; Thu, 25 Jun 2020
 17:56:12 +0000
Date:   Thu, 25 Jun 2020 14:56:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20200625175610.GA3402155@mellanox.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
X-NVConfidentiality: public
X-ClientProxiedBy: BL0PR0102CA0018.prod.exchangelabs.com
 (2603:10b6:207:18::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0018.prod.exchangelabs.com (2603:10b6:207:18::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Thu, 25 Jun 2020 17:56:12 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1joW6c-00EH9f-Va; Thu, 25 Jun 2020 14:56:10 -0300
X-NVConfidentiality: public
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 502682ac-4e44-4073-7cbb-08d819310c2f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4266:
X-Microsoft-Antispam-PRVS: <DM6PR12MB426611A65A2D4B8955CD4A70C2920@DM6PR12MB4266.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uq1JgtJsW6xtXlIlbR4c8MxmamvJMni/zon9+4NgWqShuxwDq0oNEJbRJhPKm1gp7Qa/1kV5I6oO1cg4So76G+5Aj5dR58qtzU3AOdOPj0r5nPMUE3rAZIbW7fXObHz2n6b6GH1n8F9VR73DeyFhbHfASgnt1w5Ry3CQ6EZ/MzZUSmbUtc9Q1IfMyMpYMo9e+uI1/jBX4wdQefeR+NfU9JgTrnvEyzmqaEXhOuHk7dDCkGC+mN8hlwUDkBFUUka7kxJsQC7zIn/8sah0vncJFoGm530mjxUJ4u/Mc1SvyJeSF1iTyjLrzPZKldiL6hsLeOsbHkAHE1QVxxpqFERxQBQQwyRAai1NWafkJnatkBf49BLUYJJ0jQYsdyrG6owy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(396003)(376002)(39860400002)(136003)(4326008)(33656002)(9786002)(86362001)(2906002)(66946007)(110136005)(83380400001)(66556008)(426003)(36756003)(186003)(5660300002)(44144004)(478600001)(9686003)(9746002)(316002)(26005)(1076003)(21480400003)(8676002)(8936002)(66476007)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: exAZ7UueXu2qSw/LfSz0aOgg4cnrham0oNL5bXsRX2pmbH9YyFiZxhc9qhRayb+CjSRouJ7nyMdrAKbk3ENK0Lh03r/WnOanKtmciBhVwu52MwEDFqSHQ2uAEXt61WQNJesLemdKc5R+QLtE0FSSJDh/BRORrKCROz/tJ6mNxKxeyB8bNUtLDQnxwQQSfSizfXmnsCd2eX5OiWHS847n+0Gq3ChxsY9HLDXYpIHruzKzvoDbolSZiOkGyWRGT28AvNjwHbR57V4KsYGeEfzM+nbR8Q4CM+NeXIqup9tLDBcUT8eFKH1++xARRZ/303P2m9bY3dQdDxpKI1LjmyuVtHRtgJiz31+6RtUMkmyoWCZr3sHDx4bi8ruTcDUERLcuEUue7Xt2wo8KZ7wMH01WSG9sTaTXybWh7k7HGOL4j59AOVSyMmJ3fCO5qPqZlsUBoCYO75CHjFnnbxF8IkS/APNtRHFFf4XKDti2zPN9kzM=
X-MS-Exchange-CrossTenant-Network-Message-Id: 502682ac-4e44-4073-7cbb-08d819310c2f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 17:56:12.5113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRshF73ku6KeONFbXTRQZUz4E/DBYqepnnOaOPRAMzPkWIUeYDIG2z82GUBN+IT4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593107776; bh=a5ztpjsoDbVIxU99fROYBlRPv8WUJ+46fIzh70iSCYw=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:Content-Type:Content-Disposition:
         X-NVConfidentiality:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-NVConfidentiality:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-Forefront-PRVS:X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=AGkv6d6xtYDJWpWEhg05X2es211Do9Ohc/XEev7wilz4o8Bl7K9oZdpGOKkQzWgB7
         YZntxor74Xni3kf0KFP/KXrqB5Mvyrdxo2rX8D6iuBaqBT/GCGiGFSgvm0jWOdCoyv
         OJQNbCQ2umX1KzxOCABdiylarRswDq9MqsbYySPPXvTOnAfs/C9y6cCayxpSf+slzh
         QzRrB16O91fp/duGFsIW2UbBz1d/aetciTHqgk/K+4cbrZ6uyMQDGLNHRDOjgw5TXl
         AFic/sCc54My5W3nxEQYocbAjYiS0r1t2RbengkQRoIvXwWwJVJWNu8H/G4oeVe8FE
         VZqptmooolECg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

First rc pull request

Collected fixes from the last four weeks, fixing several regressions
in areas that had big changes this cycle.

Thanks,
Jason

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 38fd98afeeb79d3b148db49f81f2ec6a37a4ee00:

  IB/hfi1: Add atomic triggered sleep/wakeup (2020-06-24 16:13:38 -0300)

----------------------------------------------------------------
RDMA first 5.8 rc pull request

Several regression fixes from work that landed in the merge window,
particularly in the mlx5 driver:

- Various static checker and warning fixes

- General bug fixes in rvt, qedr, hns, mlx5 and hfi1

- Several regression fixes related to the ECE and QP changes in last cycle

- Fixes for a few long standing crashers in CMA, uverbs ioctl, and xrc

----------------------------------------------------------------
Aditya Pakki (1):
      RDMA/rvt: Fix potential memory leak caused by rvt_alloc_rq

Colin Ian King (1):
      RDMA/mlx5: Remove duplicated assignment to resp.response_length

Dennis Dalessandro (2):
      IB/hfi1: Restore kfree in dummy_netdev cleanup
      IB/hfi1: Fix module use count flaw due to leftover module put calls

Fan Guo (1):
      RDMA/mad: Fix possible memory leak in ib_mad_post_receive_mads()

Gal Pressman (1):
      RDMA/efa: Set maximum pkeys device attribute

Kieran Bingham (1):
      RDMA/hfi1: Fix trivial mis-spelling of 'descriptor'

Leon Romanovsky (6):
      RDMA/core: Annotate CMA unlock helper routine
      RDMA/mlx5: Add missed RST2INIT and INIT2INIT steps during ECE handshake
      RDMA/core: Check that type_attrs is not NULL prior access
      RDMA/mlx5: Don't access ib_qp fields in internal destroy QP path
      RDMA/mlx5: Remove ECE limitation from the RAW_PACKET QPs
      RDMA/mlx5: Protect from kernel crash if XRC_TGT doesn't have udata

Maor Gottlieb (1):
      RDMA/mlx5: Fix remote gid value in query QP

Mark Zhang (2):
      RDMA/cma: Protect bind_list and listen_list while finding matching cm id
      RDMA/counter: Query a counter before release

Max Gurtovoy (1):
      RDMA/mlx5: Fix integrity enabled QP creation

Michal Kalderon (1):
      RDMA/qedr: Fix KASAN: use-after-free in ucma_event_handler+0x532

Mike Marciniszyn (2):
      IB/hfi1: Correct -EBUSY handling in tx code
      IB/hfi1: Add atomic triggered sleep/wakeup

Shay Drory (1):
      IB/mad: Fix use after free when destroying MAD agent

Tom Seewald (2):
      RDMA/mlx5: Fix -Wformat warning in check_ucmd_data()
      RDMA/siw: Fix pointer-to-int-cast warning in siw_rx_pbl()

Yangyang Li (2):
      RDMA/hns: Fix a calltrace when registering MR from userspace
      RDMA/hns: Fix an cmd queue issue when resetting

 drivers/infiniband/core/cm.c                |   1 +
 drivers/infiniband/core/cma.c               |  18 +++++
 drivers/infiniband/core/counters.c          |   4 +-
 drivers/infiniband/core/mad.c               |   3 +-
 drivers/infiniband/core/rdma_core.c         |  36 ++++++----
 drivers/infiniband/hw/efa/efa_verbs.c       |   1 +
 drivers/infiniband/hw/hfi1/debugfs.c        |  19 +----
 drivers/infiniband/hw/hfi1/iowait.h         |   2 +-
 drivers/infiniband/hw/hfi1/ipoib.h          |   6 ++
 drivers/infiniband/hw/hfi1/ipoib_tx.c       | 104 ++++++++++++++++++----------
 drivers/infiniband/hw/hfi1/netdev_rx.c      |   2 +-
 drivers/infiniband/hw/hfi1/verbs_txreq.h    |   2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |   7 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |   4 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  17 ++---
 drivers/infiniband/hw/hns/hns_roce_mr.c     |   5 +-
 drivers/infiniband/hw/mlx5/qp.c             |  50 ++++++-------
 drivers/infiniband/hw/mlx5/qpc.c            |   8 +++
 drivers/infiniband/hw/qedr/qedr_iw_cm.c     |  13 +++-
 drivers/infiniband/sw/rdmavt/qp.c           |   6 +-
 drivers/infiniband/sw/siw/siw_qp_rx.c       |   3 +-
 include/linux/mlx5/mlx5_ifc.h               |  10 +--
 22 files changed, 197 insertions(+), 124 deletions(-)

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl705TcACgkQOG33FX4g
mxpEDA//Zovl3fAZbLirMqkZixl1FOoperuGZJIQRZz/uDFtgUlvJRPI7umhrGFF
OAScLgzev6WQQ0NKFlszjlmzivLz0kn18vJ3nPFrlHajitz5CPifCKDp18BpSCa0
KUO8BUDMJ5VsaOrNZ5sjGA9MqZfwzTsukLpbE9RSIuIy2HikL5ECkkbH7oGAF3yz
XCfRa5X5a4YXE5rFwOlGi0pBL/vjHcv1jgXSe5J59KTjJV+qkSfEDEYlj/8Tb2Fj
shvE8wOU0BRup94q0F9Y4v+BctYoxGjZmsoYhggnTQG8DKQ8H1MOCIuSLRJa4kR9
QrMXc4WzlxO/6b1LWjalfURTVYUMRBQkIVN1/C1HyUHwfM8/uXg+Z0Z4dPdPWoAv
ULQ0In0gB+1o0Y1vPUdWKJK6DEEWneevBGd0uhD5I2aRKKOaie2BT5v4qxk0bHrs
QhDuZqTqRe3k8RSz0TAjlX58AL289253xvua82jIp7Rg6oRB1E7aWy7LsLm0GSJM
ZhNplxThBL441uj2x4toGhELgd763KShuJDIyx4vk6mfyX5jd58cb4IOWzaIXFLp
i/uMfv0y7x86LS7b/h9oQvv7BFyWD/gAnx0orGpfm+Ou9kRldTJVbb59b+dErNT5
la8aunuFL56MFd5ks3USwvbnHddrvwqL+O5R1nKR/7jmdrysVtU=
=NsZ4
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
