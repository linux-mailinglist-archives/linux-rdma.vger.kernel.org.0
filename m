Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8573D6A04
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 01:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbhGZWaJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jul 2021 18:30:09 -0400
Received: from mail-bn8nam11on2047.outbound.protection.outlook.com ([40.107.236.47]:37824
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233491AbhGZWaJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Jul 2021 18:30:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HT/2v9rt1HrroObSR/Cs668u8HSRO5PukuCzLRj8BHmgVJqlAlsjafb52g1QynP0i2gG44SzesxNivMmFz+EM2Jd9Fz9D+GGv8I6KSiO9T1DMyTF7WPSsu3z3QOfT/yAJXnoFae9TqNhiy9ElacPJTaTWsJkM5nuaLp3rR4oTDUgcCl9KjscDaSfB32lJaEFbmENXcI3bamu+Zn6sdkMss01s5Tez64RmzlykGITyOrWpXHcWCGERnlorctudGpbpYSmPKuNkGaAS+gubWrXr1CPQZIjwdkdDJysCtuc1TmmtXOImxDPU2KVlpMauY9zeXNtrSCrsJsJVQ0dYJzQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcIy7ecurkDNjmQjEsGtG0X6DvzXKbq5eZAY/0bvVC0=;
 b=NPBzy5N3MMdwJ2wlNqmIdYxZjlu2gMg9JDzFs5ebaDMXPlXrXXgz829c7x1GFlHntFM2fIwZyZ0kKYWmyI2gl9TRyaTtvhjD1MS0NXX22J58jRt1nTyJMrK23gU3UAKjlIIBfp/Etix8PFa5O9v9BSyPgGCIYVLuCZhBcjeAcpGKJcmUetjDBuTOIS6us5kGU1FYXPvAVvf3yg90qQWsGwIuhn8as3VEHUceI0UVWtltD2E4UF3GzxJHeuOSAWJKRDoEK3zmHTW0Zj87o3v0BWucHhSlGTVDCvce5pWNvMfyqYUkXkHCZ0WPeGp8AB6jq04kZNDaFGBBAuRC029rfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcIy7ecurkDNjmQjEsGtG0X6DvzXKbq5eZAY/0bvVC0=;
 b=CWlU0VV6Tc+J0X+AoJHnyOS9TklADevV45IEnFo29cv2AOuXcf6WF20mVGcaoCHGoH5l7cw+91eGa9s22PcsE6/NfJhAFOb+Yu7IzLYCmbPKKmEwVw+DL3v9NXHuCLYwkELFpLNBBFhz1VRHKJF9DmKyYgQcIhj2vGHNp+FNWUkF1hBOQ1AA5hfoY0CgRcL7MvjnZZvoGtSLUPZz6VlcUYgf5JefiHZqddcjf+k2+J5d7rqQ4jvDADVdtn1MQW4zOKmECYFEKBcdjRG8JpQpHUuRUbZcvssyhG1xtnV2Il2vurEOvgw5papvRBDA6jN9zdJNBYUIXBQ7RggYm4I9Nw==
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Mon, 26 Jul
 2021 23:10:36 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 23:10:36 +0000
Date:   Mon, 26 Jul 2021 20:10:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20210726231035.GA2109238@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
X-ClientProxiedBy: BL1PR13CA0334.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::9) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0334.namprd13.prod.outlook.com (2603:10b6:208:2c6::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.9 via Frontend Transport; Mon, 26 Jul 2021 23:10:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m89k3-008qiz-Km; Mon, 26 Jul 2021 20:10:35 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c31575c2-dcce-4dcc-a572-08d9508a93c9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5349280ED4CB0D6393011200C2E89@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZ9teQTNwmMEh8+1H8SqZgymi5/L1bXNnJ0JdNwDB0ddrqPWRzBk/I+CW1GMrz/kda7eHKOchLICT7YELUVk2RuTZ7ab64jBZjiivrZjNq9Vedrz5tKTGANFeGFtBuuQPq6AJfDCucplOx3DSdjWu9BD/VMJH28IQpWnS2z5/liMt+Jjj+8KRHJ//lb2KpCd/at06d7nYNLngDElLV9lQkYzP2axj/2b6CREGNurri43ucwZoHRGnkACEM9gaxBX8zzz60nChhDc8FJQZdfHb/n3k4JFlkEg5jRUC5cl6T8BE4/l4v8rUoJvNvEEAIgAOm0ZoJfSBE84RAhD0wRugKT6nARLvhWXQvP1CczxkY1nwvvMVOSNpwWXAM/ByNP2SuWt2q3v8BzKuKic6eBro+KRLi9hU0YpWnxjemSlTtcNLWjAREGKwYw36GindP/AN4ACnB7sfEXvKoBrwmsb3lGsrZy0txH2sILoYQ8H5bdVX0g/uoqhHN9f/+dwQnm/2uPjFtSRlPLZCyyCGyCRCvqE0jGMHwIlsKBAWzkCWZ4MSIJY+WpngsOobuwaqXx++1EOGAegAvy8bCbf2+pJyIJ9TwHwrXWWnj1s8fa8jKPXOZbvo0fIkOeyd/avziJ7Vg2OKJUV922/4kylVk5H+SvrEK52KwukM7HLU/iYi3C6ux9/utk8Ba4Gj3tVLP+dZmZk3gYCtR7MoUxKpiimdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(36756003)(86362001)(186003)(83380400001)(8676002)(33656002)(4326008)(38100700002)(8936002)(21480400003)(26005)(5660300002)(478600001)(2906002)(9746002)(66556008)(66476007)(66946007)(9786002)(44144004)(2616005)(426003)(1076003)(316002)(110136005)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CybXonaUtm3Wr3EJzcVfDsXl0fWk7qYnBh2T7PyiqWCZr2OZCXO3YoS4k0cN?=
 =?us-ascii?Q?vXMv5dGq36h6wTF1wQmrDlE3lfK5XAbp7kOPEcUPqX9IkCU+swdTQ54Z7wJQ?=
 =?us-ascii?Q?p57gXJVEiKE0sGtTCTTq+/HkQBvHKDgjc3PXbS6nhNqPvoHX27B62VV4ji5C?=
 =?us-ascii?Q?gda0Rg5rqnr+beRGt+Yv0mkWuIMU7JA1XBDZ7cKktDm7FaDfvzKLNdlnSr6W?=
 =?us-ascii?Q?DHnOOLmxszL03ZEFGc/QNu7Fe3yNEx2MUw17XzOd4IhPBi6BrIQ/6QUTuYp4?=
 =?us-ascii?Q?5aaUBKI4+J7VRSXdgQ14Ps9g6THRui2fUp4EZkxTfiYbUWZOV1gcCsRVEmXN?=
 =?us-ascii?Q?+f7aJTc2XUUMqxTtctDIbPwPFJrm4iWaozp/zfdeUFvz04gGKpwDhcLANy0F?=
 =?us-ascii?Q?yuiM9XROm9gUkBlmKAHRDGcjO7FsCcqLy6VHmmx2o8sv9yneapSF/y9feOCs?=
 =?us-ascii?Q?7yAmSq2RYnCxhB60QIHlvmcKTpIxnsTyTwhM6nr+uEmQRy4EdZio0mgzNe7n?=
 =?us-ascii?Q?j84kTW0hkNNNjP0iO7ozuTAxvsh5ZjUG/su6XjS8Zg0v55mws1GErfxeKw9F?=
 =?us-ascii?Q?o2Q4CNs+LAr+E/koETaIruTfKHwgUreET6PUBw6fIwOLAi4TJc5TIu3f5sjR?=
 =?us-ascii?Q?2ztzoic8G0jczu+nTaV/bfviRj0+qOSrb36iqLgv2AcSujp+6z+vs/dPynez?=
 =?us-ascii?Q?t9eruruh4XoUrs8Be0VdxQzA6DcYlbD0pkR7hG7Y+m9XdoayiFTRlX85ULK2?=
 =?us-ascii?Q?m0eGZgo1k1ZBF1JIGvbK6xOln7tjco5APhgy82Uks5B6tEIfS2qOp7AOc7UO?=
 =?us-ascii?Q?s+BHRzaYm+el1CoYoEtWS3CJwyxYyecbSiW8ERdG6VwKL+rxjbCQ6tGMx/Pg?=
 =?us-ascii?Q?I2qWnNh3tf0J2zyI2O+Q4/kAZtV9UOLAfrUj5REk6Ip7vJkeRg3ieuTyjs0A?=
 =?us-ascii?Q?qlffmYiQM/gJeN02hA1WKddZuDmMEkeXs+Dek+CEpmNLSV4I0jzV62DEsg+t?=
 =?us-ascii?Q?YQ9c7ZGMXDaoDg42KB3xwepjywUWvO1CJukmb7+4848sxAU4e75ESt4Cy0lx?=
 =?us-ascii?Q?SjoVUIezgG73F0bX+7V+tve/gHY1kpiL0k0eVcY9Sg429CdFeoBq1HgNLmtv?=
 =?us-ascii?Q?fQy5fcTCUyasuos/sKxq7BRiPWvLH/JItVXy6HSF3XbDwL2sQdnbASznb8c0?=
 =?us-ascii?Q?1ySXW5Ehox0UYFwoxjwFioYDELsmXDWj5UFF5FNByLpGjglLIIw+kBY+KPJP?=
 =?us-ascii?Q?tSuIzIvKV/8LcEJCZwle7nfHMHGPob1X7+nxfRnEUkkZjmNxe4FSBRq6a5KY?=
 =?us-ascii?Q?WcnLExwKbQkUZp97SqkQtZ6E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31575c2-dcce-4dcc-a572-08d9508a93c9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 23:10:36.5925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCWjPeo20ACgcHt9NncOoi8siO++j6pB+B0hnZJ/7uMicb9n9wSPrsib5MkzIWqb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Nothing very exciting here, just a bunch of irdma fixes. irdma is a
new driver this cycle so it as expected.

Thanks,
Jason

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to dc6afef7e14252c5ca5b8a8444946cb4b75b0aa0:

  RDMA/irdma: Change returned type of irdma_setup_virt_qp to void (2021-07-15 15:14:11 -0300)

----------------------------------------------------------------
RDMA v5.14 first rc Pull Request

- Many more irdma fixups from bots/etc

- bnxt_re regression in their counters from a FW upgrade

- User triggerable memory leak in rxe

----------------------------------------------------------------
Bob Pearson (1):
      RDMA/rxe: Fix memory leak in error path code

Lukas Bulwahn (1):
      RDMA/irdma: Make spdxcheck.py happy

Naresh Kumar PBS (1):
      RDMA/bnxt_re: Fix stats counters

Tatyana Nikolova (2):
      RDMA/irdma: Fix unused variable total_size warning
      RDMA/irdma: Check vsi pointer before using it

Zhu Yanjun (4):
      RDMA/irdma: Change the returned type to void
      RDMA/irdma: change the returned type of irdma_sc_repost_aeq_entries to void
      RDMA/irdma: Change the returned type of irdma_set_hw_rsrc to void
      RDMA/irdma: Change returned type of irdma_setup_virt_qp to void

 drivers/infiniband/hw/bnxt_re/main.c      |  4 +++-
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 10 ++++------
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  1 +
 drivers/infiniband/hw/irdma/ctrl.c        | 13 +++++--------
 drivers/infiniband/hw/irdma/hw.c          | 11 ++---------
 drivers/infiniband/hw/irdma/main.c        |  9 ++++++---
 drivers/infiniband/hw/irdma/type.h        |  3 +--
 drivers/infiniband/hw/irdma/uk.c          |  5 +----
 drivers/infiniband/hw/irdma/verbs.c       |  6 ++----
 drivers/infiniband/sw/rxe/rxe_mr.c        | 27 +++++++++++++++++----------
 include/uapi/rdma/irdma-abi.h             |  2 +-
 11 files changed, 43 insertions(+), 48 deletions(-)

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmD/QOgACgkQOG33FX4g
mxqGTxAAl7q49DhAiQLNmCb5tXLm97IPB3OkUPeA5pGpR55qPfmKL7ayCMpKRqVi
GHpyRfILT2iij/ydye8wIp/0bE3ZVmgbs/ho0z8M2DgjyFXUuqB4VZMvUVK77pBb
S8UXd7CqBFMK9IdcjFOOWUgoyacYdY67LpKFh5+Th7kxtStrDxb7u2b0HLNqNVM8
oVgqBXbvkG4BSDiX/GGogYLowMKcdYDqzfL35uHHPdyImLAD1SeHyFqpGD2BfyaP
Zo5bdeyrtKjrjQxy4KWo4qNeKMQ3LwT9GF4mL+h/ZX9HxKL4Rp3i5e5QzFlDeMZf
PuZW1jWE4OkTTmPeb8/TpJibS4fHOD0Ah9Xio3f9EII6oxFkN6OdCVKynW11QSRw
b4DoH9Lpkg+BT8zEstGO/9vvlkMqVZoeR3Q7NVkt4hZJ/3vc6uO8kZRTm+XG+gXQ
0ypDecwHKjIxR80CV5ssHyTgjiov+/w6FgsJuBrZ4YTz4nOPqEFQ/G7ni6fq4H6X
cTcV7DR7cT9bPuZJEZzBmPWe8JXsBmUtIkN58d2TTbA2dKLZDGgc79MZmTfOG4TT
fxz5CgHjcGYwBU3FgFPDvILFAThm3byyViJ9zhqxO50Wyywi++rAmdB6oTia7tWu
bpFqekwZ22qQcR3IjUdTlWym0Zy1kKF/nXWf9ohHoLuj4QN/lT8=
=Bf8P
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
