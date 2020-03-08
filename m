Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A487117D0B8
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2020 01:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgCHAHc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 7 Mar 2020 19:07:32 -0500
Received: from mail-db8eur05on2062.outbound.protection.outlook.com ([40.107.20.62]:61103
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726109AbgCHAHb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 7 Mar 2020 19:07:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyKhbnFz3PNguGt6j+0xXZXyIpsYKu3iAuPJ7J+BoH62YqwMY70yt5Sx7bSNV3EGGj1oppdrSw0U64j7EUEc1HrXLfSx99RshvPKtznc7/NRf+oQHwPj6JgeWeqbdqDEwdWVfKnBW39BjB33RMn7HvULdjEx72jKit5KjoTzzm8P5dacu8NZbdXXgwRSq/l6tP0Gf1KmbIEjXhrwu5jLFG92vMWifIoZBIivYvSRKMugSFqcB3kicm9xYyWgJ5Ek8u+gaxwTRtFEPOQerdAVkv5dYQnx7wOZTQ1iffuQFJVFNAt0oDYJMupKzFhNgkxZXV5wgbVUB6CH2O35RzSbxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6/yVKiiB+B2DKLYE1k22/PQWiAxASIoVUHHobYP6vc=;
 b=Ey/R63cJxxS27c02byut1KeSvRtyJJwzTj4d7QDOIIefy8t2k7hqyeQ3/sNtFza/KOfEuu0znF1vqNmFupli3HVu4fs7qyvbnUzIF0A3bx3edhqO1Ws2N0NqEJoUBXhX2WeZjOT828kckJn+jge9XglAkV4rj3y4Z2o90DvB084xrgUqlTkj1DiuGj/rmZdVLYQe67GnvN3oV+WhqToJjw0R6SLQxQ3pEEcV6dc+VX1V4ehiCgZY6d1cUf2oaPphcFws4/OozsZVJNxVlecoBkoDIFyXN7kUpzzTuLeCO43/fuh4ylXFi3IBp2AJZnLgnMKu1RIwdXWr8e8V737o4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6/yVKiiB+B2DKLYE1k22/PQWiAxASIoVUHHobYP6vc=;
 b=Ep5gEhltsnqUvfleISU/JoP/pGSsE3kXpVtOSxTfagmNlOQ5oooWYIG6fU1a1M0e1TyN2qxIDx4C69KfiI0F0NvDIifToTXoWOJnCBoMUQrFlH8i6CBYmtuUh0QNxaHLiOpxrnL/f38JrkNJGj+QQEDxtxLBLPOaU/IFQ4IDfok=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4928.eurprd05.prod.outlook.com (20.177.50.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Sun, 8 Mar 2020 00:07:24 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2772.019; Sun, 8 Mar 2020
 00:07:24 +0000
Date:   Sat, 7 Mar 2020 20:07:18 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20200308000718.GA27153@ziepe.ca>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR01CA0050.prod.exchangelabs.com (2603:10b6:208:23f::19)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR01CA0050.prod.exchangelabs.com (2603:10b6:208:23f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Sun, 8 Mar 2020 00:07:24 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jAjTS-00074o-DU; Sat, 07 Mar 2020 20:07:18 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f61ba8c8-f547-425a-9816-08d7c2f4adef
X-MS-TrafficTypeDiagnostic: VI1PR05MB4928:
X-Microsoft-Antispam-PRVS: <VI1PR05MB4928BAEDDE31E37D15F096DFCFE10@VI1PR05MB4928.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:363;
X-Forefront-PRVS: 03361FCC43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(366004)(346002)(39850400004)(376002)(199004)(189003)(9746002)(9786002)(1076003)(52116002)(44144004)(26005)(66556008)(110136005)(33656002)(66476007)(66946007)(316002)(8936002)(5660300002)(81156014)(81166006)(8676002)(2906002)(478600001)(9686003)(186003)(86362001)(36756003)(21480400003)(4326008)(24400500001)(2700100001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4928;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pki8uEQYN7GvTzOgPK3qb+J2EIhhorcd60aGx26ouPc6t4TMHHMEzPpEOmJwoU7aPcpGnjVK3++vlDioFlERYjrHoROCqASP2pXgBY29ZfY3diyaLxA1ogOx7aU3KVm8kML1A9mSMmBikS9nTa6VD3qBy1X19J6J9/hXo2UVHmz+ctk+pfb7T5khmjlWvqLXyRd8DVNnfrn+Olq/5YOsNvOgFOwoRFv5SCVFsi+9R+U43wRz/hZGsrCIoA7dy5jIh7/I2zjJavRKOkYWoVGmhc4Y9Vd1PDc8yMitwo7+s9XHEB/8Tu909I5QU3bHu57eLb4Bq/OPiLBXiiaVa13vkPdpfi3LtK9ee269ydQkaKeLcWY64A4pKqg0tHXaokinJUVHDMPYW18W1uR5P612Tpwv5dSjMASq4oStn5zzUsyWych78ja8SlmT7CVnDFq73uyoQvaNws6zriHol60Rarc5jjwmj2i7Q5S2/aY+pJ0/Ua1ir+HMxXhIAgdzqtwK27aNDBrGSs+2yl1JOqv1FA==
X-MS-Exchange-AntiSpam-MessageData: hzwqfcsOsIfLYEXOsr/u03//zbO2yGohcqeWCBgY0v1zaGECqIhacbbHb1vOZPQGlcYz/DzvYirA/0gPlnAwcfHVSu+EW8vtumlyhaoU0EmX8KTle1t1QidR6yAOdIlMjUwbF3QLNnbWxBzvmET7Og==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61ba8c8-f547-425a-9816-08d7c2f4adef
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2020 00:07:24.3173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02DibqjM2bQTcU2J6fjCx10tTT5y/F4YpHXiHeTEBXQpjRW+R5J36khFK/JZA7/vDObxF70xXbBNnf8MYyPQYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4928
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Second rc pull request

Nothing particularly exciting, some small ODP regressions from the mmu
notifier rework, another bunch of syzkaller fixes, and a bug fix for a
botched syzkaller fix in the first rc pull request.

Thanks,
Jason

The following changes since commit 11a48a5a18c63fd7621bb050228cebf13566e4d8:

  Linux 5.6-rc2 (2020-02-16 13:16:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 810dbc69087b08fd53e1cdd6c709f385bc2921ad:

  RDMA/iwcm: Fix iwcm work deallocation (2020-03-04 14:28:25 -0400)

----------------------------------------------------------------
Second RDMA 5.6 pull request

- Fix busted syzkaller fix in 'get_new_pps' - this turned out to crash on
  certain HW configurations

- Bug fixes for various missed things in error unwinds

- Add a missing rcu_read_lock annotation in hfi/qib

- Fix two ODP related regressions from the recent mmu notifier changes

- Several more syzkaller bugs in siw, RDMA netlink, verbs and iwcm

- Revert an old patch in CMA as it is now shown to not be allocating port
  numbers properly

----------------------------------------------------------------
Artemy Kovalyov (1):
      IB/mlx5: Fix implicit ODP race

Bernard Metzler (2):
      RDMA/siw: Fix failure handling during device creation
      RDMA/iwcm: Fix iwcm work deallocation

Dennis Dalessandro (1):
      IB/hfi1, qib: Ensure RCU is locked when accessing list

Jason Gunthorpe (2):
      RMDA/cm: Fix missing ib_cm_destroy_id() in ib_cm_insert_listen()
      RDMA/odp: Ensure the mm is still alive before creating an implicit child

Maor Gottlieb (2):
      RDMA/core: Fix pkey and port assignment in get_new_pps
      RDMA/core: Fix protection fault in ib_mr_pool_destroy

Mark Zhang (1):
      RDMA/nldev: Fix crash when set a QP to a new counter but QPN is missing

Max Gurtovoy (1):
      RDMA/rw: Fix error flow during RDMA context initialization

Nathan Chancellor (1):
      RDMA/core: Fix use of logical OR in get_new_pps

Parav Pandit (1):
      Revert "RDMA/cma: Simplify rdma_resolve_addr() error flow"

 drivers/infiniband/core/cm.c          |  1 +
 drivers/infiniband/core/cma.c         | 15 +++++++++++----
 drivers/infiniband/core/core_priv.h   | 14 ++++++++++++++
 drivers/infiniband/core/iwcm.c        |  4 +++-
 drivers/infiniband/core/nldev.c       |  2 ++
 drivers/infiniband/core/rw.c          | 31 ++++++++++++++++++++-----------
 drivers/infiniband/core/security.c    | 14 +++++++++-----
 drivers/infiniband/core/umem_odp.c    | 24 +++++++++++++++++++-----
 drivers/infiniband/core/uverbs_cmd.c  |  9 ---------
 drivers/infiniband/core/verbs.c       | 10 ----------
 drivers/infiniband/hw/hfi1/verbs.c    |  4 +++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h  |  1 +
 drivers/infiniband/hw/mlx5/odp.c      | 17 +++++++----------
 drivers/infiniband/hw/qib/qib_verbs.c |  2 ++
 drivers/infiniband/sw/siw/siw_main.c  |  6 +++---
 15 files changed, 95 insertions(+), 59 deletions(-)

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl5kNy8ACgkQOG33FX4g
mxqKAQ/+O6/CyIsJmHAkX3jZTdJwIbcdU0EsP2p/GraTbTuRJYAaUmACQBr4UsK1
ybxbxypoYcUApMiZUvuMFAH79zlqq+iphmR9UFT4gSYbqiIr9P6zkZfG79hF1k4w
MtxeCboRvjhZLE7gpb2eT49GOK3OZnivlrC6kkSo8MnheIXWAZ0aWmMCONkWe3r8
NdpqqWTHp3mDLsg7mHVlDJiQ897IaJbHwiRFGsxOXCnaWMU5i954p641cBaYeIdN
dJtrBM0Tj27oOiHJ1X2biQ8GMm0azA7vnTXbWbmJb6AHGkJhutxZBAdy31n+yXOv
pqxWfcQ1cXyZ77/zMcqspfj8/EzSZG3QPV8qQpXsBQzI6O6gd+af0rjxzQDcpUZ0
l0bfrtzw2c1QWKuRK1QSBLXDAUsk7HakOHEIFSFDvnfPzrfjjko6HR6+MfgPf8OZ
UFrh7oFWlbIjT/ausR6ZFAHKDA7egdHbeCr9cSurC981eZs/eEtn9DEnsevgQ4i6
+dfYDReUdTEUJHg1J8jGhoeBIH9ifvg0xfOVGcPwxOZ0gFLzQiY7tGkv0rUgi5kQ
+jozHwD3I9dxYH3T1hNPd1Fq7uliZiSI7b2c8qrz9R28cIs2rNS0QUuwu6hV6kRc
DRyhI7ChcsqV900bRPkL9oFHxK4pIyICXCqljIccmjsIgcNPb88=
=T6Wk
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
