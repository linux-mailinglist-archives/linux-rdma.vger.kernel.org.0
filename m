Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFA46C08B1
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Mar 2023 02:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjCTBob (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Mar 2023 21:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCTBoa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Mar 2023 21:44:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759984C1A
        for <linux-rdma@vger.kernel.org>; Sun, 19 Mar 2023 18:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679276669; x=1710812669;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/UF/I2fYue49HFp7fXtG6df4BQmvxFxscw4hA9aN+kA=;
  b=bVQWCqPhr7KTCYRDH2iPYlo8tekWIdlH3XEB2bKJYVD5EHgT6QiqdwJl
   CcJVSMLJCp7BMwD30g/EUBxI79BcNqfb9tAgOAWMoPjAXu/EooGTmOpcB
   zyxQBkuMYuYJfmM7P+0PpipG87cOuyHm604U5kxyKX9VEWjyypnUrmaro
   BUQvcdEtGJAbrgoYDlzhp1kHr/PAw6DpMqD0ae7a0SlQX51LXLGWfW/QK
   jELMi2j/4GYpP+fZSVBfGcrqhIsK2TyThDRLxnMmLoKl+mgnquvRNiVus
   cRtIJ/wfuGdFZ2cA6O+nYo6NQI+gAv48aG8vI9vJrr/c1+ypRfRzoGz0f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="338578512"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="338578512"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 18:44:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713385486"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713385486"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 19 Mar 2023 18:44:26 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pe4ZV-000Ajt-1k;
        Mon, 20 Mar 2023 01:44:25 +0000
Date:   Mon, 20 Mar 2023 09:43:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 e4522c097ec10f23ea0933e9e69d4fa9d8ae9441
Message-ID: <6417ba5e.bcaqV4C0rTPGqxEX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: e4522c097ec10f23ea0933e9e69d4fa9d8ae9441  RDMA/irdma: Add ipv4 check to irdma_find_listener()

elapsed time: 787m

configs tested: 170
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230319   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230319   gcc  
alpha                randconfig-r035-20230319   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230319   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                  randconfig-r003-20230319   gcc  
arc                  randconfig-r003-20230320   gcc  
arc                  randconfig-r012-20230319   gcc  
arc                  randconfig-r016-20230319   gcc  
arc                  randconfig-r034-20230319   gcc  
arc                  randconfig-r043-20230319   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                  randconfig-r002-20230319   clang
arm                  randconfig-r046-20230319   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230319   gcc  
arm64                               defconfig   gcc  
csky                             alldefconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230319   gcc  
csky                 randconfig-r026-20230319   gcc  
hexagon      buildonly-randconfig-r001-20230319   clang
hexagon      buildonly-randconfig-r003-20230319   clang
hexagon              randconfig-r001-20230319   clang
hexagon              randconfig-r032-20230319   clang
hexagon              randconfig-r041-20230319   clang
hexagon              randconfig-r045-20230319   clang
i386                             allyesconfig   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r003-20230319   gcc  
ia64                                defconfig   gcc  
ia64                        generic_defconfig   gcc  
ia64                 randconfig-r006-20230319   gcc  
ia64                 randconfig-r024-20230319   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r006-20230319   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r031-20230319   gcc  
m68k                             allmodconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                 randconfig-r006-20230319   gcc  
microblaze   buildonly-randconfig-r006-20230319   gcc  
microblaze           randconfig-r033-20230319   gcc  
microblaze           randconfig-r036-20230319   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                 randconfig-r026-20230319   gcc  
nios2                         3c120_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230319   gcc  
nios2                randconfig-r014-20230319   gcc  
nios2                randconfig-r025-20230319   gcc  
nios2                randconfig-r034-20230319   gcc  
openrisc     buildonly-randconfig-r004-20230319   gcc  
openrisc             randconfig-r002-20230319   gcc  
openrisc             randconfig-r011-20230319   gcc  
openrisc             randconfig-r021-20230319   gcc  
openrisc             randconfig-r024-20230319   gcc  
openrisc             randconfig-r025-20230319   gcc  
openrisc             randconfig-r031-20230319   gcc  
openrisc             randconfig-r033-20230319   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc               randconfig-r004-20230319   gcc  
parisc               randconfig-r022-20230319   gcc  
parisc               randconfig-r024-20230319   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230319   clang
powerpc                 canyonlands_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                      ppc64e_defconfig   clang
powerpc                         ps3_defconfig   gcc  
powerpc              randconfig-r004-20230319   gcc  
powerpc              randconfig-r005-20230319   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv                randconfig-r016-20230319   clang
riscv                randconfig-r036-20230319   gcc  
riscv                randconfig-r042-20230319   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r015-20230319   clang
s390                 randconfig-r035-20230319   gcc  
s390                 randconfig-r044-20230319   clang
sh                               allmodconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh           buildonly-randconfig-r004-20230319   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r013-20230319   gcc  
sh                   randconfig-r023-20230319   gcc  
sh                   randconfig-r025-20230319   gcc  
sh                   randconfig-r032-20230319   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230319   gcc  
sparc64      buildonly-randconfig-r005-20230319   gcc  
sparc64              randconfig-r004-20230320   gcc  
sparc64              randconfig-r006-20230319   gcc  
sparc64              randconfig-r015-20230319   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                              defconfig   gcc  
xtensa               randconfig-r013-20230319   gcc  
xtensa               randconfig-r015-20230319   gcc  
xtensa               randconfig-r022-20230319   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
