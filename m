Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8C7204A30
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 08:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbgFWGtT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 02:49:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:52474 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730583AbgFWGtS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 02:49:18 -0400
IronPort-SDR: yQyKvJkDEcsnGQaJf7Sg9s5p79xLVhmWiUEAWAdagNKwvPjC0A3jLJJYR9ywTmgCAUDgbykzX9
 8R0DX03GnmHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="162058358"
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="scan'208";a="162058358"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 23:49:14 -0700
IronPort-SDR: yk4HUJX9h39Lx7TTnOsShllA2dybMwCRKY9ZOnBRJm1bEoyLjIugJSjlP2y/PSUeHX+Khg8s/Y
 S5iBWPv3wFgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="scan'208";a="275248901"
Received: from lkp-server01.sh.intel.com (HELO f484c95e4fd1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Jun 2020 23:49:12 -0700
Received: from kbuild by f484c95e4fd1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jnck3-0000eW-Mf; Tue, 23 Jun 2020 06:49:11 +0000
Date:   Tue, 23 Jun 2020 14:49:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 116a1b9f1cb769b83e5adff323f977a62b1dcb2e
Message-ID: <5ef1a5e0.388Fnuw6Jl0xD5u/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-rc
branch HEAD: 116a1b9f1cb769b83e5adff323f977a62b1dcb2e  IB/mad: Fix use after free when destroying MAD agent

elapsed time: 726m

configs tested: 151
configs skipped: 9

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
arm                           corgi_defconfig
arm                        realview_defconfig
xtensa                           allyesconfig
arm                            mmp2_defconfig
mips                malta_kvm_guest_defconfig
arm                         s3c6400_defconfig
xtensa                           alldefconfig
sh                  sh7785lcr_32bit_defconfig
arm                           h3600_defconfig
sh                          sdk7780_defconfig
x86_64                              defconfig
parisc                           alldefconfig
mips                malta_qemu_32r6_defconfig
arc                    vdk_hs38_smp_defconfig
arm                       netwinder_defconfig
mips                          ath79_defconfig
xtensa                    xip_kc705_defconfig
arm                        keystone_defconfig
arm                       versatile_defconfig
m68k                            mac_defconfig
sh                           sh2007_defconfig
mips                        omega2p_defconfig
powerpc                          g5_defconfig
c6x                         dsk6455_defconfig
arm                          tango4_defconfig
powerpc                      ppc44x_defconfig
m68k                             allyesconfig
arm                           efm32_defconfig
m68k                             alldefconfig
m68k                         apollo_defconfig
powerpc                     pseries_defconfig
sh                        sh7785lcr_defconfig
sh                          rsk7264_defconfig
mips                          malta_defconfig
sparc64                             defconfig
mips                    maltaup_xpa_defconfig
alpha                               defconfig
mips                       bmips_be_defconfig
ia64                            zx1_defconfig
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
alpha                            allyesconfig
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
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20200622
i386                 randconfig-a002-20200622
i386                 randconfig-a003-20200622
i386                 randconfig-a001-20200622
i386                 randconfig-a005-20200622
i386                 randconfig-a004-20200622
i386                 randconfig-a006-20200623
i386                 randconfig-a002-20200623
i386                 randconfig-a003-20200623
i386                 randconfig-a001-20200623
i386                 randconfig-a005-20200623
i386                 randconfig-a004-20200623
x86_64               randconfig-a012-20200623
x86_64               randconfig-a011-20200623
x86_64               randconfig-a013-20200623
x86_64               randconfig-a014-20200623
x86_64               randconfig-a015-20200623
x86_64               randconfig-a016-20200623
i386                 randconfig-a013-20200622
i386                 randconfig-a016-20200622
i386                 randconfig-a012-20200622
i386                 randconfig-a014-20200622
i386                 randconfig-a015-20200622
i386                 randconfig-a011-20200622
i386                 randconfig-a013-20200623
i386                 randconfig-a016-20200623
i386                 randconfig-a012-20200623
i386                 randconfig-a014-20200623
i386                 randconfig-a015-20200623
i386                 randconfig-a011-20200623
x86_64               randconfig-a004-20200622
x86_64               randconfig-a002-20200622
x86_64               randconfig-a003-20200622
x86_64               randconfig-a005-20200622
x86_64               randconfig-a001-20200622
x86_64               randconfig-a006-20200622
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
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
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
