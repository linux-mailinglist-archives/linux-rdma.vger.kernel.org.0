Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B358338D4D
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 13:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhCLMja (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Mar 2021 07:39:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:5892 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhCLMjN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Mar 2021 07:39:13 -0500
IronPort-SDR: /MTfx8VfLr0JEmva0g64F5uaWCNb1/HDV+5kqVvj4oE3qKaTeVrMEVBD3URT7jMfmtEXFpc9dB
 PlwxuY0R38Sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="168741997"
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="168741997"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 04:39:12 -0800
IronPort-SDR: r8Bhr0zWW9wIbCa6kQp920/4pOBNmVM8fW2NIdYLOGjtMoKBgfv+rOq6qfoWeqqVw8vX5mGJH/
 lufCzk0LzH5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="409838465"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 12 Mar 2021 04:39:10 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lKh4P-0001Lr-P2; Fri, 12 Mar 2021 12:39:09 +0000
Date:   Fri, 12 Mar 2021 20:38:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 7610ab57de5616631b664ea31c11bad527810391
Message-ID: <604b60c5.D5jK6sNEV1kDQ2rn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 7610ab57de5616631b664ea31c11bad527810391  RDMA/mlx5: Allow larger pages in DevX umem

elapsed time: 726m

configs tested: 148
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     stx_gp3_defconfig
powerpc                      pmac32_defconfig
powerpc                     mpc512x_defconfig
powerpc                     kilauea_defconfig
powerpc                      ppc44x_defconfig
sh                        edosk7705_defconfig
nds32                            alldefconfig
powerpc                    socrates_defconfig
sh                           se7712_defconfig
arm                          collie_defconfig
riscv                               defconfig
powerpc                    ge_imp3a_defconfig
sh                             sh03_defconfig
arm                             mxs_defconfig
sh                        dreamcast_defconfig
arm                          ixp4xx_defconfig
h8300                               defconfig
arc                          axs101_defconfig
sh                   sh7724_generic_defconfig
m68k                         apollo_defconfig
arm                         lpc32xx_defconfig
m68k                          multi_defconfig
powerpc                     mpc5200_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                      ep88xc_defconfig
sh                        sh7763rdp_defconfig
arm                        neponset_defconfig
sh                 kfr2r09-romimage_defconfig
ia64                          tiger_defconfig
arm                       netwinder_defconfig
arm                        magician_defconfig
mips                        bcm63xx_defconfig
powerpc                      tqm8xx_defconfig
arm                       cns3420vb_defconfig
arc                        nsim_700_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                 mpc832x_rdb_defconfig
arm64                            alldefconfig
sh                          r7785rp_defconfig
arc                           tb10x_defconfig
arm                        keystone_defconfig
arm                        trizeps4_defconfig
sparc                               defconfig
parisc                generic-64bit_defconfig
mips                          malta_defconfig
m68k                        mvme147_defconfig
powerpc                      ppc40x_defconfig
powerpc                     tqm8548_defconfig
arm                         s3c6400_defconfig
mips                        nlm_xlr_defconfig
arm                          iop32x_defconfig
sparc                       sparc32_defconfig
powerpc                 mpc836x_mds_defconfig
xtensa                generic_kc705_defconfig
powerpc                     tqm5200_defconfig
sparc                            allyesconfig
arc                        nsimosci_defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210311
i386                 randconfig-a005-20210311
i386                 randconfig-a003-20210311
i386                 randconfig-a002-20210311
i386                 randconfig-a004-20210311
i386                 randconfig-a006-20210311
x86_64               randconfig-a011-20210312
x86_64               randconfig-a016-20210312
x86_64               randconfig-a013-20210312
x86_64               randconfig-a014-20210312
x86_64               randconfig-a015-20210312
x86_64               randconfig-a012-20210312
i386                 randconfig-a013-20210311
i386                 randconfig-a016-20210311
i386                 randconfig-a011-20210311
i386                 randconfig-a014-20210311
i386                 randconfig-a015-20210311
i386                 randconfig-a012-20210311
i386                 randconfig-a013-20210312
i386                 randconfig-a016-20210312
i386                 randconfig-a011-20210312
i386                 randconfig-a015-20210312
i386                 randconfig-a014-20210312
i386                 randconfig-a012-20210312
x86_64               randconfig-a006-20210311
x86_64               randconfig-a001-20210311
x86_64               randconfig-a005-20210311
x86_64               randconfig-a002-20210311
x86_64               randconfig-a003-20210311
x86_64               randconfig-a004-20210311
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210312
x86_64               randconfig-a001-20210312
x86_64               randconfig-a005-20210312
x86_64               randconfig-a003-20210312
x86_64               randconfig-a002-20210312
x86_64               randconfig-a004-20210312
x86_64               randconfig-a011-20210311
x86_64               randconfig-a016-20210311
x86_64               randconfig-a013-20210311
x86_64               randconfig-a015-20210311
x86_64               randconfig-a014-20210311
x86_64               randconfig-a012-20210311

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
