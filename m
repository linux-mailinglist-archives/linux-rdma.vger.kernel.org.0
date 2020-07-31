Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7452E234204
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jul 2020 11:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbgGaJHR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jul 2020 05:07:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:63479 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731981AbgGaJHR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 Jul 2020 05:07:17 -0400
IronPort-SDR: ftNpzAhao/WulGY3cb9f+gmpJl7NsXQOM1bbJAE2h8n4LvO5tYaO/YodorDR9XfdFt8vkS/wq8
 5D9brO1V7nvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="149577001"
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="149577001"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 02:07:16 -0700
IronPort-SDR: VSIWuHcFU1ND4Ku5dV5EptqY/jdhD/geDfm3Iy5C0slee48+94OKyw/blUyjveAA4dqbMrsZSv
 S0S4+Ur9xJ+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="491425711"
Received: from lkp-server02.sh.intel.com (HELO d4d86dd808e0) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 31 Jul 2020 02:07:14 -0700
Received: from kbuild by d4d86dd808e0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k1R0T-0000VK-Km; Fri, 31 Jul 2020 09:07:13 +0000
Date:   Fri, 31 Jul 2020 17:06:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 395f2e8fd340c5bfad026f5968b56ec34cf20dd1
Message-ID: <5f23df0f.RQePvG7QMxokFg0K%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-next
branch HEAD: 395f2e8fd340c5bfad026f5968b56ec34cf20dd1  RDMA/hns: Fix the unneeded process when getting a general type of CQE error

elapsed time: 725m

configs tested: 84
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
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
powerpc                             defconfig
i386                 randconfig-a005-20200730
i386                 randconfig-a004-20200730
i386                 randconfig-a006-20200730
i386                 randconfig-a002-20200730
i386                 randconfig-a001-20200730
i386                 randconfig-a003-20200730
i386                 randconfig-a005-20200731
i386                 randconfig-a004-20200731
i386                 randconfig-a006-20200731
i386                 randconfig-a002-20200731
i386                 randconfig-a001-20200731
i386                 randconfig-a003-20200731
x86_64               randconfig-a001-20200730
x86_64               randconfig-a004-20200730
x86_64               randconfig-a002-20200730
x86_64               randconfig-a006-20200730
x86_64               randconfig-a003-20200730
x86_64               randconfig-a005-20200730
x86_64               randconfig-a015-20200731
x86_64               randconfig-a014-20200731
x86_64               randconfig-a016-20200731
x86_64               randconfig-a012-20200731
x86_64               randconfig-a013-20200731
x86_64               randconfig-a011-20200731
i386                 randconfig-a016-20200731
i386                 randconfig-a012-20200731
i386                 randconfig-a014-20200731
i386                 randconfig-a015-20200731
i386                 randconfig-a011-20200731
i386                 randconfig-a013-20200731
i386                 randconfig-a016-20200730
i386                 randconfig-a012-20200730
i386                 randconfig-a014-20200730
i386                 randconfig-a015-20200730
i386                 randconfig-a011-20200730
i386                 randconfig-a013-20200730
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
