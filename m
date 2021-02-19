Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9DF31F88B
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Feb 2021 12:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhBSLmv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Feb 2021 06:42:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:43408 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230468AbhBSLmO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Feb 2021 06:42:14 -0500
IronPort-SDR: uL2TXmWL9Y9vTLoLTa1U3kYaYkQXCk80XRnt6I4cEwzlytwhE18FEUF9mwil2nF+uJjFwqA/ld
 a0nHxoFgP9Og==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="183936599"
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="183936599"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 03:41:31 -0800
IronPort-SDR: AMsZ3ZM+b+yE7XEACXA5BlshxjuxUUn5AaqcZ+QRFyiB3DBR7QKwxd/iBTjegriKMnsfV3sp01
 OfzVPV3aA3XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,189,1610438400"; 
   d="scan'208";a="594665935"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 19 Feb 2021 03:41:29 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lD4A5-000AMA-9E; Fri, 19 Feb 2021 11:41:29 +0000
Date:   Fri, 19 Feb 2021 19:40:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 7289e26f395b583f68b676d4d12a0971e4f6f65c
Message-ID: <602fa3b1.aCgzMBN323W4bwab%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 7289e26f395b583f68b676d4d12a0971e4f6f65c  Merge tag 'v5.11' into rdma.git for-next

elapsed time: 720m

configs tested: 107
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                             alldefconfig
powerpc                      pcm030_defconfig
sh                        edosk7760_defconfig
mips                        qi_lb60_defconfig
riscv                          rv32_defconfig
arm                             pxa_defconfig
arm                       omap2plus_defconfig
m68k                        mvme16x_defconfig
mips                      bmips_stb_defconfig
powerpc                 mpc836x_mds_defconfig
m68k                        m5407c3_defconfig
arm                         palmz72_defconfig
powerpc                     tqm8540_defconfig
sh                            migor_defconfig
mips                         cobalt_defconfig
powerpc                     tqm8541_defconfig
arm                        vexpress_defconfig
powerpc                     mpc83xx_defconfig
mips                      loongson3_defconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210218
x86_64               randconfig-a001-20210218
x86_64               randconfig-a004-20210218
x86_64               randconfig-a002-20210218
x86_64               randconfig-a005-20210218
x86_64               randconfig-a006-20210218
i386                 randconfig-a005-20210218
i386                 randconfig-a003-20210218
i386                 randconfig-a002-20210218
i386                 randconfig-a004-20210218
i386                 randconfig-a001-20210218
i386                 randconfig-a006-20210218
x86_64               randconfig-a013-20210217
x86_64               randconfig-a016-20210217
x86_64               randconfig-a012-20210217
x86_64               randconfig-a015-20210217
x86_64               randconfig-a014-20210217
x86_64               randconfig-a011-20210217
i386                 randconfig-a016-20210217
i386                 randconfig-a014-20210217
i386                 randconfig-a012-20210217
i386                 randconfig-a013-20210217
i386                 randconfig-a011-20210217
i386                 randconfig-a015-20210217
i386                 randconfig-a016-20210218
i386                 randconfig-a012-20210218
i386                 randconfig-a014-20210218
i386                 randconfig-a013-20210218
i386                 randconfig-a011-20210218
i386                 randconfig-a015-20210218
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20210218
x86_64               randconfig-a016-20210218
x86_64               randconfig-a013-20210218
x86_64               randconfig-a015-20210218
x86_64               randconfig-a011-20210218
x86_64               randconfig-a014-20210218

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
