Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5AE2A17F5
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Oct 2020 14:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgJaNps (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 31 Oct 2020 09:45:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:42231 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbgJaNps (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 31 Oct 2020 09:45:48 -0400
IronPort-SDR: AnnL/9b/fp05Zb9HwNQnh1tHay5ZUjxxC4JWOeeQs8t/LqnEsil8RZ++EquKX/GUoNFHc2+s59
 vZVxOjCIVLwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="156503574"
X-IronPort-AV: E=Sophos;i="5.77,437,1596524400"; 
   d="scan'208";a="156503574"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2020 06:45:46 -0700
IronPort-SDR: a3mE++OK43y9NLPGlh4sbVcunYc6RT1anrUiev3QlNOWXKmT+J1q/H2r0PZzlexrXrR5m/7MLo
 LnwZSwHeiwsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,437,1596524400"; 
   d="scan'208";a="324367489"
Received: from lkp-server02.sh.intel.com (HELO ee7b80346e9c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 31 Oct 2020 06:45:45 -0700
Received: from kbuild by ee7b80346e9c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kYrCS-00002v-VK; Sat, 31 Oct 2020 13:45:44 +0000
Date:   Sat, 31 Oct 2020 21:45:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 7e555a0f168f02a4a586aef73be405041781e1e1
Message-ID: <5f9d6a82.+lZI6S3/71N5xiGY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 7e555a0f168f02a4a586aef73be405041781e1e1  RDMA: Convert various random sprintf sysfs _show uses to sysfs_emit

elapsed time: 723m

configs tested: 150
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
sh                 kfr2r09-romimage_defconfig
powerpc                     taishan_defconfig
arm                        magician_defconfig
microblaze                          defconfig
arm                          pxa910_defconfig
i386                             alldefconfig
sh                           se7722_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                        mvme16x_defconfig
mips                      maltasmvp_defconfig
arm                       imx_v4_v5_defconfig
mips                         tb0219_defconfig
s390                             allyesconfig
arm                            xcep_defconfig
powerpc                      ppc6xx_defconfig
sh                             shx3_defconfig
nios2                               defconfig
powerpc                   motionpro_defconfig
arm                     eseries_pxa_defconfig
sh                          r7780mp_defconfig
arm                           omap1_defconfig
powerpc                     kilauea_defconfig
c6x                        evmc6457_defconfig
powerpc                      ep88xc_defconfig
mips                malta_qemu_32r6_defconfig
arm                     am200epdkit_defconfig
mips                       lemote2f_defconfig
riscv                            alldefconfig
sh                          sdk7786_defconfig
arm                        cerfcube_defconfig
h8300                    h8300h-sim_defconfig
sh                            hp6xx_defconfig
arm                          pxa3xx_defconfig
powerpc                       ebony_defconfig
parisc                generic-32bit_defconfig
arm                           h5000_defconfig
microblaze                    nommu_defconfig
powerpc                 mpc8540_ads_defconfig
mips                           mtx1_defconfig
mips                          rm200_defconfig
arc                         haps_hs_defconfig
arm                        multi_v5_defconfig
powerpc                  mpc885_ads_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                          allmodconfig
powerpc                         ps3_defconfig
arm                         socfpga_defconfig
powerpc                 mpc8560_ads_defconfig
m68k                       bvme6000_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                         lubbock_defconfig
mips                        bcm47xx_defconfig
arc                     haps_hs_smp_defconfig
um                             i386_defconfig
arm                        keystone_defconfig
mips                          ath79_defconfig
mips                     loongson1b_defconfig
sparc                            allyesconfig
riscv                               defconfig
arm                       multi_v4t_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20201030
x86_64               randconfig-a001-20201030
x86_64               randconfig-a002-20201030
x86_64               randconfig-a003-20201030
x86_64               randconfig-a006-20201030
x86_64               randconfig-a004-20201030
i386                 randconfig-a005-20201030
i386                 randconfig-a003-20201030
i386                 randconfig-a002-20201030
i386                 randconfig-a001-20201030
i386                 randconfig-a006-20201030
i386                 randconfig-a004-20201030
i386                 randconfig-a005-20201031
i386                 randconfig-a003-20201031
i386                 randconfig-a002-20201031
i386                 randconfig-a001-20201031
i386                 randconfig-a006-20201031
i386                 randconfig-a004-20201031
x86_64               randconfig-a013-20201031
x86_64               randconfig-a014-20201031
x86_64               randconfig-a015-20201031
x86_64               randconfig-a016-20201031
x86_64               randconfig-a011-20201031
x86_64               randconfig-a012-20201031
i386                 randconfig-a011-20201030
i386                 randconfig-a014-20201030
i386                 randconfig-a015-20201030
i386                 randconfig-a012-20201030
i386                 randconfig-a013-20201030
i386                 randconfig-a016-20201030
i386                 randconfig-a011-20201031
i386                 randconfig-a014-20201031
i386                 randconfig-a015-20201031
i386                 randconfig-a012-20201031
i386                 randconfig-a013-20201031
i386                 randconfig-a016-20201031
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20201030
x86_64               randconfig-a014-20201030
x86_64               randconfig-a015-20201030
x86_64               randconfig-a016-20201030
x86_64               randconfig-a011-20201030
x86_64               randconfig-a012-20201030

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
