Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FA32F7382
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Jan 2021 08:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbhAOHFN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Jan 2021 02:05:13 -0500
Received: from mga14.intel.com ([192.55.52.115]:7792 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731275AbhAOHFN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 15 Jan 2021 02:05:13 -0500
IronPort-SDR: qUUzWU6xgHVMd0ZJecTFQfFSZuQ71FFWKD1mgKiR3Ln3zVH2XZnIYALM2ZW6YCQnMgcFCn7zj9
 KmDtBoejnapQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="177730196"
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="177730196"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 23:04:28 -0800
IronPort-SDR: RtrrqzXIjY4tuf5YXkx0Hiowa/FCXVwdpwrJVoeXpRpwKQM8yevXqugyQjSjrfBTXI9DEcmccg
 lUx+C9VqyBtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="364491822"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Jan 2021 23:04:27 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0J9m-0000EZ-DH; Fri, 15 Jan 2021 07:04:26 +0000
Date:   Fri, 15 Jan 2021 15:04:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 7c7b3e5d9aeed31d35c5dab0bf9c0fd4c8923206
Message-ID: <60013e6b.gcpHzmcyGjFH+Mna%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 7c7b3e5d9aeed31d35c5dab0bf9c0fd4c8923206  RDMA/cma: Fix error flow in default_roce_mode_store

elapsed time: 722m

configs tested: 134
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       mainstone_defconfig
powerpc                 mpc832x_rdb_defconfig
parisc                              defconfig
powerpc                        fsp2_defconfig
mips                       bmips_be_defconfig
arm                       imx_v4_v5_defconfig
arc                      axs103_smp_defconfig
sh                          r7785rp_defconfig
m68k                        m5272c3_defconfig
arm                        oxnas_v6_defconfig
arm                       aspeed_g4_defconfig
mips                         tb0226_defconfig
powerpc                  iss476-smp_defconfig
mips                           gcw0_defconfig
openrisc                         alldefconfig
arm                        multi_v5_defconfig
sh                            migor_defconfig
powerpc                      ppc44x_defconfig
arc                        nsimosci_defconfig
sh                                  defconfig
powerpc                    socrates_defconfig
arm                           spitz_defconfig
arm                           sunxi_defconfig
powerpc                      tqm8xx_defconfig
xtensa                    smp_lx200_defconfig
arm                         vf610m4_defconfig
mips                          rb532_defconfig
sh                             shx3_defconfig
powerpc                 mpc837x_mds_defconfig
mips                      bmips_stb_defconfig
powerpc                      ppc6xx_defconfig
i386                             alldefconfig
powerpc                     redwood_defconfig
arm                            lart_defconfig
arm                            pleb_defconfig
sh                     sh7710voipgw_defconfig
sh                     magicpanelr2_defconfig
mips                malta_kvm_guest_defconfig
c6x                         dsk6455_defconfig
arm                             ezx_defconfig
arm                      integrator_defconfig
powerpc                     mpc5200_defconfig
mips                        workpad_defconfig
mips                  decstation_64_defconfig
arm                          pxa168_defconfig
powerpc                      cm5200_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     sbc8548_defconfig
mips                           ci20_defconfig
sh                          rsk7203_defconfig
sh                               alldefconfig
parisc                generic-32bit_defconfig
mips                        nlm_xlp_defconfig
mips                   sb1250_swarm_defconfig
powerpc                    mvme5100_defconfig
sh                           se7712_defconfig
powerpc                     taishan_defconfig
mips                             allmodconfig
m68k                           sun3_defconfig
m68k                        stmark2_defconfig
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
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210114
i386                 randconfig-a005-20210114
i386                 randconfig-a006-20210114
i386                 randconfig-a001-20210114
i386                 randconfig-a003-20210114
i386                 randconfig-a004-20210114
x86_64               randconfig-a012-20210114
x86_64               randconfig-a013-20210114
x86_64               randconfig-a011-20210114
x86_64               randconfig-a015-20210114
x86_64               randconfig-a016-20210114
x86_64               randconfig-a014-20210114
i386                 randconfig-a012-20210114
i386                 randconfig-a011-20210114
i386                 randconfig-a016-20210114
i386                 randconfig-a015-20210114
i386                 randconfig-a013-20210114
i386                 randconfig-a014-20210114
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
x86_64               randconfig-a004-20210114
x86_64               randconfig-a006-20210114
x86_64               randconfig-a001-20210114
x86_64               randconfig-a003-20210114
x86_64               randconfig-a005-20210114
x86_64               randconfig-a002-20210114

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
