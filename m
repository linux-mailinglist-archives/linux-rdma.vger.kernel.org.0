Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6AFC46F590
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 22:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhLIVK5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Dec 2021 16:10:57 -0500
Received: from mail-co1nam11on2073.outbound.protection.outlook.com ([40.107.220.73]:2272
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230304AbhLIVK4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 9 Dec 2021 16:10:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvuwHYElFOrDNLWTX8cnix3w+5h2mKOBZ/BIHwl7iQV8Yu+FCPTlTqcrw4AJInPEQK/KZfPRAPP4WP150xOCDQGXQ1FAUfc3uOuBDWw4PEt7vtEyuNgQl7sZhR0xlJtQUxS0GVQqq9h1GBbxsfEaf4I9tgGkT12oKUwlzEudGsZbMcQVhZBNW4vGHLRaTaIf1um1NDgPfZgaafEiaIj6oBrZ0utV7Y3fCmfoYlqDLd0eTJVmXnmNmcDxtSU1prjkSlhkRlPbLnnUU/8/aXs7fuY7n46aP8ItXRuIpH6zu/DXliegMYothtNujZTYualSPidp/mrk9USR1NXjV2cY2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1EHN7nDnmDRcFb0ReloZBKbhW+KeEA9JdAThzWAh/0=;
 b=b4DYbQXpqPHcb72pUntvkQt7q2+gd+PU3ir40Zez3yCrqhtUJNcEzX3lIMohRYru/edxS4sUKHd6k2WDvO3UcoDpT0IgjcVzLvxDKZ8XtwOprRqidyJa2JVWW75FS31pL+bi1EUgeYkwkvBevikqiJiVtRccILV62lfGbNY8RtCNhjRdGMbGhMDyHc9owp1EneDOsimsUaumYNrQrjFnPWM8cbPPfeOEBilOeAt0tv9DlxXUWNLc4NATrUrXeUXaWIvx0viB+5AC701n9IZBzTEDUHRONL3TK6bd+d3RiZkE1CYlp2A7Qe8WGSb4O8HGm9SgB93mzlk7x7FfebyPiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1EHN7nDnmDRcFb0ReloZBKbhW+KeEA9JdAThzWAh/0=;
 b=VFHcOrcYJyWZQWpBY6XUtD+HqHCexTfDv7sgGxXrcyRlJXqnUo/K7zTLZ1NFgkIZaWMFxta8ZiGw6AHscLbkxJ55K3uYBTTNVQ0DeOaqO6rsTSDxg0AdnGtp8oVy/rxf7HQ6uZQEsJFs8jVsJe8Q/3QM7AhQONkErn+jJMmnjmSrCUYbXtggLRPBglca8eyrOQmi03guQHr1wqZxpK0002CDPhbUPMlO/E3TQsSHkq/0BZVfoHH9QsEhpX2xtb9ImTt4C1kUO1JK9eaWJFu3kZxF1ajihFGh/xlb+08QNLAovnF6sAxLsYkqyS0ISuhqkensXTb4iJfA129StjtvwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5046.namprd12.prod.outlook.com (2603:10b6:208:313::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Thu, 9 Dec
 2021 21:07:19 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 21:07:19 +0000
Date:   Thu, 9 Dec 2021 17:07:18 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20211209210718.GA343585@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
X-ClientProxiedBy: BL1P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2c6ef8e-b91f-4469-9365-08d9bb57e2e0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5046:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5046BB198E17C6ADB2579E3DC2709@BL1PR12MB5046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:198;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttAVtbXF/tsysj71q94FAO7XiTDsqsk09fALf91l+/pfl+J5C1b6OVYVdpOpnSkoR17HhZzWDAm8ZA/da0858FuPD3xy9BPHK81hYHuXiWwfJzY95tWqzAHA6RcL8jrFUREqGMQ2ZLyleUsqoOC5QQ5iMQrpUL3+n1mNG3v0OzOUzJh7hVX+ZgqXp+5tDjl3/I/bE2jl7V79WPX8A6yAf2BDtk87lNpmUlDBDH1bK5pgdvHIWwzdEz6l7C5ogk1i75GSAK2gS2aoJnC5TMyy6H9l5Zwuyapk7xWr19r0PzJgmYChCz0K/MPelp7EKv6+gF+KPqU0Due1onYDwM4YawTm8e7QMnz2wWOvb9s83YoZ6PN1gutUm3w0/pX5R9Rm1kUtKQ/gqXJeYo82SuGtax8rlUlRMOHc1YclG70ew+tAVkLPGnRpznnsrRfgpISIzYgHUTlj0qFvpz7UKF4+T+Z4OThvfo5bg9Omj4UVGPWSpSrpU0g3960+8aAFXGmCjjpcvuMzBuJJWxjVLippfJ7wHS6GygVdTMUedUOQTJKUHavYp+m1eLZ7Q51GsFcahH7+bA0ud5fdnzTLLzBZT2VMJkUpc4iQi4wy+/fWQYCe+qpiGEXNxXYoMCY6urufIpCvJIJpHsi+GPiq475fW18oG4OS2DquJR5IvvMqjTaB3L0M/mCkGoGZdMB/lxtjMVv0YUOnHPmaocT+Emf5QzBKB7Oa7QWubg4+TGchKMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(6512007)(36756003)(8676002)(6916009)(186003)(2906002)(21480400003)(4001150100001)(508600001)(6506007)(66476007)(5660300002)(66946007)(33656002)(66556008)(4326008)(38100700002)(6486002)(83380400001)(44144004)(316002)(8936002)(86362001)(26005)(2616005)(27376004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0mdCDVKE91W3eiJzO1G5DzGIJfZkz3uWpm+MYD1v2SzOOCqMtAdBJnc/oofg?=
 =?us-ascii?Q?RYDqCdpWe4ni/J3X21I5gaPUB1z09QYY6iiJUIMGuYHE66L9HQhslH0fAt9k?=
 =?us-ascii?Q?lObx9Jo+akLQDPC/PJVcyN4eV+M/jR+ZrOWqItYvszunoB50Vf9/CcYJxt5D?=
 =?us-ascii?Q?INyqtoYm9O5H2YnsRHRlpaly3+x7E+DcPyz9AjFkeIKl2/n7NjBZyqQKwXHb?=
 =?us-ascii?Q?VEbvbOzdrTPGbpvR1EfA+xFf3HJn5jMXHRIXeO9AWDvS3vCFqVl/sOim6aDC?=
 =?us-ascii?Q?duWlnG8br+i6rfh9zc3PClqFNfhVR5ts146mQfG1AjpbrcsFuS69c6EWZJ1J?=
 =?us-ascii?Q?ytI0L5kNTbzdE2sa9zOi+bEGFS+YaR9THxn3xQSws158dJRqh29m4d2bi6Au?=
 =?us-ascii?Q?vig9NMU8wHlRplWlzBIUihGXlTCzL2vnv4OXEne+dBFUCAVAMWFh36vXoxjn?=
 =?us-ascii?Q?uT+LRn9rHBmWHvn1rXAgrq92QSjWF3FovE55+yB5FT/CvfZUpSH1Lc/anXwz?=
 =?us-ascii?Q?b0NZSHqTqVMp6PJq/Y+hDVL6fzSgxz+QPPhyXOeuvPeY1XTd9AkQ5U84Wuu2?=
 =?us-ascii?Q?pTLsecBD0JnHCZuf0C+ZwSdG889uT8ObYPSkPuqYxYeYyz/84tgez05gClQD?=
 =?us-ascii?Q?Igu5vFM8N51XSiJhQyN7UvxWLpMdRLI7ac6ea/4qz32XNNtLLSP0sDNSgDJ7?=
 =?us-ascii?Q?C3hToE2AtSfJIORzjVZaIIdE3GG/eqHOKRuofCQKAI6w7i209mE5BfYFUv89?=
 =?us-ascii?Q?CZqXpXIQy1Njgx7cOUAJ0OF6lNEeeBpvPnQHKhpeRKwAKqC549Wmgx/bGNx5?=
 =?us-ascii?Q?gSDWtvVrm34kE6q7Hl3WnkILJQKlOuwM078b27h8flweyKNuuQhy5Fl8RBxs?=
 =?us-ascii?Q?sfF5WVQRAwfPQtXtt3/oGLb2ZxA2ENTyKBBeRtuy4dz09dQOMCl1GuSc5Gan?=
 =?us-ascii?Q?MkNcj6hmMPvhDJKw1eSjYOAn4dm6FrCzK4EGYEHKC3GOEmcBYpSzTOTwCLzA?=
 =?us-ascii?Q?XS3dgY86gY0QOacztOsRbgsnhPUHpIPDiy8Exfo08zwNeDdBMEB+euIYbzqC?=
 =?us-ascii?Q?YB65hTEfUATcpQmRJKGCaRUlcRvy/mpwXMJDp/owEcZOqmYebm6XHSxq0NqI?=
 =?us-ascii?Q?78jefysiC3gspqFKD5na51UnXTKxNoPXfESJFPm4nFqE7ic3pOKZtHnrMUyF?=
 =?us-ascii?Q?MnQQS+bwIbDEbLHqY57c3+xVMWZNP4ebEMPMIKjJ5O86VIbqKJ0frEaKruSD?=
 =?us-ascii?Q?pDOzCA1KpbRb3IrGWAnRtJcHAYZVnc/v7L7JLlytaIgKAQDym0afZ16H8vQG?=
 =?us-ascii?Q?T9hsJYtYl6lji2KY7GgVueVb929GCrvnynU3vqGXsoK3SZjMrutrTSFietM/?=
 =?us-ascii?Q?KbPajQUDFUiRs6RAOWHgcNQ4sLXwiYD2tupuZ+TfLligdLbL/mIu+DJjs0i9?=
 =?us-ascii?Q?Qb+nQ6W+e1iZTMmMnqFCpzrTKVReZL9ggGbo651sYNLgsLVZyf84TO27J/Ri?=
 =?us-ascii?Q?2VYMkmg1dfRy6XiTaOjcQlc48fzjCqhPobd51QqSXCB01DOh/87+qHFl/ggI?=
 =?us-ascii?Q?xjCrC+RMZgpfl01BYb8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c6ef8e-b91f-4469-9365-08d9bb57e2e0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 21:07:19.3490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wg1vBTqta+iEdJWDZ5BuEDw4xWC3IsDK2G6c0UeYgvWkTip3AviFMQm+ECkwjZqh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5046
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The usual driver bug fixes, but nothing that has broke too recently.

Thanks,
Jason

The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6:

  Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 10467ce09fefa2e74359f5b2ab1efb8909402f19:

  RDMA/irdma: Don't arm the CQ more than two times if no CE for this CQ (2021-12-07 13:53:01 -0400)

----------------------------------------------------------------
RDMA v5.16 second rc pull request

Quite a few small bug fixes old and new, also Doug Ledford is retiring
now, we thank him for his work. Details:

- Use after free in rxe

- mlx5 DM regression

- hns bugs triggred by device reset

- Two fixes for CONFIG_DEBUG_PREEMPT

- Several longstanding corner case bugs in hfi1

- Two irdma data path bugs in rare cases and some memory issues

----------------------------------------------------------------
Alaa Hleihel (1):
      RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow

Christophe JAILLET (1):
      RDMA/irdma: Fix a potential memory allocation issue in 'irdma_prm_add_pble_mem()'

Doug Ledford (1):
      Remove Doug Ledford from MAINTAINERS

Guoqing Jiang (1):
      RDMA/rtrs: Call {get,put}_cpu_ptr to silence a debug kernel warning

Mike Marciniszyn (4):
      IB/hfi1: Correct guard on eager buffer deallocation
      IB/hfi1: Insure use of smp_processor_id() is preempt disabled
      IB/hfi1: Fix early init panic
      IB/hfi1: Fix leak of rcvhdrtail_dummy_kvaddr

Pavel Skripkin (1):
      RDMA: Fix use-after-free in rxe_queue_cleanup

Shiraz Saleem (2):
      RDMA/irdma: Fix a user-after-free in add_pble_prm
      RDMA/irdma: Report correct WC errors

Tatyana Nikolova (1):
      RDMA/irdma: Don't arm the CQ more than two times if no CE for this CQ

Yangyang Li (2):
      RDMA/hns: Do not halt commands during reset until later
      RDMA/hns: Do not destroy QP resources in the hw resetting phase

 MAINTAINERS                                  |  1 -
 drivers/infiniband/hw/hfi1/chip.c            |  2 ++
 drivers/infiniband/hw/hfi1/driver.c          |  2 ++
 drivers/infiniband/hw/hfi1/init.c            | 40 ++++++++++++----------------
 drivers/infiniband/hw/hfi1/sdma.c            |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c   | 14 +++++++---
 drivers/infiniband/hw/irdma/hw.c             |  7 ++++-
 drivers/infiniband/hw/irdma/main.h           |  1 +
 drivers/infiniband/hw/irdma/pble.c           |  8 +++---
 drivers/infiniband/hw/irdma/pble.h           |  1 -
 drivers/infiniband/hw/irdma/utils.c          | 24 ++++++++++++-----
 drivers/infiniband/hw/irdma/verbs.c          | 23 ++++++++++++----
 drivers/infiniband/hw/irdma/verbs.h          |  2 ++
 drivers/infiniband/hw/mlx5/mlx5_ib.h         |  6 ++---
 drivers/infiniband/hw/mlx5/mr.c              | 26 +++++++++---------
 drivers/infiniband/sw/rxe/rxe_qp.c           |  1 +
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c |  9 ++++---
 17 files changed, 102 insertions(+), 67 deletions(-)

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmGycAMACgkQOG33FX4g
mxpIwBAAhZjawP8+QH/wThV6ol0zYkYcuYrfCKA7Z78tshsTBU0Q2T2xYc7tWD/o
OGnKCFsVzxOikJEPqb96fo4WugP8eSh6Atn3zDARw7jrrZejVXaodfE2Gd5BiuxA
JwfQzGUfPBvBhC2JbGZ43WVLE26sxLcJ7CIzEAwdklE4PQKf7RXGjNxp0IJUOJCn
KdPKAZ7Q5oUuxSTuLwFpKGqZVxXoRZGPoH80oyQt03WM97ekxPe+TtIDcDydTnoT
bk5W8OWg3XbIgKMvLWXmi/+5Dz27QXgHNBwfW36xJ9jWx6KVfR7+YV4rT5pmJ2Lj
nWo5/Pzlwd8XPGeUKb1wGx65z2m/Cq/7F9epg1TxWQyF6W4n22IXHTSAuVkYEkRQ
ajNaPt3hOYhPPXeLSG86HwB3btLZvPzgWzhz8TFpmnCIN4AAIt3LUWjll06P16PE
U02KaZe9BhGFgqEdGYlBkv8hDS8nmTOSw4eLV4ubAJXMjMqjTwXYHot3CGyxlNWU
l8eTpDvTNoeM7uY7qD6EzUy9gE9W+qvjSaQPbivuJDa4vgSm+zcD0z3TwHwGH/BG
CI2LOx70XrWPAR08+cIXzhd5SlQCyrdz3l2JC4fZ8R8NAbFTkLVcvOsR/PpUUnSf
R59zjybEsT0HMa8dbXrhGBMdkaJN/DLdeQW231CZR2D3d/KDcFM=
=JA1t
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
