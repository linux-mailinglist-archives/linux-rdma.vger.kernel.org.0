Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE7538B1D7
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 16:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbhETOit (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 10:38:49 -0400
Received: from mail-mw2nam08on2077.outbound.protection.outlook.com ([40.107.101.77]:22144
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232606AbhETOis (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 10:38:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QL9ZP03VEZTf8rAa+92X7IR7GQJMCNJcAX+xki1wqPV2Y8HMJxu62A2wYMakEKDnPgcC8js2e99cGeIZePVvY/qbr7LoQkzEj5J57YCqV8kh9eS0ugNtiKUlGlSuuLY5nzevldnUX2GeYW6bhDxMMLKbGerR89vK7tAfrdxKkdVuKMUdeBCLSnz2gANykfDrndLCe91IQtKw9ku7Zy5Go64bGBhMS8kQ89CVe3qTLbIGJ4WNsUWLPu6vmzN0wNP4aFe41ydhu6hbAmp8/kERho6+F9joEKBQnR+Hj0TXLQD7iT11jz/qcpHpByQ2kOxbhQhbnMok7K1W/v0iIVasdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KieMp5yJ4xLpHVW4LiCZALK8eCGkrwXt7MZY3Uq2Svk=;
 b=Zdg7+TKLoVvjJlPprL8Bb2e7ebkipcCSLQZNqReMQctcu9ObKMJ6Q7fIuTNMnsQ2OOUzlNe+5Kwy54kB0saMSQ4WF1SRbGDFhiUWMpyOaFijCvBvRcuqVzyJLgBNTBdm+071JdY8Ldm1RfeV93PzDDAgc4z0PqkPRCZwn5P8cUikLD422975ngms9g4ftAWWp0Ia4kTmXe22cU8YechuBqfhYaSmhBGt2MfuxKqYkdLY2L8ICxl0kyb/dGwAmHk7W6mWwMPtgDT/Q8Hoexm3fhE62j1U4E2UQXMmiB860ypZ0bGcnQLB841gUPe/nYzHrJKpv4wBrRdafZtNBP+dgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KieMp5yJ4xLpHVW4LiCZALK8eCGkrwXt7MZY3Uq2Svk=;
 b=fG+qkZfcYuEXykVb0nxPgUuo1/TGlpgmPxblq26qA4d6MVLLqLsJepBZ4conHDsL/6AdWKqqbRn0qxEsSKuIZoytrd6HvFkNtPy0ixuO6N5cP+4hMfdU9fEz5G6R+mvjoRU6L836nKiunzEBAq/pKHrZJX1ptBmU+hiiZqPAqSzhdVrVjeGB9VEQ+4uPITYXZx7ZHARw93vQKJNIErS8cFS0l+d+Hr7fO1SS64zIO6D2cHRm969drgdjsDUhzDcg4wypkJ0HPXs0ImvbLeNSK8jaSwXUYuUfCWFoGGJAd1yP7XFdWmhePxWIIVvaRiQKULgpBsX5zaOkhmDpXRGPtQ==
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Thu, 20 May
 2021 14:37:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4150.023; Thu, 20 May 2021
 14:37:26 +0000
Date:   Thu, 20 May 2021 11:37:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20210520143724.GA2715302@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0427.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::12) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0427.namprd13.prod.outlook.com (2603:10b6:208:2c3::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend Transport; Thu, 20 May 2021 14:37:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljjng-00BOOu-Bb; Thu, 20 May 2021 11:37:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3696314f-b44e-4a60-aaf0-08d91b9cc964
X-MS-TrafficTypeDiagnostic: DM6PR12MB3835:
X-Microsoft-Antispam-PRVS: <DM6PR12MB383503CD89EB0D05B282450AC22A9@DM6PR12MB3835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ueIZvH/Z101AD1SRGDvmBZn9rP8n701pXAFurdVeXJ7hLw+0HXwp/ijutizlZcTLGFEsaOKeiixrAZCUmFTSbozQDmemp5ykMKHgEOQfGxGemnwoao+fExbL5FkLJI7lTWSNsSxbuxl7cUgTu2qDr9/zc1JiYhPgL1Ir5xfg8eat645zSVIOyoF2P2TL3BTatEU1vvz1Nx9fIKY/FOTcCng4DhOzEEZlFqKoVq3BZbCaWxC45jlHLMzpHxa7C5xJRz+Om+qeXWwkmZA4YJ0C5n/dz7pkG3kW+sFfWyCFU5ko+Pa80e7Ybin2d7DKL2L2A/cap8C8maSwEZA3nDXIQnGMXzzRY8retLz0PJ0Zi56FFgIpuYMqBFeaYyIiMerDVgYx8vJN2FxOMCxDNLnUIqDUq5xpty4AJ5sgyGTQe1uTFOHjYs/oM4gSzulmIRjJodNZDFFdomiQctxWl+Lp3ltCZrThV/TQXXNou4g71jRK5v0X5aqhVQv4vH48GM9mfIL5BwW4TDkNhnyjKu3fWxxTBcUMpoaMbLcIDS+8F4sx8cfcHagGpjj9AYAatnqv/5AGpmN6wD3uGcfIqDG14ogg7EuGzRG1hFAL9uKCp2VarfzxMaM7eviiYHBB6GxkeN07UM9M9+/cO3z80FWbJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(44144004)(5660300002)(426003)(2906002)(86362001)(83380400001)(33656002)(2616005)(26005)(38100700002)(478600001)(1076003)(36756003)(66556008)(21480400003)(186003)(9746002)(9786002)(316002)(4326008)(110136005)(8936002)(66476007)(66946007)(8676002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PlEwg2u9UKfy4eBrU5jhGFbPaN42vZAuQa1nP7sLpN+6B/O0cTYFWmy8eIMK?=
 =?us-ascii?Q?dv37p25gsdt2L1sy+viUvX3hfquqb6hGzAvPzNpR+ZFqqbw7q2/ilxIJKBjc?=
 =?us-ascii?Q?du68SXzBltlRx/jH4wpiGHqdbX0ONZF/Y/Bdj1qfGF93tMvmesnajysD4Uv2?=
 =?us-ascii?Q?3rifes2FICHzeyAh1SYN2diGw+1TvdVOVXDprT9CxkcDV2tQ1fzmAtFvuw+B?=
 =?us-ascii?Q?U6lJbfS1u7ariuyD7SEFtOvbY+iO6IR75Yrn/foLapm1KTv68AoagqymMOxj?=
 =?us-ascii?Q?mJj+bUqODpCIVtXSbOgjA9iyo+X+8pccB7OAU8OtP0KOV+E2XkirPa5BdeCd?=
 =?us-ascii?Q?2JPE4MdbV6m3Vh7H//hPCx7QwI5xta6v0ELDj3bmUBBGNlE/UtCHjPK7RRQZ?=
 =?us-ascii?Q?x29iATWZoE4p2XLYqAi6DZQoyUv0bb+jkdcldb94nNapgl3wXN+lUMUZm0XU?=
 =?us-ascii?Q?hk983Mvxdd6wrwXkhT+VyZrmJs3iFr49IPhQG125+z2R0kZmbN6Xv1MpzyZk?=
 =?us-ascii?Q?bksT0eA7RZwqAuGExRqnBatkFFHHX362PGGaAkHdsLzzIUnxG5abkWvmB677?=
 =?us-ascii?Q?lXYM4V922/vFTUnNeSxzsK+fyHAO+ypew6/KFIAYhFrTfTtJuwh21v+E/cSI?=
 =?us-ascii?Q?JmCGQNBuK+CP8B7MkCRDlCfkiIBYLh21ME0NZpMx9soOSz75gfJ3AFmaOmSW?=
 =?us-ascii?Q?YZ0tD/xko+QJQ61J56yraL0M/Q9XqQgQtHVFO7aLSX1ey449t/a/s4sXL6SW?=
 =?us-ascii?Q?exshSKQFfit188XaPTxDkj+1kDGKLzMbclz02jkLEXY2Ktd+YLlONsOWXKoh?=
 =?us-ascii?Q?huEgNOWcsQNRrGW85eMed5q0qN6IMTMZwqGZNdGiFVY3oyT0TSzQLzYIN60J?=
 =?us-ascii?Q?8XqrLZ1v6hwKIpYoPPd1W8yHh4o7z7Rx9pvZxaKOB3x0cr5Du1agToYwgAUF?=
 =?us-ascii?Q?dhg1tTWh3Iqmyx9xXp3zZ8PEbaVqk1tnU601G4s5BxM14y8CT8iYpvIzzhKX?=
 =?us-ascii?Q?JUanbfMmVq03KcXeyDmtvXwzJ15JkXh0Y3Y2PHckp89Vj6F8O3khCLXTtdxv?=
 =?us-ascii?Q?c+uny/kDyxrq74aE3ml0NSL7Ch3W6pTQGRmNLxZ5o5HJxIDvOAP9LeBcRe9Y?=
 =?us-ascii?Q?KyXNGqB8wIHL3CwcydYmR6CK7SBamgfiPU5FzCz1Eg2qcRzAi+00/ZPGDptX?=
 =?us-ascii?Q?f//HRQpvCKIaYouGQ9IWk2npriRgA16ab/fGFAULfxJs71D7iJEcsuoQKHVu?=
 =?us-ascii?Q?sEtdSMYt6BtYTyot/kZLR8lW6NUnofUovTxdlmvpuXJPRoSZ4ADAE7iPwvkl?=
 =?us-ascii?Q?6PyeIFz4E8ErBDTsyb+bpd+e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3696314f-b44e-4a60-aaf0-08d91b9cc964
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 14:37:25.9400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1j6Gti2A8SL/oHp5MXrbblOSevix+p2QnYWQbUuWzXg442LFvj+H8RVkSw9BoUX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3835
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Nothing exciting here, just the usual trickle of bug fixes.

Thanks,
Jason

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 463a3f66473b58d71428a1c3ce69ea52c05440e5:

  RDMA/uverbs: Fix a NULL vs IS_ERR() bug (2021-05-19 15:32:07 -0300)

----------------------------------------------------------------
RDMA first v5.13 rc Pull Request

A mixture of small bug fixes, most for longer standing problems:

- NULL pointer crash in siw

- Various error unwind bugs in siw, rxe, cm

- User triggerable errors in uverbs

- Minor bugs in mlx5 and rxe drivers

----------------------------------------------------------------
Dan Carpenter (1):
      RDMA/uverbs: Fix a NULL vs IS_ERR() bug

Leon Romanovsky (5):
      RDMA/siw: Properly check send and receive CQ pointers
      RDMA/siw: Release xarray entry
      RDMA/core: Prevent divide-by-zero error triggered by the user
      RDMA/rxe: Clear all QP fields if creation failed
      RDMA/rxe: Return CQE error if invalid lkey was supplied

Maor Gottlieb (3):
      RDMA/mlx5: Verify that DM operation is reasonable
      RDMA/mlx5: Recover from fatal event in dual port mode
      RDMA/mlx5: Fix query DCT via DEVX

Shay Drory (1):
      RDMA/core: Don't access cm_id after its destruction

 drivers/infiniband/core/cma.c                     |  5 +++--
 drivers/infiniband/core/uverbs_std_types_device.c |  7 +++++--
 drivers/infiniband/hw/mlx5/devx.c                 |  6 ++----
 drivers/infiniband/hw/mlx5/dm.c                   |  3 +++
 drivers/infiniband/hw/mlx5/main.c                 |  1 +
 drivers/infiniband/sw/rxe/rxe_comp.c              | 16 ++++++++++------
 drivers/infiniband/sw/rxe/rxe_qp.c                |  7 +++++++
 drivers/infiniband/sw/siw/siw_verbs.c             | 11 ++++-------
 8 files changed, 35 insertions(+), 21 deletions(-)

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmCmdCEACgkQOG33FX4g
mxoBxRAAjdDxL0uCAPLet5JnU8OAo1NXLonzry3bXhZw6w514qM5k1jzeEkD8301
ewMrkXND/HsaC7gaFapPyQbv8/S8eZ0jL/q2yaYJ4bZd8jfjXno+n83FiAvAscjA
ars7dIk2pVvBmZhVQNw0GZd8mbN2gBgmaHbPIWJPsYz3KTlK+ZUHXhnZHqsehtDy
fbPqYcYRIZEuYAW1pen9PSsGIEUq+rQoNBw1J8CpFN5+IwqArlgCXZj7iX3tNLGT
x611FF1iYYF2jtFy7MXl7GmaiG9IWcVS3yy2WHrPoh9iWMxsy9RXou8Jb4wo3WHX
X4iVHPx+w92xLQYd+oxXBHk426asBEoiQeAN+p+FkbppXDp0bKq9C5Q5hoDNPAdm
9nqZjr0wQ/NFr/DlLiXNIryCNCl9fCpNAxnNYzi/ZyEnAVZkA1W3AjmqHy7DsEMg
AyUuxnr1eLoFUMIfUwbGak3SMCpjPtfLVR7aGRECJG4STwHueBLJ93aSR0ZrjThv
F+brsnuxrE0svywCz//Fokfs3IGt+QBqDt1UMiD2D0IhoR9Pa3cU6y3n39DM7+m9
ce5xQvs6cIpZ1sYn345Gr29MqIW4Gr0gFXINQeWOxdH5CFLeFhACtAc7IeLwqOre
bmO2qf47AnRbyQMh2tm5kV5E4Ys6qB5tXtpR5DvAR27wa/o/ebQ=
=tGrW
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
