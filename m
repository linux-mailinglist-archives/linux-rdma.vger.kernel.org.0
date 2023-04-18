Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38D76E5B0B
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Apr 2023 09:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjDRH4d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Apr 2023 03:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjDRH4b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Apr 2023 03:56:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787EC3C1D
        for <linux-rdma@vger.kernel.org>; Tue, 18 Apr 2023 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681804588; x=1713340588;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vjB1+b7oLJBXpIGYEtGX/3pEZATHf+iBZ20KNFnGQak=;
  b=a/iEQmTSS/zfLRuK1GV8DEDeVb1pqVtUAs5N5BRZVza9sneY5FnTKkJu
   W9ZQvuk8tSh06gjjrhmyxhHLKL3okFcPUuqJlBB3KFvlJ7NYcGM3eCs/J
   aKU+ouoFCqJInR5cOVl/t+NQP5A9sOAy2XXIW5LxdhRX8GbTPxPc9yRnn
   Dt65O86QPuQdwTyNyz1ja3bDjIexNxpdvaGFVZkjgPHV6mcpNfrx43grE
   WksZiUjlBjbecSi7Q1uzFrI2RnmZNGK0+POF/0B25iKyBEsc7viRostnc
   5jZ802gWs2fAtQzJMOeP7Fbb4wG41FrrSJ4CqfK/A47vOFnw3hELh3/Fp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="333906907"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="333906907"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 00:56:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723542204"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="723542204"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Apr 2023 00:56:26 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pogCQ-000d8D-0I;
        Tue, 18 Apr 2023 07:56:26 +0000
Date:   Tue, 18 Apr 2023 15:56:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 f605f26ea196a3b49bea249330cbd18dba61a33e
Message-ID: <643e4d16.KgGMGKsK8MOAj7tF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: f605f26ea196a3b49bea249330cbd18dba61a33e  RDMA/rxe: Protect QP state with qp->state_lock

elapsed time: 728m

configs tested: 126
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r016-20230416   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230417   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230416   gcc  
arc                  randconfig-r043-20230417   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r013-20230416   clang
arm                  randconfig-r046-20230416   clang
arm                  randconfig-r046-20230417   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230417   gcc  
arm64        buildonly-randconfig-r004-20230416   clang
arm64                               defconfig   gcc  
arm64                randconfig-r021-20230417   clang
arm64                randconfig-r032-20230416   clang
arm64                randconfig-r036-20230417   gcc  
csky         buildonly-randconfig-r004-20230417   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230416   gcc  
hexagon              randconfig-r003-20230416   clang
hexagon              randconfig-r023-20230417   clang
hexagon              randconfig-r041-20230416   clang
hexagon              randconfig-r041-20230417   clang
hexagon              randconfig-r045-20230416   clang
hexagon              randconfig-r045-20230417   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230417   gcc  
i386                 randconfig-a002-20230417   gcc  
i386                 randconfig-a003-20230417   gcc  
i386                 randconfig-a004-20230417   gcc  
i386                 randconfig-a005-20230417   gcc  
i386                 randconfig-a006-20230417   gcc  
i386                 randconfig-a011-20230417   clang
i386                 randconfig-a012-20230417   clang
i386                 randconfig-a013-20230417   clang
i386                 randconfig-a014-20230417   clang
i386                 randconfig-a015-20230417   clang
i386                 randconfig-a016-20230417   clang
i386                 randconfig-r004-20230417   gcc  
i386                 randconfig-r011-20230417   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r005-20230417   gcc  
ia64                 randconfig-r006-20230416   gcc  
ia64                 randconfig-r031-20230416   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230416   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230416   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r022-20230417   gcc  
m68k                 randconfig-r024-20230417   gcc  
m68k                 randconfig-r035-20230416   gcc  
microblaze           randconfig-r014-20230417   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r023-20230416   clang
nios2        buildonly-randconfig-r001-20230416   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230416   gcc  
openrisc     buildonly-randconfig-r005-20230417   gcc  
openrisc             randconfig-r015-20230416   gcc  
openrisc             randconfig-r033-20230417   gcc  
openrisc             randconfig-r034-20230416   gcc  
parisc       buildonly-randconfig-r002-20230416   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r026-20230417   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230416   gcc  
powerpc              randconfig-r016-20230417   clang
powerpc              randconfig-r025-20230416   gcc  
powerpc              randconfig-r032-20230417   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230417   clang
riscv                               defconfig   gcc  
riscv                randconfig-r015-20230417   clang
riscv                randconfig-r022-20230416   gcc  
riscv                randconfig-r026-20230416   gcc  
riscv                randconfig-r042-20230416   gcc  
riscv                randconfig-r042-20230417   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230417   clang
s390                                defconfig   gcc  
s390                 randconfig-r044-20230416   gcc  
s390                 randconfig-r044-20230417   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230416   gcc  
sh                   randconfig-r002-20230417   gcc  
sh                   randconfig-r003-20230417   gcc  
sh                   randconfig-r014-20230416   gcc  
sh                   randconfig-r025-20230417   gcc  
sh                   randconfig-r033-20230416   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230417   gcc  
sparc                randconfig-r031-20230417   gcc  
sparc64              randconfig-r006-20230417   gcc  
sparc64              randconfig-r012-20230417   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230417   gcc  
x86_64               randconfig-a002-20230417   gcc  
x86_64               randconfig-a003-20230417   gcc  
x86_64               randconfig-a004-20230417   gcc  
x86_64               randconfig-a005-20230417   gcc  
x86_64               randconfig-a006-20230417   gcc  
x86_64               randconfig-r035-20230417   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r021-20230416   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
