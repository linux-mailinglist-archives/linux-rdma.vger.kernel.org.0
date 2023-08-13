Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E7A77AB4D
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Aug 2023 23:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjHMVDn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Aug 2023 17:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHMVDn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Aug 2023 17:03:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B29F10D0
        for <linux-rdma@vger.kernel.org>; Sun, 13 Aug 2023 14:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691960625; x=1723496625;
  h=date:from:to:cc:subject:message-id;
  bh=d+IMtUWwYzx9wxfO2d0E4/Ndbz1bTS+Oa4lpbW8sbD0=;
  b=ZVBOYg7Hi0vKweWevWvUhCRJWaoHO8rnuPC71Oncm3u1wxlFOCOCHsOq
   YH/OQZqdERd5wiWWa/7xlwKvrfTOUGuquZBw8imZIX/MySkMgdPM2vxxM
   p1SQdswEi9V6Mx6epBw1cce1ZrR1oehNIrnuEFOQC71JrELjsqW1R05qB
   GDLWEJ/i/zR9QteO1JsrEv0zEfyOxH/OHl2gbW5IHt4kRGvuNI/vV0vrU
   XYQeZFPvI1LKuw29fmpNX653jqLtMNphzRFrpgI6r8kfvXs6LQtBBmO/6
   GH+Sdxlt5/Htwtr/cCIMDIA3Gf0ylEyIr21KD5iG4MkuTkv9uTP+WjZWL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="371928612"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="371928612"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 14:03:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="907011654"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="907011654"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Aug 2023 14:03:42 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVIFR-0009DW-2p;
        Sun, 13 Aug 2023 21:03:41 +0000
Date:   Mon, 14 Aug 2023 05:03:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 ca60fd116c7ee1a4471a8ad0fe07cdfa57f24c11
Message-ID: <202308140534.qycAtQy6-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: ca60fd116c7ee1a4471a8ad0fe07cdfa57f24c11  IB/core: Add more speed parsing in ib_get_width_and_speed()

elapsed time: 726m

configs tested: 129
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230813   gcc  
alpha                randconfig-r036-20230813   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r033-20230813   gcc  
arc                  randconfig-r043-20230813   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230813   gcc  
arm                  randconfig-r046-20230813   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230813   gcc  
arm64                randconfig-r015-20230813   gcc  
arm64                randconfig-r024-20230813   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230813   gcc  
csky                 randconfig-r014-20230813   gcc  
csky                 randconfig-r023-20230813   gcc  
csky                 randconfig-r033-20230813   gcc  
csky                 randconfig-r034-20230813   gcc  
hexagon              randconfig-r014-20230813   clang
hexagon              randconfig-r026-20230813   clang
hexagon              randconfig-r041-20230813   clang
hexagon              randconfig-r045-20230813   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230813   clang
i386         buildonly-randconfig-r005-20230813   clang
i386         buildonly-randconfig-r006-20230813   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230813   clang
i386                 randconfig-i002-20230813   clang
i386                 randconfig-i003-20230813   clang
i386                 randconfig-i004-20230813   clang
i386                 randconfig-i005-20230813   clang
i386                 randconfig-i006-20230813   clang
i386                 randconfig-i011-20230813   gcc  
i386                 randconfig-i012-20230813   gcc  
i386                 randconfig-i013-20230813   gcc  
i386                 randconfig-i014-20230813   gcc  
i386                 randconfig-i015-20230813   gcc  
i386                 randconfig-i016-20230813   gcc  
i386                 randconfig-r002-20230813   clang
i386                 randconfig-r016-20230813   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230813   gcc  
loongarch            randconfig-r013-20230813   gcc  
loongarch            randconfig-r032-20230813   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r024-20230813   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r003-20230813   gcc  
mips                 randconfig-r011-20230813   clang
nios2                               defconfig   gcc  
nios2                randconfig-r023-20230813   gcc  
nios2                randconfig-r031-20230813   gcc  
nios2                randconfig-r032-20230813   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r021-20230813   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r006-20230813   clang
powerpc              randconfig-r031-20230813   clang
powerpc              randconfig-r035-20230813   clang
powerpc              randconfig-r036-20230813   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230813   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230813   clang
s390                 randconfig-r002-20230813   clang
s390                 randconfig-r013-20230813   gcc  
s390                 randconfig-r044-20230813   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r022-20230813   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r025-20230813   gcc  
sparc64              randconfig-r035-20230813   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r001-20230813   gcc  
um                   randconfig-r006-20230813   gcc  
um                   randconfig-r016-20230813   clang
um                   randconfig-r034-20230813   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230813   clang
x86_64       buildonly-randconfig-r002-20230813   clang
x86_64       buildonly-randconfig-r003-20230813   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r005-20230813   clang
x86_64               randconfig-r012-20230813   gcc  
x86_64               randconfig-r025-20230813   gcc  
x86_64               randconfig-x001-20230813   gcc  
x86_64               randconfig-x002-20230813   gcc  
x86_64               randconfig-x003-20230813   gcc  
x86_64               randconfig-x004-20230813   gcc  
x86_64               randconfig-x005-20230813   gcc  
x86_64               randconfig-x006-20230813   gcc  
x86_64               randconfig-x011-20230813   clang
x86_64               randconfig-x012-20230813   clang
x86_64               randconfig-x013-20230813   clang
x86_64               randconfig-x014-20230813   clang
x86_64               randconfig-x015-20230813   clang
x86_64               randconfig-x016-20230813   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r021-20230813   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
