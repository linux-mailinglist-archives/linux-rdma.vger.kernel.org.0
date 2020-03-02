Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0AFA176565
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 21:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgCBUyn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 15:54:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:5849 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgCBUyn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Mar 2020 15:54:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 12:54:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,508,1574150400"; 
   d="scan'208";a="386377278"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 02 Mar 2020 12:54:40 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j8s5I-0006kQ-5z; Tue, 03 Mar 2020 04:54:40 +0800
Date:   Tue, 03 Mar 2020 04:54:27 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 817a68a6584aa08e323c64283fec5ded7be84759
Message-ID: <5e5d7283.QWxBqwxTy9QRt4eX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-rc
branch HEAD: 817a68a6584aa08e323c64283fec5ded7be84759  IB/hfi1, qib: Ensure RCU is locked when accessing list

elapsed time: 176m

configs tested: 140
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
ia64                                defconfig
xtensa                          iss_defconfig
s390                             alldefconfig
powerpc                           allnoconfig
m68k                          multi_defconfig
nios2                         3c120_defconfig
mips                             allyesconfig
riscv                          rv32_defconfig
powerpc                             defconfig
i386                              allnoconfig
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
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
alpha                randconfig-a001-20200302
m68k                 randconfig-a001-20200302
mips                 randconfig-a001-20200302
nds32                randconfig-a001-20200302
parisc               randconfig-a001-20200302
riscv                randconfig-a001-20200302
c6x                  randconfig-a001-20200302
h8300                randconfig-a001-20200302
microblaze           randconfig-a001-20200302
nios2                randconfig-a001-20200302
sparc64              randconfig-a001-20200302
csky                 randconfig-a001-20200302
openrisc             randconfig-a001-20200302
s390                 randconfig-a001-20200302
sh                   randconfig-a001-20200302
xtensa               randconfig-a001-20200302
x86_64               randconfig-c001-20200302
x86_64               randconfig-c002-20200302
x86_64               randconfig-c003-20200302
i386                 randconfig-c001-20200302
i386                 randconfig-c002-20200302
i386                 randconfig-c003-20200302
x86_64               randconfig-d001-20200302
x86_64               randconfig-d002-20200302
x86_64               randconfig-d003-20200302
i386                 randconfig-d001-20200302
i386                 randconfig-d002-20200302
i386                 randconfig-d003-20200302
x86_64               randconfig-e001-20200302
x86_64               randconfig-e002-20200302
x86_64               randconfig-e003-20200302
i386                 randconfig-e001-20200302
i386                 randconfig-e002-20200302
i386                 randconfig-e003-20200302
x86_64               randconfig-g001-20200302
x86_64               randconfig-g002-20200302
x86_64               randconfig-g003-20200302
i386                 randconfig-g001-20200302
i386                 randconfig-g002-20200302
i386                 randconfig-g003-20200302
x86_64               randconfig-h001-20200302
x86_64               randconfig-h002-20200302
x86_64               randconfig-h003-20200302
i386                 randconfig-h001-20200302
i386                 randconfig-h002-20200302
i386                 randconfig-h003-20200302
arc                  randconfig-a001-20200302
arm                  randconfig-a001-20200302
arm64                randconfig-a001-20200302
ia64                 randconfig-a001-20200302
powerpc              randconfig-a001-20200302
sparc                randconfig-a001-20200302
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                            allyesconfig
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
