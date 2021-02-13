Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7207B31ADEB
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Feb 2021 21:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBMUSa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 13 Feb 2021 15:18:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:8566 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhBMUS3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 13 Feb 2021 15:18:29 -0500
IronPort-SDR: bY1gvjYhv/fm7TTymi1HirMSgzQdwtjHfvssEW9g7fmO0omoda5Edo32omUngNr3wi2Hfg3U7I
 2plt/jes8ngg==
X-IronPort-AV: E=McAfee;i="6000,8403,9894"; a="182613949"
X-IronPort-AV: E=Sophos;i="5.81,176,1610438400"; 
   d="scan'208";a="182613949"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2021 12:17:47 -0800
IronPort-SDR: tduJPTmLfEhBUX2HhcjPBJAKHf4kKHge4FE87qil4RzepZZyaEl1KelRIA6sA4FHGdGh5ILZ4w
 KcmW/jztRplg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,176,1610438400"; 
   d="scan'208";a="363366926"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Feb 2021 12:17:45 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lB1MP-0005u8-5v; Sat, 13 Feb 2021 20:17:45 +0000
Date:   Sun, 14 Feb 2021 04:17:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS WITH WARNING
 c88b31c46cefe50f524a1ad3deaf1599bc9ee2e6
Message-ID: <602833d3.bkkrTbjoMtEStQaB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: c88b31c46cefe50f524a1ad3deaf1599bc9ee2e6  RDMA/mlx5: Fail QP creation if the device can not support the CQE TS

possible Warning in current branch:

drivers/infiniband/ulp/rtrs/rtrs-srv.c:1805 rtrs_rdma_connect() warn: passing zero to 'PTR_ERR'

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- ia64-randconfig-m031-20210209
    `-- drivers-infiniband-ulp-rtrs-rtrs-srv.c-rtrs_rdma_connect()-warn:passing-zero-to-PTR_ERR

elapsed time: 1532m

configs tested: 169
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         shannon_defconfig
arm                     davinci_all_defconfig
arc                        vdk_hs38_defconfig
sh                        sh7763rdp_defconfig
c6x                        evmc6474_defconfig
sh                      rts7751r2d1_defconfig
m68k                            q40_defconfig
arm                            lart_defconfig
arm                            pleb_defconfig
arm                   milbeaut_m10v_defconfig
h8300                            alldefconfig
arm                         axm55xx_defconfig
sh                          landisk_defconfig
sh                        edosk7760_defconfig
arm                        realview_defconfig
arm                      integrator_defconfig
sh                        apsh4ad0a_defconfig
mips                       bmips_be_defconfig
powerpc                  iss476-smp_defconfig
arm                          pxa3xx_defconfig
sh                           se7206_defconfig
sh                         ap325rxa_defconfig
powerpc                       eiger_defconfig
xtensa                  cadence_csp_defconfig
powerpc64                           defconfig
arc                              alldefconfig
microblaze                      mmu_defconfig
powerpc                 mpc834x_mds_defconfig
xtensa                           allyesconfig
arm                       cns3420vb_defconfig
arm                      pxa255-idp_defconfig
arm                          exynos_defconfig
powerpc                 canyonlands_defconfig
powerpc                   bluestone_defconfig
sh                          rsk7203_defconfig
powerpc                    gamecube_defconfig
mips                          ath79_defconfig
powerpc64                        alldefconfig
powerpc                     mpc5200_defconfig
arm                        clps711x_defconfig
arc                        nsim_700_defconfig
powerpc                      pmac32_defconfig
openrisc                 simple_smp_defconfig
powerpc                        icon_defconfig
xtensa                    xip_kc705_defconfig
powerpc                    socrates_defconfig
arm                        neponset_defconfig
arm                         orion5x_defconfig
xtensa                         virt_defconfig
mips                         bigsur_defconfig
m68k                             allmodconfig
arm                        magician_defconfig
mips                            e55_defconfig
parisc                              defconfig
parisc                generic-32bit_defconfig
powerpc                         ps3_defconfig
arm                       imx_v4_v5_defconfig
m68k                          atari_defconfig
mips                  cavium_octeon_defconfig
s390                          debug_defconfig
m68k                       m5208evb_defconfig
mips                     decstation_defconfig
mips                        nlm_xlp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
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
x86_64               randconfig-a006-20210209
x86_64               randconfig-a001-20210209
x86_64               randconfig-a005-20210209
x86_64               randconfig-a004-20210209
x86_64               randconfig-a002-20210209
x86_64               randconfig-a003-20210209
i386                 randconfig-a001-20210209
i386                 randconfig-a005-20210209
i386                 randconfig-a003-20210209
i386                 randconfig-a002-20210209
i386                 randconfig-a006-20210209
i386                 randconfig-a004-20210209
i386                 randconfig-a003-20210212
i386                 randconfig-a005-20210212
i386                 randconfig-a002-20210212
i386                 randconfig-a001-20210212
i386                 randconfig-a004-20210212
i386                 randconfig-a006-20210212
i386                 randconfig-a003-20210213
i386                 randconfig-a005-20210213
i386                 randconfig-a002-20210213
i386                 randconfig-a001-20210213
i386                 randconfig-a004-20210213
i386                 randconfig-a006-20210213
x86_64               randconfig-a013-20210213
x86_64               randconfig-a016-20210213
x86_64               randconfig-a012-20210213
x86_64               randconfig-a015-20210213
x86_64               randconfig-a014-20210213
x86_64               randconfig-a011-20210213
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
i386                 randconfig-a016-20210213
i386                 randconfig-a014-20210213
i386                 randconfig-a012-20210213
i386                 randconfig-a013-20210213
i386                 randconfig-a011-20210213
i386                 randconfig-a015-20210213
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
x86_64               randconfig-a003-20210211
x86_64               randconfig-a002-20210211
x86_64               randconfig-a001-20210211
x86_64               randconfig-a004-20210211
x86_64               randconfig-a005-20210211
x86_64               randconfig-a006-20210211
x86_64               randconfig-a003-20210213
x86_64               randconfig-a002-20210213
x86_64               randconfig-a013-20210209
x86_64               randconfig-a014-20210209
x86_64               randconfig-a015-20210209
x86_64               randconfig-a012-20210209
x86_64               randconfig-a016-20210209
x86_64               randconfig-a011-20210209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
