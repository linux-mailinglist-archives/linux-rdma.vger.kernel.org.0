Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAA059A572
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Aug 2022 20:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350560AbiHSSVs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Aug 2022 14:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350535AbiHSSVr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Aug 2022 14:21:47 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20607.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D77BB01A;
        Fri, 19 Aug 2022 11:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiAzkISIFpqZinL0XgyqHetEV8eQbwP85nDHzkJnyduiBBcxBfB1ZI1nOLv5iamqcXE5Pm9z5kOMq6AEqWb9yfuSMYy1EFYP4D3sCUyPfGpwXq7/B+mXn0qGLq7HcfgjW2lZ2XNvMpw0GOLwgliRDDeGUanHQ/R7xB9UH3x49XOG4uRQerZhRhgrHE4DxjBW009hIXaSyzLtdNcj8TmvKgJf4odw7U59PBPK3FcO+ghNdWLC7Ab8/GNPujI0Zeq/+TtFqimowz0Vuko8CKLGrP+3DnHlZIGvwVPoS5pXDhzxq6OZv8C8BLCpin/vQi931jvRXAbGE5SarWi37T6MEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hxEKZza8ei7+TZlerV3YLpDTb869TiAcdCGsM4njx0=;
 b=MYpOtwEGQPu1Gnr8+yv1iBAYZw5qG8/yR9A4KUntwlHS3Zg5uDobdQPwonLxr5XalynPJP1/we1oIpPu3hh/fgBEyujQx8+LQM+vWUcDMy43PBXlQrnGLS2unO9qyxsTQxPMPT5w/iL5hZr12ATTBGfZ94hDSgpGfbWPtdSc4F4nfs5YnXxsSivQ2OCTBfhvJ1VW/EXQwv4a15KTGowUqt0TUnYbIUJAnxbpKyv7UP5afgnaDKTWUitplzYPRTRzfmkN7kfrjPFwDqomJWQi+rBkFZQDPiGgrk0n6U4DQOemk3nCFGCTKE9GBFwooyDEC3QdNxdbbEv0d8M2uS4ADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hxEKZza8ei7+TZlerV3YLpDTb869TiAcdCGsM4njx0=;
 b=S3CpLpQk41kELTbCiZAeRwkm/HLZAfbwFA4OL66NUeKzcaQZxlolDlsSEHYFswpZAZMIdGbDRc0BGVLYiHWvCoiBBgLLXvm2cCxzmi0bTVoFJPVRfDujnMee+B6ZqxX9RELTAnzzKofnMl+Ieo8ZTW96uNzNJP2jv+bTgPntYW04YJ2jN4fBah9D6BG7ubpluPNfk2JLq5ICgcScbgbbpu6V7stS3uyDYI1scUujL+ghNzvRnKi/eTZ3+RxX30M31e5rIWaLiqqqntnGLMAmifMZhbK3XvwH9MqBnCzj4NUF8+yZVFvktLf1UBAzCrWCwBdaUk2c3+A6ixhjRznI0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 19 Aug
 2022 18:21:44 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%6]) with mapi id 15.20.5525.019; Fri, 19 Aug 2022
 18:21:44 +0000
Date:   Fri, 19 Aug 2022 15:21:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <Yv/Uti/+/VAycxfW@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4cKsM4IVqIIhzT0o"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR11CA0015.namprd11.prod.outlook.com
 (2603:10b6:208:23b::20) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78ff1fad-71e6-4dd3-b0e5-08da820fab85
X-MS-TrafficTypeDiagnostic: SA0PR12MB4400:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2R31qTZocLZucJgsBEB3GBnq6HQfE9yyfHfx9qSXqJ3hGmti76n+UjeTHEfl9vwOHRwRUBGG2BZg0rxZs4yfinzgqGaW9zDw8sOJ8xIKLMK9aR/QJsvPNUtvubMrOmAiS4CAO3pRoVohW/jZp0Oi8i3lDGxg/77qke15GqqwQ4oXF7qNWTBR1hknKoTvdTYzujycGdcxaEXGuUCdqikeqAKZ1qI6YFNvYjhZ6JSVp+SyuwiqiUwaI+l7XC6vODeHo7gqxpBpgCgaLsuog5hExTsI7siIPCwZgWmKYAnOGfetpLUFGB2/ezn5IEtjOYOrRA30jlEntmZ8v0UjRJynDk1hKKZ+AgoSNUHzRk2Vv7sf6wIqUclud2QxP+xLA/MjPLRoy99nSnlba2pYH4scAtVEWwTk/qsDfsBA0bGDB8WIRZM258gr7/l0lEfVCFGAKFHK2sQpnWegHwbsH9Iq+NmWTfT6GaPnOAg1tA09JqXO56v7Q3mestmTgQB7JL/yPpWH45vAQSZKbIe1G7zrmXyI3AdIVU0UlSWlrrRXerL+hWLokLbZdJoZlLykPjFjTDIoyjVp3kSlKsW7jlx02ie4JdxFplGBlwHJ1l0S82g8O8qzirR+yeYlQyKyfD78Q8VQ3hIecNx0LqDEsxrqKtaFRnBC4MQV6cXZDuch2g1T7uvNO+sgZojzJ5AvSwJmDp7f57MFb3qp3dFLNXkkUyH4rXPvmBrIwPFUTI32Mw23SHEvVvE5vbxbNqPlusr8v6p073vtzO97l0OPi7m3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(2616005)(2906002)(36756003)(41300700001)(4326008)(8676002)(6916009)(6512007)(44144004)(316002)(26005)(478600001)(6486002)(6506007)(66556008)(66476007)(107886003)(186003)(21480400003)(86362001)(8936002)(66946007)(5660300002)(83380400001)(38100700002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DYtvy3ZX+T43xthz1CduH1MCBFJ2MROJ+oBjqxv9oK4PP0yxpW44lz8ZcBcr?=
 =?us-ascii?Q?xKiA8SgR2bo50iVGlTwjqMvfF1KLPo9RwGRdKuNUaf7XKcSAXfRn7p0mtHjb?=
 =?us-ascii?Q?8y0zwoymLQ97c18ljI2RoCVyTePgDLsd17YdSqtknj6mut7EsTbOD/6EFh6D?=
 =?us-ascii?Q?lFqjHN8w73DC3CHIWXc2OBQWSnIOF6twtxhxhxJwX9dGz/kYg907xvV+3Dtd?=
 =?us-ascii?Q?Z930gdR0sEZBmlFFAR0LPikIbBmXY0Q1NmbSDZz5JJbp2HjtGZYGbCHIDlyd?=
 =?us-ascii?Q?5vABPlkDwWJHy4HUlpks9WLkfe+6LvfShI5r8B2keJHvBDhnG6kqnX60XcoE?=
 =?us-ascii?Q?TJweAGVGqSvdIJ4GIlMP4m7lK5r8Ix84kCtYtv8F/nNMLYpQbrVd9y218Rfi?=
 =?us-ascii?Q?MBsqTIPVQkLSHYqzga89U5jpeD8qZX++sC/5TTqE/6vGVM0Sq1lKu+0V8xtK?=
 =?us-ascii?Q?KARzVDHPEDtLQRFgIboEejRbaHaOmo8rnEz8muDVEPSv/G8d9efxVnYEvEsS?=
 =?us-ascii?Q?wEIc3AoN5LXf7K3U3VpYDwh8agPSiAe/q6UgKVOk7Y0/Q7z8gi2VQQBSDwsz?=
 =?us-ascii?Q?FkMHlbYIbUX8TMrIX9CtVroI4EdlWumHZyAY7KLAJtvx1GXi2Z/SAygbfWFS?=
 =?us-ascii?Q?GHDmeT5Yx48BgQD3qiv7U6vIwNcPoTQ5dL8yw/HmSyXgELxeUeEmcTsy0xau?=
 =?us-ascii?Q?QXNarALEt89FK8qarDUJWVY0YFX4Vdgqt4xc8dt+Li+6z481HMH1pdWoC2BN?=
 =?us-ascii?Q?6Fp2OmKeaGRqBcbKnSM9UxgHh/TDGiM2bjPU4QUr1nskFMHldp9mHOLb8EOh?=
 =?us-ascii?Q?puOnnnFx4c8kz0WCaRbS+kpZ50OiSaeh5o/7fTdinglE+tNmI8MDG0+/EcE4?=
 =?us-ascii?Q?jVJZLt/70vTNpji+QrI+Wx1lvD2QwPxnv1KghBKBtDQ+HUnIZhMgieli3C6/?=
 =?us-ascii?Q?G6fczU9pc2I7gokSsF6sAzIQgA7rm5ZZd0jSRWBvAdofNyz0PpeEoE21eic2?=
 =?us-ascii?Q?y/p1G36X04DIrprUxr7Sjx2171MnhT/DjGB3Ps/oT0hITpVZ1DoU9rxli8Hf?=
 =?us-ascii?Q?BU2BAn/K9mNAgvLkI2j67sTZoLFlTjfsUAtMqR9oTqpw3UzwkKxZBjtXGiUl?=
 =?us-ascii?Q?ckxfmT4LwQ1znPhw4KVVqLGzQW2s5XASte4gy1RgvSJLIolmKdc3Sa3SpbFz?=
 =?us-ascii?Q?+yAm6pwdmbbrLNvgbWZQ8IX5pnYaXQMT+hoHutaeyPlLvorQvzolpOQDHoxr?=
 =?us-ascii?Q?vfa1xPjEq6WIOUE72oDraabmwM5vhnlNeIizGgavc1LSN0+Ur9aQ9U254fLu?=
 =?us-ascii?Q?1ag4fU3OZsDRp36wQ6sEHFKFphwHcS2CxpA8G1YuKi5Uy7jKOF3HfZbnbwEg?=
 =?us-ascii?Q?HIRdvinBwR8IOgc4HDmeAeLhElcJgxbzZt+tbAo8BecMEa8rvM31slT6Mt+R?=
 =?us-ascii?Q?DhhUApez96w3XHWel12zkmYbSXVq7wqzt4VL4NDXrloen71JQOxTSC+ERYHU?=
 =?us-ascii?Q?MUTAMVKOaUnabD6vUJdWT88xUqCyBAVjNDSlbMXAAJ0n0EEpKd28L+z6CU4z?=
 =?us-ascii?Q?+e7nDRA/k+k70xjac+EnK85lCTN1cOVrQLijJvKS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ff1fad-71e6-4dd3-b0e5-08da820fab85
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 18:21:44.1694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +48Lf8Da34eCK0NXRpC0nFRoY5uwGxu4kOpTJYI1x/KPH5qOfXWVb5GeDKc1RIoq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--4cKsM4IVqIIhzT0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

6 patches for the rc release

Thanks,
Jason

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to b16de8b9e7d1aae169d059c3a0dd9a881a3c0d1d:

  RDMA: Handle the return code from dma_resv_wait_timeout() properly (2022-08-16 17:13:23 +0300)

----------------------------------------------------------------
v6.0 first rc pull request

A few minor fixes:
 - Fix buffer management in SRP to correct a regression with the login
   authentication feature from v5.17

 - Don't iterate over non-present ports in mlx5

 - Fix an error introduced by the foritify work in cxgb4

 - Two bug fixes for the recently merged ERDMA driver

 - Unbreak RDMA dmabuf support, a regresion from v5.19

----------------------------------------------------------------
Cheng Xu (2):
      RDMA/erdma: Using the key in FMR WR instead of MR structure
      RDMA/erdma: Correct the max_qp and max_cq capacities of the device

Jason Gunthorpe (1):
      RDMA: Handle the return code from dma_resv_wait_timeout() properly

Mark Bloch (1):
      RDMA/mlx5: Use the proper number of ports

Potnuri Bharat Teja (1):
      RDMA/cxgb4: fix accept failure due to increased cpl_t5_pass_accept_rpl size

Sergey Gorenko (1):
      IB/iser: Fix login with authentication

 drivers/infiniband/core/umem_dmabuf.c        |  8 ++++++-
 drivers/infiniband/hw/cxgb4/cm.c             | 25 ++++++++------------
 drivers/infiniband/hw/erdma/erdma_qp.c       |  2 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c    |  4 ++--
 drivers/infiniband/hw/mlx5/main.c            | 34 +++++++++++++---------------
 drivers/infiniband/ulp/iser/iser_initiator.c |  7 +++++-
 drivers/net/ethernet/chelsio/cxgb4/t4_msg.h  |  2 +-
 7 files changed, 42 insertions(+), 40 deletions(-)

--4cKsM4IVqIIhzT0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCYv/UswAKCRCFwuHvBreF
YUXpAQC56qR7c+Jc9Y5KBpWIip1FBpeY9ZcUXk1LD4oXID8dmgEAvaAndqTL8iNm
ESh9kiovr83xvoqiDXNkjzKkbl2caQ0=
=2z7L
-----END PGP SIGNATURE-----

--4cKsM4IVqIIhzT0o--
