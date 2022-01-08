Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20656488549
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jan 2022 19:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiAHSPG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Jan 2022 13:15:06 -0500
Received: from mga12.intel.com ([192.55.52.136]:45476 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbiAHSPF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 8 Jan 2022 13:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641665705; x=1673201705;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ESg9siVq4N7C8XQCqg9imY0NhTePDvzC9/hpwmmiysw=;
  b=VO05DsxJv68nvEr/CeyurCZFxLwQQTzI5Q0oXfriavMxDgmHacOE+Esp
   51BszVZQTqL9q7re0T/A1VD2+uUI3jQFFEkZ8MAs1wWllQyZEQQYJvCPq
   WaYDEeJfI/Qan0Y6904OaG2ZXi3xd4oa8rQklA5Hvhv7f3A0h2W8T+dDX
   n47o8qOch8q3s0kjogbsEpVlJgYNezaj/qeJBVBK/9Je3mZl5fRn+yXMu
   gP5UJzq9weNq6z0TUSaDl1awNg7Uf+7uJjEZVeMqyFaTrje0TwgyflpJk
   /SjehnrFJHcGLMtGoHevLXEnEbBl8+QeGNEXsQbJMmCtI0h1+LpoCdIWK
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="223017128"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="223017128"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 10:15:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="473683908"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Jan 2022 10:15:03 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n6GF4-0000tO-MZ; Sat, 08 Jan 2022 18:15:02 +0000
Date:   Sun, 09 Jan 2022 02:14:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 104f062fd1b9c8571dba6a3020649da6bbc66259
Message-ID: <61d9d49a.QT0YQOVitGUTzD1g%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 104f062fd1b9c8571dba6a3020649da6bbc66259  RDMA/rxe: Use the standard method to produce udp source port

possible Warning in current branch (please contact us if interested):

drivers/net/ethernet/mellanox/mlx5/core/fs_core.c:2861 create_fdb_bypass() warn: passing a valid pointer to 'PTR_ERR'

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-m021-20220107
    `-- drivers-net-ethernet-mellanox-mlx5-core-fs_core.c-create_fdb_bypass()-warn:passing-a-valid-pointer-to-PTR_ERR

elapsed time: 1106m

configs tested: 118
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220108
sh                                  defconfig
powerpc                      pasemi_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                    sam440ep_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                  randconfig-c002-20220107
arm                  randconfig-c002-20220108
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
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
i386                 randconfig-a003-20220107
i386                 randconfig-a005-20220107
i386                 randconfig-a004-20220107
i386                 randconfig-a006-20220107
i386                 randconfig-a002-20220107
i386                 randconfig-a001-20220107
x86_64               randconfig-a015-20220108
x86_64               randconfig-a012-20220108
x86_64               randconfig-a014-20220108
x86_64               randconfig-a013-20220108
x86_64               randconfig-a011-20220108
x86_64               randconfig-a016-20220108
i386                 randconfig-a012-20220108
i386                 randconfig-a016-20220108
i386                 randconfig-a015-20220108
i386                 randconfig-a014-20220108
i386                 randconfig-a011-20220108
i386                 randconfig-a013-20220108
s390                 randconfig-r044-20220108
arc                  randconfig-r043-20220108
riscv                randconfig-r042-20220108
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                  randconfig-c002-20220108
mips                 randconfig-c004-20220108
i386                 randconfig-c001-20220108
riscv                randconfig-c006-20220108
powerpc              randconfig-c003-20220108
x86_64               randconfig-c007-20220108
arm                          ixp4xx_defconfig
powerpc                     skiroot_defconfig
mips                        maltaup_defconfig
mips                           ip22_defconfig
i386                 randconfig-a003-20220108
i386                 randconfig-a005-20220108
i386                 randconfig-a006-20220108
i386                 randconfig-a004-20220108
i386                 randconfig-a001-20220108
i386                 randconfig-a002-20220108
x86_64               randconfig-a012-20220107
x86_64               randconfig-a015-20220107
x86_64               randconfig-a014-20220107
x86_64               randconfig-a013-20220107
x86_64               randconfig-a011-20220107
x86_64               randconfig-a016-20220107
x86_64               randconfig-a005-20220108
x86_64               randconfig-a001-20220108
x86_64               randconfig-a004-20220108
x86_64               randconfig-a006-20220108
x86_64               randconfig-a003-20220108
x86_64               randconfig-a002-20220108
hexagon              randconfig-r041-20220107
hexagon              randconfig-r045-20220107
riscv                randconfig-r042-20220107

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
