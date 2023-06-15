Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C3B731912
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jun 2023 14:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244899AbjFOMj5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jun 2023 08:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjFOMjh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Jun 2023 08:39:37 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA371FDB;
        Thu, 15 Jun 2023 05:39:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CM9a2gpQXsnUMFahtnG5AJxUcdkXYjJOaeCl/6zvjRWBS342tFkdBnLBuynOVtGMcZl1xLuwulOTUFdK5PhdYnNZrhyaayiiMq4fWas+0w5iWbRm1HpI6NqKerOHm+3iZ9A/l+fMiPlKZBrspjYp00HJ/el/p9Lms4yyzfAoukIQqduVnwiP9mhYen27pl1eUBouVUq9qt4FL+gGLeClr+E1jfWkBBdMSAfzij+6Lw6VG0hTUVUjtIzuBbVqB5aqNlvVlY6sRbLwScl1nigSmwO1sF7A9E2sBNNAHXNPPu7+I+lLjgGCOQfy5TOWFfIiL1xkrMwjUh31s0Wvnc0JfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtanfBGT+mWGGyxIZuDUjabw0GquLIuK0ZfPJquwskE=;
 b=PCDA3qT0Jo+f62Ka0YK14Sk/nLfbnV7ZGPIlW9+US7xaWdsqz4yfMp4VxJ7chsEOPSbAuDjRLjWIk1hZ5D5QXA6h8saEeQsFRO0rbOEQj3G0cO37S5QEPMvknRQuocXrvVmYNDNvWOCaE1QoXrKYEqgKt4ugI15tZUuxQIL37wfe4Jbh7apDhHMZ3eJRBFOpfrWdUyZCBZMcdP5KsbBiWsrAd4nE3J73Kw5rhN/aZqZ9GgbSUnDWG6rBsUpjTudQHf10csHcHTK81uTmKYa+TOnp41e6rCIGcQ1aFfRWxlV5oYu+ChI4/DvbnAoZQxJUSI41WEIrWXnau3kbsZ10TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtanfBGT+mWGGyxIZuDUjabw0GquLIuK0ZfPJquwskE=;
 b=en45HcGLOZ1k+Ltxrx4Xrtq7dX3VaLTqWHBK1qpdqxBY6KIw7FCVf/t2L5VMgWD6vcnBdOT39QJD/7CdZ4ly1TKEclMjPzQoZTNNrnclxWPOo6ZZbKYyOnkhkpYn2Y0RHKtu80aWx/OEyiEcXSPmfaGEm3A3Q5W1TflgrrsPtpt3DF7ktvp+vPd2y0MS2LtQkBGsmvNfzMD+ut/itaB2cCt9BdB3HIoWi7OJpau8nXzwtxfcHTAOczg7S0r2ttGMaWOjZkP2WzKf8f4kqJjeyLr0j+fRRkEuZpiaKHwPtybGYxP36wqV6mch+e3qScVmNyK4UpgBYTcxCesiXE0UNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB9035.namprd12.prod.outlook.com (2603:10b6:930:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 12:39:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 12:39:34 +0000
Date:   Thu, 15 Jun 2023 09:39:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <ZIsGgrn/gfiufynL@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8K99Rz7EulD7P1fG"
Content-Disposition: inline
X-ClientProxiedBy: BYAPR08CA0061.namprd08.prod.outlook.com
 (2603:10b6:a03:117::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB9035:EE_
X-MS-Office365-Filtering-Correlation-Id: ecbd1563-a1de-4282-a989-08db6d9d9285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vjTaUZjD/acw67FFMUA+45AMk1qFv0kmwT1qinc65sOO8m8e1GExKK76aMxXmHsgOCHBS31q0OJ+vOb9k6bB9AVo42W5asa4S/05HXTQsbGf/D/Fyo/z0EbGxO9KIJBGr2ggl1oZPH/So2NJVnsKQ8uAGo32rtApfp5x0ucM7HJdfIT/wSwZtsGiwgQGd0qtAGeVeHq9A67Rv/JNfdWPcULiNkGPs1h5jSFojqh3LrruF/qgfjzqzi4odp6I2Ix/eVJhl6fBA6FLryfPA1y4QOH09vKL2Idoz/cHWb0lIiKYYyqrDeYSIKI9nxwK44QeYTbVYFL41Rpr8I0Mmv9irBZhJzAfuD+ZDBStpRNReZHRdg5ZHqWQeK3yRvvnDasSzI6wVQRD4AUDiK9jIQnpGyviQbV3gfkYCfm+L47bxF930V3or7ynPxqh7HuMhMqasbLM1/333LKfDnzRpDjFEYz9A5EkUbwfTy0xYQYKBqMiMe8rTTr39vycgYsS5lY9EC2BUBBpPY+EbNSA2SxX4vBV1R7NR+wtBEm04loXefihLMQuFZKrwSGKthD96Kjqb5zZ24XL0lQWlenyb4KH7kNGBXmPkF0TmRdSlji75rc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(2616005)(83380400001)(36756003)(86362001)(38100700002)(478600001)(8936002)(6486002)(6666004)(8676002)(2906002)(4326008)(5660300002)(44144004)(66476007)(66946007)(66556008)(316002)(186003)(41300700001)(66899021)(21480400003)(107886003)(6916009)(6512007)(26005)(6506007)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iEDUEMTzFZ3d83wFBYHEeCcof/iC0k5TlFN1y62dzgQjmw4udYtX7bsRR3oY?=
 =?us-ascii?Q?+84dYqw5itFlQD6XAbik4g2J60AV1mqW9U/frddGkvRuH3V/lf68KOz5MfE+?=
 =?us-ascii?Q?Vb//wpQnVHuasp9Pkaews1LhlW8Ryojm0IaF/X8viyAJyBu/DK0exsdkKz1z?=
 =?us-ascii?Q?FCk/4Nz6tGko2h3Ew2oWTlnAeZjm+Dmtd/bgy8CAa53fd1oBDwW590fb9ERz?=
 =?us-ascii?Q?9ggCKQMUlW5bkdFk85sLr1b4NgvvxfjmgxN4hjO6lR7NvQiyyUnWpelv8B/z?=
 =?us-ascii?Q?19UHdeaXwsnFKSKVCcnIWAt+OKWEFNzzw6aeS0E5qY8wDYuCi2JMHd3rSOmV?=
 =?us-ascii?Q?WgAVrYFiyPzANPY1ga6JNQAsIgI1NRxFLX7s9LZ6nAzUMEwFffKkNucd9PJa?=
 =?us-ascii?Q?6iW7bNtjzP9Y1S0Elz6oR9QmRXthyxkWBmU+qLGq2IsS/VOBpHswKc5kB6un?=
 =?us-ascii?Q?zLyykgvJAZ3GvWNQfIpv1HiN9mfYGEfwTm0llqGpPPEPiYYNKchGA1v2cPbJ?=
 =?us-ascii?Q?QE6QmETT6wFrogYJ543ck5Jn4sPcYMnHdrDuzrALHX2m06jZfJrcIUkZH7vV?=
 =?us-ascii?Q?xp5uvxsXeM5RwiMABiePcNnJmStU/HjiBLba9AgHUK82ETsDFwyTiJTW6n3w?=
 =?us-ascii?Q?ZJ8WYiZoLznN1SYIwldlVo2S6Jnrw0Znnlc8YqaPaBn7CdNNh7j/VSjbbbs3?=
 =?us-ascii?Q?h8WkI2P9mmvaxda6QfdxOS3guglH8tchSl0EPqK85v2S0ql+++CZuDslxpwY?=
 =?us-ascii?Q?IHEn6Z1f2YjMLcWqK5G34ru1exzbCZno0rmYTr4mKn1VwlG5Jiol1mUaih0V?=
 =?us-ascii?Q?Rb0qq4iPqm6Iqb0B+XBF2X9jkOC34e+QG3E/ft0dAhw5rTPBYeAlwlhkmYfS?=
 =?us-ascii?Q?zcY8C3hSSoQE+9pXqGHu3H+ZqcQ1WAyuo2hKP8Zs8z3Erv8JA5RaqSzYDvXJ?=
 =?us-ascii?Q?5pABoj7tps7Ah7DcCrmrOOwEd5gr/JJypGnpybDm4wG9T9d3984fyyj8mtG3?=
 =?us-ascii?Q?8Xc6NOIw0YKbuw44IOXbAgcnF6hImdkQhGzJbakkF/wv4DR0xIJVZYnEZXrs?=
 =?us-ascii?Q?FZhr0BP5RJonOI33/AnB8MJM6ZlAK+Fa8LXSjb1jGycgjuIF4a8xHcfP8kWn?=
 =?us-ascii?Q?qHTB7f6Y07UJi0M/wH++zleUuniBGvXElI+mmY3Dcx9vBvpyi7H8r7OYZ2LE?=
 =?us-ascii?Q?7aZPUeL+TBPD6WEakIG5V7Mz5FUBxCjbHs3Vy0XPJPap/x9IcnapZC32LjzO?=
 =?us-ascii?Q?HeWwmzp3gfFvPdr32OzTKUXkjETu9APqKaP0vLIIUn0Z6FWZEvzqo8n4R/QJ?=
 =?us-ascii?Q?x0h1OSvppcKlKxjO1Qm/ttNHSbxsMjQDnulaorgyWLKz2s5W2UfqBZYdXL6B?=
 =?us-ascii?Q?9osXXT8UKijjg9tHq05dDQlWl4N4nKjS3dQp+w4dYJAb/hjhNOYsF8i4VBN3?=
 =?us-ascii?Q?AKyCqiWCZ337pKuQPCgg7JoxuVzTk4yCQ9zxNWhyBJzQkxmVKik7m8Ygwf7R?=
 =?us-ascii?Q?lYOSYtsO4nZC5O0YaexnxD6fH+kRpbC1UBBI2TzUPt5kpfD8jnFdWVWwXGYZ?=
 =?us-ascii?Q?eZ+bdKkYyNyb4e7s9DA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbd1563-a1de-4282-a989-08db6d9d9285
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 12:39:33.9948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3+xffkkgE4WHiaGS5zGYOoxbKrSPBlbQToUJFSDG4ifrRX6FZHEUA/9tjCJnnxs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9035
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--8K99Rz7EulD7P1fG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

This is an unusually large bunch of bug fixes for the later rc cycle,
rxe and mlx5 both dumped a lot of things at once. rxe continues to fix
itself, and mlx5 is fixing a bunch of "queue counters" related bugs.

There is one highly notable bug fix regarding the qkey. This small
security check was missed in the original 2005 implementation and it
allows some significant issues.

Thanks,
Jason

The following changes since commit 5842d1d9c1b0d17e0c29eae65ae1f245f83682dd:

  RDMA/irdma: Fix Local Invalidate fencing (2023-05-29 14:06:29 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 0c7e314a6352664e12ec465f576cf039e95f8369:

  RDMA/rxe: Fix rxe_cq_post (2023-06-14 14:12:43 -0300)

----------------------------------------------------------------
v6.4 second rc RDMA pull request

Many rc bug fixes:

- Two rtrs bug fixes for error unwind bugs

- Several rxe bug fixes:
   * Incorrect Rx packet validation
   * Using memory without a refcount
   * Syzkaller found use before initialization
   * Regression fix for missing locking with the tasklet conversion from
     this merge window

- Have bnxt report the correct link properties to userspace, this was
  a regression in v6.3

- Several mlx5 bug fixes:
   * Kernel crash triggerable by userspace for the RAW ethernet profile
   * Defend against steering refcounting issues created by userspace
   * Incorrect change of QP port affinity parameters in some LAG configurations

- Fix mlx5 Q counters:
   * Do not over allocate Q counters to allow userspace to use the full
     port capacity
   * Kernel crash triggered by eswitch due to mis-use of Q counters
   * Incorrect mlx5_device for Q counters in some LAG configurations

- Properly implement the IBA spec restricting privileged qkeys to root

- Always an error when reading from a disassociated device's event queue

- isert bug fixes:
   * Avoid a deadlock with the CM handler and CM ID destruction
   * Correct list corruption due to incorrect locking
   * Fix a use after free around connection tear down

----------------------------------------------------------------
Bob Pearson (3):
      RDMA/rxe: Fix packet length checks
      RDMA/rxe: Fix ref count error in check_rkey()
      RDMA/rxe: Fix rxe_cq_post

Edward Srouji (1):
      RDMA/uverbs: Restrict usage of privileged QKEYs

Kamal Heib (1):
      RDMA/bnxt_re: Fix reporting active_{speed,width} attributes

Li Zhijian (2):
      RDMA/rtrs: Fix the last iu->buf leak in err path
      RDMA/rtrs: Fix rxe_dealloc_pd warning

Maher Sanalla (1):
      RDMA/mlx5: Initiate dropless RQ for RAW Ethernet functions

Mark Bloch (2):
      RDMA/mlx5: Create an indirect flow table for steering anchor
      RDMA/mlx5: Fix affinity assignment

Mark Zhang (1):
      RDMA/cma: Always set static rate to 0 for RoCE

Patrisious Haddad (3):
      RDMA/mlx5: Fix Q-counters per vport allocation
      RDMA/mlx5: Remove vport Q-counters dependency on normal Q-counters
      RDMA/mlx5: Fix Q-counters query in LAG mode

Saravanan Vajravel (3):
      IB/isert: Fix dead lock in ib_isert
      IB/isert: Fix possible list corruption in CMA handler
      IB/isert: Fix incorrect release of isert connection

Yishai Hadas (1):
      IB/uverbs: Fix to consider event queue closing also upon non-blocking mode

Zhu Yanjun (1):
      RDMA/rxe: Fix the use-before-initialization error of resp_pkts

 drivers/infiniband/core/cma.c                      |   4 +-
 drivers/infiniband/core/uverbs_cmd.c               |   7 +-
 drivers/infiniband/core/uverbs_main.c              |  12 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h            |   2 -
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |   7 +-
 drivers/infiniband/hw/bnxt_re/main.c               |   2 -
 drivers/infiniband/hw/mlx5/counters.c              |  89 +++++--
 drivers/infiniband/hw/mlx5/fs.c                    | 276 ++++++++++++++++++++-
 drivers/infiniband/hw/mlx5/fs.h                    |  16 ++
 drivers/infiniband/hw/mlx5/main.c                  |   3 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |  14 ++
 drivers/infiniband/hw/mlx5/qp.c                    |   3 +
 drivers/infiniband/sw/rxe/rxe_cq.c                 |   4 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |   6 +
 drivers/infiniband/sw/rxe/rxe_qp.c                 |   7 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |   3 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |  16 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |  55 ++--
 drivers/infiniband/ulp/rtrs/rtrs.c                 |   4 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |  12 -
 include/linux/mlx5/driver.h                        |  12 +
 include/rdma/ib_addr.h                             |  23 --
 22 files changed, 447 insertions(+), 130 deletions(-)

--8K99Rz7EulD7P1fG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZIsGgQAKCRCFwuHvBreF
YbuJAP0WaYFvuUcpzt+9mEZIp7WOnRZzUrtX58YY+2j2S9GTWQEAt4WYd5cX/z04
6/0u4vVWjhcK3vrAQ5vBgBUeR0GwEws=
=AJlA
-----END PGP SIGNATURE-----

--8K99Rz7EulD7P1fG--
