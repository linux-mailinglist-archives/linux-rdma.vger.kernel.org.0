Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946D25E70C6
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Sep 2022 02:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiIWAlw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Sep 2022 20:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIWAlv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Sep 2022 20:41:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A32410976B
        for <linux-rdma@vger.kernel.org>; Thu, 22 Sep 2022 17:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663893711; x=1695429711;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/+y+h/BXdmwXck+u/a2adWpvY4QHTZjSkHfoBdZZZAU=;
  b=LXMLS1MoB6i7R9ygOw73qdNR+O2R92erkhy7tomAIYA8MJ2otklJXFiI
   jIVySybngWAvViDupltYQlq0p40aW3W8VQ0Kp/kuKvXaZwHED8VS2NGpg
   1P1jJMK876Q0kyfRTA7BQEIiBKMwku2YYdD3fvZtQ71xDbUMInQLT9aFv
   VU/9fFEJpB4ZxrVIPAtK1ik3W3QxQkOGCA+9yRJvdH50pgb9lRoHgAAKP
   f6aZcjjlsM8mPmVhcrDGkIXa1WrIZ5iWidItJY5fZau75ARKyRtzWK3v9
   gMsegPIACBcGgZSmnHpoQvh8r29qap17i5D1NRHkfCxuD1y8MO/L3HUjt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="326801621"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="326801621"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 17:41:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="650758374"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 22 Sep 2022 17:41:49 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obWlI-000584-1n;
        Fri, 23 Sep 2022 00:41:48 +0000
Date:   Fri, 23 Sep 2022 08:41:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 b300729b77b0b746c4f898332705672eb50d3297
Message-ID: <632d00cb.IYmztkH7ys9jbAWc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: b300729b77b0b746c4f898332705672eb50d3297  RDMA/core: Clean up a variable name in ib_create_srq_user()

elapsed time: 726m

configs tested: 115
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
sh                               allmodconfig
arc                  randconfig-r043-20220922
s390                                defconfig
m68k                             allmodconfig
alpha                            allyesconfig
i386                                defconfig
x86_64                              defconfig
arc                              allyesconfig
s390                             allyesconfig
m68k                             allyesconfig
x86_64                        randconfig-a015
arm                                 defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                           allyesconfig
arm64                            allyesconfig
i386                          randconfig-a001
x86_64                        randconfig-a004
arm                              allyesconfig
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                             allyesconfig
i386                          randconfig-a005
x86_64                        randconfig-a006
arc                               allnoconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
ia64                             allmodconfig
sparc                               defconfig
loongarch                        alldefconfig
m68k                        stmark2_defconfig
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
sparc                       sparc32_defconfig
sh                           se7721_defconfig
m68k                          atari_defconfig
mips                             allmodconfig
xtensa                       common_defconfig
i386                          randconfig-c001
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
powerpc                 mpc837x_mds_defconfig
xtensa                          iss_defconfig
nios2                            alldefconfig
m68k                            mac_defconfig
sh                        edosk7705_defconfig
xtensa                    smp_lx200_defconfig
csky                             alldefconfig
sh                           se7705_defconfig
powerpc                      tqm8xx_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220922
arm                        cerfcube_defconfig
microblaze                          defconfig
arm                           viper_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                         wii_defconfig
powerpc                    adder875_defconfig
arm                             ezx_defconfig
mips                       bmips_be_defconfig

clang tested configs:
hexagon              randconfig-r041-20220922
riscv                randconfig-r042-20220922
hexagon              randconfig-r045-20220922
s390                 randconfig-r044-20220922
x86_64                        randconfig-a014
x86_64                        randconfig-a012
i386                          randconfig-a013
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
i386                          randconfig-a002
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a004
i386                          randconfig-a006
powerpc                      ppc64e_defconfig
arm                          ep93xx_defconfig
x86_64                        randconfig-c007
arm                  randconfig-c002-20220922
i386                          randconfig-c001
s390                 randconfig-c005-20220922
riscv                randconfig-c006-20220922
mips                 randconfig-c004-20220922
powerpc              randconfig-c003-20220922
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
