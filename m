Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A79872AC53
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Jun 2023 16:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjFJObq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 10 Jun 2023 10:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFJObp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 10 Jun 2023 10:31:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6062C0
        for <linux-rdma@vger.kernel.org>; Sat, 10 Jun 2023 07:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686407504; x=1717943504;
  h=date:from:to:cc:subject:message-id;
  bh=uFFTqdbrfvHda2eMOHR/nm3SGrUp4Wd1RKvOi0f7BDo=;
  b=jSDjTJWvedn13XvO6JFC6UfDzQH6W6TK2yN3YizrhsBl/L9Q1ohpsmX/
   EtSkvSCpjzsVhM7bfUFSQn7XPxlxstDmjaBMIYZETmEf+D3SVfKiATn/J
   Nk8sOTLVqKe37uWeUF7PrnFOM83EJFSnX5inFVbA9xNOGPgNFz0W0PD5S
   4/ZosxHzM/A0sXq4MuUK+dnxlclkLIyJiSzR8WbW5jp5P4Vws/aipbI4i
   KZz8bTKLM216J5qZgDZS6WdUcceFDIZfg8Y0NWfzP09dxwmwc/w9rx9DU
   4UdDqm4sKafImCu//muc21urusy696QuWhEoCD2vpdGA0lc3iU/BU7DFS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="342451927"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="342451927"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 07:31:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="775815688"
X-IronPort-AV: E=Sophos;i="6.00,232,1681196400"; 
   d="scan'208";a="775815688"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jun 2023 07:31:42 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7zcz-000A9C-2W;
        Sat, 10 Jun 2023 14:31:41 +0000
Date:   Sat, 10 Jun 2023 22:31:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 2a62b6210ce876c596086ab8fd4c8a0c3d10611a
Message-ID: <202306102208.EYt3bGbK-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: 2a62b6210ce876c596086ab8fd4c8a0c3d10611a  RDMA/rxe: Fix the use-before-initialization error of resp_pkts

elapsed time: 1227m

configs tested: 168
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r006-20230610   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230610   gcc  
alpha                randconfig-r014-20230610   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230610   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                  randconfig-r012-20230610   gcc  
arc                  randconfig-r015-20230610   gcc  
arc                  randconfig-r043-20230609   gcc  
arc                  randconfig-r043-20230610   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230610   clang
arm          buildonly-randconfig-r002-20230610   clang
arm                                 defconfig   gcc  
arm                          ep93xx_defconfig   clang
arm                          moxart_defconfig   clang
arm                       netwinder_defconfig   clang
arm                  randconfig-r013-20230610   clang
arm                  randconfig-r022-20230610   clang
arm                  randconfig-r046-20230609   clang
arm                  randconfig-r046-20230610   clang
arm                         vf610m4_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r024-20230610   gcc  
csky         buildonly-randconfig-r002-20230610   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r025-20230610   gcc  
hexagon              randconfig-r005-20230610   clang
hexagon              randconfig-r025-20230608   clang
hexagon              randconfig-r036-20230610   clang
hexagon              randconfig-r041-20230609   clang
hexagon              randconfig-r041-20230610   clang
hexagon              randconfig-r045-20230609   clang
hexagon              randconfig-r045-20230610   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230608   gcc  
i386                 randconfig-i001-20230610   clang
i386                 randconfig-i002-20230608   gcc  
i386                 randconfig-i002-20230610   clang
i386                 randconfig-i003-20230608   gcc  
i386                 randconfig-i003-20230610   clang
i386                 randconfig-i004-20230608   gcc  
i386                 randconfig-i004-20230610   clang
i386                 randconfig-i005-20230610   clang
i386                 randconfig-i011-20230610   gcc  
i386                 randconfig-i012-20230610   gcc  
i386                 randconfig-i013-20230610   gcc  
i386                 randconfig-i014-20230610   gcc  
i386                 randconfig-i015-20230610   gcc  
i386                 randconfig-i016-20230610   gcc  
i386                 randconfig-r024-20230608   clang
i386                 randconfig-r025-20230610   gcc  
i386                 randconfig-r026-20230608   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230610   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r021-20230610   gcc  
loongarch            randconfig-r022-20230608   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                 randconfig-r024-20230610   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze   buildonly-randconfig-r006-20230610   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips         buildonly-randconfig-r004-20230610   gcc  
mips                          malta_defconfig   clang
mips                      malta_kvm_defconfig   clang
mips                 randconfig-r011-20230610   clang
mips                 randconfig-r022-20230610   clang
mips                 randconfig-r026-20230610   clang
nios2                               defconfig   gcc  
nios2                randconfig-r032-20230610   gcc  
openrisc             randconfig-r011-20230610   gcc  
openrisc             randconfig-r033-20230610   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r023-20230610   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    gamecube_defconfig   clang
powerpc                      katmai_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc              randconfig-r033-20230610   clang
powerpc              randconfig-r035-20230610   clang
powerpc                      tqm8xx_defconfig   gcc  
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv        buildonly-randconfig-r003-20230610   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r031-20230610   clang
riscv                randconfig-r042-20230609   gcc  
riscv                randconfig-r042-20230610   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230610   gcc  
s390         buildonly-randconfig-r005-20230610   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230610   clang
s390                 randconfig-r031-20230610   clang
s390                 randconfig-r044-20230609   gcc  
s390                 randconfig-r044-20230610   gcc  
sh                               allmodconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r034-20230610   gcc  
sh                          rsk7201_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230610   gcc  
sparc                randconfig-r016-20230610   gcc  
sparc                randconfig-r023-20230608   gcc  
sparc64      buildonly-randconfig-r004-20230610   gcc  
sparc64              randconfig-r034-20230610   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230610   clang
x86_64               randconfig-a002-20230610   clang
x86_64               randconfig-a003-20230610   clang
x86_64               randconfig-a004-20230610   clang
x86_64               randconfig-a006-20230610   clang
x86_64               randconfig-a011-20230608   clang
x86_64               randconfig-a011-20230610   gcc  
x86_64               randconfig-a012-20230610   gcc  
x86_64               randconfig-a013-20230608   clang
x86_64               randconfig-a013-20230610   gcc  
x86_64               randconfig-a014-20230608   clang
x86_64               randconfig-a014-20230610   gcc  
x86_64               randconfig-a015-20230610   gcc  
x86_64               randconfig-a016-20230610   gcc  
x86_64               randconfig-r004-20230610   clang
x86_64               randconfig-r015-20230610   gcc  
x86_64               randconfig-r021-20230610   gcc  
x86_64               randconfig-r023-20230610   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r006-20230610   gcc  
xtensa               randconfig-r016-20230610   gcc  
xtensa               randconfig-r021-20230608   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
