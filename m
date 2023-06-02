Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E230D720130
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 14:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjFBMLA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Jun 2023 08:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbjFBMKe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Jun 2023 08:10:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092AFD3
        for <linux-rdma@vger.kernel.org>; Fri,  2 Jun 2023 05:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685707833; x=1717243833;
  h=date:from:to:cc:subject:message-id;
  bh=eSTN+85hNv1QZhoG2neP8dnhZC86mFjdTbZNlwb1BsY=;
  b=lAX7Ths/5yVqNxm9lkHBUzFHTVok+/TvyjqImbVa6ND2CKHpjWiGW+Jb
   EXtS7TWflKe/VUEgaZ280KIPyz8UaC9IAl7hY81XcFcLUawhi7MmpwpWo
   brEd0/+IRbFYwQ1WD6aZIv0x5917xsoYkMmBjeHET4VnFySxUEFlBH9Uu
   StxP9bgNftOHr8lO2X8tC+YOYifJaLhbWd0P5bH2o3kfYmflQiV9tMuSn
   Qk4RzEEofDUUYKL1IJQrF9RplazhQyOtFJ16erZ9XYgQ52RrZBXd+qXdS
   tb23JTgAayctG0VoA4WC0T0VOAUW8aJFTKVLUDBwv9yrYqh9+10pPYhdm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="354701933"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="354701933"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 05:10:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="797581820"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="797581820"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jun 2023 05:10:30 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q53bw-0000QZ-0h;
        Fri, 02 Jun 2023 12:10:28 +0000
Date:   Fri, 02 Jun 2023 20:09:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 95ea2efbd66fb9e85238bd8d59341f8ce7a31065
Message-ID: <20230602120958.mFIRn%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: 95ea2efbd66fb9e85238bd8d59341f8ce7a31065  IB/hfi1: Remove unused struct mmu_rb_ops fields .insert, .invalidate

elapsed time: 720m

configs tested: 123
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r004-20230602   gcc  
alpha        buildonly-randconfig-r005-20230531   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230531   gcc  
alpha                randconfig-r025-20230531   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230531   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230602   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230602   clang
arm                  randconfig-r021-20230531   gcc  
arm                  randconfig-r026-20230531   gcc  
arm                  randconfig-r032-20230531   clang
arm                  randconfig-r046-20230531   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230602   clang
arm64                randconfig-r022-20230531   clang
arm64                randconfig-r036-20230602   gcc  
csky         buildonly-randconfig-r002-20230531   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r025-20230531   gcc  
csky                 randconfig-r035-20230602   gcc  
hexagon              randconfig-r041-20230531   clang
hexagon              randconfig-r045-20230531   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r001-20230531   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230531   gcc  
i386                 randconfig-i001-20230602   gcc  
i386                 randconfig-i002-20230531   gcc  
i386                 randconfig-i002-20230602   gcc  
i386                 randconfig-i003-20230531   gcc  
i386                 randconfig-i003-20230602   gcc  
i386                 randconfig-i004-20230531   gcc  
i386                 randconfig-i004-20230602   gcc  
i386                 randconfig-i005-20230531   gcc  
i386                 randconfig-i005-20230602   gcc  
i386                 randconfig-i006-20230602   gcc  
i386                 randconfig-i051-20230531   gcc  
i386                 randconfig-i051-20230602   gcc  
i386                 randconfig-i052-20230531   gcc  
i386                 randconfig-i052-20230602   gcc  
i386                 randconfig-i053-20230531   gcc  
i386                 randconfig-i053-20230602   gcc  
i386                 randconfig-i054-20230531   gcc  
i386                 randconfig-i054-20230602   gcc  
i386                 randconfig-i055-20230531   gcc  
i386                 randconfig-i055-20230602   gcc  
i386                 randconfig-i056-20230531   gcc  
i386                 randconfig-i056-20230602   gcc  
i386                 randconfig-i061-20230531   gcc  
i386                 randconfig-i062-20230531   gcc  
i386                 randconfig-i063-20230531   gcc  
i386                 randconfig-i064-20230531   gcc  
i386                 randconfig-i065-20230531   gcc  
i386                 randconfig-i066-20230531   gcc  
i386                 randconfig-r001-20230531   gcc  
i386                 randconfig-r004-20230602   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r004-20230531   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r015-20230531   gcc  
m68k                 randconfig-r034-20230531   gcc  
microblaze           randconfig-r014-20230531   gcc  
microblaze           randconfig-r024-20230531   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230602   clang
mips                 randconfig-r012-20230602   gcc  
mips                 randconfig-r022-20230531   gcc  
mips                 randconfig-r033-20230531   clang
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230531   gcc  
nios2                randconfig-r014-20230602   gcc  
nios2                randconfig-r026-20230531   gcc  
openrisc             randconfig-r011-20230531   gcc  
openrisc             randconfig-r031-20230531   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r004-20230531   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r034-20230602   gcc  
riscv                randconfig-r042-20230531   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230531   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r002-20230602   gcc  
sparc        buildonly-randconfig-r003-20230602   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r006-20230602   gcc  
sparc                randconfig-r011-20230602   gcc  
sparc                randconfig-r036-20230531   gcc  
sparc64              randconfig-r003-20230531   gcc  
sparc64              randconfig-r005-20230531   gcc  
sparc64              randconfig-r015-20230602   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r003-20230531   gcc  
x86_64       buildonly-randconfig-r006-20230602   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r001-20230602   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r016-20230531   gcc  
xtensa               randconfig-r023-20230531   gcc  
xtensa               randconfig-r033-20230602   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
