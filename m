Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986A43CB318
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jul 2021 09:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbhGPHQ4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jul 2021 03:16:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:35319 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236137AbhGPHQr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Jul 2021 03:16:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="296331589"
X-IronPort-AV: E=Sophos;i="5.84,244,1620716400"; 
   d="scan'208";a="296331589"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 00:13:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,244,1620716400"; 
   d="scan'208";a="506375088"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jul 2021 00:13:49 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m4I2e-000KOq-AO; Fri, 16 Jul 2021 07:13:48 +0000
Date:   Fri, 16 Jul 2021 15:13:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 dc6afef7e14252c5ca5b8a8444946cb4b75b0aa0
Message-ID: <60f13180.Asaa2LoTtuq5+MZ1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: dc6afef7e14252c5ca5b8a8444946cb4b75b0aa0  RDMA/irdma: Change returned type of irdma_setup_virt_qp to void

elapsed time: 721m

configs tested: 140
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                                  defconfig
powerpc                 mpc8272_ads_defconfig
sh                ecovec24-romimage_defconfig
um                                  defconfig
powerpc                     ppa8548_defconfig
sh                           se7705_defconfig
arc                          axs101_defconfig
sh                      rts7751r2d1_defconfig
arm                          gemini_defconfig
powerpc                     asp8347_defconfig
riscv                    nommu_virt_defconfig
m68k                        mvme16x_defconfig
x86_64                           alldefconfig
mips                         mpc30x_defconfig
m68k                            mac_defconfig
sh                           se7722_defconfig
arc                                 defconfig
powerpc               mpc834x_itxgp_defconfig
mips                     loongson1c_defconfig
s390                             alldefconfig
sh                         apsh4a3a_defconfig
m68k                       m5249evb_defconfig
powerpc                      pmac32_defconfig
sh                          sdk7780_defconfig
mips                           ip32_defconfig
arm                       spear13xx_defconfig
arm                    vt8500_v6_v7_defconfig
arm                         shannon_defconfig
mips                     loongson2k_defconfig
m68k                            q40_defconfig
powerpc                      cm5200_defconfig
alpha                            alldefconfig
sh                          rsk7269_defconfig
sparc                               defconfig
sh                               j2_defconfig
mips                        nlm_xlp_defconfig
nds32                            alldefconfig
powerpc64                           defconfig
ia64                         bigsur_defconfig
arm                            lart_defconfig
powerpc                    klondike_defconfig
mips                     cu1000-neo_defconfig
arm                          pxa3xx_defconfig
arm                        realview_defconfig
arm                        keystone_defconfig
sh                         ecovec24_defconfig
xtensa                  nommu_kc705_defconfig
arm                              alldefconfig
powerpc                    ge_imp3a_defconfig
mips                         tb0219_defconfig
sh                           se7712_defconfig
powerpc                       eiger_defconfig
arm                         nhk8815_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
x86_64                            allnoconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210715
i386                 randconfig-a006-20210715
i386                 randconfig-a004-20210715
i386                 randconfig-a001-20210715
i386                 randconfig-a003-20210715
i386                 randconfig-a002-20210715
i386                 randconfig-a005-20210716
i386                 randconfig-a006-20210716
i386                 randconfig-a004-20210716
i386                 randconfig-a001-20210716
i386                 randconfig-a002-20210716
i386                 randconfig-a003-20210716
x86_64               randconfig-a013-20210715
x86_64               randconfig-a012-20210715
x86_64               randconfig-a015-20210715
x86_64               randconfig-a014-20210715
x86_64               randconfig-a016-20210715
x86_64               randconfig-a011-20210715
i386                 randconfig-a014-20210715
i386                 randconfig-a015-20210715
i386                 randconfig-a011-20210715
i386                 randconfig-a013-20210715
i386                 randconfig-a012-20210715
i386                 randconfig-a016-20210715
i386                 randconfig-a015-20210716
i386                 randconfig-a014-20210716
i386                 randconfig-a011-20210716
i386                 randconfig-a013-20210716
i386                 randconfig-a012-20210716
i386                 randconfig-a016-20210716
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210715
x86_64               randconfig-a005-20210715
x86_64               randconfig-a004-20210715
x86_64               randconfig-a002-20210715
x86_64               randconfig-a003-20210715
x86_64               randconfig-a006-20210715
x86_64               randconfig-a001-20210715

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
