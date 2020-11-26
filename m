Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9EFC2C571B
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 15:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389965AbgKZO2H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Nov 2020 09:28:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:53182 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389991AbgKZO2H (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Nov 2020 09:28:07 -0500
IronPort-SDR: u5rrq8G92IbozbQW8KsW935zvo97Id+LFsSmN1s4PrSdl30i+Xy0vh6FXfsZMVg0X5C2K24dFn
 cWEqduV/xAgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="256999135"
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="256999135"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 06:28:06 -0800
IronPort-SDR: I5gW8i/zPLiMZs2mHlalsWUnH/bs66y1PlLUhccGvT6GpPOHqxr19ZZ5ehLooh3aMXGAa0lPrG
 c8sFQDXQ0vSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="333393727"
Received: from lkp-server02.sh.intel.com (HELO 334d66ce2fbf) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 26 Nov 2020 06:28:03 -0800
Received: from kbuild by 334d66ce2fbf with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kiIFe-00007J-CZ; Thu, 26 Nov 2020 14:28:02 +0000
Date:   Thu, 26 Nov 2020 22:27:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 dd37d2f59eb839d51b988f6668ce5f0d533b23fd
Message-ID: <5fbfbb6f.rkOB2B1M+B8sIcc5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: dd37d2f59eb839d51b988f6668ce5f0d533b23fd  RDMA/cma: Fix deadlock on &lock in rdma_cma_listen_on_all() error unwind

elapsed time: 721m

configs tested: 114
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
sh                          landisk_defconfig
arm                            pleb_defconfig
arm                          pcm027_defconfig
arm                         orion5x_defconfig
mips                           ip22_defconfig
powerpc                      obs600_defconfig
arm                        realview_defconfig
openrisc                 simple_smp_defconfig
arm                            mps2_defconfig
openrisc                    or1ksim_defconfig
m68k                        m5307c3_defconfig
mips                        maltaup_defconfig
mips                       rbtx49xx_defconfig
arm                        trizeps4_defconfig
h8300                            allyesconfig
powerpc                 mpc8313_rdb_defconfig
sh                         apsh4a3a_defconfig
mips                        jmr3927_defconfig
arm                           omap1_defconfig
arm                            hisi_defconfig
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
