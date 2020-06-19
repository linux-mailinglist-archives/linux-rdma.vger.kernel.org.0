Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EEA200231
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 08:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgFSGvw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 02:51:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:42476 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729080AbgFSGvw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Jun 2020 02:51:52 -0400
IronPort-SDR: nYToZn0s7sou9wnbyp4fW82A0Pi7qmqw4GfvH48huHzpk6fHjys40jdTF6ytFYxSrPp+3yQFMV
 wH1cntAUSfaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="123121996"
X-IronPort-AV: E=Sophos;i="5.75,254,1589266800"; 
   d="scan'208";a="123121996"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 23:51:49 -0700
IronPort-SDR: x4GOquGFYL/FqyLtNfyzIKH11HDAuWwgvH4po5ESFq+dQte6Pj+3WzInwNpIA3AG3HYvqByS+I
 urAKIDw1GzhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,254,1589266800"; 
   d="scan'208";a="450917753"
Received: from lkp-server02.sh.intel.com (HELO 5ce11009e457) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Jun 2020 23:51:49 -0700
Received: from kbuild by 5ce11009e457 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jmAsO-0000jD-Lo; Fri, 19 Jun 2020 06:51:48 +0000
Date:   Fri, 19 Jun 2020 14:51:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 9e0dc7b9e1cbc9cd0dc4ab2377c0536d4b18bedc
Message-ID: <5eec606e.DyB2NuDM7gIYHsry%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-rc
branch HEAD: 9e0dc7b9e1cbc9cd0dc4ab2377c0536d4b18bedc  RDMA/mlx5: Fix integrity enabled QP creation

elapsed time: 721m

configs tested: 98
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
h8300                            allmodconfig
xtensa                              defconfig
h8300                            allyesconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                              allnoconfig
mips                             allyesconfig
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
i386                 randconfig-a002-20200618
i386                 randconfig-a006-20200618
i386                 randconfig-a001-20200618
i386                 randconfig-a004-20200618
i386                 randconfig-a005-20200618
i386                 randconfig-a003-20200618
x86_64               randconfig-a001-20200618
x86_64               randconfig-a003-20200618
x86_64               randconfig-a006-20200618
x86_64               randconfig-a002-20200618
x86_64               randconfig-a005-20200618
x86_64               randconfig-a004-20200618
i386                 randconfig-a011-20200618
i386                 randconfig-a015-20200618
i386                 randconfig-a014-20200618
i386                 randconfig-a013-20200618
i386                 randconfig-a016-20200618
i386                 randconfig-a012-20200618
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
um                               allyesconfig
um                                  defconfig
um                               allmodconfig
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
