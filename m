Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031195AA5B9
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Sep 2022 04:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbiIBCYx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 22:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235356AbiIBCYY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 22:24:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C731AFAE9
        for <linux-rdma@vger.kernel.org>; Thu,  1 Sep 2022 19:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662085433; x=1693621433;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JofwGp6cE8zR988ms4PqIz+QJ1tUmH5LgBUVboXo78A=;
  b=XBJnV+cZDqkYrmvu1SJmJWTZtYeRkZ4vYdYKCLSbdGxtS/FR1ivkiqLM
   b0GykfIO6ucl6phD4l75zWlhu31A2yCbmWQN59WgfqcQtYS3gKAmIYVT3
   Rjdc4KXSrbwnZppZgUJfsQzC3mSVCYPKvv4FuR4SYAC3hhtnDaW5WLFiE
   l71AH5X6XSknrk+0sotwTX7VZxeTtVps7uzvYULEBEkysuFjYBI8pE7EQ
   P2p9FX+5GeG68PQH36AhBmpK8eoyLayLTXZ8YntebrUW2NJYobnf7hvAZ
   pH5NWK9+/bzj8kbRMIW68hpSdsNfrM3y0jP9nMqbXuuabVN1I3DOaeeNH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="322030227"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="322030227"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 19:22:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="563772740"
Received: from lkp-server02.sh.intel.com (HELO fccc941c3034) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 01 Sep 2022 19:22:47 -0700
Received: from kbuild by fccc941c3034 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTwKU-000011-1o;
        Fri, 02 Sep 2022 02:22:46 +0000
Date:   Fri, 02 Sep 2022 10:22:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 45baad7dd98f4d83f67c86c28769d3184390e324
Message-ID: <631168dc.8pFYHHnZsukdpS2t%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 45baad7dd98f4d83f67c86c28769d3184390e324  RDMA/hns: Remove the num_qpc_timer variable

elapsed time: 1154m

configs tested: 107
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
arc                  randconfig-r043-20220831
um                           x86_64_defconfig
x86_64                              defconfig
s390                 randconfig-r044-20220831
x86_64                           allyesconfig
x86_64                               rhel-8.3
i386                                defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a016
i386                             allyesconfig
i386                          randconfig-a001
x86_64                        randconfig-a004
i386                          randconfig-a003
x86_64                        randconfig-a002
i386                          randconfig-a005
x86_64                        randconfig-a006
m68k                             allyesconfig
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arm                                 defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a012
i386                          randconfig-a014
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
arm                              allyesconfig
arm64                            allyesconfig
m68k                         apollo_defconfig
sh                          rsk7264_defconfig
sh                           se7751_defconfig
arm                            hisi_defconfig
sh                         apsh4a3a_defconfig
powerpc                  storcenter_defconfig
powerpc                      cm5200_defconfig
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
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220831
hexagon              randconfig-r045-20220831
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a015
i386                          randconfig-a002
x86_64                        randconfig-a001
i386                          randconfig-a004
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a006
riscv                randconfig-r042-20220901
hexagon              randconfig-r041-20220901
hexagon              randconfig-r045-20220901
s390                 randconfig-r044-20220901
powerpc                      katmai_defconfig
powerpc                     mpc5200_defconfig
x86_64                        randconfig-k001
arm                        vexpress_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
