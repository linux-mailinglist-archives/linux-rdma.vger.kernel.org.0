Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F38275B2D
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 17:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgIWPJ0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 11:09:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:56918 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgIWPJ0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Sep 2020 11:09:26 -0400
IronPort-SDR: N24wteXN2quGqsCJPTyghkW5PjaYEqpthyUOoy3HA7rCLLgXzOMuhnC1dZZjkXCxEZLsjDMeVo
 Bv2/Eyua89vA==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="225049883"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="225049883"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 08:09:25 -0700
IronPort-SDR: LnR0yqKgdj2o4H/329E+l3I0IUKX82nvbTMNpiLa346MP4wL9CM/evD3MkpPPETL2VG9HeKlqI
 ZLskXg7KKBiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="511028603"
Received: from lkp-server01.sh.intel.com (HELO 9f27196b5390) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 23 Sep 2020 08:09:24 -0700
Received: from kbuild by 9f27196b5390 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kL6OZ-0000CS-T9; Wed, 23 Sep 2020 15:09:23 +0000
Date:   Wed, 23 Sep 2020 23:08:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 f2334964e969762e266a616acf9377f6046470a2
Message-ID: <5f6b64fa.O12VuoB+KWM6t2ee%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: f2334964e969762e266a616acf9377f6046470a2  i40iw: Add support to make destroy QP synchronous

elapsed time: 927m

configs tested: 117
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                         3c120_defconfig
powerpc                     tqm8555_defconfig
arm                          iop32x_defconfig
ia64                         bigsur_defconfig
sh                     magicpanelr2_defconfig
powerpc                       maple_defconfig
sh                             sh03_defconfig
mips                          rm200_defconfig
mips                       bmips_be_defconfig
powerpc                   currituck_defconfig
mips                           gcw0_defconfig
sh                           se7722_defconfig
arm                      tct_hammer_defconfig
powerpc                       ebony_defconfig
arm                          tango4_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      chrp32_defconfig
arm                         axm55xx_defconfig
um                            kunit_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                         shannon_defconfig
arc                          axs101_defconfig
nios2                            alldefconfig
powerpc                      mgcoge_defconfig
arm                        multi_v5_defconfig
sh                             shx3_defconfig
sh                          rsk7269_defconfig
powerpc                     rainier_defconfig
mips                            e55_defconfig
powerpc                        icon_defconfig
arm                        multi_v7_defconfig
arc                        nsimosci_defconfig
arm                           efm32_defconfig
m68k                            q40_defconfig
powerpc                 mpc8313_rdb_defconfig
m68k                       m5249evb_defconfig
powerpc                      cm5200_defconfig
mips                   sb1250_swarm_defconfig
sh                                  defconfig
arm                         lpc18xx_defconfig
mips                           ip27_defconfig
sh                   sh7724_generic_defconfig
arm                         mv78xx0_defconfig
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
i386                 randconfig-a002-20200923
i386                 randconfig-a006-20200923
i386                 randconfig-a003-20200923
i386                 randconfig-a004-20200923
i386                 randconfig-a005-20200923
i386                 randconfig-a001-20200923
x86_64               randconfig-a011-20200923
x86_64               randconfig-a013-20200923
x86_64               randconfig-a014-20200923
x86_64               randconfig-a015-20200923
x86_64               randconfig-a012-20200923
x86_64               randconfig-a016-20200923
i386                 randconfig-a012-20200923
i386                 randconfig-a014-20200923
i386                 randconfig-a016-20200923
i386                 randconfig-a013-20200923
i386                 randconfig-a011-20200923
i386                 randconfig-a015-20200923
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
x86_64               randconfig-a005-20200923
x86_64               randconfig-a003-20200923
x86_64               randconfig-a004-20200923
x86_64               randconfig-a002-20200923
x86_64               randconfig-a006-20200923
x86_64               randconfig-a001-20200923

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
