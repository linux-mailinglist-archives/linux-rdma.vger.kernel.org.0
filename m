Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A082779BAD
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Aug 2023 01:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbjHKXzT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Aug 2023 19:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjHKXzR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Aug 2023 19:55:17 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8871719;
        Fri, 11 Aug 2023 16:55:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6y/T/DzKpHt70KZlPQ01YjzY8KBKUpZUizXaulPly/pSCjxAeVrgHnUnCFJIWFrKdbDBjiku0+U7N9daT3Ytk23DrVGdOwkzecw22HnsZ0mYfqytEnwajBBRBtQPO4iQzIJm736l31mm8oSO18hWJPpG7EprpwmO5ppid0Csy94xrCBHHAWLKDamsrvWjR4n5ZWZZI2TOdBWx3Mxl4BcIby/hUO2PW0nd9fsCv+UdHiVXep6Z4fw22YFOU9l05eaUgbtGUorxO5RVV6reeXNL7eObNojr6IPONqnA2K0yMKbYYqI4+xgTuSrG5mixydeiNU8L9BA5Ob2qyIKyFRGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUxe9lxBrHC1wlSogaBiJM+VPNwUxPNyW/9ZoicA/8g=;
 b=jKgTcdUres+vBTDk4Ff0yrJFtEak2/lv79Onj7iUpjUw4+EGwYCq+3c/86quAXEcBo71eGOy7/nyGqUFzJpta8d/Vu/UGgUmpA65nUU/zsRtPCuud8JmR0JuZUi+lY/GNVcF4+wSEFFp6FlRejD6xqPLypkLE8KHlXEd0YB42WjijFDZfv80LM23Ah7i+e+2K0OH0eBxL71hUy80q2f0R25kEHk8VuOaNdtaQVrmTA2BaCUPlNr861XUV1fKQOkTW/VIIOGSY2nUsTyCibhKrRNMxmiBJXqHDqDO0qMHm6p5pVxPhoqEP2IH/pt+8Ky0MwmPIYd76cN9kgi0ae056w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUxe9lxBrHC1wlSogaBiJM+VPNwUxPNyW/9ZoicA/8g=;
 b=Ier9XvMcVl3ZIMIRRO+GDj/CsC82ta6zAGcYQDPQJBjU8/llspQxLSSCz1QCGmklxY9PNGa52Ke81Oi3ak3wQ1I7fg+hvA82bQSpVeov+u8N45AEqs/Fap1IjxzzDHc9G+CnKAf4q5p7gAFKM+dbiJw9RQGEZ6awW1hLLXW3WAgqIgEW+pBG1zhmKyVUD96SMR8nBmMdLe4//fb+zAVNRRxtZwY1MeLpo9QurF2x1Sovw0Lixo1cDMRT5oHJV2mD7tKejrqMeHzt22YGUlc0fzZ9nuEjUsGhcTHiqaDkSF5lkswWZx3t1poNlbSAKG6bzMCZKmOZ5yVXW5mKWjSyZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 23:55:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 23:55:14 +0000
Date:   Fri, 11 Aug 2023 20:55:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <ZNbKYH+u1lodzknB@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uxzEKKOve04VRk7Y"
Content-Disposition: inline
X-ClientProxiedBy: CH0P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: a3684b9d-4f1e-47f4-f229-08db9ac667f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sdn4tLwwBRAhp771/QRvIVEX5XFUFMZF5ycwNGLIAFOmIjhIExr+HhsOvSa+5U+E65RAoGrmVgDLlEj9pOGvSPF6nyiyG5+MBVmedpa/ch79yK+tU6LFxA+mxVuki2QBdu50ent1VBD9ehEvPVD9bxSwtpexQvnTQm0xdR8LabBV3b4ChYUjDyCWLDVwHp2bpkEgP2FdYPg/IZ0ZEWC26xYdmuVdaeR8O+swK3tIwIKXR9UQTOswy8h6NxCtJPe1hT5PksY+SGn7ISFERpuTogjJ4pe1QeOmRSbiUCVFBGANFilvWul/K9tQWWdCMaG07pFvpJBkdl7cSg3ZL2a7sCWroW6OTFkrHFuvV35bNnDU/mKVbZCt3mzCvv0gzKDdXfgtNfWgt2xVuKrSFMyur53q6/yPDNU8BaPAOYsM2+/HabG04zIdlX84V7VyGmzNcbby0j2Co6F+bs9k51mHZGukqqDm9gKv7sDTq/DhTN1evZCE9Fzgfmtf16uCHgspjZtWU01ACe0JskIXZfxtLq/Kz18eH7vLTkDsS26LW9EPzJ0GlMIUHvdd4awv44hcXjvg3YOIeoGhGAkcluZqPJam4am4UBmvxlelQo4KSHyCTIdQAxYIyHpCyVKkBuIhGWE7ksX9nyFODev7WUfo6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199021)(1800799006)(186006)(4326008)(83380400001)(2906002)(38100700002)(2616005)(86362001)(478600001)(21480400003)(107886003)(5660300002)(26005)(6506007)(316002)(36756003)(6512007)(6486002)(8676002)(8936002)(41300700001)(66476007)(66946007)(44144004)(66556008)(6916009)(67856001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dnzBZLbTRa0KYtflc6jjjilHD94wWFFVg7SBxyj902+SOzthGIuG5C7meVgv?=
 =?us-ascii?Q?ePLzALLSgEEBPrtv8El6JEaIJrFOC6fYAh4W+ERL9ZVtdZSbK/6ah/lKMDn/?=
 =?us-ascii?Q?uKtX0EInI9Igya3SjzSBG1cok1xPKWWKa6jS7Uma4r/07SdsNMgImAHLWSTm?=
 =?us-ascii?Q?8MMhxOqKcBrbL+lY2BBNYJNQWdLWPXospxSHmK/PxggwA5AUmmHKjIkXs3p/?=
 =?us-ascii?Q?4yLIB9C77udvcRKOLIRfaeefzT4vtzrfwxDI9f5TBbCUi0YanPHIC+GQaJ7h?=
 =?us-ascii?Q?kGLhb0TSkAmVqH5d3NNXmdl4kOFht4iNXg1KRukQU60fg19z8FoA0oWD9OLL?=
 =?us-ascii?Q?etL1y/oPA/dtnTV2W+DeSu0Rd3eF6cA1MUEwXR/tn5XCmJxf4VY9AjcwACrY?=
 =?us-ascii?Q?ySGgG6EUUQ09K6ALE4eOhZdpjzuZBcFJN6dx1d/RHM2fMDTHVzJMM1h0gk4k?=
 =?us-ascii?Q?qM5u4SbPnzF314PfxmiWhBI7ravTQfYw5VnnKnBD0fACaX5od8d4775idQVa?=
 =?us-ascii?Q?Jsx/3FiRpS2v2CqJoT5GAzEvsyft57YuV6j4V2Wjt950IbH2FmPchZLNJoNb?=
 =?us-ascii?Q?i72P/WFOHO3wQ66HsOgUpiwX7MAOVYIlIm5nXtQwD4nWkXq1SEb/B3I9V9Ny?=
 =?us-ascii?Q?1ykuwVYsQLjXUkUqbgdGyTjOtNV5z5JDUd8uFKF5Z8vrwwUhmqTe+p8BAMcg?=
 =?us-ascii?Q?RhZeJ/mmOx+1JhVD0o+/VqIER0deYXA0+UEMCps+vv7GT6hYPAEkxQgLfAlq?=
 =?us-ascii?Q?aJt1ho4NJVFe0nK3Fq1+zXljFxD9ADgL2mfagKLX1GQNykOmsOHiUo2zJi6u?=
 =?us-ascii?Q?6EFR5PV+URT9n/tzu4N76pNjoFAZ+3YGjNzveFlfxjYgm2U7rd38y4XahijJ?=
 =?us-ascii?Q?SIOChWdG2WdaO2q7Pb1chruZyg/3g2ITvdDLsbZzszoW8sYkL+yc5aUMDveS?=
 =?us-ascii?Q?9iYPQCSgxC3VBugDCh+KCDa/UZmGm9IuuFps85SQuLN76DZmPb8EwdUstKG4?=
 =?us-ascii?Q?YCgPYLGAO8dHsRNci4Gqy2J+un104+7IJ71LQDIud96W3JhN8LLlaGHxflKY?=
 =?us-ascii?Q?bnAab3XGXhxPxqxo/WnZltTv+x1UgrRixtxe03GJ+PHo1puYjbUngxwnmQ8J?=
 =?us-ascii?Q?1d86GfKDyDZNmEDOyI9Xp7+7Yk7NWl8SvWWZ/eT0ghD5bUlVC05ZjlAkcA9m?=
 =?us-ascii?Q?AZHwHP0gjnaYZmPi1Pj/eZaYZ7j5/QcGRLzdRk1jvVAOQD8QB2cDM3mDvQ3W?=
 =?us-ascii?Q?RPOh/keMaZH+1GcBDpIWvBU5IgoZ+wgy/ZEozIUROM7fN5+OLYFB1k7ciQPn?=
 =?us-ascii?Q?rUo6r0avgVKnkZNz4EZF1hvOWRl/OLxXJNmHFRE6RuoUjJ2rQ+uhM+omzdDK?=
 =?us-ascii?Q?FWAL53GSPy5mdDoCWaQT9qnulEnS+fpAWhfa5z2QyD17K9dbH+JKUI2kMGa5?=
 =?us-ascii?Q?8PJVKU774k/G0LmF9Le37KU1eS6j3T79bSDqdtBA9PtHrDcKKMs511BZjAmY?=
 =?us-ascii?Q?hZhxd2apLWJy1fKaRPO+KshzfuD6G5PI5B6GZ9vqgjebXh7+c4KUtSkPVvYP?=
 =?us-ascii?Q?DVM2JxjzMe8gGWu6NLIZql4UP+ZgO93BuP65GlWj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3684b9d-4f1e-47f4-f229-08db9ac667f5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 23:55:14.3184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yWj3S/98DaMSRn7A2voAFkEHe6Vny+VNmPjhS+7LSeAIzsCT1/4eYGrswCsGyvq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--uxzEKKOve04VRk7Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Small rc update, thanks

The following changes since commit ae463563b7a1b7d4a3d0b065b09d37a76b693937:

  RDMA/irdma: Report correct WC error (2023-07-26 14:58:42 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 64b632654b97319b253c2c902fe4c11349aaa70f:

  RDMA/bnxt_re: Initialize dpi_tbl_lock mutex (2023-08-10 16:35:54 -0300)

----------------------------------------------------------------
v6.5 second rc RDMA pull request

Few small bugs:

- Fix longstanding mlx5 bug where ODP would fail with certain MR alignments

- cancel work to prevent a hfi1 UAF

- MAINTAINERS update

- UAF, missing mutex_init and an error unwind bug in bnxt_re

----------------------------------------------------------------
Douglas Miller (1):
      IB/hfi1: Fix possible panic during hotplug remove

Junxian Huang (1):
      MAINTAINERS: Remove maintainer of HiSilicon RoCE

Kalesh AP (1):
      RDMA/bnxt_re: Fix error handling in probe failure path

Kashyap Desai (1):
      RDMA/bnxt_re: Initialize dpi_tbl_lock mutex

Michael Guralnik (1):
      RDMA/umem: Set iova in ODP flow

Selvin Xavier (1):
      RDMA/bnxt_re: Properly order ib_device_unalloc() to avoid UAF

 MAINTAINERS                               | 1 -
 drivers/infiniband/core/umem.c            | 3 ++-
 drivers/infiniband/hw/bnxt_re/main.c      | 4 +++-
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 1 +
 drivers/infiniband/hw/hfi1/chip.c         | 1 +
 5 files changed, 7 insertions(+), 3 deletions(-)

--uxzEKKOve04VRk7Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZNbKXwAKCRCFwuHvBreF
YWNSAP9VhnsHHR0uFY/MrgYFBL15jcJQ4PDN3vZb7gDwcTTAcQEAtGDzoMg/X1e/
5ymHiEUHgFirARulMIGnJhWmwt1zXgw=
=nHTp
-----END PGP SIGNATURE-----

--uxzEKKOve04VRk7Y--
