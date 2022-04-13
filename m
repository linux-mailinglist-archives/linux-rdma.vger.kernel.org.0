Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710C54FF918
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Apr 2022 16:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiDMOlz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Apr 2022 10:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiDMOly (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Apr 2022 10:41:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8CAB84F
        for <linux-rdma@vger.kernel.org>; Wed, 13 Apr 2022 07:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649860773; x=1681396773;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=OFuzD97zRxsxJuMw/odL9DotrhH2VFPhyABd+dvX6GI=;
  b=TFFcV7ZzHC85P8dULsnPXoRjm4wRHHclXMLwc2NlCUvcZPe5qQa9+ZBY
   yhpj1aKJu27TfMXojt2l1TC3Nje7MCZmH1tGWaGEfD9SW067TD3A4sKF9
   x8ruhz/NBY9Bpj1pq3KSbNH81P4QicmPWaT9tdMXwhUzf3rZVJqzrWGWB
   6q08TkNBho78Q72HMGjgGYsFD03rHsv/naV6QFJVxV5LSRDZGFedNhI3D
   Cz+200WX3+wFYshi8vHqpxMOuB9sQ2c+eXln/vlA0yNAQKoqTOuUsyQlR
   LHVvMHcvmjJHHjpuI09qUK31Na4B+UaF5oH/zDjcNUXqXJbs02AbC7vI+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="323128413"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="323128413"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 07:36:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="552229764"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 13 Apr 2022 07:36:19 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nee6U-0000Nc-Tr;
        Wed, 13 Apr 2022 14:36:18 +0000
Date:   Wed, 13 Apr 2022 22:35:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 290c4a902b79246ec55e477fc313f27f98393dee
Message-ID: <6256dfc6.vNk5Qk+mVjEVD/mD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: 290c4a902b79246ec55e477fc313f27f98393dee  RDMA/rxe: Fix "Replace mr by rkey in responder resources"

elapsed time: 1281m

configs tested: 156
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220411
mips                           ci20_defconfig
arm                        cerfcube_defconfig
sh                   sh7770_generic_defconfig
powerpc                       maple_defconfig
powerpc                      makalu_defconfig
sh                           se7750_defconfig
powerpc                       eiger_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                       holly_defconfig
arm                         at91_dt_defconfig
sh                        sh7763rdp_defconfig
s390                       zfcpdump_defconfig
h8300                       h8s-sim_defconfig
s390                          debug_defconfig
arm                          badge4_defconfig
sh                           se7721_defconfig
um                           x86_64_defconfig
arc                            hsdk_defconfig
arc                     nsimosci_hs_defconfig
riscv                               defconfig
arm                       multi_v4t_defconfig
arm                            mps2_defconfig
xtensa                           allyesconfig
sh                        dreamcast_defconfig
ia64                      gensparse_defconfig
sparc                               defconfig
powerpc                   motionpro_defconfig
arc                     haps_hs_smp_defconfig
parisc                           alldefconfig
arm                            zeus_defconfig
powerpc                       ppc64_defconfig
sh                   rts7751r2dplus_defconfig
sh                        apsh4ad0a_defconfig
mips                  decstation_64_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220413
arm                  randconfig-c002-20220411
x86_64               randconfig-c001-20220411
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a016-20220411
x86_64               randconfig-a012-20220411
x86_64               randconfig-a013-20220411
x86_64               randconfig-a014-20220411
x86_64               randconfig-a015-20220411
x86_64               randconfig-a011-20220411
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                 randconfig-a011-20220411
i386                 randconfig-a014-20220411
i386                 randconfig-a012-20220411
i386                 randconfig-a013-20220411
i386                 randconfig-a015-20220411
i386                 randconfig-a016-20220411
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220411
arc                  randconfig-r043-20220411
s390                 randconfig-r044-20220411
riscv                randconfig-r042-20220413
arc                  randconfig-r043-20220413
s390                 randconfig-r044-20220413
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220413
arm                  randconfig-c002-20220413
i386                          randconfig-c001
riscv                randconfig-c006-20220413
mips                 randconfig-c004-20220413
powerpc              randconfig-c003-20220411
arm                  randconfig-c002-20220411
riscv                randconfig-c006-20220411
x86_64               randconfig-c007-20220411
mips                 randconfig-c004-20220411
i386                 randconfig-c001-20220411
mips                      pic32mzda_defconfig
hexagon                             defconfig
powerpc                      ppc44x_defconfig
powerpc                        icon_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                      obs600_defconfig
arm                         bcm2835_defconfig
x86_64                           allyesconfig
arm                        magician_defconfig
i386                 randconfig-a003-20220411
i386                 randconfig-a005-20220411
i386                 randconfig-a001-20220411
i386                 randconfig-a004-20220411
i386                 randconfig-a002-20220411
i386                 randconfig-a006-20220411
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64               randconfig-a003-20220411
x86_64               randconfig-a004-20220411
x86_64               randconfig-a006-20220411
x86_64               randconfig-a001-20220411
x86_64               randconfig-a002-20220411
x86_64               randconfig-a005-20220411
hexagon              randconfig-r041-20220413
hexagon              randconfig-r045-20220413

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
