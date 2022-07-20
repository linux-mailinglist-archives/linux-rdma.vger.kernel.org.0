Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B57057AD90
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jul 2022 04:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239955AbiGTCEo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jul 2022 22:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240063AbiGTCEo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jul 2022 22:04:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E5F558D7
        for <linux-rdma@vger.kernel.org>; Tue, 19 Jul 2022 19:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658282683; x=1689818683;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mV7dkgiupuH0NjjrTU2zVy/f/6BfKZrBgE6fyrXEVDs=;
  b=Ia8q+CMaBUMJTKJsA0/Kb3plQ862Qu3old3cMc71ooasnJIz3PPhTIJN
   6/HEct3gVTzFMkF6a1iBfovDsV0lmH+XpgCXhJsfRkSNw8WKFLAMDDyYZ
   hTCRyJIIt+zdO6fJGlkMyg9PDRdnK0ruxALArZVRRXpIomfrP/cRavY8p
   GCTLXbtYPWsFJz1jIRgvTQpbL1MBCY79KjO26RpjbZG5j1NH8bIyvKHpb
   TZq0yxwPZdUGnXTVR7D8SaZS5+wXyYRme8qpHxPa+bljuJrKtp8yGCsMu
   Zd0DOZPRNLQkF3haEdr4ftljT61ekSLqUcfK4oJ87RshDatHe0wB5E2Gm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="312347409"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="312347409"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 19:04:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="656049661"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jul 2022 19:04:42 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDz4r-0006LC-Hj;
        Wed, 20 Jul 2022 02:04:41 +0000
Date:   Wed, 20 Jul 2022 10:04:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:hmm] BUILD SUCCESS bea86a8116f60c40d3d49cfef02e0e8d82c4c4d1
Message-ID: <62d762a3.w9K/h8uIbJnipctm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git hmm
branch HEAD: bea86a8116f60c40d3d49cfef02e0e8d82c4c4d1  RDMA/erdma: Add driver to kernel build environment

elapsed time: 1565m

configs tested: 141
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220718
arm                        realview_defconfig
arm                             rpc_defconfig
powerpc                 mpc837x_rdb_defconfig
m68k                         amcore_defconfig
sh                           se7343_defconfig
sh                         microdev_defconfig
arm                          pxa910_defconfig
arm                        oxnas_v6_defconfig
powerpc                    sam440ep_defconfig
xtensa                    smp_lx200_defconfig
arm                          pxa3xx_defconfig
powerpc                       maple_defconfig
m68k                        m5307c3_defconfig
m68k                             alldefconfig
arc                     haps_hs_smp_defconfig
powerpc                     pq2fads_defconfig
arc                     nsimosci_hs_defconfig
m68k                          atari_defconfig
powerpc                     asp8347_defconfig
m68k                           virt_defconfig
powerpc                      ep88xc_defconfig
arm                      footbridge_defconfig
mips                        bcm47xx_defconfig
powerpc                      ppc40x_defconfig
arm64                            alldefconfig
mips                            ar7_defconfig
sh                             sh03_defconfig
m68k                                defconfig
powerpc                     rainier_defconfig
arm                          lpd270_defconfig
powerpc                     ep8248e_defconfig
arc                        nsimosci_defconfig
sh                             shx3_defconfig
arc                           tb10x_defconfig
arm                        keystone_defconfig
powerpc                     stx_gp3_defconfig
powerpc                      ppc6xx_defconfig
arm                        spear6xx_defconfig
arm                            qcom_defconfig
sh                        sh7757lcr_defconfig
x86_64                              defconfig
mips                           jazz_defconfig
xtensa                  cadence_csp_defconfig
arm                         at91_dt_defconfig
mips                      loongson3_defconfig
sh                        dreamcast_defconfig
xtensa                       common_defconfig
mips                            gpr_defconfig
sh                          lboxre2_defconfig
ia64                          tiger_defconfig
arc                    vdk_hs38_smp_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                           defconfig
loongarch                         allnoconfig
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a005
i386                          randconfig-a001
x86_64               randconfig-a014-20220718
x86_64               randconfig-a016-20220718
x86_64               randconfig-a012-20220718
x86_64               randconfig-a013-20220718
x86_64               randconfig-a015-20220718
x86_64               randconfig-a011-20220718
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                 randconfig-a015-20220718
i386                 randconfig-a011-20220718
i386                 randconfig-a012-20220718
i386                 randconfig-a014-20220718
i386                 randconfig-a016-20220718
i386                 randconfig-a013-20220718
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                 randconfig-r044-20220718
riscv                randconfig-r042-20220718
arc                  randconfig-r043-20220718
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                          ath79_defconfig
powerpc                    gamecube_defconfig
mips                      maltaaprp_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                 randconfig-a004-20220718
i386                 randconfig-a001-20220718
i386                 randconfig-a005-20220718
i386                 randconfig-a006-20220718
i386                 randconfig-a002-20220718
i386                 randconfig-a003-20220718
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220718
hexagon              randconfig-r045-20220718

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
