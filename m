Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5889118B259
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 12:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgCSLcx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 07:32:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:10080 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgCSLcx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 07:32:53 -0400
IronPort-SDR: jJCgDuQLDO3hgrQXitF76Mz04zwrfHYW/ghQ/7Nb34aCk4zo6qpbHvj3/wDknaIvIkSb2vF6VX
 47FHda7slU6w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 04:32:52 -0700
IronPort-SDR: WUq4G9JjlHxhk8fcP1C4c0d76UDfCwI0tq/GxdINwP/m3zJzBvHeGQwL5hvn5kZ2jXXjbtxRZm
 TQzccETqIbUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,571,1574150400"; 
   d="scan'208";a="268704245"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Mar 2020 04:32:50 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jEtPu-0000ZD-GC; Thu, 19 Mar 2020 19:32:50 +0800
Date:   Thu, 19 Mar 2020 19:32:39 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 fa8a44f6b245ffa9d39d667ebbf81bebc61ca657
Message-ID: <5e735857.g6cTZTXDjmmxicnn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: fa8a44f6b245ffa9d39d667ebbf81bebc61ca657  RDMA/efa: Use in-kernel offsetofend() to check field availability

elapsed time: 485m

configs tested: 157
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
openrisc                    or1ksim_defconfig
s390                              allnoconfig
mips                      malta_kvm_defconfig
riscv                    nommu_virt_defconfig
ia64                                defconfig
sparc64                             defconfig
arc                              allyesconfig
mips                      fuloong2e_defconfig
nios2                         3c120_defconfig
m68k                           sun3_defconfig
sh                                allnoconfig
c6x                        evmc6678_defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
nios2                         10m50_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
arc                                 defconfig
microblaze                      mmu_defconfig
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
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
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
h8300                randconfig-a001-20200319
sparc64              randconfig-a001-20200319
c6x                  randconfig-a001-20200319
nios2                randconfig-a001-20200319
microblaze           randconfig-a001-20200319
xtensa               randconfig-a001-20200319
csky                 randconfig-a001-20200319
openrisc             randconfig-a001-20200319
sh                   randconfig-a001-20200319
s390                 randconfig-a001-20200319
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
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                          rv32_defconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
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
