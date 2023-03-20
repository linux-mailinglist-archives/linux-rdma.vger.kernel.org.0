Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC316C0936
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Mar 2023 04:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjCTDKf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Mar 2023 23:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCTDKd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Mar 2023 23:10:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCBF12BE4
        for <linux-rdma@vger.kernel.org>; Sun, 19 Mar 2023 20:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679281831; x=1710817831;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=wJv/B4yjeL6jYvsSHUFJpCRUnnIDW/p7CZSdI8nKmdA=;
  b=bzUVB7wJYu/z/FHpeSCHFYev6vEFei3/ZVwxm4qfYO75vhGLeIuVhCpf
   akLWnFNtcg91MLajtxG56EueWF2mtYRiMIVx7DTwD7ZZtw5ituXIOXu2W
   bNLrlCEi4RKnCC+kb0r6/WNfRrE5ePC38WKidb0ULfgydNDDzPFUasEuI
   Xi1pXvfLjlnZz268A1WSTHqWOoxciF/PUQ2/PIbgwaciLMWtXGUzWtOCb
   9T0yMN7NEX4PgWKW20DA8pTzPJrjKZXqaTSZYs0XvwPsz0a6sz2p4riai
   xVn9MnP12VaWlBL7TBTPkXhUeEiS5MbcdFdm87h4n+z9WTYxVZwFUU/rP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="322407445"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="322407445"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 20:10:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="683324933"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="683324933"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 19 Mar 2023 20:10:28 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pe5um-000AnK-0U;
        Mon, 20 Mar 2023 03:10:28 +0000
Date:   Mon, 20 Mar 2023 11:09:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg+lists@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/leon-for-next] BUILD SUCCESS
 697d5cf073acd41a8ab135695bb1e2ae3fd0acb3
Message-ID: <6417ce82.yjZcoJQZrBLPl5lT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
branch HEAD: 697d5cf073acd41a8ab135695bb1e2ae3fd0acb3  IB/qib: Drop redundant pci_enable_pcie_error_reporting()

elapsed time: 723m

configs tested: 188
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230319   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230319   gcc  
alpha                randconfig-r005-20230319   gcc  
alpha                randconfig-r021-20230319   gcc  
alpha                randconfig-r023-20230319   gcc  
alpha                randconfig-r036-20230319   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230319   gcc  
arc                  randconfig-r003-20230320   gcc  
arc                  randconfig-r025-20230319   gcc  
arc                  randconfig-r043-20230319   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       multi_v4t_defconfig   gcc  
arm                         nhk8815_defconfig   gcc  
arm                        oxnas_v6_defconfig   gcc  
arm                  randconfig-r006-20230319   clang
arm                  randconfig-r012-20230319   gcc  
arm                  randconfig-r024-20230319   gcc  
arm                  randconfig-r046-20230319   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230319   gcc  
arm64                               defconfig   gcc  
csky                             alldefconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230319   gcc  
csky                 randconfig-r003-20230319   gcc  
csky                 randconfig-r006-20230319   gcc  
csky                 randconfig-r022-20230319   gcc  
hexagon      buildonly-randconfig-r001-20230319   clang
hexagon      buildonly-randconfig-r003-20230319   clang
hexagon              randconfig-r032-20230319   clang
hexagon              randconfig-r041-20230319   clang
hexagon              randconfig-r045-20230319   clang
i386                             allyesconfig   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
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
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r023-20230319   gcc  
ia64                 randconfig-r033-20230319   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r014-20230319   gcc  
loongarch            randconfig-r022-20230319   gcc  
loongarch            randconfig-r026-20230319   gcc  
loongarch            randconfig-r034-20230319   gcc  
m68k                             allmodconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k         buildonly-randconfig-r001-20230319   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r006-20230319   gcc  
m68k                 randconfig-r026-20230319   gcc  
m68k                           virt_defconfig   gcc  
microblaze   buildonly-randconfig-r006-20230319   gcc  
microblaze           randconfig-r005-20230319   gcc  
microblaze           randconfig-r013-20230319   gcc  
microblaze           randconfig-r024-20230319   gcc  
microblaze           randconfig-r032-20230319   gcc  
microblaze           randconfig-r033-20230319   gcc  
microblaze           randconfig-r036-20230319   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                 randconfig-r001-20230319   clang
mips                 randconfig-r024-20230319   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230319   gcc  
nios2                randconfig-r011-20230319   gcc  
nios2                randconfig-r015-20230319   gcc  
nios2                randconfig-r031-20230319   gcc  
nios2                randconfig-r034-20230319   gcc  
nios2                randconfig-r035-20230319   gcc  
nios2                randconfig-r036-20230319   gcc  
openrisc             randconfig-r002-20230319   gcc  
openrisc             randconfig-r011-20230319   gcc  
openrisc             randconfig-r031-20230319   gcc  
openrisc             randconfig-r035-20230319   gcc  
parisc       buildonly-randconfig-r004-20230319   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r024-20230319   gcc  
parisc               randconfig-r025-20230319   gcc  
parisc               randconfig-r031-20230319   gcc  
parisc               randconfig-r033-20230319   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230319   clang
powerpc                 canyonlands_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                    klondike_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                 mpc85xx_cds_defconfig   gcc  
powerpc                     pq2fads_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc              randconfig-r002-20230319   gcc  
powerpc              randconfig-r004-20230319   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230319   gcc  
riscv                randconfig-r016-20230319   clang
riscv                randconfig-r042-20230319   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r015-20230319   clang
s390                 randconfig-r035-20230319   gcc  
s390                 randconfig-r044-20230319   clang
sh                               allmodconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh           buildonly-randconfig-r003-20230319   gcc  
sh                         ecovec24_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r002-20230319   gcc  
sh                   randconfig-r021-20230319   gcc  
sh                   randconfig-r025-20230319   gcc  
sh                   randconfig-r032-20230319   gcc  
sh                           se7721_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sparc        buildonly-randconfig-r006-20230319   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230319   gcc  
sparc                randconfig-r012-20230319   gcc  
sparc                randconfig-r021-20230319   gcc  
sparc                randconfig-r031-20230319   gcc  
sparc64      buildonly-randconfig-r005-20230319   gcc  
sparc64              randconfig-r004-20230320   gcc  
sparc64              randconfig-r013-20230319   gcc  
um                               alldefconfig   gcc  
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
xtensa                              defconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa               randconfig-r003-20230319   gcc  
xtensa               randconfig-r004-20230319   gcc  
xtensa               randconfig-r013-20230319   gcc  
xtensa               randconfig-r015-20230319   gcc  
xtensa               randconfig-r022-20230319   gcc  
xtensa               randconfig-r023-20230319   gcc  
xtensa               randconfig-r026-20230319   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
