Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9408576B09E
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Aug 2023 12:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjHAKO5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Aug 2023 06:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbjHAKOb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Aug 2023 06:14:31 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBFA129
        for <linux-rdma@vger.kernel.org>; Tue,  1 Aug 2023 03:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690884823; x=1722420823;
  h=date:from:to:cc:subject:message-id;
  bh=SMMEKmo8wR20Km4Y/h010cNu2kimHtI4b0QbO3Vc40o=;
  b=AoS97Sg1bA6t1AsrxQ8NnX2oRf/AvGzg9MMiwgp9aicWjOvgS9O5gfA8
   5N24DZSOnnCRcxv1THfGwa/kmOpVIG/B+EAw63bfQuci3DbSUpZ6x0wso
   FQWA80lWK991OpJVptmkBm6tPHBiBJe6f1kpLXqy1BuUgpZZkVAABTATU
   JwRRo3qe1gpLPFrT1XORrDMuejxBORqKiwf2Cs8Tj44f7KzwveoJr/O9L
   XHKmrwW9SJ0i9hUJWS4fX8FNU8eAril1/trZjtD65wuRcukMF+dTLS4lK
   CWu0xL+Z4U6Peg+H/b9lUyfxshbY6TOlDrDsMNc1cFsF+t0ef4IJEsn4L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="354188291"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="354188291"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 03:13:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="1059343989"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="1059343989"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 01 Aug 2023 03:13:41 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQmNo-0000BT-1p;
        Tue, 01 Aug 2023 10:13:40 +0000
Date:   Tue, 01 Aug 2023 18:12:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 2897f1925be9a3fad3972660ca4bb0909cd64f35
Message-ID: <202308011840.NDVHGiDK-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 2897f1925be9a3fad3972660ca4bb0909cd64f35  RDMA/hns: Remove unused function declarations

elapsed time: 896m

configs tested: 133
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230731   gcc  
alpha                randconfig-r032-20230731   gcc  
alpha                randconfig-r036-20230731   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r023-20230731   gcc  
arc                  randconfig-r043-20230731   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                  randconfig-r005-20230731   clang
arm                  randconfig-r013-20230731   gcc  
arm                  randconfig-r031-20230731   clang
arm                  randconfig-r046-20230731   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230731   clang
arm64                randconfig-r026-20230731   clang
arm64                randconfig-r033-20230731   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230731   gcc  
csky                 randconfig-r026-20230731   gcc  
csky                 randconfig-r031-20230731   gcc  
hexagon              randconfig-r025-20230731   clang
hexagon              randconfig-r041-20230731   clang
hexagon              randconfig-r045-20230731   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230731   gcc  
i386         buildonly-randconfig-r005-20230731   gcc  
i386         buildonly-randconfig-r006-20230731   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230731   gcc  
i386                 randconfig-i002-20230731   gcc  
i386                 randconfig-i003-20230731   gcc  
i386                 randconfig-i004-20230731   gcc  
i386                 randconfig-i005-20230731   gcc  
i386                 randconfig-i006-20230731   gcc  
i386                 randconfig-i011-20230731   clang
i386                 randconfig-i012-20230731   clang
i386                 randconfig-i013-20230731   clang
i386                 randconfig-i014-20230731   clang
i386                 randconfig-i015-20230731   clang
i386                 randconfig-i016-20230731   clang
i386                 randconfig-r024-20230731   clang
i386                 randconfig-r034-20230731   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230731   gcc  
loongarch            randconfig-r016-20230731   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230731   gcc  
m68k                 randconfig-r005-20230731   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze           randconfig-r006-20230731   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        vocore2_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230731   gcc  
nios2                randconfig-r005-20230731   gcc  
nios2                randconfig-r006-20230731   gcc  
nios2                randconfig-r025-20230731   gcc  
openrisc             randconfig-r014-20230731   gcc  
openrisc             randconfig-r024-20230731   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r032-20230731   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r022-20230731   clang
riscv                randconfig-r042-20230731   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r012-20230731   clang
s390                 randconfig-r044-20230731   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r014-20230731   gcc  
sh                   randconfig-r021-20230731   gcc  
sh                   randconfig-r022-20230731   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230731   gcc  
sparc                randconfig-r036-20230731   gcc  
sparc64              randconfig-r002-20230731   gcc  
sparc64              randconfig-r003-20230731   gcc  
sparc64              randconfig-r015-20230731   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230731   gcc  
x86_64       buildonly-randconfig-r002-20230731   gcc  
x86_64       buildonly-randconfig-r003-20230731   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r016-20230731   clang
x86_64               randconfig-x001-20230731   clang
x86_64               randconfig-x002-20230731   clang
x86_64               randconfig-x003-20230731   clang
x86_64               randconfig-x004-20230731   clang
x86_64               randconfig-x005-20230731   clang
x86_64               randconfig-x006-20230731   clang
x86_64               randconfig-x011-20230731   gcc  
x86_64               randconfig-x012-20230731   gcc  
x86_64               randconfig-x013-20230731   gcc  
x86_64               randconfig-x014-20230731   gcc  
x86_64               randconfig-x015-20230731   gcc  
x86_64               randconfig-x016-20230731   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r003-20230731   gcc  
xtensa               randconfig-r023-20230731   gcc  
xtensa               randconfig-r035-20230731   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
