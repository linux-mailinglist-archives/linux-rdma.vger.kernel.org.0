Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6026EB898
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Apr 2023 12:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDVKhu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Apr 2023 06:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDVKhs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 22 Apr 2023 06:37:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2891996
        for <linux-rdma@vger.kernel.org>; Sat, 22 Apr 2023 03:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682159866; x=1713695866;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0ErzR2T9H3kk/yHsOGUBpnsCv95SjJ1LWkPhfxdvOPY=;
  b=KBtTxTAbwxZURV+5b0Ug/DCBSWhp8p3tuNxh4cdmGA707ExrYomZVGyS
   zsotHAvUlLOTPhycjPL371b0J8dwRyXeEH5pYskgrI5moahY7nR6aryAE
   v84O8ZHuuXlunVJCY/q5XrHpattBOPsER7w1uNyOTAygCO6js6J3wfd06
   jQs+d2kNTynHtab2NsJTF2e0uC9YAIZzN4/FE6QJj93LwqXOefUaLsQcY
   zM3RhFXTazkVacFPCsHpgX93FzBOUfNhYmYwlv8IvcHzAwqrzhOJdM+/j
   bsHo2C6y/n8WPUXF3/D/Yi8EbUCPGZd7WpWjE/l0IOn8pa6mksiXCDO1w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="325744100"
X-IronPort-AV: E=Sophos;i="5.99,218,1677571200"; 
   d="scan'208";a="325744100"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2023 03:37:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="816698029"
X-IronPort-AV: E=Sophos;i="5.99,218,1677571200"; 
   d="scan'208";a="816698029"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 22 Apr 2023 03:37:42 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pqAcf-000hFI-2k;
        Sat, 22 Apr 2023 10:37:41 +0000
Date:   Sat, 22 Apr 2023 18:36:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 531094dc7164718d28ebb581d729807d7e846363
Message-ID: <6443b8c5.gjb/O+tWqfS5e4sP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 531094dc7164718d28ebb581d729807d7e846363  RDMA/efa: Add rdma write capability to device caps

elapsed time: 727m

configs tested: 156
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230421   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230421   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230421   gcc  
arc                  randconfig-r022-20230421   gcc  
arc                  randconfig-r026-20230421   gcc  
arc                  randconfig-r033-20230421   gcc  
arc                  randconfig-r043-20230421   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          exynos_defconfig   gcc  
arm                         nhk8815_defconfig   gcc  
arm                  randconfig-r031-20230421   clang
arm                  randconfig-r046-20230421   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230421   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230421   gcc  
arm64                randconfig-r015-20230421   clang
csky                                defconfig   gcc  
csky                 randconfig-r002-20230421   gcc  
csky                 randconfig-r024-20230421   gcc  
csky                 randconfig-r032-20230421   gcc  
hexagon      buildonly-randconfig-r002-20230421   clang
hexagon              randconfig-r022-20230421   clang
hexagon              randconfig-r041-20230421   clang
hexagon              randconfig-r045-20230421   clang
i386                             allyesconfig   gcc  
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
ia64                             alldefconfig   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230421   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r003-20230421   gcc  
ia64                 randconfig-r014-20230421   gcc  
ia64                 randconfig-r035-20230421   gcc  
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r015-20230421   gcc  
loongarch            randconfig-r023-20230421   gcc  
loongarch            randconfig-r025-20230421   gcc  
loongarch            randconfig-r036-20230421   gcc  
m68k                             allmodconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                 randconfig-r001-20230421   gcc  
m68k                 randconfig-r006-20230421   gcc  
m68k                 randconfig-r016-20230421   gcc  
m68k                 randconfig-r023-20230421   gcc  
microblaze           randconfig-r012-20230421   gcc  
microblaze           randconfig-r021-20230421   gcc  
microblaze           randconfig-r031-20230421   gcc  
microblaze           randconfig-r032-20230421   gcc  
microblaze           randconfig-r034-20230421   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r013-20230421   gcc  
mips                 randconfig-r021-20230421   gcc  
nios2        buildonly-randconfig-r002-20230421   gcc  
nios2        buildonly-randconfig-r005-20230421   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230421   gcc  
nios2                randconfig-r035-20230421   gcc  
openrisc     buildonly-randconfig-r002-20230421   gcc  
openrisc     buildonly-randconfig-r003-20230421   gcc  
openrisc     buildonly-randconfig-r006-20230421   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r032-20230421   gcc  
parisc       buildonly-randconfig-r002-20230421   gcc  
parisc       buildonly-randconfig-r004-20230421   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230421   gcc  
parisc               randconfig-r004-20230421   gcc  
parisc               randconfig-r011-20230421   gcc  
parisc               randconfig-r036-20230421   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc              randconfig-r006-20230421   gcc  
powerpc              randconfig-r014-20230421   clang
powerpc              randconfig-r033-20230421   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230421   gcc  
riscv                randconfig-r005-20230421   gcc  
riscv                randconfig-r006-20230421   gcc  
riscv                randconfig-r042-20230421   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230421   clang
s390                                defconfig   gcc  
s390                 randconfig-r004-20230421   gcc  
s390                 randconfig-r005-20230421   gcc  
s390                 randconfig-r011-20230421   clang
s390                 randconfig-r012-20230421   clang
s390                 randconfig-r016-20230421   clang
s390                 randconfig-r044-20230421   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r003-20230421   gcc  
sh                   randconfig-r016-20230421   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sparc        buildonly-randconfig-r004-20230421   gcc  
sparc        buildonly-randconfig-r005-20230421   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230421   gcc  
sparc                randconfig-r002-20230421   gcc  
sparc                randconfig-r004-20230421   gcc  
sparc64      buildonly-randconfig-r001-20230421   gcc  
sparc64              randconfig-r024-20230421   gcc  
sparc64              randconfig-r035-20230421   gcc  
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
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230421   gcc  
xtensa               randconfig-r034-20230421   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
