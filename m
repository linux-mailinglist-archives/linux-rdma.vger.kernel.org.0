Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD502C65F7
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Nov 2020 13:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgK0Mui (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Nov 2020 07:50:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:30269 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728910AbgK0Muh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Nov 2020 07:50:37 -0500
IronPort-SDR: SIRwonGYfFCuqC5A2B+StCFzPUY3qvgw3buzZoY7Zr24mD34wdvHfZ6ZV09lthHSEuucPQHp6t
 stHTUdcDtPuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9817"; a="172544848"
X-IronPort-AV: E=Sophos;i="5.78,374,1599548400"; 
   d="scan'208";a="172544848"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2020 04:50:37 -0800
IronPort-SDR: 2BPtCzgAzRF9XMgmCVzj9QB4fou4VR0AvzWprztWfPC+cZ/5C0wYM8jhXvCvYnepNkHSUQVxxX
 Ttoikvcc0U4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,374,1599548400"; 
   d="scan'208";a="536043051"
Received: from lkp-server01.sh.intel.com (HELO b5888d13d5a5) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 27 Nov 2020 04:50:35 -0800
Received: from kbuild by b5888d13d5a5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kidCt-00003b-6e; Fri, 27 Nov 2020 12:50:35 +0000
Date:   Fri, 27 Nov 2020 20:50:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 66d86e529dd58616495ea0b03cc687e5d6522b59
Message-ID: <5fc0f613.eVpmBztA8XaKQvHX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 66d86e529dd58616495ea0b03cc687e5d6522b59  RDMA/hns: Add UD support for HIP09

elapsed time: 725m

configs tested: 117
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                          axs101_defconfig
mips                      pic32mzda_defconfig
arm                       imx_v6_v7_defconfig
powerpc64                        alldefconfig
sh                   sh7724_generic_defconfig
m68k                        m5307c3_defconfig
csky                             alldefconfig
xtensa                          iss_defconfig
powerpc                    sam440ep_defconfig
powerpc                    amigaone_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                     loongson1b_defconfig
powerpc                    gamecube_defconfig
arm                        cerfcube_defconfig
powerpc                     mpc5200_defconfig
powerpc                      chrp32_defconfig
arm                      tct_hammer_defconfig
powerpc                     rainier_defconfig
m68k                        mvme147_defconfig
riscv                             allnoconfig
mips                         tb0219_defconfig
powerpc                     tqm8555_defconfig
mips                    maltaup_xpa_defconfig
mips                        bcm47xx_defconfig
mips                           ip28_defconfig
powerpc                      katmai_defconfig
powerpc                       eiger_defconfig
powerpc                      ppc44x_defconfig
powerpc                      arches_defconfig
x86_64                           alldefconfig
sh                             shx3_defconfig
powerpc                        cell_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                 mpc8272_ads_defconfig
xtensa                              defconfig
mips                       lemote2f_defconfig
xtensa                  cadence_csp_defconfig
mips                     decstation_defconfig
arc                            hsdk_defconfig
powerpc                      ppc40x_defconfig
sh                        dreamcast_defconfig
arm                       spear13xx_defconfig
um                            kunit_defconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201127
i386                 randconfig-a003-20201127
i386                 randconfig-a002-20201127
i386                 randconfig-a005-20201127
i386                 randconfig-a001-20201127
i386                 randconfig-a006-20201127
x86_64               randconfig-a015-20201127
x86_64               randconfig-a011-20201127
x86_64               randconfig-a014-20201127
x86_64               randconfig-a016-20201127
x86_64               randconfig-a012-20201127
x86_64               randconfig-a013-20201127
i386                 randconfig-a012-20201127
i386                 randconfig-a013-20201127
i386                 randconfig-a011-20201127
i386                 randconfig-a016-20201127
i386                 randconfig-a014-20201127
i386                 randconfig-a015-20201127
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20201127
x86_64               randconfig-a003-20201127
x86_64               randconfig-a004-20201127
x86_64               randconfig-a005-20201127
x86_64               randconfig-a002-20201127
x86_64               randconfig-a001-20201127

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
