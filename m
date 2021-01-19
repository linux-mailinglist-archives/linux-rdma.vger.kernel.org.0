Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598402FBAAC
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 16:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbhASPAb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 10:00:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:6858 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395405AbhASOSY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Jan 2021 09:18:24 -0500
IronPort-SDR: svqlXgVRmczZa98bVoDKhAV59BfOF1ehs+Vc47es0AWiWnVDcGKaERwP+ARWIghN22Au/aoIhg
 +aqRvAWAXo/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="166597693"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="166597693"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 06:15:01 -0800
IronPort-SDR: AK4MZ3YUYlCn63BrXM0JPGNKvikXS7aQKfrik1pbdQ01iAxNcG9ZC7/jOwTBYYHcAT/6QjSVSx
 HhUMqQyD3Z4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="466712198"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2021 06:14:59 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l1rmd-00056O-6o; Tue, 19 Jan 2021 14:14:59 +0000
Date:   Tue, 19 Jan 2021 22:14:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 a372173bf314d374da4dd1155549d8ca7fc44709
Message-ID: <6006e92b.zI1vjitV8ecEHL7Q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: a372173bf314d374da4dd1155549d8ca7fc44709  RDMA/cxgb4: Fix the reported max_recv_sge value

elapsed time: 725m

configs tested: 124
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
powerpc                    amigaone_defconfig
ia64                                defconfig
arm                           tegra_defconfig
arm                          collie_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                  mpc885_ads_defconfig
openrisc                         alldefconfig
arm                           h3600_defconfig
mips                         tb0226_defconfig
powerpc                 canyonlands_defconfig
powerpc                      tqm8xx_defconfig
sh                          polaris_defconfig
s390                             allyesconfig
m68k                        mvme147_defconfig
arm                          tango4_defconfig
powerpc                  iss476-smp_defconfig
s390                       zfcpdump_defconfig
powerpc                      ep88xc_defconfig
powerpc                      mgcoge_defconfig
arm                            xcep_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                         nhk8815_defconfig
h8300                     edosk2674_defconfig
mips                     decstation_defconfig
mips                malta_qemu_32r6_defconfig
arm                         s3c2410_defconfig
sh                              ul2_defconfig
m68k                          multi_defconfig
mips                           xway_defconfig
sparc                       sparc32_defconfig
mips                       lemote2f_defconfig
arm                          imote2_defconfig
arm                       imx_v4_v5_defconfig
mips                      pic32mzda_defconfig
sparc                               defconfig
sh                        sh7763rdp_defconfig
sh                          rsk7201_defconfig
arm                         shannon_defconfig
arm                           efm32_defconfig
arc                      axs103_smp_defconfig
arm                           sama5_defconfig
arm                        mvebu_v7_defconfig
mips                          rm200_defconfig
arm                        magician_defconfig
h8300                               defconfig
openrisc                 simple_smp_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                      tct_hammer_defconfig
mips                           jazz_defconfig
powerpc                     skiroot_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
sparc                            allyesconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210118
i386                 randconfig-a005-20210118
i386                 randconfig-a006-20210118
i386                 randconfig-a001-20210118
i386                 randconfig-a003-20210118
i386                 randconfig-a004-20210118
x86_64               randconfig-a015-20210118
x86_64               randconfig-a013-20210118
x86_64               randconfig-a012-20210118
x86_64               randconfig-a016-20210118
x86_64               randconfig-a011-20210118
x86_64               randconfig-a014-20210118
i386                 randconfig-a011-20210118
i386                 randconfig-a012-20210118
i386                 randconfig-a016-20210118
i386                 randconfig-a015-20210118
i386                 randconfig-a013-20210118
i386                 randconfig-a014-20210118
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                      rhel-8.3-kbuiltin
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210118
x86_64               randconfig-a006-20210118
x86_64               randconfig-a001-20210118
x86_64               randconfig-a003-20210118
x86_64               randconfig-a005-20210118
x86_64               randconfig-a002-20210118

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
