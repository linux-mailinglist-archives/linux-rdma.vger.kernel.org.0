Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6465D486F83
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 02:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344153AbiAGBPX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jan 2022 20:15:23 -0500
Received: from mail-dm6nam12on2061.outbound.protection.outlook.com ([40.107.243.61]:58720
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239981AbiAGBPW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Jan 2022 20:15:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jrrk54sllbfsYt2CITQAuVuQh810YWbfNVJc8+CBKRghoLxsiJ5Fin7clXRGFOnKvPggJs2nKmAQ07Sy5R+Jyke3a8XadDR0b8it7TGXgmtGIDKvgwmFun4GvfdrQoJuJYpXMtYo19fxs6E23V0rORNzC1twiJ3hVaeEHFIKPJrjNizymp8SePGroe2d0De8/J0QFL5E1nD6g7FmWRGNpFPEQJO5SomkrrRtEGv/VaDVrcfK0xm4wKP370VKgSPISM2gG01Qbs4X5HICiKwjHPkMmpUisK0aQ43Gwy8QXqYvk7ufDsoabCe0sX1i5kNDrCLA7wl/z0VTW/CUqWPhtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Q9wwU4OgXkvGh8rtOc+wltudBEr35Ty8qRguv74igE=;
 b=MM7mpvnGmB85tkVwPXurPWHK0g21C719wIgqcOx18i+nQXE7e1YMVjfuC9WmEyKKmgbwm6LPDGudng86evpxvffwTy2E2SC8bq2hsxMSS7xGgLRntW4LfC+I7AcfIg+oesYA/Gs1e82Co9vt03o8gWqt7UY9t1QHIpJ9LTQ/434Uh0DxzzlGp/3tg9TboeNH6CoAcohUPLGp+mGz1+hLe3uwIndyIEe2bTe1Sec9E7lOHa7k2bfDhLzkQmUFlqc5hFuriZcyNRl423enGWu/WQ+Ag989T5zZXQF6WilKil67jU4WhxDifAcJ7gTAUlyyt9AwqhG0wtkzFrflsvUAhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q9wwU4OgXkvGh8rtOc+wltudBEr35Ty8qRguv74igE=;
 b=H+v8jTx9CsXqkuMbCOsqfkAtZ5akRoWejnJu6w101HvwfNzZeszgpKbT6QoypsHeYd3RM4D9DqGY3fImg2/dYDL8FZeX1z+mvbKpz6qP38fpSF3WauiTUvf7nN7VZibNr2UfflmI+nlVr60WeckKDnLhnsb5FlMYyXCfHU91lLp3koF2ctuUYlckcfT54Rrrsjw2EBmZBW0t3ylsD8cMQEhU2AwQxs8hHjvZ5+I+wzObkjgKmoqgtz5QkaOAMR7ImH8mHazdpJtolRec+0+cjArvtq0LpIiESCQPVH7iUykv7XUPf8mVPmgV6vtRTA7vV2JtFKrXxf+wrzWBbiuB/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 01:15:21 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 01:15:21 +0000
Date:   Thu, 6 Jan 2022 21:15:19 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20220107011519.GA3028671@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
X-ClientProxiedBy: YT3PR01CA0073.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::7) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ffa00e1-5703-4a74-ecfb-08d9d17b2cc8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5255:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5255BC52CCF41F8B7180FD76C24D9@BL1PR12MB5255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:305;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rP91uoaVXbdIFXLhg6u2ga52Signwb0uFHUNzZuwV26ULBCjAbxRZlO4NLm/UFLDvf+5PmYat2/DLggg8LmjNrzQyI7NJVFNzzZ54I+qw59akjz7ODXSo+GMU9UesiXzPeIpc+JQ0Kl/S50WfMvr/kGGOnK0b9AxtYoLdLbxV4IVV1v/487eeZz8WMAe2oXpVLstki2zMbidLtf0+UhKXy/1kkAHCsMoE3xUNjc6VBA5WPIksNVKqUwkCL5d7FGzeCOO6qnhv8R0Y/dqSAEFo0b2j23w2U3wOfO9Nb/auF5j5f+Tt0XIUJwLsqUZMyo+TtE+qcWJqgcARmcqA6mJ4WKUn4hHmJuPL0BT/B8Wj95aAUEWcQwzN38t4sH8OGXVUYRsW1IEYxz02McdVxYeghxozX4OdVSrhYZETZRE4LkEeWjy0BRtfVBMKo33Q4o9y3GlaD0DS0LJf3LzOCByHcVJMW/KE6/HtsTliWgNZZvkyxsQcmbdUwye6/Yv2pXGkA1OkrZ95hb00vcOSb+mDRoQ8q6ubsiIhbd/hs+4E8a54hsoe006vsZbwn7sey9+xYD8oYoM0sN2e4u4u1WSLljVM9Xw0NWzo+6U4ylG6T3cZwTEdCSevqKjVR2mgxLbunDa+ePQMPW7Vox8nkLQ9xYb03/ce+QzNiL1+k/NtcqtyN5i/AjNi49EWw9dcIgcW2KLipawGAWlJRRFoXVgvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(38100700002)(316002)(21480400003)(2616005)(4326008)(44144004)(36756003)(6486002)(5660300002)(508600001)(6512007)(33656002)(6916009)(2906002)(8676002)(186003)(66476007)(86362001)(8936002)(66556008)(1076003)(26005)(83380400001)(6506007)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gCuT9CEiAS6nhJnp281tFyGrHSfgN0CzjaHMEfUKNGtH1IOVxIFVg9W6jAIz?=
 =?us-ascii?Q?SDF/zaTaPYUH0V/xUY6GFP/9p65ZcPn0AlYUmY9xoF1ZogpPA83EREiTH8QD?=
 =?us-ascii?Q?sFXyTnJoK5kSxz8br994O6eIqbzR6val+cFPHkro/uFE7TKmQFhKtkAh4fIc?=
 =?us-ascii?Q?Xc/EcrS1Fh4S1Pf15cca7eeqE+Rbg5XuKxwF/wusNXNthVk2r9E4/VZzhTm3?=
 =?us-ascii?Q?81DK+TQYtUurLeos3EaqK8BGXyq9kVB5WMEdGfa8w755JVkYtO/it83G1aji?=
 =?us-ascii?Q?XjeicBzBLkHRc59SwD6elc+FvdMKV3xFj0R1R1WyDXF08odDdRwNWl1mMrsX?=
 =?us-ascii?Q?vjx2GEhuX2W5eRANPyrIK4NWtcpkbE55dSIO4Bz+x4/Z98dW78oymqOo0Cp2?=
 =?us-ascii?Q?tomUwHC0D7EFgfR+vS2zWz+1N5qqdaBo5lnUhoXwZo/edEdblGwwnDxDldKO?=
 =?us-ascii?Q?DtvsgPQJiKSrZuR4tchwM0U+t6ZHKTkSQ84ApvZJNUZX4Z8ZHvCZM6/4lsN9?=
 =?us-ascii?Q?pLiIEdNJfgjvL5sLKtTMISi6ywDUcNyzJbTCkRDry5EEcJnMHfQhNI98qeMQ?=
 =?us-ascii?Q?z4L6iIEDV0sDnGsveMf5KeqXFTFRAYv1BC4WvTZqyc8OAS3ldeG83wB32E4p?=
 =?us-ascii?Q?lmACDABj9qwJm/opE+nGgcugxNcFSo9gpxjk0JsIzu2ROPkqr6gHEarrqMGO?=
 =?us-ascii?Q?Vqwd/XcmE4BT25Bx5sHmw/ivby0FDXD6yN6ZASviI9+nZjSaNpFyg2x75q0v?=
 =?us-ascii?Q?xTFmwWLmL00LUB1dmv4j4hnM79p28SqKrFR+UfprgC6+IMDhupLCGa1xy2WE?=
 =?us-ascii?Q?ItfOPBq9Bj65JtSQjb15RBaBYuu/A7wNnD7U/ScaQZbeUGRfnAyTYbgx2k+C?=
 =?us-ascii?Q?IzIdC2lEY8WJbi/T4boNUf879xpUAnQ89mMeuw/tZYESEicXVBptL1J+9Qqv?=
 =?us-ascii?Q?BfrbB3ltKnnLeDLO91NNab2w7PkjvZnXSkJpIhpYfNLzWdFso/jLnw+RmXuY?=
 =?us-ascii?Q?aGYEkF5l9cW4zorgqA2LagcEHR7PPnJnFPiL4R0kMqS24bl/O5LQ30ZcXesX?=
 =?us-ascii?Q?EwrbmhtTVpKhknEjVj0c1rD8Ilukrz2LHbKif6lNNWPB/7DEuIsNfolFqUvY?=
 =?us-ascii?Q?8Ws9QYJgHccBwLJ/7tkC2VBEJYSNjVZpfbZrskPlvSq0zKQiTjhS389csPqr?=
 =?us-ascii?Q?kUMEm2gLl7jMiL3Wlh2m5V/9aCc0GwHLORe1vmZqpmAjTblPoR5HzsWhORjW?=
 =?us-ascii?Q?Uw/e+0grVbuJmh7j7Y3uh3McgCcDAmQnvN6/TG6fTl3lVDUpYcfNpzXkpuio?=
 =?us-ascii?Q?Jh08+oULJrm3AykKhN2I6mmDZUqfr2z/AnsCuNeBhoPhTHe3jlm+ZOPJwVK1?=
 =?us-ascii?Q?kPTcWo6oIuBHpHT8PEpKADBUkXdWSXFAhSolKYeDsAEUJ4DXRp9g0irzuLmu?=
 =?us-ascii?Q?T3Gaz8fWvIjnHgOYMaE0X/55to6i2FElK0BPVr99ZKiyogj5v8U0h8Y6CZd8?=
 =?us-ascii?Q?LdzYSRimB2JLu1UErh9lifKlncRi/7+p1U1O49Q6gLlvOxg+p3V49B6wpkBI?=
 =?us-ascii?Q?F/IFvQjQw+0oKPzsSNk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffa00e1-5703-4a74-ecfb-08d9d17b2cc8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 01:15:21.3120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFHRdcS7xnQ+uEzBFfND2eBt7Xmc57Nkuu7YfKyOU1AD4Y6Oq87rZBEuumYMvbJu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Last PR for 5.16, the reversion has been known for a while now but
didn't get a proper fix in time. Looks like we will have several
info-leak bugs to take care of going foward.

Thanks,
Jason

The following changes since commit c9e6606c7fe92b50a02ce51dda82586ebdf99b48:

  Linux 5.16-rc8 (2022-01-02 14:23:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to b35a0f4dd544eaa6162b6d2f13a2557a121ae5fd:

  RDMA/core: Don't infoleak GRH fields (2022-01-05 16:30:19 -0400)

----------------------------------------------------------------
RDMA v5.16 fourth rc pull request

- Revert the patch fixing the DM related crash causing a widespread
  regression for kernel ULPs. A proper fix just didn't appear this cycle
  due to the holidays

- Missing NULL check on alloc in uverbs

- Double free in rxe error paths

- Fix a new kernel-infoleak report when forming ah_attr's without GRH's in
  ucma

----------------------------------------------------------------
Jiasheng Jiang (1):
      RDMA/uverbs: Check for null return of kmalloc_array

Leon Romanovsky (1):
      RDMA/core: Don't infoleak GRH fields

Li Zhijian (1):
      RDMA/rxe: Prevent double freeing rxe_map_set()

Maor Gottlieb (1):
      Revert "RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow"

 drivers/infiniband/core/uverbs_marshall.c |  2 +-
 drivers/infiniband/core/uverbs_uapi.c     |  3 +++
 drivers/infiniband/hw/mlx5/mlx5_ib.h      |  6 +++---
 drivers/infiniband/hw/mlx5/mr.c           | 26 ++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_mr.c        | 16 +++++++---------
 5 files changed, 28 insertions(+), 25 deletions(-)

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmHXlBsACgkQOG33FX4g
mxrJrw/7BTaZqUol/zjvEvkkwJcgqFmLBcDdrMeqyg/47Rotv9rDSC3T4jn6hxkm
vLT1MPj8gJalbpBp+4Hmluw/qn5gDByxR3CG8O1Igu0uMyTnLFy/Sq1izKASvlmi
5KI7b4zfXkmDGHOwFAWfbPgCB+Vxl82V9ED8Rz3ReTsuqCIqC0bIV0WsoJcoUqFV
wJalgqDR1RUObLQuIRPldUN9IC2+bKHU9dSLI6vPXAKtHNCGGzTZsK/HVB699UtW
d2+eb50xoW5ITOz2zfsGprdONFoUzWf+MRIz0G40NdBxWLqAxFhX1kCNvR4nL2i0
YfcAiopWSEQ9np19vSKDKy4JiEmNRMoEVFxxCOaoupw5d2wYkks2r3GfKt/gjdAs
Y08P8FDpx1J1SJEUP8tdc1vvp7IJ+V8shVpjdCH78ZHCrNgY6w3hHjPT/37SQoWf
2o6ICQIMpYc/8l4FBzuK2AFP3GvSY0abwlkkJhYn2t/rzTxXHpUDnpspm1PnY+S8
0ZCye8QsWHf2Cl5XU1sZugvcp+A7QOE2uQGY6ObC0wSk9AtLKXgt8CiqmAFpC4ni
mT/BrDSqFrLW473BcymRsnGFfABrqv8/D2AryfeP9jtNzVDqR69vmW2YDb7bGUQs
JCYhQqpAGg/IHAhGF5bDFcLAr+7DGLRjZci1W58q1/+sktgNR+Y=
=L6CN
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
