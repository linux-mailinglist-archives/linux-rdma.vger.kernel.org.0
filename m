Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208D41C8A35
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2020 14:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgEGMOW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 May 2020 08:14:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:64545 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgEGMOU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 May 2020 08:14:20 -0400
IronPort-SDR: kbLPmmwvW6EcNcwLEM55emzCaeMiSniv6d230Mvx2bSpZ6s6dWkLMh+/1ySnE+mG0CNJ/BDMY5
 NCFhHLvbOPbw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 05:14:19 -0700
IronPort-SDR: LzxkjcxXLhLnj9tS8IZvenSa4dGhstglluspdO+Jf+DjHwX3WaGM+e/hXKszhTTgIBwS9UvclX
 8knJK5potytw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; 
   d="scan'208";a="296516957"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 May 2020 05:14:18 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jWfPt-0008dd-KT; Thu, 07 May 2020 20:14:17 +0800
Date:   Thu, 07 May 2020 20:13:46 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 56c91440ff00d63b6d6cd206d8e2759918f6eebd
Message-ID: <5eb3fb7a.0sIZrooTvvHODHzd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-rc
branch HEAD: 56c91440ff00d63b6d6cd206d8e2759918f6eebd  IB/hfi1: Fix another case where pq is left on waitlist

elapsed time: 913m

configs tested: 102
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                               defconfig
sparc                            allyesconfig
m68k                             allyesconfig
ia64                             allyesconfig
i386                              allnoconfig
s390                             allmodconfig
h8300                            allmodconfig
csky                             allyesconfig
mips                             allyesconfig
nios2                               defconfig
um                                  defconfig
riscv                               defconfig
sparc                               defconfig
i386                                defconfig
openrisc                         allyesconfig
openrisc                            defconfig
nds32                               defconfig
mips                              allnoconfig
powerpc                             defconfig
s390                              allnoconfig
um                                allnoconfig
sparc64                          allmodconfig
um                               allmodconfig
c6x                               allnoconfig
microblaze                       allyesconfig
csky                                defconfig
i386                             allyesconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
m68k                              allnoconfig
m68k                             allmodconfig
m68k                           sun3_defconfig
m68k                                defconfig
nios2                            allyesconfig
c6x                              allyesconfig
nds32                             allnoconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                           allmodconfig
parisc                              defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a015-20200507
x86_64               randconfig-a014-20200507
x86_64               randconfig-a012-20200507
x86_64               randconfig-a013-20200507
x86_64               randconfig-a011-20200507
x86_64               randconfig-a016-20200507
i386                 randconfig-a012-20200507
i386                 randconfig-a016-20200507
i386                 randconfig-a014-20200507
i386                 randconfig-a011-20200507
i386                 randconfig-a015-20200507
i386                 randconfig-a013-20200507
x86_64               randconfig-a003-20200506
x86_64               randconfig-a001-20200506
x86_64               randconfig-a002-20200506
i386                 randconfig-a001-20200506
i386                 randconfig-a002-20200506
i386                 randconfig-a003-20200506
x86_64               randconfig-a002-20200507
i386                 randconfig-a001-20200507
i386                 randconfig-a002-20200507
i386                 randconfig-a003-20200507
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                                defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
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
