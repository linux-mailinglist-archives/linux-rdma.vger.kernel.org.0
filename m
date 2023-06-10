Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0835572A91F
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Jun 2023 07:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjFJFLT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 10 Jun 2023 01:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjFJFLT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 10 Jun 2023 01:11:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED193AB4
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 22:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686373878; x=1717909878;
  h=date:from:to:cc:subject:message-id;
  bh=rhyZMpGLqpJKSJKyVOWMAtmZYxvXW+VD2ERs63EihZ8=;
  b=X3N6vC2uavIUEhC0c62RTvOPHIVPjxFQRJ3ZtGoU1QOF7HPeh9hztJwi
   TzRxEPW9ezCt1PqnlxgjzSacI/rZ5IBiCM60VHGiHF95ZtvilfOwqrIZ3
   lyEmD0OHYq2/ZIGoHoxSBFJKIKiNyGmJhbPzZl/RB/oDq7Hhj1jU4OHr0
   cHljatF5SH0y3y8Xffl24IRVmkr79tL5+6wqmkbqR8vS6+wjtntPksorb
   /ZhBiIoxY8kEkRdIlV9W6MZJxx8IwFLM4gKSoEhDIzGgnl9nrlaOxyVXv
   J6AFLtAgLWV9dKGzoNOC8+zoDiINx/NtwftIsG0wBC6dRsJ13FfJh7Je7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="421325874"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="421325874"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 22:11:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="660987364"
X-IronPort-AV: E=Sophos;i="6.00,231,1681196400"; 
   d="scan'208";a="660987364"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Jun 2023 22:11:16 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7qsd-0009le-22;
        Sat, 10 Jun 2023 05:11:15 +0000
Date:   Sat, 10 Jun 2023 13:10:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:for-rc] BUILD SUCCESS
 18e7e3e4217083a682e2c7282011c70c8a1ba070
Message-ID: <202306101338.K0in3Rgg-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: 18e7e3e4217083a682e2c7282011c70c8a1ba070  RDMA/bnxt_re: Fix reporting active_{speed,width} attributes

elapsed time: 741m

configs tested: 97
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230608   gcc  
alpha                randconfig-r021-20230608   gcc  
alpha                randconfig-r023-20230608   gcc  
alpha                randconfig-r031-20230608   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r025-20230608   gcc  
arc                  randconfig-r043-20230608   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230608   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r022-20230608   clang
csky                                defconfig   gcc  
csky                 randconfig-r002-20230608   gcc  
hexagon      buildonly-randconfig-r001-20230608   clang
hexagon              randconfig-r001-20230608   clang
hexagon              randconfig-r013-20230610   clang
hexagon              randconfig-r041-20230608   clang
hexagon              randconfig-r045-20230608   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230608   gcc  
i386                 randconfig-i002-20230608   gcc  
i386                 randconfig-i003-20230608   gcc  
i386                 randconfig-i004-20230608   gcc  
i386                 randconfig-i005-20230608   gcc  
i386                 randconfig-i006-20230608   gcc  
i386                 randconfig-i051-20230608   gcc  
i386                 randconfig-i052-20230608   gcc  
i386                 randconfig-i053-20230608   gcc  
i386                 randconfig-i054-20230608   gcc  
i386                 randconfig-i055-20230608   gcc  
i386                 randconfig-i056-20230608   gcc  
i386                 randconfig-r003-20230608   gcc  
i386                 randconfig-r011-20230610   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230608   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r033-20230608   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r005-20230608   gcc  
microblaze           randconfig-r024-20230608   gcc  
microblaze           randconfig-r036-20230608   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r016-20230610   clang
nios2                               defconfig   gcc  
nios2                randconfig-r034-20230608   gcc  
openrisc             randconfig-r014-20230610   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r006-20230608   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230608   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r032-20230608   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230608   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r012-20230610   gcc  
s390                 randconfig-r035-20230608   gcc  
s390                 randconfig-r044-20230608   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r026-20230608   gcc  
sparc                            allyesconfig   gcc  
sparc        buildonly-randconfig-r003-20230608   gcc  
sparc                               defconfig   gcc  
sparc64      buildonly-randconfig-r005-20230608   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x061-20230608   clang
x86_64               randconfig-x062-20230608   clang
x86_64               randconfig-x063-20230608   clang
x86_64               randconfig-x064-20230608   clang
x86_64               randconfig-x065-20230608   clang
x86_64               randconfig-x066-20230608   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
