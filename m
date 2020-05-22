Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5A21DE757
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 14:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgEVMzh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 08:55:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:60924 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728853AbgEVMzh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 22 May 2020 08:55:37 -0400
IronPort-SDR: EDG1C6niLLVmTlZ5Iwdzu1Zxvvu8ZN0+eoJ9TbX9k2phPvW4Qk9JdSGOtAF1lcetI/qqzSMN4N
 nSf5GLUAmqGA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 05:55:35 -0700
IronPort-SDR: VXTYuzdkQcePahcIdcqGMT0k3KgLHT3k6TWt1w6GGs32szPzjh+HA1AdcHp1Z3VYM6c/gwlA73
 Wf3KQqxwzQ/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,421,1583222400"; 
   d="scan'208";a="255589414"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 22 May 2020 05:55:34 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jc7D3-000Gfy-M6; Fri, 22 May 2020 20:55:33 +0800
Date:   Fri, 22 May 2020 20:55:24 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 d6ea395072457153f2120e2361657e00f3c0958d
Message-ID: <5ec7cbbc.0CYNFADX5hQPEz55%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-next
branch HEAD: d6ea395072457153f2120e2361657e00f3c0958d  rnbd/rtrs: Pass max segment size from blk user to the rdma library

elapsed time: 951m

configs tested: 116
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
sparc                            allyesconfig
mips                             allyesconfig
m68k                             allyesconfig
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
alpha                               defconfig
alpha                            allyesconfig
xtensa                              defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
arc                                 defconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
arc                              allyesconfig
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
i386                 randconfig-a001-20200521
i386                 randconfig-a004-20200521
i386                 randconfig-a006-20200521
i386                 randconfig-a003-20200521
i386                 randconfig-a002-20200521
i386                 randconfig-a005-20200521
x86_64               randconfig-a015-20200522
x86_64               randconfig-a013-20200522
x86_64               randconfig-a016-20200522
x86_64               randconfig-a012-20200522
x86_64               randconfig-a014-20200522
x86_64               randconfig-a011-20200522
x86_64               randconfig-a013-20200520
x86_64               randconfig-a015-20200520
x86_64               randconfig-a016-20200520
x86_64               randconfig-a012-20200520
x86_64               randconfig-a014-20200520
x86_64               randconfig-a011-20200520
i386                 randconfig-a013-20200522
i386                 randconfig-a012-20200522
i386                 randconfig-a015-20200522
i386                 randconfig-a011-20200522
i386                 randconfig-a016-20200522
i386                 randconfig-a014-20200522
i386                 randconfig-a013-20200521
i386                 randconfig-a012-20200521
i386                 randconfig-a015-20200521
i386                 randconfig-a011-20200521
i386                 randconfig-a016-20200521
i386                 randconfig-a014-20200521
x86_64               randconfig-a002-20200521
x86_64               randconfig-a006-20200521
x86_64               randconfig-a005-20200521
x86_64               randconfig-a004-20200521
x86_64               randconfig-a003-20200521
x86_64               randconfig-a001-20200521
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             allyesconfig
s390                                defconfig
x86_64                              defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allyesconfig
um                               allmodconfig
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
