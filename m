Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D883E23E07C
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Aug 2020 20:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgHFSfK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Aug 2020 14:35:10 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5528 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgHFSej (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Aug 2020 14:34:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2c4b340000>; Thu, 06 Aug 2020 11:25:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Aug 2020 11:27:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Aug 2020 11:27:36 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Aug
 2020 18:27:36 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 6 Aug 2020 18:27:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Di6Fx1rH8skdHQ2psrk8OI1P1xTpi6OMSivmGpybQ0r+kPFxl+Z7lKNb/g1zJ+p4zYmNkYo85kEj+S4OzqHisTEMrpzUmXi51SLDlTUkw06Fu9XxM0Umiq8QH3NowGE5IKuBcMmgZzpO3esDrspM7DH/ll4wlZLTKyyqX83sNw7yQejReBusgA82O8u1Up2u0RMhNGLsM+c1q+rX8E6Byiu8BxXVn4IarBaosrMT01BUBfTyhlh7dRqI0fflVr0SE7eoplZ3/ae1Qbz54Z8AnkL/CbaB2EFeeHtgezqMBWRSRuXIVQ4giRgWGIVFohtfvEdnqlhkbzlBvgJVv5PEuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNkq9pCkQ1NdTrz45y8qel84TmzxbIFh0GtYOeBh8FY=;
 b=iZeA8mNBU0EI+qE4R4XKSGQZP9jJ5uJUb1NkZ8CCP47gZm1lt4XZzpVaVk1jMuxkpjTKR0u4w7CC4HF3FSBsr7NcI4KWrAEIUsbS6yoPg9skPZulkthJw7eMp8ZNwWtcXWGu1L9wtijsyLWSd6UmDmYfqVC8Mc29x2UY8Nk7VhJ7cqx8hnNHUa48UZho07A7XEe4zqctcn4X+66jii5deoiQ8Qq9h3TM0FhLNcew6Z6icM70lThL89Cvmqd07sKaE34vvHSSGu6Iyo1h5bQgbze6RzM/QCrkP9mmjdLxDQjB2remt98rDHAxpsqIpaf2oc7mqSu9sS81waPY6JDXcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Thu, 6 Aug
 2020 18:27:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3239.022; Thu, 6 Aug 2020
 18:27:34 +0000
Date:   Thu, 6 Aug 2020 15:27:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20200806182732.GA1062117@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
X-ClientProxiedBy: BL0PR02CA0083.namprd02.prod.outlook.com
 (2603:10b6:208:51::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0083.namprd02.prod.outlook.com (2603:10b6:208:51::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend Transport; Thu, 6 Aug 2020 18:27:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k3kc0-004Sfw-H0; Thu, 06 Aug 2020 15:27:32 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bced412-c158-4b3b-0347-08d83a36633a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3210:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3210B8743ECDD04FADAAED59C2480@DM6PR12MB3210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:49;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SE/Y0IySB5fT46FU9ff9qMkwaaHBeDAbwOZuEJpLtrwqsLzRiherUePghFNfgeg+guyOm6DCje5LuOCCpUZuHDj+3n7CKlHcOfcswFvqYp6dmsOxpldHxusYS4IIUCKf7c3bVluBAzomGa8u8FfBQprKPMRv41TL35teda7JGeQ98X9bmPz/aMUtcUv0HBA/ssxiZXR/u5XFo6kGfLl5eLOTbtHqwj7iz2gP1r54HfsoDQ1vNkbhpFCqLqkB6HHpYBlvhlPk8lF0u22AdGSSEFWKX8MS+ffXDLEw6eeh/i5D09+w3bQzXEdxdjr87mps7KjBb4h42GnnGbYNK/DJLrT0Vd5mznthku7PM+/R3/f37RLOcFy0XkU1TVv6t6Xd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(21480400003)(426003)(4326008)(86362001)(30864003)(2616005)(9746002)(33656002)(1076003)(83380400001)(9786002)(5660300002)(2906002)(26005)(8936002)(66556008)(478600001)(186003)(110136005)(316002)(8676002)(66476007)(66946007)(44144004)(36756003)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: VyyyEZvQwk6xD7i8y307TUbo0ajNvYp2MxWlTZo/Zcga+Z+Ih3uxB9xxxLEZATN7my7ATVfBgfmCbwkh45ITkOVLVmrEiRsGoTehntUnE+UrZxdyvI75V5/RAO/jFaD5ItKqyB8YDPLHc/HVw5/cUx3qJTUnLesCf40n2qoKM32iD7f4Og1rtZlnw7vaJow6pB4dAkZQS2GlBPvhx1mEnTeSPo6/5JM/8htf3Ch1hu8dTnvLQJr4n5CxHHkTs//VCErbaNI+Qdb4heeR6OhzYn11F7iRMyl7d+xi+tIG/oMOTdpcsSNo0cQ1ts9naBqanMG53cYrHopKOFnsVGi0+gn57xqDFJAXBzlG0OLZtsz1AgP/avZDgqDp+OyqwIAvWEsHpmqkMiJrOojg5w0HU06/30iZOEmjsKnQTMCktPNpp3xV+SA7ixq8jr7rnWlRRer1DA6mM/+6S99WgflKXdWmcRVl0dEsIpdwW1kj1tX7B8c2dsCGLVV2LD3L+eqwcAtYZzBVjRMvfE4hFsoLchNQqBucb6UnsXBgkDu+546gEG7N1UDP0KHjfegyXVaUalBoZsCeQn4xARqCaMpK3mxHKcdE8E3AKLhRZKZV/GCuYRRemrMtVFOoZBk+H33zIkvYEj0k2sWPlSMhnx3T/Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bced412-c158-4b3b-0347-08d83a36633a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 18:27:34.3024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B214UuNRjPx/10BgdBVuaXBk/UzY3uIv97ju5FuPGgitbIXGsbVYHUxZ7YzGjYnH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3210
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596738356; bh=GNkq9pCkQ1NdTrz45y8qel84TmzxbIFh0GtYOeBh8FY=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:Content-Type:Content-Disposition:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=lGKpwfu/99+icW3GEfr+Baq+NZMZTlVndh5CKPij/JcqCwV5DrY61XwJBaDzexC8n
         igTxXxoGPOhqEDmvAA1VkPc4mHSQJRCnAhXIEYT2Jax2sdTMzPiycOn7nAlzhxYxW5
         IgHC3qn+yoOWkX1sKTgQiPTNlP36qLJQlOXaitMdzKOAuqEAPYq0dGP5BPy0B9yMS1
         sAgtdYFjmQOnremb90nyZ38+gT4HbfHpgB2Xuy7aUEhnwtdAbxN9PFP5168tGE4xPG
         u1mwunjvjOVELjUpDmfcxl75D89nmx4m77wd3lY0a8Y81t3fT+8zw+OM3+JGcsTagm
         xYjuH/SREUXFw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

These are the proposed RDMA patches for 5.9.

A quiet cycle after the larger 5.8 effort. Substantially cleanup and
driver work with a few smaller features this time.

There is one conflict with Kees's removal of uninitialized_var -
resolve by taking the RDMA version of the conflicting hunks to delete
the local variables.

The tag for-linus-merged with my merge resolution to your tree is also
available for reference.

Thanks,
Jason

The following changes since commit 2d1b69ed65ee033aa541518cc9f6a815296ac493:

  net/mlx5: kTLS, Improve TLS params layout structures (2020-06-27 13:50:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 23fcc7dee2c6aba1060558683988263851e74bab:

  RDMA/mlx5: Fix flow destination setting for RDMA TX flow table (2020-08-05 21:09:39 -0300)

----------------------------------------------------------------
RDMA 5.9 merge window pull request

Smaller set of RDMA updates. A smaller number of 'big topics' with the
majority of changes being driver updates.

- Driver updates for hfi1, rxe, mlx5, hns, qedr, usnic, bnxt_re

- Removal of dead or redundant code across the drivers

- RAW resource tracker dumps to include a device specific data blob for
  device objects to aide device debugging

- Further advance the IOCTL interface, remove the ability to turn it off.
  Add QUERY_CONTEXT, QUERY_MR, and QUERY_PD commands

- Remove stubs related to devices with no pkey table

- A shared CQ scheme to allow multiple ULPs to share the CQ rings of a
  device to give higher performance

- Several more static checker, syzkaller and rare crashers fixed

----------------------------------------------------------------
Bolarinwa Olayemi Saheed (1):
      IB/hfi1: Convert PCIBIOS_* errors to generic -E* errors

Christophe JAILLET (1):
      RDMA/usnic: switch from 'pci_' to 'dma_' API

Chuck Lever (1):
      RDMA/core: Clean up tracepoint headers

Colton Lewis (1):
      RDMA: Correct trivial kernel-doc inconsistencies

Danil Kipnis (1):
      RDMA/rtrs-clt: add an additional random 8 seconds before reconnecting

Daria Velikovsky (1):
      RDMA/mlx5: Init dest_type when create flow

Devesh Sharma (6):
      RDMA/bnxt_re: introduce wqe mode to select execution path
      RDMA/bnxt_re: introduce a function to allocate swq
      RDMA/bnxt_re: Pull psn buffer dynamically based on prod
      RDMA/bnxt_re: Add helper data structures
      RDMA/bnxt_re: Change wr posting logic to accommodate variable wqes
      RDMA/bnxt_re: Update maintainers for Broadcom rdma driver

Eli Cohen (3):
      net/mlx5: Support setting access rights of dma addresses
      net/mlx5: Add VDPA interface type to supported enumerations
      net/mlx5: Add interface changes required for VDPA

Eric Dumazet (1):
      RDMA/umem: Add a schedule point in ib_umem_get()

Gal Pressman (8):
      RDMA/core: Check for error instead of success in alloc MR function
      RDMA/core: Remove ib_alloc_mr_user function
      RDMA: Remove the udata parameter from alloc_mr callback
      RDMA/mlx5: Remove unused to_mibmr function
      RDMA/efa: Expose maximum TX doorbell batch
      RDMA/efa: Expose minimum SQ size
      RDMA/efa: User/kernel compatibility handshake mechanism
      RDMA/efa: Add EFA 0xefa1 PCI ID

Gustavo A. R. Silva (2):
      IB/hfi1: Remove unnecessary fall-through markings
      IB/hfi1: Use fallthrough pseudo-keyword

Jack Wang (1):
      RDMA/rtrs: remove WQ_MEM_RECLAIM for rtrs_wq

Jason Gunthorpe (9):
      Merge branch 'raw_dumps' into rdma.git for-next
      RDMA/ipoib: Fix ABBA deadlock with ipoib_reap_ah()
      RDMA/core: Fix bogus WARN_ON during ib_unregister_device_queued()
      Merge branch 'mlx5_ipoib_qpn' into rdma.git for-next
      Merge branch 'mlx5_uar' into rdma.git /for-next
      RDMA/cma: Simplify DEVICE_REMOVAL for internal_id
      RDMA/cma: Using the standard locking pattern when delivering the removal event
      RDMA/cma: Remove unneeded locking for req paths
      RDMA/cma: Execute rdma_cm destruction from a handler properly

Jing Xiangfeng (1):
      IB/srpt: Remove WARN_ON from srpt_cm_req_recv

Kamal Heib (16):
      RDMA/ipoib: Return void from ipoib_mcast_stop_thread()
      RDMA/hfi1: Remove hfi1_create_qp declaration
      RDMA/rxe: Remove unused rxe_mem_map_pages
      RDMA/ipoib: Return void from ipoib_ib_dev_stop()
      RDMA/rxe: Drop pointless checks in rxe_init_ports
      RDMA/rxe: Return void from rxe_init_port_param()
      RDMA/rxe: Return void from rxe_mem_init_dma()
      RDMA/rxe: Remove rxe_link_layer()
      RDMA/core: Expose pkeys sysfs files only if pkey_tbl_len is set
      RDMA/core: Allocate the pkey cache only if the pkey_tbl_len is set
      RDMA/core: Remove query_pkey from the mandatory ops
      RDMA/siw: Remove the query_pkey callback
      RDMA/cxgb4: Remove the query_pkey callback
      RDMA/i40iw: Remove the query_pkey callback
      RDMA/qedr: Remove the query_pkey callback
      RDMA/rxe: Remove pkey table

Lang Cheng (4):
      RDMA/hns: Remove redundant hardware opcode definitions
      RDMA/hns: Remove support for HIP08_A
      RDMA/hns: Delete unnecessary memset when allocating VF resource
      RDMA/hns: Fix error during modify qp RTS2RTS

Leon Romanovsky (16):
      RDMA/core: Delete not-used create RWQ table function
      RDMA/mlx5: Get XRCD number directly for the internal use
      RDMA/core: Create and destroy counters in the ib_core
      RDMA: Move XRCD to be under ib_core responsibility
      RDMA/mlx5: Limit the scope of mlx5_ib_enable_driver function
      RDMA/mlx5: Separate restrack callbacks initialization from main.c
      RDMA/mlx5: Separate counters from main.c
      RDMA/mlx5: Separate flow steering logic from main.c
      RDMA/mlx5: Cleanup DEVX initialization flow
      RDMA/mlx5: Delete one-time used functions
      RDMA/core: Align abort/commit object scheme for write() and ioctl() paths
      RDMA/core: Update write interface to use automatic object lifetime
      RDMA/uverbs: Remove redundant assignments
      RDMA/uverbs: Silence shiftTooManyBitsSigned warning
      RDMA/mlx5: Delete unreachable code
      RDMA/include: Replace license text with SPDX tags

Li Heng (1):
      RDMA/core: Fix return error value in _ib_modify_qp() to negative

Maor Gottlieb (14):
      RDMA/core: Don't call fill_res_entry for PD
      RDMA: Add dedicated MR resource tracker function
      RDMA: Add a dedicated CQ resource tracker function
      RDMA: Add dedicated QP resource tracker function
      RDMA: Add dedicated CM_ID resource tracker function
      RDMA: Add support to dump resource tracker in RAW format
      RDMA/mlx5: Add support to get QP resource in RAW format
      RDMA/mlx5: Add support to get CQ resource in RAW format
      RDMA/mlx5: Add support to get MR resource in RAW format
      RDMA/mlx5: Introduce ODP prefetch counter
      RDMA/core: Clean ib_alloc_xrcd() and reuse it to allocate XRC domain
      RDMA/core: Optimize XRC target lookup
      RDMA/mlx5: Allow SQ modification
      RDMA/mlx5: Add missing srcu_read_lock in ODP implicit flow

Mark Zhang (4):
      RDMA/counter: Add PID category support in auto mode
      RDMA/counter: Only bind user QPs in auto mode
      RDMA/counter: Allow manually bind QPs with different pids to same counter
      RDMA/netlink: Remove CAP_NET_RAW check when dump a raw QP

Max Gurtovoy (1):
      IB/isert: allocate RW ctxs according to max IO size

Meir Lichtinger (3):
      RDMA/mlx5: ConnectX-7 new capabilities to set relaxed ordering by UMR
      RDMA/mlx5: Use MLX5_SET macro instead of local structure
      RDMA/mlx5: Set mkey relaxed ordering by UMR with ConnectX-7

Michael Guralnik (4):
      net/mlx5: Enable QP number request when creating IPoIB underlay QP
      RDMA/ipoib: Handle user-supplied address when creating child
      net/mlx5: Enable count action for rules with allow action
      RDMA/mlx5: Fix flow destination setting for RDMA TX flow table

Michal Kalderon (2):
      RDMA/qedr: Add EDPM mode type for user-fw compatibility
      RDMA/qedr: Add EDPM max size to alloc ucontext response

Mikhail Malygin (1):
      RDMA/rxe: Prevent access to wr->next ptr afrer wr is posted to send queue

Pavel Machek (1):
      RDMA/mlx5: Fix typo in enum name

Randy Dunlap (1):
      RDMA: rdma_user_ioctl.h: fix a duplicated word + clarify

Shay Drory (3):
      IB/mad: Issue complete whenever decrements agent refcount
      IB/mad: Change atomics to refcount API
      IB/mad: Delete RMPP_STATE_CANCELING state

Weihang Li (2):
      RDMA/hns: Refactor hns_roce_v2_set_hem()
      RDMA/hns: Remove redundant parameters in set_rc_wqe()

Xi Wang (2):
      RDMA/hns: Optimize MTR level-0 addressing to access huge page
      RDMA/hns: Fix the unneeded process when getting a general type of CQE error

Yamin Friedman (3):
      IB/iser: use new shared CQ mechanism
      IB/isert: use new shared CQ mechanism
      IB/srpt: use new shared CQ mechanism

Yishai Hadas (7):
      IB/uverbs: Enable CQ ioctl commands by default
      IB/uverbs: Set IOVA on IB MR in uverbs layer
      IB/uverbs: Expose UAPI to query ucontext
      RDMA/mlx5: Refactor mlx5_ib_alloc_ucontext() response
      RDMA/mlx5: Implement the query ucontext functionality
      RDMA/mlx5: Introduce UAPI to query PD attributes
      IB/uverbs: Expose UAPI to query MR

Yuval Basson (1):
      RDMA/qedr: SRQ's bug fixes

Zhu Yanjun (1):
      RDMA/rxe: Skip dgid check in loopback mode

 MAINTAINERS                                        |    1 +
 drivers/infiniband/Kconfig                         |    8 -
 drivers/infiniband/core/cache.c                    |   45 +-
 drivers/infiniband/core/cma.c                      |  257 +-
 drivers/infiniband/core/counters.c                 |   24 +-
 drivers/infiniband/core/device.c                   |   28 +-
 drivers/infiniband/core/mad.c                      |   30 +-
 drivers/infiniband/core/mad_priv.h                 |    2 +-
 drivers/infiniband/core/mad_rmpp.c                 |   27 +-
 drivers/infiniband/core/nldev.c                    |  223 +-
 drivers/infiniband/core/sysfs.c                    |   61 +-
 drivers/infiniband/core/trace.c                    |    2 -
 drivers/infiniband/core/umem.c                     |    1 +
 drivers/infiniband/core/umem_odp.c                 |    2 +
 drivers/infiniband/core/uverbs_cmd.c               |  321 +-
 drivers/infiniband/core/uverbs_ioctl.c             |    1 +
 drivers/infiniband/core/uverbs_main.c              |    4 +
 .../infiniband/core/uverbs_std_types_counters.c    |   17 +-
 drivers/infiniband/core/uverbs_std_types_cq.c      |    3 -
 drivers/infiniband/core/uverbs_std_types_device.c  |   48 +-
 drivers/infiniband/core/uverbs_std_types_mr.c      |   54 +-
 drivers/infiniband/core/verbs.c                    |  185 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |  170 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h           |   10 +-
 drivers/infiniband/hw/bnxt_re/main.c               |   23 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  751 ++--
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |  127 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h          |   58 +-
 drivers/infiniband/hw/bnxt_re/roce_hsi.h           |    1 +
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h             |    9 +-
 drivers/infiniband/hw/cxgb4/mem.c                  |    3 +-
 drivers/infiniband/hw/cxgb4/provider.c             |   22 +-
 drivers/infiniband/hw/cxgb4/restrack.c             |   24 +-
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h    |   15 +-
 drivers/infiniband/hw/efa/efa_com_cmd.c            |    2 +
 drivers/infiniband/hw/efa/efa_com_cmd.h            |    2 +
 drivers/infiniband/hw/efa/efa_main.c               |    6 +-
 drivers/infiniband/hw/efa/efa_verbs.c              |   42 +
 drivers/infiniband/hw/hfi1/chip.c                  |   27 +-
 drivers/infiniband/hw/hfi1/firmware.c              |   16 -
 drivers/infiniband/hw/hfi1/mad.c                   |    9 +-
 drivers/infiniband/hw/hfi1/pcie.c                  |   22 +-
 drivers/infiniband/hw/hfi1/pio.c                   |    2 +-
 drivers/infiniband/hw/hfi1/pio_copy.c              |   12 +-
 drivers/infiniband/hw/hfi1/platform.c              |   10 +-
 drivers/infiniband/hw/hfi1/qp.c                    |    2 +-
 drivers/infiniband/hw/hfi1/qp.h                    |   14 -
 drivers/infiniband/hw/hfi1/qsfp.c                  |    4 +-
 drivers/infiniband/hw/hfi1/rc.c                    |   25 +-
 drivers/infiniband/hw/hfi1/sdma.c                  |    9 +-
 drivers/infiniband/hw/hfi1/tid_rdma.c              |    4 +-
 drivers/infiniband/hw/hfi1/uc.c                    |    8 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        |   31 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |    7 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  253 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |   19 +-
 drivers/infiniband/hw/hns/hns_roce_main.c          |    2 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c            |  210 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |   10 -
 drivers/infiniband/hw/hns/hns_roce_restrack.c      |   14 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c          |   22 +-
 drivers/infiniband/hw/mlx4/main.c                  |   37 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h               |    2 +-
 drivers/infiniband/hw/mlx4/mr.c                    |    3 +-
 drivers/infiniband/hw/mlx5/Makefile                |    6 +-
 drivers/infiniband/hw/mlx5/cmd.c                   |   12 -
 drivers/infiniband/hw/mlx5/cmd.h                   |    1 -
 drivers/infiniband/hw/mlx5/counters.c              |  709 ++++
 drivers/infiniband/hw/mlx5/counters.h              |   17 +
 drivers/infiniband/hw/mlx5/devx.c                  |  102 +-
 drivers/infiniband/hw/mlx5/devx.h                  |   45 +
 drivers/infiniband/hw/mlx5/flow.c                  |  765 ----
 drivers/infiniband/hw/mlx5/fs.c                    | 2516 +++++++++++
 drivers/infiniband/hw/mlx5/fs.h                    |   29 +
 drivers/infiniband/hw/mlx5/main.c                  | 4380 +++++---------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |  109 +-
 drivers/infiniband/hw/mlx5/mr.c                    |    2 +-
 drivers/infiniband/hw/mlx5/odp.c                   |   28 +-
 drivers/infiniband/hw/mlx5/qp.c                    |   71 +-
 drivers/infiniband/hw/mlx5/qp.h                    |    1 +
 drivers/infiniband/hw/mlx5/restrack.c              |  121 +-
 drivers/infiniband/hw/mlx5/restrack.h              |   13 +
 drivers/infiniband/hw/mlx5/srq.c                   |    4 +-
 drivers/infiniband/hw/mlx5/std_types.c             |   45 +
 drivers/infiniband/hw/mlx5/wr.c                    |   68 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |    2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h        |    2 +-
 drivers/infiniband/hw/qedr/main.c                  |    3 +-
 drivers/infiniband/hw/qedr/qedr.h                  |    5 +-
 drivers/infiniband/hw/qedr/verbs.c                 |   45 +-
 drivers/infiniband/hw/qedr/verbs.h                 |    2 +-
 drivers/infiniband/hw/usnic/usnic_fwd.c            |    4 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c       |    2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h    |    2 +-
 drivers/infiniband/sw/rdmavt/ah.c                  |    3 +-
 drivers/infiniband/sw/rdmavt/mr.c                  |    2 +-
 drivers/infiniband/sw/rdmavt/mr.h                  |    2 +-
 drivers/infiniband/sw/rxe/rxe.c                    |   41 +-
 drivers/infiniband/sw/rxe/rxe_loc.h                |    8 +-
 drivers/infiniband/sw/rxe/rxe_mr.c                 |   50 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |    5 -
 drivers/infiniband/sw/rxe/rxe_param.h              |    4 +-
 drivers/infiniband/sw/rxe/rxe_recv.c               |   35 +-
 drivers/infiniband/sw/rxe/rxe_req.c                |    5 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |   48 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h              |    1 -
 drivers/infiniband/sw/siw/siw_main.c               |    1 -
 drivers/infiniband/sw/siw/siw_verbs.c              |   11 +-
 drivers/infiniband/sw/siw/siw_verbs.h              |    3 +-
 drivers/infiniband/ulp/ipoib/ipoib.h               |    4 +-
 drivers/infiniband/ulp/ipoib/ipoib_ib.c            |   67 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |   13 +-
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c     |    4 +-
 drivers/infiniband/ulp/iser/iscsi_iser.h           |   25 +-
 drivers/infiniband/ulp/iser/iser_verbs.c           |  112 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |  175 +-
 drivers/infiniband/ulp/isert/ib_isert.h            |   21 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h   |   23 +
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |   16 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             |    2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |   20 +-
 drivers/infiniband/ulp/srpt/ib_srpt.h              |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/alloc.c    |   11 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |    1 +
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |    7 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |    3 +
 include/linux/mlx5/device.h                        |    9 +-
 include/linux/mlx5/driver.h                        |    2 +
 include/linux/mlx5/mlx5_ifc.h                      |  129 +-
 include/rdma/ib.h                                  |   31 +-
 include/rdma/ib_addr.h                             |   31 +-
 include/rdma/ib_cache.h                            |   29 +-
 include/rdma/ib_cm.h                               |    1 +
 include/rdma/ib_hdrs.h                             |   44 +-
 include/rdma/ib_mad.h                              |   31 +-
 include/rdma/ib_marshall.h                         |   31 +-
 include/rdma/ib_pack.h                             |   29 +-
 include/rdma/ib_pma.h                              |   31 +-
 include/rdma/ib_sa.h                               |   29 +-
 include/rdma/ib_smi.h                              |   31 +-
 include/rdma/ib_umem.h                             |   29 +-
 include/rdma/ib_umem_odp.h                         |   29 +-
 include/rdma/ib_verbs.h                            |  100 +-
 include/rdma/iw_cm.h                               |   30 +-
 include/rdma/iw_portmap.h                          |   30 +-
 include/rdma/opa_addr.h                            |   44 +-
 include/rdma/opa_port_info.h                       |   31 +-
 include/rdma/opa_smi.h                             |   31 +-
 include/rdma/opa_vnic.h                            |   49 +-
 include/rdma/rdma_cm.h                             |   31 +-
 include/rdma/rdma_cm_ib.h                          |   31 +-
 include/rdma/rdma_netlink.h                        |    2 +-
 include/rdma/rdma_vt.h                             |   50 +-
 include/rdma/rdmavt_cq.h                           |   53 +-
 include/rdma/rdmavt_mr.h                           |   50 +-
 include/rdma/rdmavt_qp.h                           |   50 +-
 include/rdma/uverbs_ioctl.h                        |   30 +-
 include/rdma/uverbs_named_ioctl.h                  |   29 +-
 include/rdma/uverbs_std_types.h                    |   43 +-
 include/rdma/uverbs_types.h                        |   29 +-
 include/uapi/rdma/efa-abi.h                        |   15 +-
 include/uapi/rdma/ib_user_ioctl_cmds.h             |   15 +
 include/uapi/rdma/mlx5_user_ioctl_cmds.h           |   16 +-
 include/uapi/rdma/qedr-abi.h                       |   10 +-
 include/uapi/rdma/rdma_netlink.h                   |    9 +
 include/uapi/rdma/rdma_user_ioctl.h                |    2 +-
 166 files changed, 6945 insertions(+), 7569 deletions(-)
(diffstat from tag for-linus-merged)

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl8sS5MACgkQOG33FX4g
mxoW7g/+KVIfLP7uRVucQONGvYW9p++uewdFUYL3yOqhKbR/5d13rFSM1Y0eehM2
QqtJqXAWSXIX9DWRnj2WkL40959Y1Y/RwVpbQeyz1vNG8OkiZ7sX7vk09RQLp+TM
9w3reM5ulSBF8dkIZx2SMKb+CCAgeA5CQRHV9VIVuw9l5IB9wr1tFvdYrsV/qqKE
b1AFG42miz2oTiIHLR9nUJyYmV5gRkfedytHFQm1oooJ9+mJdZIHjwPwOIa2PNDE
TnqA9C7uT/lKQAguQVexJ8lRE2ZHwZM63jpJ4/fj2Xve8kqmhN40cKm85I/abtAe
rjAMMgmwVETN3+Lj4Zk8aa2BSqyo/2SDGWqS1bJj3tL3q1e2w01luAU1rn/gzRAR
ZpaGfzFJO6A0Ca0m5c4Ca2tIdzzb1w0y6kb3UXr/XDmvURG1dZfLxr1Q685P1UQ7
FuexPLdM+GisYFOlNKW3Of1zJnR30MywqaHLazoVIxg4K45cmAfASWnfoGa2h9Pt
c0w7sCCmb7BpSQg178kZpMjejNoFRs4G+YBBtqtqrE+ccrZzch3XLBbSedJjhI0H
lgc8FIMWzS/gW1c7E9q1lzUM4FADa04HkjAaq2HnJiSuKLrFI8YJUD+PEJ8zsHPu
yi2SHBZsisTFZXB7bm/DiGmIH4yt2zd6jKO5fqwJxBfvGkuTKfo=
=rHEf
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
