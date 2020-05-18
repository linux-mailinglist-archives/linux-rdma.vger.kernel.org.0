Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F76C1D7122
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 08:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgERGhq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 May 2020 02:37:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:9195 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgERGhq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 May 2020 02:37:46 -0400
IronPort-SDR: QcBlHZXyROOV2fBnMlB2YlDedmGs0PrbHuufUbj/bxeUjYVjshLYf6ib34i0qi8cnJhzArS3XV
 gdTgMS1a4ZuA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 23:37:45 -0700
IronPort-SDR: aXfO74V5gJlj23GqrvSKYatyKmRDbI1BpcXPrbn958GWsQ7zIvmNoOkgfXEFuul6NVr6bTS2ej
 RLf5gB7+IzRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,406,1583222400"; 
   d="scan'208";a="288463681"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 17 May 2020 23:37:44 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jaZPD-0008CQ-Qk; Mon, 18 May 2020 14:37:43 +0800
Date:   Mon, 18 May 2020 14:37:23 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 f11e0ec55f0c80ff47693af2150bad5db0e20387
Message-ID: <5ec22d23.gLXfQSP31aa4ek6A%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-next
branch HEAD: f11e0ec55f0c80ff47693af2150bad5db0e20387  MAINTAINERS: Add maintainers for RNBD/RTRS modules

elapsed time: 496m

configs tested: 160
configs skipped: 13

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
sparc                            allyesconfig
mips                             allyesconfig
m68k                             allyesconfig
sh                             sh03_defconfig
arm                         vf610m4_defconfig
h8300                               defconfig
mips                         rt305x_defconfig
arc                           tb10x_defconfig
mips                        workpad_defconfig
powerpc                     ep8248e_defconfig
sh                        dreamcast_defconfig
mips                          ath79_defconfig
m68k                                defconfig
powerpc                           allnoconfig
arm                            mmp2_defconfig
mips                     loongson1c_defconfig
arc                        nsimosci_defconfig
nds32                               defconfig
nios2                            allyesconfig
arc                            hsdk_defconfig
mips                      loongson3_defconfig
arm                        oxnas_v6_defconfig
powerpc                          allyesconfig
sparc                               defconfig
powerpc                      ppc6xx_defconfig
m68k                       bvme6000_defconfig
powerpc                mpc7448_hpc2_defconfig
m68k                         apollo_defconfig
sh                          r7785rp_defconfig
arm                           omap1_defconfig
arm                            mps2_defconfig
arm                            pleb_defconfig
h8300                            alldefconfig
microblaze                      mmu_defconfig
powerpc                      ppc44x_defconfig
sparc64                             defconfig
arm                       multi_v4t_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc8272_ads_defconfig
arm                           h3600_defconfig
mips                malta_qemu_32r6_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          lpd270_defconfig
arm                        shmobile_defconfig
sh                          r7780mp_defconfig
arm                          pcm027_defconfig
powerpc                       ppc64_defconfig
parisc                generic-32bit_defconfig
arm                          ep93xx_defconfig
arm                    vt8500_v6_v7_defconfig
arm                         hackkit_defconfig
xtensa                         virt_defconfig
arm                              zx_defconfig
mips                           ci20_defconfig
parisc                              defconfig
um                             i386_defconfig
alpha                               defconfig
powerpc                         ps3_defconfig
arm                             mxs_defconfig
s390                             alldefconfig
sh                     magicpanelr2_defconfig
arm                          imote2_defconfig
i386                              allnoconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
nios2                               defconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
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
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
x86_64               randconfig-a005-20200517
x86_64               randconfig-a003-20200517
x86_64               randconfig-a006-20200517
x86_64               randconfig-a004-20200517
x86_64               randconfig-a001-20200517
x86_64               randconfig-a002-20200517
i386                 randconfig-a006-20200517
i386                 randconfig-a005-20200517
i386                 randconfig-a003-20200517
i386                 randconfig-a001-20200517
i386                 randconfig-a004-20200517
i386                 randconfig-a002-20200517
i386                 randconfig-a006-20200518
i386                 randconfig-a005-20200518
i386                 randconfig-a001-20200518
i386                 randconfig-a003-20200518
i386                 randconfig-a004-20200518
i386                 randconfig-a002-20200518
x86_64               randconfig-a016-20200518
x86_64               randconfig-a012-20200518
x86_64               randconfig-a015-20200518
x86_64               randconfig-a013-20200518
x86_64               randconfig-a011-20200518
x86_64               randconfig-a014-20200518
i386                 randconfig-a012-20200518
i386                 randconfig-a014-20200518
i386                 randconfig-a016-20200518
i386                 randconfig-a011-20200518
i386                 randconfig-a015-20200518
i386                 randconfig-a013-20200518
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
x86_64                              defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-7.6-kselftests
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
