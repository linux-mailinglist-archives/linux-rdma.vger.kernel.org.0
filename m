Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A07F2B2C01
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Nov 2020 08:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgKNHsW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 14 Nov 2020 02:48:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:28755 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgKNHsW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 14 Nov 2020 02:48:22 -0500
IronPort-SDR: b9jm6LRRXzX+C8XhUD/VFPdPetr9dxw3eNyvVF7dSFPm4voT26SE40DJbn4YDiP8p2UXuoqCw/
 knm9asd0/ZDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="167989128"
X-IronPort-AV: E=Sophos;i="5.77,477,1596524400"; 
   d="scan'208";a="167989128"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 23:48:22 -0800
IronPort-SDR: 4F4qtdwUfuIOU/+k8xLo/cWJk6Wpp3daNPVVTcSkyINCaTE9DwbRdilbGYK75iPKpaMDnO3vkP
 XX0BQY/RszaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,477,1596524400"; 
   d="scan'208";a="309839355"
Received: from lkp-server02.sh.intel.com (HELO 697932c29306) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 13 Nov 2020 23:48:20 -0800
Received: from kbuild by 697932c29306 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kdqIG-0000jw-5D; Sat, 14 Nov 2020 07:48:20 +0000
Date:   Sat, 14 Nov 2020 15:47:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 dabbd6abcdbeb1358a53ec28a244429320eb0e3a
Message-ID: <5faf8b94.7ljzhXc8pSo4J9Dm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-rc
branch HEAD: dabbd6abcdbeb1358a53ec28a244429320eb0e3a  IB/hfi1: Fix error return code in hfi1_init_dd()

elapsed time: 842m

configs tested: 164
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         hackkit_defconfig
mips                          rm200_defconfig
sh                          r7785rp_defconfig
ia64                             alldefconfig
arm                          collie_defconfig
powerpc                     sequoia_defconfig
powerpc                       eiger_defconfig
arm                        neponset_defconfig
powerpc                     kmeter1_defconfig
m68k                        m5307c3_defconfig
powerpc                      mgcoge_defconfig
sh                          sdk7780_defconfig
arm                         lubbock_defconfig
mips                            e55_defconfig
xtensa                  cadence_csp_defconfig
nios2                            alldefconfig
sh                          rsk7203_defconfig
m68k                            q40_defconfig
sh                             shx3_defconfig
openrisc                    or1ksim_defconfig
mips                      malta_kvm_defconfig
mips                        omega2p_defconfig
arm                           u8500_defconfig
sh                           se7343_defconfig
arm                         nhk8815_defconfig
powerpc                  storcenter_defconfig
sparc                       sparc32_defconfig
powerpc                     ppa8548_defconfig
arm                          gemini_defconfig
m68k                       m5249evb_defconfig
arm                          iop32x_defconfig
arm                          simpad_defconfig
arm                           sunxi_defconfig
mips                         rt305x_defconfig
powerpc                   bluestone_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                      pxa255-idp_defconfig
powerpc                     tqm8560_defconfig
powerpc                  mpc866_ads_defconfig
sh                ecovec24-romimage_defconfig
arm64                            alldefconfig
arm                           h5000_defconfig
powerpc                      pmac32_defconfig
mips                   sb1250_swarm_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                      cm5200_defconfig
powerpc                      bamboo_defconfig
mips                        bcm47xx_defconfig
powerpc64                        alldefconfig
sh                   sh7724_generic_defconfig
alpha                            alldefconfig
arm                         s3c6400_defconfig
arm                         vf610m4_defconfig
arm                      integrator_defconfig
sh                         ecovec24_defconfig
sh                           se7750_defconfig
mips                           jazz_defconfig
powerpc                      acadia_defconfig
xtensa                          iss_defconfig
nds32                            alldefconfig
arm                       aspeed_g4_defconfig
arm                         assabet_defconfig
um                            kunit_defconfig
powerpc                      chrp32_defconfig
sh                               j2_defconfig
powerpc                     rainier_defconfig
m68k                            mac_defconfig
mips                        vocore2_defconfig
xtensa                         virt_defconfig
arm                        shmobile_defconfig
powerpc64                           defconfig
arm                           sama5_defconfig
mips                           ip32_defconfig
riscv                               defconfig
sh                          kfr2r09_defconfig
mips                     loongson1c_defconfig
arm                   milbeaut_m10v_defconfig
arm                           spitz_defconfig
mips                         tb0226_defconfig
m68k                        m5272c3_defconfig
arm                       imx_v4_v5_defconfig
powerpc                     pq2fads_defconfig
powerpc                    mvme5100_defconfig
ia64                        generic_defconfig
arm                           stm32_defconfig
mips                        bcm63xx_defconfig
arc                     haps_hs_smp_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                          g5_defconfig
sparc                       sparc64_defconfig
mips                      pistachio_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201113
i386                 randconfig-a005-20201113
i386                 randconfig-a002-20201113
i386                 randconfig-a001-20201113
i386                 randconfig-a003-20201113
i386                 randconfig-a004-20201113
x86_64               randconfig-a015-20201113
x86_64               randconfig-a011-20201113
x86_64               randconfig-a014-20201113
x86_64               randconfig-a013-20201113
x86_64               randconfig-a016-20201113
x86_64               randconfig-a012-20201113
i386                 randconfig-a012-20201113
i386                 randconfig-a014-20201113
i386                 randconfig-a016-20201113
i386                 randconfig-a011-20201113
i386                 randconfig-a015-20201113
i386                 randconfig-a013-20201113
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201113
x86_64               randconfig-a005-20201113
x86_64               randconfig-a004-20201113
x86_64               randconfig-a002-20201113
x86_64               randconfig-a006-20201113
x86_64               randconfig-a001-20201113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
