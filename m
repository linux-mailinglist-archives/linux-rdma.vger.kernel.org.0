Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC94E192791
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2020 12:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgCYLwQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Mar 2020 07:52:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:24267 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbgCYLwQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Mar 2020 07:52:16 -0400
IronPort-SDR: lz0QtVuY1+hs1LVvROSs4UonOu52HNjeg7PdI8wjc2GWapIzqAbPRSvewMK6o19yJkY1EIn/1q
 OjEzcMFcq9mQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 04:52:15 -0700
IronPort-SDR: 0LB2tAdc6fh/2Wxr5ZIyofPmbdmWI2YOSBOAHOsR1GVkTuyuHqlP1b8RyeWEPP4l7PL/viphLp
 9efUrWfcqczw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,304,1580803200"; 
   d="scan'208";a="235915781"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Mar 2020 04:52:14 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jH4Zx-0004h5-Ic; Wed, 25 Mar 2020 19:52:13 +0800
Date:   Wed, 25 Mar 2020 19:51:15 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 1f3db161881b7e21efb149e0ae8152b79a571a8f
Message-ID: <5e7b45b3.qGYZc8p33fibT//p%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 1f3db161881b7e21efb149e0ae8152b79a571a8f  IB/mlx5: Generally use the WC auto detection test result

elapsed time: 485m

configs tested: 174
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
riscv                            allyesconfig
i386                             allyesconfig
c6x                        evmc6678_defconfig
ia64                             allmodconfig
microblaze                    nommu_defconfig
sh                            titan_defconfig
csky                                defconfig
m68k                       m5475evb_defconfig
xtensa                          iss_defconfig
microblaze                      mmu_defconfig
ia64                             allyesconfig
powerpc                       ppc64_defconfig
nds32                             allnoconfig
nios2                         3c120_defconfig
c6x                              allyesconfig
i386                              allnoconfig
i386                             alldefconfig
i386                                defconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             alldefconfig
nios2                         10m50_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
nds32                               defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
arc                                 defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200325
x86_64               randconfig-a002-20200325
x86_64               randconfig-a003-20200325
i386                 randconfig-a001-20200325
i386                 randconfig-a002-20200325
i386                 randconfig-a003-20200325
alpha                randconfig-a001-20200324
m68k                 randconfig-a001-20200324
mips                 randconfig-a001-20200324
nds32                randconfig-a001-20200324
parisc               randconfig-a001-20200324
riscv                randconfig-a001-20200324
h8300                randconfig-a001-20200324
microblaze           randconfig-a001-20200324
nios2                randconfig-a001-20200324
c6x                  randconfig-a001-20200324
sparc64              randconfig-a001-20200324
c6x                  randconfig-a001-20200325
h8300                randconfig-a001-20200325
microblaze           randconfig-a001-20200325
nios2                randconfig-a001-20200325
sparc64              randconfig-a001-20200325
s390                 randconfig-a001-20200324
csky                 randconfig-a001-20200324
xtensa               randconfig-a001-20200324
openrisc             randconfig-a001-20200324
sh                   randconfig-a001-20200324
csky                 randconfig-a001-20200325
openrisc             randconfig-a001-20200325
s390                 randconfig-a001-20200325
sh                   randconfig-a001-20200325
xtensa               randconfig-a001-20200325
x86_64               randconfig-b001-20200325
x86_64               randconfig-b002-20200325
x86_64               randconfig-b003-20200325
i386                 randconfig-b001-20200325
i386                 randconfig-b002-20200325
i386                 randconfig-b003-20200325
x86_64               randconfig-c003-20200325
i386                 randconfig-c002-20200325
x86_64               randconfig-c001-20200325
x86_64               randconfig-c002-20200325
i386                 randconfig-c003-20200325
i386                 randconfig-c001-20200325
x86_64               randconfig-d001-20200325
x86_64               randconfig-d002-20200325
x86_64               randconfig-d003-20200325
i386                 randconfig-d001-20200325
i386                 randconfig-d002-20200325
i386                 randconfig-d003-20200325
x86_64               randconfig-e001-20200325
x86_64               randconfig-e002-20200325
x86_64               randconfig-e003-20200325
i386                 randconfig-e001-20200325
i386                 randconfig-e002-20200325
i386                 randconfig-e003-20200325
x86_64               randconfig-f001-20200325
x86_64               randconfig-f002-20200325
x86_64               randconfig-f003-20200325
i386                 randconfig-f001-20200325
i386                 randconfig-f002-20200325
i386                 randconfig-f003-20200325
x86_64               randconfig-g001-20200325
x86_64               randconfig-g002-20200325
x86_64               randconfig-g003-20200325
i386                 randconfig-g001-20200325
i386                 randconfig-g002-20200325
i386                 randconfig-g003-20200325
x86_64               randconfig-h002-20200325
x86_64               randconfig-h003-20200325
i386                 randconfig-h003-20200325
i386                 randconfig-h001-20200325
x86_64               randconfig-h001-20200325
i386                 randconfig-h002-20200325
arc                  randconfig-a001-20200325
arm                  randconfig-a001-20200325
arm64                randconfig-a001-20200325
ia64                 randconfig-a001-20200325
powerpc              randconfig-a001-20200325
sparc                randconfig-a001-20200325
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
