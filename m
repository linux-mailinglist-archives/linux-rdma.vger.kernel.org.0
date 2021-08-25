Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FE33F6D99
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Aug 2021 05:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbhHYDIO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Aug 2021 23:08:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:45047 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230021AbhHYDIK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Aug 2021 23:08:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="214315122"
X-IronPort-AV: E=Sophos;i="5.84,349,1620716400"; 
   d="scan'208";a="214315122"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 20:07:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,349,1620716400"; 
   d="scan'208";a="515948604"
Received: from lkp-server02.sh.intel.com (HELO 181e7be6f509) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 24 Aug 2021 20:07:22 -0700
Received: from kbuild by 181e7be6f509 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mIjG5-00015p-R9; Wed, 25 Aug 2021 03:07:21 +0000
Date:   Wed, 25 Aug 2021 11:07:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 f0a64199195e5adfff921cb7bf4e4e67e1916401
Message-ID: <6125b3e4.2mdrdVOnCC94bUpK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: f0a64199195e5adfff921cb7bf4e4e67e1916401  RDMA/hns: Delete unused hns bitmap interface

elapsed time: 735m

configs tested: 135
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210824
sh                           se7722_defconfig
powerpc                    mvme5100_defconfig
powerpc                     ep8248e_defconfig
sh                          sdk7786_defconfig
arm                           viper_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                    adder875_defconfig
powerpc                       ebony_defconfig
arm                            xcep_defconfig
riscv                          rv32_defconfig
sh                          rsk7201_defconfig
riscv                            alldefconfig
sparc64                             defconfig
arc                           tb10x_defconfig
arm                          pxa910_defconfig
powerpc                        fsp2_defconfig
sh                           se7750_defconfig
ia64                      gensparse_defconfig
xtensa                  cadence_csp_defconfig
powerpc                     pq2fads_defconfig
mips                      malta_kvm_defconfig
powerpc                     pseries_defconfig
arc                              alldefconfig
arm                           tegra_defconfig
sh                      rts7751r2d1_defconfig
x86_64                           alldefconfig
mips                          ath79_defconfig
arm                            lart_defconfig
mips                           mtx1_defconfig
mips                    maltaup_xpa_defconfig
riscv                    nommu_k210_defconfig
arm                        realview_defconfig
powerpc                      pmac32_defconfig
arm                         cm_x300_defconfig
powerpc                       maple_defconfig
sh                               j2_defconfig
sh                        sh7763rdp_defconfig
i386                                defconfig
arm                          ixp4xx_defconfig
powerpc                   lite5200b_defconfig
arm                             rpc_defconfig
powerpc                     mpc83xx_defconfig
powerpc                     kilauea_defconfig
m68k                         apollo_defconfig
sh                           se7721_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210824
x86_64               randconfig-a006-20210824
x86_64               randconfig-a001-20210824
x86_64               randconfig-a003-20210824
x86_64               randconfig-a004-20210824
x86_64               randconfig-a002-20210824
i386                 randconfig-a006-20210824
i386                 randconfig-a001-20210824
i386                 randconfig-a002-20210824
i386                 randconfig-a005-20210824
i386                 randconfig-a003-20210824
i386                 randconfig-a004-20210824
x86_64               randconfig-a014-20210825
x86_64               randconfig-a015-20210825
x86_64               randconfig-a016-20210825
x86_64               randconfig-a013-20210825
x86_64               randconfig-a012-20210825
x86_64               randconfig-a011-20210825
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20210824
s390                 randconfig-c005-20210824
arm                  randconfig-c002-20210824
riscv                randconfig-c006-20210824
x86_64               randconfig-c007-20210824
mips                 randconfig-c004-20210824
powerpc              randconfig-c003-20210824
x86_64               randconfig-a014-20210824
x86_64               randconfig-a015-20210824
x86_64               randconfig-a016-20210824
x86_64               randconfig-a013-20210824
x86_64               randconfig-a012-20210824
x86_64               randconfig-a011-20210824
i386                 randconfig-a011-20210824
i386                 randconfig-a016-20210824
i386                 randconfig-a012-20210824
i386                 randconfig-a014-20210824
i386                 randconfig-a013-20210824
i386                 randconfig-a015-20210824
hexagon              randconfig-r041-20210824
hexagon              randconfig-r045-20210824
riscv                randconfig-r042-20210824
s390                 randconfig-r044-20210824

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
