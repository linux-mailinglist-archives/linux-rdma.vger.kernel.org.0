Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02132FFE12
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jan 2021 09:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbhAVIWl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jan 2021 03:22:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:3307 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbhAVIWf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 22 Jan 2021 03:22:35 -0500
IronPort-SDR: EKT3eycjag8j04dGPmk5822pG/QrYnq/vG0HBnn8rleljmJMV7ZX/bPRDegeK2SY6vQ6PnAlS7
 xNJnKteuiHsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="178634937"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="178634937"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 00:21:48 -0800
IronPort-SDR: scnhq5ysoqcVO25jfsyLQx/5MLgQkRzmb6HmIBkryqXmUYedWvBudiwkH4UfYd9OIfZwH0LHr4
 ixHgylvsYjfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="467767830"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jan 2021 00:21:47 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l2rhS-00077D-Gf; Fri, 22 Jan 2021 08:21:46 +0000
Date:   Fri, 22 Jan 2021 16:21:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 efeb973ffce7f3460d814ab91f22cbbc1cce7af8
Message-ID: <600a8b08.OWmt785RZcMC9sQ/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: efeb973ffce7f3460d814ab91f22cbbc1cce7af8  RDMA/uverbs: Don't set rcq for a QP if qp_type is IB_QPT_XRC_INI

elapsed time: 769m

configs tested: 123
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                    amigaone_defconfig
mips                malta_qemu_32r6_defconfig
mips                        maltaup_defconfig
powerpc                     tqm8560_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                   motionpro_defconfig
c6x                        evmc6457_defconfig
mips                         tb0226_defconfig
mips                           ip22_defconfig
powerpc                        icon_defconfig
mips                        nlm_xlp_defconfig
xtensa                generic_kc705_defconfig
powerpc                    socrates_defconfig
m68k                          atari_defconfig
arm                             mxs_defconfig
powerpc                   currituck_defconfig
arm                        trizeps4_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                       holly_defconfig
powerpc                  storcenter_defconfig
powerpc                     taishan_defconfig
sh                           se7712_defconfig
mips                        bcm47xx_defconfig
arm                        spear3xx_defconfig
arm                       imx_v4_v5_defconfig
arm                     eseries_pxa_defconfig
mips                        jmr3927_defconfig
sh                   sh7770_generic_defconfig
arm                          tango4_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                   sh7724_generic_defconfig
sh                         ap325rxa_defconfig
arc                            hsdk_defconfig
mips                           ip27_defconfig
arm                           stm32_defconfig
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
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210121
x86_64               randconfig-a003-20210121
x86_64               randconfig-a001-20210121
x86_64               randconfig-a005-20210121
x86_64               randconfig-a006-20210121
x86_64               randconfig-a004-20210121
i386                 randconfig-a001-20210121
i386                 randconfig-a002-20210121
i386                 randconfig-a004-20210121
i386                 randconfig-a006-20210121
i386                 randconfig-a005-20210121
i386                 randconfig-a003-20210121
i386                 randconfig-a001-20210122
i386                 randconfig-a002-20210122
i386                 randconfig-a004-20210122
i386                 randconfig-a006-20210122
i386                 randconfig-a003-20210122
i386                 randconfig-a005-20210122
i386                 randconfig-a013-20210121
i386                 randconfig-a011-20210121
i386                 randconfig-a012-20210121
i386                 randconfig-a014-20210121
i386                 randconfig-a015-20210121
i386                 randconfig-a016-20210121
i386                 randconfig-a013-20210122
i386                 randconfig-a011-20210122
i386                 randconfig-a012-20210122
i386                 randconfig-a014-20210122
i386                 randconfig-a015-20210122
i386                 randconfig-a016-20210122
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
x86_64               randconfig-a002-20210122
x86_64               randconfig-a003-20210122
x86_64               randconfig-a001-20210122
x86_64               randconfig-a005-20210122
x86_64               randconfig-a006-20210122
x86_64               randconfig-a004-20210122

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
