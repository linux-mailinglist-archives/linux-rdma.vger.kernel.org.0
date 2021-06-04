Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8DB39B13F
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jun 2021 06:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhFDEPe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Jun 2021 00:15:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:1147 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhFDEPe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Jun 2021 00:15:34 -0400
IronPort-SDR: 5BGclTef5E80fNzqWpcOQ06sg0om/6KuwqIy4E92173isuBF45dBQtDm/dKmxWFt9+7T7KHA20
 CVinnMpWhkiQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="268082803"
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; 
   d="scan'208";a="268082803"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 21:13:46 -0700
IronPort-SDR: zzvV59IA7iKU6WyYp0lyeRY++ZiqBjrVyB0XEcYHdmYXBnKIQzZ3ENF0q1qInItEHe9RDgpngP
 wdpgNVNlPexw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; 
   d="scan'208";a="475318060"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jun 2021 21:13:44 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lp1DM-0006eC-1e; Fri, 04 Jun 2021 04:13:44 +0000
Date:   Fri, 04 Jun 2021 12:12:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 a3e74fb9247cd530dca246699d5eb5a691884d32
Message-ID: <60b9a83b.jS8YRDSYk6hml4uY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: a3e74fb9247cd530dca246699d5eb5a691884d32  RDMA/ipoib: Fix warning caused by destroying non-initial netns

elapsed time: 1692m

configs tested: 287
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         socfpga_defconfig
arm                            qcom_defconfig
sh                          sdk7786_defconfig
mips                       rbtx49xx_defconfig
parisc                           allyesconfig
mips                        vocore2_defconfig
mips                           ip27_defconfig
powerpc                      pasemi_defconfig
m68k                       m5249evb_defconfig
arm                         lpc32xx_defconfig
nios2                            alldefconfig
arm                      tct_hammer_defconfig
powerpc                      cm5200_defconfig
mips                       capcella_defconfig
ia64                      gensparse_defconfig
sh                            hp6xx_defconfig
powerpc                    adder875_defconfig
m68k                         apollo_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                      arches_defconfig
powerpc                           allnoconfig
h8300                     edosk2674_defconfig
sparc64                          alldefconfig
arm                     am200epdkit_defconfig
arm                        multi_v5_defconfig
mips                         rt305x_defconfig
mips                           mtx1_defconfig
h8300                    h8300h-sim_defconfig
powerpc                     kilauea_defconfig
sh                           se7780_defconfig
mips                          rm200_defconfig
arm                             mxs_defconfig
sh                            titan_defconfig
arm                           h5000_defconfig
powerpc                     tqm8548_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                         apsh4a3a_defconfig
arc                         haps_hs_defconfig
arm                         mv78xx0_defconfig
sh                         ecovec24_defconfig
sh                         ap325rxa_defconfig
sh                           se7722_defconfig
m68k                         amcore_defconfig
mips                    maltaup_xpa_defconfig
arm                          pxa168_defconfig
arc                                 defconfig
powerpc                    amigaone_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                   sh7770_generic_defconfig
m68k                       m5275evb_defconfig
powerpc                 mpc836x_mds_defconfig
parisc                              defconfig
sh                               j2_defconfig
mips                  decstation_64_defconfig
powerpc                 mpc837x_mds_defconfig
mips                       lemote2f_defconfig
arm                              alldefconfig
m68k                        m5407c3_defconfig
m68k                        mvme16x_defconfig
arc                    vdk_hs38_smp_defconfig
um                                  defconfig
powerpc                      katmai_defconfig
mips                         mpc30x_defconfig
powerpc                      acadia_defconfig
powerpc64                        alldefconfig
arm                          collie_defconfig
arc                     nsimosci_hs_defconfig
s390                       zfcpdump_defconfig
arm                         bcm2835_defconfig
mips                            ar7_defconfig
powerpc                  storcenter_defconfig
m68k                             alldefconfig
arm                         lpc18xx_defconfig
arc                      axs103_smp_defconfig
sh                        dreamcast_defconfig
arm                         s3c6400_defconfig
sparc                       sparc32_defconfig
powerpc                     tqm8540_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                    sam440ep_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                               alldefconfig
powerpc                     sbc8548_defconfig
arm                       netwinder_defconfig
mips                           rs90_defconfig
arm                        cerfcube_defconfig
powerpc                 canyonlands_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                        warp_defconfig
arm                        neponset_defconfig
arm                    vt8500_v6_v7_defconfig
arm                            zeus_defconfig
xtensa                generic_kc705_defconfig
m68k                          amiga_defconfig
mips                            gpr_defconfig
powerpc                     tqm5200_defconfig
sh                             shx3_defconfig
arm                           viper_defconfig
powerpc                 mpc8315_rdb_defconfig
nios2                         3c120_defconfig
powerpc                      pcm030_defconfig
nds32                             allnoconfig
powerpc                   lite5200b_defconfig
arm                           u8500_defconfig
arm                       aspeed_g4_defconfig
sh                           se7751_defconfig
mips                      bmips_stb_defconfig
sparc                            alldefconfig
mips                          rb532_defconfig
mips                          ath25_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                        cell_defconfig
mips                        bcm63xx_defconfig
powerpc                      walnut_defconfig
mips                      pic32mzda_defconfig
mips                           jazz_defconfig
mips                malta_qemu_32r6_defconfig
nios2                               defconfig
mips                         db1xxx_defconfig
powerpc                     pseries_defconfig
sh                           se7343_defconfig
powerpc                      tqm8xx_defconfig
sh                          urquell_defconfig
arm                  colibri_pxa270_defconfig
um                            kunit_defconfig
arm                     davinci_all_defconfig
sh                      rts7751r2d1_defconfig
arc                            hsdk_defconfig
powerpc                   currituck_defconfig
mips                       bmips_be_defconfig
powerpc                     mpc83xx_defconfig
arm                          ixp4xx_defconfig
mips                         cobalt_defconfig
arm                        trizeps4_defconfig
xtensa                    xip_kc705_defconfig
powerpc                 mpc8560_ads_defconfig
arm                           sunxi_defconfig
sh                           se7712_defconfig
powerpc                     rainier_defconfig
arm                         orion5x_defconfig
arm                         axm55xx_defconfig
nios2                            allyesconfig
sh                             espt_defconfig
powerpc                     mpc5200_defconfig
powerpc                 mpc834x_itx_defconfig
arm                           stm32_defconfig
riscv                    nommu_virt_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                  cavium_octeon_defconfig
arm                         palmz72_defconfig
powerpc                  mpc866_ads_defconfig
arm                           omap1_defconfig
arm                            mps2_defconfig
arm                         s5pv210_defconfig
sh                          lboxre2_defconfig
mips                         tb0219_defconfig
m68k                        m5307c3_defconfig
arm                       multi_v4t_defconfig
arm                       spear13xx_defconfig
powerpc                    ge_imp3a_defconfig
openrisc                  or1klitex_defconfig
powerpc64                           defconfig
arm                           tegra_defconfig
powerpc                          allmodconfig
sh                              ul2_defconfig
mips                     loongson2k_defconfig
arc                              alldefconfig
mips                      pistachio_defconfig
sh                        sh7757lcr_defconfig
ia64                          tiger_defconfig
arm                         lubbock_defconfig
powerpc                     mpc512x_defconfig
arm                      pxa255-idp_defconfig
arm                           spitz_defconfig
arm                        vexpress_defconfig
sh                   rts7751r2dplus_defconfig
arm                         shannon_defconfig
powerpc                     tqm8541_defconfig
sh                        sh7785lcr_defconfig
arm                          simpad_defconfig
parisc                           alldefconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      bamboo_defconfig
powerpc                       ppc64_defconfig
arc                        nsimosci_defconfig
mips                        jmr3927_defconfig
arm                          ep93xx_defconfig
arm                          moxart_defconfig
sh                        edosk7705_defconfig
xtensa                  nommu_kc705_defconfig
ia64                                defconfig
x86_64                              defconfig
powerpc                     skiroot_defconfig
mips                 decstation_r4k_defconfig
arm                       mainstone_defconfig
sh                           se7721_defconfig
powerpc                         ps3_defconfig
sh                           se7206_defconfig
powerpc                    gamecube_defconfig
mips                      maltasmvp_defconfig
m68k                        stmark2_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
i386                 randconfig-a003-20210603
i386                 randconfig-a006-20210603
i386                 randconfig-a004-20210603
i386                 randconfig-a001-20210603
i386                 randconfig-a002-20210603
i386                 randconfig-a005-20210603
i386                 randconfig-a003-20210604
i386                 randconfig-a006-20210604
i386                 randconfig-a004-20210604
i386                 randconfig-a001-20210604
i386                 randconfig-a005-20210604
i386                 randconfig-a002-20210604
x86_64               randconfig-a015-20210603
x86_64               randconfig-a011-20210603
x86_64               randconfig-a012-20210603
x86_64               randconfig-a014-20210603
x86_64               randconfig-a016-20210603
x86_64               randconfig-a013-20210603
i386                 randconfig-a015-20210603
i386                 randconfig-a011-20210603
i386                 randconfig-a014-20210603
i386                 randconfig-a012-20210603
i386                 randconfig-a013-20210603
i386                 randconfig-a016-20210603
x86_64               randconfig-a002-20210604
x86_64               randconfig-a004-20210604
x86_64               randconfig-a003-20210604
x86_64               randconfig-a006-20210604
x86_64               randconfig-a005-20210604
x86_64               randconfig-a001-20210604
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210603
x86_64               randconfig-b001-20210604
x86_64               randconfig-a002-20210603
x86_64               randconfig-a004-20210603
x86_64               randconfig-a003-20210603
x86_64               randconfig-a006-20210603
x86_64               randconfig-a005-20210603
x86_64               randconfig-a001-20210603
x86_64               randconfig-a015-20210604
x86_64               randconfig-a011-20210604
x86_64               randconfig-a014-20210604
x86_64               randconfig-a012-20210604
x86_64               randconfig-a016-20210604
x86_64               randconfig-a013-20210604

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
