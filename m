Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF58476794
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Dec 2021 02:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhLPBx3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 20:53:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:20560 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232680AbhLPBx3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Dec 2021 20:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639619609; x=1671155609;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jPd4xlz4VEculVd2zLIgDN0NFulUIUnNkg0HTOxm/FI=;
  b=e+ba+yLacRXb71mILzaWn50KKyCGgIjNsUR9BijhWbc8/RzpVhfSqo4x
   i9HDdcvLHvwDw5UFLrGNkWkTRm2jWniPf1LR2JVlt/gGDit/oElhD6m5I
   3NvK5Y5QstltcivllOAVBE7McJknrZj8av2e9A/kKx4kC6sx7h/w1IWJi
   QsCFUM3zlt1WQBEYNTHN9F6OH0Ip+SA05p2ZY3IpwWzSe/5zKgDJua+gu
   oBYxHb+XhhxYybKvWXcIe64+im2wCannQXlSN9wpDq7peq7YoSN2boAu0
   Ogog/CG2oh94D2iHeImxydJKWFRsAWe42tpMmxHI/1D/ee4M3NJU7nOln
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="300156067"
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="300156067"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 17:53:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="682741503"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Dec 2021 17:53:27 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxfxW-0002bV-VZ; Thu, 16 Dec 2021 01:53:26 +0000
Date:   Thu, 16 Dec 2021 09:52:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 c8f476da84add618b55352194fdd11caaf87c0a7
Message-ID: <61ba9be3.8XiAHUVIw80MIYV9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: c8f476da84add618b55352194fdd11caaf87c0a7  Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux

elapsed time: 720m

configs tested: 171
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm                              allyesconfig
i386                 randconfig-c001-20211214
mips                 randconfig-c004-20211214
i386                 randconfig-c001-20211215
powerpc                   bluestone_defconfig
arm                          pcm027_defconfig
mips                           rs90_defconfig
h8300                            alldefconfig
powerpc                     mpc512x_defconfig
sh                          rsk7203_defconfig
arm                          moxart_defconfig
arm                      footbridge_defconfig
mips                            gpr_defconfig
sh                     magicpanelr2_defconfig
arm                            zeus_defconfig
s390                             allyesconfig
powerpc                      ppc64e_defconfig
arm                         lpc32xx_defconfig
m68k                          multi_defconfig
arm                         s3c6400_defconfig
arm                           stm32_defconfig
powerpc                       ppc64_defconfig
powerpc                 mpc837x_mds_defconfig
arm                          lpd270_defconfig
m68k                        mvme16x_defconfig
arm                            hisi_defconfig
powerpc                mpc7448_hpc2_defconfig
arc                          axs103_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                   sh7770_generic_defconfig
arm                         palmz72_defconfig
mips                          rb532_defconfig
arm                          exynos_defconfig
sh                         apsh4a3a_defconfig
arm                        mvebu_v5_defconfig
um                                  defconfig
mips                         rt305x_defconfig
arm                           sama5_defconfig
ia64                        generic_defconfig
powerpc64                        alldefconfig
arm                          pxa910_defconfig
powerpc                 mpc837x_rdb_defconfig
m68k                        m5407c3_defconfig
mips                           jazz_defconfig
powerpc                     asp8347_defconfig
m68k                        mvme147_defconfig
xtensa                  nommu_kc705_defconfig
xtensa                    xip_kc705_defconfig
powerpc                 mpc832x_mds_defconfig
arc                        vdk_hs38_defconfig
powerpc                      pcm030_defconfig
sh                             espt_defconfig
mips                          ath79_defconfig
mips                 decstation_r4k_defconfig
powerpc                      tqm8xx_defconfig
arm                          gemini_defconfig
mips                         tb0226_defconfig
sh                              ul2_defconfig
nios2                         10m50_defconfig
powerpc                      arches_defconfig
xtensa                              defconfig
m68k                        stmark2_defconfig
mips                     cu1000-neo_defconfig
powerpc                     rainier_defconfig
powerpc                        cell_defconfig
powerpc                 mpc836x_rdk_defconfig
sparc                               defconfig
powerpc                          g5_defconfig
mips                     loongson1c_defconfig
sh                   rts7751r2dplus_defconfig
arm                       omap2plus_defconfig
mips                          rm200_defconfig
powerpc                        warp_defconfig
powerpc                         wii_defconfig
mips                    maltaup_xpa_defconfig
powerpc                       eiger_defconfig
arm                        neponset_defconfig
powerpc                     kmeter1_defconfig
arm                  randconfig-c002-20211214
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nds32                               defconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211214
x86_64               randconfig-a005-20211214
x86_64               randconfig-a001-20211214
x86_64               randconfig-a002-20211214
x86_64               randconfig-a003-20211214
x86_64               randconfig-a004-20211214
i386                 randconfig-a001-20211214
i386                 randconfig-a002-20211214
i386                 randconfig-a005-20211214
i386                 randconfig-a003-20211214
i386                 randconfig-a006-20211214
i386                 randconfig-a004-20211214
x86_64               randconfig-a011-20211215
x86_64               randconfig-a014-20211215
x86_64               randconfig-a012-20211215
x86_64               randconfig-a013-20211215
x86_64               randconfig-a016-20211215
x86_64               randconfig-a015-20211215
i386                 randconfig-a013-20211215
i386                 randconfig-a011-20211215
i386                 randconfig-a016-20211215
i386                 randconfig-a014-20211215
i386                 randconfig-a015-20211215
i386                 randconfig-a012-20211215
arc                  randconfig-r043-20211214
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20211214
x86_64               randconfig-a014-20211214
x86_64               randconfig-a012-20211214
x86_64               randconfig-a013-20211214
x86_64               randconfig-a015-20211214
x86_64               randconfig-a016-20211214
i386                 randconfig-a013-20211214
i386                 randconfig-a011-20211214
i386                 randconfig-a012-20211214
i386                 randconfig-a014-20211214
i386                 randconfig-a016-20211214
i386                 randconfig-a015-20211214
hexagon              randconfig-r045-20211214
s390                 randconfig-r044-20211214
riscv                randconfig-r042-20211214
hexagon              randconfig-r041-20211214

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
