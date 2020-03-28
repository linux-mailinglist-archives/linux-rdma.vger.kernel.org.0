Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 947B61963DD
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2020 06:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgC1Fol (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Mar 2020 01:44:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:13581 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgC1Fol (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 28 Mar 2020 01:44:41 -0400
IronPort-SDR: LQFMWcAGyvTNLRK6KqTvud2sE7P9ObQUXcPqsqQUpzUER+WBQv+rH5CsmFa3+xPY93tLqwklNv
 4x7XQgZr5qDw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 22:44:40 -0700
IronPort-SDR: DBj+7gkzF/x76nwJj9+gGpxFOqBIuv9M2cntWjzyiZRIkg5AadUYY3FIBzJsQXece3hV9eU3RV
 TBpYo1jGnxHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,315,1580803200"; 
   d="scan'208";a="283060975"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 27 Mar 2020 22:44:39 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jI4Gs-0004Ky-Qf; Sat, 28 Mar 2020 13:44:38 +0800
Date:   Sat, 28 Mar 2020 13:43:44 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 dbdf8909d03d8ab23dc7a6d6edce0791d6a9055c
Message-ID: <5e7ee410.5XUutq7Jf1ZEkdI3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: dbdf8909d03d8ab23dc7a6d6edce0791d6a9055c  Merge branch 'mlx5_tx_steering' into rdma.git for-next

elapsed time: 482m

configs tested: 164
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
mips                              allnoconfig
nds32                               defconfig
sh                          rsk7269_defconfig
s390                       zfcpdump_defconfig
sparc64                          allyesconfig
sh                            titan_defconfig
um                           x86_64_defconfig
powerpc                       ppc64_defconfig
ia64                             allyesconfig
ia64                             allmodconfig
sparc                               defconfig
s390                              allnoconfig
sh                  sh7785lcr_32bit_defconfig
m68k                       m5475evb_defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                                defconfig
i386                             allyesconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
mips                      fuloong2e_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                             allyesconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200327
x86_64               randconfig-a002-20200327
x86_64               randconfig-a003-20200327
i386                 randconfig-a001-20200327
i386                 randconfig-a002-20200327
i386                 randconfig-a003-20200327
alpha                randconfig-a001-20200327
m68k                 randconfig-a001-20200327
mips                 randconfig-a001-20200327
nds32                randconfig-a001-20200327
parisc               randconfig-a001-20200327
riscv                randconfig-a001-20200327
c6x                  randconfig-a001-20200327
h8300                randconfig-a001-20200327
microblaze           randconfig-a001-20200327
nios2                randconfig-a001-20200327
sparc64              randconfig-a001-20200327
csky                 randconfig-a001-20200327
openrisc             randconfig-a001-20200327
s390                 randconfig-a001-20200327
sh                   randconfig-a001-20200327
xtensa               randconfig-a001-20200327
x86_64               randconfig-b001-20200327
x86_64               randconfig-b002-20200327
x86_64               randconfig-b003-20200327
i386                 randconfig-b001-20200327
i386                 randconfig-b002-20200327
i386                 randconfig-b003-20200327
x86_64               randconfig-c001-20200327
x86_64               randconfig-c002-20200327
x86_64               randconfig-c003-20200327
i386                 randconfig-c001-20200327
i386                 randconfig-c002-20200327
i386                 randconfig-c003-20200327
x86_64               randconfig-d001-20200327
x86_64               randconfig-d002-20200327
x86_64               randconfig-d003-20200327
i386                 randconfig-d001-20200327
i386                 randconfig-d002-20200327
i386                 randconfig-d003-20200327
x86_64               randconfig-e001-20200327
x86_64               randconfig-e002-20200327
x86_64               randconfig-e003-20200327
i386                 randconfig-e001-20200327
i386                 randconfig-e002-20200327
i386                 randconfig-e003-20200327
x86_64               randconfig-f001-20200327
x86_64               randconfig-f002-20200327
x86_64               randconfig-f003-20200327
i386                 randconfig-f001-20200327
i386                 randconfig-f002-20200327
i386                 randconfig-f003-20200327
x86_64               randconfig-g001-20200327
x86_64               randconfig-g002-20200327
x86_64               randconfig-g003-20200327
i386                 randconfig-g001-20200327
i386                 randconfig-g002-20200327
i386                 randconfig-g003-20200327
x86_64               randconfig-h001-20200327
x86_64               randconfig-h002-20200327
x86_64               randconfig-h003-20200327
i386                 randconfig-h001-20200327
i386                 randconfig-h002-20200327
i386                 randconfig-h003-20200327
arm                  randconfig-a001-20200327
arm64                randconfig-a001-20200327
ia64                 randconfig-a001-20200327
powerpc              randconfig-a001-20200327
sparc                randconfig-a001-20200327
arc                  randconfig-a001-20200327
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                             alldefconfig
s390                             allmodconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
sh                               allmodconfig
sh                                allnoconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
um                                  defconfig
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
