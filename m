Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642E02238D0
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jul 2020 11:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgGQJ7P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Jul 2020 05:59:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:12460 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgGQJ7O (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Jul 2020 05:59:14 -0400
IronPort-SDR: v1GcjWLZT3+0pC90q5ZVYbTjmMu9lvFn7WBISSyg29DM3u5qA0q0BUdSD4nYRpt9/0FluPVqPH
 YtlvkzLV+jbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="211104249"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="211104249"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 02:59:12 -0700
IronPort-SDR: uVclMNilNfBV/bVjCIQwWBaujjqL0lDWjJoBBtx7NjPPoMud0Om6SySWXG2jFz5waPy9zvsc9q
 md4I86P8nLbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="486418906"
Received: from lkp-server02.sh.intel.com (HELO 50058c6ee6fc) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jul 2020 02:59:11 -0700
Received: from kbuild by 50058c6ee6fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jwN94-0000Fe-Hf; Fri, 17 Jul 2020 09:59:10 +0000
Date:   Fri, 17 Jul 2020 17:57:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 5f0b2a6093a4d9aab093964c65083fe801ef1e58
Message-ID: <5f117623.D6HyjDIYuSZFdVz4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 5f0b2a6093a4d9aab093964c65083fe801ef1e58  RDMA/rxe: Prevent access to wr->next ptr afrer wr is posted to send queue

elapsed time: 725m

configs tested: 91
configs skipped: 2

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
nds32                             allnoconfig
powerpc                      ppc64e_defconfig
arm                           viper_defconfig
ia64                             alldefconfig
sh                           se7721_defconfig
arm                       aspeed_g4_defconfig
mips                           ip27_defconfig
m68k                        m5307c3_defconfig
sh                               j2_defconfig
powerpc                       ppc64_defconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                        jmr3927_defconfig
arm                            xcep_defconfig
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
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nios2                               defconfig
nios2                            allyesconfig
nds32                               defconfig
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
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20200717
i386                 randconfig-a005-20200717
i386                 randconfig-a002-20200717
i386                 randconfig-a006-20200717
i386                 randconfig-a003-20200717
i386                 randconfig-a004-20200717
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
