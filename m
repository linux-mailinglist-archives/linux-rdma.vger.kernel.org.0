Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0352B3F37C2
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Aug 2021 02:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbhHUAib (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 20:38:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:47708 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231742AbhHUAib (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Aug 2021 20:38:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="238992897"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="238992897"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 17:37:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="513121251"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Aug 2021 17:37:51 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mHF1C-000VLm-MD; Sat, 21 Aug 2021 00:37:50 +0000
Date:   Sat, 21 Aug 2021 08:37:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 446dee2d09b096ded4dc18ce5898c66e14724c3f
Message-ID: <61204ad4.uHYK2UjIznzGs9UM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 446dee2d09b096ded4dc18ce5898c66e14724c3f  RDMA/hns: Dump detailed driver-specific UCTX

elapsed time: 725m

configs tested: 131
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210820
arm                           u8500_defconfig
m68k                         amcore_defconfig
sh                   sh7770_generic_defconfig
powerpc                     stx_gp3_defconfig
arm                          pxa168_defconfig
mips                           ip28_defconfig
arm                            qcom_defconfig
mips                            ar7_defconfig
powerpc                     rainier_defconfig
sh                          r7780mp_defconfig
sh                           se7724_defconfig
arc                    vdk_hs38_smp_defconfig
sparc                            alldefconfig
arm                          iop32x_defconfig
sh                              ul2_defconfig
arm                     eseries_pxa_defconfig
sh                        sh7763rdp_defconfig
powerpc                   lite5200b_defconfig
mips                       lemote2f_defconfig
powerpc                     kilauea_defconfig
arm                        multi_v7_defconfig
arm                             pxa_defconfig
powerpc                      ep88xc_defconfig
arm                          pcm027_defconfig
mips                          ath25_defconfig
powerpc                     mpc512x_defconfig
sh                                  defconfig
sparc                       sparc32_defconfig
powerpc                      pmac32_defconfig
powerpc                     kmeter1_defconfig
openrisc                    or1ksim_defconfig
i386                             alldefconfig
arm                       mainstone_defconfig
powerpc                 mpc8272_ads_defconfig
arm                            dove_defconfig
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
x86_64               randconfig-a005-20210820
x86_64               randconfig-a006-20210820
x86_64               randconfig-a001-20210820
x86_64               randconfig-a003-20210820
x86_64               randconfig-a004-20210820
x86_64               randconfig-a002-20210820
i386                 randconfig-a006-20210820
i386                 randconfig-a001-20210820
i386                 randconfig-a002-20210820
i386                 randconfig-a005-20210820
i386                 randconfig-a003-20210820
i386                 randconfig-a004-20210820
i386                 randconfig-a011-20210821
i386                 randconfig-a016-20210821
i386                 randconfig-a012-20210821
i386                 randconfig-a014-20210821
i386                 randconfig-a013-20210821
i386                 randconfig-a015-20210821
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
i386                 randconfig-c001-20210821
i386                 randconfig-a006-20210821
i386                 randconfig-a001-20210821
i386                 randconfig-a002-20210821
i386                 randconfig-a005-20210821
i386                 randconfig-a004-20210821
i386                 randconfig-a003-20210821
x86_64               randconfig-a014-20210820
x86_64               randconfig-a016-20210820
x86_64               randconfig-a015-20210820
x86_64               randconfig-a013-20210820
x86_64               randconfig-a012-20210820
x86_64               randconfig-a011-20210820
x86_64               randconfig-a013-20210818
x86_64               randconfig-a011-20210818
x86_64               randconfig-a012-20210818
x86_64               randconfig-a016-20210818
x86_64               randconfig-a014-20210818
x86_64               randconfig-a015-20210818
i386                 randconfig-a011-20210820
i386                 randconfig-a016-20210820
i386                 randconfig-a012-20210820
i386                 randconfig-a014-20210820
i386                 randconfig-a013-20210820
i386                 randconfig-a015-20210820

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
