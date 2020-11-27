Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4080F2C603F
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Nov 2020 08:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392598AbgK0G7k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Nov 2020 01:59:40 -0500
Received: from mga06.intel.com ([134.134.136.31]:65328 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392592AbgK0G7j (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Nov 2020 01:59:39 -0500
IronPort-SDR: taRmctzTVePb+dctooxsEiGABNzf1VQpxfRM5+4vvVzmtzploYdvf/CdM30Hm+SNWOO4Te8XGf
 Vd8i4Nx9UZDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9817"; a="233963184"
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="233963184"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 22:59:39 -0800
IronPort-SDR: FN3mwSQtmoFkZJkbXGXV2K4DIVCSvOxQ7b/ZQdmqs7iAHI/hedthVwhIPL9QeoZjbGcUI5cfhZ
 z1phPK/bxYzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="363055102"
Received: from lkp-server02.sh.intel.com (HELO c88ef3cb410b) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2020 22:59:37 -0800
Received: from kbuild by c88ef3cb410b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kiXjF-00000m-6H; Fri, 27 Nov 2020 06:59:37 +0000
Date:   Fri, 27 Nov 2020 14:58:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 17475e104dcb74217c282781817f8f52b46130d3
Message-ID: <5fc0a3ae.Gi09ssUGLlll45da%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-rc
branch HEAD: 17475e104dcb74217c282781817f8f52b46130d3  RDMA/hns: Bugfix for memory window mtpt configuration

elapsed time: 814m

configs tested: 155
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                          axs101_defconfig
mips                      pic32mzda_defconfig
arm                       imx_v6_v7_defconfig
powerpc64                        alldefconfig
sh                   sh7724_generic_defconfig
m68k                        m5307c3_defconfig
csky                             alldefconfig
xtensa                          iss_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                   currituck_defconfig
ia64                            zx1_defconfig
powerpc                     tqm8560_defconfig
sh                           se7721_defconfig
powerpc                      ep88xc_defconfig
powerpc                        fsp2_defconfig
powerpc                      acadia_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                     mpc83xx_defconfig
arm                           viper_defconfig
arc                              allyesconfig
s390                                defconfig
sh                         ap325rxa_defconfig
powerpc                      pasemi_defconfig
mips                         bigsur_defconfig
mips                        omega2p_defconfig
xtensa                       common_defconfig
powerpc                     kilauea_defconfig
xtensa                    xip_kc705_defconfig
parisc                generic-32bit_defconfig
arm                        magician_defconfig
arm                           corgi_defconfig
sh                            titan_defconfig
powerpc                 mpc837x_mds_defconfig
mips                   sb1250_swarm_defconfig
powerpc                    sam440ep_defconfig
powerpc                    amigaone_defconfig
mips                     loongson1b_defconfig
powerpc                    gamecube_defconfig
arm                        cerfcube_defconfig
powerpc                     mpc5200_defconfig
powerpc                      chrp32_defconfig
arm                      tct_hammer_defconfig
powerpc                     rainier_defconfig
m68k                        mvme147_defconfig
riscv                             allnoconfig
mips                         tb0219_defconfig
powerpc                     tqm8555_defconfig
mips                    maltaup_xpa_defconfig
mips                        bcm47xx_defconfig
c6x                                 defconfig
powerpc                      katmai_defconfig
arm                         assabet_defconfig
c6x                        evmc6474_defconfig
mips                        nlm_xlp_defconfig
mips                           ip28_defconfig
powerpc                       eiger_defconfig
powerpc                      ppc44x_defconfig
powerpc                     akebono_defconfig
arm                     davinci_all_defconfig
powerpc                   bluestone_defconfig
mips                          rb532_defconfig
mips                           ip32_defconfig
powerpc                      arches_defconfig
x86_64                           alldefconfig
sh                             shx3_defconfig
powerpc                        cell_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                          pxa3xx_defconfig
mips                       rbtx49xx_defconfig
powerpc                     tqm8540_defconfig
powerpc                     skiroot_defconfig
arm                        trizeps4_defconfig
arm                         nhk8815_defconfig
powerpc                  mpc885_ads_defconfig
sh                         microdev_defconfig
arm                          tango4_defconfig
arc                          axs103_defconfig
mips                     decstation_defconfig
arc                            hsdk_defconfig
powerpc                      ppc40x_defconfig
sh                        dreamcast_defconfig
arm                       spear13xx_defconfig
um                            kunit_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201127
i386                 randconfig-a003-20201127
i386                 randconfig-a002-20201127
i386                 randconfig-a005-20201127
i386                 randconfig-a001-20201127
i386                 randconfig-a006-20201127
x86_64               randconfig-a015-20201127
x86_64               randconfig-a011-20201127
x86_64               randconfig-a014-20201127
x86_64               randconfig-a016-20201127
x86_64               randconfig-a012-20201127
x86_64               randconfig-a013-20201127
i386                 randconfig-a012-20201127
i386                 randconfig-a013-20201127
i386                 randconfig-a011-20201127
i386                 randconfig-a016-20201127
i386                 randconfig-a014-20201127
i386                 randconfig-a015-20201127
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a006-20201127
x86_64               randconfig-a003-20201127
x86_64               randconfig-a004-20201127
x86_64               randconfig-a005-20201127
x86_64               randconfig-a002-20201127
x86_64               randconfig-a001-20201127

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
