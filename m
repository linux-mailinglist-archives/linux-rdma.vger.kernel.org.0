Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88F46DC1ED
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Apr 2023 00:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjDIWgw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Apr 2023 18:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDIWgv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Apr 2023 18:36:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D33630EC
        for <linux-rdma@vger.kernel.org>; Sun,  9 Apr 2023 15:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681079810; x=1712615810;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/Xrzxjlr+cShX5ItbbyvqlfuB68K0uPK/ckb/p3ISqo=;
  b=SpHv1lBKrl3FgkBhhf5m+pfuTW8wFgy13EUR28NQhKKycZM0WE4Xi3bP
   5XAjMxSgfKo44hpxjjfR7QgM9hFXW1m9d/ZAXqTMRa6zXvnDHVKsVrm8q
   7p6rzV/mwW4iTepFTNpeqEtxolTeLB6rDeK2O2gnxKw1PW60jR32RUU7b
   esMFv98Qxj2eAuP+fE9YXZu/QlPYBiMJAy4e0Eeh/levUSsga+UJPeDt+
   m9sBTo1NS3bcWiCaUc5VV3kCZd81UO8qslrxVC4el6lB8h8SWq+vjLg9N
   wAtXtjcJvgMwAtpSuBwjRUY0QlN/q5WDooP/4aOY2P2ELOglic5P92+Yc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="345035246"
X-IronPort-AV: E=Sophos;i="5.98,332,1673942400"; 
   d="scan'208";a="345035246"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2023 15:36:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10675"; a="688080811"
X-IronPort-AV: E=Sophos;i="5.98,332,1673942400"; 
   d="scan'208";a="688080811"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Apr 2023 15:36:48 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pldeR-000UpE-1l;
        Sun, 09 Apr 2023 22:36:47 +0000
Date:   Mon, 10 Apr 2023 06:36:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 866694afd644cd5ee32411713c3d802fcca22ebb
Message-ID: <64333dec.3WYc7/Yj2Y+CqjMr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 866694afd644cd5ee32411713c3d802fcca22ebb  IB/hfi1: Place struct mmu_rb_handler on cache line start

elapsed time: 722m

configs tested: 140
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230409   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230409   gcc  
alpha                randconfig-r013-20230409   gcc  
alpha                randconfig-r032-20230409   gcc  
alpha                randconfig-r035-20230409   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230409   gcc  
arc                  randconfig-r043-20230409   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                  randconfig-r014-20230409   clang
arm                  randconfig-r046-20230409   clang
arm64                            alldefconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230409   clang
csky                                defconfig   gcc  
csky                 randconfig-r031-20230409   gcc  
hexagon      buildonly-randconfig-r002-20230409   clang
hexagon              randconfig-r005-20230409   clang
hexagon              randconfig-r012-20230409   clang
hexagon              randconfig-r015-20230409   clang
hexagon              randconfig-r041-20230409   clang
hexagon              randconfig-r045-20230409   clang
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
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r003-20230409   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r013-20230409   gcc  
ia64                 randconfig-r022-20230409   gcc  
ia64                 randconfig-r025-20230409   gcc  
ia64                          tiger_defconfig   gcc  
ia64                            zx1_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r021-20230409   gcc  
loongarch            randconfig-r024-20230409   gcc  
loongarch            randconfig-r035-20230409   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230409   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip22_defconfig   clang
mips                           ip27_defconfig   clang
mips                 randconfig-r021-20230409   clang
mips                 randconfig-r034-20230409   gcc  
mips                           rs90_defconfig   clang
nios2        buildonly-randconfig-r006-20230409   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230409   gcc  
nios2                randconfig-r002-20230409   gcc  
nios2                randconfig-r011-20230409   gcc  
nios2                randconfig-r016-20230409   gcc  
parisc       buildonly-randconfig-r001-20230409   gcc  
parisc       buildonly-randconfig-r003-20230409   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230409   gcc  
parisc               randconfig-r011-20230409   gcc  
parisc               randconfig-r023-20230409   gcc  
parisc               randconfig-r024-20230409   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                 mpc836x_mds_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230409   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230409   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r026-20230409   gcc  
s390                 randconfig-r044-20230409   gcc  
sh                               allmodconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                   randconfig-r022-20230409   gcc  
sh                   randconfig-r025-20230409   gcc  
sh                           se7750_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r033-20230409   gcc  
sparc64      buildonly-randconfig-r005-20230409   gcc  
sparc64      buildonly-randconfig-r006-20230409   gcc  
sparc64              randconfig-r026-20230409   gcc  
sparc64              randconfig-r032-20230409   gcc  
sparc64              randconfig-r033-20230409   gcc  
sparc64              randconfig-r036-20230409   gcc  
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
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r002-20230409   gcc  
xtensa               randconfig-r005-20230409   gcc  
xtensa               randconfig-r015-20230409   gcc  
xtensa               randconfig-r016-20230409   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
