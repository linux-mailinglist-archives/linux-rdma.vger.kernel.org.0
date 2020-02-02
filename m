Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2815A14FEFE
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Feb 2020 20:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgBBTvy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 2 Feb 2020 14:51:54 -0500
Received: from mga09.intel.com ([134.134.136.24]:65457 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgBBTvy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 2 Feb 2020 14:51:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Feb 2020 11:51:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,395,1574150400"; 
   d="scan'208";a="403215908"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Feb 2020 11:51:51 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iyLHa-000A8R-Vl; Mon, 03 Feb 2020 03:51:50 +0800
Date:   Mon, 03 Feb 2020 03:51:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 8889f6fa35884d09f24734e10fea0c9ddcbc6429
Message-ID: <5e37284f./++cpC+2VEIklOBe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-next
branch HEAD: 8889f6fa35884d09f24734e10fea0c9ddcbc6429  RDMA/core: Make the entire API tree static

elapsed time: 4085m

configs tested: 264
configs skipped: 1

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
arc                                 defconfig
um                           x86_64_defconfig
sparc64                          allyesconfig
m68k                           sun3_defconfig
s390                                defconfig
microblaze                      mmu_defconfig
um                             i386_defconfig
ia64                                defconfig
powerpc                             defconfig
powerpc                           allnoconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
xtensa                       common_defconfig
openrisc                    or1ksim_defconfig
nios2                         3c120_defconfig
xtensa                          iss_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
nds32                               defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                          multi_defconfig
arc                              allyesconfig
microblaze                    nommu_defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                      malta_kvm_defconfig
mips                      fuloong2e_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                 randconfig-a003-20200202
i386                 randconfig-a002-20200202
x86_64               randconfig-a003-20200202
i386                 randconfig-a001-20200202
x86_64               randconfig-a002-20200202
x86_64               randconfig-a001-20200202
x86_64               randconfig-a001-20200129
i386                 randconfig-a001-20200129
x86_64               randconfig-a002-20200129
i386                 randconfig-a002-20200129
i386                 randconfig-a003-20200129
x86_64               randconfig-a003-20200129
i386                 randconfig-a002-20200130
i386                 randconfig-a001-20200130
x86_64               randconfig-a002-20200130
x86_64               randconfig-a003-20200130
i386                 randconfig-a003-20200130
x86_64               randconfig-a001-20200130
nds32                randconfig-a001-20200131
parisc               randconfig-a001-20200131
alpha                randconfig-a001-20200131
riscv                randconfig-a001-20200131
m68k                 randconfig-a001-20200131
alpha                randconfig-a001-20200202
parisc               randconfig-a001-20200202
m68k                 randconfig-a001-20200202
nds32                randconfig-a001-20200202
mips                 randconfig-a001-20200202
riscv                randconfig-a001-20200202
nds32                randconfig-a001-20200130
parisc               randconfig-a001-20200130
alpha                randconfig-a001-20200130
mips                 randconfig-a001-20200130
m68k                 randconfig-a001-20200130
riscv                randconfig-a001-20200130
h8300                randconfig-a001-20200202
nios2                randconfig-a001-20200202
microblaze           randconfig-a001-20200202
c6x                  randconfig-a001-20200202
h8300                randconfig-a001-20200130
nios2                randconfig-a001-20200130
c6x                  randconfig-a001-20200130
sparc64              randconfig-a001-20200130
sparc64              randconfig-a001-20200202
sh                   randconfig-a001-20200202
s390                 randconfig-a001-20200202
csky                 randconfig-a001-20200202
xtensa               randconfig-a001-20200202
openrisc             randconfig-a001-20200202
x86_64               randconfig-b002-20200129
i386                 randconfig-b001-20200129
i386                 randconfig-b002-20200129
x86_64               randconfig-b001-20200129
x86_64               randconfig-b003-20200129
i386                 randconfig-b001-20200202
x86_64               randconfig-b002-20200202
i386                 randconfig-b002-20200202
x86_64               randconfig-b001-20200202
i386                 randconfig-b003-20200202
x86_64               randconfig-b003-20200202
i386                 randconfig-b003-20200129
i386                 randconfig-c003-20200202
i386                 randconfig-c003-20200129
x86_64               randconfig-c003-20200129
x86_64               randconfig-c002-20200129
x86_64               randconfig-c001-20200129
i386                 randconfig-c001-20200129
i386                 randconfig-c002-20200129
i386                 randconfig-c001-20200131
x86_64               randconfig-c003-20200131
i386                 randconfig-c003-20200131
x86_64               randconfig-c001-20200131
x86_64               randconfig-c002-20200131
i386                 randconfig-c002-20200131
x86_64               randconfig-c003-20200202
x86_64               randconfig-c002-20200202
i386                 randconfig-c002-20200202
i386                 randconfig-c001-20200202
x86_64               randconfig-c001-20200202
i386                 randconfig-d003-20200202
i386                 randconfig-d003-20200130
x86_64               randconfig-d002-20200130
i386                 randconfig-d001-20200130
i386                 randconfig-d002-20200130
x86_64               randconfig-d003-20200130
x86_64               randconfig-d001-20200130
i386                 randconfig-d003-20200129
i386                 randconfig-d002-20200129
x86_64               randconfig-d003-20200129
x86_64               randconfig-d001-20200129
x86_64               randconfig-d002-20200129
i386                 randconfig-d001-20200129
x86_64               randconfig-d003-20200202
i386                 randconfig-d001-20200202
x86_64               randconfig-d002-20200202
x86_64               randconfig-d001-20200202
i386                 randconfig-d002-20200202
i386                 randconfig-e003-20200202
i386                 randconfig-e002-20200202
x86_64               randconfig-e001-20200202
x86_64               randconfig-e003-20200202
i386                 randconfig-e001-20200202
x86_64               randconfig-e002-20200202
i386                 randconfig-e002-20200129
x86_64               randconfig-e002-20200129
i386                 randconfig-e001-20200129
i386                 randconfig-e003-20200129
x86_64               randconfig-e003-20200129
x86_64               randconfig-e001-20200129
i386                 randconfig-e001-20200130
x86_64               randconfig-e002-20200130
x86_64               randconfig-e003-20200130
i386                 randconfig-e003-20200130
x86_64               randconfig-e001-20200130
i386                 randconfig-e002-20200130
x86_64               randconfig-f001-20200202
x86_64               randconfig-f002-20200202
x86_64               randconfig-f003-20200202
i386                 randconfig-f001-20200202
i386                 randconfig-f002-20200202
i386                 randconfig-f003-20200202
x86_64               randconfig-f001-20200129
x86_64               randconfig-f003-20200129
x86_64               randconfig-f002-20200129
i386                 randconfig-f001-20200129
i386                 randconfig-f003-20200129
i386                 randconfig-f002-20200129
i386                 randconfig-g003-20200129
x86_64               randconfig-g003-20200129
x86_64               randconfig-g001-20200129
i386                 randconfig-g001-20200129
x86_64               randconfig-g002-20200129
i386                 randconfig-g002-20200129
x86_64               randconfig-g003-20200202
x86_64               randconfig-g001-20200202
i386                 randconfig-g001-20200202
x86_64               randconfig-g002-20200202
i386                 randconfig-g002-20200202
i386                 randconfig-g003-20200202
x86_64               randconfig-h001-20200202
x86_64               randconfig-h002-20200202
x86_64               randconfig-h003-20200202
i386                 randconfig-h001-20200202
i386                 randconfig-h002-20200202
i386                 randconfig-h003-20200202
i386                 randconfig-h003-20200129
x86_64               randconfig-h003-20200131
i386                 randconfig-h001-20200131
x86_64               randconfig-h002-20200131
i386                 randconfig-h003-20200131
i386                 randconfig-h002-20200131
x86_64               randconfig-h001-20200131
arm64                randconfig-a001-20200131
ia64                 randconfig-a001-20200131
sparc                randconfig-a001-20200131
arm                  randconfig-a001-20200131
arc                  randconfig-a001-20200131
arc                  randconfig-a001-20200203
arm                  randconfig-a001-20200203
arm64                randconfig-a001-20200203
ia64                 randconfig-a001-20200203
powerpc              randconfig-a001-20200203
sparc                randconfig-a001-20200203
arm64                randconfig-a001-20200130
ia64                 randconfig-a001-20200130
sparc                randconfig-a001-20200130
arm                  randconfig-a001-20200130
arc                  randconfig-a001-20200130
sparc                randconfig-a001-20200202
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
s390                          debug_defconfig
s390                       zfcpdump_defconfig
s390                              allnoconfig
s390                             alldefconfig
s390                             allmodconfig
s390                             allyesconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sh                            titan_defconfig
i386                             allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
um                                  defconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64                              fedora-25
x86_64                                  kexec
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
