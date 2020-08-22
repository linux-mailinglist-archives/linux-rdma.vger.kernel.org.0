Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96FF24E4CA
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Aug 2020 05:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHVDYU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Aug 2020 23:24:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:36868 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbgHVDYU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Aug 2020 23:24:20 -0400
IronPort-SDR: 40HHGqvAoVvioRuudqtF401/mIH9Gn3AAhdTQ0JwPgLFvK/j8LNVoGsTTSCCxX+jX8hFVW0hIs
 iS8xPD/97CtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="219949528"
X-IronPort-AV: E=Sophos;i="5.76,339,1592895600"; 
   d="scan'208";a="219949528"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 20:24:19 -0700
IronPort-SDR: jNll/YRu1mjtfV4ntBVxJQwnIHVDQ3JfFeENyy0zF32WRcYTB7164Vccy7uzhlE6qMHIpbjJXF
 nIt1XyWEd9kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,339,1592895600"; 
   d="scan'208";a="294009159"
Received: from lkp-server01.sh.intel.com (HELO 91ed66e1ca04) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Aug 2020 20:24:17 -0700
Received: from kbuild by 91ed66e1ca04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k9K8f-0001Si-3k; Sat, 22 Aug 2020 03:24:17 +0000
Date:   Sat, 22 Aug 2020 11:23:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 f6da70d99c96256f8be0cbb4dd72d45d622c7823
Message-ID: <5f408fbf.rSPssmAcQUYkfJpL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  for-rc
branch HEAD: f6da70d99c96256f8be0cbb4dd72d45d622c7823  MAINTAINERS: Update Mellanox and Cumulus Network addresses to new domain

elapsed time: 722m

configs tested: 74
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                           ip28_defconfig
arm                            mmp2_defconfig
h8300                    h8300h-sim_defconfig
arm                           corgi_defconfig
riscv                            alldefconfig
arm                   milbeaut_m10v_defconfig
sh                         ecovec24_defconfig
arm                          collie_defconfig
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
i386                 randconfig-a002-20200820
i386                 randconfig-a004-20200820
i386                 randconfig-a005-20200820
i386                 randconfig-a003-20200820
i386                 randconfig-a006-20200820
i386                 randconfig-a001-20200820
x86_64               randconfig-a015-20200820
x86_64               randconfig-a012-20200820
x86_64               randconfig-a016-20200820
x86_64               randconfig-a014-20200820
x86_64               randconfig-a011-20200820
x86_64               randconfig-a013-20200820
i386                 randconfig-a013-20200820
i386                 randconfig-a012-20200820
i386                 randconfig-a011-20200820
i386                 randconfig-a016-20200820
i386                 randconfig-a014-20200820
i386                 randconfig-a015-20200820
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
