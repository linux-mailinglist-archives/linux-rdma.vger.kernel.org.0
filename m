Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3778C3DC321
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jul 2021 06:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhGaEOY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 31 Jul 2021 00:14:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:27089 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231630AbhGaEOY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 31 Jul 2021 00:14:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="193485972"
X-IronPort-AV: E=Sophos;i="5.84,283,1620716400"; 
   d="scan'208";a="193485972"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 21:14:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,283,1620716400"; 
   d="scan'208";a="500740177"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jul 2021 21:14:16 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m9gO7-000Ag7-Df; Sat, 31 Jul 2021 04:14:15 +0000
Date:   Sat, 31 Jul 2021 12:14:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 0050a57638ca4d681ff92bee55246bf64a6afe54
Message-ID: <6104ce0f.xRcr2syLuByAj4oa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 0050a57638ca4d681ff92bee55246bf64a6afe54  RDMA/qedr: Improve error logs for rdma_alloc_tid error return

elapsed time: 724m

configs tested: 108
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
i386                 randconfig-c001-20210730
nds32                            alldefconfig
m68k                       m5249evb_defconfig
sh                          r7785rp_defconfig
powerpc                 mpc832x_mds_defconfig
arm                            xcep_defconfig
mips                      pic32mzda_defconfig
mips                          malta_defconfig
h8300                            alldefconfig
arm                          collie_defconfig
powerpc                     ppa8548_defconfig
arm                           sunxi_defconfig
m68k                       bvme6000_defconfig
arm                         assabet_defconfig
arm                           viper_defconfig
mips                           ip28_defconfig
m68k                            q40_defconfig
nios2                         10m50_defconfig
arm                          pcm027_defconfig
powerpc                         wii_defconfig
arc                              alldefconfig
sh                           se7705_defconfig
mips                           mtx1_defconfig
x86_64                           alldefconfig
powerpc                    gamecube_defconfig
powerpc                   currituck_defconfig
powerpc                      chrp32_defconfig
mips                      fuloong2e_defconfig
sh                ecovec24-romimage_defconfig
mips                           rs90_defconfig
arm                      footbridge_defconfig
x86_64                            allnoconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210730
i386                 randconfig-a004-20210730
i386                 randconfig-a003-20210730
i386                 randconfig-a002-20210730
i386                 randconfig-a006-20210730
i386                 randconfig-a001-20210730
x86_64               randconfig-a015-20210730
x86_64               randconfig-a014-20210730
x86_64               randconfig-a013-20210730
x86_64               randconfig-a011-20210730
x86_64               randconfig-a012-20210730
x86_64               randconfig-a016-20210730
i386                 randconfig-a013-20210730
i386                 randconfig-a016-20210730
i386                 randconfig-a012-20210730
i386                 randconfig-a011-20210730
i386                 randconfig-a014-20210730
i386                 randconfig-a015-20210730
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210730
x86_64               randconfig-a001-20210730
x86_64               randconfig-a004-20210730
x86_64               randconfig-a002-20210730
x86_64               randconfig-a003-20210730
x86_64               randconfig-a006-20210730
x86_64               randconfig-a005-20210730

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
