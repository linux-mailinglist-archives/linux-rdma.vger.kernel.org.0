Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD6D284649
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 08:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgJFGsp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 02:48:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:57232 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbgJFGsp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Oct 2020 02:48:45 -0400
IronPort-SDR: QVqMGTD+XbTtIxo58Cjy4AHJpEEMnKzMAt/X0jkR2nDySCUVCxhZSMB5L6GL+PMUmXyk3nScGf
 vjZXIiIKnWRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="151320184"
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400"; 
   d="scan'208";a="151320184"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 23:48:42 -0700
IronPort-SDR: A47GxaKIMM9+9JQ24JHoTJoK0dyg8UKyx8yKb0ZiVkSczVXbYM3q71ISg+Kwzcg+oRz+sS7pRU
 m0TMj0N7b4+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400"; 
   d="scan'208";a="353339486"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Oct 2020 23:48:40 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kPgm7-000171-E8; Tue, 06 Oct 2020 06:48:39 +0000
Date:   Tue, 06 Oct 2020 14:48:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 5ce2dced8e95e76ff7439863a118a053a7fc6f91
Message-ID: <5f7c1325.8Pldg69jq0jKTAyG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 5ce2dced8e95e76ff7439863a118a053a7fc6f91  RDMA/ipoib: Set rtnl_link_ops for ipoib interfaces

elapsed time: 725m

configs tested: 189
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                        m5307c3_defconfig
sh                           se7751_defconfig
sparc                               defconfig
arm                              zx_defconfig
arm                       multi_v4t_defconfig
m68k                             allyesconfig
mips                  maltasmvp_eva_defconfig
m68k                        mvme16x_defconfig
sh                ecovec24-romimage_defconfig
ia64                        generic_defconfig
powerpc                      acadia_defconfig
mips                       bmips_be_defconfig
sh                                  defconfig
arm                             mxs_defconfig
mips                          malta_defconfig
arm                         assabet_defconfig
arm                          collie_defconfig
mips                           ci20_defconfig
mips                           rs90_defconfig
arm                          exynos_defconfig
mips                          ath79_defconfig
arm                          pxa168_defconfig
arm                         cm_x300_defconfig
powerpc                      pasemi_defconfig
mips                      bmips_stb_defconfig
powerpc                      cm5200_defconfig
powerpc                     stx_gp3_defconfig
sh                           se7721_defconfig
mips                         bigsur_defconfig
arm                           stm32_defconfig
arm                          iop32x_defconfig
arm                          tango4_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                        nlm_xlp_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        magician_defconfig
alpha                               defconfig
arm                         lpc32xx_defconfig
m68k                          amiga_defconfig
arm                       imx_v6_v7_defconfig
powerpc                     tqm8555_defconfig
ia64                         bigsur_defconfig
arm                            qcom_defconfig
powerpc                     tqm5200_defconfig
sh                          sdk7786_defconfig
powerpc                      ppc40x_defconfig
sh                        apsh4ad0a_defconfig
mips                        vocore2_defconfig
c6x                        evmc6474_defconfig
openrisc                    or1ksim_defconfig
sh                          lboxre2_defconfig
m68k                            q40_defconfig
sh                          r7780mp_defconfig
sparc64                             defconfig
sh                         apsh4a3a_defconfig
arc                            hsdk_defconfig
arm                        multi_v5_defconfig
xtensa                           alldefconfig
powerpc                         ps3_defconfig
powerpc                  mpc885_ads_defconfig
sh                          rsk7269_defconfig
m68k                            mac_defconfig
powerpc                     tqm8540_defconfig
h8300                            alldefconfig
arm                           efm32_defconfig
mips                           ip27_defconfig
sh                           se7724_defconfig
powerpc                   lite5200b_defconfig
arm                           omap1_defconfig
powerpc                      chrp32_defconfig
mips                malta_qemu_32r6_defconfig
arm                         palmz72_defconfig
arm                          ixp4xx_defconfig
sh                           se7722_defconfig
sh                   secureedge5410_defconfig
m68k                        m5272c3_defconfig
powerpc                 mpc85xx_cds_defconfig
m68k                                defconfig
arm                       mainstone_defconfig
arm                         bcm2835_defconfig
sh                          kfr2r09_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                        sh7763rdp_defconfig
sh                   rts7751r2dplus_defconfig
ia64                             allmodconfig
mips                        jmr3927_defconfig
arm                         vf610m4_defconfig
mips                          ath25_defconfig
powerpc                 canyonlands_defconfig
arm                             pxa_defconfig
sh                         ap325rxa_defconfig
powerpc                     powernv_defconfig
parisc                              defconfig
sh                               allmodconfig
mips                     loongson1c_defconfig
sh                          rsk7264_defconfig
arm                        spear6xx_defconfig
arm                           viper_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                          g5_defconfig
c6x                         dsk6455_defconfig
powerpc                     sequoia_defconfig
arm                            dove_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
s390                             allyesconfig
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
i386                 randconfig-a006-20201005
i386                 randconfig-a005-20201005
i386                 randconfig-a001-20201005
i386                 randconfig-a004-20201005
i386                 randconfig-a003-20201005
i386                 randconfig-a002-20201005
i386                 randconfig-a006-20201006
i386                 randconfig-a005-20201006
i386                 randconfig-a001-20201006
i386                 randconfig-a004-20201006
i386                 randconfig-a003-20201006
i386                 randconfig-a002-20201006
i386                 randconfig-a006-20201004
i386                 randconfig-a005-20201004
i386                 randconfig-a001-20201004
i386                 randconfig-a004-20201004
i386                 randconfig-a003-20201004
i386                 randconfig-a002-20201004
x86_64               randconfig-a012-20201005
x86_64               randconfig-a015-20201005
x86_64               randconfig-a014-20201005
x86_64               randconfig-a013-20201005
x86_64               randconfig-a011-20201005
x86_64               randconfig-a016-20201005
i386                 randconfig-a014-20201005
i386                 randconfig-a015-20201005
i386                 randconfig-a013-20201005
i386                 randconfig-a016-20201005
i386                 randconfig-a011-20201005
i386                 randconfig-a012-20201005
i386                 randconfig-a014-20201004
i386                 randconfig-a015-20201004
i386                 randconfig-a013-20201004
i386                 randconfig-a016-20201004
i386                 randconfig-a011-20201004
i386                 randconfig-a012-20201004
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
x86_64               randconfig-a004-20201005
x86_64               randconfig-a002-20201005
x86_64               randconfig-a001-20201005
x86_64               randconfig-a003-20201005
x86_64               randconfig-a005-20201005
x86_64               randconfig-a006-20201005

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
