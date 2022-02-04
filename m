Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85F64AA4CC
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Feb 2022 00:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349198AbiBDX70 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Feb 2022 18:59:26 -0500
Received: from mail-bn8nam11on2081.outbound.protection.outlook.com ([40.107.236.81]:15724
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231710AbiBDX70 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Feb 2022 18:59:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnOj81b2s3Bh/FK2XnqPFOQOrtnbcRZyKLaBqevZjazFuX1aWrGVEog2rApgVJtin5ZMltWjtFy7qJLvLryGzQgRK2Uy3fB+jxDqurSSGD86VVrzkVR2iVun+CuamEqigYIik7QYf0WMNszIcDqnqaV3iKggv2hurH0y7s3kjkbGx+nakkbODi0I0sIxZ17l30w6XibT0W5BPB7pKSakbBDETOi4rcV19bQUXEm+IxQyF/Pzpn/ai2dlMCOsu3usb97pKEnRI1oTk47Ux9t4fg+We9BGex+DpjaCnJv0skfAa80up0rj8+KBAa2bnIyFtxVOdJ+Zu60vsKq/YWUYgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdijqUa7FYyBcHcYfEpnAdeB809+R0MS1AgIiXP2Oqg=;
 b=dnljwndIi6LGIYtqfnMo0IuZvGlyeAjVIrgdzc4+6Gg6S2XOQa3/Hg3KUgDSVidKozUQdXvqjAyxWZqW6eMR5wNL9RwiRpBbV2f0phVg+F1wl77EiO6HS04nC+EAVQHJtIm43PzI2+yh63ljsojBXvu5sp79A2wbSbOvF/BootqI7V9SCZyuzT3PWkbnV23ihpO/8cb6/1S2+TSg8g+L2TqtG282uBLKzBFpdycvVvxO+qPdRZfHAYBIGFbS0FBGUz0iW157jHTplwY/uiH/9MlvaGVMvMbfJlUCFWzykVMsY0BO3NMLxtnFyCvjIzVH0xY0tZyRQSsc4bTXWBNw8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdijqUa7FYyBcHcYfEpnAdeB809+R0MS1AgIiXP2Oqg=;
 b=HP8F1yl/b1ALp5T+tk1g9vHRCq1HFqh8ZfFdRQrFb0hbe62IkqqRcnZ5wD3wmoyHlS264SCj0AFgtyzoX7JanomOpgWFrg0I+bpCFwqMj6PDRz/gxi5X1vQjHGEmfTfME2FZjt+BbuTcyCURQA8zoRUnNeZujUvRBNtU1eNtS8PXwCZFgYg640y3okeuk0GTxBoRpzTVv4nQTI8ARmL936Pjo8ESWU2C52jF+Qz0+mxA5CvaEWlnAhFt5b8vp6v+GMGR7IhIy2xSQcTjmje6lbgPy+rR+j6p84MaootVuMdCaZZkXijPHQ5z3ioQHYPLtCLCD/Ibb4pmooTAb0WsQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 23:59:24 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 23:59:24 +0000
Date:   Fri, 4 Feb 2022 19:59:22 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20220204235922.GA2979630@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
X-ClientProxiedBy: BL0PR02CA0136.namprd02.prod.outlook.com
 (2603:10b6:208:35::41) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7e0f3bd-43ad-4ec8-079f-08d9e83a5e64
X-MS-TrafficTypeDiagnostic: BY5PR12MB4289:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB42892CC45B82440F5CADC5CEC2299@BY5PR12MB4289.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCBLKAi4aWBpksspjeTBakAWoeg9GRMjkRoU9gRmSDWIH3I0xddZSi+SL4dbaSZ65kHtQJ5WVT3NZuBBOHlosnh5cXbcy8S0rxGQ602vdGcybxWuINCiIMqfITZqD33K/EpvtWMTh2013cY8de90lEcVoVcZGnbW2CMAUimISavQU9qecUrX8P/A040m2owSCs5wUINWbIok5u6otqCAKj4C405dpj0vT/kuNQoG7eLAevi1/nOtxCsAIBl1dwbC/epjeEhJLuQfMB4xr6vNYKjvizWs1wVwF95fn3SHuT1tmFkw2NsNN/nl9FqIXpCOwhExPF8dmORtb5XdlcGZLKF/SdRNxb8siw30BTUOnodop73PJvMoLwiusVq5zQguLElqDtqCnMwuMNP3EyXroGrHmxAPYiHw2BeLQ+DELCj1Ne5FeT1gToH2KWVfR75h9OBjSm33fuESeXZk+59J7yIhuriLh5ylsD+fHvviKrgmnqh7gqpdPfN9jmVhdUfYiz/E8AWB4r9cmh3dlUlY2XfTfYcQU7zOrOLwDsvPpAuhLJlKRK7uiQpFKoFY72e9AA9oInzb6cpxzhS4Z64IC2sFPlqCsjdX3RuxxpEamVaxUZEUlBB4ldasOmEYJ0pT3+Tl/fPlYOA6xY5TwMPZwsqlP3LAb30maSmrkW6GcHz+T5dZvNUGEL2k5ov4Nxf6XtujwAuQP0ee016mTLdMCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(66556008)(5660300002)(2906002)(6486002)(83380400001)(66476007)(33656002)(508600001)(8676002)(316002)(66946007)(38100700002)(44144004)(186003)(6506007)(21480400003)(86362001)(4326008)(6916009)(36756003)(2616005)(6512007)(8936002)(26005)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?759f/sm1QTLZZ692n3WpXxWTlMSLDBZxBXV9LNrkZiHH/TumDNIV1vBlREAd?=
 =?us-ascii?Q?n8jQ6ZTPkTCysBu2/jdahHrd4FZy4dFlFqtPLSa6e1O3KPiR8H6sVKGOq/S2?=
 =?us-ascii?Q?WXnQrtbhCriLm6A3/KLzkHWwqHpxDB5HUlMjp1wfhRXg+qXbiOEG+Kxj6HB7?=
 =?us-ascii?Q?gG++V8AwuXzgDyBLnqR/NoxJ2U0y3Diryda1PsBmUUuVrab/mRAq5twjiMXo?=
 =?us-ascii?Q?97jz/DeYbGqGZT4hhC4h3Il6G/idsXoKUVQjipowQeatuCTvm73W6E85CMag?=
 =?us-ascii?Q?ZdWrYW86E5WDESRrYbSCpNz/dn8neAF/Cfoc7NpccWsK4z0kqyvPV5N+Gq5o?=
 =?us-ascii?Q?NDI9h6IBPPzZn+3c7ngBvCe6+7qORklD72nGW0a491GMDWMAnfevYPsgZYeh?=
 =?us-ascii?Q?RXo65AgdS90LmK94BjW+I8XLjGX9OtD5GKGomg0I1wEq5uDRo6hB94+pJWA5?=
 =?us-ascii?Q?CRuG45zrCqhmkVmCmpL2CXvd4P3A+qwC+wDxXC96Z9mRIQH2DlfG3dfvgF06?=
 =?us-ascii?Q?YLdrAWlPDz3QXX8Dq8uB6s2mbmWqC3WQq1KUbKOPrczKX7BDHpRxdNvFSSK2?=
 =?us-ascii?Q?jF26LhC81JXsWSvFLyukQpBjUVzY+obPqa9z0Ic9PH9pI4T1TgsvbpXHhDEP?=
 =?us-ascii?Q?1xbvvG93xbbgmJk2X+r6BSworT/tyW2qoyVQfPKpUFFj8O2Pkui8IJFxuXGk?=
 =?us-ascii?Q?ohqL+PWh/A7FKEzBPfDmkAm/ezSNoIJ73zL4JxupQS7YOawKTGcikjrrDa1e?=
 =?us-ascii?Q?NckKY4O8DcaL9NYG8rTRTl4MsbjZGQ90NexEnbEPYNduE0RDG7LADAOvbazB?=
 =?us-ascii?Q?oXZfBUlu56N4TEDlLhBCLiGrzS83kK9k92160E6vZ0aSunx39zPqpSfW5ynL?=
 =?us-ascii?Q?7iZDYosV3IWwYkDO7QLtXrtR0zecawyYaFMKD0myqSLrbcsYUpE6044pCcLA?=
 =?us-ascii?Q?Fx0K6kiVpxwiankSYaGw4siarhBLBUL+moVnImkXB/pM0jkdPBLeRnHHmXRm?=
 =?us-ascii?Q?ckstoTXIQ9P/cc6JC7IJ6RGavUXTqN51AVqxoLIldU1nEp3pRES2qCtezHDd?=
 =?us-ascii?Q?lLYn9qew7hfwmlcOkpzNcuDSO0RqZO09QDhl+9ga9PDJPJMeqJzqX8HROsvY?=
 =?us-ascii?Q?T6iL+UAOq08US8UBXitLnTXPbrtTYhvQqJcvzLpwVBW7aB+xd4F7oy1HaceV?=
 =?us-ascii?Q?pQGDQX5h6282wxbGN7oRvJD10pqWz38OGCgmpLr3vUG6nuXewGe+YFLPzvJi?=
 =?us-ascii?Q?T0n0AylAoz8gkxuXX9zvA8nIkMcIYcIZ5VLHPk/khcV+isIvRr5rtUVpZog6?=
 =?us-ascii?Q?mLd3xN2MiSrFXljAhRoJb5b1zDyvURfwt2YaVWJ+GVn1eLGb6HbL2d6lnkfS?=
 =?us-ascii?Q?dFRQVTKmxnPAFpCh5VvxOIc2IUkeo4SCfXQst0d7oXwAyYw/xohP43ZPUhJs?=
 =?us-ascii?Q?cTm7fgXZZ/jTrXbaMHYtWYbYdhfUSx9s46LPklu7UDEiKpk/cuqbD5+WfFur?=
 =?us-ascii?Q?VWKt2LLtZb/RhXlF1L5YOv7tkXzV6p8eQmwWKHSMcDKC4qLvXkAPcVeWmxsP?=
 =?us-ascii?Q?Q/Vxti+kTSuU3y1zW68=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e0f3bd-43ad-4ec8-079f-08d9e83a5e64
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 23:59:24.0246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQPsyipgp2wwXBb4bSzUkrBIMZhQY9w2fsB3kb1dj14MASKn4qMqomLwEZK07dKV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

A few rc fixes that were accumulated over the merge window period

Thanks,
Jason

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to f3136c4ce7acf64bee43135971ca52a880572e32:

  RDMA/mlx4: Don't continue event handler after memory allocation failure (2022-02-01 10:12:26 -0400)

----------------------------------------------------------------
First v5.17 rc request

Some medium sized bugs in the various drivers. A couple are more recent
regressions:

- Fix two panics in hfi1 and two allocation problems

- Send the IGMP to the correct address in cma

- Squash a syzkaller bug related to races reading the multicast list

- Memory leak in siw and cm

- Fix a corner case spec compliance for HFI/QIB

- Correct the implementation of fences in siw

- Error unwind bug in mlx4

----------------------------------------------------------------
Bernard Metzler (1):
      RDMA/siw: Fix broken RDMA Read Fence/Resume logic.

Dan Carpenter (1):
      RDMA/siw: Fix refcounting leak in siw_create_qp()

Leon Romanovsky (2):
      RDMA/ucma: Protect mc during concurrent multicast leaves
      RDMA/mlx4: Don't continue event handler after memory allocation failure

Maor Gottlieb (1):
      RDMA/cma: Use correct address when leaving multicast group

Mark Zhang (1):
      IB/cm: Release previously acquired reference counter in the cm_id_priv

Mike Marciniszyn (5):
      IB/hfi1: Fix panic with larger ipoib send_queue_size
      IB/hfi1: Fix alloc failure with larger txqueuelen
      IB/hfi1: Fix AIP early init panic
      IB/hfi1: Fix tstats alloc and dealloc
      IB/rdmavt: Validate remote_addr during loopback atomic tests

 drivers/infiniband/core/cm.c            |  2 +-
 drivers/infiniband/core/cma.c           | 22 ++++++++++---------
 drivers/infiniband/core/ucma.c          | 34 +++++++++++++++++++----------
 drivers/infiniband/hw/hfi1/ipoib.h      |  2 +-
 drivers/infiniband/hw/hfi1/ipoib_main.c | 27 ++++++++++++-----------
 drivers/infiniband/hw/hfi1/ipoib_tx.c   | 38 ++++++++++++++++++++++-----------
 drivers/infiniband/hw/mlx4/main.c       |  2 +-
 drivers/infiniband/sw/rdmavt/qp.c       |  2 ++
 drivers/infiniband/sw/siw/siw.h         |  7 +-----
 drivers/infiniband/sw/siw/siw_qp_rx.c   | 20 +++++++++--------
 drivers/infiniband/sw/siw/siw_verbs.c   |  3 ++-
 11 files changed, 95 insertions(+), 64 deletions(-)

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmH9vdcACgkQOG33FX4g
mxq30Q/9HGF9Zt7BrLhrwv1UuqH5tm+BcfRbpj8lG1bgeipAxKA0Kk+lbfyPI872
7uSUC3nj1u0zPzZsvTwHkmr+DUUAVrWqqKpOYBeNAZnK6diLMosE9NZT+Bbf6+vT
qkw+APg3oKAYpKtIl300B+jFMsD79ydDhB8xNsBc/LvH31GQUiP6Uhw5/WjDi3EX
gkZRk/WR8qJtLVXFT62fToi6k/KdcCXA/f6LGYOjNak5mXozAK3R8AmqA1l5Vj02
2avOkq/tW9cVtyCc6nbRXQVwCdSKHPFB3umcTAWzBm+GXpTUafqAoMi8UGhZ/5lM
LfZ82WGGobxqxtFxx/IOoDWLg1lhIyYyMmmsDH/cIS7kNVDx5NHT+eDyG1aluaTE
DUfeS+jecgQA/au2wbVVsl8MnyDK5HyRWmFHjc9C5Og4Rxsq6mXZQw4kcdn+o6wt
RzBwG97o3dXdH+LGu8O7zPjTYRq60Ntsy1gAnkCbZ8xJfnrTPvxcxVyTnU5yoLnX
FT9unUh1hXsyPtgjf0BtwK2EqWeJBtinlgEprI9FB3Tw9g4io5lLoAeMJjeWkMUl
Mocsjav12ROWyyhZ+J/0FaNeiqnFtQf6iD8bp/1o/6lAjgKGdEI7WfJE90VHrZk4
MDSbn2q1BqbIK+LARdn4zbG/PDwfXZ3fc70UvGmx7PKUKZpXZko=
=SNn7
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
