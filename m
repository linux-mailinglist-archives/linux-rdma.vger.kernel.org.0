Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DD636670E
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 10:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbhDUIgR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 04:36:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:46179 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234407AbhDUIgQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Apr 2021 04:36:16 -0400
IronPort-SDR: ABpdjCbP4del6cgMzWz3IZRBw0fEyoPWc0tFNkABI10q55OcmTknF926hb1RpP0GRsfEn02xDm
 QdltHEdJu1Zw==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="256976799"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="256976799"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 01:35:43 -0700
IronPort-SDR: bNBodq6+ymdKC5vgrlRycssP5Z+3pG3iH5fvgu79MTwNDqUb/rXCh1MQ4/8usTqxg6IkCQD5Kq
 Tk1wcePYsHZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="524230546"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2021 01:35:41 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lZ8Kj-0003Vi-2h; Wed, 21 Apr 2021 08:35:41 +0000
Date:   Wed, 21 Apr 2021 16:35:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 04d64b2b08b740cb41ee98ef59340ff377dbd1f6
Message-ID: <607fe3c0.RXl1cl6vF5/HWPgB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 04d64b2b08b740cb41ee98ef59340ff377dbd1f6  RDMA/mlx5: Fix type assignment for ICM DM

elapsed time: 721m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
riscv                            allyesconfig
mips                           gcw0_defconfig
sh                           se7724_defconfig
mips                     decstation_defconfig
sh                          r7785rp_defconfig
m68k                        m5272c3_defconfig
mips                           xway_defconfig
sh                           se7721_defconfig
i386                             alldefconfig
m68k                        mvme16x_defconfig
um                             i386_defconfig
arm                        magician_defconfig
m68k                          multi_defconfig
mips                      maltaaprp_defconfig
m68k                        m5407c3_defconfig
arm                       multi_v4t_defconfig
sh                             shx3_defconfig
mips                        bcm63xx_defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210420
i386                 randconfig-a002-20210420
i386                 randconfig-a001-20210420
i386                 randconfig-a006-20210420
i386                 randconfig-a004-20210420
i386                 randconfig-a003-20210420
x86_64               randconfig-a015-20210420
x86_64               randconfig-a016-20210420
x86_64               randconfig-a011-20210420
x86_64               randconfig-a014-20210420
x86_64               randconfig-a013-20210420
x86_64               randconfig-a012-20210420
i386                 randconfig-a012-20210420
i386                 randconfig-a014-20210420
i386                 randconfig-a011-20210420
i386                 randconfig-a013-20210420
i386                 randconfig-a015-20210420
i386                 randconfig-a016-20210420
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                      rhel-8.3-kbuiltin
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210420
x86_64               randconfig-a002-20210420
x86_64               randconfig-a001-20210420
x86_64               randconfig-a005-20210420
x86_64               randconfig-a006-20210420
x86_64               randconfig-a003-20210420

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
