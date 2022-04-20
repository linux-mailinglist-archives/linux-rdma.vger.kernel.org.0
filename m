Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83479508697
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Apr 2022 13:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377923AbiDTLKK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 07:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377917AbiDTLKI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 07:10:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240A940900
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 04:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650452843; x=1681988843;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=A4eYkz2Xd7YCXwYyQ14mOzHusG0bIEjQkgAF45KUqfE=;
  b=icNsjDg1izZuK+RiB5K8hvo5c9M0BfRhlffXib/hg2fBsKXp7mOYfCq/
   Gwn8EYOw2KfdjIEdK+26JVCoxtkamv23wpphJ0aGYqUmaXELKt9im3awS
   d9hv91hhLkDeHRKRpzFZMBladMLdNBn8hreUPnvRarA9UcRcNA5WNMaIG
   nKcs4xHmDEnIJoAeRnGET1apuOxMfjadGssRFWDw8wI7S04JPU4hD+/nD
   MQKPMITzeeH8dC6tfNtStP10wO3zAGvn+IpsKOKklas9yXkfwz5fq0YxG
   Im5CiogQ2mDw7y0gMb35vR85KHWkn+Pl0GZ+YzIJeJk1+tp9cl3+2MHKL
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245893230"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="245893230"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 04:07:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="668350998"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Apr 2022 04:07:21 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nh8B6-0006vF-Ij;
        Wed, 20 Apr 2022 11:07:20 +0000
Date:   Wed, 20 Apr 2022 19:07:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 679ab61bf5f5f519377d812afb4fb93634782c74
Message-ID: <625fe957.WRRzYYam/xZkZ0gT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: 679ab61bf5f5f519377d812afb4fb93634782c74  RDMA/irdma: Fix deadlock in irdma_cleanup_cm_core()

elapsed time: 829m

configs tested: 146
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220420
sh                              ul2_defconfig
arm                       aspeed_g5_defconfig
nios2                               defconfig
powerpc64                           defconfig
arm                       imx_v6_v7_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                 mpc85xx_cds_defconfig
xtensa                    xip_kc705_defconfig
h8300                       h8s-sim_defconfig
powerpc                   motionpro_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                       common_defconfig
arc                      axs103_smp_defconfig
ia64                         bigsur_defconfig
arm                        keystone_defconfig
powerpc                     redwood_defconfig
mips                     loongson1b_defconfig
m68k                         amcore_defconfig
s390                                defconfig
powerpc                      makalu_defconfig
ia64                        generic_defconfig
mips                            ar7_defconfig
um                           x86_64_defconfig
mips                    maltaup_xpa_defconfig
arm                          lpd270_defconfig
sh                           se7721_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                        mvme16x_defconfig
arc                            hsdk_defconfig
mips                       bmips_be_defconfig
mips                      loongson3_defconfig
arc                        nsimosci_defconfig
sh                            hp6xx_defconfig
microblaze                          defconfig
sh                           se7722_defconfig
i386                                defconfig
arc                           tb10x_defconfig
arm                          iop32x_defconfig
m68k                        mvme147_defconfig
ia64                             alldefconfig
sh                        dreamcast_defconfig
sh                   rts7751r2dplus_defconfig
mips                         cobalt_defconfig
arc                     nsimosci_hs_defconfig
arm                           u8500_defconfig
sh                           sh2007_defconfig
csky                                defconfig
sh                        apsh4ad0a_defconfig
sh                          r7785rp_defconfig
arm                        shmobile_defconfig
m68k                        m5307c3_defconfig
arm                        mvebu_v7_defconfig
powerpc                     asp8347_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220420
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
arc                              allyesconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220419
arc                  randconfig-r043-20220420
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
riscv                randconfig-c006-20220420
mips                 randconfig-c004-20220420
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220420
powerpc              randconfig-c003-20220420
s390                 randconfig-c005-20220420
mips                        qi_lb60_defconfig
arm                         s3c2410_defconfig
powerpc                    socrates_defconfig
mips                           ip22_defconfig
arm                         shannon_defconfig
powerpc                      katmai_defconfig
arm                       mainstone_defconfig
powerpc                     ksi8560_defconfig
powerpc                  mpc885_ads_defconfig
arm                         mv78xx0_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220420
riscv                randconfig-r042-20220420
hexagon              randconfig-r045-20220420
hexagon              randconfig-r041-20220419
hexagon              randconfig-r045-20220419
s390                 randconfig-r044-20220420

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
