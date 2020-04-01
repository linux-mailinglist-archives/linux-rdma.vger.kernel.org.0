Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F07A19B8CC
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2020 01:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbgDAXFT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Apr 2020 19:05:19 -0400
Received: from mail-eopbgr00069.outbound.protection.outlook.com ([40.107.0.69]:37582
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732537AbgDAXFT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 Apr 2020 19:05:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfZUFfZZ5Fc99dKUfrVOBhfoDDIc2AMNRTHy5BrAAr+ZDsdCpT7R8EvuitkGtVAI5W5kk2X6dByzVjGXhlqMUOQqU9ZBMk28+2XQZphg5RtbWIM3r7sdx61irpV8Az5r4Q4sBym9Wtbe6ccpfZIt619nqdy4WGAjLi4YD3mmUN9llHga+SK/ZC6sKzyxJHpBiwl8czSjWd6zNcjA2Go9h2y3Vc9frk4xANzcqO2jMOlyZEz2MAmp6T9zYZVR6raaiLNqWPoYpZZbOx+cqKaNKX+RA6T3uoJf5b/7nlps2hj/E9ZIB55aIFRC/z9T8A6YLQhragaYdK3lS70DG0vmkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKtw5Gch6Q6PfAyH8snhDrp0ByoFZxUGvgvA43/wTP8=;
 b=m9uLJa3WG++0gC1m8HgTPk92WvKPPZor0b5dZjedM9gsigIFIEMx0HmcIsYoqPnsxMrAYNxuFbPHtSUTqNY9YmOThqA0VMngNg8v+E2MH8uMl/6bQ+TjwfT2rWHp4KJWRs6XFzZU4wIfNWWcK5P9qiPJ7+PbnB6xqvLtLW000q8hHkPr9lWOBNWYG8lMujBBEA258QcjJQe4NOW4xiWO4Gygs4fAO5LRdedy5r/lBOQLq+xYqoizzzamCHQMd9GAArrRdrRgZlQCauerl5ow84AB4m33Gqd3TyctAudiMKJjPzcHLXDjrYFw9yCfSVVWaCU6sAd9gaL7kjOEmh3gaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKtw5Gch6Q6PfAyH8snhDrp0ByoFZxUGvgvA43/wTP8=;
 b=Gsja/u3W+QTBhFOqwSMwPxOT2yiiC2ltaU1cbkSrv1CCDrfzQ9c8/UkeAVoEEaqb75m7WZnxbvTPz+YEvzQ3mqvqgXRcf2EADCmVd2pzMXc9NNUaxDM1q+YY1BkH+pUA2m2DpkRq9qtNUWq+0UcPc6+CkiMUMXFX2SVbrTMFRIg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6845.eurprd05.prod.outlook.com (10.186.163.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Wed, 1 Apr 2020 23:01:36 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3%7]) with mapi id 15.20.2878.014; Wed, 1 Apr 2020
 23:01:36 +0000
Date:   Wed, 1 Apr 2020 20:01:33 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20200401230133.GA14469@ziepe.ca>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR15CA0065.namprd15.prod.outlook.com
 (2603:10b6:208:237::34) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR15CA0065.namprd15.prod.outlook.com (2603:10b6:208:237::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Wed, 1 Apr 2020 23:01:36 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jJmMX-0003mO-5y; Wed, 01 Apr 2020 20:01:33 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25df87ad-d05d-44cf-3ea9-08d7d690a13c
X-MS-TrafficTypeDiagnostic: VI1PR05MB6845:
X-Microsoft-Antispam-PRVS: <VI1PR05MB6845FEB9F46D2DD3BC5FA74BCFC90@VI1PR05MB6845.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:372;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(66946007)(9786002)(110136005)(66476007)(2906002)(21480400003)(66556008)(5660300002)(33656002)(26005)(186003)(9746002)(316002)(8936002)(81156014)(9686003)(81166006)(36756003)(1076003)(8676002)(86362001)(52116002)(44144004)(30864003)(4326008)(478600001)(24400500001)(2700100001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ShpvFlYvLDS+sEDJAnsR5xUWt6hJes2FeHrtWSVy9x6SJZ61Mh33Ot+aZVs02okSQIbPRKoa0Q6SjGhfF2wP38Odi0rcDGxjphA+JdqWw1Vup0ZgcvEo6aP5l2iTc8LFVn4pPdW+kmLMSe9l+DuTaIHDkW79S4sN6ElTAOUBeoSkcBq+F5CvWHTWXlqmPLKStEtO69ZCd5KEF3RzfUDBPN2qX+Yhu3vBlAasSFxoibABS/xA51DoEfPPwu96JWaQ3YOfaDOBVrlW3GeVytKDiOtZ2orIke8zgvjUkHKcroUiuwlYxPjr5TDTIVVukM4e5vIc/CK1z446vJyn/OQ4/3okDAmrBmEOPO1xFT5eu1taQ9E+y2QbWgBE9DbmZr3NF7K9b+WNth3RTYIB6YbFuRVIyW/P6f7oWJ4cp3GMWqvrQ+TfEpHgFqaTdAd0Sl7JXmpqUcszYgltdhUgj8oBglO05Qj5gUuOuzkchEWVrrwexy/d0BoFA9QPRSmL2EQv++amwF/51+huqfxS2GHdYA==
X-MS-Exchange-AntiSpam-MessageData: CntsZDWtbQWJxOCdpqWwgt1OrXfD4JAqJkx1DzW15j90gPv3+95VedDsoW7UxtDHnRM/F4IXUc2A5Mcod9KQfeIfF+f0/rqNypL6ahasAWKqeiNSWwSwioMpxsheYtZ2LfxfbE7PDBAtICPnI/HxAw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25df87ad-d05d-44cf-3ea9-08d7d690a13c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 23:01:36.8107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLwAaNWvHXAKtbaFp7VrfLI+IUSjfSn4OLkYRC0mGtUkvEWUgpMSILx+MvTT5O7f6epsDcW7JVI5RpNR9JiRdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6845
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

These are the proposed RDMA patches for 5.7.

This cycle saw some more activity from Syzkaller, I think we are now clean on
all but one of those bugs, including the long standing and obnoxious rdma_cm
locking design defect. Continue to see many drivers getting cleanups, with a
few new user visible features.

Thanks,
Jason

The following changes since commit 826096d84f509d95ee8f72728fe19c44fbb9df6b:

  mlx5: Remove uninitialized use of key in mlx5_core_create_mkey (2020-03-16 23:30:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to b4d8ddf8356d8ac73fb931d16bcc661a83b2c0fe:

  RDMA/bnxt_re: make bnxt_re_ib_init static (2020-03-30 15:03:19 -0300)

----------------------------------------------------------------
RDMA 5.7 pull request

The majority of the patches are cleanups, refactorings and clarity
improvements

- Various driver updates for siw, bnxt_re, rxe, efa, mlx5, hfi1

- Lots of cleanup patches for hns

- Convert more places to use refcount

- Aggressively lock the RDMA CM code that syzkaller says isn't working

- Work to clarify ib_cm

- Use the new ib_device lifecycle model in bnxt_re

- Fix mlx5's MR cache which seems to be failing more often with the new
  ODP code

- mlx5 'dynamic uar' and 'tx steering' user interfaces

----------------------------------------------------------------
Alex Vesker (1):
      IB/mlx5: Replace tunnel mpls capability bits for tunnel_offloads

Alexander Lobakin (1):
      IB/mlx5: Optimize u64 division on 32-bit arches

Andrew Morton (1):
      RDMA/siw: Suppress uninitialized var warning

Avihai Horon (1):
      RDMA/cm: Update num_paths in cma_resolve_iboe_route error flow

Bart Van Assche (1):
      RDMA/rxe: Fix configuration of atomic queue pair attributes

Bernard Metzler (1):
      RDMA/siw: Fix passive connection establishment

Christophe JAILLET (1):
      RDMA/bnxt_re: Remove a redundant 'memset'

Colin Ian King (2):
      RDMA/hns: fix spelling mistake: "attatch" -> "attach"
      RDMA/hns: fix spelling mistake "attatch" -> "attach"

Dan Carpenter (1):
      IB/mlx5: Fix a NULL vs IS_ERR() check

Devesh Sharma (8):
      RDMA/bnxt_re: Refactor queue pair creation code
      RDMA/bnxt_re: Replace chip context structure with pointer
      RDMA/bnxt_re: Refactor hardware queue memory allocation
      RDMA/bnxt_re: Refactor net ring allocation function
      RDMA/bnxt_re: Refactor command queue management code
      RDMA/bnxt_re: Refactor notification queue management code
      RDMA/bnxt_re: Refactor doorbell management functions
      RDMA/bnxt_re: use ibdev based message printing functions

Erez Shitrit (1):
      RDMA/mlx5: Remove duplicate definitions of SW_ICM macros

Gal Pressman (3):
      RDMA/efa: Unified getters/setters for device structs bitmask access
      RDMA/efa: Properly document the interrupt mask register
      RDMA/efa: Do not delay freeing of DMA pages

George Spelvin (1):
      IB/qib: Delete struct qib_ivdev.qp_rnd

Gustavo A. R. Silva (2):
      RDMA: Replace zero-length array with flexible-array member
      RDMA/hns: Fix uninitialized variable bug

Jason Gunthorpe (35):
      RDMA/core: Get rid of ib_create_qp_user
      RDMA/ucma: Use refcount_t for the ctx->ref
      RDMA/bnxt_re: Using vmalloc requires including vmalloc.h
      RDMA/ucma: Put a lock around every call to the rdma_cm layer
      Merge tag 'v5.6-rc4' into rdma.git for-next
      Merge branch 'mlx5_packet_pacing' into rdma.git for-next
      Merge tag 'v5.6-rc5' into rdma.git for-next
      RDMA/cma: Teach lockdep about the order of rtnl and lock
      RDMA/mlx5: Rename the tracking variables for the MR cache
      RDMA/mlx5: Simplify how the MR cache bucket is located
      RDMA/mlx5: Always remove MRs from the cache before destroying them
      RDMA/mlx5: Fix MR cache size and limit debugfs
      RDMA/mlx5: Lock access to ent->available_mrs/limit when doing queue_work
      RDMA/mlx5: Fix locking in MR cache work queue
      RDMA/mlx5: Revise how the hysteresis scheme works for cache filling
      RDMA/mlx5: Allow MRs to be created in the cache synchronously
      Merge branch 'mlx5_mr_cache' into rdma.git for-next
      RDMA/cm: Fix ordering of xa_alloc_cyclic() in ib_create_cm_id()
      RDMA/cm: Fix checking for allowed duplicate listens
      RDMA/cm: Remove a race freeing timewait_info
      RDMA/cm: Make the destroy_id flow more robust
      RDMA/cm: Simplify establishing a listen cm_id
      RDMA/cm: Read id.state under lock when doing pr_debug()
      RDMA/cm: Make it clear that there is no concurrency in cm_sidr_req_handler()
      RDMA/cm: Make it clearer how concurrency works in cm_req_handler()
      RDMA/cm: Add missing locking around id.state in cm_dup_req_handler
      RDMA/cm: Add some lockdep assertions for cm_id_priv->lock
      RDMA/cm: Allow ib_send_cm_dreq() to be done under lock
      RDMA/cm: Allow ib_send_cm_drep() to be done under lock
      RDMA/cm: Allow ib_send_cm_rej() to be done under lock
      RDMA/cm: Allow ib_send_cm_sidr_rep() to be done under lock
      RDMA/cm: Make sure the cm_id is in the IB_CM_IDLE state in destroy
      RDMA/bnxt_re: Use ib_device_try_get()
      RDMA/bnxt_re: Fix lifetimes in bnxt_re_task
      Merge branch 'mlx5_tx_steering' into rdma.git for-next

Jihua Tao (1):
      RDMA/hns: Reduce PFC frames in congestion scenarios

Kaike Wan (3):
      IB/hfi1: Remove kobj from hfi1_devdata
      IB/hfi1: Fix memory leaks in sysfs registration and unregistration
      IB/hfi1: Call kobject_put() when kobject_init_and_add() fails

Kamal Heib (3):
      RDMA/siw: Fix setting active_mtu attribute
      RDMA/siw: Fix setting active_{speed, width} attributes
      RDMA/providers: Fix return value when QP type isn't supported

Lang Cheng (10):
      RDMA/hns: Cleanups of magic numbers
      RDMA/hns: Initialize all fields of doorbells to zero
      RDMA/hns: Treat revision HIP08_A as a special case
      RDMA/hns: Check if depth of qp is 0 before configure
      RDMA/hns: Simplify attribute judgment code
      RDMA/hns: Adjust the qp status value sequence of the hardware
      RDMA/hns: Remove definition of cq doorbell structure
      RDMA/hns: Remove redundant qpc setup operations
      RDMA/hns: Reduce the maximum number of extend SGE per WQE
      RDMA/hns: Modify the mask of QP number for CQE of hip08

Leon Romanovsky (8):
      RDMA/ucma: Mask QPN to be 24 bits according to IBTA
      RDMA/ipoib: Don't set constant driver version
      RDMA/opa_vnic: Delete driver version
      RDMA/mlx4: Delete duplicated offsetofend implementation
      RDMA/mlx5: Use offsetofend() instead of duplicated variant
      RDMA/cm: Delete not implemented CM peer to peer communication
      RDMA/efa: Use in-kernel offsetofend() to check field availability
      IB/mlx5: Limit the scope of struct mlx5_bfreg_info to mlx5_ib

Lijun Ou (2):
      RDMA/hns: Unify format of prints
      RDMA/hns: Optimize hns_roce_alloc_vf_resource()

Mauro Carvalho Chehab (1):
      IB/hfi1: Get rid of a warning

Max Gurtovoy (1):
      RDMA/rw: map P2P memory correctly for signature operations

Michael Guralnik (4):
      RDMA/core: Add weak ordering dma attr to dma mapping
      RDMA/mlx5: Prevent UMR usage with RO only when we have RO caps
      net/mlx5: Add support for RDMA TX steering
      RDMA/mlx5: Add support for RDMA TX flow table

Mike Marciniszyn (1):
      IB/rdmavt: Delete unused routine

Parav Pandit (8):
      RDMA/cma: Use a helper function to enqueue resolve work items
      RDMA/cma: Use RDMA device port iterator
      RDMA/cma: Rename cma_device ref/deref helpers to to get/put
      RDMA/cma: Use refcount API to reflect refcount
      RDMA/cma: Rename cma_device ref/deref helpers to to get/put
      RDMA/cma: Use refcount API to reflect refcount
      IB/mlx5: Add np_min_time_between_cnps and rp_max_rate debug params
      IB/mlx5: Fix missing congestion control debugfs on rep rdma device

Saeed Mahameed (1):
      RDMA/mlx5: Replace spinlock protected write with atomic var

Selvin Xavier (6):
      RDMA/core: Add helper function to retrieve driver gid context from gid attr
      RDMA/bnxt_re: Use rdma_read_gid_hw_context to retrieve HW gid index
      RDMA/bnxt_re: Refactor device add/remove functionalities
      RDMA/bnxt_re: Use driver_unregister and unregistration API
      RDMA/bnxt_re: Remove unnecessary sched count
      RDMA/bnxt_re: Wait for all the CQ events before freeing CQ data structures

Sergey Gorenko (1):
      IB/iser: Always check sig MR before putting it to the free pool

Shiraz Saleem (1):
      i40iw: Do an RCU lookup in i40iw_add_ipv4_addr

Sindhu, Devale (1):
      i40iw: Report correct firmware version

Takashi Iwai (1):
      IB/hfi1: Use scnprintf() for avoiding potential buffer overflow

Weihang Li (4):
      RDMA/hns: Fix wrong judgments of udata->outlen
      RDMA/hns: Fix a wrong judgment of return value
      RDMA/hns: Remove redundant assignment of wc->smac when polling cq
      RDMA/hns: Remove redundant judgment of qp_type

Wenpeng Liang (1):
      RDMA/hns: Remove meaningless prints

Xi Wang (15):
      RDMA/hns: Optimize eqe buffer allocation flow
      RDMA/hns: Optimize qp destroy flow
      RDMA/hns: Optimize qp context create and destroy flow
      RDMA/hns: Optimize qp number assign flow
      RDMA/hns: Optimize qp buffer allocation flow
      RDMA/hns: Optimize qp param setup flow
      RDMA/hns: Optimize kernel qp wrid allocation flow
      RDMA/hns: Optimize qp doorbell allocation flow
      RDMA/hns: Rename wqe buffer related functions
      RDMA/hns: Optimize wqe buffer filling process for post send
      RDMA/hns: Optimize the wr opcode conversion from ib to hns
      RDMA/hns: Optimize base address table config flow for qp buffer
      RDMA/hns: Optimize wqe buffer set flow for post send
      RDMA/hns: Optimize mhop get flow for multi-hop addressing
      RDMA/hns: Optimize mhop put flow for multi-hop addressing

Yishai Hadas (6):
      IB/mlx5: Introduce UAPIs to manage packet pacing
      IB/mlx5: Generally use the WC auto detection test result
      IB/mlx5: Expose UAR object and its alloc/destroy commands
      IB/mlx5: Extend CQ creation to get uar page index from user space
      IB/mlx5: Extend QP creation to get uar page index from user space
      IB/mlx5: Move to fully dynamic UAR mode once user space supports it

Yixian Liu (4):
      RDMA/hns: Add the workqueue framework for flush cqe handler
      RDMA/hns: Delayed flush cqe process with workqueue
      RDMA/hns: Use flush framework for the case in aeq
      RDMA/hns: Stop doorbell update while qp state error

YueHaibing (4):
      RDMA/bnxt_re: Remove set but not used variable 'pg_size'
      RDMA/bnxt_re: Remove set but not used variable 'dev_attr'
      RDMA/bnxt_re: Remove set but not used variables 'pg' and 'idx'
      RDMA/bnxt_re: make bnxt_re_ib_init static

Zhu Yanjun (2):
      RDMA/core: Remove the duplicate header file
      RDMA/rxe: Set sys_image_guid to be aligned with HW IB devices

 drivers/infiniband/core/cache.c                    |   19 +-
 drivers/infiniband/core/cm.c                       |  746 ++++----
 drivers/infiniband/core/cma.c                      |  114 +-
 drivers/infiniband/core/cma_configfs.c             |    6 +-
 drivers/infiniband/core/cma_priv.h                 |    6 +-
 drivers/infiniband/core/mad_priv.h                 |    4 +-
 drivers/infiniband/core/multicast.c                |    2 +-
 drivers/infiniband/core/rw.c                       |   12 +-
 drivers/infiniband/core/sa_query.c                 |    2 +-
 drivers/infiniband/core/ucma.c                     |   61 +-
 drivers/infiniband/core/umem.c                     |   11 +-
 drivers/infiniband/core/verbs.c                    |   24 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h            |   26 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |  926 ++++++----
 drivers/infiniband/hw/bnxt_re/main.c               |  492 +++---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  489 +++---
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |   95 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |  463 +++--
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h         |   85 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c          |  470 +++--
 drivers/infiniband/hw/bnxt_re/qplib_res.h          |  145 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |   48 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h             |    4 +-
 drivers/infiniband/hw/cxgb4/qp.c                   |    2 +-
 drivers/infiniband/hw/cxgb4/t4fw_ri_api.h          |    8 +-
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h    |    7 +-
 drivers/infiniband/hw/efa/efa_admin_defs.h         |    4 +-
 drivers/infiniband/hw/efa/efa_com.c                |  158 +-
 drivers/infiniband/hw/efa/efa_com_cmd.c            |   29 +-
 drivers/infiniband/hw/efa/efa_common_defs.h        |   13 +-
 drivers/infiniband/hw/efa/efa_regs_defs.h          |   25 +-
 drivers/infiniband/hw/efa/efa_verbs.c              |   51 +-
 drivers/infiniband/hw/hfi1/fault.c                 |    4 +-
 drivers/infiniband/hw/hfi1/file_ops.c              |    4 +-
 drivers/infiniband/hw/hfi1/hfi.h                   |    2 -
 drivers/infiniband/hw/hfi1/init.c                  |   26 +-
 drivers/infiniband/hw/hfi1/mad.c                   |    4 +-
 drivers/infiniband/hw/hfi1/mad.h                   |    2 +-
 drivers/infiniband/hw/hfi1/pio.h                   |    4 +-
 drivers/infiniband/hw/hfi1/sdma.c                  |    2 +-
 drivers/infiniband/hw/hfi1/sdma.h                  |    4 +-
 drivers/infiniband/hw/hfi1/sysfs.c                 |   26 +-
 drivers/infiniband/hw/hfi1/user_exp_rcv.h          |    2 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c            |    8 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        |   54 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c           |  474 ++---
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |   46 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         | 1851 +++++++-------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |   16 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c            |    2 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c            |    6 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |  977 ++++++-----
 drivers/infiniband/hw/hns/hns_roce_srq.c           |    3 +-
 drivers/infiniband/hw/i40iw/i40iw.h                |   22 +-
 drivers/infiniband/hw/i40iw/i40iw_cm.h             |    4 +-
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c           |   96 +
 drivers/infiniband/hw/i40iw/i40iw_d.h              |   26 +-
 drivers/infiniband/hw/i40iw/i40iw_main.c           |   24 +-
 drivers/infiniband/hw/i40iw/i40iw_p.h              |    1 +
 drivers/infiniband/hw/i40iw/i40iw_status.h         |    3 +-
 drivers/infiniband/hw/i40iw/i40iw_type.h           |   12 +
 drivers/infiniband/hw/i40iw/i40iw_verbs.c          |   12 +-
 drivers/infiniband/hw/mlx4/main.c                  |    9 +-
 drivers/infiniband/hw/mlx4/qp.c                    |    2 +-
 drivers/infiniband/hw/mlx5/Makefile                |    1 +
 drivers/infiniband/hw/mlx5/cong.c                  |   20 +
 drivers/infiniband/hw/mlx5/cq.c                    |   21 +-
 drivers/infiniband/hw/mlx5/flow.c                  |    3 +
 drivers/infiniband/hw/mlx5/main.c                  |  265 ++-
 drivers/infiniband/hw/mlx5/mem.c                   |    2 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |   89 +-
 drivers/infiniband/hw/mlx5/mr.c                    |  608 ++++---
 drivers/infiniband/hw/mlx5/odp.c                   |    2 +-
 drivers/infiniband/hw/mlx5/qos.c                   |  136 ++
 drivers/infiniband/hw/mlx5/qp.c                    |   35 +-
 drivers/infiniband/hw/mthca/mthca_memfree.c        |    2 +-
 drivers/infiniband/hw/mthca/mthca_memfree.h        |    2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c       |    2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |    2 +-
 drivers/infiniband/hw/qedr/verbs.c                 |    2 +-
 drivers/infiniband/hw/qib/qib_verbs.c              |    2 -
 drivers/infiniband/hw/qib/qib_verbs.h              |    1 -
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c       |    2 +-
 drivers/infiniband/hw/usnic/usnic_uiom.h           |    2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c       |    2 +-
 drivers/infiniband/sw/rdmavt/qp.c                  |    2 +-
 drivers/infiniband/sw/rdmavt/vt.c                  |    6 -
 drivers/infiniband/sw/rxe/rxe.c                    |    2 +
 drivers/infiniband/sw/rxe/rxe_qp.c                 |    7 +-
 drivers/infiniband/sw/rxe/rxe_queue.h              |    2 +-
 drivers/infiniband/sw/siw/siw_cm.c                 |  137 +-
 drivers/infiniband/sw/siw/siw_qp_rx.c              |    2 +-
 drivers/infiniband/sw/siw/siw_verbs.c              |   11 +-
 drivers/infiniband/ulp/ipoib/ipoib.h               |    2 -
 drivers/infiniband/ulp/ipoib/ipoib_ethtool.c       |    3 -
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |    4 -
 drivers/infiniband/ulp/iser/iser_memory.c          |   21 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h   |    6 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c |    2 -
 .../infiniband/ulp/opa_vnic/opa_vnic_internal.h    |    1 -
 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c    |    5 -
 drivers/infiniband/ulp/srp/ib_srp.h                |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   53 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |    7 +-
 include/linux/mlx5/device.h                        |    6 +
 include/linux/mlx5/driver.h                        |   17 -
 include/linux/mlx5/fs.h                            |    1 +
 include/linux/mlx5/mlx5_ifc.h                      |    8 +-
 include/rdma/ib_cache.h                            |    1 +
 include/rdma/ib_cm.h                               |    1 -
 include/rdma/ib_fmr_pool.h                         |    2 +-
 include/rdma/ib_verbs.h                            |   49 +-
 include/rdma/opa_vnic.h                            |    2 +-
 include/rdma/rdmavt_mr.h                           |    2 +-
 include/rdma/rdmavt_qp.h                           |    2 +-
 include/rdma/uverbs_ioctl.h                        |    2 +-
 include/uapi/rdma/mlx5-abi.h                       |    6 +
 include/uapi/rdma/mlx5_user_ioctl_cmds.h           |   35 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h          |   10 +
 120 files changed, 5401 insertions(+), 4495 deletions(-)
(diffstat from tag for-linus-merged)

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl6FHUoACgkQOG33FX4g
mxqq3g//Uc5ladXCiIfdnjp2J+t6xOAjdLNbHke1VRpTS0nqcwZlNKTEMRqTL+y5
OTMc/ueQNRtphXA6mTv4UInfY1Dv/5vmIRbLY5Cnx4ex4Vf5+HmtVIq/QeS1qG3Z
EZJVmJlacxOEimCwi4YCzRxWU6SkEJhpbOKcmuJ/Q4b4cZmrXKEfYaW/D8VSUACH
2dbXViJJvO6xIyXUII/zC3Khy4uPnvtOtwuYnOS29tpTJqsbdcxJkfJ81DgWAVQC
Lz6RdfHQMjyibELBV3xZTaWD5TgNN1E1BXt9ViDnTGaWnb47nCBEtnz7uEAbPbBg
aasV8dGA24uSVX8juvkbEW37e+YYLNTpC9XPdIP+Ia1TSPeo4ns1CY9qhfTdbnAh
W4WnRGlKG0pTS2O/EWJ1owNjkPxE2h0I1EdQ6lymZti8Of9d/DqOG4PwVilWhuD2
loUJYTntt6c6CkwTQEUe5eCtkjp6s8u+xP6JdSu0iJkzEDVz14n2F2XKREwJ+b8x
IKK2d1p9U1p4qqQsqDpI8RMvpT5Y59XtmmOqC1hjV0Ta0iwO6NYNq48h2ZVtfeDf
0tc8H0KJwEoVd9XYCFATMhNudWuyR9xkqYn0ySOJnixUc7dfsV2IGt3naGRSO1ab
QpgnYHehbWebUzKV9mIs1l8MBvA/tOwjHT0GFy+ltB6m5aYuurs=
=S4SI
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
