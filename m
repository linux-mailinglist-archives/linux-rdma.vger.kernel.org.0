Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008E028848D
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 10:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732436AbgJIIBO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 04:01:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:37285 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732748AbgJIIBF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 9 Oct 2020 04:01:05 -0400
IronPort-SDR: xvGs0hyI6IHov3jup6D/M3pIV0v6Y8Zk1gG42mExUMO6+fOe0viS8r8Tt2yiRjAbUZqJqgz095
 qNDSi62qhblQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="165570727"
X-IronPort-AV: E=Sophos;i="5.77,354,1596524400"; 
   d="scan'208";a="165570727"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 01:00:51 -0700
IronPort-SDR: NFgse6qBtTCQdHdB5/Dmzum2jfrZXRuf0t8g/NdR5RYhkDo1zXVzQ4yBodla6bqlWQgEyiE7wJ
 n7ucmexaKk8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,354,1596524400"; 
   d="scan'208";a="316961485"
Received: from lkp-server02.sh.intel.com (HELO 80eb06af76cf) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Oct 2020 01:00:50 -0700
Received: from kbuild by 80eb06af76cf with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kQnKb-0000JV-BM; Fri, 09 Oct 2020 08:00:49 +0000
Date:   Fri, 09 Oct 2020 16:00:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 f2e7449f175fee0a86fe7bd0fca2695074320801
Message-ID: <5f801892.EuhyX8qdKkS8R0Na%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: f2e7449f175fee0a86fe7bd0fca2695074320801  IB/hfi,rdmavt,qib,opa_vnic: Update MAINTAINERS

elapsed time: 737m

configs tested: 196
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                  colibri_pxa300_defconfig
m68k                       m5475evb_defconfig
mips                      fuloong2e_defconfig
arm                          exynos_defconfig
powerpc                 mpc832x_mds_defconfig
arm                        mvebu_v5_defconfig
arm                           omap1_defconfig
s390                                defconfig
mips                   sb1250_swarm_defconfig
powerpc                  mpc885_ads_defconfig
sh                          rsk7203_defconfig
sh                 kfr2r09-romimage_defconfig
c6x                        evmc6678_defconfig
powerpc                      ppc64e_defconfig
powerpc                        warp_defconfig
arm                       mainstone_defconfig
mips                             allyesconfig
powerpc                     ep8248e_defconfig
powerpc                        fsp2_defconfig
sh                           se7343_defconfig
arm                        clps711x_defconfig
arm                       aspeed_g5_defconfig
arm                              zx_defconfig
sh                          r7785rp_defconfig
powerpc                     kilauea_defconfig
mips                     cu1830-neo_defconfig
powerpc                 mpc832x_rdb_defconfig
m68k                             allmodconfig
sh                   rts7751r2dplus_defconfig
powerpc                        icon_defconfig
sh                          landisk_defconfig
mips                     decstation_defconfig
sparc                               defconfig
powerpc                     pseries_defconfig
arm                       netwinder_defconfig
arm                          ep93xx_defconfig
i386                             alldefconfig
powerpc                 mpc834x_itx_defconfig
m68k                        mvme16x_defconfig
arc                    vdk_hs38_smp_defconfig
arc                          axs103_defconfig
powerpc                    sam440ep_defconfig
m68k                       m5208evb_defconfig
arm                   milbeaut_m10v_defconfig
mips                       rbtx49xx_defconfig
powerpc                 canyonlands_defconfig
arm                          lpd270_defconfig
m68k                        m5307c3_defconfig
m68k                       m5275evb_defconfig
powerpc                     ppa8548_defconfig
openrisc                    or1ksim_defconfig
sh                          rsk7201_defconfig
riscv                             allnoconfig
powerpc                          allyesconfig
sh                           se7724_defconfig
sh                           sh2007_defconfig
sh                        sh7785lcr_defconfig
arc                     haps_hs_smp_defconfig
sh                          r7780mp_defconfig
um                             i386_defconfig
alpha                            allyesconfig
powerpc                     tqm8548_defconfig
sh                   secureedge5410_defconfig
arm                         mv78xx0_defconfig
arm                         assabet_defconfig
mips                          ath25_defconfig
mips                           rs90_defconfig
powerpc                       holly_defconfig
arm                      pxa255-idp_defconfig
sh                        edosk7705_defconfig
openrisc                            defconfig
powerpc                      cm5200_defconfig
powerpc                       eiger_defconfig
sh                        sh7757lcr_defconfig
arm                          imote2_defconfig
powerpc                      chrp32_defconfig
arm                         lpc18xx_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                      pic32mzda_defconfig
arm                         s5pv210_defconfig
x86_64                              defconfig
powerpc                   currituck_defconfig
arm                           tegra_defconfig
mips                            gpr_defconfig
mips                      loongson3_defconfig
arm                          collie_defconfig
arm                         nhk8815_defconfig
arm                       aspeed_g4_defconfig
sh                             shx3_defconfig
sh                           se7721_defconfig
arm                        spear3xx_defconfig
openrisc                         alldefconfig
arm                          pxa168_defconfig
arm                    vt8500_v6_v7_defconfig
mips                        qi_lb60_defconfig
c6x                        evmc6472_defconfig
sh                     sh7710voipgw_defconfig
m68k                          multi_defconfig
mips                         tb0219_defconfig
sh                          urquell_defconfig
ia64                        generic_defconfig
ia64                             alldefconfig
arm                        oxnas_v6_defconfig
arm                        trizeps4_defconfig
arm                     davinci_all_defconfig
sh                      rts7751r2d1_defconfig
powerpc                      walnut_defconfig
sparc                            allyesconfig
powerpc                 mpc837x_mds_defconfig
h8300                     edosk2674_defconfig
arm                     eseries_pxa_defconfig
m68k                          amiga_defconfig
mips                           xway_defconfig
sh                              ul2_defconfig
sh                          lboxre2_defconfig
mips                  decstation_64_defconfig
powerpc                     kmeter1_defconfig
powerpc                      obs600_defconfig
mips                       capcella_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201009
i386                 randconfig-a005-20201009
i386                 randconfig-a001-20201009
i386                 randconfig-a004-20201009
i386                 randconfig-a002-20201009
i386                 randconfig-a003-20201009
i386                 randconfig-a006-20201008
i386                 randconfig-a005-20201008
i386                 randconfig-a001-20201008
i386                 randconfig-a004-20201008
i386                 randconfig-a002-20201008
i386                 randconfig-a003-20201008
x86_64               randconfig-a012-20201009
x86_64               randconfig-a015-20201009
x86_64               randconfig-a013-20201009
x86_64               randconfig-a014-20201009
x86_64               randconfig-a011-20201009
x86_64               randconfig-a016-20201009
i386                 randconfig-a015-20201009
i386                 randconfig-a013-20201009
i386                 randconfig-a014-20201009
i386                 randconfig-a016-20201009
i386                 randconfig-a011-20201009
i386                 randconfig-a012-20201009
i386                 randconfig-a015-20201008
i386                 randconfig-a013-20201008
i386                 randconfig-a014-20201008
i386                 randconfig-a016-20201008
i386                 randconfig-a011-20201008
i386                 randconfig-a012-20201008
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201009
x86_64               randconfig-a003-20201009
x86_64               randconfig-a005-20201009
x86_64               randconfig-a001-20201009
x86_64               randconfig-a002-20201009
x86_64               randconfig-a006-20201009

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
