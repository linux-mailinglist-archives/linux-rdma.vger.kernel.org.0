Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8038E285DC1
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Oct 2020 13:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgJGLEO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Oct 2020 07:04:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:4855 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgJGLEN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Oct 2020 07:04:13 -0400
IronPort-SDR: 6p3qP7t0KT9xj9mTX2TEeGR3eZNQ2wGnYepr84nhV+KOPZMaCM4fh/mS5SK68KepN4YPmdVx+e
 jEAfMfwIX+ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="164128066"
X-IronPort-AV: E=Sophos;i="5.77,346,1596524400"; 
   d="scan'208";a="164128066"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 04:04:03 -0700
IronPort-SDR: ZC2xMNBShO6yCq+10FWjxx5h55PoVuTIw3aRXl8MTwtqDsOvp+4/GsdbFluxHfGfOjjgoG3I3U
 oMvcXkOCDFwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,346,1596524400"; 
   d="scan'208";a="418650180"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 07 Oct 2020 04:04:00 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kQ7El-0001cb-Gu; Wed, 07 Oct 2020 11:03:59 +0000
Date:   Wed, 07 Oct 2020 19:03:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 73c5265913b4b11a56d119396f745a57c7c272b7
Message-ID: <5f7da081.KJJ7+9vFa4sFvibA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 73c5265913b4b11a56d119396f745a57c7c272b7  RDMA/bnxt_re: Fix sizeof mismatch for allocation of pbl_tbl.

elapsed time: 735m

configs tested: 139
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                  cavium_octeon_defconfig
arm                         hackkit_defconfig
arm                         socfpga_defconfig
sh                          r7780mp_defconfig
sh                            migor_defconfig
riscv                            allmodconfig
mips                           ip28_defconfig
mips                        omega2p_defconfig
arc                             nps_defconfig
mips                      pistachio_defconfig
sh                           se7721_defconfig
arm                       aspeed_g4_defconfig
powerpc                      ep88xc_defconfig
xtensa                    xip_kc705_defconfig
powerpc                      arches_defconfig
arm                         palmz72_defconfig
powerpc                  mpc885_ads_defconfig
openrisc                         alldefconfig
arm                         at91_dt_defconfig
arm                         s5pv210_defconfig
sh                   sh7724_generic_defconfig
arm64                            alldefconfig
powerpc                          g5_defconfig
arm                           sunxi_defconfig
arm                       imx_v4_v5_defconfig
powerpc                    adder875_defconfig
m68k                       bvme6000_defconfig
powerpc                        warp_defconfig
microblaze                      mmu_defconfig
arm                          pxa168_defconfig
arm                          moxart_defconfig
sh                          urquell_defconfig
arm                            mmp2_defconfig
m68k                         amcore_defconfig
sparc64                          alldefconfig
powerpc                 mpc8560_ads_defconfig
arc                           tb10x_defconfig
powerpc                         wii_defconfig
h8300                            alldefconfig
nios2                            alldefconfig
m68k                       m5208evb_defconfig
powerpc                       eiger_defconfig
mips                         tb0226_defconfig
mips                        nlm_xlr_defconfig
powerpc                     redwood_defconfig
sh                          rsk7269_defconfig
arm                              alldefconfig
powerpc                 xes_mpc85xx_defconfig
sh                          sdk7786_defconfig
mips                         mpc30x_defconfig
powerpc                     mpc83xx_defconfig
arm                           corgi_defconfig
m68k                          amiga_defconfig
mips                     cu1000-neo_defconfig
alpha                            allyesconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201006
x86_64               randconfig-a002-20201006
x86_64               randconfig-a001-20201006
x86_64               randconfig-a005-20201006
x86_64               randconfig-a003-20201006
x86_64               randconfig-a006-20201006
i386                 randconfig-a006-20201005
i386                 randconfig-a005-20201005
i386                 randconfig-a001-20201005
i386                 randconfig-a004-20201005
i386                 randconfig-a003-20201005
i386                 randconfig-a002-20201005
x86_64               randconfig-a012-20201005
x86_64               randconfig-a015-20201005
x86_64               randconfig-a014-20201005
x86_64               randconfig-a013-20201005
x86_64               randconfig-a011-20201005
x86_64               randconfig-a016-20201005
x86_64               randconfig-a012-20201007
x86_64               randconfig-a015-20201007
x86_64               randconfig-a014-20201007
x86_64               randconfig-a013-20201007
x86_64               randconfig-a011-20201007
x86_64               randconfig-a016-20201007
i386                 randconfig-a014-20201005
i386                 randconfig-a015-20201005
i386                 randconfig-a013-20201005
i386                 randconfig-a016-20201005
i386                 randconfig-a011-20201005
i386                 randconfig-a012-20201005
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201005
x86_64               randconfig-a002-20201005
x86_64               randconfig-a001-20201005
x86_64               randconfig-a003-20201005
x86_64               randconfig-a005-20201005
x86_64               randconfig-a006-20201005

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
