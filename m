Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FDE2DA8B2
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Dec 2020 08:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgLOHmn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Dec 2020 02:42:43 -0500
Received: from mga18.intel.com ([134.134.136.126]:37059 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbgLOHmm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Dec 2020 02:42:42 -0500
IronPort-SDR: IB1lP44ScQkuwy430Zn459UHiyp1t04jfgLXGyPuNh8KtJG0xNYOxcFX5H3RUAHQTbhXSvoYBo
 mXsuH+eXqkqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="162587314"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="162587314"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 23:41:55 -0800
IronPort-SDR: 2lGn0se+sjiKvFB4fuHe+SFTIF3AyrMZQwsdwXXGcjUyyhkmddEeVEAr4YAQp/h6+X9aSJRcId
 k/BfwfRsg3QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="385204196"
Received: from lkp-server02.sh.intel.com (HELO a947d92d0467) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 14 Dec 2020 23:41:54 -0800
Received: from kbuild by a947d92d0467 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kp4y1-0000eo-Bl; Tue, 15 Dec 2020 07:41:53 +0000
Date:   Tue, 15 Dec 2020 15:41:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 e246b7c035d74abfb3507fa10082d0c42cc016c3
Message-ID: <5fd868a7.I8lD0DXB6bRX5Jy5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: e246b7c035d74abfb3507fa10082d0c42cc016c3  RDMA/cma: Don't overwrite sgid_attr after device is released

elapsed time: 722m

configs tested: 160
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                       maple_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                       ebony_defconfig
sh                   secureedge5410_defconfig
m68k                             allmodconfig
mips                        nlm_xlp_defconfig
arc                          axs101_defconfig
sh                           se7206_defconfig
arm                              zx_defconfig
powerpc                      arches_defconfig
arc                              alldefconfig
powerpc                     kmeter1_defconfig
arc                      axs103_smp_defconfig
powerpc                      walnut_defconfig
m68k                          atari_defconfig
powerpc                 mpc8560_ads_defconfig
arm                      tct_hammer_defconfig
arm                       cns3420vb_defconfig
mips                      pistachio_defconfig
arc                        nsimosci_defconfig
mips                         rt305x_defconfig
xtensa                    xip_kc705_defconfig
mips                           xway_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     ppa8548_defconfig
h8300                     edosk2674_defconfig
sh                          sdk7780_defconfig
m68k                           sun3_defconfig
arm                            u300_defconfig
sh                          rsk7269_defconfig
powerpc                   currituck_defconfig
powerpc                     mpc83xx_defconfig
mips                           ip32_defconfig
mips                            gpr_defconfig
powerpc                     tqm8540_defconfig
arm                       omap2plus_defconfig
m68k                             alldefconfig
arm                         socfpga_defconfig
sparc64                             defconfig
arm                      footbridge_defconfig
sh                          rsk7264_defconfig
powerpc                      obs600_defconfig
mips                     cu1000-neo_defconfig
csky                                defconfig
powerpc                      pasemi_defconfig
sh                           se7724_defconfig
powerpc                      ppc40x_defconfig
h8300                               defconfig
sh                            migor_defconfig
mips                      maltaaprp_defconfig
mips                     loongson1b_defconfig
sh                             sh03_defconfig
x86_64                           alldefconfig
arm                      pxa255-idp_defconfig
mips                      bmips_stb_defconfig
mips                     loongson1c_defconfig
powerpc                      pmac32_defconfig
xtensa                         virt_defconfig
sh                        edosk7760_defconfig
mips                       capcella_defconfig
sh                          lboxre2_defconfig
sh                           se7722_defconfig
arm                        spear6xx_defconfig
mips                        nlm_xlr_defconfig
mips                       lemote2f_defconfig
powerpc                          g5_defconfig
arm                           sunxi_defconfig
sh                         ap325rxa_defconfig
arc                                 defconfig
sh                         microdev_defconfig
powerpc64                        alldefconfig
mips                 decstation_r4k_defconfig
mips                  cavium_octeon_defconfig
sh                   sh7724_generic_defconfig
sh                         apsh4a3a_defconfig
sh                           se7619_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
sh                               allmodconfig
parisc                              defconfig
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
i386                 randconfig-a001-20201214
i386                 randconfig-a004-20201214
i386                 randconfig-a003-20201214
i386                 randconfig-a002-20201214
i386                 randconfig-a006-20201214
i386                 randconfig-a005-20201214
i386                 randconfig-a001-20201213
i386                 randconfig-a004-20201213
i386                 randconfig-a003-20201213
i386                 randconfig-a002-20201213
i386                 randconfig-a005-20201213
i386                 randconfig-a006-20201213
x86_64               randconfig-a016-20201214
x86_64               randconfig-a012-20201214
x86_64               randconfig-a013-20201214
x86_64               randconfig-a015-20201214
x86_64               randconfig-a014-20201214
x86_64               randconfig-a011-20201214
i386                 randconfig-a014-20201214
i386                 randconfig-a013-20201214
i386                 randconfig-a012-20201214
i386                 randconfig-a011-20201214
i386                 randconfig-a015-20201214
i386                 randconfig-a016-20201214
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
x86_64               randconfig-a003-20201214
x86_64               randconfig-a006-20201214
x86_64               randconfig-a002-20201214
x86_64               randconfig-a005-20201214
x86_64               randconfig-a004-20201214
x86_64               randconfig-a001-20201214
x86_64               randconfig-a016-20201213
x86_64               randconfig-a012-20201213
x86_64               randconfig-a013-20201213
x86_64               randconfig-a015-20201213
x86_64               randconfig-a014-20201213
x86_64               randconfig-a011-20201213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
