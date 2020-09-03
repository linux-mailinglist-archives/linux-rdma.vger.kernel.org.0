Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E7325C1DC
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 15:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgICMln (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 08:41:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:9114 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728717AbgICMkx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Sep 2020 08:40:53 -0400
IronPort-SDR: bjewAfXJs31XqTob2qY+tYSu9msI0oJCLv0CvJEQahlgPNjV78ihp8qnh5FIPTQtflbQK9r2vR
 ujauiLvdXXmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="155069476"
X-IronPort-AV: E=Sophos;i="5.76,386,1592895600"; 
   d="scan'208";a="155069476"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 05:40:52 -0700
IronPort-SDR: DYDjFDIrbzQ7pccXEzl1ulvVgMWoUcYRAuS94n1XTMOFN+xKb+NepvtZJ1L/1uQBTV79isaMbG
 4Wokgf3T0eaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,386,1592895600"; 
   d="scan'208";a="284067289"
Received: from lkp-server01.sh.intel.com (HELO f1af165c0d27) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 03 Sep 2020 05:40:51 -0700
Received: from kbuild by f1af165c0d27 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kDoXq-000095-LZ; Thu, 03 Sep 2020 12:40:50 +0000
Date:   Thu, 03 Sep 2020 20:39:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 4f680cb9f1bb6c2b5cd3574533702334709e50ad
Message-ID: <5f50e41e.ieUamkjgXWxz3nEQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 4f680cb9f1bb6c2b5cd3574533702334709e50ad  RDMA/ucma: Fix resource leak on error path

elapsed time: 723m

configs tested: 166
configs skipped: 20

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7206_defconfig
mips                     loongson1b_defconfig
sh                          lboxre2_defconfig
mips                         rt305x_defconfig
nios2                            alldefconfig
sh                          polaris_defconfig
arm                          gemini_defconfig
arc                        nsim_700_defconfig
arm                              zx_defconfig
microblaze                          defconfig
mips                        vocore2_defconfig
mips                      maltasmvp_defconfig
powerpc                      ppc44x_defconfig
m68k                            q40_defconfig
m68k                       m5475evb_defconfig
mips                 pnx8335_stb225_defconfig
mips                             allyesconfig
arm                          badge4_defconfig
arm                            zeus_defconfig
um                             i386_defconfig
mips                         mpc30x_defconfig
c6x                        evmc6474_defconfig
arm                      jornada720_defconfig
m68k                       m5249evb_defconfig
x86_64                           alldefconfig
mips                   sb1250_swarm_defconfig
arm                       imx_v4_v5_defconfig
sh                           se7712_defconfig
mips                          rb532_defconfig
sh                            hp6xx_defconfig
arm                           h5000_defconfig
arm                           sunxi_defconfig
sh                           se7721_defconfig
powerpc                             defconfig
arm                      tct_hammer_defconfig
arm                        mini2440_defconfig
powerpc                          allmodconfig
arm                        shmobile_defconfig
nds32                             allnoconfig
arm                           omap1_defconfig
mips                  decstation_64_defconfig
arc                      axs103_smp_defconfig
arc                              alldefconfig
sh                      rts7751r2d1_defconfig
arm                        mvebu_v5_defconfig
arm                         nhk8815_defconfig
powerpc                      tqm8xx_defconfig
mips                           gcw0_defconfig
arm                          moxart_defconfig
powerpc                    adder875_defconfig
mips                           ip28_defconfig
openrisc                         alldefconfig
arm                          iop32x_defconfig
sh                        sh7785lcr_defconfig
arm                     eseries_pxa_defconfig
arm                           sama5_defconfig
sparc64                             defconfig
powerpc                      pmac32_defconfig
sh                         microdev_defconfig
mips                          malta_defconfig
powerpc                  mpc866_ads_defconfig
arm                       netwinder_defconfig
mips                        workpad_defconfig
c6x                        evmc6457_defconfig
mips                          rm200_defconfig
h8300                            alldefconfig
mips                            gpr_defconfig
mips                     cu1830-neo_defconfig
mips                        omega2p_defconfig
mips                        nlm_xlp_defconfig
arc                              allyesconfig
sh                           se7724_defconfig
arm                         mv78xx0_defconfig
microblaze                      mmu_defconfig
riscv                          rv32_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20200903
x86_64               randconfig-a006-20200903
x86_64               randconfig-a003-20200903
x86_64               randconfig-a005-20200903
x86_64               randconfig-a001-20200903
x86_64               randconfig-a002-20200903
i386                 randconfig-a004-20200902
i386                 randconfig-a005-20200902
i386                 randconfig-a006-20200902
i386                 randconfig-a002-20200902
i386                 randconfig-a001-20200902
i386                 randconfig-a003-20200902
i386                 randconfig-a004-20200903
i386                 randconfig-a005-20200903
i386                 randconfig-a006-20200903
i386                 randconfig-a002-20200903
i386                 randconfig-a001-20200903
i386                 randconfig-a003-20200903
x86_64               randconfig-a013-20200902
x86_64               randconfig-a016-20200902
x86_64               randconfig-a011-20200902
x86_64               randconfig-a012-20200902
x86_64               randconfig-a015-20200902
x86_64               randconfig-a014-20200902
i386                 randconfig-a016-20200902
i386                 randconfig-a015-20200902
i386                 randconfig-a011-20200902
i386                 randconfig-a013-20200902
i386                 randconfig-a014-20200902
i386                 randconfig-a012-20200902
i386                 randconfig-a016-20200903
i386                 randconfig-a015-20200903
i386                 randconfig-a011-20200903
i386                 randconfig-a013-20200903
i386                 randconfig-a014-20200903
i386                 randconfig-a012-20200903
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20200902
x86_64               randconfig-a003-20200902
x86_64               randconfig-a005-20200902
x86_64               randconfig-a001-20200902
x86_64               randconfig-a002-20200902
x86_64               randconfig-a006-20200902
x86_64               randconfig-a013-20200903
x86_64               randconfig-a016-20200903
x86_64               randconfig-a011-20200903
x86_64               randconfig-a012-20200903
x86_64               randconfig-a015-20200903
x86_64               randconfig-a014-20200903

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
