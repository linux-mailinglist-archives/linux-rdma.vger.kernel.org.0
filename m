Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3607BBA9B
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Oct 2023 16:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjJFOoM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Oct 2023 10:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjJFOoL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Oct 2023 10:44:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3148A6
        for <linux-rdma@vger.kernel.org>; Fri,  6 Oct 2023 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696603450; x=1728139450;
  h=date:from:to:cc:subject:message-id;
  bh=oo9jB6+i+GymbHxZKyPFbIekYFsS8VG06s6c1Nd6A+E=;
  b=DTQ4pZV0JsyiesLNO8YFu9t72EI86Tb7pR0pxrLSyWFMdEsEgtsv/cDU
   mW+Y2kcsGVM8fnuwmYBzhfgAqnuHlzdLWMFxUlAtCS0t5DAhDI6JqXdY3
   t6mXKVW6/qOS0duks71zTnaR/MxvdP01sc5WFrSYvABk2eHM6rvT9YKIl
   Xm+6CWuV4CjQypttgqfdygvSO94NRlP02Np4VXCaX0ta20pTPISlSTo+3
   fvgnkIiSvfAHscHJoLivnZ1jTzgiQUxBM4SyDz5ooDK69F/RYk4grDAl4
   boPjNYek1u0BlnzrkwRF8jqSbSjQQd3+t5tnpdyzNktSVxnL5zxthXPOP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="386588834"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="386588834"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 07:44:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="787404019"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="787404019"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 Oct 2023 07:44:08 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qom3i-0001Dd-0a;
        Fri, 06 Oct 2023 14:44:06 +0000
Date:   Fri, 06 Oct 2023 22:43:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 1c66501b71020e70802b0c8b3375fd92df1bb016
Message-ID: <202310062236.bIJMXTED-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: 1c66501b71020e70802b0c8b3375fd92df1bb016  Revert "RDMA/rxe: Add workqueue support for rxe tasks"

elapsed time: 1288m

configs tested: 94
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
arc                   randconfig-001-20231006   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
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
i386         buildonly-randconfig-001-20231006   gcc  
i386         buildonly-randconfig-002-20231006   gcc  
i386         buildonly-randconfig-003-20231006   gcc  
i386         buildonly-randconfig-004-20231006   gcc  
i386         buildonly-randconfig-005-20231006   gcc  
i386         buildonly-randconfig-006-20231006   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231006   gcc  
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
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
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
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
