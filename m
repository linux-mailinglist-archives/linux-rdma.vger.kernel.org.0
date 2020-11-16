Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E272B4071
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 11:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgKPKF0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 05:05:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:23563 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgKPKF0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Nov 2020 05:05:26 -0500
IronPort-SDR: HNa70cZO7PKkCsE6mTvq0P7iVnT1GhaOf05vNL59iOMF+xGji4CSbUtrfX3t2CKhEqTfoqF4BF
 OZVluAnhuEqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="169941271"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="169941271"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 02:05:24 -0800
IronPort-SDR: VIog+AcJmXGZCg66LnX7fY/DUEZpANr6AQelYTw0uCRmAtz0l9pvgM4K4OrCUqAHfNSPDL1if1
 +YfwrtAckfUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="310346736"
Received: from lkp-server01.sh.intel.com (HELO fb398427a497) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 16 Nov 2020 02:05:22 -0800
Received: from kbuild by fb398427a497 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kebNx-00002a-VV; Mon, 16 Nov 2020 10:05:21 +0000
Date:   Mon, 16 Nov 2020 18:05:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 e96ea81cacb1f8c6c87062ab0822e1f2e0e65068
Message-ID: <5fb24ecf.hgkZWPx/+ZYEZuaz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: e96ea81cacb1f8c6c87062ab0822e1f2e0e65068  RDMA/cma: Add missing error handling of listen_id

elapsed time: 859m

configs tested: 167
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         lpc32xx_defconfig
mips                            e55_defconfig
openrisc                 simple_smp_defconfig
powerpc                           allnoconfig
arm                         at91_dt_defconfig
arm                          exynos_defconfig
m68k                        mvme147_defconfig
arm                       spear13xx_defconfig
microblaze                    nommu_defconfig
powerpc                  mpc866_ads_defconfig
arm                       mainstone_defconfig
um                           x86_64_defconfig
arm                        magician_defconfig
m68k                        m5272c3_defconfig
arm                        spear3xx_defconfig
arc                            hsdk_defconfig
sh                             shx3_defconfig
um                            kunit_defconfig
mips                        vocore2_defconfig
sh                      rts7751r2d1_defconfig
arm                     eseries_pxa_defconfig
mips                      malta_kvm_defconfig
m68k                         amcore_defconfig
arm                           viper_defconfig
ia64                          tiger_defconfig
mips                       capcella_defconfig
mips                        nlm_xlr_defconfig
sh                        dreamcast_defconfig
h8300                       h8s-sim_defconfig
powerpc64                           defconfig
xtensa                           alldefconfig
powerpc                      pmac32_defconfig
s390                          debug_defconfig
powerpc                    ge_imp3a_defconfig
arm                         s3c6400_defconfig
powerpc                  storcenter_defconfig
powerpc                 mpc837x_rdb_defconfig
openrisc                         alldefconfig
powerpc                      cm5200_defconfig
mips                          malta_defconfig
powerpc                     tqm8555_defconfig
powerpc                      ppc40x_defconfig
microblaze                          defconfig
sh                          rsk7203_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                           xway_defconfig
alpha                               defconfig
riscv                             allnoconfig
powerpc                     mpc512x_defconfig
powerpc                      walnut_defconfig
powerpc                     ep8248e_defconfig
alpha                            allyesconfig
riscv                               defconfig
h8300                               defconfig
arm                          pxa3xx_defconfig
i386                             allyesconfig
powerpc                     powernv_defconfig
i386                                defconfig
powerpc                     pq2fads_defconfig
mips                        jmr3927_defconfig
xtensa                  audio_kc705_defconfig
arm                        vexpress_defconfig
m68k                          hp300_defconfig
sh                          kfr2r09_defconfig
arm                       multi_v4t_defconfig
arm                          ixp4xx_defconfig
powerpc                      chrp32_defconfig
arm                          moxart_defconfig
powerpc                      arches_defconfig
arm                     am200epdkit_defconfig
sh                          lboxre2_defconfig
arm                         s3c2410_defconfig
c6x                        evmc6457_defconfig
powerpc                 linkstation_defconfig
mips                     loongson1b_defconfig
mips                         mpc30x_defconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a003-20201116
x86_64               randconfig-a005-20201116
x86_64               randconfig-a004-20201116
x86_64               randconfig-a002-20201116
x86_64               randconfig-a001-20201116
x86_64               randconfig-a006-20201116
i386                 randconfig-a006-20201116
i386                 randconfig-a005-20201116
i386                 randconfig-a001-20201116
i386                 randconfig-a002-20201116
i386                 randconfig-a004-20201116
i386                 randconfig-a003-20201116
i386                 randconfig-a006-20201115
i386                 randconfig-a005-20201115
i386                 randconfig-a001-20201115
i386                 randconfig-a002-20201115
i386                 randconfig-a004-20201115
i386                 randconfig-a003-20201115
x86_64               randconfig-a015-20201115
x86_64               randconfig-a011-20201115
x86_64               randconfig-a014-20201115
x86_64               randconfig-a013-20201115
x86_64               randconfig-a016-20201115
x86_64               randconfig-a012-20201115
i386                 randconfig-a012-20201116
i386                 randconfig-a014-20201116
i386                 randconfig-a016-20201116
i386                 randconfig-a011-20201116
i386                 randconfig-a015-20201116
i386                 randconfig-a013-20201116
i386                 randconfig-a012-20201115
i386                 randconfig-a014-20201115
i386                 randconfig-a016-20201115
i386                 randconfig-a011-20201115
i386                 randconfig-a015-20201115
i386                 randconfig-a013-20201115
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201115
x86_64               randconfig-a005-20201115
x86_64               randconfig-a004-20201115
x86_64               randconfig-a002-20201115
x86_64               randconfig-a001-20201115
x86_64               randconfig-a006-20201115
x86_64               randconfig-a015-20201116
x86_64               randconfig-a011-20201116
x86_64               randconfig-a014-20201116
x86_64               randconfig-a013-20201116
x86_64               randconfig-a016-20201116
x86_64               randconfig-a012-20201116

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
