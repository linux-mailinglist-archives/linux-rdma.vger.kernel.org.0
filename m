Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A748270ABB
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 06:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgISEm7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Sep 2020 00:42:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:44232 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgISEm6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 19 Sep 2020 00:42:58 -0400
IronPort-SDR: LrsAWDRNpiiL1yynuKRp63KMocuBRKFs+L1D+GQB9rofJisvMkJ1VY94dSmtOMvyoQir+1xiGd
 LDwR+bY0X+lA==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="224234536"
X-IronPort-AV: E=Sophos;i="5.77,277,1596524400"; 
   d="scan'208";a="224234536"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 21:42:50 -0700
IronPort-SDR: k8S+wRFx0txUEdeVk4j2NBX7I1oUkvH5LeqFbB7ZyoMYqp1hcJzyQCVkOMc4H3GNYKmk286t+9
 OhQn7QrMQwfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,277,1596524400"; 
   d="scan'208";a="381144499"
Received: from lkp-server01.sh.intel.com (HELO a05db971c861) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Sep 2020 21:42:48 -0700
Received: from kbuild by a05db971c861 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kJUi0-0000sd-7e; Sat, 19 Sep 2020 04:42:48 +0000
Date:   Sat, 19 Sep 2020 12:42:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 4aa1615268a8ac2b20096211d3f9ac53874067d7
Message-ID: <5f658c43.YbYhXKoqzQrt2Kq+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-rc
branch HEAD: 4aa1615268a8ac2b20096211d3f9ac53874067d7  RDMA/core: Fix ordering of CQ pool destruction

elapsed time: 730m

configs tested: 171
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                    vdk_hs38_smp_defconfig
xtensa                    smp_lx200_defconfig
powerpc                      acadia_defconfig
arm                        neponset_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          pxa910_defconfig
m68k                          amiga_defconfig
powerpc                 mpc832x_mds_defconfig
ia64                             alldefconfig
riscv                          rv32_defconfig
arm                       imx_v6_v7_defconfig
arm                             rpc_defconfig
arm                            u300_defconfig
c6x                              allyesconfig
arm                       omap2plus_defconfig
m68k                             alldefconfig
mips                          malta_defconfig
mips                        vocore2_defconfig
sh                           se7750_defconfig
xtensa                         virt_defconfig
arm                           corgi_defconfig
sparc                               defconfig
arm                           efm32_defconfig
powerpc                 mpc8272_ads_defconfig
m68k                         apollo_defconfig
mips                           jazz_defconfig
arm                         s5pv210_defconfig
sparc64                          alldefconfig
mips                           ip28_defconfig
m68k                       m5208evb_defconfig
s390                             allyesconfig
powerpc                      arches_defconfig
xtensa                              defconfig
arm                        spear3xx_defconfig
nios2                         3c120_defconfig
powerpc                      pcm030_defconfig
sh                        sh7763rdp_defconfig
c6x                                 defconfig
mips                           rs90_defconfig
powerpc                      ppc40x_defconfig
sh                      rts7751r2d1_defconfig
sh                          urquell_defconfig
powerpc                     rainier_defconfig
arm                            hisi_defconfig
powerpc                        cell_defconfig
arm                  colibri_pxa300_defconfig
mips                  maltasmvp_eva_defconfig
sh                         microdev_defconfig
alpha                               defconfig
riscv                             allnoconfig
arm                    vt8500_v6_v7_defconfig
arm                         mv78xx0_defconfig
arm                          badge4_defconfig
mips                      loongson3_defconfig
m68k                        stmark2_defconfig
sh                           se7780_defconfig
powerpc                     tqm5200_defconfig
powerpc                    klondike_defconfig
arc                         haps_hs_defconfig
arm                          lpd270_defconfig
arm                          simpad_defconfig
mips                           ci20_defconfig
arm                          moxart_defconfig
parisc                           alldefconfig
powerpc                 linkstation_defconfig
mips                     decstation_defconfig
sh                        edosk7760_defconfig
powerpc                     tqm8541_defconfig
sh                          kfr2r09_defconfig
sparc64                             defconfig
arm                          ixp4xx_defconfig
arc                     nsimosci_hs_defconfig
mips                        omega2p_defconfig
arm                       versatile_defconfig
arm                            mps2_defconfig
powerpc                        icon_defconfig
mips                        jmr3927_defconfig
mips                       rbtx49xx_defconfig
mips                        nlm_xlp_defconfig
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20200917
i386                 randconfig-a006-20200917
i386                 randconfig-a003-20200917
i386                 randconfig-a001-20200917
i386                 randconfig-a002-20200917
i386                 randconfig-a005-20200917
i386                 randconfig-a004-20200918
i386                 randconfig-a001-20200918
i386                 randconfig-a003-20200918
i386                 randconfig-a006-20200918
i386                 randconfig-a002-20200918
i386                 randconfig-a005-20200918
x86_64               randconfig-a014-20200917
x86_64               randconfig-a011-20200917
x86_64               randconfig-a016-20200917
x86_64               randconfig-a012-20200917
x86_64               randconfig-a015-20200917
x86_64               randconfig-a013-20200917
x86_64               randconfig-a011-20200919
x86_64               randconfig-a012-20200919
x86_64               randconfig-a014-20200919
x86_64               randconfig-a016-20200919
x86_64               randconfig-a015-20200919
x86_64               randconfig-a013-20200919
x86_64               randconfig-a004-20200918
x86_64               randconfig-a006-20200918
x86_64               randconfig-a003-20200918
x86_64               randconfig-a002-20200918
x86_64               randconfig-a005-20200918
x86_64               randconfig-a001-20200918
i386                 randconfig-a015-20200917
i386                 randconfig-a014-20200917
i386                 randconfig-a011-20200917
i386                 randconfig-a013-20200917
i386                 randconfig-a016-20200917
i386                 randconfig-a012-20200917
i386                 randconfig-a015-20200918
i386                 randconfig-a011-20200918
i386                 randconfig-a014-20200918
i386                 randconfig-a013-20200918
i386                 randconfig-a012-20200918
i386                 randconfig-a016-20200918
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20200917
x86_64               randconfig-a004-20200917
x86_64               randconfig-a003-20200917
x86_64               randconfig-a002-20200917
x86_64               randconfig-a001-20200917
x86_64               randconfig-a005-20200917

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
