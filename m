Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0272F4C36
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Jan 2021 14:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbhAMN2I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Jan 2021 08:28:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:22390 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbhAMN2I (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Jan 2021 08:28:08 -0500
IronPort-SDR: naHUuEWZ6mfZkacunuWNrw1X1r+mEx5JrkVuUiNg6hsQ2ZzqESAQWlyygXw70c1ZcuO8DcUrx3
 SVmh+YzktdTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="174693839"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="174693839"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 05:27:27 -0800
IronPort-SDR: p8hQXuDkUIOikdVDHoJhS5ttxw8L+HNzamndpugkPewoIXC1L4DxKx6lXTGb/qYmA7tYf5BBvs
 P5SKzY1wj0bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="464902094"
Received: from lkp-server01.sh.intel.com (HELO d5d1a9a2c6bb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jan 2021 05:27:25 -0800
Received: from kbuild by d5d1a9a2c6bb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kzgBJ-0000E6-98; Wed, 13 Jan 2021 13:27:25 +0000
Date:   Wed, 13 Jan 2021 21:27:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 8a48ac7f6c24973863b42d03156d5e34c46c2971
Message-ID: <5ffef52d.i+aSssFeBOtKXYwf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 8a48ac7f6c24973863b42d03156d5e34c46c2971  RDMA/rxe: Fix race in rxe_mcast.c

elapsed time: 772m

configs tested: 193
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc834x_itx_defconfig
sh                          polaris_defconfig
ia64                         bigsur_defconfig
mips                            e55_defconfig
openrisc                 simple_smp_defconfig
xtensa                  nommu_kc705_defconfig
arm                         shannon_defconfig
powerpc                       maple_defconfig
arm                              zx_defconfig
arm                       spear13xx_defconfig
arm                  colibri_pxa300_defconfig
sh                           se7206_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                   lite5200b_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                       lemote2f_defconfig
sh                      rts7751r2d1_defconfig
m68k                        m5272c3_defconfig
sh                            migor_defconfig
powerpc                        icon_defconfig
arm                           corgi_defconfig
arm                     eseries_pxa_defconfig
ia64                          tiger_defconfig
powerpc                      pasemi_defconfig
mips                         bigsur_defconfig
mips                       rbtx49xx_defconfig
c6x                              alldefconfig
mips                     decstation_defconfig
sh                   sh7770_generic_defconfig
arm                            hisi_defconfig
c6x                        evmc6472_defconfig
microblaze                          defconfig
xtensa                  cadence_csp_defconfig
powerpc                    mvme5100_defconfig
m68k                         amcore_defconfig
mips                        bcm47xx_defconfig
sh                          rsk7264_defconfig
m68k                         apollo_defconfig
m68k                            mac_defconfig
mips                      pistachio_defconfig
arm                          pxa910_defconfig
arm                         nhk8815_defconfig
mips                        workpad_defconfig
h8300                     edosk2674_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                           xway_defconfig
arc                           tb10x_defconfig
sh                           se7721_defconfig
arm                         axm55xx_defconfig
m68k                            q40_defconfig
arm                        mini2440_defconfig
powerpc                     tqm8560_defconfig
sh                         ecovec24_defconfig
s390                       zfcpdump_defconfig
xtensa                    smp_lx200_defconfig
h8300                    h8300h-sim_defconfig
arm                       multi_v4t_defconfig
xtensa                generic_kc705_defconfig
mips                      bmips_stb_defconfig
sh                             espt_defconfig
arm                            xcep_defconfig
arm                        oxnas_v6_defconfig
arm                     davinci_all_defconfig
sh                               alldefconfig
sh                          r7780mp_defconfig
arm                        keystone_defconfig
ia64                            zx1_defconfig
mips                      maltaaprp_defconfig
sh                           se7724_defconfig
sh                          urquell_defconfig
sparc                            alldefconfig
arm                        multi_v5_defconfig
powerpc                      pmac32_defconfig
powerpc                     ksi8560_defconfig
nios2                         3c120_defconfig
c6x                        evmc6678_defconfig
powerpc                      bamboo_defconfig
powerpc                     tqm8548_defconfig
c6x                        evmc6457_defconfig
powerpc                    amigaone_defconfig
arc                     haps_hs_smp_defconfig
csky                                defconfig
um                            kunit_defconfig
mips                     cu1830-neo_defconfig
powerpc                     tqm5200_defconfig
mips                      maltasmvp_defconfig
arc                        nsimosci_defconfig
sh                           se7705_defconfig
parisc                              defconfig
m68k                        m5407c3_defconfig
m68k                          atari_defconfig
powerpc                      ep88xc_defconfig
sh                        apsh4ad0a_defconfig
sh                           se7722_defconfig
mips                     loongson1b_defconfig
arm                        magician_defconfig
powerpc                 canyonlands_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                        fsp2_defconfig
m68k                       m5275evb_defconfig
powerpc                      ppc44x_defconfig
arm                            qcom_defconfig
sh                ecovec24-romimage_defconfig
arm                          tango4_defconfig
mips                          ath25_defconfig
sh                           sh2007_defconfig
arm                         socfpga_defconfig
m68k                       m5249evb_defconfig
ia64                        generic_defconfig
mips                  decstation_64_defconfig
arm                        spear6xx_defconfig
arm                         s3c6400_defconfig
powerpc                     pseries_defconfig
arc                              alldefconfig
arc                     nsimosci_hs_defconfig
powerpc                     rainier_defconfig
arm                         lubbock_defconfig
h8300                            alldefconfig
arm                         orion5x_defconfig
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
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
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
x86_64               randconfig-a006-20210113
x86_64               randconfig-a004-20210113
x86_64               randconfig-a001-20210113
x86_64               randconfig-a005-20210113
x86_64               randconfig-a003-20210113
x86_64               randconfig-a002-20210113
i386                 randconfig-a002-20210113
i386                 randconfig-a005-20210113
i386                 randconfig-a006-20210113
i386                 randconfig-a003-20210113
i386                 randconfig-a001-20210113
i386                 randconfig-a004-20210113
i386                 randconfig-a012-20210113
i386                 randconfig-a011-20210113
i386                 randconfig-a016-20210113
i386                 randconfig-a013-20210113
i386                 randconfig-a015-20210113
i386                 randconfig-a014-20210113
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210113
x86_64               randconfig-a012-20210113
x86_64               randconfig-a013-20210113
x86_64               randconfig-a016-20210113
x86_64               randconfig-a014-20210113
x86_64               randconfig-a011-20210113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
