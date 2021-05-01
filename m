Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F2A370524
	for <lists+linux-rdma@lfdr.de>; Sat,  1 May 2021 05:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhEAD13 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Apr 2021 23:27:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:14062 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhEAD13 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Apr 2021 23:27:29 -0400
IronPort-SDR: NZ/hscpy5Bgu/kxtX9dmwUueVx1tBq6/6BnTCA16N9rdsrwptorjCgi07AXM1HSGxnh1pkl5/f
 j+Kc4d+AmtfQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9970"; a="196980912"
X-IronPort-AV: E=Sophos;i="5.82,264,1613462400"; 
   d="scan'208";a="196980912"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 20:26:39 -0700
IronPort-SDR: 7GjntREsA+piEe0c5jQLIhBGRLrjkrDq4FGzG8j96mhCbSek9ViaUK9OKyj3DMuZyLUau3/bau
 AlV0NKZslcog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,264,1613462400"; 
   d="scan'208";a="456213610"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Apr 2021 20:26:37 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lcgH6-0008PQ-Os; Sat, 01 May 2021 03:26:36 +0000
Date:   Sat, 01 May 2021 11:25:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 6da7bda36388ae00822f732c11febfe2ebbb5544
Message-ID: <608cca43.10qqZRt2OiEOk0bL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 6da7bda36388ae00822f732c11febfe2ebbb5544  IB/qib: Remove redundant assignment to ret

elapsed time: 720m

configs tested: 113
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
m68k                          hp300_defconfig
powerpc                   bluestone_defconfig
nios2                         3c120_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                        omega2p_defconfig
sh                      rts7751r2d1_defconfig
m68k                       m5208evb_defconfig
powerpc                          g5_defconfig
i386                                defconfig
s390                             alldefconfig
mips                         rt305x_defconfig
powerpc                      katmai_defconfig
m68k                       m5275evb_defconfig
h8300                            allyesconfig
arm                        shmobile_defconfig
sh                               allmodconfig
powerpc                     pseries_defconfig
mips                      loongson3_defconfig
powerpc                 mpc8315_rdb_defconfig
ia64                          tiger_defconfig
mips                        jmr3927_defconfig
m68k                       bvme6000_defconfig
ia64                         bigsur_defconfig
mips                        vocore2_defconfig
parisc                              defconfig
mips                          ath79_defconfig
m68k                        stmark2_defconfig
mips                           jazz_defconfig
openrisc                            defconfig
sh                             shx3_defconfig
sh                  sh7785lcr_32bit_defconfig
h8300                       h8s-sim_defconfig
mips                           ip27_defconfig
m68k                        m5407c3_defconfig
sh                        edosk7760_defconfig
sh                   secureedge5410_defconfig
arm                         mv78xx0_defconfig
openrisc                  or1klitex_defconfig
mips                          rb532_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210430
x86_64               randconfig-a004-20210430
x86_64               randconfig-a002-20210430
x86_64               randconfig-a006-20210430
x86_64               randconfig-a001-20210430
x86_64               randconfig-a005-20210430
i386                 randconfig-a004-20210430
i386                 randconfig-a001-20210430
i386                 randconfig-a003-20210430
i386                 randconfig-a002-20210430
i386                 randconfig-a005-20210430
i386                 randconfig-a006-20210430
i386                 randconfig-a013-20210430
i386                 randconfig-a011-20210430
i386                 randconfig-a016-20210430
i386                 randconfig-a015-20210430
i386                 randconfig-a012-20210430
i386                 randconfig-a014-20210430
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210430
x86_64               randconfig-a016-20210430
x86_64               randconfig-a013-20210430
x86_64               randconfig-a014-20210430
x86_64               randconfig-a012-20210430
x86_64               randconfig-a015-20210430

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
