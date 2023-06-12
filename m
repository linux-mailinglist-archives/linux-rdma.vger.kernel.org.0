Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED94C72D2E9
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 23:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbjFLVLN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 17:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239419AbjFLVJJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 17:09:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE691FDD
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 14:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686604006; x=1718140006;
  h=date:from:to:cc:subject:message-id;
  bh=TklLMnTDuE6GXuOM5chFZ1rAl7EW32oatO7/OnZ5XNQ=;
  b=XDe7YNuSEQkg2S//WN6foNjKP77wejxwE6B35cwOdPLgF/G1fUnILUKb
   gZJ5pcnkBFnfC8ilX8pLDbuPCWPICSc4LI4QWRsAjIQlJ8naBP1faDKtc
   ynZfbMDvEO3Azl4srdlXbxP+wua8v/F0aiAsnFsXL7ZVwtI1+lsoJGY2g
   Bnd2CgCn6/3H+R04wU2Jt6+DiYlJy5z4cyzmCL6zrb8uI4hCL0/qZwsUI
   2GSojQGUAOl8qMXwHDd5xY128ZFRVhpiqTb/5SFZFlr2k6MS623KYLC6R
   cdQP3kEXS4Ez654qQzrlafOVrrsoLn/iUWiA03ta6HmOCXeqs5zanm4Q7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="347813150"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="347813150"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 14:06:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="1041496659"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="1041496659"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jun 2023 14:05:09 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8oiq-0000ky-2z;
        Mon, 12 Jun 2023 21:05:08 +0000
Date:   Tue, 13 Jun 2023 05:04:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 fd06a5925e47732175fcaed39d7ed5012e99f56b
Message-ID: <202306130513.6AUVQSfp-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: fd06a5925e47732175fcaed39d7ed5012e99f56b  RDMA/cma: prevent rdma id destroy during cma_iw_handler

elapsed time: 765m

configs tested: 186
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230612   gcc  
alpha                randconfig-r015-20230612   gcc  
alpha                randconfig-r024-20230612   gcc  
alpha                randconfig-r036-20230612   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r015-20230612   gcc  
arc                  randconfig-r033-20230612   gcc  
arc                  randconfig-r034-20230612   gcc  
arc                  randconfig-r043-20230612   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r004-20230612   clang
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230612   gcc  
arm                  randconfig-r012-20230612   clang
arm                  randconfig-r016-20230612   clang
arm                  randconfig-r024-20230612   clang
arm                  randconfig-r026-20230612   clang
arm                  randconfig-r033-20230612   gcc  
arm                  randconfig-r036-20230612   gcc  
arm                  randconfig-r046-20230612   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230612   clang
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r002-20230612   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230612   gcc  
csky                 randconfig-r012-20230612   gcc  
csky                 randconfig-r031-20230612   gcc  
csky                 randconfig-r032-20230612   gcc  
hexagon              randconfig-r003-20230612   clang
hexagon              randconfig-r016-20230612   clang
hexagon              randconfig-r041-20230612   clang
hexagon              randconfig-r045-20230612   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230612   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230612   clang
i386                 randconfig-i002-20230612   clang
i386                 randconfig-i003-20230612   clang
i386                 randconfig-i004-20230612   clang
i386                 randconfig-i005-20230612   clang
i386                 randconfig-i006-20230612   clang
i386                 randconfig-i011-20230612   gcc  
i386                 randconfig-i011-20230613   clang
i386                 randconfig-i012-20230612   gcc  
i386                 randconfig-i012-20230613   clang
i386                 randconfig-i013-20230612   gcc  
i386                 randconfig-i013-20230613   clang
i386                 randconfig-i014-20230612   gcc  
i386                 randconfig-i014-20230613   clang
i386                 randconfig-i015-20230612   gcc  
i386                 randconfig-i015-20230613   clang
i386                 randconfig-i016-20230612   gcc  
i386                 randconfig-i016-20230613   clang
i386                 randconfig-r001-20230612   clang
i386                 randconfig-r012-20230612   gcc  
i386                 randconfig-r014-20230612   gcc  
i386                 randconfig-r015-20230612   gcc  
i386                 randconfig-r021-20230612   gcc  
i386                 randconfig-r035-20230612   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230612   gcc  
loongarch            randconfig-r015-20230612   gcc  
loongarch            randconfig-r023-20230612   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k         buildonly-randconfig-r004-20230612   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230612   gcc  
m68k                 randconfig-r006-20230612   gcc  
m68k                 randconfig-r011-20230612   gcc  
m68k                 randconfig-r021-20230612   gcc  
m68k                 randconfig-r033-20230612   gcc  
microblaze           randconfig-r004-20230612   gcc  
microblaze           randconfig-r012-20230612   gcc  
microblaze           randconfig-r013-20230612   gcc  
microblaze           randconfig-r014-20230612   gcc  
microblaze           randconfig-r022-20230612   gcc  
microblaze           randconfig-r032-20230612   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r006-20230612   gcc  
mips                 randconfig-r001-20230612   gcc  
mips                 randconfig-r003-20230612   gcc  
mips                 randconfig-r005-20230612   gcc  
mips                 randconfig-r011-20230612   clang
mips                 randconfig-r031-20230612   gcc  
mips                 randconfig-r034-20230612   gcc  
nios2        buildonly-randconfig-r001-20230612   gcc  
nios2        buildonly-randconfig-r005-20230612   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230612   gcc  
nios2                randconfig-r014-20230612   gcc  
nios2                randconfig-r024-20230612   gcc  
nios2                randconfig-r025-20230612   gcc  
nios2                randconfig-r031-20230612   gcc  
openrisc     buildonly-randconfig-r004-20230612   gcc  
openrisc             randconfig-r011-20230612   gcc  
openrisc             randconfig-r013-20230612   gcc  
openrisc             randconfig-r026-20230612   gcc  
openrisc             randconfig-r036-20230612   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r003-20230612   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230612   gcc  
parisc               randconfig-r022-20230612   gcc  
parisc               randconfig-r023-20230612   gcc  
parisc               randconfig-r036-20230612   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230612   gcc  
powerpc      buildonly-randconfig-r005-20230612   gcc  
powerpc              randconfig-r003-20230612   clang
powerpc              randconfig-r015-20230612   gcc  
powerpc              randconfig-r032-20230612   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv        buildonly-randconfig-r005-20230612   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230612   clang
riscv                randconfig-r005-20230612   clang
riscv                randconfig-r006-20230612   clang
riscv                randconfig-r011-20230612   gcc  
riscv                randconfig-r042-20230612   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230612   clang
s390                 randconfig-r013-20230612   gcc  
s390                 randconfig-r016-20230612   gcc  
s390                 randconfig-r025-20230612   gcc  
s390                 randconfig-r044-20230612   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r003-20230612   gcc  
sh                   randconfig-r001-20230612   gcc  
sh                   randconfig-r016-20230612   gcc  
sh                   randconfig-r035-20230612   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230612   gcc  
sparc                randconfig-r022-20230612   gcc  
sparc                randconfig-r025-20230612   gcc  
sparc64      buildonly-randconfig-r001-20230612   gcc  
sparc64      buildonly-randconfig-r006-20230612   gcc  
sparc64              randconfig-r002-20230612   gcc  
sparc64              randconfig-r013-20230612   gcc  
sparc64              randconfig-r015-20230612   gcc  
sparc64              randconfig-r021-20230612   gcc  
sparc64              randconfig-r031-20230612   gcc  
sparc64              randconfig-r032-20230612   gcc  
sparc64              randconfig-r034-20230612   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230612   clang
x86_64               randconfig-a002-20230612   clang
x86_64               randconfig-a003-20230612   clang
x86_64               randconfig-a004-20230612   clang
x86_64               randconfig-a005-20230612   clang
x86_64               randconfig-a006-20230612   clang
x86_64               randconfig-a011-20230612   gcc  
x86_64               randconfig-a012-20230612   gcc  
x86_64               randconfig-a013-20230612   gcc  
x86_64               randconfig-a014-20230612   gcc  
x86_64               randconfig-a015-20230612   gcc  
x86_64               randconfig-a016-20230612   gcc  
x86_64               randconfig-r012-20230612   gcc  
x86_64               randconfig-r026-20230612   gcc  
x86_64               randconfig-r034-20230612   clang
x86_64               randconfig-r035-20230612   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r014-20230612   gcc  
xtensa               randconfig-r016-20230612   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
