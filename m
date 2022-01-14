Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24AF48E69E
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jan 2022 09:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbiANIgh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jan 2022 03:36:37 -0500
Received: from mga14.intel.com ([192.55.52.115]:34019 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234295AbiANIgg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Jan 2022 03:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642149396; x=1673685396;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1x1FCLzhqwaK0NdthjnHjX2QBQEyfMbB30DB7I1A67o=;
  b=Q0vfnJVQ+soO4pzjqySxU/LBFEsJwhGEi5y99Tyy+jGi/kvaUPnyv4q4
   BcfJlT0lVZtiy4IeB6BgFJ5CspS/fg3z+E4aRpJrnIhuyEXujkk71tFZI
   yOgLlhpStK6dK9lFkZ3brRlL8R2RXOV/tlI7rCpXD57s/IYNfWYv9Wneq
   yNutEOKNGe2XD2snEQNEVtoj4vhzv1yGyoBo2RBT57Xv0Uowrseo6d548
   qweP/eMBa/GKHIFv0Uw/jrqSjG6NDyDk/tr/UxaygWee4Gxx+BfVj3iec
   EVmI1emT0torWfood6ud8BnhhShy0SA3nav7iNUbxv5VQefUYAluNk8WY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="244409837"
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="244409837"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 00:36:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,288,1635231600"; 
   d="scan'208";a="620910747"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jan 2022 00:36:35 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n8I4Y-0008JJ-NU; Fri, 14 Jan 2022 08:36:34 +0000
Date:   Fri, 14 Jan 2022 16:35:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 c0fe82baaeb2719f910359684c0817057f79a84a
Message-ID: <61e135d4.FVxEvsywXR2gnXxg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: c0fe82baaeb2719f910359684c0817057f79a84a  Merge tag 'v5.16' into rdma.git for-next

elapsed time: 724m

configs tested: 146
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
arm                          gemini_defconfig
arm                         at91_dt_defconfig
nios2                         10m50_defconfig
sparc64                             defconfig
mips                        bcm47xx_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                        mvme16x_defconfig
powerpc                     tqm8555_defconfig
arm                            hisi_defconfig
powerpc                      tqm8xx_defconfig
arm                         lpc18xx_defconfig
powerpc                      pcm030_defconfig
arm                         s3c6400_defconfig
arm                         axm55xx_defconfig
arm                           h5000_defconfig
powerpc                    amigaone_defconfig
arc                        nsim_700_defconfig
sh                        sh7757lcr_defconfig
sh                          landisk_defconfig
csky                             alldefconfig
xtensa                          iss_defconfig
arm                           sunxi_defconfig
powerpc                      pasemi_defconfig
sh                               j2_defconfig
arc                              alldefconfig
mips                           ci20_defconfig
arm                          iop32x_defconfig
mips                         tb0226_defconfig
arm                            mps2_defconfig
arm                          lpd270_defconfig
riscv                            allmodconfig
arm                            qcom_defconfig
arm                            pleb_defconfig
ia64                        generic_defconfig
sh                   rts7751r2dplus_defconfig
sh                   sh7724_generic_defconfig
mips                         db1xxx_defconfig
powerpc                     mpc83xx_defconfig
mips                        vocore2_defconfig
openrisc                    or1ksim_defconfig
s390                          debug_defconfig
sh                          rsk7264_defconfig
sh                          r7785rp_defconfig
arm                            xcep_defconfig
sh                           se7343_defconfig
sh                                  defconfig
i386                             alldefconfig
sh                          sdk7786_defconfig
arm                           tegra_defconfig
sh                         microdev_defconfig
powerpc                       ppc64_defconfig
m68k                             allmodconfig
sh                              ul2_defconfig
arm                  randconfig-c002-20220113
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
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220113
arc                  randconfig-r043-20220113
s390                 randconfig-r044-20220113
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220113
x86_64                        randconfig-c007
riscv                randconfig-c006-20220113
powerpc              randconfig-c003-20220113
i386                          randconfig-c001
mips                 randconfig-c004-20220113
mips                           ip28_defconfig
arm                          pxa168_defconfig
powerpc                     powernv_defconfig
powerpc                        icon_defconfig
mips                        bcm63xx_defconfig
arm                          ixp4xx_defconfig
powerpc                     mpc5200_defconfig
mips                            e55_defconfig
powerpc                 mpc836x_mds_defconfig
riscv                             allnoconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220113
hexagon              randconfig-r041-20220113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
