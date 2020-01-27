Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE9E14AB1E
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2020 21:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgA0U0H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jan 2020 15:26:07 -0500
Received: from mga09.intel.com ([134.134.136.24]:60512 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgA0U0H (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Jan 2020 15:26:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 12:24:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,371,1574150400"; 
   d="scan'208";a="427419575"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jan 2020 12:24:42 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iwAw5-0000Oi-HO; Tue, 28 Jan 2020 04:24:41 +0800
Date:   Tue, 28 Jan 2020 04:24:16 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 8e2ef394d4a99a2d65a2a5bc09b6cf8d31721ec9
Message-ID: <5e2f46f0.PWjX/w/0YvBvVszE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 8e2ef394d4a99a2d65a2a5bc09b6cf8d31721ec9  IB/mlx4: Fix leak in id_map_find_del

elapsed time: 2881m

configs tested: 165
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

mips                      malta_kvm_defconfig
openrisc                 simple_smp_defconfig
h8300                       h8s-sim_defconfig
um                                  defconfig
nios2                         3c120_defconfig
ia64                                defconfig
powerpc                             defconfig
sparc64                             defconfig
arm64                               defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
x86_64               randconfig-a001-20200126
x86_64               randconfig-a002-20200126
x86_64               randconfig-a003-20200126
i386                 randconfig-a001-20200126
i386                 randconfig-a002-20200126
i386                 randconfig-a003-20200126
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
x86_64               randconfig-c001-20200126
x86_64               randconfig-c002-20200126
x86_64               randconfig-c003-20200126
i386                 randconfig-c001-20200126
i386                 randconfig-c002-20200126
i386                 randconfig-c003-20200126
arm                              allmodconfig
arm64                            allmodconfig
x86_64               randconfig-f001-20200126
x86_64               randconfig-f002-20200126
x86_64               randconfig-f003-20200126
i386                 randconfig-f001-20200126
i386                 randconfig-f002-20200126
i386                 randconfig-f003-20200126
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
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
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
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
arc                  randconfig-a001-20200126
arm                  randconfig-a001-20200126
arm64                randconfig-a001-20200126
ia64                 randconfig-a001-20200126
powerpc              randconfig-a001-20200126
sparc                randconfig-a001-20200126
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64               randconfig-h001-20200126
x86_64               randconfig-h002-20200126
x86_64               randconfig-h003-20200126
i386                 randconfig-h001-20200126
i386                 randconfig-h002-20200126
i386                 randconfig-h003-20200126
alpha                randconfig-a001-20200126
m68k                 randconfig-a001-20200126
mips                 randconfig-a001-20200126
nds32                randconfig-a001-20200126
parisc               randconfig-a001-20200126
riscv                randconfig-a001-20200126
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
csky                 randconfig-a001-20200126
openrisc             randconfig-a001-20200126
s390                 randconfig-a001-20200126
sh                   randconfig-a001-20200126
xtensa               randconfig-a001-20200126
c6x                  randconfig-a001-20200126
h8300                randconfig-a001-20200126
microblaze           randconfig-a001-20200126
nios2                randconfig-a001-20200126
sparc64              randconfig-a001-20200126
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
openrisc                    or1ksim_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
parisc                         b180_defconfig
x86_64               randconfig-g001-20200126
x86_64               randconfig-g002-20200126
x86_64               randconfig-g003-20200126
i386                 randconfig-g001-20200126
i386                 randconfig-g002-20200126
i386                 randconfig-g003-20200126
parisc                            allnoconfig
parisc                            allyesonfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64               randconfig-e001-20200126
x86_64               randconfig-e002-20200126
x86_64               randconfig-e003-20200126
i386                 randconfig-e001-20200126
i386                 randconfig-e002-20200126
i386                 randconfig-e003-20200126
x86_64               randconfig-d001-20200126
x86_64               randconfig-d002-20200126
x86_64               randconfig-d003-20200126
i386                 randconfig-d001-20200126
i386                 randconfig-d002-20200126
i386                 randconfig-d003-20200126
x86_64               randconfig-b001-20200126
x86_64               randconfig-b002-20200126
x86_64               randconfig-b003-20200126
i386                 randconfig-b001-20200126
i386                 randconfig-b002-20200126
i386                 randconfig-b003-20200126

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
