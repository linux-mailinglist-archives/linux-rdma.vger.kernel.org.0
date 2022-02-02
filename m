Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6514A6CD1
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Feb 2022 09:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240383AbiBBIVu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Feb 2022 03:21:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:54887 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239508AbiBBIVu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Feb 2022 03:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643790110; x=1675326110;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Wa0ccGUpniUQ9r21e+WMmxkdlsp6d5EkwUsQ/bOfaVI=;
  b=bBGVDRJNa1YPRFKChgRgFFN+G6x48+FGZ7WqN5mHD6mlb6yQNRhRx+Nn
   DkTMbZBvVWJtUw/EzFiJoWooOVbjBhe/dvROiILucCeqq+/jx2JBrrT5+
   ZwI7PJa1WOeXgBoBXftWO86+MJksALCfQLq2ba5pFfv9ScpKZm4t6rwel
   z2Tj+ZtSXGq6ghFccLQRGfT6AiNVigwwMrStf9OimsNNj51AnCQH9FMPA
   UgLrQFcFjMPMENrn2+ZyX3FG8tNrY2HVfO1BmaClaEFA93bnwCnbgY9z+
   LHLWBSV+fPrSirJ49yzKGXvrqUXzJXw21GyR4S/gThZvPtJUHAFwPBx00
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="227838481"
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="227838481"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 00:21:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="482737379"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Feb 2022 00:21:48 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFAtf-000ULt-RY; Wed, 02 Feb 2022 08:21:47 +0000
Date:   Wed, 02 Feb 2022 16:20:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 0d9c00117b8a57a361b27f7bd94284c94155f039
Message-ID: <61fa3edf.6F7kIFnR925pwVfN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 0d9c00117b8a57a361b27f7bd94284c94155f039  RDMA/mlx4: remove redundant assignment to variable nreq

elapsed time: 733m

configs tested: 163
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220131
powerpc              randconfig-c003-20220131
arm                            zeus_defconfig
sh                          rsk7269_defconfig
sh                   sh7770_generic_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                 mpc837x_rdb_defconfig
arc                              alldefconfig
powerpc                         ps3_defconfig
arm                          gemini_defconfig
sh                   sh7724_generic_defconfig
arc                         haps_hs_defconfig
mips                           ci20_defconfig
sh                             sh03_defconfig
powerpc                     rainier_defconfig
arm                             rpc_defconfig
arm                          lpd270_defconfig
sh                             espt_defconfig
powerpc                    amigaone_defconfig
powerpc                      ppc6xx_defconfig
arm                        mvebu_v7_defconfig
arc                     nsimosci_hs_defconfig
arm                        trizeps4_defconfig
mips                         rt305x_defconfig
powerpc                    adder875_defconfig
arm                      integrator_defconfig
m68k                        mvme147_defconfig
sh                           se7343_defconfig
mips                           ip32_defconfig
sh                            migor_defconfig
arm                        multi_v7_defconfig
powerpc                      tqm8xx_defconfig
arm                     eseries_pxa_defconfig
um                             i386_defconfig
powerpc                mpc7448_hpc2_defconfig
ia64                      gensparse_defconfig
riscv                    nommu_k210_defconfig
arm                           corgi_defconfig
arm                         s3c6400_defconfig
sparc64                             defconfig
mips                         db1xxx_defconfig
mips                         mpc30x_defconfig
m68k                           sun3_defconfig
powerpc                  iss476-smp_defconfig
m68k                             allmodconfig
sh                          rsk7203_defconfig
sh                        edosk7760_defconfig
sh                           se7721_defconfig
powerpc                     stx_gp3_defconfig
sh                         ecovec24_defconfig
powerpc                      pasemi_defconfig
powerpc                     taishan_defconfig
xtensa                              defconfig
s390                       zfcpdump_defconfig
m68k                       m5475evb_defconfig
sh                          sdk7786_defconfig
arm                        oxnas_v6_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
arm                  randconfig-c002-20220201
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20220131
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
i386                 randconfig-a006-20220131
i386                 randconfig-a005-20220131
i386                 randconfig-a003-20220131
i386                 randconfig-a002-20220131
i386                 randconfig-a001-20220131
i386                 randconfig-a004-20220131
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                randconfig-r042-20220130
arc                  randconfig-r043-20220130
arc                  randconfig-r043-20220131
s390                 randconfig-r044-20220130
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                          rhel-8.3-func

clang tested configs:
riscv                randconfig-c006-20220201
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220201
mips                 randconfig-c004-20220201
i386                          randconfig-c001
arm                  randconfig-c002-20220201
powerpc                 xes_mpc85xx_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                      maltaaprp_defconfig
powerpc                     mpc512x_defconfig
mips                        bcm63xx_defconfig
powerpc                     mpc5200_defconfig
arm                       cns3420vb_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a013-20220131
x86_64               randconfig-a015-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
i386                 randconfig-a011-20220131
i386                 randconfig-a013-20220131
i386                 randconfig-a014-20220131
i386                 randconfig-a012-20220131
i386                 randconfig-a015-20220131
i386                 randconfig-a016-20220131
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131
s390                 randconfig-r044-20220131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
