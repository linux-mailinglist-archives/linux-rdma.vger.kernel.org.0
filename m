Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13550197222
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2020 03:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgC3Bmj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Mar 2020 21:42:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:5443 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbgC3Bmi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 29 Mar 2020 21:42:38 -0400
IronPort-SDR: b+1ifUVxkFP0/M/n/6NeTkJftz9kSV8/1V15B1NnYACzjcS26i2fafU41zEPUVHRnupcoHYAQq
 cTq1vZNxk8bg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 18:42:37 -0700
IronPort-SDR: nWWgIjzqVBKYOH0nrf4nW+KCIWjN7ScADgQCNp6qbMZWFlkBsamLBTh4EmrDp+JOH+Ew6E2Jve
 d4LmXskkSFYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,322,1580803200"; 
   d="scan'208";a="248470700"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Mar 2020 18:42:36 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jIjRj-0000CF-O4; Mon, 30 Mar 2020 09:42:35 +0800
Date:   Mon, 30 Mar 2020 09:41:37 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 3e87f4313035c86999281336582ff554e9a17bef
Message-ID: <5e814e51.dWSZguc6I6fdjSN3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 3e87f4313035c86999281336582ff554e9a17bef  IB/qib: Delete struct qib_ivdev.qp_rnd

elapsed time: 483m

configs tested: 160
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
sparc64                           allnoconfig
sparc64                          allyesconfig
nios2                         3c120_defconfig
i386                                defconfig
xtensa                          iss_defconfig
openrisc                    or1ksim_defconfig
arc                                 defconfig
riscv                          rv32_defconfig
riscv                               defconfig
sparc64                          allmodconfig
microblaze                      mmu_defconfig
um                             i386_defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
ia64                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
arc                              allyesconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
i386                 randconfig-a002-20200329
x86_64               randconfig-a001-20200329
i386                 randconfig-a001-20200329
i386                 randconfig-a003-20200329
nds32                randconfig-a001-20200329
mips                 randconfig-a001-20200329
parisc               randconfig-a001-20200329
m68k                 randconfig-a001-20200329
alpha                randconfig-a001-20200329
riscv                randconfig-a001-20200329
h8300                randconfig-a001-20200329
nios2                randconfig-a001-20200329
microblaze           randconfig-a001-20200329
sparc64              randconfig-a001-20200329
c6x                  randconfig-a001-20200329
csky                 randconfig-a001-20200329
openrisc             randconfig-a001-20200329
s390                 randconfig-a001-20200329
sh                   randconfig-a001-20200329
xtensa               randconfig-a001-20200329
i386                 randconfig-b003-20200329
x86_64               randconfig-b003-20200329
i386                 randconfig-b001-20200329
i386                 randconfig-b002-20200329
x86_64               randconfig-b002-20200329
x86_64               randconfig-b001-20200329
x86_64               randconfig-c001-20200329
x86_64               randconfig-c002-20200329
x86_64               randconfig-c003-20200329
i386                 randconfig-c001-20200329
i386                 randconfig-c002-20200329
i386                 randconfig-c003-20200329
x86_64               randconfig-d001-20200329
x86_64               randconfig-d002-20200329
x86_64               randconfig-d003-20200329
i386                 randconfig-d001-20200329
i386                 randconfig-d002-20200329
i386                 randconfig-d003-20200329
x86_64               randconfig-e001-20200329
x86_64               randconfig-e002-20200329
x86_64               randconfig-e003-20200329
i386                 randconfig-e001-20200329
i386                 randconfig-e002-20200329
i386                 randconfig-e003-20200329
i386                 randconfig-f001-20200329
i386                 randconfig-f003-20200329
i386                 randconfig-f002-20200329
x86_64               randconfig-f002-20200329
x86_64               randconfig-f001-20200329
i386                 randconfig-g003-20200329
x86_64               randconfig-g002-20200329
i386                 randconfig-g002-20200329
i386                 randconfig-g001-20200329
x86_64               randconfig-g001-20200329
x86_64               randconfig-h001-20200329
x86_64               randconfig-h002-20200329
x86_64               randconfig-h003-20200329
i386                 randconfig-h001-20200329
i386                 randconfig-h002-20200329
i386                 randconfig-h003-20200329
arm                  randconfig-a001-20200329
arm64                randconfig-a001-20200329
ia64                 randconfig-a001-20200329
sparc                randconfig-a001-20200329
arc                  randconfig-a001-20200329
powerpc              randconfig-a001-20200329
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
s390                             alldefconfig
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
sparc                               defconfig
sparc64                             defconfig
um                           x86_64_defconfig
um                                  defconfig
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
