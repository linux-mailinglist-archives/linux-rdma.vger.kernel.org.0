Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE99368CD5
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Apr 2021 07:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhDWFu6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Apr 2021 01:50:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:31575 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhDWFu6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 23 Apr 2021 01:50:58 -0400
IronPort-SDR: BB3vJjmZBC2igGWr9K9GDGAUWq+Lw4MlyqFpujG4AQVj+1qyXqmTizTlMvSSHO/F7ZOq4ugvam
 YAuVgLEHmrzQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="183150757"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="183150757"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 22:50:20 -0700
IronPort-SDR: A1PKZQU7vGJVrrnYdvsFx3PO9YKnfcJYt007DM78n5MBJHSQHfnJeFF9FAUwcQDylcn4SZ9tY7
 39yvZPHWNwYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="385002331"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Apr 2021 22:50:17 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lZohk-0004YE-C6; Fri, 23 Apr 2021 05:50:16 +0000
Date:   Fri, 23 Apr 2021 13:50:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 c6c11ad3ab9fe5eb279479879e3461da99f6fdf0
Message-ID: <6082600f.MXZ3OqjLEb6URTPJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: c6c11ad3ab9fe5eb279479879e3461da99f6fdf0  RDMA/nldev: Add QP numbers to SRQ information

elapsed time: 724m

configs tested: 174
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
x86_64                           allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     redwood_defconfig
m68k                          atari_defconfig
powerpc                      cm5200_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                           mtx1_defconfig
sh                               allmodconfig
ia64                            zx1_defconfig
arm                          lpd270_defconfig
sh                          kfr2r09_defconfig
sh                            titan_defconfig
powerpc                  storcenter_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                         apollo_defconfig
sh                   sh7770_generic_defconfig
um                               allyesconfig
mips                            e55_defconfig
sh                        sh7757lcr_defconfig
sh                          lboxre2_defconfig
powerpc                       maple_defconfig
nds32                             allnoconfig
arm                       aspeed_g5_defconfig
m68k                       m5275evb_defconfig
xtensa                  audio_kc705_defconfig
arc                     nsimosci_hs_defconfig
powerpc                  mpc885_ads_defconfig
mips                          rm200_defconfig
arc                           tb10x_defconfig
powerpc                      acadia_defconfig
sh                                  defconfig
powerpc                       eiger_defconfig
arm                           h5000_defconfig
sh                         microdev_defconfig
powerpc                 mpc832x_mds_defconfig
arm                       spear13xx_defconfig
ia64                             alldefconfig
arm                           sama5_defconfig
mips                malta_qemu_32r6_defconfig
mips                     cu1000-neo_defconfig
arm                           u8500_defconfig
sh                           se7343_defconfig
mips                           ip32_defconfig
sh                        sh7763rdp_defconfig
csky                             alldefconfig
powerpc                  iss476-smp_defconfig
powerpc                     kmeter1_defconfig
arm                     eseries_pxa_defconfig
mips                     decstation_defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc64e_defconfig
arm                          badge4_defconfig
sh                           se7750_defconfig
powerpc                      arches_defconfig
powerpc                   currituck_defconfig
mips                         tb0287_defconfig
arm                          pcm027_defconfig
um                             i386_defconfig
arm                           spitz_defconfig
arm                         nhk8815_defconfig
powerpc                         ps3_defconfig
arm                    vt8500_v6_v7_defconfig
nios2                         3c120_defconfig
arm                          gemini_defconfig
arm                            dove_defconfig
arm                        neponset_defconfig
mips                 decstation_r4k_defconfig
mips                      maltaaprp_defconfig
um                           x86_64_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nios2                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
nds32                               defconfig
csky                                defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
s390                                defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
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
i386                 randconfig-a005-20210423
i386                 randconfig-a002-20210423
i386                 randconfig-a001-20210423
i386                 randconfig-a006-20210423
i386                 randconfig-a004-20210423
i386                 randconfig-a003-20210423
x86_64               randconfig-a015-20210422
x86_64               randconfig-a016-20210422
x86_64               randconfig-a011-20210422
x86_64               randconfig-a014-20210422
x86_64               randconfig-a012-20210422
x86_64               randconfig-a013-20210422
i386                 randconfig-a014-20210421
i386                 randconfig-a015-20210421
i386                 randconfig-a016-20210421
i386                 randconfig-a012-20210421
i386                 randconfig-a011-20210421
i386                 randconfig-a013-20210421
i386                 randconfig-a014-20210422
i386                 randconfig-a012-20210422
i386                 randconfig-a011-20210422
i386                 randconfig-a013-20210422
i386                 randconfig-a015-20210422
i386                 randconfig-a016-20210422
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
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
x86_64               randconfig-a015-20210423
x86_64               randconfig-a016-20210423
x86_64               randconfig-a011-20210423
x86_64               randconfig-a014-20210423
x86_64               randconfig-a012-20210423
x86_64               randconfig-a013-20210423
x86_64               randconfig-a002-20210422
x86_64               randconfig-a004-20210422
x86_64               randconfig-a001-20210422
x86_64               randconfig-a005-20210422
x86_64               randconfig-a006-20210422
x86_64               randconfig-a003-20210422

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
