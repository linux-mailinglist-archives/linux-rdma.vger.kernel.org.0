Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85AE2FB893
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 15:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387843AbhASNOz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 08:14:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:37975 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387620AbhASJga (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Jan 2021 04:36:30 -0500
IronPort-SDR: dwQZ65p34u/LAVf9q1Y/PgymgJyHahuOwx3qDvg5Cnvm75ass+JfW+IGsxyfiVkZlIwJOsZfER
 EXELC1q8w6pQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="176330049"
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; 
   d="scan'208";a="176330049"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 01:35:39 -0800
IronPort-SDR: H41XFZFbH6QlMXu1x2ldgmM5JsWmuaQDtp8SodmmWz8EEBWK4EkeshHSjAgISSeqNaeZUFU9X5
 UV9xZKpMbY/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; 
   d="scan'208";a="347124241"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jan 2021 01:35:37 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l1nQG-0004xX-D3; Tue, 19 Jan 2021 09:35:36 +0000
Date:   Tue, 19 Jan 2021 17:34:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 7fbc3c373eefc291ff96d48496106c106b7f81c6
Message-ID: <6006a7b3.w21dsKw2KoOxKhaJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 7fbc3c373eefc291ff96d48496106c106b7f81c6  RDMA/rtrs: Fix KASAN: stack-out-of-bounds bug

elapsed time: 762m

configs tested: 135
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc836x_rdk_defconfig
openrisc                            defconfig
arm                         lubbock_defconfig
sh                 kfr2r09-romimage_defconfig
sparc                            allyesconfig
sparc64                             defconfig
arm                          pxa910_defconfig
powerpc                         ps3_defconfig
arm                     am200epdkit_defconfig
mips                      loongson3_defconfig
ia64                             alldefconfig
powerpc                 xes_mpc85xx_defconfig
arm                         s3c6400_defconfig
arm                         lpc32xx_defconfig
sh                           sh2007_defconfig
powerpc                     kmeter1_defconfig
nds32                               defconfig
arm                          gemini_defconfig
um                           x86_64_defconfig
arc                     nsimosci_hs_defconfig
s390                       zfcpdump_defconfig
powerpc                      ep88xc_defconfig
powerpc                      mgcoge_defconfig
arm                            xcep_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                         nhk8815_defconfig
arm                       imx_v4_v5_defconfig
mips                      pic32mzda_defconfig
sparc                               defconfig
sh                        sh7763rdp_defconfig
sh                          rsk7201_defconfig
powerpc                    sam440ep_defconfig
powerpc                    mvme5100_defconfig
powerpc                      ppc64e_defconfig
arc                              alldefconfig
mips                        vocore2_defconfig
arm                      jornada720_defconfig
arm                            zeus_defconfig
mips                      bmips_stb_defconfig
arm                            hisi_defconfig
arm                         vf610m4_defconfig
arm                        shmobile_defconfig
arm                       netwinder_defconfig
parisc                generic-32bit_defconfig
powerpc                      katmai_defconfig
powerpc                     tqm8548_defconfig
h8300                               defconfig
arm                      tct_hammer_defconfig
mips                           jazz_defconfig
powerpc                     skiroot_defconfig
xtensa                generic_kc705_defconfig
powerpc                     tqm5200_defconfig
m68k                         amcore_defconfig
arm                             ezx_defconfig
xtensa                       common_defconfig
sh                            hp6xx_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                               tinyconfig
i386                                defconfig
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
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210118
x86_64               randconfig-a006-20210118
x86_64               randconfig-a001-20210118
x86_64               randconfig-a003-20210118
x86_64               randconfig-a005-20210118
x86_64               randconfig-a002-20210118
x86_64               randconfig-a015-20210119
x86_64               randconfig-a013-20210119
x86_64               randconfig-a012-20210119
x86_64               randconfig-a016-20210119
x86_64               randconfig-a011-20210119
x86_64               randconfig-a014-20210119

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
