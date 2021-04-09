Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC6435969D
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Apr 2021 09:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhDIHnW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Apr 2021 03:43:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:42037 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhDIHnW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 9 Apr 2021 03:43:22 -0400
IronPort-SDR: FIQ4FIGLRIb+lifgMVz/6k2W1Fg+4SMQfIpMbYrM+B9M49Dzd2zKUMVoEmDK+DW5CjcQAI9JTh
 OxN8RZvrHIfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="214132004"
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="214132004"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 00:43:09 -0700
IronPort-SDR: 1A81XcSme+Z4avubkFdba0sxZ4fKkYQ37XunwMEJLOeVlTtqBtsuOjKCKER2tTG2VOLQDP7PN2
 uMY+8/eOhx+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="442062261"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 Apr 2021 00:43:08 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lUlnH-000GOF-8L; Fri, 09 Apr 2021 07:43:07 +0000
Date:   Fri, 09 Apr 2021 15:42:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 d1c803a9ccd7bd3aff5e989ccfb39ed3b799b975
Message-ID: <6070057e.tvxNnEtR4/MvD7Zr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: d1c803a9ccd7bd3aff5e989ccfb39ed3b799b975  RDMA/addr: Be strict with gid size

elapsed time: 724m

configs tested: 125
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
mips                         rt305x_defconfig
um                                allnoconfig
sh                          urquell_defconfig
sh                            titan_defconfig
arm                             ezx_defconfig
arm                        oxnas_v6_defconfig
powerpc                     akebono_defconfig
arm                     eseries_pxa_defconfig
arm                            pleb_defconfig
m68k                         amcore_defconfig
sparc                       sparc32_defconfig
powerpc                     ppa8548_defconfig
m68k                        m5407c3_defconfig
arm                            lart_defconfig
arm                           spitz_defconfig
arm                         palmz72_defconfig
arm                         lpc32xx_defconfig
ia64                             alldefconfig
arm                        clps711x_defconfig
xtensa                    xip_kc705_defconfig
m68k                       bvme6000_defconfig
h8300                            alldefconfig
arc                     nsimosci_hs_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                  storcenter_defconfig
arm                         s5pv210_defconfig
ia64                         bigsur_defconfig
arm                         orion5x_defconfig
m68k                        stmark2_defconfig
sh                          landisk_defconfig
powerpc                      arches_defconfig
mips                          rb532_defconfig
m68k                          hp300_defconfig
s390                          debug_defconfig
sh                 kfr2r09-romimage_defconfig
arm                             mxs_defconfig
mips                          malta_defconfig
arm                           u8500_defconfig
arm                            zeus_defconfig
arm                      footbridge_defconfig
powerpc                        warp_defconfig
mips                           ip22_defconfig
m68k                          multi_defconfig
sh                          lboxre2_defconfig
arm64                            alldefconfig
arm                            xcep_defconfig
riscv                               defconfig
ia64                            zx1_defconfig
sh                  sh7785lcr_32bit_defconfig
ia64                                defconfig
ia64                             allmodconfig
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
arc                                 defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210408
x86_64               randconfig-a005-20210408
x86_64               randconfig-a003-20210408
x86_64               randconfig-a001-20210408
x86_64               randconfig-a002-20210408
x86_64               randconfig-a006-20210408
i386                 randconfig-a006-20210408
i386                 randconfig-a003-20210408
i386                 randconfig-a001-20210408
i386                 randconfig-a004-20210408
i386                 randconfig-a005-20210408
i386                 randconfig-a002-20210408
i386                 randconfig-a014-20210408
i386                 randconfig-a016-20210408
i386                 randconfig-a011-20210408
i386                 randconfig-a012-20210408
i386                 randconfig-a013-20210408
i386                 randconfig-a015-20210408
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210408
x86_64               randconfig-a015-20210408
x86_64               randconfig-a012-20210408
x86_64               randconfig-a013-20210408
x86_64               randconfig-a011-20210408
x86_64               randconfig-a016-20210408

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
