Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FDD389EDC
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 09:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhETHYN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 03:24:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:20909 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230102AbhETHYM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 03:24:12 -0400
IronPort-SDR: BRjIPQtStxV+I4cdEOJXJ5pHGrZMqFqeM7vD00lXE2TwZ7JbRtbkeNZ6ZCt9EJ94YBp9RQNEM7
 9GXwkxPmL1uQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="181443517"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="181443517"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 00:22:51 -0700
IronPort-SDR: jI9Q0wzo8WWdgN7/EtzZCGBxAom1oeXQnzTkcXMFricojcqx9j0iJ60u8xoqp/JQgTlU3Iohpi
 MtS3v5fIJwEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="461765977"
Received: from lkp-server02.sh.intel.com (HELO 1b329be5b008) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 20 May 2021 00:22:50 -0700
Received: from kbuild by 1b329be5b008 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ljd17-0000U2-US; Thu, 20 May 2021 07:22:49 +0000
Date:   Thu, 20 May 2021 15:22:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 cfa3b797118eda7d68f9ede9b1a0279192aca653
Message-ID: <60a60e1b.TXG1ZueQiiF48qiz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: cfa3b797118eda7d68f9ede9b1a0279192aca653  RDMA/mlx5: Fix query DCT via DEVX

elapsed time: 723m

configs tested: 181
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     mpc5200_defconfig
openrisc                         alldefconfig
powerpc                      walnut_defconfig
mips                      malta_kvm_defconfig
mips                           mtx1_defconfig
sh                         microdev_defconfig
arm                         socfpga_defconfig
arm                         bcm2835_defconfig
arc                            hsdk_defconfig
powerpc                        icon_defconfig
powerpc                    amigaone_defconfig
arm                             mxs_defconfig
arm64                            alldefconfig
powerpc                      katmai_defconfig
powerpc                       eiger_defconfig
mips                         tb0226_defconfig
arm                        clps711x_defconfig
sh                          sdk7780_defconfig
xtensa                       common_defconfig
sh                              ul2_defconfig
arm                         shannon_defconfig
sh                      rts7751r2d1_defconfig
powerpc                      pasemi_defconfig
powerpc                     powernv_defconfig
mips                        qi_lb60_defconfig
arm                          badge4_defconfig
m68k                       m5208evb_defconfig
arm                          pcm027_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                    adder875_defconfig
ia64                          tiger_defconfig
powerpc                mpc7448_hpc2_defconfig
riscv                            allyesconfig
mips                        workpad_defconfig
powerpc                 mpc834x_itx_defconfig
arm                      tct_hammer_defconfig
mips                         tb0287_defconfig
mips                             allyesconfig
powerpc                      arches_defconfig
mips                          malta_defconfig
powerpc                  storcenter_defconfig
powerpc                       ppc64_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                           ip27_defconfig
powerpc                      ep88xc_defconfig
arm                             rpc_defconfig
arm                         assabet_defconfig
mips                           ci20_defconfig
m68k                        mvme147_defconfig
mips                         cobalt_defconfig
xtensa                         virt_defconfig
sh                         ap325rxa_defconfig
m68k                       m5275evb_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                  mpc885_ads_defconfig
sh                            hp6xx_defconfig
sh                           se7721_defconfig
arc                      axs103_smp_defconfig
arm                           h3600_defconfig
ia64                        generic_defconfig
arm                            hisi_defconfig
powerpc                      ppc40x_defconfig
m68k                            q40_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                   currituck_defconfig
sh                          rsk7269_defconfig
xtensa                    xip_kc705_defconfig
mips                         bigsur_defconfig
arm                         s3c2410_defconfig
m68k                             allyesconfig
sh                          rsk7203_defconfig
arm                           corgi_defconfig
powerpc                 mpc832x_mds_defconfig
arm                      jornada720_defconfig
arm                  colibri_pxa300_defconfig
powerpc                     tqm8541_defconfig
arc                              alldefconfig
powerpc                 mpc834x_mds_defconfig
arc                     haps_hs_smp_defconfig
sh                        apsh4ad0a_defconfig
arm                           viper_defconfig
mips                     cu1000-neo_defconfig
powerpc                      cm5200_defconfig
powerpc                     rainier_defconfig
mips                          rb532_defconfig
arm                          ixp4xx_defconfig
arm                         lpc18xx_defconfig
sh                           se7712_defconfig
powerpc                     taishan_defconfig
sh                        dreamcast_defconfig
arm                        oxnas_v6_defconfig
arc                        vdk_hs38_defconfig
sh                        edosk7760_defconfig
m68k                         amcore_defconfig
xtensa                  audio_kc705_defconfig
ia64                            zx1_defconfig
arm                      integrator_defconfig
powerpc                 mpc836x_mds_defconfig
arc                          axs101_defconfig
sh                          kfr2r09_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                        mvebu_v7_defconfig
powerpc                     stx_gp3_defconfig
arm                           sunxi_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210519
i386                 randconfig-a001-20210519
i386                 randconfig-a005-20210519
i386                 randconfig-a004-20210519
i386                 randconfig-a002-20210519
i386                 randconfig-a006-20210519
x86_64               randconfig-a012-20210519
x86_64               randconfig-a015-20210519
x86_64               randconfig-a013-20210519
x86_64               randconfig-a011-20210519
x86_64               randconfig-a016-20210519
x86_64               randconfig-a014-20210519
i386                 randconfig-a014-20210519
i386                 randconfig-a016-20210519
i386                 randconfig-a011-20210519
i386                 randconfig-a015-20210519
i386                 randconfig-a012-20210519
i386                 randconfig-a013-20210519
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
x86_64               randconfig-b001-20210519
x86_64               randconfig-a003-20210519
x86_64               randconfig-a004-20210519
x86_64               randconfig-a005-20210519
x86_64               randconfig-a001-20210519
x86_64               randconfig-a002-20210519
x86_64               randconfig-a006-20210519

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
