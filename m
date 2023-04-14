Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2471D6E24B8
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Apr 2023 15:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjDNNvw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Apr 2023 09:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDNNvv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Apr 2023 09:51:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22A4B45A
        for <linux-rdma@vger.kernel.org>; Fri, 14 Apr 2023 06:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681480282; x=1713016282;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Nvf7FS5ZKWlI3nfWqG+9eFASH71SSS6RloVjamXwMV0=;
  b=g/57nDsynw8gGEEbBeJVgP6jeppLTXh5aBole5veIuJ6NiAPUxxDq7MG
   BWpq6v+gvPII1tqLWOKNxDNUKzBfTbEn1qI/sO1G/BFLbsJmygI11c0uF
   cDSKuPr7U0hMNHcHxRHBEnQAYTWCAZZDAMybtCBQ87YMvOnY+E4egx2k6
   Y7BYN9NZgEoEMSGK5MdIyGHOF8flTbW8Y99CjEXaVsQ/Imq4MDoidA5+q
   Z81U2ymkfgxUtboMmi3FaVSwRshj8kYNuTYoNLNqNVxtyG7G3XO1p/TXo
   HmhjkNKDDS2kA/UK7yxjMuPAdlVmwdf1YmlqPKLIMzet0rlA3VRMMX48o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="372332656"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="372332656"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 06:50:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="640110410"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="640110410"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 14 Apr 2023 06:50:32 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pnJot-000ZaN-2Y;
        Fri, 14 Apr 2023 13:50:31 +0000
Date:   Fri, 14 Apr 2023 21:50:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 aca3b0fa3d04b40c96934d86cc224cccfa7ea8e0
Message-ID: <64395a22.Mp/QwlLsL8d1D2gH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: aca3b0fa3d04b40c96934d86cc224cccfa7ea8e0  RDMA/core: Fix GID entry ref leak when create_ah fails

elapsed time: 726m

configs tested: 111
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230413   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r024-20230413   gcc  
alpha                randconfig-r032-20230413   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230412   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r024-20230413   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r026-20230413   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r021-20230410   gcc  
arm64                randconfig-r025-20230412   gcc  
csky         buildonly-randconfig-r004-20230411   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r022-20230410   gcc  
csky                 randconfig-r031-20230413   gcc  
hexagon              randconfig-r022-20230413   clang
hexagon              randconfig-r026-20230410   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a011-20230410   gcc  
i386                 randconfig-a012-20230410   gcc  
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230410   gcc  
i386                 randconfig-a014-20230410   gcc  
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                 randconfig-a016-20230410   gcc  
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r006-20230411   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r025-20230409   gcc  
ia64                 randconfig-r031-20230411   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r021-20230409   gcc  
loongarch            randconfig-r033-20230411   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r025-20230410   gcc  
m68k                 randconfig-r025-20230413   gcc  
microblaze   buildonly-randconfig-r003-20230411   gcc  
microblaze           randconfig-r023-20230413   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2        buildonly-randconfig-r003-20230413   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r023-20230410   gcc  
nios2                randconfig-r034-20230413   gcc  
openrisc     buildonly-randconfig-r002-20230411   gcc  
openrisc     buildonly-randconfig-r006-20230413   gcc  
openrisc             randconfig-r022-20230413   gcc  
openrisc             randconfig-r024-20230412   gcc  
openrisc             randconfig-r025-20230413   gcc  
openrisc             randconfig-r032-20230411   gcc  
openrisc             randconfig-r034-20230411   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r021-20230413   gcc  
parisc               randconfig-r024-20230409   gcc  
parisc               randconfig-r026-20230412   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r035-20230413   gcc  
powerpc              randconfig-r036-20230411   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r021-20230412   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230412   gcc  
sh           buildonly-randconfig-r005-20230411   gcc  
sh           buildonly-randconfig-r005-20230413   gcc  
sh                   randconfig-r022-20230409   gcc  
sh                   randconfig-r026-20230413   gcc  
sh                   randconfig-r033-20230413   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r023-20230412   gcc  
sparc                randconfig-r035-20230411   gcc  
sparc64      buildonly-randconfig-r004-20230413   gcc  
sparc64      buildonly-randconfig-r005-20230412   gcc  
sparc64              randconfig-r026-20230409   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a005   clang
x86_64               randconfig-a011-20230410   gcc  
x86_64               randconfig-a012-20230410   gcc  
x86_64               randconfig-a013-20230410   gcc  
x86_64               randconfig-a014-20230410   gcc  
x86_64               randconfig-a015-20230410   gcc  
x86_64               randconfig-a016-20230410   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230411   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
