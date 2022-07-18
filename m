Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E25578E17
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jul 2022 01:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbiGRXMP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 19:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiGRXMO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 19:12:14 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDCD2CCA9;
        Mon, 18 Jul 2022 16:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmbfzDMsu+0G9EdPYXYeAioZZvUpQCKD+uIN6OUvdgDQ16EfSCUZPr/m3JVhqg1DumDUsHq06prSdWDpwCO2m/lJJEMBU7genE+NfniyzUsY37Pnd5n/KaUVvqBIllXuqeJvDSmy3Bc0EyBa9qGJL3PHADO/pgTg9BRZzVxANNZeRBvzotP35h0WmbHD1tCep6IBPMDa0HucleW58UpYjdG3Zj4dRaQYfmZovdMFrHCiq+cGGQ/CvulJdbUgMZG7oYgSZwDhAs9BQ+qqgCVl/wTXZKEK4za2tyChHzTMirbou+37X6MiSirjMCZSYzkteFHxOC1SYq0eHOHdDiu+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYN/U2MJkiLuG5drslbVWkS2MFcqOKduOegr7O96NBY=;
 b=hzTC8ROvGALJGkDn0o4kj+iBB7lEiBy9kAfsFKrCAftEBPkm1sPMxyNGmRTzNrtJwsQtVGQe2gAdBznJbA/nNMci8GKXLOyrvx9BdB7BZnPdiHQC+9yNA2LWtVKHNqj0q3h2pBmKL3pMSH0vdKM7if8Ockbjviye7YEL4XTdCOSx0dSEZJVAQYQlS2MnS7a3EwvONp/m0Fu5kb/rc5FVLuaY1/fp7ZUFWWG+iWI6c9ChjBDgV1F9WVA7bNxxI9CwGGcxeuRDRk8aUO/cqRXPtKMFmwbWr7oEgf21SAUFgqjqbEeWYJM33e2tsFxlRAvOEiF2ee0IrIhkq85o+JvE0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYN/U2MJkiLuG5drslbVWkS2MFcqOKduOegr7O96NBY=;
 b=hSv1EgJ5MX2rDQ5sAMN6++g1fp+c0VSkcfCdUFd8jNy37rfjqWox7iQhFD8I8/RbcuWjnsMRjzVdTQIY0Q/2mq0PD48tj09ftiQnK5g3IRV1/w8AO9YIaYeDrYqJJ368kiZaoKqxqrW4NxkuFjEFsXpEzIpqougCgytdGaTcPq7WFExoXXYwCkKQLoMbFnHFTHgmiKTIP/FcUi0qt7qY7ac7VBHMfMb7Vyjwgpgvgccjm9oxeLnaNmryv4Ly/e/brUllkRUWnsHGWIMYRoNvKE/n3POthpqauLnAN3qi+BvqxL/4QZ7tpqlY1LNm+LvoeWnnTrAMQk9Hi75WFbZt0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW2PR12MB4681.namprd12.prod.outlook.com (2603:10b6:302:12::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 23:12:11 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 23:12:11 +0000
Date:   Mon, 18 Jul 2022 20:12:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20220718231210.GA143116@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR14CA0020.namprd14.prod.outlook.com
 (2603:10b6:208:23e::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d06cfc8a-175f-4db4-cd2a-08da6912f1cb
X-MS-TrafficTypeDiagnostic: MW2PR12MB4681:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IDQd4rvQEi8UTyg2liErtaGFw54dcRnYgdYDge8fGyU0l8SDFfO7bPag6LGlxz/OOnuE+Iq+LvbtOwHWlZmWi355a/eaC7qif06tP8deCgmXF7wEs3ge3c4gjHiFBttF5dH0Fo7ANdObQGpj5agbNQ79KKXHpzYbDFRslMXvCqenyCMvuHNRmB2gserIwmL7gc0L17Fyl53FsjmIzd6hsRKcBOrpX7zknhK7mG3QXYdvM2ZJrOQ5EH5f0r4mYi2XYJrTNJpQQ1L1nWPAcuKZibzTorD5f2JwySZk6ka1RBlXtJCE1oL4Z3wmCnZuHGHJKB1bXco+zLVIFN9OlRTkxwrqoO/XTezozczHfYueiFXMFA3K3rQ1BTutNlhOHToAMqV+HISkthdtvFtYbKn01CzWde3CGo5cIM317LyjveFI2tpPZuT+m/1eH49rxjMw11DHJUkAwBRWqto1gHijfTtSJ37R6HYnyx+J3r/5MGUurRXiozGe9w7DoT0OqofNMKBCrCmEzMijRnP2JtofO5hYwJbrZVa9UQ5yoT3FInbW84J6tLJtpUzgRTI6Mpl51LXJvkvdvKLqRmyki8ebl5V5UU5BPb4Cu0wJSPqxBGea51uVyTmOXseWQErlE/LuVyDfBIb4QO2NXBRvPGUA7TY6W2qgMRNVTy4Q1/K8LOtgVXbcDKw+VfiBdZG812Wf2QpaYN4qg8oxnFmPjkD6RchP2BlQ0DSXMz1H1VDCer9eMxrw8MVKd9j3wU1Dg7ZqpItguual7yaZ7IuhP8ZD2PxWA6KWeamsrYQckTQT4yUdLpAvGhOPfg4vrgTsKF9u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(8936002)(5660300002)(33656002)(2906002)(6916009)(8676002)(66556008)(4326008)(316002)(86362001)(36756003)(41300700001)(1076003)(66476007)(26005)(107886003)(186003)(2616005)(478600001)(6512007)(6486002)(38100700002)(44144004)(21480400003)(66946007)(83380400001)(6506007)(27376004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BRh4EGSL1lP4d8exzss2gCdV0+XNMQ/xzN7O2twTop7OigTV1+dIVhKe501g?=
 =?us-ascii?Q?BXeZjxDbk2DGECE9qtFQhgJqrte3kuxT3cTGKKQ4bKKba2MMH00M/ox3mQsc?=
 =?us-ascii?Q?3lvxTiio3uE1DXK2Dja+B4csvb76PgngGSiCxEfvQNrRjLrLKV/8Mq2iKUuc?=
 =?us-ascii?Q?yZU0aMPl3TYjpyERl6Gc8qOIikQuhV8/CAdn7PCooZdNOUIJKs0T3mUQ8RoW?=
 =?us-ascii?Q?WyHK3A6PBeap9jTnwiu28tXqKTSsGPXXpw4LFaOBtzLu0B8Fi3pi/wPwKJOK?=
 =?us-ascii?Q?Wg55sZOmUqKIRdRB0CJ88nr6haAknHsd4mj1TzsXJQwDwzKunZIm8vrHbFRm?=
 =?us-ascii?Q?+JzxEa7zdQdyy/6hmIA8GJ1PJf04cmPRZkusJKI5i+8eWVwX1ssx6w3KqZxt?=
 =?us-ascii?Q?j7lcTA6SJTGXEoUmvn4ZGqT2aESufLb3lA0y1tQVJlhUQ0ycvjikOfLgh2/8?=
 =?us-ascii?Q?0HgYVN6YmbZTBBdBpWEi3wVJ81Bs4qMR2dRf4G7hmt2oVIK4HI4t1cvf2vTg?=
 =?us-ascii?Q?/2l8T7UmvUhksHU2EPZkbVM5eJQ5LQ0LRC3k6mO84HVNNbkJHqL4cI+vepLZ?=
 =?us-ascii?Q?AI2Z+8VRf7GicKkjVVF7IoGV7rr6XNPUs5sEh9n6bcFYzmm87ot1bWmgy/vg?=
 =?us-ascii?Q?bXTRoroXknFY/ukmqLy/t8jmapHNUS/wKupAZlHNzYCJZru92eLwhuV06J4t?=
 =?us-ascii?Q?bbs+WqD+LKms5Jcpi0k3WjGnw8azboOY2wzCBY03V+OG+tYMOxRygJyJ8Grk?=
 =?us-ascii?Q?t9EhxuOlfuwFoXUTLk1DdXR9rGIeZ6+WJcjqbDNiARoCXNnHQEOyvOi4iiEu?=
 =?us-ascii?Q?2bKNuYpo3VWqcF58ldEz75zZb9nJp2BZsGEzSGub/Jb+3Fz+0qKd0LuMhgIs?=
 =?us-ascii?Q?Hne9O1A1iUSIPLuinuhn5YlNxTm41lfZeQVI5wzHxW5WbS/8Tqn88vrRlMX6?=
 =?us-ascii?Q?H2lpSvqP3c1FgrwktduxaLOHgiNQlOhHi5mrab8As/kKV4FiOdz8P7x8UUDg?=
 =?us-ascii?Q?6Xm8KeRxJrY3CDh11fmX0XA599mkSNmnzaO4+uI0KiCfBpPGAEs01ILd9YDe?=
 =?us-ascii?Q?zZlTSmyA+l/bTqYfVYJqi+O2gRtzdNjU2o5YkQXY+txx0weRjsgdQSArqMCN?=
 =?us-ascii?Q?+196Y+kIZigrWIMBDVfNp2dg3CM8NXGbfOBDDqzuAnh4LAi5t2HjyghLw6An?=
 =?us-ascii?Q?odvuzK81GN803lLlJ5xV6cCT6Z9ocC1jY2jzo1x0kC99mln7ACapInHNfFPq?=
 =?us-ascii?Q?DEBMllSnTVIDpNfPbhG1AwnlUf0cXwPpDT0BuJIlD90gPRggRJufsNBWkQ6q?=
 =?us-ascii?Q?tfjdI2IvjyGA3Y4qd5D9q+IwQJsQFEZH7y5IzqOnXymsg2/HK/UMAdcRr3cw?=
 =?us-ascii?Q?h2R7rQIyghV5DSgDif8Gu/dRjjsiSDS7ElW+Pz4dsSSQd43EPv4W/EFnJZ4k?=
 =?us-ascii?Q?EePRlQDFAZ+r5fltc1V95BzTRIpBkTKsMc7nBSfyCEKe5ZyLSBfzON/oq94r?=
 =?us-ascii?Q?976cuOmzFGvbYS6BU/4ZCMI2sWpF9WLuQvUWZO3+nFY5jBtFur7xPLYikGUa?=
 =?us-ascii?Q?pOUrdHc+4KdE/hDdbLOpj7BL/H0xId2MJJKUkMs7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06cfc8a-175f-4db4-cd2a-08da6912f1cb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 23:12:11.4433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlqIqvZrOp2bvO2ArUWy9kZrujo5z2Q4doCJ4a++rzhHNCxnshVzkoOaq7HGpVym
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4681
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Two small patches for the irdma driver.

Thanks,
Jason

The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to cc0315564d6eec91c716d314b743321be24c70b3:

  RDMA/irdma: Fix sleep from invalid context BUG (2022-07-11 03:04:16 -0300)

----------------------------------------------------------------
Second v5.19 rc pull request

Two bug fixes for irdma:

- x722 does not support 1GB pages, trying to configure them will corrupt
  the dma mapping

- Fix a sleep while holding a spinlock

----------------------------------------------------------------
Mustafa Ismail (2):
      RDMA/irdma: Do not advertise 1GB page size for x722
      RDMA/irdma: Fix sleep from invalid context BUG

 drivers/infiniband/hw/irdma/cm.c        | 50 ---------------------------------
 drivers/infiniband/hw/irdma/i40iw_hw.c  |  1 +
 drivers/infiniband/hw/irdma/icrdma_hw.c |  1 +
 drivers/infiniband/hw/irdma/irdma.h     |  1 +
 drivers/infiniband/hw/irdma/verbs.c     |  4 +--
 5 files changed, 5 insertions(+), 52 deletions(-)

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCYtXoyAAKCRCFwuHvBreF
YX4iAPwM5tEkLdPtiaEnZYHCdaJ1AQUXMHrzyl3VaRjNIkdnlwEAvni6HdqRBMD8
+WNTRWmEc4cPkonFSbAncWlv4yFfdgQ=
=EhlT
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
