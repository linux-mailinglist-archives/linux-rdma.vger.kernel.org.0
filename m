Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90FC2133D8
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jul 2020 08:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbgGCGFE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jul 2020 02:05:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:41640 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgGCGFE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 3 Jul 2020 02:05:04 -0400
IronPort-SDR: yGjtKnsW6TLH6LFvDMpWlNFu+HAYtJJm5P6PJ7p1/xBDXRTMfD+YD4J3JzEpAKw50kN/1s9Ox2
 nmnl17hUf37A==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="144621171"
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="144621171"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 23:05:03 -0700
IronPort-SDR: CucZVcgtgniBWYtJJlUEgZ0l6NCnLSlsnI7cDFuI3LPGta8Lc+HeTu8DXoOJRXuqGObjx3IXrl
 EDTOy/q4W0/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="482262672"
Received: from lkp-server01.sh.intel.com (HELO 6dc8ab148a5d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Jul 2020 23:05:01 -0700
Received: from kbuild by 6dc8ab148a5d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jrEon-00003M-96; Fri, 03 Jul 2020 06:05:01 +0000
Date:   Fri, 03 Jul 2020 14:04:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 2315ec12ee8e8257bb335654c62e0cae71dc278d
Message-ID: <5efeca87.kNDVeXPDURtS9R1s%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-rc
branch HEAD: 2315ec12ee8e8257bb335654c62e0cae71dc278d  IB/hfi1: Do not destroy link_wq when the device is shut down

elapsed time: 727m

configs tested: 125
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                       aspeed_g4_defconfig
m68k                       m5249evb_defconfig
arm                            mmp2_defconfig
sh                            shmin_defconfig
powerpc                      pmac32_defconfig
parisc                           allmodconfig
sh                               j2_defconfig
sh                             espt_defconfig
x86_64                           alldefconfig
arm                          exynos_defconfig
arc                     nsimosci_hs_defconfig
arc                          axs103_defconfig
powerpc                  mpc885_ads_defconfig
arm                   milbeaut_m10v_defconfig
sh                        dreamcast_defconfig
openrisc                    or1ksim_defconfig
arm                         lubbock_defconfig
m68k                       bvme6000_defconfig
microblaze                          defconfig
arm                         orion5x_defconfig
mips                         cobalt_defconfig
sh                           se7721_defconfig
mips                  maltasmvp_eva_defconfig
ia64                        generic_defconfig
microblaze                    nommu_defconfig
parisc                generic-64bit_defconfig
mips                        jmr3927_defconfig
mips                 decstation_r4k_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200701
i386                 randconfig-a001-20200701
i386                 randconfig-a006-20200701
i386                 randconfig-a005-20200701
i386                 randconfig-a004-20200701
i386                 randconfig-a003-20200701
x86_64               randconfig-a012-20200701
x86_64               randconfig-a016-20200701
x86_64               randconfig-a014-20200701
x86_64               randconfig-a011-20200701
x86_64               randconfig-a015-20200701
x86_64               randconfig-a013-20200701
i386                 randconfig-a011-20200701
i386                 randconfig-a015-20200701
i386                 randconfig-a014-20200701
i386                 randconfig-a016-20200701
i386                 randconfig-a012-20200701
i386                 randconfig-a013-20200701
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allyesconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
