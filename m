Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E20F770061
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Aug 2023 14:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjHDMld (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Aug 2023 08:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjHDMlb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Aug 2023 08:41:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5399249E1
        for <linux-rdma@vger.kernel.org>; Fri,  4 Aug 2023 05:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691152888; x=1722688888;
  h=date:from:to:cc:subject:message-id;
  bh=9FtPFYQ/DxCAHHHTs2adlSdmQixJIn0n5HKnU7jh51s=;
  b=nBWx2KuAfboJXeqvf1IyfXZ+FshbJ+ovTCv7OL7dYxccCzlSBS0RZ8JA
   VosuT/WeI2GxeyOiVWf032dVqJketm+4TW4zu4197iHKrnq438BjqtKvN
   MNPgTMOWfXJQ3Vv1ehvRidfEpvgDZ/0q207GcJ7KLgxCMcZqv4jHauC60
   5Od0ovVnKLvNceqmPe8LYsY0poT+qVwtPu1B4ekk0vopQ/V8xcvIFaYUV
   Pk81CqHASWnUOhCgN6pYWOvq1Gku/hHCmwn29L5Buwa7yvCbf++6CoryM
   Bqkt6LxFRgcWWJhrHIINsXUsoicyuBwwZz4toXNoiI/3FWCARePUtXQY1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="372890807"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="372890807"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 05:41:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="853739111"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="853739111"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 Aug 2023 05:41:25 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qRu7Q-0002qg-2i;
        Fri, 04 Aug 2023 12:41:24 +0000
Date:   Fri, 04 Aug 2023 20:41:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 38313c6d2a02c28162e06753b01bd885caf9386d
Message-ID: <202308042059.UYFUUZKy-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 38313c6d2a02c28162e06753b01bd885caf9386d  RDMA/irdma: Replace one-element array with flexible-array member

elapsed time: 1065m

configs tested: 153
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r034-20230731   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230801   gcc  
arc                  randconfig-r021-20230803   gcc  
arc                  randconfig-r036-20230731   gcc  
arc                  randconfig-r043-20230731   gcc  
arc                  randconfig-r043-20230802   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230801   clang
arm                  randconfig-r021-20230731   gcc  
arm                  randconfig-r035-20230731   clang
arm                  randconfig-r046-20230731   gcc  
arm                        realview_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230731   gcc  
arm64                randconfig-r014-20230731   clang
arm64                randconfig-r023-20230731   clang
csky                                defconfig   gcc  
csky                 randconfig-r032-20230731   gcc  
hexagon              randconfig-r013-20230731   clang
hexagon              randconfig-r022-20230803   clang
hexagon              randconfig-r041-20230731   clang
hexagon              randconfig-r045-20230731   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230801   gcc  
i386         buildonly-randconfig-r004-20230802   clang
i386         buildonly-randconfig-r005-20230801   gcc  
i386         buildonly-randconfig-r005-20230802   clang
i386         buildonly-randconfig-r006-20230801   gcc  
i386         buildonly-randconfig-r006-20230802   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230731   gcc  
i386                 randconfig-i001-20230802   clang
i386                 randconfig-i002-20230731   gcc  
i386                 randconfig-i002-20230802   clang
i386                 randconfig-i003-20230731   gcc  
i386                 randconfig-i003-20230802   clang
i386                 randconfig-i004-20230731   gcc  
i386                 randconfig-i004-20230802   clang
i386                 randconfig-i005-20230731   gcc  
i386                 randconfig-i005-20230802   clang
i386                 randconfig-i006-20230731   gcc  
i386                 randconfig-i006-20230802   clang
i386                 randconfig-i011-20230731   clang
i386                 randconfig-i012-20230731   clang
i386                 randconfig-i013-20230731   clang
i386                 randconfig-i014-20230731   clang
i386                 randconfig-i015-20230731   clang
i386                 randconfig-i016-20230731   clang
i386                 randconfig-r014-20230731   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r024-20230803   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r001-20230801   gcc  
microblaze           randconfig-r003-20230801   gcc  
microblaze           randconfig-r011-20230731   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                 randconfig-r002-20230801   clang
mips                 randconfig-r025-20230803   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230731   gcc  
nios2                randconfig-r022-20230731   gcc  
openrisc             randconfig-r003-20230731   gcc  
openrisc             randconfig-r013-20230731   gcc  
openrisc             randconfig-r016-20230731   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230801   gcc  
parisc               randconfig-r015-20230731   gcc  
parisc               randconfig-r023-20230803   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      katmai_defconfig   clang
powerpc                     mpc83xx_defconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r025-20230731   clang
riscv                randconfig-r042-20230731   clang
riscv                randconfig-r042-20230802   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r011-20230731   clang
s390                 randconfig-r015-20230731   clang
s390                 randconfig-r044-20230731   clang
s390                 randconfig-r044-20230802   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230731   gcc  
sh                   randconfig-r016-20230731   gcc  
sh                   randconfig-r024-20230731   gcc  
sh                          rsk7203_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r026-20230731   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230801   gcc  
x86_64       buildonly-randconfig-r001-20230802   clang
x86_64       buildonly-randconfig-r002-20230801   gcc  
x86_64       buildonly-randconfig-r002-20230802   clang
x86_64       buildonly-randconfig-r003-20230801   gcc  
x86_64       buildonly-randconfig-r003-20230802   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r012-20230731   clang
x86_64               randconfig-r031-20230731   gcc  
x86_64               randconfig-x001-20230731   clang
x86_64               randconfig-x001-20230802   gcc  
x86_64               randconfig-x002-20230731   clang
x86_64               randconfig-x002-20230802   gcc  
x86_64               randconfig-x003-20230731   clang
x86_64               randconfig-x003-20230802   gcc  
x86_64               randconfig-x004-20230731   clang
x86_64               randconfig-x004-20230802   gcc  
x86_64               randconfig-x005-20230731   clang
x86_64               randconfig-x005-20230802   gcc  
x86_64               randconfig-x006-20230731   clang
x86_64               randconfig-x006-20230802   gcc  
x86_64               randconfig-x011-20230731   gcc  
x86_64               randconfig-x012-20230731   gcc  
x86_64               randconfig-x013-20230731   gcc  
x86_64               randconfig-x014-20230731   gcc  
x86_64               randconfig-x015-20230731   gcc  
x86_64               randconfig-x016-20230731   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r026-20230803   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
