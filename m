Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089242A3F0E
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 09:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgKCIiv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 03:38:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:64744 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbgKCIiv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Nov 2020 03:38:51 -0500
IronPort-SDR: 4RjstmhNBgG/ez0nIPVsQr2wfBKOVsA68lfSK7CbhN9QCPfTWp0BNRZYxfqaHBcW0MNU/D9/nb
 VsWH4Ui/ZHcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="169123449"
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="169123449"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 00:38:50 -0800
IronPort-SDR: QclZlu7XlSX9k4KN0mo0mIFXYSKL3UBK8sTecRV9GNWVqE7yaAvGfeFDFgyaELQ+wTR2LO1Ew4
 pUpyyWYE7zFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="320352663"
Received: from lkp-server02.sh.intel.com (HELO e61783667810) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Nov 2020 00:38:49 -0800
Received: from kbuild by e61783667810 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kZrq4-000078-Ea; Tue, 03 Nov 2020 08:38:48 +0000
Date:   Tue, 03 Nov 2020 16:38:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 2f3f202afa371f9211df308d443dfd1b90177c39
Message-ID: <5fa116f8.iwkQHiAhDOmkpM/f%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 2f3f202afa371f9211df308d443dfd1b90177c39  IB/mlx5: Add support for NDR link speed

elapsed time: 722m

configs tested: 188
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7269_defconfig
arm                      tct_hammer_defconfig
arm                            xcep_defconfig
sh                   rts7751r2dplus_defconfig
mips                      maltasmvp_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                 mpc8272_ads_defconfig
um                           x86_64_defconfig
arm64                            alldefconfig
sh                        sh7763rdp_defconfig
xtensa                              defconfig
powerpc               mpc834x_itxgp_defconfig
mips                       rbtx49xx_defconfig
arm                          exynos_defconfig
arm                        neponset_defconfig
arm                        oxnas_v6_defconfig
arc                     nsimosci_hs_defconfig
sh                           se7750_defconfig
arm                         at91_dt_defconfig
arm                              zx_defconfig
sh                           se7343_defconfig
sh                            hp6xx_defconfig
powerpc                      makalu_defconfig
sh                          polaris_defconfig
sh                           se7724_defconfig
m68k                             allmodconfig
m68k                       bvme6000_defconfig
ia64                            zx1_defconfig
m68k                        mvme16x_defconfig
mips                        bcm47xx_defconfig
mips                            gpr_defconfig
powerpc                 mpc837x_mds_defconfig
arm                        shmobile_defconfig
m68k                        m5407c3_defconfig
mips                        qi_lb60_defconfig
arm                            u300_defconfig
powerpc                          allmodconfig
mips                     loongson1b_defconfig
powerpc                      arches_defconfig
arm                         lpc32xx_defconfig
m68k                        mvme147_defconfig
powerpc                     redwood_defconfig
mips                      bmips_stb_defconfig
arm                         lubbock_defconfig
arm                        vexpress_defconfig
powerpc                     mpc512x_defconfig
arm                         axm55xx_defconfig
parisc                           alldefconfig
powerpc                    socrates_defconfig
powerpc                 mpc834x_mds_defconfig
arm                     davinci_all_defconfig
arm                       omap2plus_defconfig
sh                             sh03_defconfig
arm                      pxa255-idp_defconfig
sh                          sdk7780_defconfig
powerpc                       eiger_defconfig
m68k                          multi_defconfig
xtensa                generic_kc705_defconfig
powerpc                      obs600_defconfig
sh                   sh7770_generic_defconfig
csky                                defconfig
nios2                            alldefconfig
c6x                        evmc6472_defconfig
sh                            migor_defconfig
sh                          rsk7264_defconfig
m68k                       m5475evb_defconfig
m68k                        m5307c3_defconfig
mips                           jazz_defconfig
arm                          prima2_defconfig
mips                          rb532_defconfig
powerpc                 mpc832x_rdb_defconfig
m68k                          amiga_defconfig
arc                        nsim_700_defconfig
mips                   sb1250_swarm_defconfig
mips                malta_kvm_guest_defconfig
mips                        jmr3927_defconfig
powerpc                   currituck_defconfig
arm                         socfpga_defconfig
sh                   sh7724_generic_defconfig
powerpc                     powernv_defconfig
mips                  maltasmvp_eva_defconfig
sh                               j2_defconfig
sh                          rsk7201_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                    gamecube_defconfig
powerpc                    sam440ep_defconfig
nds32                               defconfig
arm                       spear13xx_defconfig
arm                          pxa168_defconfig
xtensa                  nommu_kc705_defconfig
arm                          pxa3xx_defconfig
mips                      fuloong2e_defconfig
arm                       cns3420vb_defconfig
arm                  colibri_pxa270_defconfig
m68k                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
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
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201102
i386                 randconfig-a006-20201102
i386                 randconfig-a005-20201102
i386                 randconfig-a001-20201102
i386                 randconfig-a002-20201102
i386                 randconfig-a003-20201102
i386                 randconfig-a004-20201103
i386                 randconfig-a006-20201103
i386                 randconfig-a005-20201103
i386                 randconfig-a001-20201103
i386                 randconfig-a002-20201103
i386                 randconfig-a003-20201103
x86_64               randconfig-a012-20201102
x86_64               randconfig-a015-20201102
x86_64               randconfig-a011-20201102
x86_64               randconfig-a013-20201102
x86_64               randconfig-a014-20201102
x86_64               randconfig-a016-20201102
i386                 randconfig-a013-20201102
i386                 randconfig-a015-20201102
i386                 randconfig-a014-20201102
i386                 randconfig-a016-20201102
i386                 randconfig-a011-20201102
i386                 randconfig-a012-20201102
i386                 randconfig-a013-20201103
i386                 randconfig-a015-20201103
i386                 randconfig-a014-20201103
i386                 randconfig-a016-20201103
i386                 randconfig-a011-20201103
i386                 randconfig-a012-20201103
x86_64               randconfig-a004-20201103
x86_64               randconfig-a005-20201103
x86_64               randconfig-a003-20201103
x86_64               randconfig-a002-20201103
x86_64               randconfig-a006-20201103
x86_64               randconfig-a001-20201103
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201102
x86_64               randconfig-a005-20201102
x86_64               randconfig-a003-20201102
x86_64               randconfig-a002-20201102
x86_64               randconfig-a006-20201102
x86_64               randconfig-a001-20201102
x86_64               randconfig-a012-20201103
x86_64               randconfig-a015-20201103
x86_64               randconfig-a011-20201103
x86_64               randconfig-a013-20201103
x86_64               randconfig-a014-20201103
x86_64               randconfig-a016-20201103

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
