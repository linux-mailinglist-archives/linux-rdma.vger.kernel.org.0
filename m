Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63ABD1C8BF2
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2020 15:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgEGNTy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 May 2020 09:19:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:19662 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgEGNTx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 May 2020 09:19:53 -0400
IronPort-SDR: 4Y5jeM8fp2AM6fvCi0mnEdzJ5POzTeCXMrG+8z/LC+58pz05yCmt8q82cknU3vYIQPhOmsp3ML
 Yb2XovPA/Kzg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 06:19:53 -0700
IronPort-SDR: 3Ncge8kwVRLPHkl0NssR9+k081skaKX72t7tdhvmIOtwfDI731SMccgUlUfrnY6Ac2o5BH7o9d
 0+bCZQKPBK3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; 
   d="scan'208";a="435285473"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 May 2020 06:19:51 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jWgRK-0004Nl-Vt; Thu, 07 May 2020 21:19:50 +0800
Date:   Thu, 07 May 2020 21:19:04 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 029e88fd1e6142ded73f07e2baef3e8a2a87e0ed
Message-ID: <5eb40ac8.g8z8SVDu63il7MBQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 029e88fd1e6142ded73f07e2baef3e8a2a87e0ed  RDMA/mlx5: Move all WR logic from qp.c to separate file

elapsed time: 978m

configs tested: 86
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
sparc                            allyesconfig
m68k                             allyesconfig
ia64                             allyesconfig
s390                             allmodconfig
i386                              allnoconfig
h8300                            allmodconfig
csky                             allyesconfig
nios2                               defconfig
um                                  defconfig
csky                                defconfig
nds32                             allnoconfig
openrisc                            defconfig
mips                              allnoconfig
powerpc                             defconfig
nios2                            allyesconfig
alpha                               defconfig
parisc                           allyesconfig
um                                allnoconfig
alpha                            allyesconfig
m68k                              allnoconfig
xtensa                              defconfig
riscv                               defconfig
openrisc                         allyesconfig
um                               allmodconfig
nds32                               defconfig
microblaze                       allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
m68k                             allmodconfig
m68k                           sun3_defconfig
m68k                                defconfig
c6x                              allyesconfig
c6x                               allnoconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                             allmodconfig
parisc                              defconfig
parisc                            allnoconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20200507
x86_64               randconfig-a006-20200507
x86_64               randconfig-a002-20200507
i386                 randconfig-a001-20200507
i386                 randconfig-a002-20200507
i386                 randconfig-a003-20200507
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                                defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allyesconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
