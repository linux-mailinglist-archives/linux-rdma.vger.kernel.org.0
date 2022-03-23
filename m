Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CFD4E596E
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Mar 2022 20:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344431AbiCWT4L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Mar 2022 15:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344169AbiCWT4K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Mar 2022 15:56:10 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041878BF10;
        Wed, 23 Mar 2022 12:54:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrgJmsFV4zAqbN1ArVCB6kcXFMzGsZw843PY4Qjfw3CrQ65pg1VT2KfzZx1KEjqCzijP5nGGuXVnpwxg7FR/XTqvzB6zpujBv2WPdEfULwOcoe8/+KMXEE3ToxNVY8mAt/eSN2l40N8IViPKeaXZMtzOG2WDucCFC1UzxDTs4DDrMDYuNMf6wNL5sx4UQwRJdKfDGrwro2zC49V/h+11aGry41U4vfobyxc3yxWqxcpKUB8iT8buSL5GMTHjRIg355Ep1WKY2YuC9h4/mj/gNOFJVsSfGOsI5QIQ7JlNoh0DqdK3aX5xvM+ntzyD9qb7z1Qj/2WUbi9FIsezlJVc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HIC2mu4iu2EoUfcfftHWSKFcCsAPkPbd/uBEkyuoZA=;
 b=Hzqn64emwrszjWNGj+YK6Cw4E3Y1Sz/NVgL3JANPyQusEzcU0GzLtFpTXMXBfU73Ledgul5YxQYrNbUKiAFQxJ0vElnQvQhJqTfr/fO8XEaNOU8l8xxraz7r82OLinMUuh8n7iPtYK2u0MjWUTYpusQiEclXEm6o5/Lslbh2khYVtyR7XnTSSy8vrK0Vf9ox3pWfdRHDYT6W4v1ghXRNeAxWjgMGHRm5PXclUjOq8Ic9JlodkoW2Dpox9Wls6PzL2WKHYHwSibQu3JzK/v7fUhmIG5/t4yNLJ7XehHHsCxUNdWrgqy+fZz61fpumYDUBL+WatJ5iG42k1YiT4gJJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HIC2mu4iu2EoUfcfftHWSKFcCsAPkPbd/uBEkyuoZA=;
 b=TitLHAH6n2THbxd3xFh4ZnkumW01eaOaQNPjAshk4eL4c0XcXq9QlKpjiAZKrY/9ZXAfzb/TL1NkcYbhtHKRWOj2+hi2Ivo7ANXMgWdw9eQqX+npXkOlhD0qKgY7oXYiZfs3ZDd3M2IhiWKonXrwWf9G8HPMugPALS9CI3TXdKhrF9FCKj0PTZSvNwsvmJ/3iMNb/aCUC91fPzBsSddn0OMCXJ8Qxxh6m05TmMbMlRnZfF/Cf8Ts+Inwe2jDKGMZZt4E3q44lgd0YJk7ZyXWASrlSoHMhTMj3uurf83E35nh3ZcuFgmAxuHzVdMLCU0KsPOzfK+8et1KolzCgsIcDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SA0PR12MB4352.namprd12.prod.outlook.com (2603:10b6:806:9c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 19:54:38 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 19:54:38 +0000
Date:   Wed, 23 Mar 2022 16:54:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20220323195436.GA1216814@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
X-ClientProxiedBy: BL1PR13CA0298.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::33) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fa87a1b-5190-4985-5711-08da0d06f638
X-MS-TrafficTypeDiagnostic: SA0PR12MB4352:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB435286D0D8995A02F0BA79DDC2189@SA0PR12MB4352.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dFWCqP5mptuOzqBRzSPv6JSqgdal6o0zbGcR7B+NhT0XPxuOryhWmCBdJbB8p5QPpgsE3X+IU+R7iwbR7rHvANC9T16CvMfh1FAvJw3KiBfMR0YKLkeVCLEIVde1lQfWG8ksNE1JWSU3GOXmBBCZPVEOlibusVe+CPAZcv+bk36IAdPlIwOU75Rlgdtc5St7B1N+DsjnSfvm/fLqONzkAjdlY/3MVD7Mj2RxgKW80tkH4L0AFF3qSIVwh6qg8AOkFc2zbjcqIWUzTOj/+Gb2FgP4ZkBnPwB/M5D6Kh7iCVWtIFdlJTi3tmOb2ELB1RiMu73n/T3tU1B5ilNbumhPp6MjO8pW+TqDfdCDsUJqArPiW8yoVz9zcg1g6WFYgpTms6eL+SETtq8mTSqvfrRa3ZBTieZh1RY3ny2BO7baoLvGlPDpIpVTc+eqeWmeGCgpZFpeuK2tB1cy9dTVLSDhs/dqZ3pMVNJRSoXhQG8DWTJ6BdNPc+onhq9bX3bww7wD7bkBMAJDhPL3MdxIl40krayNdj/69gDCHkTur0CJRHvwsTF9fPZEyBErecS2KfpNNlk9JuMyRY8fS/9oBNpUFKOPbRHvjKXiZxxAuiNN4XDaRm5oPTWLxXtQb+rHXkEPwVvKdfRper4oh2hLKYwpki2eYm2tS9bmgjw/kD/cv6QdIpV3bV0Rvxv2W622N2fhCw6k4Pp5OAm+9xqWCftJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(66476007)(38100700002)(4326008)(8676002)(66946007)(66556008)(5660300002)(30864003)(6916009)(316002)(2616005)(508600001)(6486002)(6512007)(26005)(186003)(8936002)(2906002)(21480400003)(86362001)(33656002)(66574015)(33964004)(1076003)(44144004)(83380400001)(6506007)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkRSd09ib0sxanRJeG1FRm0yeHhhZUhhZnZkOEdSUnRENDUrOGRrb2FhdUw0?=
 =?utf-8?B?NUhNMHVxMzBlcU1ST2dXV25DT3F5MHgrK3lGRnF0c2NJQjQ3QjhBME52V0VX?=
 =?utf-8?B?eDFVM1BkVTlFdi9yczB3TzlTVklGbVFGWVNWM1pTSkZDWEEwUGsrTlRpZmtp?=
 =?utf-8?B?Q3hrd3Jpa1RRanllOVVsTWozeVpSME44c1g0RGV6a0dIWTVmUVhoVjRQNEZX?=
 =?utf-8?B?RTVnL0NWS1lpTDN5T0hqVTFxQjc2cTh4aTc2eERBY2dXRzk2ZjVJN2VrdGZz?=
 =?utf-8?B?ZzRkUnZPcm02QjkzcGt1aHdvWGNRbFR2ZmpaVTMyOXBHeTgzQ3pLNHR6UXpG?=
 =?utf-8?B?dWJXRW80am4vK0tLVDYxWnpRVmkrRnd2ZitReFpKYUlsNkNHbzdOMS9WRkxR?=
 =?utf-8?B?NUYwdGhNR2JkaFZ1QUJFN2RlNkIzVEZQTDRDaFZEelJVNWlaVTdIZkVpQUo5?=
 =?utf-8?B?K0puMjRMc2R6TVgrMy91NnBhTXdEeE1xSk5CZEYybVM5aWFvNTdWanZyYlg4?=
 =?utf-8?B?dlFNY0tUakdSa3Vzd0o0ZkRnOGNDV01oRUpjY1J6RkprUUR6TXJjeWVjdEc4?=
 =?utf-8?B?aVBPeXpDdWxxMzI4bnl2UUhYNFUrNzZHdldLaDROTFk3TmFmQk01U1JZQnpl?=
 =?utf-8?B?WnJweWlSR00xRytTYmNqVDVHYnZQSFI2RG5JSm04UmN6VTJKSWgvVHQ0ekwz?=
 =?utf-8?B?WXNuOTRRalpYVnRRVldtKzFQV3dvekhrZGdRTVc0TGhNNzJaaUxhREo2R3dZ?=
 =?utf-8?B?VGlkaUpaQ3p0ek5hTGliQ1A5UlltbE9pTzdQdjdLU1hMWVpaZUpFMzNOdGZr?=
 =?utf-8?B?aFg4SUlnY3poS25qRHNpUDF3eDlld3ZRZWhrUGdROEJoMTNNdExENDU5TWV2?=
 =?utf-8?B?SXNmNGVwQThOc2lkdzBzTVEvRFJaajVtNzVaWDZZY2V1QkV1WHhlUVJ1QStv?=
 =?utf-8?B?d29JKzVpR3ZpajBsK2pxbHdzTW04ZEZNdC9aTjhYaVNEUzZHbXI4L0lOZkZH?=
 =?utf-8?B?Nm1VMFZxRkZ4Uys2cHdqbWhhZEljYnJEZGg0dFJKVnl3TXFUVzJoeEUxL2hv?=
 =?utf-8?B?MW1aSUF3S201R3NOL0haV2JIekJhZS9oMC9BS3BhVXRKWXk0RitZU1VjSE1k?=
 =?utf-8?B?SUt0bkRMNEEwWnBNYW5IN3dQVlJ4VllIM0wySGpPSSthQVBveFNNVnlqenk5?=
 =?utf-8?B?emhhaXJjbVB0TythM2dBRUE4ZmwwZExGRVpPbVpRY1o3U3QxMCtnVEg5dXFU?=
 =?utf-8?B?WUk0SlBueTlCNU9zM0s1bGpNYmN1WVg1MFN6V3dNWVVSamJBSXB6WXdHQytG?=
 =?utf-8?B?S2k4anBKQVlmVmVZY29RQ3ViNlBKdGRMTkdBRUhaTGdWYi9iTWN3czVicWNw?=
 =?utf-8?B?RDY0OXpkYmZ0T21iMmMzaHdVelpHSjY1UmI2KzVvNTJPUVdXOXdIRjdiRnpk?=
 =?utf-8?B?TWNaTU9Kazl1REphRW5QaDFFUnJGMENsYkYwWEJxdk1Xdnl2V2RCTys0Rmtw?=
 =?utf-8?B?YkhqZHhKV0ZSanZWWkJWVEpGbkQzTm9YWDJVejYyVG9Zcyt5Z0NvYUU0NDd6?=
 =?utf-8?B?cVdxUnBHdEQzQjBneFBVaE1ubGlHNmF5cDlCZFoxaHFVc1NvZ21KUXpBOWln?=
 =?utf-8?B?MkViYUdNM3ZsbGwvRUQ4QTFqL0V2a1dqQVNzZnRaTTJzYlpYQW13dUdEN3Mx?=
 =?utf-8?B?bTlSSGxOQVZXZk9HVG9heXlCRHBKV3hlMG9xbE5sZ21xcW5IRXQzU1N6SnJG?=
 =?utf-8?B?L2hHSm02aUJPdHhObHdzdGNoSUJvZ090OHBQSTdCM2Q3eFlqQVZhZG0vNXFv?=
 =?utf-8?B?YUdkVm1NVmE1UmhLVUZjRnFLSDBOSWkwMVkwbW85QVFYWWY3c3pTYWovUEdx?=
 =?utf-8?B?TDFYbk8vbHdXL21vbU02eXY1aEtIWU14cWNQclRqeGp2TklFamt5dFQ1WnVR?=
 =?utf-8?Q?s0WS5HhUU1d94/pvZWqTkDKs71+NjlJm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa87a1b-5190-4985-5711-08da0d06f638
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 19:54:38.0854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tl/yJ0ozEGfmssLHff21GVzwNAczG32Thk5hrKuScV9NEDmEpwesWt1BgzOGNJag
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4352
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Another smaller pull request this time. There is a new RDMA driver on
the list for Alibaba's cloud environment which may land for the next
cycle.

Thanks,
Jason

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 87e0eacb176f9500c2063d140c0a1d7fa51ab8a5:

  RDMA/nldev: Prevent underflow in nldev_stat_set_counter_dynamic_doit() (2=
022-03-18 15:40:54 -0300)

----------------------------------------------------------------
v5.18 merge window pull request

Patchces for the merge window:

- Minor bug fixes in mlx5, mthca, pvrdma, rtrs, mlx4, hfi1, hns

- Minor cleanups: coding style, useless includes and documentation

- Reorganize how multicast processing works in rxe

- Replace a red/black tree with xarray in rxe which improves performance

- DSCP support and HW address handle re-use in irdma

- Simplify the mailbox command handling in hns

- Simplify iser now that FMR is eliminated

----------------------------------------------------------------
Aharon Landau (5):
      RDMA/mlx5: Remove redundant work in struct mlx5_cache_ent
      RDMA/mlx5: Fix the flow of a miss in the allocation of a cache ODP MR
      RDMA/mlx5: Merge similar flows of allocating MR from the cache
      RDMA/mlx5: Store ndescs instead of the translation table size
      RDMA/mlx5: Reorder calls to pcie_relaxed_ordering_enabled()

Bart Van Assche (1):
      RDMA/ib_srp: Add more documentation

Bob Pearson (27):
      RDMA/rxe: Move rxe_mcast_add/delete to rxe_mcast.c
      RDMA/rxe: Move rxe_mcast_attach/detach to rxe_mcast.c
      RDMA/rxe: Rename rxe_mc_grp and rxe_mc_elem
      RDMA/rxe: Enforce IBA o10-2.2.3
      RDMA/rxe: Remove rxe_drop_all_macst_groups
      RDMA/rxe: Remove qp->grp_lock and qp->grp_list
      RDMA/rxe: Revert changes from irqsave to bh locks
      RDMA/rxe: Move mcg_lock to rxe
      RDMA/rxe: Use kzmalloc/kfree for mca
      RDMA/rxe: Replace grp by mcg, mce by mca
      RDMA/rxe: Replace int num_qp by atomic_t qp_num
      RDMA/rxe: Replace pool key by rxe->mcg_tree
      RDMA/rxe: Remove key'ed object support
      RDMA/rxe: Remove mcg from rxe pools
      RDMA/rxe: Warn if mcast memory is not freed
      RDMA/rxe: Collect mca init code in a subroutine
      RDMA/rxe: Collect cleanup mca code in a subroutine
      RDMA/rxe: Cleanup rxe_mcast.c
      RDMA/rxe: Fix ref error in rxe_av.c
      RDMA/rxe: Replace mr by rkey in responder resources
      RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
      RDMA/rxe: Delete _locked() APIs for pool objects
      RDMA/rxe: Replace obj by elem in declaration
      RDMA/rxe: Move max_elem into rxe_type_info
      RDMA/rxe: Shorten pool names in rxe_pool.c
      RDMA/rxe: Replace red-black trees by xarrays
      RDMA/rxe: Use standard names for ref counting

Chengchang Tang (5):
      RDMA/hns: Remove the unused parameter "op_modifier" in mailbox
      RDMA/hns: Remove fixed parameter =E2=80=9Ctimeout=E2=80=9D in the mai=
lbox
      RDMA/hns: Refactor mailbox functions
      RDMA/hns: Remove similar code that configures the hardware contexts
      RDMA/hns: Refactor the alloc_srqc()

Chengguang Xu (2):
      RDMA/rxe: Change variable and function argument to proper type
      RDMA/rxe: Remove useless argument for update_state()

Christophe JAILLET (2):
      IB/mthca: Remove useless DMA-32 fallback configuration
      RDMA/pvrdma: Remove useless DMA-32 fallback configuration

Colin Ian King (1):
      RDMA/mlx4: remove redundant assignment to variable nreq

Dan Carpenter (2):
      RDMA/irdma: Prevent some integer underflows
      RDMA/nldev: Prevent underflow in nldev_stat_set_counter_dynamic_doit()

Dave Ertman (1):
      ice: add support for DSCP QoS for IDC

Gioh Kim (2):
      RDMA/rtrs: Remove empty line after bracket
      RDMA/rtrs-clt: Reflow text so lines don't end with a '('

H=C3=A5kon Bugge (1):
      IB/cma: Allow XRC INI QPs to set their local ACK timeout

Jack Wang (2):
      RDMA/rtrs-clt: Update one outdated comment in path_it_deinit()
      RDMA/rtrs-clt: Do stop and failover outside reconnect work.

Jason Gunthorpe (1):
      Merge branch 'irdma_dscp' into rdma.git for-next

Julia Lawall (1):
      RDMA/qib: Fix typos in comments

Leon Romanovsky (13):
      RDMA/mlx5: Delete get_num_static_uars function
      RDMA/mlx5: Delete useless module.h include
      RDMA/core: Delete useless module.h include
      RDMA/hfi1: Delete useless module.h include
      RDMA/mlx4: Delete useless module.h include
      RDMA/mthca: Delete useless module.h include
      RDMA/qib: Delete useless module.h include
      RDMA/usnic: Delete useless module.h include
      RDMA/rxe: Delete useless module.h include
      RDMA/ipoib: Delete useless module.h include
      RDMA/iser: Delete useless module.h include
      RDMA/opa: Delete useless module.h include
      Revert "RDMA/core: Fix ib_qp_usecnt_dec() called when error"

Maor Gottlieb (1):
      RDMA/core: Set MR type in ib_reg_user_mr

Max Gurtovoy (4):
      IB/iser: Remove iser_reg_data_sg helper function
      IB/iser: Use iser_fr_desc as registration context
      IB/iser: Generalize map/unmap dma tasks
      IB/iser: Fix error flow in case of registration failure

Mike Marciniszyn (1):
      IB/hfi1: Allow larger MTU without AIP

Mustafa Ismail (6):
      RDMA/irdma: Refactor DCB bits in prep for DSCP support
      RDMA/irdma: Add support for DSCP
      RDMA/irdma: Fix netdev notifications for vlan's
      RDMA/irdma: Fix Passthrough mode in VM
      RDMA/irdma: Remove incorrect masking of PD
      RDMA/irdma: Add support for address handle re-use

Shiraz Saleem (3):
      RDMA/irdma: Remove enum irdma_status_code
      RDMA/irdma: Propagate error codes
      RDMA/irdma: Remove excess error variables

Wenpeng Liang (4):
      RDMA/hns: Remove redundant parameter "mailbox" in the mailbox
      RDMA/hns: Fix the wrong type of parameter "op" of the mailbox
      RDMA/hns: Clean up the return value check of hns_roce_alloc_cmd_mailb=
ox()
      RDMA/hns: Refactor the alloc_cqc()

Xiao Yang (1):
      RDMA/rxe: Check the last packet by RXE_END_MASK

Yajun Deng (2):
      RDMA/core: Remove unnecessary statements
      RDMA/core: Fix ib_qp_usecnt_dec() called when error

Yixing Liu (1):
      RDMA/hns: Use the reserved loopback QPs to free MR before destroying =
MPT

Yongzhi Liu (1):
      RDMA/mlx5: Fix memory leak in error flow for subscribe event routine

Yury Norov (1):
      RDMA/hfi: Replace cpumask_weight with cpumask_empty where appropriate

Zhu Yanjun (4):
      RDMA/irdma: Use net_type to check network type
      RDMA/irdma: Remove the unnecessary variable saddr
      RDMA/irdma: Move union irdma_sockaddr to header file
      RDMA/irdma: Make irdma_create_mg_ctx return a void

 drivers/infiniband/core/addr.c                    |   1 -
 drivers/infiniband/core/cache.c                   |   1 -
 drivers/infiniband/core/cma.c                     |   2 +-
 drivers/infiniband/core/cma_configfs.c            |   1 -
 drivers/infiniband/core/cq.c                      |   1 -
 drivers/infiniband/core/iwpm_util.h               |   1 -
 drivers/infiniband/core/nldev.c                   |   3 +-
 drivers/infiniband/core/sa_query.c                |   1 -
 drivers/infiniband/core/verbs.c                   |   9 +-
 drivers/infiniband/hw/hfi1/affinity.c             |   5 +-
 drivers/infiniband/hw/hfi1/debugfs.c              |   1 -
 drivers/infiniband/hw/hfi1/device.c               |   1 -
 drivers/infiniband/hw/hfi1/fault.c                |   1 -
 drivers/infiniband/hw/hfi1/firmware.c             |   1 -
 drivers/infiniband/hw/hfi1/verbs.c                |   3 +-
 drivers/infiniband/hw/hns/hns_roce_cmd.c          |  97 ++--
 drivers/infiniband/hw/hns/hns_roce_cmd.h          |   8 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c           |  71 +--
 drivers/infiniband/hw/hns/hns_roce_device.h       |  26 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c          |   4 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c        | 458 +++++++++++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h        |  20 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c    |   5 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c           |  50 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c          | 110 ++--
 drivers/infiniband/hw/irdma/cm.c                  |  68 +--
 drivers/infiniband/hw/irdma/cm.h                  |   7 +
 drivers/infiniband/hw/irdma/ctrl.c                | 602 +++++++++++-------=
----
 drivers/infiniband/hw/irdma/defs.h                |   8 +-
 drivers/infiniband/hw/irdma/hmc.c                 | 105 ++--
 drivers/infiniband/hw/irdma/hmc.h                 |  53 +-
 drivers/infiniband/hw/irdma/hw.c                  | 192 ++++---
 drivers/infiniband/hw/irdma/i40iw_hw.c            |   1 -
 drivers/infiniband/hw/irdma/i40iw_if.c            |   3 +-
 drivers/infiniband/hw/irdma/main.c                |  29 +-
 drivers/infiniband/hw/irdma/main.h                |  47 +-
 drivers/infiniband/hw/irdma/osdep.h               |  41 +-
 drivers/infiniband/hw/irdma/pble.c                |  77 ++-
 drivers/infiniband/hw/irdma/pble.h                |  25 +-
 drivers/infiniband/hw/irdma/protos.h              |  90 ++--
 drivers/infiniband/hw/irdma/puda.c                | 132 +++--
 drivers/infiniband/hw/irdma/puda.h                |  43 +-
 drivers/infiniband/hw/irdma/status.h              |  71 ---
 drivers/infiniband/hw/irdma/type.h                | 109 ++--
 drivers/infiniband/hw/irdma/uda.c                 |  40 +-
 drivers/infiniband/hw/irdma/uda.h                 |  46 +-
 drivers/infiniband/hw/irdma/uk.c                  | 122 ++---
 drivers/infiniband/hw/irdma/user.h                |  62 +--
 drivers/infiniband/hw/irdma/utils.c               | 247 +++++----
 drivers/infiniband/hw/irdma/verbs.c               | 389 +++++++-------
 drivers/infiniband/hw/irdma/verbs.h               |  15 +-
 drivers/infiniband/hw/irdma/ws.c                  |  19 +-
 drivers/infiniband/hw/irdma/ws.h                  |   2 +-
 drivers/infiniband/hw/mlx4/alias_GUID.c           |   1 -
 drivers/infiniband/hw/mlx4/srq.c                  |   1 -
 drivers/infiniband/hw/mlx5/devx.c                 |   4 +-
 drivers/infiniband/hw/mlx5/ib_virt.c              |   1 -
 drivers/infiniband/hw/mlx5/mem.c                  |   1 -
 drivers/infiniband/hw/mlx5/mlx5_ib.h              |  12 +-
 drivers/infiniband/hw/mlx5/mr.c                   | 104 ++--
 drivers/infiniband/hw/mlx5/odp.c                  |  19 +-
 drivers/infiniband/hw/mlx5/qp.c                   |   4 +-
 drivers/infiniband/hw/mlx5/srq.c                  |   1 -
 drivers/infiniband/hw/mthca/mthca_main.c          |   8 +-
 drivers/infiniband/hw/mthca/mthca_profile.c       |   2 -
 drivers/infiniband/hw/qib/qib_fs.c                |   1 -
 drivers/infiniband/hw/qib/qib_iba7220.c           |   4 +-
 drivers/infiniband/hw/usnic/usnic_debugfs.c       |   1 -
 drivers/infiniband/hw/usnic/usnic_ib_qp_grp.c     |   1 -
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c      |   1 -
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c      |   1 -
 drivers/infiniband/hw/usnic/usnic_transport.c     |   1 -
 drivers/infiniband/hw/usnic/usnic_vnic.c          |   1 -
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  10 +-
 drivers/infiniband/sw/rxe/rxe.c                   | 110 +---
 drivers/infiniband/sw/rxe/rxe.h                   |   1 -
 drivers/infiniband/sw/rxe/rxe_av.c                |  19 +-
 drivers/infiniband/sw/rxe/rxe_comp.c              |   8 +-
 drivers/infiniband/sw/rxe/rxe_cq.c                |  20 +-
 drivers/infiniband/sw/rxe/rxe_loc.h               |  32 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c             | 556 +++++++++++++++---=
--
 drivers/infiniband/sw/rxe/rxe_mmap.c              |   1 -
 drivers/infiniband/sw/rxe/rxe_mr.c                |  15 +-
 drivers/infiniband/sw/rxe/rxe_mw.c                |  38 +-
 drivers/infiniband/sw/rxe/rxe_net.c               |  41 +-
 drivers/infiniband/sw/rxe/rxe_pool.c              | 443 ++++------------
 drivers/infiniband/sw/rxe/rxe_pool.h              | 105 +---
 drivers/infiniband/sw/rxe/rxe_qp.c                |  57 +-
 drivers/infiniband/sw/rxe/rxe_queue.c             |  10 +-
 drivers/infiniband/sw/rxe/rxe_recv.c              |  26 +-
 drivers/infiniband/sw/rxe/rxe_req.c               |  71 +--
 drivers/infiniband/sw/rxe/rxe_resp.c              | 170 +++---
 drivers/infiniband/sw/rxe/rxe_verbs.c             | 108 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.h             |  27 +-
 drivers/infiniband/ulp/ipoib/ipoib_netlink.c      |   1 -
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c         |   1 -
 drivers/infiniband/ulp/iser/iscsi_iser.h          |  13 +-
 drivers/infiniband/ulp/iser/iser_initiator.c      |  58 +--
 drivers/infiniband/ulp/iser/iser_memory.c         |  69 +--
 drivers/infiniband/ulp/iser/iser_verbs.c          |   3 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c |   1 -
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c      |   3 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c            |  42 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.h            |   1 +
 drivers/infiniband/ulp/rtrs/rtrs.c                |   1 -
 drivers/infiniband/ulp/srp/ib_srp.h               |  11 +-
 drivers/net/ethernet/intel/ice/ice_idc.c          |   5 +
 include/linux/net/intel/iidc.h                    |   4 +
 108 files changed, 2890 insertions(+), 2886 deletions(-)
 delete mode 100644 drivers/infiniband/hw/irdma/status.h

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmI7evkACgkQOG33FX4g
mxpfXQ/6AjgB53ij7EWYgAonpaKBYlqxDreJ7qmntjTnEbbT13YmL2H9l/qNimB0
DynLR4o2N9sqEFtaN1Qq3MmlzKPfc/MorefmtB5/4ylKvySGcSOMV+Ar4nBeL4sP
5t5H/TJHYK1Mj0PfbpcE1rokM4sDrZZoBP2uXG9pOcARcZiaa16hLzXiImEOOQPE
GeoLM7lpSt3bxv7yZE4wXUnm7/bYqyD13lP+A6kH87BWmwhOAuVtFmq6xtzEzHsT
08xEikuLYT9QKjlDRBUfjqvgKNxZZeLNHgguUV6kDPT/yUs8FPgE2THkjl2o6i32
UwMoVS7dCWjJy3HuW9SNhnrP95uj/zdIs/T9i6DXX/qQ3dirrQqplBybHopM1x/i
jfd2F98McYyHhm+vz3mE1FRe4sSJD5L+r8hDrf39CkdAuuIDDLjqxiDKSeTBCW+k
bEyoy1BUBeXunqOO8C9206eswztBwg1YmOcE6DmnT45rzcGR/wFvPgxFyd92tYJL
lPou4g8QcqcP+H418YxIkHMpmGeDCjtoTrn4JGzuFPRkFzhZbFwoj2i2qT6OhYjv
P9pH6kPi6kz0efFKPSUl9U4ZEHOHM2S2Kxp22R6hh2IPJTf4bkhA4XbrNY91QlZu
lYgOarvFboe7GI6VTUVvPq/QXUQ1rKbSsPqLywJI6uII/f1HnY8=
=Rw9q
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
