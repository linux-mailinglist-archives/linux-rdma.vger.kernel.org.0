Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D38718B25A
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 12:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgCSLc4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 07:32:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:9534 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgCSLc4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 07:32:56 -0400
IronPort-SDR: qdBSGNG0EKKPNKi5A9m3MAhvN94kNY4NVHjbCGyoZCGVnLdfZsjijd+7F+KyuRakTzRP7ZzPad
 vra182bRy6Fw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 04:32:55 -0700
IronPort-SDR: +w+IlDz29+MaW+ctXRgcQX1PvDoMPIBWJ09Nhst4cw80MhtoNETzlX0524nG5af8QmgWPeTUMA
 T3CXT7tM9dXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,571,1574150400"; 
   d="scan'208";a="245134276"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Mar 2020 04:32:53 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jEtPw-0000xZ-Ny; Thu, 19 Mar 2020 19:32:52 +0800
Date:   Thu, 19 Mar 2020 19:32:33 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:hmm] BUILD SUCCESS ede58c05bec9e5ccf659cf001bb969963806bed0
Message-ID: <5e735851.N71OP4obae83HkDZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  hmm
branch HEAD: ede58c05bec9e5ccf659cf001bb969963806bed0  mm: merge hmm_vma_do_fault into into hmm_vma_walk_hole_

elapsed time: 485m

configs tested: 164
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
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
openrisc                    or1ksim_defconfig
s390                              allnoconfig
mips                      malta_kvm_defconfig
riscv                    nommu_virt_defconfig
ia64                                defconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
mips                      fuloong2e_defconfig
nios2                         3c120_defconfig
m68k                           sun3_defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
xtensa                          iss_defconfig
xtensa                       common_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
openrisc                 simple_smp_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                          multi_defconfig
arc                                 defconfig
arc                              allyesconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200319
x86_64               randconfig-a002-20200319
x86_64               randconfig-a003-20200319
i386                 randconfig-a001-20200319
i386                 randconfig-a002-20200319
i386                 randconfig-a003-20200319
riscv                randconfig-a001-20200319
m68k                 randconfig-a001-20200319
nds32                randconfig-a001-20200319
alpha                randconfig-a001-20200319
parisc               randconfig-a001-20200319
mips                 randconfig-a001-20200319
c6x                  randconfig-a001-20200319
h8300                randconfig-a001-20200319
microblaze           randconfig-a001-20200319
nios2                randconfig-a001-20200319
sparc64              randconfig-a001-20200319
csky                 randconfig-a001-20200319
openrisc             randconfig-a001-20200319
s390                 randconfig-a001-20200319
sh                   randconfig-a001-20200319
xtensa               randconfig-a001-20200319
x86_64               randconfig-b001-20200319
x86_64               randconfig-b002-20200319
x86_64               randconfig-b003-20200319
i386                 randconfig-b001-20200319
i386                 randconfig-b002-20200319
i386                 randconfig-b003-20200319
x86_64               randconfig-c001-20200319
x86_64               randconfig-c002-20200319
x86_64               randconfig-c003-20200319
i386                 randconfig-c001-20200319
i386                 randconfig-c002-20200319
i386                 randconfig-c003-20200319
x86_64               randconfig-d001-20200319
x86_64               randconfig-d002-20200319
x86_64               randconfig-d003-20200319
i386                 randconfig-d001-20200319
i386                 randconfig-d002-20200319
i386                 randconfig-d003-20200319
x86_64               randconfig-e001-20200319
x86_64               randconfig-e002-20200319
x86_64               randconfig-e003-20200319
i386                 randconfig-e001-20200319
i386                 randconfig-e002-20200319
i386                 randconfig-e003-20200319
x86_64               randconfig-f001-20200319
x86_64               randconfig-f002-20200319
x86_64               randconfig-f003-20200319
i386                 randconfig-f001-20200319
i386                 randconfig-f002-20200319
i386                 randconfig-f003-20200319
x86_64               randconfig-g001-20200319
x86_64               randconfig-g002-20200319
x86_64               randconfig-g003-20200319
i386                 randconfig-g001-20200319
i386                 randconfig-g002-20200319
i386                 randconfig-g003-20200319
x86_64               randconfig-h001-20200319
x86_64               randconfig-h002-20200319
x86_64               randconfig-h003-20200319
i386                 randconfig-h001-20200319
i386                 randconfig-h002-20200319
i386                 randconfig-h003-20200319
arc                  randconfig-a001-20200319
arm                  randconfig-a001-20200319
arm64                randconfig-a001-20200319
ia64                 randconfig-a001-20200319
powerpc              randconfig-a001-20200319
sparc                randconfig-a001-20200319
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                  defconfig
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
