Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6428B6E0D51
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Apr 2023 14:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjDMMPY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Apr 2023 08:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjDMMOw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Apr 2023 08:14:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74D2448F
        for <linux-rdma@vger.kernel.org>; Thu, 13 Apr 2023 05:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681388090; x=1712924090;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=MF6LmidI4B+E6Acgw92YV2V38VnP/0fyn9kr+p5Pbm0=;
  b=YPrYP0wBISUMP0PoQnYOIqZELyG4oA687uKw4Ur9P8YEhKnSvn4HzZ4U
   vnhggSGSTZ7b0rD21iUVh4vCzGkuLHWlIxaAK/HZSArdwc2JRuNdt6036
   17uUMtSHQm4GL4rs7c6IEqzFtdDn6HDU1kH7Fy1+ZV79EuraQwGpvroQB
   jQSxnDX3l7Bo6xsF/oAyvp35d5twZsw6EpyjIDF1Qm/kcKasbYGPDams8
   h3R2rvzqQho8XDWK61y8YhvQOulZa7uaAxCahXBRODYOulhPIp8QXrwZG
   y8qjP7ea0QxkMDmzPugSaUBP+DKaR90CTSIuuTKKkt7PsbfyjTYIDMHFY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="328282374"
X-IronPort-AV: E=Sophos;i="5.99,341,1677571200"; 
   d="scan'208";a="328282374"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 05:14:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="758675738"
X-IronPort-AV: E=Sophos;i="5.99,341,1677571200"; 
   d="scan'208";a="758675738"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 13 Apr 2023 05:14:48 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pmvqh-000Yez-2K;
        Thu, 13 Apr 2023 12:14:47 +0000
Date:   Thu, 13 Apr 2023 20:14:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 979e5e0a255d7a4fe568aa23f2ec9c21eb97c258
Message-ID: <6437f232.tDRqKZ+tDl98fPjT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 979e5e0a255d7a4fe568aa23f2ec9c21eb97c258  RDMA/irdma: Slightly optimize irdma_form_ah_cm_frame()

elapsed time: 723m

configs tested: 163
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230413   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230409   gcc  
alpha                randconfig-r023-20230410   gcc  
alpha                randconfig-r026-20230410   gcc  
alpha                randconfig-r032-20230413   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230412   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r026-20230413   gcc  
arc                  randconfig-r043-20230409   gcc  
arc                  randconfig-r043-20230410   gcc  
arc                  randconfig-r043-20230412   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                                 defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230410   clang
arm64                randconfig-r016-20230410   gcc  
arm64                randconfig-r022-20230410   gcc  
csky         buildonly-randconfig-r004-20230411   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r014-20230410   gcc  
csky                 randconfig-r031-20230413   gcc  
hexagon              randconfig-r005-20230410   clang
i386                             allyesconfig   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230410   clang
i386                 randconfig-a002-20230410   clang
i386                 randconfig-a003-20230410   clang
i386                 randconfig-a004-20230410   clang
i386                 randconfig-a005-20230410   clang
i386                 randconfig-a006-20230410   clang
i386                 randconfig-a011-20230410   gcc  
i386                 randconfig-a012-20230410   gcc  
i386                 randconfig-a013-20230410   gcc  
i386                 randconfig-a014-20230410   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                 randconfig-a016-20230410   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230409   gcc  
ia64         buildonly-randconfig-r006-20230411   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r022-20230409   gcc  
ia64                 randconfig-r031-20230411   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r006-20230413   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230410   gcc  
loongarch            randconfig-r014-20230409   gcc  
loongarch            randconfig-r022-20230412   gcc  
loongarch            randconfig-r024-20230409   gcc  
loongarch            randconfig-r033-20230411   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r021-20230410   gcc  
m68k                 randconfig-r024-20230409   gcc  
m68k                 randconfig-r024-20230413   gcc  
microblaze   buildonly-randconfig-r003-20230411   gcc  
microblaze           randconfig-r016-20230409   gcc  
microblaze           randconfig-r023-20230410   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      pic32mzda_defconfig   clang
nios2        buildonly-randconfig-r003-20230413   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r025-20230413   gcc  
nios2                randconfig-r034-20230413   gcc  
openrisc     buildonly-randconfig-r002-20230411   gcc  
openrisc     buildonly-randconfig-r002-20230413   gcc  
openrisc     buildonly-randconfig-r004-20230409   gcc  
openrisc     buildonly-randconfig-r006-20230413   gcc  
openrisc             randconfig-r024-20230410   gcc  
openrisc             randconfig-r032-20230411   gcc  
openrisc             randconfig-r034-20230411   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r023-20230409   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230410   gcc  
powerpc      buildonly-randconfig-r006-20230409   gcc  
powerpc              randconfig-r006-20230409   clang
powerpc              randconfig-r026-20230410   gcc  
powerpc              randconfig-r035-20230413   gcc  
powerpc              randconfig-r036-20230411   gcc  
powerpc              randconfig-r036-20230412   clang
powerpc                     tqm5200_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230409   clang
riscv                randconfig-r003-20230410   clang
riscv                randconfig-r004-20230409   clang
riscv                randconfig-r021-20230412   gcc  
riscv                randconfig-r024-20230410   gcc  
riscv                randconfig-r031-20230412   clang
riscv                randconfig-r035-20230412   clang
riscv                randconfig-r042-20230409   gcc  
riscv                randconfig-r042-20230410   gcc  
riscv                randconfig-r042-20230412   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230409   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r024-20230412   gcc  
s390                 randconfig-r026-20230409   gcc  
s390                 randconfig-r044-20230409   gcc  
s390                 randconfig-r044-20230410   gcc  
s390                 randconfig-r044-20230412   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230412   gcc  
sh           buildonly-randconfig-r005-20230411   gcc  
sh           buildonly-randconfig-r005-20230413   gcc  
sh                   randconfig-r015-20230409   gcc  
sh                   randconfig-r021-20230413   gcc  
sh                   randconfig-r025-20230409   gcc  
sh                   randconfig-r033-20230413   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r012-20230409   gcc  
sparc                randconfig-r035-20230411   gcc  
sparc64      buildonly-randconfig-r004-20230413   gcc  
sparc64      buildonly-randconfig-r005-20230412   gcc  
sparc64              randconfig-r022-20230410   gcc  
sparc64              randconfig-r022-20230413   gcc  
sparc64              randconfig-r023-20230412   gcc  
sparc64              randconfig-r025-20230410   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230410   clang
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230410   clang
x86_64               randconfig-a003-20230410   clang
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230410   clang
x86_64               randconfig-a005-20230410   clang
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230410   clang
x86_64               randconfig-a011-20230410   gcc  
x86_64               randconfig-a012-20230410   gcc  
x86_64               randconfig-a013-20230410   gcc  
x86_64               randconfig-a014-20230410   gcc  
x86_64               randconfig-a015-20230410   gcc  
x86_64               randconfig-a016-20230410   gcc  
x86_64               randconfig-r006-20230410   clang
x86_64               randconfig-r021-20230410   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230411   gcc  
xtensa       buildonly-randconfig-r001-20230413   gcc  
xtensa               randconfig-r025-20230412   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
