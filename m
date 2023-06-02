Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90F87201FF
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 14:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbjFBMXn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Jun 2023 08:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbjFBMXm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Jun 2023 08:23:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03E9134
        for <linux-rdma@vger.kernel.org>; Fri,  2 Jun 2023 05:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685708611; x=1717244611;
  h=date:from:to:cc:subject:message-id;
  bh=P0KCgwFVVWYxnnZ5Q1Diymz9oZBDtaehSJTlchzTmX0=;
  b=jGBeQtW5z+q5WolHpQgQuRZaPz4yf8fteBQny2HBxHvMDDlwSnkjV4Nr
   dQZgSG70lxZKyO2XMQT1IE7BfawG4bFaDJEye8PGnNagy2Ucd13ih4Uv0
   jBT9QSBGpa9ya43iDnUhGVDxwvlyHqg33WuCfg/FNlc9L8c369BgJjkKP
   vfdA0sobmdCocp4dmRpdIQoxHKnAnpNRYnTbvVTW/JMnP+feNqpEb7RKK
   rRDMgOclu0V5imbnreg2XhKT6x71RyQwdIi8pxbTEAIQ8isssh5jYVaQI
   VlcIQ8VCEalYg7Zlt8CS7ByeioijuNwb89Q7aaMl3J4VpMEglSM/vnRAJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="384137486"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="384137486"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 05:23:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="831972922"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="831972922"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 02 Jun 2023 05:23:30 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q53oX-0000R5-0b;
        Fri, 02 Jun 2023 12:23:29 +0000
Date:   Fri, 02 Jun 2023 20:22:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 b00683422fd79dd07c9b75efdce1660e5e19150e
Message-ID: <20230602122239.olnL5%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: b00683422fd79dd07c9b75efdce1660e5e19150e  RDMA/rxe: Fix ref count error in check_rkey()

elapsed time: 732m

configs tested: 124
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230531   gcc  
alpha                randconfig-r024-20230531   gcc  
alpha                randconfig-r025-20230531   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r005-20230602   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r012-20230601   gcc  
arc                  randconfig-r043-20230531   gcc  
arc                  randconfig-r043-20230601   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r001-20230531   clang
arm                  randconfig-r034-20230602   clang
arm                  randconfig-r046-20230531   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230602   gcc  
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r004-20230602   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r005-20230531   gcc  
hexagon      buildonly-randconfig-r001-20230531   clang
hexagon              randconfig-r015-20230601   clang
hexagon              randconfig-r041-20230531   clang
hexagon              randconfig-r041-20230601   clang
hexagon              randconfig-r045-20230531   clang
hexagon              randconfig-r045-20230601   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230531   gcc  
i386                 randconfig-i002-20230531   gcc  
i386                 randconfig-i003-20230531   gcc  
i386                 randconfig-i004-20230531   gcc  
i386                 randconfig-i005-20230531   gcc  
i386                 randconfig-i006-20230531   gcc  
i386                 randconfig-i051-20230531   gcc  
i386                 randconfig-i052-20230531   gcc  
i386                 randconfig-i053-20230531   gcc  
i386                 randconfig-i054-20230531   gcc  
i386                 randconfig-i055-20230531   gcc  
i386                 randconfig-i056-20230531   gcc  
i386                 randconfig-i061-20230531   gcc  
i386                 randconfig-i062-20230531   gcc  
i386                 randconfig-i063-20230531   gcc  
i386                 randconfig-i064-20230531   gcc  
i386                 randconfig-i065-20230531   gcc  
i386                 randconfig-i066-20230531   gcc  
i386                 randconfig-r004-20230531   gcc  
i386                 randconfig-r032-20230602   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230601   gcc  
loongarch            randconfig-r021-20230531   gcc  
loongarch            randconfig-r025-20230531   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r016-20230601   gcc  
microblaze           randconfig-r003-20230531   gcc  
microblaze           randconfig-r022-20230531   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r006-20230531   clang
mips                 randconfig-r011-20230601   clang
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230531   gcc  
nios2                randconfig-r032-20230531   gcc  
openrisc     buildonly-randconfig-r003-20230531   gcc  
openrisc             randconfig-r031-20230602   gcc  
parisc       buildonly-randconfig-r006-20230602   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r024-20230531   gcc  
parisc               randconfig-r035-20230602   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r006-20230531   gcc  
powerpc              randconfig-r035-20230531   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230531   gcc  
riscv                randconfig-r014-20230601   gcc  
riscv                randconfig-r021-20230531   clang
riscv                randconfig-r023-20230531   clang
riscv                randconfig-r042-20230531   clang
riscv                randconfig-r042-20230601   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230531   clang
s390                 randconfig-r044-20230601   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230602   gcc  
sh           buildonly-randconfig-r005-20230531   gcc  
sh                   randconfig-r003-20230531   gcc  
sh                   randconfig-r036-20230531   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230531   gcc  
sparc                randconfig-r031-20230531   gcc  
sparc64      buildonly-randconfig-r002-20230531   gcc  
sparc64      buildonly-randconfig-r004-20230531   gcc  
sparc64              randconfig-r002-20230531   gcc  
sparc64              randconfig-r023-20230531   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230531   gcc  
x86_64               randconfig-a002-20230531   gcc  
x86_64               randconfig-a003-20230531   gcc  
x86_64               randconfig-a004-20230531   gcc  
x86_64               randconfig-a005-20230531   gcc  
x86_64               randconfig-a006-20230531   gcc  
x86_64               randconfig-r033-20230531   gcc  
x86_64               randconfig-r034-20230531   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r003-20230602   gcc  
xtensa               randconfig-r033-20230602   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
