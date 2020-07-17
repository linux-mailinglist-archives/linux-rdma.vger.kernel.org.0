Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C662232AF
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jul 2020 07:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgGQFBX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Jul 2020 01:01:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:28688 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgGQFBX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Jul 2020 01:01:23 -0400
IronPort-SDR: Ib8jMxDjHwsAAbSwi7s9tR/+uwgj+Ox9zNV+csN1MfwZKcYLKaGJWXnMDvYEwolz6ifQAbHPtA
 vb8z24RBedjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="234389691"
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="234389691"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 22:01:23 -0700
IronPort-SDR: B7WGDgu1TNT2ykgYAJB9wD5FdhS4xGSB5g+57ubsoI/FjzBzpyv+EqX+ilbVPbqF7xhVfQwcXB
 S8XsNCyk8t0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="460728386"
Received: from lkp-server02.sh.intel.com (HELO 50058c6ee6fc) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Jul 2020 22:01:21 -0700
Received: from kbuild by 50058c6ee6fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jwIUq-00005x-RU; Fri, 17 Jul 2020 05:01:20 +0000
Date:   Fri, 17 Jul 2020 13:00:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 cbeb7d896c0f296451ffa7b67e7706786b8364c8
Message-ID: <5f113053.b+0JeU8OV4HiX+F+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-next
branch HEAD: cbeb7d896c0f296451ffa7b67e7706786b8364c8  RDMA/counter: Allow manually bind QPs with different pids to same counter

elapsed time: 815m

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
m68k                             allyesconfig
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
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
x86_64               randconfig-a012-20200716
x86_64               randconfig-a011-20200716
x86_64               randconfig-a016-20200716
x86_64               randconfig-a014-20200716
x86_64               randconfig-a013-20200716
x86_64               randconfig-a015-20200716
i386                 randconfig-a016-20200716
i386                 randconfig-a011-20200716
i386                 randconfig-a015-20200716
i386                 randconfig-a012-20200716
i386                 randconfig-a013-20200716
i386                 randconfig-a014-20200716
i386                 randconfig-a016-20200717
i386                 randconfig-a011-20200717
i386                 randconfig-a015-20200717
i386                 randconfig-a012-20200717
i386                 randconfig-a013-20200717
i386                 randconfig-a014-20200717
x86_64               randconfig-a005-20200717
x86_64               randconfig-a006-20200717
x86_64               randconfig-a002-20200717
x86_64               randconfig-a001-20200717
x86_64               randconfig-a003-20200717
x86_64               randconfig-a004-20200717
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
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
