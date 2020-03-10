Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0D91803F7
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 17:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCJQvq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 12:51:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:38789 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgCJQvq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 12:51:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 09:51:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,537,1574150400"; 
   d="scan'208";a="441367372"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 10 Mar 2020 09:51:43 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jBi6Z-000IQi-6N; Wed, 11 Mar 2020 00:51:43 +0800
Date:   Wed, 11 Mar 2020 00:51:18 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 6d108b0c56db22292c3bbd1655093bea58aa1546
Message-ID: <5e67c586.e+aD9uDUsnY5Kp9l%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-rc
branch HEAD: 6d108b0c56db22292c3bbd1655093bea58aa1546  RDMA/core: Fix missing error check on dev_set_name()

elapsed time: 1100m

configs tested: 187
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
openrisc                 simple_smp_defconfig
ia64                                defconfig
powerpc                             defconfig
riscv                             allnoconfig
openrisc                    or1ksim_defconfig
i386                              allnoconfig
sparc                               defconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200310
x86_64               randconfig-a002-20200310
x86_64               randconfig-a003-20200310
i386                 randconfig-a001-20200310
i386                 randconfig-a002-20200310
i386                 randconfig-a003-20200310
alpha                randconfig-a001-20200309
m68k                 randconfig-a001-20200309
mips                 randconfig-a001-20200309
nds32                randconfig-a001-20200309
parisc               randconfig-a001-20200309
riscv                randconfig-a001-20200309
c6x                  randconfig-a001-20200310
h8300                randconfig-a001-20200310
microblaze           randconfig-a001-20200310
nios2                randconfig-a001-20200310
sparc64              randconfig-a001-20200310
csky                 randconfig-a001-20200309
openrisc             randconfig-a001-20200309
s390                 randconfig-a001-20200309
sh                   randconfig-a001-20200309
xtensa               randconfig-a001-20200309
csky                 randconfig-a001-20200310
openrisc             randconfig-a001-20200310
s390                 randconfig-a001-20200310
sh                   randconfig-a001-20200310
xtensa               randconfig-a001-20200310
x86_64               randconfig-b001-20200309
x86_64               randconfig-b002-20200309
x86_64               randconfig-b003-20200309
i386                 randconfig-b001-20200309
i386                 randconfig-b002-20200309
i386                 randconfig-b003-20200309
x86_64               randconfig-b001-20200310
x86_64               randconfig-b002-20200310
x86_64               randconfig-b003-20200310
i386                 randconfig-b001-20200310
i386                 randconfig-b002-20200310
i386                 randconfig-b003-20200310
x86_64               randconfig-c001-20200310
x86_64               randconfig-c002-20200310
x86_64               randconfig-c003-20200310
i386                 randconfig-c001-20200310
i386                 randconfig-c002-20200310
i386                 randconfig-c003-20200310
x86_64               randconfig-c001-20200309
x86_64               randconfig-c002-20200309
x86_64               randconfig-c003-20200309
i386                 randconfig-c001-20200309
i386                 randconfig-c002-20200309
i386                 randconfig-c003-20200309
x86_64               randconfig-d001-20200310
x86_64               randconfig-d002-20200310
x86_64               randconfig-d003-20200310
i386                 randconfig-d001-20200310
i386                 randconfig-d002-20200310
i386                 randconfig-d003-20200310
x86_64               randconfig-e001-20200310
x86_64               randconfig-e002-20200310
x86_64               randconfig-e003-20200310
i386                 randconfig-e001-20200310
i386                 randconfig-e002-20200310
i386                 randconfig-e003-20200310
x86_64               randconfig-f001-20200310
x86_64               randconfig-f002-20200310
x86_64               randconfig-f003-20200310
i386                 randconfig-f001-20200310
i386                 randconfig-f002-20200310
i386                 randconfig-f003-20200310
x86_64               randconfig-g001-20200310
x86_64               randconfig-g002-20200310
x86_64               randconfig-g003-20200310
i386                 randconfig-g001-20200310
i386                 randconfig-g002-20200310
i386                 randconfig-g003-20200310
x86_64               randconfig-g001-20200309
x86_64               randconfig-g002-20200309
x86_64               randconfig-g003-20200309
i386                 randconfig-g001-20200309
i386                 randconfig-g002-20200309
i386                 randconfig-g003-20200309
x86_64               randconfig-h001-20200310
x86_64               randconfig-h002-20200310
x86_64               randconfig-h003-20200310
i386                 randconfig-h001-20200310
i386                 randconfig-h002-20200310
i386                 randconfig-h003-20200310
arc                  randconfig-a001-20200310
arm                  randconfig-a001-20200310
arm64                randconfig-a001-20200310
ia64                 randconfig-a001-20200310
powerpc              randconfig-a001-20200310
sparc                randconfig-a001-20200310
riscv                            allmodconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
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
