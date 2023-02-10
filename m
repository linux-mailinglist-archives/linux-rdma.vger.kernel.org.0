Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCFA6915AE
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Feb 2023 01:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjBJAhz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Feb 2023 19:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjBJAhb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Feb 2023 19:37:31 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2F25A91F;
        Thu,  9 Feb 2023 16:37:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUZqd8+L4Dj7RjriQxV4Vx/euLJBjOjTbwXb1YnW55jgRowpi1CgXY05BTw9f02XItMXXkh0umFCAg7yoKGxS4FlssY+sYva1L91vtOJHrJmXI4/Ry+h/rSaqZWLjBu7iYMDORTqipwELenNMNR9QfqTDQw27vCT4bNL5jV2/U3LXVjRoeemBHssVYgU6+KR7v+oSMMugqN8L0uFlRC3CPtnYrO1Fl31v/+NIN0MM0R+aPZiDOwTi26XBOka+0NEkZTH67A4vjTrHxyk57ZG69HUl5C2DtjcUPwC6OOxQDH4aXkIEvdY5PDujgve3AQYAPr5UYFrUaZNewZvsRrc0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRkiEBJ02jVy8x/gjh+cALoSEQ43UfPjOCRjmxjYt7E=;
 b=LIHRXVKtFgII1lr5pbgtBfXizvBjS+Z9y5asHnJYFsJ7ieHIzdCGHi+vmLyk1sOcz6GWtNRKVFW65FCvfFfVkrSwWiyFkNup7h/mLkpVqtlD90EyPKwZlmoqlwXCEPrDPUhqTv55kYGabWLKESS0Ld+GTJjM7UqQ7Xtn7P9YDFkfglfLwJfBFvGKJoo3VV/ZmsQyvh/n5FKwjDVtyDmn5wWJfiyVKuRECTtsC3A0PMS46smjhVQ9nrzxZuj19nH4XlvCvwfJpShZhezo6qdL78F3thySt9QwqJkXtJ3fx1/RgzZTAOw2S9YLOmXJczQZL7V0M43x3ioNCMl+HSBoUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRkiEBJ02jVy8x/gjh+cALoSEQ43UfPjOCRjmxjYt7E=;
 b=AUIlH/+ybmRP9LVfR1+/su9v4t4IXSHRt6+wIBBEWHFBitvEXWGPrEajdZbgwYc9hRrv9om/tWG7dbwBFoi/EpfvXmEXhgvIZhVx5N8OHxzNdPFW56n0MA2UTvVc20totEwk50q3CVzb88xFTFttOCjiJdZWrWUkmsWn1sHYCT2YDQeBzlkv2d5As5RBRtF6OgU2fG8eUT2MvnR+k2Yagoy1YvGR4UH2m5fFKNEjLv3np+Y8N8HkF/ytQsmXptoMsBEQ8fFlacCaC2b8Jh7r5W9lbszEe7frjP4a8iVmnz6o7++T6azt5uzI45AzP/e2bwODwtgmqoNHg0O3mYPyUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 00:35:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 00:35:51 +0000
Date:   Thu, 9 Feb 2023 20:35:49 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <Y+WRZa36TxqYbpUP@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ng0Mf+mXLvXueGVa"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:208:fc::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 1338aa32-5889-45c6-67a1-08db0afec2f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JIEuzcJ4trhk4DCv4ghmxSRTRpzk+J7qMUooqj8LC9HhC54ZNNKik8wZCTwas1Ow3cBuUeiAtDg1bny+4TafCUZG4w3evd2KAgfp0hnsRIOpH0qGndncuf5jmBpLSSSARdQynDw8Wal4FqF117dBHDvZr1rfNnqh04VeeAhiEYxhHva/OfkwIO1BPi1n4C27sf/R6mOejuJCSGwwrEUROUARpVfy3JpuHOczeoxZI/DflOAAfJT1vovXTudMlOqMb3jO92mdBJWYb6h18z5xnSEkPsl8pnWfL8+NHWmJCvafQUs+7sZOpRv2aPEj0IauKsMeD67qHGzAQPlFNPRKdvX8wh0q0cmI7fbcMEA0sNER51cM1fNIG8iqULb8yoC7suee9UBhVcS/NpDXAqmUR6cTBaB3IaYEHumnyeIb0UGlslBWVkTzPn6xVGM//JeTgALeoEaT/oq+uruMY+MfwfYSlW7nUQLfBc4TPLrxp6cNr2A4S/vaO7xquMi/uGMYtZ5IZrydNExTNl/AB+RXbokFg3UXZMhXXnZzL8Jk2qF3arKhuy0qajBpwg0PYZupWbjGtfy06hUAgn4u5AAvITjpx1HGGVdEXIvrVWAtiLEPrCdnq2Sah8X1ZGXx6ic42Z+gpSZkvXqEgHOkmO6sRHXh8NnrJkXo0M3VTaL3LCF2//m90BjZSSnpoYOIk50cS/HF5m6c/ZlIMyEnV1t+KWW70PL8hwvyVLj4r5MANkU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199018)(83380400001)(36756003)(6916009)(86362001)(2906002)(8936002)(5660300002)(4326008)(8676002)(66946007)(66476007)(41300700001)(66556008)(316002)(107886003)(6486002)(21480400003)(2616005)(38100700002)(6506007)(26005)(186003)(478600001)(6512007)(44144004)(67856001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x05kS9/4fEdwbvWQCDjLCQtzU4tR1ir4WJBlBHLFKysdatcC8LYQS0Gq1NRi?=
 =?us-ascii?Q?IxWEwEEqjspqMp8u/NDW8v/3rTBSDfqkCGvDrnVDwS9TEWsGWtGkaqOBmUsL?=
 =?us-ascii?Q?BxCCPdIQbugVH43Ri11Lac7nyHUq96132d2pcDQk5/mBRuJXS8voPWh3NSfz?=
 =?us-ascii?Q?WgDFPAGvHy+b4YW9qsektfTxa8LnMy12hRNxebofaTCaKBi1YG3j+iN5uU3Q?=
 =?us-ascii?Q?k4sR/+wCZU5mn3GMb1FvzJWEsL2MpTTtqJ+ojjido7K9zxgmpRqtWaECCYUZ?=
 =?us-ascii?Q?RW7TZiKeZ5mngXbO3So6JQYapZ3IBTInznl40aPBwA8dJEu+yIzFdYc+yo6M?=
 =?us-ascii?Q?z3sKlEv4rsG2uoISSz42H6l3r3I22cbjKj+4zSkWEU37mnfIJNMc1tglAUzc?=
 =?us-ascii?Q?+gjD40QZ5isl9HmfxCmDOOmpaVelunO9aw0Xoh2QyGzYeSxpVzW0AM9J+94W?=
 =?us-ascii?Q?+fXUyG9NZWQfC+nLwDw6V2PB8dy0wzKktjdx0HX/HGZxBMFr5/pjjTYTROb5?=
 =?us-ascii?Q?UrvP0AU9SfPDT7u53NG5BCEI/jwy6SwVyKHbXeklD8r9P0OICRK40E33Cqlo?=
 =?us-ascii?Q?N8pwTsKE4pFyQiOpEY80CR0G798Ef8EZJXyYgNu/RgiHbV6mbGIvUyDhkOYl?=
 =?us-ascii?Q?OzaJHit1zlDphhLOH8aM/LexUufkx77uj640uaOEA+tP1zTMWZBUqbNsayp5?=
 =?us-ascii?Q?q1TdMOpAbI+A0ByB+mbyaa5S018PRdtfL54RL+mMlD3FaTNMLJ6slqVt/agV?=
 =?us-ascii?Q?DcISNcLJJRDS6NaZLIPecz9Nas9A0+5f14AwrKXl7gG1qdy9y+9KxRjiKN0u?=
 =?us-ascii?Q?fFOA59hKg0wcRy/JMJLc+IfUMggscrg84ScdB+M0Pl1M6gy+gS44R9p0t+rL?=
 =?us-ascii?Q?aGsmSfaB7S2JfQesDzbCExp6X45Eh0YlzMp7lHWokoJwpgfTm3XBXc/YHso7?=
 =?us-ascii?Q?0gS3U7e25kw3i57qqn3eQU9OhuyJcsbbVQumJpFBU1nlOVJc7i6xTONDCxPU?=
 =?us-ascii?Q?M2R8PepR8lpWHFmswpCGrG407X4CQcgtdiEw/rUMuU8yNfmGFXFEz3zHliX6?=
 =?us-ascii?Q?2moEAel/2ocFtTOZUVbsCiH4u1t4QXAvU8RV5eRyMJdwPEZwEygPutng0IU5?=
 =?us-ascii?Q?zMGxvhSwQSpWq9nu+2wjiSDIlRiimkQI+D5N2HqzpdxaEQeJ+ycXWQxk4wl/?=
 =?us-ascii?Q?74yaBTSVHLINwqQUa2vGTi2junmaxXfYSnlDmc1Wt30jon37JnpyEza9936N?=
 =?us-ascii?Q?IMpL8ys2IzgUxMa1L73IAxu6G9FaWGvvwEgLMiY8jFnvgi3LedWH/ZxWoLcg?=
 =?us-ascii?Q?oYocor5NDE5uPhJ9p1EntZcG8Q7/Oj/gl32aRvFpDy8IeoKEr2MhIb/rZXxD?=
 =?us-ascii?Q?sNyLg3342LTsSFbLsukpzztMrlFINDRFubs4M31BgMDGB9bF53gX/4Xpr0Gg?=
 =?us-ascii?Q?VvoH97Q9rFNWU7AAeCkzODjPWaSD8DV28h16N2o6xxk/JuufpJnWb1saW4br?=
 =?us-ascii?Q?aHo07xY8qTMwoo4aJGjhFSB1Km/S1XmtH87WPDDDEq6Uex1P93KEE854iAXx?=
 =?us-ascii?Q?dMXSiQ55ohpOTqsNZBI/jq00w+7ucQuck2A+zjNN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1338aa32-5889-45c6-67a1-08db0afec2f3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 00:35:51.2993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuMWha8Rd+ywAACiOmHp0kEkvRHXoGz7Bjg7X3zUvqkTuhYuN3vNcNZPgwlUnQ8B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--Ng0Mf+mXLvXueGVa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Usual collection of small driver bug fixes.

Thanks,
Jason

The following changes since commit 0f097f08c9b3c1fdb6cc9f2dd423abc17d13f1a2:

  lib/scatterlist: Fix to calculate the last_pg properly (2023-01-16 12:08:31 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 2de49fb1c9bb8bfe283070fef2e9304d9842a30c:

  RDMA/rtrs: Don't call kobject_del for srv_path->kobj (2023-02-07 11:21:32 +0200)

----------------------------------------------------------------
v6.2 third rc pull request

- Fix error unwind bugs in hfi1, irdma rtrs

- Old bug with IPoIB children interfaces possibly using the wrong number
  of queues

- Really old bug in usnic calling iommu_map in an atomic context

- Recent regression from the DMABUF locking rework

- Missing user data validation in MANA

----------------------------------------------------------------
Dan Carpenter (1):
      RDMA/mana_ib: Prevent array underflow in mana_ib_create_qp_raw()

Dean Luick (2):
      IB/hfi1: Restore allocated resources on failed copyout
      IB/hfi1: Assign npages earlier

Dragos Tatulea (1):
      IB/IPoIB: Fix legacy IPoIB due to wrong number of queues

Li Zhijian (1):
      RDMA/rtrs: Don't call kobject_del for srv_path->kobj

Maor Gottlieb (1):
      RDMA/umem: Use dma-buf locked API to solve deadlock

Nikita Zhandarovich (1):
      RDMA/irdma: Fix potential NULL-ptr-dereference

Yang Yingliang (1):
      RDMA/usnic: use iommu_map_atomic() under spin_lock()

 drivers/infiniband/core/umem_dmabuf.c        | 8 ++++----
 drivers/infiniband/hw/hfi1/file_ops.c        | 7 +++++--
 drivers/infiniband/hw/hfi1/user_exp_rcv.c    | 9 ++-------
 drivers/infiniband/hw/irdma/cm.c             | 3 +++
 drivers/infiniband/hw/mana/qp.c              | 2 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c     | 8 ++++----
 drivers/infiniband/ulp/ipoib/ipoib_main.c    | 8 ++++++++
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 3 +--
 8 files changed, 28 insertions(+), 20 deletions(-)

--Ng0Mf+mXLvXueGVa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCY+WRYQAKCRCFwuHvBreF
YUkWAP9AXhpvJ7nUckDafpHIfcgKdYDvJ+9TZy/cFEXD1+wHxgEAnu8+0rEp8fzN
oeLgRzOaVNNqUGrGmOY5/3ifDPHbxwk=
=C3Nl
-----END PGP SIGNATURE-----

--Ng0Mf+mXLvXueGVa--
