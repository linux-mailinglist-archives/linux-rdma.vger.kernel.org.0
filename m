Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBC81ECC8A
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2020 11:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgFCJ0V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jun 2020 05:26:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:10946 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgFCJ0U (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 3 Jun 2020 05:26:20 -0400
IronPort-SDR: HEOzsoyVrcoVu9mlrLzeTLhAyqDPxIZWf4Jr5NgX0fwzOqvx3/2J4t+/lrDUf4JKkw+FEpk7JL
 d6yZa3WZHa+g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 02:26:18 -0700
IronPort-SDR: nmqgvkBOGLnfoD8UG7++1dLN+zlOfpE294s7psOEUriFnJ5N0HjuXxky8f54ID1lxC/cywg8gW
 tAQ1CapIjG9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="470987140"
Received: from lkp-server01.sh.intel.com (HELO dad89584b564) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jun 2020 02:26:16 -0700
Received: from kbuild by dad89584b564 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jgPf6-00004V-4k; Wed, 03 Jun 2020 09:26:16 +0000
Date:   Wed, 03 Jun 2020 17:25:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 87d9e568496aeb519f1da61f54ac0dcb8d37561e
Message-ID: <5ed76c94.im16kMbIMrkFAxZa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-next
branch HEAD: 87d9e568496aeb519f1da61f54ac0dcb8d37561e  RDMA/hns: Uninitialized variable in modify_qp_init_to_rtr()

i386-tinyconfig vmlinux size:

+-------+------------------------------------+---------------------------------------------------------------------------+
| DELTA |               SYMBOL               |                                  COMMIT                                   |
+-------+------------------------------------+---------------------------------------------------------------------------+
|  +455 | TOTAL                              | 8f3d9f354286..87d9e568496a (ALL COMMITS)                                  |
|  +456 | TOTAL                              | eafd47fc200e Merge tag 'v5.7-rc6' into rdma.git for-next                  |
|  +379 | TEXT                               | eafd47fc200e Merge tag 'v5.7-rc6' into rdma.git for-next                  |
|   +72 | DATA                               | eafd47fc200e Merge tag 'v5.7-rc6' into rdma.git for-next                  |
|  +240 | free_irq()                         | eafd47fc200e Merge tag 'v5.7-rc6' into rdma.git for-next                  |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 21aad80b17e6 RDMA/mlx5: Globally parse DEVX UID                           |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 5d6fffed1cfd RDMA/mlx5: Promote RSS RAW QP flags check to higher level    |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 6367da46d3cb RDMA/mlx5: Remove redundant destroy QP call                  |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 451c9fc77ae6 Merge branch 'mellanox/mlx5-next' into rdma.git for-next     |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 51aab12631dd RDMA/core: Get xmit slave for LAG                            |
|  +136 | arch/x86/events/zhaoxin/built-in.* | b2ea69b3b443 RDMA/efa: Report create CQ error counter                     |
|  +136 | arch/x86/events/zhaoxin/built-in.* | f86e34374a05 RDMA/efa: Count admin commands errors                        |
|  +136 | arch/x86/events/zhaoxin/built-in.* | d5665a21250e RDMA/core: Add hash functions to calculate RoCEv2 flowlabel  |
|  +136 | arch/x86/events/zhaoxin/built-in.* | f66534051936 RDMA/cma: Initialize the flow label of CM's route path recor |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 2929c40f08a9 RDMA/hns: Remove unused MTT functions                        |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 67954a6e379b RDMA/hns: Optimize SRQ buffer size calculating process       |
|  +136 | arch/x86/events/zhaoxin/built-in.* | e4faa478c6b8 RDMA/hns: Remove redundant assignment of caps                |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 029e88fd1e61 RDMA/mlx5: Move all WR logic from qp.c to separate file      |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 52c81f47f0d2 RDMA/mlx5: Remove duplicated assignment to variable rcqe_sz  |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 90ae0b57e4a5 RDMA/hns: Combine enable flags of qp                         |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 42113eed8f10 RDMA/cm: Remove unused store to ret in cm_rej_handler        |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 9767a27e1aeb RDMA/cm: Pass the cm_id_private into cm_cleanup_timewait     |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 1cc44279f297 RDMA/cm: Remove the cm_free_id() wrapper function            |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 0cb9e4f9e98a IB/rdmavt: Replace zero-length array with flexible-array     |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 8c112a5f29a3 RDMA/mlx5: Add support in steering default miss              |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 9ddacff18b15 sysfs: export sysfs_remove_file_self()                       |
|  +136 | arch/x86/events/zhaoxin/built-in.* | c0894b3ea69d RDMA/rtrs: core: lib functions shared between client and ser |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 89dd4c3bdc46 RDMA/rtrs: client: statistics functions                      |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 9cb837480424 RDMA/rtrs: server: main functionality                        |
|  +136 | arch/x86/events/zhaoxin/built-in.* | c013fbc1fd34 RDMA/rtrs: include client and server modules into kernel com |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 90426e89f54d block/rnbd: client: private header with client structs and f |
|  +136 | arch/x86/events/zhaoxin/built-in.* | d4c6957dd001 block/rnbd: server: private header with server structs and f |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 8cee532f469b block/rnbd: server: sysfs interface functions                |
|  +136 | arch/x86/events/zhaoxin/built-in.* | f11e0ec55f0c MAINTAINERS: Add maintainers for RNBD/RTRS modules           |
|  +136 | arch/x86/events/zhaoxin/built-in.* | b0810b037de0 RDMA/core: Consolidate ib_create_srq flows                   |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 23bbd5818e2b RDMA/srpt: Fix disabling device management                   |
|  +136 | arch/x86/events/zhaoxin/built-in.* | bf1d8edb38bb RDMA/rtrs: Fix a couple off by one bugs in rtrs_srv_rdma_don |
|  +136 | arch/x86/events/zhaoxin/built-in.* | d6ea39507245 rnbd/rtrs: Pass max segment size from blk user to the rdma l |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 349be2765094 RDMA/hns: Bugfix for querying qkey                           |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 6968aeb5aa64 RDMA/hns: Fix wrong assignment of SRQ's max_wr               |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 9581a356ccad RDMA/hns: Rename macro for defining hns hardware page size   |
|  +136 | arch/x86/events/zhaoxin/built-in.* | cc8a635e24ac RDMA/efa: Fix setting of wrong bit in get/set_feature comman |
|  +136 | arch/x86/events/zhaoxin/built-in.* | d99dc602e2a5 IB/hfi1: Add functions to transmit datagram ipoib packets    |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 84e3b19a27f8 IB/hfi1: Remove module parameter for KDETH qpns              |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 6d72344cf6c4 IB/ipoib: Increase ipoib Datagram mode MTU's upper limit     |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 370caa5b5880 IB/hfi1: Add rx functions for dummy netdev                   |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 7638c0e965f4 IB/hfi1: Add packet histogram trace event                    |
|  +136 | arch/x86/events/zhaoxin/built-in.* | eafd47fc200e Merge tag 'v5.7-rc6' into rdma.git for-next                  |
|  +136 | arch/x86/events/zhaoxin/built-in.* | cda9ee494248 IB/uverbs: Extend CQ to get its own asynchronous event FD    |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 63a3345c2d42 IB/cma: Fix ports memory leak in cma_configfs                |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 25966e893143 RDMA/hns: Let software PI/CI grow naturally                  |
|  +136 | arch/x86/events/zhaoxin/built-in.* | b9c93e3aad13 RDMA/hns: Remove unused code about assert                    |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 13aa13dddd5f RDMA/hns: Change variables representing quantity to unsigned |
|  +136 | arch/x86/events/zhaoxin/built-in.* | f226f6765f7f RDMA/hns: Remove redundant parameters from free_srq/qp_wrid( |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 49ea0c036ede RDMA/iw_cxgb4: cleanup device debugfs entries on ULD remove  |
|  +136 | arch/x86/events/zhaoxin/built-in.* | bebcfe85f433 RDMA/core: Use sizeof_field() helper                         |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 98fc1126c416 RDMA/mlx5: Separate to user/kernel create QP flows           |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 08d53976609a RDMA/mlx5: Copy response to the user in one place            |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 0eacc574aae7 RDMA/mlx5: Verify that QP is created with RQ or SQ           |
|  -136 | arch/x86/events/zhaoxin/built-in.* | bd3920eac133 RDMA/core: Add LAG functionality                             |
|  -136 | arch/x86/events/zhaoxin/built-in.* | cfc1a89e449c RDMA/mlx5: Set lag tx affinity according to slave            |
|  -136 | arch/x86/events/zhaoxin/built-in.* | eca5757f804f RDMA/efa: Count mmap failures                                |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 11a0ae4c4bff RDMA: Allow ib_client's to fail when add() is called         |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 2b880b2e5e03 RDMA/mlx5: Define RoCEv2 udp source port when set path       |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 9b2cf76c9f05 RDMA/hns: Optimize PBL buffer allocation process             |
|  -136 | arch/x86/events/zhaoxin/built-in.* | ffb1308b88b6 RDMA/hns: Move SRQ code to the reasonable place              |
|  -136 | arch/x86/events/zhaoxin/built-in.* | b713128de7a1 RDMA/hns: Adjust lp_pktn_ini dynamically                     |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 6671cde83ddb RDMA/mlx5: Refactor mlx5_post_send() to improve readability  |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 42caf9cb5937 RDMA/mlx5: Allow only raw Ethernet QPs when RoCE isn't enabl |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 30661322b8c3 RDMA/hns: Extend capability flags for HIP08_C                |
|  -136 | arch/x86/events/zhaoxin/built-in.* | d3552fb65d23 RDMA/cm: Remove return code from add_cm_id_to_port_list      |
|  -136 | arch/x86/events/zhaoxin/built-in.* | e83f195aa45c RDMA/cm: Pull duplicated code into cm_queue_work_unlock()    |
|  -136 | arch/x86/events/zhaoxin/built-in.* | cfa68b0d0440 RDMA/cm: Make find_remote_id() return a cm_id_private        |
|  -136 | arch/x86/events/zhaoxin/built-in.* | a0e46db4e764 RDMA/cm: Increment the refcount inside cm_find_listen()      |
|  -136 | arch/x86/events/zhaoxin/built-in.* | b9019507aa6e RDMA/mlx5: Refactor DV create flow                           |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 59dde4d19cf8 RDMA/mlx5: Fix query_srq_cmd() function                      |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 91fddedd439c RDMA/rtrs: private headers with rtrs protocol structs and he |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 6a98d71daea1 RDMA/rtrs: client: main functionality                        |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 787f78a6b075 RDMA/rtrs: server: private header with server structs and fu |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 91b11610af8d RDMA/rtrs: server: sysfs interface functions                 |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 219ace607701 block/rnbd: private headers with rnbd protocol structs and h |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 1eb54f8f5dd8 block/rnbd: client: sysfs interface functions                |
|  -136 | arch/x86/events/zhaoxin/built-in.* | f0aad9baadb5 block/rnbd: server: functionality for IO submitting to block |
|  -136 | arch/x86/events/zhaoxin/built-in.* | aa4d16e44f60 block/rnbd: a bit of documentation                           |
|  -136 | arch/x86/events/zhaoxin/built-in.* | dbd67252869b RDMA/uverbs: Fix create WQ to use the given user handle      |
|  -136 | arch/x86/events/zhaoxin/built-in.* | daeee976904c RDMA/mlx5: Update mlx5_ib driver name                        |
|  -136 | arch/x86/events/zhaoxin/built-in.* | b386cd65d961 RDMA/rtrs: Fix some signedness bugs in error handling        |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 6b31afcef51e RDMA/rtrs: server: Fix some error return code                |
|  -136 | arch/x86/events/zhaoxin/built-in.* | bd25c8066fc2 RDMA/siw: Replace one-element array and use struct_size() he |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 441c88d5b3ff RDMA/hns: Fix cmdq parameter of querying pf timer resource   |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 7b611d2f6e8b RDMA/hns: Store mr len information into mr obj               |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 819f7427bafd RDMA/mlx5: Add init2init as a modify command                 |
|  -136 | arch/x86/events/zhaoxin/built-in.* | fe810b509c5f IB/hfi1: Add accelerated IP capability bit                   |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 438d7dda9841 IB/hfi1: Add the transmit side of a datagram ipoib RDMA netd |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 19d8b90a509f IB/hfi1: RSM rules for AIP                                   |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 0bae02d56bba IB/hfi1: Add interrupt handler functions for accelerated ipo |
|  -136 | arch/x86/events/zhaoxin/built-in.* | b7e159eb008e IB/{hfi1, ipoib, rdma}: Broadcast ping sent packets which ex |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 0ad45e5fdc52 IB/hfi1: Enable the transmit side of the datagram ipoib netd |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 98a8890f7348 IB/uverbs: Refactor related objects to use their own asynchr |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 47393fb57ba7 block/rnbd: Fix an IS_ERR() vs NULL check in find_or_create_ |
|  -136 | arch/x86/events/zhaoxin/built-in.* | e172037be757 RDMA/rtrs: server: Use already dereferenced rtrs_sess struct |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 0db6570947f4 RDMA/hns: Optimize post and poll process                     |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 82d07a4e466f RDMA/hns: Change all page_shift to unsigned                  |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 14ba87304bf9 RDMA/hns: Remove redundant type cast for general pointers    |
|  -136 | arch/x86/events/zhaoxin/built-in.* | e1b43f07c0d4 RDMA/hns: Make the end of sge process more clear             |
|  -136 | arch/x86/events/zhaoxin/built-in.* | ebd6e96b33a2 RDMA/ipoib: Remove can_sleep parameter from iboib_mcast_allo |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 87fee61c3513 RDMA/srp: Make the channel count configurable per target     |
|   +72 | copy_clone_args_from_user()        | eafd47fc200e Merge tag 'v5.7-rc6' into rdma.git for-next                  |
|   +64 | noop_backing_dev_info              | eafd47fc200e Merge tag 'v5.7-rc6' into rdma.git for-next                  |
|   -86 | setup_irq()                        | eafd47fc200e Merge tag 'v5.7-rc6' into rdma.git for-next                  |
|  -253 | __free_irq()                       | eafd47fc200e Merge tag 'v5.7-rc6' into rdma.git for-next                  |
+-------+------------------------------------+---------------------------------------------------------------------------+

elapsed time: 482m

configs tested: 114
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arc                              allyesconfig
ia64                                defconfig
arm                      pxa255-idp_defconfig
mips                        vocore2_defconfig
powerpc                           allnoconfig
arm                         nhk8815_defconfig
mips                           gcw0_defconfig
arc                    vdk_hs38_smp_defconfig
ia64                          tiger_defconfig
parisc                           allmodconfig
arm                         axm55xx_defconfig
sh                         apsh4a3a_defconfig
arm                        magician_defconfig
microblaze                    nommu_defconfig
mips                         rt305x_defconfig
powerpc                 linkstation_defconfig
arm                        spear6xx_defconfig
mips                            gpr_defconfig
powerpc                 mpc8272_ads_defconfig
arm                         s5pv210_defconfig
arm                       multi_v4t_defconfig
sh                        edosk7705_defconfig
arm                              alldefconfig
sh                          rsk7203_defconfig
powerpc                     pq2fads_defconfig
s390                             allyesconfig
powerpc                     mpc83xx_defconfig
sh                            migor_defconfig
powerpc                  mpc885_ads_defconfig
riscv                            alldefconfig
sh                        sh7785lcr_defconfig
arm                          lpd270_defconfig
s390                             alldefconfig
c6x                        evmc6472_defconfig
sh                          rsk7264_defconfig
sh                          kfr2r09_defconfig
m68k                       m5208evb_defconfig
c6x                         dsk6455_defconfig
m68k                            mac_defconfig
m68k                          multi_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                             defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
um                               allyesconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
