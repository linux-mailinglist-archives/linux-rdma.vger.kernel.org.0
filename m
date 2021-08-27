Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CE03F93C6
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Aug 2021 06:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhH0Es4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Aug 2021 00:48:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:41243 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhH0Es4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Aug 2021 00:48:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="303469880"
X-IronPort-AV: E=Sophos;i="5.84,355,1620716400"; 
   d="scan'208";a="303469880"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 21:48:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,355,1620716400"; 
   d="scan'208";a="517160818"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 26 Aug 2021 21:48:06 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mJTmf-0001y9-I4; Fri, 27 Aug 2021 04:48:05 +0000
Date:   Fri, 27 Aug 2021 12:47:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 145eba1aaec9f6798c30842d201920a80f9049a3
Message-ID: <61286e68.4LGFa7SpeC6FH1Av%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 145eba1aaec9f6798c30842d201920a80f9049a3  RDMA/hfi1: Convert to SPDX identifier

elapsed time: 741m

configs tested: 225
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210827
i386                 randconfig-c001-20210826
powerpc              randconfig-c003-20210826
sh                           se7722_defconfig
powerpc                     powernv_defconfig
powerpc                        warp_defconfig
mips                      loongson3_defconfig
um                             i386_defconfig
powerpc                 mpc834x_itx_defconfig
sh                         microdev_defconfig
arm                       netwinder_defconfig
arm                         mv78xx0_defconfig
arm                    vt8500_v6_v7_defconfig
xtensa                    xip_kc705_defconfig
mips                     loongson1b_defconfig
powerpc                      ppc64e_defconfig
parisc                generic-32bit_defconfig
arm                          ep93xx_defconfig
powerpc                         ps3_defconfig
sh                               alldefconfig
arm                            lart_defconfig
sh                         apsh4a3a_defconfig
arm                           viper_defconfig
powerpc                    amigaone_defconfig
m68k                       m5249evb_defconfig
arm                            mmp2_defconfig
powerpc                       eiger_defconfig
powerpc                 canyonlands_defconfig
arm                         cm_x300_defconfig
mips                           ip27_defconfig
powerpc                 mpc8313_rdb_defconfig
s390                             alldefconfig
nds32                            alldefconfig
powerpc                    ge_imp3a_defconfig
sh                          rsk7269_defconfig
powerpc                 mpc837x_mds_defconfig
arm                      integrator_defconfig
m68k                            q40_defconfig
x86_64                           allyesconfig
sh                             sh03_defconfig
arm                           spitz_defconfig
arm                       multi_v4t_defconfig
um                           x86_64_defconfig
powerpc                   lite5200b_defconfig
riscv                    nommu_virt_defconfig
arm                         vf610m4_defconfig
arm                          collie_defconfig
ia64                        generic_defconfig
sh                          rsk7264_defconfig
arm                      pxa255-idp_defconfig
powerpc                    gamecube_defconfig
arm                        spear3xx_defconfig
arm                            zeus_defconfig
h8300                     edosk2674_defconfig
powerpc                     pq2fads_defconfig
arm                         bcm2835_defconfig
mips                        jmr3927_defconfig
mips                       bmips_be_defconfig
powerpc                      pcm030_defconfig
openrisc                  or1klitex_defconfig
arm                        realview_defconfig
m68k                            mac_defconfig
mips                      pistachio_defconfig
ia64                          tiger_defconfig
sh                                  defconfig
openrisc                            defconfig
powerpc                     asp8347_defconfig
sparc                       sparc64_defconfig
sh                            shmin_defconfig
s390                          debug_defconfig
powerpc                 mpc8272_ads_defconfig
arc                            hsdk_defconfig
arm                           h5000_defconfig
arm                            mps2_defconfig
powerpc                 mpc836x_mds_defconfig
sh                           se7712_defconfig
m68k                        m5272c3_defconfig
xtensa                  cadence_csp_defconfig
xtensa                generic_kc705_defconfig
arm                         lpc18xx_defconfig
powerpc                          g5_defconfig
xtensa                          iss_defconfig
ia64                      gensparse_defconfig
powerpc                     akebono_defconfig
arm                             ezx_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                           ip28_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                   microwatt_defconfig
xtensa                  nommu_kc705_defconfig
riscv                    nommu_k210_defconfig
sh                          landisk_defconfig
arm                           corgi_defconfig
sh                ecovec24-romimage_defconfig
mips                            e55_defconfig
arm                        oxnas_v6_defconfig
mips                        qi_lb60_defconfig
powerpc                         wii_defconfig
mips                           ci20_defconfig
mips                   sb1250_swarm_defconfig
arm                       aspeed_g4_defconfig
sh                           se7724_defconfig
powerpc                    mvme5100_defconfig
arm                     am200epdkit_defconfig
arc                          axs101_defconfig
mips                         tb0219_defconfig
nios2                         10m50_defconfig
sh                   secureedge5410_defconfig
arm                         shannon_defconfig
arm                             pxa_defconfig
powerpc                      pmac32_defconfig
mips                        vocore2_defconfig
powerpc                     pseries_defconfig
arm                           omap1_defconfig
powerpc                  storcenter_defconfig
arm                       spear13xx_defconfig
ia64                             alldefconfig
arm                          pcm027_defconfig
microblaze                      mmu_defconfig
m68k                          amiga_defconfig
mips                        maltaup_defconfig
arm                      footbridge_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                          pxa168_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210826
x86_64               randconfig-a006-20210826
x86_64               randconfig-a001-20210826
x86_64               randconfig-a003-20210826
x86_64               randconfig-a004-20210826
x86_64               randconfig-a002-20210826
i386                 randconfig-a006-20210826
i386                 randconfig-a001-20210826
i386                 randconfig-a002-20210826
i386                 randconfig-a005-20210826
i386                 randconfig-a003-20210826
i386                 randconfig-a004-20210826
x86_64               randconfig-a014-20210827
x86_64               randconfig-a015-20210827
x86_64               randconfig-a016-20210827
x86_64               randconfig-a013-20210827
x86_64               randconfig-a012-20210827
x86_64               randconfig-a011-20210827
arc                  randconfig-r043-20210827
riscv                randconfig-r042-20210827
s390                 randconfig-r044-20210827
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20210826
s390                 randconfig-c005-20210826
arm                  randconfig-c002-20210826
riscv                randconfig-c006-20210826
powerpc              randconfig-c003-20210826
x86_64               randconfig-c007-20210826
mips                 randconfig-c004-20210826
s390                 randconfig-c005-20210827
i386                 randconfig-c001-20210827
arm                  randconfig-c002-20210827
riscv                randconfig-c006-20210827
powerpc              randconfig-c003-20210827
x86_64               randconfig-c007-20210827
mips                 randconfig-c004-20210827
x86_64               randconfig-a005-20210827
x86_64               randconfig-a001-20210827
x86_64               randconfig-a006-20210827
x86_64               randconfig-a003-20210827
x86_64               randconfig-a004-20210827
x86_64               randconfig-a002-20210827
x86_64               randconfig-a014-20210826
x86_64               randconfig-a015-20210826
x86_64               randconfig-a016-20210826
x86_64               randconfig-a013-20210826
x86_64               randconfig-a012-20210826
x86_64               randconfig-a011-20210826
i386                 randconfig-a011-20210826
i386                 randconfig-a016-20210826
i386                 randconfig-a012-20210826
i386                 randconfig-a014-20210826
i386                 randconfig-a013-20210826
i386                 randconfig-a015-20210826
hexagon              randconfig-r041-20210826
hexagon              randconfig-r045-20210826
riscv                randconfig-r042-20210826
s390                 randconfig-r044-20210826

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
