Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F44218342
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2020 11:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgGHJNE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jul 2020 05:13:04 -0400
Received: from mga04.intel.com ([192.55.52.120]:12725 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728131AbgGHJNA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Jul 2020 05:13:00 -0400
IronPort-SDR: DVB7IwfjvFng+lRV+Rd0AqXiZ1gjS2PUc0anyMHMZpsA1FJb+LtOF7JXCPwUu/nV8KFbz+SMNl
 h1n3ikybZrtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="145264795"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="145264795"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 02:12:59 -0700
IronPort-SDR: EwAfv8rWeO+WymupLfFzbY+bNM/ivW4rHOKqOyd9cQL7q2ELgEEcfJ+qBVt36Eu9WlacEHGoI9
 umBR0AXh/MqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="483823881"
Received: from lkp-server01.sh.intel.com (HELO 6136dd46483e) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jul 2020 02:12:58 -0700
Received: from kbuild by 6136dd46483e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jt68P-00001x-F5; Wed, 08 Jul 2020 09:12:57 +0000
Date:   Wed, 08 Jul 2020 17:11:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 cc33b23e1e1cf54bcb9e5c193e3888a3b17a5479
Message-ID: <5f058ddb.VDj0n0oCp1prOapS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: cc33b23e1e1cf54bcb9e5c193e3888a3b17a5479  RDMA/hns: Optimize MTR level-0 addressing to access huge page

elapsed time: 847m

configs tested: 94
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
nios2                               defconfig
powerpc                     pq2fads_defconfig
mips                     decstation_defconfig
powerpc                      ppc40x_defconfig
sh                                allnoconfig
arm                         nhk8815_defconfig
s390                       zfcpdump_defconfig
nios2                            alldefconfig
sh                          r7785rp_defconfig
arm                        trizeps4_defconfig
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
i386                 randconfig-a001-20200707
i386                 randconfig-a002-20200707
i386                 randconfig-a006-20200707
i386                 randconfig-a004-20200707
i386                 randconfig-a005-20200707
i386                 randconfig-a003-20200707
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
