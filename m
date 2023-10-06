Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5147BBEB3
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Oct 2023 20:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjJFSaf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Oct 2023 14:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjJFSae (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Oct 2023 14:30:34 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C58DB6;
        Fri,  6 Oct 2023 11:30:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8FmA76jO+c1CmQjddUX4efMdxgPmd86jFMiwI1DQ3l1+vsleu4/on4K1qMv9J+W2RbLErr59r2oUIG97NzWk/zDtd1krX74blN90UfU6vMGe+456M6SkOO2ovXcdrxiWBy8mWLJH7d4PlHv+ZhMMqleht3wrR2s8vm7XKWBPPKJIzkMVpAfXy3B7NMvAlBvCrwcse0OlqLvVi727fw3gN2UlSad9qYfW5k9m3gPrIYjo4V5Bb2tJy9c/GXoZaDvFI8Jx4DXXx5J0XvUAssATOV1wrR6750X7qk1wuLVKr3uWzjPFlispc32Zzel32CEsLwdG/TPcWryUiuaTB5JOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeonCzU3hNJvT9onsLu9EQTt9UdLD25nNgGIe8nk3gY=;
 b=nTkOuPR4OJ/32Rno8FpyePNWSCcH213UR9L+zeURF5TTutT/3dsnVurnt7HeM6lbtycsmfPNnlVmYzQs/bCZiUjVlng6pj3Np8lshYEYHA2zEkjWZN6g8FvRttVwndZhQ/M8DTv6jzrTy7QtErl5X3b3SaCuCIAiLso0DaH7gBhM03pCCusllU+H/Q1xWQHuuR2cBKt7SpuLrz/fi7wK/Q1PoZ4gHYHuZAxoAKI+4Saz4T9YuADbF2g32AhXAbcidXHwrWCsp3QqTCNurDam3tkrbFrjP1N4izoZKV59vn2x81xVZRFZ4K9fKMjatWpJFoyera/icDzbuXWoITFMhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeonCzU3hNJvT9onsLu9EQTt9UdLD25nNgGIe8nk3gY=;
 b=lrgEGdcK3hMATpzTWbRlCuvFbmN1bxnx8sGSxmi/hG2SsI6VgGJSgekUVI5AZFITZclxKYYVs1V/djqRkIy9sSC3+fVl/7E+3cWdOUzDh4NYI9wk294fWZQaBTd4fF196M3JFXk6dhGtvISCAMc70Y8l1CwMrpb6VVs99VsbBT3Ut1tit0j4Pfc+zG47MsY/YC+dCFMzH8pH+YkVmZ43R/PTISbXi9DO7T9mIS3j5zscuQ5xyuFdul6O9/6ymq/noMIDngB7NIpBlgQ85Vngbwd8nMAP7rJ6qFr0I4zXKuwC84twH2SwrfhZKNqfWn31e2CqT+A+pU84GhEzYJ0h6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5721.namprd12.prod.outlook.com (2603:10b6:8:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Fri, 6 Oct
 2023 18:30:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Fri, 6 Oct 2023
 18:30:30 +0000
Date:   Fri, 6 Oct 2023 15:30:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20231006183028.GA1213337@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OLKb0wYVX/A7YWt3"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:208:23b::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c3d5bb-aba5-4a8b-d11b-08dbc69a5194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSZWx92N8Nb9AOgvTXEGZuQZUGnH3D8wILH8SzvTfXfWdaP9PtBAmDvIUkSYdc1E3PveK4Ex5FV7RmM5tZ1y67s+3u7z/FLCsvNbw43SjdHuNkZcIVE4LE08Y8o1WO9ZqwiLq8PI7T4/F6MTG3XrUIcHEA7MudZu/ky3SxjWAu/btN2LGplyc0XPdBiOb6QpcFqIlRHefWzHvzhUhaxIWPUgFeZWDoAElAAyutOCkBCX1OGYJKMKy1hLA0ga4cQInCfYUKZbPxsSKoJh1F6f0STWowE3MBWGAQ4piUlInRHgxiJeRpDaKgmHKenD11wONCYwlasrT0GNGlj9a7CnchiZCmPiWOw0nKN/Ii+m3qNSK1qiqUJZjTO/ZnTu/L/zKxAiC1tpLo2hfMw0Hk6UhH0ZxnpQKgjZATg/eGj+R+Yhru8k3FOvxqWkyvDzoML1jRZrKqrW+EyQzpteh9i3dXas4GmrCdEP8Fu19+wdOkWhLsyaeeSb6dNtp2vZ75dtnnF32xTReZQt4/PNCr/hV6ceo5TvBV2k8TqnoDjyTmnlAsrasAyN1JvLSLeGPagPmz9M0l1KBCEOOZsA+lGvlMBIw7IP0cpTEKtDOXXp93SIvfztvQ7EDTQeTqteaP0B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(107886003)(21480400003)(6916009)(38100700002)(2906002)(66946007)(478600001)(316002)(66556008)(66476007)(8676002)(8936002)(86362001)(41300700001)(83380400001)(26005)(5660300002)(2616005)(4326008)(6512007)(6486002)(6506007)(44144004)(1076003)(36756003)(33656002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2lTU+FfX86qGw/gk57AfAcq2K3N42+xu5oiiSDxLidINZYhlpmT3EpE5QD9W?=
 =?us-ascii?Q?TiwIVhvqORNYuOQ6x/WfyxSqEzTYzpHw7gsxaMlcmXUwW76V94Bmi++5i473?=
 =?us-ascii?Q?3qDiUOMmjjYhRajmIRDdDO7WKxx3SDAwBSdpOYnwX6RgVHl/VnQ9TJnWrsb1?=
 =?us-ascii?Q?4Znaap92yxev0hlHzk0uCZIqY/SOkUaHJp5sB2ld/bWvuyucqNEZqjgHIeIV?=
 =?us-ascii?Q?de20/63aw4gPOuQyu1VvBMAGcXJeq8m3+wl6wc8MtsjsGMXs6ts/8MQvq8Sg?=
 =?us-ascii?Q?y0Wp1dRd3Gzf0Cc183KLwqVZ/DwTttsfBQIrvjDUbS82HiNFnYWHODmn01AT?=
 =?us-ascii?Q?CTJIvYOPDn9roQDiiGTzyj1qyeziXxXpWEtrvgjBCh0dhdYazB70NIonxLxP?=
 =?us-ascii?Q?WTvTqdNHTIojUo1XGDmVHa4qwRcQgaKQXh6siuAjo8BNHduurFjNJSJ/rvKN?=
 =?us-ascii?Q?kYZfKQVq4LqXZLsiiuP7Dk6RwE6MeihzD1iNwmQ1a9hT4yLk5U2WGMuNx+zQ?=
 =?us-ascii?Q?YFPskvgoilaSc7kfyD0t1nefFnzQjbnbKnK5wxZk0qVpojlC/+RRizQMtmrh?=
 =?us-ascii?Q?ZU0NJB1qMVud6UJtpz/GJovqSwfoPluHP7fcglIMTSZbxGiLSZBUQEpxHpOH?=
 =?us-ascii?Q?lekdQpuoYJAi2+nwtPdAVWDtKluauXZqXEY9P96S+SDryi75LOYOrxCjs5N0?=
 =?us-ascii?Q?IOL6l+3UcgH2LGxIz6ogCOw4AMrCBYtCy3r3DT+aZN4JNg8Y4TEbea+xU5S0?=
 =?us-ascii?Q?uFf3ZLKeDle0Ei3g5Lt9GMFIlATSLu+B42uwlN21rem84JlY/m7CdxPxztr6?=
 =?us-ascii?Q?SlGf0Y4FgKflHJMkjOasDOeCiB21o4EqX6yXWhUWM4Zp4Rt/ku5RVZ/s4oty?=
 =?us-ascii?Q?puWbne73SYTTwsQthsJ+/52aocEaNUL73bt2NE3Te40tTf0bw7TBqAds7nUW?=
 =?us-ascii?Q?AmcyoA576gqUJvQgn+HUIctGhQfrb++SaEy5Fi2JAJdid/tYhdtVP5Sk85rT?=
 =?us-ascii?Q?dIGsVYeIZ8gOXgw4r/H4XQR+00K2dLamYAhbKD3RQMzuOIdDWarcnUvg3RFD?=
 =?us-ascii?Q?i6z+yR9bUEsHgAyByOt92EWidyDJdW/uEgEh3wbcgb4uJMNxSWpKUcYw2px7?=
 =?us-ascii?Q?RoOv0X+Dc9mwTSWzBy0Y8LB0XRLyydfdC1aAOkV26MI7KoiNiO4BFiZx23sl?=
 =?us-ascii?Q?xKP8yz6rPjarKi1UVujp8WhL7Hheq2ApgNZ7tVp4jXy+gULRbVAWVIktvpC5?=
 =?us-ascii?Q?8cEkmC3XlXSNHCK4/gnDNS5kvaL9/MES5nWBYecl8m0kI5eFTCi2hChC4+Ey?=
 =?us-ascii?Q?N0W72wP/9yJsA6cWQwla8oskRtCq/9zfWvNkvDu3S70f44wF7uuCUqDLRa4r?=
 =?us-ascii?Q?hq17LUgtd5hWh5gjhCv2ee7HKX095WSqQdAMB+MxQLhQlX6Pa5Dj65LDVgGg?=
 =?us-ascii?Q?I7hFkWactFUKVZRBi3kGlngzk4vO2hHozxxXWRxdpVnr4OBbmleLWqUASUdm?=
 =?us-ascii?Q?QNwKwCRckjKutdEjli7q16VEOMoYzsD1+7qL6mdqxoH2anrd1KT1iWtpsogN?=
 =?us-ascii?Q?jM3m1NeygkvXjo6xL2p7D1MsSV0n4nyOpDFhFjxC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c3d5bb-aba5-4a8b-d11b-08dbc69a5194
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 18:30:30.0062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4T91mVu2lZtpqyFuScy6w6L955fUjljoGY+cAT9naUZYN6xCmr13DF8Llh2FJ5Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5721
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--OLKb0wYVX/A7YWt3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Accumulated RC bug fixes - seems like a more serious set of bugs this
time.

Thanks,
Jason

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to c38d23a54445f9a8aa6831fafc9af0496ba02f9e:

  RDMA/core: Require admin capabilities to set system parameters (2023-10-05 20:01:47 +0300)

----------------------------------------------------------------
v6.6 first rc pull request

This includes a fix for a significant security miss in checking the
RDMA_NLDEV_CMD_SYS_SET operation.

- UAF in SRP

- Error unwind failure in siw connection management

- Missing error checks

- NULL/ERR_PTR confusion in erdma

- Possible string truncation in CMA configfs and mlx4

- Data ordering issue in bnxt_re

- Missing stats decrement on object destroy in bnxt_re

- Mlx5 bugs in this merge window:
  * Incorrect access_flag in the new mkey cache
  * Missing unlock on error in flow steering
  * lockdep possible deadlock on new mkey cache destruction
    Plus a fix for this too

- Don't leak kernel stack memory to userspace in the CM

- Missing permission validation for RDMA_NLDEV_CMD_SYS_SET

----------------------------------------------------------------
Artem Chernyshev (1):
      RDMA/cxgb4: Check skb value for failure to allocate

Bart Van Assche (1):
      RDMA/srp: Do not call scsi_done() from srp_abort()

Bernard Metzler (1):
      RDMA/siw: Fix connection failure handling

Cheng Xu (1):
      RDMA/erdma: Fix NULL pointer access in regmr_cmd

Christophe JAILLET (1):
      IB/mlx4: Fix the size of a buffer in add_port_entries()

Dan Carpenter (1):
      RDMA/erdma: Fix error code in erdma_create_scatter_mtt()

Hamdan Igbaria (1):
      RDMA/mlx5: Fix mutex unlocking on error flow for steering anchor creation

Konstantin Meskhidze (1):
      RDMA/uverbs: Fix typo of sizeof argument

Leon Romanovsky (3):
      RDMA/cma: Fix truncation compilation warning in make_cma_ports
      RDMA/mlx5: Remove not-used cache disable flag
      RDMA/core: Require admin capabilities to set system parameters

Mark Zhang (1):
      RDMA/cma: Initialize ib_sa_multicast structure to 0 when join

Michael Guralnik (1):
      RDMA/mlx5: Fix assigning access flags to cache mkeys

Selvin Xavier (2):
      RDMA/bnxt_re: Fix the handling of control path response data
      RDMA/bnxt_re: Decrement resource stats correctly

Shay Drory (2):
      RDMA/mlx5: Fix NULL string error
      RDMA/mlx5: Fix mkey cache possible deadlock on cleanup

 drivers/infiniband/core/cma.c              |  2 +-
 drivers/infiniband/core/cma_configfs.c     |  2 +-
 drivers/infiniband/core/nldev.c            |  1 +
 drivers/infiniband/core/uverbs_main.c      |  2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   |  4 ++++
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 11 +++++++++--
 drivers/infiniband/hw/cxgb4/cm.c           |  3 +++
 drivers/infiniband/hw/erdma/erdma_verbs.c  |  7 +++----
 drivers/infiniband/hw/mlx4/sysfs.c         |  2 +-
 drivers/infiniband/hw/mlx5/fs.c            |  2 +-
 drivers/infiniband/hw/mlx5/main.c          |  2 +-
 drivers/infiniband/hw/mlx5/mr.c            | 14 +++++++++++---
 drivers/infiniband/sw/siw/siw_cm.c         | 16 ++++++++++++----
 drivers/infiniband/ulp/srp/ib_srp.c        | 16 +++++-----------
 14 files changed, 54 insertions(+), 30 deletions(-)

--OLKb0wYVX/A7YWt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZSBSQgAKCRCFwuHvBreF
YUq+AP9FS42HeR9RzUou9+VzqoZHIQNlABFRr/FDYahyqUFNvAEAjeBXJdEbm1Lb
+3AzVaDTnVAPHtldQZ+gDYFLi3NU3Ac=
=cylJ
-----END PGP SIGNATURE-----

--OLKb0wYVX/A7YWt3--
