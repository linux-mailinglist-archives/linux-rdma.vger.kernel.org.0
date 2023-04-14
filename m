Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1D16E2481
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Apr 2023 15:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDNNnl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Apr 2023 09:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDNNnl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Apr 2023 09:43:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B295E4
        for <linux-rdma@vger.kernel.org>; Fri, 14 Apr 2023 06:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681479820; x=1713015820;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3+TvdornYTRI73XuiTL2nX7hoAAADggUZLCOdoXDpJc=;
  b=mbOvXnfMIkb9ygg2Vty6U0IAujoiKw/cS00sGBz2JWIvvB2SjMiZ4sZW
   xjPYwb3LvnJPPBq1GsI1DLkCAuCJsQrDDi1Sd6WA4GXbsqCce6DenenAv
   c584jb2a2f8UnmAgzoApjmOZeN3vnToYyKMYMrTg7MWTXojhtFyOwm+gP
   4p6yVryKnKLU2AIl0UW7IYqxI9HssH0OVFa3sbYf+1TgnVsIDv7jtgAhs
   pWHaWBkb7UoD6x7ldhGd0AOZyBQ72frjx2fv0ImNRaWrzkarT7R1OAlov
   IfWjCmMzX6rAoYhvzWqwmf/ZVUAy+0dGfDiR/eY7TDI/zrhZW34Ek5lU7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="324093848"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="324093848"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 06:43:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="720290253"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="720290253"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Apr 2023 06:43:37 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pnJi7-000ZZs-1U;
        Fri, 14 Apr 2023 13:43:31 +0000
Date:   Fri, 14 Apr 2023 21:42:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 a2e20b29cf9ce6d2070a6e36666e2239f7f9625b
Message-ID: <6439585a.i1Ae453rLUJETo3G%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: a2e20b29cf9ce6d2070a6e36666e2239f7f9625b  RDMA/irdma: Slightly optimize irdma_form_ah_cm_frame()

elapsed time: 720m

configs tested: 107
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r024-20230413   gcc  
alpha                randconfig-r032-20230413   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r014-20230413   gcc  
arc                  randconfig-r015-20230413   gcc  
arc                  randconfig-r016-20230413   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                                 defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                  randconfig-r026-20230413   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r025-20230412   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r031-20230413   gcc  
i386                             allyesconfig   gcc  
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
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230410   gcc  
i386                 randconfig-a014-20230410   gcc  
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                 randconfig-a016-20230410   gcc  
i386                          randconfig-a016   gcc  
i386                 randconfig-r011-20230410   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r011-20230414   gcc  
ia64                 randconfig-r031-20230411   gcc  
ia64                 randconfig-r036-20230414   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r033-20230411   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r033-20230414   gcc  
microblaze           randconfig-r013-20230413   gcc  
microblaze           randconfig-r015-20230414   gcc  
microblaze           randconfig-r031-20230414   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          rm200_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r016-20230410   gcc  
nios2                randconfig-r034-20230413   gcc  
openrisc             randconfig-r013-20230414   gcc  
openrisc             randconfig-r015-20230410   gcc  
openrisc             randconfig-r022-20230413   gcc  
openrisc             randconfig-r024-20230412   gcc  
openrisc             randconfig-r025-20230413   gcc  
openrisc             randconfig-r032-20230411   gcc  
openrisc             randconfig-r034-20230411   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r014-20230409   gcc  
parisc               randconfig-r014-20230414   gcc  
parisc               randconfig-r016-20230414   gcc  
parisc               randconfig-r021-20230413   gcc  
parisc               randconfig-r026-20230412   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r015-20230409   gcc  
powerpc              randconfig-r032-20230414   clang
powerpc              randconfig-r034-20230414   clang
powerpc              randconfig-r035-20230413   gcc  
powerpc              randconfig-r036-20230411   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r014-20230410   gcc  
riscv                randconfig-r021-20230412   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r012-20230409   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r033-20230413   gcc  
sh                   randconfig-r035-20230414   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r012-20230414   gcc  
sparc                randconfig-r023-20230412   gcc  
sparc                randconfig-r035-20230411   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a005   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
