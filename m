Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A211CEB17
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 05:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgELDDn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 23:03:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:41889 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728524AbgELDDm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 23:03:42 -0400
IronPort-SDR: ImqkUPsd6CXJvzNPVp0BVi02Hov/qHyc5GSPcjPdd2b+mg7syvyjE4jxVFZNOi4vTUQj+Nlbqv
 YoPbDqrCeHng==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 20:03:42 -0700
IronPort-SDR: KWSEcrf+E2iAL9AwlKS1DUmy5KI0r/4ZeUAq+a0o2ePOGnQ9zVuBn9CRzaMDmGW6bzSehF6erU
 hAGZdiZHujNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; 
   d="scan'208";a="463386524"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 May 2020 20:03:40 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jYLCm-0001w0-23; Tue, 12 May 2020 11:03:40 +0800
Date:   Tue, 12 May 2020 11:03:05 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:hmm] BUILD SUCCESS 5aa2ffa941e7d1f604848b0081a459b8971ffc40
Message-ID: <5eba11e9.cpGTAasvCmDAO07y%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  hmm
branch HEAD: 5aa2ffa941e7d1f604848b0081a459b8971ffc40  MAINTAINERS: add HMM selftests

elapsed time: 764m

configs tested: 103
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
m68k                             allyesconfig
m68k                                defconfig
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
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20200511
x86_64               randconfig-a003-20200511
x86_64               randconfig-a006-20200511
x86_64               randconfig-a004-20200511
x86_64               randconfig-a001-20200511
x86_64               randconfig-a002-20200511
i386                 randconfig-a006-20200511
i386                 randconfig-a005-20200511
i386                 randconfig-a003-20200511
i386                 randconfig-a001-20200511
i386                 randconfig-a004-20200511
i386                 randconfig-a002-20200511
i386                 randconfig-a012-20200511
i386                 randconfig-a016-20200511
i386                 randconfig-a014-20200511
i386                 randconfig-a011-20200511
i386                 randconfig-a013-20200511
i386                 randconfig-a015-20200511
i386                 randconfig-a012-20200512
i386                 randconfig-a016-20200512
i386                 randconfig-a014-20200512
i386                 randconfig-a011-20200512
i386                 randconfig-a013-20200512
i386                 randconfig-a015-20200512
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
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
