Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155DA25D053
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Sep 2020 06:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgIDEVw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 00:21:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:45346 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbgIDEVw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Sep 2020 00:21:52 -0400
IronPort-SDR: C5xR1TpOJfnAIqrbk+VegAjC6JGJMlDpS/mFZ6qY7AKrg8CzREQqky1hksGnKEq+rG0TYHqtP6
 RlPQy33fYntg==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="156955511"
X-IronPort-AV: E=Sophos;i="5.76,388,1592895600"; 
   d="scan'208";a="156955511"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 21:21:51 -0700
IronPort-SDR: rgUMSATEPurm/JEqZjIhLRmIVsLoR4rbb6SY+VKDQqXVyQta3skIKAMw486XmL9cThWTdbK3Tc
 yGr4JAplYxsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,388,1592895600"; 
   d="scan'208";a="503321249"
Received: from lkp-server01.sh.intel.com (HELO 217b9320e422) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Sep 2020 21:21:49 -0700
Received: from kbuild by 217b9320e422 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kE3ES-00000v-0M; Fri, 04 Sep 2020 04:21:48 +0000
Date:   Fri, 04 Sep 2020 12:20:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 00b3c11879d790f51cac6477abe870936a2323ae
Message-ID: <5f51c0a7.StBwA83hBMotSFod%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 00b3c11879d790f51cac6477abe870936a2323ae  RDMA/rxe: Convert tasklets to use new tasklet_setup() API

elapsed time: 740m

configs tested: 156
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         cm_x300_defconfig
xtensa                generic_kc705_defconfig
sparc                               defconfig
arm                           spitz_defconfig
powerpc                      pmac32_defconfig
arm                       cns3420vb_defconfig
arm                         vf610m4_defconfig
ia64                         bigsur_defconfig
xtensa                           alldefconfig
arm                  colibri_pxa300_defconfig
powerpc                     powernv_defconfig
arm                            lart_defconfig
sh                          rsk7203_defconfig
mips                      fuloong2e_defconfig
mips                            ar7_defconfig
arm                         lpc32xx_defconfig
powerpc                        cell_defconfig
mips                        workpad_defconfig
openrisc                         alldefconfig
powerpc                      ep88xc_defconfig
arm                           viper_defconfig
um                            kunit_defconfig
sh                          r7780mp_defconfig
powerpc                          g5_defconfig
um                             i386_defconfig
sh                            shmin_defconfig
powerpc                         ps3_defconfig
powerpc                    mvme5100_defconfig
sh                           se7780_defconfig
c6x                        evmc6457_defconfig
mips                     decstation_defconfig
arm                        multi_v5_defconfig
arc                     nsimosci_hs_defconfig
sh                         ap325rxa_defconfig
arc                                 defconfig
powerpc                       ppc64_defconfig
arm                         palmz72_defconfig
sh                           se7724_defconfig
sh                           se7343_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                    vt8500_v6_v7_defconfig
alpha                            alldefconfig
x86_64                              defconfig
sh                               alldefconfig
powerpc                     ep8248e_defconfig
arm                          imote2_defconfig
sh                          urquell_defconfig
powerpc64                           defconfig
mips                        nlm_xlr_defconfig
powerpc                     mpc512x_defconfig
mips                         tb0287_defconfig
powerpc                       maple_defconfig
powerpc                      ppc64e_defconfig
openrisc                 simple_smp_defconfig
sh                   sh7724_generic_defconfig
mips                           mtx1_defconfig
arm                           stm32_defconfig
arm                            hisi_defconfig
microblaze                    nommu_defconfig
sh                          lboxre2_defconfig
arm                        spear6xx_defconfig
arc                             nps_defconfig
arm                        keystone_defconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
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
i386                 randconfig-a016-20200903
i386                 randconfig-a015-20200903
i386                 randconfig-a011-20200903
i386                 randconfig-a013-20200903
i386                 randconfig-a014-20200903
i386                 randconfig-a012-20200903
i386                 randconfig-a016-20200902
i386                 randconfig-a015-20200902
i386                 randconfig-a011-20200902
i386                 randconfig-a013-20200902
i386                 randconfig-a014-20200902
i386                 randconfig-a012-20200902
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20200902
x86_64               randconfig-a006-20200902
x86_64               randconfig-a003-20200902
x86_64               randconfig-a005-20200902
x86_64               randconfig-a001-20200902
x86_64               randconfig-a002-20200902
x86_64               randconfig-a013-20200903
x86_64               randconfig-a016-20200903
x86_64               randconfig-a011-20200903
x86_64               randconfig-a012-20200903
x86_64               randconfig-a015-20200903
x86_64               randconfig-a014-20200903

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
