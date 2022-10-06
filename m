Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4165F7182
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Oct 2022 01:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJFXDL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Oct 2022 19:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiJFXDK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Oct 2022 19:03:10 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0164E4E402;
        Thu,  6 Oct 2022 16:03:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNu0c4lnx8e5utdLxl84PuUtUoFctDASO+2olO0OwdjSPDKDnyoUL2bCdTbS284qRrY012wR61U+Is+4BYPHXgywSfuiJM+blqQsTuZP40QIeGcaSsszcz//WivduvrlD2vL2oBTDBpnUhqOdKtUsmB/Lo6FgUOnXi/KshDF1GdA308jkNt8Infdg/EzUGsKIdo5JJef9gcTA2hedjjkzVxUTPV+EiVjPBwXVcGAUh36XOKzCCFzqiV0NqYf5F6K7Ugcu0mqtjm7OsfC9ihOuFFms8k+hwReKalJMNeHBayR/IdG6fi5ylOOioTfM5nF6kmAudYof98weQyN446Ohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJBm41sv2L4ORJpUQrSaSHwC3LdvETldzi8Tw+pt4MA=;
 b=T4vNvu+hEodXnOiTlgI1iwfj98NLaF/v0LqyE3c3DeOeTi6QXo9j5Qw9v1Y/i4VdMv73nBmXaYrWj8K9oFcsuMqYdgE+8pVYxNUF2/UMoKUNq6BUXpPLoQWEPcapvRdn58wDBYUNx7I3s0e+YXGHFz6N2eqQlxUIwBux/2TdyDZKY8ZIwJJ69FNUCmLhRF+22C/9379ayPvHnOibSl3YDrj5sosjaEXX4tbanH0Z6cj6gOvo+N70dK+BcjBntlaVbJ8iWYM+yDTK9OCLiFZVUK2l6sNkdsi2VHJxB26GT4sm/fPbU9A19lu9qemZ2xTNwIiRHWHIU7B2O949aF3sXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJBm41sv2L4ORJpUQrSaSHwC3LdvETldzi8Tw+pt4MA=;
 b=flWYLiL/fHlO4ulnhKhWsmilRzFs1IOrg8K9Zty0pYqW+HVQTQj/gdM2eHVjQcfdLfJiJys+cUB/8IqXsWJnSIW5lFnizT8kIkG5Rkbr9QZ4hZ9EG31OEvz2xjfOQoyK9sCdblUPILrnGqsVzwopsvzMKlCDzv5+r9Uk9P5eTmg4SUi18RtXT5JWyMHeO/Y+gy34imASl/ZeDGbVacY2nri30OQcWNvOd+QI11K+AVAbnOHXL56hDkr4iZOLsKGkHZOrzMsUoEfcChQ+NmDdFeWsoAvP6a2e3Eo+Xu2q53Joioid5EWQnhfTQFntXxay2Wy/TRnemHYm9AzRx2fSIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 23:03:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%5]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 23:03:05 +0000
Date:   Thu, 6 Oct 2022 20:03:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <Yz9eqEUfSParOUJk@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DMTgkBMpz+FHi6/l"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:208:234::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: 60da4030-29ef-460a-e6ad-08daa7eeed95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SKuNrUifnQutKKMCFaRF6FuRnua2fld8GWtclEmxmDvDaAQn5mhHB7JjPEO300eQUBoWUsXblt+inetGlaCCqT1cxfkCHj5wvwCEfO1/KzRPgBWv1aE7Yse3VJPPwPWeO4IoA4qBGh6VvZwMd0ptBY1aX+RckMb87/T/aOcD/UVjzwnVUXkjjx43YSUiJjm445FX/1dZb9/RsKxCuc3ApevdtcHBpTQQ/7gwSdiuqnmyScSXoPM4NBtSX4vAF9s16YA+LUewke0ABPAokaA2gsrDKkTVX3X/fKlb9WWGNwqUZn8fuP5EMzx4xcLjn6Z4G2uPxtIDcVun+zFUDv8QeR0Q402yc0/fn/PlARCKCCr/9BfaMFLQvhdIzsWC95I8RcsGydwNhyqL/OuoVVB43YLGdY0GHBfdkquDx66m6j1Uq2g/ztEpJyGJrr1ky2WBVY9I3u611sIbtjow/tIw1r/L0cJpXERiYdnTmbrgT0AgX4MYsUZIRlGC6OyK1XJuaqJzi0glUxKYWucBYVHXSie5jNWk3zDcjsXeecyC6AiHjmnGz3oSUgsnHrWw0lhXBwsJUNpMrcQ8cbFBFB+CGIXX9XY3gZJPP7meZnGxjbpbY6CWzzETJdDrQn7BTAJoo/9KIn9hj03gf4May0pHtQby4exzADWBiJf/kn54x0gVOm8zlhGY7BbKVfZe1b+hUD/TpOkKsKnsan8Nf6MlaesjqSMNgZPUQ4N1C/fSDbjeJIiJWgVsEVGn/TOHCNN1e47e+k/yanjcpv9PGROYZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199015)(36756003)(86362001)(38100700002)(21480400003)(4326008)(6512007)(44144004)(2906002)(8936002)(186003)(5660300002)(107886003)(26005)(41300700001)(6506007)(2616005)(66476007)(83380400001)(66574015)(6486002)(30864003)(478600001)(66946007)(6916009)(66556008)(8676002)(316002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K+/B9YjwH3vAcgWbO5XQfMj+ozTC6EggKnZALtMd7rAzxcCwphwec+AzJIDw?=
 =?us-ascii?Q?PnhjO/ZMUMQnZqzB85iV2C2y+CFWBdkfq9PVtclrjN+IXQc2gNUFLI+m4NfO?=
 =?us-ascii?Q?RhtSjUXwrtzH3zjhUuxGKQqyWgj5kLCUsqdmZMbjda5/ph2VQUdAGoGRSSUf?=
 =?us-ascii?Q?M+6HELKU/MMhWSIyW0VP5gUc2irvMmd0v3eXy0u75gyGHwG04TSCpbgzwy1d?=
 =?us-ascii?Q?KDpdG+E66YC5lr36thmkDZ8H1KmOm1bldMc3p3N4hPvlCOq6SOc6NI7kIgMW?=
 =?us-ascii?Q?dU6SFZyV0UuQv0G56vd0xPO+TxfWwF5QHBWei/NcQcVtafpYXFMAb1yXLZpW?=
 =?us-ascii?Q?o4e3rcunyumLOUJBiAekstfxrAYcqzF0x/gOJWSZG6VLD1Uu48jX7LEBya11?=
 =?us-ascii?Q?EpMB9+quxDuaWF8h3O8goYKCBA/Mp5A8CxkPHjs+da7XPKZawqZVlqUZypE0?=
 =?us-ascii?Q?Wk15Y5OBJkwF5jlwYt9FvS53+J5yZ7V4+THMYfGNd6K2VhqXfKHCG/ygrVIu?=
 =?us-ascii?Q?OsQcYq3/7x0fk7jzs1ccvQjW6af/LzwzJJG6rgiN0gKdEWC09REsf8rgUsln?=
 =?us-ascii?Q?ensU8EahyRKCbLDQWTApm0+GQNU1+U8pbPdsz/sVXDHRBsFLtZjo4UtWmxiP?=
 =?us-ascii?Q?z+YcP25UAuyWw5EZG9a3KqaN9tPSD3/X6+6YvtQb3hJw2YVxcb6ANJFZf7/F?=
 =?us-ascii?Q?kix0R45Lj9Qdwf3e1TlhQ8MUPk8Nannub5OGVidwrP8cx0v8uJJhsdlaFSe7?=
 =?us-ascii?Q?SGb5sn4twUsOho6WJLLWp5wxTUY45IGm39PTYOK/gdLNwyo0KdXIDnFnUdxt?=
 =?us-ascii?Q?qiM+fyoUwG5KaV/L1d9P26zcvkXZK/VuQxYx5Uy9qNOFEAjeDmuOmfZArRyh?=
 =?us-ascii?Q?bMY/6092Yw/63jH76D/e1guriAvUKA797X7AZW1tAayQPy2fAjY2QiyidP6B?=
 =?us-ascii?Q?H0zHhtw5+7xmiW4iP3Cr9nzChe0k493Q3kvgoswVs3xS8NC17/BYusxzG3Cn?=
 =?us-ascii?Q?X2BungDjQ9MAKm2tVBrKOJmLhdgWcSalLV0SEbkgzOtPg0gjxgRGNMY2G0il?=
 =?us-ascii?Q?4qFZVdt1B+x+Nq559DkfOPhVdWByGZBB7Kn4mZgQoV5zRZA2EhIDjyMVB31o?=
 =?us-ascii?Q?wrJkFzv/zVwBo+Y+848XHlaqfkXFfxtJFRibjoRti/Ka9JbO5vPNmr9XqA4U?=
 =?us-ascii?Q?oSaay0O3TjzIf6km2dqb+9Hh+PtJ0RyztROBDhPemq5Di67P20/GXowgPFvP?=
 =?us-ascii?Q?Hg2nu/UVcIhGLA4n0sWaOAPSB42xHQdIcd184QXKxFfJd2oD6gE/aes3twbu?=
 =?us-ascii?Q?b2B2ZQy7ac/3HuHwh4r7zwwo5GQJR5+lzIAzRXGjM5pCRVYYoiVowa5Gzkcg?=
 =?us-ascii?Q?eBHMWiUqca0NsJJLDUiy3VEXYt+nV0t/ydkxsyDbdX+3KHKDu7AV9tVdTiJZ?=
 =?us-ascii?Q?QZn1SkcTvO4ZPKg8ZWQ1nE+XN6wUi5SnhlPbJfzClBsI0PVI63cZmSCMjeZS?=
 =?us-ascii?Q?5WzU9Ghq124NX720V9PYnZUNX7WE5cWiY/jUFBnHjz/Ey/E2I0lOKPelN0Yq?=
 =?us-ascii?Q?mpTb8PjhgPe7S/w1kWw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60da4030-29ef-460a-e6ad-08daa7eeed95
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 23:03:05.7843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Twcswc7rfqpJvxtCXXa7526Wr2J77nutLNtiD0iywSMvmKuMMAJ0N2VXiTMhDWxy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--DMTgkBMpz+FHi6/l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Not a big list of changes this cycle, mostly small things. The new
MANA rdma driver should come next cycle along with a bunch of work on
rxe.

The following changes since commit 4fe89d07dcc2804c8b562f6c7896a45643d34b2f:

  Linux 6.0 (2022-10-02 14:09:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 33331a728c83f380e53a3dbf2be0c1893da1d739:

  Merge tag 'v6.0' into rdma.git for-next (2022-10-06 19:48:45 -0300)

----------------------------------------------------------------
v6.1 merge window pull request

- Small bug fixes in mlx5, efa, rxe, hns, irdma, erdma, siw

- rts tracing improvements

- Code improvements: strlscpy conversion, unused parameter, spelling
  mistakes, unused variables, flex arrays

- restrack device details report for hns

- Simplify struct device initialization in SRP

- Eliminate the never-used service_mask support in IB CM

- Make rxe not print to the console for some kinds of network packets

- Asymetric paths and router support in the CM through netlink messages

- DMABUF importer support for mlx5devx umem's

----------------------------------------------------------------
Aharon Landau (1):
      RDMA/mlx5: Don't compare mkey tags in DEVX indirect mkey

Bart Van Assche (5):
      RDMA/srp: Rework the srp_add_port() error path
      RDMA/srp: Remove the srp_host.released completion
      RDMA/srp: Handle dev_set_name() failure
      RDMA/srp: Use the attribute group mechanism for sysfs attributes
      RDMA/srp: Fix srp_abort()

Bernard Metzler (2):
      RDMA/siw: Always consume all skbuf data in sk_data_ready() upcall.
      RDMA/siw: Fix QP destroy to wait for all references dropped.

Bob Pearson (3):
      RDMA/rxe: Set pd early in mr alloc routines
      RDMA/rxe: Fix resize_finish() in rxe_queue.c
      RDMA/rxe: Remove redundant num_sge fields

Bodong Wang (1):
      IB/mlx5: Support querying eswitch functions from DEVX

Cheng Xu (4):
      RDMA/erdma: Eliminate unnecessary casting for erdma_post_cmd_wait
      RDMA/erdma: Remove redundant includes
      RDMA/erdma: Make hardware internal opcodes invisible to driver
      RDMA/erdma: Support dynamic mtu

Chengchang Tang (1):
      RDMA/hns: Remove redundant 'phy_addr' in hns_roce_hem_list_find_mtt()

Daisuke Matsuda (7):
      IB/mlx5: Remove duplicate header inclusion related to ODP
      RDMA/rxe: Remove an unused member from struct rxe_mr
      RDMA/rxe: Delete error messages triggered by incoming Read requests
      RDMA/mlx5: Remove duplicate assignment in umr_rereg_pas()
      IB: Set IOVA/LENGTH on IB_MR in core/uverbs layers
      RDMA/rxe: Use members of generic struct in rxe_mr
      RDMA/rxe: Remove error/warning messages from packet receiver path

Dan Carpenter (1):
      RDMA/core: Clean up a variable name in ib_create_srq_user()

Gaosheng Cui (1):
      IB/hfi1: remove rc_only_opcode and uc_only_opcode declarations

Guofeng Yue (4):
      RDMA/hns: Cleanup for a spelling error of Asynchronous
      RDMA/hns: Remove unnecessary braces for single statement blocks
      RDMA/hns: Remove unnecessary brackets when getting point
      RDMA/hns: Unified Log Printing Style

Guoqing Jiang (4):
      RDMA/rtrs: Remove 'dir' argument from rnbd_srv_rdma_ev
      RDMA/rtrs: Update comments for MAX_SESS_QUEUE_DEPTH
      RDMA/rtrs-clt: Break the loop once one path is connected
      RDMA/rtrs-clt: Kill xchg_paths

Hangyu Hua (1):
      RDMA/srpt: Use flex array destination for memcpy()

Jack Wang (1):
      RDMA/rtrs-clt: Output sg index when warning on

Jason Gunthorpe (6):
      IB/mlx5: Call io_stop_wc() after writing to WC MMIO
      net/mlx5: Add IFC bits for mkey ATS
      RDMA/core: Add UVERBS_ATTR_RAW_FD
      RDMA/mlx5: Add support for dmabuf to devx umem
      RDMA/mlx5: Enable ATS support for MRs and umems
      Merge tag 'v6.0' into rdma.git for-next

Leon Romanovsky (1):
      Merge branch 'mlx5-next' into wip/leon-for-next

Li Zhijian (3):
      RDMA/rxe: use %u to print u32 variables
      RDMA/rxe: convert pr_warn to pr_debug
      RDMA/rxe: Add send_common_ack() helper

Luoyouming (1):
      RDMA/hns: Repacing 'dseg_len' by macros in fill_ext_sge_inl_data()

Mark Zhang (7):
      IB/cm: Remove the service_mask parameter from ib_cm_listen()
      IB/cm: remove cm_id_priv->id.service_mask and service_mask parameter of cm_init_listen()
      IB/cm: Refactor cm_insert_listen() and cm_find_listen()
      RDMA/core: Rename rdma_route.num_paths field to num_pri_alt_paths
      RDMA/cma: Multiple path records support with netlink channel
      RDMA/cm: Use SLID in the work completion as the DLID in responder side
      RDMA/cm: Use DLID from inbound/outbound PathRecords as the datapath DLID

Michael Margolin (1):
      RDMA/efa: Support CQ receive entries with source GID

Mikhael Goikhman (1):
      RDMA/srp: Support more than 255 rdma ports

Santosh Pradhan (2):
      RDMA/rtrs-clt: Add event tracing support
      RDMA/rtrs-srv: Add event tracing support

Shang XiaoJing (1):
      IB/hfi1: Use skb_put_data() instead of skb_put/memcpy pair

Shiraz Saleem (1):
      RDMA/irdma: Validate udata inlen and outlen

Sindhu-Devale (1):
      RDMA/irdma: Align AE id codes to correct flush code and event

Tom Talpey (1):
      RDMA/siw: Add missing Kconfig selections

Wenpeng Liang (8):
      RDMA/hns: Remove redundant DFX file and DFX ops structure
      RDMA/hns: Add or remove CQ's restrack attributes
      RDMA/hns: Support CQ's restrack raw ops for hns driver
      RDMA/hns: Support QP's restrack ops for hns driver
      RDMA/hns: Support QP's restrack raw ops for hns driver
      RDMA/hns: Support MR's restrack ops for hns driver
      RDMA/hns: Support MR's restrack raw ops for hns driver
      RDMA/hns: Remove redundant member doorbell_qpn of struct hns_roce_qp

Wolfram Sang (1):
      IB: move from strlcpy with unused retval to strscpy

Xiu Jianfeng (1):
      IB/rdmavt: Add __init/__exit annotations to module init/exit funcs

Yangyang Li (2):
      RDMA/hns: Remove redundant 'num_mtt_segs' and 'max_extend_sg'
      RDMA/hns: Remove redundant 'max_srq_desc_sz' in caps

Yixing Liu (2):
      RDMA/hns: Remove redundant 'attr_mask' in modify_qp_init_to_init()
      RDMA/hns: Replacing magic number with macros in apply_func_caps()

Yunsheng Lin (3):
      RDMA/core: Remove 'device' argument from rdma_build_skb()
      RDMA/hns: Remove redundant 'bt_level' for hem_list_alloc_item()
      RDMA/hns: Remove redundant 'use_lowmem' argument from hns_roce_init_hem_table()

Zeng Heng (1):
      RDMA/usnic: fix set-but-not-unused variable 'flags' warning

Zhu Yanjun (3):
      RDMA/rxe: Fix "kernel NULL pointer dereference" error
      RDMA/rxe: Fix the error caused by qp->sk
      RDMA/rxe: Remove the unused variable obj

wangjianli (2):
      RDMA/hfi1: fix repeated words in comments
      RDMA/qib: fix repeated words in comments

ye xingchen (1):
      RDMA/hfi1: Remove the unneeded result variable

 drivers/block/rnbd/rnbd-srv.c                      |  11 +-
 drivers/infiniband/core/cm.c                       | 104 ++++----
 drivers/infiniband/core/cma.c                      |  88 +++++--
 drivers/infiniband/core/cma_configfs.c             |   2 +-
 drivers/infiniband/core/device.c                   |   4 +-
 drivers/infiniband/core/lag.c                      |   5 +-
 drivers/infiniband/core/sa_query.c                 | 235 +++++++++++------
 drivers/infiniband/core/ucma.c                     |  10 +-
 drivers/infiniband/core/umem_odp.c                 |   2 -
 drivers/infiniband/core/uverbs_cmd.c               |   5 +-
 drivers/infiniband/core/uverbs_ioctl.c             |   8 +
 drivers/infiniband/core/verbs.c                    |   4 +-
 drivers/infiniband/hw/bnxt_re/main.c               |   2 +-
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h    |   6 +-
 drivers/infiniband/hw/efa/efa_com_cmd.c            |   5 +-
 drivers/infiniband/hw/efa/efa_com_cmd.h            |   3 +-
 drivers/infiniband/hw/efa/efa_io_defs.h            | 289 +++++++++++++++++++++
 drivers/infiniband/hw/efa/efa_verbs.c              |  11 +-
 drivers/infiniband/hw/erdma/erdma.h                |   4 +-
 drivers/infiniband/hw/erdma/erdma_cm.c             |   8 -
 drivers/infiniband/hw/erdma/erdma_cmdq.c           |   8 +-
 drivers/infiniband/hw/erdma/erdma_cq.c             |   4 -
 drivers/infiniband/hw/erdma/erdma_eq.c             |  13 +-
 drivers/infiniband/hw/erdma/erdma_hw.h             |  14 +-
 drivers/infiniband/hw/erdma/erdma_main.c           |  17 +-
 drivers/infiniband/hw/erdma/erdma_qp.c             |  15 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c          |  35 ++-
 drivers/infiniband/hw/erdma/erdma_verbs.h          |   9 +-
 drivers/infiniband/hw/hfi1/chip.c                  |   2 +-
 drivers/infiniband/hw/hfi1/file_ops.c              |   2 +-
 drivers/infiniband/hw/hfi1/firmware.c              |   2 +-
 drivers/infiniband/hw/hfi1/ipoib_rx.c              |   5 +-
 drivers/infiniband/hw/hfi1/verbs.c                 |   6 +-
 drivers/infiniband/hw/hfi1/verbs.h                 |   3 -
 drivers/infiniband/hw/hns/Makefile                 |   2 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c            |   6 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        |  25 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c           |  33 +--
 drivers/infiniband/hw/hns/hns_roce_hem.h           |   5 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         | 164 +++++++-----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |  14 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c     |  34 ---
 drivers/infiniband/hw/hns/hns_roce_main.c          |  64 +++--
 drivers/infiniband/hw/hns/hns_roce_mr.c            |   7 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |  19 +-
 drivers/infiniband/hw/hns/hns_roce_restrack.c      | 220 ++++++++++++----
 drivers/infiniband/hw/irdma/defs.h                 |   1 +
 drivers/infiniband/hw/irdma/hw.c                   |  51 ++--
 drivers/infiniband/hw/irdma/type.h                 |   1 +
 drivers/infiniband/hw/irdma/user.h                 |   1 +
 drivers/infiniband/hw/irdma/utils.c                |   3 +
 drivers/infiniband/hw/irdma/verbs.c                |  69 ++++-
 drivers/infiniband/hw/mlx4/mr.c                    |   1 -
 drivers/infiniband/hw/mlx5/devx.c                  |  57 ++--
 drivers/infiniband/hw/mlx5/main.c                  |   6 +-
 drivers/infiniband/hw/mlx5/mem.c                   |   2 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |  36 +++
 drivers/infiniband/hw/mlx5/mr.c                    |   8 +-
 drivers/infiniband/hw/mlx5/odp.c                   |   4 +-
 drivers/infiniband/hw/mthca/mthca_cmd.c            |   2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c           |   2 +-
 drivers/infiniband/hw/qib/qib_iba7322.c            |   2 +-
 drivers/infiniband/hw/qib/qib_pcie.c               |   2 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c           |   3 -
 drivers/infiniband/sw/rdmavt/vt.c                  |   4 +-
 drivers/infiniband/sw/rxe/rxe_icrc.c               |  12 +-
 drivers/infiniband/sw/rxe/rxe_loc.h                |   6 +-
 drivers/infiniband/sw/rxe/rxe_mr.c                 |  22 +-
 drivers/infiniband/sw/rxe/rxe_mw.c                 |   6 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |   1 -
 drivers/infiniband/sw/rxe/rxe_qp.c                 |  61 ++---
 drivers/infiniband/sw/rxe/rxe_queue.c              |  12 +-
 drivers/infiniband/sw/rxe/rxe_recv.c               | 106 ++------
 drivers/infiniband/sw/rxe/rxe_resp.c               |  53 ++--
 drivers/infiniband/sw/rxe/rxe_task.c               |   3 +-
 drivers/infiniband/sw/rxe/rxe_task.h               |   3 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |  19 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h              |   3 -
 drivers/infiniband/sw/siw/Kconfig                  |   5 +-
 drivers/infiniband/sw/siw/siw.h                    |   1 +
 drivers/infiniband/sw/siw/siw_qp.c                 |   2 +-
 drivers/infiniband/sw/siw/siw_qp_rx.c              |  27 +-
 drivers/infiniband/sw/siw/siw_verbs.c              |   3 +
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |   4 +-
 drivers/infiniband/ulp/ipoib/ipoib_ethtool.c       |   4 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |   2 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c |   4 +-
 drivers/infiniband/ulp/rtrs/Makefile               |  10 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-trace.c       |  15 ++
 drivers/infiniband/ulp/rtrs/rtrs-clt-trace.h       |  86 ++++++
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |  26 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h             |   7 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-trace.c       |  16 ++
 drivers/infiniband/ulp/rtrs/rtrs-srv-trace.h       |  88 +++++++
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             |  12 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.h             |   5 +
 drivers/infiniband/ulp/rtrs/rtrs.c                 |   2 +-
 drivers/infiniband/ulp/rtrs/rtrs.h                 |   3 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |  66 ++---
 drivers/infiniband/ulp/srp/ib_srp.h                |   3 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |   6 +-
 include/linux/mlx5/mlx5_ifc.h                      |  11 +-
 include/rdma/ib_cm.h                               |  10 +-
 include/rdma/ib_sa.h                               |   3 +-
 include/rdma/rdma_cm.h                             |  13 +-
 include/rdma/rdma_vt.h                             |   2 +-
 include/rdma/uverbs_ioctl.h                        |  13 +
 include/uapi/rdma/efa-abi.h                        |   4 +-
 include/uapi/rdma/mlx5-abi.h                       |   1 +
 include/uapi/rdma/mlx5_user_ioctl_cmds.h           |   1 +
 include/uapi/rdma/rdma_user_rxe.h                  |   4 +-
 111 files changed, 1693 insertions(+), 862 deletions(-)
(diffstat from tag for-linus-merged)

--DMTgkBMpz+FHi6/l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCYz9epgAKCRCFwuHvBreF
YcKjAQDyt7wrt7Sd0x+ZmbLn6+kX6RCOgX8bwORY6xjPksULPwD+N705y7jmVvr+
V2C7rpYPNPwvgEz0wKB4zAJSGhAYegA=
=V8KJ
-----END PGP SIGNATURE-----

--DMTgkBMpz+FHi6/l--
