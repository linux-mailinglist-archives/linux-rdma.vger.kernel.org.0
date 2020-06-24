Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A29206C62
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2020 08:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388360AbgFXGcW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jun 2020 02:32:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:53692 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387880AbgFXGcW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Jun 2020 02:32:22 -0400
IronPort-SDR: 3p/A8/p15llD2MGJf3ImMI7ESRm+MRk7nznPyIY5AnXv6HEh1MXNue/trnary7mHbhNcihxD1T
 fAZFG660baSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="162432888"
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208";a="162432888"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 23:32:22 -0700
IronPort-SDR: mYJBpJfxUS2ALw9dWYXcyEyGJrUGxh8SMK6Pufa7SUFbGEVrRsKXCXqdfWPg5YG9qV9CYv38Uv
 8KUNZo3EcP2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208";a="385082524"
Received: from lkp-server01.sh.intel.com (HELO 538b5e3c8319) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jun 2020 23:32:20 -0700
Received: from kbuild by 538b5e3c8319 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jnyxI-0000ld-3B; Wed, 24 Jun 2020 06:32:20 +0000
Date:   Wed, 24 Jun 2020 14:31:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 10cd686eb958331f23d569a48e6f3e1bee1ce1c1
Message-ID: <5ef2f355.8n+N8dBTYRSIoRuR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 10cd686eb958331f23d569a48e6f3e1bee1ce1c1  RDMA/ipoib: Return void from ipoib_ib_dev_stop()

elapsed time: 724m

configs tested: 139
configs skipped: 10

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
powerpc                      mgcoge_defconfig
sh                ecovec24-romimage_defconfig
arm                        mvebu_v7_defconfig
arm                        multi_v5_defconfig
mips                malta_kvm_guest_defconfig
sh                          rsk7203_defconfig
arc                         haps_hs_defconfig
xtensa                          iss_defconfig
arm                          lpd270_defconfig
arm                            lart_defconfig
s390                              allnoconfig
sparc64                             defconfig
m68k                            mac_defconfig
xtensa                       common_defconfig
sh                          lboxre2_defconfig
arm                           h3600_defconfig
sh                          sdk7780_defconfig
x86_64                              defconfig
h8300                       h8s-sim_defconfig
powerpc                          allyesconfig
mips                        qi_lb60_defconfig
m68k                          hp300_defconfig
sh                        sh7763rdp_defconfig
arm                            pleb_defconfig
arc                        nsim_700_defconfig
arm                         palmz72_defconfig
arc                     nsimosci_hs_defconfig
arm                      tct_hammer_defconfig
mips                        omega2p_defconfig
powerpc                          g5_defconfig
c6x                         dsk6455_defconfig
arm                          tango4_defconfig
powerpc                      ppc44x_defconfig
m68k                             allyesconfig
mips                           ip27_defconfig
m68k                         amcore_defconfig
powerpc                    gamecube_defconfig
arc                          axs101_defconfig
arc                              allyesconfig
mips                     cu1000-neo_defconfig
sparc                            alldefconfig
mips                        nlm_xlr_defconfig
sh                        sh7757lcr_defconfig
arm                        multi_v7_defconfig
arm                          gemini_defconfig
powerpc                 mpc8272_ads_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
sh                          rsk7264_defconfig
mips                          malta_defconfig
mips                    maltaup_xpa_defconfig
alpha                               defconfig
mips                       bmips_be_defconfig
ia64                            zx1_defconfig
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
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
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20200623
i386                 randconfig-a002-20200623
i386                 randconfig-a003-20200623
i386                 randconfig-a001-20200623
i386                 randconfig-a005-20200623
i386                 randconfig-a004-20200623
i386                 randconfig-a013-20200623
i386                 randconfig-a016-20200623
i386                 randconfig-a012-20200623
i386                 randconfig-a014-20200623
i386                 randconfig-a015-20200623
i386                 randconfig-a011-20200623
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
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
