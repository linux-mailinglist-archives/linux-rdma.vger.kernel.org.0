Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EA91C5041
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2020 10:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgEEI2B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 May 2020 04:28:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:64579 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgEEI2B (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 May 2020 04:28:01 -0400
IronPort-SDR: +kMXE/3/UXQFZe6bB2EDg6Lu4ZLUJF4BO4JPKrkSN8GzJZOXWy7pAMRRPAzdIGpMoWhZhl6o/V
 aR2ykhiCOLHQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 01:28:00 -0700
IronPort-SDR: 4kkC6c5dxCnX+GPunTqrLwQgbzzPnloNTxVyd9KhhVYO7tLrK8nbYHNA4yG8y+Lc6eZKEoEjbd
 ZBeGy7gi6PbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="294895555"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 05 May 2020 01:27:59 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jVsvm-000FQB-LB; Tue, 05 May 2020 16:27:58 +0800
Date:   Tue, 05 May 2020 16:27:18 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 221e97d6fb6606100f9b06f7f55a3346be6ee2c0
Message-ID: <5eb12366.pkadtdNn1x1ugaoS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-rc
branch HEAD: 221e97d6fb6606100f9b06f7f55a3346be6ee2c0  IB/i40iw: Remove bogus call to netdev_master_upper_dev_get()

elapsed time: 483m

configs tested: 220
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
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
mips                malta_kvm_guest_defconfig
s390                             alldefconfig
powerpc                      chrp32_defconfig
sh                          rsk7269_defconfig
sparc64                          allmodconfig
nds32                             allnoconfig
riscv                               defconfig
c6x                              allyesconfig
mips                           ip32_defconfig
sh                  sh7785lcr_32bit_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                        generic_defconfig
ia64                          tiger_defconfig
ia64                         bigsur_defconfig
ia64                             allyesconfig
ia64                             alldefconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
m68k                       bvme6000_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
xtensa                          iss_defconfig
h8300                    h8300h-sim_defconfig
xtensa                       common_defconfig
arc                                 defconfig
arc                              allyesconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                            ar7_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
mips                         tb0287_defconfig
mips                       capcella_defconfig
mips                  decstation_64_defconfig
mips                      loongson3_defconfig
mips                          ath79_defconfig
mips                        bcm63xx_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                       holly_defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
powerpc                           allnoconfig
powerpc                  mpc866_ads_defconfig
powerpc                    amigaone_defconfig
powerpc                    adder875_defconfig
powerpc                     ep8248e_defconfig
powerpc                          g5_defconfig
powerpc                     mpc512x_defconfig
m68k                 randconfig-a001-20200505
mips                 randconfig-a001-20200505
nds32                randconfig-a001-20200505
parisc               randconfig-a001-20200505
alpha                randconfig-a001-20200505
riscv                randconfig-a001-20200505
h8300                randconfig-a001-20200503
nios2                randconfig-a001-20200503
microblaze           randconfig-a001-20200503
c6x                  randconfig-a001-20200503
sparc64              randconfig-a001-20200503
xtensa               randconfig-a001-20200503
openrisc             randconfig-a001-20200503
csky                 randconfig-a001-20200503
s390                 randconfig-a001-20200505
xtensa               randconfig-a001-20200505
sh                   randconfig-a001-20200505
openrisc             randconfig-a001-20200505
csky                 randconfig-a001-20200505
x86_64               randconfig-a003-20200505
x86_64               randconfig-a001-20200505
i386                 randconfig-a001-20200505
i386                 randconfig-a003-20200505
i386                 randconfig-a002-20200505
i386                 randconfig-b003-20200503
x86_64               randconfig-b002-20200503
i386                 randconfig-b001-20200503
x86_64               randconfig-b003-20200503
x86_64               randconfig-b001-20200503
i386                 randconfig-b002-20200503
i386                 randconfig-b003-20200505
x86_64               randconfig-b002-20200505
i386                 randconfig-b001-20200505
x86_64               randconfig-b001-20200505
x86_64               randconfig-b003-20200505
i386                 randconfig-b002-20200505
x86_64               randconfig-a002-20200503
i386                 randconfig-a002-20200503
i386                 randconfig-a003-20200503
i386                 randconfig-a001-20200503
x86_64               randconfig-c002-20200502
i386                 randconfig-c002-20200502
i386                 randconfig-c001-20200502
i386                 randconfig-c003-20200502
x86_64               randconfig-c001-20200503
x86_64               randconfig-c002-20200503
i386                 randconfig-c002-20200503
x86_64               randconfig-c003-20200503
i386                 randconfig-c001-20200503
i386                 randconfig-c003-20200503
x86_64               randconfig-d001-20200505
i386                 randconfig-d003-20200505
i386                 randconfig-d001-20200505
x86_64               randconfig-d003-20200505
x86_64               randconfig-d002-20200505
i386                 randconfig-d002-20200505
x86_64               randconfig-d001-20200503
i386                 randconfig-d003-20200503
x86_64               randconfig-d003-20200503
i386                 randconfig-d001-20200503
x86_64               randconfig-d002-20200503
i386                 randconfig-d002-20200503
x86_64               randconfig-e003-20200503
x86_64               randconfig-e002-20200503
i386                 randconfig-e003-20200503
x86_64               randconfig-e001-20200503
i386                 randconfig-e002-20200503
i386                 randconfig-e001-20200503
i386                 randconfig-f003-20200503
x86_64               randconfig-f002-20200503
i386                 randconfig-f001-20200503
i386                 randconfig-f002-20200503
x86_64               randconfig-g003-20200502
i386                 randconfig-g003-20200502
i386                 randconfig-g002-20200502
x86_64               randconfig-g001-20200502
x86_64               randconfig-g002-20200502
i386                 randconfig-g001-20200502
i386                 randconfig-g003-20200505
i386                 randconfig-g002-20200505
i386                 randconfig-g001-20200505
x86_64               randconfig-g002-20200505
i386                 randconfig-h001-20200503
i386                 randconfig-h002-20200503
i386                 randconfig-h003-20200503
x86_64               randconfig-h002-20200503
i386                 randconfig-h002-20200505
i386                 randconfig-h001-20200505
i386                 randconfig-h003-20200505
x86_64               randconfig-h003-20200505
x86_64               randconfig-h001-20200505
ia64                 randconfig-a001-20200505
arc                  randconfig-a001-20200505
powerpc              randconfig-a001-20200505
arm                  randconfig-a001-20200505
sparc                randconfig-a001-20200505
ia64                 randconfig-a001-20200502
arm64                randconfig-a001-20200502
arc                  randconfig-a001-20200502
powerpc              randconfig-a001-20200502
arm                  randconfig-a001-20200502
sparc                randconfig-a001-20200502
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
