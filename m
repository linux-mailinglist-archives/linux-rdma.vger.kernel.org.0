Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F095A2C2401
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 12:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732485AbgKXLUn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 06:20:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:9232 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgKXLUn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Nov 2020 06:20:43 -0500
IronPort-SDR: GJEl4q4fjVAUrSSjHMNnMilv6rUd2It2fX2bMPVySIo0CgDtsyfEHU9TShXBRuCfPoJP6Clwtr
 Lptuc5B+vBdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="233535732"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="233535732"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 03:20:42 -0800
IronPort-SDR: tpTYrIv6t1zgz7hVSE7l1AtQn9jd76EMC86htATwrBEZJrbbVK5WdxYDZfICULrK2tSuaJFKKk
 hMDlXhsSGtGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="478467589"
Received: from lkp-server01.sh.intel.com (HELO 2820ec516a85) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 Nov 2020 03:20:40 -0800
Received: from kbuild by 2820ec516a85 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1khWNE-00004x-0u; Tue, 24 Nov 2020 11:20:40 +0000
Date:   Tue, 24 Nov 2020 19:20:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 6830ff853a5764c75e56750d59d0bbb6b26f1835
Message-ID: <5fbcec86.FeA6mQQMMLWU9s5G%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-rc
branch HEAD: 6830ff853a5764c75e56750d59d0bbb6b26f1835  IB/mthca: fix return value of error branch in mthca_init_cq()

elapsed time: 804m

configs tested: 196
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                          axs101_defconfig
c6x                        evmc6678_defconfig
mips                          malta_defconfig
parisc                           alldefconfig
sh                          kfr2r09_defconfig
m68k                       m5208evb_defconfig
powerpc                     asp8347_defconfig
arm                           viper_defconfig
mips                         cobalt_defconfig
arm                       mainstone_defconfig
arm                          moxart_defconfig
openrisc                         alldefconfig
ia64                                defconfig
arm                        mvebu_v5_defconfig
powerpc                      makalu_defconfig
arc                              allyesconfig
sh                         microdev_defconfig
c6x                         dsk6455_defconfig
powerpc                     tqm8560_defconfig
sh                   rts7751r2dplus_defconfig
arm                        keystone_defconfig
mips                           ip32_defconfig
arm                            u300_defconfig
mips                         bigsur_defconfig
mips                           jazz_defconfig
powerpc                      pmac32_defconfig
mips                       lemote2f_defconfig
mips                      maltasmvp_defconfig
powerpc                      ppc44x_defconfig
mips                     loongson1b_defconfig
arm                           sama5_defconfig
arc                            hsdk_defconfig
mips                       rbtx49xx_defconfig
m68k                        m5272c3_defconfig
m68k                        m5307c3_defconfig
mips                     cu1000-neo_defconfig
sh                             espt_defconfig
mips                          ath79_defconfig
powerpc                  mpc866_ads_defconfig
arm                        multi_v5_defconfig
powerpc                 mpc837x_mds_defconfig
sh                           se7619_defconfig
mips                             allyesconfig
powerpc                 mpc832x_mds_defconfig
arm                          badge4_defconfig
powerpc                     stx_gp3_defconfig
arm                      integrator_defconfig
sh                         ecovec24_defconfig
mips                      bmips_stb_defconfig
m68k                         amcore_defconfig
powerpc                     tqm8540_defconfig
powerpc                     akebono_defconfig
sh                             shx3_defconfig
sparc                               defconfig
sh                           se7750_defconfig
arm                       imx_v6_v7_defconfig
sh                          sdk7786_defconfig
sh                            titan_defconfig
xtensa                       common_defconfig
m68k                        stmark2_defconfig
mips                  cavium_octeon_defconfig
sh                          landisk_defconfig
arm                         bcm2835_defconfig
powerpc                 mpc8272_ads_defconfig
sh                        edosk7760_defconfig
mips                        workpad_defconfig
m68k                       m5475evb_defconfig
arm                             ezx_defconfig
powerpc                       eiger_defconfig
sh                            hp6xx_defconfig
powerpc                 mpc85xx_cds_defconfig
m68k                        m5407c3_defconfig
arm                            lart_defconfig
m68k                          amiga_defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc40x_defconfig
arm                         at91_dt_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                         nhk8815_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                           h5000_defconfig
arm                        oxnas_v6_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                           omap1_defconfig
arm                          pxa168_defconfig
powerpc                     ksi8560_defconfig
mips                         rt305x_defconfig
arc                      axs103_smp_defconfig
powerpc                      arches_defconfig
powerpc                      ppc64e_defconfig
arm                          collie_defconfig
mips                         tb0219_defconfig
arm                          simpad_defconfig
arm                        spear3xx_defconfig
powerpc                    sam440ep_defconfig
xtensa                         virt_defconfig
mips                         tb0226_defconfig
xtensa                    xip_kc705_defconfig
mips                            ar7_defconfig
arm                     am200epdkit_defconfig
arm                         orion5x_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20201124
x86_64               randconfig-a003-20201124
x86_64               randconfig-a004-20201124
x86_64               randconfig-a005-20201124
x86_64               randconfig-a001-20201124
x86_64               randconfig-a002-20201124
i386                 randconfig-a004-20201123
i386                 randconfig-a003-20201123
i386                 randconfig-a002-20201123
i386                 randconfig-a005-20201123
i386                 randconfig-a001-20201123
i386                 randconfig-a006-20201123
i386                 randconfig-a004-20201124
i386                 randconfig-a003-20201124
i386                 randconfig-a002-20201124
i386                 randconfig-a005-20201124
i386                 randconfig-a001-20201124
i386                 randconfig-a006-20201124
x86_64               randconfig-a015-20201123
x86_64               randconfig-a011-20201123
x86_64               randconfig-a014-20201123
x86_64               randconfig-a016-20201123
x86_64               randconfig-a012-20201123
x86_64               randconfig-a013-20201123
i386                 randconfig-a012-20201123
i386                 randconfig-a013-20201123
i386                 randconfig-a011-20201123
i386                 randconfig-a016-20201123
i386                 randconfig-a014-20201123
i386                 randconfig-a015-20201123
i386                 randconfig-a012-20201124
i386                 randconfig-a013-20201124
i386                 randconfig-a011-20201124
i386                 randconfig-a016-20201124
i386                 randconfig-a014-20201124
i386                 randconfig-a015-20201124
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20201123
x86_64               randconfig-a003-20201123
x86_64               randconfig-a004-20201123
x86_64               randconfig-a005-20201123
x86_64               randconfig-a002-20201123
x86_64               randconfig-a001-20201123
x86_64               randconfig-a015-20201124
x86_64               randconfig-a011-20201124
x86_64               randconfig-a014-20201124
x86_64               randconfig-a016-20201124
x86_64               randconfig-a012-20201124
x86_64               randconfig-a013-20201124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
