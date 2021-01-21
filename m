Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DC32FF284
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 18:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388427AbhAURqY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 12:46:24 -0500
Received: from mga03.intel.com ([134.134.136.65]:62081 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389024AbhAURqU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Jan 2021 12:46:20 -0500
IronPort-SDR: Jxp548Me4LDAuK+OpdngLPXou5GbKU6fsG5DJN8gi8zR9vbrYuVzxjGMP3t79cSL+RrA8sXfuP
 lkPE76zxRKeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="179394588"
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="179394588"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 09:45:31 -0800
IronPort-SDR: 2Lr04dwr00PlY0nc84XDe1fO0ASs2adQyerh5p7qssN/TTr+g+sMPVyPvTeiujoBMPTRj2fxtw
 BJaHX38AD0QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="574338323"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jan 2021 09:45:29 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l2e1R-0006eN-1H; Thu, 21 Jan 2021 17:45:29 +0000
Date:   Fri, 22 Jan 2021 01:44:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 f1b0a8ea9f12b8ade0dbe40dd57e4ffa9a30ed93
Message-ID: <6009bd8c.kEtmQY01tHy6ydyf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: f1b0a8ea9f12b8ade0dbe40dd57e4ffa9a30ed93  Revert "RDMA/rxe: Remove VLAN code leftovers from RXE"

elapsed time: 1287m

configs tested: 222
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
alpha                            alldefconfig
arm                           stm32_defconfig
sparc64                             defconfig
arm                   milbeaut_m10v_defconfig
powerpc                     kilauea_defconfig
sh                     magicpanelr2_defconfig
arc                          axs101_defconfig
sh                   sh7770_generic_defconfig
c6x                              alldefconfig
s390                          debug_defconfig
mips                     cu1830-neo_defconfig
arm                          moxart_defconfig
xtensa                    smp_lx200_defconfig
mips                          malta_defconfig
powerpc                     stx_gp3_defconfig
arm                             pxa_defconfig
mips                        maltaup_defconfig
powerpc                  storcenter_defconfig
powerpc                 mpc836x_mds_defconfig
arm                              alldefconfig
arm                       aspeed_g5_defconfig
powerpc                       holly_defconfig
powerpc                         ps3_defconfig
arm                         hackkit_defconfig
powerpc64                           defconfig
m68k                          sun3x_defconfig
ia64                      gensparse_defconfig
sh                            titan_defconfig
arm                        mini2440_defconfig
mips                        nlm_xlr_defconfig
powerpc                 mpc834x_mds_defconfig
xtensa                  cadence_csp_defconfig
h8300                     edosk2674_defconfig
arc                        vdk_hs38_defconfig
arm                        keystone_defconfig
ia64                         bigsur_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      acadia_defconfig
powerpc                       eiger_defconfig
arm                          pxa910_defconfig
m68k                        stmark2_defconfig
arm                        multi_v7_defconfig
arm                    vt8500_v6_v7_defconfig
arm                         cm_x300_defconfig
powerpc                    amigaone_defconfig
openrisc                            defconfig
mips                           ip28_defconfig
sh                               j2_defconfig
arm                         vf610m4_defconfig
arm                        clps711x_defconfig
mips                      malta_kvm_defconfig
m68k                        mvme16x_defconfig
mips                       lemote2f_defconfig
arm                          pcm027_defconfig
arc                        nsim_700_defconfig
m68k                           sun3_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                   sb1250_swarm_defconfig
sh                           se7724_defconfig
mips                     decstation_defconfig
mips                         bigsur_defconfig
xtensa                              defconfig
powerpc                      obs600_defconfig
powerpc                   lite5200b_defconfig
sh                   secureedge5410_defconfig
sparc                       sparc64_defconfig
arm                       multi_v4t_defconfig
sh                        sh7757lcr_defconfig
sparc                               defconfig
h8300                    h8300h-sim_defconfig
powerpc                     ppa8548_defconfig
arm                         nhk8815_defconfig
powerpc                    klondike_defconfig
powerpc                     rainier_defconfig
arm                           corgi_defconfig
powerpc                    adder875_defconfig
powerpc                     powernv_defconfig
mips                           xway_defconfig
arm                           sunxi_defconfig
powerpc                 mpc834x_itx_defconfig
mips                            ar7_defconfig
ia64                        generic_defconfig
mips                        jmr3927_defconfig
riscv                             allnoconfig
c6x                         dsk6455_defconfig
powerpc                     pseries_defconfig
mips                           rs90_defconfig
mips                       bmips_be_defconfig
sh                        edosk7705_defconfig
xtensa                         virt_defconfig
i386                             alldefconfig
arc                     haps_hs_smp_defconfig
sh                        edosk7760_defconfig
sparc64                          alldefconfig
arm                             ezx_defconfig
m68k                         apollo_defconfig
arm                     am200epdkit_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                       spear13xx_defconfig
sh                          rsk7264_defconfig
powerpc                      pasemi_defconfig
sh                          kfr2r09_defconfig
powerpc                    socrates_defconfig
sh                          r7785rp_defconfig
powerpc                      arches_defconfig
powerpc                       ppc64_defconfig
mips                      pistachio_defconfig
powerpc                 mpc837x_mds_defconfig
arm                        oxnas_v6_defconfig
sparc                            alldefconfig
ia64                          tiger_defconfig
powerpc                        cell_defconfig
mips                        nlm_xlp_defconfig
arm                          gemini_defconfig
m68k                        m5407c3_defconfig
mips                           jazz_defconfig
csky                             alldefconfig
arm                         mv78xx0_defconfig
mips                           ip32_defconfig
mips                      maltasmvp_defconfig
mips                           gcw0_defconfig
xtensa                generic_kc705_defconfig
sh                        sh7763rdp_defconfig
powerpc                      ppc6xx_defconfig
mips                           ip22_defconfig
powerpc                 mpc8313_rdb_defconfig
m68k                          atari_defconfig
arm                        cerfcube_defconfig
arm                          ixp4xx_defconfig
powerpc                     kmeter1_defconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210121
x86_64               randconfig-a003-20210121
x86_64               randconfig-a001-20210121
x86_64               randconfig-a005-20210121
x86_64               randconfig-a006-20210121
x86_64               randconfig-a004-20210121
i386                 randconfig-a001-20210121
i386                 randconfig-a002-20210121
i386                 randconfig-a004-20210121
i386                 randconfig-a006-20210121
i386                 randconfig-a005-20210121
i386                 randconfig-a003-20210121
i386                 randconfig-a001-20210120
i386                 randconfig-a002-20210120
i386                 randconfig-a004-20210120
i386                 randconfig-a006-20210120
i386                 randconfig-a005-20210120
i386                 randconfig-a003-20210120
x86_64               randconfig-a012-20210120
x86_64               randconfig-a015-20210120
x86_64               randconfig-a016-20210120
x86_64               randconfig-a011-20210120
x86_64               randconfig-a013-20210120
x86_64               randconfig-a014-20210120
i386                 randconfig-a013-20210120
i386                 randconfig-a011-20210120
i386                 randconfig-a012-20210120
i386                 randconfig-a014-20210120
i386                 randconfig-a015-20210120
i386                 randconfig-a016-20210120
i386                 randconfig-a013-20210121
i386                 randconfig-a011-20210121
i386                 randconfig-a012-20210121
i386                 randconfig-a014-20210121
i386                 randconfig-a015-20210121
i386                 randconfig-a016-20210121
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a002-20210120
x86_64               randconfig-a003-20210120
x86_64               randconfig-a001-20210120
x86_64               randconfig-a005-20210120
x86_64               randconfig-a006-20210120
x86_64               randconfig-a004-20210120

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
