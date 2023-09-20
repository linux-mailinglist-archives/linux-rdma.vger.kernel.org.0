Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741267A8E4E
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 23:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjITVSr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 17:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjITVSq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 17:18:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D54B9
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 14:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695244720; x=1726780720;
  h=date:from:to:cc:subject:message-id;
  bh=Q4cGh1GJ3l3ffTo86frBTKQbD/7RBWjk5t9oDBMcZWQ=;
  b=hhbwOA48BEJGn4J15D8mVIl+OOz9OLTpQM5FALcGbK2nnC+KEMPdSTI8
   /iYl0O2wkLsctpkzc2+572xAMUk2oLusQ98FebR960Nzwb7oMQtI83I9Y
   XQZZIC6SnFRgHPYxJDhdMmitEg88TRPIyn0IOFJlVBTyp2cGHbN48IdOx
   ojg6FGYp99bawKTlcxWGJl8bQ8I2DDjBmIx0Ll+5dxB5OAfDJRrJA5I9R
   uqaRSmp4bgOxj+hn8/b4wnfiEnEMM8vEACpmPIyOXTA6phbyDgjjyxLTv
   zq7vuX70mrP/bDH/IGcofGkRsxl02y4TXoX6EVmgv73PZMHKY5hb006rC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359726509"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="359726509"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 14:15:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="812319743"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="812319743"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 20 Sep 2023 14:15:07 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qj4XJ-00099u-2x;
        Wed, 20 Sep 2023 21:15:05 +0000
Date:   Thu, 21 Sep 2023 05:13:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 58c49c097fbf5ad77fd367ad500339c36d284c23
Message-ID: <202309210514.bccBuzBE-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 58c49c097fbf5ad77fd367ad500339c36d284c23  RDMA/hns: Support SRQ restrack ops for hns driver

elapsed time: 734m

configs tested: 137
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230920   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230920   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230920   gcc  
i386         buildonly-randconfig-002-20230920   gcc  
i386         buildonly-randconfig-003-20230920   gcc  
i386         buildonly-randconfig-004-20230920   gcc  
i386         buildonly-randconfig-005-20230920   gcc  
i386         buildonly-randconfig-006-20230920   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230920   gcc  
i386                  randconfig-002-20230920   gcc  
i386                  randconfig-003-20230920   gcc  
i386                  randconfig-004-20230920   gcc  
i386                  randconfig-005-20230920   gcc  
i386                  randconfig-006-20230920   gcc  
i386                  randconfig-011-20230920   gcc  
i386                  randconfig-012-20230920   gcc  
i386                  randconfig-013-20230920   gcc  
i386                  randconfig-014-20230920   gcc  
i386                  randconfig-015-20230920   gcc  
i386                  randconfig-016-20230920   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230920   gcc  
loongarch             randconfig-001-20230921   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230920   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230920   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230920   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230920   gcc  
x86_64       buildonly-randconfig-002-20230920   gcc  
x86_64       buildonly-randconfig-003-20230920   gcc  
x86_64       buildonly-randconfig-004-20230920   gcc  
x86_64       buildonly-randconfig-005-20230920   gcc  
x86_64       buildonly-randconfig-006-20230920   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230920   gcc  
x86_64                randconfig-002-20230920   gcc  
x86_64                randconfig-003-20230920   gcc  
x86_64                randconfig-004-20230920   gcc  
x86_64                randconfig-005-20230920   gcc  
x86_64                randconfig-006-20230920   gcc  
x86_64                randconfig-011-20230920   gcc  
x86_64                randconfig-012-20230920   gcc  
x86_64                randconfig-013-20230920   gcc  
x86_64                randconfig-014-20230920   gcc  
x86_64                randconfig-015-20230920   gcc  
x86_64                randconfig-016-20230920   gcc  
x86_64                randconfig-071-20230920   gcc  
x86_64                randconfig-072-20230920   gcc  
x86_64                randconfig-073-20230920   gcc  
x86_64                randconfig-074-20230920   gcc  
x86_64                randconfig-075-20230920   gcc  
x86_64                randconfig-076-20230920   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
