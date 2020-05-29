Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4801E7FF5
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2020 16:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgE2OQF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 May 2020 10:16:05 -0400
Received: from mail-eopbgr140078.outbound.protection.outlook.com ([40.107.14.78]:12862
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726593AbgE2OQE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 29 May 2020 10:16:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJQxbMVT/hbGRZDnXFEg+sBzfy00eXcXPDIWldFrXodfvxPbwdHnM0y3zoDFjbh9eDSicYaZ9A4ljmCg1vzGDpa7dImuDXgyyG78zl2XEkfzQz6YB7NlFIjXIeE89zZfU7rOYYY8aMZI8vigPMwkq2NlZTkuJtaqH7m11gHbSVVLJxJg5qXksEOpQSABAV+PlfkWGzERtv20K7lYuzpSAlmDuiwYZX7ij/yJ6tuuBox/iEXb2/VEcxRlKwu2+kzdNaVOCIATuSwDCDE/qlGQMfJZ9WKNLDfcKT+ePlNRzjUBmByhNrSq4OMskkJeNzahbptwVgDFYk9ptHl3Lpwt4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBQL55MA2lg4kJGjy+0KzdCTo2QOZh+3nmd6IStSn+k=;
 b=XbaOXiSFeJlOr3N3CdxBR2TZc4qbeiq3Vi5dwuIGCPYCarRrPcEDGYS9rh0sdcvQrfUU4ngiWF7RtFWzqlzcv4CYYUn08VMe7yxjMUJPHGVR8uBmXo+s/9eqOzhzyJWHv4qPS1dalCntqiRzTypWzwyYLuRgZR30/WGx6dbMIv886jpnlRBdT1+Ea50pvLyOem1NCanxjEZz3gOSFSlR9MaZVcPhezjojMr6vInK/QCiqofsC2n6AHNngLgvaydj0Bmcu1AMcjRXgGD8YPpHBPzmDgtyzzISIURzoykdmwuyACrHcSvK3tI09txN+0Hz1Hc1kcjlKJ66fs2bsH7LUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBQL55MA2lg4kJGjy+0KzdCTo2QOZh+3nmd6IStSn+k=;
 b=qElBwbQO2+9gv5TwKqQ6JuV8EZJ0Ab3v/7KpwNXv6h13ZVJ2clARO625dOPKukjiaQ7SUu96kbDEvBdOnu+hQUp1rt9yBx1hnVFUeDdvSMTMoW470QPtcc0If23DQ1JgcrR6Tru/hzAOKsTufvQb/fvO5LO0I4XbZKyGf2IxcGg=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB5344.eurprd05.prod.outlook.com (2603:10a6:803:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Fri, 29 May
 2020 14:16:01 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 14:16:01 +0000
Date:   Fri, 29 May 2020 11:15:56 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20200529141556.GA30959@ziepe.ca>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:208:23a::22) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR03CA0017.namprd03.prod.outlook.com (2603:10b6:208:23a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Fri, 29 May 2020 14:15:59 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jefng-000856-5j; Fri, 29 May 2020 11:15:56 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d5062a09-1b13-4e77-8dba-08d803dacff0
X-MS-TrafficTypeDiagnostic: VI1PR05MB5344:
X-Microsoft-Antispam-PRVS: <VI1PR05MB5344E65AC66924D263627C83CF8F0@VI1PR05MB5344.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:556;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JCrgZ0GYeYCdQncX8EJHHK2EIdftSZhT1X/symwpspn2Q2a9qv2nISJDMuaMVZqoGRtyAXkgiMw+CyK7flgNX7fZtXaxda61Dzg3xivXOx/7VQCFuj/cd+huqsC3aXwXi9/IB6BKPQRRKV6LcVuGqt2ej8g2pkzzoHjZvo+GVKOykd0aQa6aqTUBM0lgFAL+hkEDmHYg/stFvf7+7JZDh8yKZz3dFmdwtSg3c3MspDNP8lEAFFmKKqvKotjpuQoA6hr2Qg01+nkNd4ENeS3w3ewKnAdCSarsNEAykIVOw7wfioAdxBjXsTk8mi5XaO0KmTWBSax71E7EfHiAegvysukOQE9I55VlCOrlXEpug2sybDYepGO0XZZG1gtN8aeTc4TVaO8Iw/bHpQ83rL1BE14Fj/j9iUxoC6yJIMaFpTk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(44144004)(110136005)(8936002)(5660300002)(9686003)(9786002)(4326008)(186003)(26005)(9746002)(36756003)(33656002)(1076003)(8676002)(2906002)(66476007)(478600001)(66946007)(21480400003)(86362001)(316002)(83380400001)(66556008)(24400500001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fA3IZQhKHw5yYV+jhqVyMAvI/grwG/1vxxEXQ9o8XeYapzsFOFSsN/Dm8fvXz0GwD/TD5LEOtXfUsJ6VjDVVjp8kj9Qes+m1hiusvgU1P+VeHio682DPAYspkyLxSDnnstBHXK08muJiuHVLsz+ZJ7+aaKoQgfPhVioImVvuez0vlGfH8uOGMvn7URwBNhyF1vHWbc2qhvaSY32NUwxSGzdouZvLfwBur6ofuQIaaWkGEe5+Iv1nblM/jic57TU2BZ89bgeC5tCgVYKEXH0ERvir+uofcoDM0HCMahg8X64eD7bBKhQbrF2NWIx8caaGFRI41YN24Tj1/EbJMnNfZpgHAvzVGxsmWgVmE1B0iEQ26YreSpLybfB/D7lS4AHW4gBEwxadawBtZZCPg2qT0gSFs3iUAwILo9lQzUtiZLyETgG7CHotHENrEnr0eAGHtf96d5wtPJwgLuyryqieTcVi/IyWVb89RopOjf+aiwo=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5062a09-1b13-4e77-8dba-08d803dacff0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 14:16:00.8262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZfmOUsXW/vichIpvhVAyrrwllTQklFIXw0KH+l2EwiS16K4LU7WZqd/76LQKXqhgaT60ruWqpwLDhflOBIVa0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5344
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Third rc pull request

Nothing profound here, just a last set of long standing bug fixes for 5.7

The following changes since commit b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce:

  Linux 5.7-rc6 (2020-05-17 16:48:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 1acba6a817852d4aa7916d5c4f2c82f702ee9224:

  IB/ipoib: Fix double free of skb in case of multicast traffic in CM mode (2020-05-27 21:14:09 -0300)

----------------------------------------------------------------
Third RDMA 5.7 rc pull request

A few bug fixes:

- Incorrect error unwind in qib and pvrdma

- User triggerable NULL pointer crash in mlx5 with ODP prefetch

- syzkaller RCU race in uverbs

- Rare double free crash in ipoib

----------------------------------------------------------------
Jason Gunthorpe (1):
      RDMA/core: Fix double destruction of uobject

Kaike Wan (1):
      IB/qib: Call kobject_put() when kobject_init_and_add() fails

Maor Gottlieb (1):
      RDMA/mlx5: Fix NULL pointer dereference in destroy_prefetch_work

Qiushi Wu (1):
      RDMA/pvrdma: Fix missing pci disable in pvrdma_pci_probe()

Valentine Fatiev (1):
      IB/ipoib: Fix double free of skb in case of multicast traffic in CM mode

 drivers/infiniband/core/rdma_core.c            | 20 +++++++++++++-------
 drivers/infiniband/hw/mlx5/mr.c                |  1 +
 drivers/infiniband/hw/qib/qib_sysfs.c          |  9 +++++----
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c |  2 +-
 drivers/infiniband/ulp/ipoib/ipoib.h           |  4 ++++
 drivers/infiniband/ulp/ipoib/ipoib_cm.c        | 15 +++++++++------
 drivers/infiniband/ulp/ipoib/ipoib_ib.c        |  9 +++++++--
 drivers/infiniband/ulp/ipoib/ipoib_main.c      | 10 ++++++----
 include/rdma/uverbs_std_types.h                |  2 +-
 9 files changed, 47 insertions(+), 25 deletions(-)

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl7RGRkACgkQOG33FX4g
mxoOgg//Wj7EALhpAMobWu5ubtuDlm66hwTTEMXo0dpRRi31pnf7+SJ7EXr9XrL3
HwqDmKQMzhPJFd73C4+SUVIdrdZDba7ZVylCBtPMH0Rw5WclrFT35JEEW62M9HHV
YAk3hB4Fc+Tn4k8L8jdFRLB2bMYDqPqqhR0GKegx7OVo2pVTb2ZnSG5wYbdAH2A9
h090Gtfhhdp3r0E8mfShxeNbuJYrk8RgadjgEUQq7eM2kZJmtLTeie2IZ0wbkbmy
I/AGJs+stLvS2MCK6k+KHne5HLXrWHTpT46fT0vCyKg/1fKs5XUWbQvmSOXt4Wzu
yzi8e5PeirUlPqwqrPObiP2uLbo8Eij1rGw3gJ1NLUkjZxKP53TlO4qVDuWTGn40
Ud/fHuhzeI/iKD8DitUpIDCEGjuC/93vw1ly1HkH12GV+FkVSWZ2N/sLYcH2OLED
x5GNR7oqe1F3DP21Ilghin/822EEwFrd345119Jgf8szYI6b4AhJhadV2Q5UwEyX
P7zVk0mxuq3WzZf3gJBHQfaD9pGxgg44KnLkwi76S4mh/lEn9AkArFKVs9PfLLqG
9LoBJue2OXG23YPYhx49h9oV7PXPLRTMu35GOJ5HkscvYwo3LGJYA4PIApsFydi1
UaSL+9FCtQ7JpENY+YUjBRuLPR6hGnW8RAWoYKyf9bRpQ58ACdY=
=to3N
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
