Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57EC6190A2A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2020 11:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgCXKEs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Mar 2020 06:04:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:35428 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgCXKEs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Mar 2020 06:04:48 -0400
IronPort-SDR: +jHxOGEQHUURCivJG7/SfrUg8l0+R8wovdYfQpq9616+ObrJ6B4JTLrQ9JdmSRx4uS8XAFOPXk
 wjy8l7dmUtqQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 03:04:45 -0700
IronPort-SDR: H9Pwo7ZnR4SXMPNxJPGQXl1chXvz17/O0ZfZmHtQXecj7zKhnqRHNjT2836+dyMDPD00qZgfDJ
 SS0WHiJlsDlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,300,1580803200"; 
   d="scan'208";a="235537284"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Mar 2020 03:04:44 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jGgQN-0007Bc-EP; Tue, 24 Mar 2020 18:04:43 +0800
Date:   Tue, 24 Mar 2020 18:03:56 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 9a293d1e21a6461a11b4217b155bf445e57f4131
Message-ID: <5e79db0c.LvAQlo0mlfVgbPfg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-rc
branch HEAD: 9a293d1e21a6461a11b4217b155bf445e57f4131  IB/hfi1: Ensure pq is not left on waitlist

elapsed time: 486m

configs tested: 155
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
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
h8300                     edosk2674_defconfig
sh                                allnoconfig
c6x                        evmc6678_defconfig
ia64                                defconfig
powerpc                             defconfig
sparc64                             defconfig
i386                             alldefconfig
microblaze                    nommu_defconfig
um                           x86_64_defconfig
alpha                               defconfig
arc                                 defconfig
s390                             allyesconfig
s390                       zfcpdump_defconfig
csky                                defconfig
i386                             allyesconfig
i386                                defconfig
i386                              allnoconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nds32                               defconfig
nds32                             allnoconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
microblaze                      mmu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200324
x86_64               randconfig-a002-20200324
x86_64               randconfig-a003-20200324
i386                 randconfig-a001-20200324
i386                 randconfig-a002-20200324
i386                 randconfig-a003-20200324
mips                 randconfig-a001-20200324
nds32                randconfig-a001-20200324
m68k                 randconfig-a001-20200324
parisc               randconfig-a001-20200324
alpha                randconfig-a001-20200324
riscv                randconfig-a001-20200324
c6x                  randconfig-a001-20200324
h8300                randconfig-a001-20200324
microblaze           randconfig-a001-20200324
nios2                randconfig-a001-20200324
sparc64              randconfig-a001-20200324
csky                 randconfig-a001-20200324
openrisc             randconfig-a001-20200324
s390                 randconfig-a001-20200324
xtensa               randconfig-a001-20200324
sh                   randconfig-a001-20200324
x86_64               randconfig-c003-20200324
i386                 randconfig-c002-20200324
x86_64               randconfig-c001-20200324
x86_64               randconfig-c002-20200324
i386                 randconfig-c003-20200324
i386                 randconfig-c001-20200324
i386                 randconfig-d003-20200324
i386                 randconfig-d001-20200324
x86_64               randconfig-d002-20200324
x86_64               randconfig-d001-20200324
i386                 randconfig-d002-20200324
x86_64               randconfig-d003-20200324
x86_64               randconfig-e001-20200324
i386                 randconfig-e002-20200324
i386                 randconfig-e003-20200324
x86_64               randconfig-e002-20200324
i386                 randconfig-e001-20200324
x86_64               randconfig-f001-20200324
x86_64               randconfig-f002-20200324
x86_64               randconfig-f003-20200324
i386                 randconfig-f001-20200324
i386                 randconfig-f002-20200324
i386                 randconfig-f003-20200324
x86_64               randconfig-g001-20200324
x86_64               randconfig-g002-20200324
x86_64               randconfig-g003-20200324
i386                 randconfig-g001-20200324
i386                 randconfig-g002-20200324
i386                 randconfig-g003-20200324
x86_64               randconfig-h002-20200324
x86_64               randconfig-h003-20200324
i386                 randconfig-h003-20200324
i386                 randconfig-h001-20200324
x86_64               randconfig-h001-20200324
i386                 randconfig-h002-20200324
arm                  randconfig-a001-20200324
powerpc              randconfig-a001-20200324
arm64                randconfig-a001-20200324
ia64                 randconfig-a001-20200324
arc                  randconfig-a001-20200324
sparc                randconfig-a001-20200324
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                          debug_defconfig
s390                                defconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
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
