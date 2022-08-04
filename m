Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C961D58A0C1
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Aug 2022 20:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiHDStD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Aug 2022 14:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiHDStC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Aug 2022 14:49:02 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F8213D4D;
        Thu,  4 Aug 2022 11:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jruz1T26OCHYgE0xEzS6CPZo29eA8pIUmESuMjnM1JCGtuzms8B0wadd/OHOY8e1ajXSaWi9A+OwhGIuFOIIp0MrXZfHJnCN4BBfJouxUup6XkP6IwX3fz45yTXCn/UeEapT9dJMSRLaqnpW28I7mobhSwFRFVjQSjY+VZmIz37XTx6cGQNDtmb/NGYBcuhdNYoSS0EF5a9UmylYXc5pSu2KUImIQPNwqIwCRPsqxnXjKHssDWHTkfp9YGcU5z3FQtzqw3NOfEGzK5NGkz2zpjlJ0+ys52USzZh2OIYyBlLP+iNm+VZ8ED+Qv8MqLgRK2C60CIpKn1P7F4L8S22myA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qs+0xxy+36yguPo4RU2R5X4qcKcZJB7RWK7OZHPfIM=;
 b=WpprSPbR5JW51aNlidMgxQA8Z+rdzolJAVSKGvdLsI4D164rBJFkEQj5S5CiB7n4Rpo04xpD8q1a1r5ZCwhrybIQVC85XUaL66x9Gtrjgb8cLK22jy7BlsLMeifyuPDuWoFdY6ahrJJBUia/nQdE1qvWT+AwDlg4yV9I3b1XUKF5SkYijd8gDlPpw8JEtq7lmJefRF2gr7R4sBiQC0o1FBOMTvgVIsLU+R7k39b6OFGf1czIWLGrMK1t8jFV9PxtauVnopHTHVMBj6fyV/p/cCKGgm6lElLEhDywtGR/7AkiyTZZAvgPwJqPEErGyPfd8pcPl3RIqXJtqxIxfA6dbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qs+0xxy+36yguPo4RU2R5X4qcKcZJB7RWK7OZHPfIM=;
 b=SGurFOKakkgOwN0SXFTd+1C5jlQgpEFoZs0A8G03umdV6DO11m+Sw1ZOoq2Pg4UzcIwGhc1hCN9w1jG1PW961A5Bco6SfahGqjapZNh2LgS3odUGhGcrLQvg1g6IZpuJt5BfHiJxV7DjGMbdEL0OD84BET2nn+fOwtj39vSu90epYq1HqCEO/VVE1OEscbiFlQHvpQ3OeZY/68F1NDCQK75IuOy+la79Ma5oakgQRHMMnt6XvPeEcHkrn/tACm88yamdt/YzP5MEndctLObfao9MV2bTp+W49p0cL01c6zdvLjyGI6QiuHBGH9rtzCrNoBvVF5q78G+ll5N3FWEW6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB3878.namprd12.prod.outlook.com (2603:10b6:610:2a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Thu, 4 Aug
 2022 18:48:58 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::1a7:7daa:9230:1372]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::1a7:7daa:9230:1372%7]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 18:48:58 +0000
Date:   Thu, 4 Aug 2022 15:48:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <YuwUmSRis1rYhR+y@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ShRoNNnBLWzlIxpU"
Content-Disposition: inline
X-ClientProxiedBy: BL1P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::12) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dddf616-061c-41e5-efa2-08da7649fd60
X-MS-TrafficTypeDiagnostic: CH2PR12MB3878:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hkns9YaXdtH8cnX+HZ/iDmabus2lfVKuEfvDW8Q7K6BnI9HEmarxuBDsWfkHX31i3xoEXBQ1MlLFiHIwV70yCHwrNIcoz8JuS/sEsAujaVruDsmz5dRVDYqK14LDfccj7WVywQDz5p+RcvjKTiPSsmH9v/CaTT96uMsVzVeZA8flriUgdglEu45986Q9jU/7ToNtJpWM9VvceXNfGOt69yRfMpsaHon/OliUklhq5k5hVwgzrWDUA4THiTG8TvJU961StlGluiOgMMpmaeEaL9z51pZEGMfbi2et2gOXzHLQCV4NRGNpipErRET8tCZj2AfyL9zB8URebJp8xvci1s+4q6KOKgXft0n3g09S8nkixm+ELPKtc4TWyiDoJRPqknCzkh5CTcC4768s56clFK9DzASl9lFfApCj4kPqv2mi7c4ZkCQIMf4FDWFMxLSPbe/FOHvvANrH2qRx20+8GeQ/LyU7IeJMbL5/qxLZwjYGSI6yfd/PaSaWCMdzcMTD//aKEn9EP/MQ4/rP4qogfwcy1/U3DStCUzeC97QQN33xkRFStuOevwEJewOQ/UY8jYxIBUwKu/J5ODEm68vA4tD15/osPwfZivJuGCsh4ELkhLvnnekuTTwj7b8OaGDTxVGfvc8+cw98PDPsDpJTBeSdXXmHdxDcyc9Euzn7OUfFGJXdPV1N7aLHL1rUyp0BLsFSQuIFluNLYoWYVgokMXojhjWQJUTA263D7qk5WuYUDfX2visnHTfc40Wmoj6IdiE4Pd/5ysHK8y7rdX91YtrwKvIkJYJyhvCEh3Bm3yt4wyWF6mwW+0sfF5DSq65v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(186003)(36756003)(5660300002)(2906002)(83380400001)(21480400003)(66476007)(8936002)(66946007)(4326008)(8676002)(66556008)(30864003)(6486002)(316002)(6916009)(478600001)(38100700002)(26005)(86362001)(6506007)(44144004)(6512007)(41300700001)(107886003)(2616005)(67856001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dEi07PTxGigMR0757K4OjqX9MxNMaRK4ARnqiTNX+eO62cpVkdwJek0fQ2qA?=
 =?us-ascii?Q?OUsFw0I9D5DLTWbPWpuyELJEu9ARZ+Lc7sCf4W+30maqUauLsVfujJ4rV+rq?=
 =?us-ascii?Q?18BD5mnUsLVkWtx1Mg30wft3z9dle6IAuXWD8SZyl0ZIeDmZqukIDw0Gos7R?=
 =?us-ascii?Q?1HjoQ75sojfTt8VFXOuyw5FqrxcmW465A3s46W08Tq0hQyLquUpx7kMgIBtP?=
 =?us-ascii?Q?DzUB9sq7Lxhn3KBISnsMdr0f4HCvCmgaX8Uv9Yxi854tRoCgxr7qZErMij9x?=
 =?us-ascii?Q?/K1wuD0mVWsBrHBmQw4AngwgMlKCIZt8e6BqDQlaR2s0rLigqnv9NzYfjV9h?=
 =?us-ascii?Q?DCcUNd2wb+9fhR7Z4wWoWBt80GDAES2rjIXEvF9gv73yU8HU61D6qsjj7Dv7?=
 =?us-ascii?Q?K6IKF1HXK0TKGCITwPMboUcU5q9pr343VK4b6YdxSCOFwVU+jckADZuL5owo?=
 =?us-ascii?Q?WzILp5yv7GVKdNC27Ba65vSifx/px6FvcoaW+xtO7W2a9+zLw38WVYtTEGiv?=
 =?us-ascii?Q?cZHH1+ojL2aslNQevLBQN5DaN5LkLZBLZqqA9/GctwEgJby/sxGhGov4ll79?=
 =?us-ascii?Q?dE0qHz1aBcvjrZ2TtWY5gnveiI8qsvOsVVCCwjR7+PiFjyGWJBs7WjXVQEFI?=
 =?us-ascii?Q?egeir4fEcBhvfmGEsdGQC1BOIz8cLwoL05zPtDGaQ3WoC+xKFE5BRIvi+SCS?=
 =?us-ascii?Q?E0OmCQq6eJp6Jqd4C+7DmsR+3TnjkRo2RgS6wTR2LevO7wOqyXPVOU5fSwlj?=
 =?us-ascii?Q?z3pV66BBs6CeDLyXOohKuZiIBlwfkJEep2kZFApG5crl0+pW9+YhZ2vmUT6y?=
 =?us-ascii?Q?nxFB6chD70A7YKqJxdvaI19lNshCxMyhDfOvW6lRfgxllRuKQAGFxnTN8hmX?=
 =?us-ascii?Q?26zamTIIqWlBfZJC1HwLVwmHUU6UwVeY1SWA1fukrS8pjleoKlcXS+ehIa33?=
 =?us-ascii?Q?jVYMF68AD20QFqsE6s7dn/XmCYorFCLIbkaPR98V8mPdzshtNs3iMYXXe703?=
 =?us-ascii?Q?ICZP/AcRjgDeiDQRg/4/kGeEL2bNz8jwxKbSq1MTjCsu3pAReFcPxtsYCQv5?=
 =?us-ascii?Q?JIeiCoOgz0JoyFeZ3PhRBHMxDrVa9/bB8HODVZYWoVv/ppOfhiUogXzSgMnn?=
 =?us-ascii?Q?TbGAA6dHCvTnogv4o9lA4FM/WXdkDVxtc5ujU+a52wOhcxI8YpE9bQd0Plg4?=
 =?us-ascii?Q?TQ6dMt4vJJ1Zsh7V1QkEVj7efL3Cm4hAPmwdQqHLNDIu1F7HQpt7WhPgPdiL?=
 =?us-ascii?Q?fYaNwW9slRoMYMkWKe7CyID2V0U9W+MygJCyy0Xnzgt1HBvEhMnR4POqqLFu?=
 =?us-ascii?Q?7ad8tb5CUIWcSWHske6LqEzsw5OXSxYSmQfhymLyeHSnX1OZ5a8OSRWmjmpl?=
 =?us-ascii?Q?Hifya2Zf2WRUYxPbKQTK2QPwSS99gxCaXo3HymboFq4JKDJL03Anw2Yd3YUc?=
 =?us-ascii?Q?rP1v4zMaDR/Eka++1Jvra7HpEsDiMJXL9KYJJW4we8Y0CDtwUBJDc8jo83bA?=
 =?us-ascii?Q?EYUZ4C+SLnKkF8Ijlnsp+ITnehTHWevOs6PJUI5JbDXDMNcUoiUWlIwqE4x1?=
 =?us-ascii?Q?FULdZacAU/yXyPUPFyqx5IdYd3tLxEmr/Y+7nJn2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dddf616-061c-41e5-efa2-08da7649fd60
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 18:48:58.3587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JAPr9FrWfrbkwMxFqmAXFaBR9IJD+1mZxngqeE7X8bkpwRLhix4il06jpYc7+od
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3878
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--ShRoNNnBLWzlIxpU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

This cycle we got a new RDMA driver "ERDMA" for the Alibaba cloud
environment. Otherwise the PR is dominated by rxe fixes.

There is another RDMA driver on the list that might get merged next
cycle, "MANA" for the Azure cloud environment.

Thanks,
Jason

The following changes since commit cdcdce948d64139aea1c6dfea4b04f5c8ad2784e:

  net/mlx5: Add bits and fields to support enhanced CQE compression (2022-06-13 14:59:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 6b822d408b58c3c4f26dae93245c6b7d8b39e0f9:

  RDMA/ib_srpt: Unify checking rdma_cm_id condition in srpt_cm_req_recv() (2022-08-02 15:10:55 -0300)

----------------------------------------------------------------
v5.20 pull request

This PR includes a new RDMA driver for Alibaba Cloud hardware

- Bug fixes and small features for irdma, hns, siw, qedr, hfi1, mlx5

- General spelling/grammer fixes

- rdma cm can follow changes in neighbours for control packets

- Significant amounts of rxe fixes and spec compliance changes

- Use the modern NAPI API

- Use the bitmap API instead of open coding

- Performance improvements for rtrs

- Add the ERDMA driver for Alibaba cloud

- Fix a use after free bug in SRP

----------------------------------------------------------------
Aharon Landau (6):
      RDMA/mlx5: Add a umr recovery flow
      RDMA/mlx5: Replace ent->lock with xa_lock
      RDMA/mlx5: Replace cache list with Xarray
      RDMA/mlx5: Store the number of in_use cache mkeys instead of total_mrs
      RDMA/mlx5: Store in the cache mkeys instead of mrs
      RDMA/mlx5: Rename the mkey cache variables and functions

Andrey Strachuk (1):
      RDMA: remove useless condition in siw_create_cq()

Bart Van Assche (3):
      RDMA/srpt: Duplicate port name members
      RDMA/srpt: Introduce a reference count in struct srpt_device
      RDMA/srpt: Fix a use-after-free

Bob Pearson (18):
      RDMA/rxe: Stop lookup of partially built objects
      RDMA/rxe: Convert read side locking to rcu
      RDMA/rxe: Move code to rxe_prepare_atomic_res()
      RDMA/rxe: Add a responder state for atomic reply
      RDMA/rxe: Move atomic responder res to atomic_reply
      RDMA/rxe: Move atomic original value to res
      RDMA/rxe: Merge normal and retry atomic flows
      RDMA/rxe: Fix deadlock in rxe_do_local_ops()
      RDMA/rxe: Convert pr_warn/err to pr_debug in pyverbs
      RDMA/rxe: Replace include statement
      RDMA/rxe: Remove unnecessary include statement
      RDMA/rxe: Fix mw bind to allow any consumer key portion
      RDMA/rxe: Add rxe_is_fenced() subroutine
      RDMA/rxe: Fix rnr retry behavior
      RDMA/rxe: Make the tasklet exits the same
      RDMA/rxe: Limit the number of calls to each tasklet
      RDMA/rxe: Replace __rxe_do_task by rxe_run_task
      RDMA/rxe: Split qp state for requester and completer

Cheng Xu (12):
      RDMA/siw: Fix duplicated reported IW_CM_EVENT_CONNECT_REPLY event
      RDMA: Add ERDMA to rdma_driver_id definition
      RDMA/erdma: Add the hardware related definitions
      RDMA/erdma: Add main include file
      RDMA/erdma: Add cmdq implementation
      RDMA/erdma: Add event queue implementation
      RDMA/erdma: Add verbs header file
      RDMA/erdma: Add verbs implementation
      RDMA/erdma: Add connection management (CM) support
      RDMA/erdma: Add the erdma module
      RDMA/erdma: Add the ABI definitions
      RDMA/erdma: Add driver to kernel build environment

Christophe JAILLET (5):
      RDMA/qib: Use the bitmap API when applicable
      RDMA/qib: Use the bitmap API to allocate bitmaps
      RDMA/rtrs-clt: Use the bitmap API to allocate bitmaps
      RDMA/rtrs-clt: Use bitmap_empty()
      RDMA/irdma: Use the bitmap API to allocate bitmaps

Dongliang Mu (1):
      RDMA/rxe: fix xa_alloc_cycle() error return value check again

Ehab Ababneh (1):
      RDMA/hfi1: Depend on !UML

Haoyue Xu (5):
      RDMA/hns: Remove unused abnormal interrupt of type RAS
      RDMA/hns: Fix the wrong type of return value of the interrupt handler
      RDMA/hns: Fix incorrect clearing of interrupt status register
      RDMA/hns: Refactor the abnormal interrupt handler function
      RDMA/hns: Recover 1bit-ECC error of RAM on chip

Jack Wang (2):
      RDMA/rtrs-srv: Fix modinfo output for stringify
      RDMA/rtrs-srv: Do not use mempool for page allocation

Jakub Kicinski (3):
      IB/hfi1: switch to netif_napi_add_tx()
      IB/hfi1: switch to netif_napi_add_weight()
      ipoib: switch to netif_napi_add_weight()

Jason Gunthorpe (1):
      Merge branch 'erdma' into rdma.git for-next

Jason Wang (1):
      IB/qib: Fix comment typo

Jiang Jian (1):
      RDMA: Correct duplicated words in comments

Jianglei Nie (2):
      RDMA/qedr: Fix potential memory leak in __qedr_alloc_mr()
      RDMA/hfi1: fix potential memory leak in setup_base_ctxt()

Leon Romanovsky (2):
      Merge branch 'mlx5-next' into wip/leon-for-next
      Merge branch 'mlx5-next' into wip/leon-for-next

Li Zhijian (4):
      Revert "RDMA/rxe: Create duplicate mapping tables for FMRs"
      RDMA/rxe: Update wqe_index for each wqe error completion
      RDMA/rxe: Generate error completion for error requester QP state
      RDMA/ib_srpt: Unify checking rdma_cm_id condition in srpt_cm_req_recv()

Maor Gottlieb (1):
      RDMA/mlx5: Add missing check for return value in get namespace flow

Mark Bloch (5):
      net/mlx5: Expose the ability to point to any UID from shared UID
      net/mlx5: fs, expose flow table ID to users
      net/mlx5: fs, allow flow table creation with a UID
      RDMA/mlx5: Refactor get flow table function
      RDMA/mlx5: Expose steering anchor to userspace

Max Gurtovoy (1):
      IB/iser: Drain the entire QP during destruction flow

Md Haris Iqbal (2):
      RDMA/rtrs-clt: Replace list_next_or_null_rr_rcu with an inline function
      RDMA/rxe: For invalidate compare according to set keys in mr

Mustafa Ismail (6):
      RDMA/irdma: Add 2 level PBLE support for FMR
      RDMA/irdma: Add AE source to error log
      RDMA/irdma: Make CQP invalid state error non-critical
      RDMA/irdma: Fix a window for use-after-free
      RDMA/irdma: Fix VLAN connection with wildcard address
      RDMA/irdma: Fix setting of QP context err_rq_idx_valid field

Nayan Kumar (1):
      RDMA/irdma: Make resource distribution algorithm more QP oriented

Patrisious Haddad (2):
      RDMA/core: Add an rb_tree that stores cm_ids sorted by ifindex and remote IP
      RDMA/core: Add a netevent notifier to cma

Robin Murphy (1):
      RDMA/usnic: Use device_iommu_capable()

Santosh Kumar Pradhan (2):
      RDMA/rtrs-clt: Use this_cpu_ API for stats
      RDMA/rtrs-srv: Use per-cpu variables for rdma stats

Slark Xiao (1):
      IB: Fix repeated words 'the the' comments

Xiang wangx (1):
      RDMA/hfi1: Fix typo in comment

Xiao Yang (4):
      RDMA/rxe: Remove useless pkt parameters
      RDMA/rxe: Add common rxe_prepare_res()
      RDMA/rxe: Rename rxe_atomic_reply to atomic_reply
      RDMA/rxe: Remove unused qp parameter

Xin Gao (1):
      RDMA: Fix comment typo

Zhang Jiaming (2):
      IB: Fix spelling of 'writable'
      RDMA/rxe: Fix spelling mistake in error print

Zhu Yanjun (2):
      RDMA/rxe: Fix BUG: KASAN: null-ptr-deref in rxe_qp_do_cleanup
      RDMA/rxe: Fix error unwind in rxe_create_qp()

lizhijian@fujitsu.com (1):
      RDMA/rxe: Remove unused mask parameter

wangjianli (1):
      IB/qib: Fix repeated "in" within comments

 MAINTAINERS                                        |    8 +
 drivers/infiniband/Kconfig                         |   15 +-
 drivers/infiniband/core/cma.c                      |  230 ++-
 drivers/infiniband/core/cma_priv.h                 |    1 +
 drivers/infiniband/core/rdma_core.c                |    2 +-
 drivers/infiniband/core/roce_gid_mgmt.c            |    2 +-
 drivers/infiniband/hw/Makefile                     |    1 +
 drivers/infiniband/hw/bnxt_re/bnxt_re.h            |    2 +-
 drivers/infiniband/hw/erdma/Kconfig                |   12 +
 drivers/infiniband/hw/erdma/Makefile               |    4 +
 drivers/infiniband/hw/erdma/erdma.h                |  287 ++++
 drivers/infiniband/hw/erdma/erdma_cm.c             | 1430 +++++++++++++++++++
 drivers/infiniband/hw/erdma/erdma_cm.h             |  167 +++
 drivers/infiniband/hw/erdma/erdma_cmdq.c           |  493 +++++++
 drivers/infiniband/hw/erdma/erdma_cq.c             |  205 +++
 drivers/infiniband/hw/erdma/erdma_eq.c             |  329 +++++
 drivers/infiniband/hw/erdma/erdma_hw.h             |  508 +++++++
 drivers/infiniband/hw/erdma/erdma_main.c           |  608 ++++++++
 drivers/infiniband/hw/erdma/erdma_qp.c             |  566 ++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.c          | 1460 ++++++++++++++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.h          |  342 +++++
 drivers/infiniband/hw/hfi1/Kconfig                 |    2 +-
 drivers/infiniband/hw/hfi1/file_ops.c              |    4 +-
 drivers/infiniband/hw/hfi1/ipoib_tx.c              |    4 +-
 drivers/infiniband/hw/hfi1/netdev_rx.c             |    2 +-
 drivers/infiniband/hw/hfi1/pio_copy.c              |    2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        |    1 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  248 +++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |   13 +-
 drivers/infiniband/hw/irdma/cm.c                   |   11 +-
 drivers/infiniband/hw/irdma/ctrl.c                 |    8 +-
 drivers/infiniband/hw/irdma/hw.c                   |   33 +-
 drivers/infiniband/hw/irdma/main.h                 |    2 +-
 drivers/infiniband/hw/irdma/utils.c                |    1 +
 drivers/infiniband/hw/irdma/verbs.c                |   16 +-
 drivers/infiniband/hw/mlx5/cq.c                    |    4 +
 drivers/infiniband/hw/mlx5/fs.c                    |  165 ++-
 drivers/infiniband/hw/mlx5/main.c                  |    4 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |   79 +-
 drivers/infiniband/hw/mlx5/mr.c                    |  514 +++----
 drivers/infiniband/hw/mlx5/odp.c                   |    2 +-
 drivers/infiniband/hw/mlx5/umr.c                   |   78 +-
 drivers/infiniband/hw/qedr/verbs.c                 |    8 +-
 drivers/infiniband/hw/qib/qib.h                    |    2 +-
 drivers/infiniband/hw/qib/qib_file_ops.c           |    6 +-
 drivers/infiniband/hw/qib/qib_iba7220.c            |    2 +-
 drivers/infiniband/hw/qib/qib_iba7322.c            |   23 +-
 drivers/infiniband/hw/qib/qib_init.c               |    5 +-
 drivers/infiniband/hw/qib/qib_sd7220.c             |    2 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c           |    2 +-
 drivers/infiniband/sw/rxe/rxe_comp.c               |   49 +-
 drivers/infiniband/sw/rxe/rxe_cq.c                 |    8 +-
 drivers/infiniband/sw/rxe/rxe_loc.h                |    5 +-
 drivers/infiniband/sw/rxe/rxe_mr.c                 |  213 +--
 drivers/infiniband/sw/rxe/rxe_mw.c                 |   19 +-
 drivers/infiniband/sw/rxe/rxe_param.h              |    6 +
 drivers/infiniband/sw/rxe/rxe_pool.c               |  106 +-
 drivers/infiniband/sw/rxe/rxe_pool.h               |   18 +-
 drivers/infiniband/sw/rxe/rxe_qp.c                 |   36 +-
 drivers/infiniband/sw/rxe/rxe_queue.h              |    5 +-
 drivers/infiniband/sw/rxe/rxe_req.c                |  137 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |  236 ++--
 drivers/infiniband/sw/rxe/rxe_task.c               |   16 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |   78 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h              |   27 +-
 drivers/infiniband/sw/siw/siw_cm.c                 |    7 +-
 drivers/infiniband/sw/siw/siw_verbs.c              |    2 +-
 drivers/infiniband/ulp/ipoib/ipoib_ib.c            |    2 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |    6 +-
 drivers/infiniband/ulp/iser/iser_verbs.c           |    6 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c       |   14 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |   50 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h             |   21 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c       |   32 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c       |    2 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             |   32 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.h             |   15 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |  156 ++-
 drivers/infiniband/ulp/srpt/ib_srpt.h              |   18 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |   16 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h   |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |    8 +-
 .../ethernet/mellanox/mlx5/core/steering/dr_cmd.c  |    1 +
 .../mellanox/mlx5/core/steering/dr_table.c         |    8 +-
 .../mellanox/mlx5/core/steering/dr_types.h         |    1 +
 .../ethernet/mellanox/mlx5/core/steering/fs_dr.c   |    7 +-
 .../ethernet/mellanox/mlx5/core/steering/mlx5dr.h  |    3 +-
 include/linux/mlx5/driver.h                        |    6 +-
 include/linux/mlx5/fs.h                            |    2 +
 include/linux/mlx5/mlx5_ifc.h                      |    6 +-
 include/rdma/ib_verbs.h                            |    2 +-
 include/rdma/rdma_cm.h                             |    1 +
 include/uapi/rdma/erdma-abi.h                      |   49 +
 include/uapi/rdma/ib_user_ioctl_verbs.h            |    1 +
 include/uapi/rdma/mlx5_user_ioctl_cmds.h           |   17 +
 95 files changed, 8364 insertions(+), 1003 deletions(-)
(diffstat from tag for-linus-merged)

--ShRoNNnBLWzlIxpU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCYuwUlwAKCRCFwuHvBreF
YbItAQCb8+5L/pnhoInayYob6QVb84oEzuh3i+Q9bMuKw5BC+QEAvTn6N+5wsJ99
+lVozcWORxFTVmQELN23MK5pdVXI1QU=
=tjWx
-----END PGP SIGNATURE-----

--ShRoNNnBLWzlIxpU--
