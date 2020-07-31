Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D9D234203
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jul 2020 11:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731848AbgGaJHP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jul 2020 05:07:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:31756 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbgGaJHP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 Jul 2020 05:07:15 -0400
IronPort-SDR: HXPbKZVkTYv7kRP5+9jrXaSHz/PqZwKwP8FXN2sXl+/RD+fcZLFSdT9agbqj1bEh9p9Hf0s50b
 tHAn4rlXxvlA==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="152959526"
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="152959526"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 02:07:14 -0700
IronPort-SDR: 8CWZOhhA0eW4Wfjq2eejbdoaDZo5J/BvOeV6/HDKXK9S/9coF++sVymy7KjmUxn/zsnIm+wE+w
 Kzse+3V1ymUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="287126084"
Received: from lkp-server02.sh.intel.com (HELO d4d86dd808e0) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 31 Jul 2020 02:07:12 -0700
Received: from kbuild by d4d86dd808e0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k1R0S-0000VE-4Z; Fri, 31 Jul 2020 09:07:12 +0000
Date:   Fri, 31 Jul 2020 17:06:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 fb448ce87a4a9482b084e67faf804aec79ed9b43
Message-ID: <5f23df11.FzoaDpcgEloZ5MPL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-rc
branch HEAD: fb448ce87a4a9482b084e67faf804aec79ed9b43  RDMA/core: Free DIM memory in error unwind

elapsed time: 725m

configs tested: 66
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20200731
i386                 randconfig-a004-20200731
i386                 randconfig-a006-20200731
i386                 randconfig-a002-20200731
i386                 randconfig-a001-20200731
i386                 randconfig-a003-20200731
x86_64               randconfig-a015-20200731
x86_64               randconfig-a014-20200731
x86_64               randconfig-a016-20200731
x86_64               randconfig-a012-20200731
x86_64               randconfig-a013-20200731
x86_64               randconfig-a011-20200731
i386                 randconfig-a016-20200731
i386                 randconfig-a012-20200731
i386                 randconfig-a014-20200731
i386                 randconfig-a015-20200731
i386                 randconfig-a011-20200731
i386                 randconfig-a013-20200731
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
