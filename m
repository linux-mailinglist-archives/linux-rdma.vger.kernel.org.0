Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D07F616F04F
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2020 21:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgBYUmC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Feb 2020 15:42:02 -0500
Received: from mga12.intel.com ([192.55.52.136]:3742 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729183AbgBYUmC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Feb 2020 15:42:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 12:42:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,485,1574150400"; 
   d="scan'208";a="230240679"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 25 Feb 2020 12:41:59 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j6h1j-000A5C-5T; Wed, 26 Feb 2020 04:41:59 +0800
Date:   Wed, 26 Feb 2020 04:41:22 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 6ccad8483b28666bdafbb52fe94e64f41e7836be
Message-ID: <5e558672.VCOwUyUj3jyTWq8s%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 6ccad8483b28666bdafbb52fe94e64f41e7836be  RDMA/bnxt_re: use ibdev based message printing functions

elapsed time: 5376m

configs tested: 271
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm64                               defconfig
arm                           sunxi_defconfig
sparc                            allyesconfig
ia64                             alldefconfig
arc                              allyesconfig
sparc64                           allnoconfig
ia64                             allyesconfig
um                             i386_defconfig
microblaze                    nommu_defconfig
xtensa                          iss_defconfig
mips                      fuloong2e_defconfig
s390                       zfcpdump_defconfig
sparc                               defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                              allnoconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
arc                                 defconfig
microblaze                      mmu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200223
x86_64               randconfig-a002-20200223
x86_64               randconfig-a003-20200223
i386                 randconfig-a001-20200223
i386                 randconfig-a002-20200223
i386                 randconfig-a003-20200223
x86_64               randconfig-a001-20200225
x86_64               randconfig-a002-20200225
x86_64               randconfig-a003-20200225
i386                 randconfig-a001-20200225
i386                 randconfig-a002-20200225
i386                 randconfig-a003-20200225
x86_64               randconfig-a001-20200222
x86_64               randconfig-a002-20200222
x86_64               randconfig-a003-20200222
i386                 randconfig-a001-20200222
i386                 randconfig-a002-20200222
i386                 randconfig-a003-20200222
alpha                randconfig-a001-20200225
m68k                 randconfig-a001-20200225
mips                 randconfig-a001-20200225
nds32                randconfig-a001-20200225
parisc               randconfig-a001-20200225
riscv                randconfig-a001-20200225
csky                 randconfig-a001-20200226
openrisc             randconfig-a001-20200226
s390                 randconfig-a001-20200226
sh                   randconfig-a001-20200226
xtensa               randconfig-a001-20200226
openrisc             randconfig-a001-20200221
csky                 randconfig-a001-20200222
openrisc             randconfig-a001-20200222
s390                 randconfig-a001-20200222
sh                   randconfig-a001-20200222
xtensa               randconfig-a001-20200222
csky                 randconfig-a001-20200223
openrisc             randconfig-a001-20200223
s390                 randconfig-a001-20200223
sh                   randconfig-a001-20200223
xtensa               randconfig-a001-20200223
csky                 randconfig-a001-20200224
openrisc             randconfig-a001-20200224
s390                 randconfig-a001-20200224
sh                   randconfig-a001-20200224
xtensa               randconfig-a001-20200224
csky                 randconfig-a001-20200225
openrisc             randconfig-a001-20200225
s390                 randconfig-a001-20200225
sh                   randconfig-a001-20200225
xtensa               randconfig-a001-20200225
x86_64               randconfig-b001-20200223
x86_64               randconfig-b002-20200223
x86_64               randconfig-b003-20200223
i386                 randconfig-b001-20200223
i386                 randconfig-b002-20200223
i386                 randconfig-b003-20200223
i386                 randconfig-b002-20200225
i386                 randconfig-b003-20200225
x86_64               randconfig-b001-20200222
x86_64               randconfig-b002-20200222
x86_64               randconfig-b003-20200222
i386                 randconfig-b001-20200222
i386                 randconfig-b002-20200222
i386                 randconfig-b003-20200222
x86_64               randconfig-b001-20200225
x86_64               randconfig-b002-20200225
x86_64               randconfig-b003-20200225
i386                 randconfig-b001-20200225
x86_64               randconfig-c001-20200223
x86_64               randconfig-c002-20200223
x86_64               randconfig-c003-20200223
i386                 randconfig-c001-20200223
i386                 randconfig-c002-20200223
i386                 randconfig-c003-20200223
x86_64               randconfig-c001-20200225
x86_64               randconfig-c002-20200225
x86_64               randconfig-c003-20200225
i386                 randconfig-c001-20200225
i386                 randconfig-c002-20200225
i386                 randconfig-c003-20200225
x86_64               randconfig-c001-20200222
x86_64               randconfig-c002-20200222
x86_64               randconfig-c003-20200222
i386                 randconfig-c001-20200222
i386                 randconfig-c002-20200222
i386                 randconfig-c003-20200222
x86_64               randconfig-d001-20200222
x86_64               randconfig-d002-20200222
x86_64               randconfig-d003-20200222
i386                 randconfig-d001-20200222
i386                 randconfig-d002-20200222
i386                 randconfig-d003-20200222
x86_64               randconfig-d001-20200225
x86_64               randconfig-d002-20200225
x86_64               randconfig-d003-20200225
i386                 randconfig-d001-20200225
i386                 randconfig-d002-20200225
i386                 randconfig-d003-20200225
x86_64               randconfig-d001-20200223
x86_64               randconfig-d002-20200223
x86_64               randconfig-d003-20200223
i386                 randconfig-d001-20200223
i386                 randconfig-d002-20200223
i386                 randconfig-d003-20200223
x86_64               randconfig-e001-20200222
x86_64               randconfig-e002-20200222
x86_64               randconfig-e003-20200222
i386                 randconfig-e001-20200222
i386                 randconfig-e002-20200222
i386                 randconfig-e003-20200222
x86_64               randconfig-e001-20200224
x86_64               randconfig-e002-20200224
x86_64               randconfig-e003-20200224
i386                 randconfig-e001-20200224
i386                 randconfig-e002-20200224
i386                 randconfig-e003-20200224
x86_64               randconfig-f001-20200224
x86_64               randconfig-f002-20200224
x86_64               randconfig-f003-20200224
i386                 randconfig-f001-20200224
i386                 randconfig-f002-20200224
i386                 randconfig-f003-20200224
x86_64               randconfig-f003-20200221
x86_64               randconfig-f002-20200221
x86_64               randconfig-f001-20200221
i386                 randconfig-f001-20200221
x86_64               randconfig-f001-20200223
x86_64               randconfig-f002-20200223
x86_64               randconfig-f003-20200223
i386                 randconfig-f001-20200223
i386                 randconfig-f002-20200223
i386                 randconfig-f003-20200223
x86_64               randconfig-f001-20200222
x86_64               randconfig-f002-20200222
x86_64               randconfig-f003-20200222
i386                 randconfig-f001-20200222
i386                 randconfig-f002-20200222
i386                 randconfig-f003-20200222
x86_64               randconfig-g001-20200222
x86_64               randconfig-g002-20200222
x86_64               randconfig-g003-20200222
i386                 randconfig-g001-20200222
i386                 randconfig-g002-20200222
i386                 randconfig-g003-20200222
x86_64               randconfig-g001-20200223
x86_64               randconfig-g002-20200223
x86_64               randconfig-g003-20200223
i386                 randconfig-g001-20200223
i386                 randconfig-g002-20200223
i386                 randconfig-g003-20200223
x86_64               randconfig-g001-20200225
x86_64               randconfig-g002-20200225
x86_64               randconfig-g003-20200225
i386                 randconfig-g001-20200225
i386                 randconfig-g002-20200225
i386                 randconfig-g003-20200225
x86_64               randconfig-h001-20200225
x86_64               randconfig-h002-20200225
x86_64               randconfig-h003-20200225
i386                 randconfig-h001-20200225
i386                 randconfig-h002-20200225
i386                 randconfig-h003-20200225
x86_64               randconfig-h001-20200223
x86_64               randconfig-h002-20200223
x86_64               randconfig-h003-20200223
i386                 randconfig-h001-20200223
i386                 randconfig-h002-20200223
i386                 randconfig-h003-20200223
x86_64               randconfig-h001-20200222
x86_64               randconfig-h002-20200222
x86_64               randconfig-h003-20200222
i386                 randconfig-h001-20200222
i386                 randconfig-h002-20200222
i386                 randconfig-h003-20200222
arc                  randconfig-a001-20200225
arm                  randconfig-a001-20200225
arm64                randconfig-a001-20200225
ia64                 randconfig-a001-20200225
powerpc              randconfig-a001-20200225
sparc                randconfig-a001-20200225
riscv                            allmodconfig
riscv                             allnoconfig
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
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                                  defconfig
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
