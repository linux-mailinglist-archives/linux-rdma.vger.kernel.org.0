Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56CA1B8A8A
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2020 02:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgDZA5Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Apr 2020 20:57:16 -0400
Received: from mga05.intel.com ([192.55.52.43]:20919 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgDZA5P (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 25 Apr 2020 20:57:15 -0400
IronPort-SDR: JRc6QHHHcN+qgc+EAt5H/ZwHvEh5zdtWZWOgUd9dfjIQF7S8zIsZDGPXYNo/imhQ4zjFvQv0IG
 vlhbcMflCKrA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2020 17:57:08 -0700
IronPort-SDR: xfZVeEgcUTJYI8fweEUgwNS6r30Ow/v6ZvWSiUofykjFfJtUUGdmlvklkDzQjLAqEASz4KUoT4
 t3mKocmflZ1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,318,1583222400"; 
   d="scan'208";a="431262091"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Apr 2020 17:57:06 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jSVbW-000I50-AZ; Sun, 26 Apr 2020 08:57:06 +0800
Date:   Sun, 26 Apr 2020 08:56:42 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 f0abc761bbb9418876cc4d1ebc473e4ea6352e42
Message-ID: <5ea4dc4a.4TXbOrdGDkViDmDa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-rc
branch HEAD: f0abc761bbb9418876cc4d1ebc473e4ea6352e42  RDMA/core: Fix race between destroy and release FD object

elapsed time: 1696m

configs tested: 249
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                              allmodconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
s390                             alldefconfig
ia64                                defconfig
mips                          ath79_defconfig
openrisc                    or1ksim_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                              allnoconfig
ia64                        generic_defconfig
ia64                          tiger_defconfig
ia64                         bigsur_defconfig
ia64                             allyesconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
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
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                            ar7_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
mips                malta_kvm_guest_defconfig
mips                         tb0287_defconfig
mips                       capcella_defconfig
mips                           ip32_defconfig
mips                  decstation_64_defconfig
mips                      loongson3_defconfig
mips                        bcm63xx_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
parisc                           allmodconfig
parisc               randconfig-a001-20200424
alpha                randconfig-a001-20200424
m68k                 randconfig-a001-20200424
riscv                randconfig-a001-20200424
nds32                randconfig-a001-20200424
parisc               randconfig-a001-20200426
mips                 randconfig-a001-20200426
alpha                randconfig-a001-20200426
m68k                 randconfig-a001-20200426
nds32                randconfig-a001-20200426
nios2                randconfig-a001-20200424
c6x                  randconfig-a001-20200424
h8300                randconfig-a001-20200424
sparc64              randconfig-a001-20200424
microblaze           randconfig-a001-20200424
nios2                randconfig-a001-20200425
c6x                  randconfig-a001-20200425
h8300                randconfig-a001-20200425
sparc64              randconfig-a001-20200425
microblaze           randconfig-a001-20200425
sh                   randconfig-a001-20200424
csky                 randconfig-a001-20200424
s390                 randconfig-a001-20200424
xtensa               randconfig-a001-20200424
openrisc             randconfig-a001-20200424
sh                   randconfig-a001-20200425
csky                 randconfig-a001-20200425
s390                 randconfig-a001-20200425
xtensa               randconfig-a001-20200425
openrisc             randconfig-a001-20200425
i386                 randconfig-b002-20200426
x86_64               randconfig-b001-20200426
i386                 randconfig-b001-20200426
i386                 randconfig-b003-20200426
x86_64               randconfig-b003-20200426
i386                 randconfig-b002-20200425
x86_64               randconfig-b001-20200425
i386                 randconfig-b001-20200425
i386                 randconfig-b003-20200425
x86_64               randconfig-b002-20200425
x86_64               randconfig-b003-20200425
i386                 randconfig-c002-20200425
i386                 randconfig-c001-20200425
x86_64               randconfig-c002-20200425
x86_64               randconfig-c001-20200425
i386                 randconfig-c003-20200425
x86_64               randconfig-c003-20200425
i386                 randconfig-c002-20200424
i386                 randconfig-c001-20200424
x86_64               randconfig-c001-20200424
i386                 randconfig-c003-20200424
x86_64               randconfig-c003-20200424
x86_64               randconfig-d001-20200424
i386                 randconfig-d002-20200424
i386                 randconfig-d001-20200424
x86_64               randconfig-d003-20200424
i386                 randconfig-d003-20200424
x86_64               randconfig-d002-20200426
i386                 randconfig-d002-20200426
i386                 randconfig-d001-20200426
i386                 randconfig-d003-20200426
x86_64               randconfig-a001-20200426
i386                 randconfig-a003-20200426
x86_64               randconfig-a003-20200426
i386                 randconfig-a002-20200426
i386                 randconfig-a001-20200426
x86_64               randconfig-a002-20200426
i386                 randconfig-e003-20200425
x86_64               randconfig-e002-20200425
x86_64               randconfig-e003-20200425
i386                 randconfig-e002-20200425
i386                 randconfig-e001-20200425
x86_64               randconfig-e001-20200425
i386                 randconfig-e003-20200426
x86_64               randconfig-e003-20200426
i386                 randconfig-e002-20200426
i386                 randconfig-e001-20200426
x86_64               randconfig-e001-20200426
i386                 randconfig-f002-20200425
i386                 randconfig-f003-20200425
x86_64               randconfig-f003-20200425
i386                 randconfig-f001-20200425
x86_64               randconfig-f001-20200425
x86_64               randconfig-f002-20200426
i386                 randconfig-f002-20200426
x86_64               randconfig-f003-20200426
i386                 randconfig-f003-20200426
i386                 randconfig-f001-20200426
x86_64               randconfig-f001-20200426
x86_64               randconfig-f002-20200424
i386                 randconfig-f002-20200424
i386                 randconfig-f003-20200424
x86_64               randconfig-f003-20200424
i386                 randconfig-f001-20200424
x86_64               randconfig-f001-20200424
i386                 randconfig-g003-20200424
i386                 randconfig-g001-20200424
x86_64               randconfig-g001-20200424
x86_64               randconfig-g002-20200424
i386                 randconfig-g002-20200424
x86_64               randconfig-g003-20200424
i386                 randconfig-g003-20200426
i386                 randconfig-g001-20200426
x86_64               randconfig-g001-20200426
x86_64               randconfig-g002-20200426
i386                 randconfig-g002-20200426
x86_64               randconfig-g003-20200426
x86_64               randconfig-a001-20200424
i386                 randconfig-a003-20200424
x86_64               randconfig-a003-20200424
i386                 randconfig-a002-20200424
i386                 randconfig-a001-20200424
x86_64               randconfig-a002-20200424
i386                 randconfig-h003-20200425
x86_64               randconfig-h001-20200425
x86_64               randconfig-h003-20200425
i386                 randconfig-h002-20200425
i386                 randconfig-h001-20200425
i386                 randconfig-h003-20200424
x86_64               randconfig-h001-20200424
x86_64               randconfig-h003-20200424
x86_64               randconfig-h002-20200424
i386                 randconfig-h001-20200424
i386                 randconfig-h002-20200424
i386                 randconfig-h003-20200426
x86_64               randconfig-h001-20200426
x86_64               randconfig-h003-20200426
x86_64               randconfig-h002-20200426
i386                 randconfig-h001-20200426
i386                 randconfig-h002-20200426
sparc                randconfig-a001-20200425
ia64                 randconfig-a001-20200425
powerpc              randconfig-a001-20200425
arm                  randconfig-a001-20200425
arc                  randconfig-a001-20200425
sparc                randconfig-a001-20200424
ia64                 randconfig-a001-20200424
powerpc              randconfig-a001-20200424
arm64                randconfig-a001-20200424
arc                  randconfig-a001-20200424
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec
x86_64                         rhel-7.2-clear
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
