Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB15660BCC
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Jan 2023 03:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbjAGCMF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Jan 2023 21:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjAGCME (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Jan 2023 21:12:04 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15008B515;
        Fri,  6 Jan 2023 18:12:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVYNVyHOyVIZdOWnb2qLizxVdV/gK5Ond1k/LIyyqos9NXEUSoGgZNzVRITZzJLlv14Nz79CPfTAys3WQJVb7eqfKWuRguWUu/4AWDBBwllL4yX4WhPh5hbgtKi7qEunqfXViXLB0/lXhsruDUOUao+uhOUFfwTGDgs82AIvwXEuRdNNyJKTB6YxauB3kHSp73L7qzmHWZYMENuv6E1hTZLllRxiIHMhszJAlcNAZz0+Q57FvUfcGnzBoMmZbrvbrWp3xN8a3bpD/KjZa9N0roZC6LvsFrKqBdYwoEzrGJ8t0TFc9BPMBnCXHbJV7RaujjfGo8ig5qp09XAI0tvwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrtM/oCmDM0ykOe2rMyoN5Q956zp8QPEpgLhDmO0CdU=;
 b=igFqM22qa2mFtdDymx5K4jMOPVumrdM+Y0nEsfyBtXJTCx0JE372Yh76+M8KQX/r3m9xj4nTiyZ5WXXSzcTFMrzkIspdXBP/FAzupDUt8XbYBYb1Vdi2jKBxiGPosh8ismLekCuwkpiiJSw0/RVSxSA/rl9k+6lXmoMzVsX7V76Z4zHiJr/nHDuMW3f7xXW0Agp6Mg+u9XXAz0SfEFPGjh46z3al7CrPQr23mNMauq7l1iJMg9PJc9Fy5eBIX5snnxmSJtuCOR1WR+yBtBbW8BlL30oIT34oSPStEF0LoniEV8j/NlWcAxlJ63+F6kdNsi9ywf/ixRUSlMccm+WUPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrtM/oCmDM0ykOe2rMyoN5Q956zp8QPEpgLhDmO0CdU=;
 b=iYNqfmcvFqnPx1Jo8nFrmxOhd9+ppZqUNXq0u8vUJLAAsT1RuKfF0uEXDA8HPwdl63Roq3Wy9xKi1ige/fqwUqysctqOq0l6fQSRRmwKJrTaKZLhC8Pbx6qksO6wtZHfu7Eyc77e2e29v9pd3CB2VdYY0xap1a/mqZIbBtfK+QhgFNdmdi0+POKnzC/Qho78e9Sp65fjGb/Lr2EFHtWGA6FUmJ1yluLApuqnx12sgvBMHpmFAjW0hwMmo1IhTBL2EXzv0ew4kchgw+Fes6/HMA/7aS2G7d/JuFrN6x8V5zaCkGthVX1Py01lsu/kJGkF4+kshqpx19G3zM/dnzZZSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4506.namprd12.prod.outlook.com (2603:10b6:303:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Sat, 7 Jan
 2023 02:12:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Sat, 7 Jan 2023
 02:12:00 +0000
Date:   Fri, 6 Jan 2023 22:11:59 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <Y7jU7+B793cI61LU@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ekH2sQJTWB936xRU"
Content-Disposition: inline
X-ClientProxiedBy: BL1P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4506:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8a3af2-b7d4-4867-66b1-08daf0548fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zoYVm49VvEkwcjnRTLX5Yh4ATfEZw7kG28pceYpP1Z5SXDnRw1kTF/Wf+s+UeKKEI4mZAHwnaOrkNjXUfZqqGBPuyO9DAqiQG3+iClnYCbAmyG/j810O9f9gprXMUb/fNvuxr92TB+u8PcKS6n6tvBrOcw6YcOHzvGwnEeY5r8Ixrz7MCvWOSw+Nyl5eaxRhglubgJy7yFHv40o2Lafmpr2ZKDo0jQenZrCKyKEJaT0GjWpropKZu6yULoe28fO0UU8BX0N4K4Gm+1uf6CIUUeOC7ktKHgOnaUyvSRa7akQhDQ3+1jP9tDfyM9UhZutHOUweH3NZG8jHLg+cZFJt9EZrkK2FKu9RLv5i4KIfMmdQgs9L4al8nFu4N5F1KMEeQwn2uoxqR51jdUN7YDip7K9beQP1VKCv1lhwdbMxM4Ma5viwws3XDKATR2JRMcNTE+HGXcQMJnIP+mxLxvoJhxcxEC21W/xy0i7Qmrz0wxFGQGs9zMHRymz9mAIoDzj6IFvfrGaFnSaH7gAGRm1CCVQGR3A1msl/2DuVsaXT1S08+So31qR+bgqI65Ixfa/jhCDF1v5hVQjWxoQXA2JmL4EhkiLg/Sy8LlHcoSoc6b+i4l6QskfCBK3X00jRTtV9bK/1IW7BjH/xeF7gzR48iNna8SmkmY6/006eh+oRe8rywIGV+WE0i5iVnRiHt3Th/I3boaobJBmXEldqx/tike1U9Kzl1Rea4f+cDSfv6dw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199015)(36756003)(5660300002)(41300700001)(38100700002)(8936002)(4001150100001)(83380400001)(86362001)(66946007)(6916009)(6486002)(66556008)(2906002)(478600001)(8676002)(107886003)(2616005)(21480400003)(66476007)(26005)(186003)(6512007)(6506007)(4326008)(316002)(44144004)(2700100001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yhOUbGZofBM1xlrO12UqZssJSvpdThIzfgQRrBA4kSyuFgM8Rm8dxP2R1GEH?=
 =?us-ascii?Q?zd5ehBk+iG71fHATQgck/apCm6PnNFu221wkCyXsw42IGaaHnYzhOmPOtkKm?=
 =?us-ascii?Q?A/bJBVRB/kKTkBu113s0V52uvWCFOt89jAtsdrCUI6fqive6AvIpa2KViXv0?=
 =?us-ascii?Q?fizIpHRT6GXh761yMb8OcpiRg7WBumqrrscHjkJzgG/9TPfh66j2XdYakt7O?=
 =?us-ascii?Q?vdeswEwTkESNqzlBl5jXRwLns+MniwTvG9VMiKveccb1NmtwAONJDTdNHzNV?=
 =?us-ascii?Q?sGl4eLiCP6rp8ZAS7KRUrxCv3nFDjnG30Bjdih19Z609yi9YTXYVgCS3nNZu?=
 =?us-ascii?Q?MLVjW/mYGnURCvljXoMAshruDS0OTPsRIBggaYIoFhINurfpGThTxFXc3Ios?=
 =?us-ascii?Q?EyaeEk9RWMRRIzQ89o7RBxJ6WVqHf5LDWaMXUX9dswJKmBdk4RVWme3e4Hm4?=
 =?us-ascii?Q?ARzmYmYMNEzq3ArHueU/5E2wZyLOiKCH/pSXrOmWvr+2HKkHvkJV7yGMljhZ?=
 =?us-ascii?Q?IE7H0nLzMwZ0ejo4XnfFEnCpdzzxcxTlxfig2/el5VM/CT7e+iEWWcIVVhdt?=
 =?us-ascii?Q?rDwJjGhO5UM4Ig03UuX8z9TI/1SVjjA2nnf21/A7IbqtLUxlQ0F2f8+2J67r?=
 =?us-ascii?Q?S4wy1zC0+YZ3G4TvW9SJqWlwMPgvTX2DLFkvSSM/sPGspYT3gffpOu062PoB?=
 =?us-ascii?Q?dNE/dbO8Lo7SLeu6kXDTkqRRsD4i/49LJdy7HNq6VslqNfzlB60Y+kjXIra8?=
 =?us-ascii?Q?EKo6SjF/DyzX5ThVyWWaasnNjE52NMqPnNTHmRGNM6aTw1kL7OMKpR/QdDzc?=
 =?us-ascii?Q?xTwjOcrGEQuOfETtZALyn/hPs7yZ0hFUaKLtWP9pEKKuOkMgoE1i9Am0m4OA?=
 =?us-ascii?Q?IlT5IrsSHHvsBjfWeRqOkVyeAsQ7hbrhfr+0a/tgaqZfXrr/QYI958HxSVsp?=
 =?us-ascii?Q?6xImkOZOWUjZbTizKK/mOQuvrwhS5POoDgj1J3i7LjAbGNOOH7KohoAjP/1O?=
 =?us-ascii?Q?GNFvRfSqto2li94bvxmTT6KC4U7RmCOyl7GNvXjmfmqB30Fn070VL9y+U2gZ?=
 =?us-ascii?Q?09mrkWP914JFOs2OtoCU8+m4uJqS5yhvbxsFoYQaV4BFYfoimztAmMUkx3ov?=
 =?us-ascii?Q?XATt36ddD2jlR/KB+vHekp43w6FhRqROAH+OhzQtMOgNl0qxSHZDqDFT5QSY?=
 =?us-ascii?Q?FPaBn9Sj6Z3eO5EjjpuBhw2HBYjddF5WUwRboxVv0Y87P23Oz6NzJU+1HhDR?=
 =?us-ascii?Q?gaQGmeHA02AeH8kbRq9H3njt9kM8dw7TnlNRfGOc6nMO1CRMM1Vi2V79o6e5?=
 =?us-ascii?Q?yKpWyJ6Tmq6sgDYFn9RO5cadScrow5vjzUNLrMMRwuOwiriv2LdD2z4s9sil?=
 =?us-ascii?Q?GZ9M9HsGW+vzSWGeGVu9M01LYJfL0pPAnqWztZXNFQTXLWRK/8Gvns0J5tTZ?=
 =?us-ascii?Q?tFcOpr8Iql3YWaqxu/DC8BKGsiJOy19noaO8lKY3lWTT15MN02ZngPPOtH1h?=
 =?us-ascii?Q?hAd4oApcQ2mxi0YLMobDeOoWEv2ay/xVYty/u12XW2oPPWBZ1eh2mGpXBJJv?=
 =?us-ascii?Q?qqHTbOocbko9O1qFLeZHnOwVEndafUET/micM5WM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8a3af2-b7d4-4867-66b1-08daf0548fb1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2023 02:12:00.6418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATHTVUZpL6hdpVwso+HDjXVBcWCuHJ18YqZnAOBA6VrIrwk+IWLDziYXRDj9TbXh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4506
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--ekH2sQJTWB936xRU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Yishai found a big data corruption regression in this merge window due
to a scatterlist change.

Thanks,
Jason

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to e95d50d74b93a767a026f588e8de0b9718a0105e:

  lib/scatterlist: Fix to merge contiguous pages into the last SG properly (2023-01-05 16:01:05 -0400)

----------------------------------------------------------------
v6.2 first rc pull request

A big data corruption regression due to a change in the scatterlist

- Fix compilation warnings on gcc 13

- Oops when using some mlx5 stats

- Bad enforcement of atomic responder resources in mlx5

- Do not wrongly combine non-contiguous pages in scatterlist

----------------------------------------------------------------
Jiri Slaby (SUSE) (1):
      RDMA/srp: Move large values to a new enum for gcc13

Maor Gottlieb (1):
      RDMA/mlx5: Fix validation of max_rd_atomic caps for DC

Shay Drory (1):
      RDMA/mlx5: Fix mlx5_ib_get_hw_stats when used for device

Yishai Hadas (1):
      lib/scatterlist: Fix to merge contiguous pages into the last SG properly

 drivers/infiniband/hw/mlx5/counters.c |  6 ++---
 drivers/infiniband/hw/mlx5/qp.c       | 49 +++++++++++++++++++++++++----------
 drivers/infiniband/ulp/srp/ib_srp.h   |  8 +++---
 lib/scatterlist.c                     |  2 +-
 4 files changed, 44 insertions(+), 21 deletions(-)

--ekH2sQJTWB936xRU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCY7jU7AAKCRCFwuHvBreF
YUk2AQCQXvFXVTmMED75IO5F/K/ErO2tsK3MkB5zHzWIXqzWTwD+PP0tXGOtwsJ2
haWSHVa+UwVm56A2Lk82nXpOQr8SAg4=
=7weu
-----END PGP SIGNATURE-----

--ekH2sQJTWB936xRU--
