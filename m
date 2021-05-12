Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C066D37EE38
	for <lists+linux-rdma@lfdr.de>; Thu, 13 May 2021 00:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbhELVNI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 17:13:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:22803 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377354AbhELTDv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 May 2021 15:03:51 -0400
IronPort-SDR: vm4k5lnXbW29CHavfXO7SzVscYzC/+GF3EYLRKNWSxj9CdskGJrEaPM35AkUHqPZHhcY+O297D
 Mmp1z4CVNzxQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="220763006"
X-IronPort-AV: E=Sophos;i="5.82,295,1613462400"; 
   d="scan'208";a="220763006"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 12:02:42 -0700
IronPort-SDR: B9VBkB/DPW2I/PHYMGFedcCHPqOwACkAQnjzJ9e6UlklXUZwroSAHRYCYMx0LfPc53DUwYB918
 18h7LiMkvekw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,295,1613462400"; 
   d="scan'208";a="435338063"
Received: from lkp-server01.sh.intel.com (HELO 1e931876798f) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 May 2021 12:02:40 -0700
Received: from kbuild by 1e931876798f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lgu7z-0000Rx-Pd; Wed, 12 May 2021 19:02:39 +0000
Date:   Thu, 13 May 2021 03:01:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 620ccaaa46d1fa9e6d15d78deaa37a4228772592
Message-ID: <609c261a.GFsppoejm3igUVl6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 620ccaaa46d1fa9e6d15d78deaa37a4228772592  IB/hfi1: Delete an unneeded bool conversion

elapsed time: 735m

configs tested: 182
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         tb0287_defconfig
m68k                          sun3x_defconfig
mips                          rb532_defconfig
arm                      jornada720_defconfig
arm                          imote2_defconfig
mips                            ar7_defconfig
arm64                            alldefconfig
powerpc                     mpc512x_defconfig
openrisc                 simple_smp_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                      pcm030_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                            hisi_defconfig
powerpc                     tqm8560_defconfig
mips                        nlm_xlp_defconfig
openrisc                  or1klitex_defconfig
m68k                          amiga_defconfig
mips                           xway_defconfig
sh                           se7712_defconfig
arm                          collie_defconfig
powerpc                     ppa8548_defconfig
powerpc                      obs600_defconfig
mips                     decstation_defconfig
arm                           sunxi_defconfig
powerpc                    sam440ep_defconfig
arm                       mainstone_defconfig
mips                           jazz_defconfig
powerpc                        warp_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                    socrates_defconfig
arm                         s5pv210_defconfig
arm                        magician_defconfig
arm                         mv78xx0_defconfig
arm                       aspeed_g4_defconfig
mips                      malta_kvm_defconfig
parisc                generic-32bit_defconfig
powerpc                     sequoia_defconfig
sh                           se7619_defconfig
riscv                    nommu_k210_defconfig
powerpc                     powernv_defconfig
arc                            hsdk_defconfig
arm                          iop32x_defconfig
mips                        workpad_defconfig
arm                         bcm2835_defconfig
arm                        spear6xx_defconfig
arc                          axs101_defconfig
powerpc                      ep88xc_defconfig
mips                        jmr3927_defconfig
um                            kunit_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                          rsk7203_defconfig
powerpc                    klondike_defconfig
arm                            dove_defconfig
mips                      maltasmvp_defconfig
m68k                       m5475evb_defconfig
mips                      bmips_stb_defconfig
arm                          ep93xx_defconfig
mips                        nlm_xlr_defconfig
riscv                               defconfig
sh                          rsk7264_defconfig
powerpc                       holly_defconfig
mips                         mpc30x_defconfig
mips                  decstation_64_defconfig
mips                           ip27_defconfig
ia64                                defconfig
arc                 nsimosci_hs_smp_defconfig
arm                        keystone_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                      tqm8xx_defconfig
arm                            xcep_defconfig
arm                        vexpress_defconfig
sh                         ecovec24_defconfig
parisc                           alldefconfig
powerpc                        fsp2_defconfig
m68k                       m5275evb_defconfig
xtensa                          iss_defconfig
powerpc                 mpc834x_mds_defconfig
mips                     cu1830-neo_defconfig
sh                           se7722_defconfig
riscv                    nommu_virt_defconfig
mips                             allmodconfig
arm                     eseries_pxa_defconfig
m68k                        mvme16x_defconfig
x86_64                           alldefconfig
mips                           ip32_defconfig
sh                            migor_defconfig
h8300                     edosk2674_defconfig
arm                         lpc18xx_defconfig
sparc64                             defconfig
powerpc                     tqm8555_defconfig
sh                            hp6xx_defconfig
arm                         at91_dt_defconfig
powerpc64                           defconfig
arm                          pcm027_defconfig
arm                             rpc_defconfig
arm                         cm_x300_defconfig
mips                           ip28_defconfig
sh                         microdev_defconfig
mips                        bcm47xx_defconfig
arm                           tegra_defconfig
arm                         shannon_defconfig
powerpc                    ge_imp3a_defconfig
sh                            titan_defconfig
sh                   sh7770_generic_defconfig
powerpc                         ps3_defconfig
powerpc                      chrp32_defconfig
sh                           se7343_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210512
x86_64               randconfig-a004-20210512
x86_64               randconfig-a001-20210512
x86_64               randconfig-a005-20210512
x86_64               randconfig-a002-20210512
x86_64               randconfig-a006-20210512
i386                 randconfig-a003-20210512
i386                 randconfig-a001-20210512
i386                 randconfig-a005-20210512
i386                 randconfig-a004-20210512
i386                 randconfig-a002-20210512
i386                 randconfig-a006-20210512
i386                 randconfig-a016-20210512
i386                 randconfig-a014-20210512
i386                 randconfig-a011-20210512
i386                 randconfig-a015-20210512
i386                 randconfig-a012-20210512
i386                 randconfig-a013-20210512
riscv                            allyesconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210512
x86_64               randconfig-a012-20210512
x86_64               randconfig-a011-20210512
x86_64               randconfig-a013-20210512
x86_64               randconfig-a016-20210512
x86_64               randconfig-a014-20210512

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
