Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9127522CC8D
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 19:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgGXRrr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 13:47:47 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:52943 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgGXRrr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Jul 2020 13:47:47 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1b1ebf0000>; Sat, 25 Jul 2020 01:47:43 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 24 Jul 2020 10:47:43 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 24 Jul 2020 10:47:43 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Jul
 2020 17:47:43 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 24 Jul 2020 17:47:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTHTeNiJqZbW1vppLLEnAWEDX3dxnuWbHgS6+DZruA9zguLLl58vqSP5G3gwC7bk5HAeJtg75Ygw4d4/EnpYIAryK9JOg4F98JDHigbCT9KbXvZDnBEnXhh6uTuAJoj4u55mZ4V7Oo+ejKNB/7g4we29GGSw51VB70WjIKShJyGtzMTPBdXvI72zTp/j1w4FyKx/h/TT2wFHVLjCJ4xBJbn07b80iRx+AgGFMx9tZqutlTOx/GpQKd1VraxYIMQZVdOVJ2DRgv4zTwmeB1wmNtUL7JmCeuE8uAYup3d0LmK1JfWe19KOVPQ11BCiEux7/PAH6qncy7qgoRPEZTUXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuVQFLXgerb0z18lo+OilOkdOuQK7gpkmB7qXO8JC8M=;
 b=m/QqIGkerMLMg9+siBfsrVUE8ff7KxEA38O+tzueAzX8KHWDkHgziX1brYGxSRMjLEY4bHoZVAX8WBbekOS5086NxbR4Vnai3Zm04obqCYWS43RDK7xy3L+tYEDL0JJxCAInSv1qQWNFflcYRvyHHhtoef95Bd16aMU/b4I3ID9I4oEiPi6xcZ58Xj3iBLld6BMB4UanpyDefwUHL8U304OmncJ60mulIkSUkHQ7SyuydcU40A3Q7xJ7BsnhhUYGryeEnvbFTjHLaKcXJZKDjoKeBsa3e26IUdmpl5eP94pNUA9iZCdJik6lTN34XEL4ZUiZiC2kINGBU7NJcmPCRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Fri, 24 Jul
 2020 17:47:41 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 17:47:41 +0000
Date:   Fri, 24 Jul 2020 14:47:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20200724174739.GA3635934@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
X-ClientProxiedBy: YT1PR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by YT1PR01CA0079.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Fri, 24 Jul 2020 17:47:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1jz1nH-00FFvn-5g; Fri, 24 Jul 2020 14:47:39 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 634bc3b6-26b9-4ad3-d39f-08d82ff9a99a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:
X-Microsoft-Antispam-PRVS: <DM6PR12MB35145362DC0DFA3D5D59FCB5C2770@DM6PR12MB3514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kPwQHd5otbRKa47dDTp0uZ2ATfvmEu7/iGdLesV3SoA02gx5ecRqL61MDX7q5ObjDjD4gRfkpB2cFZ+hukXcPHBhsebdKWl9ZRsRnkHMdwNC2WyCB9Z4ynPppHuNVSxvDM+71F5TqcY8lR5MoaVDxdvMwvyYp77I+EQgOW1F9uW1S+88LTHjFcxlrgYkLA9Vy9TcmTxjjjKfl+hGW3+K0/RhqMHW9c6ThwkWteImPTDklOH1rfn+t6xx6YQO8MZ2HnDyDbg87mDQhV3Y5iHWWuH5m/J1qTtosHhaQ2OlOm4vlRQyZ+z/FJoEou1W8YwZUbEI+kLZLrynPVBp8ovMoFf1ZLuGmSnci11zMQOuBG6j0Aob4aFgXmYOzGHUh+uY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(478600001)(2906002)(33656002)(426003)(2616005)(86362001)(8936002)(44144004)(26005)(83380400001)(8676002)(21480400003)(186003)(316002)(110136005)(9746002)(36756003)(1076003)(4326008)(5660300002)(66946007)(66556008)(66476007)(9786002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: NDhvhiBNthJzj3yoz3gpX1zub0g/IaiLLqYe7qmrVz9b/f4COPA9ZZWJzXc4LIaLhvEX6fhMivSYFhls7F2oiuwo/NZiVpy1f7477sSL+G8iqhz4qWrlkrwLs1r/nLdkYAv5bQrqS5Lkw7V6oftKN8q3TDiNSHD6j3+vIZW/0R0Q4uXPUcLgLGc9M49yXKs2TpnpOuweJ3v8Jh3FtOzgigGctnaU1T8uv4E41GPjX7/ZDXBPqRgg/UrhG87y90dvpkd7BJg/MC4Nr0CEaxa0v25AdkaNrggU3Um6bCeMPIJFfOR0lIvdj+gnXRvmPt7LnJx4d+yFHnMj6TwIYRYXnp75WE+DBc8xgc6xNWPA19PE1VzuwdG7+FyORSvME+4nTf4t/UhSVlifgmvEUyny3teg9eaXG6TWEboUzfTxldFentQXRW9L9Dk8KZesjI1ZKng4Yo8XwbHXdOOjzW/r3ZuIycyjQ/o0ZzZ6x2IGnes=
X-MS-Exchange-CrossTenant-Network-Message-Id: 634bc3b6-26b9-4ad3-d39f-08d82ff9a99a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 17:47:41.3712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOoVggcS3l+uolMRgQBtI3w0bMjfCdJ9K/ZAaL03DSistmgsyaVLOS0Qkln+eu4D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595612864; bh=RuVQFLXgerb0z18lo+OilOkdOuQK7gpkmB7qXO8JC8M=;
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
        b=JH3aJb3U8tg8/39OLiMU2DVhH36DEdda91e2pMKGUdGPHInCQXybYVhRaSSJ72kiF
         3bo4KvCCB68r6X4cEJCfB5pT5jhwIHDvxgDtRP2Zv/bGAgJ1Gc4LBlja2CaUw6xlGN
         p1BdBYgfC/z0uB6VvrmfZWzGaE6wOPBtBokSBqaOHoRoWaNnVpPLlDsFikrDc8yv2a
         3x2RWl0n9w7fyiQZyuSA3xkRSShKoftn3XHeN72Pw3iwSV5JoaNsmtk5a2UKYES051
         PSDiQZkrSOz35/pqrxQp0mqZHxfzjgQA71jzom6nv9ipUR7T+gCdk5xhKRftN09oeD
         GP6ZfSJ4ZyM6Q==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Things remain quiet here, a few more of the usual fixes.

The following changes since commit 11ba468877bb23f28956a35e896356252d63c983:

  Linux 5.8-rc5 (2020-07-12 16:34:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to a862192e9227ad46e0447fd0a03869ba1b30d16f:

  RDMA/mlx5: Prevent prefetch from racing with implicit destruction (2020-07-21 13:51:35 -0300)

----------------------------------------------------------------
RDMA third 5.8 rc pull request

One merge window regression, some corruption bugs in HNS and a few more
syzkaller fixes.

- Two long standing syzkaller races

- Fix incorrect HW configuration in HNS

- Restore accidentally dropped locking in IB CM

- Fix ODP prefetch bug added in the big rework several versions ago

----------------------------------------------------------------
Jason Gunthorpe (1):
      RDMA/mlx5: Prevent prefetch from racing with implicit destruction

Leon Romanovsky (1):
      RDMA/core: Fix race in rdma_alloc_commit_uobject()

Maor Gottlieb (2):
      RDMA/mlx5: Use xa_lock_irq when access to SRQ table
      RDMA/cm: Protect access to remote_sidr_table

Weihang Li (1):
      RDMA/hns: Fix wrong assignment of lp_pktn_ini in QPC

Xi Wang (1):
      RDMA/hns: Fix wrong PBL offset when VA is not aligned to PAGE_SIZE

 drivers/infiniband/core/cm.c               |  2 ++
 drivers/infiniband/core/rdma_core.c        |  6 +++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 34 +++++++++++++++++++-----------
 drivers/infiniband/hw/hns/hns_roce_mr.c    |  2 +-
 drivers/infiniband/hw/mlx5/odp.c           | 22 ++++++++++++++++---
 drivers/infiniband/hw/mlx5/srq_cmd.c       |  4 ++--
 6 files changed, 49 insertions(+), 21 deletions(-)

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl8bHrgACgkQOG33FX4g
mxp/9w/9ExzW6SinlK8p4R6wRDKp4MlPR7+Qa09KBRzUBp5+9RijS3G9RXiahcPv
wRS328lstOtuo7IZGzBYUVpWz6blLC9TdDJMZ7N3POZnfjLav6xVjRHbnSLadTHL
dXKM22LNhj94ILmjW8FdNJkUjbO7ovF6Zylb3j1C7tgb188i9b7s/N9orj2KG3bS
JcSinKyLqfaIoUESfxeHhwvykMCOibGwr3CQIYNFsAHQvWN8Yw6XqMu3cs6ib+P5
X5A6Q9ihAnLmX8FlqwJSctgxWoLiZD2jpMi82ZZylIlvT/TD1klL0DnIutoj/96K
wAHNCuRGU/e44G0ddt0hqrfv66PE5BOd1HIOpAWf+NnLy0bSFLwrHL2BDVpD6AXb
HwC5feTM45kY63jq/XcDE4hZziiPmgqhecqg6IP+hZAXy8U9Qd5+H9axunGaUNl2
8xQMuYr4YVs2C8cbhbWgmDBBc6q+W+sLEJLwsasuqJ17Eb+BKfVz1R4ItTXLzh5W
et9snsFVw2P9ozAmHFn7OKkW5/Hi+iYkA/ruIwP3OhPvW9OUWogmPdx7RC6tphzD
pQo5RQcXIZKheanEzieysUBRXu3wEniE4oRFwi1v+7YYyvOs/UuCaN6s2Wf/yjpW
Yzm8R5pL+lWkyyuYKNfPBI4XjFjrnF3jI0bFDXKu201PwNLa5Ek=
=MIGw
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
