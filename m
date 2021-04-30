Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B850B36FEF8
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Apr 2021 18:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhD3Q4U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Apr 2021 12:56:20 -0400
Received: from mail-dm6nam11on2056.outbound.protection.outlook.com ([40.107.223.56]:7392
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229750AbhD3Q4U (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Apr 2021 12:56:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPoAofOTI0na/kgTHsEp1F9LqftP58EWx7af+nZcMZf97GiydPVaSC8Ms8tya++7IzmVqW+4y4pTHJfI8Nc4pjWJhQI2xZJH69Stb6ZuFU4FT8PpxzP+WQOCjk8TOIAHtN1OUBNRDhjqTUkN9IyAyXvaDx8M6O7pVmq0cDRDLGcroRlPNG2K7JABW07qQbZF8wPiDJzczqVaLQVPawUWHAOVj8jJCXnvpdHqcx4U2EtmpEuzZM4hDZYzgIw4Gu3Dof2LYAxczaSlxPMxgEiWqwiaDt/5zaljm6RPtdML/gk6W+aOcx0h9px3ikirJbWuFZw+G5br76P71r1qdDlrKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pU0XXGI5ys8rGdHHAeELhqBtb0yV94rYHOYXdMzBtVg=;
 b=jqfU23yuDA1SbwIUOYZkmpKcNiEawFoYzugtTlvyzTO8mJmilqZ7BwddxTLtVa3mDnkxwzLqU4gm+Mlbu1tHi/2h/KpRDqoSP/bPmL9VwYrhMLUgoJrCGlcqPsTfLq1lc5+iIvW+mnvJmp1hVObg+UFKGMUFW6c673y2pQ/D+vo+qSRFaRXGZXOZfIJ82pYfOTk67FKH4NeZph+DhNGKhkbnmyYDAbhoAl90Bbt4mlHPD0Klr1r/xPDdcfofQNx3tcpfHyevTxxQQ2DupGyN48UlUPd+xwVf4bknnSvuL5WEG3mBEUlVS8dtuOHZIUBXzfDZdce2FdX/HKtIGOo0Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pU0XXGI5ys8rGdHHAeELhqBtb0yV94rYHOYXdMzBtVg=;
 b=Rqqv87nIBjNfF/VRZ+Uj/JpTRnlDmMUcSPGYPwItrwxOGzUibb0irrF2WJNJmKW1olDSEsSRzqWT4lGOu7ITCveP0uBd3d7gQ4C3jn+vt7SOnMNqvMBiSQr2O0rhWE4Et23RRkSaqBUmYdkIwvUHiIL8JW83BugMbJr12LPWNi8QSsXFrLyOnp7vIbLzEV+59HMXAXnQCo+vwCW3CDELlmgJK6w9mH4Ojt5aJY1LYQvyU+/VR6DQ8+bOefAy+xO3PlF9FRqIXULpcffXaCmWgVIlO2lq1EBGWtSiSI1zl8ZI27Qc3EtrEUn/T/0i7sIr+OfmCbe3tmH6Z117atdfFw==
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Fri, 30 Apr
 2021 16:55:29 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 16:55:29 +0000
Date:   Fri, 30 Apr 2021 13:55:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20210430165527.GA3573658@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:610:76::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR04CA0010.namprd04.prod.outlook.com (2603:10b6:610:76::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 16:55:29 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lcWQJ-00EzoJ-Hc; Fri, 30 Apr 2021 13:55:27 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c201a6db-e31c-42d4-4e7f-08d90bf8c266
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-Microsoft-Antispam-PRVS: <DM5PR12MB11481BB892E4207221FC96ABC25E9@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SjqlIG+2R0ojOUVBx1rfYP7/TIuq9mNfFzulQ34QwU5mJiNyH3HFKCfhuhp8r9rY52og+Qx/oxHGiA85dHxwjhsSVGhuh9ubw8urQ9LH+/vFR5bL0dJ1obPZCFjblUgXIw/CN+zpA0ej5IEYxSVVd0rDtxdMW5lsCLIGVgTtBZarpnUXhOUWTA/gvu06pvS4iLea+S0iCuszH0A/dT85W+LGwgq/TBj4LjXY/shHJ0wYOYMu7XOpQ9Ggtl8adkBhvD2izeuq2y+nqg1nRrOjVfkeiBg+lDasqkQvEfa7D8lfvs2fxZCAvGVj79iSSaN5FyeaLI4L4YGfFKQr4FLR85WRAD5T/1mq+VW1XOtFCryS4vQkg/Lx4ei9mW6gzNwDZ0kpOwbLCsrfg/kYkuEK8NGSrPXn5LhEQ0iy6pDpuLJgPvdceonGqXNGf0ClekORvNqRlZbq2VOWDMy6xRkBI8rFG0cB3CJvf+7IvuaXcs7ObXcizUnsbpBWHQFt0C4TNjtNgDD/NSp7OwaUJ5C2X8w4WPiBq2bMRKeYxcHhbQZpZ+ji3BILmcdRXT2RFdEk93vWvh7BrmY0kfcE/jjWWvOeF7RfTRGFuhLvuXkOR6x3Mljf0BI0A+vP9b76WbfI6vFEXNqcqnGfj1TuTuHzAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39850400004)(21480400003)(36756003)(44144004)(1076003)(33964004)(33656002)(9746002)(2906002)(4326008)(478600001)(316002)(8936002)(9786002)(186003)(83380400001)(2616005)(38100700002)(66574015)(66476007)(30864003)(8676002)(66556008)(86362001)(110136005)(5660300002)(66946007)(26005)(426003)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aUJKZmNsNmZzekcxTUtmNTBjTVo0TE9NZ2hjbkdHYWxaZElySEQ4cFdxcWJW?=
 =?utf-8?B?RFpmS1NNNkV3M1lpajBHREh3ZDdGUllhNk9tL21kY1JZZW1WSU1yY2daQUJ5?=
 =?utf-8?B?TmlUb0ozQ0FSZ1FlbzBqeENuN2pQZ0l4dWdQV0dodXM3MGFHd0NNa2xwbWNQ?=
 =?utf-8?B?L3ZLNzlwWjlGUVd5U3poT2hWR3prRTZ3ZkxJTU9GWmpuMHdqMWVZTUFJdG1p?=
 =?utf-8?B?czBlS3hsYkhZMFg5L293THZVUE1XMHVtSXNJenlVQ0ZHeHlPajVDMVliUFhq?=
 =?utf-8?B?QXIxNFhrNkdJS05ab3RBQU9PUW00b25IWm9kWnVKK0VYbnZkMS9oYjZsYWgy?=
 =?utf-8?B?U29JUlRzMEFBeU9kZFpQd0xTd0MycCtkK1N5SzZLZXEwV3BZTHA1T3dMV3I4?=
 =?utf-8?B?aVE3OUdpUlFnblpzNWNYWkk3bDd3UjZHTys3NnByS2wxOU5vdHlSUWdlRm9O?=
 =?utf-8?B?Q0o4SXg1SmN4Mk9LTlp3WHBTZ2xGb2RhWWNpL1JBYnlCUWtqNVQwUElBaDN4?=
 =?utf-8?B?bERNajJwNUNyVThJR2RJRThGNy91dHRLcnhaaTI4ZGRPSkFtYjducHBYR0xt?=
 =?utf-8?B?Rkl4RFdURkdmMFh1c1diUVVCeWw0Q3RMOC9xem45dml3OUxYK0k3WU9TaGpK?=
 =?utf-8?B?QjBhaDFGWjFXM3pyM0hjZHkzczh5RWFiWUQ0c2djN0M2Z2JEbXZNWDJDUm1Y?=
 =?utf-8?B?eC94WE1ncGJjYXV3YjFKTkhZbFppVHM2RUlaMmo1a2hEanQvVXM5V2pheHJL?=
 =?utf-8?B?dUJyUGl5NFdHZVNybEdiTEpuS1hVaDNOUWFrVkRUNWoxN05jSFpHdzY5RVVJ?=
 =?utf-8?B?MEZOSzR0MjlZSGNBTnV3ZzlDQ0NQYXVBaWZ2bkE0ZnFCWXJodnM2aGRSWHhS?=
 =?utf-8?B?NXJkQ3RhZ21Fd0dQQmpvcTdMMzZCZkJTVGUzcmRqaWhuSFVLd0lQaWtFb01J?=
 =?utf-8?B?VUtvU3R2czZYbkRlRDdhaW1wRDIxMTVwYmJUeGc4QVJZRmJZODlIUG1tdExO?=
 =?utf-8?B?MXRpOGNRK2ZDMGhLZXorV0ttZ05VNU1pODZMa2FyWTR2TGJYanhTNVNlSW1L?=
 =?utf-8?B?TTZlU0dWUXE0MEd5QlZOM0xrNkpRQ0FvRVBqdjZQZlVhWVBkMzZwNG1qK2wr?=
 =?utf-8?B?MGFlakg4UU5YRHJObVlzc3NscWNLK1ZxZ1Jtd04rRHZyZDZMMDdRRHFNWERp?=
 =?utf-8?B?Q2FZeUExTzlkWndFZXJEU0ZsdENra2Q2SGdHbmFBRVQrSWE2OXRnUmxRQTh5?=
 =?utf-8?B?NFg0bUFPaHc0eXNvdkpVQUZuS2pyUzBLU3gxamFjMGV6cXExVUg5QTdwUjdV?=
 =?utf-8?B?SDVSZkNoYTdhbmptb0cwd1ZFWlQzaTRpTHNwZzVubWxXRjhQbjFMckpSdURI?=
 =?utf-8?B?T0RRbkdTTVh3UlpRZGVIL0lXNTdrZWUvTWFIdlZGa2NqVmNpTHVVUnZhQVhI?=
 =?utf-8?B?S29EOWVtRDRIRy85THphaml2T3B0R0tZak1JWnRNaHFHSWtBelg3WS9lZ3hX?=
 =?utf-8?B?bHVUOWU1ejl2b2ZuN0ZMUFplTlhUZHNGZTVBMHZKYUEzYTNtSHNRLzBuL3Ev?=
 =?utf-8?B?VXVNNVZ4ME5YZk5tV3cwN1cwZGZBdEx1SlFGNnJYeVlMQ3ZmcFFTeXZWeWNF?=
 =?utf-8?B?NnRTSHNqWkoxdkp2RDJjWExnOEloTy9SdzYydkduUUlLcmM0TGowTks0bWVz?=
 =?utf-8?B?QVltNkY0aUNGa1NCMm8vaVJOL2x0Wm5PQy9vdHJobnVOTTlCKzVOZktqNHI5?=
 =?utf-8?Q?Lr0QhjU8J1WNkUJea/BJSTur2UCohaQCgjZFrP0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c201a6db-e31c-42d4-4e7f-08d90bf8c266
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 16:55:29.4203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0ImPtgdXxDtpvIMsxwiafxCS2aCButSWnfaZjHj8SXGmbyXwUfSIduY6gISkSo5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

These are the proposed RDMA patches for 5.13.

We are continuing to see small cycles in RDMA, this may be a new
structural normal.

This time hns and rtrs lead the pack in change volume, but must is
cleaning not features.

Thanks,
Jason

The following changes since commit e71b75f73763d88665b3a19c5a4d52d559aa7732:

  net/mlx5: Implement sriov_get_vf_total_msix/count() callbacks (2021-04-04=
 10:30:38 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 6da7bda36388ae00822f732c11febfe2ebbb5544:

  IB/qib: Remove redundant assignment to ret (2021-04-30 10:58:15 -0300)

----------------------------------------------------------------
RDMA merge window pull request

This is significantly bug fixes and general cleanups. The noteworthy new
features are fairly small:

- XRC support for HNS and improves RQ operations

- Bug fixes and updates for hns, mlx5, bnxt_re, hfi1, i40iw, rxe, siw and
  qib

- Quite a few general cleanups on spelling, error handling, static checker
  detections, etc

- Increase the number of device ports supported beyond 255. High port
  count software switches now exist

- Several bug fixes for rtrs

- mlx5 Device Memory support for host controlled atomics

- Report SRQ tables through to rdma-tool

----------------------------------------------------------------
Bernard Metzler (1):
      RDMA/iwcm: Allow AFONLY binding for IPv6 addresses

Bhaskar Chowdhury (4):
      RDMA/include: Mundane typo fixes throughout the file
      IB/hns: Fix mispelling of subsystem
      IB/hfi1: Fix a typo
      RDMA: Fix a typo

Bob Pearson (3):
      RDMA/rxe: Split MEM into MR and MW
      RDMA/rxe: Fix missing acks from responder
      RDMA/rxe: Fix a bug in rxe_fill_ip_info()

Christophe JAILLET (1):
      RDMA/mlx4: Remove an unused variable

Danil Kipnis (1):
      MAINTAINERS: Change maintainer for rtrs module

Gal Pressman (4):
      RDMA/core: Remove unused req_ncomp_notif device operation
      RDMA/cma: Remove unused leftovers in cma code
      RDMA/efa: Use strscpy instead of strlcpy
      RDMA/nldev: Add copy-on-fork attribute to get sys command

Gioh Kim (9):
      RDMA/rtrs: New function converting rtrs_addr to string
      RDMA/rtrs-srv: Report temporary sessname for error message
      RDMA/rtrs-clt: destroy sysfs after removing session from active list
      RDMA/rtrs-clt: Add a minimum latency multipath policy
      RDMA/rtrs-clt: New sysfs attribute to print the latency of each path
      Documentation/ABI/rtrs-clt: Add descriptions for min-latency policy
      RDMA/rtrs-clt: Print more info when an error happens
      RDMA/rtrs-srv: More debugging info when fail to send reply
      RDMA/rtrs-clt: Simplify error message

Guoqing Jiang (4):
      RDMA/rtrs-clt: Remove redundant code from rtrs_clt_read_req
      RDMA/rtrs: Kill the put label in rtrs_srv_create_once_sysfs_root_fold=
ers
      RDMA/rtrs: Remove sessname and sess_kobj from rtrs_attrs
      RDMA/rtrs: Cleanup the code in rtrs_srv_rdma_cm_handler

H=C3=A5kon Bugge (4):
      RDMA/core: Fix corrupted SL on passive side
      IB/cma: Introduce rdma_set_min_rnr_timer()
      rds: ib: Remove two ib_modify_qp() calls
      RDMA/core: Unify RoCE check and re-factor code

Jack Wang (5):
      RDMA/rtrs: Use new shared CQ mechanism
      RDMA/rtrs-clt: Use rdma_event_msg in log
      RDMA/rtrs: Cleanup unused 's' variable in __alloc_sess
      RDMA/rtrs-clt: Cap max_io_size
      RDMA/ipoib: Print a message if only child interface is UP

Jason Gunthorpe (7):
      RDMA/mlx5: Zero out ODP related items in the mlx5_ib_mr
      RDMA/mlx5: Use a union inside mlx5_ib_mr
      RDMA/mlx5: Consolidate MR destruction to mlx5_ib_dereg_mr()
      RDMA/mlx5: Rename mlx5_mr_cache_invalidate() to revoke_mr()
      RDMA/mlx5: Allow larger pages in DevX umem
      Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel=
/git/mellanox/linux
      Merge branch 'mlx5_memic_ops' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/mellanox/linux

Jiapeng Chong (2):
      RDMA/qib: Remove useless qib_read_ureg() function
      IB/hfi1: Remove redundant variable rcd

Kaike Wan (1):
      IB/hfi1: Remove unused function

Kamal Heib (1):
      RDMA/rxe: Remove rxe_dma_device declaration

Lang Cheng (5):
      RDMA/hns: Use new SQ doorbell register for HIP09
      RDMA/hns: Support to query firmware version
      RDMA/hns: Enable all CMDQ context
      RDMA/hns: Support more return types of command queue
      RDMA/hns: Prevent le32 from being implicitly converted to u32

Leon Romanovsky (6):
      RDMA/mlx5: Add missing returned error check of mlx5_ib_dereg_mr
      RDMA: Fix kernel-doc compilation warnings
      RDMA: Delete not-used static inline functions
      RDMA/bnxt_re: Depend on bnxt ethernet driver and not blindly select it
      RDMA/bnxt_re: Create direct symbol link between bnxt modules
      RDMA/bnxt_re: Get rid of custom module reference counting

Lv Yunlong (3):
      IB/isert: Fix a use after free in isert_connect_request
      RDMA/siw: Fix a use after free in siw_alloc_mr
      RDMA/bnxt_re: Fix a double free in bnxt_qplib_alloc_res

Manjunath Patil (1):
      IB/ipoib: Improve latency in ipoib/cm connection formation

Maor Gottlieb (10):
      RDMA/mlx5: Fix query RoCE port
      RDMA/mlx5: Fix drop packet rule in egress table
      net/mlx5: Add MEMIC operations related bits
      RDMA/uverbs: Make UVERBS_OBJECT_METHODS to consider line number
      RDMA/mlx5: Move all DM logic to separate file
      RDMA/mlx5: Re-organize the DM code
      RDMA/mlx5: Add support to MODIFY_MEMIC command
      RDMA/mlx5: Add support in MEMIC operations
      RDMA/mlx5: Expose UAPI to query DM
      RDMA/mlx5: Fix type assignment for ICM DM

Mark Bloch (2):
      RDMA: Support more than 255 rdma ports
      RDMA/mlx5: Expose private query port

Mark Zhang (1):
      RDMA/mlx5: Fix mlx5 rates to IB rates map

Mike Marciniszyn (8):
      IB/hfi1: Add AIP tx traces
      IB/{ipoib,hfi1}: Add a timeout handler for rdma_netdev
      IB/hfi1: Correct oversized ring allocation
      IB/hfi1: Use napi_schedule_irqoff() for tx napi
      IB/hfi1: Remove indirect call to hfi1_ipoib_send_dma()
      IB/hfi1: Add additional usdma traces
      IB/hfi1: Use kzalloc() for mmu_rb_handler allocation
      IB/hfi1: Rework AIP and VNIC dummy netdev usage

Neta Ostrovsky (4):
      RDMA/nldev: Return context information
      RDMA/restrack: Add support to get resource tracking for SRQ
      RDMA/nldev: Return SRQ information
      RDMA/nldev: Add QP numbers to SRQ information

Parav Pandit (2):
      IB/mlx5: Set right RoCE l3 type and roce version while deleting GID
      RDMA/cma: Skip device which doesn't support CM

Patrisious Haddad (1):
      RDMA/uverbs: Refactor rdma_counter_set_auto_mode and __counter_set_mo=
de

Potnuri Bharat Teja (1):
      RDMA/cxgb4: add missing qpid increment

Praveen Kumar Kannoju (1):
      IB/mlx5: Reduce max order of memory allocated for xlt update

Ruiqi Gong (1):
      RDMA/hns: Fix a spelling mistake in hns_roce_hw_v1.c

Selvin Xavier (1):
      RDMA/bnxt_re: Move device to error state upon device crash

Shay Drory (3):
      RDMA/mlx5: Create ODP EQ only when ODP MR is created
      RDMA/mlx5: Set ODP caps only if device profile support ODP
      RDMA/core: Add CM to restrack after successful attachment to a device

Sindhu Devale (1):
      RDMA/i40iw: Fix error unwinding when i40iw_hmc_sd_one fails

Tang Yizhou (1):
      RDMA/iw_cxgb4: Use DEFINE_SPINLOCK() for spinlock

Wan Jiabing (2):
      RDMA/iser: struct iscsi_iser_task is declared twice
      IB/ipoib: Remove unnecessary struct declaration

Wang Wensheng (4):
      RDMA/qedr: Fix error return code in qedr_iw_connect()
      IB/hfi1: Fix error return code in parse_platform_config()
      RDMA/bnxt_re: Fix error return code in bnxt_qplib_cq_process_terminal=
()
      RDMA/srpt: Fix error return code in srpt_cm_req_recv()

Wei Xu (5):
      RDMA/hns: Support query information of functions from FW
      RDMA/hns: Query the number of functions supported by the PF
      RDMA/hns: Reserve the resource for the VFs
      RDMA/hns: Set parameters of all the functions belong to a PF
      RDMA/hns: Enable RoCE on virtual functions

Wei Yongjun (1):
      RDMA/hns: Use GFP_ATOMIC under spin lock

Weihang Li (5):
      RDMA/hns: Fix memory corruption when allocating XRCDN
      MAINTAINERS: remove Xavier as maintainer of HISILICON ROCE DRIVER
      RDMA/hns: Refactor hns_roce_v2_poll_one()
      RDMA/hns: Avoid enabling RQ inline on UD
      RDMA/hns: Fix missing assignment of max_inline_data

Wenpeng Liang (11):
      RDMA/hns: Add support for XRC on HIP09
      RDMA/hns: Modify prints for mailbox and command queue
      RDMA/hns: Delete redundant abnormal interrupt status
      RDMA/hns: Remove unsupported QP types
      RDMA/hns: Add XRC subtype in QPC and XRC type in SRQC
      RDMA/core: Print the function name by __func__ instead of an fixed st=
ring
      RDMA/core: Remove the redundant return statements
      RDMA/core: Add necessary spaces
      RDMA/core: Remove redundant spaces
      RDMA/core: Correct format of braces
      RDMA/core: Correct format of block comments

Xi Wang (5):
      RDMA/hns: Refactor reset state checking flow
      RDMA/hns: Reorganize process of setting HEM
      RDMA/hns: Simplify command fields for HEM base address configuration
      RDMA/hns: Simplify function's resource related command
      RDMA/hns: Remove duplicated hem page size config code

Yang Li (1):
      IB/qib: Remove redundant assignment to ret

Yangyang Li (4):
      RDMA/core: Correct misspellings of two words in comments
      RDMA/hns: Support congestion control type selection according to the =
FW
      RDMA/hns: Delete redundant condition judgment related to eq
      RDMA/hns: Delete unused members in the structure hns_roce_hw

Ye Bin (1):
      RDMA/i40iw: Use DEFINE_SPINLOCK() for spinlock

Yishai Hadas (2):
      IB/core: Drop WARN_ON() from ib_umem_find_best_pgsz()
      IB/core: Split uverbs_get_const/default to consider target type

Yixian Liu (4):
      RDMA/hns: Support configuring doorbell mode of RQ and CQ
      RDMA/hns: Reorganize doorbell update interfaces for all queues
      RDMA/core: Make the wc status prompt message clearer
      RDMA/hns: Remove unnecessary flush operation for workqueue

Yixing Liu (2):
      RDMA/hns: Reorganize hns_roce_create_cq()
      RDMA/hns: Simplify the function config_eqc()

YueHaibing (1):
      RDMA/uverbs: Fix -Wunused-function warning

 Documentation/ABI/testing/sysfs-class-rtrs-client  |   12 +
 .../bindings/infiniband/hisilicon-hns-roce.txt     |    2 +-
 MAINTAINERS                                        |    5 +-
 drivers/infiniband/core/cache.c                    |   87 +-
 drivers/infiniband/core/cm.c                       |   58 +-
 drivers/infiniband/core/cm_msgs.h                  |    4 +-
 drivers/infiniband/core/cma.c                      |  116 +-
 drivers/infiniband/core/cma_configfs.c             |    8 +-
 drivers/infiniband/core/cma_priv.h                 |   10 +-
 drivers/infiniband/core/core_priv.h                |   28 +-
 drivers/infiniband/core/counters.c                 |   62 +-
 drivers/infiniband/core/device.c                   |   37 +-
 drivers/infiniband/core/iwpm_msg.c                 |    3 +-
 drivers/infiniband/core/mad.c                      |   79 +-
 drivers/infiniband/core/mad_rmpp.c                 |   10 +-
 drivers/infiniband/core/multicast.c                |    8 +-
 drivers/infiniband/core/nldev.c                    |  176 +-
 drivers/infiniband/core/opa_smi.h                  |    4 +-
 drivers/infiniband/core/rdma_core.c                |    4 +-
 drivers/infiniband/core/restrack.c                 |    3 +
 drivers/infiniband/core/roce_gid_mgmt.c            |   52 +-
 drivers/infiniband/core/rw.c                       |   25 +-
 drivers/infiniband/core/sa.h                       |    2 +-
 drivers/infiniband/core/sa_query.c                 |   22 +-
 drivers/infiniband/core/security.c                 |    8 +-
 drivers/infiniband/core/smi.c                      |   12 +-
 drivers/infiniband/core/smi.h                      |    4 +-
 drivers/infiniband/core/sysfs.c                    |   29 +-
 drivers/infiniband/core/ucma.c                     |    8 +-
 drivers/infiniband/core/umem.c                     |    8 +-
 drivers/infiniband/core/umem_dmabuf.c              |    4 +
 drivers/infiniband/core/user_mad.c                 |   34 +-
 drivers/infiniband/core/uverbs_cmd.c               |   25 +-
 drivers/infiniband/core/uverbs_ioctl.c             |   32 +-
 drivers/infiniband/core/verbs.c                    |   43 +-
 drivers/infiniband/hw/bnxt_re/Kconfig              |    4 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h            |    1 +
 drivers/infiniband/hw/bnxt_re/hw_counters.c        |    4 +-
 drivers/infiniband/hw/bnxt_re/hw_counters.h        |    4 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |   10 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h           |   10 +-
 drivers/infiniband/hw/bnxt_re/main.c               |   63 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |    1 +
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |    4 +
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h         |    2 +
 drivers/infiniband/hw/bnxt_re/qplib_res.c          |    1 +
 drivers/infiniband/hw/cxgb4/cm.c                   |    3 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h             |   11 -
 drivers/infiniband/hw/cxgb4/provider.c             |   12 +-
 drivers/infiniband/hw/cxgb4/resource.c             |    2 +-
 drivers/infiniband/hw/cxgb4/t4.h                   |   33 -
 drivers/infiniband/hw/efa/efa.h                    |   14 +-
 drivers/infiniband/hw/efa/efa_main.c               |   10 +-
 drivers/infiniband/hw/efa/efa_verbs.c              |   14 +-
 drivers/infiniband/hw/hfi1/affinity.c              |    8 +-
 drivers/infiniband/hw/hfi1/chip.c                  |   10 +-
 drivers/infiniband/hw/hfi1/chip.h                  |    5 -
 drivers/infiniband/hw/hfi1/driver.c                |    2 +-
 drivers/infiniband/hw/hfi1/exp_rcv.c               |    6 +-
 drivers/infiniband/hw/hfi1/firmware.c              |    1 +
 drivers/infiniband/hw/hfi1/hfi.h                   |   20 +-
 drivers/infiniband/hw/hfi1/init.c                  |    7 +-
 drivers/infiniband/hw/hfi1/iowait.h                |    2 +-
 drivers/infiniband/hw/hfi1/ipoib.h                 |   15 +-
 drivers/infiniband/hw/hfi1/ipoib_main.c            |   13 +-
 drivers/infiniband/hw/hfi1/ipoib_tx.c              |   71 +-
 drivers/infiniband/hw/hfi1/mad.c                   |  128 +-
 drivers/infiniband/hw/hfi1/mad.h                   |    2 +-
 drivers/infiniband/hw/hfi1/mmu_rb.c                |    2 +-
 drivers/infiniband/hw/hfi1/msix.c                  |   12 +-
 drivers/infiniband/hw/hfi1/netdev.h                |   39 +-
 drivers/infiniband/hw/hfi1/netdev_rx.c             |  172 +-
 drivers/infiniband/hw/hfi1/sdma.c                  |    2 +-
 drivers/infiniband/hw/hfi1/sdma.h                  |   18 -
 drivers/infiniband/hw/hfi1/sysfs.c                 |    2 +-
 drivers/infiniband/hw/hfi1/trace_tx.h              |  179 ++
 drivers/infiniband/hw/hfi1/user_sdma.c             |   12 +-
 drivers/infiniband/hw/hfi1/user_sdma.h             |    1 +
 drivers/infiniband/hw/hfi1/verbs.c                 |    8 +-
 drivers/infiniband/hw/hfi1/verbs.h                 |    4 +-
 drivers/infiniband/hw/hfi1/verbs_txreq.h           |    5 -
 drivers/infiniband/hw/hfi1/vnic.h                  |    2 +-
 drivers/infiniband/hw/hfi1/vnic_main.c             |    2 +-
 drivers/infiniband/hw/hns/hns_roce_alloc.c         |    3 +
 drivers/infiniband/hw/hns/hns_roce_cmd.c           |  114 +-
 drivers/infiniband/hw/hns/hns_roce_common.h        |   25 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c            |   92 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        |   91 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |   55 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         | 2267 +++++++++++-----=
----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |  578 ++---
 drivers/infiniband/hw/hns/hns_roce_main.c          |   74 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c            |   59 +
 drivers/infiniband/hw/hns/hns_roce_qp.c            |  124 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c           |    5 +-
 drivers/infiniband/hw/i40iw/i40iw.h                |    9 -
 drivers/infiniband/hw/i40iw/i40iw_cm.c             |    4 +-
 drivers/infiniband/hw/i40iw/i40iw_hmc.c            |    4 +-
 drivers/infiniband/hw/i40iw/i40iw_main.c           |    5 +-
 drivers/infiniband/hw/i40iw/i40iw_osdep.h          |   22 -
 drivers/infiniband/hw/i40iw/i40iw_pble.c           |    6 +-
 drivers/infiniband/hw/i40iw/i40iw_puda.c           |    2 +-
 drivers/infiniband/hw/i40iw/i40iw_utils.c          |    2 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c          |   14 +-
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c       |    2 +-
 drivers/infiniband/hw/mlx4/alias_GUID.c            |   16 +-
 drivers/infiniband/hw/mlx4/mad.c                   |   46 +-
 drivers/infiniband/hw/mlx4/main.c                  |   47 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h               |   26 +-
 drivers/infiniband/hw/mlx4/qp.c                    |    3 -
 drivers/infiniband/hw/mlx5/Makefile                |    1 +
 drivers/infiniband/hw/mlx5/cmd.c                   |  101 -
 drivers/infiniband/hw/mlx5/cmd.h                   |    3 -
 drivers/infiniband/hw/mlx5/cong.c                  |    8 +-
 drivers/infiniband/hw/mlx5/counters.c              |   10 +-
 drivers/infiniband/hw/mlx5/counters.h              |    2 +-
 drivers/infiniband/hw/mlx5/devx.c                  |   64 +-
 drivers/infiniband/hw/mlx5/dm.c                    |  587 +++++
 drivers/infiniband/hw/mlx5/dm.h                    |   68 +
 drivers/infiniband/hw/mlx5/fs.c                    |    9 +-
 drivers/infiniband/hw/mlx5/ib_rep.c                |    4 +-
 drivers/infiniband/hw/mlx5/ib_rep.h                |    4 +-
 drivers/infiniband/hw/mlx5/ib_virt.c               |   16 +-
 drivers/infiniband/hw/mlx5/mad.c                   |   16 +-
 drivers/infiniband/hw/mlx5/main.c                  |  343 +--
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |  182 +-
 drivers/infiniband/hw/mlx5/mr.c                    |  163 +-
 drivers/infiniband/hw/mlx5/odp.c                   |  185 +-
 drivers/infiniband/hw/mlx5/qp.c                    |   17 +-
 drivers/infiniband/hw/mlx5/std_types.c             |  173 ++
 drivers/infiniband/hw/mthca/mthca_av.c             |    6 +-
 drivers/infiniband/hw/mthca/mthca_dev.h            |    8 +-
 drivers/infiniband/hw/mthca/mthca_mad.c            |    4 +-
 drivers/infiniband/hw/mthca/mthca_provider.c       |   10 +-
 drivers/infiniband/hw/mthca/mthca_qp.c             |    2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_ah.c           |    2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_ah.h           |    2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c         |    4 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |    4 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h        |    7 +-
 drivers/infiniband/hw/qedr/main.c                  |    8 +-
 drivers/infiniband/hw/qedr/qedr_iw_cm.c            |    4 +-
 drivers/infiniband/hw/qedr/verbs.c                 |    9 +-
 drivers/infiniband/hw/qedr/verbs.h                 |   11 +-
 drivers/infiniband/hw/qib/qib.h                    |   34 +-
 drivers/infiniband/hw/qib/qib_common.h             |    7 -
 drivers/infiniband/hw/qib/qib_file_ops.c           |    5 +-
 drivers/infiniband/hw/qib/qib_iba6120.c            |    2 +-
 drivers/infiniband/hw/qib/qib_iba7220.c            |    4 +-
 drivers/infiniband/hw/qib/qib_iba7322.c            |   26 +-
 drivers/infiniband/hw/qib/qib_init.c               |    2 +-
 drivers/infiniband/hw/qib/qib_mad.c                |    4 +-
 drivers/infiniband/hw/qib/qib_qp.c                 |    4 +-
 drivers/infiniband/hw/qib/qib_sd7220.c             |    1 -
 drivers/infiniband/hw/qib/qib_sysfs.c              |    2 +-
 drivers/infiniband/hw/qib/qib_verbs.c              |    6 +-
 drivers/infiniband/hw/qib/qib_verbs.h              |    6 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c        |    2 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c       |    6 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h       |    6 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h          |   10 -
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c     |    2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c       |    2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c    |   12 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h    |   45 +-
 drivers/infiniband/sw/rdmavt/mad.c                 |    5 +-
 drivers/infiniband/sw/rdmavt/mad.h                 |    2 +-
 drivers/infiniband/sw/rdmavt/vt.c                  |   34 +-
 drivers/infiniband/sw/rdmavt/vt.h                  |   11 +-
 drivers/infiniband/sw/rxe/rxe_av.c                 |    2 +-
 drivers/infiniband/sw/rxe/rxe_comp.c               |    5 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.c        |    4 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.h        |    4 +-
 drivers/infiniband/sw/rxe/rxe_loc.h                |   30 +-
 drivers/infiniband/sw/rxe/rxe_mr.c                 |  271 ++-
 drivers/infiniband/sw/rxe/rxe_pool.c               |   14 +-
 drivers/infiniband/sw/rxe/rxe_req.c                |   10 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |   52 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |   32 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h              |   60 +-
 drivers/infiniband/sw/siw/iwarp.h                  |   13 -
 drivers/infiniband/sw/siw/siw_cm.c                 |   19 +-
 drivers/infiniband/sw/siw/siw_mem.c                |    4 +-
 drivers/infiniband/sw/siw/siw_mem.h                |    5 -
 drivers/infiniband/sw/siw/siw_verbs.c              |    8 +-
 drivers/infiniband/sw/siw/siw_verbs.h              |   10 +-
 drivers/infiniband/ulp/ipoib/ipoib.h               |    6 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |    6 +-
 drivers/infiniband/ulp/ipoib/ipoib_ib.c            |    2 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |   26 +-
 drivers/infiniband/ulp/iser/iscsi_iser.h           |    1 -
 drivers/infiniband/ulp/isert/ib_isert.c            |   16 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c       |   48 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |  122 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.h             |    1 +
 drivers/infiniband/ulp/rtrs/rtrs-pri.h             |    3 +
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c       |   20 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             |   36 +-
 drivers/infiniband/ulp/rtrs/rtrs.c                 |   35 +-
 drivers/infiniband/ulp/rtrs/rtrs.h                 |    3 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |    4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |    2 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |    1 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |    1 +
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/gid.c  |    4 +-
 include/linux/mlx5/driver.h                        |    2 +-
 include/linux/mlx5/mlx5_ifc.h                      |   42 +-
 include/rdma/ib_cache.h                            |   18 +-
 include/rdma/ib_mad.h                              |    2 +-
 include/rdma/ib_sa.h                               |   15 +-
 include/rdma/ib_verbs.h                            |  199 +-
 include/rdma/iw_cm.h                               |    1 +
 include/rdma/rdma_cm.h                             |    4 +-
 include/rdma/rdma_counter.h                        |   16 +-
 include/rdma/rdma_vt.h                             |   18 +-
 include/rdma/restrack.h                            |    4 +
 include/rdma/rw.h                                  |   18 +-
 include/rdma/uverbs_ioctl.h                        |   81 +-
 include/rdma/uverbs_named_ioctl.h                  |    2 +-
 include/uapi/rdma/hns-abi.h                        |    2 +
 include/uapi/rdma/mlx5_user_ioctl_cmds.h           |   29 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h          |   25 +
 include/uapi/rdma/rdma_netlink.h                   |   16 +
 net/rds/ib_cm.c                                    |   35 +-
 net/rds/rdma_transport.c                           |    1 +
 226 files changed, 5325 insertions(+), 4036 deletions(-)
(diffstat from tag for-linus-merged)

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmCMNn0ACgkQOG33FX4g
mxrYkhAAjT7KmKnU7avsvuUA9wtpED8G1bsZEV8UX1l2a5is2tlBoU41wubt4iHv
+FRoOBwOXkKEghSDNOcJyEkz4pyNp2E1sDr8E2G8bk5zniF0phIXG2V7pSQm2v2A
BEvZRCXsQJtLVpymiQFTXL7Jr2/6GhryskGvtmhiSWG+WB6A7Vz+uQqHIviuLovC
OnKVWU63iNRW/5u7GDzkuHD2+Ad7l56fSzriCbdtmdaec+nAqrkHgdYT4tgJ9tR8
BOBl26/j3T2g6IAYnuvWQddpKNiIpzE97w64LB7js5Mj5mZ3WJSEe8u2DPumrg47
X10E+yr/zRTta8xM9ksS1NvGobgTrAu7/TuAMZqk+mJS524df1qBpYu0714piMkm
ExeQdcm6soEbBNTOUmNE7tL6eZu2tJSr0Ex7XC3P72shp+RJ/r+MhEOjmHSciEW/
zWvB5T1c/GlbN3q0WhnWiE1cUIXd9RseuUHWs1knF5Lib00zq4T5uyh5p2EXTYJs
ok+ZTOufUONW1//bW+3ApLRNG5Kuhq9+6kWN3jSf1jsNB7HVyQRTd1ssADdd36ml
BfsDa4exhwKJYdEordw8Q2gOHHQH1wGcKRsYoFSbKiy88+UEU6ujFiEzGX29YiAr
1Ed+2K2hnVzNQA3FVc3VLaexRJug9SgXmnXfqyawFk9/2ZOLs/I=
=69IY
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
