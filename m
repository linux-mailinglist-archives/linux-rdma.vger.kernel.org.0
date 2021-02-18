Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CB531E73E
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Feb 2021 09:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBRIDs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Feb 2021 03:03:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:59033 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231310AbhBRH7h (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Feb 2021 02:59:37 -0500
IronPort-SDR: 1nCg5lfAWpE/iFJB1M/1Wlg7iAC/cNnF90x5XAb+ED0faKUfpTkbGGwSeDjZyFRAc3CZIp5Iyg
 kiSAUFSZ3QxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="163212163"
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="163212163"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 23:58:32 -0800
IronPort-SDR: B23DN4hAD8FZUTYsljxsCqhccFbFgAH1phmnER0Tm39dreeJqDulytPFEs3k8xLXK5Dz1WrCc1
 /KswyMLxxgQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="427905413"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 17 Feb 2021 23:58:30 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lCeCj-0009X8-SV; Thu, 18 Feb 2021 07:58:29 +0000
Date:   Thu, 18 Feb 2021 15:58:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 ed408529679737a9a7ad816c8de5d59ba104bb11
Message-ID: <602e1e1c.Y2PZR6zuZHpE1zHg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: ed408529679737a9a7ad816c8de5d59ba104bb11  RDMA/rtrs-srv: Do not pass a valid pointer to PTR_ERR()

elapsed time: 723m

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
powerpc                     asp8347_defconfig
arm                        keystone_defconfig
mips                         mpc30x_defconfig
mips                        bcm47xx_defconfig
arm                        trizeps4_defconfig
powerpc                  iss476-smp_defconfig
arm                        multi_v5_defconfig
arm                            u300_defconfig
powerpc                        icon_defconfig
arc                          axs101_defconfig
sh                             espt_defconfig
arm                        realview_defconfig
powerpc                     tqm8548_defconfig
mips                            e55_defconfig
arm                         cm_x300_defconfig
riscv                    nommu_k210_defconfig
c6x                                 defconfig
sh                ecovec24-romimage_defconfig
arm                         lubbock_defconfig
sh                           sh2007_defconfig
arm                           sama5_defconfig
m68k                         amcore_defconfig
sparc                       sparc64_defconfig
m68k                        mvme147_defconfig
mips                        nlm_xlr_defconfig
mips                           ip28_defconfig
arm                         axm55xx_defconfig
arm                            lart_defconfig
mips                       capcella_defconfig
arm                      footbridge_defconfig
powerpc                     mpc83xx_defconfig
sh                                  defconfig
sh                          rsk7264_defconfig
sh                          rsk7269_defconfig
mips                        maltaup_defconfig
powerpc                     sbc8548_defconfig
arm                          imote2_defconfig
powerpc64                           defconfig
arm                       netwinder_defconfig
xtensa                  cadence_csp_defconfig
sh                           se7206_defconfig
sh                         ap325rxa_defconfig
powerpc                    amigaone_defconfig
arm                          badge4_defconfig
riscv                            allmodconfig
arc                         haps_hs_defconfig
x86_64                           alldefconfig
arc                        nsim_700_defconfig
sh                        apsh4ad0a_defconfig
powerpc                         wii_defconfig
powerpc                     mpc512x_defconfig
arm                         shannon_defconfig
x86_64                           allyesconfig
sh                          r7785rp_defconfig
arm                          tango4_defconfig
powerpc                mpc7448_hpc2_defconfig
c6x                        evmc6474_defconfig
arm                       imx_v4_v5_defconfig
arm                     eseries_pxa_defconfig
mips                           xway_defconfig
parisc                generic-64bit_defconfig
arm                           omap1_defconfig
mips                             allyesconfig
powerpc                      katmai_defconfig
arm                        cerfcube_defconfig
arm                         lpc32xx_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                                defconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
i386                               tinyconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210216
i386                 randconfig-a005-20210216
i386                 randconfig-a002-20210216
i386                 randconfig-a006-20210216
i386                 randconfig-a001-20210216
i386                 randconfig-a004-20210216
i386                 randconfig-a003-20210217
i386                 randconfig-a005-20210217
i386                 randconfig-a002-20210217
i386                 randconfig-a006-20210217
i386                 randconfig-a001-20210217
i386                 randconfig-a004-20210217
x86_64               randconfig-a003-20210216
x86_64               randconfig-a002-20210216
x86_64               randconfig-a004-20210216
x86_64               randconfig-a001-20210216
x86_64               randconfig-a005-20210216
x86_64               randconfig-a006-20210216
x86_64               randconfig-a016-20210217
x86_64               randconfig-a015-20210217
x86_64               randconfig-a016-20210215
x86_64               randconfig-a013-20210215
x86_64               randconfig-a012-20210215
x86_64               randconfig-a015-20210215
x86_64               randconfig-a014-20210215
x86_64               randconfig-a011-20210215
x86_64               randconfig-a013-20210217
x86_64               randconfig-a012-20210217
x86_64               randconfig-a014-20210217
x86_64               randconfig-a011-20210217
i386                 randconfig-a016-20210217
i386                 randconfig-a015-20210217
i386                 randconfig-a014-20210217
i386                 randconfig-a012-20210217
i386                 randconfig-a013-20210217
i386                 randconfig-a011-20210217
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                      rhel-8.3-kbuiltin

clang tested configs:
x86_64               randconfig-a003-20210215
x86_64               randconfig-a002-20210215
x86_64               randconfig-a001-20210215
x86_64               randconfig-a004-20210215
x86_64               randconfig-a005-20210215
x86_64               randconfig-a006-20210215

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
