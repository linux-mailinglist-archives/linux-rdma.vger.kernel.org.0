Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2592021AF35
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2020 08:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgGJGPD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jul 2020 02:15:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:29764 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgGJGPD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 10 Jul 2020 02:15:03 -0400
IronPort-SDR: BsoLvSFjSOQBJNjmLTMXjnxATJZ1j2qgqVHRbFqhtre12QlqmMbHsOubCsghmfNxMZUDkKddxS
 ixEVkZMQz3NQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="147247725"
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="147247725"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 23:15:01 -0700
IronPort-SDR: IBvFSRbBDJ4i410wFcehWoqkrZj6xMStOrFB2Ytmj1kniMtihDsZdUcr9yNHA9UqmwZiJP69f3
 7HPWnsY+I74Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="389389767"
Received: from lkp-server02.sh.intel.com (HELO 0fc60ea15964) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jul 2020 23:15:00 -0700
Received: from kbuild by 0fc60ea15964 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jtmJH-000034-Na; Fri, 10 Jul 2020 06:14:59 +0000
Date:   Fri, 10 Jul 2020 14:14:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 0a03715068794e4b524f66ebbf412ab1f2933f3f
Message-ID: <5f080745.ZCO81flrZ7nwvcAR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-rc
branch HEAD: 0a03715068794e4b524f66ebbf412ab1f2933f3f  RDMA/mlx5: Set PD pointers for the error flow unwind

elapsed time: 800m

configs tested: 108
configs skipped: 8

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
mips                         rt305x_defconfig
sh                                  defconfig
nios2                            alldefconfig
m68k                         apollo_defconfig
mips                        omega2p_defconfig
powerpc                     mpc512x_defconfig
arm                        spear6xx_defconfig
m68k                       m5249evb_defconfig
arm                        multi_v7_defconfig
powerpc                       holly_defconfig
x86_64                              defconfig
arm                         ebsa110_defconfig
csky                                defconfig
powerpc                      tqm8xx_defconfig
powerpc                      ep88xc_defconfig
arm                         at91_dt_defconfig
m68k                          hp300_defconfig
powerpc                  mpc866_ads_defconfig
powerpc64                           defconfig
um                             i386_defconfig
openrisc                         allyesconfig
sh                        edosk7705_defconfig
m68k                          atari_defconfig
sh                             espt_defconfig
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
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
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
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
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
i386                 randconfig-a002-20200709
i386                 randconfig-a001-20200709
i386                 randconfig-a006-20200709
i386                 randconfig-a005-20200709
i386                 randconfig-a004-20200709
i386                 randconfig-a003-20200709
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
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
um                               allyesconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
