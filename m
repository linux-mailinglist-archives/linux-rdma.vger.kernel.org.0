Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB67227A9C
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jul 2020 10:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgGUIZz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jul 2020 04:25:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:11958 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgGUIZz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Jul 2020 04:25:55 -0400
IronPort-SDR: j+TYgY6Uye/+SCzRYUF9AVmjtDu2NHU02tD7aRfd6EnXWZZByTzbbiEx5X78M9XlOMgrK0vHZ2
 cnMCxh20IOuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="129658161"
X-IronPort-AV: E=Sophos;i="5.75,378,1589266800"; 
   d="scan'208";a="129658161"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 01:25:54 -0700
IronPort-SDR: PyArZGYEQt0WTLxI7CqbjrKuCQBFdn+zp0TJvSRTriXaeG+CpilWunxwLiUE2MxlSy7lsYEtKR
 4IH7J215sKNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,378,1589266800"; 
   d="scan'208";a="326307854"
Received: from lkp-server02.sh.intel.com (HELO 7dd7ac9fbea4) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jul 2020 01:25:53 -0700
Received: from kbuild by 7dd7ac9fbea4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jxnay-00000z-Gs; Tue, 21 Jul 2020 08:25:52 +0000
Date:   Tue, 21 Jul 2020 16:24:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 8e7eafb816ab7e5047b74cb8eb1db2f8f14f7d7a
Message-ID: <5f16a621.ftltQ0unW137XQ/q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 8e7eafb816ab7e5047b74cb8eb1db2f8f14f7d7a  RDMA: rdma_user_ioctl.h: fix a duplicated word + clarify

elapsed time: 727m

configs tested: 110
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
c6x                                 defconfig
c6x                        evmc6474_defconfig
arm                         shannon_defconfig
sparc64                           allnoconfig
powerpc                       ppc64_defconfig
arm                      footbridge_defconfig
s390                             alldefconfig
c6x                               allnoconfig
s390                          debug_defconfig
arm                          pxa3xx_defconfig
m68k                        m5407c3_defconfig
sh                          sdk7780_defconfig
c6x                         dsk6455_defconfig
arm                           h5000_defconfig
i386                             allyesconfig
i386                                defconfig
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
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
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
i386                 randconfig-a001-20200719
i386                 randconfig-a006-20200719
i386                 randconfig-a002-20200719
i386                 randconfig-a005-20200719
i386                 randconfig-a003-20200719
i386                 randconfig-a004-20200719
x86_64               randconfig-a014-20200720
x86_64               randconfig-a015-20200720
x86_64               randconfig-a016-20200720
x86_64               randconfig-a012-20200720
x86_64               randconfig-a013-20200720
x86_64               randconfig-a011-20200720
x86_64               randconfig-a005-20200719
x86_64               randconfig-a002-20200719
x86_64               randconfig-a006-20200719
x86_64               randconfig-a001-20200719
x86_64               randconfig-a003-20200719
x86_64               randconfig-a004-20200719
i386                 randconfig-a015-20200719
i386                 randconfig-a011-20200719
i386                 randconfig-a016-20200719
i386                 randconfig-a012-20200719
i386                 randconfig-a013-20200719
i386                 randconfig-a014-20200719
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
