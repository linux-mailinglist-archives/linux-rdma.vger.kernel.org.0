Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 116EF1965F3
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2020 13:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgC1MDd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 28 Mar 2020 08:03:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:25432 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgC1MDd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 28 Mar 2020 08:03:33 -0400
IronPort-SDR: +OBsZI0D2QSFvihW6QZErlqSZ2Itdbhpy7HI5R3SWAayfed7mX7y2oiSR/BYZLXMqs9XUyQUp2
 p4HQ0RrNb1fw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 05:03:30 -0700
IronPort-SDR: FGtLMcXTrDALQ0U1e9hmuMSTq0twpRfRoRQY8ySxrtbacVPvZxhxrhen/yQKafYq5lnCWEu50W
 sRvMrfRBKNRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,316,1580803200"; 
   d="scan'208";a="251409348"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Mar 2020 05:03:29 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jIABU-0009IU-D3; Sat, 28 Mar 2020 20:03:28 +0800
Date:   Sat, 28 Mar 2020 20:03:14 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:hmm] BUILD SUCCESS dfe33b0f46951c8d98df238707db191017ea74c4
Message-ID: <5e7f3d02.M2S7kbbf7NTU3/xr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  hmm
branch HEAD: dfe33b0f46951c8d98df238707db191017ea74c4  mm/hmm: return error for non-vma snapshots

elapsed time: 484m

configs tested: 165
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                               allnoconfig
arm64                             allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
um                                  defconfig
mips                      fuloong2e_defconfig
s390                              allnoconfig
sparc64                             defconfig
ia64                                defconfig
nios2                         10m50_defconfig
parisc                generic-64bit_defconfig
microblaze                    nommu_defconfig
ia64                             alldefconfig
microblaze                      mmu_defconfig
parisc                generic-32bit_defconfig
s390                          debug_defconfig
nds32                             allnoconfig
mips                              allnoconfig
riscv                    nommu_virt_defconfig
sparc                               defconfig
sh                  sh7785lcr_32bit_defconfig
nds32                               defconfig
i386                             alldefconfig
openrisc                    or1ksim_defconfig
s390                             alldefconfig
m68k                       m5475evb_defconfig
sparc64                           allnoconfig
i386                              allnoconfig
i386                                defconfig
i386                             allyesconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
nios2                         3c120_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
m68k                             allmodconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
powerpc                           allnoconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200327
x86_64               randconfig-a002-20200327
x86_64               randconfig-a003-20200327
i386                 randconfig-a001-20200327
i386                 randconfig-a002-20200327
i386                 randconfig-a003-20200327
mips                 randconfig-a001-20200327
nds32                randconfig-a001-20200327
m68k                 randconfig-a001-20200327
parisc               randconfig-a001-20200327
alpha                randconfig-a001-20200327
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
i386                 randconfig-b003-20200327
i386                 randconfig-b001-20200327
x86_64               randconfig-b003-20200327
i386                 randconfig-b002-20200327
x86_64               randconfig-b002-20200327
x86_64               randconfig-b001-20200327
x86_64               randconfig-c001-20200327
x86_64               randconfig-c002-20200327
x86_64               randconfig-c003-20200327
i386                 randconfig-c001-20200327
i386                 randconfig-c002-20200327
i386                 randconfig-c003-20200327
i386                 randconfig-d003-20200327
i386                 randconfig-d001-20200327
x86_64               randconfig-d002-20200327
x86_64               randconfig-d001-20200327
i386                 randconfig-d002-20200327
x86_64               randconfig-d003-20200327
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
arm                  randconfig-a001-20200328
arm64                randconfig-a001-20200328
ia64                 randconfig-a001-20200328
arc                  randconfig-a001-20200328
sparc                randconfig-a001-20200328
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
s390                                defconfig
s390                       zfcpdump_defconfig
s390                             allyesconfig
s390                             allmodconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                                allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
