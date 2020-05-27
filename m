Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591B81E451E
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2020 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbgE0ODl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 10:03:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:52053 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730313AbgE0ODl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 May 2020 10:03:41 -0400
IronPort-SDR: w9VlWd3ecUKFvU/lplCqOkxHAur6WquGc6TU4+pUeYQiHPsEIOiFWyuyDqPi3GAyM03Cvsyu9h
 xaZAt4gCVzkg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 07:03:40 -0700
IronPort-SDR: BgrxeIDOT6JFP6pXyzU2axg/jYipdACUyH+DdMW+W/AgFSd1w10gRYmvFhnxRAFNMExe6JZygV
 NUgbZVztdTWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,441,1583222400"; 
   d="scan'208";a="255791499"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 May 2020 07:03:38 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jdwef-000DJa-T0; Wed, 27 May 2020 22:03:37 +0800
Date:   Wed, 27 May 2020 22:03:05 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 db857e6ae548f0f4f4a0f63fffeeedf3cca21f9d
Message-ID: <5ece7319.MILU3OujEsWIlzLK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-rc
branch HEAD: db857e6ae548f0f4f4a0f63fffeeedf3cca21f9d  RDMA/pvrdma: Fix missing pci disable in pvrdma_pci_probe()

elapsed time: 2674m

configs tested: 121
configs skipped: 1

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
sh                           se7722_defconfig
arc                        vdk_hs38_defconfig
arm                          gemini_defconfig
sh                          sdk7786_defconfig
powerpc                      ppc64e_defconfig
h8300                               defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                              allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
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
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
arc                              allyesconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
x86_64               randconfig-a006-20200527
x86_64               randconfig-a002-20200527
x86_64               randconfig-a005-20200527
x86_64               randconfig-a003-20200527
x86_64               randconfig-a004-20200527
x86_64               randconfig-a001-20200527
i386                 randconfig-a001-20200527
i386                 randconfig-a004-20200527
i386                 randconfig-a003-20200527
i386                 randconfig-a006-20200527
i386                 randconfig-a002-20200527
i386                 randconfig-a005-20200527
i386                 randconfig-a001-20200526
i386                 randconfig-a004-20200526
i386                 randconfig-a003-20200526
i386                 randconfig-a006-20200526
i386                 randconfig-a002-20200526
i386                 randconfig-a005-20200526
x86_64               randconfig-a015-20200526
x86_64               randconfig-a013-20200526
x86_64               randconfig-a016-20200526
x86_64               randconfig-a012-20200526
x86_64               randconfig-a014-20200526
x86_64               randconfig-a011-20200526
i386                 randconfig-a013-20200527
i386                 randconfig-a015-20200527
i386                 randconfig-a012-20200527
i386                 randconfig-a011-20200527
i386                 randconfig-a016-20200527
i386                 randconfig-a014-20200527
i386                 randconfig-a013-20200526
i386                 randconfig-a015-20200526
i386                 randconfig-a012-20200526
i386                 randconfig-a011-20200526
i386                 randconfig-a016-20200526
i386                 randconfig-a014-20200526
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
um                                allnoconfig
um                                  defconfig
um                               allyesconfig
um                               allmodconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
