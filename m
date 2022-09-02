Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD0F5AA661
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Sep 2022 05:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbiIBDbE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 23:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbiIBDa7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 23:30:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ABCABD6E
        for <linux-rdma@vger.kernel.org>; Thu,  1 Sep 2022 20:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662089452; x=1693625452;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=llhF/hIrKTbKneeTFpPpd/RFh2XbmTDIww7Qo3G271c=;
  b=lfVnX9jAoFzRk4hQrSu7psriI2+0r1Oeg1rtbPCcj7q5fU0UKo4QW3pj
   tsYL914ZGR9Eth7UOsBWZo7SU81QDdPV+du9fsuhBY1qTaIuRtensRKmg
   HjjL9/tdyleXIjPvhCplzSyx8d+d6EL4wEwEjCrA4hbQgh9776R00E6EZ
   S0LNwKfUEyEMezhiekKPfPONfeebQ65CxkmbuQw3Gh6o37kxzybI+dHNJ
   htnuGeVWnh4fKmmlIsGth+bbx+ZJtUOL9xbLD+NP28GT/MHyyaSVEeA4h
   jyLYpu22DV3mFdcupg7ZuHcT4w3ppqi5d4YoWXpw71PsNIVYO6KF5qpAm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="275628823"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="275628823"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 20:30:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="755104510"
Received: from lkp-server02.sh.intel.com (HELO fccc941c3034) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 01 Sep 2022 20:30:50 -0700
Received: from kbuild by fccc941c3034 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTxOM-00004l-0H;
        Fri, 02 Sep 2022 03:30:50 +0000
Date:   Fri, 02 Sep 2022 11:30:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 12f35199a2c0551187edbf8eb01379f0598659fa
Message-ID: <631178bb.VlUs1FGogq5ic7hr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 12f35199a2c0551187edbf8eb01379f0598659fa  RDMA/srp: Set scmnd->result only when scmnd is not NULL

elapsed time: 1222m

configs tested: 111
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                          allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
mips                             allyesconfig
powerpc                           allnoconfig
x86_64                        randconfig-a013
i386                                defconfig
arc                  randconfig-r043-20220901
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a016
i386                          randconfig-a005
i386                          randconfig-a014
i386                             allyesconfig
m68k                             allyesconfig
x86_64                              defconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
sh                               allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
i386                          randconfig-a012
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arm                              allyesconfig
arm                           stm32_defconfig
powerpc                     pq2fads_defconfig
arc                               allnoconfig
mips                       bmips_be_defconfig
arm                        oxnas_v6_defconfig
mips                 randconfig-c004-20220901
i386                          randconfig-c001
sh                            shmin_defconfig
sh                             espt_defconfig
sparc                            alldefconfig
csky                              allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
arm64                            allyesconfig
m68k                         apollo_defconfig
sh                          rsk7264_defconfig
sh                           se7751_defconfig
arm                            hisi_defconfig
sh                         apsh4a3a_defconfig
powerpc                  storcenter_defconfig
powerpc                      cm5200_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
mips                     decstation_defconfig
mips                            ar7_defconfig
powerpc                      tqm8xx_defconfig
alpha                            alldefconfig
arm                         lubbock_defconfig
sh                           se7750_defconfig
m68k                          amiga_defconfig
powerpc                     mpc83xx_defconfig
arm                          badge4_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-c001
microblaze                      mmu_defconfig
m68k                        m5272c3_defconfig
sparc                               defconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
sparc                       sparc64_defconfig
mips                           ip32_defconfig
mips                            gpr_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                          pxa3xx_defconfig
mips                           ci20_defconfig
sh                          lboxre2_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
ia64                             allmodconfig

clang tested configs:
riscv                randconfig-r042-20220901
hexagon              randconfig-r045-20220901
hexagon              randconfig-r041-20220901
s390                 randconfig-r044-20220901
i386                          randconfig-a002
i386                          randconfig-a015
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                      katmai_defconfig
powerpc                     mpc5200_defconfig
x86_64                        randconfig-k001
arm                        vexpress_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
