Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 844A516013C
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Feb 2020 01:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgBPAUH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Feb 2020 19:20:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:36158 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgBPAUH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 15 Feb 2020 19:20:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2020 16:19:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,446,1574150400"; 
   d="scan'208";a="407386172"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Feb 2020 16:19:49 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j37f2-0001on-KY; Sun, 16 Feb 2020 08:19:48 +0800
Date:   Sun, 16 Feb 2020 08:19:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 f03d9fadfe13a78ee28fec320d43f7b37574adcb
Message-ID: <5e488a87.bzzWMxTaRWwVfh0O%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: f03d9fadfe13a78ee28fec320d43f7b37574adcb  RDMA/core: Add weak ordering dma attr to dma mapping

elapsed time: 2883m

configs tested: 244
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
sparc                            allyesconfig
powerpc                             defconfig
m68k                          multi_defconfig
csky                                defconfig
nds32                               defconfig
i386                                defconfig
riscv                            allmodconfig
sparc                               defconfig
riscv                            allyesconfig
s390                                defconfig
powerpc                           allnoconfig
h8300                     edosk2674_defconfig
mips                             allyesconfig
arc                              allyesconfig
m68k                           sun3_defconfig
i386                              allnoconfig
nios2                         3c120_defconfig
arc                                 defconfig
parisc                generic-64bit_defconfig
m68k                       m5475evb_defconfig
microblaze                      mmu_defconfig
riscv                             allnoconfig
alpha                               defconfig
um                           x86_64_defconfig
parisc                           allyesconfig
h8300                       h8s-sim_defconfig
i386                             allyesconfig
ia64                                defconfig
ia64                              allnoconfig
mips                              allnoconfig
nds32                             allnoconfig
s390                             alldefconfig
um                                  defconfig
mips                             allmodconfig
sh                  sh7785lcr_32bit_defconfig
ia64                             alldefconfig
openrisc                    or1ksim_defconfig
riscv                               defconfig
s390                          debug_defconfig
parisc                generic-32bit_defconfig
c6x                              allyesconfig
i386                             alldefconfig
sh                          rsk7269_defconfig
s390                             allmodconfig
s390                              allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
h8300                    h8300h-sim_defconfig
m68k                             allmodconfig
microblaze                    nommu_defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
x86_64               randconfig-a001-20200215
x86_64               randconfig-a002-20200215
x86_64               randconfig-a003-20200215
i386                 randconfig-a001-20200215
i386                 randconfig-a002-20200215
i386                 randconfig-a003-20200215
i386                 randconfig-a003-20200214
i386                 randconfig-a001-20200214
x86_64               randconfig-a003-20200214
x86_64               randconfig-a002-20200214
x86_64               randconfig-a001-20200214
i386                 randconfig-a002-20200214
alpha                randconfig-a001-20200214
m68k                 randconfig-a001-20200214
mips                 randconfig-a001-20200214
nds32                randconfig-a001-20200214
parisc               randconfig-a001-20200214
riscv                randconfig-a001-20200214
c6x                  randconfig-a001-20200213
h8300                randconfig-a001-20200213
microblaze           randconfig-a001-20200213
nios2                randconfig-a001-20200213
sparc64              randconfig-a001-20200213
c6x                  randconfig-a001-20200214
h8300                randconfig-a001-20200214
microblaze           randconfig-a001-20200214
nios2                randconfig-a001-20200214
sparc64              randconfig-a001-20200214
c6x                  randconfig-a001-20200215
h8300                randconfig-a001-20200215
microblaze           randconfig-a001-20200215
nios2                randconfig-a001-20200215
sparc64              randconfig-a001-20200215
csky                 randconfig-a001-20200214
openrisc             randconfig-a001-20200214
s390                 randconfig-a001-20200214
sh                   randconfig-a001-20200214
xtensa               randconfig-a001-20200214
csky                 randconfig-a001-20200215
openrisc             randconfig-a001-20200215
s390                 randconfig-a001-20200215
sh                   randconfig-a001-20200215
xtensa               randconfig-a001-20200215
csky                 randconfig-a001-20200213
openrisc             randconfig-a001-20200213
s390                 randconfig-a001-20200213
sh                   randconfig-a001-20200213
xtensa               randconfig-a001-20200213
x86_64               randconfig-b001-20200214
x86_64               randconfig-b002-20200214
x86_64               randconfig-b003-20200214
i386                 randconfig-b001-20200214
i386                 randconfig-b002-20200214
i386                 randconfig-b003-20200214
x86_64               randconfig-c001-20200213
x86_64               randconfig-c002-20200213
x86_64               randconfig-c003-20200213
i386                 randconfig-c001-20200213
i386                 randconfig-c002-20200213
i386                 randconfig-c003-20200213
x86_64               randconfig-c001-20200214
x86_64               randconfig-c002-20200214
x86_64               randconfig-c003-20200214
i386                 randconfig-c001-20200214
i386                 randconfig-c002-20200214
i386                 randconfig-c003-20200214
x86_64               randconfig-d001-20200213
x86_64               randconfig-d002-20200213
x86_64               randconfig-d003-20200213
i386                 randconfig-d001-20200213
i386                 randconfig-d002-20200213
i386                 randconfig-d003-20200213
x86_64               randconfig-d001-20200214
x86_64               randconfig-d002-20200214
x86_64               randconfig-d003-20200214
i386                 randconfig-d001-20200214
i386                 randconfig-d002-20200214
i386                 randconfig-d003-20200214
x86_64               randconfig-d001-20200215
x86_64               randconfig-d002-20200215
x86_64               randconfig-d003-20200215
i386                 randconfig-d001-20200215
i386                 randconfig-d002-20200215
i386                 randconfig-d003-20200215
x86_64               randconfig-e001-20200214
x86_64               randconfig-e002-20200214
x86_64               randconfig-e003-20200214
i386                 randconfig-e001-20200214
i386                 randconfig-e002-20200214
i386                 randconfig-e003-20200214
x86_64               randconfig-f001-20200214
x86_64               randconfig-f002-20200214
x86_64               randconfig-f003-20200214
i386                 randconfig-f001-20200214
i386                 randconfig-f002-20200214
i386                 randconfig-f003-20200214
x86_64               randconfig-f001-20200213
x86_64               randconfig-f002-20200213
x86_64               randconfig-f003-20200213
i386                 randconfig-f001-20200213
i386                 randconfig-f002-20200213
i386                 randconfig-f003-20200213
x86_64               randconfig-g001-20200214
x86_64               randconfig-g002-20200214
x86_64               randconfig-g003-20200214
i386                 randconfig-g001-20200214
i386                 randconfig-g002-20200214
i386                 randconfig-g003-20200214
x86_64               randconfig-g001-20200213
x86_64               randconfig-g002-20200213
x86_64               randconfig-g003-20200213
i386                 randconfig-g001-20200213
i386                 randconfig-g002-20200213
i386                 randconfig-g003-20200213
x86_64               randconfig-g001-20200215
x86_64               randconfig-g002-20200215
x86_64               randconfig-g003-20200215
i386                 randconfig-g001-20200215
i386                 randconfig-g002-20200215
i386                 randconfig-g003-20200215
x86_64               randconfig-h001-20200214
x86_64               randconfig-h002-20200214
x86_64               randconfig-h003-20200214
i386                 randconfig-h001-20200214
i386                 randconfig-h002-20200214
i386                 randconfig-h003-20200214
x86_64               randconfig-h001-20200213
x86_64               randconfig-h002-20200213
x86_64               randconfig-h003-20200213
i386                 randconfig-h001-20200213
i386                 randconfig-h002-20200213
i386                 randconfig-h003-20200213
arc                  randconfig-a001-20200215
arm                  randconfig-a001-20200215
arm64                randconfig-a001-20200215
ia64                 randconfig-a001-20200215
powerpc              randconfig-a001-20200215
sparc                randconfig-a001-20200215
arc                  randconfig-a001-20200214
arm                  randconfig-a001-20200214
arm64                randconfig-a001-20200214
ia64                 randconfig-a001-20200214
powerpc              randconfig-a001-20200214
sparc                randconfig-a001-20200214
arc                  randconfig-a001-20200213
sparc                randconfig-a001-20200213
ia64                 randconfig-a001-20200213
arm                  randconfig-a001-20200213
powerpc              randconfig-a001-20200213
arm64                randconfig-a001-20200213
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             allyesconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                            titan_defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                             i386_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
