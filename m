Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC95D660FAB
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Jan 2023 15:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjAGO5O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 7 Jan 2023 09:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjAGO5N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 7 Jan 2023 09:57:13 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22A64ECA5
        for <linux-rdma@vger.kernel.org>; Sat,  7 Jan 2023 06:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673103432; x=1704639432;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=g0zWV9zwHbhWxtvcvVx8/ynV0FptoYT2ukjhzp7TwAQ=;
  b=YJpAqB4rzhXTn3JaRmmuVtA6OaCOpl/9+IAuB6tsHxziCSyXOo3gFTlz
   6FopY45n8jlr3gZjt2rhUQ+4QYVLiaGQYBBc9JtsUfBOGjOUcjU5lVItc
   r7Rb8tTHoHtQ+XzqPAwVLCJEXdgebGk5K83lXexkE2WnLoqGEAgVYEScj
   3vnjTqmHG230o2Fl7ubJAHAmpDYksjNMxhoXGAjPAFKznjOEOda7fWRVE
   +8qRtlxRj8lB9USyMEqTsZLsJ8+XN6ubZFRfB3dMDwITmV3J/pP26PwWe
   shfNNKV3wWFlmog+pVatbJEut/IS1SelEZtIFBIEk9+UnPiefjzgjIr90
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10583"; a="310435484"
X-IronPort-AV: E=Sophos;i="5.96,308,1665471600"; 
   d="scan'208";a="310435484"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2023 06:57:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10583"; a="798555293"
X-IronPort-AV: E=Sophos;i="5.96,308,1665471600"; 
   d="scan'208";a="798555293"
Received: from lkp-server02.sh.intel.com (HELO f1920e93ebb5) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jan 2023 06:57:10 -0800
Received: from kbuild by f1920e93ebb5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pEAdB-0004e6-0z;
        Sat, 07 Jan 2023 14:57:09 +0000
Date:   Sat, 07 Jan 2023 22:56:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:for-rc] BUILD SUCCESS
 e95d50d74b93a767a026f588e8de0b9718a0105e
Message-ID: <63b98837.rXLpLMv3VciHGCsm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-rc
branch HEAD: e95d50d74b93a767a026f588e8de0b9718a0105e  lib/scatterlist: Fix to merge contiguous pages into the last SG properly

elapsed time: 720m

configs tested: 111
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                            allnoconfig
s390                                defconfig
s390                             allyesconfig
um                             i386_defconfig
arm                                 defconfig
um                           x86_64_defconfig
arm64                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm                              allyesconfig
arc                  randconfig-r043-20230106
arm                  randconfig-r046-20230106
x86_64                        randconfig-a006
i386                          randconfig-a014
sh                               allmodconfig
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-bpf
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a005
x86_64                          rhel-8.3-func
m68k                             allyesconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a015
i386                             allyesconfig
i386                                defconfig
powerpc                      ppc40x_defconfig
arc                              alldefconfig
mips                           ci20_defconfig
arm                        cerfcube_defconfig
m68k                        mvme147_defconfig
sparc64                             defconfig
powerpc                       ppc64_defconfig
sh                            titan_defconfig
ia64                             alldefconfig
powerpc                     mpc83xx_defconfig
arm                            lart_defconfig
mips                         db1xxx_defconfig
powerpc                      ppc6xx_defconfig
mips                         cobalt_defconfig
sh                          rsk7264_defconfig
x86_64                           alldefconfig
ia64                             allmodconfig
m68k                             allmodconfig
i386                          randconfig-c001
powerpc                 linkstation_defconfig
arm64                               defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     rainier_defconfig
sh                           se7619_defconfig
arm                        oxnas_v6_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
ia64                        generic_defconfig
nios2                            allyesconfig
sh                           sh2007_defconfig
powerpc                   currituck_defconfig
powerpc                      pasemi_defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
hexagon              randconfig-r045-20230106
x86_64                        randconfig-a005
hexagon              randconfig-r041-20230106
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
riscv                randconfig-r042-20230106
s390                 randconfig-r044-20230106
x86_64                          rhel-8.3-rust
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-k001
hexagon              randconfig-r041-20230107
hexagon              randconfig-r045-20230107
arm                  randconfig-r046-20230107
powerpc                 xes_mpc85xx_defconfig
powerpc                          g5_defconfig
arm                          ixp4xx_defconfig
arm                         palmz72_defconfig
arm                         orion5x_defconfig
arm                           spitz_defconfig
arm                       aspeed_g4_defconfig
powerpc                     mpc5200_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
