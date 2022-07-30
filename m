Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F2D585BF1
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Jul 2022 22:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiG3UC1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 Jul 2022 16:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiG3UC1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 Jul 2022 16:02:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12F3140DC
        for <linux-rdma@vger.kernel.org>; Sat, 30 Jul 2022 13:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659211345; x=1690747345;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=u87fsDjK0SrKy1q75IXsepdfnMS99EQTUSo3xbCsLXg=;
  b=i0ACOh1FjqN3Rnj29ghm4LK/QJZ3nSoGrq4cQ5eaa7rr1+7vmEWZ2nDY
   OPYKVjBXZM/BVQJeEIKIZsEsBAi1PoXwRwKlxmwje9DRAF3tGVoQhUVra
   VC2HHLdiF9YtN9HGM+kGsqI4Z6VLmxlb9Ei4KlOX4bvPozpRHG5OrhovC
   0f4ltmL6Il5G5u7u77yovuAn0Mlh6sp6Y6tR0O65W5dfy57oMV3fif2Iz
   0CmV+3VPMlO6EFZ7XQ96wQKXSw7rpmyO8knlW1+dV0TvpuoSCuk5Wg4bM
   Ne6RBZsam9yesaujy0fldjFsmaNvtW9efKFgz1n3zPBIQfN2Yu2d0NmiU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="289714610"
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="289714610"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 13:02:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="777846798"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 30 Jul 2022 13:02:23 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHsfH-000DEB-0W;
        Sat, 30 Jul 2022 20:02:23 +0000
Date:   Sun, 31 Jul 2022 04:02:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-next] BUILD SUCCESS
 b5605148e6ce36bb21020d49010b617693933128
Message-ID: <62e58e3b.7LjC3Zahp0PIkTAx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-next
branch HEAD: b5605148e6ce36bb21020d49010b617693933128  RDMA/srpt: Fix a use-after-free

elapsed time: 1442m

configs tested: 116
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
x86_64                              defconfig
i386                             allyesconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
mips                             allyesconfig
x86_64                           allyesconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a016
ia64                             allmodconfig
powerpc                          allmodconfig
sh                               allmodconfig
x86_64                           rhel-8.3-syz
i386                          randconfig-a012
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arc                               allnoconfig
alpha                             allnoconfig
csky                              allnoconfig
riscv                             allnoconfig
arm                         lpc18xx_defconfig
powerpc                 mpc8540_ads_defconfig
xtensa                    xip_kc705_defconfig
openrisc                    or1ksim_defconfig
mips                 decstation_r4k_defconfig
powerpc                     ep8248e_defconfig
sparc                       sparc64_defconfig
sh                           se7724_defconfig
sh                          rsk7201_defconfig
sh                           se7619_defconfig
powerpc                      bamboo_defconfig
m68k                          hp300_defconfig
sh                              ul2_defconfig
nios2                               defconfig
sh                         ecovec24_defconfig
mips                       capcella_defconfig
mips                          rb532_defconfig
sh                        apsh4ad0a_defconfig
ia64                                defconfig
powerpc                      mgcoge_defconfig
m68k                        mvme147_defconfig
sh                          r7780mp_defconfig
sh                         apsh4a3a_defconfig
arm                        shmobile_defconfig
m68k                                defconfig
powerpc                     pq2fads_defconfig
ia64                            zx1_defconfig
sh                           se7206_defconfig
powerpc                       eiger_defconfig
arm                           h3600_defconfig
x86_64                           alldefconfig
arm                             ezx_defconfig
xtensa                  audio_kc705_defconfig
sh                          r7785rp_defconfig
sh                            hp6xx_defconfig
mips                       bmips_be_defconfig
arm                        clps711x_defconfig
powerpc                  iss476-smp_defconfig
ia64                             alldefconfig
sh                          kfr2r09_defconfig
parisc                generic-64bit_defconfig
sh                        dreamcast_defconfig
sh                           se7722_defconfig
arm                           sama5_defconfig
xtensa                generic_kc705_defconfig

clang tested configs:
hexagon              randconfig-r041-20220729
riscv                randconfig-r042-20220729
hexagon              randconfig-r045-20220729
s390                 randconfig-r044-20220729
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a006
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
powerpc                   microwatt_defconfig
arm                       imx_v4_v5_defconfig
powerpc                      katmai_defconfig
powerpc                          g5_defconfig
mips                           mtx1_defconfig
mips                           ip28_defconfig
powerpc                  mpc866_ads_defconfig
arm                      tct_hammer_defconfig
mips                        maltaup_defconfig
powerpc                 mpc832x_mds_defconfig
mips                      maltaaprp_defconfig
mips                     loongson1c_defconfig
arm                         palmz72_defconfig
x86_64                        randconfig-k001
arm                       spear13xx_defconfig
riscv                             allnoconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
