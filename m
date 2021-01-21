Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746C02FF24D
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 18:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389024AbhAURq0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 12:46:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:36779 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388907AbhAURqT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Jan 2021 12:46:19 -0500
IronPort-SDR: mxkFyeu+eyQvRAS4v8u2RXES3unRTlP7aIak6cbQ6wxlD7Pqe/avWaXyZRXyirRxmecBtsIthm
 /HYdxq6oAC8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="176737776"
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="176737776"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 09:45:32 -0800
IronPort-SDR: Ixxd/Sj8W6GiZiymIJeLfU2unTlnd4FfUHVIW0TidD9n3jrYl8OcsCKRmRQ6/o48jDXvUEii5+
 kA49+Rv14wfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="467530698"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jan 2021 09:45:30 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l2e1R-0006eP-22; Thu, 21 Jan 2021 17:45:29 +0000
Date:   Fri, 22 Jan 2021 01:44:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 90da7dc8206a5999a23af719733f1cda26b5f815
Message-ID: <6009bd90.K3SmJs+wt3aL/cFE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 90da7dc8206a5999a23af719733f1cda26b5f815  RDMA/mlx5: Support dma-buf based userspace memory region

elapsed time: 984m

configs tested: 165
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                          axs101_defconfig
sh                   sh7770_generic_defconfig
c6x                              alldefconfig
arm                     davinci_all_defconfig
mips                        omega2p_defconfig
sh                        dreamcast_defconfig
powerpc                     ppa8548_defconfig
sh                           se7780_defconfig
arm                       aspeed_g5_defconfig
powerpc                       holly_defconfig
powerpc                 mpc836x_mds_defconfig
h8300                     edosk2674_defconfig
arc                        vdk_hs38_defconfig
powerpc                 mpc832x_mds_defconfig
arm                        keystone_defconfig
ia64                         bigsur_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                      arches_defconfig
mips                    maltaup_xpa_defconfig
arc                           tb10x_defconfig
powerpc                         wii_defconfig
mips                        vocore2_defconfig
arm                          moxart_defconfig
powerpc                      acadia_defconfig
powerpc                       eiger_defconfig
arm                          pxa910_defconfig
m68k                        stmark2_defconfig
arm                        multi_v7_defconfig
mips                           ip28_defconfig
sh                               j2_defconfig
arm                         vf610m4_defconfig
ia64                      gensparse_defconfig
arm                       imx_v4_v5_defconfig
mips                malta_qemu_32r6_defconfig
mips                            e55_defconfig
arm                        clps711x_defconfig
mips                      malta_kvm_defconfig
m68k                        mvme16x_defconfig
mips                       lemote2f_defconfig
arm                          pcm027_defconfig
arc                        nsim_700_defconfig
m68k                           sun3_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      obs600_defconfig
powerpc                   lite5200b_defconfig
sh                   secureedge5410_defconfig
sparc                       sparc64_defconfig
arm                       multi_v4t_defconfig
sh                        sh7757lcr_defconfig
mips                           ip27_defconfig
arm                       spear13xx_defconfig
m68k                          multi_defconfig
xtensa                  nommu_kc705_defconfig
arm                           corgi_defconfig
powerpc                    adder875_defconfig
powerpc                     powernv_defconfig
mips                           xway_defconfig
powerpc                  storcenter_defconfig
arm                           sunxi_defconfig
powerpc                 mpc834x_itx_defconfig
mips                            ar7_defconfig
ia64                        generic_defconfig
mips                        jmr3927_defconfig
c6x                         dsk6455_defconfig
powerpc                     pseries_defconfig
mips                           rs90_defconfig
mips                       bmips_be_defconfig
sh                        edosk7705_defconfig
xtensa                         virt_defconfig
i386                             alldefconfig
sh                          rsk7264_defconfig
powerpc                      pasemi_defconfig
sh                          kfr2r09_defconfig
powerpc                    socrates_defconfig
sh                          r7785rp_defconfig
sh                      rts7751r2d1_defconfig
powerpc                       ppc64_defconfig
mips                      pistachio_defconfig
powerpc                 mpc837x_mds_defconfig
arm                        oxnas_v6_defconfig
arm                          gemini_defconfig
m68k                        m5407c3_defconfig
mips                           jazz_defconfig
mips                           gcw0_defconfig
xtensa                generic_kc705_defconfig
sh                        sh7763rdp_defconfig
powerpc                      ppc6xx_defconfig
mips                           ip22_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                        edosk7760_defconfig
m68k                          atari_defconfig
arm                        cerfcube_defconfig
arm                          ixp4xx_defconfig
powerpc                     kmeter1_defconfig
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
i386                 randconfig-a013-20210121
i386                 randconfig-a011-20210121
i386                 randconfig-a012-20210121
i386                 randconfig-a014-20210121
i386                 randconfig-a015-20210121
i386                 randconfig-a016-20210121
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
