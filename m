Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55F835F446
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Apr 2021 14:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347459AbhDNMxU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Apr 2021 08:53:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:43347 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233219AbhDNMxR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 14 Apr 2021 08:53:17 -0400
IronPort-SDR: X3t1nnfGzFgGn+CU0C0LQg5pvvncF19dtgIjDJVSpZ+e4Ok016r62wVtIuI68xRXvyZlwxhjVL
 ov0FITT4Esqg==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="182134722"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="182134722"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 05:52:55 -0700
IronPort-SDR: 2SFEtaR1rF8yuyu1DQiYTk1kfah0B9kVbc2LfUY6nXSY/+q20yXfJT/jMAZObaB8uyJDC7KNP+
 AYno8wfer3jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="421312940"
Received: from lkp-server02.sh.intel.com (HELO fa9c8fcc3464) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 14 Apr 2021 05:52:53 -0700
Received: from kbuild by fa9c8fcc3464 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lWf0n-00001p-1D; Wed, 14 Apr 2021 12:52:53 +0000
Date:   Wed, 14 Apr 2021 20:52:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/for-testing] BUILD SUCCESS
 327b4a010a156b8a1bee43e8691dffcec42ab54b
Message-ID: <6076e5a0.ZCcEa4dc7O7bUSGE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/for-testing
branch HEAD: 327b4a010a156b8a1bee43e8691dffcec42ab54b  Merge tag 'v5.12-rc7' into rdma.git for-next

i386-tinyconfig vmlinux size:

+-------+-------------------------+-----------------------------------------------------------+
| DELTA |         SYMBOL          |                          COMMIT                           |
+-------+-------------------------+-----------------------------------------------------------+
|  +552 | TOTAL                   | a38fd8748464..327b4a010a15 (ALL COMMITS)                  |
|  +550 | TOTAL                   | 327b4a010a15 Merge tag 'v5.12-rc7' into rdma.git for-next |
|  +538 | TEXT                    | 327b4a010a15 Merge tag 'v5.12-rc7' into rdma.git for-next |
|   +80 | timekeeping_notify()    | 327b4a010a15 Merge tag 'v5.12-rc7' into rdma.git for-next |
|   +70 | __perf_pmu_sched_task() | 327b4a010a15 Merge tag 'v5.12-rc7' into rdma.git for-next |
|   +64 | perf_pmu_sched_task()   | 327b4a010a15 Merge tag 'v5.12-rc7' into rdma.git for-next |
|   -92 | change_clocksource()    | 327b4a010a15 Merge tag 'v5.12-rc7' into rdma.git for-next |
+-------+-------------------------+-----------------------------------------------------------+

elapsed time: 722m

configs tested: 213
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
mips                           ip28_defconfig
powerpc                     asp8347_defconfig
ia64                        generic_defconfig
arc                     nsimosci_hs_defconfig
arm                          pxa3xx_defconfig
openrisc                         alldefconfig
powerpc64                           defconfig
sh                        apsh4ad0a_defconfig
h8300                       h8s-sim_defconfig
sh                           se7206_defconfig
s390                             allmodconfig
sh                           se7343_defconfig
mips                           gcw0_defconfig
arm                           corgi_defconfig
sh                           se7724_defconfig
powerpc                      obs600_defconfig
arm                            mmp2_defconfig
arc                        nsim_700_defconfig
arm                       imx_v4_v5_defconfig
m68k                          atari_defconfig
mips                malta_qemu_32r6_defconfig
arm                          iop32x_defconfig
arm                           sunxi_defconfig
arc                         haps_hs_defconfig
powerpc                     taishan_defconfig
powerpc64                        alldefconfig
powerpc                     ksi8560_defconfig
xtensa                  cadence_csp_defconfig
sh                          urquell_defconfig
h8300                    h8300h-sim_defconfig
arm                          collie_defconfig
nds32                            alldefconfig
arm                         socfpga_defconfig
sparc64                             defconfig
powerpc                        warp_defconfig
mips                        nlm_xlr_defconfig
ia64                      gensparse_defconfig
powerpc                    socrates_defconfig
powerpc                   lite5200b_defconfig
powerpc                      bamboo_defconfig
arm                            xcep_defconfig
mips                        nlm_xlp_defconfig
powerpc                  iss476-smp_defconfig
powerpc                       ebony_defconfig
powerpc                      ppc6xx_defconfig
mips                          rb532_defconfig
sh                        sh7785lcr_defconfig
sh                          landisk_defconfig
csky                             alldefconfig
powerpc                     tqm8560_defconfig
arm                       spear13xx_defconfig
m68k                          hp300_defconfig
sparc64                          alldefconfig
i386                                defconfig
riscv             nommu_k210_sdcard_defconfig
arm                         orion5x_defconfig
powerpc                     ppa8548_defconfig
powerpc                         ps3_defconfig
sh                                  defconfig
s390                             allyesconfig
mips                         tb0287_defconfig
arc                        vdk_hs38_defconfig
mips                         bigsur_defconfig
arm                         vf610m4_defconfig
powerpc                     tqm8548_defconfig
powerpc                      ppc44x_defconfig
arc                     haps_hs_smp_defconfig
mips                        maltaup_defconfig
arm                        realview_defconfig
arm                     am200epdkit_defconfig
i386                             alldefconfig
mips                          rm200_defconfig
arm                          pcm027_defconfig
arm                        cerfcube_defconfig
microblaze                          defconfig
arm                     eseries_pxa_defconfig
sparc                            allyesconfig
xtensa                  nommu_kc705_defconfig
arc                          axs101_defconfig
powerpc                 mpc8540_ads_defconfig
mips                        qi_lb60_defconfig
arm                            dove_defconfig
powerpc                     tqm8540_defconfig
arm                       aspeed_g4_defconfig
sh                         microdev_defconfig
powerpc                     sequoia_defconfig
sh                          lboxre2_defconfig
sh                ecovec24-romimage_defconfig
arm                          lpd270_defconfig
mips                           ci20_defconfig
arm                        multi_v7_defconfig
arm                        spear3xx_defconfig
arm                         bcm2835_defconfig
sh                          rsk7201_defconfig
arc                          axs103_defconfig
mips                           xway_defconfig
sh                   secureedge5410_defconfig
alpha                               defconfig
arm                       versatile_defconfig
mips                        bcm63xx_defconfig
arm                        clps711x_defconfig
xtensa                generic_kc705_defconfig
arm                      footbridge_defconfig
arm                      jornada720_defconfig
powerpc                   motionpro_defconfig
arm                       netwinder_defconfig
mips                            gpr_defconfig
m68k                             allyesconfig
powerpc                 canyonlands_defconfig
arm                       multi_v4t_defconfig
sh                     magicpanelr2_defconfig
arm                           sama5_defconfig
mips                       rbtx49xx_defconfig
powerpc                     mpc512x_defconfig
arm                        trizeps4_defconfig
powerpc                       eiger_defconfig
sh                   rts7751r2dplus_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210413
x86_64               randconfig-a002-20210413
x86_64               randconfig-a001-20210413
x86_64               randconfig-a005-20210413
x86_64               randconfig-a006-20210413
x86_64               randconfig-a004-20210413
i386                 randconfig-a003-20210413
i386                 randconfig-a001-20210413
i386                 randconfig-a006-20210413
i386                 randconfig-a005-20210413
i386                 randconfig-a004-20210413
i386                 randconfig-a002-20210413
i386                 randconfig-a003-20210414
i386                 randconfig-a006-20210414
i386                 randconfig-a001-20210414
i386                 randconfig-a005-20210414
i386                 randconfig-a004-20210414
i386                 randconfig-a002-20210414
x86_64               randconfig-a014-20210414
x86_64               randconfig-a015-20210414
x86_64               randconfig-a011-20210414
x86_64               randconfig-a013-20210414
x86_64               randconfig-a012-20210414
x86_64               randconfig-a016-20210414
i386                 randconfig-a015-20210413
i386                 randconfig-a014-20210413
i386                 randconfig-a016-20210413
i386                 randconfig-a013-20210413
i386                 randconfig-a012-20210413
i386                 randconfig-a011-20210413
i386                 randconfig-a015-20210414
i386                 randconfig-a014-20210414
i386                 randconfig-a013-20210414
i386                 randconfig-a012-20210414
i386                 randconfig-a016-20210414
i386                 randconfig-a011-20210414
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210413
x86_64               randconfig-a015-20210413
x86_64               randconfig-a011-20210413
x86_64               randconfig-a013-20210413
x86_64               randconfig-a012-20210413
x86_64               randconfig-a016-20210413
x86_64               randconfig-a003-20210414
x86_64               randconfig-a002-20210414
x86_64               randconfig-a005-20210414
x86_64               randconfig-a001-20210414
x86_64               randconfig-a006-20210414
x86_64               randconfig-a004-20210414

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
