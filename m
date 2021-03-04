Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C909E32CCDC
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 07:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbhCDGa4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 01:30:56 -0500
Received: from mga14.intel.com ([192.55.52.115]:26724 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235216AbhCDGar (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Mar 2021 01:30:47 -0500
IronPort-SDR: jNC7Ygjt+LuxkHB0GamMErFpygy5vRXjrLXRBhTwOuygxkmvmzeoyyd8cxDpLpjjdd9JNHyzXJ
 VuB7kZxRaGWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="186700508"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="186700508"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 22:30:06 -0800
IronPort-SDR: NQYnKYKqOzsuZg4CIUvzo23HvXzhcJyWaUbm4MRcZo/LBB/Wch3ekbQZ+DOmgFe4CIed9dYfxk
 5FBQBgBSXMQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="445602506"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2021 22:30:05 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHhUq-000243-Fo; Thu, 04 Mar 2021 06:30:04 +0000
Date:   Thu, 04 Mar 2021 14:29:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 cca7f12b939bd75f3a5e2b0fa20e3de67d1d33b1
Message-ID: <60407e32.HVFDM5b5tW0lGguM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: cca7f12b939bd75f3a5e2b0fa20e3de67d1d33b1  RDMA/uverbs: Fix kernel-doc warning of _uverbs_alloc

elapsed time: 732m

configs tested: 128
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                  colibri_pxa300_defconfig
mips                          malta_defconfig
h8300                               defconfig
ia64                      gensparse_defconfig
powerpc                      pmac32_defconfig
arc                          axs103_defconfig
powerpc                  mpc866_ads_defconfig
microblaze                      mmu_defconfig
s390                                defconfig
arm                          imote2_defconfig
arm                         shannon_defconfig
mips                           ip27_defconfig
arm                         vf610m4_defconfig
sh                           se7343_defconfig
sh                           se7619_defconfig
arm                        clps711x_defconfig
m68k                       m5249evb_defconfig
powerpc                       holly_defconfig
arm                        mini2440_defconfig
arm                        vexpress_defconfig
powerpc                   lite5200b_defconfig
arm                         assabet_defconfig
sh                        sh7785lcr_defconfig
arm                         cm_x300_defconfig
ia64                             allmodconfig
sh                                  defconfig
mips                    maltaup_xpa_defconfig
mips                     cu1830-neo_defconfig
powerpc                     tqm5200_defconfig
mips                          rm200_defconfig
arm64                            alldefconfig
arm                        oxnas_v6_defconfig
mips                  cavium_octeon_defconfig
mips                            ar7_defconfig
arm                        realview_defconfig
powerpc                      ppc64e_defconfig
powerpc                      ppc44x_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210304
x86_64               randconfig-a001-20210304
x86_64               randconfig-a004-20210304
x86_64               randconfig-a005-20210304
x86_64               randconfig-a002-20210304
x86_64               randconfig-a003-20210304
i386                 randconfig-a005-20210304
i386                 randconfig-a003-20210304
i386                 randconfig-a002-20210304
i386                 randconfig-a004-20210304
i386                 randconfig-a006-20210304
i386                 randconfig-a001-20210304
i386                 randconfig-a005-20210303
i386                 randconfig-a003-20210303
i386                 randconfig-a002-20210303
i386                 randconfig-a004-20210303
i386                 randconfig-a006-20210303
i386                 randconfig-a001-20210303
x86_64               randconfig-a013-20210303
x86_64               randconfig-a016-20210303
x86_64               randconfig-a015-20210303
x86_64               randconfig-a014-20210303
x86_64               randconfig-a012-20210303
x86_64               randconfig-a011-20210303
i386                 randconfig-a016-20210304
i386                 randconfig-a012-20210304
i386                 randconfig-a013-20210304
i386                 randconfig-a014-20210304
i386                 randconfig-a011-20210304
i386                 randconfig-a015-20210304
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210303
x86_64               randconfig-a001-20210303
x86_64               randconfig-a004-20210303
x86_64               randconfig-a002-20210303
x86_64               randconfig-a005-20210303
x86_64               randconfig-a003-20210303
x86_64               randconfig-a013-20210304
x86_64               randconfig-a016-20210304
x86_64               randconfig-a015-20210304
x86_64               randconfig-a014-20210304
x86_64               randconfig-a012-20210304
x86_64               randconfig-a011-20210304

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
