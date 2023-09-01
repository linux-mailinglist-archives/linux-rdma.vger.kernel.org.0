Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC6678F662
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Sep 2023 02:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347803AbjIAAam (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Aug 2023 20:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345909AbjIAAam (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Aug 2023 20:30:42 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918D6E4C;
        Thu, 31 Aug 2023 17:30:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6Y2IxjLHKKyKTV8V+f7ANYJMh9OfuEJcl7eS7cbCm3MaM31ApnRTfSmAbpiDSb/wqS1umD939amLKejE0+SpbA3NKs6qEedKWyIG3irIk7hqJI0KM4G+7HT5s+Ur4VLY0C2YQ7G+uK8qJZ8WeFL+7sQQTpFFxpTNPl1orVSwEXHX3ravHVnXazdPx5wDg1dHsh9WN+lNf49w2f7bj20RYx90KqQNKybmRf1P9k0yz9frkyV9KNYlZSfDvu1EfchPyEPBE5hqa9KtFXv4Y12m4vg22tIh1L81tBGu6fcVzw5yVWmZkMxYCt9hqUEvmCxQkrcN4DJSqdkk9a7h9C4Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FO9CpddBM15U/jbJGO3B0nJk7+C8lb/K23sNjyojbE=;
 b=aWNbfoUCighbIG0ktuTOWO+44G53lCia8X1/cffjmu1j1Q+bcdg9RAYE1nuf9PZUTAsyK5NYmj6CgBy9Z9rnqWbBPET4TZqTt3TPKCtP4JQwht1Z3rOGiOtlzA4lfTEVGx+6MpWHD9fqZ6UPyhl+kKdoTxAnSMuswDU2edeUsZM8tBBBA4n7cwzAVsCKm9vhsBehIAR89uFChapkH6IOBMfsQjv3Kh00WDsCztT8GNDmDx9BEIdlkOGx3ef8R9SVqXqSUBHobIitJM1LuxVWcTBuUYlCA/DY1TW3kojJt/yL2MgDLhR8hcHjIdJElCBKPBzP/s3HM9EBx/b5X1CxRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FO9CpddBM15U/jbJGO3B0nJk7+C8lb/K23sNjyojbE=;
 b=gpJDCzJM+2H+qSrqic38lZF+GZ7/ZGgD2lhJfb0b3eJpvoT6Qi+l2kz1zEs5bKAprx+iSl3eEfvRCV9f9pB8h41/OalHlMOpC9DtwXscho+n5wKLDUKs1OlHUxPsv3oxBd0iFJBMU150/QYZW1VWA4MZLSlDVsx+8Tae35x1+rrU4joY3iMgMy8/7074eyGmaMXJzXbpk75ZNv8qbS/ri6J4sBEz5EY0AhhsTZ2KOe+9vxxW0IB4/lPxph4zXb3De0FKJIg6rKBRgNVMV1itLctWBsypQCMVdMKliCiuWC+WIT5Gq7FZTjV/VKpE7e3GP2eqe5iEhcAZd5IEHxsWNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7220.namprd12.prod.outlook.com (2603:10b6:930:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Fri, 1 Sep
 2023 00:30:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6745.020; Fri, 1 Sep 2023
 00:30:35 +0000
Date:   Thu, 31 Aug 2023 21:30:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20230901003031.GA111366@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0gFKhkG7Qdxjxn3h"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a82fcc-9d82-4371-20f1-08dbaa82a843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: prUg7Kg+KP2LC9U/6Zfy9OGVj2RSiE8hclizlrfrw5V4Amy4oPUjjVbRifvTWLxhAjRagHShS81f9XKigw24TvzZXTfEDLmAzG2AKcmIPc4/S4vEMKDxiP2LRCjkBtQCQ22dqQnyWi5PyWg9W0CkmTjiI0P982gbhEfsC/ADdddQmr/8JcIW1d0KxUCQw7UEUbRm8cjYMj27PeCO8lGvg9ZOy0JCZ/lK1Jx/PbS/mm6bn5/KVqwnjgAxWKN4A5DjR6Qa6JFSJa5oyEX4W/pY3guljWCyCaSh6Izrh0JQ9ABLycG7LqpnI2YBdGdHORiduZSln+40Qvghn5fXNqHY0rYoOqtESVjj6ebdMZo31UhqKm9mfp/UKHf6uYUNTrtoNR9ZGh4u22xogNK0h8bLAG2WWQ1CbI/cedd7vxB8xb6RDojKoMKmij7ntK7IkrdxjraBBcQeVqi1fZSqIretmtKYf0ueh/hQrIXgzyIhu4Tm9xWLShV9NzWwMzFgKDCw0JMXoRa/wtCwuYBS0GuKECPBtEZqlBx7omoFuYpmr3v0NdG2eXm31d7Wn1F3HsX3VVeHgmkqCfCW12d2CKOTgpEskKusTsPyk4VcSrwF9b/moOWzwMLBRqrPem4DjjHfKTjYdlqFkNVLqWLQV3LqIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199024)(1800799009)(186009)(30864003)(6666004)(2906002)(5660300002)(86362001)(316002)(21480400003)(6916009)(478600001)(6506007)(2616005)(107886003)(4326008)(6486002)(8676002)(44144004)(6512007)(8936002)(33656002)(38100700002)(1076003)(26005)(41300700001)(66899024)(36756003)(83380400001)(66946007)(66556008)(66476007)(27376004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gDgmaNsCz+kme691UP/Z6oP7hHBBF5Qo9flswByuTgwVJTRkjfiG4SV7m6xd?=
 =?us-ascii?Q?dYMFnoZ2RhNpZWBWvIn7YkWqgDcaFZl+RHTEMdsMD7e9Yijy67gEmDp4kqph?=
 =?us-ascii?Q?OurmGS67RMG0Tp0x+DgBjhwCcmJr8ZeAeTZ6hAC7qaqauvBHQ2O+PoJdR99y?=
 =?us-ascii?Q?eMCaWtmVdXgQgHf6+Yvjs2Bkyz25zaeUb4dFc2yqcogUXRDQKZfrYIR3jlwf?=
 =?us-ascii?Q?6TOcPuMkkP57m4Uqdki7p1XLK4e4jKnEtjOM/WVzrOb+WfOzGnUQdeUVtqWy?=
 =?us-ascii?Q?MJAvEg0PAgtjnYhbbP7xQZd2nbvr2EDtD6UUVVKhDFwOCaXvewOk+6QxaoVw?=
 =?us-ascii?Q?uRqSMqBDzM+uzGiOoHyfUP/dP1AutKDFJcGO5Ouu/w883rMWT529r+nUNXxt?=
 =?us-ascii?Q?C22IHcUyrilvB1+ZSGe0VUUbxii/B8qoBhj9KcQqwv7k8vBLRFoiUEOScaIq?=
 =?us-ascii?Q?kMmkRoOJefgJszYl56MPWQxxijweYsPM3NPNr83qvD4/i6xZZ2Ml0Y3D465g?=
 =?us-ascii?Q?aVlv3eso6umelXjlxSw/RbMcxif52qONKtndEJS3h41u9D/a0tsqiSetsWhS?=
 =?us-ascii?Q?aPygzcBuuKeBdpS4/8aymitMt8XSHl+oK7EBNn+vHAfmhsFkSkrsxra432hF?=
 =?us-ascii?Q?muUkA/OTzj+uBgoqcC9os9Gq05mh+WGQ+j4SSkCZi29f02kBltgWCeSJh01N?=
 =?us-ascii?Q?+Qc5fCiSYULBhG6z8iah0CpSMJsd2rCIMaLUc3D4htXCdsk6JsM9ZvMltRLK?=
 =?us-ascii?Q?zeAjSFxWcs5pozBPBkml4BRKzlflr/ykBMmQ+Fg1stW5M7wFC/zS3/WnYnyC?=
 =?us-ascii?Q?S7sDwffKNF3UhD8eJMxdO1+4Fulsr09fMreQ7cPCy3YfA6QbtV8qWyTzQllZ?=
 =?us-ascii?Q?WrLpA1uZBG5jb2VjzSPdZmfUv8nS5pqbzVCqVJiqiH5lijfVnuMcFj7RseGH?=
 =?us-ascii?Q?pk9WUm2c83AVbYCDDYtHPjm/2j3XN33ISYQT1RY1DtrdYwzBsagQeD6MGMxb?=
 =?us-ascii?Q?Y3PYQMssOV2ywie0uN5RhKM2jWo1mjs2m0bcEepr9lgu8HlefQdBKN+1K3Ub?=
 =?us-ascii?Q?awTzVZzNUzSalmhsD0L/ys5/Deq1pzFqMKq3vrsaiUN2Y65+F4Ap984rJyWX?=
 =?us-ascii?Q?FUkokuaCrngpMYPs8smQ/f6b8aY2TA4paA+LuASVfD4lN1wcif/d57QcnVxW?=
 =?us-ascii?Q?quJiux4K8exOU9AGrKpHlBlxevfIeR9tVDVWd3YKkuv3hAtHZm0ddHb7W2XL?=
 =?us-ascii?Q?pGthct7ORDv9NgCuiJLTYZ16Rl82H1vd5ydbmvOoRHzQRrEfW7aq/PPDLbNS?=
 =?us-ascii?Q?1IeF/w9qqRu7W5ARlS2a5xxIK7OfOgoILEzHKF7VntAmeGr5kXJSThE3COAs?=
 =?us-ascii?Q?ICkpWG9PEPH1TwgJRzOki6CwI73cw4MBCDymEHrkePKxu9a3PMyCJ3Vlw+4F?=
 =?us-ascii?Q?cjPJuhVP5Bbcpc8Mk9eyAkYv77YYXuRueV83Z9Rr052rsm+gzWSeYkFruW1n?=
 =?us-ascii?Q?3wj0keSk5tz36ajVt1TYAUWZLVmL++A1LvoldSrRuDvYVtoOGDUIQC5uOt3B?=
 =?us-ascii?Q?8u1WQH9lxY+lk9pn1I6Jkw7Kba1wfXXSnKtSvYVq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a82fcc-9d82-4371-20f1-08dbaa82a843
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 00:30:35.1706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBA1stTMIaNChYZlO1Q8Kb2fyNaTwewK37YptDnND6d3ss8Ylcx3Ad9hoMRsyIlP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7220
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0gFKhkG7Qdxjxn3h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Not a big cylce this time, lots of scattered changes.

Thanks,
Jason

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to f5acc36b0714b7b8510a8b436087d33a65cb05f4:

  IB/hfi1: Reduce printing of errors during driver shut down (2023-08-22 17:31:45 +0300)

----------------------------------------------------------------
v6.6 merge window RDMA pull request

Many small changes across the subystem, some highlights:

- Usual driver cleanups in qedr, siw, erdma, hfi1, mlx4/5, irdma, mthca,
  hns, and bnxt_re

- siw now works over tunnel and other netdevs with a MAC address by
  removing assumptions about a MAC/GID from the connection manager

- "Doorbell Pacing" for bnxt_re - this is a best effort scheme to allow
  userspace to slow down the doorbell rings if the HW gets full

- irdma egress VLAN priority, better QP/WQ sizing

- rxe bug fixes in queue draining and srq resizing

- Support more ethernet speed options in the core layer

- DMABUF support for bnxt_re

- Multi-stage MTT support for erdma to allow much bigger MR registrations

- A irdma fix with a CVE that came in too late to go to -rc, missing
  bounds checking for 0 length MRs

----------------------------------------------------------------
Arnd Bergmann (1):
      RDMA/irdma: Fix building without IPv6

Bernard Metzler (1):
      RDMA/siw: Fix tx thread initialization.

Bob Pearson (4):
      RDMA/rxe: Move work queue code to subroutines
      RDMA/rxe: Fix unsafe drain work queue code
      RDMA/rxe: Fix rxe_modify_srq
      RDMA/rxe: Fix incomplete state save in rxe_requester

Brendan Cunningham (1):
      RDMA/hfi1: Move user SDMA system memory pinning code to its own file

Chandramohan Akula (11):
      bnxt_en: Update HW interface headers
      bnxt_en: Share the bar0 address with the RoCE driver
      RDMA/bnxt_re: Initialize Doorbell pacing feature
      RDMA/bnxt_re: Enable pacing support for the user apps
      RDMA/bnxt_re: Update alloc_page uapi for pacing
      RDMA/bnxt_re: Implement doorbell pacing algorithm
      RDMA/bnxt_re: Add a new uapi for driver notification
      bnxt_re: Reorganize the resource stats
      bnxt_re: Update the hw counters for resource stats
      bnxt_re: Expose the missing hw counters
      bnxt_re: Update the debug counters for doorbell pacing

Cheng Xu (3):
      RDMA/erdma: Renaming variable names and field names of struct erdma_mem
      RDMA/erdma: Refactor the storage structure of MTT entries
      RDMA/erdma: Implement hierarchical MTT

Chengchang Tang (4):
      RDMA/hns: Fix port active speed
      RDMA/hns: Fix CQ and QP cache affinity
      RDMA/hns: Dump whole QP/CQ/MR resource in raw
      RDMA/hns: Support hns HW stats

Christophe JAILLET (1):
      IB/hfi1: Use struct_size()

Christopher Bednarz (1):
      RDMA/irdma: Prevent zero-length STAG registration

Chuck Lever (4):
      RDMA/siw: Fabricate a GID on tun and loopback devices
      RDMA/core: Set gid_attr.ndev for iWARP devices
      RDMA/cma: Deduplicate error flow in cma_validate_port()
      RDMA/cma: Avoid GID lookups on iWARP devices

Douglas Miller (1):
      IB/hfi1: Reduce printing of errors during driver shut down

Guoqing Jiang (4):
      RDMA/cxgb4: Set sq_sig_type correctly
      RDMA/siw: Balance the reference of cep->kref in the error path
      RDMA/siw: Correct wrong debug message
      RDMA/siw: Call llist_reverse_order in siw_run_sq

Gustavo A. R. Silva (2):
      RDMA/irdma: Replace one-element array with flexible-array member
      RDMA/mlx4: Copy union directly

Haoyue Xu (1):
      RDMA/core: Get IB width and speed from netdev

Ivan Orlov (1):
      RDMA: Make all 'class' structures const

Jinjie Ruan (1):
      RDMA/hfi1: Use list_for_each_entry() helper

Julia Lawall (3):
      RDMA/erdma: use vmalloc_array and vcalloc
      RDMA/siw: use vmalloc_array and vcalloc
      RDMA/bnxt_re: use vmalloc_array and vcalloc

Junxian Huang (3):
      RDMA/hns: Remove VF extend configuration
      RDMA/hns: Fix incorrect post-send with direct wqe of wr-list
      RDMA/hns: Fix inaccurate error label name in init instance

Kalesh AP (6):
      RDMA/bnxt_re: Fix max_qp count for virtual functions
      RDMA/bnxt_re: Remove a redundant flag
      RDMA/bnxt_re: Cleanup bnxt_re_process_raw_qp_pkt_rx() function
      RDMA/bnxt_re: Avoid unnecessary memset
      RDMA/bnxt_re: Remove unnecessary variable initializations
      IB/core: Add more speed parsing in ib_get_width_and_speed()

Kashyap Desai (1):
      RDMA/bnxt_re: Initialize mutex dbq_lock

Krzysztof Czurylo (1):
      RDMA/irdma: Add table based lookup for CQ pointer during an event

Leon Romanovsky (3):
      RDMA/irdma: Add missing kernel-doc in irdma_setup_umode_qp()
      RDMA/bnxt_re: Fix kernel doc errors
      Revert "IB/isert: Fix incorrect release of isert connection"

Luoyouming (1):
      RDMA/hns: Support get XRCD number from firmware

Michael Margolin (1):
      RDMA/efa: Add RDMA write HW statistics counters

Minjie Du (3):
      RDMA/qedr: Remove a duplicate assignment in irdma_query_ah()
      RDMA/qedr: Remove a duplicate assignment in qedr_create_gsi_qp()
      RDMA/qedr: Remove duplicate assignments of va

Mustafa Ismail (2):
      RDMA/irdma: Implement egress VLAN priority
      RDMA/irdma: Cleanup and rename irdma_netdev_vlan_ipv6()

Rohit Chavan (2):
      RDMA/rxe: Fix redundant break statement in switch-case.
      RDMA/mlx5: Fix trailing */ formatting in block comment

Ruan Jinjie (4):
      RDMA/mlx: Remove unnecessary variable initializations
      RDMA/mthca: Remove unnecessary NULL assignments
      RDMA: Remove unnecessary ternary operators
      RDMA: Remove unnecessary NULL values

Saravanan Vajravel (1):
      RDMA/bnxt_re: Add support for dmabuf pinned memory regions

Selvin Xavier (2):
      RDMA/bnxt_re: Fix the sideband buffer size handling for FW commands
      RDMA/bnxt_re: Protect the PD table bitmap

Shetu Ayalew (1):
      IB/mlx5: Add HW counter called rx_dct_connect

Shiraz Saleem (1):
      RDMA/irdma: Drop unused kernel push code

Sindhu Devale (4):
      RDMA/irdma: Drop a local in irdma_sc_get_next_aeqe
      RDMA/irdma: Refactor error handling in create CQP
      RDMA/irdma: Allow accurate reporting on QP max send/recv WR
      RDMA/irdma: Use HW specific minimum WQ size

Xiang Yang (1):
      IB/uverbs: Fix an potential error pointer dereference

Yang Li (1):
      RDMA/irdma: Fix one kernel-doc comment

Yonatan Nachum (1):
      RDMA/efa: Fix wrong resources deallocation order

Yuanyuan Zhong (1):
      RDMA/mlx5: align MR mem allocation size to power-of-two

Yue Haibing (3):
      RDMA/hns: Remove unused function declarations
      RDMA/hns: Remove unused declaration hns_roce_modify_srq()
      RDMA Remove unused function declarations

 drivers/infiniband/core/cache.c                    |  11 +
 drivers/infiniband/core/cma.c                      |  32 +-
 drivers/infiniband/core/iwpm_util.c                |   2 +-
 drivers/infiniband/core/netlink.c                  |   2 +-
 drivers/infiniband/core/uverbs_main.c              |  35 +-
 .../infiniband/core/uverbs_std_types_counters.c    |   2 +
 drivers/infiniband/core/verbs.c                    | 109 ++++-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h            |  35 +-
 drivers/infiniband/hw/bnxt_re/hw_counters.c        |  84 +++-
 drivers/infiniband/hw/bnxt_re/hw_counters.h        |  55 +++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           | 255 +++++++----
 drivers/infiniband/hw/bnxt_re/ib_verbs.h           |   6 +
 drivers/infiniband/hw/bnxt_re/main.c               | 277 ++++++++++--
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  47 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |  66 +--
 drivers/infiniband/hw/bnxt_re/qplib_res.c          |  38 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h          |  23 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |  85 ++--
 drivers/infiniband/hw/bnxt_re/qplib_sp.h           |   2 +-
 drivers/infiniband/hw/cxgb4/qp.c                   |   2 +-
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h    |  13 +
 drivers/infiniband/hw/efa/efa_com_cmd.c            |   8 +-
 drivers/infiniband/hw/efa/efa_com_cmd.h            |  10 +-
 drivers/infiniband/hw/efa/efa_verbs.c              |  24 +-
 drivers/infiniband/hw/erdma/erdma_hw.h             |  18 +-
 drivers/infiniband/hw/erdma/erdma_qp.c             |   2 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c          | 434 ++++++++++++++-----
 drivers/infiniband/hw/erdma/erdma_verbs.h          |  36 +-
 drivers/infiniband/hw/hfi1/Makefile                |   1 +
 drivers/infiniband/hw/hfi1/affinity.c              |   4 +-
 drivers/infiniband/hw/hfi1/chip.c                  |   8 +-
 drivers/infiniband/hw/hfi1/device.c                |  72 ++--
 drivers/infiniband/hw/hfi1/hfi.h                   |   4 +-
 drivers/infiniband/hw/hfi1/pin_system.c            | 474 +++++++++++++++++++++
 drivers/infiniband/hw/hfi1/pinning.h               |  20 +
 drivers/infiniband/hw/hfi1/pio.c                   |   9 +-
 drivers/infiniband/hw/hfi1/user_sdma.c             | 441 +------------------
 drivers/infiniband/hw/hfi1/user_sdma.h             |  17 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        |  35 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c           |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         | 151 +++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |  14 +-
 drivers/infiniband/hw/hns/hns_roce_main.c          |  86 +++-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |  28 +-
 drivers/infiniband/hw/hns/hns_roce_restrack.c      |  75 +---
 drivers/infiniband/hw/irdma/cm.c                   |  90 +++-
 drivers/infiniband/hw/irdma/ctrl.c                 |  23 +-
 drivers/infiniband/hw/irdma/hw.c                   |  63 ++-
 drivers/infiniband/hw/irdma/i40iw_hw.c             |   1 +
 drivers/infiniband/hw/irdma/i40iw_hw.h             |   2 +-
 drivers/infiniband/hw/irdma/icrdma_hw.c            |   1 +
 drivers/infiniband/hw/irdma/icrdma_hw.h            |   1 +
 drivers/infiniband/hw/irdma/irdma.h                |   1 +
 drivers/infiniband/hw/irdma/main.h                 |   8 +-
 drivers/infiniband/hw/irdma/type.h                 |   3 +-
 drivers/infiniband/hw/irdma/uk.c                   | 218 +++++-----
 drivers/infiniband/hw/irdma/user.h                 |  19 +-
 drivers/infiniband/hw/irdma/utils.c                |  25 ++
 drivers/infiniband/hw/irdma/verbs.c                | 259 +++++++----
 drivers/infiniband/hw/irdma/verbs.h                |   5 +-
 drivers/infiniband/hw/mlx4/main.c                  |  47 +-
 drivers/infiniband/hw/mlx5/counters.c              |   2 +
 drivers/infiniband/hw/mlx5/mad.c                   |  40 +-
 drivers/infiniband/hw/mlx5/mr.c                    |   8 +-
 drivers/infiniband/hw/mthca/mthca_provider.c       |  20 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |   2 +-
 drivers/infiniband/hw/qedr/qedr_roce_cm.c          |   1 -
 drivers/infiniband/hw/qedr/verbs.c                 |   2 +-
 drivers/infiniband/hw/qib/qib_file_ops.c           |  17 +-
 drivers/infiniband/sw/rxe/rxe_comp.c               |   4 +
 drivers/infiniband/sw/rxe/rxe_loc.h                |   6 -
 drivers/infiniband/sw/rxe/rxe_qp.c                 | 159 ++++---
 drivers/infiniband/sw/rxe/rxe_req.c                |  45 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |   4 +
 drivers/infiniband/sw/rxe/rxe_srq.c                |  60 +--
 drivers/infiniband/sw/rxe/rxe_verbs.c              |   1 -
 drivers/infiniband/sw/siw/siw.h                    |   4 +-
 drivers/infiniband/sw/siw/siw_cm.c                 |   1 -
 drivers/infiniband/sw/siw/siw_main.c               |  62 +--
 drivers/infiniband/sw/siw/siw_qp.c                 |   4 +-
 drivers/infiniband/sw/siw/siw_qp_tx.c              |  52 ++-
 drivers/infiniband/sw/siw/siw_verbs.c              |  12 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |   2 +
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |  19 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c       |   2 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             |  15 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.h             |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h      |  54 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h      |   1 +
 include/rdma/ib_verbs.h                            |   2 -
 include/rdma/iw_cm.h                               |  21 -
 include/uapi/rdma/bnxt_re-abi.h                    |   7 +
 include/uapi/rdma/irdma-abi.h                      |   9 +
 94 files changed, 2892 insertions(+), 1670 deletions(-)
 create mode 100644 drivers/infiniband/hw/hfi1/pin_system.c
 create mode 100644 drivers/infiniband/hw/hfi1/pinning.h

--0gFKhkG7Qdxjxn3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZPEwpgAKCRCFwuHvBreF
YZDwAQDW39VIEWoIhAvQfl6N1+njPtwrUwOQTzuW+hC8ZTVpgwD/ZbG0EBzPpnPY
AajyKafAPYkxn1er1ZQaN3KrHVUjOg8=
=teFN
-----END PGP SIGNATURE-----

--0gFKhkG7Qdxjxn3h--
