Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4913A31A87C
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Feb 2021 00:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhBLXyu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 18:54:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:61909 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229679AbhBLXyt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Feb 2021 18:54:49 -0500
IronPort-SDR: jXRZufTsJYBm1a9m9Aq/drLMbXhlKl3bGlA9N04ABCK+3rTqHt6AdyRaP8J1ZtTi+wRrVP36+p
 gvjS8323gXEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="267340159"
X-IronPort-AV: E=Sophos;i="5.81,175,1610438400"; 
   d="scan'208";a="267340159"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 15:54:08 -0800
IronPort-SDR: WBYexs5JKZyaik6z89shYvkXvTRPwQNxAmwza4YoR0S0eickyUE/5iVqwTEjiPoTXG3SSIfPma
 Ev2wAHvIG88g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,175,1610438400"; 
   d="scan'208";a="511456390"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 12 Feb 2021 15:54:06 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lAiGD-0004xe-W3; Fri, 12 Feb 2021 23:54:05 +0000
Date:   Sat, 13 Feb 2021 07:53:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/for-testing] BUILD SUCCESS
 5556b910ecd94ac0f853e278ddadfddc762d6ee9
Message-ID: <602714f7.Iij+27WG5F91vJKM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/for-testing
branch HEAD: 5556b910ecd94ac0f853e278ddadfddc762d6ee9  Merge branch 'k.o/for-next' into k.o/wip/for-testing

elapsed time: 728m

configs tested: 164
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

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
nios2                         3c120_defconfig
powerpc                     tqm5200_defconfig
arm                           u8500_defconfig
mips                        nlm_xlp_defconfig
sh                      rts7751r2d1_defconfig
m68k                            q40_defconfig
arm                            lart_defconfig
arm                            pleb_defconfig
arm                   milbeaut_m10v_defconfig
h8300                            alldefconfig
powerpc                     mpc5200_defconfig
mips                         tb0287_defconfig
arm                       mainstone_defconfig
m68k                       m5208evb_defconfig
mips                      malta_kvm_defconfig
powerpc                        warp_defconfig
arm                         axm55xx_defconfig
sh                          landisk_defconfig
sh                        edosk7760_defconfig
arm                        realview_defconfig
arm                      integrator_defconfig
sparc                            allyesconfig
sh                        apsh4ad0a_defconfig
mips                       bmips_be_defconfig
powerpc                  iss476-smp_defconfig
sh                           se7705_defconfig
m68k                          hp300_defconfig
powerpc                 linkstation_defconfig
sh                            migor_defconfig
mips                      maltasmvp_defconfig
m68k                                defconfig
mips                           gcw0_defconfig
sh                          rsk7269_defconfig
m68k                       m5475evb_defconfig
sh                           se7751_defconfig
sh                   rts7751r2dplus_defconfig
arm                          pxa3xx_defconfig
sh                           se7206_defconfig
sh                         ap325rxa_defconfig
powerpc                       eiger_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                 mpc832x_rdb_defconfig
m68k                        m5407c3_defconfig
c6x                              allyesconfig
powerpc                 mpc832x_mds_defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc64e_defconfig
mips                           ci20_defconfig
xtensa                           allyesconfig
arm                       cns3420vb_defconfig
arm                      pxa255-idp_defconfig
arm                          exynos_defconfig
powerpc                 canyonlands_defconfig
arm                           corgi_defconfig
um                             i386_defconfig
arm                             rpc_defconfig
powerpc                     stx_gp3_defconfig
powerpc                   bluestone_defconfig
sh                          rsk7203_defconfig
nds32                               defconfig
powerpc                    gamecube_defconfig
mips                          ath79_defconfig
powerpc64                        alldefconfig
s390                          debug_defconfig
powerpc                       holly_defconfig
powerpc                     kmeter1_defconfig
openrisc                  or1klitex_defconfig
arm                           h5000_defconfig
arm                        clps711x_defconfig
arc                        nsim_700_defconfig
powerpc                      pmac32_defconfig
openrisc                 simple_smp_defconfig
powerpc                        icon_defconfig
parisc                              defconfig
parisc                generic-32bit_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
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
x86_64               randconfig-a013-20210209
x86_64               randconfig-a014-20210209
x86_64               randconfig-a015-20210209
x86_64               randconfig-a012-20210209
x86_64               randconfig-a016-20210209
x86_64               randconfig-a011-20210209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
