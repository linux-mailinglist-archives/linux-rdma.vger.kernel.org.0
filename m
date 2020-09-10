Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E066D264530
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Sep 2020 13:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbgIJLLI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Sep 2020 07:11:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:6916 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728970AbgIJKxn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Sep 2020 06:53:43 -0400
IronPort-SDR: h9jv+QE1RecI5HOVkjHwTHCmnVzWGfflFX9Kmpu+KeJ1ssy89Xm3euINoEQfAnlJMvDEulbhKE
 FYfjiV+zKZgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="159458864"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208";a="159458864"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 03:51:38 -0700
IronPort-SDR: i0yGfX0m+/YBQ0Sdq5tqTbOf+Wki2Q0Qgm44A2CvpkVSiZtFB/yQADaY96J5PPli2Gdwko+goy
 mMCYFKlQYsPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208";a="407726332"
Received: from lkp-server01.sh.intel.com (HELO 12ff3cf3f2e9) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Sep 2020 03:51:36 -0700
Received: from kbuild by 12ff3cf3f2e9 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kGKAy-0000q2-4M; Thu, 10 Sep 2020 10:51:36 +0000
Date:   Thu, 10 Sep 2020 18:51:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 7bf5d303007cd3cc835966bc03a8b1949a59c823
Message-ID: <5f5a0515.yxRI4UXku2rhNxub%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-rc
branch HEAD: 7bf5d303007cd3cc835966bc03a8b1949a59c823  RDMA: Restore ability to fail on PD deallocate

elapsed time: 720m

configs tested: 138
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                            zeus_defconfig
powerpc                 linkstation_defconfig
sparc64                             defconfig
mips                             allmodconfig
powerpc                     powernv_defconfig
powerpc                      mgcoge_defconfig
arm                        neponset_defconfig
m68k                        stmark2_defconfig
i386                             allyesconfig
arm                       mainstone_defconfig
mips                           mtx1_defconfig
sh                          r7785rp_defconfig
arc                           tb10x_defconfig
arm                        spear3xx_defconfig
riscv                    nommu_k210_defconfig
m68k                           sun3_defconfig
arm                            u300_defconfig
sh                           se7712_defconfig
m68k                        mvme147_defconfig
m68k                            q40_defconfig
x86_64                           alldefconfig
powerpc                     mpc83xx_defconfig
arm                  colibri_pxa270_defconfig
mips                        nlm_xlp_defconfig
arc                                 defconfig
powerpc                 mpc8272_ads_defconfig
mips                           ip22_defconfig
mips                           ip27_defconfig
riscv                               defconfig
arm                          collie_defconfig
sh                           se7750_defconfig
xtensa                    xip_kc705_defconfig
m68k                       bvme6000_defconfig
arm                         lpc18xx_defconfig
mips                           jazz_defconfig
m68k                       m5249evb_defconfig
parisc                generic-32bit_defconfig
arm                         assabet_defconfig
arm                            dove_defconfig
arm                         ebsa110_defconfig
arc                        vdk_hs38_defconfig
arm                            lart_defconfig
openrisc                         alldefconfig
c6x                         dsk6455_defconfig
mips                 decstation_r4k_defconfig
s390                             allyesconfig
arm                        cerfcube_defconfig
sh                             shx3_defconfig
arm                         cm_x300_defconfig
sh                ecovec24-romimage_defconfig
csky                                defconfig
i386                                defconfig
sh                          polaris_defconfig
m68k                        mvme16x_defconfig
c6x                              allyesconfig
openrisc                 simple_smp_defconfig
sparc                       sparc32_defconfig
mips                      loongson3_defconfig
mips                  maltasmvp_eva_defconfig
alpha                               defconfig
sh                              ul2_defconfig
powerpc                        cell_defconfig
m68k                          multi_defconfig
arm                         nhk8815_defconfig
powerpc                      chrp32_defconfig
arm                           corgi_defconfig
sh                           se7780_defconfig
sh                           se7206_defconfig
mips                          rb532_defconfig
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20200909
x86_64               randconfig-a006-20200909
x86_64               randconfig-a003-20200909
x86_64               randconfig-a001-20200909
x86_64               randconfig-a005-20200909
x86_64               randconfig-a002-20200909
x86_64               randconfig-a004-20200910
x86_64               randconfig-a006-20200910
x86_64               randconfig-a003-20200910
x86_64               randconfig-a002-20200910
x86_64               randconfig-a005-20200910
x86_64               randconfig-a001-20200910
i386                 randconfig-a004-20200909
i386                 randconfig-a005-20200909
i386                 randconfig-a006-20200909
i386                 randconfig-a002-20200909
i386                 randconfig-a001-20200909
i386                 randconfig-a003-20200909
i386                 randconfig-a016-20200909
i386                 randconfig-a015-20200909
i386                 randconfig-a011-20200909
i386                 randconfig-a013-20200909
i386                 randconfig-a014-20200909
i386                 randconfig-a012-20200909
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20200909
x86_64               randconfig-a016-20200909
x86_64               randconfig-a011-20200909
x86_64               randconfig-a012-20200909
x86_64               randconfig-a015-20200909
x86_64               randconfig-a014-20200909

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
