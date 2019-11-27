Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA7C410A775
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2019 01:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfK0AYv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Nov 2019 19:24:51 -0500
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:33285
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726873AbfK0AYu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 Nov 2019 19:24:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUfwsQHBDTcDG7Pn24RQ2rFWYK1P1E9cypOolhY2g2RhAAqmBpFTrJTCNmVOQ3J7tO1r7UnMwAwWwtKtOxi/0/ZTo2sWRRhEH9tLjWP28rzxMQE4NYhEW8A3Y9HkboQM0KQSV++3cJjcbuXprUqhou9CqRZelbhbbTXfZpF/HgWwqp4WHg1EL+50V6ECoOYcAE3pmCqZgZQjCK9XSZFqbeOcdfXCAHoJF7Fk/RZK/z9C/pwktT646Usw4MHZ7fpTRME8kZYAG9JB3FPYJhZ2jdl9pi4zQle4R234Ufc4bkMLGC9apGzU7Hx1pdD4siILv4v5l8xNz94UP9Z4sylMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXtqq5UY/TpTL3E7LH7maeZFiXeobeLPS919VNyUC6w=;
 b=D2QMgfjJqWMqs59kZYW6O4J3c8OQexwT8GDfAtxu7zu0ixuBJKosusHtqlIWIeaI61WCOEf3G13ZPJQYA3cHqsZnxJoN6yTON1Xv8aU6UIZPFHQeTsiChYht1EBppNwzy19A6cahLzUczvGfEakUrAukkQ0Ql7szoTrgdJHjYWQTxx/Bts3uBOINC2J4VswMi5JnmQAyVNY/zLzLFGZ5HrgfktcAWzq9iszgbR5D/Fbg6QwSVS4CwyrWd9p8jGnFmq+x0tBljJdhbi7HYt5MuY216fFr9xCLDFqKM8WiFT7Y339Hx3yIZmYMVY+asnTjltIR+706PHN3l/qWTVihKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXtqq5UY/TpTL3E7LH7maeZFiXeobeLPS919VNyUC6w=;
 b=KT65JfJb98u8DYNWfiG5Bx3QRFysmTH1tsFUD9/qZsh0scIw4FkDYL+IpaVdkXgJettMCVT1sxa0YV3Ra0QhlcSjZ3s0WDIIwGkZeT62GjuOc/YDhV1aqHwSGXPtQGdPnm2g4PeoQI0fE9IUiWvjMANgacJeCahCoY9QUHvJe8I=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3134.eurprd05.prod.outlook.com (10.170.237.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Wed, 27 Nov 2019 00:24:41 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 00:24:41 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHVpLkPnC8STmq42Ee9zkHJq9D0uw==
Date:   Wed, 27 Nov 2019 00:24:40 +0000
Message-ID: <20191127002431.GA4861@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:207:3c::34) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18985246-f78e-49d4-c44d-08d772d0316a
x-ms-traffictypediagnostic: VI1PR05MB3134:
x-microsoft-antispam-prvs: <VI1PR05MB3134754CC2300211620AC1ECCF440@VI1PR05MB3134.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:291;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(189003)(199004)(71200400001)(2906002)(6436002)(8936002)(81156014)(8676002)(81166006)(33656002)(6486002)(9686003)(6512007)(71190400001)(4326008)(4001150100001)(6116002)(3846002)(66066001)(52116002)(66476007)(186003)(99286004)(64756008)(66446008)(316002)(30864003)(66556008)(478600001)(26005)(1076003)(6506007)(386003)(102836004)(256004)(54906003)(5660300002)(110136005)(7736002)(305945005)(14444005)(66616009)(25786009)(36756003)(66946007)(86362001)(14454004)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3134;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mrP0SpRtcwULWh1atToNM1qiYCFUogs6oKeKeuBBP+WVEb7SMdg6sCpvrdvpLf8APhSivz5uEG+mOejZcFHsXMn3VSFya4notUKIo+jAcx1jNOMapFGR/OQlV/+WoFY0cd/M/kl52irQFer2GnAj9RVHB1nJ1z+/qBRqXBI5FV7N8u/DzTDiy0oWKohPOv2sOn6Y6stPNiDj2mM/n0S0zN6UwEVsWLzHd50UYMHeuoC6nZV9WOp4hXoTVBAMvJoyh7yA7Z9cEUmREK7fnowzXJNBmMbR2ejxEJKtoGLfm5JenXKP14IlkaGqmNirQLy7NXMtV26mEW3BBi+ZmLbV+N1M9ciCdcOhFF1X+XqgnKFzDMqP2NN2XQsdstblwU80nfEfUjTypKlBaFpeBs6ZS6p9PG/nZTI4X6Iqz1stELHnTNMp/ZN1FYbqhMikk8A5
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18985246-f78e-49d4-c44d-08d772d0316a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 00:24:40.8266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KiOMuWJBUzD6obayOQKLtgV6uY+bC3oBSqUFF1fM6dLnvaV42R7Sa9jczEvfzmSiXZVt+1Wbd3FrAl51erUDAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3134
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

These are the proposed RDMA patches for 5.5

Again another fairly quiet cycle with few notable core code changes and the
usual variety of driver bug fixes and small improvements.

There is one conflict with v5.4, the hunk should be resolved in favor of
rdma.git

The tag for-linus-merged with my merge resolution to your tree is also
available to pull.

The following changes since commit 975b992fdd4b38028d7c1dcf38286d6e7991c1b2:

  net/mlx5: Add new chain for netfilter flow table offload (2019-11-13 13:49:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to f295e4cece5cb4c60715fed539abcd62468f9ef1:

  RDMA/hns: Delete unnecessary callback functions for cq (2019-11-25 10:31:48 -0400)

----------------------------------------------------------------
RDMA subsystem updates for 5.5

Mainly a collection of smaller of driver updates this cycle.

- Various driver updates and bug fixes for siw, bnxt_re, hns, qedr,
  iw_cxgb4, vmw_pvrdma, mlx5

- Improvements in SRPT from working with iWarp

- SRIOV VF support for bnxt_re

- Skeleton kernel-doc files for drivers/infiniband

- User visible counters for events related to ODP

- Common code for tracking of mmap lifetimes so that drivers can link HW
  object liftime to a VMA

- ODP bug fixes and rework

- RDMA READ support for efa

- Removal of the very old cxgb3 driver

----------------------------------------------------------------
Arnd Bergmann (1):
      RDMA/hns: Fix build error again

Bart Van Assche (20):
      RDMA/siw: Simplify several debug messages
      RDMA/siw: Fix port number endianness in a debug message
      RDMA/siw: Make node GUIDs valid EUI-64 identifiers
      RDMA/srp: Remove two casts
      RDMA/srp: Honor the max_send_sge device attribute
      RDMA/srp: Make route resolving error messages more informative
      RDMA/srpt: Fix handling of SR-IOV and iWARP ports
      RDMA/srpt: Fix handling of iWARP logins
      RDMA/srpt: Improve a debug message
      RDMA/srpt: Rework the approach for closing an RDMA channel
      RDMA/srpt: Rework the code that waits until an RDMA port is no longer in use
      RDMA/srpt: Make the code for handling port identities more systematic
      RDMA/srpt: Postpone HCA removal until after configfs directory removal
      RDMA/srpt: Fix TPG creation
      RDMA/core: Fix ib_dma_max_seg_size()
      RDMA/rxe: Increase DMA max_segment_size parameter
      RDMA/siw: Increase DMA max_segment_size parameter
      RDMA/core: Set DMA parameters correctly
      Revert "RDMA/srpt: Postpone HCA removal until after configfs directory removal"
      RDMA/srpt: Report the SCSI residual to the initiator

Bernard Metzler (3):
      RDMA/siw: Fix SQ/RQ drain logic
      RDMA/siw: Fix post_recv QP state locking
      RDMA/siw: Cleanup unused mmap structures.

Bryan Tan (1):
      RDMA/vmw_pvrdma: Use resource ids from physical device if available

Christoph Hellwig (2):
      dma-mapping: remove the DMA_ATTR_WRITE_BARRIER flag
      IB/umem: remove the dmasync argument to ib_umem_get

Christophe JAILLET (1):
      RDMA/iw_cgxb4: Fix an error handling path in 'c4iw_connect()'

Chuhong Yuan (1):
      RDMA/uverbs: Add a check for uverbs_attr_get to uverbs_copy_to_struct_or_zero

Colin Ian King (3):
      RDMA/hns: Fix memory leak on 'context' on error return path
      RDMA/ocrdma: Fix spelling mistake in variable name
      IB/hfi1: remove redundant assignment to variable ret

Dag Moxnes (1):
      RDMA/cma: Use ACK timeout for RoCE packetLifeTime

Daniel Kranzdorf (2):
      RDMA/efa: Support remote read access in MR registration
      RDMA/efa: Expose RDMA read related attributes

Danit Goldberg (6):
      IB/mlx4: Update HW GID table while adding vlan GID
      RDMA/cm: Use refcount_t type for refcount variable
      net/core: Add support for getting VF GUIDs
      IB/core: Add interfaces to get VF node and port GUIDs
      IB/ipoib: Add ndo operation for getting VFs GUID attributes
      IB/mlx5: Implement callbacks for getting VFs GUID attributes

Devesh Sharma (3):
      RDMA/bnxt_re: Enable SRIOV VF support on Broadcom's 57500 adapter series
      RDMA/bnxt_re: Fix stat push into dma buffer on gen p5 devices
      RDMA/bnxt_re: Fix missing le16_to_cpu

Donald Dutile (1):
      ib/srp: Add missing new line after displaying fast_io_fail_tmo param

Erez Alfasi (6):
      IB/mlx5: Remove unnecessary return statement
      IB/mlx5: Remove unnecessary else statement
      IB/mlx5: Introduce ODP diagnostic counters
      RDMA/nldev: Allow different fill function per resource
      RDMA/mlx5: Return ODP type per MR
      RDMA/nldev: Provide MR statistics

Gal Pressman (2):
      RDMA/efa: Clear the admin command buffer prior to its submission
      RDMA/efa: Store network attributes in device attributes

Honggang Li (2):
      RDMA/srp: Add parse function for maximum initiator to target IU size
      RDMA/srp: Calculate max_it_iu_size if remote max_it_iu length available

Jason Gunthorpe (21):
      Merge branch 'mlx5-rd-sgl' into rdma.git for-next
      RDMA/hns: Prevent undefined behavior in hns_roce_set_user_sq_size()
      rdma: Remove nes ABI header
      Merge tag 'v5.4-rc5' into rdma.git for-next
      RDMA/mlx5: Use SRCU properly in ODP prefetch
      RDMA/mlx5: Split sig_err MR data into its own xarray
      RDMA/mlx5: Use a dedicated mkey xarray for ODP
      RDMA/mlx5: Delete struct mlx5_priv->mkey_table
      RDMA/mlx5: Rework implicit_mr_get_data
      RDMA/mlx5: Lift implicit_mr_alloc() into the two routines that call it
      RDMA/mlx5: Set the HW IOVA of the child MRs to their place in the tree
      RDMA/mlx5: Split implicit handling from pagefault_mr
      RDMA/mlx5: Use an xarray for the children of an implicit ODP
      RDMA/mlx5: Reduce locking in implicit_mr_get_data()
      RDMA/mlx5: Avoid double lookups on the pagefault path
      RDMA/mlx5: Rework implicit ODP destroy
      RDMA/mlx5: Do not store implicit children in the odp_mkeys xarray
      RDMA/mlx5: Do not race with mlx5_ib_invalidate_range during create and destroy
      RDMA/odp: Remove broken debugging call to invalidate_range
      Merge branch 'odp_rework' into rdma.git for-next
      Merge branch 'ib-guids' into rdma.git for-next

Kamal Heib (8):
      RDMA/core: Fix return code when modify_device isn't supported
      RDMA/bnxt_re: Remove unsupported modify_device callback
      RDMA/rxe: Verify modify_device mask
      RDMA/core: Fix return code when modify_port isn't supported
      RDMA/hns: Remove unsupported modify_port callback
      RDMA/ocrdma: Remove unsupported modify_port callback
      RDMA/qedr: Remove unsupported modify_port callback
      RDMA/qedr: Make qedr_iw_load_qp() static

Krzysztof Kozlowski (1):
      RDMA/bnxt_re: Fix Kconfig indentation

Lang Cheng (4):
      RDMA/hns: Modify return value of restrack functions
      RDMA/hns: Remove unnecessary structure hns_roce_sqp
      RDMA/hns: Simplify doorbell initialization code
      RDMA/hns: Modify hns_roce_hw_v2_get_cfg to simplify the code

Leon Romanovsky (19):
      RDMA/mlx5: Group boolean parameters to take less space
      RDMA/restrack: Remove PID namespace support
      RDMA/core: Check that process is still alive before sending it to the users
      RDMA/rxe: Remove useless rxe_init_device_param assignments
      RDMA/cm: Delete unused cm_is_active_peer function
      RDMA/cm: Use specific keyword to check define
      RDMA/cm: Update copyright together with SPDX tag
      RDMA/hns: Delete BITS_PER_BYTE redefinition
      RDMA/mlx5: Return proper error value
      RDMA/mad: Delete never implemented functions
      RDMA/qib: Delete extra line
      RDMA/qib: Delete empty check_cc_key function
      RDMA/mad: Allocate zeroed MAD buffer
      RDMA/ocrdma: Make ocrdma_pma_counters() return void
      RDMA/mad: Do not check MAD sizes in roce and ib drivers
      RDMA/ocrdma: Simplify process_mad function
      RDMA/mlx5: Rewrite MAD processing logic to be readable
      RDMA/hfi1: Delete unreachable code
      RDMA: Change MAD processing function to remove extra casting and parameter

Lijun Ou (1):
      RDMA/hns: Fix to support 64K page for srq

Luke Starrett (1):
      RDMA/bnxt_re: Fix chip number validation Broadcom's Gen P5 series

Mark Zhang (2):
      RDMA/counter: Prevent QP counter manual binding in auto mode
      IB/mlx5: Support extended number of strides for Striding RQ

Max Gurtovoy (4):
      IB/iser: add unlikely checks in the fast path
      IB/iser: bound protection_sg size by data_sg size
      IB/iser: remove redundant macro definitions
      RDMA/iser: Use iser_err instead of pr_err for logging

Michael Guralnik (2):
      IB/mlx5: Align usage of QP1 create flags with rest of mlx5 defines
      IB/mlx5: Test write combining support

Michal Kalderon (13):
      RDMA/qedr: Fix srqs xarray initialization
      RDMA/qedr: Fix qpids xarray api used
      RDMA/qedr: Fix synchronization methods and memory leaks in qedr
      RDMA/qedr: Fix memory leak in user qp and mr
      RDMA/core: Move core content from ib_uverbs to ib_core
      RDMA/core: Create mmap database and cookie helper functions
      RDMA: Connect between the mmap entry and the umap_priv structure
      RDMA/efa: Use the common mmap_xa helpers
      RDMA/siw: Use the common mmap_xa helpers
      RDMA/qedr: Use the common mmap API
      RDMA/qedr: Add doorbell overflow recovery support
      RDMA/qedr: Add iWARP doorbell recovery support
      RDMA/qedr: Fix null-pointer dereference when calling rdma_user_mmap_get_offset

Pan Bian (2):
      RDMA/qedr: Fix potential use after free
      RDMA/i40iw: Fix potential use after free

Parav Pandit (4):
      IB/cm: Use container_of() instead of typecast
      IB/mlx5: Introduce and use mkey context setting helper routine
      IB/cma: Honor traffic class from lower netdevice for RoCE
      IB/core: Do not notify GID change event of an unregistered device

Potnuri Bharat Teja (2):
      RDMA/iw_cxgb3: Remove the iw_cxgb3 module from kernel
      RDMA/iw_cxgb4: Report correct port speed/width

Ran Rozenstein (1):
      IB/mlx5: Remove dead code

Viresh Kumar (1):
      RDMA/qib: Validate ->show()/store() callbacks before calling them

Weihang Li (3):
      RDMA/hns: remove a redundant le16_to_cpu
      RDMA/hns: Fix wrong parameters when initial mtt of srq->idx_que
      RDMA/hns: Modify variable/field name from vlan to vlan_id

Wenpeng Liang (1):
      RDMA/hns: Modify appropriate printings

Yamin Friedman (2):
      RDMA/rw: Support threshold for registration vs scattering to local pages
      RDMA/mlx5: Add capability for max sge to get optimized performance

Yangyang Li (2):
      RDMA/hns: Release qp resources when failed to destroy qp
      RDMA/hns: Bugfix for qpc/cqc timer configuration

Yevgeny Kliteynik (1):
      IB/mlx5: Support flow counters offset for bulk counters

Yishai Hadas (1):
      RDMA/uapi: Fix and re-organize the usage of rdma_driver_id

Yixian Liu (8):
      RDMA/hns: Delete unnecessary variable max_post
      RDMA/hns: Delete unnecessary uar from hns_roce_cq
      RDMA/hns: Modify fields of struct hns_roce_srq
      RDMA/hns: Fix non-standard error codes
      RDMA/hns: Redefine interfaces used in creating cq
      RDMA/hns: Redefine the member of hns_roce_cq struct
      RDMA/hns: Rename the functions used inside creating cq
      RDMA/hns: Delete unnecessary callback functions for cq

Yixing Liu (2):
      RDMA/hns: Fix a spelling mistake in a macro
      RDMA/hns: Replace not intuitive function/macro names

rd.dunlab@gmail.com (11):
      infiniband: fix ulp/iser/iscsi_iser.[hc] kernel-doc notation
      infiniband: fix core/ipwm_util.h kernel-doc warnings
      infiniband: fix ulp/iser/iscsi_iser.h kernel-doc warnings
      infiniband: fix ulp/opa_vnic/opa_vnic_internal.h kernel-doc notation
      infiniband: fix ulp/srpt/ib_srpt.h kernel-doc notation
      infiniband: fix core/verbs.c kernel-doc notation
      infiniband: fix ulp/iser/iser_verbs.c kernel-doc notation
      infiniband: fix ulp/iser/iser_initiator.c kernel-doc warnings
      infiniband: fix core/ kernel-doc notation
      infiniband: fix sw/rdmavt/ kernel-doc notation
      infiniband: add a Documentation driver-api chapter for Infiniband

 Documentation/ABI/stable/sysfs-class-infiniband    |   19 -
 Documentation/ABI/stable/sysfs-driver-ib_srp       |    2 +
 Documentation/DMA-attributes.txt                   |   18 -
 Documentation/driver-api/index.rst                 |    1 +
 Documentation/driver-api/infiniband.rst            |  127 ++
 MAINTAINERS                                        |    8 -
 drivers/infiniband/Kconfig                         |    1 -
 drivers/infiniband/core/Makefile                   |    2 +-
 drivers/infiniband/core/cache.c                    |    8 +-
 drivers/infiniband/core/cm.c                       |   66 +-
 drivers/infiniband/core/cm_msgs.h                  |   32 +-
 drivers/infiniband/core/cma.c                      |  107 +-
 drivers/infiniband/core/core_priv.h                |   11 +
 drivers/infiniband/core/counters.c                 |   40 +-
 drivers/infiniband/core/device.c                   |   50 +-
 drivers/infiniband/core/ib_core_uverbs.c           |  335 +++
 drivers/infiniband/core/iwpm_util.h                |    5 +-
 drivers/infiniband/core/mad.c                      |   31 +-
 drivers/infiniband/core/nldev.c                    |  141 +-
 drivers/infiniband/core/rdma_core.c                |    1 +
 drivers/infiniband/core/restrack.c                 |   20 +-
 drivers/infiniband/core/restrack.h                 |    1 -
 drivers/infiniband/core/rw.c                       |   25 +-
 drivers/infiniband/core/sa_query.c                 |    2 +-
 drivers/infiniband/core/sysfs.c                    |   12 +-
 drivers/infiniband/core/umem.c                     |   12 +-
 drivers/infiniband/core/umem_odp.c                 |   38 +-
 drivers/infiniband/core/uverbs_cmd.c               |    2 +
 drivers/infiniband/core/uverbs_ioctl.c             |    3 +
 drivers/infiniband/core/uverbs_main.c              |   84 +-
 drivers/infiniband/core/verbs.c                    |   12 +
 drivers/infiniband/hw/Makefile                     |    1 -
 drivers/infiniband/hw/bnxt_re/Kconfig              |   12 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h            |    1 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |   28 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h           |    3 -
 drivers/infiniband/hw/bnxt_re/main.c               |  143 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |    5 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h          |    8 +-
 drivers/infiniband/hw/cxgb3/Kconfig                |   19 -
 drivers/infiniband/hw/cxgb3/Makefile               |    7 -
 drivers/infiniband/hw/cxgb3/cxio_hal.c             | 1312 ------------
 drivers/infiniband/hw/cxgb3/cxio_hal.h             |  204 --
 drivers/infiniband/hw/cxgb3/cxio_resource.c        |  344 ---
 drivers/infiniband/hw/cxgb3/cxio_resource.h        |   69 -
 drivers/infiniband/hw/cxgb3/cxio_wr.h              |  802 -------
 drivers/infiniband/hw/cxgb3/iwch.c                 |  282 ---
 drivers/infiniband/hw/cxgb3/iwch.h                 |  155 --
 drivers/infiniband/hw/cxgb3/iwch_cm.c              | 2258 --------------------
 drivers/infiniband/hw/cxgb3/iwch_cm.h              |  233 --
 drivers/infiniband/hw/cxgb3/iwch_cq.c              |  230 --
 drivers/infiniband/hw/cxgb3/iwch_ev.c              |  232 --
 drivers/infiniband/hw/cxgb3/iwch_mem.c             |  101 -
 drivers/infiniband/hw/cxgb3/iwch_provider.c        | 1321 ------------
 drivers/infiniband/hw/cxgb3/iwch_provider.h        |  347 ---
 drivers/infiniband/hw/cxgb3/iwch_qp.c              | 1082 ----------
 drivers/infiniband/hw/cxgb3/tcb.h                  |  632 ------
 drivers/infiniband/hw/cxgb4/cm.c                   |    4 +-
 drivers/infiniband/hw/cxgb4/mem.c                  |    2 +-
 drivers/infiniband/hw/cxgb4/provider.c             |    7 +-
 drivers/infiniband/hw/efa/efa.h                    |   13 +-
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h    |   29 +-
 drivers/infiniband/hw/efa/efa_com.c                |    5 +-
 drivers/infiniband/hw/efa/efa_com_cmd.c            |   40 +-
 drivers/infiniband/hw/efa/efa_com_cmd.h            |   19 +-
 drivers/infiniband/hw/efa/efa_main.c               |   17 +-
 drivers/infiniband/hw/efa/efa_verbs.c              |  370 ++--
 drivers/infiniband/hw/hfi1/mad.c                   |   17 +-
 drivers/infiniband/hw/hfi1/platform.c              |    2 +-
 drivers/infiniband/hw/hfi1/verbs.h                 |    5 +-
 drivers/infiniband/hw/hns/Kconfig                  |   17 +-
 drivers/infiniband/hw/hns/Makefile                 |    8 +-
 drivers/infiniband/hw/hns/hns_roce_ah.c            |   14 +-
 drivers/infiniband/hw/hns/hns_roce_alloc.c         |    4 +-
 drivers/infiniband/hw/hns/hns_roce_cmd.h           |   14 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c            |  300 ++-
 drivers/infiniband/hw/hns/hns_roce_db.c            |    2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        |   55 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c         |   38 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |   76 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |    4 +-
 drivers/infiniband/hw/hns/hns_roce_main.c          |   21 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c            |   69 +-
 drivers/infiniband/hw/hns/hns_roce_pd.c            |    2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |   54 +-
 drivers/infiniband/hw/hns/hns_roce_restrack.c      |   10 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c           |   86 +-
 drivers/infiniband/hw/i40iw/i40iw_cm.c             |    2 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c          |    2 +-
 drivers/infiniband/hw/mlx4/cq.c                    |    2 +-
 drivers/infiniband/hw/mlx4/doorbell.c              |    2 +-
 drivers/infiniband/hw/mlx4/mad.c                   |   30 +-
 drivers/infiniband/hw/mlx4/main.c                  |   18 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h               |    8 +-
 drivers/infiniband/hw/mlx4/mr.c                    |    2 +-
 drivers/infiniband/hw/mlx4/qp.c                    |    5 +-
 drivers/infiniband/hw/mlx4/srq.c                   |    2 +-
 drivers/infiniband/hw/mlx5/Makefile                |    2 +-
 drivers/infiniband/hw/mlx5/cq.c                    |   37 +-
 drivers/infiniband/hw/mlx5/devx.c                  |   25 +-
 drivers/infiniband/hw/mlx5/doorbell.c              |    2 +-
 drivers/infiniband/hw/mlx5/flow.c                  |   29 +-
 drivers/infiniband/hw/mlx5/gsi.c                   |    2 +-
 drivers/infiniband/hw/mlx5/ib_virt.c               |   24 +
 drivers/infiniband/hw/mlx5/mad.c                   |  124 +-
 drivers/infiniband/hw/mlx5/main.c                  |   75 +-
 drivers/infiniband/hw/mlx5/mem.c                   |  199 ++
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |   64 +-
 drivers/infiniband/hw/mlx5/mr.c                    |  177 +-
 drivers/infiniband/hw/mlx5/odp.c                   |  989 +++++----
 drivers/infiniband/hw/mlx5/qp.c                    |   60 +-
 drivers/infiniband/hw/mlx5/restrack.c              |   90 +
 drivers/infiniband/hw/mlx5/srq.c                   |    2 +-
 drivers/infiniband/hw/mthca/mthca_dev.h            |   12 +-
 drivers/infiniband/hw/mthca/mthca_mad.c            |   74 +-
 drivers/infiniband/hw/mthca/mthca_provider.c       |    4 +-
 drivers/infiniband/hw/ocrdma/ocrdma_ah.c           |   33 +-
 drivers/infiniband/hw/ocrdma/ocrdma_ah.h           |   11 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c         |    1 -
 drivers/infiniband/hw/ocrdma/ocrdma_sli.h          |    2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c        |    9 +-
 drivers/infiniband/hw/ocrdma/ocrdma_stats.h        |    3 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |    8 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h        |    2 -
 drivers/infiniband/hw/qedr/main.c                  |    5 +-
 drivers/infiniband/hw/qedr/qedr.h                  |   72 +-
 drivers/infiniband/hw/qedr/qedr_iw_cm.c            |  150 +-
 drivers/infiniband/hw/qedr/verbs.c                 |  643 ++++--
 drivers/infiniband/hw/qedr/verbs.h                 |   12 +-
 drivers/infiniband/hw/qib/qib_iba6120.c            |    1 -
 drivers/infiniband/hw/qib/qib_mad.c                |   38 +-
 drivers/infiniband/hw/qib/qib_sysfs.c              |    6 +
 drivers/infiniband/hw/qib/qib_verbs.h              |    5 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c       |    2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h  |   15 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_mr.c       |    2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c       |  119 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c      |    2 +-
 drivers/infiniband/sw/rdmavt/ah.c                  |    1 -
 drivers/infiniband/sw/rdmavt/cq.c                  |    2 -
 drivers/infiniband/sw/rdmavt/mr.c                  |    2 +-
 drivers/infiniband/sw/rdmavt/qp.c                  |   30 +-
 drivers/infiniband/sw/rdmavt/vt.c                  |    3 +-
 drivers/infiniband/sw/rxe/rxe.c                    |   13 -
 drivers/infiniband/sw/rxe/rxe_mr.c                 |    2 +-
 drivers/infiniband/sw/rxe/rxe_param.h              |   13 -
 drivers/infiniband/sw/rxe/rxe_verbs.c              |    7 +
 drivers/infiniband/sw/rxe/rxe_verbs.h              |    1 +
 drivers/infiniband/sw/siw/siw.h                    |   31 +-
 drivers/infiniband/sw/siw/siw_cm.c                 |   45 +-
 drivers/infiniband/sw/siw/siw_main.c               |   35 +-
 drivers/infiniband/sw/siw/siw_verbs.c              |  338 +--
 drivers/infiniband/sw/siw/siw_verbs.h              |    1 +
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |   10 +
 drivers/infiniband/ulp/iser/iscsi_iser.c           |    5 +-
 drivers/infiniband/ulp/iser/iscsi_iser.h           |   34 +-
 drivers/infiniband/ulp/iser/iser_initiator.c       |    5 +
 drivers/infiniband/ulp/iser/iser_memory.c          |    6 +-
 drivers/infiniband/ulp/iser/iser_verbs.c           |   72 +-
 .../infiniband/ulp/opa_vnic/opa_vnic_internal.h    |    8 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |   47 +-
 drivers/infiniband/ulp/srp/ib_srp.h                |    4 +
 drivers/infiniband/ulp/srpt/ib_srpt.c              |  247 ++-
 drivers/infiniband/ulp/srpt/ib_srpt.h              |   58 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |    4 -
 drivers/net/ethernet/mellanox/mlx5/core/mr.c       |   28 +-
 include/linux/dma-mapping.h                        |    5 +-
 include/linux/mlx5/driver.h                        |    4 -
 include/linux/netdevice.h                          |    4 +
 include/rdma/ib_cm.h                               |   32 +-
 include/rdma/ib_mad.h                              |   40 -
 include/rdma/ib_umem.h                             |    4 +-
 include/rdma/ib_umem_odp.h                         |   18 -
 include/rdma/ib_verbs.h                            |   79 +-
 include/rdma/restrack.h                            |    5 +
 include/uapi/rdma/cxgb3-abi.h                      |   82 -
 include/uapi/rdma/efa-abi.h                        |    6 +
 include/uapi/rdma/ib_user_ioctl_verbs.h            |   22 +
 include/uapi/rdma/mlx5_user_ioctl_cmds.h           |    1 +
 include/uapi/rdma/nes-abi.h                        |  115 -
 include/uapi/rdma/qedr-abi.h                       |   25 +
 include/uapi/rdma/rdma_user_ioctl_cmds.h           |   22 -
 include/uapi/rdma/vmw_pvrdma-abi.h                 |    5 +
 net/core/rtnetlink.c                               |   14 +
 184 files changed, 4214 insertions(+), 12877 deletions(-)
(diffstat from tag for-linus-merged)

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl3dwjwACgkQOG33FX4g
mxrUwxAAm6LCQYB92U+xJiYOpAmgTlhNs2yjt1wzcmedLL29ahnCquBBlsTICbqd
QAW7bHoaKewyCqeINVctloNU5VI8OPQd6jqU5piRU7sqGdAU6/NAG+Awiy07PLeN
RaZzpRxVX+4uTaEP5dZ5s33Lm9d9yUNZxNjZK0a6IgqvjmvbBB9F7lH6SWUZZgck
/qQVDCNoeHCUZ7BOSQcHEEB781XLLy5TpHFLNpwa14+1WhUxzEMedM4jJzJ2h7o+
NRZDvQ4Jsl43rkvHL2sNJuqrEIcVPnWmXrnFx/2ZUYIwfFcL3lgqYOPOZBRcjUUX
ipFqvCP2KrXJrmCRvRP1YxFu6eAt+HKM0IVSwmNWt7qtnEyrcrNgtKI4DhSOgaIs
3DrCop9v0gLVu0yptNoc9Is1PrkwUNzWESPPXdX4d6NO7e88mQtMOK465wqZh/+l
9E1tMwZFN8ILa/UshM/AQVYxYI/wpEZzJ1LChRPjsGk5FL6kkZCIBI7Rem7sJBtE
QUHefSdV7rsw5O9DB3yaZQGcweEldaCaxE7Ztfehr84zyMTWlAELhuRryRhc5TVf
pdcM6Sn0XRWBCpf7pJQfLvWCPw+41xab6134KUGlLkwGAePxmoWmwWF0DdnRCWj+
UCoFapA8T6ltxxNSqIwpaJnYnzVdhPtcJgQaREtW6gUfKwti6b0=
=R6NX
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
