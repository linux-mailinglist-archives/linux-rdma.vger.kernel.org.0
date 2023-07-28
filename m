Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B5E7675D9
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jul 2023 20:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjG1SxF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jul 2023 14:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbjG1SxE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Jul 2023 14:53:04 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A3A2115;
        Fri, 28 Jul 2023 11:53:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fbg+Os73y1ElZowSuYFwN2Rc2OHVgZxAznBoF8E1SmZfVhauo5/A0nG0t+nWBeydhLWq8g9JHeZMNmmt35AgVUT58nAPSDN8mn6dXNm9yeyvJCyvIz//mMv8PtyP8G8Zs+tBtvEbx6W3UMEZ92CNjsP1Tv3yssrE5yVvkLAsO9uKqlgY5tn0MHsnxRKl9r54YZ0kc4m8UjWGuTV/m8ziwd/nC6ufsC/6sv59ghF3iRgnqYQg+y/EB+MVGgXAXa7Dh8AnSdFTK0t69/qB8tL/ZVhJEj1+RkkY2enR8vyTDP/6XbCCVdUeAIv+6k7RDvC5qG0leB+Id8TNSzsghAgpaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFCvfHJ4WcF1VuyNQ9FPNDxwNVe0LqJ+8uC8upOdN4w=;
 b=DYvY3ivDxu6HNk3iU3M9V2ITnhcslgohEOrzTBw3poPNeOdyNWvX9R1tzQyJT9vbgyGFklg8n6y8gIYd9jeCwV8ymmkj8QJpCLO5Uk993gyQwlZ+lsyKMFW0rGXrHOKd6gmajYT/tKecCdrgfmVXqXnYniRd9zszVivRMX198jTsh8gm/Kyqj2TOBlbZmFUYr8J7SapCEWu3xOwfXQR98n59fsndzvnpsbTz8rJJ5xW8Xp5cFR+dePU0fCBDLbKyUpmU3j9dnb9sZX+9Z+w0po4JLkH7O6umP/FLINS96np8N7zsYD5h8PlTNt7ydk43KT6/A3t8ZcJzU9U2xPHWTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFCvfHJ4WcF1VuyNQ9FPNDxwNVe0LqJ+8uC8upOdN4w=;
 b=I0fMyFPibTKyEWRZB6FWZOZWhcLGcy465vlT6p6AhCASaW2y80qN8Q134FDjwVC6MQvVZmIfth2oBivGy9g7YIv7EHIaa3xuDvolwj9j5k/gu1Ix1vpu19HHAgvw2ltAb7BZmJGh97ijON0q6oq+dmuFmD2v6fPQcTlOxav4YakxWWuiGFC3dehJbz8AK/T3S8JMStPW8bLrhWUr7INmsS+augunRkvRxkG1J/uiOb4ViJZ+bp+zjtyQ11PQ8vqp/hdH19Vh4IEW2mTKmQfLG9baO4Se8jB2ZrMaU5575kB0BxEybYTGXR8vnrUVplftNkcovonDLR/PvywV1nCfFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4998.namprd12.prod.outlook.com (2603:10b6:a03:1d4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:53:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.034; Fri, 28 Jul 2023
 18:53:00 +0000
Date:   Fri, 28 Jul 2023 15:52:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <ZMQOiZ9p1nStFHk/@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i3CsCg7Uplkp/HB+"
Content-Disposition: inline
X-ClientProxiedBy: BY3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:254::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4998:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f3404c-6e4a-4e52-3979-08db8f9bddb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tWpABj2DcdhGuGsuqTTZTnj/q2ERtvoRpCOrfzJmsH91IwjbVmv7TtBZLbw8GpVG1xaDPeCNI7BK6d5ryqI3Dc3kEKLpJblqsjqrIlk+C9HFNRsbNDD5HtmQruBj26ba2Ph0tqIbQCQto54EwKAOIU5ejeQEyV7yBjparAG6PJy1vXlndmXtD5mIBMz94HvWi8hemEztf27idFGKiQ9IFINa1UR0lGGximWJbUPLQVf7tIPKNJsAzDkoGagL3gxp+g/enjSw8aeBwdkLzVAJIxoj3VvSrQgohkEfW+kxQ/ZPBMyGjnOnI1N2NvBNB2gsnLFGGf4lp7s0JLMeTp+MEhW/HIfA9LJK12slbv7wd6Q/ffqEOnVFnEu6O8RDe6eEa69dZZe5TfE3HUldNmNUpqZNWLtkgBv5u9tAQQfhWg93542vA8y6Zo+lb2n13MiGV82o34FVLt7QqzOKSolXK1j1Q7i4bPZjmx35nvvU6qtWEIdU4wzgFVvyQMgyFezcdIB42pb3FUF+CEmxN43Ctg/HMTK95GDXEUBUm63gokZXey5NuU/lSDEQbjUaCdqfrAxwzxxIIG4+t/vuyOBLP2iTiE9stWenXr4s9BhBP7evRs2RYo+VSbWSkwztRJv8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199021)(186003)(107886003)(44144004)(6512007)(6666004)(6486002)(478600001)(83380400001)(36756003)(86362001)(4326008)(21480400003)(66556008)(2906002)(66476007)(2616005)(6506007)(6916009)(26005)(38100700002)(66946007)(316002)(8936002)(41300700001)(8676002)(5660300002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2fCdB0tdDMVBo8TEP1VvoFNptnoUy5FOVzqzMOfeW8WlW2XdXtsS4Xt3TI1t?=
 =?us-ascii?Q?VxWdfjmGXS2pkchhvI4YOPp3on4MgDqq3H/jjkFRFhzDACgzSAeVCKmkTzCR?=
 =?us-ascii?Q?CvkUvANc7AGzk8gJyHoAG3ZUzruP91pEuNKVfVdoBuqtwJZTdbj3T6iL7szf?=
 =?us-ascii?Q?eh2lpzuUCS7d3vwDZzBgEYT6Bx4JF6b61UJcQ9iomzbaNy+UsmdYPM5RwdZQ?=
 =?us-ascii?Q?y4xTOkdx9UybO2XVvLQjHgcKr2itqn7K0qkiHi4z1P2ZsWaaIE/pfCVloLmR?=
 =?us-ascii?Q?XwI/Mkdox6hd48lHtYNraXd2oq3yZ2SVHwosWw53VZbmgkyU2dCLMM7XLIjh?=
 =?us-ascii?Q?KzceMQtdC1o6M3Rile+WpiWqxT2lj6/kn19BBLH8lxXSMCHmDM5HDeki4Em6?=
 =?us-ascii?Q?+xYK/3i/2jL2yjVrrjzScsXkWJ81UdWxLvF8kcSt4MT/GKPvclMSqwKzai57?=
 =?us-ascii?Q?hyJEoDxITwq21Oo3CeqkyipoUujTJOD5ANi/Wzz1eXjlO0gfbVmrVutRNl9W?=
 =?us-ascii?Q?6AS1Nr0CeZuLCaUQc0ELtFFGCyZz1+GIaJekfvE1KP/dYxRYx3dHTVlc6g2k?=
 =?us-ascii?Q?ytfZJa0PwKXqR/2bvX/aHQbL+n+noLTBL5ej13tPNq+fhI87zD6X6SjuI+h8?=
 =?us-ascii?Q?BSIGKU8mcZ7R0txy53ePcJVtFkpxHyo7Hk+VBz3BndmS6nKY1PP4pjLhFH+j?=
 =?us-ascii?Q?HUxyTqouJPi6+Zek9WyXKU64lMuymMiqbV90Zl53a3mSfjuFxUgX2sSBernI?=
 =?us-ascii?Q?NJDmK/fmsJu2mTGVxIw6zioSbkprKmCjJgt4WPIjHTIQNjsjV1FOaPhxrj56?=
 =?us-ascii?Q?+pnI5nC7ueaCWBiOYji/0TZiwJcEfAj+l0f9mHwNjGLcChmoI5kouKjyTDA9?=
 =?us-ascii?Q?z7hRFlGYRpIXvqNRJG9ko56g6M2mtXh4TJvWfR2ToSjhUSLiIZiagmd6hlZm?=
 =?us-ascii?Q?tcB6qr9lKzhLZiDgzqYOeYmzdwC7K0zve+zLNRt098XskcYjL+vcmhDk8ZMc?=
 =?us-ascii?Q?9XXFomnS8T3DCG6M6h94FLwevoio1HkNvuM3dCH3ocRvJ75v0FhS4BfxeX/8?=
 =?us-ascii?Q?3TAujDjUVZDbPdIAlqn6zhYdIwOlDS5ryV/p1m0gin+rVNCwdBX8avk411Gt?=
 =?us-ascii?Q?bVhAS0Ibo2orE0xOAvCxWPp3xRD5L63RY6Re2L4eAG1tHMZvwgTLrsqJr5bV?=
 =?us-ascii?Q?TP3shvWO3sL01j3jP5gr9ZplgN6dug25X6QfYtHrQ1NzwlXT8DmnXWeeXqXc?=
 =?us-ascii?Q?rUHvGSusGWUzqrNfRorBPxc9lhpMw+0ZoWSKQG2o0BILzE4OlEprbrLvqgco?=
 =?us-ascii?Q?KLIpk4x5urpBiFglYaVLTuyP8MtPfYW8ufdmeyrFW2aogjIIMzMC18LQP4rV?=
 =?us-ascii?Q?gOBT8rSkzKoFGMCYOm+L7OTN3DKG7e77Pm9DE2ymwwM22moC4PfO2bHb1Jk+?=
 =?us-ascii?Q?KKMRV9QcvCHudECbTZr2grtwezuA0j/Aa0ARo5Jk2W2Cuim7kdpEfPZVxstU?=
 =?us-ascii?Q?muIZQ3QQT+fSMASuNreE8aKzxCm9c0iyPGPFEFHORoe/usBgICRhUbSktqw4?=
 =?us-ascii?Q?9P51R6Ez4R9wCVWVj+Uf4ykt7NuANncAUUnrTkPg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f3404c-6e4a-4e52-3979-08db8f9bddb9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:53:00.7472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWMGbJWUcK8E5DEgolejnsOw0WKZypoF4D4EdSkBlWQxRxckq3M7p95NBnN+0PfI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4998
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--i3CsCg7Uplkp/HB+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Small rc pull request with the usual set of driver bug fixes

Thanks,
Jason

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to ae463563b7a1b7d4a3d0b065b09d37a76b693937:

  RDMA/irdma: Report correct WC error (2023-07-26 14:58:42 +0300)

----------------------------------------------------------------
v6.5 first rc RDMA pull request

Several smaller driver fixes and a core RDMA CM regression fix:

- Fix improperly accepting flags from userspace in mlx4

- Add missing DMA barriers for irdma

- Fix two kcsan warnings in irdma

- Report the correct CQ op code to userspace in irdma

- Report the correct MW bind error code for irdma

- Load the destination address in RDMA CM to resolve a recent regression

- Fix a QP regression in mthca

- Remove a race processing completions in bnxt_re resulting in a crash

- Fix driver unloading races with interrupts and tasklets in bnxt_re

- Fix missing error unwind in rxe

----------------------------------------------------------------
Christophe JAILLET (1):
      RDMA/rxe: Fix an error handling path in rxe_bind_mw()

Dan Carpenter (1):
      RDMA/mlx4: Make check for invalid flags stricter

Kashyap Desai (1):
      RDMA/bnxt_re: Prevent handling any completions after qp destroy

Selvin Xavier (1):
      RDMA/bnxt_re: Fix hang during driver unload

Shiraz Saleem (4):
      RDMA/irdma: Add missing read barriers
      RDMA/irdma: Fix data race on CQP completion stats
      RDMA/irdma: Fix data race on CQP request done
      RDMA/core: Update CMA destination address on rdma_resolve_addr

Sindhu Devale (2):
      RDMA/irdma: Fix op_type reporting in CQEs
      RDMA/irdma: Report correct WC error

Thomas Bogendoerfer (1):
      RDMA/mthca: Fix crash when polling CQ for shared QPs

 drivers/infiniband/core/cma.c              |  2 ++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   | 12 ++++++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 28 ++++++++++++++----
 drivers/infiniband/hw/bnxt_re/qplib_fp.h   |  1 +
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  9 +++---
 drivers/infiniband/hw/irdma/ctrl.c         | 31 ++++++++++++--------
 drivers/infiniband/hw/irdma/defs.h         | 46 ++++++++++++++----------------
 drivers/infiniband/hw/irdma/hw.c           |  3 +-
 drivers/infiniband/hw/irdma/main.h         |  2 +-
 drivers/infiniband/hw/irdma/puda.c         |  6 ++++
 drivers/infiniband/hw/irdma/type.h         |  2 ++
 drivers/infiniband/hw/irdma/uk.c           |  5 +++-
 drivers/infiniband/hw/irdma/utils.c        |  8 +++---
 drivers/infiniband/hw/mlx4/qp.c            | 18 ++++++------
 drivers/infiniband/hw/mthca/mthca_qp.c     |  2 +-
 drivers/infiniband/sw/rxe/rxe_mw.c         |  3 +-
 16 files changed, 114 insertions(+), 64 deletions(-)

--i3CsCg7Uplkp/HB+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZMQOiAAKCRCFwuHvBreF
YbSTAP0QUDsf90e61yV4re1TyGIHvPH9xWpCmBR2Gte7KRrgMgD+P1w34TtI0NF5
aDa55Pjxytm74YqdMvQzCq3mU+acigM=
=B7o4
-----END PGP SIGNATURE-----

--i3CsCg7Uplkp/HB+--
