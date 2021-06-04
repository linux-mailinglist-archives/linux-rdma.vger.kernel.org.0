Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E5039B41F
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jun 2021 09:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhFDHk6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Jun 2021 03:40:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:9034 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229978AbhFDHk6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Jun 2021 03:40:58 -0400
IronPort-SDR: YR+ph9u1b6+uWbxJlBkUVmGZYqEYxDmSASmDecPTb58caiLhtAsgp+5lr8JERn0uUtG5LdmuCD
 0mBzFCIx1u/g==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="184613900"
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; 
   d="scan'208";a="184613900"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 00:39:12 -0700
IronPort-SDR: n7jhyH0czHoagcF60ScH5d+fujHTIhyHgIF/KL2ZHKbUqscEsh+eQmFXRZdTuf8JhEOKeGFVjo
 RSB3oR0VT2hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; 
   d="scan'208";a="400870035"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 04 Jun 2021 00:39:11 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lp4QA-0006mx-Hl; Fri, 04 Jun 2021 07:39:10 +0000
Date:   Fri, 04 Jun 2021 15:38:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 5bcf5a59c41e19141783c7305d420a5e36c937b2
Message-ID: <60b9d885.cG/QJ/qtCko85Mh7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 5bcf5a59c41e19141783c7305d420a5e36c937b2  RDMA/rxe: Protext kernel index from user space

elapsed time: 724m

configs tested: 217
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                           ip27_defconfig
powerpc                      pasemi_defconfig
m68k                       m5249evb_defconfig
arm                         lpc32xx_defconfig
nios2                         3c120_defconfig
mips                         tb0219_defconfig
arm                          moxart_defconfig
mips                           xway_defconfig
powerpc                       holly_defconfig
sh                   rts7751r2dplus_defconfig
mips                     cu1830-neo_defconfig
arm                        clps711x_defconfig
arc                         haps_hs_defconfig
mips                          rb532_defconfig
arm                          collie_defconfig
h8300                     edosk2674_defconfig
sparc64                          alldefconfig
arm                     am200epdkit_defconfig
arm                        multi_v5_defconfig
um                            kunit_defconfig
powerpc                    amigaone_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                   sh7770_generic_defconfig
m68k                       m5275evb_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                      katmai_defconfig
mips                         mpc30x_defconfig
powerpc                      acadia_defconfig
powerpc64                        alldefconfig
arc                     nsimosci_hs_defconfig
m68k                             alldefconfig
arm                         lpc18xx_defconfig
arc                      axs103_smp_defconfig
sh                        dreamcast_defconfig
arm                         s3c6400_defconfig
sh                         apsh4a3a_defconfig
sparc                       sparc32_defconfig
powerpc                     tqm8540_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                    sam440ep_defconfig
sh                            titan_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                           rs90_defconfig
m68k                         amcore_defconfig
arm                        cerfcube_defconfig
powerpc                 canyonlands_defconfig
powerpc                      ep88xc_defconfig
sh                               alldefconfig
powerpc64                           defconfig
powerpc                 mpc8313_rdb_defconfig
openrisc                            defconfig
mips                  decstation_64_defconfig
powerpc                     mpc5200_defconfig
arm                     davinci_all_defconfig
powerpc                      makalu_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      pcm030_defconfig
nds32                             allnoconfig
powerpc                   lite5200b_defconfig
arm                           u8500_defconfig
um                                  defconfig
powerpc                     tqm8541_defconfig
m68k                       m5208evb_defconfig
arm                           stm32_defconfig
arm                          ep93xx_defconfig
powerpc                      tqm8xx_defconfig
sh                          urquell_defconfig
powerpc                      cm5200_defconfig
arm                  colibri_pxa270_defconfig
sh                            hp6xx_defconfig
mips                           jazz_defconfig
mips                            ar7_defconfig
powerpc                   currituck_defconfig
arm                          ixp4xx_defconfig
mips                         cobalt_defconfig
arm                        trizeps4_defconfig
xtensa                    xip_kc705_defconfig
arm                      tct_hammer_defconfig
powerpc                 mpc8560_ads_defconfig
arm                           sunxi_defconfig
powerpc                 mpc834x_itx_defconfig
riscv                    nommu_virt_defconfig
powerpc                 mpc85xx_cds_defconfig
riscv                            allyesconfig
nios2                         10m50_defconfig
mips                         db1xxx_defconfig
openrisc                 simple_smp_defconfig
arm                              alldefconfig
mips                  cavium_octeon_defconfig
powerpc                  storcenter_defconfig
arm                         palmz72_defconfig
mips                     loongson2k_defconfig
arc                              alldefconfig
mips                      pistachio_defconfig
sh                        sh7757lcr_defconfig
ia64                          tiger_defconfig
arm                         lubbock_defconfig
powerpc                     mpc512x_defconfig
mips                       lemote2f_defconfig
mips                           mtx1_defconfig
arm                      pxa255-idp_defconfig
arm                           spitz_defconfig
arm                        vexpress_defconfig
arm                           viper_defconfig
sh                         ap325rxa_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                       bmips_be_defconfig
arm                          simpad_defconfig
arm                  colibri_pxa300_defconfig
powerpc                       eiger_defconfig
powerpc                      pmac32_defconfig
powerpc                 mpc8315_rdb_defconfig
parisc                              defconfig
powerpc                      bamboo_defconfig
powerpc                       ppc64_defconfig
arc                        nsimosci_defconfig
powerpc                         ps3_defconfig
sh                           se7206_defconfig
powerpc                    gamecube_defconfig
mips                      maltasmvp_defconfig
m68k                        stmark2_defconfig
xtensa                           allyesconfig
arm                           corgi_defconfig
arm                           omap1_defconfig
arm                         nhk8815_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
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
x86_64               randconfig-a002-20210604
x86_64               randconfig-a004-20210604
x86_64               randconfig-a003-20210604
x86_64               randconfig-a006-20210604
x86_64               randconfig-a005-20210604
x86_64               randconfig-a001-20210604
i386                 randconfig-a003-20210603
i386                 randconfig-a006-20210603
i386                 randconfig-a004-20210603
i386                 randconfig-a001-20210603
i386                 randconfig-a005-20210603
i386                 randconfig-a002-20210603
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
i386                 randconfig-a013-20210603
i386                 randconfig-a011-20210603
i386                 randconfig-a016-20210603
i386                 randconfig-a014-20210603
i386                 randconfig-a012-20210603
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
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
