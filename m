Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA1E6E22F8
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Apr 2023 14:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjDNMTj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Apr 2023 08:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjDNMTH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Apr 2023 08:19:07 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20622.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::622])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A3EAF1D;
        Fri, 14 Apr 2023 05:18:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iePVVcb4FTStdUco0jOOPPEZ71vH7axkRutSe5gV/LzSFpwqT0363iek50UyAquEP7eqaFKGVivRa+ejsVg8wdZ7gsLyHupam55Sb768OTHicb0GQSDpV/sANDn9+sx7WP3+V7QiNACwVIIfo3UNF2duI44D3N6JuprDZ490vrE/RdSBvQxK4uYOsj706/+NRk0f02THphRUitHMYD4obygEE8IpqoCkhewNnAJTY1YXy+n5QCBh1UBoN/eayfj89/p5nYbKLK8NdIDYdhX92UMi7XigDguP/kCiY/ud2tUYgWAb4KxHekLGMXrpkVzZEeiB8wDAuRo0YJbWFj/x2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lr33P0F2ZykrXqVk4v77QuMLoc1wqFJ9dOkYDfcX4Hk=;
 b=Ne1lvybxGxs7HvOaHMpsd1UtADXapTfb5XJ2J9H0uf36JmB9BnL+enQ/63onbT8KvL66V+47dAn1fSLar2iwXOrcitsdaaPNIc92vKMydCr1jik92KBtwKKhwIQlnuSimuCW3K9EkhSyGisDFC5F3MlUefvD/mN4s+ACH8OgBUe565OLgcY+ZfjI+jN0meEhuTy6Ctk8kyHQWCPeXISoxm8hdx/+55jQ+tZ2Lnulk15hCo/FbroYS0Re+Va5wIxFiOXEs6fnluWBXkhUXbvi/+fsluMC7jlKPr7YNmohCgk0us1XreKT9MHQE+8ItxFKQUbWUzjGjKKTunmtEZzdkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lr33P0F2ZykrXqVk4v77QuMLoc1wqFJ9dOkYDfcX4Hk=;
 b=kY12enT11Cdpjk8hZ/a5ebyWZsnm0ck0KBUBuRkTrzCKBfTal+OfEEUYQkHVS8Jmr9NXE5EJwpnIc1wWH0Xn9MI5WwVGRP56noliUwEx2BbniJh9q53rpHcHsuoHaa6kxiM/G9OHBe5B5rL48ORLfH1BXt0w/p+yfiCOny5utUJIiMPLs3ifD5bFoCkPALS0fOuuz03YkhrFjDHgaQWzwkUgoBtY7lCQ9ktztlCylTVWyxGEq7++uVUovuuYE+lvdYHcPG2KtMIKr8WbAz7YB4dmG6c9SSmEMW+AX1cOYyB3g5p2HbWhq/jVzJgk+fD3ir3GVpIYPrZ0kBP4SgqBHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 12:18:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 12:18:56 +0000
Date:   Fri, 14 Apr 2023 09:18:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <ZDlErF54qwFrZ/X9@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L1YSN2iGruswI8m/"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f8d2de-22a8-4e7f-3ae4-08db3ce26b18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I9AoSinkBazUoZpY6pFqMNxfCsrbx2npiLkFksA3cl4bi7HuFYHREz+G62remvGDLp6c0nxK5Q5YJCaDB9QoqFeToIdtH9/26kxJTn9NmvvnmPQjle0mAWYMbIXk3xtzxdj+ehw6tPbZYml+XO8Z6+H34quq/YsT5sn6ZPW23d9ZBjdLJye4eOkOWI2Ht8cCGNjHpI5Tc82TOA/4bKmok2HUNQabsX/QqcSE9wNY4QEt4yzjbaFWD9LvQxAGE3D8Xxb1Z9N3cG05pDcZv9FAP8uKOGzHNjKj5DqLYS9M59Mk4gItZIO8w5unuAHIS2wfSkpMq4IsprsM42PgNvBO0HNkSFK1XCQ3+1z9g6LDWbkgE0IGuUbIMWR1CtWMrLyKJUrza9d/cHzHSmJPg0iWoS6391q4Yq7QqXX+KSw5IIM/TcLQipppe0FEXV9MP1AkLzMOpLOeFuIXrahhyLnLR+PRPpuw1FGmG6Buygu/Ry3y+RTInw1IJPOFRKQTywuA9CR9LZkUh0jxHsD12qIMGImre/817JLUwLF/mQHPUVf5xlouHsWufg8CAksJnC5ihXzPY5hICUUmdOck5nP0V/Ro661G18ZknFmWJCACIAA55W0aCbmuV9wL6SftT9UI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(5660300002)(41300700001)(8676002)(8936002)(2906002)(38100700002)(6666004)(6486002)(44144004)(83380400001)(478600001)(186003)(2616005)(21480400003)(107886003)(36756003)(6506007)(6512007)(26005)(86362001)(4326008)(6916009)(66946007)(66556008)(66476007)(316002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kWSMbeDydjUOm3qCrtU745Jcv1H/ef/7R8rFPABAuUmd9pmZ0KT6indZmsRz?=
 =?us-ascii?Q?OS1WhFpk6egJm0Z1IaKo4Rx/+IY1EB6Ap5LkPmbiEo29bQ/jS060av3KsVm6?=
 =?us-ascii?Q?L8+T/4dkpcxpyDCEsjO059dL/YuUZDbHbTU9gtQCTyplIha+IrSPtD0gBvKD?=
 =?us-ascii?Q?zleceWIBy/Vl8/xwTX0RuR863le6ZowHcPhOLIPvAA8+wCZZQQi2i7T8xiqp?=
 =?us-ascii?Q?O7399zZ+XWxdMoufQvbs04uNryqmTeZsa904wetw+L3FrWfUJCIyIsj6AZLQ?=
 =?us-ascii?Q?hw8PdpxNqwvdxVFkZmE5fkzyhqeOaHI0zW8I+6LyyiTtdU1gBv7hLIFfAmpK?=
 =?us-ascii?Q?1PG+9WZzyZBKGXEzJ8Nbyfs4rnzDASKFooma+BOVKnLowUGIsCCcsNnj0b1K?=
 =?us-ascii?Q?pkwnt/WNosZrbZbjZAMAjaxkWas3Ah5GjV7+zq4CcfvrH10dOy1+8IeicFE3?=
 =?us-ascii?Q?KNT73/jQoPtJ3C2Y95IV2c2qCHJ9E6Cyth1aCdV+7NcJgejzhQI4oBehZjKV?=
 =?us-ascii?Q?i8ChSr/Gwx9vPxRpALRzSqEk6N9bOrY+a0sVtDvPGhLp7gr0OXoOetZfbbIa?=
 =?us-ascii?Q?c6GNDAhYztpo+zMc7kshzxStvXZmOLLRCEpSHZo8mEHZEbDraLm93UZ1qhvH?=
 =?us-ascii?Q?CMwRYNaKWFts3s3PLqTP/F+Wh3VU1b7uA11Jss2bRFoPYESlY03WY+Qn5dx4?=
 =?us-ascii?Q?R76a5SySSm7Lc1t6IM2R9fKUC7HSniNgdE5h9Y/3I6iYHP3ukqNIUYbBxLiG?=
 =?us-ascii?Q?qlFohMWKMTAPiHzfnjzwrjLDyTsC8k318PlbD4vY/9K7BUX0e5CXGzpBorUr?=
 =?us-ascii?Q?seYqu8e/heVsZ42iWn5NgzbEk709DAAwtjfqzbuZ1UA9tFeWl4LlW0hoXFIl?=
 =?us-ascii?Q?jQXs0s+UPMgS9VIaiagAmD0/UuBd0hwcQxPajkMcg8eE+BnfQk12ngZeELGE?=
 =?us-ascii?Q?TM3f3LSKowpMd4ZFdfhm3UTo3iGtG+ii1rXegFRihJTSLHvoL3gi2ATEQyUF?=
 =?us-ascii?Q?Axq+KdIBGCYJ1wIMfXHwKLyqWX9ng9hdpQvC+lhMN30Pt/Zt9okannEnJRjK?=
 =?us-ascii?Q?Qw9F2hECEJpRzB0Cd68rJeKUiI863zMQKfFMwO+Y3AYBYzR/HNcfCPdy0aYz?=
 =?us-ascii?Q?CpSfMlJi+1l/kUn1G5MTtyP34pt+gEZPE95/k6oMg3fWfJJf2e29A2vs4voI?=
 =?us-ascii?Q?PHLmDmYkvxV/2CjD3DovZIshCurMJp+D74lViUyerVOIK2+ssYoOnY73IiP4?=
 =?us-ascii?Q?1mUe2trzagko/SiuiUdkowkG9yazAU9H+fvp20Ms3i1j40//z6JKygX1SXPj?=
 =?us-ascii?Q?YKA/eNP3JTZFW+FXiixX6WYA0PLGcPFIdAmM4tP4dMNiSxOHXw9fSUYhUjy4?=
 =?us-ascii?Q?cYyTfn1u65pJS1sILC5l6m0Gka8MGiD82uxkGtBmo4o7x0mPlWfENUQoh5lw?=
 =?us-ascii?Q?ChD2B1aZG5Q4zAB24GSTAuMgaQomWxYam79iZY6aACEIDTccurM1zkSkoPAn?=
 =?us-ascii?Q?FEBheLamYwJB02Jv8l7c0bPAcFoXwdw1o3/bnTBCrktPFvTjO3k68SVAQtkV?=
 =?us-ascii?Q?j2IxlQclk38gSuTvqK2KUMd/cytHd8BlJUF5e4Rr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f8d2de-22a8-4e7f-3ae4-08db3ce26b18
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 12:18:56.1756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Scf8Ap474jZfoJsLAeSpRzXtdRNEcbZpU2+Z1nOMS4P7Ec5EQ8A3Qmzx1Iluudb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--L1YSN2iGruswI8m/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

We had a fairly slow cycle on the rc side this time, here are the
accumulated fixes, mostly in drivers.

Thanks,
Jasn

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to aca3b0fa3d04b40c96934d86cc224cccfa7ea8e0:

  RDMA/core: Fix GID entry ref leak when create_ah fails (2023-04-13 12:17:32 -0300)

----------------------------------------------------------------
v6.3 rc RDMA pull request

Driver bug fixes:

- irdma should not generate extra completions during flushing

- Fix several memory leaks

- Do not get confused in irdma's iwarp mode if IPv6 is present

- Correct a link speed calculation in mlx5

- Increase the EQ/WQ limits on erdma as they are too small for big
  applications

- Use the right math for erdma's inline mtt feature

- Make erdma probing more robust to boot time ordering differences

- Fix a KMSAN crash in CMA due to uninitialized qkey

----------------------------------------------------------------
Cheng Xu (4):
      RDMA/erdma: Fix some typos
      RDMA/erdma: Update default EQ depth to 4096 and max_send_wr to 8192
      RDMA/erdma: Inline mtt entries into WQE if supported
      RDMA/erdma: Defer probing if netdevice can not be found

Maher Sanalla (1):
      IB/mlx5: Add support for 400G_8X lane speed

Mark Zhang (1):
      RDMA/cma: Allow UD qp_type to join multicast only

Mustafa Ismail (3):
      RDMA/irdma: Do not generate SW completions for NOPs
      RDMA/irdma: Fix memory leak of PBLE objects
      RDMA/irdma: Increase iWARP CM default rexmit count

Saravanan Vajravel (1):
      RDMA/core: Fix GID entry ref leak when create_ah fails

Tatyana Nikolova (1):
      RDMA/irdma: Add ipv4 check to irdma_find_listener()

 drivers/infiniband/core/cma.c             | 60 +++++++++++++++++--------------
 drivers/infiniband/core/verbs.c           |  2 ++
 drivers/infiniband/hw/erdma/erdma_cq.c    |  2 +-
 drivers/infiniband/hw/erdma/erdma_hw.h    |  4 +--
 drivers/infiniband/hw/erdma/erdma_main.c  |  2 +-
 drivers/infiniband/hw/erdma/erdma_qp.c    |  4 +--
 drivers/infiniband/hw/erdma/erdma_verbs.h |  2 +-
 drivers/infiniband/hw/irdma/cm.c          | 16 +++++----
 drivers/infiniband/hw/irdma/cm.h          |  2 +-
 drivers/infiniband/hw/irdma/hw.c          |  3 ++
 drivers/infiniband/hw/irdma/utils.c       |  5 ++-
 drivers/infiniband/hw/mlx5/main.c         |  4 +++
 12 files changed, 65 insertions(+), 41 deletions(-)

--L1YSN2iGruswI8m/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZDlEqwAKCRCFwuHvBreF
YfgkAP9cXsABeQCmA833vrZGtbRgXa9XSGEuGq1VXYlBgH7u5wEA+WbBSkdnpc55
Dllvx6HSFMpX2O6ueVy/fRzY41zwrQk=
=8Yxq
-----END PGP SIGNATURE-----

--L1YSN2iGruswI8m/--
