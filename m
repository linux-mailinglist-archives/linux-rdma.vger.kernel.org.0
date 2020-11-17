Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C00A2B5C50
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Nov 2020 10:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgKQJx0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Nov 2020 04:53:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:25824 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbgKQJxZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Nov 2020 04:53:25 -0500
IronPort-SDR: eMTl5d+3Z6ktfwukGhXrC3Rh6wi+7/09tTULvsLv0h+maVvoIcHpkOlWKf3i66AXqxSbzZJXkz
 pNvbY460Ef8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="170995997"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="170995997"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 01:53:25 -0800
IronPort-SDR: ufFwZ+dNRwDKnUTrBSNPl6EvhRua9alRpZ3QOI+N+lUEOtr2JHLWB63m5dScRLbJ6P8KZ7pLX8
 kL0ZuVDEMUMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="543976550"
Received: from lkp-server01.sh.intel.com (HELO 45561eaec37e) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 17 Nov 2020 01:53:23 -0800
Received: from kbuild by 45561eaec37e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kexfu-00001a-RJ; Tue, 17 Nov 2020 09:53:22 +0000
Date:   Tue, 17 Nov 2020 17:53:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 8a7904a672a1d33c848e5129f886ee69e0773a2e
Message-ID: <5fb39d8d.CVHnTT/zMpZi4B2o%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 8a7904a672a1d33c848e5129f886ee69e0773a2e  RDMA/mlx5: Lower setting the umem's PAS for SRQ

elapsed time: 722m

configs tested: 168
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                            q40_defconfig
m68k                       m5475evb_defconfig
arm                        mini2440_defconfig
arm                        vexpress_defconfig
mips                  decstation_64_defconfig
sh                          rsk7203_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                         bigsur_defconfig
sh                           sh2007_defconfig
mips                        bcm63xx_defconfig
arm                         shannon_defconfig
mips                           gcw0_defconfig
sh                 kfr2r09-romimage_defconfig
arm                          iop32x_defconfig
powerpc                 linkstation_defconfig
mips                          rb532_defconfig
m68k                        mvme147_defconfig
openrisc                    or1ksim_defconfig
sh                          rsk7201_defconfig
mips                          rm200_defconfig
mips                       lemote2f_defconfig
mips                 decstation_r4k_defconfig
powerpc                     ppa8548_defconfig
sh                     magicpanelr2_defconfig
arm                            zeus_defconfig
arm                           omap1_defconfig
arm                        neponset_defconfig
mips                           ip22_defconfig
mips                         tb0219_defconfig
arc                      axs103_smp_defconfig
mips                        qi_lb60_defconfig
m68k                            mac_defconfig
mips                          ath79_defconfig
sh                         ecovec24_defconfig
m68k                          hp300_defconfig
arm                          gemini_defconfig
arm                      tct_hammer_defconfig
mips                        bcm47xx_defconfig
sh                      rts7751r2d1_defconfig
mips                     cu1830-neo_defconfig
mips                            gpr_defconfig
powerpc                        icon_defconfig
sh                           se7721_defconfig
mips                      loongson3_defconfig
powerpc                     stx_gp3_defconfig
arc                     nsimosci_hs_defconfig
mips                        jmr3927_defconfig
powerpc                       holly_defconfig
xtensa                          iss_defconfig
powerpc                     mpc83xx_defconfig
mips                      bmips_stb_defconfig
powerpc                   lite5200b_defconfig
sh                        apsh4ad0a_defconfig
s390                             alldefconfig
arm                           sunxi_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                     powernv_defconfig
arm                            mmp2_defconfig
arm                       cns3420vb_defconfig
arm                         lpc32xx_defconfig
ia64                      gensparse_defconfig
powerpc                    amigaone_defconfig
sh                           se7724_defconfig
arc                    vdk_hs38_smp_defconfig
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
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20201116
x86_64               randconfig-a005-20201116
x86_64               randconfig-a004-20201116
x86_64               randconfig-a002-20201116
x86_64               randconfig-a001-20201116
x86_64               randconfig-a006-20201116
i386                 randconfig-a006-20201116
i386                 randconfig-a005-20201116
i386                 randconfig-a001-20201116
i386                 randconfig-a002-20201116
i386                 randconfig-a004-20201116
i386                 randconfig-a003-20201116
i386                 randconfig-a006-20201115
i386                 randconfig-a005-20201115
i386                 randconfig-a001-20201115
i386                 randconfig-a002-20201115
i386                 randconfig-a004-20201115
i386                 randconfig-a003-20201115
x86_64               randconfig-a015-20201115
x86_64               randconfig-a011-20201115
x86_64               randconfig-a014-20201115
x86_64               randconfig-a013-20201115
x86_64               randconfig-a016-20201115
x86_64               randconfig-a012-20201115
i386                 randconfig-a012-20201116
i386                 randconfig-a014-20201116
i386                 randconfig-a016-20201116
i386                 randconfig-a011-20201116
i386                 randconfig-a015-20201116
i386                 randconfig-a013-20201116
i386                 randconfig-a012-20201117
i386                 randconfig-a014-20201117
i386                 randconfig-a016-20201117
i386                 randconfig-a011-20201117
i386                 randconfig-a015-20201117
i386                 randconfig-a013-20201117
i386                 randconfig-a012-20201115
i386                 randconfig-a014-20201115
i386                 randconfig-a016-20201115
i386                 randconfig-a011-20201115
i386                 randconfig-a015-20201115
i386                 randconfig-a013-20201115
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
x86_64               randconfig-a003-20201115
x86_64               randconfig-a005-20201115
x86_64               randconfig-a004-20201115
x86_64               randconfig-a002-20201115
x86_64               randconfig-a001-20201115
x86_64               randconfig-a006-20201115
x86_64               randconfig-a015-20201116
x86_64               randconfig-a011-20201116
x86_64               randconfig-a014-20201116
x86_64               randconfig-a013-20201116
x86_64               randconfig-a016-20201116
x86_64               randconfig-a012-20201116

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
