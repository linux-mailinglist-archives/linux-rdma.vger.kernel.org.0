Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8705714EF5D
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jan 2020 16:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgAaPQd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jan 2020 10:16:33 -0500
Received: from mail-eopbgr30080.outbound.protection.outlook.com ([40.107.3.80]:41170
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728971AbgAaPQd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 Jan 2020 10:16:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7pj7lcZSjwBMOtJVhDW7u644RIrJTFrSUu4kZEsuQJ7pmCDd9NC16/xJJI9YgAmxALS3erFPrWFNYWgoj0h2CCf+yQjsZNviKJA07tZBzCV0sDqsEoVgQIslSZWDUxJ/kpMfpuAzTeQlBD7cSlpOiGsNPpPWux525YCfakucRvyvtfGPhKbTKDUJjL8gI3FS1HBqmxCSk9lkP0cjIQxVDJ7dIiZyWYJ/c9StLpxjnjQwETISph73W9+6yhyoBSkrZ20jF5JhiHumJhFhzDe/4cuRWkJvVwfDmyDIENtBntPiEXEqhMV43traBoIrB/187fRcb/BgzI0cJtu0pJ4Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfZ6VzTUNFiOeSWJy8GwKUZOg21u0TjvGwZDZKVbkX8=;
 b=PSN0VKAWqDLe7+lL3jeyxAsPvZCzfeiR3bTFKJN50WHiwIP+jvsY/LQhmOKaSzd7n2WIiU4B0Doyhrn3HmsmIubwFxKM80yZGGkppoWgn/gJ7F9R/KBSr0NOQ5pBrcptQkUe+2DEmmKkuLlRE6jCAKhCSoEcHEf9dEjGEztn5FLkrBTZPgIv29gzGvNhTFtbB1y0ydbndf6yeKOkZrqF9l8OPN/4uJXkXUtGFHHh9fTEjiyZwW2CQXdXgWVQaRVwO9qxqA52scEldiLtOKrvE1jbXWb7iDsHSRiJl7hgptZ1dBeUqNy5nxaaTzVw+cW44rnW/Ti/OqZ/G+/NH+sJSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfZ6VzTUNFiOeSWJy8GwKUZOg21u0TjvGwZDZKVbkX8=;
 b=gLm+8wb76Y4Lew41HRMo/tMNtUIqi3GENQRozM9psqs07CdYwTX7k2UFeVEGoC7KPE7/76TB27mWhgVPpzx5Qkgor04kQzys4NOjFwZBmBpu7TQQaX+O4PAz7zfqyA6G4fhwJoFM+krS+PIYjWMS8+zMu+KDsHhEYuZqPFvqW/w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5262.eurprd05.prod.outlook.com (20.178.10.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 31 Jan 2020 15:16:26 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2686.025; Fri, 31 Jan 2020
 15:16:26 +0000
Date:   Fri, 31 Jan 2020 11:16:22 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20200131151622.GA1392@ziepe.ca>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR02CA0042.namprd02.prod.outlook.com
 (2603:10b6:207:3d::19) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR02CA0042.namprd02.prod.outlook.com (2603:10b6:207:3d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.26 via Frontend Transport; Fri, 31 Jan 2020 15:16:26 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1ixY1u-000188-IV; Fri, 31 Jan 2020 11:16:22 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e7c98e1-fbe7-4e10-db05-08d7a6608a36
X-MS-TrafficTypeDiagnostic: VI1PR05MB5262:
X-Microsoft-Antispam-PRVS: <VI1PR05MB5262EE8254D7207423AA1C84CF070@VI1PR05MB5262.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:16;
X-Forefront-PRVS: 029976C540
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(199004)(189003)(5660300002)(21480400003)(86362001)(36756003)(2906002)(8936002)(66946007)(66556008)(66476007)(81156014)(81166006)(44144004)(33964004)(186003)(26005)(30864003)(478600001)(9686003)(33656002)(9786002)(9746002)(66574012)(4326008)(8676002)(1076003)(52116002)(316002)(110136005)(24400500001)(2700100001)(473944003)(414714003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5262;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B/0S7FM+mH86TrHNlsVgbb8dwZD6dCgeVldZq4YeFGnhz09mFtQtswWxjagOWUZgm42TAQrhv54I0EIjtdxRfN8KLa/C/j4bF7iuFFPjNUggmP9UAGfPKbxqrWbqGokO4BYRlDnE59+ipOX3J99fbrTflcDxACSvOtCaOWuFoBHfFng7M9sbspjMpelpCEaW/uzxFj4v++L2OJr5qSM/8HsgU2RIFq3aUpDH5vS0dzDXtSUAf6GW/K0drvMkuEEK7CX3SeTvotMHZQde0iphCb9W5rphq1DgTPi2kSi6Om7VrMxK+Dy0Fh+7/5icKd7ZzMdLsIHhf6FOFhF5yiGu+sx8qDS/ettWyp7gL0ut6jmPyh/ZHB6QPcscb7edh9Tg8IvVoFKRzO4V7MLc6/42LkO0YlOBNXbKGC+o8UrDsRcDSn71ZWE2XyY38FX6QovxAnZS9EREl2BarqqTVPQEwpwhCb0SOqXDsNr5dTXirz8YmvFWp1aaC/B73ry8EIBtGX50c57UmbHBVQ3g9tnpTBXcvMpprB9fuH4wftzApHuiY2ffhzu+5V/OZgZusE4o7zKN2aHpqgKTGVwoM/+Law==
X-MS-Exchange-AntiSpam-MessageData: ipaRcEZkmGVlOY9av8wgK00MD5R3AVilTRnjKxK3pvMEuELDwfssTj+K3Axnq8k+MzBr0cEIrcJI1fC4GHKtj+/PBryQGXilqNHG/aKarQzKH9FBCY25FbVlAl6c5b0eIpa+ULk0boiGOH53NOVEqA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7c98e1-fbe7-4e10-db05-08d7a6608a36
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 15:16:26.5994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyeXL6PXMgYbMw9LTUPVM5TRfWl8HPZZWMX4hUcNGFv5OwJr3el/Mqkb3cKCW3zuxQ3eX09tzwhVcyocxTP8xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5262
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

These are the proposed RDMA patches for 5.6.

A very quiet cycle with few notable changes. Mostly the usual list of one or
two patches to drivers changing something that isn't quite rc worthy. The
subsystem seems to be seeing a larger number of rework and cleanup style
patches right now, I feel that several vendors are prepping their drivers f=
or
new silicon.

Thanks,
Jason

The following changes since commit b2dfc6765e45a3154800333234e4952b5412d792:

  net/rds: Use prefetch for On-Demand-Paging MR (2020-01-18 11:48:19 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 8889f6fa35884d09f24734e10fea0c9ddcbc6429:

  RDMA/core: Make the entire API tree static (2020-01-30 16:28:52 -0400)

----------------------------------------------------------------
RDMA subsystem updates for 5.6

- Driver updates and cleanup for qedr, bnxt_re, hns, siw, mlx5, mlx4, rxe,
  i40iw

- Larger series doing cleanup and rework for hns and hfi1.

- Some general reworking of the CM code to make it a little more
  understandable

- Unify the different code paths connected to the uverbs FD scheme

- New UAPI ioctls conversions for get context and get async fd

- Trace points for CQ and CM portions of the RDMA stack

- mlx5 driver support for virtio-net formatted rings as RDMA raw ethernet Q=
Ps

- verbs support for setting the PCI-E relaxed ordering bit on DMA traffic
  connected to a MR

- A couple of bug fixes that came too late to make rc7

----------------------------------------------------------------
Aditya Pakki (1):
      RDMA/srpt: Remove unnecessary assertion in srpt_queue_response

Arnd Bergmann (1):
      IB/core: Fix build failure without hugepages

Artemy Kovalyov (2):
      IB/mlx5: Unify ODP MR code paths to allow extra flexibility
      RDMA/umem: Fix ib_umem_find_best_pgsz()

Avihai Horon (1):
      IB/mlx5: Expose RoCE accelerator counters

Bernard Metzler (1):
      RDMA/siw: Simplify QP representation

Chuck Lever (3):
      RDMA/cma: Add trace points in RDMA Connection Manager
      RDMA/core: Trace points for diagnosing completion queue issues
      RDMA/core: Add trace points to follow MR allocation

Danit Goldberg (2):
      RDMA/cm: Use RCU synchronization mechanism to protect cm_id_private x=
a_load()
      IB/mlx5: Return the administrative GUID if exists

Dillon Brock (1):
      IB/opa_vnic: Spelling correction of 'erorr' to 'error'

Eugene Crosser (1):
      RDMA/mlx4: Redo TX checksum offload in line with docs

Gal Pressman (4):
      RDMA/efa: Device definitions documentation updates
      RDMA/efa: Remove {} brackets from single statement if
      RDMA/efa: Remove unused ucontext parameter from efa_qp_user_mmap_entr=
ies_remove
      RDMA/efa: Mask access flags with the correct optional range

Grzegorz Andrejczuk (3):
      IB/hfi1: Move common receive IRQ code to function
      IB/hfi1: Decouple IRQ name from type
      IB/hfi1: Return void in packet receiving functions

Guoqing Jiang (1):
      RDMA/core: Remove err in iw_query_port

H=C3=A5kon Bugge (2):
      RDMA/netlink: Do not always generate an ACK for some netlink operatio=
ns
      IB/mlx4: Fix leak in id_map_find_del

Jack Morgenstein (1):
      IB/mlx4: Fix memory leak in add_gid error flow

Jason Gunthorpe (29):
      RDMA/core: Fix locking in ib_uverbs_event_read
      Merge branch 'mlx5_vdpa' into rdma.git for-next
      RDMA/uverbs: Remove needs_kfree_rcu from uverbs_obj_type_class
      RDMA/mlx5: Use RCU and direct refcounts to keep memory alive
      RDMA/core: Simplify destruction of FD uobjects
      RDMA/mlx5: Simplify devx async commands
      RDMA/core: Do not allow alloc_commit to fail
      RDMA/core: Make ib_ucq_object use ib_uevent_object
      RDMA/core: Do not erase the type of ib_cq.uobject
      RDMA/core: Do not erase the type of ib_qp.uobject
      RDMA/core: Do not erase the type of ib_srq.uobject
      RDMA/core: Do not erase the type of ib_wq.uobject
      RDMA/core: Simplify type usage for ib_uverbs_async_handler()
      RDMA/core: Remove the ufile arg from rdma_alloc_begin_uobject
      RDMA/core: Make ib_uverbs_async_event_file into a uobject
      RDMA/core: Use READ_ONCE for ib_ufile.async_file
      Merge branch 'mlx5-next' into rdma.git for-next
      RDMA/core: Add UVERBS_METHOD_ASYNC_EVENT_ALLOC
      RDMA/core: Remove ucontext_lock from the uverbs_destry_ufile_hw() path
      RDMA/uverbs: Add ioctl command to get a device context
      Merge tag 'rds-odp-for-5.5' into rdma.git for-next
      RDMA/core: Ensure that rdma_user_mmap_entry_remove() is a fence
      RDMA/cm: Add accessors for CM_REQ transport_type
      RDMA/cm: Use IBA functions for simple get/set acessors
      RDMA/cm: Use IBA functions for swapping get/set acessors
      RDMA/cm: Use IBA functions for simple structure members
      RDMA/cm: Use IBA functions for complex structure members
      RDMA/cm: Remove CM message structs
      RDMA/core: Make the entire API tree static

Jiaran Zhang (1):
      RDMA/hns: Add support for extended atomic in userspace

Jiewei Ke (1):
      RDMA/rxe: Fix error type of mmap_offset

Leon Romanovsky (4):
      RDMA/cm: Delete unused CM LAP functions
      RDMA/cm: Delete unused CM ARP functions
      net/mlx5: Add RoCE accelerator counters
      RDMA/cm: Add SET/GET implementations to hide IBA wire format

Lijun Ou (7):
      RDMA/hns: Remove unused function hns_roce_init_eq_table()
      RDMA/hns: Update the value of qp type
      RDMA/hns: Delete unnessary parameters in hns_roce_v2_qp_modify()
      RDMA/hns: Fix coding style issues
      RDMA/hns: Bugfix for posting a wqe with sge
      RDMA/hns: Add interfaces to get pf capabilities from firmware
      RDMA/hns: Get pf capabilities from firmware

Michael Guralnik (7):
      net/mlx5: Expose relaxed ordering bits
      RDMA/uverbs: Verify MR access flags
      RDMA/core: Add optional access flags range
      RDMA/efa: Allow passing of optional access flags for MR registration
      RDMA/uverbs: Add new relaxed ordering memory region access flag
      RDMA/core: Add the core support field to METHOD_GET_CONTEXT
      RDMA/mlx5: Set relaxed ordering when requested

Michael J. Ruhl (1):
      IB/hfi1: List all receive contexts from debugfs

Michal Kalderon (1):
      RDMA/qedr: Add kernel capability flags for dpm enabled mode

Mike Marciniszyn (8):
      IB/hfi1: Add accessor API routines to access context members
      IB/rdmavt: Correct comments in rdmavt_qp.h header
      IB/hfi1: Move chip specific functions to chip.c
      IB/hfi1: Add fast and slow handlers for receive context
      IB/hfi1: IB/hfi1: Add an API to handle special case drop
      IB/hfi1: Create API for auto activate
      IB/hfi1: Add software counter for ctxt0 seq drop
      IB/hfi1: Add RcvShortLengthErrCnt to hfi1stats

Nathan Chancellor (1):
      IB/hfi1: Fix logical condition in msix_request_irq

Parav Pandit (5):
      IB/mlx5: Do reverse sequence during device removal
      IB/core: Let IB core distribute cache update events
      IB/core: Cut down single member ib_cache structure
      IB/core: Rename event_handler_lock to qp_open_list_lock
      RDMA/cma: Fix unbalanced cm_id reference count during address resolve

Prabhath Sajeepa (1):
      IB/mlx5: Fix outstanding_pi index for GSI qps

Rao Shoaib (2):
      Introduce maximum WQE size to check limits
      RDMA/rxe: Compute the maximum sges and inline size based on the WQE s=
ize

Selvin Xavier (1):
      RDMA/bnxt_re: Report more number of completion vectors

Sergey Gorenko (1):
      IB/srp: Never use immediate data if it is disabled by a user

Weihang Li (1):
      RDMA/hns: Remove some redundant variables related to capabilities

Wenpeng Liang (2):
      RDMA/hns: Avoid printing address of mtt page
      RDMA/hns: Replace custom macros HNS_ROCE_ALIGN_UP

Xi Wang (1):
      RDMA/hns: Add support for reporting wc as software mode

Xiyu Yang (1):
      RDMA/i40iw: fix a potential NULL pointer dereference

Yishai Hadas (5):
      IB/core: Fix ODP get user pages flow
      IB/core: Fix ODP with IB_ACCESS_HUGETLB handling
      IB/mlx5: Extend caps stage to handle VAR capabilities
      IB/mlx5: Introduce VAR object and its alloc/destroy methods
      IB/mlx5: Add mmap support for VAR

Yixian Liu (1):
      RDMA/hns: Simplify the calculation and usage of wqe idx for post verbs

Yixing Liu (1):
      RDMA/hns: Remove redundant print information

zhengbin (5):
      RDMA/siw: use true,false for bool variable
      IB/hfi1: use true,false for bool variable
      IB/iser: use true,false for bool variable
      RDMA/mlx4: use true,false for bool variable
      RDMA/mlx5: use true,false for bool variable

 drivers/infiniband/core/Makefile                   |    9 +-
 drivers/infiniband/core/addr.c                     |    2 +-
 drivers/infiniband/core/cache.c                    |  151 +--
 drivers/infiniband/core/cm.c                       | 1000 ++++++++++------=
----
 drivers/infiniband/core/cm_msgs.h                  |  755 +--------------
 drivers/infiniband/core/cma.c                      |   90 +-
 drivers/infiniband/core/cma_trace.c                |   16 +
 drivers/infiniband/core/cma_trace.h                |  391 ++++++++
 drivers/infiniband/core/core_priv.h                |    3 +-
 drivers/infiniband/core/cq.c                       |   27 +-
 drivers/infiniband/core/device.c                   |   42 +-
 drivers/infiniband/core/ib_core_uverbs.c           |    2 +
 drivers/infiniband/core/nldev.c                    |    3 +-
 drivers/infiniband/core/rdma_core.c                |  235 ++---
 drivers/infiniband/core/rdma_core.h                |   45 +-
 drivers/infiniband/core/sa_query.c                 |    4 +-
 drivers/infiniband/core/trace.c                    |   14 +
 drivers/infiniband/core/umem.c                     |    9 +-
 drivers/infiniband/core/umem_odp.c                 |   22 +-
 drivers/infiniband/core/uverbs.h                   |   48 +-
 drivers/infiniband/core/uverbs_cmd.c               |  320 ++++---
 drivers/infiniband/core/uverbs_ioctl.c             |   45 +-
 drivers/infiniband/core/uverbs_main.c              |  301 ++----
 drivers/infiniband/core/uverbs_std_types.c         |   44 +-
 .../infiniband/core/uverbs_std_types_async_fd.c    |   52 +
 drivers/infiniband/core/uverbs_std_types_cq.c      |   19 +-
 drivers/infiniband/core/uverbs_std_types_device.c  |   38 +
 drivers/infiniband/core/uverbs_uapi.c              |    7 +-
 drivers/infiniband/core/verbs.c                    |   55 +-
 drivers/infiniband/hw/bnxt_re/main.c               |    2 +-
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h    |   37 +-
 drivers/infiniband/hw/efa/efa_verbs.c              |   15 +-
 drivers/infiniband/hw/hfi1/chip.c                  |  198 +++-
 drivers/infiniband/hw/hfi1/chip.h                  |    8 +
 drivers/infiniband/hw/hfi1/chip_registers.h        |    1 +
 drivers/infiniband/hw/hfi1/common.h                |    3 +
 drivers/infiniband/hw/hfi1/debugfs.c               |    2 +-
 drivers/infiniband/hw/hfi1/driver.c                |  237 ++---
 drivers/infiniband/hw/hfi1/file_ops.c              |   12 +-
 drivers/infiniband/hw/hfi1/hfi.h                   |  195 +++-
 drivers/infiniband/hw/hfi1/init.c                  |   87 +-
 drivers/infiniband/hw/hfi1/msix.c                  |  106 ++-
 drivers/infiniband/hw/hfi1/msix.h                  |    1 +
 drivers/infiniband/hw/hfi1/rc.c                    |    2 +-
 drivers/infiniband/hw/hfi1/trace_ctxts.h           |    2 +-
 drivers/infiniband/hw/hfi1/trace_rx.h              |   15 +-
 drivers/infiniband/hw/hfi1/vnic_main.c             |    2 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c            |    2 +
 drivers/infiniband/hw/hns/hns_roce_device.h        |   44 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |   51 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  874 +++++++++++------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |  159 +++-
 drivers/infiniband/hw/hns/hns_roce_main.c          |  106 ++-
 drivers/infiniband/hw/hns/hns_roce_mr.c            |    4 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |   92 +-
 drivers/infiniband/hw/i40iw/i40iw_main.c           |    2 +
 drivers/infiniband/hw/mlx4/cm.c                    |   29 +-
 drivers/infiniband/hw/mlx4/cq.c                    |   18 +-
 drivers/infiniband/hw/mlx4/main.c                  |   20 +-
 drivers/infiniband/hw/mlx4/qp.c                    |    4 +-
 drivers/infiniband/hw/mlx5/devx.c                  |  159 ++--
 drivers/infiniband/hw/mlx5/gsi.c                   |    3 +-
 drivers/infiniband/hw/mlx5/ib_virt.c               |   28 +-
 drivers/infiniband/hw/mlx5/main.c                  |  224 ++++-
 drivers/infiniband/hw/mlx5/mem.c                   |   25 -
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |   38 +-
 drivers/infiniband/hw/mlx5/mr.c                    |   81 +-
 drivers/infiniband/hw/mlx5/odp.c                   |   44 +-
 drivers/infiniband/hw/mlx5/qp.c                    |    4 +-
 drivers/infiniband/hw/qedr/verbs.c                 |   13 +-
 drivers/infiniband/sw/rdmavt/rc.c                  |    9 +-
 drivers/infiniband/sw/rxe/rxe_param.h              |    7 +-
 drivers/infiniband/sw/rxe/rxe_qp.c                 |   18 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h              |    2 +-
 drivers/infiniband/sw/siw/siw.h                    |   26 +-
 drivers/infiniband/sw/siw/siw_cm.c                 |    2 +-
 drivers/infiniband/sw/siw/siw_cq.c                 |    2 +-
 drivers/infiniband/sw/siw/siw_main.c               |    2 +-
 drivers/infiniband/sw/siw/siw_qp.c                 |   13 +-
 drivers/infiniband/sw/siw/siw_qp_rx.c              |    6 +-
 drivers/infiniband/sw/siw/siw_qp_tx.c              |    2 +-
 drivers/infiniband/sw/siw/siw_verbs.c              |   61 +-
 drivers/infiniband/ulp/iser/iser_memory.c          |    2 +-
 drivers/infiniband/ulp/iser/iser_verbs.c           |    2 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h   |    2 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |    3 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |    2 -
 include/linux/mlx4/cq.h                            |    5 +
 include/linux/mlx5/driver.h                        |    5 +
 include/linux/mlx5/mlx5_ifc.h                      |   24 +-
 include/rdma/ib_cm.h                               |   34 -
 include/rdma/ib_verbs.h                            |   42 +-
 include/rdma/iba.h                                 |  146 +++
 include/rdma/ibta_vol1_c12.h                       |  213 +++++
 include/rdma/rdmavt_qp.h                           |   22 +-
 include/rdma/uverbs_named_ioctl.h                  |    6 +-
 include/rdma/uverbs_std_types.h                    |   13 +-
 include/rdma/uverbs_types.h                        |   34 +-
 include/trace/events/rdma_core.h                   |  394 ++++++++
 include/uapi/rdma/ib_user_ioctl_cmds.h             |   15 +
 include/uapi/rdma/ib_user_ioctl_verbs.h            |   12 +
 include/uapi/rdma/mlx5_user_ioctl_cmds.h           |   17 +
 include/uapi/rdma/qedr-abi.h                       |   18 +-
 103 files changed, 4659 insertions(+), 3200 deletions(-)
(diffstat from tag for-linus-merged)

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl40RMQACgkQOG33FX4g
mxrd8A/+MqqUrK4CyZ4jjWFl61lX6986uCeFwh3FhRKzDhI0U3m1mBg7/5Hhrmwu
7BQcxR0Ih5RgT51TXdFmhHKtldSkMFqCSokDVPAmuVofOrIIXuwxfrAERTfeHMIC
VEyYYbVUfu4e8uceoSe9mF6+BXBJxENX4nYmjQGJN2H98+D6yRoIFpCdX4xWgWwJ
zJNF08nbURG7plHIrV3ILN/Qcmg00MwYIYawuAWVYObrtpPs+5TM7QxMAsfC9PWZ
BWu3vbel8JPOhwivPwBv0ut3ELrfWW9cyrityiMBl5hnOTlKnTa2uVo4YDg+zlq6
mTGOkTcvDcK4bknYrjm0W7VK3HxZNhkwDL6KHUUeCTxT43vxou2LDzcwcxdqemuc
BC7ui1egJQqotm3rZDe6fSYuRjXMhxGmcL5ue6Aciqyb2drPLGj5kEzoNjFdBrlt
bYKIio7nP2jRBgcYAcD60bOHEVPtmbVHeyjXdfx6Sc3xoZMNLzrvkLIaKrED2gHA
QBeL7x3W3wn9sA/w34iBV5OlbF40wPFCH6MDu6LxN7bZq3CcOt0dCFfY8NZl7TkF
tj9FFvi48c/4IzabQj/NerMMT/vqV3GDYH9KoN2hkTl6trfM1M5x8HhR0CABQ6QA
CU+Co64cz2BsTaTYpQ3FcNMYGlCYyMGFN3JVRTyey3yGZrvHBmU=
=abRo
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
