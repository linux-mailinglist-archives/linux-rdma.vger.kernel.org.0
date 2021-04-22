Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D708E368059
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 14:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhDVM1W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 08:27:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:11085 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235875AbhDVM1W (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Apr 2021 08:27:22 -0400
IronPort-SDR: O4+fC1ya/9y88yGl/7pN4AnEiGFxW0EZ1kanyml49ZY+9XeO0z/01hHyCiFEDN/g+l5NZ2P+BQ
 7Ijpz+510r4g==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="195988051"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="195988051"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 05:26:47 -0700
IronPort-SDR: RpSRtHtc+RJN7H2lR5Cop3CMQirIRkNkX1QUApmhdFPqUc1z0FIt2fzDsOwGwnnnMih1rC2ZD7
 k1aJyjQ44Slg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,242,1613462400"; 
   d="scan'208";a="603200925"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Apr 2021 05:26:45 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lZYPs-00049r-Sx; Thu, 22 Apr 2021 12:26:44 +0000
Date:   Thu, 22 Apr 2021 20:26:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 45062f441590810772959d8e1f2b24ba57ce1bd9
Message-ID: <60816b7e.h3XwvhaIuOEAJCWK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 45062f441590810772959d8e1f2b24ba57ce1bd9  RDMA/rxe: Fix a bug in rxe_fill_ip_info()

elapsed time: 723m

configs tested: 109
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                            lart_defconfig
mips                malta_qemu_32r6_defconfig
mips                          malta_defconfig
sh                             shx3_defconfig
powerpc                      ppc44x_defconfig
um                                  defconfig
arm                      footbridge_defconfig
alpha                               defconfig
h8300                    h8300h-sim_defconfig
xtensa                              defconfig
powerpc                  iss476-smp_defconfig
powerpc                     asp8347_defconfig
ia64                          tiger_defconfig
mips                        nlm_xlr_defconfig
mips                  decstation_64_defconfig
arm                         lpc18xx_defconfig
mips                      bmips_stb_defconfig
arm                        mvebu_v7_defconfig
mips                      loongson3_defconfig
xtensa                  nommu_kc705_defconfig
mips                        maltaup_defconfig
mips                        bcm47xx_defconfig
powerpc                 canyonlands_defconfig
arc                        vdk_hs38_defconfig
powerpc                     tqm5200_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                     loongson1b_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210421
x86_64               randconfig-a002-20210421
x86_64               randconfig-a001-20210421
x86_64               randconfig-a005-20210421
x86_64               randconfig-a006-20210421
x86_64               randconfig-a003-20210421
i386                 randconfig-a005-20210421
i386                 randconfig-a002-20210421
i386                 randconfig-a001-20210421
i386                 randconfig-a006-20210421
i386                 randconfig-a004-20210421
i386                 randconfig-a003-20210421
i386                 randconfig-a012-20210421
i386                 randconfig-a014-20210421
i386                 randconfig-a011-20210421
i386                 randconfig-a013-20210421
i386                 randconfig-a015-20210421
i386                 randconfig-a016-20210421
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210421
x86_64               randconfig-a016-20210421
x86_64               randconfig-a011-20210421
x86_64               randconfig-a014-20210421
x86_64               randconfig-a013-20210421
x86_64               randconfig-a012-20210421
x86_64               randconfig-a002-20210422
x86_64               randconfig-a004-20210422
x86_64               randconfig-a001-20210422
x86_64               randconfig-a005-20210422
x86_64               randconfig-a006-20210422
x86_64               randconfig-a003-20210422

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
