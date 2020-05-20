Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EA51DA937
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 06:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgETE2E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 00:28:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:37720 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgETE2D (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 May 2020 00:28:03 -0400
IronPort-SDR: ysnku8ad2EV812vjOuuzQk4w7I+ZGCKtR23+W9H+mTsEGqHnVjqT9NtyXgv4JMpShQuH9Q+bGO
 1AXZL3Swc7ig==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 21:28:03 -0700
IronPort-SDR: SPj+EkO4XTecNoaVeQpIQ3NRPTFP1FkIS6kbw2oZqGSWvVfvVJemsn3j3Zot5cqxZOXbSuxFus
 PWaIvxTxS9fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,412,1583222400"; 
   d="scan'208";a="289217007"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 May 2020 21:28:02 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jbGKn-0001q3-CW; Wed, 20 May 2020 12:28:01 +0800
Date:   Wed, 20 May 2020 12:27:42 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:hmm] BUILD SUCCESS f07e2f6be37a750737b93f5635485171ad459eb9
Message-ID: <5ec4b1be.S32iRfEJLXpQOGM/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  hmm
branch HEAD: f07e2f6be37a750737b93f5635485171ad459eb9  MAINTAINERS: add HMM selftests

i386-tinyconfig vmlinux size:

+-------+-----------------------------------+------------------------------------------+
| DELTA |              SYMBOL               |                  COMMIT                  |
+-------+-----------------------------------+------------------------------------------+
|   +98 | TOTAL                             | 0e698dfa2822..f07e2f6be37a (ALL COMMITS) |
|   +96 | TEXT                              | 0e698dfa2822..f07e2f6be37a (ALL COMMITS) |
| +1355 | balance_dirty_pages()             | 0e698dfa2822..f07e2f6be37a (ALL COMMITS) |
|  +615 | __setup_rt_frame()                | 0e698dfa2822..f07e2f6be37a (ALL COMMITS) |
|  +113 | klist_release()                   | 0e698dfa2822..f07e2f6be37a (ALL COMMITS) |
|   +93 | change_clocksource()              | 0e698dfa2822..f07e2f6be37a (ALL COMMITS) |
|   +86 | release_bdi()                     | 0e698dfa2822..f07e2f6be37a (ALL COMMITS) |
|   +84 | kobject_release()                 | 0e698dfa2822..f07e2f6be37a (ALL COMMITS) |
|   -68 | bdi_put()                         | 0e698dfa2822..f07e2f6be37a (ALL COMMITS) |
|   -77 | kobject_put()                     | 0e698dfa2822..f07e2f6be37a (ALL COMMITS) |
|   -79 | timekeeping_notify()              | 0e698dfa2822..f07e2f6be37a (ALL COMMITS) |
|   -99 | klist_dec_and_del()               | 0e698dfa2822..f07e2f6be37a (ALL COMMITS) |
|  -555 | do_signal()                       | 0e698dfa2822..f07e2f6be37a (ALL COMMITS) |
| -1383 | balance_dirty_pages_ratelimited() | 0e698dfa2822..f07e2f6be37a (ALL COMMITS) |
+-------+-----------------------------------+------------------------------------------+

elapsed time: 484m

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
sparc                            allyesconfig
mips                             allyesconfig
m68k                             allyesconfig
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
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
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
i386                 randconfig-a006-20200519
i386                 randconfig-a005-20200519
i386                 randconfig-a001-20200519
i386                 randconfig-a003-20200519
i386                 randconfig-a004-20200519
i386                 randconfig-a002-20200519
x86_64               randconfig-a003-20200519
x86_64               randconfig-a005-20200519
x86_64               randconfig-a004-20200519
x86_64               randconfig-a006-20200519
x86_64               randconfig-a002-20200519
x86_64               randconfig-a001-20200519
i386                 randconfig-a012-20200519
i386                 randconfig-a014-20200519
i386                 randconfig-a016-20200519
i386                 randconfig-a011-20200519
i386                 randconfig-a015-20200519
i386                 randconfig-a013-20200519
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
x86_64                              defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
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
