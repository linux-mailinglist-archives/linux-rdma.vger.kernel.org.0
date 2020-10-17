Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2532A290F1A
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Oct 2020 07:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411168AbgJQF04 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 17 Oct 2020 01:26:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:17777 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410580AbgJQF0z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 17 Oct 2020 01:26:55 -0400
IronPort-SDR: OY0QhLY8HANds32lXboEsK8m24Qai3ZBKDJjwPW03rJFJ9sYHMZOsfXZ+YMtJZSFBhRrVdsFFl
 04EOx9BSK4pg==
X-IronPort-AV: E=McAfee;i="6000,8403,9776"; a="164127871"
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400"; 
   d="scan'208";a="164127871"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 22:26:50 -0700
IronPort-SDR: GV1TOvqhhxrv8LDHviaupogs5Xfc8zdQKp3mRdifGe2MgZDrRmfoI6jCVx1RyiOjyJQ9F2Xg4w
 KEwdlh08TeeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400"; 
   d="scan'208";a="521411059"
Received: from lkp-server02.sh.intel.com (HELO 262a2cdd3070) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 16 Oct 2020 22:26:48 -0700
Received: from kbuild by 262a2cdd3070 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kTejw-0000GH-Cb; Sat, 17 Oct 2020 05:26:48 +0000
Date:   Sat, 17 Oct 2020 13:26:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 c7a198c700763ac89abbb166378f546aeb9afb33
Message-ID: <5f8a807f.t/eXHilFnPrSou+l%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-next
branch HEAD: c7a198c700763ac89abbb166378f546aeb9afb33  RDMA/ucma: Fix use after free in destroy id flow

elapsed time: 724m

configs tested: 185
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                        workpad_defconfig
arm                           omap1_defconfig
h8300                               defconfig
powerpc                     redwood_defconfig
sh                           se7751_defconfig
powerpc                    mvme5100_defconfig
powerpc                   lite5200b_defconfig
powerpc                     tqm8555_defconfig
arc                             nps_defconfig
sh                          rsk7201_defconfig
mips                      fuloong2e_defconfig
arm                        mini2440_defconfig
arm                        neponset_defconfig
arm                      integrator_defconfig
alpha                               defconfig
m68k                                defconfig
mips                  cavium_octeon_defconfig
arm                          moxart_defconfig
alpha                            alldefconfig
powerpc                    adder875_defconfig
mips                 pnx8335_stb225_defconfig
riscv                    nommu_virt_defconfig
m68k                          amiga_defconfig
powerpc                      cm5200_defconfig
arc                           tb10x_defconfig
microblaze                      mmu_defconfig
sh                         ap325rxa_defconfig
powerpc                 mpc832x_mds_defconfig
sh                           se7712_defconfig
arm                          pcm027_defconfig
s390                             alldefconfig
nios2                         10m50_defconfig
mips                          rm200_defconfig
mips                        omega2p_defconfig
powerpc                        cell_defconfig
mips                           ip28_defconfig
powerpc                       ebony_defconfig
sh                          r7785rp_defconfig
xtensa                          iss_defconfig
arm                              alldefconfig
arc                    vdk_hs38_smp_defconfig
mips                        qi_lb60_defconfig
powerpc                      ppc6xx_defconfig
arm                      pxa255-idp_defconfig
powerpc                     tqm8560_defconfig
mips                           xway_defconfig
mips                      pistachio_defconfig
arm                          pxa168_defconfig
arm                         ebsa110_defconfig
mips                       rbtx49xx_defconfig
arm                           viper_defconfig
arm                         axm55xx_defconfig
arm                        cerfcube_defconfig
mips                         tb0226_defconfig
arm                            u300_defconfig
ia64                          tiger_defconfig
powerpc                     pseries_defconfig
xtensa                       common_defconfig
um                            kunit_defconfig
sh                        sh7757lcr_defconfig
mips                         tb0287_defconfig
powerpc                     pq2fads_defconfig
powerpc                          allyesconfig
sh                   sh7770_generic_defconfig
mips                          ath79_defconfig
h8300                       h8s-sim_defconfig
arm                         s3c6400_defconfig
powerpc                     asp8347_defconfig
mips                     loongson1c_defconfig
mips                           ci20_defconfig
mips                         db1xxx_defconfig
m68k                         amcore_defconfig
arc                              alldefconfig
h8300                    h8300h-sim_defconfig
arm                         at91_dt_defconfig
openrisc                            defconfig
arm                        magician_defconfig
arm                  colibri_pxa270_defconfig
arc                          axs103_defconfig
arm                       imx_v4_v5_defconfig
sh                 kfr2r09-romimage_defconfig
parisc                           alldefconfig
mips                      malta_kvm_defconfig
powerpc                   currituck_defconfig
arm                            lart_defconfig
arm                         vf610m4_defconfig
sh                             shx3_defconfig
arm                         cm_x300_defconfig
mips                      bmips_stb_defconfig
arm                        keystone_defconfig
powerpc                       eiger_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     sbc8548_defconfig
m68k                        m5272c3_defconfig
powerpc                     ksi8560_defconfig
i386                             alldefconfig
arm                          gemini_defconfig
um                           x86_64_defconfig
arm                           spitz_defconfig
sh                      rts7751r2d1_defconfig
m68k                             alldefconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc834x_mds_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
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
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20201016
i386                 randconfig-a006-20201016
i386                 randconfig-a001-20201016
i386                 randconfig-a003-20201016
i386                 randconfig-a004-20201016
i386                 randconfig-a002-20201016
x86_64               randconfig-a016-20201016
x86_64               randconfig-a012-20201016
x86_64               randconfig-a015-20201016
x86_64               randconfig-a013-20201016
x86_64               randconfig-a014-20201016
x86_64               randconfig-a011-20201016
i386                 randconfig-a016-20201016
i386                 randconfig-a013-20201016
i386                 randconfig-a015-20201016
i386                 randconfig-a011-20201016
i386                 randconfig-a012-20201016
i386                 randconfig-a014-20201016
i386                 randconfig-a016-20201017
i386                 randconfig-a013-20201017
i386                 randconfig-a015-20201017
i386                 randconfig-a011-20201017
i386                 randconfig-a012-20201017
i386                 randconfig-a014-20201017
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                               rhel-8.3
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201016
x86_64               randconfig-a002-20201016
x86_64               randconfig-a006-20201016
x86_64               randconfig-a001-20201016
x86_64               randconfig-a005-20201016
x86_64               randconfig-a003-20201016
x86_64               randconfig-a016-20201017
x86_64               randconfig-a012-20201017
x86_64               randconfig-a015-20201017
x86_64               randconfig-a013-20201017
x86_64               randconfig-a014-20201017
x86_64               randconfig-a011-20201017

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
