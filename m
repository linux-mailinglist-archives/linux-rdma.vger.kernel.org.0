Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FB772B7E8
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 08:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbjFLGF4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 02:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbjFLGFl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 02:05:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15B31BE4
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 23:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686549917; x=1718085917;
  h=date:from:to:cc:subject:message-id;
  bh=X9vcX4lPjT+1tWVJGVJqZrlpVW4pQp6dO0s7iB44Hhw=;
  b=fo9LUpcOdRQFAFQc856If/qoTJSvpO6KNv2GGMIT+3/W+pylTv4ajuJ2
   L8aQkyC3qz5r9U3CQPXoP4uXxV4+GzyV5y+01Pdfp6aaK/U1i7E3ruR9V
   uWJjIUZqgW8VwBEzxDw+50qxYEHVB9CVo5ekZdhHu0oBT/Qv8bxvGpmtf
   mwS2UmkRGy18/WAWZ6Q0qI5mxDOD2N3toh6E1Vym2dzhWqIv6ZJuxnP3u
   ZQfYocQHt9o70pOpnGAabJU0EGLHaAiLxpXoM7E7WtFIyU8TM8J3Mo6nz
   Ihsrq/mX/s2olFFddI8M7UckBmIpzEj7B67IBAAHydZaHGPC759uuWoG5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="360439459"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="360439459"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2023 23:05:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="776226383"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="776226383"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jun 2023 23:04:59 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8afi-00005N-2V;
        Mon, 12 Jun 2023 06:04:58 +0000
Date:   Mon, 12 Jun 2023 14:04:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 699826f4e30ab76a62c238c86fbef7e826639c8d
Message-ID: <202306121423.XqXKNsbS-lkp@intel.com>
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
branch HEAD: 699826f4e30ab76a62c238c86fbef7e826639c8d  IB/isert: Fix incorrect release of isert connection

elapsed time: 726m

configs tested: 140
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230612   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r025-20230612   gcc  
arc                  randconfig-r026-20230612   gcc  
arc                  randconfig-r033-20230612   gcc  
arc                  randconfig-r043-20230612   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                             mxs_defconfig   clang
arm                       netwinder_defconfig   clang
arm                  randconfig-r002-20230612   gcc  
arm                  randconfig-r024-20230612   clang
arm                  randconfig-r026-20230612   clang
arm                  randconfig-r046-20230612   clang
arm                           sama7_defconfig   clang
arm                           stm32_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230612   clang
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230612   clang
arm64                randconfig-r015-20230612   gcc  
csky                                defconfig   gcc  
hexagon      buildonly-randconfig-r003-20230612   clang
hexagon              randconfig-r041-20230612   clang
hexagon              randconfig-r045-20230612   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230612   clang
i386                 randconfig-i002-20230612   clang
i386                 randconfig-i003-20230612   clang
i386                 randconfig-i004-20230612   clang
i386                 randconfig-i005-20230612   clang
i386                 randconfig-i006-20230612   clang
i386                 randconfig-i011-20230612   gcc  
i386                 randconfig-i012-20230612   gcc  
i386                 randconfig-i013-20230612   gcc  
i386                 randconfig-i014-20230612   gcc  
i386                 randconfig-i015-20230612   gcc  
i386                 randconfig-i016-20230612   gcc  
i386                 randconfig-r005-20230612   clang
i386                 randconfig-r034-20230612   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r012-20230612   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k         buildonly-randconfig-r005-20230612   gcc  
m68k         buildonly-randconfig-r006-20230612   gcc  
m68k                                defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                 randconfig-r005-20230612   gcc  
m68k                 randconfig-r021-20230612   gcc  
m68k                 randconfig-r035-20230612   gcc  
microblaze           randconfig-r022-20230612   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r006-20230612   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
mips                 randconfig-r023-20230612   clang
mips                 randconfig-r025-20230612   clang
mips                 randconfig-r032-20230612   gcc  
mips                        vocore2_defconfig   gcc  
nios2        buildonly-randconfig-r005-20230612   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r035-20230612   gcc  
openrisc             randconfig-r003-20230612   gcc  
openrisc             randconfig-r004-20230612   gcc  
openrisc             randconfig-r006-20230612   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r004-20230612   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc                    gamecube_defconfig   clang
powerpc                     mpc83xx_defconfig   gcc  
powerpc                     sequoia_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230612   clang
riscv                randconfig-r013-20230612   gcc  
riscv                randconfig-r014-20230612   gcc  
riscv                randconfig-r042-20230612   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230612   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230612   clang
s390                 randconfig-r011-20230612   gcc  
s390                 randconfig-r022-20230612   gcc  
s390                 randconfig-r036-20230612   clang
s390                 randconfig-r044-20230612   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230612   gcc  
sh                        edosk7760_defconfig   gcc  
sh                   randconfig-r016-20230612   gcc  
sh                   randconfig-r021-20230612   gcc  
sh                   randconfig-r036-20230612   gcc  
sh                           se7619_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc        buildonly-randconfig-r002-20230612   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r023-20230612   gcc  
sparc64              randconfig-r001-20230612   gcc  
sparc64              randconfig-r015-20230612   gcc  
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
x86_64               randconfig-r031-20230612   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230612   gcc  
xtensa               randconfig-r013-20230612   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
