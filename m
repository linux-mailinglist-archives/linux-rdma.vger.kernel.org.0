Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7816F2C571A
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 15:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390003AbgKZO2F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Nov 2020 09:28:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:19961 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389965AbgKZO2E (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Nov 2020 09:28:04 -0500
IronPort-SDR: DF5Xi1W5hnYwP7k7zlSjRGeUUJlvLYCXRRcxNHpFBXgT5Tv9jTYdPv8QECgbekKQ6Ivs6OUYZc
 dHiTy0u6x71Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="233895325"
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="233895325"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 06:28:04 -0800
IronPort-SDR: eu6rJipcwVy7UbvNz7mF4d3jmI0x0eHCE/URBYuPkETk/4EhreIPsT3adk9JEs0QOKGdjhrt/7
 wCrX0nQw8cKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="314030672"
Received: from lkp-server02.sh.intel.com (HELO 334d66ce2fbf) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 26 Nov 2020 06:28:03 -0800
Received: from kbuild by 334d66ce2fbf with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kiIFe-00007M-GX; Thu, 26 Nov 2020 14:28:02 +0000
Date:   Thu, 26 Nov 2020 22:27:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 3d2a9d642512c21a12d19b9250e7a835dcb41a79
Message-ID: <5fbfbb68.tg/CiobIcRl9Y/JI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-rc
branch HEAD: 3d2a9d642512c21a12d19b9250e7a835dcb41a79  IB/hfi1: Ensure correct mm is used at all times

elapsed time: 721m

configs tested: 142
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                  cavium_octeon_defconfig
mips                        omega2p_defconfig
ia64                        generic_defconfig
m68k                          multi_defconfig
h8300                     edosk2674_defconfig
sparc                            alldefconfig
powerpc                     sequoia_defconfig
mips                    maltaup_xpa_defconfig
arc                          axs103_defconfig
sh                          landisk_defconfig
arm                            pleb_defconfig
arm                          pcm027_defconfig
arm                         orion5x_defconfig
mips                           ip22_defconfig
mips                     loongson1c_defconfig
arc                        nsim_700_defconfig
parisc                generic-32bit_defconfig
arm                           viper_defconfig
arc                     haps_hs_smp_defconfig
arm                        mini2440_defconfig
powerpc                   currituck_defconfig
sh                           se7343_defconfig
powerpc                 canyonlands_defconfig
h8300                       h8s-sim_defconfig
arm                         lpc18xx_defconfig
mips                           ip27_defconfig
arm                       cns3420vb_defconfig
arm                        magician_defconfig
mips                            e55_defconfig
powerpc                      obs600_defconfig
arm                        realview_defconfig
openrisc                 simple_smp_defconfig
arm                            mps2_defconfig
openrisc                    or1ksim_defconfig
m68k                        m5307c3_defconfig
mips                        maltaup_defconfig
mips                       rbtx49xx_defconfig
arm                        trizeps4_defconfig
arm                          pxa3xx_defconfig
arm                       netwinder_defconfig
arm                            dove_defconfig
mips                        workpad_defconfig
arm                         at91_dt_defconfig
powerpc                     tqm8555_defconfig
s390                             alldefconfig
powerpc                     mpc512x_defconfig
sh                           se7705_defconfig
m68k                       m5249evb_defconfig
mips                       capcella_defconfig
arm                   milbeaut_m10v_defconfig
sh                         ecovec24_defconfig
arm                             pxa_defconfig
s390                          debug_defconfig
sh                          r7785rp_defconfig
mips                           xway_defconfig
xtensa                           alldefconfig
sh                          lboxre2_defconfig
m68k                         apollo_defconfig
arm                           h3600_defconfig
mips                      pic32mzda_defconfig
m68k                       m5275evb_defconfig
sh                            shmin_defconfig
mips                        vocore2_defconfig
sh                          rsk7203_defconfig
powerpc                      ep88xc_defconfig
powerpc                 mpc8272_ads_defconfig
arm                         lubbock_defconfig
arm                          pxa168_defconfig
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
x86_64               randconfig-a006-20201126
x86_64               randconfig-a003-20201126
x86_64               randconfig-a004-20201126
x86_64               randconfig-a005-20201126
x86_64               randconfig-a001-20201126
x86_64               randconfig-a002-20201126
i386                 randconfig-a004-20201126
i386                 randconfig-a003-20201126
i386                 randconfig-a002-20201126
i386                 randconfig-a005-20201126
i386                 randconfig-a001-20201126
i386                 randconfig-a006-20201126
i386                 randconfig-a012-20201126
i386                 randconfig-a013-20201126
i386                 randconfig-a011-20201126
i386                 randconfig-a016-20201126
i386                 randconfig-a014-20201126
i386                 randconfig-a015-20201126
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
x86_64               randconfig-a015-20201126
x86_64               randconfig-a011-20201126
x86_64               randconfig-a014-20201126
x86_64               randconfig-a016-20201126
x86_64               randconfig-a012-20201126
x86_64               randconfig-a013-20201126

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
