Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3751D0534
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 05:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgEMDCW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 23:02:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:61770 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbgEMDCW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 23:02:22 -0400
IronPort-SDR: rsESHzbC/bIaRXruIF/qSvw7ryYL15JDU4elmcaEo7Y7QoFVBqVVrZo3sUxoTrUvjBS5qHVJYo
 cycWi8LLU76Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 20:02:21 -0700
IronPort-SDR: iiKYClioj0cXaTUOQSC6djt/h0uUoqKxNsA18N+mVKVmlrzys5Vzr3/bwKHxMNMzD4UFx7RgK1
 qiEfKEL9DH4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,385,1583222400"; 
   d="scan'208";a="341113744"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 May 2020 20:02:20 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jYhf1-000Be1-H6; Wed, 13 May 2020 11:02:19 +0800
Date:   Wed, 13 May 2020 11:01:29 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 c8b1f340e54158662acfa41d6dee274846370282
Message-ID: <5ebb6309.ayE0T2NmjrACRog5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-rc
branch HEAD: c8b1f340e54158662acfa41d6dee274846370282  RDMA/iw_cxgb4: Fix incorrect function parameters

elapsed time: 558m

configs tested: 121
configs skipped: 6

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
m68k                        stmark2_defconfig
arm                  colibri_pxa300_defconfig
c6x                        evmc6457_defconfig
powerpc                     powernv_defconfig
mips                 decstation_r4k_defconfig
arm                       aspeed_g4_defconfig
sh                      rts7751r2d1_defconfig
powerpc                     ep8248e_defconfig
openrisc                    or1ksim_defconfig
h8300                     edosk2674_defconfig
sh                           se7751_defconfig
i386                                defconfig
arm                           tegra_defconfig
sh                            hp6xx_defconfig
arm                              zx_defconfig
m68k                         amcore_defconfig
powerpc                      pmac32_defconfig
arc                          axs103_defconfig
arm64                            alldefconfig
arm                        vexpress_defconfig
m68k                        m5272c3_defconfig
xtensa                         virt_defconfig
arm                         axm55xx_defconfig
arm                          prima2_defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                              allnoconfig
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
i386                 randconfig-a006-20200512
i386                 randconfig-a005-20200512
i386                 randconfig-a003-20200512
i386                 randconfig-a001-20200512
i386                 randconfig-a004-20200512
i386                 randconfig-a002-20200512
x86_64               randconfig-a016-20200512
x86_64               randconfig-a012-20200512
x86_64               randconfig-a015-20200512
x86_64               randconfig-a013-20200512
x86_64               randconfig-a014-20200512
x86_64               randconfig-a011-20200512
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
