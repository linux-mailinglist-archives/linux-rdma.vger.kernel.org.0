Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06DC37A113
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 09:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhEKHpD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 03:45:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:10036 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhEKHpC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 03:45:02 -0400
IronPort-SDR: LWzZsKJDa33TaSYCCxF2NMqmROxqLoDMoB0BSKbb28C6+K07j9rHsG2NoUj5XzYihICK6QLds6
 AsDkLiPYhMdw==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="186823378"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="186823378"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 00:43:55 -0700
IronPort-SDR: aeLcNue5ps/0Zfzm+CUBxV5FHDREtLrFf0KhoWL7LpiqwqgaXOrOJxLklqpiSgZa1aUrHvoWXJ
 9f6wFED7Tr/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="536879785"
Received: from lkp-server01.sh.intel.com (HELO f375d57c4ed4) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 May 2021 00:43:52 -0700
Received: from kbuild by f375d57c4ed4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lgN3X-0000bX-Fn; Tue, 11 May 2021 07:43:51 +0000
Date:   Tue, 11 May 2021 15:43:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 54d87913f147a983589923c7f651f97de9af5be1
Message-ID: <609a359f.8i5X1rj2/SnvtBtx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: 54d87913f147a983589923c7f651f97de9af5be1  RDMA/core: Prevent divide-by-zero error triggered by the user

elapsed time: 731m

configs tested: 231
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
mips                           gcw0_defconfig
xtensa                         virt_defconfig
sh                          urquell_defconfig
arm                         at91_dt_defconfig
powerpc                 mpc8560_ads_defconfig
mips                    maltaup_xpa_defconfig
i386                                defconfig
ia64                      gensparse_defconfig
arm                        neponset_defconfig
powerpc                    sam440ep_defconfig
arm                       aspeed_g4_defconfig
sh                          polaris_defconfig
powerpc                     tqm5200_defconfig
arm                            xcep_defconfig
powerpc                      ppc44x_defconfig
arm                            qcom_defconfig
arm                          exynos_defconfig
sparc                       sparc32_defconfig
riscv                             allnoconfig
riscv                            alldefconfig
arm                         lpc32xx_defconfig
mips                      maltaaprp_defconfig
sh                     magicpanelr2_defconfig
sh                         ap325rxa_defconfig
sh                          rsk7264_defconfig
arm                       aspeed_g5_defconfig
sh                        sh7763rdp_defconfig
arm                            pleb_defconfig
sh                   sh7770_generic_defconfig
powerpc                      chrp32_defconfig
arm                          iop32x_defconfig
sh                           se7343_defconfig
openrisc                    or1ksim_defconfig
xtensa                  nommu_kc705_defconfig
arm                          pxa3xx_defconfig
sh                          kfr2r09_defconfig
m68k                       m5208evb_defconfig
sh                            hp6xx_defconfig
arm                              alldefconfig
powerpc                      mgcoge_defconfig
m68k                         amcore_defconfig
powerpc                     tqm8555_defconfig
powerpc                      ppc40x_defconfig
sh                        sh7757lcr_defconfig
mips                     loongson1c_defconfig
mips                       capcella_defconfig
arm                           sunxi_defconfig
sh                          sdk7780_defconfig
arm                      footbridge_defconfig
h8300                            alldefconfig
powerpc                  mpc866_ads_defconfig
arm                            lart_defconfig
powerpc                    gamecube_defconfig
arm                            dove_defconfig
arm                        trizeps4_defconfig
arm                       cns3420vb_defconfig
m68k                          sun3x_defconfig
mips                           ip28_defconfig
powerpc                    adder875_defconfig
arc                              alldefconfig
powerpc                     tqm8560_defconfig
nios2                               defconfig
mips                        workpad_defconfig
arm                         axm55xx_defconfig
csky                             alldefconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     skiroot_defconfig
arm                        mvebu_v5_defconfig
arm                         lubbock_defconfig
powerpc                     ksi8560_defconfig
sh                           se7721_defconfig
sh                          lboxre2_defconfig
arm                         cm_x300_defconfig
arm                         socfpga_defconfig
sh                   sh7724_generic_defconfig
arc                        nsim_700_defconfig
arm                         nhk8815_defconfig
i386                             alldefconfig
x86_64                            allnoconfig
mips                            gpr_defconfig
arm                         orion5x_defconfig
mips                   sb1250_swarm_defconfig
nios2                            alldefconfig
arm                       imx_v6_v7_defconfig
arm                          moxart_defconfig
arc                 nsimosci_hs_smp_defconfig
um                             i386_defconfig
xtensa                  audio_kc705_defconfig
arm                         vf610m4_defconfig
mips                     loongson2k_defconfig
arm                            hisi_defconfig
mips                         tb0226_defconfig
riscv                    nommu_k210_defconfig
arm                         bcm2835_defconfig
powerpc                       ebony_defconfig
sh                          r7785rp_defconfig
riscv                    nommu_virt_defconfig
arm                       versatile_defconfig
powerpc                 mpc834x_mds_defconfig
sh                         microdev_defconfig
powerpc                          g5_defconfig
mips                        maltaup_defconfig
arm                        multi_v5_defconfig
mips                           ci20_defconfig
arc                        vdk_hs38_defconfig
sh                           se7751_defconfig
mips                          rm200_defconfig
powerpc                     pseries_defconfig
sh                               j2_defconfig
powerpc                   currituck_defconfig
arm                          ixp4xx_defconfig
sh                              ul2_defconfig
sh                           se7750_defconfig
powerpc                    mvme5100_defconfig
ia64                          tiger_defconfig
arm                   milbeaut_m10v_defconfig
ia64                             allyesconfig
arm                            mmp2_defconfig
powerpc                 canyonlands_defconfig
mips                 decstation_r4k_defconfig
sh                          rsk7201_defconfig
xtensa                    xip_kc705_defconfig
mips                         mpc30x_defconfig
powerpc                     rainier_defconfig
xtensa                       common_defconfig
m68k                        stmark2_defconfig
powerpc                    socrates_defconfig
m68k                       m5275evb_defconfig
powerpc                     tqm8540_defconfig
powerpc                 mpc836x_mds_defconfig
m68k                            q40_defconfig
sh                        edosk7760_defconfig
mips                      pistachio_defconfig
mips                  decstation_64_defconfig
arm                      jornada720_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210510
x86_64               randconfig-a004-20210510
x86_64               randconfig-a001-20210510
x86_64               randconfig-a005-20210510
x86_64               randconfig-a002-20210510
x86_64               randconfig-a006-20210510
i386                 randconfig-a003-20210510
i386                 randconfig-a001-20210510
i386                 randconfig-a005-20210510
i386                 randconfig-a004-20210510
i386                 randconfig-a002-20210510
i386                 randconfig-a006-20210510
i386                 randconfig-a003-20210511
i386                 randconfig-a001-20210511
i386                 randconfig-a005-20210511
i386                 randconfig-a004-20210511
i386                 randconfig-a002-20210511
i386                 randconfig-a006-20210511
x86_64               randconfig-a012-20210511
x86_64               randconfig-a015-20210511
x86_64               randconfig-a011-20210511
x86_64               randconfig-a013-20210511
x86_64               randconfig-a016-20210511
x86_64               randconfig-a014-20210511
i386                 randconfig-a016-20210510
i386                 randconfig-a014-20210510
i386                 randconfig-a011-20210510
i386                 randconfig-a015-20210510
i386                 randconfig-a012-20210510
i386                 randconfig-a013-20210510
i386                 randconfig-a016-20210511
i386                 randconfig-a014-20210511
i386                 randconfig-a011-20210511
i386                 randconfig-a015-20210511
i386                 randconfig-a012-20210511
i386                 randconfig-a013-20210511
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
x86_64               randconfig-a003-20210511
x86_64               randconfig-a004-20210511
x86_64               randconfig-a001-20210511
x86_64               randconfig-a005-20210511
x86_64               randconfig-a002-20210511
x86_64               randconfig-a006-20210511
x86_64               randconfig-a015-20210510
x86_64               randconfig-a012-20210510
x86_64               randconfig-a011-20210510
x86_64               randconfig-a013-20210510
x86_64               randconfig-a016-20210510
x86_64               randconfig-a014-20210510

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
