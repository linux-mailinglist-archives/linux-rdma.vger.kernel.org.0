Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E6C4875E8
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 11:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbiAGKu7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 05:50:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:11128 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232217AbiAGKu7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jan 2022 05:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641552659; x=1673088659;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=s+7HYiIuc/MFlMjeoq0l6jB/4GbhbcYv8t8upjOhj04=;
  b=Q7NcT9e7+RzvbPijN5IPmyNGPNpwu4cw0voXsPQPJzSpb9vMED1O9XnT
   psEhXqnEJs10U14rLL3KOqigkvHBXffrLmynhA7fOB3NI8WCD0BP6OSku
   s6IOASvM6jIqQ4jCw24OIBd5lEyDfrz5Ex7OATtm93iL9vMl5/BHcSMA7
   ujIATTOPAKmvXbtIM76I5tnU2h5oFutVb4wV4FTSTIppY6Usavh9SfgxH
   O2QQ2XHwqhN1FVc9Aad6PIFds0uEh1iwRx4IFcPwMkM3e89RswRgQvN8X
   7Sxzc/LvMS1Rae8BmDzZNBPubgt+taing/xI7mYMD4b6WuUKgMEEl1XP5
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="223542949"
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="223542949"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 02:50:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,269,1635231600"; 
   d="scan'208";a="471276238"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Jan 2022 02:50:52 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5mpf-000IZV-BD; Fri, 07 Jan 2022 10:50:51 +0000
Date:   Fri, 07 Jan 2022 18:50:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 ca2770c65b56374374fa00c349883e67c16943de
Message-ID: <61d81ae7.Cx8S+EApMWriQST5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: ca2770c65b56374374fa00c349883e67c16943de  IB/iser: Align coding style across driver

elapsed time: 733m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220107
arm                       omap2plus_defconfig
arm                            lart_defconfig
sh                        sh7763rdp_defconfig
sh                           se7343_defconfig
sh                     sh7710voipgw_defconfig
sh                           se7721_defconfig
m68k                        mvme147_defconfig
sh                          lboxre2_defconfig
powerpc                      chrp32_defconfig
powerpc                      mgcoge_defconfig
mips                           jazz_defconfig
arm                           viper_defconfig
xtensa                    smp_lx200_defconfig
sparc64                          alldefconfig
arm                           h5000_defconfig
arm                          badge4_defconfig
sh                        dreamcast_defconfig
arm                  randconfig-c002-20220107
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
s390                                defconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20220107
x86_64               randconfig-a001-20220107
x86_64               randconfig-a004-20220107
x86_64               randconfig-a006-20220107
x86_64               randconfig-a002-20220107
x86_64               randconfig-a003-20220107
i386                 randconfig-a005-20220107
i386                 randconfig-a004-20220107
i386                 randconfig-a006-20220107
i386                 randconfig-a002-20220107
i386                 randconfig-a001-20220107
i386                 randconfig-a003-20220107
arc                  randconfig-r043-20220107
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
mips                 randconfig-c004-20220107
arm                  randconfig-c002-20220107
i386                 randconfig-c001-20220107
riscv                randconfig-c006-20220107
powerpc              randconfig-c003-20220107
x86_64               randconfig-c007-20220107
mips                        qi_lb60_defconfig
arm                          collie_defconfig
powerpc                          allyesconfig
arm                         s5pv210_defconfig
arm                         palmz72_defconfig
powerpc                 xes_mpc85xx_defconfig
x86_64               randconfig-a012-20220107
x86_64               randconfig-a015-20220107
x86_64               randconfig-a014-20220107
x86_64               randconfig-a013-20220107
x86_64               randconfig-a011-20220107
x86_64               randconfig-a016-20220107
i386                 randconfig-a012-20220107
i386                 randconfig-a016-20220107
i386                 randconfig-a014-20220107
i386                 randconfig-a015-20220107
i386                 randconfig-a011-20220107
i386                 randconfig-a013-20220107
hexagon              randconfig-r041-20220107
hexagon              randconfig-r045-20220107
riscv                randconfig-r042-20220107
s390                 randconfig-r044-20220107

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
