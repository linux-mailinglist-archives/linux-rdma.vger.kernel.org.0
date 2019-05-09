Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C23618ADB
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2019 15:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfEINhb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 May 2019 09:37:31 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:44861
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726195AbfEINhb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 9 May 2019 09:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqMY+lNueTPGSye3++y6+jc5lIKa91Q7bYM1OIrE590=;
 b=MN9UV00aoG7t+XhfQJjylJXVgyHKVOb8LNtYY6B0wStiuAHAFBlgAGUMQuXhXpu9+Pvop78yoh3FwZA9aiIcQH4wMwKipUfnZ/rt5SmBmTr8AnWN+/LYWpE3u/WLI5ksU8TAfdhauz5UnGVY17bEbCefGmHZhkZ850vLXJoD9Wk=
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (52.134.107.143) by
 DB7PR05MB4122.eurprd05.prod.outlook.com (52.134.107.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Thu, 9 May 2019 13:37:24 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::b116:7549:7b2a:c611]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::b116:7549:7b2a:c611%3]) with mapi id 15.20.1856.012; Thu, 9 May 2019
 13:37:23 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHVBmxV5eRBaDwvRUiRaNaFnylsJw==
Date:   Thu, 9 May 2019 13:37:23 +0000
Message-ID: <20190509133711.GA16703@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::42) To DB7PR05MB4138.eurprd05.prod.outlook.com
 (2603:10a6:5:18::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c820876-2391-427e-866f-08d6d48377a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(49563074)(7193020);SRVR:DB7PR05MB4122;
x-ms-traffictypediagnostic: DB7PR05MB4122:
x-microsoft-antispam-prvs: <DB7PR05MB41223ED850E855D2A3B45B09CF330@DB7PR05MB4122.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:95;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(136003)(39860400002)(189003)(199004)(305945005)(6512007)(9686003)(966005)(14454004)(478600001)(486006)(53946003)(7736002)(6306002)(52116002)(33656002)(99286004)(5660300002)(68736007)(66946007)(66066001)(25786009)(66616009)(66476007)(4326008)(99936001)(53936002)(14444005)(66556008)(64756008)(73956011)(256004)(66446008)(1076003)(6506007)(386003)(102836004)(6486002)(71190400001)(71200400001)(26005)(30864003)(6436002)(81166006)(8676002)(54906003)(8936002)(110136005)(81156014)(316002)(476003)(86362001)(36756003)(3846002)(6116002)(186003)(2906002)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4122;H:DB7PR05MB4138.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bsg5caNG3lq8ZHnnSdfaJgZn4eoatHNFatklp9knF95On0XC+SoafQFc2mmSTrk9N34JvwqDPHdsYNSBpeKhLTuF+wl8S+urlmtKSJVJDHgKRhVtb5juJ9xOSjj1kfJ80pcIhxvluzpyofb7cOVsjParoF6rn8c1qCm9M03eb1zVUKvKGnLHM3KHQkz125rzokyk+wMjk7U2Y6zYmyYxBFcEATj8nIIj4knx1pAOfwIPneKmF2eA/XsJ0Hwu74N6rnHqWydreZxrPLRfgD1rTLC7qiEv0FK1Skr+ZRr9B4uZRzrTpk0K62+AQ8pkTAEM4j3MiO/FFFLcZ62faSO4AcCsd/mhNf+BAFRBL+aUv2+JtfDPFhr+MIes+B79BVTBQthpEjwirTjSM3YpM9y6x+NmZEBNTM7v2ciK8CpJ80Q=
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c820876-2391-427e-866f-08d6d48377a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 13:37:23.7626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4122
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

These are the proposed RDMA patches for 5.2.

There is a small conflict with the mlx5-next (net-next) tree resolved with
this hunk:

diff --cc drivers/infiniband/hw/mlx5/main.c
index 687f99172037be,fae6a6a1fbea12..abac70ad5c7c46
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@@ -200,12 -172,18 +200,12 @@@ static int mlx5_netdev_event(struct not

        switch (event) {
        case NETDEV_REGISTER:
 +              /* Should already be registered during the load */
 +              if (ibdev->is_rep)
 +                      break;
                write_lock(&roce->netdev_lock);
-               if (ndev->dev.parent == &mdev->pdev->dev)
 -              if (ibdev->rep) {
 -                      struct mlx5_eswitch *esw = ibdev->mdev->priv.eswitch;
 -                      struct net_device *rep_ndev;
 -
 -                      rep_ndev = mlx5_ib_get_rep_netdev(esw,
 -                                                        ibdev->rep->vport);
 -                      if (rep_ndev == ndev)
 -                              roce->netdev = ndev;
 -              } else if (ndev->dev.parent == mdev->device) {
++              if (ndev->dev.parent == mdev->device)
                        roce->netdev = ndev;
 -              }
                write_unlock(&roce->netdev_lock);
                break;

I also have some notifications from StephenR about minor conflicts with
patches in akpm's tree that you haven't merged yet. Here are his resolutions:

https://lore.kernel.org/lkml/20190509153805.6dfbb8ef@canb.auug.org.au/
https://lore.kernel.org/lkml/20190506204824.11a7b368@canb.auug.org.au/
https://lore.kernel.org/lkml/20190506203710.10b080dc@canb.auug.org.au/

The tag for-linus-merged with my merge resolution for the mlx5-next
branch is also available to pull.

The following changes since commit 96780e4f46b2fc0fc5ae2b95957002e2c42b11d3:

  net/mlx5: Introduce new TIR creation core API (2019-04-24 12:33:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to b79656ed44c6865e17bcd93472ec39488bcc4984:

  RDMA/ipoib: Allow user space differentiate between valid dev_port (2019-05-07 16:13:23 -0300)

----------------------------------------------------------------
5.2 Merge Window pull request

This has been a smaller cycle than normal. One new driver was accepted,
which is unusual, and at least one more driver remains in review on the
list.

- Driver fixes for hns, hfi1, nes, rxe, i40iw, mlx5, cxgb4, vmw_pvrdma

- Many patches from MatthewW converting radix tree and IDR users to use
  xarray

- Introduction of tracepoints to the MAD layer

- Build large SGLs at the start for DMA mapping and get the driver to
  split them

- Generally clean SGL handling code throughout the subsystem

- Support for restricting RDMA devices to net namespaces for containers

- Progress to remove object allocation boilerplate code from drivers

- Change in how the mlx5 driver shows representor ports linked to VFs

- mlx5 uapi feature to access the on chip SW ICM memory

- Add a new driver for 'EFA'. This is HW that supports user space packet
  processing through QPs in Amazon's cloud

----------------------------------------------------------------
Ariel Levkovich (5):
      IB/mlx5: Expose TIR ICM address to user space
      IB/mlx5: Support device memory type attribute
      IB/mlx5: Warn on allocated MEMIC buffers during cleanup
      IB/mlx5: Add steering SW ICM device memory type
      IB/mlx5: Device resource control for privileged DEVX user

Artemy Kovalyov (3):
      IB/mlx5: WQE dump jumps over first 16 bytes
      IB/mlx5: Compare only index part of a memory window rkey
      IB/core: Set qp->real_qp before it may be accessed

Bart Van Assche (6):
      RDMA/uverbs: Add a __user annotation to a pointer
      RDMA/uverbs: Annotate uverbs_request_next_ptr() return value as a __user pointer
      RDMA/uverbs: Allow the compiler to verify declaration and definition consistency
      IB/mlx5: Declare devx_async_cmd_event_fops static
      IB/hfi1: Fix two format strings
      IB/qib: Remove a set-but-not-used variable

Chengguang Xu (1):
      infiniband/qib: Fix typo in comment

Colin Ian King (6):
      RDMA/nes: remove redundant check on udata
      IB/iser: remove uninitialized variable len
      opa_vnic: fix check on record->event, incorrect operator used
      RDMA/mlx5: Check for error return in flow_rule rather than err
      RDMA/cxgb4: Fix null pointer dereference on alloc_skb failure
      RDMA/cxgb4: Fix spelling mistake "immedate" -> "immediate"

Dennis Dalessandro (1):
      IB/core, ipoib: Do not overreact to SM LID change event

Devesh Sharma (1):
      RDMA/ocrdma: Remove use of idr use pci bdf instead

Enrico Weigelt, metux IT consult (1):
      drivers: infiniband: Fix whitespace in kconfig

Erez Alfasi (1):
      RDMA: Use __packed annotation instead of __attribute__ ((packed))

Gal Pressman (14):
      RDMA/core: Introduce RDMA subsystem ibdev_* print functions
      RDMA/uverbs: Initialize udata struct on destroy flows
      RDMA: Add EFA related definitions
      RDMA/efa: Add EFA device definitions
      RDMA/efa: Add the efa.h header file
      RDMA/efa: Add the efa_com.h file
      RDMA/efa: Add the com service API definitions
      RDMA/efa: Add the ABI definitions
      RDMA/efa: Implement functions that submit and complete admin commands
      RDMA/efa: Add common command handlers
      RDMA/efa: Add EFA verbs implementation
      RDMA/efa: Add the efa module
      RDMA/efa: Add driver to Kconfig/Makefile
      lib/scatterlist: Remove leftover from sg_page_iter comment

Ira Weiny (7):
      IB/core: Ensure an invalidate_range callback on ODP MR
      IB/MAD: Add send path trace points
      IB/MAD: Add recv path trace point
      IB/MAD: Add agent trace points
      IB/UMAD: Add umad trace points
      IB/MAD: Add SMP details to MAD tracing
      BPF: Add sample code for new ib_umad tracepoint

Jack Morgenstein (1):
      IB/mlx5: Add missing XRC options to QP optional params mask

Jason Gunthorpe (9):
      Merge HFI1 updates into k.o/for-next
      IB/mlx5: Remove references to uboject->context
      IB: When attrs.udata/ufile is available use that instead of uobject
      RDMA/drivers: Convert easy drivers to use ib_device_set_netdev()
      Merge branch 'mlx5-next' into rdma.git for-next
      RDMA/mlx5: Use get_zeroed_page() for clock_info
      RDMA: Remove rdma_user_mmap_page
      Merge branch 'rdma_mmap' into rdma.git for-next
      Merge branch 'mlx5_tir_icm' into rdma.git for-next

John Fleck (1):
      IB/hfi1: Remove reference to RHF.VCRCErr

Josh Collier (1):
      IB/hfi1: Add debugfs to control expansion ROM write protect

Kaike Wan (6):
      IB/hfi1: Delay the release of destination mr for TID RDMA WRITE DATA
      IB/hfi1: Add a function to read next expected psn from hardware flow
      IB/hfi1: Unify the software PSN check for TID RDMA READ/WRITE
      IB/hfi1: Remove WARN_ON when freeing expected receive groups
      IB/hfi1: Implement CCA for TID RDMA protocol
      IB/{rdmavt, hfi1): Miscellaneous comment fixes

Kamal Heib (1):
      RDMA: Get rid of iw_cm_verbs

Kangjie Lu (1):
      RDMA/i40iw: Handle workqueue allocation failure

Leon Romanovsky (19):
      RDMA/rxe: Fix slab-out-bounds access which lead to kernel crash later
      overflow: Fix -Wtype-limits compilation warnings
      RDMA/hns: Limit scope of hns_roce_cmq_send()
      RDMA/netlink: Remove unused data structure
      RDMA/core: Don't compare specific bit after boolean AND
      RDMA/hns: Fix bad endianess of port_pd variable
      RDMA/cma: Set proper port number as index
      RDMA/mlx5: Cleanup WQE page fault handler
      RDMA/cm: Remove useless zeroing of static global variable
      RDMA/cm: Move debug counters to be under relevant IB device
      RDMA/nldev: Return device protocol
      RDMA/core: Support object allocation in atomic context
      RDMA: Handle AH allocations by IB/core
      RDMA: Handle SRQ allocations by IB/core
      RDMA/hns: Remove asynchronic QP destroy
      RDMA/rdmavt: Catch use-after-free access of AH structures
      RDMA/mlx5: Remove MAYEXEC flag
      RDMA/device: Don't fire uevent before device is fully initialized
      RDMA/ipoib: Allow user space differentiate between valid dev_port

Lijun Ou (8):
      RDMA/hns: Only assign the relatived fields of psn if IB_QP_SQ_PSN is set
      RDMA/hns: Only assign the fields of the rq psn if IB_QP_RQ_PSN is set
      RDMA/hns: Update the range of raq_psn field of qp context
      RDMA/hns: Only assgin some fields if the relatived attr_mask is set
      RDMA/hns: Hide error print information with roce vf device
      RDMA/hns: Bugfix for sending with invalidate
      RDMA/hns: Delete unused variable in hns_roce_v2_modify_qp function
      RDMA/hns: Dump detailed driver-specific CQ

Maor Gottlieb (1):
      RDMA/mlx5: Add query e-switch vport context to devx white list

Mark Bloch (16):
      RDMA/mlx5: Move netdev info into the port struct
      RDMA/mlx5: Free IB device on remove
      RDMA/mlx5: Move ports allocation to outside of INIT stage
      RDMA/mlx5: Use correct size for device resources
      RDMA/mlx5: Move rep into port struct
      RDMA/mlx5: Move default representors SQ steering to rule to modify QP
      RDMA/mlx5: Refactor netdev affinity code
      RDMA/mlx5: Move SMI caps logic
      RDMA/mlx5: Move to single device multiport ports in switchdev mode
      RDMA/mlx5: Remove VF representor profile
      RDMA/mlx5: Access the prio bypass inside the FDB flow table namespace
      RDMA/mlx5: Create flow table with max size supported
      RDMA/mlx5: Allow inserting a steering rule to the FDB
      RDMA/mlx5: Allow DEVX and raw creation flow on reps
      RDMA/mlx5: Initialize roce port info before multiport master init
      RDMA/mlx5: Don't create IB representors when in multiport RoCE mode

Matthew Wilcox (26):
      cxgb3: Convert cqidr to XArray
      cxgb3: Convert qpidr to XArray
      cxgb3: Convert mmidr to XArray
      cxgb4: Convert cqidr to XArray
      cxgb4: Convert qpidr to XArray
      cxgb4: Convert mmidr to XArray
      cxgb4: Convert hwtid_idr to XArray
      cxgb4: Convert atid_idr to XArray
      cxgb4: Convert stid_idr to XArray
      mlx5: Convert mlx5_srq_table to XArray
      mlx4: Convert pv_id_table to XArray
      IB/mad: Convert ib_mad_clients to XArray
      RDMA/cm: Convert local_id_table to XArray
      ib core: Convert query_idr to XArray
      ucm: Convert ctx_id_table to XArray
      cma: Convert portspace IDRs to XArray
      RDMA/hns: Convert cq_table to XArray
      RDMA/hns: Convert qp_table_tree to XArray
      hfi1: Convert vesw_idr to XArray
      qedr: Convert qpidr to XArray
      qedr: Convert srqidr to XArray
      hfi1: Convert hfi1_unit_table to XArray
      qib: Convert qib_unit_table to XArray
      opa_vnic: Convert vport_idr to XArray
      ib/bnxt: Remove mention of idr_alloc from comment
      uverbs: Convert idr to XArray

Mike Marciniszyn (7):
      IB/hfi1: Add running average for adaptive pio
      IB/hfi1: Make opfn.h self sufficient
      IB/rdmavt: Fix ab/ba include issues
      IB/rdmavt: Use more efficient allowed_ops
      IB/{rdmavt, qib, hfi1}: Use new routine to release reference counts
      IB/hfi1: Add selected Rcv counters
      IB/hfi1: Fix WQ_MEM_RECLAIM warning

Parav Pandit (22):
      RDMA/core: Introduce ib_core_device to hold device
      RDMA/core: Restrict sysfs entries view to init_net
      RDMA/core: Implement compat device/sysfs tree in net namespace
      RDMA/core: Support core port attributes in non init_net
      RDMA/core: Add module param to disable device sharing among net ns
      RDMA: Check net namespace access for uverbs, umad, cma and nldev
      RDMA/core: Extend ib_device_get_by_index for net namespace
      RDMA/core: Add interface to read device namespace sharing mode
      RDMA/core: Add command to set ib_core device net namspace sharing mode
      RDMA/core: Avoid freeing netdevs in disable_device()
      RDMA/core: Introduce a helper function to change net namespace of rdma device
      RDMA/core: Add a netlink command to change net namespace of rdma device
      IB/core: Allow vlan link local address based RoCE GIDs
      RDMA/cma: Consider scope_id while binding to ipv6 ll address
      RDMA/core: Do not invoke init_port on compat devices
      RDMA/rxe: Consider skb reserve space based on netdev of GID
      IB/cm: Reduce dependency on gid attribute ndev check
      RDMA: Introduce and use GID attr helper to read RoCE L2 fields
      RDMA/cma: Use rdma_read_gid_attr_ndev_rcu to access netdev
      RDMA/rxe: Use rdma_read_gid_attr_ndev_rcu to access netdev
      net/smc: Use rdma_read_gid_l2_fields to L2 fields
      RDMA/core: Allow detaching gid attribute netdevice for RoCE

Potnuri Bharat Teja (2):
      iw_cxgb4: Update Maintainer details
      RDMA/iw_cxgb4: Always disconnect when QP is transitioning to TERMINATE state

Selvin Xavier (1):
      RDMA/bnxt_re: Use correct sizing on buffers holding page DMA addresses

Shamir Rabinovitch (6):
      IB: ucontext should be set properly for all cmd & ioctl paths
      IB: Pass uverbs_attr_bundle down uobject destroy path
      IB: Pass uverbs_attr_bundle down ib_x destroy path
      IB: Remove 'uobject->context' dependency in object destroy APIs
      IB: Pass only ib_udata in function prototypes
      RDMA/uverbs: Initialize uverbs_attr_bundle ucontext in ib_uverbs_get_context

Shiraz Saleem (12):
      RDMA/cxbg: Use correct sizing on buffers holding page DMA addresses
      RDMA/mthca: Use correct sizing on buffers holding page DMA addresses
      RDMA/rxe: Use correct sizing on buffers holding page DMA addresses
      RDMA/rdmavt: Use correct sizing on buffers holding page DMA addresses
      RDMA/umem: Combine contiguous PAGE_SIZE regions in SGEs
      RDMA/umem: Use correct value for SG entries in sg_copy_to_buffer()
      RDMA/umem: Handle page combining avoidance correctly in ib_umem_add_sg_table()
      RDMA/umem: Add API to find best driver supported page size in an MR
      RDMA/verbs: Add a DMA iterator to return aligned contiguous memory blocks
      RDMA/i40iw: Use core helpers to get aligned DMA address within a supported page size
      RDMA/bnxt_re: Use core helpers to get aligned DMA address
      RDMA/umem: Remove hugetlb flag

Steve Wise (1):
      RDMA/cxgb4: Use ib_device_set_netdev()

Yuval Shaia (1):
      RDMA/vmw_pvrdma: Skip zeroing device attrs

Zhu Yanjun (1):
      IB/rxe: Replace av->network_type with skb->protocol

chenglang (1):
      RDMA/hns: Support to create 1M srq queue

 MAINTAINERS                                        |   17 +-
 drivers/infiniband/Kconfig                         |    1 +
 drivers/infiniband/core/addr.c                     |    1 +
 drivers/infiniband/core/cache.c                    |  145 +-
 drivers/infiniband/core/cm.c                       |   94 +-
 drivers/infiniband/core/cm_msgs.h                  |   22 +-
 drivers/infiniband/core/cma.c                      |   83 +-
 drivers/infiniband/core/core_priv.h                |   18 +-
 drivers/infiniband/core/cq.c                       |   21 +-
 drivers/infiniband/core/device.c                   |  632 ++++++-
 drivers/infiniband/core/iwcm.c                     |   35 +-
 drivers/infiniband/core/mad.c                      |   87 +-
 drivers/infiniband/core/mad_priv.h                 |    4 +-
 drivers/infiniband/core/multicast.c                |    1 -
 drivers/infiniband/core/nldev.c                    |  112 +-
 drivers/infiniband/core/rdma_core.c                |  200 +--
 drivers/infiniband/core/rdma_core.h                |   11 +-
 drivers/infiniband/core/sa_query.c                 |   44 +-
 drivers/infiniband/core/sysfs.c                    |   93 +-
 drivers/infiniband/core/ucm.c                      |   35 +-
 drivers/infiniband/core/umem.c                     |  179 +-
 drivers/infiniband/core/umem_odp.c                 |   20 +-
 drivers/infiniband/core/user_mad.c                 |   22 +
 drivers/infiniband/core/uverbs.h                   |    7 +-
 drivers/infiniband/core/uverbs_cmd.c               |   99 +-
 drivers/infiniband/core/uverbs_ioctl.c             |   29 +-
 drivers/infiniband/core/uverbs_main.c              |   69 +-
 drivers/infiniband/core/uverbs_std_types.c         |   52 +-
 .../infiniband/core/uverbs_std_types_counters.c    |    6 +-
 drivers/infiniband/core/uverbs_std_types_cq.c      |   12 +-
 drivers/infiniband/core/uverbs_std_types_dm.c      |   10 +-
 .../infiniband/core/uverbs_std_types_flow_action.c |    6 +-
 drivers/infiniband/core/uverbs_std_types_mr.c      |    9 +-
 drivers/infiniband/core/verbs.c                    |  233 ++-
 drivers/infiniband/hw/Makefile                     |    1 +
 drivers/infiniband/hw/bnxt_re/Kconfig              |   12 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |  194 +--
 drivers/infiniband/hw/bnxt_re/ib_verbs.h           |   36 +-
 drivers/infiniband/hw/bnxt_re/main.c               |    8 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |   39 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |   13 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |    4 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c          |   43 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h          |    8 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |   16 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h           |    4 +-
 drivers/infiniband/hw/cxgb3/cxio_wr.h              |   10 +-
 drivers/infiniband/hw/cxgb3/iwch.c                 |   56 +-
 drivers/infiniband/hw/cxgb3/iwch.h                 |   38 +-
 drivers/infiniband/hw/cxgb3/iwch_ev.c              |   18 +-
 drivers/infiniband/hw/cxgb3/iwch_mem.c             |    2 +-
 drivers/infiniband/hw/cxgb3/iwch_provider.c        |   97 +-
 drivers/infiniband/hw/cxgb4/cm.c                   |   69 +-
 drivers/infiniband/hw/cxgb4/cq.c                   |   23 +-
 drivers/infiniband/hw/cxgb4/device.c               |  210 +--
 drivers/infiniband/hw/cxgb4/ev.c                   |   18 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h             |   96 +-
 drivers/infiniband/hw/cxgb4/mem.c                  |   25 +-
 drivers/infiniband/hw/cxgb4/provider.c             |   77 +-
 drivers/infiniband/hw/cxgb4/qp.c                   |   77 +-
 drivers/infiniband/hw/efa/Kconfig                  |   15 +
 drivers/infiniband/hw/efa/Makefile                 |    9 +
 drivers/infiniband/hw/efa/efa.h                    |  163 ++
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h    |  794 +++++++++
 drivers/infiniband/hw/efa/efa_admin_defs.h         |  136 ++
 drivers/infiniband/hw/efa/efa_com.c                | 1160 +++++++++++++
 drivers/infiniband/hw/efa/efa_com.h                |  144 ++
 drivers/infiniband/hw/efa/efa_com_cmd.c            |  692 ++++++++
 drivers/infiniband/hw/efa/efa_com_cmd.h            |  270 +++
 drivers/infiniband/hw/efa/efa_common_defs.h        |   18 +
 drivers/infiniband/hw/efa/efa_main.c               |  533 ++++++
 drivers/infiniband/hw/efa/efa_regs_defs.h          |  113 ++
 drivers/infiniband/hw/efa/efa_verbs.c              | 1825 ++++++++++++++++++++
 drivers/infiniband/hw/hfi1/chip.c                  |   54 +-
 drivers/infiniband/hw/hfi1/chip.h                  |    3 +
 drivers/infiniband/hw/hfi1/chip_registers.h        |    3 +
 drivers/infiniband/hw/hfi1/common.h                |    2 +-
 drivers/infiniband/hw/hfi1/debugfs.c               |   82 +-
 drivers/infiniband/hw/hfi1/driver.c                |   19 +-
 drivers/infiniband/hw/hfi1/exp_rcv.c               |    3 -
 drivers/infiniband/hw/hfi1/hfi.h                   |    8 +-
 drivers/infiniband/hw/hfi1/init.c                  |   59 +-
 drivers/infiniband/hw/hfi1/opfn.h                  |    6 +-
 drivers/infiniband/hw/hfi1/qp.c                    |    2 +
 drivers/infiniband/hw/hfi1/rc.c                    |   27 +-
 drivers/infiniband/hw/hfi1/rc.h                    |    8 +
 drivers/infiniband/hw/hfi1/ruc.c                   |    2 +-
 drivers/infiniband/hw/hfi1/tid_rdma.c              |  274 ++-
 drivers/infiniband/hw/hfi1/tid_rdma.h              |    2 -
 drivers/infiniband/hw/hfi1/trace_dbg.h             |    4 +-
 drivers/infiniband/hw/hfi1/trace_tid.h             |   12 +-
 drivers/infiniband/hw/hfi1/verbs.c                 |   15 +-
 drivers/infiniband/hw/hfi1/verbs.h                 |    1 +
 drivers/infiniband/hw/hfi1/vnic_main.c             |   16 +-
 drivers/infiniband/hw/hns/Makefile                 |    4 +-
 drivers/infiniband/hw/hns/hns_roce_ah.c            |   36 +-
 drivers/infiniband/hw/hns/hns_roce_cmd.h           |    1 +
 drivers/infiniband/hw/hns/hns_roce_common.h        |   33 -
 drivers/infiniband/hw/hns/hns_roce_cq.c            |   68 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        |   52 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |  396 +----
 drivers/infiniband/hw/hns/hns_roce_hw_v1.h         |   14 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |  320 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |    7 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2_dfx.c     |   35 +
 drivers/infiniband/hw/hns/hns_roce_main.c          |   35 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c            |    6 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c            |    7 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |   50 +-
 drivers/infiniband/hw/hns/hns_roce_restrack.c      |  126 ++
 drivers/infiniband/hw/hns/hns_roce_srq.c           |   52 +-
 drivers/infiniband/hw/i40iw/i40iw.h                |    2 +-
 drivers/infiniband/hw/i40iw/i40iw_cm.c             |   21 +-
 drivers/infiniband/hw/i40iw/i40iw_main.c           |    5 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c          |  123 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.h          |    3 +-
 drivers/infiniband/hw/mlx4/ah.c                    |  103 +-
 drivers/infiniband/hw/mlx4/cm.c                    |   36 +-
 drivers/infiniband/hw/mlx4/cq.c                    |   40 +-
 drivers/infiniband/hw/mlx4/doorbell.c              |    6 +-
 drivers/infiniband/hw/mlx4/mad.c                   |   33 +-
 drivers/infiniband/hw/mlx4/main.c                  |   13 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h               |   41 +-
 drivers/infiniband/hw/mlx4/mr.c                    |    7 +-
 drivers/infiniband/hw/mlx4/qp.c                    |   50 +-
 drivers/infiniband/hw/mlx4/srq.c                   |   59 +-
 drivers/infiniband/hw/mlx5/ah.c                    |   33 +-
 drivers/infiniband/hw/mlx5/cmd.c                   |  155 +-
 drivers/infiniband/hw/mlx5/cmd.h                   |    8 +-
 drivers/infiniband/hw/mlx5/cq.c                    |   47 +-
 drivers/infiniband/hw/mlx5/devx.c                  |   32 +-
 drivers/infiniband/hw/mlx5/flow.c                  |   99 +-
 drivers/infiniband/hw/mlx5/ib_rep.c                |  109 +-
 drivers/infiniband/hw/mlx5/ib_rep.h                |   13 +-
 drivers/infiniband/hw/mlx5/main.c                  |  662 ++++---
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |  118 +-
 drivers/infiniband/hw/mlx5/mr.c                    |   52 +-
 drivers/infiniband/hw/mlx5/odp.c                   |  132 +-
 drivers/infiniband/hw/mlx5/qp.c                    |  161 +-
 drivers/infiniband/hw/mlx5/srq.c                   |   76 +-
 drivers/infiniband/hw/mlx5/srq.h                   |    7 +-
 drivers/infiniband/hw/mlx5/srq_cmd.c               |   35 +-
 drivers/infiniband/hw/mthca/mthca_cq.c             |    2 +-
 drivers/infiniband/hw/mthca/mthca_eq.c             |   16 +-
 drivers/infiniband/hw/mthca/mthca_mr.c             |    2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c       |  179 +-
 drivers/infiniband/hw/mthca/mthca_qp.c             |    6 +-
 drivers/infiniband/hw/nes/nes_cm.c                 |    3 +-
 drivers/infiniband/hw/nes/nes_verbs.c              |  168 +-
 drivers/infiniband/hw/ocrdma/ocrdma_ah.c           |   32 +-
 drivers/infiniband/hw/ocrdma/ocrdma_ah.h           |    6 +-
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c           |   18 +-
 drivers/infiniband/hw/ocrdma/ocrdma_hw.h           |    6 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c         |   25 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |  128 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h        |   24 +-
 drivers/infiniband/hw/qedr/main.c                  |   57 +-
 drivers/infiniband/hw/qedr/qedr.h                  |   11 +-
 drivers/infiniband/hw/qedr/qedr_iw_cm.c            |   10 +-
 drivers/infiniband/hw/qedr/qedr_roce_cm.c          |   11 +-
 drivers/infiniband/hw/qedr/verbs.c                 |  129 +-
 drivers/infiniband/hw/qedr/verbs.h                 |   27 +-
 drivers/infiniband/hw/qib/qib.h                    |    4 +-
 drivers/infiniband/hw/qib/qib_common.h             |    2 +-
 drivers/infiniband/hw/qib/qib_driver.c             |   20 +-
 drivers/infiniband/hw/qib/qib_fs.c                 |   12 +-
 drivers/infiniband/hw/qib/qib_iba7322.c            |    4 +-
 drivers/infiniband/hw/qib/qib_init.c               |   56 +-
 drivers/infiniband/hw/qib/qib_rc.c                 |    4 +-
 drivers/infiniband/hw/qib/qib_user_sdma.c          |    5 +-
 drivers/infiniband/hw/qib/qib_verbs.h              |    2 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c       |   15 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h       |   12 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c           |    3 +-
 drivers/infiniband/hw/usnic/usnic_uiom.h           |    3 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c       |   17 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c     |   28 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c       |   15 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c       |    3 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c      |   43 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c    |   56 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h    |   27 +-
 drivers/infiniband/sw/rdmavt/ah.c                  |   38 +-
 drivers/infiniband/sw/rdmavt/ah.h                  |    8 +-
 drivers/infiniband/sw/rdmavt/cq.c                  |    7 +-
 drivers/infiniband/sw/rdmavt/cq.h                  |    3 +-
 drivers/infiniband/sw/rdmavt/mmap.c                |   16 +-
 drivers/infiniband/sw/rdmavt/mmap.h                |    6 +-
 drivers/infiniband/sw/rdmavt/mr.c                  |    9 +-
 drivers/infiniband/sw/rdmavt/mr.h                  |    7 +-
 drivers/infiniband/sw/rdmavt/pd.c                  |    7 +-
 drivers/infiniband/sw/rdmavt/pd.h                  |    5 +-
 drivers/infiniband/sw/rdmavt/qp.c                  |   27 +-
 drivers/infiniband/sw/rdmavt/qp.h                  |    4 +-
 drivers/infiniband/sw/rdmavt/rc.c                  |    2 +-
 drivers/infiniband/sw/rdmavt/srq.c                 |   49 +-
 drivers/infiniband/sw/rdmavt/srq.h                 |    7 +-
 drivers/infiniband/sw/rdmavt/trace_qp.h            |    2 +-
 drivers/infiniband/sw/rdmavt/trace_rc.h            |    2 +-
 drivers/infiniband/sw/rdmavt/trace_tx.h            |    2 +-
 drivers/infiniband/sw/rdmavt/vt.c                  |    3 +
 drivers/infiniband/sw/rxe/rxe_cq.c                 |   10 +-
 drivers/infiniband/sw/rxe/rxe_hdr.h                |    2 +-
 drivers/infiniband/sw/rxe/rxe_loc.h                |   16 +-
 drivers/infiniband/sw/rxe/rxe_mmap.c               |   14 +-
 drivers/infiniband/sw/rxe/rxe_mr.c                 |   13 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |   46 +-
 drivers/infiniband/sw/rxe/rxe_pool.c               |    4 +-
 drivers/infiniband/sw/rxe/rxe_qp.c                 |   15 +-
 drivers/infiniband/sw/rxe/rxe_queue.c              |   22 +-
 drivers/infiniband/sw/rxe/rxe_queue.h              |   15 +-
 drivers/infiniband/sw/rxe/rxe_srq.c                |   14 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |   90 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h              |    4 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |   13 +-
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c         |    3 +-
 drivers/infiniband/ulp/iser/Kconfig                |    4 +-
 drivers/infiniband/ulp/iser/iscsi_iser.c           |    7 +-
 drivers/infiniband/ulp/iser/iscsi_iser.h           |    2 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c    |   60 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |   30 +-
 include/linux/dynamic_debug.h                      |   11 +
 include/linux/mlx5/driver.h                        |    1 -
 include/linux/overflow.h                           |   12 +-
 include/linux/scatterlist.h                        |   10 +-
 include/rdma/ib_cache.h                            |    4 +
 include/rdma/ib_mad.h                              |    4 +-
 include/rdma/ib_smi.h                              |    2 +-
 include/rdma/ib_umem.h                             |   12 +-
 include/rdma/ib_umem_odp.h                         |    1 +
 include/rdma/ib_verbs.h                            |  430 ++++-
 include/rdma/iw_cm.h                               |   25 -
 include/rdma/opa_port_info.h                       |    2 +-
 include/rdma/opa_smi.h                             |    4 +-
 include/rdma/rdma_vt.h                             |   78 +-
 include/rdma/rdmavt_qp.h                           |   89 +-
 include/rdma/uverbs_std_types.h                    |   42 +-
 include/rdma/uverbs_types.h                        |   18 +-
 include/trace/events/ib_mad.h                      |  390 +++++
 include/trace/events/ib_umad.h                     |  126 ++
 include/uapi/rdma/efa-abi.h                        |  101 ++
 include/uapi/rdma/mlx5-abi.h                       |    2 +
 include/uapi/rdma/mlx5_user_ioctl_cmds.h           |    2 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h          |    7 +
 include/uapi/rdma/rdma_netlink.h                   |   31 +-
 include/uapi/rdma/rdma_user_ioctl_cmds.h           |    1 +
 lib/dynamic_debug.c                                |   37 +
 net/smc/smc_ib.c                                   |   16 +-
 samples/bpf/Makefile                               |    3 +
 samples/bpf/ibumad_kern.c                          |  144 ++
 samples/bpf/ibumad_user.c                          |  122 ++
 251 files changed, 12535 insertions(+), 4571 deletions(-)
(diffstat from merge'd tree)

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAlzULQIACgkQOG33FX4g
mxqOUA/+LaRdsG9T2x4uK7nFdxoN/0kzzU7CCHo+FVEn62PdQltqKJ7kdoTeaVdb
b8rSOv8qTqgPqm4K6iLw6dPoxzIEOEZPk35baBBclV0fmyCB8EkJRvLqb5ktGU2Z
QG0IOgKjGIOIjyHKapUqBjG9mPmxl0RdgEvQ7GA7LslQNu1hnI9iGvIqsnLUx5Kv
PjJQgomSUSTyeMIC91qwNOc16/JuD643nQrNpEqMHeeH+9+cT/wgWhUEYJRv8g67
rvKmVWaU7Hk1UtFzzCcTb5hdG77v+Sl0fHw3CZZAqyFHysDGvPxHGMr2/KiyAajY
KMjy0k0OnvwmO8T1+rDgzHGtdvEZRU0O540oNgRMjCQLJU3lEXwxptN/kjJqYh3b
34ftmMLLFAz/oLirwgmXhmlOLp+HZTyjpralv5t2DGVRyCf3Dav3g20gKoK+kaLb
sY/2ZQwfAI2xsPgK1m98e6jO8pk2vV3HDRtuTm7F6cei4dXFTheP7Qh/gbByiZmH
X4kn/AYZBmOKTZ3BaWf8BIzWEf0msYws5qsxpp0YvcE+hZIxXplBT00fOC0armuj
lXiZhhP/tNu4Yqrh/Z2y/cwKaPtZdXfq0okwYnOtFsz9EdC1lXvTiuduwLNhdUPT
SDLVv3g9Y4A8WAxAViQ42m+wbVDVaFA7PpmNQ9cxqiJhQKUTJbk=
=TEbk
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
