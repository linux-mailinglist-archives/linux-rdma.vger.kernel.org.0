Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A109113B8B9
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 05:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgAOEvI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jan 2020 23:51:08 -0500
Received: from mga05.intel.com ([192.55.52.43]:64913 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728880AbgAOEvI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Jan 2020 23:51:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 20:51:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,321,1574150400"; 
   d="scan'208";a="424896529"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jan 2020 20:51:06 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1irae2-000GhV-Eh; Wed, 15 Jan 2020 12:51:06 +0800
Date:   Wed, 15 Jan 2020 12:50:54 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD INCOMPLETE
 3f59b6c3e600f9665dcf5b8e566cd7b778f03045
Message-ID: <5e1e9a2e.w2ZURwYiz0Mnzc6I%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 3f59b6c3e600f9665dcf5b8e566cd7b778f03045  IB/mlx5: Add mmap support for VAR

TIMEOUT after 2887m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 31

arm                               allnoconfig
arm                              allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig

configs tested: 132
configs skipped: 1

riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64               randconfig-c002-20200112
i386                 randconfig-c003-20200112
i386                 randconfig-c001-20200112
i386                 randconfig-c002-20200112
x86_64               randconfig-c001-20200112
x86_64               randconfig-c003-20200112
arm                              allmodconfig
arm64                            allmodconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
x86_64               randconfig-h001-20200115
x86_64               randconfig-h002-20200115
x86_64               randconfig-h003-20200115
i386                 randconfig-h001-20200115
i386                 randconfig-h002-20200115
i386                 randconfig-h003-20200115
sparc64              randconfig-a001-20200112
microblaze           randconfig-a001-20200112
nios2                randconfig-a001-20200112
c6x                  randconfig-a001-20200112
h8300                randconfig-a001-20200112
arc                  randconfig-a001-20200114
arm                  randconfig-a001-20200114
arm64                randconfig-a001-20200114
ia64                 randconfig-a001-20200114
powerpc              randconfig-a001-20200114
sparc                randconfig-a001-20200114
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                 randconfig-h001-20200114
i386                 randconfig-h002-20200114
i386                 randconfig-h003-20200114
csky                 randconfig-a001-20200114
openrisc             randconfig-a001-20200114
s390                 randconfig-a001-20200114
sh                   randconfig-a001-20200114
xtensa               randconfig-a001-20200114
c6x                  randconfig-a001-20200114
h8300                randconfig-a001-20200114
microblaze           randconfig-a001-20200114
nios2                randconfig-a001-20200114
sparc64              randconfig-a001-20200114
x86_64               randconfig-d001-20200112
x86_64               randconfig-d002-20200112
x86_64               randconfig-d003-20200112
i386                 randconfig-d001-20200112
i386                 randconfig-d002-20200112
i386                 randconfig-d003-20200112
x86_64               randconfig-a001-20200112
x86_64               randconfig-a002-20200112
x86_64               randconfig-a003-20200112
i386                 randconfig-a001-20200112
i386                 randconfig-a002-20200112
i386                 randconfig-a003-20200112
x86_64               randconfig-f001-20200114
x86_64               randconfig-f002-20200114
x86_64               randconfig-f003-20200114
i386                 randconfig-f001-20200114
i386                 randconfig-f002-20200114
i386                 randconfig-f003-20200114
csky                 randconfig-a001-20200112
openrisc             randconfig-a001-20200112
s390                 randconfig-a001-20200112
sh                   randconfig-a001-20200112
xtensa               randconfig-a001-20200112
x86_64               randconfig-b002-20200114
i386                 randconfig-b001-20200114
i386                 randconfig-b002-20200114
i386                 randconfig-b003-20200114
mips                 randconfig-a001-20200112
riscv                randconfig-a001-20200112
parisc               randconfig-a001-20200112
alpha                randconfig-a001-20200112
m68k                 randconfig-a001-20200112
nds32                randconfig-a001-20200112

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
