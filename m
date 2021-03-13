Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C550339B9C
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Mar 2021 04:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhCMDpd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Mar 2021 22:45:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:59885 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhCMDpd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Mar 2021 22:45:33 -0500
IronPort-SDR: plKR8j+Y3h0ha6eyNIt3HJ5mcwxwQ0XVNd8XarN09pt33u611UgSHOFIy/itF7sWrqWwxVFDIc
 ulAB1VbK0XEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="168834539"
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="168834539"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 19:45:33 -0800
IronPort-SDR: o4voatuE01vgLzIokeU3RAKzYkTJlJ0mXVf80Pn+lpHYhA19noIBnN0gikUEO7zv2qhWgHH08H
 Ug7JpFB26yUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="589741000"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Mar 2021 19:45:31 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lKvDW-0001n7-Uv; Sat, 13 Mar 2021 03:45:30 +0000
Date:   Sat, 13 Mar 2021 11:44:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 22053df0a3647560e6aa11cb6ddcb0da04f505cc
Message-ID: <604c3536.xRvLf5lZg2Byvttd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 22053df0a3647560e6aa11cb6ddcb0da04f505cc  RDMA/mlx5: Fix typo in destroy_mkey inbox

elapsed time: 846m

configs tested: 169
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
h8300                       h8s-sim_defconfig
arm                       imx_v4_v5_defconfig
powerpc                     tqm8541_defconfig
m68k                       m5475evb_defconfig
arm                             mxs_defconfig
powerpc64                        alldefconfig
arm                         s3c2410_defconfig
powerpc                     mpc512x_defconfig
openrisc                 simple_smp_defconfig
mips                        nlm_xlp_defconfig
mips                   sb1250_swarm_defconfig
arm                             pxa_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                     pseries_defconfig
arm                        mini2440_defconfig
arm                        keystone_defconfig
sh                           se7780_defconfig
sh                   sh7724_generic_defconfig
sh                         microdev_defconfig
parisc                generic-64bit_defconfig
arm                       cns3420vb_defconfig
powerpc                      bamboo_defconfig
sh                          lboxre2_defconfig
sh                          sdk7786_defconfig
sparc                            alldefconfig
m68k                            mac_defconfig
powerpc                      ppc44x_defconfig
h8300                     edosk2674_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          r7785rp_defconfig
arm                          iop32x_defconfig
arm                          badge4_defconfig
sh                         ap325rxa_defconfig
powerpc                      pcm030_defconfig
arm                          ep93xx_defconfig
mips                            gpr_defconfig
arm                          pxa168_defconfig
mips                           ip22_defconfig
arm                       aspeed_g5_defconfig
powerpc                     ep8248e_defconfig
arm                          simpad_defconfig
sh                                  defconfig
powerpc64                           defconfig
xtensa                          iss_defconfig
sh                            hp6xx_defconfig
sh                     sh7710voipgw_defconfig
powerpc                     akebono_defconfig
powerpc                    amigaone_defconfig
x86_64                              defconfig
powerpc                     ppa8548_defconfig
xtensa                  cadence_csp_defconfig
xtensa                         virt_defconfig
m68k                        m5407c3_defconfig
csky                             alldefconfig
sh                           sh2007_defconfig
powerpc                         ps3_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                            ar7_defconfig
arc                            hsdk_defconfig
arm                       multi_v4t_defconfig
sh                        sh7757lcr_defconfig
sh                          kfr2r09_defconfig
arm                      tct_hammer_defconfig
powerpc                  storcenter_defconfig
microblaze                      mmu_defconfig
arm                         s3c6400_defconfig
arm                      footbridge_defconfig
h8300                    h8300h-sim_defconfig
m68k                          hp300_defconfig
powerpc                 linkstation_defconfig
powerpc                      walnut_defconfig
mips                           gcw0_defconfig
m68k                             alldefconfig
sh                             espt_defconfig
powerpc                       eiger_defconfig
sh                           se7705_defconfig
powerpc                 mpc836x_mds_defconfig
arm                       imx_v6_v7_defconfig
mips                          malta_defconfig
mips                        jmr3927_defconfig
mips                       capcella_defconfig
m68k                       bvme6000_defconfig
mips                  maltasmvp_eva_defconfig
mips                           jazz_defconfig
s390                          debug_defconfig
sh                           se7751_defconfig
sparc                       sparc64_defconfig
powerpc                     mpc83xx_defconfig
mips                         tb0226_defconfig
arm                         nhk8815_defconfig
arm                       omap2plus_defconfig
parisc                generic-32bit_defconfig
powerpc                      ppc6xx_defconfig
mips                     cu1830-neo_defconfig
sh                        edosk7705_defconfig
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
parisc                           allyesconfig
s390                                defconfig
s390                             allmodconfig
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
i386                 randconfig-a001-20210312
i386                 randconfig-a005-20210312
i386                 randconfig-a002-20210312
i386                 randconfig-a003-20210312
i386                 randconfig-a004-20210312
i386                 randconfig-a006-20210312
x86_64               randconfig-a011-20210312
x86_64               randconfig-a016-20210312
x86_64               randconfig-a013-20210312
x86_64               randconfig-a014-20210312
x86_64               randconfig-a015-20210312
x86_64               randconfig-a012-20210312
i386                 randconfig-a013-20210312
i386                 randconfig-a016-20210312
i386                 randconfig-a011-20210312
i386                 randconfig-a015-20210312
i386                 randconfig-a014-20210312
i386                 randconfig-a012-20210312
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
