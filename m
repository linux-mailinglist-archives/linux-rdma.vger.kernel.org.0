Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38769456884
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 04:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhKSDTi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Nov 2021 22:19:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:52330 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232894AbhKSDTi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Nov 2021 22:19:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="295162339"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="295162339"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 19:16:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="736880817"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 18 Nov 2021 19:16:35 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mnuOA-0003xp-V5; Fri, 19 Nov 2021 03:16:34 +0000
Date:   Fri, 19 Nov 2021 11:16:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 2a67fcfa0db6b4075515bd23497750849b88850f
Message-ID: <6197170c.CXM1qcrTA9hi+FSW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 2a67fcfa0db6b4075515bd23497750849b88850f  RDMA/hns: Validate the pkey index

elapsed time: 725m

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
i386                 randconfig-c001-20211118
mips                 randconfig-c004-20211118
powerpc                 mpc836x_rdk_defconfig
arm                  colibri_pxa300_defconfig
arm                           h3600_defconfig
arc                    vdk_hs38_smp_defconfig
riscv                    nommu_virt_defconfig
mips                   sb1250_swarm_defconfig
sh                 kfr2r09-romimage_defconfig
mips                           jazz_defconfig
mips                       capcella_defconfig
arm                         vf610m4_defconfig
powerpc                 mpc836x_mds_defconfig
arm                     davinci_all_defconfig
powerpc                      pasemi_defconfig
powerpc                       ppc64_defconfig
mips                          ath25_defconfig
xtensa                           alldefconfig
arc                          axs103_defconfig
mips                      bmips_stb_defconfig
m68k                         apollo_defconfig
mips                          rm200_defconfig
arm                         assabet_defconfig
arm                          simpad_defconfig
arm                       cns3420vb_defconfig
arm                       netwinder_defconfig
powerpc                      katmai_defconfig
arm                      integrator_defconfig
s390                          debug_defconfig
powerpc                    mvme5100_defconfig
arm                            xcep_defconfig
arm                        vexpress_defconfig
sh                   sh7724_generic_defconfig
mips                         db1xxx_defconfig
arm                        cerfcube_defconfig
arm                          pxa168_defconfig
m68k                          multi_defconfig
arm                              alldefconfig
sh                           se7722_defconfig
openrisc                            defconfig
powerpc                      cm5200_defconfig
ia64                             alldefconfig
arm                  randconfig-c002-20211118
arm                  randconfig-c002-20211119
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
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
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                 randconfig-a006-20211119
i386                 randconfig-a003-20211119
i386                 randconfig-a001-20211119
i386                 randconfig-a005-20211119
i386                 randconfig-a004-20211119
i386                 randconfig-a002-20211119
x86_64               randconfig-a015-20211118
x86_64               randconfig-a012-20211118
x86_64               randconfig-a011-20211118
x86_64               randconfig-a013-20211118
x86_64               randconfig-a016-20211118
x86_64               randconfig-a014-20211118
i386                 randconfig-a016-20211118
i386                 randconfig-a014-20211118
i386                 randconfig-a012-20211118
i386                 randconfig-a011-20211118
i386                 randconfig-a013-20211118
i386                 randconfig-a015-20211118
arc                  randconfig-r043-20211118
riscv                randconfig-r042-20211118
s390                 randconfig-r044-20211118
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20211118
x86_64               randconfig-c007-20211118
arm                  randconfig-c002-20211118
s390                 randconfig-c005-20211118
powerpc              randconfig-c003-20211118
riscv                randconfig-c006-20211118
mips                 randconfig-c004-20211118
x86_64               randconfig-a005-20211118
x86_64               randconfig-a003-20211118
x86_64               randconfig-a001-20211118
x86_64               randconfig-a002-20211118
x86_64               randconfig-a006-20211118
x86_64               randconfig-a004-20211118
i386                 randconfig-a006-20211118
i386                 randconfig-a003-20211118
i386                 randconfig-a001-20211118
i386                 randconfig-a005-20211118
i386                 randconfig-a004-20211118
i386                 randconfig-a002-20211118
hexagon              randconfig-r045-20211118
hexagon              randconfig-r041-20211118

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
