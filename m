Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33BA26D2DF
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 07:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgIQFDV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 01:03:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:5697 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgIQFDV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Sep 2020 01:03:21 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 01:03:20 EDT
IronPort-SDR: Dl8eqegBpO1QMXX3eedUg2p7ed9V2KuxqbyqNmA2h1yN6hr2mwq6DherATeYFJgtmdTQTfkJs1
 2oHNWWVksf0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="160554002"
X-IronPort-AV: E=Sophos;i="5.76,435,1592895600"; 
   d="scan'208";a="160554002"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 21:56:12 -0700
IronPort-SDR: 3nPNHkZCIeQ8IB9as/Ngx98nqR6ikviZf++fHt6Wj311qrhOvZ7CL4i29jfpgR0Uv/HKa1yaQ/
 Tt+HKDlfIpew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,435,1592895600"; 
   d="scan'208";a="409786197"
Received: from lkp-server02.sh.intel.com (HELO bdcb92cf8b4e) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Sep 2020 21:56:10 -0700
Received: from kbuild by bdcb92cf8b4e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kIlxq-0000QL-92; Thu, 17 Sep 2020 04:56:10 +0000
Date:   Thu, 17 Sep 2020 12:56:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 3cc30e8dfcb625ba4bd62a75aba475581c967639
Message-ID: <5f62ec66.VWDsgGVRKRaLk+BL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git  wip/jgg-for-next
branch HEAD: 3cc30e8dfcb625ba4bd62a75aba475581c967639  RDMA/ipoib: Convert to use DEFINE_SEQ_ATTRIBUTE macro

elapsed time: 726m

configs tested: 152
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                    vt8500_v6_v7_defconfig
arm                       omap2plus_defconfig
arc                     haps_hs_smp_defconfig
sparc                               defconfig
m68k                        mvme16x_defconfig
sh                             espt_defconfig
powerpc                     redwood_defconfig
xtensa                    xip_kc705_defconfig
mips                 pnx8335_stb225_defconfig
mips                        qi_lb60_defconfig
parisc                generic-32bit_defconfig
c6x                        evmc6472_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc64                        alldefconfig
arm                        oxnas_v6_defconfig
mips                           ip22_defconfig
arm                         axm55xx_defconfig
sh                           se7722_defconfig
powerpc                      pasemi_defconfig
sh                        apsh4ad0a_defconfig
arm                         ebsa110_defconfig
openrisc                         alldefconfig
arm                      tct_hammer_defconfig
openrisc                 simple_smp_defconfig
arm                      jornada720_defconfig
arm                           corgi_defconfig
powerpc                 mpc8272_ads_defconfig
nios2                         10m50_defconfig
arm                        spear3xx_defconfig
mips                     decstation_defconfig
mips                      malta_kvm_defconfig
sh                        sh7763rdp_defconfig
arm                          pcm027_defconfig
powerpc                  storcenter_defconfig
mips                         cobalt_defconfig
mips                          rm200_defconfig
m68k                        stmark2_defconfig
riscv                            alldefconfig
sh                   secureedge5410_defconfig
sh                            shmin_defconfig
arm                  colibri_pxa300_defconfig
arm                        clps711x_defconfig
sh                           se7724_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                  mpc885_ads_defconfig
sh                          kfr2r09_defconfig
c6x                        evmc6678_defconfig
c6x                                 defconfig
arm                           stm32_defconfig
mips                           ci20_defconfig
powerpc                    sam440ep_defconfig
arm                         at91_dt_defconfig
powerpc                     kilauea_defconfig
arm                          imote2_defconfig
parisc                           allyesconfig
nios2                            allyesconfig
arm                           sama5_defconfig
sh                ecovec24-romimage_defconfig
arm                           efm32_defconfig
mips                         tb0287_defconfig
mips                         db1xxx_defconfig
arc                             nps_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc836x_mds_defconfig
mips                         rt305x_defconfig
powerpc                  mpc866_ads_defconfig
alpha                            alldefconfig
m68k                         apollo_defconfig
alpha                               defconfig
arc                      axs103_smp_defconfig
powerpc                   lite5200b_defconfig
sh                           se7343_defconfig
powerpc                 mpc85xx_cds_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                    klondike_defconfig
arc                        nsimosci_defconfig
sh                         apsh4a3a_defconfig
powerpc                       eiger_defconfig
powerpc                mpc7448_hpc2_defconfig
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
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20200916
x86_64               randconfig-a004-20200916
x86_64               randconfig-a003-20200916
x86_64               randconfig-a002-20200916
x86_64               randconfig-a001-20200916
x86_64               randconfig-a005-20200916
i386                 randconfig-a004-20200916
i386                 randconfig-a006-20200916
i386                 randconfig-a003-20200916
i386                 randconfig-a001-20200916
i386                 randconfig-a002-20200916
i386                 randconfig-a005-20200916
i386                 randconfig-a015-20200916
i386                 randconfig-a014-20200916
i386                 randconfig-a011-20200916
i386                 randconfig-a013-20200916
i386                 randconfig-a016-20200916
i386                 randconfig-a012-20200916
i386                 randconfig-a015-20200917
i386                 randconfig-a014-20200917
i386                 randconfig-a011-20200917
i386                 randconfig-a013-20200917
i386                 randconfig-a016-20200917
i386                 randconfig-a012-20200917
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

clang tested configs:
x86_64               randconfig-a014-20200916
x86_64               randconfig-a011-20200916
x86_64               randconfig-a016-20200916
x86_64               randconfig-a012-20200916
x86_64               randconfig-a015-20200916
x86_64               randconfig-a013-20200916

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
