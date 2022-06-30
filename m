Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA3A561AD5
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jun 2022 14:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbiF3M5o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jun 2022 08:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbiF3M5n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jun 2022 08:57:43 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2045.outbound.protection.outlook.com [40.107.212.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031F043AF0;
        Thu, 30 Jun 2022 05:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrtHoGqe9iBKyVp/Uvfjgzl2+ztQcoAXtWbvuUpVz1V+qnjtcFsxWOkVQR9A/EArX2HmwiTFv0b/r2aQDwZIYSHXwCHRFKCEg8bX2g+YGa791v3cIzhqK6iX9ZQgf5hC5zRSoxNG0Wz0etW6wpz4LRlV7g0JG0bpQx/hVSCX4VG5yzi1PaxJVUYCpZbHQjKjGJi3Zzclm6DnfXIQd9WWoGobfi5uLnqsbGIA4G9euqVz0FYz5KCUDvMCOFGA/kuAEOx8q3RjXxEue3vDrBruqgCR2HkajGRJuCGlL0HkrLUc5JS3JrzEg/nj0cjerVJ7EFX6UYqwu/tUPuVG+574dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RW9RxJufLrpLnCuBs6crpTH66YnGUklAwMEYulHOzTA=;
 b=GhRtLpFHcjx1d9a10w+sZP7S+RRarD1K60ItiEpcJ6nO1Gkf56+n9gcThU26W7qPdfU4iCHaQusmUuY4zzt8nSvN9Afz/rai6dNUoKKvK2ho1D1pwT21CtBL6Lz1cxNhGT1ULnaqwqWcUxnE6uNSfx/vXxj7jwCWNKEPM9MMyM7XaFKZaufOtLeMyyfjZXa4IKibNcQdjx1WIEbPrV+Z+qFnV9p+618TXbRfQUmcsZ08xpfREmbkomduy3Z1NEizJj44QoCGJVQCB1ZgvRySjzKmU0rAIEg3E/UYl/3hb97KaIzB2PJ1AYdyI9UIuOvtUrJpRo2urfLtO0CxNnPfMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RW9RxJufLrpLnCuBs6crpTH66YnGUklAwMEYulHOzTA=;
 b=ZShDDkdwusk5Wcii30tt9nfMfOFEaMYzvHm3mrh5pVL9WhSXhhMbA5MHaqyoKdFfhjY1kLgLV9vxo0XrSPFuJI1PIcVy+CKVdYvhfDtO3hmMtHQ0hjBJ/NPRCrdnbA9tUQ98zAntDtXN0P7VwkzS/HZ97d1zO1XzUEiL9DWYULmS+IgrWdJbAMUa2VM6Y48+EvzRVgGVaZxXKzwEYICLL1NoqrYWKlhMhpD1/JtqJaWV/Pr1qjCDQgMyCia6PbZnUSX3i6ieVoQt/bfRVK4yLOb3o6yBFtKkROfRl6dzM95WNGuksVdvnuBvKdeRIJvCO8Mr/UzpId8GQJch2kxwZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR12MB1881.namprd12.prod.outlook.com (2603:10b6:3:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 12:57:40 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 12:57:40 +0000
Date:   Thu, 30 Jun 2022 09:57:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20220630125738.GA969304@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
X-ClientProxiedBy: BL1PR13CA0313.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbeb90a1-21b3-4337-b553-08da5a981d51
X-MS-TrafficTypeDiagnostic: DM5PR12MB1881:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9a0BA744m91jmDOXIZAGgsVORvGNri0iVyTsYQgS0JxKQ1yL51j0hbpLU5eRFtvdBqfYdFdk2DjpNR3dI4SgbnkquI+ZgZpnJ/nszTKlRrvf1lFyNIXNNZ1tIqcMQRd6BWRoOIEeI9b31x0xm69oLKV7gtMX9wAwuKgbW6oUmm9b4/4jaoRMh05/8DFP699p3/iubD4cMs/BtC46UXxePEYoe0bd0PmuvP/uzZ1XN+de7BtJj6lo8VdpPFuOi4Mg99/NfA6MOm2Pn6okMCv6lE6PVXlM2QtZVZ2mo11WWieAVXB1qoYZYYu57PSThesQX1zs+zjG36CW5RuDZ7lfoKNxkhg9L1CRw8pw26k4xi/YT9U22JyzVhIHXEw4oS4QAuUXxQtZk0uAEYnUSjjKssWTVZAv7mPWOy3awWzDW1xwTE+li+fs/HXwTo0ZyqglgbM5lKNd6ofWc/CkN+tLnwrgXokpqK+G1v4iYW0VE26kfoRHFnJYcV4ganRIkeyoKxawTad5ASbEzkt4IiteYW1BB4lQsGHYn4Ijvb8hz/xA+qkoTQN7nnoKq14HT6wkgplDApLtKAo0twE+sXvuTOxhTLdgANNXaGqr2BuikpcotOR3vMifvlVT+pV9fg9zTCiGmI0HXNFBbLevwbwZusRuQqbPkUhFTjC4faih2LgFZlHD4lQcSbJ9Cafo62yMa5d9nq5PCyDL4Z+dnkkmy5PED8zGG3BtxEDT79N0FNSN1cbE46ZbRCgBx0HGIKMqfavu0A3uHu6uzZv2iNtU8/qoZVm3MCs5HUb9/+KTYaEpm473QLxonTNoo7EWK/kWtrhYq7hqUJ7YqeKlsmGxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(66946007)(6512007)(36756003)(2906002)(8936002)(5660300002)(83380400001)(86362001)(1076003)(6506007)(38100700002)(2616005)(41300700001)(21480400003)(66556008)(186003)(66476007)(4326008)(8676002)(107886003)(6486002)(478600001)(6916009)(44144004)(33656002)(26005)(316002)(27376004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kv4Ki1O+NXWLStWDI+rOTFegIJ/hgcwGCS62nzu6DBnamdfkeCHVH+1iavgl?=
 =?us-ascii?Q?itTkqBu3IopUprahuZLF686FL2jztMgF9AZFOuyHc2LkEFqcIKn11KXaiB1g?=
 =?us-ascii?Q?rlEG1R4jz8iNUALMqtlVzLj3JLzsuNMVXDoXJ95hTnSKT0oik5U9wta+UI2A?=
 =?us-ascii?Q?KGOkgfbQWbVb73u/OUM9fm065Bcz6huh2Rq0LMaX3dQK4qPjqQDWJ9jJY4CS?=
 =?us-ascii?Q?UP3xdwAS8gvGQ3OluTHOx2qcnEDwQiM5EaUkntLS+ZgQsgef+SutJFz2YqkX?=
 =?us-ascii?Q?tOCefTMtRFbbv2XRFASt4XaXzBoiWkz3dwiW6QmAUJ0br6Iae2P4M0SNeDae?=
 =?us-ascii?Q?iIq5dsi/YOSqVXceQ0C6Jths6SUVY77BGiwg9HTAW0ANDkcWJB2WyvaCWx0l?=
 =?us-ascii?Q?bVvseDY9/yKPx7VtyT410Qv3r6mLKFfCNiJGi4J/asG+YtE6RsBpKisK1+e9?=
 =?us-ascii?Q?QFKf8pkA2a5KzYjBKcY2SKS85R4FsbrFQns28eJ170Utbnou8vtXiyoo6EQD?=
 =?us-ascii?Q?9b9RMfEyKlJAgQQl+IBpejqunOpws2pibQ/sGaE+pTZdL65JVRcc6wuGOYzS?=
 =?us-ascii?Q?pj3B9W6zhHlnxbz/QjbOaaRc+11xdQNzxejpO9GlouDsFUcnuVmFKymLxAKu?=
 =?us-ascii?Q?y3vAeHyCX6uXKB6qDh+HgaUQfLG0XJ9fpi6dhuiVBBGJmUrZMUq2pLcqegyd?=
 =?us-ascii?Q?oU3PnDpA7bjvp3Wu5rfYAlCgxH3f7EILC0xj0aGS++zE92G1Y0ZZdwLuLmgk?=
 =?us-ascii?Q?TP09u5lbinRMdSe4ZKoELHO9+BiqJYwECZAgodblSMVXIcHLTggCQy+oL+ZE?=
 =?us-ascii?Q?pmZ3P60N3W/ZKQ3gZ/rKvh3cmW65FxKUQ7OronDiGeRfRsoVC3edmx1ppeO/?=
 =?us-ascii?Q?HyZl8KugmbBB6SvlOn7YJyU4xrKLM1iPj9aimWB9KMX8SOrf7I204plZbUle?=
 =?us-ascii?Q?03k7A/MXHUM4dl2FUUu0ApZN4PZIuVIEpxJ2RLKFpz5QULnRBuF0whVjCvMJ?=
 =?us-ascii?Q?LqdL5de3L+70onn9ahEPc0n17sO2eUAu+QKXkN9P9asprBcC0hhoFNCl/qXV?=
 =?us-ascii?Q?AAWoYtssz8FwlGJPee+OLkZr3BJof3hs5KrVNoXmXVseVWbhZMiIynjwX6Nd?=
 =?us-ascii?Q?R/YXKv9A7UawjSoNhV4V0QxgWXffRiI6L2/lrVTrMzXlp46Ra/O+BEMm4e6t?=
 =?us-ascii?Q?NWBSVDUoFl7TywTGbbBkajCLH2UExP840Szu5pSZnHIm0TeMFzSltNPqtOoW?=
 =?us-ascii?Q?CDnxG+obGAPhaWECg3JW4pSKH8XfJsm/2Uu6Y7jTlp5MqmNznlvSvrNGKrMO?=
 =?us-ascii?Q?bsIHxaujqQvADnCq55ZLCoKKcI282jS7jg5x7OawoNYkYqRjrePwFZp8tpuQ?=
 =?us-ascii?Q?Oxq0FAwACdxzj4oLd/68kVHUNRyQlE7gTIysJYLYXTVa/iR3ofAfmzVRF2AK?=
 =?us-ascii?Q?bd1o65uL8dibX/2UBEWQbcdVKo+wjTH5TMRet8v5+Z31PJToJRQTOmPq1StU?=
 =?us-ascii?Q?9H6EIsDxt5FJDREbrrP508SuRpFn9vsy013DanYgxPK1Tyze8Xu2dVrQELgz?=
 =?us-ascii?Q?bGuc7f4GgFreBtDaVX5JtCr1FI6ssDGLAcRxnTFf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbeb90a1-21b3-4337-b553-08da5a981d51
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 12:57:40.0706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGvDGkVjS0MitAeNvCXRbbUEVfy43cGwdrCTJZmVKedtYrse1aSP8P1fkBWel4Np
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1881
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Just a few patches that have accumulated in the last 5 weeks

Thanks,
Jason

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 0fe3dbbefb74a8575f61d7801b08dbc50523d60d:

  linux/dim: Fix divide by 0 in RDMA DIM (2022-06-28 10:37:25 -0300)

----------------------------------------------------------------
First v5.19 rc pull request

Three minor bug fixes:

- qedr not setting the QP timeout properly toward userspace

- Memory leak on error path in ib_cm

- Divide by 0 in RDMA interrupt moderation

----------------------------------------------------------------
Kamal Heib (1):
      RDMA/qedr: Fix reporting QP timeout attribute

Miaoqian Lin (1):
      RDMA/cm: Fix memory leak in ib_cm_insert_listen

Tao Liu (1):
      linux/dim: Fix divide by 0 in RDMA DIM

 drivers/infiniband/core/cm.c       | 4 +++-
 drivers/infiniband/hw/qedr/qedr.h  | 1 +
 drivers/infiniband/hw/qedr/verbs.c | 4 +++-
 include/linux/dim.h                | 2 +-
 4 files changed, 8 insertions(+), 3 deletions(-)

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCYr2dwAAKCRCFwuHvBreF
YUPsAP9f0WwoLHMxOm3+yLmd+oKOOkZWlgxVCCT8ZdQiGI/MTAD/cjL9m5fQlQIl
3DCU5yxNsLMJnVXvfA5Dy2xEoWy2dwg=
=8XT7
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
