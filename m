Return-Path: <linux-rdma+bounces-331-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5452680A549
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Dec 2023 15:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DBBE1C20D87
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Dec 2023 14:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F881DFC5;
	Fri,  8 Dec 2023 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m54+ynBi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D5F198D;
	Fri,  8 Dec 2023 06:19:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJC1pI8KZTiJ4vFoBnLTIMetueCU0UeKFQnRPGrICn02zLl6knG4qa3x3zQJyEZjxVaBh9bxrP1CC2QM1QMR+9MrebIHHQdDpyrMympLPzBqueJM2rDFe2UR0M34UQkETU2aDeUAwxePCDBj38VdPoLiRLpmSHzT8DkeLnhVNJY9zqNFBaAlWvVbAd+KK3AgYhK3oigOXErmGfpNLlVAZhrr0dPzQJ6pGJRhsGQ6V+Ytcc0JkI0CxhT/X4ysHSj7aBNBg/6BN9oVUN4lzH+uWXNkuHcA311FTFnzc9wDzfWyzKzDg5P3baMB9dA7CNaHG8HX7hynkGdbib+Ylaa6Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bb9ZJh8+GcdP3auO87OneF8Of3tRYgY0DH/bpkyL2Xg=;
 b=FYJZrRIMJKg988vIorglKVgoG1e11qNdMvrQeF9qufe4xszXxicLM0kbTStyD+HbvlGiXdBNsgo7GyLLhbuf10/a1kPeD/VEQPWmfmI5Ge3hgyiQrYRUfDuCH70ToVtWy9QjkBVxtHEICvp+igmfLaAq6/rCL3M7kNRpwTwPY9HNgau8M4Ur4SX2NkPanTaDtD8qGL8donK4YIVpNmHp3KWKQ6jype/hrN7W2a/VBeqSN56E2pbK/VsxEHink/u+V0CLFx05us4toaGb4bMSd4gInOFmEk1XCFxjfzgLdrG4VeEi22Vt+SOUKbj6Vylq7XWwMwz0Qu6O9XSyRfFvHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bb9ZJh8+GcdP3auO87OneF8Of3tRYgY0DH/bpkyL2Xg=;
 b=m54+ynBikHdjbnnhlNU3jItVFPu8CjDRj08TS9OH2hphSSQTYQpLdTSTg/NEm4zYxw1zjuxUn6+Vvu67noIReBtsQjgK+CMqAzwk/wbGuiVWSwvga+NqZ847rIKruA6IZM6BQLFDvmKzhLiqU3rzb+w843z1eTBz9gtPa5mISpkugUGgO/kvad/BqCov3J7HG2SYHB+w1wsn0nuAFqC2yZsvWDjCBMLAcBVaYUZQnp+cqwl8R8g5/RVDYomrnPnjqO/d9eWohLLzIjQKfGkNaYGzh5FTjmCeUog4KWfP5BEyiDuZy4nhEBcHAOZyfM8Sqt5y5S/BA+KOI5qqa1ffpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM8PR12MB5446.namprd12.prod.outlook.com (2603:10b6:8:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 14:19:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.038; Fri, 8 Dec 2023
 14:19:12 +0000
Date: Fri, 8 Dec 2023 10:19:11 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20231208141911.GA2934372@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BDpsy6xeZP2reSL4"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR01CA0040.prod.exchangelabs.com (2603:10b6:208:23f::9)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM8PR12MB5446:EE_
X-MS-Office365-Filtering-Correlation-Id: 287e9dc4-6afe-46c9-bf6a-08dbf7f8a690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b7GqgegKeMs7hY/8iio0vxEtfvFrZmCAYaguUGCSmlDEq58HZitie/1y/by2yNoyUd7pCJm411Vf19TvAEEof4vAFyWq3V/T8q6un3zm8SoWPCTZkD274dOkhrilL+VXQItc3YlwOAGXe83J9/99d8F0lO3Qf7Q6VzwAFlMbweMtT4F75ocnlVWVAr17yYmfN3mVRynnfjfQaufyyc53WxfDEkmXIx3I8xH3nkI29WfazbSVJGU7/SkX5+5uoH/Cl38/+Fv9ZFz/6vZUMKGAXl164TMxzLi+Z1839V2gBsl6076tctFSuq1r+8jSs739DVuUAj2E1UxR1jJYTxzcQBXnvRJgYLggMBE0l6z2C5dKzHu8p2/Y7Y5joeKCuzDNCElKZ80hhz+mVOZec8/9q1CI61oKxVBOvQoXxEyUS2BErJV+SQIijHCvjMluY22xlef96ua3uOacQAeLKEhZqbAZMTHGXnEqUcTRLOmWkxVhuVRl8n+fvRLmoRWjoCLljaWKCQj26h2JPcTLKIn7x2Z+BGOp6TPhNTR5Iv+outzGInFE1CmOJfRtfDJDWoK93pzjdpkEEAAYXFjFLeKWyNVGY0VkO+HthNw/X/HlCQJwGL+kiMjg4ITzP4UHXFJCrwg+c9yncTH6yQp7LY1sgiHyMKz6OZqNY22o4ivD/Fc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6486002)(478600001)(66946007)(66556008)(66476007)(38100700002)(6916009)(6512007)(83380400001)(26005)(21480400003)(316002)(6506007)(107886003)(1076003)(2616005)(44144004)(4001150100001)(2906002)(8676002)(8936002)(4326008)(86362001)(5660300002)(33656002)(36756003)(41300700001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dglgB6chxvJkpr7Hq/qlB7kNpVeT3OjPdv8ay67TpzJG1jXpnaX+d+XZSe2f?=
 =?us-ascii?Q?qa7pzluS/M9fJhuCnouX/SBI251sZAGYX2NI3Poth6WVyTdTqBfb+dbwhYfv?=
 =?us-ascii?Q?K8bFE3NgYsBwC6w3eQiBMj3tsPOfqSJs5t6EMKtd7haorpFmHOGIoZ4gGMKj?=
 =?us-ascii?Q?5yjambGCNStxyqL3sPKqT+faHJjUI1gAWu9Q80XQ2EHx4CF1Xge4aw0g17lB?=
 =?us-ascii?Q?cRXhZh21M7x48h7opd7alPsmbm/SGslySHufk/EfLnp41HZKYBvHsySwETdB?=
 =?us-ascii?Q?4IgT9goPCf89o5agHtLJ+J9wv7fMElH4PGegBhBM6Ghkv0BPkX2qyh/0av1K?=
 =?us-ascii?Q?pHJHbckY3WTWnLgB5i3KCuWJ2ZuDukX7YmJAlpW4cPOOccrXQXMxKlxUoCRT?=
 =?us-ascii?Q?I5wzHvnnJOd97MwcCfGgaJbjVIh21PWi+yR08kgXC8r53NlXUwkKIySxpcNL?=
 =?us-ascii?Q?QayOAOn01qxUeiIRJ5N+Mx3a19OZUlh20PhI5ml/rKdjT/4vkmSSsl9MnT9W?=
 =?us-ascii?Q?zAvAssvGXbcGwQ8WfA84Ai2pHLY8b/gJpKEFEowr/X0U0Yx6SxXeyLgvnFOS?=
 =?us-ascii?Q?grMWG5gf/+kl+RHbUqfubbM13juQJw7zFSWjWkw0XpKT+5lDGDT2G68IdHMh?=
 =?us-ascii?Q?QxhcZJp00WbiAnB+QP4jFJpCoRk3lWKu/kaoPPeQzgL31tyzWawuHXHakBne?=
 =?us-ascii?Q?jGGCI8ueOjR8CQSwQtvoF0sgG6tTplacswtYuX7ln3kwu1UiRcBjqOq4DAuB?=
 =?us-ascii?Q?fe36mizhXiIBaOTaMN6GP3blOHNd6351pzV43G8F1SkMfTSTL9/z1ep3vMAL?=
 =?us-ascii?Q?gPYBwnwvpw70n9oq075AAK0bu6Em7ho60yCI2bOcjJTkRNIqgmWAAcV589KU?=
 =?us-ascii?Q?IaGQb5rC9ONFGYB1/6L07vVtFEE0DUM31JdMNBSji5TPYGap08Tj/TVXDj6A?=
 =?us-ascii?Q?qX4HI+o62Xwfoxq0DXRYaCvH0esvY5RjmVL1IPizhd3lwc1L9c1aA6qIjCjI?=
 =?us-ascii?Q?d71KD+A4OmIRUCPD0EJ8Oh6NpqZhYYL4ilb7oZOjNegwXBg0Ia2bgUPuw3Kr?=
 =?us-ascii?Q?x+vkx47s/SBj4F0EJbdTvLhxlgb54xxz/zmovI+OoHgBoNpvzF9nqf2JXIHx?=
 =?us-ascii?Q?nxtmgS0aPwI5HlchBimULIPafiWl80465ZNKaqYJw07jpMlbqM1hsJXZWzZP?=
 =?us-ascii?Q?ybfM1AxYvT/uQptoONaEj1TumSJUt9cebxVYMB1hJ8M2wAOJ+9RVnefzj7DI?=
 =?us-ascii?Q?VlLwtIolZtx1uegaeHXCO+KTyRqOnmQMuGwO6x/VsV+JsxywESjzagqNtCWU?=
 =?us-ascii?Q?g3JfnjTXy9FVKYmIaemA/Y93v8I91BZt+dDkzOz78Tx8JRH+eiMFjiJGVdT5?=
 =?us-ascii?Q?iDjAWHF2JTnQ5RGRxTA14Kzca9SA9CgaV0Yh8XKmT6GYPbaZjtt/FUXz+0p2?=
 =?us-ascii?Q?lrh6QxZjWBBTKer4NSDs/PcDFPSYYPEfpmDzIqb6GZ7lLU5r2ifAtKD4YMPC?=
 =?us-ascii?Q?HM6oNd1al87x0m5yEOZVVBpOyEG1MJue4DU6yUOS9LvNZGqRT4doQG4d6ORf?=
 =?us-ascii?Q?AsYLz/kmzeasVfgaF1m++QrppqmSm7CO45Trytqn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287e9dc4-6afe-46c9-bf6a-08dbf7f8a690
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 14:19:12.2882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Z75gZjvvEZLnBRDICrI/VlO1AM4hahohlJ2G3z9UCvaydsTv1+lrqsWwkHAugPV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5446

--BDpsy6xeZP2reSL4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Batch of RC fixes. Probably the last till next year, thanks

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to e3e82fcb79eeb3f1a88a89f676831773caff514a:

  RDMA/irdma: Avoid free the non-cqp_request scratch (2023-12-04 20:02:41 -0400)

----------------------------------------------------------------
RDMA first rc pull for v6.7

Primarily rtrs and irdma fixes:

- Fix uninitialized value in ib_get_eth_speed()

- Fix hns refusing to work if userspace doesn't select the correct
  congestion control algorithm

- Several irdma fixes - unreliable Send Queue Drain, use after free, 64k
  page size bugs, device removal races

- Several rtrs bug fixes - crashes, memory leaks, use after free, bad
  credit accounting, bogus WARN_ON

- Typos and a MAINTAINER update

----------------------------------------------------------------
Jack Wang (4):
      RDMA/rtrs-srv: Do not unconditionally enable irq
      RDMA/rtrs-clt: Start hb after path_up
      RDMA/rtrs-clt: Fix the max_send_wr setting
      RDMA/rtrs-clt: Remove the warnings for req in_use check

Junxian Huang (2):
      RDMA/hns: Fix unnecessary err return when using invalid congest control algorithm
      MAINTAINERS: Add Chengchang Tang as Hisilicon RoCE maintainer

Kalesh AP (1):
      RDMA/bnxt_re: Correct module description string

Md Haris Iqbal (3):
      RDMA/rtrs-srv: Check return values while processing info request
      RDMA/rtrs-srv: Free srv_mr iu only when always_invalidate is true
      RDMA/rtrs-srv: Destroy path files after making sure no IOs in-flight

Mike Marciniszyn (3):
      RDMA/core: Fix umem iterator when PAGE_SIZE is greater then HCA pgsz
      RDMA/irdma: Ensure iWarp QP queue memory is OS paged aligned
      RDMA/irdma: Fix support for 64k pages

Mustafa Ismail (2):
      RDMA/irdma: Do not modify to SQD on error
      RDMA/irdma: Add wait for suspend on SQD

Shifeng Li (2):
      RDMA/irdma: Fix UAF in irdma_sc_ccq_get_cqe_info()
      RDMA/irdma: Avoid free the non-cqp_request scratch

Shigeru Yoshida (1):
      RDMA/core: Fix uninit-value access in ib_get_eth_speed()

 MAINTAINERS                                |  1 +
 drivers/infiniband/core/umem.c             |  6 -----
 drivers/infiniband/core/verbs.c            |  2 +-
 drivers/infiniband/hw/bnxt_re/main.c       |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 13 +++++++----
 drivers/infiniband/hw/irdma/hw.c           | 16 +++++++------
 drivers/infiniband/hw/irdma/main.c         |  2 +-
 drivers/infiniband/hw/irdma/main.h         |  2 +-
 drivers/infiniband/hw/irdma/verbs.c        | 35 +++++++++++++++++++++-------
 drivers/infiniband/hw/irdma/verbs.h        |  1 +
 drivers/infiniband/ulp/rtrs/rtrs-clt.c     |  7 +++---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c     | 37 ++++++++++++++++++++++--------
 include/rdma/ib_umem.h                     |  9 +++++++-
 include/rdma/ib_verbs.h                    |  1 +
 14 files changed, 90 insertions(+), 44 deletions(-)

--BDpsy6xeZP2reSL4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZXMl3AAKCRCFwuHvBreF
YcDJAQD032q65/HwdwWiPXFjPI7FJw9lGHHtJvxDWRYj7l7rFwEAxbBi+MoH2l1v
jJqjfiFUgw464F37t8v+GDlpMdEl9Ac=
=bscw
-----END PGP SIGNATURE-----

--BDpsy6xeZP2reSL4--

