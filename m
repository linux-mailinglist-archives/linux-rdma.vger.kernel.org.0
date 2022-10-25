Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6E460C345
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 07:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJYFcG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Oct 2022 01:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJYFcF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Oct 2022 01:32:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6E210F8A3
        for <linux-rdma@vger.kernel.org>; Mon, 24 Oct 2022 22:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666675924; x=1698211924;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=X1+TgP0K609Ufn+heDPuHJkH4/oT+PLfytYovc6BIJM=;
  b=T9vVCUn73tFy9dyyMuBmyltbpFixuEvwfEGGIgVddfyfoDogxM4JLQpv
   cs0rkjvOxAiXFn2w7bOjK1/wHiPQj3HBmNlbNZLYlDTx6GgIoEXDAakwW
   53eKpTAKYtUqsaHBJdSsDtHqHeTY7Wwkdt4UNcJh0GISgDUC8iLntqLQp
   iwBy0dGC5krKu9wKW+rdm7wN15xY/U84wSwrX0qA9JwThJ11MUowzmZ6f
   5KWGTYa75S2iQUs2Ypi3U/BnpiyXrmYDvuJfNGmzAFwQwQWUNGrV+BCV0
   0OPjEqXrempfm3AQJvzog/DHkot0IxPyWAyppdcwhL0HZZ1MnCIHXAQRm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="307584302"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="307584302"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 22:32:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="720728251"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="720728251"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Oct 2022 22:32:03 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1onCXg-0005xY-11;
        Tue, 25 Oct 2022 05:32:00 +0000
Date:   Tue, 25 Oct 2022 13:31:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/jgg-for-rc] BUILD SUCCESS
 ab9a924e54d9b10c3c7399a8342e4ce4452a1b00
Message-ID: <63577494.IiH9KxDHFqXxC+wg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/jgg-for-rc
branch HEAD: ab9a924e54d9b10c3c7399a8342e4ce4452a1b00  RDMA/rxe: Fix mr leak in RESPST_ERR_RNR

elapsed time: 720m

configs tested: 94
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
powerpc                          allmodconfig
ia64                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
x86_64                              defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
x86_64                               rhel-8.3
i386                 randconfig-a011-20221024
i386                                defconfig
i386                 randconfig-a013-20221024
i386                 randconfig-a012-20221024
i386                 randconfig-a014-20221024
i386                 randconfig-a016-20221024
x86_64                           allyesconfig
i386                 randconfig-a015-20221024
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                             allyesconfig
parisc                generic-64bit_defconfig
sh                           se7712_defconfig
arc                  randconfig-r043-20221024
s390                 randconfig-r044-20221024
riscv                randconfig-r042-20221024
arc                              alldefconfig
sh                        dreamcast_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                          polaris_defconfig
riscv                    nommu_k210_defconfig
xtensa                    xip_kc705_defconfig
x86_64               randconfig-k001-20221024
powerpc                   motionpro_defconfig
csky                             alldefconfig
powerpc                 mpc837x_rdb_defconfig
openrisc                            defconfig
x86_64               randconfig-a014-20221024
x86_64               randconfig-a015-20221024
x86_64               randconfig-a016-20221024
x86_64               randconfig-a013-20221024
x86_64               randconfig-a012-20221024
x86_64               randconfig-a011-20221024
arm                        mini2440_defconfig
powerpc                      chrp32_defconfig
sh                          lboxre2_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
m68k                       m5249evb_defconfig
arm                       aspeed_g5_defconfig
powerpc                  storcenter_defconfig
powerpc                 canyonlands_defconfig
powerpc                     tqm8555_defconfig
mips                     decstation_defconfig
arm                           h5000_defconfig
arm                       multi_v4t_defconfig

clang tested configs:
i386                 randconfig-a001-20221024
i386                 randconfig-a002-20221024
i386                 randconfig-a005-20221024
x86_64               randconfig-a001-20221024
i386                 randconfig-a003-20221024
x86_64               randconfig-a003-20221024
i386                 randconfig-a004-20221024
x86_64               randconfig-a004-20221024
x86_64               randconfig-a002-20221024
i386                 randconfig-a006-20221024
x86_64               randconfig-a005-20221024
x86_64               randconfig-a006-20221024
s390                 randconfig-r044-20221023
hexagon              randconfig-r041-20221023
riscv                randconfig-r042-20221023
hexagon              randconfig-r045-20221023
mips                     loongson2k_defconfig
arm                          moxart_defconfig
arm                         s3c2410_defconfig
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
