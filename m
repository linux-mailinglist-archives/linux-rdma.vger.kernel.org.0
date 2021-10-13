Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA82842C6F6
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 18:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbhJMQ6q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 12:58:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:17029 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237860AbhJMQ63 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Oct 2021 12:58:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="227437439"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="227437439"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 09:56:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="441720180"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Oct 2021 09:56:24 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mahYF-0004rA-Id; Wed, 13 Oct 2021 16:56:23 +0000
Date:   Thu, 14 Oct 2021 00:56:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 3b87e0824272414cec79763afef6720c7c908c44
Message-ID: <61670fa8.A6OdfDTvcgSQ7p7L%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 3b87e0824272414cec79763afef6720c7c908c44  RDMA/rxe: Convert kernel UD post send to use ah_num

elapsed time: 1463m

configs tested: 224
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211012
i386                 randconfig-c001-20211013
sh                   sh7724_generic_defconfig
powerpc                     pseries_defconfig
xtensa                          iss_defconfig
arm                           sunxi_defconfig
arm                        shmobile_defconfig
sh                          r7780mp_defconfig
mips                      malta_kvm_defconfig
arm                           sama7_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                       m5249evb_defconfig
csky                             alldefconfig
mips                            e55_defconfig
powerpc                     mpc5200_defconfig
xtensa                generic_kc705_defconfig
arm                            mmp2_defconfig
powerpc                      makalu_defconfig
s390                          debug_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                       holly_defconfig
arm                            dove_defconfig
ia64                            zx1_defconfig
powerpc                      tqm8xx_defconfig
arm                        clps711x_defconfig
powerpc                        cell_defconfig
mips                 decstation_r4k_defconfig
arm                        multi_v7_defconfig
powerpc                   bluestone_defconfig
arm                         bcm2835_defconfig
powerpc                     rainier_defconfig
sh                   secureedge5410_defconfig
arm                            zeus_defconfig
powerpc                     tqm5200_defconfig
powerpc                 mpc837x_mds_defconfig
mips                          malta_defconfig
arm                       mainstone_defconfig
sh                          urquell_defconfig
sparc                               defconfig
arm                        realview_defconfig
arm                          exynos_defconfig
m68k                           sun3_defconfig
mips                           mtx1_defconfig
arm                           omap1_defconfig
alpha                            allyesconfig
powerpc                        icon_defconfig
m68k                          multi_defconfig
arm                          imote2_defconfig
mips                  maltasmvp_eva_defconfig
openrisc                            defconfig
arm64                            alldefconfig
m68k                          atari_defconfig
ia64                        generic_defconfig
sparc64                          alldefconfig
mips                        bcm47xx_defconfig
mips                          ath25_defconfig
powerpc                       maple_defconfig
arm                             ezx_defconfig
ia64                             allyesconfig
arm                     eseries_pxa_defconfig
sh                           se7751_defconfig
arm                        spear6xx_defconfig
parisc                generic-32bit_defconfig
arm                          iop32x_defconfig
arm                      tct_hammer_defconfig
arm                         lpc32xx_defconfig
arm                       multi_v4t_defconfig
sh                        sh7785lcr_defconfig
powerpc                    sam440ep_defconfig
mips                           ip28_defconfig
sh                           se7724_defconfig
sparc                       sparc64_defconfig
arm                            pleb_defconfig
mips                      bmips_stb_defconfig
powerpc                 mpc834x_mds_defconfig
arc                    vdk_hs38_smp_defconfig
arc                              alldefconfig
arm                           tegra_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      ep88xc_defconfig
sh                          kfr2r09_defconfig
powerpc                      mgcoge_defconfig
powerpc                     tqm8548_defconfig
arm                          simpad_defconfig
mips                           ip22_defconfig
powerpc                 linkstation_defconfig
powerpc                       ppc64_defconfig
mips                         cobalt_defconfig
arm                          gemini_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                      pic32mzda_defconfig
mips                        nlm_xlp_defconfig
arm                         axm55xx_defconfig
nios2                         10m50_defconfig
powerpc                      katmai_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                           corgi_defconfig
powerpc                       ebony_defconfig
powerpc                       eiger_defconfig
arc                          axs101_defconfig
arm                         at91_dt_defconfig
arm                         s3c6400_defconfig
sh                        edosk7705_defconfig
arm                      pxa255-idp_defconfig
powerpc                 canyonlands_defconfig
mips                         tb0219_defconfig
powerpc                     sequoia_defconfig
openrisc                    or1ksim_defconfig
mips                          rb532_defconfig
powerpc                     tqm8540_defconfig
mips                      maltaaprp_defconfig
arm                  randconfig-c002-20211012
x86_64               randconfig-c001-20211012
arm                  randconfig-c002-20211013
x86_64               randconfig-c001-20211013
ia64                             allmodconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                            allyesconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20211012
x86_64               randconfig-a006-20211012
x86_64               randconfig-a001-20211012
x86_64               randconfig-a005-20211012
x86_64               randconfig-a002-20211012
x86_64               randconfig-a003-20211012
i386                 randconfig-a001-20211012
i386                 randconfig-a003-20211012
i386                 randconfig-a004-20211012
i386                 randconfig-a005-20211012
i386                 randconfig-a002-20211012
i386                 randconfig-a006-20211012
x86_64               randconfig-a015-20211013
x86_64               randconfig-a012-20211013
x86_64               randconfig-a016-20211013
x86_64               randconfig-a014-20211013
x86_64               randconfig-a013-20211013
x86_64               randconfig-a011-20211013
i386                 randconfig-a016-20211013
i386                 randconfig-a014-20211013
i386                 randconfig-a011-20211013
i386                 randconfig-a015-20211013
i386                 randconfig-a012-20211013
i386                 randconfig-a013-20211013
arc                  randconfig-r043-20211012
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
arm                  randconfig-c002-20211012
mips                 randconfig-c004-20211012
i386                 randconfig-c001-20211012
s390                 randconfig-c005-20211012
x86_64               randconfig-c007-20211012
powerpc              randconfig-c003-20211012
riscv                randconfig-c006-20211012
x86_64               randconfig-a004-20211013
x86_64               randconfig-a006-20211013
x86_64               randconfig-a001-20211013
x86_64               randconfig-a005-20211013
x86_64               randconfig-a002-20211013
x86_64               randconfig-a003-20211013
i386                 randconfig-a001-20211013
i386                 randconfig-a003-20211013
i386                 randconfig-a004-20211013
i386                 randconfig-a005-20211013
i386                 randconfig-a002-20211013
i386                 randconfig-a006-20211013
x86_64               randconfig-a015-20211012
x86_64               randconfig-a012-20211012
x86_64               randconfig-a016-20211012
x86_64               randconfig-a014-20211012
x86_64               randconfig-a013-20211012
x86_64               randconfig-a011-20211012
i386                 randconfig-a016-20211012
i386                 randconfig-a014-20211012
i386                 randconfig-a011-20211012
i386                 randconfig-a015-20211012
i386                 randconfig-a012-20211012
i386                 randconfig-a013-20211012
hexagon              randconfig-r041-20211012
s390                 randconfig-r044-20211012
riscv                randconfig-r042-20211012
hexagon              randconfig-r045-20211012
hexagon              randconfig-r041-20211013
hexagon              randconfig-r045-20211013

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
