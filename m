Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890CC35278E
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Apr 2021 10:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhDBIpT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Apr 2021 04:45:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:24402 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDBIpS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 2 Apr 2021 04:45:18 -0400
IronPort-SDR: agvTldmymptn1KlCnOIX14c5nHCsqko/NQ3J+bvX9i+3EBaZU0xEPSidEoFzjiqqD3S/mmBr7e
 ijsexPxGeLUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="172456802"
X-IronPort-AV: E=Sophos;i="5.81,299,1610438400"; 
   d="scan'208";a="172456802"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 01:45:17 -0700
IronPort-SDR: ugiHXIQmJcQHqdxIPp6xXZx+cmxfWbo1j+c25qQx7GjtXaPIEDfZGWCabNz5OKt34b/tFfs6Vs
 qohUlizse8Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,299,1610438400"; 
   d="scan'208";a="385158031"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 02 Apr 2021 01:45:14 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lSFQX-00071Y-CC; Fri, 02 Apr 2021 08:45:13 +0000
Date:   Fri, 02 Apr 2021 16:44:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 704d68f5f2df46f7195a62bc21014e71a7f67a99
Message-ID: <6066d987.GN1KQY9we0AQs8Ty%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 704d68f5f2df46f7195a62bc21014e71a7f67a99  RDMA/hns: Reorganize doorbell update interfaces for all queues

elapsed time: 729m

configs tested: 174
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
xtensa                generic_kc705_defconfig
sh                            titan_defconfig
arm                      footbridge_defconfig
arm                             ezx_defconfig
arm                        trizeps4_defconfig
arm                       aspeed_g4_defconfig
riscv                    nommu_k210_defconfig
m68k                          amiga_defconfig
alpha                            alldefconfig
arm                           sama5_defconfig
sh                         apsh4a3a_defconfig
arm                           omap1_defconfig
arm                           h5000_defconfig
powerpc                   bluestone_defconfig
sh                          rsk7264_defconfig
powerpc                      ppc64e_defconfig
mips                         tb0226_defconfig
powerpc                     tqm8548_defconfig
sh                           se7619_defconfig
mips                     cu1830-neo_defconfig
mips                     cu1000-neo_defconfig
mips                      pistachio_defconfig
riscv                          rv32_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     redwood_defconfig
parisc                generic-32bit_defconfig
mips                            gpr_defconfig
powerpc                     tqm8540_defconfig
sh                     magicpanelr2_defconfig
m68k                             allmodconfig
arm                       omap2plus_defconfig
arm                        spear6xx_defconfig
arm                          pcm027_defconfig
arm                        oxnas_v6_defconfig
arm                         shannon_defconfig
xtensa                  audio_kc705_defconfig
powerpc                      acadia_defconfig
powerpc                     mpc512x_defconfig
sh                   rts7751r2dplus_defconfig
arm                             pxa_defconfig
mips                        workpad_defconfig
nios2                         10m50_defconfig
arm                          iop32x_defconfig
ia64                             alldefconfig
m68k                          hp300_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                        mvme16x_defconfig
arc                        nsim_700_defconfig
arm                         lpc32xx_defconfig
powerpc                     tqm8560_defconfig
powerpc                      tqm8xx_defconfig
mips                           ip27_defconfig
m68k                       bvme6000_defconfig
arm                        cerfcube_defconfig
m68k                           sun3_defconfig
arm                            pleb_defconfig
mips                          malta_defconfig
arm                        magician_defconfig
ia64                      gensparse_defconfig
arm                       spear13xx_defconfig
h8300                       h8s-sim_defconfig
um                                allnoconfig
arm                          badge4_defconfig
mips                      loongson3_defconfig
arc                     nsimosci_hs_defconfig
arm                     eseries_pxa_defconfig
arm                     am200epdkit_defconfig
h8300                    h8300h-sim_defconfig
sh                          lboxre2_defconfig
mips                        qi_lb60_defconfig
mips                       rbtx49xx_defconfig
arm                           tegra_defconfig
powerpc                       maple_defconfig
powerpc                     rainier_defconfig
sh                        dreamcast_defconfig
mips                            e55_defconfig
riscv                               defconfig
mips                        vocore2_defconfig
s390                                defconfig
powerpc                 mpc8315_rdb_defconfig
sh                        edosk7760_defconfig
sh                         ecovec24_defconfig
mips                      maltaaprp_defconfig
powerpc                       eiger_defconfig
ia64                         bigsur_defconfig
xtensa                       common_defconfig
arm                          ixp4xx_defconfig
mips                         tb0219_defconfig
mips                malta_qemu_32r6_defconfig
arm                           corgi_defconfig
m68k                       m5208evb_defconfig
mips                       capcella_defconfig
arm                          exynos_defconfig
ia64                             allyesconfig
powerpc                 mpc837x_rdb_defconfig
mips                           ci20_defconfig
powerpc                  iss476-smp_defconfig
sh                           se7750_defconfig
arm                         lpc18xx_defconfig
arm                          moxart_defconfig
s390                             allyesconfig
um                               allmodconfig
arm                         palmz72_defconfig
sh                           sh2007_defconfig
arm                      jornada720_defconfig
ia64                             allmodconfig
ia64                                defconfig
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
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210401
i386                 randconfig-a003-20210401
i386                 randconfig-a001-20210401
i386                 randconfig-a004-20210401
i386                 randconfig-a002-20210401
i386                 randconfig-a005-20210401
x86_64               randconfig-a014-20210401
x86_64               randconfig-a015-20210401
x86_64               randconfig-a011-20210401
x86_64               randconfig-a013-20210401
x86_64               randconfig-a012-20210401
x86_64               randconfig-a016-20210401
i386                 randconfig-a014-20210401
i386                 randconfig-a011-20210401
i386                 randconfig-a016-20210401
i386                 randconfig-a012-20210401
i386                 randconfig-a013-20210401
i386                 randconfig-a015-20210401
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210401
x86_64               randconfig-a005-20210401
x86_64               randconfig-a003-20210401
x86_64               randconfig-a001-20210401
x86_64               randconfig-a002-20210401
x86_64               randconfig-a006-20210401

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
