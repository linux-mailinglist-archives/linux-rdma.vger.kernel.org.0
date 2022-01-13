Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8E748DDE2
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jan 2022 19:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbiAMSxR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jan 2022 13:53:17 -0500
Received: from mail-dm6nam08on2043.outbound.protection.outlook.com ([40.107.102.43]:13153
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237659AbiAMSxR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 Jan 2022 13:53:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnqT7Qfc1PHibLr3TIWJ62CHd60coFXiYVf1OMMGyrn38ASKqAfhoczCWBk81V3JhALSTfgcZeZ0eRRNuaqiTLAlIpxYpHivYQzn9VTp34I0RafTcZYpNAF5/oZuGftHTUhXtxfHu7VLhLSjoHg3FRSYKO2bnie8Rvb049lltPcoy6Z5MSDFAAyMgA4p0zeuZLPpUMfJ8XGdPxHpVpPPlYvA5RzrTiWjwi3A8OmCKn1gFooKuQggKUanE3wuNIftsZE78pCamF1AXjzwz6bBqNz+vtpSUt7wcNOOUdTm5+wwmzLBlm7XxKhVTPh14oNuD+Q/G1iEg76N+dvB5W+Cag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZuNF26Y/1d79AWg7OiSwezxDnUiLdiZ7+ttbLm3jZo=;
 b=QGYX9aoAYmIEEjWK/CUXOhdAbIv8Y5B+kZxG7RXd7A+E5s2rAqo3Mzm/AYXcrO70z10jEZb3a58AFsvflplp1emK2DTCVNTAJDmN48Z0MDbxpbjMMFYu6v9m6AkHwi9s+aUszzEPpLSW2cpnQ79JOsuRqqK6lEptin213st7ncGUDoXH5PAaB64X1jo5bDCsB6n5j69tqib9QvfMgaJJlzxqvc7k6L9PJYO0gFHKs484RrJwionK/cvKnL+J3xOLD4G/XJbbQOe8NnWz/4ASzQimWLlUSoacuEck9aEI40eOmZ4og61mwzW/GVbgBAAHnzuM7YTDqWuNbkdYywSDPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZuNF26Y/1d79AWg7OiSwezxDnUiLdiZ7+ttbLm3jZo=;
 b=jocokl70THE+cAFGfeX6GravERVnCc4xUKf7w/daFg5ZREbHjxMrsxqqHHkmK+mCi4VaJy7bUQ/x+R8y0gJtLqARGhytTVlnbiXBgxHKbvAl26r/UMbwY/HVddSY4QQIczu9hjQ/SCQHmdYKXUGPVrdlPSUu+Iy5ZSuk+DSXhKI7JDERxbjBUKfgHEWldujVQ45A2y2mANDxDX6q48NJlOIeB5pdNZ3Puex6HBvQ0j8o1FOx51vp2QlRFu/yECY49v1iVVzSU78MuD53kgbmwZGRNI5Pm76xIRTNjGW484cKOY5yEzrcfbWp8hz7dStVT6mx6s5qL7Mk7aX+J/2dHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BN8PR12MB3572.namprd12.prod.outlook.com (2603:10b6:408:47::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 18:53:11 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%8]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 18:53:11 +0000
Date:   Thu, 13 Jan 2022 14:53:10 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20220113185310.GA3791344@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
X-ClientProxiedBy: BLAPR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:208:32d::6) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fd0ebf9-ceb1-48f0-7ff4-08d9d6c5f238
X-MS-TrafficTypeDiagnostic: BN8PR12MB3572:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3572E90C7DBFE29D92CA90EFC2539@BN8PR12MB3572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7mke5N/WUvG4tGfS1w+B5T8x9prRxDchRc7bc2lwR2nU00akyX6fBSPkmWvagzJJeGTbD5G3gb4XS/P/spaZFCSVHGp5jFkvwSzh00wMZXlgGcfn5xqc3sZ9P+J2NcegUYF449DaJ8QDZFmcbZ9PzjVxzbH3fm3OEmhO91A8IPvGuwN5llSk4wDIppaBppoYcIk3EDGW+8TgvkF8pc6XyR5fjtIhM8VZXe6b5OE2jCDCZ8BXjfXCrxlL/tdneKLis7rkD8mx0bEwHMUqkBmrxwpQsJZqW00N1ePZW5VqlFGo6eJSfnTdUUT801rkSGbFlc8yGeu1yRshov/EfAGH/9rcvEaprxgxJNIRzmpI1N1lOQm/0pXB/48T4nUSFuz/BeommFryAhWuSB79cfdOqAaEnm+aRJtSqomcNM4dsq9pq+lFZZDQ6U8H1rrJ3Kt4rKI1f+u18lddn2bZx9oamSV4qbjVLZFj104eVDnYRhKAK0q0Mh+hHmtZNGY5maszGyHA/L95YaVkG3ahHE4VDetmxkw2je8yePBAYIvObHCTrz/JrIVO/+yMjOwSfzxynecZoKpFjmmuUo84dN8CDPuGgXrZS8bHis/p38OF0KVVar9+/wWZxcm4Xq7UXKTO6qULz/+JZ0H9VFmwa2NO7ZRMehFU6qE+8ADyvBwU+fPiIeV5giZmJ2TtbFs8RnBa+bCdJsfmvxH/VCLg9VWjrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(6916009)(86362001)(6506007)(83380400001)(44144004)(5660300002)(30864003)(8676002)(33964004)(26005)(66946007)(66556008)(66476007)(2906002)(36756003)(66574015)(8936002)(186003)(33656002)(4326008)(6512007)(316002)(508600001)(21480400003)(1076003)(6486002)(2616005)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1hsYk9oVnZiZFpLYUJtc1BJeHRxWjhEcENVL3dqakVYbE5DR3BCOWE0UWhk?=
 =?utf-8?B?bFJDbE1PYTEyOXNhcm10em9hZlA1KzJqNHFKQ004YjdFaVc4ejEzWFkxRFdL?=
 =?utf-8?B?VmNhZVVRVFVWb09yZGZYYnJuUzNGVnNRZ2tjSTBaMHFiODQ0c0N3enBZd0h2?=
 =?utf-8?B?VUZUU3ZOb1FsdGZ6RkNVdktFVThoem5TcmNnOE1hMUdYTUpQVnhZSS9hL1NC?=
 =?utf-8?B?RTU1alFzNlNzWlFFVU9mZVJ1OTgrUnlCUnNzN3hXN2llTm16T0FjamFVY3Rh?=
 =?utf-8?B?Q1AzWjFnOElyR2FvcUNhRG5jbFNoeXpYMzF3OEZCSzNIUE9JNWFCU0ttZmVs?=
 =?utf-8?B?TVJheHdlMk80bVNrRGIxVlZlV3ZGNzQ0a3BUY3pHb1JLOUpVb1RhUDFSQ1dZ?=
 =?utf-8?B?WjFVWmw5MEZheHlka0lpR2trcllCZ29oTWNReDJ3NnAyck9iRSs4aFNOWGxX?=
 =?utf-8?B?b0h1Mm5WcUpqV1JPNmtVVC8xbS9Sa25sTzhQTWdXMXZJQ2p5bGFFMHJxUi9t?=
 =?utf-8?B?ZVp2V3JaRmJCemdveTNmZjhnTk9CK1hGbzV3bDErcm9QT05hOUhkNk9RNlNz?=
 =?utf-8?B?SE5ZYzk5MzBtNWI5T3pnRU1LQ3NyNUtVVGFLSUhQRzh4MTMwdGhoR3pHU1h0?=
 =?utf-8?B?QTlVNytmR2NEU2ZPNmxOZGJTblBFTUJubXhnbldQbTRoY1QxZnRoNThRakdI?=
 =?utf-8?B?aUthNFloallha0dLNmdjWVBCdk9lbFNJYlFDTGlSUlhoWG5URnE0Zll2VFR2?=
 =?utf-8?B?MHM2bjRpdEVqcGhPNDlHNmRXQTNjQTJOL2RMRUoxS21uMm1NNWp2UGR0R05E?=
 =?utf-8?B?Q1JFMy83ZFRTeFAvcGJHTmovZUxMMG9sZi9NMTJMRlRHK2pSbjNYNFQrTFZ0?=
 =?utf-8?B?aFlQV0FiZXFpTTE5SnlDdHZ4Z0U1L0FuaDlFVmNoZGN0dGhoSTRUTU1iVkp6?=
 =?utf-8?B?NTFNU3pIL09LRXo3TVppdWRwMm12RXdDZnFXTlk2M2N0aVlMdGpabU9GMk5D?=
 =?utf-8?B?ZlRFdWpxUmJmOHFHYlpIWVZ6azhMWWNRQlV0SjZzdEJVTXUrZmpnQkExS2JP?=
 =?utf-8?B?UXcrRFJrZzRLY3k1azFJSTQ2Q3RVWlExT1RORWcra0NYODU0eHZHbnlaS0NF?=
 =?utf-8?B?V0J5dmY4YmJJODcwYXFrWUo1LzE4ZkJJbDdLZ1ViaElxN3E3RWZ4a0ZEV1k5?=
 =?utf-8?B?ejBzWFQwT3NYeGJhMjYzMlZPUCs3Z0hyWDhvQ09KM3lRemJ4dnNyT3VqV3h3?=
 =?utf-8?B?YU82WWVia3hRQ3Y1a1dTeUlZSW1QaFQvMmNTYmJ6MklXTDVHUXA5MXdZQ0pY?=
 =?utf-8?B?N1dNZ2NVLzM0Ty9yUWdqVmhPNWRPd28yRnk0NldmYXFYcTd5d1lVS1BaZjFa?=
 =?utf-8?B?ZGI0VWhTWHZrTEZ6TWs3SUtxR01mSjBWKzhLRHNiZXNyWm4xd2orTGtQY0VZ?=
 =?utf-8?B?ZkkvZTJRYUNNM3NRZzhaM0VKSUlNYjY4a0R1NEtLZG12cTNLL3FvYnFoelUz?=
 =?utf-8?B?OE4xV3NaT2xDcXJmb0VSODdsZmUrUnlmZHJmVklsSEJDWS9KSlRKakRUc291?=
 =?utf-8?B?ZGNBcVJDVllEZDFBYmRlN3dxYWowMkpIVHlFN3V1QmM2emRkTFdVNm9ZY3Rt?=
 =?utf-8?B?TXZSY082Q3BtUHFBcWVzRmZrWVRPVmxLSzg5WXVLU3ZkWk9WQ05kWHlmRTgr?=
 =?utf-8?B?N1BwdHdONEpidW5VWGpWam9BcE13S0dkZjREN25TK0VjWk1JRlltcnhJMUZR?=
 =?utf-8?B?S0s4LzFkd1JBM1VYVUVNZjRpY1llWXhVY0dpbUhMMUpIZnFVNUx1enlZSSt1?=
 =?utf-8?B?czJ0TVdjVE5MZjZFd0FGNDNsbGFKcGdYUjB3NHVzTlVocjM4UzRPajhhOXJM?=
 =?utf-8?B?dTZXSXFUejhDQmdaeVdHVlkxVm9ubERZVWE2WXBHa1p1VllNY3FudHdDd0dP?=
 =?utf-8?B?RjRRQS9sNk44SmtQK1Nhb3hZQnM0d25MS3RvcjZ1alVTT2JrZTJmVk5Ka3V6?=
 =?utf-8?B?bSsrd0JzYVF1R281djgwNkhRRmlET2RyZk9KN3A0NWlBK2pFcEkrNnhPd0dY?=
 =?utf-8?B?YUdvdFJ3cWpCNitGZHpPZlBXTzJnU01hWmVEbFlWbzJscEsrWkZVdGlLenVY?=
 =?utf-8?Q?auNA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd0ebf9-ceb1-48f0-7ff4-08d9d6c5f238
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 18:53:11.2356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VixtE40x9m3M4GIthEJyYt0+N8pPqXoxuuIfxemkzT1QDINv5zlCzuH6fGGf1Xz4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3572
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

These are the proposed RDMA patches for 5.17.

Another small cycle. Mostly cleanups and bug fixes, quite a bit
assisted from bots. There are a few new syzkaller splats that haven't
been solved yet but they should get into the rcs in a few weeks, I
think.

There was a small merge conflict with the rdma RC tree, I fixed it up
in a usual v5.16 merge.

Thanks,
Jason

The following changes since commit df0cc57e057f18e44dac8e6c18aba47ab53202f9:

  Linux 5.16 (2022-01-09 14:55:34 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to c0fe82baaeb2719f910359684c0817057f79a84a:

  Merge tag 'v5.16' into rdma.git for-next (2022-01-13 13:21:03 -0400)

----------------------------------------------------------------
RDMA v5.17 merge window pull request

Substantially all bug fixes and cleanups:

- Update drivers to use common helpers for GUIDs, pkeys, bitmaps,
  memset_startat, and others

- General code cleanups from bots

- Simplify some of the rxe pool code in preparation for a larger rework

- Clean out old stuff from hns, including all support for hip06 devices

- Fix a bug where GID table entries could be missed if the table had holes
  in it

- Rename paths and sessions in rtrs for better understandability

- Consolidate the roce source port selection code

- NDR speed support in mlx5

----------------------------------------------------------------
Avihai Horon (3):
      RDMA/core: Modify rdma_query_gid() to return accurate error codes
      RDMA/core: Let ib_find_gid() continue search even after empty entry
      RDMA/cma: Let cma_resolve_ib_dev() continue search even after empty e=
ntry

Bob Pearson (6):
      RDMA/rxe: Replace irqsave locks with bh locks
      RDMA/rxe: Cleanup rxe_pool_entry
      RDMA/rxe: Copy setup parameters into rxe_pool
      RDMA/rxe: Save object pointer in pool element
      RDMA/rxe: Remove #include "rxe_loc.h" from rxe_pool.c
      RDMA/rxe: Remove some #defines from rxe_pool.h

Changcheng Deng (1):
      RDMA/bnxt_re: Remove unneeded variable

Chengchang Tang (1):
      RDMA/hns: Remove support for HIP06

Chengguang Xu (1):
      RDMA/rxe: Fix a typo in opcode name

Christophe JAILLET (16):
      RDMA/bnxt_re: Scan the whole bitmap when checking if "disabling RCFW =
with pending cmd-bit"
      IB/mthca: Use bitmap_zalloc() when applicable
      IB/mthca: Use bitmap_set() when applicable
      IB/mthca: Use non-atomic bitmap functions when possible in 'mthca_all=
ocator.c'
      IB/mthca: Use non-atomic bitmap functions when possible in 'mthca_mr.=
c'
      RDMA/cxgb4: Use bitmap_zalloc() when applicable
      RDMA/cxgb4: Use bitmap_set() when applicable
      RDMA/cxgb4: Use non-atomic bitmap functions when possible
      RDMA/ocrdma: Use bitmap_zalloc() when applicable
      RDMA/ocrdma: Simplify code in 'ocrdma_search_mmap()'
      RDMA/mlx4: Use bitmap_alloc() when applicable
      IB/hfi1: Use bitmap_zalloc() when applicable
      RDMA/pvrdma: Use bitmap_zalloc() when applicable
      RDMA/pvrdma: Use non-atomic bitmap functions when possible
      RDMA/bnxt_re: Use bitmap_zalloc() when applicable
      RDMA/irdma: Fix the type used to declare a bitmap

Colin Ian King (1):
      IB/core: Remove redundant pointer mm

Dan Carpenter (1):
      RDMA/usnic: Clean up usnic_ib_alloc_pd()

Dust Li (1):
      RDMA/mlx5: Print wc status on CQE error and dump needed

Greg Kroah-Hartman (1):
      RDMA: Use default_groups in kobj_type

H=C3=A5kon Bugge (1):
      RDMA/cma: Remove open coding of overflow checking for private_data_len

Jack Wang (1):
      RDMA/rtrs-clt: Fix the initial value of min_latency

Jason Gunthorpe (3):
      Merge tag 'v5.16-rc5' into rdma.git for-next
      Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel=
/git/mellanox/linux
      Merge tag 'v5.16' into rdma.git for-next

Jiapeng Chong (1):
      RDMA/siw: Use max() instead of doing it manually

Kamal Heib (9):
      RDMA/irdma: Use helper function to set GUIDs
      RDMA/ocrdma: Use helper function to set GUIDs
      RDMA/hns: Validate the pkey index
      RDMA/cxgb4: Use helper function to set GUIDs
      RDMA/siw: Use helper function to set sys_image_guid
      RDMA/bnxt_re: Remove dynamic pkey table
      RDMA/bnxt_re: Fix endianness warning for req.pkey
      RDMA/qedr: Fix reporting max_{send/recv}_wr attrs
      RDMA/cxgb4: Set queue pair state when being queried

Kees Cook (3):
      RDMA/mlx5: Use memset_after() to zero struct mlx5_ib_mr
      iw_cxgb4: Use memset_startat() for cpl_t5_pass_accept_rpl
      IB/mthca: Use memset_startat() for clearing mpt_entry

Leon Romanovsky (2):
      RDMA/mad: Delete duplicated init_query_mad functions
      RDMA/rxe: Delete deprecated module parameters interface

Li Zhijian (1):
      RDMA/rxe: Fix indentations and operators sytle

Maher Sanalla (1):
      IB/mlx5: Expose NDR speed through MAD

Max Gurtovoy (5):
      IB/iser: Remove deprecated pi_guard module param
      IB/iser: Rename ib_ret local variable
      IB/iser: Don't suppress send completions
      IB/iser: Remove un-needed casting to/from void pointer
      IB/iser: Align coding style across driver

Minghao Chi (2):
      RDMA/ocrdma: Remove unneeded variable
      RDMA/rxe: Remove redundant err variable

Qinghua Jin (1):
      IB/qib: Fix typos

Sergey Gorenko (1):
      IB/iser: Fix RNR errors

Vaishali Thakkar (5):
      RDMA/rtrs: Rename rtrs_sess to rtrs_path
      RDMA/rtrs-srv: Rename rtrs_srv_sess to rtrs_srv_path
      RDMA/rtrs-clt: Rename rtrs_clt_sess to rtrs_clt_path
      RDMA/rtrs-srv: Rename rtrs_srv to rtrs_srv_sess
      RDMA/rtrs-clt: Rename rtrs_clt to rtrs_clt_sess

Wenpeng Liang (1):
      RDMA/hns: Modify the hop num of HIP09 EQ to 1

Xinhao Liu (6):
      RDMA/hns: Correct the hex print format
      RDMA/hns: Correct the print format to be consistent with the variable=
 type
      RDMA/hns: Replace tab with space in the right-side comments
      RDMA/hns: Correct the type of variables participating in the shift op=
eration
      RDMA/hns: Correctly initialize the members of Array[][]
      RDMA/hns: Remove magic number

Yixing Liu (3):
      RDMA/hns: Remove macros that are no longer used
      RDMA/hns: Modify the mapping attribute of doorbell to device
      RDMA/hns: Support direct wqe of userspace

Zhu Yanjun (8):
      RDMA/uverbs: Remove the unnecessary assignment
      RDMA/rxe: Remove the unnecessary variable
      RDMA/rxe: Remove the unused xmit_errors member
      RDMA/core: Calculate UDP source port based on flow label or lqpn/rqpn
      RDMA/hns: Replace get_udp_sport with rdma_get_udp_sport
      RDMA/irdma: Make the source udp port vary
      RDMA/rxe: Use the standard method to produce udp source port
      RDMA/irdma: Remove the redundant return

 drivers/block/rnbd/rnbd-clt.c                      |    4 +-
 drivers/block/rnbd/rnbd-clt.h                      |    2 +-
 drivers/block/rnbd/rnbd-srv.c                      |   16 +-
 drivers/block/rnbd/rnbd-srv.h                      |    2 +-
 drivers/infiniband/core/cache.c                    |   12 +-
 drivers/infiniband/core/cma.c                      |   18 +-
 drivers/infiniband/core/device.c                   |    3 +-
 drivers/infiniband/core/sysfs.c                    |    3 +-
 drivers/infiniband/core/umem_odp.c                 |    3 +-
 drivers/infiniband/core/uverbs_cmd.c               |    1 -
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |    9 +-
 drivers/infiniband/hw/bnxt_re/main.c               |    3 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |   11 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |   12 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h         |    1 -
 drivers/infiniband/hw/bnxt_re/qplib_res.c          |   50 -
 drivers/infiniband/hw/bnxt_re/qplib_res.h          |    7 -
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |   99 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h           |    9 -
 drivers/infiniband/hw/cxgb4/cm.c                   |    5 +-
 drivers/infiniband/hw/cxgb4/id_table.c             |   17 +-
 drivers/infiniband/hw/cxgb4/provider.c             |    8 +-
 drivers/infiniband/hw/cxgb4/qp.c                   |    1 +
 drivers/infiniband/hw/hfi1/user_sdma.c             |    8 +-
 drivers/infiniband/hw/hns/Kconfig                  |   17 +-
 drivers/infiniband/hw/hns/Makefile                 |    5 -
 drivers/infiniband/hw/hns/hns_roce_ah.c            |    5 +-
 drivers/infiniband/hw/hns/hns_roce_alloc.c         |    3 +-
 drivers/infiniband/hw/hns/hns_roce_cmd.c           |   11 +-
 drivers/infiniband/hw/hns/hns_roce_common.h        |  202 -
 drivers/infiniband/hw/hns/hns_roce_cq.c            |   13 -
 drivers/infiniband/hw/hns/hns_roce_db.c            |    1 -
 drivers/infiniband/hw/hns/hns_roce_device.h        |  108 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c           |    1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         | 4675 ----------------=
----
 drivers/infiniband/hw/hns/hns_roce_hw_v1.h         | 1147 -----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |   49 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |   22 +-
 drivers/infiniband/hw/hns/hns_roce_main.c          |   85 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c            |   32 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c            |   17 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |   93 +-
 drivers/infiniband/hw/irdma/i40iw_if.c             |    2 +-
 drivers/infiniband/hw/irdma/pble.h                 |    2 +-
 drivers/infiniband/hw/irdma/verbs.c                |   31 +-
 drivers/infiniband/hw/mlx4/main.c                  |   34 +-
 drivers/infiniband/hw/mlx5/cq.c                    |    5 +-
 drivers/infiniband/hw/mlx5/mad.c                   |   23 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |   12 +-
 drivers/infiniband/hw/mthca/mthca_allocator.c      |   15 +-
 drivers/infiniband/hw/mthca/mthca_mr.c             |   25 +-
 drivers/infiniband/hw/mthca/mthca_provider.c       |   20 +-
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c           |   16 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c         |   17 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |   18 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h        |    1 -
 drivers/infiniband/hw/qedr/verbs.c                 |    2 +
 drivers/infiniband/hw/qib/qib_iba6120.c            |    2 +-
 drivers/infiniband/hw/qib/qib_iba7220.c            |    2 +-
 drivers/infiniband/hw/qib/qib_iba7322.c            |    2 +-
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c       |    3 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c       |    8 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_doorbell.c |   10 +-
 drivers/infiniband/sw/rxe/Makefile                 |    1 -
 drivers/infiniband/sw/rxe/rxe.c                    |    4 -
 drivers/infiniband/sw/rxe/rxe.h                    |    2 -
 drivers/infiniband/sw/rxe/rxe_comp.c               |    8 +-
 drivers/infiniband/sw/rxe/rxe_cq.c                 |   24 +-
 drivers/infiniband/sw/rxe/rxe_loc.h                |   10 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c              |   11 +-
 drivers/infiniband/sw/rxe/rxe_mr.c                 |    6 +-
 drivers/infiniband/sw/rxe/rxe_mw.c                 |   21 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |    9 +-
 drivers/infiniband/sw/rxe/rxe_opcode.c             |  739 ++--
 drivers/infiniband/sw/rxe/rxe_pool.c               |  177 +-
 drivers/infiniband/sw/rxe/rxe_pool.h               |   54 +-
 drivers/infiniband/sw/rxe/rxe_qp.c                 |    6 +-
 drivers/infiniband/sw/rxe/rxe_queue.c              |    9 +-
 drivers/infiniband/sw/rxe/rxe_req.c                |   16 +-
 drivers/infiniband/sw/rxe/rxe_srq.c                |    2 +-
 drivers/infiniband/sw/rxe/rxe_sysfs.c              |  119 -
 drivers/infiniband/sw/rxe/rxe_task.c               |   18 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |   34 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h              |   24 +-
 drivers/infiniband/sw/siw/siw_verbs.c              |    6 +-
 drivers/infiniband/ulp/iser/iscsi_iser.c           |   76 +-
 drivers/infiniband/ulp/iser/iscsi_iser.h           |   23 +-
 drivers/infiniband/ulp/iser/iser_initiator.c       |  106 +-
 drivers/infiniband/ulp/iser/iser_memory.c          |   58 +-
 drivers/infiniband/ulp/iser/iser_verbs.c           |  138 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c       |    8 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c       |  145 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             | 1087 ++---
 drivers/infiniband/ulp/rtrs/rtrs-clt.h             |   41 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h             |   18 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c       |  121 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             |  680 +--
 drivers/infiniband/ulp/rtrs/rtrs-srv.h             |   16 +-
 drivers/infiniband/ulp/rtrs/rtrs.c                 |   98 +-
 drivers/infiniband/ulp/rtrs/rtrs.h                 |   34 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_msg.h        |    2 +-
 include/rdma/ib_mad.h                              |    1 +
 include/rdma/ib_smi.h                              |   12 +-
 include/rdma/ib_verbs.h                            |   17 +
 include/uapi/rdma/hns-abi.h                        |    2 +
 105 files changed, 2229 insertions(+), 8794 deletions(-)
(diffstat from tag for-linus-merged)

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmHgdREACgkQOG33FX4g
mxo+Rw/+Pfmb3Lxwbk0pTEZSRXIrpewWkfdY1wsUmXxAEX8hoksJhDM770IdX4T8
cui3Gy3y+B/jcEEh1Jr1CCV1H9GpAcLOE+Y962M+WEJzDYOonPCEiJ4nRYfs7Va0
MZ2QEkAbmrxDt5Objra6S7cE9WK1HcMtCPiSmrqjANj/qQ3U5esx9d9A+AYNZ9NJ
9C09L3/YuK2mEjlQjWMqcAofHhRO+jBRjLfRDORAma3QEMepi5xyULxr4FhcCqEA
cxFKE1bMTYumo4WOKB3U3tTirkvm2UpXBvHMR35DghUQQMZciul1kQxZYhMd8GS+
p8k5Lbbt+NSl3U8970uYovs0PjcFGLu6Av3bmRTH3Kmoi6v/jHwloi8pUQ9XdDcn
VDgIR40850xAeKIeUROeHohrxY2ISCbqbvl6J3r6G0DJnjAlHdPbyyhXrj7rqtiN
ecp6NcDCwodZXvoECo7993ZbHnteR+PzhATDhXjRfvvs9unwD7oIwyPSpGrsrMHE
oRK3Ip3eYv2kjpnaQDs0Ol/1bM1DvU31Jacx+DRbw8TJEAE9HAcZJWJ+Mo3EF5I0
5QIo0tsTynI9v0xxc0Wh9nXs3P8q+EzqrCjcXq7D3m/+vIghWdtTmBatXlIEIXbu
Co9Z0N7pE/f10cYrzkPx5BXK/W/exEgIQ+tLhNcfMRbsUS/KWXc=
=WSFv
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
