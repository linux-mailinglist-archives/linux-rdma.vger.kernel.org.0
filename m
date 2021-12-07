Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1C646BC3C
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 14:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbhLGNS2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 08:18:28 -0500
Received: from mga05.intel.com ([192.55.52.43]:2361 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236923AbhLGNS1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Dec 2021 08:18:27 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="323825640"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="323825640"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 05:14:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="563507045"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 07 Dec 2021 05:14:56 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muaJ5-000MbN-KY; Tue, 07 Dec 2021 13:14:55 +0000
Date:   Tue, 07 Dec 2021 21:14:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 0a0575a12e31657415d1d5f799d4b65f3c9e8ba4
Message-ID: <61af5e20.ReRpPhbYNWO48rc/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 0a0575a12e31657415d1d5f799d4b65f3c9e8ba4  RDMA/bnxt_re: Fix endianness warning for req.pkey

elapsed time: 724m

configs tested: 147
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211207
powerpc                     tqm8541_defconfig
mips                     decstation_defconfig
parisc                           allyesconfig
powerpc                 mpc837x_rdb_defconfig
arm                       omap2plus_defconfig
sh                                  defconfig
sh                             sh03_defconfig
arm                       cns3420vb_defconfig
mips                           rs90_defconfig
powerpc                     skiroot_defconfig
mips                        workpad_defconfig
m68k                        m5307c3_defconfig
m68k                         apollo_defconfig
m68k                          atari_defconfig
arm                       multi_v4t_defconfig
xtensa                  nommu_kc705_defconfig
mips                      malta_kvm_defconfig
riscv                    nommu_virt_defconfig
powerpc                     taishan_defconfig
arm                          iop32x_defconfig
arm                         mv78xx0_defconfig
arc                     nsimosci_hs_defconfig
arm                         bcm2835_defconfig
sh                        apsh4ad0a_defconfig
arm                         vf610m4_defconfig
sh                          lboxre2_defconfig
arm                         shannon_defconfig
powerpc                 mpc8540_ads_defconfig
sh                            titan_defconfig
m68k                             allmodconfig
arm                             rpc_defconfig
mips                    maltaup_xpa_defconfig
xtensa                generic_kc705_defconfig
arm                         at91_dt_defconfig
arm                           spitz_defconfig
arc                           tb10x_defconfig
arm                         lpc32xx_defconfig
arm                          simpad_defconfig
arm                       imx_v4_v5_defconfig
mips                         tb0219_defconfig
arm                           sama7_defconfig
mips                            e55_defconfig
powerpc                   motionpro_defconfig
openrisc                         alldefconfig
powerpc                   lite5200b_defconfig
mips                         mpc30x_defconfig
m68k                                defconfig
arc                         haps_hs_defconfig
sparc                            alldefconfig
arm                         s5pv210_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     pq2fads_defconfig
mips                        omega2p_defconfig
arm                        keystone_defconfig
arm                        cerfcube_defconfig
powerpc                     akebono_defconfig
sparc                            allyesconfig
mips                         db1xxx_defconfig
mips                     cu1000-neo_defconfig
powerpc                      pmac32_defconfig
powerpc                        fsp2_defconfig
powerpc                 mpc836x_mds_defconfig
sh                           se7705_defconfig
powerpc                     tqm5200_defconfig
arm                            mps2_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                       common_defconfig
sh                             shx3_defconfig
arm                  randconfig-c002-20211207
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
s390                             allmodconfig
s390                                defconfig
sparc                               defconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211207
x86_64               randconfig-a005-20211207
x86_64               randconfig-a001-20211207
x86_64               randconfig-a002-20211207
x86_64               randconfig-a004-20211207
x86_64               randconfig-a003-20211207
i386                 randconfig-a001-20211207
i386                 randconfig-a005-20211207
i386                 randconfig-a002-20211207
i386                 randconfig-a003-20211207
i386                 randconfig-a006-20211207
i386                 randconfig-a004-20211207
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20211207
x86_64               randconfig-a011-20211207
x86_64               randconfig-a013-20211207
x86_64               randconfig-a014-20211207
x86_64               randconfig-a015-20211207
x86_64               randconfig-a012-20211207
i386                 randconfig-a016-20211207
i386                 randconfig-a013-20211207
i386                 randconfig-a011-20211207
i386                 randconfig-a014-20211207
i386                 randconfig-a012-20211207
i386                 randconfig-a015-20211207
hexagon              randconfig-r045-20211207
s390                 randconfig-r044-20211207
riscv                randconfig-r042-20211207
hexagon              randconfig-r041-20211207

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
