Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A28040E49E
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 19:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245450AbhIPREw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 13:04:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:22328 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348350AbhIPRCe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Sep 2021 13:02:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="222664738"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="222664738"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 09:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="530236958"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 16 Sep 2021 09:54:50 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mQuev-0001De-TO; Thu, 16 Sep 2021 16:54:49 +0000
Date:   Fri, 17 Sep 2021 00:54:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 ad17bbef3dd573da937816edc0ab84fed6a17fa6
Message-ID: <614376cd.2gu6824vD7XtJn/J%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: ad17bbef3dd573da937816edc0ab84fed6a17fa6  RDMA/rxe: remove the unnecessary variable

elapsed time: 2636m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210916
riscv                            alldefconfig
mips                malta_qemu_32r6_defconfig
arm                        mvebu_v5_defconfig
arm                         vf610m4_defconfig
powerpc                      ppc40x_defconfig
sh                          rsk7201_defconfig
powerpc                    amigaone_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                 canyonlands_defconfig
powerpc                     kmeter1_defconfig
sh                     sh7710voipgw_defconfig
arm                         cm_x300_defconfig
sh                          polaris_defconfig
mips                        omega2p_defconfig
arm                        multi_v5_defconfig
arc                          axs103_defconfig
ia64                                defconfig
nios2                            allyesconfig
powerpc                    mvme5100_defconfig
arm                       cns3420vb_defconfig
mips                        nlm_xlr_defconfig
sh                                  defconfig
riscv                    nommu_virt_defconfig
i386                                defconfig
x86_64               randconfig-c001-20210916
arm                  randconfig-c002-20210916
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a016-20210916
x86_64               randconfig-a013-20210916
x86_64               randconfig-a012-20210916
x86_64               randconfig-a011-20210916
x86_64               randconfig-a014-20210916
x86_64               randconfig-a015-20210916
i386                 randconfig-a016-20210916
i386                 randconfig-a015-20210916
i386                 randconfig-a011-20210916
i386                 randconfig-a012-20210916
i386                 randconfig-a013-20210916
i386                 randconfig-a014-20210916
arc                  randconfig-r043-20210915
riscv                randconfig-r042-20210916
s390                 randconfig-r044-20210916
arc                  randconfig-r043-20210916
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20210916
x86_64               randconfig-c007-20210916
mips                 randconfig-c004-20210916
powerpc              randconfig-c003-20210916
arm                  randconfig-c002-20210916
i386                 randconfig-c001-20210916
s390                 randconfig-c005-20210916
x86_64               randconfig-a002-20210916
x86_64               randconfig-a003-20210916
x86_64               randconfig-a006-20210916
x86_64               randconfig-a004-20210916
x86_64               randconfig-a005-20210916
x86_64               randconfig-a001-20210916
i386                 randconfig-a004-20210916
i386                 randconfig-a005-20210916
i386                 randconfig-a006-20210916
i386                 randconfig-a002-20210916
i386                 randconfig-a003-20210916
i386                 randconfig-a001-20210916
riscv                randconfig-r042-20210915
hexagon              randconfig-r045-20210915
s390                 randconfig-r044-20210915
hexagon              randconfig-r041-20210915

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
