Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DA73B8BC3
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jul 2021 03:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbhGABdB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Jun 2021 21:33:01 -0400
Received: from mail-bn8nam11on2042.outbound.protection.outlook.com ([40.107.236.42]:49850
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234174AbhGABdB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Jun 2021 21:33:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7r4WDO/iPXzGgC5W9GX2IhVBVCvyKA5IXRu+XuA0okAxtlb4CLlvps4RvL+NjfPu0RdUKRI5OFFLxEpEvxeLHVEcieCh2fzD+sH0Rh3t85PmjcYRozhiyHk8Gv+xp2rFebHRLJZoOhi8Pano5wDKMQ5dpiNKJyS43Pa/i5WAD4qTY7mw8GebgNxxRnSoEi6gnQgDOw5xQXyYzeRQvloiRltzCLcgW5bbr92mHnhp/9/ZxrPHxxr35Wn2bQlNiQfxIGy2KdfBKt0CEUNDOfPE7YBuq6uuhgG/P4yz5jc9wHLm8kkAzAjI27FBn9625LX2+++RLWEGTFWah9ncBF8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+n2ksGSdtUF+CSxJvAHEXwyYuGfIXE1Uuf2OFGE3hg=;
 b=O7w/K59jdbXo0moW/2erbmJOJtzmqhdxCpuxPX/XzUmV10Vbj3yQBTzUA1hjw0YRyWiscp0M9Uz0Y21mPXm2FzCx31D4Y/Xg85wNBfKxat132l6Ia/2nl9450gHH5hkqJ/SN06zeeHyRhnNickDrzIRuv01afaLMR5wiNSjam0W3l5Ft52LoaSOCLdiqzNJG+ooyRPrrmGYU2/fpkXJgRs/MGKGNpvirJpg7tWyaqwILcxvbl6pQodDFNf1VRCc5Pgld2fQFzJPPvla315EiUcsuftTTZSJ2oLi0YFVKht2OSMbdGF9Sz6Qu/GfJSItAEGeupOvQlDfFg20Y32O6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+n2ksGSdtUF+CSxJvAHEXwyYuGfIXE1Uuf2OFGE3hg=;
 b=N/F3MDU3y86okiUuy39IedzjTCILxC0CCuoQRziRFX114iYoE+NOyQzK9wrcvBy7k+oBvkFhzLh9Jbu6IwfJZLp8R/MFn3nnsfBtVQpc5d500SebVo58byrcEys2KqwFyPKYfiie2OG+HN021f0xcKhztSa1wbEHHiscfmLwX1gdOLkp3m0Pjl5rGMlZLT+MnErOmuBGCXamr5+fQ4DJkY/CqoCM+BRM4LuKOC3M30sEgFDs9oG6dj5iiCN/qDwepE1Tqkm6k/xgyfc/OXiVlASRYKuVukTqpl25iJ2BvG97C7/m5jVE+aGGQdUx+lrZcSDEuFWXJ1FunC9ut5whlA==
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM8PR12MB5480.namprd12.prod.outlook.com (2603:10b6:8:24::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.20; Thu, 1 Jul 2021 01:30:29 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::81bc:3e01:d9e0:6c52]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::81bc:3e01:d9e0:6c52%7]) with mapi id 15.20.4287.021; Thu, 1 Jul 2021
 01:30:29 +0000
Date:   Wed, 30 Jun 2021 22:30:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20210701013027.GA542170@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:208:256::25) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0020.namprd13.prod.outlook.com (2603:10b6:208:256::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.7 via Frontend Transport; Thu, 1 Jul 2021 01:30:29 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lylX9-002HEO-Ti; Wed, 30 Jun 2021 22:30:27 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d86d2ba8-a8a7-4071-30f3-08d93c2fcf67
X-MS-TrafficTypeDiagnostic: DM8PR12MB5480:
X-Microsoft-Antispam-PRVS: <DM8PR12MB5480900FA3D699355AFC405DC2009@DM8PR12MB5480.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LKRbz9pE474Gz41WPdA/3pe5Zw8M0j1c3A/LjmLHtAgaE5cO/q0q7S3GZzQK9itjx4e/dc3VbCRKRz+o7bb0MELOXWHa9pc4Kqbu5Fs4WE8dbHxROgMbVRGndn1wGLJ9TWs4/dsff8lo/blJ+G7mLXOa5nMiwyeDsquZY0zvqnpvLOknFvjG5H4M35RSuo86qgdB59qtLHQLcGq45fieDaM4lWpz2bbLmqIzSIbUCNJ/Kyjs9oLLCdy0lLC65qiJSPp+/T7ijGttx11Y3gw6bTMqgXNJAlHZ4oI1SnyFPKqSenEWt2WETTRgTYpg1ONhxi/0i87A7KgmcVWKq19l2yfM5xBLsQvfIpObFN+r2Oy8xM5hP0UKa+9gcuHnuD1dntUz1QTrON4qatwSC0PKlD9bGA6tREcpb5pMda6SZ3b2WFmRw8RWxIy/u68YPJw4mu/aNYcYTmIRf+VQbwoudusOpyLHuOuFenJSO+tMS1yrTq3/oJaucMDR/2kiyG4JInMlVi3DX5EmbkkzDZSZlT5iRNaP3Yf3szNwKucewhQ6kfcg0KEeFPWnTutbBl+X9uHDoUMRfLflqSygp94CmoicWCUvfzyHJzTAp3lz4Nk82twkkT2fF7Ab5acroiTSi7WjmkNBaM4dBDJoucawCDQDE/rFwu3uk+E0/yO2JLbhDBYSibOBggtiwAdQWVtQbTYOkYZgkjsPvbQn7R9aA+NkPUlhKUZQEKh3KvhXCyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(66946007)(66556008)(86362001)(83380400001)(26005)(316002)(66476007)(426003)(2906002)(5660300002)(36756003)(33656002)(30864003)(4326008)(2616005)(9786002)(8936002)(110136005)(1076003)(8676002)(478600001)(38100700002)(186003)(33964004)(44144004)(66574015)(21480400003)(9746002)(27376004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajh1MDh6Q212ZVQ5RGJvMU9uWW5XKzBFVkQzKzNVb0ZxQ2lSWjZHMFN5Ymsy?=
 =?utf-8?B?TzZRUjJhU0ZxK2QyOTExYzNEWEhCamlrYzFYL3BETjN3QzRTKzA0eDdmcEdQ?=
 =?utf-8?B?OEFzajdoV0NydmhBaHBMcXRxQkNjai9adFlveFR0RWprNlhsT0tRdFNPREQw?=
 =?utf-8?B?MGh3Zi9pMGMxY2FwS1JwaEFubmNNZmpXbTA4TUtESjFhMEVScWhDQTdkSWFL?=
 =?utf-8?B?N0w5VVpZbGdZMFVNZFBmSG9KVHRDVXk4QlFDRDNQSXJTZXlldnVFRGc5K3Np?=
 =?utf-8?B?b3IxUVZyZkEzaHViMENHeEpWdXBYNVR2MHJWYUx3M2xLVEZiQVMyUWdjUmh1?=
 =?utf-8?B?a2h0Tm4zTU81NHRpZjRzcEZveWppU3JJT01HUGxhdklmZXFPaE5xMlRaN29E?=
 =?utf-8?B?bjlCNkt3KzI1V0xQQm9MbWRLWUdKdGxTNUhVQzN5Q3YrUDJyQ0hBRWl5V2VR?=
 =?utf-8?B?S1V2Y3ZYUjRjSEZncWlnTDNrdG9RTmJPYmNBRjJoVk9zQ2VoVjVlTG5yRlV6?=
 =?utf-8?B?SHQ1ZHdRSWtSYXdJbmx5WitpS3c3TjRhV3Z1dkh3dnl4Y2ZXSzNXK1cwcGNo?=
 =?utf-8?B?WFRMMkZiNkZjeTJJYzJXR3BsK0dYY3JVamNCMkdWN3NOWDVBR1BieUxGR0xo?=
 =?utf-8?B?VzVwL1cwcTA4bHhsTEZBa3BuR1ZpRlNMbGxXMkI5RTdFVmRndEFndS8ycjQw?=
 =?utf-8?B?RHFiTjU2ZzJ6dFU0UU9YOENuSmZnRVVFMUNqc2t1SjNJdmdoaG9VV2xzZllJ?=
 =?utf-8?B?dkF3djlycVNHbmRZUDZYL0ZoVXBrRFU0R01JYXJYRzZzTmVBNkUwTndSMUcw?=
 =?utf-8?B?TlZYNEt1bDZja0VwQThRQm54ZHU2RmZwWXhwTlFPZlhnc0REd1JDeGYxSkRC?=
 =?utf-8?B?TiszcHhLbFcya1M2MkpWaEpwRTMzbHpscUR1NGlxTUh1bzNZZ1Qyd2ZPSi9u?=
 =?utf-8?B?NjBCZmxLakFHMDZhQlo2NlNGSFZsQm1ZUnBlbnY2WkRGTHJRSWxsSVRnZy9j?=
 =?utf-8?B?cGRKc1JuZUhDTHY4YWRCTGR4ajBZTGZFTXVDQjIxV3NPOHBxM2xWSVdodXZT?=
 =?utf-8?B?YUZEM2JLTnR6N1hDb2RGWEhmMnRYR0w5c3pFKzU0TTlJNGFUeE9tTlRtS1ZB?=
 =?utf-8?B?ekZqM3UyZnhOVkhwNkd0ZDd0NVFjMmdVaktpbHZVVkI3dmlVK1RpaVNGOGR2?=
 =?utf-8?B?RWM4Zm54YW1rR0FtNlBtR0ZNbEpVdGJTeXBnVVUxK09vWjcyQlcvd1dEaWJj?=
 =?utf-8?B?RWNyWGl4YUZKVnYzdythU3psS1QzaVNLQkNneTR1eHErOEsxeFU2YW9mSVoz?=
 =?utf-8?B?aXNGU0dDMCtiK3lkRzM2TkVxcU1jVE5LTzAyNUNlcC9qMGF0Q2NzYVNOejhl?=
 =?utf-8?B?bDN4a3MxYm1RMlNWT0k1OVBDTDc0U1U3d3lRTUptNkxzczNVRXp1NGRGT3FJ?=
 =?utf-8?B?UG5LZGVxTGd5UmFnWWk0Q045Z1BvVHl0VXpXRWtZallDWjgzOUlIaysvT1Zn?=
 =?utf-8?B?am9jRHZDWnhlVEJNbTZNYldiZ1N1ZENIdW9hK1hTVEhuTDBOd0ozTjVhWEVY?=
 =?utf-8?B?SHhKY1E2MDhVSk1NNEI0TzJkQkl2UEZqQWVGOG9Ibm5uWTBuWlZpYlBnL3Jp?=
 =?utf-8?B?RS94ZXdLNWlpcjRXUTRMOTRKUGtzaHAyeWFOUzJ5bGlPa216L25SZndLeWNt?=
 =?utf-8?B?K0h6NGVGVEtTQVIzQzVYY0t2TVB6UFJvTVM5SVF1WGkvbzU2OEtJYzBKUW1V?=
 =?utf-8?Q?GNRC6z020kx+Uoaxh4sdJ4FBlbzMx9T61KBFF6P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86d2ba8-a8a7-4071-30f3-08d93c2fcf67
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 01:30:29.3020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36NCdMzGc34zoKpuWXMX7f4aUFPsVVuppQpTZ9P4KZXSZp5TkJUs7726b3w5/rjm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5480
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

These are the proposed RDMA patches for 5.14.

This PR has a very huge diffstat due to finally merging the
replacement Intel RDMA driver. I first heard about this project at LPC
2018, which means it took about three years to do this (and at least
10 postings). The new driver is in many ways a rewrite of the old
driver and continues to support the old hardware but is now structured
to support the new Intel HW as well. Normally a rip and replace
shouldn't be done, but Intel believed that this was necessary and have
been shipping it already for several years out of tree. There will be
some followup patches for this next cycle(s) as several difficult
features were not included. Hopefully the several weeks in linux-next
cleaned out most of the static checker detections.

Otherwise the rest of the PR is fairly typical for RDMA, cleanups and
driver changes with HNS leading the pack this time.

Thanks,
Jason

The following changes since commit 13311e74253fe64329390df80bed3f07314ddd61:

  Linux 5.13-rc7 (2021-06-20 15:03:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 3d8287544223a3d2f37981c1f9ffd94d0b5e9ffc:

  RDMA/core: Always release restrack object (2021-06-29 19:57:18 -0300)

----------------------------------------------------------------
RDMA v5.14 merge window Pull Request

This PR contains a replacement driver for Intel iWarp hardware. This new
driver supports the old ethernet hardware and also newer chips that can do
ROCE. Otherwise this contains the typical mix of patches:

- Driver updates and cleanups for bnxt_re, cxgb4, mlx4, and mlx5

- Many static checker driven code clean ups, including a wide refcount_t
  conversion

- Several series for the hns driver, more HIP09 HW capabilities, migration
  to new HW register manipulators, and code cleanups

- Minor fixes and improvements  in srp, rts, and cm

- Improvements throughout for sysfs related code to use DEVICE_ATTR_*,
  make the ib_port sysfs first-class, and overall use sysfs APIs properly

- Intel's new irdma driver replacing i40iw

- rxe general clean ups and Memory Window support

----------------------------------------------------------------
Aharon Landau (2):
      RDMA/mlx5: Refactor get_ts_format functions to simplify code
      RDMA/mlx5: Support real-time timestamp directly from the device

Anand Khoje (2):
      IB/core: Removed port validity check from ib_get_cached_subnet_prefix
      IB/core: Shuffle locks in ib_port_data to save memory

Avihai Horon (1):
      RDMA/mlx5: Enable Relaxed Ordering by default for kernel ULPs

Baokun Li (1):
      RDMA/irdma: Use list_move instead of list_del/list_add

Bart Van Assche (5):
      IB/hfi1: Move a function from a header file into a .c file
      RDMA/srp: Add more structure size checks
      RDMA/srp: Apply the __packed attribute to members instead of structur=
es
      RDMA/srp: Fix a recently introduced memory leak
      RDMA/srp: Make struct scsi_cmnd and struct srp_request adjacent

Bob Pearson (20):
      RDMA/rxe: Add a type flag to rxe_queue structs
      RDMA/rxe: Protect user space index loads/stores
      RDMA/rxe: Protext kernel index from user space
      RDMA/rxe: Fix qp reference counting for atomic ops
      RDMA/rxe: Add bind MW fields to rxe_send_wr
      RDMA/rxe: Return errors for add index and key
      RDMA/rxe: Enable MW object pool
      RDMA/rxe: Add ib_alloc_mw and ib_dealloc_mw verbs
      RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
      RDMA/rxe: Move local ops to subroutine
      RDMA/rxe: Add support for bind MW work requests
      RDMA/rxe: Implement invalidate MW operations
      RDMA/rxe: Implement memory access through MWs
      RDMA/rxe: Disallow MR dereg and invalidate when bound
      RDMA/rxe: Fix useless copy in send_atomic_ack
      RDMA/rxe: Fix redundant call to ip_send_check
      RDMA/rxe: Fix extra copies in build_rdma_network_hdr
      RDMA/rxe: Fix over copying in get_srq_wqe
      RDMA/rxe: Fix extra copy in prepare_ack_packet
      RDMA/rxe: Fix redundant skb_put_zero

Colin Ian King (5):
      RDMA/irdma: Fix issues with u8 left shift operation
      RDMA/irdma: remove extraneous indentation on a statement
      RDMA/irdma: remove redundant initialization of variable val
      RDMA/irdma: Fix spelling mistake "Allocal" -> "Allocate"
      RDMA/bnxt_re: Fix uninitialized struct bit field rsvd1

Dan Carpenter (1):
      RDMA/rxe: Missing unlock on error in get_srq_wqe()

Devesh Sharma (3):
      RDMA/bnxt_re: Enable global atomic ops if platform supports
      RDMA/bnxt_re: Update maintainers list
      RDMA/bnxt_re: Update ABI to pass wqe-mode to user space

Dima Stepanov (1):
      RDMA/rtrs: Use strscpy instead of strlcpy

Gerd Rausch (1):
      RDMA/cma: Fix rdma_resolve_route() memory leak

Gioh Kim (7):
      RDMA/rtrs-clt: Remove MAX_SESS_QUEUE_DEPTH from rtrs_send_sess_info
      RDMA/rtrs: Change MAX_SESS_QUEUE_DEPTH
      RDMA/rtrs: Define MIN_CHUNK_SIZE
      RDMA/rtrs: Do not reset hb_missed_max after re-connection
      RDMA/rtrs-srv: Duplicated session name is not allowed
      RDMA/rtrs-srv: Fix memory leak of unfreed rtrs_srv_stats object
      RDMA/rtrs-clt: Fix memory leak of not-freed sess->stats and stats->pc=
pu_stats

Guenter Roeck (1):
      RDMA/bnxt_re: Drop unnecessary NULL checks after container_of

Guoqing Jiang (7):
      RDMA/rtrs-srv: Kill reject_w_econnreset label
      RDMA/rtrs-srv: Clean up the code in __rtrs_srv_change_state
      RDMA/rtrs-clt: Kill rtrs_clt_{start,stop}_hb
      RDMA/rtrs-clt: Kill rtrs_clt_disconnect_from_sysfs
      RDMA/rtrs-srv: Kill __rtrs_srv_change_state
      RDMA/rtrs-clt: Remove redundant 'break'
      RDMA/rtrs: Rename cq_size/queue_size to cq_num/queue_num

H=C3=A5kon Bugge (5):
      IB/core: Only update PKEY and GID caches on respective events
      RDMA/cma: Remove unnecessary INIT->INIT transition
      RDMA/cma: Protect RMW with qp_mutex
      RDMA/cma: Fix incorrect Packet Lifetime calculation
      RDMA/core/sa_query: Remove unused argument

Ira Weiny (2):
      RDMA/irdma: Remove use of kmap()
      RDMA/hfi1: Remove use of kmap()

Jack Wang (11):
      RDMA/rtrs-srv: convert scnprintf to sysfs_emit
      RDMA/rtrs-srv: Fix memory leak when having multiple sessions
      RDMA/rtrs: Avoid Wtautological-constant-out-of-range-compare
      RDMA/rtrs-srv: Set minimal max_send_wr and max_recv_wr
      RDMA/rtrs-clt: Use minimal max_send_sge when create qp
      RDMA/rtrs: Check device max_qp_wr limit when create QP
      RDMA/rtrs: Introduce head/tail wr
      RDMA/rtrs-clt: Write path fast memory registration
      RDMA/rtrs_clt: Alloc less memory with write path fast memory registra=
tion
      RDMA/rtrs-clt: Raise MAX_SEGMENTS
      rnbd/rtrs-clt: Query and use max_segments from rtrs-clt.

Jason Gunthorpe (24):
      IB/cm: Pair cm_alloc_response_msg() with a cm_free_response_msg()
      IB/cm: Split cm_alloc_msg()
      IB/cm: Call the correct message free functions in cm_send_handler()
      IB/cm: Tidy remaining cm_msg free paths
      Merge branch 'irdma' into rdma.git for-next
      RDMA/core: Remove refcount from struct ib_mad_snoop_private
      IB/cm: Remove dgid from the cm_id_priv av
      RDMA: Split the alloc_hw_stats() ops to port and device variants
      RDMA/core: Replace the ib_port_data hw_stats pointers with a ib_port =
pointer
      RDMA/core: Split port and device counter sysfs attributes
      RDMA/core: Split gid_attrs related sysfs from add_port()
      RDMA/core: Simplify how the gid_attrs sysfs is created
      RDMA/core: Simplify how the port sysfs is created
      RDMA/core: Create the device hw_counters through the normal groups me=
chanism
      RDMA/core: Remove the kobject_uevent() NOP
      RDMA/core: Expose the ib port sysfs attribute machinery
      RDMA/cm: Use an attribute_group on the ib_port_attribute intead of ko=
bj's
      RDMA/qib: Use attributes for the port sysfs
      RDMA/hfi1: Use attributes for the port sysfs
      RDMA: Change ops->init_port to ops->port_groups
      RDMA/core: Allow port_groups to be used with namespaces
      RDMA: Remove rdma_set_device_sysfs_group()
      Merge tag 'v5.13-rc7' into rdma.git for-next
      Merge branch 'mlx5_realtime_ts' into rdma.git for-next

Jiapeng Chong (1):
      RDMA/cxgb4: Fix missing error code in create_qp()

Kamal Heib (3):
      RDMA/rxe: Fix failure during driver load
      RDMA/irdma: Fix return error sign from irdma_modify_qp
      RDMA/irdma: Use the queried port attributes

Kees Cook (2):
      IB/mlx4: Avoid field-overflowing memcpy()
      RDMA/core: Use flexible array for mad data

Lang Cheng (13):
      RDMA/hns: Remove unused parameter udata
      RDMA/mlx4: Remove unused parameter udata
      RDMA/mlx5: Remove unused parameter udata
      RDMA/rxe: Remove unused parameter udata
      RDMA/hns: Rename CMDQ head/tail pointer to PI/CI
      RDMA/hns: Remove Receive Queue of CMDQ
      RDMA/hns: Remove unused CMDQ member
      RDMA/hns: Add hr_reg_write_bool()
      RDMA/hns: Use new interface to modify QP context
      RDMA/hns: Use new interface to get CQE fields
      RDMA/hns: Force rewrite inline flag of WQE
      RDMA/hns: Fix spelling mistakes of original
      RDMA/hns: Add vendor_err info to error WC

Leon Romanovsky (6):
      RDMA/core: Remove never used ib_modify_wq function call
      RDMA/core: Sanitize WQ state received from the userspace
      RDMA/mlx5: Don't add slave port to unaffiliated list
      RDMA: Fix kernel-doc warnings about wrong comment
      RDMA/mlx5: Don't access NULL-cleared mpi pointer
      RDMA/core: Always release restrack object

Maor Gottlieb (1):
      RDMA/mlx5: Take qp type from mlx5_ib_qp

Mark Zhang (4):
      Revert "IB/cm: Mark stale CM id's whenever the mad agent was unregist=
ered"
      IB/cm: Simplify ib_cancel_mad() and ib_modify_mad() calls
      IB/cm: Improve the calling of cm_init_av_for_lap and cm_init_av_by_pa=
th
      IB/cm: Protect cm_dev, cm_ports and mad_agent with kref and lock

Max Gurtovoy (2):
      IB/isert: set rdma cm afonly flag
      IB/isert: Align target max I/O size to initiator size

Md Haris Iqbal (5):
      RDMA/rtrs-srv: Add error messages for cases when failing RDMA connect=
ion
      RDMA/rtrs-clt: Check state of the rtrs_clt_sess before reading its st=
ats
      RDMA/rtrs-srv: Replace atomic_t with percpu_ref for ids_inflight
      RDMA/rtrs-clt: Check if the queue_depth has changed during a reconnec=
tion
      RDMA/rtrs: RDMA_RXE requires more number of WR

Michael J. Ruhl (1):
      RDMA/irdma: Add dynamic tracing for CM

Mustafa Ismail (13):
      RDMA/irdma: Register auxiliary driver and implement private channel O=
Ps
      RDMA/irdma: Implement device initialization definitions
      RDMA/irdma: Implement HW Admin Queue OPs
      RDMA/irdma: Add HMC backing store setup functions
      RDMA/irdma: Add privileged UDA queue implementation
      RDMA/irdma: Add QoS definitions
      RDMA/irdma: Add connection manager
      RDMA/irdma: Add PBLE resource manager
      RDMA/irdma: Implement device supported verb APIs
      RDMA/irdma: Add RoCEv2 UD OP support
      RDMA/irdma: Add user/kernel shared libraries
      RDMA/irdma: Add miscellaneous utility definitions
      RDMA/irdma: Add ABI definitions

Selvin Xavier (1):
      MAINTAINERS: Update Broadcom RDMA maintainers

Sergey Gorenko (2):
      RDMA/mlx5: Support SQD2RTS for modify QP
      RDMA/mlx5: Add SQD2RTS bit to the alloc ucontext response

Shaokun Zhang (1):
      IB/hfi1: Remove the repeated declaration

Shiraz Saleem (7):
      RDMA/irdma: Add irdma Kconfig/Makefile and remove i40iw
      RDMA/irdma: Update MAINTAINERS file
      RDMA/irdma: Use list_last_entry/list_first_entry
      RDMA/irdma: Store PBL info address a pointer type
      RDMA/irdma: Check return value from ib_umem_find_best_pgsz
      RDMA/irdma: Check contents of user-space irdma_mem_reg_req object
      RDMA/irdma: Fix potential overflow expression in irdma_prm_get_pbles

Tian Tao (1):
      RDMA/cxgb4: Remove useless assignments

Wan Jiabing (1):
      RDMA: Remove unnecessary struct declaration

Weihang Li (14):
      RDMA/hns: Use refcount_t APIs for HEM
      RDMA/core: Use refcount_t instead of atomic_t on refcount of iwcm_id_=
private
      RDMA/core: Use refcount_t instead of atomic_t on refcount of iwpm_adm=
in_data
      RDMA/core: Use refcount_t instead of atomic_t on refcount of mcast_me=
mber
      RDMA/core: Use refcount_t instead of atomic_t on refcount of mcast_po=
rt
      RDMA/hns: Use refcount_t instead of atomic_t for CQ reference counting
      RDMA/hns: Use refcount_t instead of atomic_t for SRQ reference counti=
ng
      RDMA/hns: Use refcount_t instead of atomic_t for QP reference counting
      RDMA/cxgb4: Use refcount_t instead of atomic_t for reference counting
      RDMA/ipoib: Use refcount_t instead of atomic_t for reference counting
      RDMA/core: Use refcount_t instead of atomic_t on refcount of ib_uverb=
s_device
      RDMA/hns: Do not use !! for values that are already bool when calling=
 hr_reg_write()
      RDMA/hns: Add a check to ensure integer mtu is positive
      RDMA/hns: Fix incorrect vlan enable bit in QPC

Wenpeng Liang (2):
      RDMA/core: Fix incorrect print format specifier
      RDMA/hns: Encapsulate flushing CQE as a function

Xi Wang (10):
      RDMA/hns: Refactor extend link table allocation
      RDMA/hns: Optimize the base address table config for MTR
      RDMA/hns: Refactor root BT allocation for MTR
      RDMA/hns: Fix wrong timer context buffer page size
      RDMA/hns: Clean the hardware related code for HEM
      RDMA/hns: Refactor capability configuration flow of VF
      RDMA/hns: Support getting max QP number from firmware
      RDMA/hns: Clear extended doorbell info before using
      RDMA/hns: Clean SRQC structure definition
      RDMA/hns: Clean definitions of EQC structure

Xiao Yang (1):
      RDMA/rxe: Don't overwrite errno from ib_umem_get()

Xiaofei Tan (1):
      RDMA/ucma: Cleanup to reduce duplicate code

Yang Li (2):
      RDMA/mlx5: Remove redundant assignment to ret
      IB/srpt: Remove redundant assignment to ret

Yangyang Li (9):
      RDMA/hns: Remove the unused hns_roce_bitmap_alloc_range function
      RDMA/hns: Remove the unused hns_roce_bitmap_free_range function
      RDMA/hns: Remove unused RR mechanism
      RDMA/hns: Use IDA interface to manage mtpt index
      RDMA/hns: Use IDA interface to manage pd index
      RDMA/hns: Use IDA interface to manage xrcd index
      RDMA/hns: Add member assignments for qp_init_attr
      RDMA/hns: Delete unnecessary branch of hns_roce_v2_query_qp
      RDMA/hns: Modify function return value type

Yixian Liu (1):
      RDMA/hns: Remove the condition of light load for posting DWQE

Yixing Liu (7):
      RDMA/hns: Use new interface to write CQ context.
      RDMA/hns: Use new interface to write FRMR fields
      RDMA/hns: Use new interface to write DB related fields
      RDMA/hns: Fix uninitialized variable
      RDMA/hns: Fix some print issues
      RDMA/hns: Simplify the judgment in hns_roce_v2_post_send()
      RDMA/hns: Add window selection field of congestion control

YueHaibing (3):
      IB/ipoib: Use DEVICE_ATTR_*() macros
      RDMA/core: Use the DEVICE_ATTR_RO macro
      RDMA/srp: Use DEVICE_ATTR_*() macros

Zhen Lei (1):
      IB/hfi1: Delete an unneeded bool conversion

 Documentation/ABI/stable/sysfs-class-infiniband    |   20 -
 MAINTAINERS                                        |   20 +-
 drivers/block/rnbd/rnbd-clt.c                      |    5 +-
 drivers/block/rnbd/rnbd-clt.h                      |    5 +-
 drivers/infiniband/Kconfig                         |    2 +-
 drivers/infiniband/core/cache.c                    |   40 +-
 drivers/infiniband/core/cm.c                       |  863 ++-
 drivers/infiniband/core/cma.c                      |   48 +-
 drivers/infiniband/core/core_priv.h                |   15 +-
 drivers/infiniband/core/counters.c                 |    4 +-
 drivers/infiniband/core/device.c                   |   41 +-
 drivers/infiniband/core/iwcm.c                     |    9 +-
 drivers/infiniband/core/iwcm.h                     |    2 +-
 drivers/infiniband/core/iwpm_msg.c                 |   22 +-
 drivers/infiniband/core/iwpm_util.c                |   16 +-
 drivers/infiniband/core/iwpm_util.h                |    4 +-
 drivers/infiniband/core/mad.c                      |   27 +-
 drivers/infiniband/core/mad_priv.h                 |    1 -
 drivers/infiniband/core/multicast.c                |   20 +-
 drivers/infiniband/core/netlink.c                  |    2 +-
 drivers/infiniband/core/nldev.c                    |   10 +-
 drivers/infiniband/core/roce_gid_mgmt.c            |    5 +-
 drivers/infiniband/core/rw.c                       |    8 +-
 drivers/infiniband/core/sa_query.c                 |   10 +-
 drivers/infiniband/core/security.c                 |    9 +-
 drivers/infiniband/core/sysfs.c                    | 1110 ++--
 drivers/infiniband/core/ucma.c                     |   11 +-
 drivers/infiniband/core/ud_header.c                |    8 +-
 drivers/infiniband/core/umem_odp.c                 |    2 +-
 drivers/infiniband/core/user_mad.c                 |    4 +-
 drivers/infiniband/core/uverbs.h                   |    2 +-
 drivers/infiniband/core/uverbs_cmd.c               |   23 +-
 drivers/infiniband/core/uverbs_main.c              |   12 +-
 drivers/infiniband/core/uverbs_uapi.c              |    2 +-
 drivers/infiniband/core/verbs.c                    |   23 +-
 drivers/infiniband/hw/Makefile                     |    2 +-
 drivers/infiniband/hw/bnxt_re/hw_counters.c        |    7 +-
 drivers/infiniband/hw/bnxt_re/hw_counters.h        |    4 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |   30 +-
 drivers/infiniband/hw/bnxt_re/main.c               |   19 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |    2 +
 drivers/infiniband/hw/bnxt_re/qplib_res.c          |   17 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h          |    7 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |   13 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h           |    2 -
 drivers/infiniband/hw/cxgb4/cq.c                   |    6 +-
 drivers/infiniband/hw/cxgb4/ev.c                   |    8 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h             |    2 +-
 drivers/infiniband/hw/cxgb4/provider.c             |   11 +-
 drivers/infiniband/hw/cxgb4/qp.c                   |    2 +-
 drivers/infiniband/hw/efa/efa.h                    |    3 +-
 drivers/infiniband/hw/efa/efa_main.c               |    3 +-
 drivers/infiniband/hw/efa/efa_verbs.c              |   11 +-
 drivers/infiniband/hw/hfi1/chip.c                  |    4 +-
 drivers/infiniband/hw/hfi1/file_ops.c              |    6 +-
 drivers/infiniband/hw/hfi1/hfi.h                   |    9 +-
 drivers/infiniband/hw/hfi1/init.c                  |    4 +-
 drivers/infiniband/hw/hfi1/pio.c                   |    2 +-
 drivers/infiniband/hw/hfi1/pio.h                   |    2 -
 drivers/infiniband/hw/hfi1/sdma.c                  |    4 +-
 drivers/infiniband/hw/hfi1/sysfs.c                 |  530 +-
 drivers/infiniband/hw/hfi1/tid_rdma.c              |    2 +-
 drivers/infiniband/hw/hfi1/trace.c                 |    5 +
 drivers/infiniband/hw/hfi1/verbs.c                 |   92 +-
 drivers/infiniband/hw/hns/hns_roce_alloc.c         |  114 +-
 drivers/infiniband/hw/hns/hns_roce_common.h        |   12 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c            |   15 +-
 drivers/infiniband/hw/hns/hns_roce_db.c            |    3 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        |   72 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c           |  371 +-
 drivers/infiniband/hw/hns/hns_roce_hem.h           |   13 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |   79 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.h         |    5 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         | 1983 +++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |  969 ++--
 drivers/infiniband/hw/hns/hns_roce_main.c          |   40 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c            |   84 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c            |   94 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |   47 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c           |   22 +-
 drivers/infiniband/hw/i40iw/Kconfig                |    9 -
 drivers/infiniband/hw/i40iw/Makefile               |    9 -
 drivers/infiniband/hw/i40iw/i40iw.h                |  602 ---
 drivers/infiniband/hw/i40iw/i40iw_cm.c             | 4419 ---------------
 drivers/infiniband/hw/i40iw/i40iw_cm.h             |  462 --
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c           | 5243 ----------------=
--
 drivers/infiniband/hw/i40iw/i40iw_d.h              | 1746 ------
 drivers/infiniband/hw/i40iw/i40iw_hmc.c            |  821 ---
 drivers/infiniband/hw/i40iw/i40iw_hmc.h            |  241 -
 drivers/infiniband/hw/i40iw/i40iw_hw.c             |  851 ---
 drivers/infiniband/hw/i40iw/i40iw_main.c           | 2064 -------
 drivers/infiniband/hw/i40iw/i40iw_osdep.h          |  195 -
 drivers/infiniband/hw/i40iw/i40iw_p.h              |  129 -
 drivers/infiniband/hw/i40iw/i40iw_pble.c           |  611 ---
 drivers/infiniband/hw/i40iw/i40iw_pble.h           |  131 -
 drivers/infiniband/hw/i40iw/i40iw_puda.c           | 1496 ------
 drivers/infiniband/hw/i40iw/i40iw_puda.h           |  188 -
 drivers/infiniband/hw/i40iw/i40iw_register.h       | 1030 ----
 drivers/infiniband/hw/i40iw/i40iw_status.h         |  101 -
 drivers/infiniband/hw/i40iw/i40iw_type.h           | 1358 -----
 drivers/infiniband/hw/i40iw/i40iw_uk.c             | 1200 -----
 drivers/infiniband/hw/i40iw/i40iw_user.h           |  422 --
 drivers/infiniband/hw/i40iw/i40iw_utils.c          | 1518 ------
 drivers/infiniband/hw/i40iw/i40iw_verbs.c          | 2652 ---------
 drivers/infiniband/hw/i40iw/i40iw_verbs.h          |  179 -
 drivers/infiniband/hw/i40iw/i40iw_vf.c             |   85 -
 drivers/infiniband/hw/i40iw/i40iw_vf.h             |   62 -
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c       |  759 ---
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.h       |  124 -
 drivers/infiniband/hw/irdma/Kconfig                |   12 +
 drivers/infiniband/hw/irdma/Makefile               |   27 +
 drivers/infiniband/hw/irdma/cm.c                   | 4421 +++++++++++++++
 drivers/infiniband/hw/irdma/cm.h                   |  417 ++
 drivers/infiniband/hw/irdma/ctrl.c                 | 5657 ++++++++++++++++=
++++
 drivers/infiniband/hw/irdma/defs.h                 | 1155 ++++
 drivers/infiniband/hw/irdma/hmc.c                  |  710 +++
 drivers/infiniband/hw/irdma/hmc.h                  |  180 +
 drivers/infiniband/hw/irdma/hw.c                   | 2725 ++++++++++
 drivers/infiniband/hw/irdma/i40iw_hw.c             |  216 +
 drivers/infiniband/hw/irdma/i40iw_hw.h             |  160 +
 drivers/infiniband/hw/irdma/i40iw_if.c             |  216 +
 drivers/infiniband/hw/irdma/icrdma_hw.c            |  149 +
 drivers/infiniband/hw/irdma/icrdma_hw.h            |   71 +
 drivers/infiniband/hw/irdma/irdma.h                |  153 +
 drivers/infiniband/hw/irdma/main.c                 |  358 ++
 drivers/infiniband/hw/irdma/main.h                 |  555 ++
 drivers/infiniband/hw/irdma/osdep.h                |   86 +
 drivers/infiniband/hw/irdma/pble.c                 |  520 ++
 drivers/infiniband/hw/irdma/pble.h                 |  136 +
 drivers/infiniband/hw/irdma/protos.h               |  116 +
 drivers/infiniband/hw/irdma/puda.c                 | 1744 ++++++
 drivers/infiniband/hw/irdma/puda.h                 |  194 +
 drivers/infiniband/hw/irdma/status.h               |   71 +
 drivers/infiniband/hw/irdma/trace.c                |  112 +
 drivers/infiniband/hw/irdma/trace.h                |    3 +
 drivers/infiniband/hw/irdma/trace_cm.h             |  458 ++
 drivers/infiniband/hw/irdma/type.h                 | 1541 ++++++
 drivers/infiniband/hw/irdma/uda.c                  |  271 +
 drivers/infiniband/hw/irdma/uda.h                  |   89 +
 drivers/infiniband/hw/irdma/uda_d.h                |  128 +
 drivers/infiniband/hw/irdma/uk.c                   | 1684 ++++++
 drivers/infiniband/hw/irdma/user.h                 |  437 ++
 drivers/infiniband/hw/irdma/utils.c                | 2541 +++++++++
 drivers/infiniband/hw/irdma/verbs.c                | 4544 ++++++++++++++++
 drivers/infiniband/hw/irdma/verbs.h                |  225 +
 drivers/infiniband/hw/irdma/ws.c                   |  406 ++
 drivers/infiniband/hw/irdma/ws.h                   |   41 +
 drivers/infiniband/hw/mlx4/cq.c                    |    8 +-
 drivers/infiniband/hw/mlx4/main.c                  |   27 +-
 drivers/infiniband/hw/mlx4/qp.c                    |   11 +-
 drivers/infiniband/hw/mlx5/counters.c              |   42 +-
 drivers/infiniband/hw/mlx5/cq.c                    |   10 +-
 drivers/infiniband/hw/mlx5/doorbell.c              |    3 +-
 drivers/infiniband/hw/mlx5/main.c                  |   19 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |   12 +-
 drivers/infiniband/hw/mlx5/mr.c                    |   12 +-
 drivers/infiniband/hw/mlx5/odp.c                   |    5 +-
 drivers/infiniband/hw/mlx5/qp.c                    |  177 +-
 drivers/infiniband/hw/mlx5/qpc.c                   |    6 +
 drivers/infiniband/hw/mlx5/srq.c                   |    2 +-
 drivers/infiniband/hw/mlx5/wr.c                    |   14 +-
 drivers/infiniband/hw/mthca/mthca_provider.c       |    2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c         |    2 +-
 drivers/infiniband/hw/qedr/main.c                  |    2 +-
 drivers/infiniband/hw/qib/qib.h                    |    8 +-
 drivers/infiniband/hw/qib/qib_sysfs.c              |  616 +--
 drivers/infiniband/hw/qib/qib_verbs.c              |    6 +-
 drivers/infiniband/hw/usnic/usnic_ib_main.c        |    3 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c     |    2 +-
 drivers/infiniband/sw/rdmavt/mr.c                  |    4 +-
 drivers/infiniband/sw/rdmavt/qp.c                  |    3 +-
 drivers/infiniband/sw/rdmavt/vt.c                  |    6 +-
 drivers/infiniband/sw/rxe/Makefile                 |    1 +
 drivers/infiniband/sw/rxe/rxe.c                    |    1 +
 drivers/infiniband/sw/rxe/rxe_comp.c               |   36 +-
 drivers/infiniband/sw/rxe/rxe_cq.c                 |   32 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.c        |    7 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.h        |    4 +-
 drivers/infiniband/sw/rxe/rxe_loc.h                |   38 +-
 drivers/infiniband/sw/rxe/rxe_mr.c                 |  130 +-
 drivers/infiniband/sw/rxe/rxe_mw.c                 |  343 ++
 drivers/infiniband/sw/rxe/rxe_net.c                |   14 +-
 drivers/infiniband/sw/rxe/rxe_opcode.c             |   11 +-
 drivers/infiniband/sw/rxe/rxe_opcode.h             |    3 +-
 drivers/infiniband/sw/rxe/rxe_param.h              |   19 +-
 drivers/infiniband/sw/rxe/rxe_pool.c               |   45 +-
 drivers/infiniband/sw/rxe/rxe_pool.h               |    8 +-
 drivers/infiniband/sw/rxe/rxe_qp.c                 |   23 +-
 drivers/infiniband/sw/rxe/rxe_queue.c              |   21 +-
 drivers/infiniband/sw/rxe/rxe_queue.h              |  272 +-
 drivers/infiniband/sw/rxe/rxe_req.c                |  159 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |  208 +-
 drivers/infiniband/sw/rxe/rxe_srq.c                |    5 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |  101 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h              |   53 +-
 drivers/infiniband/ulp/ipoib/ipoib.h               |    4 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |    8 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |   48 +-
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c          |    4 +-
 drivers/infiniband/ulp/iser/iser_verbs.c           |    2 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |   18 +-
 drivers/infiniband/ulp/isert/ib_isert.h            |    3 -
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c       |    5 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |  254 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.h             |    6 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h             |   27 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c       |   12 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c       |    1 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             |  199 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.h             |    4 +-
 drivers/infiniband/ulp/rtrs/rtrs.c                 |   53 +-
 drivers/infiniband/ulp/rtrs/rtrs.h                 |    2 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |  256 +-
 drivers/infiniband/ulp/srp/ib_srp.h                |    2 -
 drivers/infiniband/ulp/srpt/ib_srpt.c              |    1 -
 drivers/net/ethernet/intel/i40e/i40e_client.c      |  149 -
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |    8 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.h    |   10 +-
 include/linux/mlx5/mlx5_ifc.h                      |   36 +-
 include/linux/mlx5/qp.h                            |    4 +-
 include/linux/net/intel/i40e_client.h              |    3 -
 include/rdma/ib_hdrs.h                             |    5 -
 include/rdma/ib_mad.h                              |   27 +-
 include/rdma/ib_sysfs.h                            |   37 +
 include/rdma/ib_verbs.h                            |   83 +-
 include/scsi/srp.h                                 |   26 +-
 include/uapi/rdma/bnxt_re-abi.h                    |   11 +-
 include/uapi/rdma/i40iw-abi.h                      |  107 -
 include/uapi/rdma/ib_user_ioctl_verbs.h            |    1 +
 include/uapi/rdma/ib_user_mad.h                    |    2 +-
 include/uapi/rdma/irdma-abi.h                      |  111 +
 include/uapi/rdma/mlx5-abi.h                       |    3 +
 include/uapi/rdma/rdma_user_rxe.h                  |   10 +
 233 files changed, 38023 insertions(+), 34428 deletions(-)
(diffstat from tag for-linus-merged)

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAmDdGrEACgkQOG33FX4g
mxoNvw/9E2EcO9w/ttlJBePV9SABuJLmyZWzypd9Qc7g6Boi/Z/KOCmdOyuej4FD
/fZRfaKEw6BbVtHpDS9VzYgxLysx/TJ+c8MuM00bCuH5PFc2HiogBi413JYHt2Vy
TuJor3vlacWmFTLMdiw8pPIZQlnYF/aVd/cWBu0QjU8vb7IE3+yYAxbKTxq4eBPK
B+cMeC9T6L8G4Ai72AUs/0ziSp1CfkHket14ApXBeqY2Sp0jqJxE9p40sq1MYYAH
e+x6Lvd0lSAgHWWsgD1YC4X0Tqk76Wimg5UVm2mSFG3CzWwWtroHzVx5egfktw+f
y7NuH8TZc/Rv2AGS67BhkJJEji7lpzA8IbVU/gdEOkPNOZ/eW2XisC3iolXqKGV0
HL6UEWQlIjQeO/3qmqIANIYgLD6c77t9Jsdiz3OFH+Gve4cxrUYiVw/LaN5n8gU6
l4lCY/of/fTwvf3Bh92EKpQ/Y1zZVrfkcKeO7QBnLhlQXSIGc7o53Axm7ahMiAy/
CHapMUexadB6oCAhOPWWJE2ccDAWv9LuN3B+yZsfePWIBXFZMdqOYWxGHOt6FeLj
k3Ylz8EM21B0/4VKi1V11DzgJ2jij/xwSfAWI4dHX4LsPgmdUZudjiuUssbASNFp
b+grFhaftSRg0s+ZEE9S0ohtSbrUsOL8WLoX5rrWvN2OsFv+SGQ=
=kAGi
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
