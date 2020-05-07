Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AA71C8CBD
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2020 15:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgEGNmA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 May 2020 09:42:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:25612 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgEGNmA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 7 May 2020 09:42:00 -0400
IronPort-SDR: TAdeeNEFAmQzJoo1dMkQYaDTnoYseJ6TPIuoMsw2TG+tP+S+zS7KlAznzJnWsdYKUd85FphUGf
 pUy1SZ+VRFRw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 06:41:59 -0700
IronPort-SDR: hLjaUhbOimat38hUjEA1oVn4BT7ZOdGxBNomBsfg4nHBqLQFKSbvfrUDb6C11hVZFqwD7DuCdV
 1XdoYZz7BEig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; 
   d="scan'208";a="278602265"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 07 May 2020 06:41:57 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jWgmi-000GUQ-TO; Thu, 07 May 2020 21:41:56 +0800
Date:   Thu, 07 May 2020 21:41:41 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-hmm] BUILD SUCCESS
 65afd0405ffa20cd60010fc135a6cb54bf21303c
Message-ID: <5eb41015.WHhFmQGr0nXhH9pi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-hmm
branch HEAD: 65afd0405ffa20cd60010fc135a6cb54bf21303c  MAINTAINERS: add HMM selftests

elapsed time: 1001m

configs tested: 105
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
mips                             allyesconfig
riscv                               defconfig
sparc                               defconfig
i386                                defconfig
openrisc                         allyesconfig
c6x                               allnoconfig
mips                              allnoconfig
powerpc                             defconfig
nds32                               defconfig
s390                              allnoconfig
um                                allnoconfig
xtensa                              defconfig
um                                  defconfig
um                               allmodconfig
i386                             allyesconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
m68k                             allmodconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                              allnoconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
arc                              allyesconfig
microblaze                       allyesconfig
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
i386                 randconfig-a005-20200507
i386                 randconfig-a004-20200507
i386                 randconfig-a001-20200507
i386                 randconfig-a002-20200507
i386                 randconfig-a003-20200507
i386                 randconfig-a006-20200507
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
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                                defconfig
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
