Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0EC1732F1
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2020 09:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgB1IdD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Feb 2020 03:33:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:1084 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgB1IdD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Feb 2020 03:33:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 00:33:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,495,1574150400"; 
   d="scan'208";a="350879316"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2020 00:33:00 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j7b4t-0001qR-VG; Fri, 28 Feb 2020 16:32:59 +0800
Date:   Fri, 28 Feb 2020 16:32:13 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 65a166201552113f9e1e8d1bb4a55a1eb70cb19c
Message-ID: <5e58d00d.O8gMRqEU0GcUlUbz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-next
branch HEAD: 65a166201552113f9e1e8d1bb4a55a1eb70cb19c  RDMA/bnxt_re: Using vmalloc requires including vmalloc.h

elapsed time: 2134m

configs tested: 263
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
h8300                     edosk2674_defconfig
arc                                 defconfig
riscv                    nommu_virt_defconfig
s390                       zfcpdump_defconfig
riscv                          rv32_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
sparc64                          allmodconfig
nios2                         3c120_defconfig
sparc64                             defconfig
sparc64                           allnoconfig
h8300                    h8300h-sim_defconfig
ia64                              allnoconfig
nds32                               defconfig
csky                                defconfig
nios2                         10m50_defconfig
sh                          rsk7269_defconfig
ia64                             allmodconfig
ia64                                defconfig
powerpc                             defconfig
um                                  defconfig
xtensa                          iss_defconfig
mips                      malta_kvm_defconfig
nds32                             allnoconfig
powerpc                       ppc64_defconfig
riscv                            allyesconfig
mips                      fuloong2e_defconfig
sh                            titan_defconfig
s390                          debug_defconfig
microblaze                      mmu_defconfig
m68k                           sun3_defconfig
xtensa                       common_defconfig
sparc64                          allyesconfig
parisc                generic-32bit_defconfig
s390                              allnoconfig
powerpc                           allnoconfig
parisc                generic-64bit_defconfig
sh                                allnoconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allyesconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
arc                              allyesconfig
microblaze                    nommu_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
parisc                            allnoconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200227
x86_64               randconfig-a002-20200227
x86_64               randconfig-a003-20200227
i386                 randconfig-a001-20200227
i386                 randconfig-a002-20200227
i386                 randconfig-a003-20200227
x86_64               randconfig-a001-20200226
x86_64               randconfig-a002-20200226
x86_64               randconfig-a003-20200226
i386                 randconfig-a001-20200226
i386                 randconfig-a002-20200226
i386                 randconfig-a003-20200226
x86_64               randconfig-a001-20200228
x86_64               randconfig-a002-20200228
x86_64               randconfig-a003-20200228
i386                 randconfig-a001-20200228
i386                 randconfig-a002-20200228
i386                 randconfig-a003-20200228
alpha                randconfig-a001-20200227
m68k                 randconfig-a001-20200227
mips                 randconfig-a001-20200227
nds32                randconfig-a001-20200227
parisc               randconfig-a001-20200227
riscv                randconfig-a001-20200227
alpha                randconfig-a001-20200228
m68k                 randconfig-a001-20200228
mips                 randconfig-a001-20200228
nds32                randconfig-a001-20200228
parisc               randconfig-a001-20200228
riscv                randconfig-a001-20200228
c6x                  randconfig-a001-20200227
h8300                randconfig-a001-20200227
microblaze           randconfig-a001-20200227
nios2                randconfig-a001-20200227
sparc64              randconfig-a001-20200227
c6x                  randconfig-a001-20200228
h8300                randconfig-a001-20200228
microblaze           randconfig-a001-20200228
nios2                randconfig-a001-20200228
sparc64              randconfig-a001-20200228
c6x                  randconfig-a001-20200226
h8300                randconfig-a001-20200226
microblaze           randconfig-a001-20200226
nios2                randconfig-a001-20200226
sparc64              randconfig-a001-20200226
csky                 randconfig-a001-20200227
openrisc             randconfig-a001-20200227
s390                 randconfig-a001-20200227
sh                   randconfig-a001-20200227
xtensa               randconfig-a001-20200227
csky                 randconfig-a001-20200228
openrisc             randconfig-a001-20200228
s390                 randconfig-a001-20200228
sh                   randconfig-a001-20200228
xtensa               randconfig-a001-20200228
x86_64               randconfig-b001-20200227
x86_64               randconfig-b002-20200227
x86_64               randconfig-b003-20200227
i386                 randconfig-b001-20200227
i386                 randconfig-b002-20200227
i386                 randconfig-b003-20200227
x86_64               randconfig-b001-20200228
x86_64               randconfig-b002-20200228
x86_64               randconfig-b003-20200228
i386                 randconfig-b001-20200228
i386                 randconfig-b002-20200228
i386                 randconfig-b003-20200228
x86_64               randconfig-c001-20200227
x86_64               randconfig-c002-20200227
x86_64               randconfig-c003-20200227
i386                 randconfig-c001-20200227
i386                 randconfig-c002-20200227
i386                 randconfig-c003-20200227
x86_64               randconfig-c001-20200226
x86_64               randconfig-c002-20200226
x86_64               randconfig-c003-20200226
i386                 randconfig-c001-20200226
i386                 randconfig-c002-20200226
i386                 randconfig-c003-20200226
x86_64               randconfig-d001-20200227
x86_64               randconfig-d002-20200227
x86_64               randconfig-d003-20200227
i386                 randconfig-d001-20200227
i386                 randconfig-d002-20200227
i386                 randconfig-d003-20200227
x86_64               randconfig-d001-20200226
x86_64               randconfig-d002-20200226
x86_64               randconfig-d003-20200226
i386                 randconfig-d001-20200226
i386                 randconfig-d002-20200226
i386                 randconfig-d003-20200226
x86_64               randconfig-d001-20200228
x86_64               randconfig-d002-20200228
x86_64               randconfig-d003-20200228
i386                 randconfig-d001-20200228
i386                 randconfig-d002-20200228
i386                 randconfig-d003-20200228
x86_64               randconfig-e001-20200227
x86_64               randconfig-e002-20200227
x86_64               randconfig-e003-20200227
i386                 randconfig-e001-20200227
i386                 randconfig-e002-20200227
i386                 randconfig-e003-20200227
x86_64               randconfig-e001-20200226
x86_64               randconfig-e002-20200226
x86_64               randconfig-e003-20200226
i386                 randconfig-e001-20200226
i386                 randconfig-e002-20200226
i386                 randconfig-e003-20200226
x86_64               randconfig-e001-20200228
x86_64               randconfig-e002-20200228
x86_64               randconfig-e003-20200228
i386                 randconfig-e001-20200228
i386                 randconfig-e002-20200228
i386                 randconfig-e003-20200228
x86_64               randconfig-f001-20200227
x86_64               randconfig-f002-20200227
x86_64               randconfig-f003-20200227
i386                 randconfig-f001-20200227
i386                 randconfig-f002-20200227
i386                 randconfig-f003-20200227
x86_64               randconfig-f001-20200226
x86_64               randconfig-f002-20200226
x86_64               randconfig-f003-20200226
i386                 randconfig-f001-20200226
i386                 randconfig-f002-20200226
i386                 randconfig-f003-20200226
x86_64               randconfig-g001-20200228
x86_64               randconfig-g002-20200228
x86_64               randconfig-g003-20200228
i386                 randconfig-g001-20200228
i386                 randconfig-g002-20200228
i386                 randconfig-g003-20200228
x86_64               randconfig-g001-20200227
x86_64               randconfig-g002-20200227
x86_64               randconfig-g003-20200227
i386                 randconfig-g001-20200227
i386                 randconfig-g002-20200227
i386                 randconfig-g003-20200227
x86_64               randconfig-h001-20200227
x86_64               randconfig-h002-20200227
x86_64               randconfig-h003-20200227
i386                 randconfig-h001-20200227
i386                 randconfig-h002-20200227
i386                 randconfig-h003-20200227
x86_64               randconfig-h001-20200228
x86_64               randconfig-h002-20200228
x86_64               randconfig-h003-20200228
i386                 randconfig-h001-20200228
i386                 randconfig-h002-20200228
i386                 randconfig-h003-20200228
x86_64               randconfig-h001-20200226
x86_64               randconfig-h002-20200226
x86_64               randconfig-h003-20200226
i386                 randconfig-h001-20200226
i386                 randconfig-h002-20200226
i386                 randconfig-h003-20200226
arm                  randconfig-a001-20200227
arm64                randconfig-a001-20200227
ia64                 randconfig-a001-20200227
powerpc              randconfig-a001-20200227
arc                  randconfig-a001-20200228
arm                  randconfig-a001-20200228
arm64                randconfig-a001-20200228
ia64                 randconfig-a001-20200228
powerpc              randconfig-a001-20200228
sparc                randconfig-a001-20200228
arc                  randconfig-a001-20200227
sparc                randconfig-a001-20200227
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
sh                               allmodconfig
sh                  sh7785lcr_32bit_defconfig
sparc                               defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
