Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A6A37EE36
	for <lists+linux-rdma@lfdr.de>; Thu, 13 May 2021 00:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346343AbhELVND (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 May 2021 17:13:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:16266 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377332AbhELTDh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 May 2021 15:03:37 -0400
IronPort-SDR: TPiS0m8W5tMVcGPJRtf3Hfb88xRK3rSctYSAnItoqVuSi0alk60xfVFSLLudUXS/Uz+ngvbTTR
 ggwIBbWA0dLw==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="186915222"
X-IronPort-AV: E=Sophos;i="5.82,295,1613462400"; 
   d="scan'208";a="186915222"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 12:01:40 -0700
IronPort-SDR: nUjM+pstKiWo1oPxxvqfo1SQpFz/vgbUJ/1q8me2nHeuEY+eQ/0fSxtXNMoRPrVRJuJdz6eIi7
 9tXWx0l57HQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,295,1613462400"; 
   d="scan'208";a="400499536"
Received: from lkp-server01.sh.intel.com (HELO 1e931876798f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 12 May 2021 12:01:39 -0700
Received: from kbuild by 1e931876798f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lgu70-0000RZ-Hz; Wed, 12 May 2021 19:01:38 +0000
Date:   Thu, 13 May 2021 03:01:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 67f29896fdc83298eed5a6576ff8f9873f709228
Message-ID: <609c2602.Pd30YOT7vQJcYo0f%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: 67f29896fdc83298eed5a6576ff8f9873f709228  RDMA/rxe: Clear all QP fields if creation failed

elapsed time: 735m

configs tested: 183
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         tb0287_defconfig
m68k                          sun3x_defconfig
mips                          rb532_defconfig
arm                      jornada720_defconfig
arm                          imote2_defconfig
powerpc                      pcm030_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                            hisi_defconfig
powerpc                     tqm8560_defconfig
mips                        nlm_xlp_defconfig
um                               allmodconfig
sh                          landisk_defconfig
arm                         at91_dt_defconfig
powerpc                     tqm8555_defconfig
powerpc                 mpc836x_mds_defconfig
openrisc                  or1klitex_defconfig
m68k                          amiga_defconfig
mips                           xway_defconfig
sh                           se7712_defconfig
arm                          collie_defconfig
powerpc                     ppa8548_defconfig
powerpc                      obs600_defconfig
mips                     decstation_defconfig
mips                             allyesconfig
arm                           sunxi_defconfig
powerpc                    sam440ep_defconfig
arm                       mainstone_defconfig
mips                           jazz_defconfig
powerpc                        warp_defconfig
powerpc                 mpc834x_itx_defconfig
mips                           ip27_defconfig
sh                        edosk7760_defconfig
sh                   sh7770_generic_defconfig
sh                          rsk7201_defconfig
s390                       zfcpdump_defconfig
xtensa                         virt_defconfig
sh                        sh7763rdp_defconfig
csky                                defconfig
arm                        mini2440_defconfig
powerpc                    socrates_defconfig
arm                         s5pv210_defconfig
arm                        magician_defconfig
arm                         mv78xx0_defconfig
arm                       aspeed_g4_defconfig
mips                      malta_kvm_defconfig
parisc                generic-32bit_defconfig
powerpc                     sequoia_defconfig
sh                           se7619_defconfig
riscv                    nommu_k210_defconfig
powerpc                     powernv_defconfig
arc                            hsdk_defconfig
arm                          iop32x_defconfig
mips                        workpad_defconfig
arm                         bcm2835_defconfig
arm                        spear6xx_defconfig
arc                          axs101_defconfig
powerpc                      ep88xc_defconfig
mips                        jmr3927_defconfig
um                            kunit_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                          rsk7203_defconfig
powerpc                    klondike_defconfig
arm                            dove_defconfig
mips                      maltasmvp_defconfig
arc                      axs103_smp_defconfig
arm                       imx_v6_v7_defconfig
powerpc                     asp8347_defconfig
arm                          pxa910_defconfig
m68k                       m5475evb_defconfig
mips                      bmips_stb_defconfig
arm                          ep93xx_defconfig
mips                        nlm_xlr_defconfig
riscv                               defconfig
sh                          rsk7264_defconfig
powerpc                       holly_defconfig
mips                         mpc30x_defconfig
mips                  decstation_64_defconfig
ia64                                defconfig
arc                 nsimosci_hs_smp_defconfig
arm                        keystone_defconfig
powerpc                      tqm8xx_defconfig
arm                            xcep_defconfig
arm                        vexpress_defconfig
sh                         ecovec24_defconfig
parisc                           alldefconfig
powerpc                        fsp2_defconfig
m68k                       m5275evb_defconfig
xtensa                          iss_defconfig
powerpc                 mpc834x_mds_defconfig
mips                     cu1830-neo_defconfig
sh                           se7722_defconfig
riscv                    nommu_virt_defconfig
mips                             allmodconfig
arm                     eseries_pxa_defconfig
m68k                        mvme16x_defconfig
x86_64                           alldefconfig
mips                           ip32_defconfig
sh                            migor_defconfig
h8300                     edosk2674_defconfig
arm                         lpc18xx_defconfig
sparc64                             defconfig
sh                            hp6xx_defconfig
powerpc64                           defconfig
arm                          pcm027_defconfig
arm                             rpc_defconfig
arm                         shannon_defconfig
powerpc                    ge_imp3a_defconfig
sh                            titan_defconfig
powerpc                         ps3_defconfig
powerpc                      chrp32_defconfig
sh                           se7343_defconfig
x86_64                            allnoconfig
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
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210512
x86_64               randconfig-a004-20210512
x86_64               randconfig-a001-20210512
x86_64               randconfig-a005-20210512
x86_64               randconfig-a002-20210512
x86_64               randconfig-a006-20210512
i386                 randconfig-a003-20210512
i386                 randconfig-a001-20210512
i386                 randconfig-a005-20210512
i386                 randconfig-a004-20210512
i386                 randconfig-a002-20210512
i386                 randconfig-a006-20210512
i386                 randconfig-a016-20210512
i386                 randconfig-a014-20210512
i386                 randconfig-a011-20210512
i386                 randconfig-a015-20210512
i386                 randconfig-a012-20210512
i386                 randconfig-a013-20210512
riscv                            allyesconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210512
x86_64               randconfig-a012-20210512
x86_64               randconfig-a011-20210512
x86_64               randconfig-a013-20210512
x86_64               randconfig-a016-20210512
x86_64               randconfig-a014-20210512

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
