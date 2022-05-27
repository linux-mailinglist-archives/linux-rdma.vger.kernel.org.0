Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3694B535797
	for <lists+linux-rdma@lfdr.de>; Fri, 27 May 2022 04:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiE0Ccz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 May 2022 22:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiE0Ccy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 May 2022 22:32:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE772DFA6
        for <linux-rdma@vger.kernel.org>; Thu, 26 May 2022 19:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653618773; x=1685154773;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FeN3JxL4GsBy5YqdCsa/NsdeZursA582S+tynB4p8yg=;
  b=oG5QnBqd9Ij5LMdPPOYGSTxHKr1lcrkkuKsWLpXbwG4OWWSOtWbDR7WF
   40jUPAV9GuL4umrWBiKHDAPo82Bi7gAdYm/RRYLOUs3mkuXFsGKbF+LID
   NDRcSglOu4zG3Y0KEAHqUvPslfHs/wS4Unm1lsTQ41dF/CFbF4dqLNJEw
   ZogfhXR2jIm2Hl05EtBvlvxy/61L9UbZVbmzDMBLTh7zh0j5x2R6stvxL
   VMLvfKssfHhp/5Rj6ITLAnOGQFB0UfjResQOkDkSbugaQNwgbgdxLQMrK
   z1Goh57Pk0bMQCOtwnhrXOveKgb0JyGkpVf+PYQxANXWIaZUfaMRiSh4+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="254851192"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="254851192"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 19:32:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="746672136"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 26 May 2022 19:32:51 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuPmU-0004Ko-CL;
        Fri, 27 May 2022 02:32:50 +0000
Date:   Fri, 27 May 2022 10:32:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-next] BUILD SUCCESS
 9c477178a0a187c4718c228cc6e0692564811441
Message-ID: <62903835.0p5WNmZvuNFSscaR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
branch HEAD: 9c477178a0a187c4718c228cc6e0692564811441  RDMA/rtrs-clt: Fix one kernel-doc comment

elapsed time: 726m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm64                               defconfig
mips                         db1xxx_defconfig
arm                            mps2_defconfig
arm                         assabet_defconfig
sh                          polaris_defconfig
powerpc                      pcm030_defconfig
arm                          pxa3xx_defconfig
arm                         vf610m4_defconfig
mips                         bigsur_defconfig
sh                ecovec24-romimage_defconfig
m68k                          atari_defconfig
mips                           xway_defconfig
sh                           se7750_defconfig
powerpc                     asp8347_defconfig
arm                            pleb_defconfig
sparc                       sparc32_defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
alpha                            allyesconfig
nios2                            allyesconfig
sh                               allmodconfig
arc                                 defconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
parisc64                            defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
riscv                randconfig-r042-20220524
s390                 randconfig-r044-20220524
arc                  randconfig-r043-20220524
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                  randconfig-c002-20220524
powerpc              randconfig-c003-20220524
mips                 randconfig-c004-20220524
x86_64                        randconfig-c007
riscv                randconfig-c006-20220524
i386                          randconfig-c001
s390                 randconfig-c005-20220524
powerpc                  mpc885_ads_defconfig
arm                              alldefconfig
arm                        mvebu_v5_defconfig
mips                      pic32mzda_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220524
hexagon              randconfig-r041-20220524

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
