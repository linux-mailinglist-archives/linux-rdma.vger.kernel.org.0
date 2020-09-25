Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A38C27864D
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Sep 2020 13:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgIYLwY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Sep 2020 07:52:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:27074 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbgIYLwY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Sep 2020 07:52:24 -0400
IronPort-SDR: U4jGwX5gyFDmVCFk2xMBLFp4gl/MwOmMwsdciGOL55OioINSPzK+d3ILDopgJLf5sNnBeTl4zB
 oRrnt35EYwiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="140915411"
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="140915411"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 04:39:21 -0700
IronPort-SDR: u0xNA1R9SJtdtn/6Om28+GO/NfV+qihB4OuDeqYpG5VDMqT303Ub6ARKUu4NIoHe0/RkgQoilk
 o7p5Og3rlPSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="512108112"
Received: from lkp-server01.sh.intel.com (HELO 2dda29302fe3) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 25 Sep 2020 04:39:19 -0700
Received: from kbuild by 2dda29302fe3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kLm4N-00004i-7s; Fri, 25 Sep 2020 11:39:19 +0000
Date:   Fri, 25 Sep 2020 19:39:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 30b707886aeb89eee4e6b4e0c1aba9fb50e30a5f
Message-ID: <5f6dd6de.ovqJpDuM3447pWdl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 30b707886aeb89eee4e6b4e0c1aba9fb50e30a5f  RDMA/hns: Support inline data in extented sge space for RC

elapsed time: 871m

configs tested: 157
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7203_defconfig
nios2                         10m50_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                        mvme16x_defconfig
powerpc                       holly_defconfig
sh                          landisk_defconfig
arm                            lart_defconfig
sh                   secureedge5410_defconfig
m68k                        mvme147_defconfig
sh                   rts7751r2dplus_defconfig
sh                ecovec24-romimage_defconfig
arm                      footbridge_defconfig
arm                           h5000_defconfig
powerpc                     tqm8540_defconfig
arc                          axs103_defconfig
powerpc                  mpc885_ads_defconfig
mips                           ci20_defconfig
i386                                defconfig
powerpc                      tqm8xx_defconfig
arm                         bcm2835_defconfig
arm                           stm32_defconfig
arm                          collie_defconfig
mips                         cobalt_defconfig
arm                        clps711x_defconfig
powerpc                      ppc64e_defconfig
xtensa                  audio_kc705_defconfig
h8300                            alldefconfig
arm                        trizeps4_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                      rts7751r2d1_defconfig
mips                        bcm47xx_defconfig
mips                         tb0226_defconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
m68k                         apollo_defconfig
powerpc                          g5_defconfig
mips                           rs90_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     stx_gp3_defconfig
powerpc                   bluestone_defconfig
sh                           se7751_defconfig
mips                       capcella_defconfig
parisc                generic-32bit_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                         hackkit_defconfig
um                           x86_64_defconfig
arm                       netwinder_defconfig
arm                        keystone_defconfig
arc                              alldefconfig
powerpc                      pasemi_defconfig
sh                             sh03_defconfig
mips                          rm200_defconfig
arm                           sunxi_defconfig
arm                          imote2_defconfig
arm                        mini2440_defconfig
arm                         assabet_defconfig
mips                         bigsur_defconfig
mips                     loongson1c_defconfig
m68k                       m5275evb_defconfig
mips                        workpad_defconfig
powerpc                     ep8248e_defconfig
powerpc                     ppa8548_defconfig
powerpc                       maple_defconfig
arm                       omap2plus_defconfig
mips                         db1xxx_defconfig
s390                             allyesconfig
sh                          sdk7786_defconfig
arm                          tango4_defconfig
mips                           mtx1_defconfig
m68k                          atari_defconfig
sh                             shx3_defconfig
mips                      maltasmvp_defconfig
mips                           ip22_defconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200923
i386                 randconfig-a006-20200923
i386                 randconfig-a003-20200923
i386                 randconfig-a004-20200923
i386                 randconfig-a005-20200923
i386                 randconfig-a001-20200923
i386                 randconfig-a002-20200924
i386                 randconfig-a006-20200924
i386                 randconfig-a003-20200924
i386                 randconfig-a004-20200924
i386                 randconfig-a005-20200924
i386                 randconfig-a001-20200924
i386                 randconfig-a002-20200925
i386                 randconfig-a006-20200925
i386                 randconfig-a003-20200925
i386                 randconfig-a004-20200925
i386                 randconfig-a005-20200925
i386                 randconfig-a001-20200925
x86_64               randconfig-a011-20200925
x86_64               randconfig-a013-20200925
x86_64               randconfig-a014-20200925
x86_64               randconfig-a015-20200925
x86_64               randconfig-a012-20200925
x86_64               randconfig-a016-20200925
i386                 randconfig-a012-20200925
i386                 randconfig-a014-20200925
i386                 randconfig-a016-20200925
i386                 randconfig-a013-20200925
i386                 randconfig-a011-20200925
i386                 randconfig-a015-20200925
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
x86_64               randconfig-a005-20200925
x86_64               randconfig-a002-20200925
x86_64               randconfig-a006-20200925
x86_64               randconfig-a001-20200925
x86_64               randconfig-a003-20200925
x86_64               randconfig-a004-20200925

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
