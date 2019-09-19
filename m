Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61854B7F39
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2019 18:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbfISQe5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Sep 2019 12:34:57 -0400
Received: from mail-eopbgr00056.outbound.protection.outlook.com ([40.107.0.56]:52998
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390488AbfISQe4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Sep 2019 12:34:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnRgD4TiD5ZSnUoy+tLkyhbCv8jq+t3e+P1yyySDpXtUwjJnzW1x7aD1R6rliT66AHGEqy/SgkwNzD2OMfIEGvsrqca1Rdx6wxukLRHlsutus7d/SHptJBL/79KvCxTRYE0g5jFYISh7bIfgkn+kIt7sGpKS+/QVFc3NSPSbL1FuE2kfvFTcdxWzx93rsVvDQh3QryFk1SiiqBBwWeG48UUDqlbPcvo4Cr9sC9VpyT6wRYeAxtWRkO+CdP10i5a1A4lbNqR4hPDVp0A74KrRnc7pYXDbLavc2PUGh/oKa5Rl1NI5LULly8gIMxizEdHDsHnxtxoNsaPEqVHkPNoRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiBvw4O07He19ISSU9jNdUskUBfRuWS1tZiDcZj1kS8=;
 b=IQjNHLdXA0uZuRV2w8dkhU9l9uWFJ5IZmZ4sYALsI9fjLkk3X5zoZEiyKt0duKoaSZqH58M/N3i7yMS9g/sIrFlwjVDpH8+IF69jTdbF49XzwEZSxapm2JMmXQ6oHbQoYjFhtBl2F0Lu/x0Ycr0jE46eCSVRCPqUcxDyHr6VK6/e8gp10d10K2x93JY8hlEDfMBrOktumIfsExCNlSElKEamScCSprzMAHMZv/dmcrfUNy5yiT5sd/seWEKMbEzCPrVUIEYauCPc+YGTTQeAWUNrKBr/F7SP0fZRWQNO958aWbLUfQp1sdm26udU+rt8MXUUZz+/hyhaLlDj5yyJdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiBvw4O07He19ISSU9jNdUskUBfRuWS1tZiDcZj1kS8=;
 b=RN1V2ZAj5hEz1AoYx3bnzjMWKosTvxxjtRiOuHa5hT95PgtzNhmTV+j3X/S3RNCxSF3u6O79QTnvdULNGBMQGJ4wiaQnnoworGbB7S0DQDtwA0c5EJLuVXrvrKSocWKJLsZgNRC2ekytJAQ/awtJ+JSNJRIKY6WtRyPklmf5NKk=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5309.eurprd05.prod.outlook.com (20.178.8.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.26; Thu, 19 Sep 2019 16:34:47 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::d9ac:7e4e:9520:29a6]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::d9ac:7e4e:9520:29a6%6]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 16:34:47 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHVbwgmkBizlvvdUkq4KGEMRqpZFQ==
Date:   Thu, 19 Sep 2019 16:34:46 +0000
Message-ID: <20190919163435.GA4578@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::40) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.167.223.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 418020b0-1c0b-4cbb-5e36-08d73d1f487d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(49563074)(7193020);SRVR:VI1PR05MB5309;
x-ms-traffictypediagnostic: VI1PR05MB5309:
x-microsoft-antispam-prvs: <VI1PR05MB53092D6B3F0E7ECE4A2AD88BCF890@VI1PR05MB5309.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:327;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(189003)(199004)(7736002)(305945005)(30864003)(14454004)(1076003)(66574012)(6436002)(8936002)(81166006)(8676002)(81156014)(476003)(66066001)(6486002)(6116002)(478600001)(3846002)(5660300002)(25786009)(4326008)(33656002)(486006)(86362001)(71190400001)(71200400001)(256004)(14444005)(110136005)(66616009)(66556008)(64756008)(66446008)(5024004)(54906003)(66476007)(66946007)(102836004)(99936001)(6506007)(386003)(52116002)(2906002)(36756003)(186003)(26005)(6512007)(9686003)(316002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5309;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TDWp0ERbCNw7raifvQJqiR9NMONJumku+v8S7V0In8JiRwrheScM4ENVh4FsijHunw/htkMlGkYTxMLveAANpuen51Ag2TatUj8KW+U/2lvxulE2Y9kKb1TvcHP9s4XLNcuxl+c0reLrn+cPmUrYJ/ja72PvYXNIYj17EJo5JqZ/8uty10yCu4z1EkNumMR10Voz1MofyGpxifvYHi8u8Zhdghs3rNBnPJbB1vRVn7PWZSfJhioT2YTiIqGB9rhdwkOvEwb79lT1LO9nHmh5JXOiG0Kywdllh2NhT9yYNJAWjN5DWor/+qrXrOToHzYhQJ7By0s6JZUG1Q7CSypG2Z5cZqT8s7wYpyFYvLk/7Thnl3FnvXqU9asy83BmLrr3EY7XF29UGDpOKpxnWo6i5Rf2tGvCb71XveMO1CylMRI=
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418020b0-1c0b-4cbb-5e36-08d73d1f487d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 16:34:46.9108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U0lpirvlWhOWKrDbChbWNXYLQbWGW0EPC2mJ1ttWeR0RW3hLaHa/GKa7YFm6tYnIqSAzcJ4Db78Uaw1LdnGMbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5309
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

These are the proposed RDMA patches for 5.4

This cycle has proved to be quiet with a focus on bug fix and cleanup style
patches, and less on major new functionality. I am aware of no conflicts.

The following changes since commit f74c2bb98776e2de508f4d607cd519873065118e:

  Linux 5.3-rc8 (2019-09-08 13:33:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 3eca7fc2d8d1275d9cf0c709f0937becbfcf6d96:

  RDMA: Fix double-free in srq creation error flow (2019-09-16 14:37:38 -03=
00)

----------------------------------------------------------------
RDMA subsystem updates for 5.4

This cycle mainly saw lots of bug fixes and clean up code across the core
code and several drivers, few new functional changes were made.

- Many cleanup and bug fixes for hns

- Various small bug fixes and cleanups in hfi1, mlx5, usnic, qed,
  bnxt_re, efa

- Share the query_port code between all the iWarp drivers

- General rework and cleanup of the ODP MR umem code to fit better with
  the mmu notifier get/put scheme

- Support rdma netlink in non init_net name spaces

- mlx5 support for XRC devx and DC ODP

----------------------------------------------------------------
Andrey Konovalov (1):
      RDMA/mlx4: Untag user pointers in mlx4_get_umem_mr

Arnd Bergmann (1):
      RDMA/usnic: Avoid overly large buffers on stack

Bernard Metzler (2):
      RDMA/siw: Fix page address mapping in TX path
      RDMA/siw: Relax from kmap_atomic() use in TX path

Chuck Lever (1):
      rdma: Enable ib_alloc_cq to spread work over a device's comp_vectors

Chuhong Yuan (1):
      IB/usnic: Use dev_get_drvdata

Colin Ian King (3):
      RDMA/hns: Fix comparison of unsigned long variable 'end' with less th=
an zero
      RDMA/core: fix spelling mistake "Nelink" -> "Netlink"
      RDMA/bnxt_re: Fix spelling mistake "missin_resp" -> "missing_resp"

Dan Carpenter (1):
      RDMA/hns: Fix some white space check_mtu_validate()

Danit Goldberg (2):
      IB/mlx5: Use the original address for the page during free_pages
      IB/mlx5: Free mpi in mp_slave mode

Doug Ledford (3):
      Merge branch 'wip/dl-for-rc' into wip/dl-for-next
      Merge remote-tracking branch 'mlx5-next/mlx5-next' into wip/dl-for-ne=
xt
      Merge remote-tracking branch 'mlx5-next/mlx5-next' into for-next

Gal Pressman (6):
      RDMA/efa: Expose device statistics
      RDMA/core: Introduce ratelimited ibdev printk functions
      RDMA/efa: Rate limit admin queue error prints
      RDMA/efa: Remove umem check on dereg MR flow
      RDMA/efa: Use existing FIELD_SIZEOF macro
      RDMA/efa: Fix incorrect error print

Guoqing Jiang (1):
      Documentation/infiniband: update name of some functions

Hariprasad Kelam (2):
      RDMA/qib: Unneeded variable ret
      RDMA/qedr: Remove Unneeded variable rc

H=C3=A5kon Bugge (1):
      RDMA/cma: Fix false error message

Ira Weiny (1):
      IB/hfi1: Define variables as unsigned long to fix KASAN warning

Jack Morgenstein (1):
      RDMA: Fix double-free in srq creation error flow

Jason Gunthorpe (16):
      RDMA: Make most headers compile stand alone
      RDMA/odp: Use the common interval tree library instead of generic
      RDMA/odp: Iterate over the whole rbtree directly
      RDMA/odp: Make it clearer when a umem is an implicit ODP umem
      RMDA/odp: Consolidate umem_odp initialization
      RDMA/odp: Make the three ways to create a umem_odp clear
      RDMA/odp: Split creating a umem_odp from ib_umem_get
      RDMA/odp: Provide ib_umem_odp_release() to undo the allocs
      RDMA/odp: Check for overflow when computing the umem_odp end
      RDMA/odp: Use kvcalloc for the dma_list and page_list
      RDMA/mlx5: Use ib_umem_start instead of umem.address
      RDMA/mlx5: Use odp instead of mr->umem in pagefault_mr
      Merge branch 'odp_fixes' into rdma.git for-next
      Merge branch 'mlx5-odp-dc' into rdma.git for-next
      RDMA/odp: Add missing cast for 32 bit
      Merge tag 'v5.3-rc8' into rdma.git for-next

Joe Perches (1):
      mlx5: Fix formats with line continuation whitespace

Kaike Wan (3):
      IB/hfi1: Do not update hcrc for a KDETH packet during fault injection
      IB/hfi1: Add traces for TID RDMA READ
      IB/{rdmavt, hfi1, qib}: Add a counter for credit waits

Kamal Heib (4):
      RDMA: Introduce ib_port_phys_state enum
      RDMA/cxgb3: Use ib_device_set_netdev()
      RDMA/core: Add common iWARP query port
      RDMA/{cxgb3, cxgb4, i40iw}: Remove common code

Lang Cheng (10):
      RDMA/hns: Clean up unnecessary initial assignment
      RDMA/hns: Update some comments style
      RDMA/hns: Handling the error return value of hem function
      RDMA/hns: Split bool statement and assign statement
      RDMA/hns: Refactor irq request code
      RDMA/hns: Remove unnecessary kzalloc
      RDMA/hns: Remove unuseful member
      RDMA/hns: Modify the data structure of hns_roce_av
      RDMA/hns: Fix cast from or to restricted __le32 for driver
      RDMA/hns: Add reset process for function-clear

Leon Romanovsky (6):
      RDMA/mlx4: Separate creation of RWQ and QP
      RDMA/mlx4: Annotate boolean arguments as bool and not int
      RDMA/mlx5: Remove DEBUG ODP code
      RDMA/hns: Remove not used UAR assignment
      RDMA/mlx5: Annotate lock dependency in bind/unbind slave port
      RDMA: Delete DEBUG code

Lijun Ou (13):
      RDMA/hns: Package the flow of creating cq
      RDMA/hns: Refactor the code of creating srq
      RDMA/hns: Refactor for hns_roce_v2_modify_qp function
      RDMA/hns: Use a separated function for setting extend sge paramters
      RDMA/hns: Package for hns_roce_rereg_user_mr function
      RDMA/hns: Refactor hem table mhop check and calculation
      RDMA/hns: Encapsulate some lines for setting sq size in user mode
      RDMA/hns: Optimize hns_roce_modify_qp function
      RDMA/hns: Use the new APIs for printing log
      RDMA/hns: Bugfix for creating qp attached to srq
      RDMA/hns: Remove the some magic number
      RDMA/hns: Fix wrong assignment of qp_access_flags
      RDMA/hns: Package operations of rq inline buffer into separate functi=
ons

Mark Zhang (1):
      RDMA/mlx5: RDMA_RX flow type support for user applications

Markus Elfring (1):
      RDMA/iwpm: Delete unnecessary checks before the macro call "dev_kfree=
_skb"

Max Gurtovoy (1):
      IB/mlx5: Add CREATE_PSV/DESTROY_PSV for devx interface

Michael Guralnik (2):
      IB/mlx5: Remove check of FW capabilities in ODP page fault handling
      IB/mlx5: Add page fault handler for DC initiator WQE

Michal Kalderon (1):
      qed*: Change dpi_addr to be denoted with __iomem

Mike Marciniszyn (1):
      IB/hfi1: Remove unused define

Moni Shoua (1):
      RDMA/core: Make invalidate_range a device operation

Navid Emamdoost (1):
      RDMA: Fix goto target to release the allocated memory

Parav Pandit (6):
      RDMA/core: Annotate destroy of mutex to ensure that it is released as=
 unlocked
      IB/mlx5: Avoid unnecessary typecast
      RDMA/core: Support netlink commands in non init_net net namespaces
      IB/mlx5: Refactor code for counters allocation
      IB/mlx5: Support per device q counters in switchdev mode
      IB/bnxt_re: Do not notifify GID change event

Sergey Gorenko (1):
      IB/iser: Support up to 16MB data transfer in a single command

Stephen Boyd (1):
      infiniband: Remove dev_err() usage after platform_get_irq()

Weihang Li (3):
      RDMA/hns: Remove redundant print in hns_roce_v2_ceq_int()
      RDMA/hns: Disable alw_lcl_lpbk of SSU
      RDMA/hns: Logic optimization of wc_flags

Wenpeng Liang (2):
      RDMA/hns: Remove if-else judgment statements for creating srq
      RDMA/hns: Delete the not-used lines

Xi Wang (3):
      RDMA/hns: optimize the duplicated code for qpc setting flow
      RDMA/hns: Bugfix for slab-out-of-bounds when unloading hip08 driver
      RDMA/hns: bugfix for slab-out-of-bounds when loading hip08 driver

Yangyang Li (2):
      RDMA/hns: Refactor hns_roce_v2_set_hem for hip08
      RDMA/hns: Modify pi vlaue when cq overflows

Yishai Hadas (2):
      IB/mlx5: Add legacy events to DEVX list
      IB/mlx5: Expose XRQ legacy commands over the DEVX interface

Yixian Liu (4):
      RDMA/hns: Refactor eq table init for hip08
      RDMA/hns: Update the prompt message for creating and destroy qp
      RDMA/hns: Remove unnessary init for cmq reg
      RDMA/hns: Optimize cmd init and mode selection for hip08

YueHaibing (3):
      RDMA/hns: remove set but not used variable 'irq_num'
      RDMA/hns: remove obsolete Kconfig comment
      RDMA/hns: Use devm_platform_ioremap_resource() to simplify code

chenglang (1):
      RDMA/hns: Optimize hns_roce_mhop_alloc function.

 Documentation/infiniband/core_locking.rst    |    8 +-
 drivers/infiniband/Kconfig                   |    1 +
 drivers/infiniband/core/addr.c               |    2 +-
 drivers/infiniband/core/cache.c              |    1 +
 drivers/infiniband/core/cma.c                |    2 +-
 drivers/infiniband/core/cma_configfs.c       |    8 +-
 drivers/infiniband/core/core_priv.h          |   24 +-
 drivers/infiniband/core/counters.c           |    8 +-
 drivers/infiniband/core/cq.c                 |   28 +
 drivers/infiniband/core/device.c             |  129 +++-
 drivers/infiniband/core/fmr_pool.c           |   13 -
 drivers/infiniband/core/iwpm_msg.c           |   17 +-
 drivers/infiniband/core/iwpm_util.c          |   15 +-
 drivers/infiniband/core/netlink.c            |   63 +-
 drivers/infiniband/core/nldev.c              |   20 +-
 drivers/infiniband/core/sa_query.c           |    2 +-
 drivers/infiniband/core/sysfs.c              |   30 +-
 drivers/infiniband/core/umem.c               |   50 +-
 drivers/infiniband/core/umem_odp.c           |  437 ++++++-----
 drivers/infiniband/core/user_mad.c           |    2 +-
 drivers/infiniband/core/uverbs_cmd.c         |    5 +-
 drivers/infiniband/core/uverbs_main.c        |    4 +
 drivers/infiniband/core/verbs.c              |    1 +
 drivers/infiniband/hw/bnxt_re/hw_counters.c  |    2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c     |    6 +-
 drivers/infiniband/hw/bnxt_re/main.c         |    1 -
 drivers/infiniband/hw/cxgb3/iwch_provider.c  |   45 +-
 drivers/infiniband/hw/cxgb4/provider.c       |   24 -
 drivers/infiniband/hw/efa/efa.h              |    3 +
 drivers/infiniband/hw/efa/efa_com.c          |   70 +-
 drivers/infiniband/hw/efa/efa_com_cmd.c      |  165 ++--
 drivers/infiniband/hw/efa/efa_com_cmd.h      |   23 +
 drivers/infiniband/hw/efa/efa_main.c         |    2 +
 drivers/infiniband/hw/efa/efa_verbs.c        |   91 ++-
 drivers/infiniband/hw/hfi1/chip.c            |    2 +
 drivers/infiniband/hw/hfi1/chip.h            |    1 +
 drivers/infiniband/hw/hfi1/mad.c             |   45 +-
 drivers/infiniband/hw/hfi1/rc.c              |   15 +-
 drivers/infiniband/hw/hfi1/tid_rdma.c        |    8 +
 drivers/infiniband/hw/hfi1/trace_tid.h       |   38 +
 drivers/infiniband/hw/hfi1/user_sdma.h       |    6 -
 drivers/infiniband/hw/hfi1/verbs.c           |   17 +-
 drivers/infiniband/hw/hns/Kconfig            |    8 -
 drivers/infiniband/hw/hns/hns_roce_ah.c      |   23 +-
 drivers/infiniband/hw/hns/hns_roce_cmd.c     |   11 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c      |  186 +++--
 drivers/infiniband/hw/hns/hns_roce_device.h  |   95 ++-
 drivers/infiniband/hw/hns/hns_roce_hem.c     |  252 +++---
 drivers/infiniband/hw/hns/hns_roce_hem.h     |    6 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c   |   69 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c   | 1065 +++++++++++++++-------=
----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h   |    7 +-
 drivers/infiniband/hw/hns/hns_roce_main.c    |   11 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c      |  434 ++++++-----
 drivers/infiniband/hw/hns/hns_roce_qp.c      |  359 +++++----
 drivers/infiniband/hw/hns/hns_roce_srq.c     |  296 +++----
 drivers/infiniband/hw/i40iw/i40iw_verbs.c    |   11 -
 drivers/infiniband/hw/mlx4/main.c            |    3 +-
 drivers/infiniband/hw/mlx4/mr.c              |    7 +-
 drivers/infiniband/hw/mlx4/qp.c              |  242 ++++--
 drivers/infiniband/hw/mlx5/devx.c            |   26 +
 drivers/infiniband/hw/mlx5/flow.c            |   13 +-
 drivers/infiniband/hw/mlx5/main.c            |  131 ++--
 drivers/infiniband/hw/mlx5/mem.c             |   13 -
 drivers/infiniband/hw/mlx5/mlx5_ib.h         |    2 +
 drivers/infiniband/hw/mlx5/mr.c              |   38 +-
 drivers/infiniband/hw/mlx5/odp.c             |  172 ++---
 drivers/infiniband/hw/mlx5/qp.c              |   25 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  |    4 +-
 drivers/infiniband/hw/qedr/main.c            |    2 +-
 drivers/infiniband/hw/qedr/qedr.h            |    2 +-
 drivers/infiniband/hw/qedr/verbs.c           |    7 +-
 drivers/infiniband/hw/qib/qib_file_ops.c     |    3 +-
 drivers/infiniband/hw/qib/qib_rc.c           |   10 +-
 drivers/infiniband/hw/qib/qib_sysfs.c        |    2 +
 drivers/infiniband/hw/usnic/usnic_ib_main.c  |   10 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c |    9 +-
 drivers/infiniband/sw/rxe/rxe.h              |    4 -
 drivers/infiniband/sw/rxe/rxe_param.h        |    2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c        |    6 +-
 drivers/infiniband/sw/siw/siw_qp_tx.c        |   23 +-
 drivers/infiniband/sw/siw/siw_verbs.c        |    3 +-
 drivers/infiniband/ulp/iser/iscsi_iser.h     |    7 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c        |    4 +-
 drivers/net/ethernet/mellanox/mlx5/core/rl.c |    6 +-
 drivers/net/ethernet/qlogic/qed/qed_rdma.c   |    5 +-
 fs/cifs/smbdirect.c                          |   10 +-
 include/Kbuild                               |    6 -
 include/linux/mlx5/device.h                  |    9 +
 include/linux/qed/qed_rdma_if.h              |    2 +-
 include/rdma/ib.h                            |    2 +
 include/rdma/ib_umem_odp.h                   |   48 +-
 include/rdma/ib_verbs.h                      |   78 +-
 include/rdma/iw_portmap.h                    |    3 +
 include/rdma/opa_port_info.h                 |    2 +
 include/rdma/rdma_netlink.h                  |   10 +-
 include/rdma/rdma_vt.h                       |    1 +
 include/rdma/rdmavt_cq.h                     |    1 +
 include/rdma/rdmavt_qp.h                     |   35 +
 include/rdma/signature.h                     |    2 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h    |    1 +
 net/9p/trans_rdma.c                          |    6 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c     |    8 +-
 net/sunrpc/xprtrdma/verbs.c                  |   13 +-
 104 files changed, 3072 insertions(+), 2213 deletions(-)
(diffstat from tag for-linus-merged)

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl2DrhcACgkQOG33FX4g
mxqUVhAAmoqW58WFKUJFXgSIERfkJnEsqzj+8gK4yB0cmPFDbrbbW/ES6lQx9ROj
HbJf+5SOGw/Ks0bSyOJJvSLS+oRwD6dIr6fDTYsBjAwYItrrZKpELB7K4osTwYRL
1o2AaMQY/TLjFOCZpfSx19cbQctr4WvJadxGQBoTstT5BlRcyJH+ICsfLFNrM7n9
ciItjQ53zym0P3BKqwRvpeLNNl5XMOFObhnhvwlJYOsIp3YrUew9k4EHHadiGwiB
uPKgemZb08CSxJ/755JJjrMIxa3u5EiFuq2UdBj97PhZf0hqdn351yWIJ+GK0vEF
sbs53TUSKIIhMwzLrVMnVGNKAfcPlPW0HlejsNqHt/Utf+e9GuK6s0vmXZwIzBIs
EuW/gjV+341VeoOq9ZQGe1i0TatMtsFeFrzNVEn5mBDOPPIuSBILjt8/JDkiOKhK
pfivZ0CrvBri/jb8DAOVeIDSVE+VIo9bX3dCpPDZUMzT7hd/cKPiFCvXTV52Wwqj
EETBWX+QTavdbXtLzuo334ULvJPHqptcJFzwo5hlMrwQ+XUDonPIpyU6ZcR3eukZ
o0ggJ1OzcpDSnIdY6q+BIQPVAZmcphoOIQcfpcKstTW1wKXHvf0e6ZioYMMcxrV7
GAFrYw4x2OmPWJr9KksYlchO8zEl767cFy+HjMTl4/K/8AaQPNI=
=Yw0h
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
