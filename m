Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B477F546A8C
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jun 2022 18:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349655AbiFJQfd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jun 2022 12:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349732AbiFJQfL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jun 2022 12:35:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE1656F83
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jun 2022 09:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654878887; x=1686414887;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=soOMFLa592DzBmgmRwLis9x/6MzcvUnBqLoDLZj2OO0=;
  b=dD8bdIBPgwyzsm73PZPEaVVsy/7XTgeRq3rGOpYeNLweIA9VUOKJFRDe
   stbOm251GE4RuMop/b+EbLSs6JQbafQIasa2ZfSktrvxkR4jfvpCVZf40
   rntBGZ5t9MUkKtgfBVbwJIsXJ0p2H0AzQdQJ0PG+xPxqyHvyu9xSR2Tb/
   soAGqNt7BG4Ym2zA4xm6cygSb3pdII0Fewqn+0JzhICtjaCdqG8+YSHVU
   nHcJKL5/BAHTpr2i+tQBGuvfHo8fKJSG24tF1avuB5yKzQpxriAmzQpWH
   6G5lZLl53fhSuKtXT1UZfD71/VuztpjmjSLGijImRQazN/oxz/tS8+ju4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="266445217"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="266445217"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 09:34:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="684635086"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jun 2022 09:34:45 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzhav-000I73-2m;
        Fri, 10 Jun 2022 16:34:45 +0000
Date:   Sat, 11 Jun 2022 00:34:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 118f767413ada4eef7825fbd4af7c0866f883441
Message-ID: <62a3729d.IxJAC0htCBd7uJxg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 118f767413ada4eef7825fbd4af7c0866f883441  RDMA/qedr: Fix reporting QP timeout attribute

elapsed time: 4752m

configs tested: 143
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220607
sh                         ap325rxa_defconfig
arc                     haps_hs_smp_defconfig
m68k                       m5475evb_defconfig
nios2                               defconfig
m68k                          sun3x_defconfig
powerpc                 mpc8540_ads_defconfig
arc                      axs103_smp_defconfig
sparc64                             defconfig
sh                           sh2007_defconfig
arm                           viper_defconfig
sh                           se7206_defconfig
powerpc                    adder875_defconfig
sh                         apsh4a3a_defconfig
sh                          r7785rp_defconfig
powerpc                      ppc6xx_defconfig
arm                        shmobile_defconfig
parisc                generic-64bit_defconfig
openrisc                 simple_smp_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                      tqm8xx_defconfig
powerpc                 mpc834x_itx_defconfig
alpha                            alldefconfig
m68k                            mac_defconfig
arm                       imx_v6_v7_defconfig
arm                         s3c6400_defconfig
arm                             ezx_defconfig
arm                      footbridge_defconfig
m68k                        mvme147_defconfig
powerpc                  storcenter_defconfig
mips                           xway_defconfig
openrisc                         alldefconfig
mips                      fuloong2e_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220607
arm                  randconfig-c002-20220608
arm                  randconfig-c002-20220609
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
powerpc                          allyesconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
um                             i386_defconfig
x86_64                        randconfig-a004
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                          randconfig-a001
x86_64                    rhel-8.3-kselftests
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc              randconfig-c003-20220608
x86_64                        randconfig-c007
riscv                randconfig-c006-20220608
i386                          randconfig-c001
s390                 randconfig-c005-20220608
mips                 randconfig-c004-20220608
arm                  randconfig-c002-20220608
powerpc              randconfig-c003-20220607
riscv                randconfig-c006-20220607
s390                 randconfig-c005-20220607
mips                 randconfig-c004-20220607
arm                  randconfig-c002-20220607
mips                      pic32mzda_defconfig
arm                         socfpga_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                        fsp2_defconfig
powerpc                          g5_defconfig
arm64                            allyesconfig
mips                        maltaup_defconfig
powerpc                       ebony_defconfig
arm                  colibri_pxa300_defconfig
powerpc                      katmai_defconfig
powerpc                 mpc832x_mds_defconfig
mips                        workpad_defconfig
powerpc                     akebono_defconfig
arm                         mv78xx0_defconfig
arm                         lpc32xx_defconfig
x86_64                        randconfig-k001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a012
i386                          randconfig-a011
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220609
s390                 randconfig-r044-20220609
riscv                randconfig-r042-20220609
hexagon              randconfig-r041-20220609
hexagon              randconfig-r045-20220608
hexagon              randconfig-r041-20220608

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
