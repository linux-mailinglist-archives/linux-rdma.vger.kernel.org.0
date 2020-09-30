Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D5C27E191
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 08:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgI3Gnm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 02:43:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:8198 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgI3Gnm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Sep 2020 02:43:42 -0400
IronPort-SDR: 0kjodQvgHcdwFMJbvPMpkPQe+nkYG5mt1gwJXL6hBB65k43MJK9dZ9RCxITwbpW5KpczLvsI8u
 y8pSqEXVo8kQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="180530893"
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="180530893"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 23:43:41 -0700
IronPort-SDR: +pEuHF9JZU/R5tVJ2UQrBFGYjFKQpvVqqE/cT7G43njmT+mtcJ2Av73WuyjqnWSB1R1wzdEzam
 h19c3FY3VtRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="350572208"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Sep 2020 23:43:39 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kNVpz-00007C-8O; Wed, 30 Sep 2020 06:43:39 +0000
Date:   Wed, 30 Sep 2020 14:42:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 cf4c0fb00d5a93cefedadb6a973416376d3321dc
Message-ID: <5f7428e4.Vu78U83Q2zUYBH4A%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: cf4c0fb00d5a93cefedadb6a973416376d3321dc  RDMA/hns: Remove unused variables and definitions

elapsed time: 725m

configs tested: 162
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 xes_mpc85xx_defconfig
arc                      axs103_smp_defconfig
arc                         haps_hs_defconfig
arm                         orion5x_defconfig
riscv                               defconfig
arm                           h3600_defconfig
powerpc                          g5_defconfig
arm                       spear13xx_defconfig
mips                           ip22_defconfig
arm                         nhk8815_defconfig
ia64                        generic_defconfig
mips                       rbtx49xx_defconfig
powerpc                      pmac32_defconfig
powerpc64                        alldefconfig
sh                        sh7785lcr_defconfig
xtensa                         virt_defconfig
powerpc                   bluestone_defconfig
arm                         s5pv210_defconfig
m68k                        mvme147_defconfig
riscv                            alldefconfig
arm                           viper_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                    amigaone_defconfig
sh                           se7751_defconfig
mips                      malta_kvm_defconfig
powerpc                     rainier_defconfig
arm                           efm32_defconfig
arm                      tct_hammer_defconfig
powerpc                        icon_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     tqm8541_defconfig
sh                        sh7763rdp_defconfig
mips                    maltaup_xpa_defconfig
xtensa                           allyesconfig
mips                          rm200_defconfig
m68k                       m5249evb_defconfig
arc                    vdk_hs38_smp_defconfig
mips                        maltaup_defconfig
arm                       versatile_defconfig
arm                       omap2plus_defconfig
powerpc                    socrates_defconfig
parisc                generic-64bit_defconfig
xtensa                  audio_kc705_defconfig
s390                       zfcpdump_defconfig
powerpc                      ep88xc_defconfig
sh                         apsh4a3a_defconfig
s390                             allyesconfig
arm                            u300_defconfig
arc                        vdk_hs38_defconfig
mips                             allmodconfig
arm                      pxa255-idp_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                          simpad_defconfig
sh                        edosk7705_defconfig
powerpc                 mpc837x_rdb_defconfig
c6x                        evmc6457_defconfig
arm                         s3c6400_defconfig
arm                           sama5_defconfig
powerpc                    mvme5100_defconfig
powerpc                        fsp2_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                       multi_v4t_defconfig
sh                             shx3_defconfig
microblaze                          defconfig
mips                   sb1250_swarm_defconfig
mips                malta_kvm_guest_defconfig
h8300                     edosk2674_defconfig
mips                         tb0219_defconfig
sh                          r7780mp_defconfig
mips                       capcella_defconfig
arm                         ebsa110_defconfig
c6x                                 defconfig
um                           x86_64_defconfig
arm                        multi_v7_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20200929
i386                 randconfig-a002-20200929
i386                 randconfig-a003-20200929
i386                 randconfig-a004-20200929
i386                 randconfig-a005-20200929
i386                 randconfig-a001-20200929
x86_64               randconfig-a011-20200929
x86_64               randconfig-a013-20200929
x86_64               randconfig-a015-20200929
x86_64               randconfig-a014-20200929
x86_64               randconfig-a016-20200929
x86_64               randconfig-a012-20200929
x86_64               randconfig-a015-20200930
x86_64               randconfig-a013-20200930
x86_64               randconfig-a012-20200930
x86_64               randconfig-a016-20200930
x86_64               randconfig-a014-20200930
x86_64               randconfig-a011-20200930
i386                 randconfig-a011-20200930
i386                 randconfig-a015-20200930
i386                 randconfig-a012-20200930
i386                 randconfig-a014-20200930
i386                 randconfig-a016-20200930
i386                 randconfig-a013-20200930
i386                 randconfig-a012-20200929
i386                 randconfig-a016-20200929
i386                 randconfig-a014-20200929
i386                 randconfig-a013-20200929
i386                 randconfig-a015-20200929
i386                 randconfig-a011-20200929
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200929
x86_64               randconfig-a003-20200929
x86_64               randconfig-a004-20200929
x86_64               randconfig-a002-20200929
x86_64               randconfig-a006-20200929
x86_64               randconfig-a001-20200929
x86_64               randconfig-a001-20200930
x86_64               randconfig-a005-20200930
x86_64               randconfig-a003-20200930
x86_64               randconfig-a004-20200930
x86_64               randconfig-a002-20200930
x86_64               randconfig-a006-20200930

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
